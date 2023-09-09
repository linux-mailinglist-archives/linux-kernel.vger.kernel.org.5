Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFF7999CE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjIIQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjIIOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:24:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100FA180;
        Sat,  9 Sep 2023 07:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEF5C433C8;
        Sat,  9 Sep 2023 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694269481;
        bh=zVn2Zw7WnqviXrl0PFThoMfvMcVrD4b3OlWOf1nMLeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VLsaU8JnoEKd5Nr/fIz+WM6zKsNNKK8bTE+O8loGiVXjA7B6F/CS4cbQpXA78ykuo
         srX9/kAWw7+qjk9UZZwXIthm/FVner+NBL+GM6vgJB6xMCjIrZkyQupiCD8ed+PKSc
         7+Eu+TyUhBmkRRWOASNOJ/oHADM9JQhEeP5xMzYs0FwE3IEnyU0s2i1KC541JVwtMi
         CSAU0+kV6pc5BBcOiN7GTwTo/mchs14GVnJiIWx7gdvrDlQM3xavfBOZ9RAzXtuKn1
         JAVuYA10plL7MK4H05N/XYSmwG2I+ro0nzwCDyyMHzcphSrcTJx2iymowRN29qUyDh
         oIfDyiMG+D3+g==
Date:   Sat, 9 Sep 2023 23:24:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230909232435.dfa15f93f1c5eef5b229a7d2@kernel.org>
In-Reply-To: <yt9dzg1zokyg.fsf@linux.ibm.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
        <169280377434.282662.7610009313268953247.stgit@devnote2>
        <20230904224038.4420a76ea15931aa40179697@kernel.org>
        <yt9d5y4pozrl.fsf@linux.ibm.com>
        <20230905223633.23cd4e6e8407c45b934be477@kernel.org>
        <yt9dzg1zokyg.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Wed, 06 Sep 2023 08:49:11 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Masami,
> 
> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> 
> > Thus, we need to ensure that the ftrace_regs which is saved in the ftrace
> > *without* FTRACE_WITH_REGS flags, can be used for hooking the function
> > return. I saw;
> >
> > void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> > {
> >         rh->ret_addr = regs->gprs[14];
> >         rh->frame = regs->gprs[15];
> >
> >         /* Replace the return addr with trampoline addr */
> >         regs->gprs[14] = (unsigned long)&arch_rethook_trampoline;
> > }
> >
> > gprs[15] is a stack pointer, so it is saved in ftrace_regs too, but what about
> > gprs[14]? (I guess it is a link register)
> > We need to read the gprs[14] and ensure that is restored to gpr14 when the
> > ftrace is exit even without FTRACE_WITH_REGS flag.
> >
> > IOW, it is ftrace save regs/restore regs code issue. I need to check how the
> > function_graph implements it.
> 
> gpr2-gpr14 are always saved in ftrace_caller/ftrace_regs_caller(),
> regardless of the FTRACE_WITH_REGS flags. The only difference is that
> without the FTRACE_WITH_REGS flag the program status word (psw) is not
> saved because collecting that is a rather expensive operation.

Thanks for checking that! So s390 will recover those saved registers
even if FTRACE_WITH_REGS flag is not set? (I wonder what is the requirement
of the ftrace_regs when returning from ftrace_call() without
FTRACE_WITH_REGS?)

> 
> I used the following commands to test rethook (is that the correct
> testcase?)
> 
> #!/bin/bash
> cd /sys/kernel/tracing
> 
> echo 'r:icmp_rcv icmp_rcv' >kprobe_events
> echo 1 >events/kprobes/icmp_rcv/enable
> ping -c 1 127.0.0.1
> cat trace

No, the kprobe will path pt_regs to rethook.
Cna you run

echo "f:icmp_rcv%return icmp_rcv" >> dynamic_events

instead of kprobe_events?

Thank you,

> 
> which gave me:
> 
> ping-686     [001] ..s1.    96.890817: icmp_rcv: (ip_protocol_deliver_rcu+0x42/0x218 <- icmp_rcv)
> 
> I applied the following patch on top of your patches to make it compile,
> and rethook still seems to work:
> 
> commit dab51b0a5b885660630433ac89f8e64a2de0eb86
> Author: Sven Schnelle <svens@linux.ibm.com>
> Date:   Wed Sep 6 08:06:23 2023 +0200
> 
>     rethook wip
>     
>     Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> 
> diff --git a/arch/s390/kernel/rethook.c b/arch/s390/kernel/rethook.c
> index af10e6bdd34e..4e86c0a1a064 100644
> --- a/arch/s390/kernel/rethook.c
> +++ b/arch/s390/kernel/rethook.c
> @@ -3,8 +3,9 @@
>  #include <linux/kprobes.h>
>  #include "rethook.h"
>  
> -void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> +void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
>  {
> +	struct pt_regs *regs = (struct pt_regs *)fregs;
>  	rh->ret_addr = regs->gprs[14];
>  	rh->frame = regs->gprs[15];
>  
> @@ -13,10 +14,11 @@ void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mc
>  }
>  NOKPROBE_SYMBOL(arch_rethook_prepare);
>  
> -void arch_rethook_fixup_return(struct pt_regs *regs,
> +void arch_rethook_fixup_return(struct ftrace_regs *fregs,
>  			       unsigned long correct_ret_addr)
>  {
>  	/* Replace fake return address with real one. */
> +	struct pt_regs *regs = (struct pt_regs *)fregs;
>  	regs->gprs[14] = correct_ret_addr;
>  }
>  NOKPROBE_SYMBOL(arch_rethook_fixup_return);
> @@ -24,9 +26,9 @@ NOKPROBE_SYMBOL(arch_rethook_fixup_return);
>  /*
>   * Called from arch_rethook_trampoline
>   */
> -unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
> +unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs)
>  {
> -	return rethook_trampoline_handler(regs, regs->gprs[15]);
> +	return rethook_trampoline_handler(fregs, fregs->regs.gprs[15]);
>  }
>  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>  
> diff --git a/arch/s390/kernel/rethook.h b/arch/s390/kernel/rethook.h
> index 32f069eed3f3..0fe62424fc78 100644
> --- a/arch/s390/kernel/rethook.h
> +++ b/arch/s390/kernel/rethook.h
> @@ -2,6 +2,6 @@
>  #ifndef __S390_RETHOOK_H
>  #define __S390_RETHOOK_H
>  
> -unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +unsigned long arch_rethook_trampoline_callback(struct ftrace_regs *fregs);
>  
>  #endif
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
