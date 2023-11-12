Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1B7E8F59
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKLJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:34:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEEB2D51;
        Sun, 12 Nov 2023 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699781677; x=1731317677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=58bsD01c7O4HL20v1MM92h3BL8J+4zZed97OD3jdFto=;
  b=DmNlhzvAq5RFMg1eU7Y2k5G3Hfx9Ac33BlBTdMXIFecpol6Y30SSvvIn
   rhJTDjYZwhF8K8lk9QwQ0TALoWF+XvCStDDDFKXtBl9XYC5RDMqEJPqjd
   7PNzPF1+THF6ArTLZOV9L8MF75PpmKvGxdu0qs+3ScRnXhfEuZgK9cOoK
   ErQRODAc3x2N9EeMO+gsZmTGehwxCkkr1kE+DkCEMAWdvQP/WEDdbczu3
   YsVm4Sobl9tv6z2xuTOvqfJAA5gF73kDP540WWbtcejNrmxYBM8gDKM9v
   saqGfheppDrGkeirDAezJOX2tfC48f+SrNsA2+fUPAIfz9R8uq0k9vo+2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="393189128"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="393189128"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 01:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="11818113"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orviesa001.jf.intel.com with ESMTP; 12 Nov 2023 01:34:34 -0800
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, arnd@arndb.de
Cc:     geert@linux-m68k.org, haicheng.li@intel.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv: Avoid code duplication with generic bitops implementation
Date:   Sun, 12 Nov 2023 17:44:21 +0800
Message-Id: <20231112094421.4014931-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's code duplication between the fallback implementation for bitops
__ffs/__fls/ffs/fls API and the generic C implementation in
include/asm-generic/bitops/. To avoid this duplication, this patch renames
the generic C implementation by adding a "generic_" prefix to them, then we
can use these generic APIs as fallback.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/bitops.h    | 138 +++++------------------------
 include/asm-generic/bitops/__ffs.h |   8 +-
 include/asm-generic/bitops/__fls.h |   8 +-
 include/asm-generic/bitops/ffs.h   |   8 +-
 include/asm-generic/bitops/fls.h   |   8 +-
 5 files changed, 48 insertions(+), 122 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index f7c167646460..23f7c122b151 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -22,6 +22,16 @@
 #include <asm-generic/bitops/fls.h>
 
 #else
+#define __HAVE_ARCH___FFS
+#define __HAVE_ARCH___FLS
+#define __HAVE_ARCH_FFS
+#define __HAVE_ARCH_FLS
+
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/fls.h>
+
 #include <asm/alternative-macros.h>
 #include <asm/hwcap.h>
 
