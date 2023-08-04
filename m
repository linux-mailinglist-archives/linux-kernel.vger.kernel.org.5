Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97676F6C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjHDBJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHDBJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51F4215
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE72D61EFE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0730AC433C9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691111348;
        bh=jB/AVgWdSOZxlMIXgH0/3k+Ww5e4ngKqwvGg7rkTYSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RU68zc5WSt0gnYG47NTqrPIJ0U91nlLuXUqM7CRVhMbnMs6WWesLNwCbiDTFES1PP
         kHG0ppCMVpxRBVyWa9ieBbSVJnGOHM5wSVX01JoW56Ft/4O93MgQDO6hQ8BiK6Txza
         ixK7FEJ/++FiJZRLSY25X9RCeXMi2XehoFf2cw+XcamWWEzFpLjrofwa63jzwr8pDa
         9bOmDriItiNkVU5DpsDi1VpdglDI2oqSBbYo2YQpAEm+H1Qeou758qK6b8uSRUwOWO
         W0FZMM3JUekYkid96Wp/br9ST1eDSJEYET0jLUPvIG1kaXv1+TUC/juT99APfA9ol5
         S8xMjlZy0VAqQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so2691878e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 18:09:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVZx0ZAVNayqBuOB6Moif6a5UTJVa66lprQrYlIKwTZ4/qQ/YE
        dwwiqijBLgXNLJLqvjSqa5WspyulUIaPoXIBif8=
X-Google-Smtp-Source: AGHT+IFGwVJKxnoah4BhbjlH2xY7jVN4KdpLUBUU6KA2KE7CLGjMnH6v4F8jsyyh08Dzjhx2sw7LIJkBvje+X9OCDtE=
X-Received: by 2002:a19:914d:0:b0:4fb:9da2:6cec with SMTP id
 y13-20020a19914d000000b004fb9da26cecmr155510lfj.7.1691111345965; Thu, 03 Aug
 2023 18:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230803224458.4156006-1-ancientmodern4@gmail.com>
