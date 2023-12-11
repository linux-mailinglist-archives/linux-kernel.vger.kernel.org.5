Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1580C8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjLKMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjLKMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:06:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A935D6;
        Mon, 11 Dec 2023 04:06:21 -0800 (PST)
Date:   Mon, 11 Dec 2023 12:06:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702296379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G78RNOpLa8XVcxJfF2eZlwdtk/PkTnqU6DbxyMBE2lk=;
        b=1xj0L7aSqbmCin0bvL7p4dPt9uUnI6naXSgsEhQn47xEAYAhexN6ht0ukpTpmN/87x9klB
        3IIcZKj1E/tx8JSbCK56AM6y+OCEjHsxjAyGGBJ8IIpe3R7Ue7/AB3nIQvIwW+GCgG8pRm
        IOd6+CI9O5IbUvp8J7oa700lQx1CdawGhIcnmCl+hBmTzqAYa2LoJqP9aD5rRFVGDr7gVR
        RFd/FRfbpoCmcHhdgi1xsrM0WqigvhCH2asoZuOtnXapM5tAc84Mfo9CoyBVzbm4TLv3rp
        2YTg++dPq1fEAtW+AjDQWe0jgBHPcQL80q8M2BHV0jfZDDjZYi71kL///NNTug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702296379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G78RNOpLa8XVcxJfF2eZlwdtk/PkTnqU6DbxyMBE2lk=;
        b=RoLuEaRlM6CCn8GLgGiIuYESz+pmcK9Qw8PFmpJEfqRPE2EH1ffNYc5dnNnlg3URpiTdfM
        S+SJT+CyNXubEDBg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Fix "const_pcpu_hot" version generation failure
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231204210320.114429-1-ubizjak@gmail.com>
References: <20231204210320.114429-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170229637904.398.12069378585426327897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     0e3703630bd3fead041a6bfb3a3f2a9891af6c34
Gitweb:        https://git.kernel.org/tip/0e3703630bd3fead041a6bfb3a3f2a9891af6c34
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 04 Dec 2023 22:02:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Dec 2023 11:47:14 +01:00

x86/percpu: Fix "const_pcpu_hot" version generation failure

Version generation for "const_pcpu_hot" symbol failed because genksyms
doesn't know the __seg_gs keyword. Effectively revert commit 4604c052b84d
("x86/percpu: Declare const_pcpu_hot as extern const variable") and
use this_cpu_read_const() instead to avoid "sparse: dereference of
noderef expression" warning when reading const_pcpu_hot.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231204210320.114429-1-ubizjak@gmail.com
---
 arch/x86/include/asm/current.h   | 5 +++--
 arch/x86/include/asm/percpu.h    | 7 +++++++
 arch/x86/include/asm/processor.h | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 9fbd7cb..c8c5674 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -37,12 +37,13 @@ static_assert(sizeof(struct pcpu_hot) == 64);
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
+DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+			const_pcpu_hot);
 
 static __always_inline struct task_struct *get_current(void)
 {
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return const_pcpu_hot.current_task;
+		return this_cpu_read_const(const_pcpu_hot.current_task);
 
 	return this_cpu_read_stable(pcpu_hot.current_task);
 }
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 0f12b20..3859aba 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -28,6 +28,7 @@
 
 #else /* ...!ASSEMBLY */
 
+#include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 
@@ -462,6 +463,7 @@ do {									\
 #define this_cpu_write_8(pcp, val)	__raw_cpu_write(volatile, pcp, val)
 #endif
 
+#define this_cpu_read_const(pcp)	__raw_cpu_read(, pcp)
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
@@ -486,6 +488,11 @@ do {									\
 #define this_cpu_write_8(pcp, val)	percpu_to_op(8, volatile, "mov", (pcp), val)
 #endif
 
+/*
+ * The generic per-cpu infrastrucutre is not suitable for
+ * reading const-qualified variables.
+ */
+#define this_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f20e876..a94a857 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -519,7 +519,7 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  entry trampoline.
 	 */
 	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
-		return const_pcpu_hot.top_of_stack;
+		return this_cpu_read_const(const_pcpu_hot.top_of_stack);
 
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
