Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AC770075
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHDMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjHDMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:46:25 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A446A8;
        Fri,  4 Aug 2023 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1691153176; bh=T5rQ9BO20/3cqL6c0WAUB+h7He7LtLc8XAN9qYPfAFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7cYQeAVS7cPN9MbQo1xCS0Rc7W5H4cYCHTQv/gIs9sDCr2ESMy6EtrZl2qmPILlu
         +26Z5l14/eicGjYQxscC/TsXx+ugdff3u2QvNAUTymdvIzI7jAZ+pfA/282IKYBY8h
         EuwuVcmieX8KnTocOBNShvRDHBFYNjYbJaOB+dr0=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 8F9BF6019D;
        Fri,  4 Aug 2023 20:46:16 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-raid@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v3 2/3] raid6: Add LoongArch SIMD syndrome calculation
Date:   Fri,  4 Aug 2023 20:46:10 +0800
Message-Id: <20230804124611.2051048-3-kernel@xen0n.name>
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

The algorithms work on 64 bytes at a time, which is the L1 cache line
size of all current and future LoongArch cores (that we care about), as
confirmed by Huacai. The code is based on the generic int.uc algorithm,
unrolled 4 times for LSX and 2 times for LASX. Further unrolling does
not meaningfully improve the performance according to experiments.

Performance numbers measured during system boot on a 3A5000 @ 2.5GHz:

> raid6: lasx     gen() 12726 MB/s
> raid6: lsx      gen() 10001 MB/s
> raid6: int64x8  gen()  2876 MB/s
> raid6: int64x4  gen()  3867 MB/s
> raid6: int64x2  gen()  2531 MB/s
> raid6: int64x1  gen()  1945 MB/s

Comparison of xor() speeds (from different boots but meaningful anyway):

> lasx:    11226 MB/s
> lsx:     6395 MB/s
> int64x4: 2147 MB/s

Performance as measured by raid6test:

> raid6: lasx     gen() 25109 MB/s
> raid6: lsx      gen() 13233 MB/s
> raid6: int64x8  gen()  4164 MB/s
> raid6: int64x4  gen()  6005 MB/s
> raid6: int64x2  gen()  5781 MB/s
> raid6: int64x1  gen()  4119 MB/s
> raid6: using algorithm lasx gen() 25109 MB/s
> raid6: .... xor() 14439 MB/s, rmw enabled

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 include/linux/raid/pq.h    |   2 +
 lib/raid6/Makefile         |   1 +
 lib/raid6/algos.c          |   8 +
 lib/raid6/loongarch.h      |  38 ++++
 lib/raid6/loongarch_simd.c | 422 +++++++++++++++++++++++++++++++++++++
 lib/raid6/test/Makefile    |  12 ++
 6 files changed, 483 insertions(+)
 create mode 100644 lib/raid6/loongarch.h
 create mode 100644 lib/raid6/loongarch_simd.c

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index f29aaaf2eb21e..8744474858487 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -108,6 +108,8 @@ extern const struct raid6_calls raid6_vpermxor1;
 extern const struct raid6_calls raid6_vpermxor2;
 extern const struct raid6_calls raid6_vpermxor4;
 extern const struct raid6_calls raid6_vpermxor8;
