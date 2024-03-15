Return-Path: <linux-kernel+bounces-104089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92C87C8D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4072BB20C54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04C13AD8;
	Fri, 15 Mar 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjtVRFvS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2412E63
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710484462; cv=none; b=VqAZcfoAvTFuqR+qr6GccFcZxevxem37bW51JgaTw2XTT1B4TQd3GqMISbKVTYYrRk82f9uS7nBrqrusaHfFuQ8mnnm9vv7LTT04HTHdDA6QdEiAlhTBl/TqGLbvSQ3cOqBsv0XSZsIAOYnTVEBRUMOiR8YCSpdN33pZqQyXakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710484462; c=relaxed/simple;
	bh=8Mo+0UAAzOaVJnJdh/x65H+8vyq4kGYM8In2RBLfjqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VZcDEx34mFcK064CrMc5AkxPx8+WMgEVb9qAb+XezgLL0QBhcDZ70rqJRGm+mGNjfv60sDjQOy+R0Jq3f2JdWzeV4LfitKRRsHCTVFMbFjRacZpQLzG3FRsmDnjdzlYlwd9B35N8ARfVqw2DyCcSAmoa+F4y80D7Ma+1jKk4uBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjtVRFvS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710484460; x=1742020460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Mo+0UAAzOaVJnJdh/x65H+8vyq4kGYM8In2RBLfjqE=;
  b=RjtVRFvSgZWoN6lSqgH3oWWey2XYbYFx5JtKD2jQAxsNh8lD8xQkoDhS
   l8Fz4SBrOdwnlKpJ/kGuDxoW8Ad4qdtXkKpROyiATbKStH/AUFBScsHTi
   cLx4co6Z8jepdH2BfelaZy4/kXTD61sX0VY4ThmJvpyx98+htBdG0x0fw
   Sd1GnRR5Xyaai9mXiS3NXjapcEAtqZcy88fc6IwxiAj1wzHSoGWA+eYs/
   qSMQXDxbxctoixHfSN0MmLn2Xx6oREequBBH/Q3WT8znGZKpsoUKe4Jk7
   pRS5ndhyRewex4YsV2WOb/Yzbrrvng8sLZbsu9ewHt+Ok1DH0xG27XDbc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16795454"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="16795454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 23:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="17177039"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmviesa003.fm.intel.com with ESMTP; 14 Mar 2024 23:34:16 -0700
From: Xiao Wang <xiao.w.wang@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	david.laight@aculab.com,
	charlie@rivosinc.com,
	haicheng.li@intel.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v4] riscv: Optimize crc32 with Zbc extension
Date: Fri, 15 Mar 2024 14:38:28 +0800
Message-Id: <20240315063828.341306-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by the B-ext spec, the Zbc (carry-less multiplication)
instructions can be used to accelerate CRC calculations. Currently, the
crc32 is the most widely used crc function inside kernel, so this patch
focuses on the optimization of just the crc32 APIs.

Compared with the current table-lookup based optimization, Zbc based
optimization can also achieve large stride during CRC calculation loop,
meantime, it avoids the memory access latency of the table-lookup based
implementation and it reduces memory footprint.

If Zbc feature is not supported in a runtime environment, then the
table-lookup based implementation would serve as fallback via alternative
mechanism.

By inspecting the vmlinux built by gcc v12.2.0 with default optimization
level (-O2), we can see below instruction count change for each 8-byte
stride in the CRC32 loop:

rv64: crc32_be (54->31), crc32_le (54->13), __crc32c_le (54->13)
rv32: crc32_be (50->32), crc32_le (50->16), __crc32c_le (50->16)

The compile target CPU is little endian, extra effort is needed for byte
swapping for the crc32_be API, thus, the instruction count change is not
as significant as that in the *_le cases.

This patch is tested on QEMU VM with the kernel CRC32 selftest for both
rv64 and rv32.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
v4:
- Use "asm goto" instead of "asm_volatile_goto". (Charlie)

v3:
- Use Zbc to handle also the data head and tail bytes, instead of calling
  fallback function.
- Misc changes due to the new design.

