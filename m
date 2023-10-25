Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AAC7D7367
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJYSiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjJYSha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:37:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F61AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578b4997decso90694a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698259044; x=1698863844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3sIOyZ5p5Uajadw8K50qTKq2/dD0THvRCAR8HIfH6Y=;
        b=XIUuc6JC9IEcYhaNy7CMwVUskbHCU2XMO8aw1FKHweCDXRt1gf9UclnzkTl7biWcFA
         YCzDDfCL19ZNAZai1w1AYpG8f8jaEoHBuYBg1jPjLFGFqgjyiiYTryK0rxu5jcoR2Kmg
         vPdzMRDF0olZgEb+szIZmbq2QaYbxGcny7TADBdPazTqR1uod/AtaiedZd2c9gLFrLPU
         l6RmudDLPYQqSGHFMlxg9jM4A2HsUKYhSM1ms0PtLoqBqeQLA16NTElti29R7BgVVfy2
         lDZp/nWfN4gTu4KOHNWa8brX+cyddpdNKrx7mAjzxWtYtc8voUA77FlzlX5QX+w46T96
         e5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259044; x=1698863844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3sIOyZ5p5Uajadw8K50qTKq2/dD0THvRCAR8HIfH6Y=;
        b=H+v5JTBgXLL/CG1lz0dy0mOc046ngwVfaaqnb/Il5/j6erukvyginvewHcm6FG949/
         HTdLhaexQoVBjPn5n/KoxZSzt+i1B4o4JTsPIZs8fTokT/vR6B8ne6VOnVdkoI2wa3Pn
         XS5SONVsaOUCHbhIfO7WjZdWl9ADbt/LNdzRImuAHhbgqO8QWtPtysGTuat4rVywBXDz
         0IQnZP83eR6TdtgZZgYJaFpEYuYJlRKMUMHhBpY9mTTkw0AVHJvcRKfpSyPJy1GYWsn4
         enW4eFJiNXMWWa15lpzmmyqOGBLyAA1xsQyMLe3fr6R0WaGJZ0yLDguSY+PA+st1bcR3
         KyIg==
X-Gm-Message-State: AOJu0YzvkqHU4GT8yG+xMLYVOtMGs7uBlngCMj5wmMUNLo/QX7HSxyEP
        bDbufq77QWPQDuvn6xnN4FPBRg==
X-Google-Smtp-Source: AGHT+IGu8yxKc9K1usDnSzC0aQvB+RBgSE4w4NZky1E/bDehLZ+KuUk4ZVCDlNGg1awjDL3F+ZoeYA==
X-Received: by 2002:a17:90b:288e:b0:27d:7f1b:1bec with SMTP id qc14-20020a17090b288e00b0027d7f1b1becmr14664038pjb.35.1698259044137;
        Wed, 25 Oct 2023 11:37:24 -0700 (PDT)
