Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE37FDC26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjK2QDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjK2QDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:03:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CAD73
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:03:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332f2c1f909so701921f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701273820; x=1701878620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7IGDwssStSDpyhXdV1nfus/AGOvw09dSHX5DmZ6h29s=;
        b=xOE2hNdOHHg+CV22PtM8lrFl/msrm5gjieDMrLhzNMHWqFBAk0gv2boG0F3ly7ZiR2
         T5dQpu3xl7IRoWYpxXiVZTWd25vl+7KW6gQ0p7pmQziB7dJfsWceoqvCG0zHuDokIb2W
         +YZbNKw8BhVEaFP6cBwcbat48imlR0EWnSaUG8dzN5o/rQAcDWAbnAPNnOwG4auZlBnI
         fDcJC0Xp6Q0HBZ+/zb73l1U+p9VwUnA5giVueBXb+hSmTI1c1gdA6LyPsZOL9UE1WDeX
         B1Fq7m9tISZusfE2tlONYKa6cN41/gFHopb3Nok/HGW7bzi94heD2OHULtLHP1XqNWq+
         U3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273820; x=1701878620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IGDwssStSDpyhXdV1nfus/AGOvw09dSHX5DmZ6h29s=;
        b=wB/BysI10tp1wBbeVrq6BkfmgdiIQ1b5nXvTwrxGBKvZTto0FWICdw/0kZ8uxALHsf
         SNhrTpFq0hX9SV9rk+oBCZSrVQzTdkoepxpw2eZihBz3Mr3qkawDHwsDvfHIHMuT3rP1
         q/1Nr7Sm+VUpKi9LusZExSNLSrGUuNPfaPqRlaoNVzZ4T++Gzja5qxt8t/OlSuTjece3
         eaCmMN5QtptwjTcoEkbliUxuFqhuHn5A6xjBvD7Y/KMDXzy84Wp/VUrDksxiAVFsTyAU
         FsQW0Sa3xxOwa4nEY5aE2+JW+o9VM+MKH/KuvzeljkML7de2LV76BLS8up6oabOGG37N
         Rngg==
X-Gm-Message-State: AOJu0YzT9ozK57i1TRIb4B8nS2ENYbnaso5qBooSl5T8RfFzTP4mFPHX
        q3PhnSJgvvl9gFXH0bf512z4aGs8Zh78dnGKaps=
X-Google-Smtp-Source: AGHT+IHiupA6lbwePPPMup095kGgR6Wzqg1hkQkrzFoWGaSz5k1vlW/5w08YDqh5N/Ye6RNFE45lOw==
X-Received: by 2002:a05:6000:4011:b0:332:e749:adaa with SMTP id cp17-20020a056000401100b00332e749adaamr12719911wrb.3.1701273819573;
        Wed, 29 Nov 2023 08:03:39 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:11a9:3d89:528b:b336])
        by smtp.gmail.com with ESMTPSA id q1-20020a5d6581000000b00331a55d3875sm18230283wru.38.2023.11.29.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:03:39 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH] RISC-V: Implement archrandom when Zkr is available
Date:   Wed, 29 Nov 2023 17:03:25 +0100
Message-ID: <20231129160325.1119803-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Ortiz <sameo@rivosinc.com>

From: Samuel Ortiz <sameo@rivosinc.com>

The Zkr extension is ratified and provides 16 bits of entropy seed when
reading the SEED CSR.

We can implement arch_get_random_seed_longs() by doing multiple csrrw to
that CSR and filling an unsigned long with valid entropy bits.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---

This series depends on "riscv: report more ISA extensions through
hwprobe" series [1].

Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/ [1]
---
 arch/riscv/include/asm/archrandom.h | 69 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h        |  9 ++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/riscv/include/asm/archrandom.h

diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
new file mode 100644
index 000000000000..795837ccb583
--- /dev/null
+++ b/arch/riscv/include/asm/archrandom.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel interface for the RISCV arch_random_* functions
+ *
+ * Copyright (c) 2023 by Rivos Inc.
+ *
+ */
+
+#ifndef ASM_RISCV_ARCHRANDOM_H
+#define ASM_RISCV_ARCHRANDOM_H
+
+#include <asm/csr.h>
+
+#define SEED_RETRY_LOOPS 100
+
+static inline bool __must_check csr_seed_long(unsigned long *v)
+{
+	unsigned int retry = SEED_RETRY_LOOPS, valid_seeds = 0;
+	const int needed_seeds = sizeof(long) / sizeof(u16);
+	u16 *entropy = (u16 *)v;
+
+	do {
+		/*
+		 * The SEED CSR must be accessed with a read-write instruction.
+		 */
+		unsigned long csr_seed = csr_swap(CSR_SEED, 0);
+
+		switch (csr_seed & SEED_OPST_MASK) {
+		case SEED_OPST_ES16:
+			entropy[valid_seeds++] = csr_seed & SEED_ENTROPY_MASK;
+			if (valid_seeds == needed_seeds)
+				return true;
+			break;
+
+		case SEED_OPST_DEAD:
+			pr_err_once("archrandom: Unrecoverable error\n");
+			return false;
+
+		case SEED_OPST_BIST:
+		case SEED_OPST_WAIT:
+		default:
+			continue;
+		}
+	} while (--retry);
+
+	return false;
+}
+
+static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
+{
+	return 0;
+}
+
+static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
+{
+	if (!max_longs)
+		return 0;
+
+	/*
+	 * If Zkr is supported and csr_seed_long succeeds, we return one long
+	 * worth of entropy.
+	 */
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_long(v))
+		return 1;
+
+	return 0;
+}
+
+#endif /* ASM_RISCV_ARCHRANDOM_H */
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..510014051f5d 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -411,6 +411,15 @@
 #define CSR_VTYPE		0xc21
 #define CSR_VLENB		0xc22
 
+/* Scalar Crypto Extension - Entropy */
+#define CSR_SEED		0x015
+#define SEED_OPST_MASK		_AC(0xC0000000, UL)
+#define SEED_OPST_BIST		_AC(0x00000000, UL)
+#define SEED_OPST_WAIT		_AC(0x40000000, UL)
+#define SEED_OPST_ES16		_AC(0x80000000, UL)
+#define SEED_OPST_DEAD		_AC(0xC0000000, UL)
+#define SEED_ENTROPY_MASK	_AC(0xFFFF, UL)
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.42.0

