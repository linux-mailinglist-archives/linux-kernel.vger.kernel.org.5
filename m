Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C57FC2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjK1Qwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjK1Qwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:52:32 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87AD51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:52:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c48fad2f6dso763373b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701190358; x=1701795158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnLhxWGiNOAcjSzhcquu45Yp0FzINgLL91XiNVW3XvM=;
        b=mMt6D+S9jkBO1wA0Ko2CJsthB5Ermjs6GOkaK/rvuEEVmCabqSmy+Y5FNzZd30kpO+
         LivVZUEmiPLwUD6TXSDffs9eVlUP2BjzaFVV9sR0NxVAOLmuxBmdc6c+ppv7RjXDWR2c
         xC890IG1EEcx9XQpABZCKgZ/75RnD3pB9hu3sB7xWHeiUbFVN83zSzgcw11sK7n2p5cX
         omOVblAAStPdZ2op+1eblOSBb/ywX8PLDLp4VTRU4i8b9TxFA/SrcGH+J3fGGadXYCBV
         q1KGP5kBGThBO5mMlU71ltJPGgWf18mc6ugN784jnS+KSIFBKMfZZluQVk0ICH2um3KG
         ZT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190358; x=1701795158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnLhxWGiNOAcjSzhcquu45Yp0FzINgLL91XiNVW3XvM=;
        b=R7EmV1EJ2VLUu0B/omrrgEGQOB505W8dM6X/oCr4dQ7rigDJzXGsF4/G8qka8OmgeN
         tv+txIhRnV9y0x3uBXd5SfCoFZ0+NKFuiJmZnkL+Fuj7S5gXsJuCi8v/5avCQnGHgOF8
         wx4ETTIJ0EeP6vmFUan0R6ZLWPsR9Zx4zIjV+nxLsG8zcfU5kW8Iyt9jOam8u0zDnfF7
         nLYBi1tOwHDmJkKEw0qUB6gHxTzO/8wGX1v81a3Uu49nkIEjyBl0fKuaSsOKbct9IrR0
         0hGskYGE685UHgnjycMm12pPkSVxblSPbaAd0sXZwudyvLNzyVJ12OzAr6H9FQkVdf8q
         O8ww==
X-Gm-Message-State: AOJu0YyinvfyL3kik8B3+vCaiP5gpEq0Wwyk4WfTuE5XSzniOwUb6fJX
        YuvIWdHsWgmrJBo0+FDU09HID+Pqq+CToovSADU=
X-Google-Smtp-Source: AGHT+IFnZ8Vm76JvaH+ck0p1W5IysPSFuxb8VUiIVKVTK7bDKBiGrm11EUNRu7hvwuegOHNUFDs+vA==
X-Received: by 2002:a05:6a20:e10f:b0:18b:1b76:d70f with SMTP id kr15-20020a056a20e10f00b0018b1b76d70fmr21717928pzb.2.1701190357660;
        Tue, 28 Nov 2023 08:52:37 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:c518:cca8:9551:f5d2])
        by smtp.gmail.com with ESMTPSA id az22-20020a17090b029600b00280a2275e4bsm9821819pjb.27.2023.11.28.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:52:37 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH] riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code
Date:   Tue, 28 Nov 2023 17:52:06 +0100
Message-ID: <20231128165206.589240-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reworking code to fix sparse errors, it appears that the
RISCV_M_MODE specific could actually be removed and use the one for
normal mode. Even though RISCV_M_MODE can do direct user memory access,
using the user uaccess helpers is also going to work. Since there is no
need anymore for specific accessors (load_u8()/store_u8()), we can
directly use memcpy()/copy_{to/from}_user() and get rid of the copy
loop entirely. __read_insn() is also fixed to use an unsigned long
instead of a pointer which was cast in __user address space. The
insn_addr parameter is now cast from unsigned long to the correct
address space directly.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---

Notes: This patch is a complete rework of a previous one [1] and thus is
not a V3.

[1] https://lore.kernel.org/linux-riscv/d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com/
---
 arch/riscv/kernel/traps_misaligned.c | 108 +++++----------------------
 1 file changed, 18 insertions(+), 90 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 5eba37147caa..38af97f4819c 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -264,86 +264,14 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 #define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
 #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
 
