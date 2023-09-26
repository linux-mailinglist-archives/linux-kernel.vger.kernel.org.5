Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A097AE5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjIZGYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjIZGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:23:55 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69C121;
        Mon, 25 Sep 2023 23:23:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VsvlMsY_1695709421;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VsvlMsY_1695709421)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 14:23:44 +0800
Message-ID: <b3e8777d-7621-3842-53b0-2b43ffc25d34@linux.alibaba.com>
Date:   Tue, 26 Sep 2023 14:23:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v8 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, rafael@kernel.org,
        wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
        mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, james.morse@arm.com,
        gregkh@linuxfoundation.org, will@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org,
        hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-2-xueshuai@linux.alibaba.com>
 <CVS2TK6J4193.2X0455FSP2MLQ@suppilovahvero>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CVS2TK6J4193.2X0455FSP2MLQ@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/25 22:43, Jarkko Sakkinen wrote:
> On Tue Sep 19, 2023 at 5:21 AM EEST, Shuai Xue wrote:
>> There are two major types of uncorrected recoverable (UCR) errors :
>>
>> - Action Required (AR): The error is detected and the processor already
>>   consumes the memory. OS requires to take action (for example, offline
>>   failure page/kill failure thread) to recover this uncorrectable error.
>>
>> - Action Optional (AO): The error is detected out of processor execution
>>   context. Some data in the memory are corrupted. But the data have not
>>   been consumed. OS is optional to take action to recover this
>>   uncorrectable error.
>>
>> The essential difference between AR and AO errors is that AR is a
>> synchronous event, while AO is an asynchronous event. The hardware will
>> signal a synchronous exception (Machine Check Exception on X86 and
>> Synchronous External Abort on Arm64) when an error is detected and the
>> memory access has been architecturally executed.
>>
>> When APEI firmware first is enabled, a platform may describe one error
>> source for the handling of synchronous errors (e.g. MCE or SEA notification
>> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
>> notification). In other words, we can distinguish synchronous errors by
>> APEI notification. For AR errors, kernel will kill current process
>> accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
>> addition, for AO errors, kernel will notify the process who owns the
>> poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
>> However, the GHES driver always sets mf_flags to 0 so that all UCR errors
>> are handled as AO errors in memory failure.
>>
>> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
>> events.
>>
>> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ef59d6ea16da..88178aa6222d 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>>  	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>>  }
>>  
>> +/*
>> + * A platform may describe one error source for the handling of synchronous
>> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> + * or External Interrupt). On x86, the HEST notifications are always
>> + * asynchronous, so only SEA on ARM is delivered as a synchronous
>> + * notification.
>> + */
>> +static inline bool is_hest_sync_notify(struct ghes *ghes)
>> +{
>> +	u8 notify_type = ghes->generic->notify.type;
>> +
>> +	return notify_type == ACPI_HEST_NOTIFY_SEA;
>> +}
>> +
>>  /*
>>   * This driver isn't really modular, however for the time being,
>>   * continuing to use module_param is the easiest way to remain
>> @@ -475,7 +489,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  }
>>  
>>  static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>> -				       int sev)
>> +				       int sev, bool sync)
>>  {
>>  	int flags = -1;
>>  	int sec_sev = ghes_severity(gdata->error_severity);
>> @@ -489,7 +503,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>  	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>>  		flags = MF_SOFT_OFFLINE;
>>  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>> -		flags = 0;
>> +		flags = sync ? MF_ACTION_REQUIRED : 0;
> 
> Not my territory but this branching looks a bit weird to my
> eyes so just in case putting a comment.
> 
> What *if* the previous condition sets MF_SOFT_OFFLINE and
> this condition overwrites the value?
> 
> I know that earlier it could have been overwritten by zero.
> 
> Neither the function comment has any explanation why it is
> ok overwrite like this.
> 
> Or if these cannot happen simultaenously why there is not
> immediate return after settting MF_SOFT_OFFLINE?
> 
> For someone like me the functions logic is tediously hard
> to understand tbh.
> 
> BR, Jarkko

Hi, Jarkko,

I hope the original source code can help to understand:

	/* iff following two events can be handled properly by now */
	if (sec_sev == GHES_SEV_CORRECTED &&
	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
		flags = MF_SOFT_OFFLINE;
	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
		flags = 0;

	if (flags != -1)
		return ghes_do_memory_failure(mem_err->physical_addr, flags);

The sec_sev of gdata is either GHES_SEV_CORRECTED or GHES_SEV_RECOVERABLE.
So the two if-conditions are independent of each other and these cannot
happen simultaneously. ghes_do_memory_failure() then handle the two events
with a proper seted flags.

Thanks.

Best Regards,
Shuai
