Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3E76F5D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHCWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHCWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:45:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC130C0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:45:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-563c7aabf38so1815353a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691102701; x=1691707501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAlJWo27YckxGe+Mw6BTj+vxeILwstk0mYPg6rjf2Hs=;
        b=AcL5dzc9c7sV9ducujGWgHv687kRJ/vhcG6lFXz39juZ9x8ATzr7B3hrI7JD06d2Vy
         LYSxUclHk270RcAQTa+4snrIYlBakPDVZRA2DzoUiWoQbMn7VJyjFdEjpCAFP1IEm92p
         a4pRoVUmHQfXs+ApMjRDoPjNHbwBE01IcZjw5WrtQAb0J+ekMVlQLaYKvUsXP2UoVBIF
         0o44PuXlpK/k2IuTMteshRTJXpzU9uNVYm4VksT2YKX2dOtqGzGTzDNnWgoIDTxClRMB
         0vwF7BOkkju/MoeMaou+ufgxKNDvsKSZhx5IlxbZSKuNWOrXq6hEeQzqKB+hfY8M49MX
         Q07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691102701; x=1691707501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAlJWo27YckxGe+Mw6BTj+vxeILwstk0mYPg6rjf2Hs=;
        b=N92kGo74/1YZ6TTnVbU/52yZSmDNN4ixGRnCG+1gwsyAbrnPYoN202NUgQwmUxHnTO
         amEfo5U6rUhK1bPZDPgi4fUuWrVhsqj1x36WnQwZfpeojiFQ3zrMdhR439lyaRwA6rOR
         gj49+2qslGomSC8AOduuEbU/ZWwtcuQelRRl7NowlrW0OTIiabGV0aluRAGEVdF2oFFh
         urjXa1zeZxPgqWtg2n59NoEopSlPwIvwpDxHFPP7xkyXciAtPlqspoRnghSnTKdfWsAa
         tWKIt+yuIsgyInt7SltrmTnQ7jpRIfUpVnoi8pJLE/ARALyjSX/WgqTWf2tF2ZdI0GI5
         Nq6g==
X-Gm-Message-State: AOJu0YyAMaZP0eacdPM1SF5bPrBAZDkOS2M5NrpsHTYyuLvisgfGBMri
        oCSP2npYZ83k/z6T0fvlFtM=
X-Google-Smtp-Source: AGHT+IFKVOLQ1aybl2M17BBYvolMeeUhomCebMp1p+r+44b6sLMJ82VEB8fUFIkzAUAMIXae1dIw+Q==
X-Received: by 2002:a17:90b:1e10:b0:268:94b:8d0 with SMTP id pg16-20020a17090b1e1000b00268094b08d0mr126790pjb.11.1691102700837;
        Thu, 03 Aug 2023 15:45:00 -0700 (PDT)
Received: from haorong.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001bc18e579aesm359196plh.101.2023.08.03.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:45:00 -0700 (PDT)
From:   Haorong Lu <ancientmodern4@gmail.com>
Cc:     Haorong Lu <ancientmodern4@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mathis Salmen <mathis.salmen@matsal.de>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] riscv: signal: handle syscall restart before get_signal
Date:   Thu,  3 Aug 2023 15:44:54 -0700
Message-ID: <20230803224458.4156006-1-ancientmodern4@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current riscv implementation, blocking syscalls like read() may
not correctly restart after being interrupted by ptrace. This problem
arises when the syscall restart process in arch_do_signal_or_restart()
is bypassed due to changes to the regs->cause register, such as an
ebreak instruction.

Steps to reproduce:
1. Interrupt the tracee process with PTRACE_SEIZE & PTRACE_INTERRUPT.
2. Backup original registers and instruction at new_pc.
3. Change pc to new_pc, and inject an instruction (like ebreak) to this
   address.
4. Resume with PTRACE_CONT and wait for the process to stop again after
   executing ebreak.
5. Restore original registers and instructions, and detach from the
   tracee process.
6. Now the read() syscall in tracee will return -1 with errno set to
   ERESTARTSYS.

Specifically, during an interrupt, the regs->cause changes from
EXC_SYSCALL to EXC_BREAKPOINT due to the injected ebreak, which is
inaccessible via ptrace so we cannot restore it. This alteration breaks
the syscall restart condition and ends the read() syscall with an
ERESTARTSYS error. According to include/linux/errno.h, it should never
be seen by user programs. X86 can avoid this issue as it checks the
syscall condition using a register (orig_ax) exposed to user space.
Arm64 handles syscall restart before calling get_signal, where it could
be paused and inspected by ptrace/debugger.

