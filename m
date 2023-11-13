Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0F7E9D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjKMNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjKMNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:32:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EEF1A5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:32:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE17C433C8;
        Mon, 13 Nov 2023 13:32:33 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     geert@linux-m68k.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH v2] m68k: use kernel's generic muldi3 libgcc function
Date:   Mon, 13 Nov 2023 23:32:09 +1000
Message-Id: <20231113133209.1367286-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kernels own generic lib/muldi3.c implementation of muldi3 for
68K machines. Some 68K CPUs support 64bit multiplies so move the arch
specific umul_ppmm() macro into a header file that is included by
lib/muldi3.c. That way it can take advantage of the single instruction
when available.

There does not appear to be any existing mechanism for the generic
lib/muldi3.c code to pick up an external arch definition of umul_ppmm().
Create an arch specific libgcc.h that can optionally be included by
the system include/linux/libgcc.h to allow for this.

Somewhat oddly there is also a similar definition of umul_ppmm() in
the non-architecture code in lib/crypto/mpi/longlong.h for a wide range
or machines. Its presence ends up complicating the include setup and
means not being able to use something like compiler.h instead. Actually
there is a few other defines of umul_ppmm() macros spread around in
various architectures, but not directly usable for the m68k case.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/Kconfig                   |  8 +++
 arch/m68k/Kconfig              |  2 +
 arch/m68k/include/asm/libgcc.h | 20 +++++++
 arch/m68k/lib/Makefile         |  2 +-
 arch/m68k/lib/muldi3.c         | 97 ----------------------------------
 include/linux/libgcc.h         |  4 ++
 6 files changed, 35 insertions(+), 98 deletions(-)
 create mode 100644 arch/m68k/include/asm/libgcc.h
 delete mode 100644 arch/m68k/lib/muldi3.c

v2: change to using arch libgcc.h instead of compiler.h

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..3764328dd8b1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1331,6 +1331,14 @@ config HAVE_ARCH_COMPILER_H
 	  linux/compiler-*.h in order to override macro definitions that those
 	  headers generally provide.
 
+config HAVE_ARCH_LIBGCC_H
+	bool
+	help
+	  An architecture can select this if it provides an
+	  asm/libgcc.h header that should be included after
+	  linux/libgcc.h in order to override macro definitions that
+	  header generally provides.
+
 config HAVE_ARCH_PREL32_RELOCATIONS
 	bool
 	help
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 4b3e93cac723..1594f78e3666 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -22,7 +22,9 @@ config M68K
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_MULDI3
 	select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA
+	select HAVE_ARCH_LIBGCC_H
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/m68k/include/asm/libgcc.h b/arch/m68k/include/asm/libgcc.h
new file mode 100644
index 000000000000..1cce6d130d80
--- /dev/null
+++ b/arch/m68k/include/asm/libgcc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_M68K_LIBGCC_H
+#define __ASM_M68K_LIBGCC_H
+
+#ifndef CONFIG_CPU_HAS_NO_MULDIV64
+/*
+ * For those 68K CPUs that support 64bit multiply define umul_ppm()
+ * for the common muldi3 libgcc helper function (in lib/muldi3.c).
+ * CPUs that don't have it (like the original 68000 and ColdFire)
+ * will fallback to using the C-coded version of umul_ppmm().
+ */
+#define umul_ppmm(w1, w0, u, v)				\
+	__asm__ ("mulu%.l %3,%1:%0"			\
+		 : "=d" ((unsigned long)(w0)),		\
+		   "=d" ((unsigned long)(w1))		\
+		 : "%0" ((unsigned long)(u)),		\
+		   "dmi" ((unsigned long)(v)))
+#endif /* !CONFIG_CPU_HAS_NO_MULDIV64 */
+
+#endif /* __ASM_M68K_LIBGCC_H */
diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
index 9158688e6cc6..15278a95259e 100644
--- a/arch/m68k/lib/Makefile
+++ b/arch/m68k/lib/Makefile
@@ -4,7 +4,7 @@
 # Makefile for m68k-specific library files..
 #
 
-lib-y	:= muldi3.o memcpy.o memset.o memmove.o
+lib-y	:= memcpy.o memset.o memmove.o
 
 lib-$(CONFIG_MMU) += uaccess.o
 lib-$(CONFIG_CPU_HAS_NO_MULDIV64) += mulsi3.o divsi3.o udivsi3.o
