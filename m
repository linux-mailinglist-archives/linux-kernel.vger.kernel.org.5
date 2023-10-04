Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09667B834E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbjJDPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjJDPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C9C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406553f6976so5071355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432465; x=1697037265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1p2iCt2/GYKYHhTcUS5xXMpXi+9mCsK1NUx+ndGvU8=;
        b=tTVlpor7EJV43VmFSuEcBU6nOke2BticJbENRLmlCZ6mT1O+HBIAzY1z5gJ2oEQUN4
         PxkY+dqIosMPgFx36Q13I761mcCOIz+ANh6eQ45SItNucEwyj05LevhS8yt3xqxd1yIi
         bF06KPin5LajWfkepTzP7JrHv7op2ZZZNeEOmiYnRf/2etSFRMoQQ7eUdUXyIJk9x1Va
         uNtiEHFXexgFg8u/XK+8dfqaMhwzIdT1RHh9EVLxa8oFURXBNVQMUXo7It1ii0WCvRzq
         8vG3L1MJiSHebaW5EqSsSjTuDPD6EElfLDpi/jg/vd5gt30TsrfF6jGeYv5evywpfb9+
         hvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432465; x=1697037265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1p2iCt2/GYKYHhTcUS5xXMpXi+9mCsK1NUx+ndGvU8=;
        b=olMq3g6QxSwP/9xLgAH1uIEDPjLqCwLSt+7VUVTpgeaGDZxeypT/G1XNO/PMbhySbm
         p4PnaLeqqZXHh9xdoDhiT797sHMZPFljZjGDJN6eIR7sbWLicg3EQgy0OmUl5nYTp+ve
         HIZ4Td3vbYfr8rOAXBxbMxyLq6t48Qrr8RGDG18aYpU15DiUygRn1hHQ8zIn1jRzjK3P
         a2TVF4Kc+J3MfWWFs3GGObXOzxz0atHqgUYAd6XnvlzlTaMjKipbbfHQxCWqly+SOnVW
         7CvLXbi/9eFal5SHbdQvVXtbnjFa0qaNGAsCsJl9ZzPvoEmiuBbQ6A05sZ4S2enuuGyT
         PRcA==
X-Gm-Message-State: AOJu0YzRlGb6MJ1IPSDR51IPh4ZEBVMAwNCyBQBHPdXX0VeKM1sgsrg3
        I1VLu17Y0gN0aVKd5EPy3q/uTw==
X-Google-Smtp-Source: AGHT+IGD0PGV8oHiSuHWjQcdT4h1ZjbLGuKWI1OID61VdNsu3050wmo3Yv6YuKgmZuMKm3DbjuHW5g==
X-Received: by 2002:a05:600c:5114:b0:405:4127:f471 with SMTP id o20-20020a05600c511400b004054127f471mr2631811wms.1.1696432465062;
        Wed, 04 Oct 2023 08:14:25 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:24 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 2/8] riscv: add support for misaligned trap handling in S-mode
Date:   Wed,  4 Oct 2023 17:13:59 +0200
Message-ID: <20231004151405.521596-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misalignment trap handling is only supported for M-mode and uses direct
accesses to user memory. In S-mode, when handling usermode fault, this
requires to use the get_user()/put_user() accessors. Implement
load_u8(), store_u8() and get_insn() using these accessors for
userspace and direct text access for kernel.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/Kconfig                    |   8 ++
 arch/riscv/include/asm/entry-common.h |  14 +++
 arch/riscv/kernel/Makefile            |   2 +-
 arch/riscv/kernel/traps.c             |   9 --
 arch/riscv/kernel/traps_misaligned.c  | 119 +++++++++++++++++++++++---
 5 files changed, 129 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..6e167358a897 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -636,6 +636,14 @@ config THREAD_SIZE_ORDER
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
 	  affects irq stack size, which is equal to thread stack size.
 
+config RISCV_MISALIGNED
+	bool "Support misaligned load/store traps for kernel and userspace"
+	default y
+	help
+	  Say Y here if you want the kernel to embed support for misaligned
+	  load/store for both kernel and userspace. When disable, misaligned
+	  accesses will generate SIGBUS in userspace and panic in kernel.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 6e4dee49d84b..7ab5e34318c8 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -8,4 +8,18 @@
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
+#ifdef CONFIG_RISCV_MISALIGNED
+int handle_misaligned_load(struct pt_regs *regs);
+int handle_misaligned_store(struct pt_regs *regs);
+#else
+static inline int handle_misaligned_load(struct pt_regs *regs)
+{
+	return -1;
+}
+static inline int handle_misaligned_store(struct pt_regs *regs)
+{
+	return -1;
+}
+#endif
+
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 95cf25d48405..0d874fb24b51 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -59,7 +59,7 @@ obj-y	+= patch.o
 obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
+obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 19807c4d3805..d69779e4b967 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -179,14 +179,6 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
-#ifndef CONFIG_RISCV_M_MODE
-DO_ERROR_INFO(do_trap_load_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
-DO_ERROR_INFO(do_trap_store_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
-#else
-int handle_misaligned_load(struct pt_regs *regs);
-int handle_misaligned_store(struct pt_regs *regs);
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
@@ -229,7 +221,6 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
 		irqentry_nmi_exit(regs, state);
 	}
 }
-#endif
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
 DO_ERROR_INFO(do_trap_ecall_s,
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index e7bfb33089c1..9daed7d756ae 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/entry-common.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -151,21 +152,25 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-static inline u8 load_u8(const u8 *addr)
+#ifdef CONFIG_RISCV_M_MODE
+static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 {
 	u8 val;
 
 	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
+	*r_val = val;
 
-	return val;
+	return 0;
 }
 
-static inline void store_u8(u8 *addr, u8 val)
+static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
 {
 	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
+
+	return 0;
 }
 
-static inline ulong get_insn(ulong mepc)
+static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
 {
 	register ulong __mepc asm ("a2") = mepc;
 	ulong val, rvc_mask = 3, tmp;
@@ -194,9 +199,87 @@ static inline ulong get_insn(ulong mepc)
 	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
 	  [xlen_minus_16] "i" (XLEN_MINUS_16));
 
-	return val;
+	*r_insn = val;
+
+	return 0;
+}
+#else
+static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
+{
+	if (user_mode(regs)) {
+		return __get_user(*r_val, addr);
+	} else {
+		*r_val = *addr;
+		return 0;
+	}
 }
 
+static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
+{
+	if (user_mode(regs)) {
+		return __put_user(val, addr);
+	} else {
+		*addr = val;
+		return 0;
+	}
+}
+
+#define __read_insn(regs, insn, insn_addr)		\
+({							\
+	int __ret;					\
+							\
+	if (user_mode(regs)) {				\
+		__ret = __get_user(insn, insn_addr);	\
+	} else {					\
+		insn = *insn_addr;			\
+		__ret = 0;				\
+	}						\
+							\
+	__ret;						\
+})
+
+static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	ulong insn = 0;
+
+	if (epc & 0x2) {
+		ulong tmp = 0;
+		u16 __user *insn_addr = (u16 __user *)epc;
+
+		if (__read_insn(regs, insn, insn_addr))
+			return -EFAULT;
+		/* __get_user() uses regular "lw" which sign extend the loaded
+		 * value make sure to clear higher order bits in case we "or" it
+		 * below with the upper 16 bits half.
+		 */
+		insn &= GENMASK(15, 0);
+		if ((insn & __INSN_LENGTH_MASK) != __INSN_LENGTH_32) {
+			*r_insn = insn;
+			return 0;
+		}
+		insn_addr++;
+		if (__read_insn(regs, tmp, insn_addr))
+			return -EFAULT;
+		*r_insn = (tmp << 16) | insn;
+
+		return 0;
+	} else {
+		u32 __user *insn_addr = (u32 __user *)epc;
+
+		if (__read_insn(regs, insn, insn_addr))
+			return -EFAULT;
+		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
+			*r_insn = insn;
+			return 0;
+		}
+		insn &= GENMASK(15, 0);
+		*r_insn = insn;
+
+		return 0;
+	}
+}
+#endif
+
 union reg_data {
 	u8 data_bytes[8];
 	ulong data_ulong;
@@ -207,10 +290,13 @@ int handle_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
-	unsigned long insn = get_insn(epc);
-	unsigned long addr = csr_read(mtval);
+	unsigned long insn;
+	unsigned long addr = regs->badaddr;
 	int i, fp = 0, shift = 0, len = 0;
 
+	if (get_insn(regs, epc, &insn))
+		return -1;
+
 	regs->epc = 0;
 
 	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
@@ -274,8 +360,10 @@ int handle_misaligned_load(struct pt_regs *regs)
 	}
 
 	val.data_u64 = 0;
-	for (i = 0; i < len; i++)
-		val.data_bytes[i] = load_u8((void *)(addr + i));
+	for (i = 0; i < len; i++) {
+		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
+			return -1;
+	}
 
 	if (fp)
 		return -1;
@@ -290,10 +378,13 @@ int handle_misaligned_store(struct pt_regs *regs)
 {
 	union reg_data val;
 	unsigned long epc = regs->epc;
-	unsigned long insn = get_insn(epc);
-	unsigned long addr = csr_read(mtval);
+	unsigned long insn;
+	unsigned long addr = regs->badaddr;
 	int i, len = 0;
 
+	if (get_insn(regs, epc, &insn))
+		return -1;
+
 	regs->epc = 0;
 
 	val.data_ulong = GET_RS2(insn, regs);
@@ -327,8 +418,10 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -1;
 	}
 
-	for (i = 0; i < len; i++)
-		store_u8((void *)(addr + i), val.data_bytes[i]);
+	for (i = 0; i < len; i++) {
+		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
+			return -1;
+	}
 
 	regs->epc = epc + INSN_LEN(insn);
 
-- 
2.42.0

