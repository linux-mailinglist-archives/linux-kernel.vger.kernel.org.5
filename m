Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5976CFF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjHBOYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjHBOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:24:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FAB126B6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:24:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93E76113E;
        Wed,  2 Aug 2023 07:25:14 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 708A63F5A1;
        Wed,  2 Aug 2023 07:24:30 -0700 (PDT)
Message-ID: <a7804048-19c8-c7fd-c262-4540621c1fb8@arm.com>
Date:   Wed, 2 Aug 2023 15:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6] arm64: sdei: abort running SDEI handlers during crash
Content-Language: en-GB
To:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
References: <20230627002939.2758-1-scott@os.amperecomputing.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230627002939.2758-1-scott@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On 27/06/2023 01:29, D Scott Phillips wrote:
> Interrupts are blocked in SDEI context, per the SDEI spec: "The client
> interrupts cannot preempt the event handler." If we crashed in the SDEI
> handler-running context (as with ACPI's AGDI) then we need to clean up the
> SDEI state before proceeding to the crash kernel so that the crash kernel
> can have working interrupts.
> 
> Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
> the handler, discarding the interrupted context.

I still argue this is a firmware bug. That preempt text was supposed to mean "PSTATE.DAIF
get set", the whole "GIC abstraction" thing got shoehorned in much later.

But I agree we need to work around it in linux.


> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index f9040bd61081..285fe7ad490d 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1095,3 +1095,22 @@ int sdei_event_handler(struct pt_regs *regs,
>  	return err;
>  }
>  NOKPROBE_SYMBOL(sdei_event_handler);
> +
> +void sdei_handler_abort(void)
> +{
> +	/*
> +	 * If the crash happened in an SDEI event handler then we need to
> +	 * finish the handler with the firmware so that we can have working
> +	 * interrupts in the crash kernel.
> +	 */
> +	if (__this_cpu_read(sdei_active_critical_event)) {
> +	        pr_warn("still in SDEI critical event context, attempting to finish handler.\n");
> +	        __sdei_handler_abort();
> +	        __this_cpu_write(sdei_active_critical_event, NULL);
> +	}
> +	if (__this_cpu_read(sdei_active_normal_event)) {
> +	        pr_warn("still in SDEI normal event context, attempting to finish handler.\n");
> +	        __sdei_handler_abort();
> +	        __this_cpu_write(sdei_active_normal_event, NULL);
> +	}
> +}

I'm not sure why this moved out to drivers/firmware when the only caller is the arch code,
but it doesn't matter...

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
