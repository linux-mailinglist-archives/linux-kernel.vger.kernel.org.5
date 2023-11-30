Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617FD7FF87B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbjK3Rjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjK3Rjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:39:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B96210FC;
        Thu, 30 Nov 2023 09:40:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54A7143D;
        Thu, 30 Nov 2023 09:40:46 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185523F6C4;
        Thu, 30 Nov 2023 09:39:54 -0800 (PST)
Message-ID: <c77e1909-8e03-6b2f-ecaf-c5b395642688@arm.com>
Date:   Thu, 30 Nov 2023 17:39:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Content-Language: en-GB
To:     Shuai Xue <xueshuai@linux.alibaba.com>, rafael@kernel.org,
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20231007072818.58951-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuai,

On 07/10/2023 08:28, Shuai Xue wrote:
> There are two major types of uncorrected recoverable (UCR) errors :

Is UCR a well known x86 acronym? It's best to just spell this out each time,
there is enough jargon in this area already.

> 
> - Action Required (AR): The error is detected and the processor already
>   consumes the memory. OS requires to take action (for example, offline
>   failure page/kill failure thread) to recover this uncorrectable error.
> 
> - Action Optional (AO): The error is detected out of processor execution
>   context. Some data in the memory are corrupted. But the data have not
>   been consumed. OS is optional to take action to recover this
>   uncorrectable error.

As elsewhere, please don't think of errors as 'action required', this is how
things get reported to user-space. Action-required for one thread may be
action-optional for another that has the same page mapped - its really not a
property of the error.
It would be better to describe this as synchronous and asynchronous, or in-band
and out-of-band.


> The essential difference between AR and AO errors is that AR is a
> synchronous event, while AO is an asynchronous event. The hardware will
> signal a synchronous exception (Machine Check Exception on X86 and
> Synchronous External Abort on Arm64) when an error is detected and the
> memory access has been architecturally executed.

> When APEI firmware first is enabled, a platform may describe one error
> source for the handling of synchronous errors (e.g. MCE or SEA notification
> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
> notification). In other words, we can distinguish synchronous errors by
> APEI notification. For AR errors, kernel will kill current process
> accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
> addition, for AO errors, kernel will notify the process who owns the
> poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
> However, the GHES driver always sets mf_flags to 0 so that all UCR errors
> are handled as AO errors in memory failure.

To make this easier to read:
 UCR and AR -> synchronous
 AO -> asynchronous



> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
> events.

> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'

Erm, this predates arm64 support, and what you have here doesn't change the behaviour on x86.

You can blame 7f17b4a121d0d50 ("ACPI: APEI: Kick the memory_failure() queue for
synchronous errors"), which should have covered this.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ef59d6ea16da..88178aa6222d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>  }
>  
> +/*
> + * A platform may describe one error source for the handling of synchronous
> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
> + * or External Interrupt). On x86, the HEST notifications are always
> + * asynchronous, so only SEA on ARM is delivered as a synchronous
> + * notification.
> + */
> +static inline bool is_hest_sync_notify(struct ghes *ghes)
> +{
> +	u8 notify_type = ghes->generic->notify.type;
> +
> +	return notify_type == ACPI_HEST_NOTIFY_SEA;
> +}

and as you had in earlier versions, sometimes SDEI.
SDEI can report by synchronous and asynchronous errors, I wouldn't too surprised if the
hardware NMI can be used for the same. It would be good to chase up having a hint of this
in the CPER records and pass that in here as a hint.

Unfortunately, its not safe to assume either way for SDEI.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
