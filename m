Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A48002FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377404AbjLAFWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:22:30 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A950C10FC;
        Thu, 30 Nov 2023 21:22:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VxVHB4Y_1701408150;
Received: from 30.240.114.121(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxVHB4Y_1701408150)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 13:22:32 +0800
Message-ID: <c89342d5-79a2-47cb-b1dc-e69f0d528862@linux.alibaba.com>
Date:   Fri, 1 Dec 2023 13:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, rafael@kernel.org,
        wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
        mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, gregkh@linuxfoundation.org,
        will@kernel.org, jarkko@kernel.org
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
 <20231007072818.58951-2-xueshuai@linux.alibaba.com>
 <c77e1909-8e03-6b2f-ecaf-c5b395642688@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <c77e1909-8e03-6b2f-ecaf-c5b395642688@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/1 01:39, James Morse wrote:
> Hi Shuai,
> 
> On 07/10/2023 08:28, Shuai Xue wrote:
>> There are two major types of uncorrected recoverable (UCR) errors :
> 
> Is UCR a well known x86 acronym? It's best to just spell this out each time,
> there is enough jargon in this area already.

Quite agreed, will replace the commit log with "uncorrected recoverable error".

> 
>>
>> - Action Required (AR): The error is detected and the processor already
>>   consumes the memory. OS requires to take action (for example, offline
>>   failure page/kill failure thread) to recover this uncorrectable error.
>>
>> - Action Optional (AO): The error is detected out of processor execution
>>   context. Some data in the memory are corrupted. But the data have not
>>   been consumed. OS is optional to take action to recover this
>>   uncorrectable error.
> 
> As elsewhere, please don't think of errors as 'action required', this is how
> things get reported to user-space. Action-required for one thread may be
> action-optional for another that has the same page mapped - its really not a
> property of the error.
> It would be better to describe this as synchronous and asynchronous, or in-band
> and out-of-band.

Thank you for explanation. I will change to "synchronous and asynchronous".

> 
> 
>> The essential difference between AR and AO errors is that AR is a
>> synchronous event, while AO is an asynchronous event. The hardware will
>> signal a synchronous exception (Machine Check Exception on X86 and
>> Synchronous External Abort on Arm64) when an error is detected and the
>> memory access has been architecturally executed.
> 
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
> 
> To make this easier to read:
>  UCR and AR -> synchronous
>  AO -> asynchronous
> 

Will do that.

> 
>> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
>> events.
> 
>> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
> 
> Erm, this predates arm64 support, and what you have here doesn't change the behaviour on x86.
> 
> You can blame 7f17b4a121d0d50 ("ACPI: APEI: Kick the memory_failure() queue for
> synchronous errors"), which should have covered this.

Do you mean just drop the "Fixes" tags?

> 
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
> 
> and as you had in earlier versions, sometimes SDEI.
> SDEI can report by synchronous and asynchronous errors, I wouldn't too surprised if the
> hardware NMI can be used for the same. It would be good to chase up having a hint of this
> in the CPER records and pass that in here as a hint.> 
> Unfortunately, its not safe to assume either way for SDEI.

For SDEI notification, only x0-x17 has preserved by firmware.  As SDEI
TRM[1] describes "the dispatcher can simulate an exception-like entry into
the client, **with the client providing an additional asynchronous entry
point similar to an interrupt entry point**".  The client (kernel) lacks
complete synchronous context, e.g. system register (ELR, ESR, etc). So I
think SDEI notification should not be used for asynchronous error, can you
help to confirm this?

For NMI notification, as far as I know, AArch64 (aka arm64 in the Linux
tree) does not provide architected NMIs.

> 
> Reviewed-by: James Morse <james.morse@arm.com>
> 

Thank you for valuable comments.

Best Regards,
Shuai

[1] https://developer.arm.com/documentation/den0054/latest/
