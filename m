Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48749789ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjH0B1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjH0B0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:26:53 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE81B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:50 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5733789a44cso1439289eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693099610; x=1693704410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExZs/Ozc5l4bbPGNHrfkcofcGWcAaQ7sfcQyuY4JEts=;
        b=mENLkbVNQcciD80loVn0MQJWYsOKvy3JwwwlPSEIvInRWvoIsBRPy7a/ERxr32CN41
         dE5XWQgAbSdsVxrMaGxqmyHw5iKPyNf7QfCKohtIu3BMNW/3iH6Fd3s4o2sOGS5w+IrI
         73aSoP63Wf02tG9CDg3Mj/0a6z3vsLsuqrXz9AgfxBL3gRNfRgfeBybbtlyXJO+NIYW5
         Gf+GHn+aM6hDzQV0QNd+pflAy8kGBGDq3Vfu6SH+nRY58BZxl4xbFEGA3SRSVpm6yweq
         j4lbOvWCf1ReWiljEiMGnJ2stpC9FJYC9V60H5Fcc5vZiPvXSWYjRLZu1Qo49er9FCsP
         cS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099610; x=1693704410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExZs/Ozc5l4bbPGNHrfkcofcGWcAaQ7sfcQyuY4JEts=;
        b=Ntu4PwZQOAbuHY1xObegdv05wT8WEskHqCuLZ+0bLgYtXz/+2pFcFrbwGImrrZbSFm
         h8NkbX5jEQIopNCxP99G7Qz71bKWkkYojaCZYXsKqFxpm9oXabksEqysjaskkW+hGFY6
         YIYcMbHmwbbhcJzYoFrsT2bYFwv/gAa04KaefVKiMj6jLUarE62mj0e5HjJTsFHrQ4Vr
         QKOuPmPd39qjCvGKt++vtAwPqVJk1rSZgDRERKlNhctRbzTLhnqRvH/5PRz403upO5DK
         fKawugzUAmAWZuOAbpfvFxbkJzOVP4DGD9LTSRJgpXJdImU+ZlxBkjgoga36TTYPZpwe
         Ws9g==
X-Gm-Message-State: AOJu0YzPUO1as9JXPXc0yygMERKmY5LfpRyJh7cRszzhWFwRAUYHFVEW
        rwhT4C+9iEmbWqjgMRs3kNIP8Q==
X-Google-Smtp-Source: AGHT+IEGHUp91K/R5AJzws7m5jTW/0V4MOrwdiKfnAZq2vc5gFCk+yTLxuLR2FbxrnzWKQCy61yFdQ==
X-Received: by 2002:a05:6358:281d:b0:135:ae78:56c9 with SMTP id k29-20020a056358281d00b00135ae7856c9mr24257121rwb.6.1693099610119;
        Sat, 26 Aug 2023 18:26:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b869410ed2sm4357404plb.72.2023.08.26.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:26:49 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Sat, 26 Aug 2023 18:26:08 -0700
Subject: [PATCH 3/5] riscv: Vector checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230826-optimize_checksum-v1-3-937501b4522a@rivosinc.com>
References: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
In-Reply-To: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not ready for merge as vector support in the kernel is
limited. However, the code has been tested in QEMU so the algorithms
do work. It is written in assembly rather than using the GCC vector
instrinsics because they did not provide optimal code.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 81 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index af49b3409576..7e31c0ad6346 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -10,6 +10,10 @@
 #include <linux/in6.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_RISCV_ISA_V
+#include <riscv_vector.h>
+#endif
+
 /* Default version is sufficient for 32 bit */
 #ifdef CONFIG_64BIT
 #define _HAVE_ARCH_IPV6_CSUM
@@ -36,6 +40,46 @@ static inline __sum16 csum_fold(__wsum sum)
  *	without the bitmanip extensions zba/zbb.
  */
 #ifdef CONFIG_32BIT
+#ifdef CONFIG_RISCV_ISA_V
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int vl;
+	unsigned int high_result;
+	unsigned int low_result;
+
+	asm("vsetivli x0, 1, e64, ta, ma				\n\t\
+	vmv.v.i %[prev_buffer], 0					\n\t\
+	1:								\n\t\
+	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\t\
+	vle32.v %[curr_buffer], (%[iph])				\n\t\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\t\
+	sub %[ihl], %[ihl], %[vl]					\n\t"
+#ifdef CONFIG_RISCV_ISA_ZBA
+	"sh2add %[iph], %[vl], %[iph]					\n\t"
+#else
+	"slli %[vl], %[vl], 2						\n\
+	add %[iph], %[vl], %[iph]					\n\t"
+#endif
+	"bnez %[ihl], 1b						\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.x.s %[low_result], %[prev_buffer]				\n\
+	addi %[vl], x0, 32						\n\
+	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
+	vmv.x.s %[high_result], %[prev_buffer]"
+	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+		[curr_buffer] "=&vd" (curr_buffer),
+		[high_result] "=&r" (high_result),
+		[low_result] "=&r" (low_result)
+	: [iph] "r" (iph), [ihl] "r" (ihl));
+
+	high_result += low_result;
+	high_result += high_result < low_result;
+	return csum_fold((__force __wsum)(high_result));
+}
+
+#else
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	__wsum csum = 0;
@@ -47,8 +91,44 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	} while (++pos < ihl);
 	return csum_fold(csum);
 }
+#endif
+#else
+
+#ifdef CONFIG_RISCV_ISA_V
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned long vl;
+	unsigned long result;
+
+	asm("vsetivli x0, 1, e64, ta, ma				\n\
+	vmv.v.i %[prev_buffer], 0					\n\
+	1:								\n\
+	# Setup 32-bit sum of iph					\n\
+	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
+	vle32.v %[curr_buffer], (%[iph])				\n\
+	# Sum each 32-bit segment of iph that can fit into a vector reg	\n\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]     \n\
+	subw %[ihl], %[ihl], %[vl]					\n\t"
+#ifdef CONFIG_RISCV_ISA_ZBA
+	"sh2add %[iph], %[vl], %[iph]					\n\t"
 #else
+	"slli %[vl], %[vl], 2						\n\
+	addw %[iph], %[vl], %[iph]					\n\t"
+#endif
+	"# If not all of iph could fit into vector reg, do another sum	\n\
+	bnez %[ihl], 1b							\n\
+	vsetvli x0, x0, e64, m1, ta, ma					\n\
+	vmv.x.s %[result], %[prev_buffer]"
+	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
+		[curr_buffer] "=&vd" (curr_buffer), [result] "=&r" (result)
+	: [iph] "r" (iph), [ihl] "r" (ihl));
 
+	result += (result >> 32) | (result << 32);
+	return csum_fold((__force __wsum)(result >> 32));
+}
+#else
 /*
  * Quickly compute an IP checksum with the assumption that IPv4 headers will
  * always be in multiples of 32-bits, and have an ihl of at least 5.
@@ -74,6 +154,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return csum_fold((__force __wsum)(csum >> 32));
 }
 #endif
+#endif
 #define ip_fast_csum ip_fast_csum
 
 extern unsigned int do_csum(const unsigned char *buff, int len);

-- 
2.41.0

