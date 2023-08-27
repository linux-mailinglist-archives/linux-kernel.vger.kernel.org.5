Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03941789AD1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjH0B1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjH0B0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:26:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29B1B4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26f38171174so1334523a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693099609; x=1693704409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcyEIUqviA7khUw+arj1F8KZbIH4pa6BCJUUF1erYKQ=;
        b=KBssN7pSowk/dJIIEgHKav1tbbyrmro3jYrP4WaAKlOMelorWlbKl6B5G9TRP9R9vm
         Cn/y4MlGtkiL+mEqtt7syBiBa6vzehktUGC4vJl5Bek9x1lbOAyLfEIuYLQBFfnr06QO
         vuULcGbun73JMaKzaej0JFrEU4DD5K4v6xHe2t941gT/NqP2zUPVypqwXGoSdrHg+zI0
         FqfR4wVVNL3DpAl5aijkwqrmOMvaqeKZHUegDc3KJhhZIM4cay+jKTpVhBvOiV8hR6QN
         /b73p5FCVDSRnKsC5SBWWr+P1MzCDKNAEUuk2YRI6nqctwO0uqMuMim2uq+zxNnS+Z3V
         ceZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099609; x=1693704409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcyEIUqviA7khUw+arj1F8KZbIH4pa6BCJUUF1erYKQ=;
        b=AQnSe8GBcMkxvKp01csaCiqEWoIbsO7lzlT3jRF6ctAT5K5baCNk4fBJ1CsS8jGWPd
         OMoVvQyOTD09vPWYaPW/0zVBlaQ9/+Wi8q4HCIMaSsv8ImhYTh28qB1FWkWTgslHG5VZ
         Plt3kwpJvuE9mQroVai4UxRE4rx/YBf/JiOwX9X/BBM5byDBL4rIZRKII4kW5SZYkyDe
         fbUy5i3O8o4PVylo7whpfE9BL3VfeucnGZQv7fHgyLsISFJX1SRZO9DRTmpbiu5SkEld
         i6H5p3fbm3iXr8TeXKk7N/VSdAsrg6y6Oju5qWt6xNF3ocmdS+2ZtkBN/VxIxlfqk2oO
         nkcg==
X-Gm-Message-State: AOJu0YyPQOdyg++DiFRXkjNoyC5vLhbHCdlvPtCkpYBpvUL67bD38/eV
        bbuzqZ6arhJq9PofFUAS8se9tBus1h/ICg+A7UQ=
X-Google-Smtp-Source: AGHT+IHd5wO3p992s4Jo593vlDR2y4R+RaUPenkdSZfrxwMjPtp06m42dnM4COmq5sTNRn0RSemKjw==
X-Received: by 2002:a17:90a:4ec2:b0:268:f987:305f with SMTP id v2-20020a17090a4ec200b00268f987305fmr21012361pjl.46.1693099608933;
        Sat, 26 Aug 2023 18:26:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b869410ed2sm4357404plb.72.2023.08.26.18.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:26:48 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Sat, 26 Aug 2023 18:26:07 -0700
Subject: [PATCH 2/5] riscv: Add checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230826-optimize_checksum-v1-2-937501b4522a@rivosinc.com>
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

Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
will load from the buffer in groups of 32 bits, and when compiled for
64-bit will load in groups of 64 bits.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h |   2 -
 arch/riscv/lib/Makefile           |   1 +
 arch/riscv/lib/csum.c             | 118 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index cd98f8cde888..af49b3409576 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -76,10 +76,8 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 #endif
 #define ip_fast_csum ip_fast_csum
 
-#ifdef CONFIG_64BIT
 extern unsigned int do_csum(const unsigned char *buff, int len);
 #define do_csum do_csum
-#endif
 
 #include <asm-generic/checksum.h>
 
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
index 000000000000..2037041ce8a0
--- /dev/null
+++ b/arch/riscv/lib/csum.c
@@ -0,0 +1,118 @@
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
+#ifdef CONFIG_64BIT
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum csum)
+{
+	unsigned long sum, ulen, uproto;
+
+	uproto = (unsigned long)htonl(proto);
+	ulen = (unsigned long)htonl(len);
+	sum = (unsigned long)csum;
+
+	sum += *(const unsigned long *)saddr->s6_addr;
+	sum += sum < csum;
+
+	sum += *((const unsigned long *)saddr->s6_addr + 1);
+	sum += sum < *((const unsigned long *)saddr->s6_addr + 1);
+
+	sum += *(const unsigned long *)daddr->s6_addr;
+	sum += sum < *(const unsigned long *)daddr->s6_addr;
+
+	sum += *((const unsigned long *)daddr->s6_addr + 1);
+	sum += sum < *((const unsigned long *)daddr->s6_addr + 1);
+
+	sum += ulen;
+	sum += sum < ulen;
+
+	sum += uproto;
+	sum += sum < uproto;
+
+	sum += (sum >> 32) | (sum << 32);
+	sum >>= 32;
+	return csum_fold((__force __wsum)sum);
+}
+EXPORT_SYMBOL(csum_ipv6_magic);
+#endif
+
+#ifdef CONFIG_32BIT
+typedef unsigned int csum_t;
+#define OFFSET_MASK 3
+#else
+typedef unsigned long csum_t;
+#define OFFSET_MASK 7
+#endif
+
+/*
+ * Perform a checksum on an arbitrary memory address.
+ * Algorithm accounts for buff being misaligned.
+ * If not aligned on an 8-byte boundary, will read the whole byte but not use
+ * the bytes that it shouldn't. The same thing will occur on the tail-end of the
+ * read.
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
+	 * RISC-V is always little endian, so need to clear bits to the right.
+	 */
+	shift = offset * 8;
+	data = *ptr;
+	data = (data >> shift) << shift;
+
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
+	data = (data << shift) >> shift;
+	csum += data;
+	csum += csum < data;
+
+#ifdef CONFIG_64BIT
+	csum += (csum >> 32) | (csum << 32);
+	csum >>= 32;
+#endif
+	csum = (unsigned int)csum + (((unsigned int)csum >> 16) | ((unsigned int)csum << 16));
+	if (offset & 1)
+		return (unsigned short)swab32(csum);
+	return csum >> 16;
+}

-- 
2.41.0

