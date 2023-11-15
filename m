Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367CA7DC6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjJaGgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjJaGgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:36:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA1BD;
        Mon, 30 Oct 2023 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698734177; x=1730270177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LMdgacdpQJDId28m7gM38i/zIbwoCgHbYIHNsx+v+Dk=;
  b=K+nMWgogbxea/4GXNVMu8hZiZe1Tyr1hvT+OO7rxvXlHh1yfQ1W1NMr5
   eFV8/+1QMf9qc+Y+umpGW0+Z00oh+uTRPWZjANMB0CDwhS6lmDknn2cMK
   l+y6uZvjkZ2hoiXUeNfU9SBex2i2m3zibB2Ha8fKmR1hLCrinqnGOiuXU
   Pxt4FxwKCET7GUbRVi54p2ppBtbk9Sdmy660cql3lcWkkyoZkPvpSZze8
   vgpfSPydhqrIPwiG6Rt3KmLmdByCbode7b3WhIVKaRl1ZtbhHP9r6HD6a
   T/tOGP90GRTE6LOdW5OLfUsqsMlqt0j25SekmMvMlRkTKlRHzNv+UO7lE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474463686"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="474463686"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1091896353"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1091896353"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2023 23:36:10 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, yujie.liu@intel.com, charlie@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v5 2/2] riscv: Optimize bitops with Zbb extension
Date:   Tue, 31 Oct 2023 14:45:53 +0800
Message-Id: <20231031064553.2319688-3-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031064553.2319688-1-xiao.w.wang@intel.com>
References: <20231031064553.2319688-1-xiao.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch leverages the alternative mechanism to dynamically optimize
bitops (including __ffs, __fls, ffs, fls) with Zbb instructions. When
Zbb ext is not supported by the runtime CPU, legacy implementation is
used. If Zbb is supported, then the optimized variants will be selected
via alternative patching.

The legacy bitops support is taken from the generic C implementation as
fallback.

If the parameter is a build-time constant, we leverage compiler builtin to
calculate the result directly, this approach is inspired by x86 bitops
implementation.

EFI stub runs before the kernel, so alternative mechanism should not be
used there, this patch introduces a macro NO_ALTERNATIVE for this purpose.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/bitops.h       | 254 +++++++++++++++++++++++++-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 2 files changed, 252 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 3540b690944b..b212c2708cda 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -15,13 +15,261 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
+#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
 #include <asm-generic/bitops/__ffs.h>
-#include <asm-generic/bitops/ffz.h>
-#include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/fls.h>
+
+#else
+#include <asm/alternative-macros.h>
+#include <asm/hwcap.h>
+
+#if (BITS_PER_LONG == 64)
+#define CTZW	"ctzw "
+#define CLZW	"clzw "
+#elif (BITS_PER_LONG == 32)
+#define CTZW	"ctz "
+#define CLZW	"clz "
+#else
+#error "Unexpected BITS_PER_LONG"
+#endif
+
+static __always_inline unsigned long variable__ffs(unsigned long word)
+{
+	int num;
+
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile (".option push\n"
+		      ".option arch,+zbb\n"
+		      "ctz %0, %1\n"
+		      ".option pop\n"
+		      : "=r" (word) : "r" (word) :);
+
+	return word;
+
+legacy:
+	num = 0;
+#if BITS_PER_LONG == 64
+	if ((word & 0xffffffff) == 0) {
+		num += 32;
+		word >>= 32;
+	}
+#endif
+	if ((word & 0xffff) == 0) {
+		num += 16;
+		word >>= 16;
+	}
+	if ((word & 0xff) == 0) {
+		num += 8;
+		word >>= 8;
+	}
+	if ((word & 0xf) == 0) {
+		num += 4;
+		word >>= 4;
+	}
+	if ((word & 0x3) == 0) {
+		num += 2;
+		word >>= 2;
+	}
+	if ((word & 0x1) == 0)
+		num += 1;
+	return num;
+}
+
+/**
+ * __ffs - find first set bit in a long word
+ * @word: The word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+#define __ffs(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(word) :	\
+	 variable__ffs(word))
+
+static __always_inline unsigned long variable__fls(unsigned long word)
+{
+	int num;
+
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile (".option push\n"
+		      ".option arch,+zbb\n"
+		      "clz %0, %1\n"
+		      ".option pop\n"
+		      : "=r" (word) : "r" (word) :);
+
+	return BITS_PER_LONG - 1 - word;
+
+legacy:
+	num = BITS_PER_LONG - 1;
+#if BITS_PER_LONG == 64
+	if (!(word & (~0ul << 32))) {
+		num -= 32;
+		word <<= 32;
+	}
+#endif
+	if (!(word & (~0ul << (BITS_PER_LONG - 16)))) {
+		num -= 16;
+		word <<= 16;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG - 8)))) {
+		num -= 8;
+		word <<= 8;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG - 4)))) {
+		num -= 4;
+		word <<= 4;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG - 2)))) {
+		num -= 2;
+		word <<= 2;
+	}
+	if (!(word & (~0ul << (BITS_PER_LONG - 1))))
+		num -= 1;
+	return num;
+}
+
+/**
+ * __fls - find last set bit in a long word
+ * @word: the word to search
+ *
+ * Undefined if no set bit exists, so code should check against 0 first.
+ */
+#define __fls(word)							\
+	(__builtin_constant_p(word) ?					\
+	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
+	 variable__fls(word))
+
+static __always_inline int variable_ffs(int x)
+{
+	int r;
+
+	if (!x)
+		return 0;
+
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile (".option push\n"
+		      ".option arch,+zbb\n"
+		      CTZW "%0, %1\n"
+		      ".option pop\n"
+		      : "=r" (r) : "r" (x) :);
+
+	return r + 1;
+
+legacy:
+	r = 1;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+/**
+ * ffs - find first set bit in a word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs routines.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first set bit if
+ * value is nonzero. The first (least significant) bit is at position 1.
+ */
+#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
+
+static __always_inline int variable_fls(unsigned int x)
+{
+	int r;
+
+	if (!x)
+		return 0;
+
+	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile (".option push\n"
+		      ".option arch,+zbb\n"
+		      CLZW "%0, %1\n"
+		      ".option pop\n"
+		      : "=r" (r) : "r" (x) :);
+
+	return 32 - r;
+
+legacy:
+	r = 32;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+/**
+ * fls - find last set bit in a word
+ * @x: the word to search
+ *
+ * This is defined in a similar way as ffs, but returns the position of the most
+ * significant set bit.
+ *
+ * fls(value) returns 0 if value is 0 or the position of the last set bit if
+ * value is nonzero. The last (most significant) bit is at position 32.
+ */
+#define fls(x)							\
+({								\
+	typeof(x) x_ = (x);					\
+	__builtin_constant_p(x_) ?				\
+	 (int)((x_ != 0) ? (32 - __builtin_clz(x_)) : 0)	\
+	 :							\
+	 variable_fls(x_);					\
+})
+
+#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE) */
+
+#include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
-#include <asm-generic/bitops/ffs.h>
 
 #include <asm-generic/bitops/hweight.h>
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a1157c2a7170..d68cacd4e3af 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic
+cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.25.1

