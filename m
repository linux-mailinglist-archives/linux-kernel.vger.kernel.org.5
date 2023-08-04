Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32777006C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjHDMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHDMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:46:24 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF546B2;
        Fri,  4 Aug 2023 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1691153176; bh=5dpgIOxLRmBYn5HXPpB1JJzKTYnTf5xnIvQxbuNWheI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJfA7bI+Srp9XiJxhozz8zajtx8pWccJnYEuvu9hKK9ggshRqawAW/3iFVOayNTkq
         /jZQdiaVvCKK6lQHmmEP2r/+okrKd4fBaFVKA/zsPn54ImQFOvqAzvWeIdqo6vXe9F
         aX2msJbOh9/hqPDSR+9Rd28VFoT7jzCQfT8HfxOs=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 192606015A;
        Fri,  4 Aug 2023 20:46:15 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-raid@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v3 1/3] LoongArch: Add SIMD-optimized XOR routines
Date:   Fri,  4 Aug 2023 20:46:09 +0800
Message-Id: <20230804124611.2051048-2-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230804124611.2051048-1-kernel@xen0n.name>
References: <20230804124611.2051048-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Add LSX and LASX implementations of xor operations, operating on 64
bytes (one L1 cache line) at a time, for a balance between memory
utilization and instruction mix. Huacai confirmed that all future
LoongArch implementations by Loongson (that we care) will likely also
feature 64-byte cache lines, and experiments show no throughput
improvement with further unrolling.

Performance numbers measured during system boot on a 3A5000 @ 2.5GHz:

> 8regs           : 12702 MB/sec
> 8regs_prefetch  : 10920 MB/sec
> 32regs          : 12686 MB/sec
> 32regs_prefetch : 10918 MB/sec
> lsx             : 17589 MB/sec
> lasx            : 26116 MB/sec

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/xor.h      |  68 ++++++++++++++++
 arch/loongarch/include/asm/xor_simd.h |  42 ++++++++++
 arch/loongarch/lib/Makefile           |   3 +
 arch/loongarch/lib/xor_simd.c         |  93 ++++++++++++++++++++++
 arch/loongarch/lib/xor_simd.h         |  46 +++++++++++
 arch/loongarch/lib/xor_simd_glue.c    |  71 +++++++++++++++++
 arch/loongarch/lib/xor_template.c     | 110 ++++++++++++++++++++++++++
 7 files changed, 433 insertions(+)
 create mode 100644 arch/loongarch/include/asm/xor.h
 create mode 100644 arch/loongarch/include/asm/xor_simd.h
 create mode 100644 arch/loongarch/lib/xor_simd.c
 create mode 100644 arch/loongarch/lib/xor_simd.h
 create mode 100644 arch/loongarch/lib/xor_simd_glue.c
 create mode 100644 arch/loongarch/lib/xor_template.c

