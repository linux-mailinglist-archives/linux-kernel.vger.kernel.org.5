Return-Path: <linux-kernel+bounces-14096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210AE8217D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B4F1C213C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F90EAE5;
	Tue,  2 Jan 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUB2cCR6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C0E555;
	Tue,  2 Jan 2024 06:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E95C433CA;
	Tue,  2 Jan 2024 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178228;
	bh=X7OG37lToaBZiUGTXBzftTxzjeutlpdLOxmdbsOOHvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUB2cCR64ITW8HUmuUBto7jF5ROLBzoEsGsEJMKMDpkPTrLUHBmiGyr9fEAaWsx74
	 Zua97nqZpeCNVgGhfuCmrmxE9yp1Ztu72/JwKhmsd6/OWO2Wp91XeCWzULVomiRHJN
	 tu/VNPSeXcNgvg0VRDfURhRzExxxaiVDYtEzTsUFzc4E8RKAwIHpFEjTtTVaCeT6yl
	 GcmMDCclrM4jAFmT50Nt5RUc9XPLLlpaHRtpQpDkKy58ZvWl1QNNqs60Ccy9Cae+1X
	 sU1a/NQBJR4uBvQRpGIMb2fv3BALUhr7MykvbChT9srXbfl5Ek4+wRets5Aaaaqssh
	 ja6RhtnldPKyg==
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
Subject: [RFC PATCH 06/13] crypto: riscv - add vector crypto accelerated AES
Date: Tue,  2 Jan 2024 00:47:32 -0600
Message-ID: <20240102064743.220490-7-ebiggers@kernel.org>
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

