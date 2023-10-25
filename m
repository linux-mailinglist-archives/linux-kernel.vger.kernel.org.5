Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828787D7362
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjJYSha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjJYShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:37:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47E193
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d3c886671so3817a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259032; x=1698863832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWKTD/SWI8njkmgyeeN+5f9jkvLnhIgL7e3VWIYvG8Q=;
        b=OligZW4ClXoFMTp8YmdWgUfsaapPuy6hpOpQA9zMBmB1EXNnFxE1dd7VV14ml5FDBM
         yTkYGMcI61LSTl7Z8KwhU/vfP0K5Fb499YEzUqFtA1mx7CxkLOnClJGMhZhsAzx4uQkA
         Q52tvYCe4x1yD8jOwHskx78991r7AWed5ajzE5wJ62/b4Jp5Xj+R4qYxpHdGIOXlPqop
         LTww+Rm0tubgnfiO16wIW8Laz9h3xjkI8xR517eoJpA0hiV2h7QKhCVjCbzBqUqzbOwB
         PfKaB7gIyJymwQMgDF8a1cT5Hf8/PkZDJiGSqKxoxnM+X1nU65G1edz+D4kHz/c9lY2Q
         +ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259032; x=1698863832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWKTD/SWI8njkmgyeeN+5f9jkvLnhIgL7e3VWIYvG8Q=;
        b=ieYSXOBcpXqj46/bhcNT0l55xxukCvmz0bRVjI+cswVVdRSPv00h7RRPTBahEzaDb6
         Tw3u2gqMR2r6J/YxuEfy6jd/6hh+r4g4O168bI7aEm883oKP8u9Mk6SMaLu5jU7r4sfc
         LK0Ubg/MxExNaDcZTJ79Dvi1IVUFP/yUvQNoKQ5aIGyqWN1U8VvBuFX3Rdk2COL/LIE7
         BfVLGy5LLXl75C9ofMtjxHf/b0AtWtHZrNBwrNrr9XldadyqclKzdQncepkvvfvhW/lq
         V/sqvc2aS9a0rR65iDP70dw/gDiXYzqysjfuqPt0Vd4Ie2EsipayEp9ySYJnit3zi4ci
         BTtQ==
X-Gm-Message-State: AOJu0YzR/fKmUoPby+gFFOotu77+mcVbRDTKvzDiHQqPjVxea4fLevYd
        2I4ar9GbuwYUwL4bQcPN5EsvX7k7XvGCAiTJ1X/g5A==
X-Google-Smtp-Source: AGHT+IGRNYQPO/oiPp8ACsYhU0M5aGJ04WqOdeXXrN2GlGvrHQNkylxeMduls440BMus9XknRraQ5g==
X-Received: by 2002:a17:90a:7442:b0:27d:9b67:7fa6 with SMTP id o2-20020a17090a744200b0027d9b677fa6mr14293424pjk.3.1698259031716;
        Wed, 25 Oct 2023 11:37:11 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:37:11 -0700 (PDT)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ebiggers@kernel.org, ardb@kernel.org,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 04/12] RISC-V: crypto: add Zvkned accelerated AES implementation
Date:   Thu, 26 Oct 2023 02:36:36 +0800
Message-Id: <20231025183644.8735-5-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/riscv/crypto/Kconfig               |  12 +
 arch/riscv/crypto/Makefile              |  11 +
 arch/riscv/crypto/aes-riscv64-glue.c    | 163 +++++++++
 arch/riscv/crypto/aes-riscv64-glue.h    |  28 ++
 arch/riscv/crypto/aes-riscv64-zvkned.pl | 451 ++++++++++++++++++++++++
 5 files changed, 665 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 10d60edc0110..500938317e71 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -2,4 +2,16 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
