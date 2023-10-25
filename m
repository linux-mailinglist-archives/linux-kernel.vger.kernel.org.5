Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3D7D6A19
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjJYL1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjJYL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:27:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 175EF18D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:27:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586552F4;
        Wed, 25 Oct 2023 04:28:06 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95EC23F738;
        Wed, 25 Oct 2023 04:27:23 -0700 (PDT)
Date:   Wed, 25 Oct 2023 12:27:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea della Porta <andrea.porta@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, arnd@arndb.de
Subject: Re: [PATCH v2 3/4] arm64/entry-common: Make Aarch32 exceptions'
 availability depend on aarch32_enabled()
Message-ID: <ZTj7mHTv-PDT4ba8@FVFF77S0Q05N>
References: <cover.1698069331.git.andrea.porta@suse.com>
 <d0484051d8ff23e0ed1f2933789cde3d390a2fa6.1698069331.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0484051d8ff23e0ed1f2933789cde3d390a2fa6.1698069331.git.andrea.porta@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:42:22PM +0200, Andrea della Porta wrote:
> Another major aspect of supporting running of 32bit processes is the
> ability to access 32bit syscalls and exceptions. Syscalls, in
> particular, can be invoked by using the svc instruction.
> 
> If Aarch32 support is disabled ensure that calling svc (or any
> exceptions) from 32bit context results in the same behavior as if
> CONFIG_COMPAT has not been enabled (i.e. a kernel panic).
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Just to be clear, as it stands, I don't think we should apply this patch.

* There's no justficiation so far for disabling the vectors given they should
  be unreachable.

* If we really want to do this, the behaviour should be driven by a cpucap, so
  as to have truly negligible impact and to be consistent with how we handle
  features elsewhere.

  That will require some preparatory rework to the way de handle detecing
  support for AArch32 at EL0 (some of which I think we should do anyway as a
  cleanup).

* We should not introduce new *_ni_handler() functions. If we really want to
  do this, we should refactor the existing code such that we have a single
  el0t_32_<vector>_handler() implementation for each vector regardless of
  CONFIG_COMPAT, which can figure out what to do, e.g. something like:

  | asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
  | {
  |         if (!system_suports_compat_el0())
  | 	            panic_unhandled_vector(el0t, 32, irq, regs);
  |             
  | 	    __el0_irq_handler_common(regs);
  | }

  That way the feature check only needs to test IS_ENABLED(CONFIG_COMPAT) and
  alternative_has_cap(whatever), and we can rely on the compiler to elide the
  unreachable code. That way we use the exact same code for the case that
  32-bit support is disabled statically or dynamically.

  I had a quick go at mocking that up:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry/unhandled-rework

  ... which doesn't look too hard.
 
> ---
>  arch/arm64/include/asm/exception.h |  7 +++++++
>  arch/arm64/kernel/entry-common.c   | 25 ++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
> index ad688e157c9b..ccb41ba8d86c 100644
> --- a/arch/arm64/include/asm/exception.h
> +++ b/arch/arm64/include/asm/exception.h
> @@ -48,6 +48,13 @@ asmlinkage void el0t_32_irq_handler(struct pt_regs *regs);
>  asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
>  asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
>  
> +#ifdef CONFIG_COMPAT
> +asmlinkage void el0t_32_sync_ni_handler(struct pt_regs *regs);
> +asmlinkage void el0t_32_irq_ni_handler(struct pt_regs *regs);
> +asmlinkage void el0t_32_fiq_ni_handler(struct pt_regs *regs);
> +asmlinkage void el0t_32_error_ni_handler(struct pt_regs *regs);
> +#endif
> +
>  asmlinkage void call_on_irq_stack(struct pt_regs *regs,
>  				  void (*func)(struct pt_regs *));
>  asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
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

This isn't the right way to use the UNHANDLED() macro, the 'vector' argument is
supposed to be the name of the exception vector, since that'll be printed out
in the message. The above will result in wanings like:

  "Unhandled 32-bit sync_ni exception"

Whereas we want:
  
  "Unhandled 32-bit sync exception"

As with the code linked to above, I'd be happy to remove the UNHANDLED() macro
entirely.

> +
>  static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
>  {
>  	enter_from_user_mode(regs);
> @@ -821,6 +826,11 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
>  
>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>  {
> +	if (!aarch32_enabled()) {

As above, we should use a cpucap so that this can be an alternative branch
rather than a load and test of a global variable.

> +		el0t_32_sync_ni_handler(regs);

... and similarly we shouldn't need the *_ni_handler() functions.

Mark.

> +		return;
> +	}
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
