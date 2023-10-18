Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBED7CDC71
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjJRM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJRM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:57:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEC40106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:57:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DAE2F4;
        Wed, 18 Oct 2023 05:57:45 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809553F762;
        Wed, 18 Oct 2023 05:57:03 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:57:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea della Porta <andrea.porta@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 3/4] arm64/entry-common: Make Aarch32 syscalls'
 availability depend on aarch32_enabled()
Message-ID: <ZS_WHHnWzfkKtJWs@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:13:21PM +0200, Andrea della Porta wrote:
> Another major aspect of supporting running of 32bit processes is the
> ability to access 32bit syscalls. Such syscalls can be invoked by
> using the svc instruction.
> 
> If Aarch32 emulation is disabled ensure that calling svc results
> in the same behavior as if CONFIG_COMPAT has not been enabled (i.e.
> a kernel panic).

It's not "emulation" it's directly supported by the hardware.

> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/kernel/entry-common.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 69ff9b8c0bde..32761760d9dd 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -802,6 +802,11 @@ asmlinkage void noinstr el0t_64_error_handler(struct pt_regs *regs)
>  }
>  
>  #ifdef CONFIG_COMPAT
> +UNHANDLED(el0t, 32, sync_ni)
> +UNHANDLED(el0t, 32, irq_ni)
> +UNHANDLED(el0t, 32, fiq_ni)
> +UNHANDLED(el0t, 32, error_ni)

IRQ, FIQ, and SError are not syscalls, so the commit title is bad.

> +
>  static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
>  {
>  	enter_from_user_mode(regs);
> @@ -821,6 +826,11 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
>  
>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>  {
> +	if (!aarch32_enabled()) {
> +		el0t_32_sync_ni_handler(regs);
> +		return;
> +	}

Why do we have to do this at all?

If we don't have AArch32 tasks, these paths are unreachable. Why do we need to
check that they aren't called?

Mark.

> +
>  	unsigned long esr = read_sysreg(esr_el1);
>  
>  	switch (ESR_ELx_EC(esr)) {
> @@ -865,17 +875,26 @@ asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>  
>  asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
>  {
> -	__el0_irq_handler_common(regs);
> +	if (!aarch32_enabled())
> +		el0t_32_irq_ni_handler(regs);
> +	else
> +		__el0_irq_handler_common(regs);
>  }
>  
>  asmlinkage void noinstr el0t_32_fiq_handler(struct pt_regs *regs)
>  {
> -	__el0_fiq_handler_common(regs);
> +	if (!aarch32_enabled())
> +		el0t_32_fiq_ni_handler(regs);
> +	else
> +		__el0_fiq_handler_common(regs);
>  }
>  
>  asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
>  {
> -	__el0_error_handler_common(regs);
> +	if (!aarch32_enabled())
> +		el0t_32_error_ni_handler(regs);
> +	else
> +		__el0_error_handler_common(regs);
>  }
>  
>  bool __aarch32_enabled __ro_after_init = true;
> -- 
> 2.35.3
> 
