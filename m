Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2017079D080
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjILL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjILL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:58:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D31722;
        Tue, 12 Sep 2023 04:57:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5D4C433C8;
        Tue, 12 Sep 2023 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694519877;
        bh=4Xylyg4Vp6jVguzMuCezz1iiCS344DbnSDbckTx6MjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEbhIbaoqPi47AUJVl/lKVeL5CpiDVMTgRXXH7bT2lk4AdvIgqSUZfGesMXkkTcA6
         ZLQRGQOZO/3Ksh9YoKQEzahqLPYG6aWiQVWaQoWl+aM4Wv6NWs9WR3HVCz0bDe6O5G
         42DzL4K5JEM8E9Fq0ceeYA2YnzHsazVTwmoX3f3xZpDrevRZwIHSDA6fUa3Mko6mG5
         g/aYl+eA6C6enOca9zJvdeqAUocV8tdD+gM9UR7J5a1IY0Bvqy6rQHomMIkYNCkjiT
         RHAftuDsGNBOAU1eFaybqPUXwujUvM9GpMslSiVZvuyc2UaYQIUNEAhghspWSj+Fpq
         BoP5jUfhPcN3g==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/6] riscv: vector: do not pass task_struct into riscv_v_vstate_{save,restore}()
Date:   Tue, 12 Sep 2023 13:57:26 +0200
Message-Id: <20230912115728.172982-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912115728.172982-1-bjorn@kernel.org>
References: <20230912115728.172982-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Chiu <andy.chiu@sifive.com>

riscv_v_vstate_{save,restore}() can operate only on the knowlege of
struct __riscv_v_ext_state, and struct pt_regs. Let the caller decides
which should be passed into the function. Meanwhile, the kernel-mode
Vector is going to introduce another vstate, so this also makes functions
potentially able to be reused.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/entry-common.h  |  2 +-
 arch/riscv/include/asm/vector.h        | 14 +++++---------
 arch/riscv/kernel/kernel_mode_vector.c |  2 +-
 arch/riscv/kernel/ptrace.c             |  2 +-
 arch/riscv/kernel/signal.c             |  2 +-
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 52926f4d8d7c..aa1b9e50d6c8 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -12,7 +12,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 {
 	if (ti_work & _TIF_RISCV_V_DEFER_RESTORE) {
 		clear_thread_flag(TIF_RISCV_V_DEFER_RESTORE);
-		riscv_v_vstate_restore(current, regs);
+		riscv_v_vstate_restore(&current->thread.vstate, regs);
 	}
 }
 
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 768acd517414..9b818aac8a94 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -164,23 +164,19 @@ static inline void riscv_v_vstate_discard(struct pt_regs *regs)
 	__riscv_v_vstate_dirty(regs);
 }
 
-static inline void riscv_v_vstate_save(struct task_struct *task,
+static inline void riscv_v_vstate_save(struct __riscv_v_ext_state *vstate,
 				       struct pt_regs *regs)
 {
 	if ((regs->status & SR_VS) == SR_VS_DIRTY) {
-		struct __riscv_v_ext_state *vstate = &task->thread.vstate;
-
 		__riscv_v_vstate_save(vstate, vstate->datap);
 		__riscv_v_vstate_clean(regs);
 	}
 }
 
-static inline void riscv_v_vstate_restore(struct task_struct *task,
+static inline void riscv_v_vstate_restore(struct __riscv_v_ext_state *vstate,
 					  struct pt_regs *regs)
 {
 	if ((regs->status & SR_VS) != SR_VS_OFF) {
-		struct __riscv_v_ext_state *vstate = &task->thread.vstate;
-
 		__riscv_v_vstate_restore(vstate, vstate->datap);
 		__riscv_v_vstate_clean(regs);
 	}
@@ -201,7 +197,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
 	struct pt_regs *regs;
 
 	regs = task_pt_regs(prev);
-	riscv_v_vstate_save(prev, regs);
+	riscv_v_vstate_save(&prev->thread.vstate, regs);
 	riscv_v_vstate_set_restore(next, task_pt_regs(next));
 }
 
@@ -219,8 +215,8 @@ static inline bool riscv_v_vstate_query(struct pt_regs *regs) { return false; }
 static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 #define riscv_v_vsize (0)
 #define riscv_v_vstate_discard(regs)		do {} while (0)
-#define riscv_v_vstate_save(task, regs)		do {} while (0)
-#define riscv_v_vstate_restore(task, regs)	do {} while (0)
+#define riscv_v_vstate_save(vstate, regs)	do {} while (0)
+#define riscv_v_vstate_restore(vstate, regs)	do {} while (0)
 #define __switch_to_vector(__prev, __next)	do {} while (0)
 #define riscv_v_vstate_off(regs)		do {} while (0)
 #define riscv_v_vstate_on(regs)			do {} while (0)
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 1c3b32d2b340..d9e097e68937 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -68,7 +68,7 @@ void kernel_vector_begin(void)
 
 	BUG_ON(!may_use_simd());
 
-	riscv_v_vstate_save(current, task_pt_regs(current));
+	riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
 
 	get_cpu_vector_context();
 
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2afe460de16a..2e7e00f4f8e1 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -100,7 +100,7 @@ static int riscv_vr_get(struct task_struct *target,
 	 * copying them to membuf.
 	 */
 	if (target == current)
-		riscv_v_vstate_save(current, task_pt_regs(current));
+		riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
 
 	ptrace_vstate.vstart = vstate->vstart;
 	ptrace_vstate.vl = vstate->vl;
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 0fca2c128b5f..75fd8cc05e10 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -86,7 +86,7 @@ static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
 	/* datap is designed to be 16 byte aligned for better performance */
 	WARN_ON(unlikely(!IS_ALIGNED((unsigned long)datap, 16)));
 
-	riscv_v_vstate_save(current, regs);
+	riscv_v_vstate_save(&current->thread.vstate, regs);
 	/* Copy everything of vstate but datap. */
 	err = __copy_to_user(&state->v_state, &current->thread.vstate,
 			     offsetof(struct __riscv_v_ext_state, datap));
-- 
2.39.2

