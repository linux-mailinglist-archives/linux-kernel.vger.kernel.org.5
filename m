Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B179753A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjGNMDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjGNMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8F30DE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6A3861CF8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ECCC433C7;
        Fri, 14 Jul 2023 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336176;
        bh=u28JpsKtmzmM7ch3+n86dxFQxq6SMXzEpAIsFKPewQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvx2oe+9X6z2ScvepDU80Pa36lOIWr3C28TZgr2tvYdfQ+uIT5knhRwM15/IkN/KR
         6gyS+PLnL8JaAZsXQXSENU7+s1Eq6yYbwnOaT/Lso304bYwLVnXaR3c2WxmJ5KW9kF
         KNrX7Y6vK5BPVzglPt9U701Fojo+Aw1sJUi18ElEF2Ss13tyONeN2RUr/0PivUgQr0
         7zF1qD4YjwKNH+xlDZZozlE0kKSIcWUfa+Ny4LYVQyYXvqLA/yueYFGRB7sLB8qr1O
         3gbNr0G3KTxlxe9nGpOVNRiU7LMQXC+0fRpcW3Ju7iEIbOo/ZkZMy0w+wx3YibzcqC
         0CvjT5ifJC2Ew==
Date:   Fri, 14 Jul 2023 14:02:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize in_task() and in_interrupt() a bit
Message-ID: <ZLE5bSAy6857cq9B@lothringen>
References: <44ad7a7afa1b8b1383426971402d2901361db1c5.1689326311.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ad7a7afa1b8b1383426971402d2901361db1c5.1689326311.git.fthain@linux-m68k.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 07:18:31PM +1000, Finn Thain wrote:
> Except on x86, preempt_count is always accessed with READ_ONCE.
> Repeated invocations in macros like irq_count() produce repeated loads.
> These redundant instructions appear in various fast paths. In the one
> shown below, for example, irq_count() is evaluated during kernel entry
> if !tick_nohz_full_cpu(smp_processor_id()).
> 
> 0001ed0a <irq_enter_rcu>:
>    1ed0a:       4e56 0000       linkw %fp,#0
>    1ed0e:       200f            movel %sp,%d0
>    1ed10:       0280 ffff e000  andil #-8192,%d0
>    1ed16:       2040            moveal %d0,%a0
>    1ed18:       2028 0008       movel %a0@(8),%d0
>    1ed1c:       0680 0001 0000  addil #65536,%d0
>    1ed22:       2140 0008       movel %d0,%a0@(8)
>    1ed26:       082a 0001 000f  btst #1,%a2@(15)
>    1ed2c:       670c            beqs 1ed3a <irq_enter_rcu+0x30>
>    1ed2e:       2028 0008       movel %a0@(8),%d0
>    1ed32:       2028 0008       movel %a0@(8),%d0
>    1ed36:       2028 0008       movel %a0@(8),%d0
>    1ed3a:       4e5e            unlk %fp
>    1ed3c:       4e75            rts
> 
> This patch doesn't prevent the pointless btst and beqs instructions
> above, but it does eliminate 2 of the 3 pointless move instructions
> here and elsewhere.
> 
> On x86, preempt_count is per-cpu data and the problem does not arise
> perhaps because the compiler is free to perform similar optimizations.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Fixes: 15115830c887 ("preempt: Cleanup the macro maze a bit")

Does this optimization really deserves a "Fixes:" tag?

> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> This patch was tested on m68k and x86. I was expecting no changes
> to object code for x86 and mostly that's what I saw. However, there
> were a few places where code generation was perturbed for some reason.
> ---
>  include/linux/preempt.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 0df425bf9bd7..953358e40291 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -102,10 +102,11 @@ static __always_inline unsigned char interrupt_context_level(void)
>  #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
>  #ifdef CONFIG_PREEMPT_RT
>  # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
> +# define irq_count()		((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
>  #else
>  # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
> +# define irq_count()		(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK))
>  #endif
> -#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())

Perhaps add a comment as to why you're making these two versions (ie: because
that avoids three consecutive reads), otherwise people may be tempted to roll
that back again in the future to make the code shorter.

>  
>  /*
>   * Macros to retrieve the current execution context:
> @@ -118,7 +119,11 @@ static __always_inline unsigned char interrupt_context_level(void)
>  #define in_nmi()		(nmi_count())
>  #define in_hardirq()		(hardirq_count())
>  #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
> -#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> +#ifdef CONFIG_PREEMPT_RT
> +# define in_task()		(!((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | in_serving_softirq()))
> +#else
> +# define in_task()		(!(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> +#endif

Same here, thanks!

>  
>  /*
>   * The following macros are deprecated and should not be used in new code:
> -- 
> 2.39.3
> 