This patch adjusts the riscv implementation to arm64 style, which also
checks syscall using a kernel register (syscallno). It ensures the
syscall restart process is not bypassed when changes to the cause
register occur, providing more consistent behavior across various
architectures.

For a simplified reproduction program, feel free to visit:
https://github.com/ancientmodern/riscv-ptrace-bug-demo.

Signed-off-by: Haorong Lu <ancientmodern4@gmail.com>
---
 arch/riscv/kernel/signal.c | 85 +++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 180d951d3624..d2d7169048ea 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -391,30 +391,6 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
-	/* Are we from a system call? */
-	if (regs->cause == EXC_SYSCALL) {
-		/* Avoid additional syscall restarting via ret_from_exception */
-		regs->cause = -1UL;
-		/* If so, check system call restarting.. */
-		switch (regs->a0) {
-		case -ERESTART_RESTARTBLOCK:
-		case -ERESTARTNOHAND:
-			regs->a0 = -EINTR;
-			break;
-
-		case -ERESTARTSYS:
-			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
-				regs->a0 = -EINTR;
-				break;
-			}
-			fallthrough;
-		case -ERESTARTNOINTR:
-                        regs->a0 = regs->orig_a0;
-			regs->epc -= 0x4;
-			break;
-		}
-	}
-
 	rseq_signal_deliver(ksig, regs);
 
 	/* Set up the stack frame */
@@ -428,35 +404,66 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 
 void arch_do_signal_or_restart(struct pt_regs *regs)
 {
+	unsigned long continue_addr = 0, restart_addr = 0;
+	int retval = 0;
 	struct ksignal ksig;
+	bool syscall = (regs->cause == EXC_SYSCALL);
 
-	if (get_signal(&ksig)) {
-		/* Actually deliver the signal */
-		handle_signal(&ksig, regs);
-		return;
-	}
+	/* If we were from a system call, check for system call restarting */
+	if (syscall) {
+		continue_addr = regs->epc;
+		restart_addr = continue_addr - 4;
+		retval = regs->a0;
 
-	/* Did we come from a system call? */
-	if (regs->cause == EXC_SYSCALL) {
 		/* Avoid additional syscall restarting via ret_from_exception */
 		regs->cause = -1UL;
 
-		/* Restart the system call - no handlers present */
-		switch (regs->a0) {
+		/*
+		 * Prepare for system call restart. We do this here so that a
+		 * debugger will see the already changed PC.
+		 */
+		switch (retval) {
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
-                        regs->a0 = regs->orig_a0;
-			regs->epc -= 0x4;
-			break;
 		case -ERESTART_RESTARTBLOCK:
-                        regs->a0 = regs->orig_a0;
-			regs->a7 = __NR_restart_syscall;
-			regs->epc -= 0x4;
+			regs->a0 = regs->orig_a0;
+			regs->epc = restart_addr;
 			break;
 		}
 	}
 
+	/*
+	 * Get the signal to deliver. When running under ptrace, at this point
+	 * the debugger may change all of our registers.
+	 */
+	if (get_signal(&ksig)) {
+		/*
+		 * Depending on the signal settings, we may need to revert the
+		 * decision to restart the system call, but skip this if a
+		 * debugger has chosen to restart at a different PC.
+		 */
+		if (regs->epc == restart_addr &&
+		    (retval == -ERESTARTNOHAND ||
+		     retval == -ERESTART_RESTARTBLOCK ||
+		     (retval == -ERESTARTSYS &&
+		      !(ksig.ka.sa.sa_flags & SA_RESTART)))) {
+			regs->a0 = -EINTR;
+			regs->epc = continue_addr;
+		}
+
+		/* Actually deliver the signal */
+		handle_signal(&ksig, regs);
+		return;
+	}
+
+	/*
+	 * Handle restarting a different system call. As above, if a debugger
+	 * has chosen to restart at a different PC, ignore the restart.
+	 */
+	if (syscall && regs->epc == restart_addr && retval == -ERESTART_RESTARTBLOCK)
+		regs->a7 = __NR_restart_syscall;
+
 	/*
 	 * If there is no signal to deliver, we just put the saved
 	 * sigmask back.
-- 
2.41.0

