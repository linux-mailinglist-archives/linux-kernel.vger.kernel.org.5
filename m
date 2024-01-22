Return-Path: <linux-kernel+bounces-32237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F1B8358FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1865228242E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA60DB66E;
	Mon, 22 Jan 2024 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCCjnk9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548333C0;
	Mon, 22 Jan 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882981; cv=none; b=USqOYWJx2P4j4K90Sf/eHgKeUOkJda3SBLhmASGcQekX3aszEouq6qdxW6V4dkHExk1LPz9sNYbPKOjj3Jg7xeOpbGklc6/2sh6ObdWFChw7lzNpbu6fsw/rzj2oDPdNVGhLf3HlcYv0/s42pf0TZbX0mKrs7SmCEm6H7ePoZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882981; c=relaxed/simple;
	bh=BH8DWDwlQPyIgcG7nEKEMMv58AgI1J8gP1nTyg7ugIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcxfx4exPW4/P78nBq3kroZwpyqwXlAsTPYamBicrDnHddtjCVwpnizb+H/N+y8iwZHhBZkkP4EcjUFgJzT7/DjPgh7xQDOgfUbLgZlsvaLL1Fve9wcGATrfTZc7IVrNstEEfoAN1rnzZUuMHiFv+JdCN/ztnZ7aQx7/t+leNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCCjnk9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2561C43390;
	Mon, 22 Jan 2024 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705882980;
	bh=BH8DWDwlQPyIgcG7nEKEMMv58AgI1J8gP1nTyg7ugIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCCjnk9ZfbJTWtTAWW2Y96hsCzBFA54lyNCaJNemFRlEvtcjtg1lQP87eZa2oQZTF
	 mjFXr+8jHPoh17UZB3DZsKZ33XW00ejN1/B8DqdWWEbzYLjUmaNSOQ2Aiht7AtLPXT
	 UW4eji6/aV6fekm3SG172KpksMvL5JBPMKp9nplMhxqKPbgnUchMA1ZUO0hvcL4WM6
	 RXNw5g8f3rvEv6uo4DuNLlvlo1+7wwX8+VS//BdArdzsw/3eYtHk9Lvb/IUY9txC18
	 FLIYKm7AnrY4SvSae9VNXSHOahlG9pw7Q4yBKdHWQQWEvuV6xlaJXUXVUtw3ntuXUp
	 eG9n+5G2eYsWA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko@sntech.de>,
	Jerry Shih <jerry.shih@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com
Subject: [PATCH v3 04/10] crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
Date: Sun, 21 Jan 2024 16:19:15 -0800
Message-ID: <20240122002024.27477-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
References: <20240122002024.27477-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jerry Shih <jerry.shih@sifive.com>