@@ -37,8 +47,6 @@
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
 {
-	int num;
-
 	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
@@ -52,32 +60,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 	return word;
 
 legacy:
-	num = 0;
-#if BITS_PER_LONG == 64
-	if ((word & 0xffffffff) == 0) {
-		num += 32;
-		word >>= 32;
-	}
-#endif
-	if ((word & 0xffff) == 0) {
-		num += 16;
-		word >>= 16;
-	}
-	if ((word & 0xff) == 0) {
-		num += 8;
-		word >>= 8;
-	}
-	if ((word & 0xf) == 0) {
-		num += 4;
-		word >>= 4;
-	}
-	if ((word & 0x3) == 0) {
-		num += 2;
-		word >>= 2;
-	}
-	if ((word & 0x1) == 0)
-		num += 1;
-	return num;
+	return generic___ffs(word);
 }
 
 /**
@@ -93,8 +76,6 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable__fls(unsigned long word)
 {
-	int num;
-
 	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
@@ -108,32 +89,7 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 	return BITS_PER_LONG - 1 - word;
 
 legacy:
-	num = BITS_PER_LONG - 1;
-#if BITS_PER_LONG == 64
-	if (!(word & (~0ul << 32))) {
-		num -= 32;
-		word <<= 32;
-	}
-#endif
-	if (!(word & (~0ul << (BITS_PER_LONG - 16)))) {
-		num -= 16;
-		word <<= 16;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG - 8)))) {
-		num -= 8;
-		word <<= 8;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG - 4)))) {
-		num -= 4;
-		word <<= 4;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG - 2)))) {
-		num -= 2;
-		word <<= 2;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG - 1))))
-		num -= 1;
-	return num;
+	return generic___fls(word);
 }
 
 /**
@@ -149,46 +105,23 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 
 static __always_inline int variable_ffs(int x)
 {
-	int r;
-
-	if (!x)
-		return 0;
-
 	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
 
+	if (!x)
+		return 0;
+
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
 		      CTZW "%0, %1\n"
 		      ".option pop\n"
-		      : "=r" (r) : "r" (x) :);
+		      : "=r" (x) : "r" (x) :);
 
-	return r + 1;
+	return x + 1;
 
 legacy:
-	r = 1;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
+	return generic_ffs(x);
 }
 
 /**
@@ -204,46 +137,23 @@ static __always_inline int variable_ffs(int x)
 
 static __always_inline int variable_fls(unsigned int x)
 {
-	int r;
-
-	if (!x)
-		return 0;
-
 	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
 			  : : : : legacy);
 
+	if (!x)
+		return 0;
+
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
 		      CLZW "%0, %1\n"
 		      ".option pop\n"
-		      : "=r" (r) : "r" (x) :);
+		      : "=r" (x) : "r" (x) :);
 
-	return 32 - r;
+	return 32 - x;
 
 legacy:
-	r = 32;
-	if (!(x & 0xffff0000u)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xff000000u)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf0000000u)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc0000000u)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
+	return generic_fls(x);
 }
 
 /**
diff --git a/include/asm-generic/bitops/__ffs.h b/include/asm-generic/bitops/__ffs.h
index 39e56e1c7203..446fea6dda78 100644
--- a/include/asm-generic/bitops/__ffs.h
+++ b/include/asm-generic/bitops/__ffs.h
@@ -5,12 +5,12 @@
 #include <asm/types.h>
 
 /**
- * __ffs - find first bit in word.
+ * generic___ffs - find first bit in word.
  * @word: The word to search
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned long generic___ffs(unsigned long word)
 {
 	int num = 0;
 
@@ -41,4 +41,8 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
+#ifndef __HAVE_ARCH___FFS
+#define __ffs(word) generic___ffs(word)
+#endif
+
 #endif /* _ASM_GENERIC_BITOPS___FFS_H_ */
diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
index 03f721a8a2b1..54ccccf96e21 100644
--- a/include/asm-generic/bitops/__fls.h
+++ b/include/asm-generic/bitops/__fls.h
@@ -5,12 +5,12 @@
 #include <asm/types.h>
 
 /**
- * __fls - find last (most-significant) set bit in a long word
+ * generic___fls - find last (most-significant) set bit in a long word
  * @word: the word to search
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned long generic___fls(unsigned long word)
 {
 	int num = BITS_PER_LONG - 1;
 
@@ -41,4 +41,8 @@ static __always_inline unsigned long __fls(unsigned long word)
 	return num;
 }
 
+#ifndef __HAVE_ARCH___FLS
+#define __fls(word) generic___fls(word)
+#endif
+
 #endif /* _ASM_GENERIC_BITOPS___FLS_H_ */
diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
index 323fd5d6ae26..4c43f242daeb 100644
--- a/include/asm-generic/bitops/ffs.h
+++ b/include/asm-generic/bitops/ffs.h
@@ -3,14 +3,14 @@
 #define _ASM_GENERIC_BITOPS_FFS_H_
 
 /**
- * ffs - find first bit set
+ * generic_ffs - find first bit set
  * @x: the word to search
  *
  * This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from ffz (man ffs).
  */
-static inline int ffs(int x)
+static inline int generic_ffs(int x)
 {
 	int r = 1;
 
@@ -39,4 +39,8 @@ static inline int ffs(int x)
 	return r;
 }
 
+#ifndef __HAVE_ARCH_FFS
+#define ffs(x) generic_ffs(x)
+#endif
+
 #endif /* _ASM_GENERIC_BITOPS_FFS_H_ */
diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index b168bb10e1be..26f3ce1dd6e4 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -3,14 +3,14 @@
 #define _ASM_GENERIC_BITOPS_FLS_H_
 
 /**
- * fls - find last (most-significant) bit set
+ * generic_fls - find last (most-significant) bit set
  * @x: the word to search
  *
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int fls(unsigned int x)
+static __always_inline int generic_fls(unsigned int x)
 {
 	int r = 32;
 
@@ -39,4 +39,8 @@ static __always_inline int fls(unsigned int x)
 	return r;
 }
 
+#ifndef __HAVE_ARCH_FLS
+#define fls(x) generic_fls(x)
+#endif
+
 #endif /* _ASM_GENERIC_BITOPS_FLS_H_ */
-- 
2.25.1

