Return-Path: <linux-kernel+bounces-55264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5D84BA1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E61B2BC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12BE13399B;
	Tue,  6 Feb 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V1Mll6Co"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36413398A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234124; cv=none; b=V+U2i7i5MYrkqzhwwP9LERTmcFJJYhc4Owa5dEvhyazOXIN5a5UEDr+7xEXPxP2v8jehE/hZqNfuoryTa+tYvOTmJ/BRuNaTxhxJ74uaqIFUeXvKRmiGqjtJWJdt0teev3zkb+F+Lt4xfTIsUB47IYMAwzervGHKhhBambLEpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234124; c=relaxed/simple;
	bh=eYRTJmOtYcWQAnASXaHSok8ye5YC98QuTwfe5/baHxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hSQj8z7YzaMFZB7jemi5ET01UOGgVB7/+0B6xXj+oyv41sRimZ3PkStwPuMrQbAKABMv2IrgzS3MPb7+FGwGwelJJQ6YIeK8+fNkCj13Eu4ad1uBSASbap/72buLKJZWfYLJbQpQQ5YkRTeSm/ZXGddv+LN1YRQuVR+/rvojHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V1Mll6Co; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2904c81f26eso738955a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707234122; x=1707838922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0serQGLJfMuAm7UCmFlRU9sglml/pgZOh7w7pdhvabI=;
        b=V1Mll6CoUA2FbMs73143uQAUJNPBm7DEjnsM3a82e5H3/h9aLoohcyNYKSgfTx2UZJ
         yKjWPcvD9jc13EeeByigsgKkaC2KK6jC1h1ObOGraK/IZJIykW0rBMvoB1HjrNfeHabX
         C/NuSr5sy/CI+llVmJsXis2ePpLiQoOPucRUDQcRMVjT7eBl2oRyrIDSVIAhT4Zaceqn
         CPUY4PqpbkmrSYe/tCjJUO8gpDORyt+5XieZ5vj0KxfYXD1Xfrm/xg/98EKN/Q1CF/2p
         MSuq3ZfU0yCm17woxks+oNn74ct3Qvx8Zz4L76Gitya4AvB8AgzbdF65zzkas+9gSSE4
         PyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707234122; x=1707838922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0serQGLJfMuAm7UCmFlRU9sglml/pgZOh7w7pdhvabI=;
        b=uj7wY5eT7RYfjiB+jxkm4V3Kggv2eYnNUCF7fwjkM08tSVzEuoH5aCP7046X/Au7cf
         W/79k3AiYBuqCTBoRWnUAH9ehKqYD0cpRC6gedxye4a3qsG7TeOMM9F/CRkt2jkVVOzm
         EjLPC3O4lM3Nl6IjXVyXiA5D0kl3QMI7KflE/qTqD7DPOHdYbzWREQt0aACLzmyNrFnk
         Ci7uLHL0jN0+QZ3uqK8Kl7b3GB+xZ4XJE6BWGAZ1Zf/042wZ/7I8TLogxNzbO0/mUIVN
         MhmwKugtE6b55F86LtECzzpmkQEl4kbsEHLE61NjvHKfibqsbUyTdzSiIorA4SGU+bIJ
         Jlyw==
X-Gm-Message-State: AOJu0Yx6/+YDd3xyLy56yRIcFj4dBvhDaFhI9+BJSI9847NzrehISFyG
	GZzS2Ku/+oV3EyFuBXOeOxWUgZ9BVQE0SlbxreGIabSCH25D49cdy+zYXDUrf3o=
