Return-Path: <linux-kernel+bounces-32236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5B8358F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C601F22C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293D53A9;
	Mon, 22 Jan 2024 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+NDonKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CF33C8;
	Mon, 22 Jan 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882981; cv=none; b=E0v6i7VLZVVKy62Li7f9zq9bR2a2ONtRzx+Nsisodz03Ks7LNkqX7pk/GTNpLpTwEpDAnPUtLE7oftDSV1O11GLXtw2upbjMciqmHDR6NOulMJVo6HiorYmrlTP919PoFSOdUis5bNCz4BzuCtgubweLqtpcI3atLE0i619RTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882981; c=relaxed/simple;
	bh=A4Q6dU0W0wB5xtZm1bf80ruC0X86VEjB52RlElp15SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9+KtTbObWw6vlelFZLc3q75Bmn6K/fsFDX8vBjvLdSYWGgIPih8u6XBD4uhjp+kxj0tdtoDiqDAgb4ruDTB/JB9bJqRGPg9TO/C28gEa5dTRV0F+3m95bQbcC71eGch2paDpTKtLCVp+Tihe8rgrDcWsyo5yHTo5+gRcSSD07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+NDonKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87638C43394;
	Mon, 22 Jan 2024 00:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705882981;
	bh=A4Q6dU0W0wB5xtZm1bf80ruC0X86VEjB52RlElp15SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+NDonKz6NhhCID8CiUBaqWXBpIAB7PeZBjQrb6l7ozO5cGLv5R1QluEgDKT3y6ga
	 XxWuO8sWDaLmQNFgjhGO4dsB97q4ZqUzWdUWRtHbcH/xOOj7fW2gihi2qWbb9oPcgD
	 qFLUE491oSvqt37SH1/ldqx10hHmxWqvfGFh3apj3B72zJicqtbyR8/J3FWIwzCXV1
	 YG4WDbdDVYE9JaAayiRMn8IQo33AzYP1p1mHrbMVF+LF6HmZvfEtSukyS/TGMPjPLk
	 5G8d1diKZMcszQ1JxkWCr+OzgHjOfyiVzGNX1fir1rf0WXc1GkrQ8xlKeNVCkdnkXd
	 hZkbteEhT5z7w==
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
Subject: [PATCH v3 05/10] crypto: riscv - add vector crypto accelerated ChaCha20
Date: Sun, 21 Jan 2024 16:19:16 -0800
Message-ID: <20240122002024.27477-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
References: <20240122002024.27477-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jerry Shih <jerry.shih@sifive.com>