+config CRYPTO_AES_RISCV64
+	default y if RISCV_ISA_V
+	tristate "Ciphers: AES"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_AES
+	select CRYPTO_ALGAPI
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
index 000000000000..5c4f1018d3aa
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.c
@@ -0,0 +1,163 @@
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
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "aes-riscv64-glue.h"
+
+/*
+ * aes cipher using zvkned vector crypto extension
+ *
+ * All zvkned-based functions use encryption expending keys for both encryption
+ * and decryption.
+ */
+void rv64i_zvkned_encrypt(const u8 *in, u8 *out, const struct aes_key *key);
+void rv64i_zvkned_decrypt(const u8 *in, u8 *out, const struct aes_key *key);
+
+static inline int aes_round_num(unsigned int keylen)
+{
+	switch (keylen) {
+	case AES_KEYSIZE_128:
+		return 10;
+	case AES_KEYSIZE_192:
+		return 12;
+	case AES_KEYSIZE_256:
+		return 14;
+	default:
+		return 0;
+	}
+}
+
+int riscv64_aes_setkey(struct riscv64_aes_ctx *ctx, const u8 *key,
+		       unsigned int keylen)
+{
+	/*
+	 * The RISC-V AES vector crypto key expending doesn't support AES-192.
+	 * We just use the generic software key expending here to simplify the key
+	 * expending flow.
+	 */
+	u32 aes_rounds;
+	u32 key_length;
+	int ret;
+
+	ret = aes_expandkey(&ctx->fallback_ctx, key, keylen);
+	if (ret < 0)
+		return -EINVAL;
+
+	/*
+	 * Copy the key from `crypto_aes_ctx` to `aes_key` for zvkned-based AES
+	 * implementations.
+	 */
+	aes_rounds = aes_round_num(keylen);
+	ctx->key.rounds = aes_rounds;
+	key_length = AES_BLOCK_SIZE * (aes_rounds + 1);
+	memcpy(ctx->key.key, ctx->fallback_ctx.key_enc, key_length);
+
+	return 0;
+}
+
+void riscv64_aes_encrypt_zvkned(const struct riscv64_aes_ctx *ctx, u8 *dst,
+				const u8 *src)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		rv64i_zvkned_encrypt(src, dst, &ctx->key);
+		kernel_vector_end();
+	} else {
+		aes_encrypt(&ctx->fallback_ctx, dst, src);
+	}
+}
+
+void riscv64_aes_decrypt_zvkned(const struct riscv64_aes_ctx *ctx, u8 *dst,
+				const u8 *src)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		rv64i_zvkned_decrypt(src, dst, &ctx->key);
+		kernel_vector_end();
+	} else {
+		aes_decrypt(&ctx->fallback_ctx, dst, src);
+	}
+}
+
+static int aes_setkey(struct crypto_tfm *tfm, const u8 *key,
+		      unsigned int keylen)
+{
+	struct riscv64_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	return riscv64_aes_setkey(ctx, key, keylen);
+}
+
+static void aes_encrypt_zvkned(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct riscv64_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	riscv64_aes_encrypt_zvkned(ctx, dst, src);
+}
+
+static void aes_decrypt_zvkned(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct riscv64_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	riscv64_aes_decrypt_zvkned(ctx, dst, src);
+}
+
+static struct crypto_alg riscv64_aes_alg_zvkned = {
+	.cra_name = "aes",
+	.cra_driver_name = "aes-riscv64-zvkned",
+	.cra_module = THIS_MODULE,
+	.cra_priority = 300,
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize = AES_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct riscv64_aes_ctx),
+	.cra_cipher = {
+		.cia_min_keysize = AES_MIN_KEY_SIZE,
+		.cia_max_keysize = AES_MAX_KEY_SIZE,
+		.cia_setkey = aes_setkey,
+		.cia_encrypt = aes_encrypt_zvkned,
+		.cia_decrypt = aes_decrypt_zvkned,
+	},
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
+	if (check_aes_ext())
+		crypto_unregister_alg(&riscv64_aes_alg_zvkned);
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
index 000000000000..7f1f675aca0d
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef AES_RISCV64_GLUE_H
+#define AES_RISCV64_GLUE_H
+
+#include <crypto/aes.h>
+#include <linux/types.h>
+
+struct aes_key {
+	u32 key[AES_MAX_KEYLENGTH_U32];
+	u32 rounds;
+};
+
+struct riscv64_aes_ctx {
+	struct aes_key key;
+	struct crypto_aes_ctx fallback_ctx;
+};
+
+int riscv64_aes_setkey(struct riscv64_aes_ctx *ctx, const u8 *key,
+		       unsigned int keylen);
+
+void riscv64_aes_encrypt_zvkned(const struct riscv64_aes_ctx *ctx, u8 *dst,
+				const u8 *src);
+
+void riscv64_aes_decrypt_zvkned(const struct riscv64_aes_ctx *ctx, u8 *dst,
+				const u8 *src);
+
+#endif /* AES_RISCV64_GLUE_H */
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl b/arch/riscv/crypto/aes-riscv64-zvkned.pl
new file mode 100644
index 000000000000..c0ecde77bf56
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
@@ -0,0 +1,451 @@
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
+# void rv64i_zvkned_encrypt(const unsigned char *in, unsigned char *out,
+#                           const AES_KEY *key);
+my ($INP, $OUTP, $KEYP) = ("a0", "a1", "a2");
+my ($T0, $T1, $ROUNDS, $T6) = ("a3", "a4", "t5", "t6");
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_encrypt
+.type rv64i_zvkned_encrypt,\@function
+rv64i_zvkned_encrypt:
+    # Load number of rounds
+    lwu $ROUNDS, 240($KEYP)
+
+    # Get proper routine for key size
+    li $T6, 14
+    beq $ROUNDS, $T6, L_enc_256
+    li $T6, 10
+    beq $ROUNDS, $T6, L_enc_128
+    li $T6, 12
+    beq $ROUNDS, $T6, L_enc_192
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
+    @{[vle32_v $V1, ($INP)]}
+
+    @{[vle32_v $V10, ($KEYP)]}
+    @{[vaesz_vs $V1, $V10]}    # with round key w[ 0, 3]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, ($KEYP)]}
+    @{[vaesem_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, ($KEYP)]}
+    @{[vaesem_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, ($KEYP)]}
+    @{[vaesem_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, ($KEYP)]}
+    @{[vaesem_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, ($KEYP)]}
+    @{[vaesem_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V16, ($KEYP)]}
+    @{[vaesem_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V17, ($KEYP)]}
+    @{[vaesem_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V18, ($KEYP)]}
+    @{[vaesem_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V19, ($KEYP)]}
+    @{[vaesem_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V20, ($KEYP)]}
+    @{[vaesef_vs $V1, $V20]}   # with round key w[40,43]
+
+    @{[vse32_v $V1, ($OUTP)]}
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
+    @{[vle32_v $V1, ($INP)]}
+
+    @{[vle32_v $V10, ($KEYP)]}
+    @{[vaesz_vs $V1, $V10]}     # with round key w[ 0, 3]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, ($KEYP)]}
+    @{[vaesem_vs $V1, $V11]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, ($KEYP)]}
+    @{[vaesem_vs $V1, $V12]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, ($KEYP)]}
+    @{[vaesem_vs $V1, $V13]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, ($KEYP)]}
+    @{[vaesem_vs $V1, $V14]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, ($KEYP)]}
+    @{[vaesem_vs $V1, $V15]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V16, ($KEYP)]}
+    @{[vaesem_vs $V1, $V16]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V17, ($KEYP)]}
+    @{[vaesem_vs $V1, $V17]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V18, ($KEYP)]}
+    @{[vaesem_vs $V1, $V18]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V19, ($KEYP)]}
+    @{[vaesem_vs $V1, $V19]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V20, ($KEYP)]}
+    @{[vaesem_vs $V1, $V20]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V21, ($KEYP)]}
+    @{[vaesem_vs $V1, $V21]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V22, ($KEYP)]}
+    @{[vaesef_vs $V1, $V22]}
+
+    @{[vse32_v $V1, ($OUTP)]}
+    ret
+.size L_enc_192,.-L_enc_192
+___
+
+$code .= <<___;
+.p2align 3
+L_enc_256:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+
+    @{[vle32_v $V1, ($INP)]}
+
+    @{[vle32_v $V10, ($KEYP)]}
+    @{[vaesz_vs $V1, $V10]}     # with round key w[ 0, 3]
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V11, ($KEYP)]}
+    @{[vaesem_vs $V1, $V11]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V12, ($KEYP)]}
+    @{[vaesem_vs $V1, $V12]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V13, ($KEYP)]}
+    @{[vaesem_vs $V1, $V13]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V14, ($KEYP)]}
+    @{[vaesem_vs $V1, $V14]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V15, ($KEYP)]}
+    @{[vaesem_vs $V1, $V15]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V16, ($KEYP)]}
+    @{[vaesem_vs $V1, $V16]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V17, ($KEYP)]}
+    @{[vaesem_vs $V1, $V17]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V18, ($KEYP)]}
+    @{[vaesem_vs $V1, $V18]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V19, ($KEYP)]}
+    @{[vaesem_vs $V1, $V19]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V20, ($KEYP)]}
+    @{[vaesem_vs $V1, $V20]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V21, ($KEYP)]}
+    @{[vaesem_vs $V1, $V21]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V22, ($KEYP)]}
+    @{[vaesem_vs $V1, $V22]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V23, ($KEYP)]}
+    @{[vaesem_vs $V1, $V23]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $V24, ($KEYP)]}
+    @{[vaesef_vs $V1, $V24]}
+
+    @{[vse32_v $V1, ($OUTP)]}
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
+    # Load number of rounds
+    lwu $ROUNDS, 240($KEYP)
+
+    # Get proper routine for key size
+    li $T6, 14
+    beq $ROUNDS, $T6, L_dec_256
+    li $T6, 10
+    beq $ROUNDS, $T6, L_dec_128
+    li $T6, 12
+    beq $ROUNDS, $T6, L_dec_192
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
+    @{[vle32_v $V1, ($INP)]}
+
+    addi $KEYP, $KEYP, 160
+    @{[vle32_v $V20, ($KEYP)]}
+    @{[vaesz_vs $V1, $V20]}    # with round key w[40,43]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V19, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V18, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V17, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V16, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V15, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V14, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V13, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V12, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V11, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V10, ($KEYP)]}
+    @{[vaesdf_vs $V1, $V10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $V1, ($OUTP)]}
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
+    @{[vle32_v $V1, ($INP)]}
+
+    addi $KEYP, $KEYP, 192
+    @{[vle32_v $V22, ($KEYP)]}
+    @{[vaesz_vs $V1, $V22]}    # with round key w[48,51]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V21, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V21]}   # with round key w[44,47]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V20, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V20]}    # with round key w[40,43]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V19, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V18, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V17, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V16, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V15, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V14, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V13, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V12, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V11, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V10, ($KEYP)]}
+    @{[vaesdf_vs $V1, $V10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $V1, ($OUTP)]}
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
+    @{[vle32_v $V1, ($INP)]}
+
+    addi $KEYP, $KEYP, 224
+    @{[vle32_v $V24, ($KEYP)]}
+    @{[vaesz_vs $V1, $V24]}    # with round key w[56,59]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V23, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V23]}   # with round key w[52,55]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V22, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V22]}    # with round key w[48,51]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V21, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V21]}   # with round key w[44,47]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V20, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V20]}    # with round key w[40,43]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V19, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V19]}   # with round key w[36,39]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V18, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V18]}   # with round key w[32,35]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V17, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V17]}   # with round key w[28,31]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V16, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V16]}   # with round key w[24,27]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V15, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V15]}   # with round key w[20,23]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V14, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V14]}   # with round key w[16,19]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V13, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V13]}   # with round key w[12,15]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V12, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V12]}   # with round key w[ 8,11]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V11, ($KEYP)]}
+    @{[vaesdm_vs $V1, $V11]}   # with round key w[ 4, 7]
+    addi $KEYP, $KEYP, -16
+    @{[vle32_v $V10, ($KEYP)]}
+    @{[vaesdf_vs $V1, $V10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $V1, ($OUTP)]}
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