diff --git a/arch/m68k/lib/muldi3.c b/arch/m68k/lib/muldi3.c
deleted file mode 100644
index 5012a9b218c7..000000000000
--- a/arch/m68k/lib/muldi3.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/* muldi3.c extracted from gcc-2.7.2.3/libgcc2.c and 
-			   gcc-2.7.2.3/longlong.h which is: */
-/* Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
-
-This file is part of GNU CC.
-
-GNU CC is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License as published by
-the Free Software Foundation; either version 2, or (at your option)
-any later version.
-
-GNU CC is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-GNU General Public License for more details. */
-
-#include <linux/compiler.h>
-#include <linux/export.h>
-#include <linux/libgcc.h>
-
-#ifdef CONFIG_CPU_HAS_NO_MULDIV64
-
-#define SI_TYPE_SIZE 32
-#define __BITS4 (SI_TYPE_SIZE / 4)
-#define __ll_B (1L << (SI_TYPE_SIZE / 2))
-#define __ll_lowpart(t) ((USItype) (t) % __ll_B)
-#define __ll_highpart(t) ((USItype) (t) / __ll_B)
-
-#define umul_ppmm(w1, w0, u, v)						\
-  do {									\
-    USItype __x0, __x1, __x2, __x3;					\
-    USItype __ul, __vl, __uh, __vh;					\
-									\
-    __ul = __ll_lowpart (u);						\
-    __uh = __ll_highpart (u);						\
-    __vl = __ll_lowpart (v);						\
-    __vh = __ll_highpart (v);						\
-									\
-    __x0 = (USItype) __ul * __vl;					\
-    __x1 = (USItype) __ul * __vh;					\
-    __x2 = (USItype) __uh * __vl;					\
-    __x3 = (USItype) __uh * __vh;					\
-									\
-    __x1 += __ll_highpart (__x0);/* this can't give carry */		\
-    __x1 += __x2;		/* but this indeed can */		\
-    if (__x1 < __x2)		/* did we get it? */			\
-      __x3 += __ll_B;		/* yes, add it in the proper pos. */	\
-									\
-    (w1) = __x3 + __ll_highpart (__x1);					\
-    (w0) = __ll_lowpart (__x1) * __ll_B + __ll_lowpart (__x0);		\
-  } while (0)
-
-#else
-
-#define umul_ppmm(w1, w0, u, v) \
-  __asm__ ("mulu%.l %3,%1:%0"						\
-           : "=d" ((USItype)(w0)),					\
-             "=d" ((USItype)(w1))					\
-           : "%0" ((USItype)(u)),					\
-             "dmi" ((USItype)(v)))
-
-#endif
-
-#define __umulsidi3(u, v) \
-  ({DIunion __w;							\
-    umul_ppmm (__w.s.high, __w.s.low, u, v);				\
-    __w.ll; })
-
-typedef 	 int SItype	__mode(SI);
-typedef unsigned int USItype	__mode(SI);
-typedef		 int DItype	__mode(DI);
-typedef int word_type           __mode(__word__);
-
-struct DIstruct {SItype high, low;};
-
-typedef union
-{
-  struct DIstruct s;
-  DItype ll;
-} DIunion;
-
-DItype
-__muldi3 (DItype u, DItype v)
-{
-  DIunion w;
-  DIunion uu, vv;
-
-  uu.ll = u;
-  vv.ll = v;
-
-  w.ll = __umulsidi3 (uu.s.low, vv.s.low);
-  w.s.high += ((USItype) uu.s.low * (USItype) vv.s.high
-	       + (USItype) uu.s.high * (USItype) vv.s.low);
-
-  return w.ll;
-}
-EXPORT_SYMBOL(__muldi3);
diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
index fc388da6a027..0d68f9d6a6a7 100644
--- a/include/linux/libgcc.h
+++ b/include/linux/libgcc.h
@@ -34,4 +34,8 @@ long long notrace __lshrdi3(long long u, word_type b);
 long long notrace __muldi3(long long u, long long v);
 word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b);
 
+#ifdef CONFIG_HAVE_ARCH_LIBGCC_H
+#include <asm/libgcc.h>
+#endif
+
 #endif /* __ASM_LIBGCC_H */
-- 
2.25.1