Add implementations of AES-ECB, AES-CBC, AES-CTR, and AES-XTS, as well
as bare (single-block) AES, using the RISC-V vector crypto extensions.
The assembly code is derived from OpenSSL code (openssl/openssl#21923)
that was dual-licensed so that it could be reused in the kernel.
Nevertheless, the assembly has been significantly reworked for
integration with the kernel, for example by using regular .S files
instead of the so-called perlasm, using the assembler instead of bare
'.inst', greatly reducing code duplication, supporting AES-192, and
making the code use the same AES key structure as the C code.

Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                     |  16 +
 arch/riscv/crypto/Makefile                    |   4 +
 arch/riscv/crypto/aes-macros.S                | 156 +++++
 arch/riscv/crypto/aes-riscv64-glue.c          | 550 ++++++++++++++++++
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 312 ++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 +++++
 arch/riscv/crypto/aes-riscv64-zvkned.S        | 180 ++++++
 7 files changed, 1364 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-macros.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 10d60edc0110a..ebe805fa3f5f7 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -1,5 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
+config CRYPTO_AES_RISCV64
+	tristate "Ciphers: AES, modes: ECB, CBC, CTR, XTS"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_AES
+	select CRYPTO_SKCIPHER
+	help
+	  Block cipher: AES cipher algorithms
+	  Length-preserving ciphers: AES with ECB, CBC, CTR, XTS
+
+	  Architecture: riscv64 using:
+	  - Zvkned vector crypto extension
+	  - Zvbb vector extension (XTS)
+	  - Zvkb vector crypto extension (CTR)
+	  - Zvkg vector crypto extension (XTS)
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index a4e40e534e6a8..44922df7d182f 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -1 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
+aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
+		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
diff --git a/arch/riscv/crypto/aes-macros.S b/arch/riscv/crypto/aes-macros.S
new file mode 100644
index 0000000000000..d1a258d04bc73
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
+// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
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
index 0000000000000..37bc6ef0be40e
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-glue.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AES using the RISC-V vector crypto extensions.  Includes the bare block
+ * cipher and the ECB, CBC, CTR, and XTS modes.
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
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/xts.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+asmlinkage void aes_encrypt_zvkned(const struct crypto_aes_ctx *key,
+				   const u8 in[AES_BLOCK_SIZE],
+				   u8 out[AES_BLOCK_SIZE]);
+asmlinkage void aes_decrypt_zvkned(const struct crypto_aes_ctx *key,
+				   const u8 in[AES_BLOCK_SIZE],
+				   u8 out[AES_BLOCK_SIZE]);
+
+asmlinkage void aes_ecb_encrypt_zvkned(const struct crypto_aes_ctx *key,
+				       const u8 *in, u8 *out, size_t len);
+asmlinkage void aes_ecb_decrypt_zvkned(const struct crypto_aes_ctx *key,
+				       const u8 *in, u8 *out, size_t len);
+
+asmlinkage void aes_cbc_encrypt_zvkned(const struct crypto_aes_ctx *key,
+				       const u8 *in, u8 *out, size_t len,
+				       u8 iv[AES_BLOCK_SIZE]);
+asmlinkage void aes_cbc_decrypt_zvkned(const struct crypto_aes_ctx *key,
+				       const u8 *in, u8 *out, size_t len,
+				       u8 iv[AES_BLOCK_SIZE]);
+
+asmlinkage void aes_ctr32_crypt_zvkned_zvkb(const struct crypto_aes_ctx *key,
+					    const u8 *in, u8 *out, size_t len,
+					    u8 iv[AES_BLOCK_SIZE]);
+
+asmlinkage void aes_xts_encrypt_zvkned_zvbb_zvkg(
+			const struct crypto_aes_ctx *key,
+			const u8 *in, u8 *out, size_t len,
+			u8 tweak[AES_BLOCK_SIZE]);
+
+asmlinkage void aes_xts_decrypt_zvkned_zvbb_zvkg(
+			const struct crypto_aes_ctx *key,
+			const u8 *in, u8 *out, size_t len,
+			u8 tweak[AES_BLOCK_SIZE]);
+
+static int riscv64_aes_setkey(struct crypto_aes_ctx *ctx,
+			      const u8 *key, unsigned int keylen)
+{
+	/*
+	 * For now we just use the generic key expansion, for these reasons:
+	 *
+	 * - zvkned's key expansion instructions don't support AES-192.
+	 *   So, non-zvkned fallback code would be needed anyway.
+	 *
+	 * - Users of AES in Linux usually don't change keys frequently.
+	 *   So, key expansion isn't performance-critical.
+	 *
+	 * - For single-block AES exposed as a "cipher" algorithm, it's
+	 *   necessary to use struct crypto_aes_ctx and initialize its 'key_dec'
+	 *   field with the round keys for the Equivalent Inverse Cipher.  This
+	 *   is because with "cipher", decryption can be requested from a
+	 *   context where the vector unit isn't usable, necessitating a
+	 *   fallback to aes_decrypt().  But, zvkned can only generate and use
+	 *   the normal round keys.  Of course, it's preferable to not have
+	 *   special code just for "cipher", as e.g. XTS also uses a
+	 *   single-block AES encryption.  It's simplest to just use
+	 *   struct crypto_aes_ctx and aes_expandkey() everywhere.
+	 */
+	return aes_expandkey(ctx, key, keylen);
+}
+
+static int riscv64_aes_setkey_cipher(struct crypto_tfm *tfm,
+				     const u8 *key, unsigned int keylen)
+{
+	struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	return riscv64_aes_setkey(ctx, key, keylen);
+}
+
+static int riscv64_aes_setkey_skcipher(struct crypto_skcipher *tfm,
+				       const u8 *key, unsigned int keylen)
+{
+	struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return riscv64_aes_setkey(ctx, key, keylen);
+}
+
+/* Bare AES, without a mode of operation */
+
+static void riscv64_aes_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		aes_encrypt_zvkned(ctx, src, dst);
+		kernel_vector_end();
+	} else {
+		aes_encrypt(ctx, dst, src);
+	}
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
+/* AES-ECB */
+
+static inline int riscv64_aes_ecb_crypt(struct skcipher_request *req, bool enc)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes) != 0) {
+		kernel_vector_begin();
+		if (enc)
+			aes_ecb_encrypt_zvkned(ctx, walk.src.virt.addr,
+					       walk.dst.virt.addr,
+					       nbytes & ~(AES_BLOCK_SIZE - 1));
+		else
+			aes_ecb_decrypt_zvkned(ctx, walk.src.virt.addr,
+					       walk.dst.virt.addr,
+					       nbytes & ~(AES_BLOCK_SIZE - 1));
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, nbytes & (AES_BLOCK_SIZE - 1));
+	}
+
+	return err;
+}
+
+static int riscv64_aes_ecb_encrypt(struct skcipher_request *req)
+{
+	return riscv64_aes_ecb_crypt(req, true);
+}
+
+static int riscv64_aes_ecb_decrypt(struct skcipher_request *req)
+{
+	return riscv64_aes_ecb_crypt(req, false);
+}
+
+/* AES-CBC */
+
+static inline int riscv64_aes_cbc_crypt(struct skcipher_request *req, bool enc)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes) != 0) {
+		kernel_vector_begin();
+		if (enc)
+			aes_cbc_encrypt_zvkned(ctx, walk.src.virt.addr,
+					       walk.dst.virt.addr,
+					       nbytes & ~(AES_BLOCK_SIZE - 1),
+					       walk.iv);
+		else
+			aes_cbc_decrypt_zvkned(ctx, walk.src.virt.addr,
+					       walk.dst.virt.addr,
+					       nbytes & ~(AES_BLOCK_SIZE - 1),
+					       walk.iv);
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, nbytes & (AES_BLOCK_SIZE - 1));
+	}
+
+	return err;
+}
+
+static int riscv64_aes_cbc_encrypt(struct skcipher_request *req)
+{
+	return riscv64_aes_cbc_crypt(req, true);
+}
+
+static int riscv64_aes_cbc_decrypt(struct skcipher_request *req)
+{
+	return riscv64_aes_cbc_crypt(req, false);
+}
+
+/* AES-CTR */
+
+static int riscv64_aes_ctr_crypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	unsigned int nbytes, p1_nbytes;
+	struct skcipher_walk walk;
+	u32 ctr32, nblocks;
+	int err;
+
+	/* Get the low 32-bit word of the 128-bit big endian counter. */
+	ctr32 = get_unaligned_be32(req->iv + 12);
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes) != 0) {
+		if (nbytes < walk.total) {
+			/* Not the end yet, so keep the length block-aligned. */
+			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
+			nblocks = nbytes / AES_BLOCK_SIZE;
+		} else {
+			/* It's the end, so include any final partial block. */
+			nblocks = DIV_ROUND_UP(nbytes, AES_BLOCK_SIZE);
+		}
+		ctr32 += nblocks;
+
+		kernel_vector_begin();
+		if (ctr32 >= nblocks) {
+			/* The low 32-bit word of the counter won't overflow. */
+			aes_ctr32_crypt_zvkned_zvkb(ctx, walk.src.virt.addr,
+						    walk.dst.virt.addr, nbytes,
+						    req->iv);
+		} else {
+			/*
+			 * The low 32-bit word of the counter will overflow.
+			 * The assembly doesn't handle this case, so split the
+			 * operation into two at the point where the overflow
+			 * will occur.  After the first part, add the carry bit.
+			 */
+			p1_nbytes = min_t(unsigned int, nbytes,
+					  (nblocks - ctr32) * AES_BLOCK_SIZE);
+			aes_ctr32_crypt_zvkned_zvkb(ctx, walk.src.virt.addr,
+						    walk.dst.virt.addr,
+						    p1_nbytes, req->iv);
+			crypto_inc(req->iv, 12);
+
+			if (ctr32) {
+				aes_ctr32_crypt_zvkned_zvkb(
+					ctx,
+					walk.src.virt.addr + p1_nbytes,
+					walk.dst.virt.addr + p1_nbytes,
+					nbytes - p1_nbytes, req->iv);
+			}
+		}
+		kernel_vector_end();
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	}
+
+	return err;
+}
+
+/* AES-XTS */
+
+struct riscv64_aes_xts_ctx {
+	struct crypto_aes_ctx ctx1;
+	struct crypto_aes_ctx ctx2;
+};
+
+static int riscv64_aes_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				  unsigned int keylen)
+{
+	struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return xts_verify_key(tfm, key, keylen) ?:
+	       riscv64_aes_setkey(&ctx->ctx1, key, keylen / 2) ?:
+	       riscv64_aes_setkey(&ctx->ctx2, key + keylen / 2, keylen / 2);
+}
+
+static int riscv64_aes_xts_crypt(struct skcipher_request *req, bool enc)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int tail = req->cryptlen % AES_BLOCK_SIZE;
+	struct scatterlist sg_src[2], sg_dst[2];
+	struct skcipher_request subreq;
+	struct scatterlist *src, *dst;
+	struct skcipher_walk walk;
+	int err;
+
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
+	/* Encrypt the IV with the tweak key to get the first tweak. */
+	kernel_vector_begin();
+	aes_encrypt_zvkned(&ctx->ctx2, req->iv, req->iv);
+	kernel_vector_end();
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	/*
+	 * If the message length isn't divisible by the AES block size and the
+	 * full message isn't available in one step of the scatterlist walk,
+	 * then separate off the last full block and the partial block.  This
+	 * ensures that they are processed in the same call to the assembly
+	 * function, which is required for ciphertext stealing.
+	 */
+	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(&subreq,
+					      skcipher_request_flags(req),
+					      NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst,
+					   req->cryptlen - tail - AES_BLOCK_SIZE,
+					   req->iv);
+		req = &subreq;
+		err = skcipher_walk_virt(&walk, req, false);
+	} else {
+		tail = 0;
+	}
+
+	while (walk.nbytes) {
+		unsigned int nbytes = walk.nbytes;
+
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
+
+		kernel_vector_begin();
+		if (enc)
+			aes_xts_encrypt_zvkned_zvbb_zvkg(
+				&ctx->ctx1, walk.src.virt.addr,
+				walk.dst.virt.addr, nbytes, req->iv);
+		else
+			aes_xts_decrypt_zvkned_zvbb_zvkg(
+				&ctx->ctx1, walk.src.virt.addr,
+				walk.dst.virt.addr, nbytes, req->iv);
+		kernel_vector_end();
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+	}
+
+	if (err || likely(!tail))
+		return err;
+
+	/* Do ciphertext stealing with the last full block and partial block. */
+
+	dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+	if (req->dst != req->src)
+		dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
+
+	skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
+				   req->iv);
+
+	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
+
+	kernel_vector_begin();
+	if (enc)
+		aes_xts_encrypt_zvkned_zvbb_zvkg(
+			&ctx->ctx1, walk.src.virt.addr,
+			walk.dst.virt.addr, walk.nbytes, req->iv);
+	else
+		aes_xts_decrypt_zvkned_zvbb_zvkg(
+			&ctx->ctx1, walk.src.virt.addr,
+			walk.dst.virt.addr, walk.nbytes, req->iv);
+	kernel_vector_end();
+
+	return skcipher_walk_done(&walk, 0);
+}
+
+static int riscv64_aes_xts_encrypt(struct skcipher_request *req)
+{
+	return riscv64_aes_xts_crypt(req, true);
+}
+
+static int riscv64_aes_xts_decrypt(struct skcipher_request *req)
+{
+	return riscv64_aes_xts_crypt(req, false);
+}
+
+/* Algorithm definitions */
+
+static struct crypto_alg riscv64_zvkned_aes_cipher_alg = {
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize = AES_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+	.cra_priority = 300,
+	.cra_name = "aes",
+	.cra_driver_name = "aes-riscv64-zvkned",
+	.cra_cipher = {
+		.cia_min_keysize = AES_MIN_KEY_SIZE,
+		.cia_max_keysize = AES_MAX_KEY_SIZE,
+		.cia_setkey = riscv64_aes_setkey_cipher,
+		.cia_encrypt = riscv64_aes_encrypt,
+		.cia_decrypt = riscv64_aes_decrypt,
+	},
+	.cra_module = THIS_MODULE,
+};
+
+static struct skcipher_alg riscv64_zvkned_aes_skcipher_algs[] = {
+	{
+		.setkey = riscv64_aes_setkey_skcipher,
+		.encrypt = riscv64_aes_ecb_encrypt,
+		.decrypt = riscv64_aes_ecb_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.walksize = 8 * AES_BLOCK_SIZE, /* matches LMUL=8 */
+		.base = {
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+			.cra_priority = 300,
+			.cra_name = "ecb(aes)",
+			.cra_driver_name = "ecb-aes-riscv64-zvkned",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.setkey = riscv64_aes_setkey_skcipher,
+		.encrypt = riscv64_aes_cbc_encrypt,
+		.decrypt = riscv64_aes_cbc_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.base = {
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+			.cra_priority = 300,
+			.cra_name = "cbc(aes)",
+			.cra_driver_name = "cbc-aes-riscv64-zvkned",
+			.cra_module = THIS_MODULE,
+		},
+	}
+};
+
+static struct skcipher_alg riscv64_zvkned_zvkb_aes_skcipher_alg = {
+	.setkey = riscv64_aes_setkey_skcipher,
+	.encrypt = riscv64_aes_ctr_crypt,
+	.decrypt = riscv64_aes_ctr_crypt,
+	.min_keysize = AES_MIN_KEY_SIZE,
+	.max_keysize = AES_MAX_KEY_SIZE,
+	.ivsize = AES_BLOCK_SIZE,
+	.chunksize = AES_BLOCK_SIZE,
+	.walksize = 4 * AES_BLOCK_SIZE, /* matches LMUL=4 */
+	.base = {
+		.cra_blocksize = 1,
+		.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+		.cra_priority = 300,
+		.cra_name = "ctr(aes)",
+		.cra_driver_name = "ctr-aes-riscv64-zvkned-zvkb",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static struct skcipher_alg riscv64_zvkned_zvbb_zvkg_aes_skcipher_alg = {
+	.setkey = riscv64_aes_xts_setkey,
+	.encrypt = riscv64_aes_xts_encrypt,
+	.decrypt = riscv64_aes_xts_decrypt,
+	.min_keysize = 2 * AES_MIN_KEY_SIZE,
+	.max_keysize = 2 * AES_MAX_KEY_SIZE,
+	.ivsize = AES_BLOCK_SIZE,
+	.chunksize = AES_BLOCK_SIZE,
+	.walksize = 4 * AES_BLOCK_SIZE, /* matches LMUL=4 */
+	.base = {
+		.cra_blocksize = AES_BLOCK_SIZE,
+		.cra_ctxsize = sizeof(struct riscv64_aes_xts_ctx),
+		.cra_priority = 300,
+		.cra_name = "xts(aes)",
+		.cra_driver_name = "xts-aes-riscv64-zvkned-zvbb-zvkg",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static inline bool riscv64_aes_xts_supported(void)
+{
+	return riscv_isa_extension_available(NULL, ZVBB) &&
+	       riscv_isa_extension_available(NULL, ZVKG) &&
+	       riscv_vector_vlen() < 2048 /* Implementation limitation */;
+}
+
+static int __init riscv64_aes_mod_init(void)
+{
+	int err = -ENODEV;
+
+	if (riscv_isa_extension_available(NULL, ZVKNED) &&
+	    riscv_vector_vlen() >= 128) {
+		err = crypto_register_alg(&riscv64_zvkned_aes_cipher_alg);
+		if (err)
+			return err;
+
+		err = crypto_register_skciphers(
+			riscv64_zvkned_aes_skcipher_algs,
+			ARRAY_SIZE(riscv64_zvkned_aes_skcipher_algs));
+		if (err)
+			goto unregister_zvkned_cipher_alg;
+
+		if (riscv_isa_extension_available(NULL, ZVKB)) {
+			err = crypto_register_skcipher(
+				&riscv64_zvkned_zvkb_aes_skcipher_alg);
+			if (err)
+				goto unregister_zvkned_skcipher_algs;
+		}
+
+		if (riscv64_aes_xts_supported()) {
+			err = crypto_register_skcipher(
+				&riscv64_zvkned_zvbb_zvkg_aes_skcipher_alg);
+			if (err)
+				goto unregister_zvkned_zvkb_skcipher_alg;
+		}
+	}
+
+	return err;
+
+unregister_zvkned_zvkb_skcipher_alg:
+	if (riscv_isa_extension_available(NULL, ZVKB))
+		crypto_unregister_skcipher(&riscv64_zvkned_zvkb_aes_skcipher_alg);
+unregister_zvkned_skcipher_algs:
+	crypto_unregister_skciphers(riscv64_zvkned_aes_skcipher_algs,
+				    ARRAY_SIZE(riscv64_zvkned_aes_skcipher_algs));
+unregister_zvkned_cipher_alg:
+	crypto_unregister_alg(&riscv64_zvkned_aes_cipher_alg);
+	return err;
+}
+
+static void __exit riscv64_aes_mod_exit(void)
+{
+	if (riscv64_aes_xts_supported())
+		crypto_unregister_skcipher(&riscv64_zvkned_zvbb_zvkg_aes_skcipher_alg);
+	if (riscv_isa_extension_available(NULL, ZVKB))
+		crypto_unregister_skcipher(&riscv64_zvkned_zvkb_aes_skcipher_alg);
+	crypto_unregister_skciphers(riscv64_zvkned_aes_skcipher_algs,
+				    ARRAY_SIZE(riscv64_zvkned_aes_skcipher_algs));
+	crypto_unregister_alg(&riscv64_zvkned_aes_cipher_alg);
+}
+
+module_init(riscv64_aes_mod_init);
+module_exit(riscv64_aes_mod_exit);
+
+MODULE_DESCRIPTION("AES-ECB/CBC/CTR/XTS (RISC-V accelerated)");
+MODULE_AUTHOR("Jerry Shih <jerry.shih@sifive.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("aes");
+MODULE_ALIAS_CRYPTO("ecb(aes)");
+MODULE_ALIAS_CRYPTO("cbc(aes)");
+MODULE_ALIAS_CRYPTO("ctr(aes)");
+MODULE_ALIAS_CRYPTO("xts(aes)");
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S b/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
new file mode 100644
index 0000000000000..146fc9cfb268d
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
@@ -0,0 +1,312 @@
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
+// - RISC-V Vector ('V') with VLEN >= 128 && VLEN < 2048
+// - RISC-V Vector AES block cipher extension ('Zvkned')
+// - RISC-V Vector Bit-manipulation extension ('Zvbb')
+// - RISC-V Vector GCM/GMAC extension ('Zvkg')
+
+#include <linux/linkage.h>
+
+.text
+.option arch, +zvkned, +zvbb, +zvkg
+
+#include "aes-macros.S"
+
+#define KEYP		a0
+#define INP		a1
+#define OUTP		a2
+#define LEN		a3
+#define TWEAKP		a4
+
+#define LEN32		a5
+#define TAIL_LEN	a6
+#define VL		a7
+#define VLMAX		t4
+
+// v1-v15 contain the AES round keys, but they are used for temporaries before
+// the AES round keys have been loaded.
+#define TWEAKS		v16	// LMUL=4 (most of the time)
+#define TWEAKS_BREV	v20	// LMUL=4 (most of the time)
+#define MULTS_BREV	v24	// LMUL=4 (most of the time)
+#define TMP0		v28
+#define TMP1		v29
+#define TMP2		v30
+#define TMP3		v31
+
+// xts_init initializes the following values:
+//
+//	TWEAKS: N 128-bit tweaks T*(x^i) for i in 0..(N - 1)
+//	TWEAKS_BREV: same as TWEAKS, but bit-reversed
+//	MULTS_BREV: N 128-bit values x^N, bit-reversed.  Only if N > 1.
+//
+// N is the maximum number of blocks that will be processed per loop iteration,
+// computed using vsetvli.
+//
+// The field convention used by XTS is the same as that of GHASH, but with the
+// bits reversed within each byte.  The zvkg extension provides the vgmul
+// instruction which does multiplication in this field.  Therefore, for tweak
+// computation we use vgmul to do multiplications in parallel, instead of
+// serially multiplying by x using shifting+xoring.  Note that for this to work,
+// the inputs and outputs to vgmul must be bit-reversed (we do it with vbrev8).
+.macro	xts_init
+
+	// Load the first tweak T.
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vle32.v		TWEAKS, (TWEAKP)
+
+	// If there's only one block (or no blocks at all), then skip the tweak
+	// sequence computation because (at most) T itself is needed.
+	li		t0, 16
+	ble		LEN, t0, .Linit_single_block\@
+
+	// Save a copy of T bit-reversed in v12.
+	vbrev8.v	v12, TWEAKS
+
+	//
+	// Generate x^i for i in 0..(N - 1), i.e. 128-bit values 1 << i assuming
+	// that N <= 128.  Though, this code actually requires N < 64 (or
+	// equivalently VLEN < 2048) due to the use of 64-bit intermediate
+	// values here and in the x^N computation later.
+	//
+	vsetvli		VL, LEN32, e32, m4, ta, ma
+	srli		t0, VL, 2	// t0 = N (num blocks)
+	// Generate two sequences, each with N 32-bit values:
+	// v0=[1, 1, 1, ...] and v1=[0, 1, 2, ...].
+	vsetvli		zero, t0, e32, m1, ta, ma
+	vmv.v.i		v0, 1
+	vid.v		v1
+	// Use vzext to zero-extend the sequences to 64 bits.  Reinterpret them
+	// as two sequences, each with 2*N 32-bit values:
+	// v2=[1, 0, 1, 0, 1, 0, ...] and v4=[0, 0, 1, 0, 2, 0, ...].
+	vsetvli		zero, t0, e64, m2, ta, ma
+	vzext.vf2	v2, v0
+	vzext.vf2	v4, v1
+	slli		t1, t0, 1	// t1 = 2*N
+	vsetvli		zero, t1, e32, m2, ta, ma
+	// Use vwsll to compute [1<<0, 0<<0, 1<<1, 0<<0, 1<<2, 0<<0, ...],
+	// widening to 64 bits per element.  When reinterpreted as N 128-bit
+	// values, this is the needed sequence of 128-bit values 1 << i (x^i).
+	vwsll.vv	v8, v2, v4
+
+	// Copy the bit-reversed T to all N elements of TWEAKS_BREV, then
+	// multiply by x^i.  This gives the sequence T*(x^i), bit-reversed.
+	vsetvli		zero, LEN32, e32, m4, ta, ma
+	vmv.v.i		TWEAKS_BREV, 0
+	vaesz.vs	TWEAKS_BREV, v12
+	vbrev8.v	v8, v8
+	vgmul.vv	TWEAKS_BREV, v8
+
+	// Save a copy of the sequence T*(x^i) with the bit reversal undone.
+	vbrev8.v	TWEAKS, TWEAKS_BREV
+
+	// Generate N copies of x^N, i.e. 128-bit values 1 << N, bit-reversed.
+	li		t1, 1
+	sll		t1, t1, t0	// t1 = 1 << N
+	vsetivli	zero, 2, e64, m1, ta, ma
+	vmv.v.i		v0, 0
+	vsetivli	zero, 1, e64, m1, tu, ma
+	vmv.v.x		v0, t1
+	vbrev8.v	v0, v0
+	vsetvli		zero, LEN32, e32, m4, ta, ma
+	vmv.v.i		MULTS_BREV, 0
+	vaesz.vs	MULTS_BREV, v0
+
+	j		.Linit_done\@
+
+.Linit_single_block\@:
+	vbrev8.v	TWEAKS_BREV, TWEAKS
+.Linit_done\@:
+.endm
+
+// Set the first 128 bits of MULTS_BREV to 0x40, i.e. 'x' bit-reversed.  This is
+// the multiplier required to advance the tweak by one.
+.macro	load_x
+	li		t0, 0x40
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vmv.v.i		MULTS_BREV, 0
+	vsetivli	zero, 1, e8, m1, tu, ma
+	vmv.v.x		MULTS_BREV, t0
+.endm
+
+.macro	__aes_xts_crypt	enc, keylen
+	// With 16 < len <= 31, there's no main loop, just ciphertext stealing.
+	beqz		LEN32, .Lcts_without_main_loop\@
+
+	vsetvli		VLMAX, zero, e32, m4, ta, ma
+1:
+	vsetvli		VL, LEN32, e32, m4, ta, ma
+2:
+	// Encrypt or decrypt VL/4 blocks.
+	vle32.v		TMP0, (INP)
+	vxor.vv		TMP0, TMP0, TWEAKS
+	aes_crypt	TMP0, \enc, \keylen
+	vxor.vv		TMP0, TMP0, TWEAKS
+	vse32.v		TMP0, (OUTP)
+
+	// Update the pointers and the remaining length.
+	slli		t0, VL, 2
+	add		INP, INP, t0
+	add		OUTP, OUTP, t0
+	sub		LEN32, LEN32, VL
+
+	// Check whether more blocks remain.
+	beqz		LEN32, .Lmain_loop_done\@
+
+	// Compute the next sequence of tweaks by multiplying the previous
+	// sequence by x^N.  Store the result in both bit-reversed order and
+	// regular order (i.e. with the bit reversal undone).
+	vgmul.vv	TWEAKS_BREV, MULTS_BREV
+	vbrev8.v	TWEAKS, TWEAKS_BREV
+
+	// Since we compute the tweak multipliers x^N in advance, we require
+	// that each iteration process the same length except possibly the last.
+	// This conflicts slightly with the behavior allowed by RISC-V Vector
+	// Extension, where CPUs can select a lower length for both of the last
+	// two iterations.  E.g., vl might take the sequence of values
+	// [16, 16, 16, 12, 12], whereas we need [16, 16, 16, 16, 8] so that we
+	// can use x^4 again instead of computing x^3.  Therefore, we explicitly
+	// keep the vl at VLMAX if there is at least VLMAX remaining.
+	bge		LEN32, VLMAX, 2b
+	j		1b
+
+.Lmain_loop_done\@:
+	load_x
+
+	// Compute the next tweak.
+	addi		t0, VL, -4
+	vsetivli	zero, 4, e32, m4, ta, ma
+	vslidedown.vx	TWEAKS_BREV, TWEAKS_BREV, t0	// Extract last tweak
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vgmul.vv	TWEAKS_BREV, MULTS_BREV		// Advance to next tweak
+
+	bnez		TAIL_LEN, .Lcts\@
+
+	// Update *TWEAKP to contain the next tweak.
+	vbrev8.v	TWEAKS, TWEAKS_BREV
+	vse32.v		TWEAKS, (TWEAKP)
+	ret
+
+.Lcts_without_main_loop\@:
+	load_x
+.Lcts\@:
+	// TWEAKS_BREV now contains the next tweak.  Compute the one after that.
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vmv.v.v		TMP0, TWEAKS_BREV
+	vgmul.vv	TMP0, MULTS_BREV
+	// Undo the bit reversal of the next two tweaks and store them in TMP1
+	// and TMP2, such that TMP1 is the first needed and TMP2 the second.
+.if \enc
+	vbrev8.v	TMP1, TWEAKS_BREV
+	vbrev8.v	TMP2, TMP0
+.else
+	vbrev8.v	TMP1, TMP0
+	vbrev8.v	TMP2, TWEAKS_BREV
+.endif
+
+	// Encrypt/decrypt the last full block.
+	vle32.v		TMP0, (INP)
+	vxor.vv		TMP0, TMP0, TMP1
+	aes_crypt	TMP0, \enc, \keylen
+	vxor.vv		TMP0, TMP0, TMP1
+
+	// Swap the first TAIL_LEN bytes of the above result with the tail.
+	// Note that to support in-place encryption/decryption, the load from
+	// the input tail must happen before the store to the output tail.
+	addi		t0, INP, 16
+	addi		t1, OUTP, 16
+	vmv.v.v		TMP3, TMP0
+	vsetvli		zero, TAIL_LEN, e8, m1, tu, ma
+	vle8.v		TMP0, (t0)
+	vse8.v		TMP3, (t1)
+
+	// Encrypt/decrypt again and store the last full block.
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vxor.vv		TMP0, TMP0, TMP2
+	aes_crypt	TMP0, \enc, \keylen
+	vxor.vv		TMP0, TMP0, TMP2
+	vse32.v		TMP0, (OUTP)
+
+	ret
+.endm
+
+.macro	aes_xts_crypt	enc
+
+	// Check whether the length is a multiple of the AES block size.
+	andi		TAIL_LEN, LEN, 15
+	beqz		TAIL_LEN, 1f
+
+	// The length isn't a multiple of the AES block size, so ciphertext
+	// stealing will be required.  Ciphertext stealing involves special
+	// handling of the partial block and the last full block, so subtract
+	// the length of both from the length to be processed in the main loop.
+	sub		LEN, LEN, TAIL_LEN
+	addi		LEN, LEN, -16
+1:
+	srli		LEN32, LEN, 2
+	// LEN and LEN32 now contain the total length of the blocks that will be
+	// processed in the main loop, in bytes and 32-bit words respectively.
+
+	xts_init
+	aes_begin	KEYP, 128f, 192f
+	__aes_xts_crypt	\enc, 256
+128:
+	__aes_xts_crypt	\enc, 128
+192:
+	__aes_xts_crypt	\enc, 192
+.endm
+
+// void aes_xts_encrypt_zvkned_zvbb_zvkg(const struct crypto_aes_ctx *key,
+//					 const u8 *in, u8 *out, size_t len,
+//					 u8 tweak[16]);
+//
+// |key| is the data key.  |tweak| contains the next tweak; the encryption of
+// the original IV with the tweak key was already done.  This function supports
+// incremental computation, but |len| must always be >= 16 (AES_BLOCK_SIZE), and
+// |len| must be a multiple of 16 except on the last call.  If |len| is a
+// multiple of 16, then this function updates |tweak| to contain the next tweak.
+SYM_FUNC_START(aes_xts_encrypt_zvkned_zvbb_zvkg)
+	aes_xts_crypt	1
+SYM_FUNC_END(aes_xts_encrypt_zvkned_zvbb_zvkg)
+
+// Same prototype and calling convention as the encryption function
+SYM_FUNC_START(aes_xts_decrypt_zvkned_zvbb_zvkg)
+	aes_xts_crypt	0
+SYM_FUNC_END(aes_xts_decrypt_zvkned_zvbb_zvkg)
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S b/arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
new file mode 100644
index 0000000000000..9962d45005870
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
@@ -0,0 +1,146 @@
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
+// - RISC-V Vector AES block cipher extension ('Zvkned')
+// - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+#include <linux/linkage.h>
+
+.text
+.option arch, +zvkned, +zvkb
+
+#include "aes-macros.S"
+
+#define KEYP		a0
+#define INP		a1
+#define OUTP		a2
+#define LEN		a3
+#define IVP		a4
+
+#define LEN32		a5
+#define VL_E32		a6
+#define VL_BLOCKS	a7
+
+.macro	aes_ctr32_crypt	keylen
+	// LEN32 = number of blocks, rounded up, in 32-bit words.
+	addi		t0, LEN, 15
+	srli		t0, t0, 4
+	slli		LEN32, t0, 2
+
+	// Create a mask that selects the last 32-bit word of each 128-bit
+	// block.  This is the word that contains the (big-endian) counter.
+	li		t0, 0x88
+	vsetvli		t1, zero, e8, m1, ta, ma
+	vmv.v.x		v0, t0
+
+	// Load the IV into v31.  The last 32-bit word contains the counter.
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vle32.v		v31, (IVP)
+
+	// Convert the big-endian counter into little-endian.
+	vsetivli	zero, 4, e32, m1, ta, mu
+	vrev8.v		v31, v31, v0.t
+
+	// Splat the IV to v16 (with LMUL=4).  The number of copies is the
+	// maximum number of blocks that will be processed per iteration.
+	vsetvli		zero, LEN32, e32, m4, ta, ma
+	vmv.v.i		v16, 0
+	vaesz.vs	v16, v31
+
+	// v20 = [x, x, x, 0, x, x, x, 1, ...]
+	viota.m		v20, v0, v0.t
+	// v16 = [IV0, IV1, IV2, counter+0, IV0, IV1, IV2, counter+1, ...]
+	vsetvli		VL_E32, LEN32, e32, m4, ta, mu
+	vadd.vv		v16, v16, v20, v0.t
+
+	j 2f
+1:
+	// Set the number of blocks to process in this iteration.  vl=VL_E32 is
+	// the length in 32-bit words, i.e. 4 times the number of blocks.
+	vsetvli		VL_E32, LEN32, e32, m4, ta, mu
+
+	// Increment the counters by the number of blocks processed in the
+	// previous iteration.
+	vadd.vx		v16, v16, VL_BLOCKS, v0.t
+2:
+	// Prepare the AES inputs into v24.
+	vmv.v.v		v24, v16
+	vrev8.v		v24, v24, v0.t	// Convert counters back to big-endian.
+
+	// Encrypt the AES inputs to create the next portion of the keystream.
+	aes_encrypt	v24, \keylen
+
+	// XOR the data with the keystream.
+	vsetvli		t0, LEN, e8, m4, ta, ma
+	vle8.v		v20, (INP)
+	vxor.vv		v20, v20, v24
+	vse8.v		v20, (OUTP)
+
+	// Advance the pointers and update the remaining length.
+	add		INP, INP, t0
+	add		OUTP, OUTP, t0
+	sub		LEN, LEN, t0
+	sub		LEN32, LEN32, VL_E32
+	srli		VL_BLOCKS, VL_E32, 2
+
+	// Repeat if more data remains.
+	bnez		LEN, 1b
+
+	// Update *IVP to contain the next counter.
+	vsetivli	zero, 4, e32, m1, ta, mu
+	vadd.vx		v16, v16, VL_BLOCKS, v0.t
+	vrev8.v		v16, v16, v0.t	// Convert counters back to big-endian.
+	vse32.v		v16, (IVP)
+
+	ret
+.endm
+
+// void aes_ctr32_crypt_zvkned_zvkb(const struct crypto_aes_ctx *key,
+//				    const u8 *in, u8 *out, size_t len,
+//				    u8 iv[16]);
+SYM_FUNC_START(aes_ctr32_crypt_zvkned_zvkb)
+	aes_begin	KEYP, 128f, 192f
+	aes_ctr32_crypt	256
+128:
+	aes_ctr32_crypt	128
+192:
+	aes_ctr32_crypt	192
+SYM_FUNC_END(aes_ctr32_crypt_zvkned_zvkb)
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.S b/arch/riscv/crypto/aes-riscv64-zvkned.S
new file mode 100644
index 0000000000000..78d4e1186c074
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.S
@@ -0,0 +1,180 @@
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
+	aes_begin	KEYP, 128f, 192f
+	__aes_crypt_zvkned	\enc, 256
+128:
+	__aes_crypt_zvkned	\enc, 128
+192:
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
+
+.macro	__aes_ecb_crypt	enc, keylen
+	srli		t0, LEN, 2
+	// t0 is the remaining length in 32-bit words.  It's a multiple of 4.
+1:
+	vsetvli		t1, t0, e32, m8, ta, ma
+	sub		t0, t0, t1	// Subtract number of words processed
+	slli		t1, t1, 2	// Words to bytes
+	vle32.v		v16, (INP)
+	aes_crypt	v16, \enc, \keylen
+	vse32.v		v16, (OUTP)
+	add		INP, INP, t1
+	add		OUTP, OUTP, t1
+	bnez		t0, 1b
+
+	ret
+.endm
+
+.macro	aes_ecb_crypt	enc
+	aes_begin	KEYP, 128f, 192f
+	__aes_ecb_crypt	\enc, 256
+128:
+	__aes_ecb_crypt	\enc, 128
+192:
+	__aes_ecb_crypt	\enc, 192
+.endm
+
+// void aes_ecb_encrypt_zvkned(const struct crypto_aes_ctx *key,
+//			       const u8 *in, u8 *out, size_t len);
+//
+// |len| must be nonzero and a multiple of 16 (AES_BLOCK_SIZE).
+SYM_FUNC_START(aes_ecb_encrypt_zvkned)
+	aes_ecb_crypt	1
+SYM_FUNC_END(aes_ecb_encrypt_zvkned)
+
+// Same prototype and calling convention as the encryption function
+SYM_FUNC_START(aes_ecb_decrypt_zvkned)
+	aes_ecb_crypt	0
+SYM_FUNC_END(aes_ecb_decrypt_zvkned)
+
+.macro	aes_cbc_encrypt	keylen
+	vle32.v		v16, (IVP)	// Load IV
+1:
+	vle32.v		v17, (INP)	// Load plaintext block
+	vxor.vv		v16, v16, v17	// XOR with IV or prev ciphertext block
+	aes_encrypt	v16, \keylen	// Encrypt
+	vse32.v		v16, (OUTP)	// Store ciphertext block
+	addi		INP, INP, 16
+	addi		OUTP, OUTP, 16
+	addi		LEN, LEN, -16
+	bnez		LEN, 1b
+
+	vse32.v		v16, (IVP)	// Store next IV
+	ret
+.endm
+
+.macro	aes_cbc_decrypt	keylen
+	vle32.v		v16, (IVP)	// Load IV
+1:
+	vle32.v		v17, (INP)	// Load ciphertext block
+	vmv.v.v		v18, v17	// Save ciphertext block
+	aes_decrypt	v17, \keylen	// Decrypt
+	vxor.vv		v17, v17, v16	// XOR with IV or prev ciphertext block
+	vse32.v		v17, (OUTP)	// Store plaintext block
+	vmv.v.v		v16, v18	// Next "IV" is prev ciphertext block
+	addi		INP, INP, 16
+	addi		OUTP, OUTP, 16
+	addi		LEN, LEN, -16
+	bnez		LEN, 1b
+
+	vse32.v		v16, (IVP)	// Store next IV
+	ret
+.endm
+
+// void aes_cbc_encrypt_zvkned(const struct crypto_aes_ctx *key,
+//			       const u8 *in, u8 *out, size_t len, u8 iv[16]);
+//
+// |len| must be nonzero and a multiple of 16 (AES_BLOCK_SIZE).
+SYM_FUNC_START(aes_cbc_encrypt_zvkned)
+	aes_begin	KEYP, 128f, 192f
+	aes_cbc_encrypt	256
+128:
+	aes_cbc_encrypt	128
+192:
+	aes_cbc_encrypt	192
+SYM_FUNC_END(aes_cbc_encrypt_zvkned)
+
+// Same prototype and calling convention as the encryption function
+SYM_FUNC_START(aes_cbc_decrypt_zvkned)
+	aes_begin	KEYP, 128f, 192f
+	aes_cbc_decrypt	256
+128:
+	aes_cbc_decrypt	128
+192:
+	aes_cbc_decrypt	192
+SYM_FUNC_END(aes_cbc_decrypt_zvkned)
-- 
2.43.0


