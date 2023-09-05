Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A3792BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbjIERCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354133AbjIEJtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:49:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 341781AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:49:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F3111FB;
        Tue,  5 Sep 2023 02:50:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352A13F793;
        Tue,  5 Sep 2023 02:49:38 -0700 (PDT)
Date:   Tue, 5 Sep 2023 10:49:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] panic: Use atomic_try_cmpxchg in panic() and nmi_panic()
Message-ID: <ZPb5kt_XD6Ta2X6n@FVFF77S0Q05N>
References: <20230904152230.9227-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904152230.9227-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 05:21:01PM +0200, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in panic() and nmi_panic().  x86 CMPXCHG instruction returns success in
> ZF flag, so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Also, rename cpu variable to this_cpu in nmi_panic() and try to unify
> logic flow between panic() and nmi_panic().
> 
> No functional change intended.

Do we really need to save a compare here? A panic isn't exactly a fast path,
and robustness and code clarity is far more important than performance here.

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  kernel/panic.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 07239d4ad81e..8740ac65cb2c 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -192,14 +192,15 @@ atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
>   */
>  void nmi_panic(struct pt_regs *regs, const char *msg)
>  {
> -	int old_cpu, cpu;
> +	int old_cpu, this_cpu;
>  
> -	cpu = raw_smp_processor_id();
> -	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
> +	old_cpu = PANIC_CPU_INVALID;
> +	this_cpu = raw_smp_processor_id();
>  
> -	if (old_cpu == PANIC_CPU_INVALID)
> +	/* atomic_try_cmpxchg updates old_cpu on failure */
> +	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
>  		panic("%s", msg);
> -	else if (old_cpu != cpu)
> +	else if (old_cpu != this_cpu)
>  		nmi_panic_self_stop(regs);
>  }
>  EXPORT_SYMBOL(nmi_panic);
> @@ -311,15 +312,18 @@ void panic(const char *fmt, ...)
>  	 * stop themself or will wait until they are stopped by the 1st CPU
>  	 * with smp_send_stop().
>  	 *
> -	 * `old_cpu == PANIC_CPU_INVALID' means this is the 1st CPU which
> -	 * comes here, so go ahead.
> +	 * cmpxchg success means this is the 1st CPU which comes here,
> +	 * so go ahead.
>  	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
>  	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
>  	 */
> +	old_cpu = PANIC_CPU_INVALID;
>  	this_cpu = raw_smp_processor_id();
> -	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
>  
> -	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
> +	/* atomic_try_cmpxchg updates old_cpu on failure */
> +	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
> +		;
> +	else if (old_cpu != this_cpu)
>  		panic_smp_self_stop();

That empty statement is quite painful to read and would be easy to break in
future with other changes. It'd be better to either avoid that entirely, or use
braces, e.g.

	if (!atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu) &&
	    old_cpu != this_cpu)
		 panic_smp_self_stop();

... or:

	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
		/* do nothing */
	} else if (old_cpu != this_cpu) {
		panic_smp_self_stop();
	}

The former is closer to the existing logic, so that's probably best.

Mark.
