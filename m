Return-Path: <linux-kernel+bounces-14103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0948217DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6081AB217C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77112E7B;
	Tue,  2 Jan 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucDSxbRB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9812E5E;
	Tue,  2 Jan 2024 06:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D51BC433C8;
	Tue,  2 Jan 2024 06:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178249;
	bh=6HrmutA4w4lJw9CHMXV+TxNZ0KU+8Hg+Z65BKTFYS74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucDSxbRBbTiz0AzoQHUy+H+gUWK/XnS3DCif5T/hE4u/TJ0MyXBc96G8Bz/XVDrwc
	 71xJWlSbob8LCNZeE1+wTrEWdSdG+e5WgLHZfK93MtPsdjoggZ+a0rEeTT09rNdcha
	 4WagtwTlo6hiMjGy0DJma4R2YBfIjSrq+uY7rEgu6NTWdcwVpttCUjPxZCmh+ER7JW
	 lCz+XTVTkbwef1nxZWpP56AtvBrsVX4mdI1zMKxnNMZVSXhYkY8w4Do3H58kayTJUg
	 J149VouGeItcpW0YT6V9F4ga1Mk4l9F/nd9NMWIUUabRlOcx99xL2Bgtd2ZzFAquOA
	 mJJK+IVwlyMHg==
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
Subject: [RFC PATCH 13/13] crypto: riscv - add vector crypto accelerated SM4
Date: Tue,  2 Jan 2024 00:47:39 -0600
Message-ID: <20240102064743.220490-14-ebiggers@kernel.org>
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

