Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECC798177
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjIHFO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbjIHFOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:14:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913AD1997
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 22:14:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0d5b16aacso14448995ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694150057; x=1694754857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pvs8l9RK0fQwoI+7Ki0PLvMGd9Mkcx5Y5fApERW7gwU=;
        b=afjhdzR/m27KWyrjoZvsSKFub6sydCOGlpDmzZy0sPR8J00h/Js+FGDC5ZJnu0q+MV
         1QZ0Ex03F7DA+txPSBiy08LY2Ligo0jy/u7OD+CiXSX9rm88oUxaqZJNaGkZPgyDNWW7
         BVrJfV4fJXvbmP4YdM9qDGNFgo4acYRF/mE72dYPG6gR7199NDX+vD7VYlEs4K/BNq3b
         4+JD8JhjT7mnQiLHF3AXRssgFyuEeXBgiyLhLP750O4WoHCem1/D6Pc54PBNKbK+swhs
         HFxL0ep1kxzXXepuRHDbehSPmtaHf7Hg271aTydAufvIzHVYKwVJLM8mpPoZvI51Mxeb
         TRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150057; x=1694754857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pvs8l9RK0fQwoI+7Ki0PLvMGd9Mkcx5Y5fApERW7gwU=;
        b=HznT4EFwApgZU/xodFfsIkCZAR5mz1WJ1mNO+uOONS1J5Ihx7Ch5sF1NAN11ELWhbk
         yrIkZsPiGliJATBNnEOINQwlyryFjDUAgvK8Rql22dWMfViEGiK+581LmhAqgPhdS85i
         G5mVbiXosS6im0iiGIbJbt3raZEHb9ECK50SFnwrs24+vOIG91Xx+qK8fK0tYhJ0UtFy
         7iGDCxR4QX2LOii+Gj+zMvPYkK7T8rJ+uXcsiTKGrx1Dpi51q6znghYiB/3V8nGgsVnU
         M7+cunfXEbje9zufHVjfSaW1kAZs0nUdjMnf3x+RtjtX9TH341tCHC2okHe1q03HYC41
         1PIQ==
X-Gm-Message-State: AOJu0Yzn4/7tDiNHYnCIr1yfJR93YnbBIxKkvrHlTN8dWXs1bAzabHJ0
        W/DpJw/erDsNfbtS4tJGE3MQvw==
X-Google-Smtp-Source: AGHT+IEryITA+jfdj3i4DnAj5hLTyBY50lsxZEucouJCy7fcMazRmJVQHKVqBg6AUzYAlwJMRidfdw==
X-Received: by 2002:a17:902:8698:b0:1c3:49cc:4ff3 with SMTP id g24-20020a170902869800b001c349cc4ff3mr1166468plo.35.1694150057023;
        Thu, 07 Sep 2023 22:14:17 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001a5fccab02dsm616482plt.177.2023.09.07.22.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:14:16 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 07 Sep 2023 22:14:05 -0700
Subject: [PATCH v3 2/5] riscv: Add checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-optimize_checksum-v3-2-c502d34d9d73@rivosinc.com>
References: <20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com>
In-Reply-To: <20230907-optimize_checksum-v3-0-c502d34d9d73@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
will load from the buffer in groups of 32 bits, and when compiled for
64-bit will load in groups of 64 bits. Benchmarking by proxy compiling
csum_ipv6_magic (64-bit version) for an x86 chip as well as running
the riscv generated code in QEMU, discovered that summing in a
tree-like structure is about 4% faster than doing 64-bit reads.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h |  11 ++
 arch/riscv/lib/Makefile           |   1 +
 arch/riscv/lib/csum.c             | 209 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index bddfc571f93f..ced276dcd6be 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -16,6 +16,14 @@ typedef unsigned int csum_t;
 typedef unsigned long csum_t;
 #endif
 
+/* Default version is sufficient for 32 bit */
+#ifdef CONFIG_64BIT
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+#endif
+
 /*
  *	Fold a partial checksum without adding pseudo headers
  */
