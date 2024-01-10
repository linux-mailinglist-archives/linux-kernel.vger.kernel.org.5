Return-Path: <linux-kernel+bounces-14099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C368217D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E09FB217D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFF6FBF5;
	Tue,  2 Jan 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeqI+tGk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44FFBE1;
	Tue,  2 Jan 2024 06:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ABAC433C7;
	Tue,  2 Jan 2024 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178238;
	bh=iEYlr2/q24F+OqvdxiGpvnWKSbZkxhoT0btJ3VoUiCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeqI+tGkbmO0+7nv3/sRtv8gCdC5xLaPfNJOZm8A+bk+Or1VY6J7arq393gtk/yQ2
	 UuNJvlQsPX2G8+2YPZk3r1Y7fzgzUVO+TcSKZCSEvSDA2T5uuex48MKMZTXNOkTgyD
	 ZSIizRIar0f8RAwQT7d6gqk9o9mqnjXnNRsEs/m1tu+LP0VusvGLIdqw5OIHxkgP4l
	 TiZ9Yp1r7f7eHLU551WKlj4fskCJvMkvRD3PihRYjjf6y+5gRKmEcxr6qinu34BniQ
	 nqGQnb0XsvA63/eN91U7rTj8IwADbO8pVpsOCFfUo+CDDhVY7Y2HbbmC7g8xtUp8kV
	 A6DVUSbDNGiZA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [RFC PATCH 09/13] crypto: riscv - add vector crypto accelerated GHASH
Date: Tue,  2 Jan 2024 00:47:35 -0600
Message-ID: <20240102064743.220490-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
References: <20240102064743.220490-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jerry Shih <jerry.shih@sifive.com>