Received: from localhost.localdomain ([49.216.222.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adb0300b00278f1512dd9sm212367pjv.32.2023.10.25.11.37.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:37:23 -0700 (PDT)
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
Subject: [PATCH 07/12] RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
Date:   Thu, 26 Oct 2023 02:36:39 +0800
Message-Id: <20231025183644.8735-8-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231025183644.8735-1-jerry.shih@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a gcm hash implementation using the Zvkg extension from OpenSSL
(openssl/openssl#21923).

The perlasm here is different from the original implementation in OpenSSL.
The OpenSSL assumes that the H is stored in little-endian. Thus, it needs
to convert the H to big-endian for Zvkg instructions. In kernel, we have
the big-endian H directly. There is no need for endian conversion.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/crypto/Kconfig               |  14 ++
 arch/riscv/crypto/Makefile              |   7 +
 arch/riscv/crypto/ghash-riscv64-glue.c  | 191 ++++++++++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl | 100 +++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index dfa9d0146d26..00be7177eb1e 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -35,4 +35,18 @@ config CRYPTO_AES_BLOCK_RISCV64
 	  - Zvkg vector crypto extension (XTS)
 	  - Zvkned vector crypto extension
 
+config CRYPTO_GHASH_RISCV64
+	default y if RISCV_ISA_V
+	tristate "Hash functions: GHASH"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_GCM
+	select CRYPTO_GHASH
+	select CRYPTO_HASH
+	select CRYPTO_LIB_GF128MUL
+	help
+	  GCM GHASH function (NIST SP 800-38D)
+
+	  Architecture: riscv64 using:
+	  - Zvkg vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 42a4e8ec79cf..532316cc1758 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,6 +9,9 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
 aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvbb-zvkg-zvkned.o aes-riscv64-zvkb-zvkned.o
 
+obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
+ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -21,6 +24,10 @@ $(obj)/aes-riscv64-zvbb-zvkg-zvkned.S: $(src)/aes-riscv64-zvbb-zvkg-zvkned.pl
 $(obj)/aes-riscv64-zvkb-zvkned.S: $(src)/aes-riscv64-zvkb-zvkned.pl
 	$(call cmd,perlasm)
 
+$(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvbb-zvkg-zvkned.S
 clean-files += aes-riscv64-zvkb-zvkned.S
+clean-files += ghash-riscv64-zvkg.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
new file mode 100644
index 000000000000..d5b7f0e4f612
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V optimized GHASH routines
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
+#include <crypto/ghash.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+/* ghash using zvkg vector crypto extension */
+void gcm_ghash_rv64i_zvkg(be128 *Xi, const be128 *H, const u8 *inp, size_t len);
+
+struct riscv64_ghash_context {
+	be128 key;
+};
+
+struct riscv64_ghash_desc_ctx {
+	be128 shash;
+	u8 buffer[GHASH_BLOCK_SIZE];
+	u32 bytes;
+};
+
+typedef void (*ghash_func)(be128 *Xi, const be128 *H, const u8 *inp,
+			   size_t len);
+
+static inline void ghash_blocks(const struct riscv64_ghash_context *ctx,
+				struct riscv64_ghash_desc_ctx *dctx,
+				const u8 *src, size_t srclen, ghash_func func)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		func(&dctx->shash, &ctx->key, src, srclen);
+		kernel_vector_end();
+	} else {
+		while (srclen >= GHASH_BLOCK_SIZE) {
+			crypto_xor((u8 *)&dctx->shash, src, GHASH_BLOCK_SIZE);
+			gf128mul_lle(&dctx->shash, &ctx->key);
+			srclen -= GHASH_BLOCK_SIZE;
+			src += GHASH_BLOCK_SIZE;
+		}
+	}
+}
+
+static int ghash_update(struct shash_desc *desc, const u8 *src, size_t srclen,
+			ghash_func func)
+{
+	size_t len;
+	const struct riscv64_ghash_context *ctx =
+		crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (dctx->bytes) {
+		if (dctx->bytes + srclen < GHASH_BLOCK_SIZE) {
+			memcpy(dctx->buffer + dctx->bytes, src, srclen);
+			dctx->bytes += srclen;
+			return 0;
+		}
+		memcpy(dctx->buffer + dctx->bytes, src,
+		       GHASH_BLOCK_SIZE - dctx->bytes);
+
+		ghash_blocks(ctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE, func);
+
+		src += GHASH_BLOCK_SIZE - dctx->bytes;
+		srclen -= GHASH_BLOCK_SIZE - dctx->bytes;
+		dctx->bytes = 0;
+	}
+	len = srclen & ~(GHASH_BLOCK_SIZE - 1);
+
+	if (len) {
+		ghash_blocks(ctx, dctx, src, len, func);
+		src += len;
+		srclen -= len;
+	}
+
+	if (srclen) {
+		memcpy(dctx->buffer, src, srclen);
+		dctx->bytes = srclen;
+	}
+
+	return 0;
+}
+
+static int ghash_final(struct shash_desc *desc, u8 *out, ghash_func func)
+{
+	const struct riscv64_ghash_context *ctx =
+		crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+	int i;
+
+	if (dctx->bytes) {
+		for (i = dctx->bytes; i < GHASH_BLOCK_SIZE; i++)
+			dctx->buffer[i] = 0;
+
+		ghash_blocks(ctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE, func);
+		dctx->bytes = 0;
+	}
+
+	memcpy(out, &dctx->shash, GHASH_DIGEST_SIZE);
+
+	return 0;
+}
+
+static int ghash_init(struct shash_desc *desc)
+{
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	*dctx = (struct riscv64_ghash_desc_ctx){};
+
+	return 0;
+}
+
+static int ghash_update_zvkg(struct shash_desc *desc, const u8 *src,
+			     unsigned int srclen)
+{
+	return ghash_update(desc, src, srclen, gcm_ghash_rv64i_zvkg);
+}
+
+static int ghash_final_zvkg(struct shash_desc *desc, u8 *out)
+{
+	return ghash_final(desc, out, gcm_ghash_rv64i_zvkg);
+}
+
+static int ghash_setkey(struct crypto_shash *tfm, const u8 *key,
+			unsigned int keylen)
+{
+	struct riscv64_ghash_context *ctx =
+		crypto_tfm_ctx(crypto_shash_tfm(tfm));
+
+	if (keylen != GHASH_BLOCK_SIZE)
+		return -EINVAL;
+
+	memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);
+
+	return 0;
+}
+
+static struct shash_alg riscv64_ghash_alg_zvkg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = ghash_init,
+	.update = ghash_update_zvkg,
+	.final = ghash_final_zvkg,
+	.setkey = ghash_setkey,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx),
+	.base = {
+		.cra_name = "ghash",
+		.cra_driver_name = "ghash-riscv64-zvkg",
+		.cra_priority = 303,
+		.cra_blocksize = GHASH_BLOCK_SIZE,
+		.cra_ctxsize = sizeof(struct riscv64_ghash_context),
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static inline bool check_ghash_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKG) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_ghash_mod_init(void)
+{
+	if (check_ghash_ext())
+		return crypto_register_shash(&riscv64_ghash_alg_zvkg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_ghash_mod_fini(void)
+{
+	if (check_ghash_ext())
+		crypto_unregister_shash(&riscv64_ghash_alg_zvkg);
+}
+
+module_init(riscv64_ghash_mod_init);
+module_exit(riscv64_ghash_mod_fini);
+
+MODULE_DESCRIPTION("GCM GHASH (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/riscv/crypto/ghash-riscv64-zvkg.pl b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
new file mode 100644
index 000000000000..4beea4ac9cbe
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
@@ -0,0 +1,100 @@
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
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector GCM/GMAC extension ('Zvkg')
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
+###############################################################################
+# void gcm_ghash_rv64i_zvkg(be128 *Xi, const be128 *H, const u8 *inp, size_t len)
+#
+# input: Xi: current hash value
+#        H: hash key
+#        inp: pointer to input data
+#        len: length of input data in bytes (multiple of block size)
+# output: Xi: Xi+1 (next hash value Xi)
+{
+my ($Xi,$H,$inp,$len) = ("a0","a1","a2","a3");
+my ($vXi,$vH,$vinp,$Vzero) = ("v1","v2","v3","v4");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zvkg
+.type gcm_ghash_rv64i_zvkg,\@function
+gcm_ghash_rv64i_zvkg:
+    @{[vsetivli "zero", 4, "e32", "m1", "ta", "ma"]}
+    @{[vle32_v $vH, $H]}
+    @{[vle32_v $vXi, $Xi]}
+
+Lstep:
+    @{[vle32_v $vinp, $inp]}
+    add $inp, $inp, 16
+    add $len, $len, -16
+    @{[vghsh_vv $vXi, $vH, $vinp]}
+    bnez $len, Lstep
+
+    @{[vse32_v $vXi, $Xi]}
+    ret
+
+.size gcm_ghash_rv64i_zvkg,.-gcm_ghash_rv64i_zvkg
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0