diff --git a/arch/loongarch/include/asm/xor.h b/arch/loongarch/include/asm/xor.h
new file mode 100644
index 0000000000000..12467fffee468
--- /dev/null
+++ b/arch/loongarch/include/asm/xor.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
+ */
+#ifndef _ASM_LOONGARCH_XOR_H
+#define _ASM_LOONGARCH_XOR_H
+
+#include <asm/cpu-features.h>
+#include <asm/xor_simd.h>
+
+#ifdef CONFIG_CPU_HAS_LSX
+static struct xor_block_template xor_block_lsx = {
+	.name = "lsx",
+	.do_2 = xor_lsx_2,
+	.do_3 = xor_lsx_3,
+	.do_4 = xor_lsx_4,
+	.do_5 = xor_lsx_5,
+};
+
+#define XOR_SPEED_LSX()					\
+	do {						\
+		if (cpu_has_lsx)			\
+			xor_speed(&xor_block_lsx);	\
+	} while (0)
+#else /* CONFIG_CPU_HAS_LSX */
+#define XOR_SPEED_LSX()
+#endif /* CONFIG_CPU_HAS_LSX */
+
+#ifdef CONFIG_CPU_HAS_LASX
+static struct xor_block_template xor_block_lasx = {
+	.name = "lasx",
+	.do_2 = xor_lasx_2,
+	.do_3 = xor_lasx_3,
+	.do_4 = xor_lasx_4,
+	.do_5 = xor_lasx_5,
+};
+
+#define XOR_SPEED_LASX()					\
+	do {							\
+		if (cpu_has_lasx)				\
+			xor_speed(&xor_block_lasx);		\
+	} while (0)
+#else /* CONFIG_CPU_HAS_LASX */
+#define XOR_SPEED_LASX()
+#endif /* CONFIG_CPU_HAS_LASX */
+
+/*
+ * For grins, also test the generic routines.
+ *
+ * More importantly: it cannot be ruled out at this point of time, that some
+ * future (maybe reduced) models could run the vector algorithms slower than
+ * the scalar ones, maybe for errata or micro-op reasons. It may be
+ * appropriate to revisit this after one or two more uarch generations.
+ */
+#include <asm-generic/xor.h>
+
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES				\
+do {							\
+	xor_speed(&xor_block_8regs);			\
+	xor_speed(&xor_block_8regs_p);			\
+	xor_speed(&xor_block_32regs);			\
+	xor_speed(&xor_block_32regs_p);			\
+	XOR_SPEED_LSX();				\
+	XOR_SPEED_LASX();				\
+} while (0)
+
+#endif /* _ASM_LOONGARCH_XOR_H */
diff --git a/arch/loongarch/include/asm/xor_simd.h b/arch/loongarch/include/asm/xor_simd.h
new file mode 100644
index 0000000000000..a087e4ded5303
--- /dev/null
+++ b/arch/loongarch/include/asm/xor_simd.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
+ */
+#ifndef _ASM_LOONGARCH_XOR_SIMD_H
+#define _ASM_LOONGARCH_XOR_SIMD_H
+
+#ifdef CONFIG_CPU_HAS_LSX
+void xor_lsx_2(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2);
+void xor_lsx_3(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3);
+void xor_lsx_4(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4);
+void xor_lsx_5(unsigned long bytes, unsigned long * __restrict p1,
+	       const unsigned long * __restrict p2,
+	       const unsigned long * __restrict p3,
+	       const unsigned long * __restrict p4,
+	       const unsigned long * __restrict p5);
+#endif /* CONFIG_CPU_HAS_LSX */
+
+#ifdef CONFIG_CPU_HAS_LASX
+void xor_lasx_2(unsigned long bytes, unsigned long * __restrict p1,
+	        const unsigned long * __restrict p2);
+void xor_lasx_3(unsigned long bytes, unsigned long * __restrict p1,
+	        const unsigned long * __restrict p2,
+	        const unsigned long * __restrict p3);
+void xor_lasx_4(unsigned long bytes, unsigned long * __restrict p1,
+	        const unsigned long * __restrict p2,
+	        const unsigned long * __restrict p3,
+	        const unsigned long * __restrict p4);
+void xor_lasx_5(unsigned long bytes, unsigned long * __restrict p1,
+	        const unsigned long * __restrict p2,
+	        const unsigned long * __restrict p3,
+	        const unsigned long * __restrict p4,
+	        const unsigned long * __restrict p5);
+#endif /* CONFIG_CPU_HAS_LASX */
+
+#endif /* _ASM_LOONGARCH_XOR_SIMD_H */
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index d60d4e096cfa9..045a3ed6ecd70 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -6,4 +6,7 @@
 lib-y	+= delay.o memset.o memcpy.o memmove.o \
 	   clear_user.o copy_user.o csum.o dump_tlb.o unaligned.o
 