@@ -89,6 +97,9 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 
 #define ip_fast_csum ip_fast_csum
 
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+
 #include <asm-generic/checksum.h>
 
 #endif // __ASM_RISCV_CHECKSUM_H
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 26cb2502ecf8..2aa1a4ad361f 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -6,6 +6,7 @@ lib-y			+= memmove.o
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
+lib-y			+= csum.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
new file mode 100644
index 000000000000..1402da888bb4
--- /dev/null
+++ b/arch/riscv/lib/csum.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IP checksum library
+ *
+ * Influenced by arch/arm64/lib/csum.c
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kernel.h>
+
+#include <net/checksum.h>
+
+/* Default version is sufficient for 32 bit */
+#ifndef CONFIG_32BIT
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum csum)
+{
+	/*
+	 * Inform the compiler/processor that the operation we are performing is
+	 * "Commutative and Associative" by summing parts of the checksum in a
+	 * tree-like structure (Section 2(A) of "Computing the Internet
+	 * Checksum"). Furthermore, defer the overflow until the end of the
+	 * computation which is shown to be valid in Section 2(C)(1) of the
+	 * same handbook.
+	 */
+	unsigned long sum, sum1, sum2, sum3, sum4, ulen, uproto;
+
+	uproto = htonl(proto);
+	ulen = htonl(len);
+
+	sum   = saddr->s6_addr32[0];
+	sum  += saddr->s6_addr32[1];
+	sum1  = saddr->s6_addr32[2];
+	sum1 += saddr->s6_addr32[3];
+
+	sum2  = daddr->s6_addr32[0];
+	sum2 += daddr->s6_addr32[1];
+	sum3  = daddr->s6_addr32[2];
+	sum3 += daddr->s6_addr32[3];
+
+	sum4  = csum;
+	sum4 += ulen;
+	sum4 += uproto;
+
+	sum  += sum1;
+	sum2 += sum3;
+
+	sum += sum2;
+	sum += sum4;
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		csum_t fold_temp;
+
+		/*
+		 * Zbb is likely available when the kernel is compiled with Zbb
+		 * support, so nop when Zbb is available and jump when Zbb is
+		 * not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+				  :
+				  :
+				  :
+				  : no_zbb);
+		asm(".option push					\n\
+		.option arch,+zbb					\n\
+			rori	%[fold_temp], %[sum], 32		\n\
+			add	%[sum], %[fold_temp], %[sum]		\n\
+			srli	%[sum], %[sum], 32			\n\
+			roriw	%[fold_temp], %[sum], 16		\n\
+			addw	%[sum], %[fold_temp], %[sum]		\n\
+		.option pop"
+		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
+		return (__force __sum16)~(sum >> 16);
+	}
+no_zbb:
+	sum += (sum >> 32) | (sum << 32);
+	sum >>= 32;
+	return csum_fold((__force __wsum)sum);
+}
+EXPORT_SYMBOL(csum_ipv6_magic);
+#endif // !CONFIG_32BIT
+
+#ifdef CONFIG_32BIT
+#define OFFSET_MASK 3
+#elif CONFIG_64BIT
+#define OFFSET_MASK 7
+#endif
+
+/*
+ * Perform a checksum on an arbitrary memory address.
+ * Algorithm accounts for buff being misaligned.
+ * If buff is not aligned, will over-read bytes but not use the bytes that it
+ * shouldn't. The same thing will occur on the tail-end of the read.
+ */
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
+{
+	unsigned int offset, shift;
+	csum_t csum, data;
+	const csum_t *ptr;
+
+	if (unlikely(len <= 0))
+		return 0;
+	/*
+	 * To align the address, grab the whole first byte in buff.
+	 * Since it is inside of a same byte, it will never cross pages or cache
+	 * lines.
+	 * Directly call KASAN with the alignment we will be using.
+	 */
+	offset = (csum_t)buff & OFFSET_MASK;
+	kasan_check_read(buff, len);
+	ptr = (const csum_t *)(buff - offset);
+	len = len + offset - sizeof(csum_t);
+
+	/*
+	 * Clear the most signifant bits that were over-read if buff was not
+	 * aligned.
+	 */
+	shift = offset * 8;
+	data = *ptr;
+#ifdef __LITTLE_ENDIAN
+	data = (data >> shift) << shift;
+#else
+	data = (data << shift) >> shift;
+#endif
+	/*
+	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
+	 * faster than doing 32-bit reads on architectures that support larger
+	 * reads.
+	 */
+	while (len > 0) {
+		csum += data;
+		csum += csum < data;
+		len -= sizeof(csum_t);
+		ptr += 1;
+		data = *ptr;
+	}
+
+	/*
+	 * Perform alignment (and over-read) bytes on the tail if any bytes
+	 * leftover.
+	 */
+	shift = len * -8;
+#ifdef __LITTLE_ENDIAN
+	data = (data << shift) >> shift;
+#else
+	data = (data >> shift) << shift;
+#endif
+	csum += data;
+	csum += csum < data;
+
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZBB))
+		goto no_zbb;
+
+	unsigned int fold_temp;
+
+	if (IS_ENABLED(CONFIG_32BIT)) {
+		asm_volatile_goto(".option push			\n\
+		.option arch,+zbb				\n\
+			rori	%[fold_temp], %[csum], 16	\n\
+			andi	%[offset], %[offset], 1		\n\
+			add	%[csum], %[fold_temp], %[csum]	\n\
+			beq	%[offset], zero, %l[end]	\n\
+			rev8	%[csum], %[csum]		\n\
+			zext.h	%[csum], %[csum]		\n\
+		.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
+			: [offset] "r" (offset)
+			:
+			: end);
+
+		return csum;
+	} else {
+		asm_volatile_goto(".option push			\n\
+		.option arch,+zbb				\n\
+			rori	%[fold_temp], %[csum], 32	\n\
+			add	%[csum], %[fold_temp], %[csum]	\n\
+			srli	%[csum], %[csum], 32		\n\
+			roriw	%[fold_temp], %[csum], 16	\n\
+			addw	%[csum], %[fold_temp], %[csum]	\n\
+			andi	%[offset], %[offset], 1		\n\
+			beq	%[offset], zero, %l[end]	\n\
+			rev8	%[csum], %[csum]		\n\
+			srli	%[csum], %[csum], 32		\n\
+			zext.h	%[csum], %[csum]		\n\
+		.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
+			: [offset] "r" (offset)
+			:
+			: end);
+
+		return csum;
+	}
+end:
+		return csum >> 16;
+no_zbb:
+#ifndef CONFIG_32BIT
+		csum += (csum >> 32) | (csum << 32);
+		csum >>= 32;
+#endif
+	csum = (unsigned int)csum + (((unsigned int)csum >> 16) | ((unsigned int)csum << 16));
+	if (offset & 1)
+		return (unsigned short)swab32(csum);
+	return csum >> 16;
+}

-- 
2.42.0