Add an implementation of GHASH using the zvkg extension.  The assembly
code is derived from OpenSSL code (openssl/openssl#21923) that was
dual-licensed so that it could be reused in the kernel.  Nevertheless,
the assembly has been significantly reworked for integration with the
kernel, for example by using a regular .S file instead of the so-called
perlasm, using the assembler instead of bare '.inst', reducing code
duplication, and eliminating unnecessary endianness conversions.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig              |  10 ++
 arch/riscv/crypto/Makefile             |   3 +
 arch/riscv/crypto/ghash-riscv64-glue.c | 170 +++++++++++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.S |  72 +++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index d9a6920df9e99..573818bb3e677 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -37,11 +37,21 @@ config CRYPTO_CHACHA_RISCV64
 	tristate "Ciphers: ChaCha"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	help
 	  Length-preserving ciphers: ChaCha20 stream cipher algorithm
 
 	  Architecture: riscv64 using:
 	  - Zvkb vector crypto extension
 
+config CRYPTO_GHASH_RISCV64
+	tristate "Hash functions: GHASH"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_GCM
+	help
+	  GCM GHASH function (NIST SP 800-38D)
+
+	  Architecture: riscv64 using:
+	  - Zvkg vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 7b1e3a3f2041f..d21d3a3fc157c 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -4,10 +4,13 @@
 #
 
 obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
 aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 
 obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
 aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
 obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
 chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
+
+obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
+ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
new file mode 100644
index 0000000000000..d20c929771f05
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GHASH using the RISC-V vector crypto extensions
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
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+asmlinkage void ghash_zvkg(be128 *accumulator, const be128 *key,
+			   const u8 *data, size_t len);
+
+struct riscv64_ghash_tfm_ctx {
+	be128 key;
+};
+
+struct riscv64_ghash_desc_ctx {
+	be128 shash;
+	u8 buffer[GHASH_BLOCK_SIZE];
+	u32 bytes;
+};
+
+static int riscv64_ghash_setkey(struct crypto_shash *tfm, const u8 *key,
+				unsigned int keylen)
+{
+	struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+
+	if (keylen != GHASH_BLOCK_SIZE)
+		return -EINVAL;
+
+	memcpy(&tctx->key, key, GHASH_BLOCK_SIZE);
+
+	return 0;
+}
+
+static int riscv64_ghash_init(struct shash_desc *desc)
+{
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	*dctx = (struct riscv64_ghash_desc_ctx){};
+
+	return 0;
+}
+
+static inline void
+riscv64_ghash_blocks(const struct riscv64_ghash_tfm_ctx *tctx,
+		     struct riscv64_ghash_desc_ctx *dctx,
+		     const u8 *src, size_t srclen)
+{
+	/* The srclen is nonzero and a multiple of 16. */
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		ghash_zvkg(&dctx->shash, &tctx->key, src, srclen);
+		kernel_vector_end();
+	} else {
+		do {
+			crypto_xor((u8 *)&dctx->shash, src, GHASH_BLOCK_SIZE);
+			gf128mul_lle(&dctx->shash, &tctx->key);
+			srclen -= GHASH_BLOCK_SIZE;
+			src += GHASH_BLOCK_SIZE;
+		} while (srclen);
+	}
+}
+
+static int riscv64_ghash_update(struct shash_desc *desc, const u8 *src,
+				unsigned int srclen)
+{
+	size_t len;
+	const struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
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
+		riscv64_ghash_blocks(tctx, dctx, dctx->buffer,
+				     GHASH_BLOCK_SIZE);
+
+		src += GHASH_BLOCK_SIZE - dctx->bytes;
+		srclen -= GHASH_BLOCK_SIZE - dctx->bytes;
+		dctx->bytes = 0;
+	}
+	len = srclen & ~(GHASH_BLOCK_SIZE - 1);
+
+	if (len) {
+		riscv64_ghash_blocks(tctx, dctx, src, len);
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
+static int riscv64_ghash_final(struct shash_desc *desc, u8 *out)
+{
+	const struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+	int i;
+
+	if (dctx->bytes) {
+		for (i = dctx->bytes; i < GHASH_BLOCK_SIZE; i++)
+			dctx->buffer[i] = 0;
+
+		riscv64_ghash_blocks(tctx, dctx, dctx->buffer,
+				     GHASH_BLOCK_SIZE);
+	}
+
+	memcpy(out, &dctx->shash, GHASH_DIGEST_SIZE);
+
+	return 0;
+}
+
+static struct shash_alg riscv64_ghash_alg = {
+	.init = riscv64_ghash_init,
+	.update = riscv64_ghash_update,
+	.final = riscv64_ghash_final,
+	.setkey = riscv64_ghash_setkey,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx),
+	.digestsize = GHASH_DIGEST_SIZE,
+	.base = {
+		.cra_blocksize = GHASH_BLOCK_SIZE,
+		.cra_ctxsize = sizeof(struct riscv64_ghash_tfm_ctx),
+		.cra_priority = 300,
+		.cra_name = "ghash",
+		.cra_driver_name = "ghash-riscv64-zvkg",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static int __init riscv64_ghash_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKG) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_shash(&riscv64_ghash_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_ghash_mod_fini(void)
+{
+	crypto_unregister_shash(&riscv64_ghash_alg);
+}
+
+module_init(riscv64_ghash_mod_init);
+module_exit(riscv64_ghash_mod_fini);
+
+MODULE_DESCRIPTION("GHASH (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/riscv/crypto/ghash-riscv64-zvkg.S b/arch/riscv/crypto/ghash-riscv64-zvkg.S
new file mode 100644
index 0000000000000..7d406ea743220
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvkg.S
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause */
+//
+// This file is dual-licensed, meaning that you can use it under your
+// choice of either of the following two licenses:
+//
+// Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+//
+// Licensed under the Apache License 2.0 (the "License"). You can obtain
+// a copy in the file LICENSE in the source distribution or at
+// https://www.openssl.org/source/license.html
+//
+// or
+//
+// Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+// Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+// Copyright 2024 Google LLC
+// All rights reserved.
+//
+// Redistribution and use in source and binary forms, with or without
+// modification, are permitted provided that the following conditions
+// are met:
+// 1. Redistributions of source code must retain the above copyright
+//    notice, this list of conditions and the following disclaimer.
+// 2. Redistributions in binary form must reproduce the above copyright
+//    notice, this list of conditions and the following disclaimer in the
+//    documentation and/or other materials provided with the distribution.
+//
+// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+// The generated code of this file depends on the following RISC-V extensions:
+// - RV64I
+// - RISC-V Vector ('V') with VLEN >= 128
+// - RISC-V Vector GCM/GMAC extension ('Zvkg')
+
+#include <linux/linkage.h>
+
+.text
+.option arch, +zvkg
+
+#define ACCUMULATOR	a0
+#define KEY		a1
+#define DATA		a2
+#define LEN		a3
+
+// void ghash_zvkg(be128 *accumulator, const be128 *key, const u8 *data,
+//		   size_t len);
+//
+// |len| must be nonzero and a multiple of 16 (GHASH_BLOCK_SIZE).
+SYM_FUNC_START(ghash_zvkg)
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vle32.v		v1, (ACCUMULATOR)
+	vle32.v		v2, (KEY)
+.Lnext_block:
+	vle32.v		v3, (DATA)
+	addi		DATA, DATA, 16
+	addi		LEN, LEN, -16
+	vghsh.vv	v1, v2, v3
+	bnez		LEN, .Lnext_block
+
+	vse32.v		v1, (ACCUMULATOR)
+	ret
+SYM_FUNC_END(ghash_zvkg)
-- 
2.43.0