X-Google-Smtp-Source: AGHT+IFMiM2uZXFaxsSt1Nw4LHlEplX/O/CZzHeieUF/qxwXcb9uaJCEqVrp6PvS/KS/7rS3FEo+Tw==
X-Received: by 2002:a17:90b:1d0c:b0:296:9dd2:2dd4 with SMTP id on12-20020a17090b1d0c00b002969dd22dd4mr3027842pjb.2.1707234121881;
        Tue, 06 Feb 2024 07:42:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaBqnyH0ebZtH7mMP0+4qY9XgtTGkr3tgX5sFeZYjL2+z8OusJmTJ8EHv6DyExJnYaGtnEeRso7OHaiuN0RSVodWWPaXLWG1CGKY9IqGOAhUKwda51Abk/dZJ3ch1fCRAAT6eVou0Lzqo7g6LgUllOpYejlSRrWKir/X1YWD4bHYrjJU2pK2Aynua4CNz3JGWA5EWIruD40WwVAmtGhD/emAgGSFQX+knjPSiTmisfhgS5jrGW0XWvTflb84QxgJtZK53BeIkzp+2uFM2UtUi2D6PKnfH8Os2zaJTguXjmZfZH
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:20a2:d2ee:941a:156e])
        by smtp.gmail.com with ESMTPSA id kx18-20020a17090b229200b0029454cca5c3sm1803609pjb.39.2024.02.06.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:42:01 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	David Laight <David.Laight@ACULAB.COM>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2] riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code
Date: Tue,  6 Feb 2024 16:40:59 +0100
Message-ID: <20240206154104.896809-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While reworking code to fix sparse errors, it appears that the
RISCV_M_MODE specific could actually be removed and use the one for
normal mode. Even though RISCV_M_MODE can do direct user memory access,
using the user uaccess helpers is also going to work. Since there is no
need anymore for specific accessors (load_u8()/store_u8()), we can
directly use memcpy()/copy_{to/from}_user() and get rid of the copy
loop entirely. __read_insn() is also fixed to use an unsigned long
instead of a pointer which was cast in __user address space. The
insn_addr parameter is now cast from unsigned lnog to the correct
address space directly.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---

The test used to validate these changes is the one used originally for
S-mode misaligned support:

https://github.com/clementleger/unaligned_test

This test exercise (almost) all the supported instructions, all the
registers for FPU instructions and is compiled with and without
compressed instructions.

For S-mode, you simply need a classic toolchain and export CROSS_COMPILE
to match it.

For M-mode validation, the following steps can be used:

Build a nommu toolchain with buildroot toolchain:
$ git clone https://github.com/buildroot/buildroot.git
$ cd buildroot
$ make O=build_nommu qemu_riscv64_nommu_virt_defconfig

Test:
$ git clone https://github.com/clementleger/unaligned_test.git
$ cd unaligned_test
$ make CFLAGS="-fPIC -Wl,-elf2flt=-r"
CROSS_COMPILE=<buildroot>/build_nommu/host/bin/riscv64-buildroot-linux-uclibc-

Copy the resulting elf files (unaligned & unaligned_c) to buildroot rootfs and rebuild it.
$ cp unaligned unaligned_c <buildroot>/build_nommu/target/root
$ cd <buildroot>/build_nommu/
$ make

Kernel:
$ make O=build_nommu nommu_virt_defconfig
$ make O=build_nommu loader

Either set the kernel initramfs or provide one on spike command line
using the one built with buildroot

Then to run it on spike (QEMU always emulate misaligned accesses and
won't generate any misaligned exception):

$ spike <kernel>/build_nommu/loader

---

V2:
 - Rebased on master
 - Align macro end "\"

Link to v1: https://lore.kernel.org/linux-riscv/20231128165206.589240-1-cleger@rivosinc.com/

Notes: This patch is a complete rework of a previous one [1] and thus is
not a V3.

[1] https://lore.kernel.org/linux-riscv/d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com/
---
 arch/riscv/kernel/traps_misaligned.c | 106 +++++----------------------
 1 file changed, 17 insertions(+), 89 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..fb202dd18fe5 100644
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
-		return __get_user(*r_val, (u8 __user *)addr);
-	} else {
-		*r_val = *addr;
-		return 0;
-	}
-}
-
-static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
-{
-	if (user_mode(regs)) {
-		return __put_user(val, (u8 __user *)addr);
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
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, insn_addr);	\
+		__ret = __get_user(insn, (type __user *) insn_addr); \
 	} else {					\
-		insn = *(__force u16 *)insn_addr;	\
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
 
@@ -586,9 +512,11 @@ int handle_misaligned_store(struct pt_regs *regs)
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
2.43.0