+obj-$(CONFIG_CPU_HAS_LSX) += xor_simd.o xor_simd_glue.o
+
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
diff --git a/arch/loongarch/lib/xor_simd.c b/arch/loongarch/lib/xor_simd.c
new file mode 100644
index 0000000000000..84cd24b728c47
--- /dev/null
+++ b/arch/loongarch/lib/xor_simd.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LoongArch SIMD XOR operations
+ *
+ * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
+ */
+
+#include "xor_simd.h"
+
+/*
+ * Process one cache line (64 bytes) per loop. This is assuming all future
+ * popular LoongArch cores are similar performance-characteristics-wise to the
+ * current models.
+ */
+#define LINE_WIDTH 64
+
+#ifdef CONFIG_CPU_HAS_LSX
+
+#define LD(reg, base, offset)	\
+	"vld $vr" #reg ", %[" #base "], " #offset "\n\t"
+#define ST(reg, base, offset)	\
+	"vst $vr" #reg ", %[" #base "], " #offset "\n\t"
+#define XOR(dj, k)	"vxor.v $vr" #dj ", $vr" #dj ", $vr" #k "\n\t"
+
+#define LD_INOUT_LINE(base)	\
+	LD(0, base, 0)		\
+	LD(1, base, 16)		\
+	LD(2, base, 32)		\
+	LD(3, base, 48)
+
+#define LD_AND_XOR_LINE(base)	\
+	LD(4, base, 0)		\
+	LD(5, base, 16)		\
+	LD(6, base, 32)		\
+	LD(7, base, 48)		\
+	XOR(0, 4)		\
+	XOR(1, 5)		\
+	XOR(2, 6)		\
+	XOR(3, 7)
+
+#define ST_LINE(base)		\
+	ST(0, base, 0)		\
+	ST(1, base, 16)		\
+	ST(2, base, 32)		\
+	ST(3, base, 48)
+
+#define XOR_FUNC_NAME(nr) __xor_lsx_##nr
+#include "xor_template.c"
+
+#undef LD
+#undef ST
+#undef XOR
+#undef LD_INOUT_LINE
+#undef LD_AND_XOR_LINE
+#undef ST_LINE
+#undef XOR_FUNC_NAME
+
+#endif /* CONFIG_CPU_HAS_LSX */
+
+#ifdef CONFIG_CPU_HAS_LASX
+
+#define LD(reg, base, offset)	\
+	"xvld $xr" #reg ", %[" #base "], " #offset "\n\t"
+#define ST(reg, base, offset)	\
+	"xvst $xr" #reg ", %[" #base "], " #offset "\n\t"
+#define XOR(dj, k)	"xvxor.v $xr" #dj ", $xr" #dj ", $xr" #k "\n\t"
+
+#define LD_INOUT_LINE(base)	\
+	LD(0, base, 0)		\
+	LD(1, base, 32)
+
+#define LD_AND_XOR_LINE(base)	\
+	LD(2, base, 0)		\
+	LD(3, base, 32)		\
+	XOR(0, 2)		\
+	XOR(1, 3)
+
+#define ST_LINE(base)		\
+	ST(0, base, 0)		\
+	ST(1, base, 32)
+
+#define XOR_FUNC_NAME(nr) __xor_lasx_##nr
+#include "xor_template.c"
+
+#undef LD
+#undef ST
+#undef XOR
+#undef LD_INOUT_LINE
+#undef LD_AND_XOR_LINE
+#undef ST_LINE
+#undef XOR_FUNC_NAME
+
+#endif /* CONFIG_CPU_HAS_LASX */
diff --git a/arch/loongarch/lib/xor_simd.h b/arch/loongarch/lib/xor_simd.h
new file mode 100644
index 0000000000000..161b8d3875c7a
--- /dev/null
+++ b/arch/loongarch/lib/xor_simd.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Simple interface to link xor_simd.c and xor_simd_glue.c
+ *
+ * Separating these files ensures that no SIMD instructions are run outside of
+ * the kfpu critical section.
+ */
+
+#ifndef __LOONGARCH_LIB_XOR_SIMD_H
+#define __LOONGARCH_LIB_XOR_SIMD_H
+
+#ifdef CONFIG_CPU_HAS_LSX
+void __xor_lsx_2(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2);
+void __xor_lsx_3(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2,
+		 const unsigned long * __restrict p3);
+void __xor_lsx_4(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2,
+		 const unsigned long * __restrict p3,
+		 const unsigned long * __restrict p4);
+void __xor_lsx_5(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2,
+		 const unsigned long * __restrict p3,
+		 const unsigned long * __restrict p4,
+		 const unsigned long * __restrict p5);
+#endif /* CONFIG_CPU_HAS_LSX */
+
+#ifdef CONFIG_CPU_HAS_LASX
+void __xor_lasx_2(unsigned long bytes, unsigned long * __restrict p1,
+		  const unsigned long * __restrict p2);
+void __xor_lasx_3(unsigned long bytes, unsigned long * __restrict p1,
+		  const unsigned long * __restrict p2,
+		  const unsigned long * __restrict p3);
+void __xor_lasx_4(unsigned long bytes, unsigned long * __restrict p1,
+		  const unsigned long * __restrict p2,
+		  const unsigned long * __restrict p3,
+		  const unsigned long * __restrict p4);
+void __xor_lasx_5(unsigned long bytes, unsigned long * __restrict p1,
+		  const unsigned long * __restrict p2,
+		  const unsigned long * __restrict p3,
+		  const unsigned long * __restrict p4,
+		  const unsigned long * __restrict p5);
+#endif /* CONFIG_CPU_HAS_LASX */
+
+#endif /* __LOONGARCH_LIB_XOR_SIMD_H */
diff --git a/arch/loongarch/lib/xor_simd_glue.c b/arch/loongarch/lib/xor_simd_glue.c
new file mode 100644
index 0000000000000..6f1832862cbbd
--- /dev/null
+++ b/arch/loongarch/lib/xor_simd_glue.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Loongson SIMD XOR operations
+//
+// Copyright 2023 WANG Xuerui <git@xen0n.name>
+
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <asm/fpu.h>
+#include <asm/xor_simd.h>
+#include "xor_simd.h"
+
+#define MAKE_XOR_GLUE_2(flavor)							\
+void xor_##flavor##_2(unsigned long bytes, unsigned long * __restrict p1,	\
+		      const unsigned long * __restrict p2)			\
+{										\
+	kernel_fpu_begin();							\
+	__xor_##flavor##_2(bytes, p1, p2);					\
+	kernel_fpu_end();							\
+}										\
+EXPORT_SYMBOL_GPL(xor_##flavor##_2)
+
+#define MAKE_XOR_GLUE_3(flavor)							\
+void xor_##flavor##_3(unsigned long bytes, unsigned long * __restrict p1,	\
+		      const unsigned long * __restrict p2,			\
+		      const unsigned long * __restrict p3)			\
+{										\
+	kernel_fpu_begin();							\
+	__xor_##flavor##_3(bytes, p1, p2, p3);					\
+	kernel_fpu_end();							\
+}										\
+EXPORT_SYMBOL_GPL(xor_##flavor##_3)
+
+#define MAKE_XOR_GLUE_4(flavor)							\
+void xor_##flavor##_4(unsigned long bytes, unsigned long * __restrict p1,	\
+		      const unsigned long * __restrict p2,			\
+		      const unsigned long * __restrict p3,			\
+		      const unsigned long * __restrict p4)			\
+{										\
+	kernel_fpu_begin();							\
+	__xor_##flavor##_4(bytes, p1, p2, p3, p4);				\
+	kernel_fpu_end();							\
+}										\
+EXPORT_SYMBOL_GPL(xor_##flavor##_4)
+
+#define MAKE_XOR_GLUE_5(flavor)							\
+void xor_##flavor##_5(unsigned long bytes, unsigned long * __restrict p1,	\
+		      const unsigned long * __restrict p2,			\
+		      const unsigned long * __restrict p3,			\
+		      const unsigned long * __restrict p4,			\
+		      const unsigned long * __restrict p5)			\
+{										\
+	kernel_fpu_begin();							\
+	__xor_##flavor##_5(bytes, p1, p2, p3, p4, p5);				\
+	kernel_fpu_end();							\
+}										\
+EXPORT_SYMBOL_GPL(xor_##flavor##_5)
+
+#define MAKE_XOR_GLUES(flavor)		\
+	MAKE_XOR_GLUE_2(flavor);	\
+	MAKE_XOR_GLUE_3(flavor);	\
+	MAKE_XOR_GLUE_4(flavor);	\
+	MAKE_XOR_GLUE_5(flavor)
+
+#ifdef CONFIG_CPU_HAS_LSX
+MAKE_XOR_GLUES(lsx);
+#endif
+
+#ifdef CONFIG_CPU_HAS_LASX
+MAKE_XOR_GLUES(lasx);
+#endif
diff --git a/arch/loongarch/lib/xor_template.c b/arch/loongarch/lib/xor_template.c
new file mode 100644
index 0000000000000..0358ced7fe333
--- /dev/null
+++ b/arch/loongarch/lib/xor_template.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
+ *
+ * Template for XOR operations, instantiated in xor_simd.c.
+ *
+ * Expected preprocessor definitions:
+ *
+ * - LINE_WIDTH
+ * - XOR_FUNC_NAME(nr)
+ * - LD_INOUT_LINE(buf)
+ * - LD_AND_XOR_LINE(buf)
+ * - ST_LINE(buf)
+ */
+
+void XOR_FUNC_NAME(2)(unsigned long bytes,
+		      unsigned long * __restrict v1,
+		      const unsigned long * __restrict v2)
+{
+	unsigned long lines = bytes / LINE_WIDTH;
+
+	do {
+		__asm__ __volatile__ (
+			LD_INOUT_LINE(v1)
+			LD_AND_XOR_LINE(v2)
+			ST_LINE(v1)
+		: : [v1] "r"(v1), [v2] "r"(v2) : "memory"
+		);
+
+		v1 += LINE_WIDTH / sizeof(unsigned long);
+		v2 += LINE_WIDTH / sizeof(unsigned long);
+	} while (--lines > 0);
+}
+
+void XOR_FUNC_NAME(3)(unsigned long bytes,
+		      unsigned long * __restrict v1,
+		      const unsigned long * __restrict v2,
+		      const unsigned long * __restrict v3)
+{
+	unsigned long lines = bytes / LINE_WIDTH;
+
+	do {
+		__asm__ __volatile__ (
+			LD_INOUT_LINE(v1)
+			LD_AND_XOR_LINE(v2)
+			LD_AND_XOR_LINE(v3)
+			ST_LINE(v1)
+		: : [v1] "r"(v1), [v2] "r"(v2), [v3] "r"(v3) : "memory"
+		);
+
+		v1 += LINE_WIDTH / sizeof(unsigned long);
+		v2 += LINE_WIDTH / sizeof(unsigned long);
+		v3 += LINE_WIDTH / sizeof(unsigned long);
+	} while (--lines > 0);
+}
+
+void XOR_FUNC_NAME(4)(unsigned long bytes,
+		      unsigned long * __restrict v1,
+		      const unsigned long * __restrict v2,
+		      const unsigned long * __restrict v3,
+		      const unsigned long * __restrict v4)
+{
+	unsigned long lines = bytes / LINE_WIDTH;
+
+	do {
+		__asm__ __volatile__ (
+			LD_INOUT_LINE(v1)
+			LD_AND_XOR_LINE(v2)
+			LD_AND_XOR_LINE(v3)
+			LD_AND_XOR_LINE(v4)
+			ST_LINE(v1)
+		: : [v1] "r"(v1), [v2] "r"(v2), [v3] "r"(v3), [v4] "r"(v4)
+		: "memory"
+		);
+
+		v1 += LINE_WIDTH / sizeof(unsigned long);
+		v2 += LINE_WIDTH / sizeof(unsigned long);
+		v3 += LINE_WIDTH / sizeof(unsigned long);
+		v4 += LINE_WIDTH / sizeof(unsigned long);
+	} while (--lines > 0);
+}
+
+void XOR_FUNC_NAME(5)(unsigned long bytes,
+		      unsigned long * __restrict v1,
+		      const unsigned long * __restrict v2,
+		      const unsigned long * __restrict v3,
+		      const unsigned long * __restrict v4,
+		      const unsigned long * __restrict v5)
+{
+	unsigned long lines = bytes / LINE_WIDTH;
+
+	do {
+		__asm__ __volatile__ (
+			LD_INOUT_LINE(v1)
+			LD_AND_XOR_LINE(v2)
+			LD_AND_XOR_LINE(v3)
+			LD_AND_XOR_LINE(v4)
+			LD_AND_XOR_LINE(v5)
+			ST_LINE(v1)
+		: : [v1] "r"(v1), [v2] "r"(v2), [v3] "r"(v3), [v4] "r"(v4),
+		    [v5] "r"(v5) : "memory"
+		);
+
+		v1 += LINE_WIDTH / sizeof(unsigned long);
+		v2 += LINE_WIDTH / sizeof(unsigned long);
+		v3 += LINE_WIDTH / sizeof(unsigned long);
+		v4 += LINE_WIDTH / sizeof(unsigned long);
+		v5 += LINE_WIDTH / sizeof(unsigned long);
+	} while (--lines > 0);
+}
-- 
2.40.0

