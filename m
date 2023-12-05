Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0A804DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjLEJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjLEJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:28:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF06283
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:28:47 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b8b1a50889so897036b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701768527; x=1702373327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwTD3K4Kri8m1i9JXNKcf7GR1NP3fxv8EZuVIRyXFX8=;
        b=bhdsu1LagEGVWzclMWB36+uwnnv27DdDJnLYlapjH4BCxHfN+zsKLiH3mNSlYeQFiy
         o4xTihu2gMaKCz0ZJeAo0R3wmVik95qSJcw9raW5ATQXqXqfwunoXgmd4dfMyusZl/wq
         d61XkCNwNdDOM4w2PwQIzDL/jCF9bOduIkeSyamwqp6cCwH4R5n/YuSVqFNLLuSBHqRK
         up1B2rseD0Hoy5m1OTW6tRKcFgJwB42EK82oxXYWcabX4fv0xyTtM8x1mBP+0mZKd4ls
         STrRm6dLmqb/f8G1iHWpLJ0HHhZ3s/CvuvaxEscmYNOOfoOJGoMhXg6fEEDY+YjWxCRT
         MR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768527; x=1702373327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwTD3K4Kri8m1i9JXNKcf7GR1NP3fxv8EZuVIRyXFX8=;
        b=cSzFxdXo13eHfAC16nEyy78eZ8uv82P2NxPAYBiXAf8osjedImgrzehr8n2BHS/bkv
         IVsJitvJxI4kLYLTzpIsscsdyLq64FJBv5RymQb7LCfHKTfyDF/fh0gXX8DhayIRVWvi
         YF4HmwFJsAXR58OLRrnxJd4ItqUhI9jWCacSYB+IHGtGxQ11Jf/96hDmfM9yPa7ESUPV
         +07Z+eXOQI0sN72IjeYIIfjgLvZtzEyCbH4HwUKpKwIt5oTgialxv5zd8YhnguexylDN
         8SQfHjCRjkEIAoWhAGRkhbNLCqbJcdg+kg8SMI4dPqWtS504LTO5Zwl9Bm2qj38d7SVz
         6OjQ==
X-Gm-Message-State: AOJu0Yy3JfWlDopDEsZfAmWekMWJUBmWGfsadT77BvaLfcl9R1QbrekM
        hiHWkz2frmyz0Yag1mEVZEln4w==
X-Google-Smtp-Source: AGHT+IHaxRimNT55Tc1y3Gj+N2olyd5vW1SYGP6ul/rhUm7Gt0MY9M6MMzSLbKlun+CgGu3jnR/8Pg==
X-Received: by 2002:a05:6808:1990:b0:3b8:b063:8935 with SMTP id bj16-20020a056808199000b003b8b0638935mr3497663oib.67.1701768526882;
        Tue, 05 Dec 2023 01:28:46 -0800 (PST)
Received: from localhost.localdomain ([101.10.93.135])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006cdd723bb6fsm8858788pfu.115.2023.12.05.01.28.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 01:28:46 -0800 (PST)
From:   Jerry Shih <jerry.shih@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, conor@kernel.org
Cc:     heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 10/12] RISC-V: crypto: add Zvksed accelerated SM4 implementation
Date:   Tue,  5 Dec 2023 17:27:59 +0800
Message-Id: <20231205092801.1335-11-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM4 implementation using Zvksed vector crypto extension from OpenSSL
(openssl/openssl#21923).

The perlasm here is different from the original implementation in OpenSSL.
In OpenSSL, SM4 has the separated set_encrypt_key and set_decrypt_key
functions. In kernel, these set_key functions are merged into a single
one in order to skip the redundant key expanding instructions.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v3:
 - Use asm mnemonics for the instructions in RVV 1.0 extension.

Changelog v2:
 - Do not turn on kconfig `SM4_RISCV64` option by default.
 - Add the missed `static` declaration for riscv64_sm4_zvksed_alg.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Rename sm4-riscv64-zvkb-zvksed to sm4-riscv64-zvksed-zvkb.
 - Reorder structure riscv64_sm4_zvksed_zvkb_alg members initialization
   in the order declared.
---
 arch/riscv/crypto/Kconfig               |  17 ++
 arch/riscv/crypto/Makefile              |   7 +
 arch/riscv/crypto/sm4-riscv64-glue.c    | 121 +++++++++++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl | 268 ++++++++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index ad0b08a13c9a..b28cf1972250 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -66,4 +66,21 @@ config CRYPTO_SHA512_RISCV64
 	  - Zvknhb vector crypto extension
 	  - Zvkb vector crypto extension
 
+config CRYPTO_SM4_RISCV64
+	tristate "Ciphers: SM4 (ShangMi 4)"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016,
+	  ISO/IEC 18033-3:2010/Amd 1:2021)
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  Architecture: riscv64 using:
+	  - Zvksed vector crypto extension
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 8aabef950ad3..8e34861bba34 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -18,6 +18,9 @@ sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
 
