Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85F77803EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357303AbjHRCmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357290AbjHRCmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:42:01 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 988DE273C;
        Thu, 17 Aug 2023 19:42:00 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D3D4E92009D; Fri, 18 Aug 2023 04:41:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CCE1092009B;
        Fri, 18 Aug 2023 03:41:59 +0100 (BST)
Date:   Fri, 18 Aug 2023 03:41:59 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 2/3] MIPS: Remove noreturn attribute for die()
In-Reply-To: <1692005246-18399-3-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <alpine.DEB.2.21.2308180231290.8596@angie.orcam.me.uk>
References: <1692005246-18399-1-git-send-email-yangtiezhu@loongson.cn> <1692005246-18399-3-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023, Tiezhu Yang wrote:

> If notify_die() returns NOTIFY_STOP, honor the return value from the
> handler chain invocation in die() as, through a debugger, the fault
> may have been fixed. It makes sense even if ignoring the event will
> make the system unstable, by allowing access through a debugger it
> has been compromised already anyway. So we can remove the noreturn
> attribute for die() to make our port consistent with x86, arm64,
> riscv and csky.

 I find it weird that you say that it is specifically the removal of the 
`noreturn' attribute that makes our port consistent with the other ones 
(and make it the change heading too).  I don't think you need to mention 
the removal of `noreturn' even as you can see it in the code itself and 
it's a natural consequence of the change proper.  How about:

"
MIPS: Do not kill the task in die() if notify_die() returns NOTIFY_STOP

If notify_die() returns NOTIFY_STOP, honor the return value from the 
handler chain invocation in die() and return without killing the task 
as, through a debugger, the fault may have been fixed. It makes sense 
even if ignoring the event will make the system unstable: by allowing 
access through a debugger it has been compromised already anyway. It 
makes our port consistent with x86, arm64, riscv and csky.
"

then (notice the use of a colon rather than a comma changing the meaning 
of the sentence above)?

> Commit 20c0d2d44029 ("[PATCH] i386: pass proper trap numbers to die
> chain handlers") may be the earliest of similar changes.
> 
> Link: https://lore.kernel.org/all/alpine.DEB.2.21.2308132148500.8596@angie.orcam.me.uk/

 I think you meant:

Link: https://lore.kernel.org/r/43DDF02E.76F0.0078.0@novell.com/

didn't you?

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 7a34674..4f5140f 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -391,16 +391,15 @@ void show_registers(struct pt_regs *regs)
>  
>  static DEFINE_RAW_SPINLOCK(die_lock);
>  
> -void __noreturn die(const char *str, struct pt_regs *regs)
> +void die(const char *str, struct pt_regs *regs)
>  {
>  	static int die_counter;
> -	int sig = SIGSEGV;
> +	int ret;
>  
>  	oops_enter();
>  
> -	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
> -		       SIGSEGV) == NOTIFY_STOP)
> -		sig = 0;
> +	ret = notify_die(DIE_OOPS, str, regs, 0,
> +			 current->thread.trap_nr, SIGSEGV);
>  
>  	console_verbose();
>  	raw_spin_lock_irq(&die_lock);
> @@ -422,7 +421,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
>  	if (regs && kexec_should_crash(current))
>  		crash_kexec(regs);
>  
> -	make_task_dead(sig);
> +	if (ret != NOTIFY_STOP)
> +		make_task_dead(SIGSEGV);

 It doesn't appear to me we should panic or execute the crash kernel if 
the oops is to be suppressed.  Can we just do what the x86 port does, that 
is return if !sig after the call to `oops_exit'?

 Also I note that the individual ports aren't exactly consistent here with 
respect to each other, so maybe that's something you might want to post a 
combined follow-up clean-up patch series for too?

  Maciej