Add an implementation of ChaCha20 using the Zvkb extension.  The
assembly code is derived from OpenSSL code (openssl/openssl#21923) that
was dual-licensed so that it could be reused in the kernel.
Nevertheless, the assembly has been significantly reworked for
integration with the kernel, for example by using a regular .S file
instead of the so-called perlasm, using the assembler instead of bare
'.inst', and reducing code duplication.

Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig               |  11 +
 arch/riscv/crypto/Makefile              |   3 +
 arch/riscv/crypto/chacha-riscv64-glue.c | 101 ++++++++
 arch/riscv/crypto/chacha-riscv64-zvkb.S | 294 ++++++++++++++++++++++++
 4 files changed, 409 insertions(+)
 create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index ebe805fa3f5f7..cb59e1d954952 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -11,11 +11,22 @@ config CRYPTO_AES_RISCV64
 	help
 	  Block cipher: AES cipher algorithms
 	  Length-preserving ciphers: AES with ECB, CBC, CTR, XTS
 
 	  Architecture: riscv64 using:
 	  - Zvkned vector crypto extension
 	  - Zvbb vector extension (XTS)
 	  - Zvkb vector crypto extension (CTR)
 	  - Zvkg vector crypto extension (XTS)
 
+config CRYPTO_CHACHA_RISCV64
+	tristate "Ciphers: ChaCha"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	help
+	  Length-preserving ciphers: ChaCha20 stream cipher algorithm
+
+	  Architecture: riscv64 using:
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 44922df7d182f..ee994c8e65509 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
 aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
 		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
+
+obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
+chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c b/arch/riscv/crypto/chacha-riscv64-glue.c
new file mode 100644
index 0000000000000..10b46f36375af
--- /dev/null
+++ b/arch/riscv/crypto/chacha-riscv64-glue.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ChaCha20 using the RISC-V vector crypto extensions
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/chacha.h>
+#include <crypto/internal/skcipher.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+asmlinkage void chacha20_zvkb(const u32 key[8], const u8 *in, u8 *out,
+			      size_t len, const u32 iv[4]);
+
+static int riscv64_chacha20_crypt(struct skcipher_request *req)
+{
+	u32 iv[CHACHA_IV_SIZE / sizeof(u32)];
+	u8 block_buffer[CHACHA_BLOCK_SIZE];
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	unsigned int tail_bytes;
+	int err;
+
+	iv[0] = get_unaligned_le32(req->iv);
+	iv[1] = get_unaligned_le32(req->iv + 4);
+	iv[2] = get_unaligned_le32(req->iv + 8);
+	iv[3] = get_unaligned_le32(req->iv + 12);
+
+	err = skcipher_walk_virt(&walk, req, false);
+	while (walk.nbytes) {
+		nbytes = walk.nbytes & ~(CHACHA_BLOCK_SIZE - 1);
+		tail_bytes = walk.nbytes & (CHACHA_BLOCK_SIZE - 1);
+		kernel_vector_begin();
+		if (nbytes) {
+			chacha20_zvkb(ctx->key, walk.src.virt.addr,
+				      walk.dst.virt.addr, nbytes, iv);
+			iv[0] += nbytes / CHACHA_BLOCK_SIZE;
+		}
+		if (walk.nbytes == walk.total && tail_bytes > 0) {
+			memcpy(block_buffer, walk.src.virt.addr + nbytes,
+			       tail_bytes);
+			chacha20_zvkb(ctx->key, block_buffer, block_buffer,
+				      CHACHA_BLOCK_SIZE, iv);
+			memcpy(walk.dst.virt.addr + nbytes, block_buffer,
+			       tail_bytes);
+			tail_bytes = 0;
+		}
+		kernel_vector_end();
+
+		err = skcipher_walk_done(&walk, tail_bytes);
+	}
+
+	return err;
+}
+
+static struct skcipher_alg riscv64_chacha_alg = {
+	.setkey = chacha20_setkey,
+	.encrypt = riscv64_chacha20_crypt,
+	.decrypt = riscv64_chacha20_crypt,
+	.min_keysize = CHACHA_KEY_SIZE,
+	.max_keysize = CHACHA_KEY_SIZE,
+	.ivsize = CHACHA_IV_SIZE,
+	.chunksize = CHACHA_BLOCK_SIZE,
+	.walksize = 4 * CHACHA_BLOCK_SIZE,
+	.base = {
+		.cra_blocksize = 1,
+		.cra_ctxsize = sizeof(struct chacha_ctx),
+		.cra_priority = 300,
+		.cra_name = "chacha20",
+		.cra_driver_name = "chacha20-riscv64-zvkb",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static int __init riscv64_chacha_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_skcipher(&riscv64_chacha_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_chacha_mod_exit(void)
+{
+	crypto_unregister_skcipher(&riscv64_chacha_alg);
+}
+
+module_init(riscv64_chacha_mod_init);
+module_exit(riscv64_chacha_mod_exit);
+
+MODULE_DESCRIPTION("ChaCha20 (RISC-V accelerated)");
+MODULE_AUTHOR("Jerry Shih <jerry.shih@sifive.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("chacha20");
diff --git a/arch/riscv/crypto/chacha-riscv64-zvkb.S b/arch/riscv/crypto/chacha-riscv64-zvkb.S
new file mode 100644
index 0000000000000..bf057737ac693
--- /dev/null
+++ b/arch/riscv/crypto/chacha-riscv64-zvkb.S
@@ -0,0 +1,294 @@
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
+// - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+#include <linux/linkage.h>
+
+.text
+.option arch, +zvkb
+
+#define KEYP		a0
+#define INP		a1
+#define OUTP		a2
+#define LEN		a3
+#define IVP		a4
+
+#define CONSTS0		a5
+#define CONSTS1		a6
+#define CONSTS2		a7
+#define CONSTS3		t0
+#define TMP		t1
+#define VL		t2
+#define STRIDE		t3
+#define NROUNDS		t4
+#define KEY0		s0
+#define KEY1		s1
+#define KEY2		s2
+#define KEY3		s3
+#define KEY4		s4
+#define KEY5		s5
+#define KEY6		s6
+#define KEY7		s7
+#define COUNTER		s8
+#define NONCE0		s9
+#define NONCE1		s10
+#define NONCE2		s11
+
+.macro	chacha_round	a0, b0, c0, d0,  a1, b1, c1, d1, \
+			a2, b2, c2, d2,  a3, b3, c3, d3
+	// a += b; d ^= a; d = rol(d, 16);
+	vadd.vv		\a0, \a0, \b0
+	vadd.vv		\a1, \a1, \b1
+	vadd.vv		\a2, \a2, \b2
+	vadd.vv		\a3, \a3, \b3
+	vxor.vv		\d0, \d0, \a0
+	vxor.vv		\d1, \d1, \a1
+	vxor.vv		\d2, \d2, \a2
+	vxor.vv		\d3, \d3, \a3
+	vror.vi		\d0, \d0, 32 - 16
+	vror.vi		\d1, \d1, 32 - 16
+	vror.vi		\d2, \d2, 32 - 16
+	vror.vi		\d3, \d3, 32 - 16
+
+	// c += d; b ^= c; b = rol(b, 12);
+	vadd.vv		\c0, \c0, \d0
+	vadd.vv		\c1, \c1, \d1
+	vadd.vv		\c2, \c2, \d2
+	vadd.vv		\c3, \c3, \d3
+	vxor.vv		\b0, \b0, \c0
+	vxor.vv		\b1, \b1, \c1
+	vxor.vv		\b2, \b2, \c2
+	vxor.vv		\b3, \b3, \c3
+	vror.vi		\b0, \b0, 32 - 12
+	vror.vi		\b1, \b1, 32 - 12
+	vror.vi		\b2, \b2, 32 - 12
+	vror.vi		\b3, \b3, 32 - 12
+
+	// a += b; d ^= a; d = rol(d, 8);
+	vadd.vv		\a0, \a0, \b0
+	vadd.vv		\a1, \a1, \b1
+	vadd.vv		\a2, \a2, \b2
+	vadd.vv		\a3, \a3, \b3
+	vxor.vv		\d0, \d0, \a0
+	vxor.vv		\d1, \d1, \a1
+	vxor.vv		\d2, \d2, \a2
+	vxor.vv		\d3, \d3, \a3
+	vror.vi		\d0, \d0, 32 - 8
+	vror.vi		\d1, \d1, 32 - 8
+	vror.vi		\d2, \d2, 32 - 8
+	vror.vi		\d3, \d3, 32 - 8
+
+	// c += d; b ^= c; b = rol(b, 7);
+	vadd.vv		\c0, \c0, \d0
+	vadd.vv		\c1, \c1, \d1
+	vadd.vv		\c2, \c2, \d2
+	vadd.vv		\c3, \c3, \d3
+	vxor.vv		\b0, \b0, \c0
+	vxor.vv		\b1, \b1, \c1
+	vxor.vv		\b2, \b2, \c2
+	vxor.vv		\b3, \b3, \c3
+	vror.vi		\b0, \b0, 32 - 7
+	vror.vi		\b1, \b1, 32 - 7
+	vror.vi		\b2, \b2, 32 - 7
+	vror.vi		\b3, \b3, 32 - 7
+.endm
+
+// void chacha20_zvkb(const u32 key[8], const u8 *in, u8 *out, size_t len,
+//		      const u32 iv[4]);
+//
+// |len| must be nonzero and a multiple of 64 (CHACHA_BLOCK_SIZE).
+// The counter is treated as 32-bit, following the RFC7539 convention.
+SYM_FUNC_START(chacha20_zvkb)
+	srli		LEN, LEN, 6	// Bytes to blocks
+
+	addi		sp, sp, -96
+	sd		s0, 0(sp)
+	sd		s1, 8(sp)
+	sd		s2, 16(sp)
+	sd		s3, 24(sp)
+	sd		s4, 32(sp)
+	sd		s5, 40(sp)
+	sd		s6, 48(sp)
+	sd		s7, 56(sp)
+	sd		s8, 64(sp)
+	sd		s9, 72(sp)
+	sd		s10, 80(sp)
+	sd		s11, 88(sp)
+
+	li		STRIDE, 64
+
+	// Set up the initial state matrix in scalar registers.
+	li		CONSTS0, 0x61707865	// "expa" little endian
+	li		CONSTS1, 0x3320646e	// "nd 3" little endian
+	li		CONSTS2, 0x79622d32	// "2-by" little endian
+	li		CONSTS3, 0x6b206574	// "te k" little endian
+	lw		KEY0, 0(KEYP)
+	lw		KEY1, 4(KEYP)
+	lw		KEY2, 8(KEYP)
+	lw		KEY3, 12(KEYP)
+	lw		KEY4, 16(KEYP)
+	lw		KEY5, 20(KEYP)
+	lw		KEY6, 24(KEYP)
+	lw		KEY7, 28(KEYP)
+	lw		COUNTER, 0(IVP)
+	lw		NONCE0, 4(IVP)
+	lw		NONCE1, 8(IVP)
+	lw		NONCE2, 12(IVP)
+
+.Lblock_loop:
+	// Set vl to the number of blocks to process in this iteration.
+	vsetvli		VL, LEN, e32, m1, ta, ma
+
+	// Set up the initial state matrix for the next VL blocks in v0-v15.
+	// v{i} holds the i'th 32-bit word of the state matrix for all blocks.
+	// Note that only the counter word, at index 12, differs across blocks.
+	vmv.v.x		v0, CONSTS0
+	vmv.v.x		v1, CONSTS1
+	vmv.v.x		v2, CONSTS2
+	vmv.v.x		v3, CONSTS3
+	vmv.v.x		v4, KEY0
+	vmv.v.x		v5, KEY1
+	vmv.v.x		v6, KEY2
+	vmv.v.x		v7, KEY3
+	vmv.v.x		v8, KEY4
+	vmv.v.x		v9, KEY5
+	vmv.v.x		v10, KEY6
+	vmv.v.x		v11, KEY7
+	vid.v		v12
+	vadd.vx		v12, v12, COUNTER
+	vmv.v.x		v13, NONCE0
+	vmv.v.x		v14, NONCE1
+	vmv.v.x		v15, NONCE2
+
+	// Load the first half of the input data for each block into v16-v23.
+	// v{16+i} holds the i'th 32-bit word for all blocks.
+	vlsseg8e32.v	v16, (INP), STRIDE
+
+	li		NROUNDS, 20
+.Lnext_doubleround:
+	addi		NROUNDS, NROUNDS, -2
+	// column round
+	chacha_round	v0, v4, v8, v12, v1, v5, v9, v13, \
+			v2, v6, v10, v14, v3, v7, v11, v15
+	// diagonal round
+	chacha_round	v0, v5, v10, v15, v1, v6, v11, v12, \
+			v2, v7, v8, v13, v3, v4, v9, v14
+	bnez		NROUNDS, .Lnext_doubleround
+
+	// Load the second half of the input data for each block into v24-v31.
+	// v{24+i} holds the {8+i}'th 32-bit word for all blocks.
+	addi		TMP, INP, 32
+	vlsseg8e32.v	v24, (TMP), STRIDE
+
+	// Finalize the first half of the keystream for each block.
+	vadd.vx		v0, v0, CONSTS0
+	vadd.vx		v1, v1, CONSTS1
+	vadd.vx		v2, v2, CONSTS2
+	vadd.vx		v3, v3, CONSTS3
+	vadd.vx		v4, v4, KEY0
+	vadd.vx		v5, v5, KEY1
+	vadd.vx		v6, v6, KEY2
+	vadd.vx		v7, v7, KEY3
+
+	// Encrypt/decrypt the first half of the data for each block.
+	vxor.vv		v16, v16, v0
+	vxor.vv		v17, v17, v1
+	vxor.vv		v18, v18, v2
+	vxor.vv		v19, v19, v3
+	vxor.vv		v20, v20, v4
+	vxor.vv		v21, v21, v5
+	vxor.vv		v22, v22, v6
+	vxor.vv		v23, v23, v7
+
+	// Store the first half of the output data for each block.
+	vssseg8e32.v	v16, (OUTP), STRIDE
+
+	// Finalize the second half of the keystream for each block.
+	vadd.vx		v8, v8, KEY4
+	vadd.vx		v9, v9, KEY5
+	vadd.vx		v10, v10, KEY6
+	vadd.vx		v11, v11, KEY7
+	vid.v		v0
+	vadd.vx		v12, v12, COUNTER
+	vadd.vx		v13, v13, NONCE0
+	vadd.vx		v14, v14, NONCE1
+	vadd.vx		v15, v15, NONCE2
+	vadd.vv		v12, v12, v0
+
+	// Encrypt/decrypt the second half of the data for each block.
+	vxor.vv		v24, v24, v8
+	vxor.vv		v25, v25, v9
+	vxor.vv		v26, v26, v10
+	vxor.vv		v27, v27, v11
+	vxor.vv		v29, v29, v13
+	vxor.vv		v28, v28, v12
+	vxor.vv		v30, v30, v14
+	vxor.vv		v31, v31, v15
+
+	// Store the second half of the output data for each block.
+	addi		TMP, OUTP, 32
+	vssseg8e32.v	v24, (TMP), STRIDE
+
+	// Update the counter, the remaining number of blocks, and the input and
+	// output pointers according to the number of blocks processed (VL).
+	add		COUNTER, COUNTER, VL
+	sub		LEN, LEN, VL
+	slli		TMP, VL, 6
+	add		OUTP, OUTP, TMP
+	add		INP, INP, TMP
+	bnez		LEN, .Lblock_loop
+
+	ld		s0, 0(sp)
+	ld		s1, 8(sp)
+	ld		s2, 16(sp)
+	ld		s3, 24(sp)
+	ld		s4, 32(sp)
+	ld		s5, 40(sp)
+	ld		s6, 48(sp)
+	ld		s7, 56(sp)
+	ld		s8, 64(sp)
+	ld		s9, 72(sp)
+	ld		s10, 80(sp)
+	ld		s11, 88(sp)
+	addi		sp, sp, 96
+	ret
+SYM_FUNC_END(chacha20_zvkb)
-- 
2.43.0


