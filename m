Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30827813AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbjHRTm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379992AbjHRTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:42:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8B4C3A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:42:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc83a96067so9813885ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692387714; x=1692992514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaspszXv86+OvZckEhn+sZ3/E4XamYDqKUxJvwoMKQc=;
        b=1CKeLNHWNRQMMERkab7z2dQsUoaL9DUa1U67OY/eRyo7NXYewPtrVuewWIeW/8rpM+
         UvkWQKT6r2ujvtiFSUIYz9wQCidyQNpyZAd/Y69QC8B0Qh2J30t4r/PXHQLBZHFQakgj
         dPUYraddgK0rR7scvl05AJmKMsX05dNjOaSXHyOwSwp8rLZgvHOHx0QCzccdkhn9hWdn
         HVD7rpmd305onrFD+Bf4R+IlCK5m4a7VOXrabi1Q5DeFmv8WLbKSSF5vys01lqtNKnsK
         6BLnFqcuupXX291D5XojqckjrUDcVoO5WCP+QYNkBqfcdrYYk9lIZQytS8D1CsV/fbUJ
         dpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692387714; x=1692992514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaspszXv86+OvZckEhn+sZ3/E4XamYDqKUxJvwoMKQc=;
        b=Wr+aTHMsgP2zn5INAxaYM/XwsJa42Z1PKx/HE5TRwU61s1/uzuIJjl0ZCYFCVLNuWi
         Dttr1GE1GgLcIfCvXIGkPSM0c+BUzzRBsUKnDvGFiIKj37dY4GgN0NY05Do/3uaJBCLy
         6SFXEYPwWH2VV0j+Oc5jNwSB6a1roXouCe5JFveleRUeRB14oDYGGZ19S7pV/KHGKdNZ
         rXjcNzrM2p3gRCKBPE/nfxNG3pmbnchH0WAkFkjGn/hmCGUeaqE2V3p2onH9Tm7PyxFA
         WCVxLxL0V8e8yGVf+Kmuj0U2zdfVMKuywCdldpe+QgdCULf1TLWzf2k/G5fRvZsU3FwL
         LrOw==
X-Gm-Message-State: AOJu0YyBjISp5odLkVn+wMp2i/LcvBwqZtJICusAwbV2iGZiMU6tqr4E
        MboRFOBBbgR8UZ63RGdmyxzfgw==
X-Google-Smtp-Source: AGHT+IH/ggrbEo+HbgSH+EKsvXsIyAcdioFOQwfoxW2Rw395su3T3/3MVqqMtzcso7kef9It0UIhxQ==
X-Received: by 2002:a17:902:c946:b0:1bb:a122:4886 with SMTP id i6-20020a170902c94600b001bba1224886mr143901pla.64.1692387713983;
        Fri, 18 Aug 2023 12:41:53 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b001a5fccab02dsm2126614plx.177.2023.08.18.12.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:41:53 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
Date:   Fri, 18 Aug 2023 12:41:35 -0700
Message-Id: <20230818194136.4084400-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818194136.4084400-1-evan@rivosinc.com>
References: <20230818194136.4084400-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than deferring unaligned access speed determinations to a vendor
function, let's probe them and find out how fast they are. If we
determine that an unaligned word access is faster than N byte accesses,
mark the hardware's unaligned access as "fast". Otherwise, we mark
accesses as slow.

The algorithm itself runs for a fixed amount of jiffies. Within each
iteration it attempts to time a single loop, and then keeps only the best
(fastest) loop it saw. This algorithm was found to have lower variance from
run to run than my first attempt, which counted the total number of
iterations that could be done in that fixed amount of jiffies. By taking
only the best iteration in the loop, assuming at least one loop wasn't
perturbed by an interrupt, we eliminate the effects of interrupts and
other "warm up" factors like branch prediction. The only downside is it
depends on having an rdtime granular and accurate enough to measure a
single copy. If we ever manage to complete a loop in 0 rdtime ticks, we
leave the unaligned setting at UNKNOWN.

There is a slight change in user-visible behavior here. Previously, all
boards except the THead C906 reported misaligned access speed of
UNKNOWN. C906 reported FAST. With this change, since we're now measuring
misaligned access speed on each hart, all RISC-V systems will have this
key set as either FAST or SLOW.

