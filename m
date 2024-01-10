Return-Path: <linux-kernel+bounces-22386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485CE829CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BF41C21A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326524CE0E;
	Wed, 10 Jan 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9ktPFDY"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBD4CB5E;
	Wed, 10 Jan 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e80d40a41so5297519e87.1;
        Wed, 10 Jan 2024 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898571; x=1705503371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLaTiUEqnhHpEDzcjzh0LRpXh9TZeJ5JQ1BIVLM+gqw=;
        b=Y9ktPFDYCVz/ffcN52D0ChirQmJnD4Do8vsa0FpcHpPLUJvipD3indQIjC2PNGbBgA
         QlSJPa2T9YCK+pwHPuA/oa9czSP2BDw1PCOG7tMMPLdy00QZ3CF0lW4z5MmKEOx8SY6S
         t7h1R4RWaLA34eDfCfTSz67wQ8Pj1lNNVseQPTn87A0yoNomNaVRbKR3QPyu3irtI/Rz
         1fojrnrRbrRlDru4t7e94YNa3It5bZ+pc+iYZAxqQznOK375XYdhMnX9N5kD0P+nRBgI
         pDKe105a+b5yqAQ8V06a+E0Kh927aWTRlnRC3g+9wBEyvVudVrAM7Ip593opUmGYVs8+
         Dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898571; x=1705503371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLaTiUEqnhHpEDzcjzh0LRpXh9TZeJ5JQ1BIVLM+gqw=;
        b=GdaE7o6qy0pNdXjAppZ5WicFbghUxG9xVlwyXwSqzywWrbBnCxivGE7VGTWngoipmh
         lZWFI9NeEaORgay6f8F5QrLwMCKVblhhzCvRdYdDvOlEe78hiz7s6Ru2W99UR3A7zbNg
         T4eZP568+zhbGa2E0xbEcODPXrNmqFlvfn7ymnmYBm31qKbzVuv8oDaL+TusV7OHMygW
         h3gPO/UrtdCYnsQjyTingyZupFs0ohg+7MrqnGr+EOCzVYvY/TPuEXu6qPR883BNIXMz
         cIvoI4K5cvhUIEbySvsi7H+u7/w6G3aOkNsf7omXyM0mM9TQKMWMxqce0qIDPF75ZLVi
         ogtQ==
X-Gm-Message-State: AOJu0YyGX7jUZkNFr8JgiXmVhiUT/gtxqHR9H/CPwPJ6DttA++0J4sGS
	HzeUDleAEWMIHTbZ19GgO08=
X-Google-Smtp-Source: AGHT+IEmWsRJPIzVvjKSG3W4CxovtYvIz/tPv4lvUtVx2c7SaE5vrwQD+TOsnx1Ylj+gfn5QPpRuDQ==
X-Received: by 2002:ac2:51b7:0:b0:50e:9343:64df with SMTP id f23-20020ac251b7000000b0050e934364dfmr488193lfk.70.1704898571178;
        Wed, 10 Jan 2024 06:56:11 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id bm3-20020a170906c04300b00a2a4efe7d3dsm2161032ejb.79.2024.01.10.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:56:10 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	corbet@lwn.net
Cc: mmaas@google.com,
	hboehm@google.com,
	striker@us.ibm.com,
	charlie@rivosinc.com,
	rehn@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 4/4] membarrier: riscv: Provide core serializing command
Date: Wed, 10 Jan 2024 15:55:33 +0100
Message-Id: <20240110145533.60234-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110145533.60234-1-parri.andrea@gmail.com>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V uses xRET instructions on return from interrupt and to go back
to user-space; the xRET instruction is not core serializing.

Use FENCE.I for providing core serialization as follows:

 - by calling sync_core_before_usermode() on return from interrupt (cf.
   ipi_sync_core()),

 - via switch_mm() and sync_core_before_usermode() (respectively, for
   uthread->uthread and kthread->uthread transitions) to go back to
   user-space.

On RISC-V, the serialization in switch_mm() is activated by resetting
the icache_stale_mask of the mm at prepare_sync_core_cmd().

Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 .../membarrier-sync-core/arch-support.txt     | 18 +++++++++++-
 MAINTAINERS                                   |  1 +
 arch/riscv/Kconfig                            |  3 ++
 arch/riscv/include/asm/membarrier.h           | 19 ++++++++++++
 arch/riscv/include/asm/sync_core.h            | 29 +++++++++++++++++++
 kernel/sched/core.c                           |  4 +++
 kernel/sched/membarrier.c                     |  4 +++
 7 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/sync_core.h

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index d96b778b87ed8..a163170fc0f48 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -10,6 +10,22 @@
 # Rely on implicit context synchronization as a result of exception return
 # when returning from IPI handler, and when returning to user-space.
 #
