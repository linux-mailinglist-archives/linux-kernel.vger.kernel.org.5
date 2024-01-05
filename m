Return-Path: <linux-kernel+bounces-17568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC615824F77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438D51F23692
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599B20310;
	Fri,  5 Jan 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5bdCnjw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEA200AA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704442111; x=1735978111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kymNFyxc7X83e2Q6Vv/6p38yrdsPo+9Xr3wdkAOH7Vk=;
  b=j5bdCnjwGdlRv2lUDri77qc1LfkEXLA9hFLIhuMHLUl9L43ocBfSEDQw
   HBNJ15lTtIca9UBOc0BaK53Px4Wgtpxx9n7boVn4Ise8FaD2NAD+dtSn9
   9ZloOfkBrJfxDj2xuyHIrejBbmCS9w6FDS4J1iQRIcUySQwaeKKexRhDl
   JUJVHPTyY86X//0gDyPd4tdWn/xrzdX7HErbdGE85X3PsVCHaLQxoxxYc
   GmIQLDaDnMC9lnh705YJB/lcs79h4DsukaqfgPgJOqjdM2SHpWktrXBD+
   eKbwWR+pBj4uCx+Tk2nbz9CEHZDnIg1GFk0q+lWi72mTfT74Z828pyN3T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4228139"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="4228139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 00:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="756872709"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="756872709"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2024 00:08:26 -0800
From: Xiao Wang <xiao.w.wang@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: conor.dooley@microchip.com,
	ajones@ventanamicro.com,
	heiko@sntech.de,
	haicheng.li@intel.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv: Optimize crc32 with Zbc extension
Date: Fri,  5 Jan 2024 16:08:30 +0800
Message-Id: <20240105080830.3738117-1-xiao.w.wang@intel.com>
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
mechanism. To avoid the performance concern of unalignment access, we also
use the fallback implementation to handle the head and tail bytes if any,
the main body is accelerated by Zbc extension.