Add an implementation of SM4 using the Zvksed extension.  The assembly
code is derived from OpenSSL code (openssl/openssl#21923) that was
dual-licensed so that it could be reused in the kernel.  Nevertheless,
the assembly has been significantly reworked for integration with the
kernel, for example by using a regular .S file instead of the so-called
perlasm, using the assembler instead of bare '.inst', and greatly
reducing code duplication.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                   |  17 +++
 arch/riscv/crypto/Makefile                  |   3 +
 arch/riscv/crypto/sm4-riscv64-glue.c        | 109 ++++++++++++++++++
 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S | 117 ++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index d44911853fa2d..9ba225d968289 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -81,11 +81,28 @@ config CRYPTO_SM3_RISCV64
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 	help
 	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
 
 	  Architecture: riscv64 using:
 	  - Zvksh vector crypto extension
 	  - Zvkb vector crypto extension
 
+config CRYPTO_SM4_RISCV64
+	tristate "Ciphers: SM4 (ShangMi 4)"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
+	help
+	  SM4 block cipher algorithm (OSCCA GB/T 32907-2016,
+	  ISO/IEC 18033-3:2010/Amd 1:2021)
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithm for use within China.
+
+	  Architecture: riscv64 using:
+	  - Zvksed vector crypto extension
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 4b5efabd1162a..70d60060d9b26 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -16,10 +16,13 @@ obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
 obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
 sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
 
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
 
 obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
 sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh-zvkb.o
+
+obj-$(CONFIG_CRYPTO_SM4_RISCV64) += sm4-riscv64.o
+sm4-riscv64-y := sm4-riscv64-glue.o sm4-riscv64-zvksed-zvkb.o
diff --git a/arch/riscv/crypto/sm4-riscv64-glue.c b/arch/riscv/crypto/sm4-riscv64-glue.c
new file mode 100644
index 0000000000000..b8993f1411f45
--- /dev/null
+++ b/arch/riscv/crypto/sm4-riscv64-glue.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SM4 using the RISC-V vector crypto extensions
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
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sm4.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+asmlinkage void sm4_expandkey_zvksed_zvkb(const u8 user_key[SM4_KEY_SIZE],
+					  u32 rkey_enc[SM4_RKEY_WORDS],
+					  u32 rkey_dec[SM4_RKEY_WORDS]);
+asmlinkage void sm4_crypt_zvksed_zvkb(const u32 rkey[SM4_RKEY_WORDS],
+				      const u8 in[SM4_BLOCK_SIZE],
+				      u8 out[SM4_BLOCK_SIZE]);
+
+static int riscv64_sm4_setkey(struct crypto_tfm *tfm, const u8 *key,
+			      unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		sm4_expandkey_zvksed_zvkb(key, ctx->rkey_enc, ctx->rkey_dec);
+		kernel_vector_end();
+	} else {
+		sm4_expandkey(ctx, key, key_len);
+	}
+	return 0;
+}
+
+static void riscv64_sm4_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		sm4_crypt_zvksed_zvkb(ctx->rkey_enc, src, dst);
+		kernel_vector_end();
+	} else {
+		sm4_crypt_block(ctx->rkey_enc, dst, src);
+	}
+}
+
+static void riscv64_sm4_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		sm4_crypt_zvksed_zvkb(ctx->rkey_dec, src, dst);
+		kernel_vector_end();
+	} else {
+		sm4_crypt_block(ctx->rkey_dec, dst, src);
+	}
+}
+
+static struct crypto_alg riscv64_sm4_alg = {
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize = SM4_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct sm4_ctx),
+	.cra_priority = 300,
+	.cra_name = "sm4",
+	.cra_driver_name = "sm4-riscv64-zvksed-zvkb",
+	.cra_cipher = {
+		.cia_min_keysize = SM4_KEY_SIZE,
+		.cia_max_keysize = SM4_KEY_SIZE,
+		.cia_setkey = riscv64_sm4_setkey,
+		.cia_encrypt = riscv64_sm4_encrypt,
+		.cia_decrypt = riscv64_sm4_decrypt,
+	},
+	.cra_module = THIS_MODULE,
+};
+
+static int __init riscv64_sm4_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKSED) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_alg(&riscv64_sm4_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sm4_mod_fini(void)
+{
+	crypto_unregister_alg(&riscv64_sm4_alg);
+}
+
+module_init(riscv64_sm4_mod_init);
+module_exit(riscv64_sm4_mod_fini);
+
+MODULE_DESCRIPTION("SM4 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sm4");
diff --git a/arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S b/arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S
new file mode 100644
index 0000000000000..143e60ddf3fe4
--- /dev/null
+++ b/arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S
@@ -0,0 +1,117 @@
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
+// - RISC-V Vector SM4 Block Cipher extension ('Zvksed')
+// - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+#include <linux/linkage.h>
+
+.text
+.option arch, +zvksed, +zvkb
+
+// void sm4_expandkey_zksed_zvkb(const u8 user_key[16], u32 rkey_enc[32],
+//				 u32 rkey_dec[32]);
+SYM_FUNC_START(sm4_expandkey_zvksed_zvkb)
+	vsetivli	zero, 4, e32, m1, ta, ma
+
+	// Load the user key.
+	vle32.v		v1, (a0)
+	vrev8.v		v1, v1
+
+	// XOR the user key with the family key.
+	la		t0, FAMILY_KEY
+	vle32.v		v2, (t0)
+	vxor.vv		v1, v1, v2
+
+	// Compute the round keys.  Store them in forwards order in rkey_enc
+	// and in reverse order in rkey_dec.
+	addi		a2, a2, 31*4
+	li		t0, -4
+	.set		i, 0
+.rept 8
+	vsm4k.vi	v1, v1, i
+	vse32.v		v1, (a1)	// Store to rkey_enc.
+	vsse32.v	v1, (a2), t0	// Store to rkey_dec.
+.if i < 7
+	addi		a1, a1, 16
+	addi		a2, a2, -16
+.endif
+	.set		i, i + 1
+.endr
+
+	ret
+SYM_FUNC_END(sm4_expandkey_zvksed_zvkb)
+
+// void sm4_crypt_zvksed_zvkb(const u32 rkey[32], const u8 in[16], u8 out[16]);
+SYM_FUNC_START(sm4_crypt_zvksed_zvkb)
+	vsetivli	zero, 4, e32, m1, ta, ma
+
+	// Load the input data.
+	vle32.v		v1, (a1)
+	vrev8.v		v1, v1
+
+	// Do the 32 rounds of SM4, 4 at a time.
+	.set		i, 0
+.rept 8
+	vle32.v		v2, (a0)
+	vsm4r.vs	v1, v2
+.if i < 7
+	addi		a0, a0, 16
+.endif
+	.set		i, i + 1
+.endr
+
+	// Store the output data (in reverse element order).
+	vrev8.v		v1, v1
+	li		t0, -4
+	addi		a2, a2, 12
+	vsse32.v	v1, (a2), t0
+
+	ret
+SYM_FUNC_END(sm4_crypt_zvksed_zvkb)
+
+.section ".rodata"
+.p2align 2
+.type FAMILY_KEY, @object
+FAMILY_KEY:
+	.word 0xA3B1BAC6, 0x56AA3350, 0x677D9197, 0xB27022DC
+.size FAMILY_KEY, .-FAMILY_KEY
-- 
2.43.0


