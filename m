Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D276CCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjHBMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjHBMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:32:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C9689B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:32:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC97113E;
        Wed,  2 Aug 2023 05:33:02 -0700 (PDT)
Received: from [10.57.1.113] (unknown [10.57.1.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 326043F6C4;
        Wed,  2 Aug 2023 05:32:18 -0700 (PDT)
Message-ID: <463b2ab6-f7b5-f1fc-8e99-e2ad93c21675@arm.com>
Date:   Wed, 2 Aug 2023 13:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH] coresight: tmc: Explicit type conversions to
 prevent integer overflow
Content-Language: en-US
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714084349.31567-1-tianruidong@linux.alibaba.com>
 <61f11ffe-473c-a36e-c51d-9e526a6fd375@arm.com>
 <a448f505-fef4-e1b7-c31e-e1f310c16e8f@linux.alibaba.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a448f505-fef4-e1b7-c31e-e1f310c16e8f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2023 13:25, Ruidong Tian wrote:
> Hi James,
> 
> Sorry, some local patch caused inaccurate information. Please allow me
> to reintroduce the question:
> 
> If you use perf with 1G AUX buffer, you can get 1G perf data. Perf
> workload is kernel build here:
> 
>     perf record -C 0 -m ,1G -e cs_etm// taskset -c 0 make
> 
>     [ perf record: Captured and wrote 1025.557 MB perf.data ]
> 
> But if you use 2G AUX buffer, perf was executed unexpectedly：
> 
>     perf record -C 0 -m ,2G -e cs_etm// taskset -c 0 make
> 
>     [ perf record: Captured and wrote 2.615 MB perf.data ]
> 
> There are just 2.615 MB perf data rather than 2G, if you probe function
> "tmc_alloc_etr_buf" in
> 
> coresight_tmc module, you can find some clues:
> 
>   perf probe -m coresight_tmc "tmc_alloc_etr_buf size:s64"
> 
>   perf record -e probe:tmc_alloc_etr_buf -aR -- perf record -C 0 -m ,2G
> -e cs_etm// -o cs.data taskset -c 0 make
> 
>   perf script
>             perf 118267 [064]  4640.324670: probe:tmc_alloc_etr_buf:
> (ffff80007a9dce60) size_s64=-2147483648
>             perf 118267 [064]  4640.324681: probe:tmc_alloc_etr_buf:
> (ffff80007a9dce60) size_s64=1048576
> 
> It's pretty obvious what's going on here. The first call of
> tmc_alloc_etr_buf in alloc_etr_buf was
> 
> failed because of overflow, the second call of tmc_alloc_etr_buf just
> alloc 1M AUX buffer which
> 
> is default ETR buffer size rather than 2G. That is why we can just get
> 2.615MB ( 1M AUX data
> 
> + perf header ).
> 
> It is necessary to check the conversion from int to s64 in coresight_tmc
> driver. The issue[1] also
> 
> exists in coresight/perf, but it's different from this topic.
> 

Thanks for the investigation, that makes more sense to me now. Are you
able to send a v2 of the patch with an updated commit message describing
these symptoms instead?

And you can also add:

Reviewed-by: James Clark <james.clark@arm.com>

> 
> [1]:
> https://lore.kernel.org/bpf/20230711014120.53461-1-xueshuai@linux.alibaba.com/
> 
> Thanks
> Ruidong
> 
> On 2023/7/24 23:38, James Clark wrote:
>>
>> On 14/07/2023 09:43, Ruidong Tian wrote:
>>> Perf cs_etm session will failed when AUX buffer > 1G.
>>>
>>>    perf record -C 0 -m ,2G -e cs_etm// -- taskset -c 0 ls
>>>    failed to mmap with 12 (Cannot allocate memory)
>>>
>>> In coresight tmc driver, "nr_pages << PAGE_SHIFT" will overflow when
>>> nr_pages >= 0x80000(correspond to 1G AUX buffer). Explicit convert
>>> nr_pages
>>> to 64 bit to avoid overflow.
>>>
>> Hi Ruidong,
>>
>> I couldn't reproduce this exact issue with the error message in the
>> commit message. Is it not another manifestation related to this change
>> [1]? I don't actually get any error message, but I was able to get a
>> warning in dmesg even with [1] applied.
>>
>> Does the overflow not result in a successful session but with the wrong
>> buffer size?
>>
>> I think the change makes sense, but maybe we also need a check for
>> MAX_ORDER because I can trigger the same WARN_ON from [1]. Or maybe I'm
>> a bit confused because of the other change and not being able to
>> reproduce this exactly coming at the same time.
>>
>> [1]:
>> https://lore.kernel.org/bpf/20230711014120.53461-1-xueshuai@linux.alibaba.com/
>>
>> Thanks
>> James
>>
>>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>>>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index 766325de0e29..1425ecd1cf78 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -1267,7 +1267,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata,
>>> struct perf_event *event,
>>>        * than the size requested via sysfs.
>>>        */
>>>       if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
>>> -        etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
>>> +        etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages <<
>>> PAGE_SHIFT),
>>>                           0, node, NULL);
>>>           if (!IS_ERR(etr_buf))
>>>               goto done;
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h
>>> b/drivers/hwtracing/coresight/coresight-tmc.h
>>> index b97da39652d2..0ee48c5ba764 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>>> @@ -325,7 +325,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table
>>> *sg_table,
>>>   static inline unsigned long
>>>   tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>>>   {
>>> -    return sg_table->data_pages.nr_pages << PAGE_SHIFT;
>>> +    return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
>>>   }
>>>     struct coresight_device *tmc_etr_get_catu_device(struct
>>> tmc_drvdata *drvdata);