Add an implementation of AES using the Zvkned extension.  The assembly
code is derived from OpenSSL code (openssl/openssl#21923) that was
dual-licensed so that it could be reused in the kernel.  Nevertheless,
the assembly has been significantly reworked for integration with the
kernel, for example by using a regular .S file instead of the so-called
perlasm, using the assembler instead of bare '.inst', greatly reducing
code duplication, supporting AES-192, and making the code use the same
AES key structure as the C code.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig              |  11 ++
 arch/riscv/crypto/Makefile             |   3 +
 arch/riscv/crypto/aes-macros.S         | 156 +++++++++++++++++++++++++
 arch/riscv/crypto/aes-riscv64-glue.c   | 123 +++++++++++++++++++
 arch/riscv/crypto/aes-riscv64-glue.h   |  15 +++
 arch/riscv/crypto/aes-riscv64-zvkned.S |  84 +++++++++++++
 6 files changed, 392 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-macros.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 10d60edc0110a..2a7c365f2a86c 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -1,5 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
+config CRYPTO_AES_RISCV64
+	tristate "Ciphers: AES"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
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
index b3b6332c9f6d0..dca698c5cba3e 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # linux/arch/riscv/crypto/Makefile
 #
+
+obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
+aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
diff --git a/arch/riscv/crypto/aes-macros.S b/arch/riscv/crypto/aes-macros.S
new file mode 100644
index 0000000000000..2ada0c70f4a6a
--- /dev/null
+++ b/arch/riscv/crypto/aes-macros.S
@@ -0,0 +1,156 @@
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
+// Copyright (c) 2023, Phoebe Chen <phoebe.chen@sifive.com>
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
+// A PARTICULAR PURPOSE ARE DISCLAIMED. INP NO EVENT SHALL THE COPYRIGHT
+// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+// THEORY OF LIABILITY, WHETHER INP CONTRACT, STRICT LIABILITY, OR TORT
+// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING INP ANY WAY OUTP OF THE USE
+// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+// This file contains macros that are shared by the other aes-*.S files.  The
+// generated code of these macros depends on the following RISC-V extensions:
+// - RV64I
+// - RISC-V Vector ('V') with VLEN >= 128
+// - RISC-V Vector AES block cipher extension ('Zvkned')
+
+// Loads the AES round keys from \keyp into vector registers and jumps to code
+// specific to the length of the key.  Specifically:
+//   - If AES-128, loads round keys into v1-v11 and jumps to \label128.
+//   - If AES-192, loads round keys into v1-v13 and jumps to \label192.
+//   - If AES-256, loads round keys into v1-v15 and continues onwards.
+//
+// Also sets vl=4 and vtype=e32,m1,ta,ma.  Clobbers t0 and t1.
+.macro	aes_begin	keyp, label128, label192
+	lwu		t0, 480(\keyp)	// t0 = key length in bytes
+	li		t1, 24		// t1 = key length for AES-192
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vle32.v		v1, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v2, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v3, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v4, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v5, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v6, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v7, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v8, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v9, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v10, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v11, (\keyp)
+	blt		t0, t1, \label128	// If AES-128, goto label128.
+	addi		\keyp, \keyp, 16
+	vle32.v		v12, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v13, (\keyp)
+	beq		t0, t1, \label192	// If AES-192, goto label192.
+	// Else, it's AES-256.
+	addi		\keyp, \keyp, 16
+	vle32.v		v14, (\keyp)
+	addi		\keyp, \keyp, 16
+	vle32.v		v15, (\keyp)
+.endm
+
+// Encrypts \data using zvkned instructions, using the round keys loaded into
+// v1-v11 (for AES-128), v1-v13 (for AES-192), or v1-v15 (for AES-256).  \keylen
+// is the AES key length in bits.  vl and vtype must already be set
+// appropriately.  Note that if vl > 4, multiple blocks are encrypted.
+.macro	aes_encrypt	data, keylen
+	vaesz.vs	\data, v1
+	vaesem.vs	\data, v2
+	vaesem.vs	\data, v3
+	vaesem.vs	\data, v4
+	vaesem.vs	\data, v5
+	vaesem.vs	\data, v6
+	vaesem.vs	\data, v7
+	vaesem.vs	\data, v8
+	vaesem.vs	\data, v9
+	vaesem.vs	\data, v10
+.if \keylen == 128
+	vaesef.vs	\data, v11
+.elseif \keylen == 192
+	vaesem.vs	\data, v11
+	vaesem.vs	\data, v12
+	vaesef.vs	\data, v13
+.else
+	vaesem.vs	\data, v11
+	vaesem.vs	\data, v12
+	vaesem.vs	\data, v13
+	vaesem.vs	\data, v14
+	vaesef.vs	\data, v15
+.endif
+.endm
+
+// Same as aes_encrypt, but decrypts instead of encrypts.
+.macro	aes_decrypt	data, keylen
+.if \keylen == 128
+	vaesz.vs	\data, v11
+.elseif \keylen == 192
+	vaesz.vs	\data, v13
+	vaesdm.vs	\data, v12
+	vaesdm.vs	\data, v11
+.else
+	vaesz.vs	\data, v15
+	vaesdm.vs	\data, v14
+	vaesdm.vs	\data, v13
+	vaesdm.vs	\data, v12
+	vaesdm.vs	\data, v11
+.endif
+	vaesdm.vs	\data, v10
+	vaesdm.vs	\data, v9
+	vaesdm.vs	\data, v8
+	vaesdm.vs	\data, v7
+	vaesdm.vs	\data, v6
+	vaesdm.vs	\data, v5
+	vaesdm.vs	\data, v4
+	vaesdm.vs	\data, v3
+	vaesdm.vs	\data, v2
+	vaesdf.vs	\data, v1
+.endm
+
+// Expands to aes_encrypt or aes_decrypt according to \enc, which is 1 or 0.
+.macro	aes_crypt	data, enc, keylen
+.if \enc
+	aes_encrypt	\data, \keylen
+.else
+	aes_decrypt	\data, \keylen
+.endif
+.endm
diff --git a/arch/riscv/crypto/aes-riscv64-glue.c b/arch/riscv/crypto/aes-riscv64-glue.c
new file mode 100644
index 0000000000000..f9c7b1a638f2d
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AES using the RISC-V vector crypto extensions
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
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+#include "aes-riscv64-glue.h"
+
+asmlinkage void aes_encrypt_zvkned(const struct crypto_aes_ctx *key,
+				   const u8 in[AES_BLOCK_SIZE],
+				   u8 out[AES_BLOCK_SIZE]);
+asmlinkage void aes_decrypt_zvkned(const struct crypto_aes_ctx *key,
+				   const u8 in[AES_BLOCK_SIZE],
+				   u8 out[AES_BLOCK_SIZE]);
+
+int __riscv64_aes_setkey(struct crypto_aes_ctx *ctx, const u8 *key,
+			 unsigned int keylen)
+{
+	/*
+	 * Always use the generic key expansion routine, for two reasons:
+	 *
+	 * - zvkned's key expansion instructions don't support AES-192.
+	 *
+	 * - ctx->key_dec always needs to be initialized with the round keys for
+	 *   the Equivalent Inverse Cipher, in case the no-SIMD fallback is
+	 *   taken during decryption.  But the zvkned code does not use this.
+	 */
+	return aes_expandkey(ctx, key, keylen);
+}
+EXPORT_SYMBOL_GPL(__riscv64_aes_setkey);
+
+void __riscv64_aes_encrypt(const struct crypto_aes_ctx *ctx,
+			   u8 *dst, const u8 *src)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		aes_encrypt_zvkned(ctx, src, dst);
+		kernel_vector_end();
+	} else {
+		aes_encrypt(ctx, dst, src);
+	}
+}
+EXPORT_SYMBOL_GPL(__riscv64_aes_encrypt);
+
+static int riscv64_aes_setkey(struct crypto_tfm *tfm,
+			      const u8 *key, unsigned int keylen)
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	return __riscv64_aes_setkey(ctx, key, keylen);
+}
+
+static void riscv64_aes_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	__riscv64_aes_encrypt(ctx, dst, src);
+}
+
+static void riscv64_aes_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		aes_decrypt_zvkned(ctx, src, dst);
+		kernel_vector_end();
+	} else {
+		aes_decrypt(ctx, dst, src);
+	}
+}
+
+static struct crypto_alg riscv64_aes_alg = {
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize = AES_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+	.cra_priority = 300,
+	.cra_name = "aes",
+	.cra_driver_name = "aes-riscv64-zvkned",
+	.cra_cipher = {
+		.cia_min_keysize = AES_MIN_KEY_SIZE,
+		.cia_max_keysize = AES_MAX_KEY_SIZE,
+		.cia_setkey = riscv64_aes_setkey,
+		.cia_encrypt = riscv64_aes_encrypt,
+		.cia_decrypt = riscv64_aes_decrypt,
+	},
+	.cra_module = THIS_MODULE,
+};
+
+static int __init riscv64_aes_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKNED) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_alg(&riscv64_aes_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_aes_mod_fini(void)
+{
+	crypto_unregister_alg(&riscv64_aes_alg);
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
index 0000000000000..0d38613380784
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef AES_RISCV64_GLUE_H
+#define AES_RISCV64_GLUE_H
+
+#include <crypto/aes.h>
+#include <linux/types.h>
+
+int __riscv64_aes_setkey(struct crypto_aes_ctx *ctx,
+			 const u8 *key, unsigned int keylen);
+
+void __riscv64_aes_encrypt(const struct crypto_aes_ctx *ctx,
+			   u8 *dst, const u8 *src);
+
+#endif /* AES_RISCV64_GLUE_H */
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.S b/arch/riscv/crypto/aes-riscv64-zvkned.S
new file mode 100644
index 0000000000000..3346978b89d6a
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.S
@@ -0,0 +1,84 @@
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
+// Copyright (c) 2023, Phoebe Chen <phoebe.chen@sifive.com>
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
+// A PARTICULAR PURPOSE ARE DISCLAIMED. INP NO EVENT SHALL THE COPYRIGHT
+// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+// THEORY OF LIABILITY, WHETHER INP CONTRACT, STRICT LIABILITY, OR TORT
+// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING INP ANY WAY OUTP OF THE USE
+// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+// The generated code of this file depends on the following RISC-V extensions:
+// - RV64I
+// - RISC-V Vector ('V') with VLEN >= 128
+// - RISC-V Vector AES block cipher extension ('Zvkned')
+
+#include <linux/linkage.h>
+
+.text
+.option arch, +zvkned
+
+#include "aes-macros.S"
+
+#define KEYP		a0
+#define INP		a1
+#define OUTP		a2
+#define LEN		a3
+#define IVP		a4
+
+.macro	__aes_crypt_zvkned	enc, keylen
+	vle32.v		v16, (INP)
+	aes_crypt	v16, \enc, \keylen
+	vse32.v		v16, (OUTP)
+	ret
+.endm
+
+.macro	aes_crypt_zvkned	enc
+	aes_begin	KEYP, 111f, 222f
+	__aes_crypt_zvkned	\enc, 256
+111:
+	__aes_crypt_zvkned	\enc, 128
+222:
+	__aes_crypt_zvkned	\enc, 192
+.endm
+
+// void aes_encrypt_zvkned(const struct crypto_aes_ctx *key,
+//			   const u8 in[16], u8 out[16]);
+SYM_FUNC_START(aes_encrypt_zvkned)
+	aes_crypt_zvkned	1
+SYM_FUNC_END(aes_encrypt_zvkned)
+
+// Same prototype and calling convention as the encryption function
+SYM_FUNC_START(aes_decrypt_zvkned)
+	aes_crypt_zvkned	0
+SYM_FUNC_END(aes_decrypt_zvkned)
-- 
2.43.0