-#ifdef CONFIG_RISCV_M_MODE
-static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
-{
-	u8 val;
-
-	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
-	*r_val = val;
-
-	return 0;
-}
-
-static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
-{
-	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
-
-	return 0;
-}
-
-static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
-{
-	register ulong __mepc asm ("a2") = mepc;
-	ulong val, rvc_mask = 3, tmp;
-
-	asm ("and %[tmp], %[addr], 2\n"
-		"bnez %[tmp], 1f\n"
-#if defined(CONFIG_64BIT)
-		__stringify(LWU) " %[insn], (%[addr])\n"
-#else
-		__stringify(LW) " %[insn], (%[addr])\n"
-#endif
-		"and %[tmp], %[insn], %[rvc_mask]\n"
-		"beq %[tmp], %[rvc_mask], 2f\n"
-		"sll %[insn], %[insn], %[xlen_minus_16]\n"
-		"srl %[insn], %[insn], %[xlen_minus_16]\n"
-		"j 2f\n"
-		"1:\n"
-		"lhu %[insn], (%[addr])\n"
-		"and %[tmp], %[insn], %[rvc_mask]\n"
-		"bne %[tmp], %[rvc_mask], 2f\n"
-		"lhu %[tmp], 2(%[addr])\n"
-		"sll %[tmp], %[tmp], 16\n"
-		"add %[insn], %[insn], %[tmp]\n"
-		"2:"
-	: [insn] "=&r" (val), [tmp] "=&r" (tmp)
-	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
-	  [xlen_minus_16] "i" (XLEN_MINUS_16));
-
-	*r_insn = val;
-
-	return 0;
-}
-#else
-static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
-{
-	if (user_mode(regs)) {
-		return __get_user(*r_val, addr);
-	} else {
-		*r_val = *addr;
-		return 0;
-	}
-}
-
-static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
-{
-	if (user_mode(regs)) {
-		return __put_user(val, addr);
-	} else {
-		*addr = val;
-		return 0;
-	}
-}
-
-#define __read_insn(regs, insn, insn_addr)		\
+#define __read_insn(regs, insn, insn_addr, type)	\
 ({							\
 	int __ret;					\
 							\
-	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, insn_addr);	\
+	if (user_mode(regs)) { \
+		__ret = __get_user(insn, (type __user *) insn_addr); \
 	} else {					\
-		insn = *insn_addr;			\
+		insn = *(type *)insn_addr;		\
 		__ret = 0;				\
 	}						\
 							\
@@ -356,9 +284,8 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 
 	if (epc & 0x2) {
 		ulong tmp = 0;
-		u16 __user *insn_addr = (u16 __user *)epc;
 
-		if (__read_insn(regs, insn, insn_addr))
+		if (__read_insn(regs, insn, epc, u16))
 			return -EFAULT;
 		/* __get_user() uses regular "lw" which sign extend the loaded
 		 * value make sure to clear higher order bits in case we "or" it
@@ -369,16 +296,14 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 			*r_insn = insn;
 			return 0;
 		}
-		insn_addr++;
-		if (__read_insn(regs, tmp, insn_addr))
+		epc += sizeof(u16);
+		if (__read_insn(regs, tmp, epc, u16))
 			return -EFAULT;
 		*r_insn = (tmp << 16) | insn;
 
 		return 0;
 	} else {
-		u32 __user *insn_addr = (u32 __user *)epc;
-
-		if (__read_insn(regs, insn, insn_addr))
+		if (__read_insn(regs, insn, epc, u32))
 			return -EFAULT;
 		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
 			*r_insn = insn;
@@ -390,7 +315,6 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 		return 0;
 	}
 }
-#endif
 
 union reg_data {
 	u8 data_bytes[8];
@@ -409,7 +333,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 	unsigned long epc = regs->epc;
 	unsigned long insn;
 	unsigned long addr = regs->badaddr;
-	int i, fp = 0, shift = 0, len = 0;
+	int fp = 0, shift = 0, len = 0;
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
@@ -490,9 +414,11 @@ int handle_misaligned_load(struct pt_regs *regs)
 		return -EOPNOTSUPP;
 
 	val.data_u64 = 0;
-	for (i = 0; i < len; i++) {
-		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
+	if (user_mode(regs)) {
+		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
 			return -1;
+	} else {
+		memcpy(&val, (u8 *)addr, len);
 	}
 
 	if (!fp)
@@ -513,7 +439,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 	unsigned long epc = regs->epc;
 	unsigned long insn;
 	unsigned long addr = regs->badaddr;
-	int i, len = 0, fp = 0;
+	int len = 0, fp = 0;
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
@@ -588,9 +514,11 @@ int handle_misaligned_store(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_FPU) && fp)
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < len; i++) {
-		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
+	if (user_mode(regs)) {
+		if (raw_copy_to_user((u8 __user *)addr, &val, len))
 			return -1;
+	} else {
+		memcpy((u8 *)addr, &val, len);
 	}
 
 	regs->epc = epc + INSN_LEN(insn);
-- 
2.42.0