v2:
- Fix sparse warnings about type casting. (lkp)
- Add info about instruction count change in commit log. (Andrew)
- Use the min() helper from linux/minmax.h. (Andrew)
- Use "#if __riscv_xlen == 64" macro check to differentiate rv64 and rv32. (Andrew)
- Line up several macro values by tab. (Andrew)
- Make poly_qt as "unsigned long" to unify the code for rv64 and rv32. (David)
- Fix the style of comment wing. (Andrew)
- Add function wrappers for the asm code for the *_le cases. (Andrew)
---
 arch/riscv/Kconfig      |  23 ++++
 arch/riscv/lib/Makefile |   1 +
 arch/riscv/lib/crc32.c  | 294 ++++++++++++++++++++++++++++++++++++++++
 include/linux/crc32.h   |   3 +
 4 files changed, 321 insertions(+)
 create mode 100644 arch/riscv/lib/crc32.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0bfcfec67ed5..68e1248bbee4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -610,6 +610,29 @@ config RISCV_ISA_ZBB
 
 	   If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZBC
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbc)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbc)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBC
+	bool "Zbc extension support for carry-less multiplication instructions"
+	depends on TOOLCHAIN_HAS_ZBC
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the Zbc
+	   extension (carry-less multiplication) and enable its usage.
+
+	   The Zbc extension could accelerate CRC (cyclic redundancy check)
+	   calculations.
+
+	   If you don't know what to do here, say Y.
+
 config RISCV_ISA_ZICBOM
 	bool "Zicbom extension support for non-coherent DMA operation"
 	depends on MMU
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index bd6e6c1b0497..2b369f51b0a5 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -13,6 +13,7 @@ endif
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
+lib-$(CONFIG_RISCV_ISA_ZBC)	+= crc32.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
diff --git a/arch/riscv/lib/crc32.c b/arch/riscv/lib/crc32.c
new file mode 100644
index 000000000000..d7dc599af3ef
--- /dev/null
+++ b/arch/riscv/lib/crc32.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Accelerated CRC32 implementation with Zbc extension.
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+
+#include <asm/hwcap.h>
+#include <asm/alternative-macros.h>
+#include <asm/byteorder.h>
+
+#include <linux/types.h>
+#include <linux/minmax.h>
+#include <linux/crc32poly.h>
+#include <linux/crc32.h>
+#include <linux/byteorder/generic.h>
+
+/*
+ * Refer to https://www.corsix.org/content/barrett-reduction-polynomials for
+ * better understanding of how this math works.
+ *
+ * let "+" denotes polynomial add (XOR)
+ * let "-" denotes polynomial sub (XOR)
+ * let "*" denotes polynomial multiplication
+ * let "/" denotes polynomial floor division
+ * let "S" denotes source data, XLEN bit wide
+ * let "P" denotes CRC32 polynomial
+ * let "T" denotes 2^(XLEN+32)
+ * let "QT" denotes quotient of T/P, with the bit for 2^XLEN being implicit
+ *
+ * crc32(S, P)
+ * => S * (2^32) - S * (2^32) / P * P
+ * => lowest 32 bits of: S * (2^32) / P * P
+ * => lowest 32 bits of: S * (2^32) * (T / P) / T * P
+ * => lowest 32 bits of: S * (2^32) * quotient / T * P
+ * => lowest 32 bits of: S * quotient / 2^XLEN * P
+ * => lowest 32 bits of: (clmul_high_part(S, QT) + S) * P
+ * => clmul_low_part(clmul_high_part(S, QT) + S, P)
+ *
+ * In terms of below implementations, the BE case is more intuitive, since the
+ * higher order bit sits at more significant position.
+ */
+
+#if __riscv_xlen == 64
+/* Slide by XLEN bits per iteration */
+# define STEP_ORDER 3
+
+/* Each below polynomial quotient has an implicit bit for 2^XLEN */
+
+/* Polynomial quotient of (2^(XLEN+32))/CRC32_POLY, in LE format */
+# define CRC32_POLY_QT_LE	0x5a72d812fb808b20
+
+/* Polynomial quotient of (2^(XLEN+32))/CRC32C_POLY, in LE format */
+# define CRC32C_POLY_QT_LE	0xa434f61c6f5389f8
+
+/* Polynomial quotient of (2^(XLEN+32))/CRC32_POLY, in BE format, it should be
+ * the same as the bit-reversed version of CRC32_POLY_QT_LE
+ */
+# define CRC32_POLY_QT_BE	0x04d101df481b4e5a
+
+static inline u64 crc32_le_prep(u32 crc, unsigned long const *ptr)
+{
+	return (u64)crc ^ (__force u64)__cpu_to_le64(*ptr);
+}
+
+static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
+{
+	u32 crc;
+
+	/* We don't have a "clmulrh" insn, so use clmul + slli instead. */
+	asm volatile (".option push\n"
+		      ".option arch,+zbc\n"
+		      "clmul	%0, %1, %2\n"
+		      "slli	%0, %0, 1\n"
+		      "xor	%0, %0, %1\n"
+		      "clmulr	%0, %0, %3\n"
+		      "srli	%0, %0, 32\n"
+		      ".option pop\n"
+		      : "=&r" (crc)
+		      : "r" (s),
+			"r" (poly_qt),
+			"r" ((u64)poly << 32)
+		      :);
+	return crc;
+}
+
+static inline u64 crc32_be_prep(u32 crc, unsigned long const *ptr)
+{
+	return ((u64)crc << 32) ^ (__force u64)__cpu_to_be64(*ptr);
+}
+
+#elif __riscv_xlen == 32
+# define STEP_ORDER 2
+/* Each quotient should match the upper half of its analog in RV64 */
+# define CRC32_POLY_QT_LE	0xfb808b20
+# define CRC32C_POLY_QT_LE	0x6f5389f8
+# define CRC32_POLY_QT_BE	0x04d101df
+
+static inline u32 crc32_le_prep(u32 crc, unsigned long const *ptr)
+{
+	return crc ^ (__force u32)__cpu_to_le32(*ptr);
+}
+
+static inline u32 crc32_le_zbc(unsigned long s, u32 poly, unsigned long poly_qt)
+{
+	u32 crc;
+
+	/* We don't have a "clmulrh" insn, so use clmul + slli instead. */
+	asm volatile (".option push\n"
+		      ".option arch,+zbc\n"
+		      "clmul	%0, %1, %2\n"
+		      "slli	%0, %0, 1\n"
+		      "xor	%0, %0, %1\n"
+		      "clmulr	%0, %0, %3\n"
+		      ".option pop\n"
+		      : "=&r" (crc)
+		      : "r" (s),
+			"r" (poly_qt),
+			"r" (poly)
+		      :);
+	return crc;
+}
+
+static inline u32 crc32_be_prep(u32 crc, unsigned long const *ptr)
+{
+	return crc ^ (__force u32)__cpu_to_be32(*ptr);
+}
+
+#else
+# error "Unexpected __riscv_xlen"
+#endif
+
+static inline u32 crc32_be_zbc(unsigned long s)
+{
+	u32 crc;
+
+	asm volatile (".option push\n"
+		      ".option arch,+zbc\n"
+		      "clmulh	%0, %1, %2\n"
+		      "xor	%0, %0, %1\n"
+		      "clmul	%0, %0, %3\n"
+		      ".option pop\n"
+		      : "=&r" (crc)
+		      : "r" (s),
+			"r" (CRC32_POLY_QT_BE),
+			"r" (CRC32_POLY_BE)
+		      :);
+	return crc;
+}
+
+#define STEP		(1 << STEP_ORDER)
+#define OFFSET_MASK	(STEP - 1)
+
+typedef u32 (*fallback)(u32 crc, unsigned char const *p, size_t len);
+
+static inline u32 crc32_le_unaligned(u32 crc, unsigned char const *p,
+				     size_t len, u32 poly,
+				     unsigned long poly_qt)
+{
+	size_t bits = len * 8;
+	unsigned long s = 0;
+	u32 crc_low = 0;
+
+	for (int i = 0; i < len; i++)
+		s = ((unsigned long)*p++ << (__riscv_xlen - 8)) | (s >> 8);
+
+	s ^= (unsigned long)crc << (__riscv_xlen - bits);
+	if (__riscv_xlen == 32 || len < sizeof(u32))
+		crc_low = crc >> bits;
+
+	crc = crc32_le_zbc(s, poly, poly_qt);
+	crc ^= crc_low;
+
+	return crc;
+}
+
+static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
+					  size_t len, u32 poly,
+					  unsigned long poly_qt,
+					  fallback crc_fb)
+{
+	size_t offset, head_len, tail_len;
+	unsigned long const *p_ul;
+	unsigned long s;
+
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+			     RISCV_ISA_EXT_ZBC, 1)
+		 : : : : legacy);
+
+	/* Handle the unaligned head. */
+	offset = (unsigned long)p & OFFSET_MASK;
+	if (offset && len) {
+		head_len = min(STEP - offset, len);
+		crc = crc32_le_unaligned(crc, p, head_len, poly, poly_qt);
+		p += head_len;
+		len -= head_len;
+	}
+
+	tail_len = len & OFFSET_MASK;
+	len = len >> STEP_ORDER;
+	p_ul = (unsigned long const *)p;
+
+	for (int i = 0; i < len; i++) {
+		s = crc32_le_prep(crc, p_ul);
+		crc = crc32_le_zbc(s, poly, poly_qt);
+		p_ul++;
+	}
+
+	/* Handle the tail bytes. */
+	p = (unsigned char const *)p_ul;
+	if (tail_len)
+		crc = crc32_le_unaligned(crc, p, tail_len, poly, poly_qt);
+
+	return crc;
+
+legacy:
+	return crc_fb(crc, p, len);
+}
+
+u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
+{
+	return crc32_le_generic(crc, p, len, CRC32_POLY_LE, CRC32_POLY_QT_LE,
+				crc32_le_base);
+}
+
+u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
+{
+	return crc32_le_generic(crc, p, len, CRC32C_POLY_LE,
+				CRC32C_POLY_QT_LE, __crc32c_le_base);
+}
+
+static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
+				     size_t len)
+{
+	size_t bits = len * 8;
+	unsigned long s = 0;
+	u32 crc_low = 0;
+
+	s = 0;
+	for (int i = 0; i < len; i++)
+		s = *p++ | (s << 8);
+
+	if (__riscv_xlen == 32 || len < sizeof(u32)) {
+		s ^= crc >> (32 - bits);
+		crc_low = crc << bits;
+	} else {
+		s ^= (unsigned long)crc << (bits - 32);
+	}
+
+	crc = crc32_be_zbc(s);
+	crc ^= crc_low;
+
+	return crc;
+}
+
+u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
+{
+	size_t offset, head_len, tail_len;
+	unsigned long const *p_ul;
+	unsigned long s;
+
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+			     RISCV_ISA_EXT_ZBC, 1)
+		 : : : : legacy);
+
+	/* Handle the unaligned head. */
+	offset = (unsigned long)p & OFFSET_MASK;
+	if (offset && len) {
+		head_len = min(STEP - offset, len);
+		crc = crc32_be_unaligned(crc, p, head_len);
+		p += head_len;
+		len -= head_len;
+	}
+
+	tail_len = len & OFFSET_MASK;
+	len = len >> STEP_ORDER;
+	p_ul = (unsigned long const *)p;
+
+	for (int i = 0; i < len; i++) {
+		s = crc32_be_prep(crc, p_ul);
+		crc = crc32_be_zbc(s);
+		p_ul++;
+	}
+
+	/* Handle the tail bytes. */
+	p = (unsigned char const *)p_ul;
+	if (tail_len)
+		crc = crc32_be_unaligned(crc, p, tail_len);
+
+	return crc;
+
+legacy:
+	return crc32_be_base(crc, p, len);
+}
diff --git a/include/linux/crc32.h b/include/linux/crc32.h
index 9e8a032c1788..87f788c0d607 100644
--- a/include/linux/crc32.h
+++ b/include/linux/crc32.h
@@ -9,7 +9,9 @@
 #include <linux/bitrev.h>
 
 u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len);
+u32 __pure crc32_le_base(u32 crc, unsigned char const *p, size_t len);
 u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len);
+u32 __pure crc32_be_base(u32 crc, unsigned char const *p, size_t len);
 
 /**
  * crc32_le_combine - Combine two crc32 check values into one. For two
@@ -37,6 +39,7 @@ static inline u32 crc32_le_combine(u32 crc1, u32 crc2, size_t len2)
 }
 
 u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len);
+u32 __pure __crc32c_le_base(u32 crc, unsigned char const *p, size_t len);
 
 /**
  * __crc32c_le_combine - Combine two crc32c check values into one. For two
-- 
2.25.1