+obj-$(CONFIG_CRYPTO_SM4_RISCV64) += sm4-riscv64.o
+sm4-riscv64-y := sm4-riscv64-glue.o sm4-riscv64-zvksed.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -39,9 +42,13 @@ $(obj)/sha256-riscv64-zvknha_or_zvknhb-zvkb.S: $(src)/sha256-riscv64-zvknha_or_z
 $(obj)/sha512-riscv64-zvknhb-zvkb.S: $(src)/sha512-riscv64-zvknhb-zvkb.pl
 	$(call cmd,perlasm)
 
+$(obj)/sm4-riscv64-zvksed.S: $(src)/sm4-riscv64-zvksed.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
 clean-files += aes-riscv64-zvkned-zvkb.S
 clean-files += ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha_or_zvknhb-zvkb.S
 clean-files += sha512-riscv64-zvknhb-zvkb.S
+clean-files += sm4-riscv64-zvksed.S
diff --git a/arch/riscv/crypto/sm4-riscv64-glue.c b/arch/riscv/crypto/sm4-riscv64-glue.c
new file mode 100644
index 000000000000..9d9d24b67ee3
--- /dev/null
+++ b/arch/riscv/crypto/sm4-riscv64-glue.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Linux/riscv64 port of the OpenSSL SM4 implementation for RISC-V 64
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
+#include <crypto/sm4.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/simd.h>
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+/* sm4 using zvksed vector crypto extension */
+asmlinkage void rv64i_zvksed_sm4_encrypt(const u8 *in, u8 *out, const u32 *key);
+asmlinkage void rv64i_zvksed_sm4_decrypt(const u8 *in, u8 *out, const u32 *key);
+asmlinkage int rv64i_zvksed_sm4_set_key(const u8 *user_key,
+					unsigned int key_len, u32 *enc_key,
+					u32 *dec_key);
+
+static int riscv64_sm4_setkey_zvksed(struct crypto_tfm *tfm, const u8 *key,
+				     unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret = 0;
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (rv64i_zvksed_sm4_set_key(key, key_len, ctx->rkey_enc,
+					     ctx->rkey_dec))
+			ret = -EINVAL;
+		kernel_vector_end();
+	} else {
+		ret = sm4_expandkey(ctx, key, key_len);
+	}
+
+	return ret;
+}
+
+static void riscv64_sm4_encrypt_zvksed(struct crypto_tfm *tfm, u8 *dst,
+				       const u8 *src)
+{
+	const struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		rv64i_zvksed_sm4_encrypt(src, dst, ctx->rkey_enc);
+		kernel_vector_end();
+	} else {
+		sm4_crypt_block(ctx->rkey_enc, dst, src);
+	}
+}
+
+static void riscv64_sm4_decrypt_zvksed(struct crypto_tfm *tfm, u8 *dst,
+				       const u8 *src)
+{
+	const struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		rv64i_zvksed_sm4_decrypt(src, dst, ctx->rkey_dec);
+		kernel_vector_end();
+	} else {
+		sm4_crypt_block(ctx->rkey_dec, dst, src);
+	}
+}
+
+static struct crypto_alg riscv64_sm4_zvksed_zvkb_alg = {
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize = SM4_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct sm4_ctx),
+	.cra_priority = 300,
+	.cra_name = "sm4",
+	.cra_driver_name = "sm4-riscv64-zvksed-zvkb",
+	.cra_cipher = {
+		.cia_min_keysize = SM4_KEY_SIZE,
+		.cia_max_keysize = SM4_KEY_SIZE,
+		.cia_setkey = riscv64_sm4_setkey_zvksed,
+		.cia_encrypt = riscv64_sm4_encrypt_zvksed,
+		.cia_decrypt = riscv64_sm4_decrypt_zvksed,
+	},
+	.cra_module = THIS_MODULE,
+};
+
+static inline bool check_sm4_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKSED) &&
+	       riscv_isa_extension_available(NULL, ZVKB) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_sm4_mod_init(void)
+{
+	if (check_sm4_ext())
+		return crypto_register_alg(&riscv64_sm4_zvksed_zvkb_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sm4_mod_fini(void)
+{
+	crypto_unregister_alg(&riscv64_sm4_zvksed_zvkb_alg);
+}
+
+module_init(riscv64_sm4_mod_init);
+module_exit(riscv64_sm4_mod_fini);
+
+MODULE_DESCRIPTION("SM4 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sm4");
diff --git a/arch/riscv/crypto/sm4-riscv64-zvksed.pl b/arch/riscv/crypto/sm4-riscv64-zvksed.pl
new file mode 100644
index 000000000000..5669a3b38944
--- /dev/null
+++ b/arch/riscv/crypto/sm4-riscv64-zvksed.pl
@@ -0,0 +1,268 @@
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
+# The generated code of this file depends on the following RISC-V extensions:
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+# - RISC-V Vector SM4 Block Cipher extension ('Zvksed')
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
+####
+# int rv64i_zvksed_sm4_set_key(const u8 *user_key, unsigned int key_len,
+#			                         u32 *enc_key, u32 *dec_key);
+#
+{
+my ($ukey,$key_len,$enc_key,$dec_key)=("a0","a1","a2","a3");
+my ($fk,$stride)=("a4","a5");
+my ($t0,$t1)=("t0","t1");
+my ($vukey,$vfk,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_set_key
+.type rv64i_zvksed_sm4_set_key,\@function
+rv64i_zvksed_sm4_set_key:
+    li $t0, 16
+    beq $t0, $key_len, 1f
+    li a0, 1
+    ret
+1:
+
+    vsetivli zero, 4, e32, m1, ta, ma
+
+    # Load the user key
+    vle32.v $vukey, ($ukey)
+    @{[vrev8_v $vukey, $vukey]}
+
+    # Load the FK.
+    la $fk, FK
+    vle32.v $vfk, ($fk)
+
+    # Generate round keys.
+    vxor.vv $vukey, $vukey, $vfk
+    @{[vsm4k_vi $vk0, $vukey, 0]} # rk[0:3]
+    @{[vsm4k_vi $vk1, $vk0, 1]} # rk[4:7]
+    @{[vsm4k_vi $vk2, $vk1, 2]} # rk[8:11]
+    @{[vsm4k_vi $vk3, $vk2, 3]} # rk[12:15]
+    @{[vsm4k_vi $vk4, $vk3, 4]} # rk[16:19]
+    @{[vsm4k_vi $vk5, $vk4, 5]} # rk[20:23]
+    @{[vsm4k_vi $vk6, $vk5, 6]} # rk[24:27]
+    @{[vsm4k_vi $vk7, $vk6, 7]} # rk[28:31]
+
+    # Store enc round keys
+    vse32.v $vk0, ($enc_key) # rk[0:3]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk1, ($enc_key) # rk[4:7]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk2, ($enc_key) # rk[8:11]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk3, ($enc_key) # rk[12:15]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk4, ($enc_key) # rk[16:19]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk5, ($enc_key) # rk[20:23]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk6, ($enc_key) # rk[24:27]
+    addi $enc_key, $enc_key, 16
+    vse32.v $vk7, ($enc_key) # rk[28:31]
+
+    # Store dec round keys in reverse order
+    addi $dec_key, $dec_key, 12
+    li $stride, -4
+    vsse32.v $vk7, ($dec_key), $stride # rk[31:28]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk6, ($dec_key), $stride # rk[27:24]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk5, ($dec_key), $stride # rk[23:20]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk4, ($dec_key), $stride # rk[19:16]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk3, ($dec_key), $stride # rk[15:12]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk2, ($dec_key), $stride # rk[11:8]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk1, ($dec_key), $stride # rk[7:4]
+    addi $dec_key, $dec_key, 16
+    vsse32.v $vk0, ($dec_key), $stride # rk[3:0]
+
+    li a0, 0
+    ret
+.size rv64i_zvksed_sm4_set_key,.-rv64i_zvksed_sm4_set_key
+___
+}
+
+####
+# void rv64i_zvksed_sm4_encrypt(const unsigned char *in, unsigned char *out,
+#                               const SM4_KEY *key);
+#
+{
+my ($in,$out,$keys,$stride)=("a0","a1","a2","t0");
+my ($vdata,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7,$vgen)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_encrypt
+.type rv64i_zvksed_sm4_encrypt,\@function
+rv64i_zvksed_sm4_encrypt:
+    vsetivli zero, 4, e32, m1, ta, ma
+
+    # Load input data
+    vle32.v $vdata, ($in)
+    @{[vrev8_v $vdata, $vdata]}
+
+    # Order of elements was adjusted in sm4_set_key()
+    # Encrypt with all keys
+    vle32.v $vk0, ($keys) # rk[0:3]
+    @{[vsm4r_vs $vdata, $vk0]}
+    addi $keys, $keys, 16
+    vle32.v $vk1, ($keys) # rk[4:7]
+    @{[vsm4r_vs $vdata, $vk1]}
+    addi $keys, $keys, 16
+    vle32.v $vk2, ($keys) # rk[8:11]
+    @{[vsm4r_vs $vdata, $vk2]}
+    addi $keys, $keys, 16
+    vle32.v $vk3, ($keys) # rk[12:15]
+    @{[vsm4r_vs $vdata, $vk3]}
+    addi $keys, $keys, 16
+    vle32.v $vk4, ($keys) # rk[16:19]
+    @{[vsm4r_vs $vdata, $vk4]}
+    addi $keys, $keys, 16
+    vle32.v $vk5, ($keys) # rk[20:23]
+    @{[vsm4r_vs $vdata, $vk5]}
+    addi $keys, $keys, 16
+    vle32.v $vk6, ($keys) # rk[24:27]
+    @{[vsm4r_vs $vdata, $vk6]}
+    addi $keys, $keys, 16
+    vle32.v $vk7, ($keys) # rk[28:31]
+    @{[vsm4r_vs $vdata, $vk7]}
+
+    # Save the ciphertext (in reverse element order)
+    @{[vrev8_v $vdata, $vdata]}
+    li $stride, -4
+    addi $out, $out, 12
+    vsse32.v $vdata, ($out), $stride
+
+    ret
+.size rv64i_zvksed_sm4_encrypt,.-rv64i_zvksed_sm4_encrypt
+___
+}
+
+####
+# void rv64i_zvksed_sm4_decrypt(const unsigned char *in, unsigned char *out,
+#                               const SM4_KEY *key);
+#
+{
+my ($in,$out,$keys,$stride)=("a0","a1","a2","t0");
+my ($vdata,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7,$vgen)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_decrypt
+.type rv64i_zvksed_sm4_decrypt,\@function
+rv64i_zvksed_sm4_decrypt:
+    vsetivli zero, 4, e32, m1, ta, ma
+
+    # Load input data
+    vle32.v $vdata, ($in)
+    @{[vrev8_v $vdata, $vdata]}
+
+    # Order of key elements was adjusted in sm4_set_key()
+    # Decrypt with all keys
+    vle32.v $vk7, ($keys) # rk[31:28]
+    @{[vsm4r_vs $vdata, $vk7]}
+    addi $keys, $keys, 16
+    vle32.v $vk6, ($keys) # rk[27:24]
+    @{[vsm4r_vs $vdata, $vk6]}
+    addi $keys, $keys, 16
+    vle32.v $vk5, ($keys) # rk[23:20]
+    @{[vsm4r_vs $vdata, $vk5]}
+    addi $keys, $keys, 16
+    vle32.v $vk4, ($keys) # rk[19:16]
+    @{[vsm4r_vs $vdata, $vk4]}
+    addi $keys, $keys, 16
+    vle32.v $vk3, ($keys) # rk[15:11]
+    @{[vsm4r_vs $vdata, $vk3]}
+    addi $keys, $keys, 16
+    vle32.v $vk2, ($keys) # rk[11:8]
+    @{[vsm4r_vs $vdata, $vk2]}
+    addi $keys, $keys, 16
+    vle32.v $vk1, ($keys) # rk[7:4]
+    @{[vsm4r_vs $vdata, $vk1]}
+    addi $keys, $keys, 16
+    vle32.v $vk0, ($keys) # rk[3:0]
+    @{[vsm4r_vs $vdata, $vk0]}
+
+    # Save the ciphertext (in reverse element order)
+    @{[vrev8_v $vdata, $vdata]}
+    li $stride, -4
+    addi $out, $out, 12
+    vsse32.v $vdata, ($out), $stride
+
+    ret
+.size rv64i_zvksed_sm4_decrypt,.-rv64i_zvksed_sm4_decrypt
+___
+}
+
+$code .= <<___;
+# Family Key (little-endian 32-bit chunks)
+.p2align 3
+FK:
+    .word 0xA3B1BAC6, 0x56AA3350, 0x677D9197, 0xB27022DC
+.size FK,.-FK
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0

