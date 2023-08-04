Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAE76F83E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjHDDKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjHDDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:08:50 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED370559A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:06:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vp-l8vD_1691118414;
Received: from 30.221.140.131(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0Vp-l8vD_1691118414)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 11:06:55 +0800
Message-ID: <233b0b82-c4bb-0c9f-14fa-bdce85ffcc38@linux.alibaba.com>
Date:   Fri, 4 Aug 2023 11:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] coresight: tmc: Explicit type conversions to prevent
 integer overflow
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, james.clark@arm.com
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
 <20230803023321.111078-1-tianruidong@linux.alibaba.com>
 <0410712c-d658-8f54-5a29-699a68bc0dea@arm.com>
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <0410712c-d658-8f54-5a29-699a68bc0dea@arm.com>
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

Sure, I will put them all to patch v3.

Ruidong

On 2023/8/4 00:19, Suzuki K Poulose wrote:
> On 03/08/2023 03:33, Ruidong Tian wrote:
>> Perf cs_etm session executed unexpectedly when AUX buffer > 1G.
>>
>>    perf record -C 0 -m ,2G -e cs_etm// -- <workload>
>>    [ perf record: Captured and wrote 2.615 MB perf.data ]
>>
>> Perf only collect about 2M perf data rather than 2G. This is becasuse
>> the operation, "nr_pages << PAGE_SHIFT", in coresight tmc driver, will
>> overflow when nr_pages >= 0x80000(correspond to 1G AUX buffer). The
>> overflow cause buffer allocation to fail, and TMC driver will alloc
>> minimal buffer size(1M). You can just get about 2M perf data(1M AUX
>> buffer + perf data header) at least.
>>
>> Explicit convert nr_pages to 64 bit to avoid overflow.
>>
>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>> Reviewed-by: James Clark <james.clark@arm.com>
>
> Fixes: 22f429f19c41 ("coresight: etm-perf: Add support for ETR backend")
>
>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c 
>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 766325de0e29..1425ecd1cf78 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1267,7 +1267,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, 
>> struct perf_event *event,
>>        * than the size requested via sysfs.
>>        */
>>       if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
>> -        etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
>> +        etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << 
>> PAGE_SHIFT),
>>                           0, node, NULL);
>>           if (!IS_ERR(etr_buf))
>>               goto done;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h 
>> b/drivers/hwtracing/coresight/coresight-tmc.h
>> index b97da39652d2..0ee48c5ba764 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table 
>> *sg_table,
>>   static inline unsigned long
>>   tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>>   {
>> -    return sg_table->data_pages.nr_pages << PAGE_SHIFT;
>> +    return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
>>   }
>>     struct coresight_device *tmc_etr_get_catu_device(struct 
>> tmc_drvdata *drvdata);
>
> There are other places where such a fix is needed.
> e.g.,
>
> $ git grep "nr_pages << PAGE_SHIFT" 
> drivers/hwtracing/coresight/coresight-tmc*
> drivers/hwtracing/coresight/coresight-tmc-etf.c:        head = 
> handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
> drivers/hwtracing/coresight/coresight-tmc-etr.c:#define 
> PERF_IDX2OFF(idx, buf)  ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
> drivers/hwtracing/coresight/coresight-tmc-etr.c:        if ((nr_pages 
> << PAGE_SHIFT) > drvdata->size) {
> drivers/hwtracing/coresight/coresight-tmc-etr.c: etr_buf = 
> tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
> drivers/hwtracing/coresight/coresight-tmc.h:    return 
> sg_table->data_pages.nr_pages << PAGE_SHIFT;
>
> Are you able to fix all of them ?
>
> Suzuki
