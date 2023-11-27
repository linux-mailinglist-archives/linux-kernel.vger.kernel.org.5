Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BDF7F9AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjK0HHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjK0HH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:07:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DCA189
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso26422135ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701068845; x=1701673645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtUiUXkF3kN/BXKzxp91tLi6KCR2x1T9PQI4Fk+ZakA=;
        b=nPlY+zb0tw7YGaJaMtvPpJkcLa5nMnjqj0ak+r8ipUxdKUdq4mxoiThCCfCdEVBskl
         AyZ2WLkBlqXCktEUjHm16kP5mQ2vipFlNvTgQG1gsW4s9iJfyzU0j4d5zDk5g8Z61vqL
         UYRG7J09/rd7jPvW+0tcNFCpirQDGPJ6oWcTPpy2hMMDjfs+rBBELjT4wTMyIbqkBV+l
         dvfPFde0ZITusi2nvcHRVovrwujeXfgRPcuZdF63d8lnK8SoF/oimRuUo0L9WhnQdHoi
         cobcknsJuumEuCPrjFFH767RP5YBEDjPv2NsaOhYgYPdX3oE36vnjuJJu8Rtj1Y9UWmP
         XJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068845; x=1701673645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtUiUXkF3kN/BXKzxp91tLi6KCR2x1T9PQI4Fk+ZakA=;
        b=I2wL2OyPFtRSk+H0DR6tQQZEg+6PNDTWuoCeNtMNSl92mchoePWcLNhX8jeN4UkeS9
         c2vij4nRHjBQWK9VmWt9HFujTpq+2VhJZgmHVD4ggMr80ioBxh/d65jyjdvJWO8dg8uS
         mejahm1rNzgDcP/KI6ny43Z6pr3Gfmb7S909VZmeCId0NiCS41PlTLJEIm+89eskMlvu
         AjSOhs0H7I2o4ob6m34pFjMZ7yO/YZYdmh991k6wmZ7vqog9oDKEkF3DLrfv5t1RFIzg
         N1UTHSfuLpGy5QwNl+1W4UlJpIlS9kw84NHYENCMhagA8owpF/TILOUtrqeN3F3GbXox
         wIYg==
X-Gm-Message-State: AOJu0YwrV9j1CGeuotpUlmEM6gyyHplj35hzIDMAbI1d+XSl8xLsst4A
        f0g8XJIcCJ429Eu4w+X1LYowWA==
X-Google-Smtp-Source: AGHT+IFRltSyEt83zMIe016Zra5s1haP8WmUsC8LiFC12OgzYubxW56A1sWoR6JvaAeOcy6VtjPE/w==
X-Received: by 2002:a17:902:d38d:b0:1cf:a4e8:d2a1 with SMTP id e13-20020a170902d38d00b001cfa4e8d2a1mr8131780pld.42.1701068845494;
        Sun, 26 Nov 2023 23:07:25 -0800 (PST)