+extern const struct raid6_calls raid6_lsx;
+extern const struct raid6_calls raid6_lasx;
 
 struct raid6_recov_calls {
 	void (*data2)(int, size_t, int, int, void **);
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 45e17619422b4..2b9ebe1054806 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -9,6 +9,7 @@ raid6_pq-$(CONFIG_ALTIVEC) += altivec1.o altivec2.o altivec4.o altivec8.o \
                               vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
 raid6_pq-$(CONFIG_KERNEL_MODE_NEON) += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
 raid6_pq-$(CONFIG_S390) += s390vx8.o recov_s390xc.o
+raid6_pq-$(CONFIG_LOONGARCH) += loongarch_simd.o
 
 hostprogs	+= mktables
 
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index a22a05c9af8a3..739c7ebcae1a2 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -73,6 +73,14 @@ const struct raid6_calls * const raid6_algos[] = {
 	&raid6_neonx2,
 	&raid6_neonx1,
 #endif
+#ifdef CONFIG_LOONGARCH
+#ifdef CONFIG_CPU_HAS_LASX
+	&raid6_lasx,
+#endif
+#ifdef CONFIG_CPU_HAS_LSX
+	&raid6_lsx,
+#endif
+#endif
 #if defined(__ia64__)
 	&raid6_intx32,
 	&raid6_intx16,
diff --git a/lib/raid6/loongarch.h b/lib/raid6/loongarch.h
new file mode 100644
index 0000000000000..acfc33ce70562
--- /dev/null
+++ b/lib/raid6/loongarch.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 WANG Xuerui <git@xen0n.name>
+ *
+ * raid6/loongarch.h
+ *
+ * Definitions common to LoongArch RAID-6 code only
+ */
+
+#ifndef _LIB_RAID6_LOONGARCH_H
+#define _LIB_RAID6_LOONGARCH_H
+
+#ifdef __KERNEL__
+
+#include <asm/cpu-features.h>
+#include <asm/fpu.h>
+
+#else /* for user-space testing */
+
+#include <sys/auxv.h>
+
+/* have to supply these defines for glibc 2.37- and musl */
+#ifndef HWCAP_LOONGARCH_LSX
+#define HWCAP_LOONGARCH_LSX	(1 << 4)
+#endif
+#ifndef HWCAP_LOONGARCH_LASX
+#define HWCAP_LOONGARCH_LASX	(1 << 5)
+#endif
+
+#define kernel_fpu_begin()
+#define kernel_fpu_end()
+
+#define cpu_has_lsx	(getauxval(AT_HWCAP) & HWCAP_LOONGARCH_LSX)
+#define cpu_has_lasx	(getauxval(AT_HWCAP) & HWCAP_LOONGARCH_LASX)
+
+#endif /* __KERNEL__ */
+
+#endif /* _LIB_RAID6_LOONGARCH_H */
diff --git a/lib/raid6/loongarch_simd.c b/lib/raid6/loongarch_simd.c
new file mode 100644
index 0000000000000..ebb33e5c8f060
--- /dev/null
+++ b/lib/raid6/loongarch_simd.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RAID6 syndrome calculations in LoongArch SIMD (LSX & LASX)
+ *
+ * Copyright 2023 WANG Xuerui <git@xen0n.name>
+ *
+ * Based on the generic RAID-6 code (int.uc):
+ *
+ * Copyright 2002-2004 H. Peter Anvin
+ */
+
+#include <linux/raid/pq.h>
+#include "loongarch.h"
+
+/*
+ * The vector algorithms are currently priority 0, which means the generic
+ * scalar algorithms are not being disabled if vector support is present.
+ * This is like the similar LoongArch RAID5 XOR code, with the main reason
+ * repeated here: it cannot be ruled out at this point of time, that some
+ * future (maybe reduced) models could run the vector algorithms slower than
+ * the scalar ones, maybe for errata or micro-op reasons. It may be
+ * appropriate to revisit this after one or two more uarch generations.
+ */
+
+#ifdef CONFIG_CPU_HAS_LSX
+#define NSIZE 16
+
+static int raid6_has_lsx(void)
+{
+	return cpu_has_lsx;
+}
+
+static void raid6_lsx_gen_syndrome(int disks, size_t bytes, void **ptrs)
+{
+	u8 **dptr = (u8 **)ptrs;
+	u8 *p, *q;
+	int d, z, z0;
+
+	z0 = disks - 3;		/* Highest data disk */
+	p = dptr[z0+1];		/* XOR parity */
+	q = dptr[z0+2];		/* RS syndrome */
+
+	kernel_fpu_begin();
+
+	/*
+	 * $vr0, $vr1, $vr2, $vr3: wp
+	 * $vr4, $vr5, $vr6, $vr7: wq
+	 * $vr8, $vr9, $vr10, $vr11: wd
+	 * $vr12, $vr13, $vr14, $vr15: w2
+	 * $vr16, $vr17, $vr18, $vr19: w1
+	 */
+	for ( d = 0 ; d < bytes ; d += NSIZE*4 ) {
+		/* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
+		asm volatile("vld $vr0, %0" : : "m"(dptr[z0][d+0*NSIZE]));
+		asm volatile("vld $vr1, %0" : : "m"(dptr[z0][d+1*NSIZE]));
+		asm volatile("vld $vr2, %0" : : "m"(dptr[z0][d+2*NSIZE]));
+		asm volatile("vld $vr3, %0" : : "m"(dptr[z0][d+3*NSIZE]));
+		asm volatile("vori.b $vr4, $vr0, 0");
+		asm volatile("vori.b $vr5, $vr1, 0");
+		asm volatile("vori.b $vr6, $vr2, 0");
+		asm volatile("vori.b $vr7, $vr3, 0");
+		for ( z = z0-1 ; z >= 0 ; z-- ) {
+			/* wd$$ = *(unative_t *)&dptr[z][d+$$*NSIZE]; */
+			asm volatile("vld $vr8, %0" : : "m"(dptr[z][d+0*NSIZE]));
+			asm volatile("vld $vr9, %0" : : "m"(dptr[z][d+1*NSIZE]));
+			asm volatile("vld $vr10, %0" : : "m"(dptr[z][d+2*NSIZE]));
+			asm volatile("vld $vr11, %0" : : "m"(dptr[z][d+3*NSIZE]));
+			/* wp$$ ^= wd$$; */
+			asm volatile("vxor.v $vr0, $vr0, $vr8");
+			asm volatile("vxor.v $vr1, $vr1, $vr9");
+			asm volatile("vxor.v $vr2, $vr2, $vr10");
+			asm volatile("vxor.v $vr3, $vr3, $vr11");
+			/* w2$$ = MASK(wq$$); */
+			asm volatile("vslti.b $vr12, $vr4, 0");
+			asm volatile("vslti.b $vr13, $vr5, 0");
+			asm volatile("vslti.b $vr14, $vr6, 0");
+			asm volatile("vslti.b $vr15, $vr7, 0");
+			/* w1$$ = SHLBYTE(wq$$); */
+			asm volatile("vslli.b $vr16, $vr4, 1");
+			asm volatile("vslli.b $vr17, $vr5, 1");
+			asm volatile("vslli.b $vr18, $vr6, 1");
+			asm volatile("vslli.b $vr19, $vr7, 1");
+			/* w2$$ &= NBYTES(0x1d); */
+			asm volatile("vandi.b $vr12, $vr12, 0x1d");
+			asm volatile("vandi.b $vr13, $vr13, 0x1d");
+			asm volatile("vandi.b $vr14, $vr14, 0x1d");
+			asm volatile("vandi.b $vr15, $vr15, 0x1d");
+			/* w1$$ ^= w2$$; */
+			asm volatile("vxor.v $vr16, $vr16, $vr12");
+			asm volatile("vxor.v $vr17, $vr17, $vr13");
+			asm volatile("vxor.v $vr18, $vr18, $vr14");
+			asm volatile("vxor.v $vr19, $vr19, $vr15");
+			/* wq$$ = w1$$ ^ wd$$; */
+			asm volatile("vxor.v $vr4, $vr16, $vr8");
+			asm volatile("vxor.v $vr5, $vr17, $vr9");
+			asm volatile("vxor.v $vr6, $vr18, $vr10");
+			asm volatile("vxor.v $vr7, $vr19, $vr11");
+		}
+		/* *(unative_t *)&p[d+NSIZE*$$] = wp$$; */
+		asm volatile("vst $vr0, %0" : "=m"(p[d+NSIZE*0]));
+		asm volatile("vst $vr1, %0" : "=m"(p[d+NSIZE*1]));
+		asm volatile("vst $vr2, %0" : "=m"(p[d+NSIZE*2]));
+		asm volatile("vst $vr3, %0" : "=m"(p[d+NSIZE*3]));
+		/* *(unative_t *)&q[d+NSIZE*$$] = wq$$; */
+		asm volatile("vst $vr4, %0" : "=m"(q[d+NSIZE*0]));
+		asm volatile("vst $vr5, %0" : "=m"(q[d+NSIZE*1]));
+		asm volatile("vst $vr6, %0" : "=m"(q[d+NSIZE*2]));
+		asm volatile("vst $vr7, %0" : "=m"(q[d+NSIZE*3]));
+	}
+
+	kernel_fpu_end();
+}
+
+static void raid6_lsx_xor_syndrome(int disks, int start, int stop,
+				   size_t bytes, void **ptrs)
+{
+	u8 **dptr = (u8 **)ptrs;
+	u8 *p, *q;
+	int d, z, z0;
+
+	z0 = stop;		/* P/Q right side optimization */
+	p = dptr[disks-2];	/* XOR parity */
+	q = dptr[disks-1];	/* RS syndrome */
+
+	kernel_fpu_begin();
+
+	/*
+	 * $vr0, $vr1, $vr2, $vr3: wp
+	 * $vr4, $vr5, $vr6, $vr7: wq
+	 * $vr8, $vr9, $vr10, $vr11: wd
+	 * $vr12, $vr13, $vr14, $vr15: w2
+	 * $vr16, $vr17, $vr18, $vr19: w1
+	 */
+	for ( d = 0 ; d < bytes ; d += NSIZE*4 ) {
+		/* P/Q data pages */
+		/* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
+		asm volatile("vld $vr0, %0" : : "m"(dptr[z0][d+0*NSIZE]));
+		asm volatile("vld $vr1, %0" : : "m"(dptr[z0][d+1*NSIZE]));
+		asm volatile("vld $vr2, %0" : : "m"(dptr[z0][d+2*NSIZE]));
+		asm volatile("vld $vr3, %0" : : "m"(dptr[z0][d+3*NSIZE]));
+		asm volatile("vori.b $vr4, $vr0, 0");
+		asm volatile("vori.b $vr5, $vr1, 0");
+		asm volatile("vori.b $vr6, $vr2, 0");
+		asm volatile("vori.b $vr7, $vr3, 0");
+		for ( z = z0-1 ; z >= start ; z-- ) {
+			/* wd$$ = *(unative_t *)&dptr[z][d+$$*NSIZE]; */
+			asm volatile("vld $vr8, %0" : : "m"(dptr[z][d+0*NSIZE]));
+			asm volatile("vld $vr9, %0" : : "m"(dptr[z][d+1*NSIZE]));
+			asm volatile("vld $vr10, %0" : : "m"(dptr[z][d+2*NSIZE]));
+			asm volatile("vld $vr11, %0" : : "m"(dptr[z][d+3*NSIZE]));
+			/* wp$$ ^= wd$$; */
+			asm volatile("vxor.v $vr0, $vr0, $vr8");
+			asm volatile("vxor.v $vr1, $vr1, $vr9");
+			asm volatile("vxor.v $vr2, $vr2, $vr10");
+			asm volatile("vxor.v $vr3, $vr3, $vr11");
+			/* w2$$ = MASK(wq$$); */
+			asm volatile("vslti.b $vr12, $vr4, 0");
+			asm volatile("vslti.b $vr13, $vr5, 0");
+			asm volatile("vslti.b $vr14, $vr6, 0");
+			asm volatile("vslti.b $vr15, $vr7, 0");
+			/* w1$$ = SHLBYTE(wq$$); */
+			asm volatile("vslli.b $vr16, $vr4, 1");
+			asm volatile("vslli.b $vr17, $vr5, 1");
+			asm volatile("vslli.b $vr18, $vr6, 1");
+			asm volatile("vslli.b $vr19, $vr7, 1");
+			/* w2$$ &= NBYTES(0x1d); */
+			asm volatile("vandi.b $vr12, $vr12, 0x1d");
+			asm volatile("vandi.b $vr13, $vr13, 0x1d");
+			asm volatile("vandi.b $vr14, $vr14, 0x1d");
+			asm volatile("vandi.b $vr15, $vr15, 0x1d");
+			/* w1$$ ^= w2$$; */
+			asm volatile("vxor.v $vr16, $vr16, $vr12");
+			asm volatile("vxor.v $vr17, $vr17, $vr13");
+			asm volatile("vxor.v $vr18, $vr18, $vr14");
+			asm volatile("vxor.v $vr19, $vr19, $vr15");
+			/* wq$$ = w1$$ ^ wd$$; */
+			asm volatile("vxor.v $vr4, $vr16, $vr8");
+			asm volatile("vxor.v $vr5, $vr17, $vr9");
+			asm volatile("vxor.v $vr6, $vr18, $vr10");
+			asm volatile("vxor.v $vr7, $vr19, $vr11");
+		}
+
+		/* P/Q left side optimization */
+		for ( z = start-1 ; z >= 0 ; z-- ) {
+			/* w2$$ = MASK(wq$$); */
+			asm volatile("vslti.b $vr12, $vr4, 0");
+			asm volatile("vslti.b $vr13, $vr5, 0");
+			asm volatile("vslti.b $vr14, $vr6, 0");
+			asm volatile("vslti.b $vr15, $vr7, 0");
+			/* w1$$ = SHLBYTE(wq$$); */
+			asm volatile("vslli.b $vr16, $vr4, 1");
+			asm volatile("vslli.b $vr17, $vr5, 1");
+			asm volatile("vslli.b $vr18, $vr6, 1");
+			asm volatile("vslli.b $vr19, $vr7, 1");
+			/* w2$$ &= NBYTES(0x1d); */
+			asm volatile("vandi.b $vr12, $vr12, 0x1d");
+			asm volatile("vandi.b $vr13, $vr13, 0x1d");
+			asm volatile("vandi.b $vr14, $vr14, 0x1d");
+			asm volatile("vandi.b $vr15, $vr15, 0x1d");
+			/* wq$$ = w1$$ ^ w2$$; */
+			asm volatile("vxor.v $vr4, $vr16, $vr12");
+			asm volatile("vxor.v $vr5, $vr17, $vr13");
+			asm volatile("vxor.v $vr6, $vr18, $vr14");
+			asm volatile("vxor.v $vr7, $vr19, $vr15");
+		}
+		/*
+		 * *(unative_t *)&p[d+NSIZE*$$] ^= wp$$;
+		 * *(unative_t *)&q[d+NSIZE*$$] ^= wq$$;
+		 */
+		asm volatile(
+			"vld $vr20, %0\n\t"
+			"vld $vr21, %1\n\t"
+			"vld $vr22, %2\n\t"
+			"vld $vr23, %3\n\t"
+			"vld $vr24, %4\n\t"
+			"vld $vr25, %5\n\t"
+			"vld $vr26, %6\n\t"
+			"vld $vr27, %7\n\t"
+			"vxor.v $vr20, $vr20, $vr0\n\t"
+			"vxor.v $vr21, $vr21, $vr1\n\t"
+			"vxor.v $vr22, $vr22, $vr2\n\t"
+			"vxor.v $vr23, $vr23, $vr3\n\t"
+			"vxor.v $vr24, $vr24, $vr4\n\t"
+			"vxor.v $vr25, $vr25, $vr5\n\t"
+			"vxor.v $vr26, $vr26, $vr6\n\t"
+			"vxor.v $vr27, $vr27, $vr7\n\t"
+			"vst $vr20, %0\n\t"
+			"vst $vr21, %1\n\t"
+			"vst $vr22, %2\n\t"
+			"vst $vr23, %3\n\t"
+			"vst $vr24, %4\n\t"
+			"vst $vr25, %5\n\t"
+			"vst $vr26, %6\n\t"
+			"vst $vr27, %7\n\t"
+			: "+m"(p[d+NSIZE*0]), "+m"(p[d+NSIZE*1]),
+			  "+m"(p[d+NSIZE*2]), "+m"(p[d+NSIZE*3]),
+			  "+m"(q[d+NSIZE*0]), "+m"(q[d+NSIZE*1]),
+			  "+m"(q[d+NSIZE*2]), "+m"(q[d+NSIZE*3])
+		);
+	}
+
+	kernel_fpu_end();
+}
+
+const struct raid6_calls raid6_lsx = {
+	raid6_lsx_gen_syndrome,
+	raid6_lsx_xor_syndrome,
+	raid6_has_lsx,
+	"lsx",
+	.priority = 0 /* see the comment near the top of the file for reason */
+};
+
+#undef NSIZE
+#endif /* CONFIG_CPU_HAS_LSX */
+
+#ifdef CONFIG_CPU_HAS_LASX
+#define NSIZE 32
+
+static int raid6_has_lasx(void)
+{
+	return cpu_has_lasx;
+}
+
+static void raid6_lasx_gen_syndrome(int disks, size_t bytes, void **ptrs)
+{
+	u8 **dptr = (u8 **)ptrs;
+	u8 *p, *q;
+	int d, z, z0;
+
+	z0 = disks - 3;		/* Highest data disk */
+	p = dptr[z0+1];		/* XOR parity */
+	q = dptr[z0+2];		/* RS syndrome */
+
+	kernel_fpu_begin();
+
+	/*
+	 * $xr0, $xr1: wp
+	 * $xr2, $xr3: wq
+	 * $xr4, $xr5: wd
+	 * $xr6, $xr7: w2
+	 * $xr8, $xr9: w1
+	 */
+	for ( d = 0 ; d < bytes ; d += NSIZE*2 ) {
+		/* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
+		asm volatile("xvld $xr0, %0" : : "m"(dptr[z0][d+0*NSIZE]));
+		asm volatile("xvld $xr1, %0" : : "m"(dptr[z0][d+1*NSIZE]));
+		asm volatile("xvori.b $xr2, $xr0, 0");
+		asm volatile("xvori.b $xr3, $xr1, 0");
+		for ( z = z0-1 ; z >= 0 ; z-- ) {
+			/* wd$$ = *(unative_t *)&dptr[z][d+$$*NSIZE]; */
+			asm volatile("xvld $xr4, %0" : : "m"(dptr[z][d+0*NSIZE]));
+			asm volatile("xvld $xr5, %0" : : "m"(dptr[z][d+1*NSIZE]));
+			/* wp$$ ^= wd$$; */
+			asm volatile("xvxor.v $xr0, $xr0, $xr4");
+			asm volatile("xvxor.v $xr1, $xr1, $xr5");
+			/* w2$$ = MASK(wq$$); */
+			asm volatile("xvslti.b $xr6, $xr2, 0");
+			asm volatile("xvslti.b $xr7, $xr3, 0");
+			/* w1$$ = SHLBYTE(wq$$); */
+			asm volatile("xvslli.b $xr8, $xr2, 1");
+			asm volatile("xvslli.b $xr9, $xr3, 1");
+			/* w2$$ &= NBYTES(0x1d); */
+			asm volatile("xvandi.b $xr6, $xr6, 0x1d");
+			asm volatile("xvandi.b $xr7, $xr7, 0x1d");
+			/* w1$$ ^= w2$$; */
+			asm volatile("xvxor.v $xr8, $xr8, $xr6");
+			asm volatile("xvxor.v $xr9, $xr9, $xr7");
+			/* wq$$ = w1$$ ^ wd$$; */
+			asm volatile("xvxor.v $xr2, $xr8, $xr4");
+			asm volatile("xvxor.v $xr3, $xr9, $xr5");
+		}
+		/* *(unative_t *)&p[d+NSIZE*$$] = wp$$; */
+		asm volatile("xvst $xr0, %0" : "=m"(p[d+NSIZE*0]));
+		asm volatile("xvst $xr1, %0" : "=m"(p[d+NSIZE*1]));
+		/* *(unative_t *)&q[d+NSIZE*$$] = wq$$; */
+		asm volatile("xvst $xr2, %0" : "=m"(q[d+NSIZE*0]));
+		asm volatile("xvst $xr3, %0" : "=m"(q[d+NSIZE*1]));
+	}
+
+	kernel_fpu_end();
+}
+
+static void raid6_lasx_xor_syndrome(int disks, int start, int stop,
+				    size_t bytes, void **ptrs)
+{
+	u8 **dptr = (u8 **)ptrs;
+	u8 *p, *q;
+	int d, z, z0;
+
+	z0 = stop;		/* P/Q right side optimization */
+	p = dptr[disks-2];	/* XOR parity */
+	q = dptr[disks-1];	/* RS syndrome */
+
+	kernel_fpu_begin();
+
+	/*
+	 * $xr0, $xr1: wp
+	 * $xr2, $xr3: wq
+	 * $xr4, $xr5: wd
+	 * $xr6, $xr7: w2
+	 * $xr8, $xr9: w1
+	 */
+	for ( d = 0 ; d < bytes ; d += NSIZE*2 ) {
+		/* P/Q data pages */
+		/* wq$$ = wp$$ = *(unative_t *)&dptr[z0][d+$$*NSIZE]; */
+		asm volatile("xvld $xr0, %0" : : "m"(dptr[z0][d+0*NSIZE]));
+		asm volatile("xvld $xr1, %0" : : "m"(dptr[z0][d+1*NSIZE]));
+		asm volatile("xvori.b $xr2, $xr0, 0");
+		asm volatile("xvori.b $xr3, $xr1, 0");
+		for ( z = z0-1 ; z >= start ; z-- ) {
+			/* wd$$ = *(unative_t *)&dptr[z][d+$$*NSIZE]; */
+			asm volatile("xvld $xr4, %0" : : "m"(dptr[z][d+0*NSIZE]));
+			asm volatile("xvld $xr5, %0" : : "m"(dptr[z][d+1*NSIZE]));
+			/* wp$$ ^= wd$$; */
+			asm volatile("xvxor.v $xr0, $xr0, $xr4");
+			asm volatile("xvxor.v $xr1, $xr1, $xr5");
+			/* w2$$ = MASK(wq$$); */
+			asm volatile("xvslti.b $xr6, $xr2, 0");
+			asm volatile("xvslti.b $xr7, $xr3, 0");
+			/* w1$$ = SHLBYTE(wq$$); */
+			asm volatile("xvslli.b $xr8, $xr2, 1");
+			asm volatile("xvslli.b $xr9, $xr3, 1");
+			/* w2$$ &= NBYTES(0x1d); */
+			asm volatile("xvandi.b $xr6, $xr6, 0x1d");
+			asm volatile("xvandi.b $xr7, $xr7, 0x1d");
+			/* w1$$ ^= w2$$; */
+			asm volatile("xvxor.v $xr8, $xr8, $xr6");
+			asm volatile("xvxor.v $xr9, $xr9, $xr7");
+			/* wq$$ = w1$$ ^ wd$$; */
+			asm volatile("xvxor.v $xr2, $xr8, $xr4");
+			asm volatile("xvxor.v $xr3, $xr9, $xr5");
+		}
+
+		/* P/Q left side optimization */
+		for ( z = start-1 ; z >= 0 ; z-- ) {
+			/* w2$$ = MASK(wq$$); */
+			asm volatile("xvslti.b $xr6, $xr2, 0");
+			asm volatile("xvslti.b $xr7, $xr3, 0");
+			/* w1$$ = SHLBYTE(wq$$); */
+			asm volatile("xvslli.b $xr8, $xr2, 1");
+			asm volatile("xvslli.b $xr9, $xr3, 1");
+			/* w2$$ &= NBYTES(0x1d); */
+			asm volatile("xvandi.b $xr6, $xr6, 0x1d");
+			asm volatile("xvandi.b $xr7, $xr7, 0x1d");
+			/* wq$$ = w1$$ ^ w2$$; */
+			asm volatile("xvxor.v $xr2, $xr8, $xr6");
+			asm volatile("xvxor.v $xr3, $xr9, $xr7");
+		}
+		/*
+		 * *(unative_t *)&p[d+NSIZE*$$] ^= wp$$;
+		 * *(unative_t *)&q[d+NSIZE*$$] ^= wq$$;
+		 */
+		asm volatile(
+			"xvld $xr10, %0\n\t"
+			"xvld $xr11, %1\n\t"
+			"xvld $xr12, %2\n\t"
+			"xvld $xr13, %3\n\t"
+			"xvxor.v $xr10, $xr10, $xr0\n\t"
+			"xvxor.v $xr11, $xr11, $xr1\n\t"
+			"xvxor.v $xr12, $xr12, $xr2\n\t"
+			"xvxor.v $xr13, $xr13, $xr3\n\t"
+			"xvst $xr10, %0\n\t"
+			"xvst $xr11, %1\n\t"
+			"xvst $xr12, %2\n\t"
+			"xvst $xr13, %3\n\t"
+			: "+m"(p[d+NSIZE*0]), "+m"(p[d+NSIZE*1]),
+			  "+m"(q[d+NSIZE*0]), "+m"(q[d+NSIZE*1])
+		);
+	}
+
+	kernel_fpu_end();
+}
+
+const struct raid6_calls raid6_lasx = {
+	raid6_lasx_gen_syndrome,
+	raid6_lasx_xor_syndrome,
+	raid6_has_lasx,
+	"lasx",
+	.priority = 0 /* see the comment near the top of the file for reason */
+};
+#undef NSIZE
+#endif /* CONFIG_CPU_HAS_LASX */
diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 1f693ea3b980c..7b244bce32b3d 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -41,6 +41,16 @@ ifeq ($(findstring ppc,$(ARCH)),ppc)
                          gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
 endif
 
+ifeq ($(ARCH),loongarch64)
+        CFLAGS += -I../../../arch/loongarch/include -DCONFIG_LOONGARCH=1
+        CFLAGS += $(shell echo 'vld $$vr0, $$zero, 0' |         \
+                    gcc -c -x assembler - >/dev/null 2>&1 &&    \
+                    rm ./-.o && echo -DCONFIG_CPU_HAS_LSX=1)
+        CFLAGS += $(shell echo 'xvld $$xr0, $$zero, 0' |        \
+                    gcc -c -x assembler - >/dev/null 2>&1 &&    \
+                    rm ./-.o && echo -DCONFIG_CPU_HAS_LASX=1)
+endif
+
 ifeq ($(IS_X86),yes)
         OBJS   += mmx.o sse1.o sse2.o avx2.o recov_ssse3.o recov_avx2.o avx512.o recov_avx512.o
         CFLAGS += -DCONFIG_X86
@@ -54,6 +64,8 @@ else ifeq ($(HAS_ALTIVEC),yes)
         CFLAGS += -DCONFIG_ALTIVEC
         OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
                 vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
+else ifeq ($(ARCH),loongarch64)
+        OBJS += loongarch_simd.o
 endif
 
 .c.o:
-- 
2.40.0

