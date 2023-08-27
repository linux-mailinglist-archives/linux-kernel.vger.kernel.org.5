Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A9789ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjH0B1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjH0B0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:26:51 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BE1B3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:48 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-571194584e2so1402214eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693099608; x=1693704408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfTS8tqhuCXvlRMkmz2PkepwLOiLzUz1oIVWEI6AmSg=;
        b=2uClxYn/559ZVUpa1YquW1FFWcG7vzRXkQRMoM5j2FLcrHWGTjCAKRd75m/5gdiqPh
         yM+9URcFsOcw0EQelDYFTuuZjZCoosRnNu79MJR79CKVohEkJwd6gRsL/eeobALPxFFg
         cQP6lkg8MltZCwzgfnmU0HspEgv5zpW/R1cgqxW3zzvjxYxixve7rX286VuKEZXZjWfa
         iHo1icydIYbrJ+qDmejDKV3LjvPKKECqFybgQlr4t5WJg70btYWsiKcwyHJjXEriRDiE
         ZBrdt7bfW73bkbWVNSu8uViudvT87B7nA3+sVIklrRrX7hUeKCGoS/qzG7wnSeXbMPtk
         mn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099608; x=1693704408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfTS8tqhuCXvlRMkmz2PkepwLOiLzUz1oIVWEI6AmSg=;
        b=a4I6/Vt3wSGToBmzpy8pA3nk+cC5BeevxJ24YON4DgYXsmnQYlO60xzCbfdVHuFtdW
         3o3AKV+sySownYCgXTQp7UgTSg6L8vEs2CcqDDG0qFqacgCELVnueZcSF+k1zaDm3mCF
         FTNvc72vFyXpT/fdjsFQqJBv7lOXqQ65FQvN5bY8KeqnHpUV1K8h8AnWaG6+WzDTTa19
         p9kENN7XeZeiVNHhI/wGpDXx7kSS3E/idFjHsKUCBY4BOhTcgA1vZ1Nvp4W+g/ZuwF+m
         d5wk8TRqmYTDEnfwNQvcb9yO6fxzvXrvwUK2j9TSdAJ0OVOMXBUxWnwNhcmRUx8BY81C
         1aNQ==
X-Gm-Message-State: AOJu0YzEmdoQG5Sz12H+kSgFQ5q3OLvX6m9yezRcVHiBbTBk1Ep5Uddz
        nKaJObW8QQ+fX5/5SbrkCl4N1Xf6bgE0uaSLmLQ=
X-Google-Smtp-Source: AGHT+IFLXaIwbb2H3mZ5Q6cj8cOqVl+jK5FQkosINRTZl886s4rzQbb1kPqE57ixOM1lSRn0MVvJpA==
X-Received: by 2002:a05:6358:880a:b0:12b:e45b:3fac with SMTP id hv10-20020a056358880a00b0012be45b3facmr17843078rwb.32.1693099607875;
        Sat, 26 Aug 2023 18:26:47 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b869410ed2sm4357404plb.72.2023.08.26.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:26:46 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Sat, 26 Aug 2023 18:26:06 -0700
Subject: [PATCH 1/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230826-optimize_checksum-v1-1-937501b4522a@rivosinc.com>
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

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Add configuration for Zba extension and add march for Zba and Zbb.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                | 23 +++++++++++
 arch/riscv/Makefile               |  2 +
 arch/riscv/include/asm/checksum.h | 86 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..8d7e475ca28d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -507,6 +507,29 @@ config RISCV_ISA_V_DEFAULT_ENABLE
 
 	  If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZBA
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zba)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zba)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
+	depends on AS_HAS_OPTION_ARCH
+
+config RISCV_ISA_ZBA
+	bool "Zba extension support for bit manipulation instructions"
+	depends on TOOLCHAIN_HAS_ZBA
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the ZBA
+	   extension (basic bit manipulation) and enable its usage.
+
+	   The Zba extension provides instructions to accelerate a number
+	   of bit-specific address creation operations.
+
+	   If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6ec6d52a4180..51fa3f67fc9a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -61,6 +61,8 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
+riscv-march-$(CONFIG_RISCV_ISA_ZBA)	:= $(riscv-march-y)_zba
+riscv-march-$(CONFIG_RISCV_ISA_ZBB)	:= $(riscv-march-y)_zbb
 
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2
diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..cd98f8cde888
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * IP checksum routines
+ *
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#ifndef __ASM_RISCV_CHECKSUM_H
+#define __ASM_RISCV_CHECKSUM_H
+
+#include <linux/in6.h>
+#include <linux/uaccess.h>
+
+/* Default version is sufficient for 32 bit */
+#ifdef CONFIG_64BIT
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+#endif
+
+/*
+ *	Fold a partial checksum without adding pseudo headers
+ */
+static inline __sum16 csum_fold(__wsum sum)
+{
+	sum += (sum >> 16) | (sum << 16);
+	return (__force __sum16)(~(sum >> 16));
+}
+
+#define csum_fold csum_fold
+
+/*
+ *	This is a version of ip_compute_csum() optimized for IP headers,
+ *	which always checksum on 4 octet boundaries.
+ *	Optimized for 32 and 64 bit platforms, with and without vector, with and
+ *	without the bitmanip extensions zba/zbb.
+ */
+#ifdef CONFIG_32BIT
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	__wsum csum = 0;
+	int pos = 0;
+
+	do {
+		csum += ((const __wsum *)iph)[pos];
+		csum += csum < ((const __wsum *)iph)[pos];
+	} while (++pos < ihl);
+	return csum_fold(csum);
+}
+#else
+
+/*
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph is also assumed to be word aligned.
+ */
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	unsigned long beginning;
+	unsigned long csum = 0;
+
+	beginning = ((const unsigned long *)iph)[0];
+	beginning += ((const unsigned long *)iph)[1];
+	beginning += beginning < ((const unsigned long *)iph)[1];
+	int pos = 4;
+
+	do {
+		csum += ((const unsigned int *)iph)[pos];
+	} while (++pos < ihl);
+	csum += beginning;
+	csum += csum < beginning;
+	csum += (csum >> 32) | (csum << 32); // Calculate overflow
+	return csum_fold((__force __wsum)(csum >> 32));
+}
+#endif
+#define ip_fast_csum ip_fast_csum
+
+#ifdef CONFIG_64BIT
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+#endif
+
+#include <asm-generic/checksum.h>
+
+#endif

-- 
2.41.0