Received: from localhost.localdomain ([101.10.45.230])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm1340134plb.77.2023.11.26.23.07.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:07:25 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES implementation
Date:   Mon, 27 Nov 2023 15:06:54 +0800
Message-Id: <20231127070703.1697-5-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231127070703.1697-1-jerry.shih@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AES implementation using the Zvkned vector crypto extension from
OpenSSL(openssl/openssl#21923).

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v2:
 - Do not turn on kconfig `AES_RISCV64` option by default.
 - Turn to use `crypto_aes_ctx` structure for aes key.
 - Use `Zvkned` extension for AES-128/256 key expanding.
 - Export riscv64_aes_* symbols for other modules.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Reorder structure riscv64_aes_alg_zvkned members initialization in
   the order declared.
---
 arch/riscv/crypto/Kconfig               |  11 +
 arch/riscv/crypto/Makefile              |  11 +
 arch/riscv/crypto/aes-riscv64-glue.c    | 151 ++++++
 arch/riscv/crypto/aes-riscv64-glue.h    |  18 +
 arch/riscv/crypto/aes-riscv64-zvkned.pl | 593 ++++++++++++++++++++++++
 5 files changed, 784 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 10d60edc0110..65189d4d47b3 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -2,4 +2,15 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
+config CRYPTO_AES_RISCV64
+	tristate "Ciphers: AES"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_AES
+	help
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+
+	  Architecture: riscv64 using:
+	  - Zvkned vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index b3b6332c9f6d..90ca91d8df26 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -2,3 +2,14 @@
 #
 # linux/arch/riscv/crypto/Makefile
 #
+
+obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
+aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $(<) void $(@)
+
+$(obj)/aes-riscv64-zvkned.S: $(src)/aes-riscv64-zvkned.pl
+	$(call cmd,perlasm)
+
+clean-files += aes-riscv64-zvkned.S
diff --git a/arch/riscv/crypto/aes-riscv64-glue.c b/arch/riscv/crypto/aes-riscv64-glue.c
new file mode 100644
index 000000000000..091e368edb30
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Port of the OpenSSL AES implementation for RISC-V
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/aes.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/simd.h>
+#include <linux/crypto.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "aes-riscv64-glue.h"
+
+/* aes cipher using zvkned vector crypto extension */
+asmlinkage int rv64i_zvkned_set_encrypt_key(const u8 *user_key, const int bytes,
+					    const struct crypto_aes_ctx *key);
+asmlinkage void rv64i_zvkned_encrypt(const u8 *in, u8 *out,
+				     const struct crypto_aes_ctx *key);
+asmlinkage void rv64i_zvkned_decrypt(const u8 *in, u8 *out,
+				     const struct crypto_aes_ctx *key);
+
+int riscv64_aes_setkey(struct crypto_aes_ctx *ctx, const u8 *key,
+		       unsigned int keylen)
+{
+	int ret;
+
+	ret = aes_check_keylen(keylen);
+	if (ret < 0)
+		return -EINVAL;
+
+	/*
+	 * The RISC-V AES vector crypto key expanding doesn't support AES-192.
+	 * Use the generic software key expanding for that case.
+	 */
+	if ((keylen == 16 || keylen == 32) && crypto_simd_usable()) {
+		/*
+		 * All zvkned-based functions use encryption expanding keys for both
+		 * encryption and decryption.
+		 */
+		kernel_vector_begin();
+		rv64i_zvkned_set_encrypt_key(key, keylen, ctx);
+		kernel_vector_end();
+	} else {
+		ret = aes_expandkey(ctx, key, keylen);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(riscv64_aes_setkey);
+
+void riscv64_aes_encrypt_zvkned(const struct crypto_aes_ctx *ctx, u8 *dst,
+				const u8 *src)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		rv64i_zvkned_encrypt(src, dst, ctx);
+		kernel_vector_end();
+	} else {
+		aes_encrypt(ctx, dst, src);
+	}
+}
+EXPORT_SYMBOL(riscv64_aes_encrypt_zvkned);
+
+void riscv64_aes_decrypt_zvkned(const struct crypto_aes_ctx *ctx, u8 *dst,
+				const u8 *src)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		rv64i_zvkned_decrypt(src, dst, ctx);
+		kernel_vector_end();
+	} else {
+		aes_decrypt(ctx, dst, src);
+	}
+}
+EXPORT_SYMBOL(riscv64_aes_decrypt_zvkned);
+
+static int aes_setkey(struct crypto_tfm *tfm, const u8 *key,
+		      unsigned int keylen)
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	return riscv64_aes_setkey(ctx, key, keylen);
+}
+
+static void aes_encrypt_zvkned(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	riscv64_aes_encrypt_zvkned(ctx, dst, src);
+}
+
+static void aes_decrypt_zvkned(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	riscv64_aes_decrypt_zvkned(ctx, dst, src);
+}
+
+static struct crypto_alg riscv64_aes_alg_zvkned = {
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize = AES_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+	.cra_priority = 300,
+	.cra_name = "aes",
+	.cra_driver_name = "aes-riscv64-zvkned",
+	.cra_cipher = {
+		.cia_min_keysize = AES_MIN_KEY_SIZE,
+		.cia_max_keysize = AES_MAX_KEY_SIZE,
+		.cia_setkey = aes_setkey,
+		.cia_encrypt = aes_encrypt_zvkned,
+		.cia_decrypt = aes_decrypt_zvkned,
+	},
+	.cra_module = THIS_MODULE,
+};
+
+static inline bool check_aes_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKNED) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_aes_mod_init(void)
+{
+	if (check_aes_ext())
+		return crypto_register_alg(&riscv64_aes_alg_zvkned);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_aes_mod_fini(void)
+{
+	crypto_unregister_alg(&riscv64_aes_alg_zvkned);
+}
+
+module_init(riscv64_aes_mod_init);
+module_exit(riscv64_aes_mod_fini);
+
+MODULE_DESCRIPTION("AES (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("aes");
diff --git a/arch/riscv/crypto/aes-riscv64-glue.h b/arch/riscv/crypto/aes-riscv64-glue.h
new file mode 100644
index 000000000000..0416bbc4318e
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef AES_RISCV64_GLUE_H
+#define AES_RISCV64_GLUE_H
+
+#include <crypto/aes.h>
+#include <linux/types.h>
+
+int riscv64_aes_setkey(struct crypto_aes_ctx *ctx, const u8 *key,
+		       unsigned int keylen);
+
+void riscv64_aes_encrypt_zvkned(const struct crypto_aes_ctx *ctx, u8 *dst,
+				const u8 *src);
+
+void riscv64_aes_decrypt_zvkned(const struct crypto_aes_ctx *ctx, u8 *dst,
+				const u8 *src);
+
+#endif /* AES_RISCV64_GLUE_H */
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl b/arch/riscv/crypto/aes-riscv64-zvkned.pl
new file mode 100644
index 000000000000..303e82d9f6f0
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
@@ -0,0 +1,593 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+# Copyright (c) 2023, Phoebe Chen <phoebe.chen@sifive.com>
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector AES block cipher extension ('Zvkned')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+use riscv;
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+.text
+___
+
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+{
+################################################################################
+# int rv64i_zvkned_set_encrypt_key(const unsigned char *userKey, const int bytes,
+#                                  AES_KEY *key)
+my ($UKEY, $BYTES, $KEYP) = ("a0", "a1", "a2");
+my ($T0) = ("t0");
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_set_encrypt_key
+.type rv64i_zvkned_set_encrypt_key,\@function
+rv64i_zvkned_set_encrypt_key:
+    beqz $UKEY, L_fail_m1
+    beqz $KEYP, L_fail_m1
+
+    # Store the key length.
+    sw $BYTES, 480($KEYP)
+
+    li $T0, 32
+    beq $BYTES, $T0, L_set_key_256
+    li $T0, 16
+    beq $BYTES, $T0, L_set_key_128
+
+    j L_fail_m2
+
+L_set_key_128:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    # Load the key
+    @{[vle32_v $V10, $UKEY]}
+
+    # Generate keys for round 2-11 into registers v11-v20.
+    @{[vaeskf1_vi $V11, $V10, 1]}   # v11 <- rk2  (w[ 4, 7])
+    @{[vaeskf1_vi $V12, $V11, 2]}   # v12 <- rk3  (w[ 8,11])
+    @{[vaeskf1_vi $V13, $V12, 3]}   # v13 <- rk4  (w[12,15])
+    @{[vaeskf1_vi $V14, $V13, 4]}   # v14 <- rk5  (w[16,19])
+    @{[vaeskf1_vi $V15, $V14, 5]}   # v15 <- rk6  (w[20,23])
+    @{[vaeskf1_vi $V16, $V15, 6]}   # v16 <- rk7  (w[24,27])
+    @{[vaeskf1_vi $V17, $V16, 7]}   # v17 <- rk8  (w[28,31])
+    @{[vaeskf1_vi $V18, $V17, 8]}   # v18 <- rk9  (w[32,35])
+    @{[vaeskf1_vi $V19, $V18, 9]}   # v19 <- rk10 (w[36,39])
+    @{[vaeskf1_vi $V20, $V19, 10]}  # v20 <- rk11 (w[40,43])
+
+    # Store the round keys
+    @{[vse32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V11, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V12, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V13, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V14, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V15, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V16, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V17, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V18, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V19, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V20, $KEYP]}
+
+    li a0, 1
+    ret
+
+L_set_key_256:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    # Load the key
+    @{[vle32_v $V10, $UKEY]}
+    addi $UKEY, $UKEY, 16
+    @{[vle32_v $V11, $UKEY]}
+
+    @{[vmv_v_v $V12, $V10]}
+    @{[vaeskf2_vi $V12, $V11, 2]}
+    @{[vmv_v_v $V13, $V11]}
+    @{[vaeskf2_vi $V13, $V12, 3]}
+    @{[vmv_v_v $V14, $V12]}
+    @{[vaeskf2_vi $V14, $V13, 4]}
+    @{[vmv_v_v $V15, $V13]}
+    @{[vaeskf2_vi $V15, $V14, 5]}
+    @{[vmv_v_v $V16, $V14]}
+    @{[vaeskf2_vi $V16, $V15, 6]}
+    @{[vmv_v_v $V17, $V15]}
+    @{[vaeskf2_vi $V17, $V16, 7]}
+    @{[vmv_v_v $V18, $V16]}
+    @{[vaeskf2_vi $V18, $V17, 8]}
+    @{[vmv_v_v $V19, $V17]}
+    @{[vaeskf2_vi $V19, $V18, 9]}
+    @{[vmv_v_v $V20, $V18]}
+    @{[vaeskf2_vi $V20, $V19, 10]}
+    @{[vmv_v_v $V21, $V19]}
+    @{[vaeskf2_vi $V21, $V20, 11]}
+    @{[vmv_v_v $V22, $V20]}
+    @{[vaeskf2_vi $V22, $V21, 12]}
+    @{[vmv_v_v $V23, $V21]}
+    @{[vaeskf2_vi $V23, $V22, 13]}
+    @{[vmv_v_v $V24, $V22]}
+    @{[vaeskf2_vi $V24, $V23, 14]}
+
+    @{[vse32_v $V10, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V11, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V12, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V13, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V14, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V15, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V16, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V17, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V18, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V19, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V20, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V21, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V22, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V23, $KEYP]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $V24, $KEYP]}
+
+    li a0, 1
+    ret
+.size rv64i_zvkned_set_encrypt_key,.-rv64i_zvkned_set_encrypt_key
+___
+}
+
+{
+################################################################################
+# void rv64i_zvkned_encrypt(const unsigned char *in, unsigned char *out,
+#                           const AES_KEY *key);
+my ($INP, $OUTP, $KEYP) = ("a0", "a1", "a2");
+my ($T0) = ("t0");
+my ($KEY_LEN) = ("a3");
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_encrypt
+.type rv64i_zvkned_encrypt,\@function
+rv64i_zvkned_encrypt:
+    # Load key length.
+    lwu $KEY_LEN, 480($KEYP)
+
+    # Get proper routine for key length.
+    li $T0, 32
+    beq $KEY_LEN, $T0, L_enc_256
+    li $T0, 24
+    beq $KEY_LEN, $T0, L_enc_192
+    li $T0, 16
+    beq $KEY_LEN, $T0, L_enc_128
+
+    j L_fail_m2
+.size rv64i_zvkned_encrypt,.-rv64i_zvkned_encrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_enc_128:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, $INP]}
+
+    @{[vle32_v $V10, $KEYP]}
+    @{[vaesz_vs $V1, $V10]}    # with round key w[ 0, 3]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    @{[vaesem_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    @{[vaesem_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+    @{[vaesem_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, $KEYP]}
+    @{[vaesem_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, $KEYP]}
+    @{[vaesem_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V16, $KEYP]}
+    @{[vaesem_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V17, $KEYP]}
+    @{[vaesem_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V18, $KEYP]}
+    @{[vaesem_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V19, $KEYP]}
+    @{[vaesem_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V20, $KEYP]}
+    @{[vaesef_vs $V1, $V20]}   # with round key w[40,43]
+
+    @{[vse32_v $V1, $OUTP]}
+
+    ret
+.size L_enc_128,.-L_enc_128
+___
+
+$code .= <<___;
+.p2align 3
+L_enc_192:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, $INP]}
+
+    @{[vle32_v $V10, $KEYP]}
+    @{[vaesz_vs $V1, $V10]}     # with round key w[ 0, 3]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    @{[vaesem_vs $V1, $V11]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    @{[vaesem_vs $V1, $V12]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+    @{[vaesem_vs $V1, $V13]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, $KEYP]}
+    @{[vaesem_vs $V1, $V14]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, $KEYP]}
+    @{[vaesem_vs $V1, $V15]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V16, $KEYP]}
+    @{[vaesem_vs $V1, $V16]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V17, $KEYP]}
+    @{[vaesem_vs $V1, $V17]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V18, $KEYP]}
+    @{[vaesem_vs $V1, $V18]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V19, $KEYP]}
+    @{[vaesem_vs $V1, $V19]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V20, $KEYP]}
+    @{[vaesem_vs $V1, $V20]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V21, $KEYP]}
+    @{[vaesem_vs $V1, $V21]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V22, $KEYP]}
+    @{[vaesef_vs $V1, $V22]}
+
+    @{[vse32_v $V1, $OUTP]}
+    ret
+.size L_enc_192,.-L_enc_192
+___
+
+$code .= <<___;
+.p2align 3
+L_enc_256:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, $INP]}
+
+    @{[vle32_v $V10, $KEYP]}
+    @{[vaesz_vs $V1, $V10]}     # with round key w[ 0, 3]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, $KEYP]}
+    @{[vaesem_vs $V1, $V11]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, $KEYP]}
+    @{[vaesem_vs $V1, $V12]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, $KEYP]}
+    @{[vaesem_vs $V1, $V13]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, $KEYP]}
+    @{[vaesem_vs $V1, $V14]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, $KEYP]}
+    @{[vaesem_vs $V1, $V15]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V16, $KEYP]}
+    @{[vaesem_vs $V1, $V16]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V17, $KEYP]}
+    @{[vaesem_vs $V1, $V17]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V18, $KEYP]}
+    @{[vaesem_vs $V1, $V18]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V19, $KEYP]}
+    @{[vaesem_vs $V1, $V19]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V20, $KEYP]}
+    @{[vaesem_vs $V1, $V20]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V21, $KEYP]}
+    @{[vaesem_vs $V1, $V21]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V22, $KEYP]}
+    @{[vaesem_vs $V1, $V22]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V23, $KEYP]}
+    @{[vaesem_vs $V1, $V23]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V24, $KEYP]}
+    @{[vaesef_vs $V1, $V24]}
+
+    @{[vse32_v $V1, $OUTP]}
+    ret
+.size L_enc_256,.-L_enc_256
+___
+
+################################################################################
+# void rv64i_zvkned_decrypt(const unsigned char *in, unsigned char *out,
+#                           const AES_KEY *key);
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_decrypt
+.type rv64i_zvkned_decrypt,\@function
+rv64i_zvkned_decrypt:
+    # Load key length.
+    lwu $KEY_LEN, 480($KEYP)
+
+    # Get proper routine for key length.
+    li $T0, 32
+    beq $KEY_LEN, $T0, L_dec_256
+    li $T0, 24
+    beq $KEY_LEN, $T0, L_dec_192
+    li $T0, 16
+    beq $KEY_LEN, $T0, L_dec_128
+
+    j L_fail_m2
+.size rv64i_zvkned_decrypt,.-rv64i_zvkned_decrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_dec_128:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, $INP]}
+
+    addi $KEYP, $KEYP, 160
+    @{[vle32_v $V20, $KEYP]}
+    @{[vaesz_vs $V1, $V20]}    # with round key w[40,43]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V19, $KEYP]}
+    @{[vaesdm_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V18, $KEYP]}
+    @{[vaesdm_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V17, $KEYP]}
+    @{[vaesdm_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V16, $KEYP]}
+    @{[vaesdm_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V15, $KEYP]}
+    @{[vaesdm_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V14, $KEYP]}
+    @{[vaesdm_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V13, $KEYP]}
+    @{[vaesdm_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V12, $KEYP]}
+    @{[vaesdm_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V11, $KEYP]}
+    @{[vaesdm_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V10, $KEYP]}
+    @{[vaesdf_vs $V1, $V10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $V1, $OUTP]}
+
+    ret
+.size L_dec_128,.-L_dec_128
+___
+
+$code .= <<___;
+.p2align 3
+L_dec_192:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, $INP]}
+
+    addi $KEYP, $KEYP, 192
+    @{[vle32_v $V22, $KEYP]}
+    @{[vaesz_vs $V1, $V22]}    # with round key w[48,51]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V21, $KEYP]}
+    @{[vaesdm_vs $V1, $V21]}   # with round key w[44,47]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V20, $KEYP]}
+    @{[vaesdm_vs $V1, $V20]}    # with round key w[40,43]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V19, $KEYP]}
+    @{[vaesdm_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V18, $KEYP]}
+    @{[vaesdm_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V17, $KEYP]}
+    @{[vaesdm_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V16, $KEYP]}
+    @{[vaesdm_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V15, $KEYP]}
+    @{[vaesdm_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V14, $KEYP]}
+    @{[vaesdm_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V13, $KEYP]}
+    @{[vaesdm_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V12, $KEYP]}
+    @{[vaesdm_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V11, $KEYP]}
+    @{[vaesdm_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V10, $KEYP]}
+    @{[vaesdf_vs $V1, $V10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $V1, $OUTP]}
+
+    ret
+.size L_dec_192,.-L_dec_192
+___
+
+$code .= <<___;
+.p2align 3
+L_dec_256:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, $INP]}
+
+    addi $KEYP, $KEYP, 224
+    @{[vle32_v $V24, $KEYP]}
+    @{[vaesz_vs $V1, $V24]}    # with round key w[56,59]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V23, $KEYP]}
+    @{[vaesdm_vs $V1, $V23]}   # with round key w[52,55]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V22, $KEYP]}
+    @{[vaesdm_vs $V1, $V22]}    # with round key w[48,51]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V21, $KEYP]}
+    @{[vaesdm_vs $V1, $V21]}   # with round key w[44,47]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V20, $KEYP]}
+    @{[vaesdm_vs $V1, $V20]}    # with round key w[40,43]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V19, $KEYP]}
+    @{[vaesdm_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V18, $KEYP]}
+    @{[vaesdm_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V17, $KEYP]}
+    @{[vaesdm_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V16, $KEYP]}
+    @{[vaesdm_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V15, $KEYP]}
+    @{[vaesdm_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V14, $KEYP]}
+    @{[vaesdm_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V13, $KEYP]}
+    @{[vaesdm_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V12, $KEYP]}
+    @{[vaesdm_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V11, $KEYP]}
+    @{[vaesdm_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V10, $KEYP]}
+    @{[vaesdf_vs $V1, $V10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $V1, $OUTP]}
+
+    ret
+.size L_dec_256,.-L_dec_256
+___
+}
+
+$code .= <<___;
+L_fail_m1:
+    li a0, -1
+    ret
+.size L_fail_m1,.-L_fail_m1
+
+L_fail_m2:
+    li a0, -2
+    ret
+.size L_fail_m2,.-L_fail_m2
+
+L_end:
+  ret
+.size L_end,.-L_end
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0