+# * riscv
+#
+# riscv uses xRET as return from interrupt and to return to user-space.
+#
+# Given that xRET is not core serializing, we rely on FENCE.I for providing
+# core serialization:
+#
+#  - by calling sync_core_before_usermode() on return from interrupt (cf.
+#    ipi_sync_core()),
+#
+#  - via switch_mm() and sync_core_before_usermode() (respectively, for
+#    uthread->uthread and kthread->uthread transitions) to go back to
+#    user-space.
+#
+#  The serialization in switch_mm() is activated by prepare_sync_core_cmd().
+#
 # * x86
 #
 # x86-32 uses IRET as return from interrupt, which takes care of the IPI.
@@ -43,7 +59,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/MAINTAINERS b/MAINTAINERS
index 6bce0aeecb4f2..e4ca6288ea3d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13817,6 +13817,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/scheduler/membarrier.rst
 F:	arch/*/include/asm/membarrier.h
+F:	arch/*/include/asm/sync_core.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 33d9ea5fa392f..2ad63a216d69a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,14 +28,17 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
+	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/riscv/include/asm/membarrier.h b/arch/riscv/include/asm/membarrier.h
index 6c016ebb5020a..47b240d0d596a 100644
--- a/arch/riscv/include/asm/membarrier.h
+++ b/arch/riscv/include/asm/membarrier.h
@@ -22,6 +22,25 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 	/*
 	 * The membarrier system call requires a full memory barrier
 	 * after storing to rq->curr, before going back to user-space.
+	 *
+	 * This barrier is also needed for the SYNC_CORE command when
+	 * switching between processes; in particular, on a transition
+	 * from a thread belonging to another mm to a thread belonging
+	 * to the mm for which a membarrier SYNC_CORE is done on CPU0:
+	 *
+	 *   - [CPU0] sets all bits in the mm icache_stale_mask (in
+	 *     prepare_sync_core_cmd());
+	 *
+	 *   - [CPU1] stores to rq->curr (by the scheduler);
+	 *
+	 *   - [CPU0] loads rq->curr within membarrier and observes
+	 *     cpu_rq(1)->curr->mm != mm, so the IPI is skipped on
+	 *     CPU1; this means membarrier relies on switch_mm() to
+	 *     issue the sync-core;
+	 *
+	 *   - [CPU1] switch_mm() loads icache_stale_mask; if the bit
+	 *     is zero, switch_mm() may incorrectly skip the sync-core.
+	 *
 	 * Matches a full barrier in the proximity of the membarrier
 	 * system call entry.
 	 */
diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
new file mode 100644
index 0000000000000..9153016da8f14
--- /dev/null
+++ b/arch/riscv/include/asm/sync_core.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_SYNC_CORE_H
+#define _ASM_RISCV_SYNC_CORE_H
+
+/*
+ * RISC-V implements return to user-space through an xRET instruction,
+ * which is not core serializing.
+ */
+static inline void sync_core_before_usermode(void)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
+
+#ifdef CONFIG_SMP
+/*
+ * Ensure the next switch_mm() on every CPU issues a core serializing
+ * instruction for the given @mm.
+ */
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+	cpumask_setall(&mm->context.icache_stale_mask);
+}
+#else
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+}
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_SYNC_CORE_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b51bc86f8340c..82de2b7d253cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6682,6 +6682,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 *
 		 * The barrier matches a full barrier in the proximity of
 		 * the membarrier system call entry.
+		 *
+		 * On RISC-V, this barrier pairing is also needed for the
+		 * SYNC_CORE command when switching between processes, cf.
+		 * the inline comments in membarrier_arch_switch_mm().
 		 */
 		++*switch_count;
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 6d1f31b3a967b..703e8d80a576d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -342,6 +342,10 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	/*
 	 * Matches memory barriers after rq->curr modification in
 	 * scheduler.
+	 *
+	 * On RISC-V, this barrier pairing is also needed for the
+	 * SYNC_CORE command when switching between processes, cf.
+	 * the inline comments in membarrier_arch_switch_mm().
 	 */
 	smp_mb();	/* system call entry is not a mb. */
 
-- 
2.34.1


