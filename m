Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29E7F72E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjKXLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXLim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:38:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24ED68
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:38:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf88973da5so4060465ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700825928; x=1701430728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIniP635t4BDCH0OpyDCPI9DgPxQOg+yG0PZN+Nm/+4=;
        b=v+aLr4O87vF/e1qtuXgj1XzmnPRHDPBbWNDAnoG8gPXcL4ErOOs2J72sW6c2yd8OVM
         G4T5Tt1PtSObzjbtneR7xyDPQp5BwOphgLfxG69vZRV3/oG0W/MzrG/pyTmKtDTVqD7g
         U5pYQYxQmN1k5gU9RDUuEjT6W2Debjz6TzdYTTbDgmXO8R3MrOjnQS58AbNlffK5kobS
         t5gooOKEsjWbl12N9g/jWSqEtY5XyBOZjf72QycP7l2A6LyPRiyOl5AcX3IfSJRxNuNu
         0v4WhvnX123rGlfS3E0ceAD8rhyAMwcnQ7uGSGrFDVC/5XpJiPILLSYqHDLlczEFt3ao
         Msxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825928; x=1701430728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIniP635t4BDCH0OpyDCPI9DgPxQOg+yG0PZN+Nm/+4=;
        b=g76uVz6hLIAuCnMSylCWdy1wUnm2TYcmBMUYGQ2Mh8SaF7w/XbaA54I+KmoLmCNa9C
         WNfnrIuGQ1RzkZ2jecQZhhre7VrnwhvfuS8dDOjoE51mAlBe6oEnFOM9l3XARRHYW7So
         T+JTqsf/vajMIQFmpgdMQPzp1ug0LKK2CZ/qQuk+E6yCIc59lZl/75RDZZfoLA9yz60+
         n90LNSitv2+zsbkDbeG3KJtnKJc+SBVa2S7r+QlExpGlI7xcqep1ZvXMTnZyNCpYhiVa
         5Nx8CnqyOqhOQ8bkt8FaSlREGZxQDlbOZ/4zIi0+S+Kx7BbPHVFlSbe3oAN8yk8Wcd7f
         BdZw==
X-Gm-Message-State: AOJu0YwguOWRLHHc04iFY1eWP6PYy5rDsQQoIpmJIUrUOWviG9U6OgPE
        Xq+QaGpdlXWFGyH/tWolXkGD6GEiHG3qE97ujnI=
X-Google-Smtp-Source: AGHT+IEHNA0kiGFMUTN9Hp8RK/+1pHNrUp5eg6LVcVSOLJTc8o1JeyeC0Hcy8YNXM6BkArrvicSJ4A==
X-Received: by 2002:a17:902:ced0:b0:1cf:658f:d2d with SMTP id d16-20020a170902ced000b001cf658f0d2dmr2531156plg.5.1700825928102;
        Fri, 24 Nov 2023 03:38:48 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:3471:930b:671b:cf77])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090282c400b001bb1f0605b2sm2964966plz.214.2023.11.24.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:38:47 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] riscv: fix incorrect use of __user pointer
Date:   Fri, 24 Nov 2023 12:38:03 +0100
Message-ID: <20231124113803.165431-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These warnings were reported by sparse and were due to lack of __user
annotation as well as dereferencing such pointer:

arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:322:24: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/traps_misaligned.c:322:24:    expected unsigned char const [noderef] __user *__gu_ptr
arch/riscv/kernel/traps_misaligned.c:322:24:    got unsigned char const [usertype] *addr
arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:332:24: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/traps_misaligned.c:332:24:    expected unsigned char [noderef] __user *__gu_ptr
arch/riscv/kernel/traps_misaligned.c:332:24:    got unsigned char [usertype] *addr

As suggested by Christoph Hellwig, casting pointers from an address
space to another is not a good idea and we should rather cast the
untyped unsigned long to their final address space. Fix the ones in
load_u8()/store_u8()/__read_insn() by passing a unsigned long and then
casting it to the appropriate type (__user of not) depending if used in
kernel/ user mode. Also remove unneeded else construct in store_u8()/
load_u8().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311160606.obGOOwB3-lkp@intel.com/
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 55 +++++++++++++---------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 5eba37147caa..a92b88af855a 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -265,19 +265,19 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
 
 #ifdef CONFIG_RISCV_M_MODE
-static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
+static inline int load_u8(struct pt_regs *regs, const unsigned long addr, u8 *r_val)
 {
 	u8 val;
 
-	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
+	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*(const u8 *)addr));
 	*r_val = val;
 
 	return 0;
 }
 
-static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
+static inline int store_u8(struct pt_regs *regs, unsigned long addr, u8 val)
 {
-	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
+	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*(u8 *)addr));
 
 	return 0;
 }
@@ -316,34 +316,32 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
 	return 0;
 }
 #else
-static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
+static inline int load_u8(struct pt_regs *regs, const unsigned long addr, u8 *r_val)
 {
-	if (user_mode(regs)) {
-		return __get_user(*r_val, addr);
-	} else {
-		*r_val = *addr;
-		return 0;
-	}
+	if (user_mode(regs))
+		return __get_user(*r_val, (u8 __user *)addr);
+
+	*r_val = *(const u8 *)addr;
+	return 0;
 }
 
-static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
+static inline int store_u8(struct pt_regs *regs, unsigned long addr, u8 val)
 {
-	if (user_mode(regs)) {
-		return __put_user(val, addr);
-	} else {
-		*addr = val;
-		return 0;
-	}
+	if (user_mode(regs))
+		return __put_user(val, (u8 __user *)addr);
+
+	*(u8 *)addr = val;
+	return 0;
 }
 
-#define __read_insn(regs, insn, insn_addr)		\
+#define __read_insn(regs, insn, insn_addr, type)	\
 ({							\
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, insn_addr);	\
+		__ret = __get_user(insn, (type __user *) insn_addr); \
 	} else {					\
-		insn = *insn_addr;			\
+		insn = *(type *)insn_addr;		\
 		__ret = 0;				\
 	}						\
 							\
@@ -356,9 +354,8 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 
 	if (epc & 0x2) {
 		ulong tmp = 0;
-		u16 __user *insn_addr = (u16 __user *)epc;
 
-		if (__read_insn(regs, insn, insn_addr))
+		if (__read_insn(regs, insn, epc, u16))
 			return -EFAULT;
 		/* __get_user() uses regular "lw" which sign extend the loaded
 		 * value make sure to clear higher order bits in case we "or" it
@@ -369,16 +366,14 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
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
@@ -491,7 +486,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	val.data_u64 = 0;
 	for (i = 0; i < len; i++) {
-		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
+		if (load_u8(regs, addr + i, &val.data_bytes[i]))
 			return -1;
 	}
 
@@ -589,7 +584,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -EOPNOTSUPP;
 
 	for (i = 0; i < len; i++) {
-		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
+		if (store_u8(regs, addr + i, val.data_bytes[i]))
 			return -1;
 	}
 
-- 
2.42.0

