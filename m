Return-Path: <linux-kernel+bounces-14091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6C8217C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BA51C20F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BC6AAB;
	Tue,  2 Jan 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXvMG7Xs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8395697;
	Tue,  2 Jan 2024 06:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59541C433CB;
	Tue,  2 Jan 2024 06:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178217;
	bh=LjgJiqwLFUXfY2pd8uFd7gL5ZAyYxGKFhbbJI1IcXy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXvMG7XsMsMpzCIBzPOF1TXAL9H/DF11GOIR/VVW26PCNGeV3q8y0jmU1rvO4YtOv
	 j0Nm3sZ24gaoZ+yY9xbeYZuHrjYmUS7draGRB5dfinu98iSZfX90lNvkHDqw81isdN
	 E1Mo1ro9sWcWWs22HTuG1rC5qNnne597m+kgfh+k8SZ9kYI/jvSax+pH5W96pIxE2c
	 Wjl4qoBdwtE0Yc5bHSHt0HvJu/48B0xytGee3fbJ8QmCmsH1EwOzai9CO2exUGUQfz
	 RxV47JOMDBHtOwryQtE9SioTICHe5fDQxKAn5wCFCh6DQhH/CRdQwMtRTQNsLiJXPI
	 zG5j36J2sju6w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>
Subject: [RFC PATCH 02/13] riscv: vector: make Vector always available for softirq context
Date: Tue,  2 Jan 2024 00:47:28 -0600
Message-ID: <20240102064743.220490-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
References: <20240102064743.220490-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

The goal of this patch is to provide full support of Vector in kernel
softirq context. So that some of the crypto alogrithms won't need scalar
fallbacks.

By disabling bottom halves in active kernel-mode Vector, softirq will
not be able to nest on top of any kernel-mode Vector. So, softirq
context is able to use Vector whenever it runs.

After this patch, Vector context cannot start with irqs disabled.
Otherwise local_bh_enable() may run in a wrong context.

Disabling bh is not enough for RT-kernel to prevent preeemption. So
we must disable preemption, which also implies disabling bh on RT.

Related-to: commit 696207d4258b ("arm64/sve: Make kernel FPU protection RT friendly")
Related-to: commit 66c3ec5a7120 ("arm64: neon: Forbid when irqs are disabled")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/include/asm/processor.h     |  5 +++--
 arch/riscv/include/asm/simd.h          |  6 +++++-
 arch/riscv/kernel/kernel_mode_vector.c | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 28d19aea24b1d..e768397890673 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -71,22 +71,23 @@
 #ifndef __ASSEMBLY__
 
 struct task_struct;
 struct pt_regs;
 
 /*
  * We use a flag to track in-kernel Vector context. Currently the flag has the
  * following meaning:
  *
  *  - bit 0: indicates whether the in-kernel Vector context is active. The
- *    activation of this state disables the preemption. Currently only 0 and 1
- *    are valid value for this field. Other values are reserved for future uses.
+ *    activation of this state disables the preemption. On a non-RT kernel, it
+ *    also disable bh. Currently only 0 and 1 are valid value for this field.
+ *    Other values are reserved for future uses.
  */
 #define RISCV_KERNEL_MODE_V	0x1
 
 /* CPU-specific state of a task */
 struct thread_struct {
 	/* Callee-saved registers */
 	unsigned long ra;
 	unsigned long sp;	/* Kernel mode stack */
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index ef8af413a9fc7..4d699e16c9a96 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -21,22 +21,26 @@
  *                instructions or access the vector register file
  *
  * Callers must not assume that the result remains true beyond the next
  * preempt_enable() or return from softirq context.
  */
 static __must_check inline bool may_use_simd(void)
 {
 	/*
 	 * RISCV_KERNEL_MODE_V is only set while preemption is disabled,
 	 * and is clear whenever preemption is enabled.
+	 *
+	 * Kernel-mode Vector temporarily disables bh. So we must not return
+	 * true on irq_disabled(). Otherwise we would fail the lockdep check
+	 * calling local_bh_enable()
 	 */
-	return !in_hardirq() && !in_nmi() && !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
+	return !in_hardirq() && !in_nmi() && !irqs_disabled() && !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
 }
 
 #else /* ! CONFIG_RISCV_ISA_V */
 
 static __must_check inline bool may_use_simd(void)
 {
 	return false;
 }
 
 #endif /* ! CONFIG_RISCV_ISA_V */
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 114cf4f0a0eb6..2fc145edae3dd 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -39,37 +39,47 @@ static inline void riscv_v_stop(u32 flags)
 }
 
 /*
  * Claim ownership of the CPU vector context for use by the calling context.
  *
  * The caller may freely manipulate the vector context metadata until
  * put_cpu_vector_context() is called.
  */
 void get_cpu_vector_context(void)
 {
-	preempt_disable();
+	/*
+	 * disable softirqs so it is impossible for softirqs to nest
+	 * get_cpu_vector_context() when kernel is actively using Vector.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
 
 	riscv_v_start(RISCV_KERNEL_MODE_V);
 }
 
 /*
  * Release the CPU vector context.
  *
  * Must be called from a context in which get_cpu_vector_context() was
  * previously called, with no call to put_cpu_vector_context() in the
  * meantime.
  */
 void put_cpu_vector_context(void)
 {
 	riscv_v_stop(RISCV_KERNEL_MODE_V);
 
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
 }
 
 /*
  * kernel_vector_begin(): obtain the CPU vector registers for use by the calling
  * context
  *
  * Must not be called unless may_use_simd() returns true.
  * Task context in the vector registers is saved back to memory as necessary.
  *
  * A matching call to kernel_vector_end() must be made before returning from the
-- 
2.43.0