This patch is tested on QEMU VM with the kernel CRC32 selftest.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/Kconfig      |  23 +++++
 arch/riscv/lib/Makefile |   1 +
 arch/riscv/lib/crc32.c  | 216 ++++++++++++++++++++++++++++++++++++++++
 include/linux/crc32.h   |   3 +
 4 files changed, 243 insertions(+)
 create mode 100644 arch/riscv/lib/crc32.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..d8b4fb697df2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -549,6 +549,29 @@ config RISCV_ISA_ZBB
 
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
index 26cb2502ecf8..183bf2097d57 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -9,5 +9,6 @@ lib-y			+= strncmp.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
+lib-$(CONFIG_RISCV_ISA_ZBC)	+= crc32.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/riscv/lib/crc32.c b/arch/riscv/lib/crc32.c
new file mode 100644
index 000000000000..1a24994df826
--- /dev/null
+++ b/arch/riscv/lib/crc32.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Accelerated CRC32 implementation with Zbc extension.
+ *
+ * Copyright (C) 2024 Intel Corporation
+ *
+ * Authors:
+ *     Xiao Wang <xiao.w.wang@intel.com>
+ */
+
+#include <asm/hwcap.h>
+#include <asm/alternative-macros.h>
+#include <asm/byteorder.h>
+
+#include <linux/types.h>
+#include <linux/crc32poly.h>
+#include <linux/crc32.h>
+#include <linux/byteorder/generic.h>
+
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
+#if (BITS_PER_LONG == 64)
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
+#elif (BITS_PER_LONG == 32)
+# define STEP_ORDER 2
+/* Each quotient should match the upper half of its analog in RV64 */
+# define CRC32_POLY_QT_LE	0xfb808b20
+# define CRC32C_POLY_QT_LE	0x6f5389f8
+# define CRC32_POLY_QT_BE	0x04d101df
+#else
+# error "Unexpected BITS_PER_LONG"
+#endif
+
+#define STEP (1 << STEP_ORDER)
+#define OFFSET_MASK (STEP - 1)
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
+typedef u32 (*fallback)(u32 crc, unsigned char const *p, size_t len);
+
+static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
+#if (BITS_PER_LONG == 64)
+					  size_t len, u32 poly, u64 poly_qt,
+#else
+					  size_t len, u32 poly, u32 poly_qt,
+#endif
+					  fallback crc_fb)
+{
+	size_t offset, head_len, tail_len;
+	const unsigned long *p_ul;
+	unsigned long s;
+
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBC, 1)
+			  : : : : legacy);
+
+	/* Handle the unalignment head. */
+	offset = (unsigned long)p & OFFSET_MASK;
+	if (offset) {
+		head_len = MIN(STEP - offset, len);
+		crc = crc_fb(crc, p, head_len);
+		len -= head_len;
+		p += head_len;
+	}
+
+	tail_len = len & OFFSET_MASK;
+	len = len >> STEP_ORDER;
+	p_ul = (unsigned long *)p;
+
+	for (int i = 0; i < len; i++) {
+#if (BITS_PER_LONG == 64)
+		s = (unsigned long)crc ^ __cpu_to_le64(*p_ul++);
+		/* We don't have a "clmulrh" insn, so use clmul + slli instead.
+		 */
+		asm volatile (".option push\n"
+			      ".option arch,+zbc\n"
+			      "clmul	%0, %1, %2\n"
+			      "slli	%0, %0, 1\n"
+			      "xor	%0, %0, %1\n"
+			      "clmulr	%0, %0, %3\n"
+			      "srli	%0, %0, 32\n"
+			      ".option pop\n"
+			      : "=&r" (crc)
+			      : "r" (s),
+				"r" (poly_qt),
+				"r" ((u64)poly << 32)
+			      :);
+#else
+		s = crc ^ __cpu_to_le32(*p_ul++);
+		/* We don't have a "clmulrh" insn, so use clmul + slli instead.
+		 */
+		asm volatile (".option push\n"
+			      ".option arch,+zbc\n"
+			      "clmul	%0, %1, %2\n"
+			      "slli	%0, %0, 1\n"
+			      "xor	%0, %0, %1\n"
+			      "clmulr	%0, %0, %3\n"
+			      ".option pop\n"
+			      : "=&r" (crc)
+			      : "r" (s),
+				"r" (poly_qt),
+				"r" (poly)
+			      :);
+#endif
+	}
+
+	/* Handle the tail bytes. */
+	if (tail_len)
+		crc = crc_fb(crc, (unsigned char const *)p_ul, tail_len);
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
+u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
+{
+	size_t offset, head_len, tail_len;
+	const unsigned long *p_ul;
+	unsigned long s;
+
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBC, 1)
+			  : : : : legacy);
+
+	/* Handle the unalignment head. */
+	offset = (unsigned long)p & OFFSET_MASK;
+	if (offset) {
+		head_len = MIN(STEP - offset, len);
+		crc = crc32_be_base(crc, p, head_len);
+		len -= head_len;
+		p += head_len;
+	}
+
+	tail_len = len & OFFSET_MASK;
+	len = len >> STEP_ORDER;
+	p_ul = (unsigned long *)p;
+
+	for (int i = 0; i < len; i++) {
+#if (BITS_PER_LONG == 64)
+		s = (unsigned long)crc << 32;
+		s ^= __cpu_to_be64(*p_ul++);
+#else
+		s = crc ^ __cpu_to_be32(*p_ul++);
+#endif
+		asm volatile (".option push\n"
+			      ".option arch,+zbc\n"
+			      "clmulh	%0, %1, %2\n"
+			      "xor	%0, %0, %1\n"
+			      "clmul	%0, %0, %3\n"
+			      ".option pop\n"
+			      : "=&r" (crc)
+			      : "r" (s),
+				"r" (CRC32_POLY_QT_BE),
+				"r" (CRC32_POLY_BE)
+			      :);
+	}
+
+	/* Handle the tail bytes. */
+	if (tail_len)
+		crc = crc32_be_base(crc, (unsigned char const *)p_ul, tail_len);
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


