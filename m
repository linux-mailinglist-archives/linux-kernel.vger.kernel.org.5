Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1276CC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjHBMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjHBMZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:25:40 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4A2720
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:25:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VouyzCy_1690979132;
Received: from 30.221.140.131(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VouyzCy_1690979132)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 20:25:33 +0800
Message-ID: <a448f505-fef4-e1b7-c31e-e1f310c16e8f@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 20:25:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH] coresight: tmc: Explicit type conversions to
 prevent integer overflow
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
 <61f11ffe-473c-a36e-c51d-9e526a6fd375@arm.com>
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <61f11ffe-473c-a36e-c51d-9e526a6fd375@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Sorry, some local patch caused inaccurate information. Please allow me 
to reintroduce the question:

If you use perf with 1G AUX buffer, you can get 1G perf data. Perf 
workload is kernel build here:

     perf record -C 0 -m ,1G -e cs_etm// taskset -c 0 make

     [ perf record: Captured and wrote 1025.557 MB perf.data ]

But if you use 2G AUX buffer, perf was executed unexpectedly：

     perf record -C 0 -m ,2G -e cs_etm// taskset -c 0 make

     [ perf record: Captured and wrote 2.615 MB perf.data ]

There are just 2.615 MB perf data rather than 2G, if you probe function 
"tmc_alloc_etr_buf" in

coresight_tmc module, you can find some clues:

   perf probe -m coresight_tmc "tmc_alloc_etr_buf size:s64"

   perf record -e probe:tmc_alloc_etr_buf -aR -- perf record -C 0 -m ,2G 
-e cs_etm// -o cs.data taskset -c 0 make

   perf script
             perf 118267 [064]  4640.324670: probe:tmc_alloc_etr_buf: 
(ffff80007a9dce60) size_s64=-2147483648
             perf 118267 [064]  4640.324681: probe:tmc_alloc_etr_buf: 
(ffff80007a9dce60) size_s64=1048576

It's pretty obvious what's going on here. The first call of 
tmc_alloc_etr_buf in alloc_etr_buf was

failed because of overflow, the second call of tmc_alloc_etr_buf just 
alloc 1M AUX buffer which

is default ETR buffer size rather than 2G. That is why we can just get 
2.615MB ( 1M AUX data

+ perf header ).

It is necessary to check the conversion from int to s64 in coresight_tmc 
driver. The issue[1] also

exists in coresight/perf, but it's different from this topic.


[1]:
https://lore.kernel.org/bpf/20230711014120.53461-1-xueshuai@linux.alibaba.com/ 


Thanks
Ruidong

On 2023/7/24 23:38, James Clark wrote:
>
> On 14/07/2023 09:43, Ruidong Tian wrote:
>> Perf cs_etm session will failed when AUX buffer > 1G.
>>
>>    perf record -C 0 -m ,2G -e cs_etm// -- taskset -c 0 ls
>>    failed to mmap with 12 (Cannot allocate memory)
>>
>> In coresight tmc driver, "nr_pages << PAGE_SHIFT" will overflow when
>> nr_pages >= 0x80000(correspond to 1G AUX buffer). Explicit convert nr_pages
>> to 64 bit to avoid overflow.
>>
> Hi Ruidong,
>
> I couldn't reproduce this exact issue with the error message in the
> commit message. Is it not another manifestation related to this change
> [1]? I don't actually get any error message, but I was able to get a
> warning in dmesg even with [1] applied.
>
> Does the overflow not result in a successful session but with the wrong
> buffer size?
>
> I think the change makes sense, but maybe we also need a check for
> MAX_ORDER because I can trigger the same WARN_ON from [1]. Or maybe I'm
> a bit confused because of the other change and not being able to
> reproduce this exactly coming at the same time.
>
> [1]:
> https://lore.kernel.org/bpf/20230711014120.53461-1-xueshuai@linux.alibaba.com/
>
> Thanks
> James
>
>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 766325de0e29..1425ecd1cf78 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1267,7 +1267,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>>   	 * than the size requested via sysfs.
>>   	 */
>>   	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
>> -		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
>> +		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
>>   					    0, node, NULL);
>>   		if (!IS_ERR(etr_buf))
>>   			goto done;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index b97da39652d2..0ee48c5ba764 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
>>   static inline unsigned long
>>   tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>>   {
>> -	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
>> +	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
>>   }
>>   
>>   struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
