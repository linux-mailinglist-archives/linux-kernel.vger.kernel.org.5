Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D07F1D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjKTTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjKTTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:08:41 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEF96D2;
        Mon, 20 Nov 2023 11:08:36 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1r59dK-0000eh-00; Mon, 20 Nov 2023 20:08:34 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 821E1C0136; Mon, 20 Nov 2023 20:08:24 +0100 (CET)
Date:   Mon, 20 Nov 2023 20:08:24 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, syq@debian.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: process: Remove lazy context flags for new kernel
 thread
Message-ID: <ZVuuqAUJ7f2ELIYW@alpha.franken.de>
References: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
 <ZTvQGs/lEpizUFLh@aurel32.net>
 <ZVjaDTcjNpD3m0cC@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVjaDTcjNpD3m0cC@aurel32.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 04:36:45PM +0100, Aurelien Jarno wrote:
> > Anyway, I have been able to test a backport of the patch onto the 5.10
> > kernel (with minor adjustments) and I confirm it fixes the reported
> > issue.
> > 
> > Tested-by: Aurelien Jarno <aurel32@debian.org>
> 
> It seems that this patch hasn't been merged yet, either in Linus' tree
> or in the MIPS tree. Is there anything blocking?

sorry, took some time to get really back from vacation...

I don't like the patch doing too much code restructing. I can't
reproduce on my loongson machine, so I can't test below patch...

What cmake version do I need and what would be a package to
reproduce the bug ?

Thomas.

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5387ed0a5186..b630604c577f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -121,6 +121,19 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
+
+	/*
+	 * New tasks lose permission to use the fpu. This accelerates context
+	 * switching for most programs since they don't use the fpu.
+	 */
+	clear_tsk_thread_flag(p, TIF_USEDFPU);
+	clear_tsk_thread_flag(p, TIF_USEDMSA);
+	clear_tsk_thread_flag(p, TIF_MSA_CTX_LIVE);
+
+#ifdef CONFIG_MIPS_MT_FPAFF
+	clear_tsk_thread_flag(p, TIF_FPUBOUND);
+#endif /* CONFIG_MIPS_MT_FPAFF */
+
 	if (unlikely(args->fn)) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
@@ -149,20 +162,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.reg29 = (unsigned long) childregs;
 	p->thread.reg31 = (unsigned long) ret_from_fork;
 
-	/*
-	 * New tasks lose permission to use the fpu. This accelerates context
-	 * switching for most programs since they don't use the fpu.
-	 */
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
 
-	clear_tsk_thread_flag(p, TIF_USEDFPU);
-	clear_tsk_thread_flag(p, TIF_USEDMSA);
-	clear_tsk_thread_flag(p, TIF_MSA_CTX_LIVE);
-
-#ifdef CONFIG_MIPS_MT_FPAFF
-	clear_tsk_thread_flag(p, TIF_FPUBOUND);
-#endif /* CONFIG_MIPS_MT_FPAFF */
-
 #ifdef CONFIG_MIPS_FP_SUPPORT
 	atomic_set(&p->thread.bd_emu_frame, BD_EMUFRAME_NONE);
 #endif

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