Currently, we don't have a way to confidently measure the difference between
SLOW and EMULATED, so we label anything not fast as SLOW. This will
mislabel some systems that are actually EMULATED as SLOW. When we get
support for delegating misaligned access traps to the kernel (as opposed
to the firmware quietly handling it), we can explicitly test in Linux to
see if unaligned accesses trap. Those systems will start to report
EMULATED, though older (today's) systems without that new SBI mechanism
will continue to report SLOW.

I've updated the documentation for those hwprobe values to reflect
this, specifically: SLOW may or may not be emulated by software, and FAST
represents means being faster than equivalent byte accesses. The change
in documentation is accurate with respect to both the former and current
behavior.

Signed-off-by: Evan Green <evan@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v4:
 - Avoid the bare 64-bit divide which fails to link on 32-bit systems,
   use div_u64() (Palmer, buildrobot)

Changes in v3:
 - Fix documentation indentation (Conor)
 - Rename __copy_..._unaligned() to __riscv_copy_..._unaligned() (Conor)
 - Renamed c0,c1 to start_cycles, end_cycles (Conor)
 - Renamed j0,j1 to start_jiffies, now
 - Renamed check_unaligned_access0() to
   check_unaligned_access_boot_cpu() (Conor)

Changes in v2:
 - Explain more in the commit message (Conor)
 - Use a new algorithm that looks for the fastest run (David)
 - Clarify documentatin further (David and Conor)
 - Unify around a single word, "unaligned" (Conor)
 - Align asm operands, and other misc whitespace changes (Conor)

 Documentation/riscv/hwprobe.rst     |  11 ++-
 arch/riscv/include/asm/cpufeature.h |   2 +
 arch/riscv/kernel/Makefile          |   1 +
 arch/riscv/kernel/copy-unaligned.S  |  71 +++++++++++++++++++
 arch/riscv/kernel/copy-unaligned.h  |  13 ++++
 arch/riscv/kernel/cpufeature.c      | 104 ++++++++++++++++++++++++++++
 arch/riscv/kernel/smpboot.c         |   2 +
 7 files changed, 198 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/kernel/copy-unaligned.S
 create mode 100644 arch/riscv/kernel/copy-unaligned.h

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 19165ebd82ba..f63fd05f1a73 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -87,13 +87,12 @@ The following keys are defined:
     emulated via software, either in or below the kernel.  These accesses are
     always extremely slow.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are supported
-    in hardware, but are slower than the cooresponding aligned accesses
-    sequences.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are slower
+    than equivalent byte accesses.  Misaligned accesses may be supported
+    directly in hardware, or trapped and emulated by software.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are supported
-    in hardware and are faster than the cooresponding aligned accesses
-    sequences.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are faster
+    than equivalent byte accesses.
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
     not supported at all and will generate a misaligned address fault.
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 23fed53b8815..d0345bd659c9 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,4 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+void check_unaligned_access(int cpu);
+
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 506cc4a9a45a..7e6c464cdfe9 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -38,6 +38,7 @@ extra-y += vmlinux.lds
 obj-y	+= head.o
 obj-y	+= soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
+obj-y	+= copy-unaligned.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
 obj-y	+= entry.o
diff --git a/arch/riscv/kernel/copy-unaligned.S b/arch/riscv/kernel/copy-unaligned.S
new file mode 100644
index 000000000000..cfdecfbaad62
--- /dev/null
+++ b/arch/riscv/kernel/copy-unaligned.S
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Rivos Inc. */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+	.text
+
+/* void __riscv_copy_words_unaligned(void *, const void *, size_t) */
+/* Performs a memcpy without aligning buffers, using word loads and stores. */
+/* Note: The size is truncated to a multiple of 8 * SZREG */
+ENTRY(__riscv_copy_words_unaligned)
+	andi  a4, a2, ~((8*SZREG)-1)
+	beqz  a4, 2f
+	add   a3, a1, a4
+1:
+	REG_L a4,       0(a1)
+	REG_L a5,   SZREG(a1)
+	REG_L a6, 2*SZREG(a1)
+	REG_L a7, 3*SZREG(a1)
+	REG_L t0, 4*SZREG(a1)
+	REG_L t1, 5*SZREG(a1)
+	REG_L t2, 6*SZREG(a1)
+	REG_L t3, 7*SZREG(a1)
+	REG_S a4,       0(a0)
+	REG_S a5,   SZREG(a0)
+	REG_S a6, 2*SZREG(a0)
+	REG_S a7, 3*SZREG(a0)
+	REG_S t0, 4*SZREG(a0)
+	REG_S t1, 5*SZREG(a0)
+	REG_S t2, 6*SZREG(a0)
+	REG_S t3, 7*SZREG(a0)
+	addi  a0, a0, 8*SZREG
+	addi  a1, a1, 8*SZREG
+	bltu  a1, a3, 1b
+
+2:
+	ret
+END(__riscv_copy_words_unaligned)
+
+/* void __riscv_copy_bytes_unaligned(void *, const void *, size_t) */
+/* Performs a memcpy without aligning buffers, using only byte accesses. */
+/* Note: The size is truncated to a multiple of 8 */
+ENTRY(__riscv_copy_bytes_unaligned)
+	andi a4, a2, ~(8-1)
+	beqz a4, 2f
+	add  a3, a1, a4
+1:
+	lb   a4, 0(a1)
+	lb   a5, 1(a1)
+	lb   a6, 2(a1)
+	lb   a7, 3(a1)
+	lb   t0, 4(a1)
+	lb   t1, 5(a1)
+	lb   t2, 6(a1)
+	lb   t3, 7(a1)
+	sb   a4, 0(a0)
+	sb   a5, 1(a0)
+	sb   a6, 2(a0)
+	sb   a7, 3(a0)
+	sb   t0, 4(a0)
+	sb   t1, 5(a0)
+	sb   t2, 6(a0)
+	sb   t3, 7(a0)
+	addi a0, a0, 8
+	addi a1, a1, 8
+	bltu a1, a3, 1b
+
+2:
+	ret
+END(__riscv_copy_bytes_unaligned)
diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-unaligned.h
new file mode 100644
index 000000000000..e3d70d35b708
--- /dev/null
+++ b/arch/riscv/kernel/copy-unaligned.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos, Inc.
+ */
+#ifndef __RISCV_KERNEL_COPY_UNALIGNED_H
+#define __RISCV_KERNEL_COPY_UNALIGNED_H
+
+#include <linux/types.h>
+
+void __riscv_copy_words_unaligned(void *dst, const void *src, size_t size);
+void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t size);
+
+#endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 71fb840ee246..72bbaf355067 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -19,12 +19,19 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
+#include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
 #include <asm/vector.h>
 
