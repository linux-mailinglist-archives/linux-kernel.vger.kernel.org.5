Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989B479D078
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjILL6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjILL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:57:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962110D2;
        Tue, 12 Sep 2023 04:57:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D39C433C7;
        Tue, 12 Sep 2023 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694519866;
        bh=Ea39ZA0/3RZcsItSpEiJ7oucesvvZLA878PUm8prZII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWSuIktaGwuOcxkYUaHG9dbixPw8+Fmca3NGIJ8npY33w861samcAJr8dlErVkZQZ
         ogAUnfuw/wBiSsJU7CrCWNYmnkTRayDwb5plTR0zOBrJGGAFkarcUMOS6MfvxFV1TQ
         W8Yr6CwRmua46FInyLDTl5TzVypnX9AGXkiqlulVBkoyKURC8DnXWllWLlXh8QFav/
         TE7svf8wPhemHjBbEDEJ8ArE7MVqd5DG07kVK/Otkfz25G3EWK5ZPgH5Hcl+Y5IvUu
         nphOf8uAlggGwAR/0XPoM2AFjY4/XkoGJz13gNVswScu3YRugHFqINclexQWtcKA48
         v+7F6PN3cggOw==
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
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [RFC PATCH 1/6] riscv: sched: defer restoring Vector context for user
Date:   Tue, 12 Sep 2023 13:57:23 +0200
Message-Id: <20230912115728.172982-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912115728.172982-1-bjorn@kernel.org>
References: <20230912115728.172982-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Chiu <andy.chiu@sifive.com>

User will use its Vector registers only after the kernel really returns
to the userspace. So we can delay restoring Vector registers as long as
we are still running in kernel mode. So, add a thread flag to indicates
the need of restoring Vector and do the restore at the last
arch-specific exit-to-user hook. This save the context restoring cost
when we switch over multiple processes that run V in kernel mode. For
example, if the kernel performs a context swicth from A->B->C, and
returns to C's userspace, then there is no need to restore B's
V-register.

Besides, this also prevents us from repeatedly restoring V context when
executing kernel-mode Vector multiple times for the upcoming kenel-mode
Vector patches.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/entry-common.h | 13 +++++++++++++
 arch/riscv/include/asm/thread_info.h  |  2 ++
 arch/riscv/include/asm/vector.h       | 11 ++++++++++-
 arch/riscv/kernel/process.c           |  2 ++
 arch/riscv/kernel/signal.c            |  2 +-
 arch/riscv/kernel/vector.c            |  2 +-
 6 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 6e4dee49d84b..52926f4d8d7c 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -4,6 +4,19 @@
 #define _ASM_RISCV_ENTRY_COMMON_H
 
 #include <asm/stacktrace.h>
+#include <asm/thread_info.h>
+#include <asm/vector.h>
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (ti_work & _TIF_RISCV_V_DEFER_RESTORE) {
+		clear_thread_flag(TIF_RISCV_V_DEFER_RESTORE);
+		riscv_v_vstate_restore(current, regs);
+	}
+}
+
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 1833beb00489..b182f2d03e25 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -93,12 +93,14 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
+#define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
 
 #define _TIF_WORK_MASK \
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index c5ee07b3df07..531873986a15 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -184,6 +184,15 @@ static inline void riscv_v_vstate_restore(struct task_struct *task,
 	}
 }
 
+static inline void riscv_v_vstate_set_restore(struct task_struct *task,
+					      struct pt_regs *regs)
+{
+	if ((regs->status & SR_VS) != SR_VS_OFF) {
+		set_tsk_thread_flag(task, TIF_RISCV_V_DEFER_RESTORE);
+		riscv_v_vstate_on(regs);
+	}
+}
+
 static inline void __switch_to_vector(struct task_struct *prev,
 				      struct task_struct *next)
 {
@@ -191,7 +200,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
 
 	regs = task_pt_regs(prev);
 	riscv_v_vstate_save(prev, regs);
-	riscv_v_vstate_restore(next, task_pt_regs(next));
+	riscv_v_vstate_set_restore(next, task_pt_regs(next));
 }
 
 void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e32d737e039f..ec89e7edb6fd 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -153,6 +153,7 @@ void flush_thread(void)
 	riscv_v_vstate_off(task_pt_regs(current));
 	kfree(current->thread.vstate.datap);
 	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
+	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
 #endif
 }
 
@@ -169,6 +170,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	*dst = *src;
 	/* clear entire V context, including datap for a new task */
 	memset(&dst->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
+	clear_tsk_thread_flag(dst, TIF_RISCV_V_DEFER_RESTORE);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 180d951d3624..0fca2c128b5f 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -134,7 +134,7 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	if (unlikely(err))
 		return err;
 
-	riscv_v_vstate_restore(current, regs);
+	riscv_v_vstate_set_restore(current, regs);
 
 	return err;
 }
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 8d92fb6c522c..9d583b760db4 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -167,7 +167,7 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
 		return true;
 	}
 	riscv_v_vstate_on(regs);
-	riscv_v_vstate_restore(current, regs);
+	riscv_v_vstate_set_restore(current, regs);
 	return true;
 }
 
-- 
2.39.2