In-Reply-To: <20230803224458.4156006-1-ancientmodern4@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 09:08:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR+-pBXLsEQM7srOyLyXXpTHRQmDjAaZfkXScFMjhpJhQ@mail.gmail.com>
Message-ID: <CAJF2gTR+-pBXLsEQM7srOyLyXXpTHRQmDjAaZfkXScFMjhpJhQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: signal: handle syscall restart before get_signal
To:     Haorong Lu <ancientmodern4@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mathis Salmen <mathis.salmen@matsal.de>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 6:45=E2=80=AFAM Haorong Lu <ancientmodern4@gmail.com=
> wrote:
>
> In the current riscv implementation, blocking syscalls like read() may
> not correctly restart after being interrupted by ptrace. This problem
> arises when the syscall restart process in arch_do_signal_or_restart()
> is bypassed due to changes to the regs->cause register, such as an
> ebreak instruction.
>
> Steps to reproduce:
> 1. Interrupt the tracee process with PTRACE_SEIZE & PTRACE_INTERRUPT.
> 2. Backup original registers and instruction at new_pc.
> 3. Change pc to new_pc, and inject an instruction (like ebreak) to this
>    address.
> 4. Resume with PTRACE_CONT and wait for the process to stop again after
>    executing ebreak.
> 5. Restore original registers and instructions, and detach from the
>    tracee process.
> 6. Now the read() syscall in tracee will return -1 with errno set to
>    ERESTARTSYS.
>
> Specifically, during an interrupt, the regs->cause changes from
> EXC_SYSCALL to EXC_BREAKPOINT due to the injected ebreak, which is
> inaccessible via ptrace so we cannot restore it. This alteration breaks
> the syscall restart condition and ends the read() syscall with an
> ERESTARTSYS error. According to include/linux/errno.h, it should never
> be seen by user programs. X86 can avoid this issue as it checks the
> syscall condition using a register (orig_ax) exposed to user space.
> Arm64 handles syscall restart before calling get_signal, where it could
> be paused and inspected by ptrace/debugger.
>
> This patch adjusts the riscv implementation to arm64 style, which also
> checks syscall using a kernel register (syscallno). It ensures the
> syscall restart process is not bypassed when changes to the cause
> register occur, providing more consistent behavior across various
> architectures.
>
> For a simplified reproduction program, feel free to visit:
> https://github.com/ancientmodern/riscv-ptrace-bug-demo.
>
> Signed-off-by: Haorong Lu <ancientmodern4@gmail.com>
> ---
>  arch/riscv/kernel/signal.c | 85 +++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 180d951d3624..d2d7169048ea 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -391,30 +391,6 @@ static void handle_signal(struct ksignal *ksig, stru=
ct pt_regs *regs)
>         sigset_t *oldset =3D sigmask_to_save();
>         int ret;
>
> -       /* Are we from a system call? */
> -       if (regs->cause =3D=3D EXC_SYSCALL) {
> -               /* Avoid additional syscall restarting via ret_from_excep=
tion */
> -               regs->cause =3D -1UL;
> -               /* If so, check system call restarting.. */
> -               switch (regs->a0) {
> -               case -ERESTART_RESTARTBLOCK:
> -               case -ERESTARTNOHAND:
> -                       regs->a0 =3D -EINTR;
> -                       break;
> -
> -               case -ERESTARTSYS:
> -                       if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
> -                               regs->a0 =3D -EINTR;
> -                               break;
> -                       }
> -                       fallthrough;
> -               case -ERESTARTNOINTR:
> -                        regs->a0 =3D regs->orig_a0;
> -                       regs->epc -=3D 0x4;
> -                       break;
> -               }
> -       }
> -
>         rseq_signal_deliver(ksig, regs);
>
>         /* Set up the stack frame */
> @@ -428,35 +404,66 @@ static void handle_signal(struct ksignal *ksig, str=
uct pt_regs *regs)
>
>  void arch_do_signal_or_restart(struct pt_regs *regs)
>  {
> +       unsigned long continue_addr =3D 0, restart_addr =3D 0;
> +       int retval =3D 0;
>         struct ksignal ksig;
> +       bool syscall =3D (regs->cause =3D=3D EXC_SYSCALL);
>
> -       if (get_signal(&ksig)) {
> -               /* Actually deliver the signal */
> -               handle_signal(&ksig, regs);
> -               return;
> -       }
> +       /* If we were from a system call, check for system call restartin=
g */
> +       if (syscall) {
> +               continue_addr =3D regs->epc;
> +               restart_addr =3D continue_addr - 4;
> +               retval =3D regs->a0;
>
> -       /* Did we come from a system call? */
> -       if (regs->cause =3D=3D EXC_SYSCALL) {
>                 /* Avoid additional syscall restarting via ret_from_excep=
tion */
>                 regs->cause =3D -1UL;
>
> -               /* Restart the system call - no handlers present */
> -               switch (regs->a0) {
> +               /*
> +                * Prepare for system call restart. We do this here so th=
at a
> +                * debugger will see the already changed PC.
> +                */
> +               switch (retval) {
>                 case -ERESTARTNOHAND:
>                 case -ERESTARTSYS:
>                 case -ERESTARTNOINTR:
> -                        regs->a0 =3D regs->orig_a0;
> -                       regs->epc -=3D 0x4;
> -                       break;
>                 case -ERESTART_RESTARTBLOCK:
> -                        regs->a0 =3D regs->orig_a0;
> -                       regs->a7 =3D __NR_restart_syscall;
> -                       regs->epc -=3D 0x4;
> +                       regs->a0 =3D regs->orig_a0;
> +                       regs->epc =3D restart_addr;
>                         break;
>                 }
>         }
>
> +       /*
> +        * Get the signal to deliver. When running under ptrace, at this =
point
> +        * the debugger may change all of our registers.
> +        */
> +       if (get_signal(&ksig)) {
> +               /*
> +                * Depending on the signal settings, we may need to rever=
t the
> +                * decision to restart the system call, but skip this if =
a
> +                * debugger has chosen to restart at a different PC.
> +                */
> +               if (regs->epc =3D=3D restart_addr &&
> +                   (retval =3D=3D -ERESTARTNOHAND ||
> +                    retval =3D=3D -ERESTART_RESTARTBLOCK ||
> +                    (retval =3D=3D -ERESTARTSYS &&
> +                     !(ksig.ka.sa.sa_flags & SA_RESTART)))) {
> +                       regs->a0 =3D -EINTR;
> +                       regs->epc =3D continue_addr;
> +               }
> +
> +               /* Actually deliver the signal */
> +               handle_signal(&ksig, regs);
> +               return;
> +       }
> +
> +       /*
> +        * Handle restarting a different system call. As above, if a debu=
gger
> +        * has chosen to restart at a different PC, ignore the restart.
> +        */
> +       if (syscall && regs->epc =3D=3D restart_addr && retval =3D=3D -ER=
ESTART_RESTARTBLOCK)
> +               regs->a7 =3D __NR_restart_syscall;
> +
I thought your patch contains two parts:
1. bugfix
2. Some coding conventions or adjusting some logic of the original signal.

Could we separate them into two pieces and make the bugfix one
minimalistic? Then, people could easier to review your patches.

>         /*
>          * If there is no signal to deliver, we just put the saved
>          * sigmask back.
> --
> 2.41.0
>


--=20
Best Regards
 Guo Ren