+#include "copy-unaligned.h"
+
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
+#define MISALIGNED_ACCESS_JIFFIES_LG2 1
+#define MISALIGNED_BUFFER_SIZE 0x4000
+#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -555,6 +562,103 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
+void check_unaligned_access(int cpu)
+{
+	u64 start_cycles, end_cycles;
+	u64 word_cycles;
+	u64 byte_cycles;
+	int ratio;
+	unsigned long start_jiffies, now;
+	struct page *page;
+	void *dst;
+	void *src;
+	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
+
+	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
+	if (!page) {
+		pr_warn("Can't alloc pages to measure memcpy performance");
+		return;
+	}
+
+	/* Make an unaligned destination buffer. */
+	dst = (void *)((unsigned long)page_address(page) | 0x1);
+	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
+	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
+	src += 2;
+	word_cycles = -1ULL;
+	/* Do a warmup. */
+	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	preempt_disable();
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	/*
+	 * For a fixed amount of time, repeatedly try the function, and take
+	 * the best time in cycles as the measurement.
+	 */
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		/* Ensure the CSR read can't reorder WRT to the copy. */
+		mb();
+		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		/* Ensure the copy ends before the end time is snapped. */
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < word_cycles)
+			word_cycles = end_cycles - start_cycles;
+	}
+
+	byte_cycles = -1ULL;
+	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		mb();
+		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < byte_cycles)
+			byte_cycles = end_cycles - start_cycles;
+	}
+
+	preempt_enable();
+
+	/* Don't divide by zero. */
+	if (!word_cycles || !byte_cycles) {
+		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
+			cpu);
+
+		goto out;
+	}
+
+	if (word_cycles < byte_cycles)
+		speed = RISCV_HWPROBE_MISALIGNED_FAST;
+
+	ratio = div_u64((byte_cycles * 100), word_cycles);
+	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
+		cpu,
+		ratio / 100,
+		ratio % 100,
+		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
+
+	per_cpu(misaligned_access_speed, cpu) = speed;
+
+out:
+	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
+}
+
+static int check_unaligned_access_boot_cpu(void)
+{
+	check_unaligned_access(0);
+	return 0;
+}
+
+arch_initcall(check_unaligned_access_boot_cpu);
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f4d6acb38dd0..00ddbd2364dc 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -26,6 +26,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 #include <asm/cpu_ops.h>
+#include <asm/cpufeature.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
@@ -245,6 +246,7 @@ asmlinkage __visible void smp_callin(void)
 
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
+	check_unaligned_access(curr_cpuid);
 	probe_vendor_features(curr_cpuid);
 
 	if (has_vector()) {
-- 
2.34.1

