Return-Path: <linux-kernel+bounces-18279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047A825AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E05B286C93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0DF381BF;
	Fri,  5 Jan 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIBqIaiE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE8374F3;
	Fri,  5 Jan 2024 18:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B6DC433D9;
	Fri,  5 Jan 2024 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704480692;
	bh=Q9KorLkt9z4ETNv86tVce30LmXb337KOzYRmXS1ZQGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIBqIaiEYWEWx02zwyaHirNUpJcm10b4KacO6EhFXhcVN2GwLyTzQa4x3Ql32LNCa
	 Mav+8JgMm1Tyth5+KS/96pluhr9QvSJkk4iviO2L52SgxCFwkWtJF7sEwg86Ulhmlp
	 vNSlBAAmMJFDIWwi13ZJduR4T5f/CyyYZZeAAOz4ZykLxXJhDjDIR8OlHwKHhR4wLi
	 I6JrkM/40hDv6zD2Qbb9/ytXA2WFfbouADlSmhLvb9B34xoU9y/GFd3dfG7oGFn0l/
	 fDZTTI9LOmG8EZHILx0kaf/acU4nGeRaOGX7rokiSyhwK/VWQSnoX6fBWQKG8BuIU9
	 pMMjDzVexMROw==
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
	Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v2 09/12] crypto: riscv - add vector crypto accelerated SHA-{256,224}
Date: Fri,  5 Jan 2024 10:49:45 -0800
Message-ID: <20240105184950.43181-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184950.43181-1-ebiggers@kernel.org>
References: <20240105184950.43181-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jerry Shih <jerry.shih@sifive.com>

Add an implementation of SHA-256 and SHA-224 using the Zvknha or Zvknhb
extension.  The assembly code is derived from OpenSSL code
(openssl/openssl#21923) that was dual-licensed so that it could be
reused in the kernel.  Nevertheless, the assembly has been significantly
reworked for integration with the kernel, for example by using a regular
.S file instead of the so-called perlasm, using the assembler instead of
bare '.inst', and greatly reducing code duplication.

Co-developed-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Signed-off-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                     |  11 +
 arch/riscv/crypto/Makefile                    |   3 +
 arch/riscv/crypto/sha256-riscv64-glue.c       | 137 +++++++++++
 .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    | 225 ++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 676ba5af8f55a..687dbb71f7d50 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -32,11 +32,22 @@ config CRYPTO_CHACHA_RISCV64
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_GCM
 	help
 	  GCM GHASH function (NIST SP 800-38D)
 
 	  Architecture: riscv64 using:
 	  - Zvkg vector crypto extension
 
+config CRYPTO_SHA256_RISCV64
+	tristate "Hash functions: SHA-224 and SHA-256"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_SHA256
+	help
+	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64 using:
+	  - Zvknha or Zvknhb vector crypto extensions
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 9666a27d76862..8674e9829cdb1 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -5,10 +5,13 @@
 
 obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
 aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
 		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
 obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
 chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
 
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
+
+obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
+sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
new file mode 100644
index 0000000000000..71e051e40a64f
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-glue.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-256 and SHA-224 using the RISC-V vector crypto extensions
+ *
+ * Copyright (C) 2022 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha256_base.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+/*
+ * Note: the asm function only uses the 'state' field of struct sha256_state.
+ * It is assumed to be the first field.
+ */
+asmlinkage void sha256_transform_zvknha_or_zvknhb_zvkb(
+	struct sha256_state *state, const u8 *data, int num_blocks);
+
+static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
+				 unsigned int len)
+{
+	/*
+	 * Ensure struct sha256_state begins directly with the SHA-256
+	 * 256-bit internal state, as this is what the asm function expects.
+	 */
+	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		sha256_base_do_update(desc, data, len,
+				      sha256_transform_zvknha_or_zvknhb_zvkb);
+		kernel_vector_end();
+	} else {
+		crypto_sha256_update(desc, data, len);
+	}
+	return 0;
+}
+
+static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
+				unsigned int len, u8 *out)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sha256_base_do_update(
+				desc, data, len,
+				sha256_transform_zvknha_or_zvknhb_zvkb);
+		sha256_base_do_finalize(
+			desc, sha256_transform_zvknha_or_zvknhb_zvkb);
+		kernel_vector_end();
+
+		return sha256_base_finish(desc, out);
+	}
+
+	return crypto_sha256_finup(desc, data, len, out);
+}
+
+static int riscv64_sha256_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sha256_finup(desc, NULL, 0, out);
+}
+
+static int riscv64_sha256_digest(struct shash_desc *desc, const u8 *data,
+				 unsigned int len, u8 *out)
+{
+	return sha256_base_init(desc) ?:
+	       riscv64_sha256_finup(desc, data, len, out);
+}
+
+static struct shash_alg riscv64_sha256_algs[] = {
+	{
+		.init = sha256_base_init,
+		.update = riscv64_sha256_update,
+		.final = riscv64_sha256_final,
+		.finup = riscv64_sha256_finup,
+		.digest = riscv64_sha256_digest,
+		.descsize = sizeof(struct sha256_state),
+		.digestsize = SHA256_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA256_BLOCK_SIZE,
+			.cra_priority = 300,
+			.cra_name = "sha256",
+			.cra_driver_name = "sha256-riscv64-zvknha_or_zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.init = sha224_base_init,
+		.update = riscv64_sha256_update,
+		.final = riscv64_sha256_final,
+		.finup = riscv64_sha256_finup,
+		.descsize = sizeof(struct sha256_state),
+		.digestsize = SHA224_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA224_BLOCK_SIZE,
+			.cra_priority = 300,
+			.cra_name = "sha224",
+			.cra_driver_name = "sha224-riscv64-zvknha_or_zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+static int __init riscv64_sha256_mod_init(void)
+{
+	/* Both zvknha and zvknhb provide the SHA-256 instructions. */
+	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
+	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_shashes(riscv64_sha256_algs,
+					       ARRAY_SIZE(riscv64_sha256_algs));
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sha256_mod_exit(void)
+{
+	crypto_unregister_shashes(riscv64_sha256_algs,
+				  ARRAY_SIZE(riscv64_sha256_algs));
+}
+
+module_init(riscv64_sha256_mod_init);
+module_exit(riscv64_sha256_mod_exit);
+
+MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sha256");
+MODULE_ALIAS_CRYPTO("sha224");
diff --git a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S b/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
new file mode 100644
index 0000000000000..8ebcc17de4dce
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
@@ -0,0 +1,225 @@
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
+// - RISC-V Vector SHA-2 Secure Hash extension ('Zvknha' or 'Zvknhb')
+// - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+#include <linux/cfi_types.h>
+
+.text
+.option arch, +zvknha, +zvkb
+
+#define STATEP		a0
+#define DATA		a1
+#define NUM_BLOCKS	a2
+
+#define STATEP_C	a3
+
+#define MASK		v0
+#define INDICES		v1
+#define W0		v2
+#define W1		v3
+#define W2		v4
+#define W3		v5
+#define VTMP		v6
+#define FEBA		v7
+#define HGDC		v8
+#define K0		v10
+#define K1		v11
+#define K2		v12
+#define K3		v13
+#define K4		v14
+#define K5		v15
+#define K6		v16
+#define K7		v17
+#define K8		v18
+#define K9		v19
+#define K10		v20
+#define K11		v21
+#define K12		v22
+#define K13		v23
+#define K14		v24
+#define K15		v25
+#define PREV_FEBA	v26
+#define PREV_HGDC	v27
+
+// Do 4 rounds of SHA-256.  w0 contains the current 4 message schedule words.
+//
+// If not all the message schedule words have been computed yet, then this also
+// computes 4 more message schedule words.  w1-w3 contain the next 3 groups of 4
+// message schedule words; this macro computes the group after w3 and writes it
+// to w0.  This means that the next (w0, w1, w2, w3) is the current (w1, w2, w3,
+// w0), so the caller must cycle through the registers accordingly.
+.macro	sha256_4rounds	last, k, w0, w1, w2, w3
+	vadd.vv		VTMP, \k, \w0
+	vsha2cl.vv	HGDC, FEBA, VTMP
+	vsha2ch.vv	FEBA, HGDC, VTMP
+.if !\last
+	vmerge.vvm	VTMP, \w2, \w1, MASK
+	vsha2ms.vv	\w0, VTMP, \w3
+.endif
+.endm
+
+.macro	sha256_16rounds	last, k0, k1, k2, k3
+	sha256_4rounds	\last, \k0, W0, W1, W2, W3
+	sha256_4rounds	\last, \k1, W1, W2, W3, W0
+	sha256_4rounds	\last, \k2, W2, W3, W0, W1
+	sha256_4rounds	\last, \k3, W3, W0, W1, W2
+.endm
+
+// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[8], const u8 *data,
+//					       int num_blocks);
+SYM_TYPED_FUNC_START(sha256_transform_zvknha_or_zvknhb_zvkb)
+
+	// Load the round constants into K0-K15.
+	vsetivli	zero, 4, e32, m1, ta, ma
+	la		t0, K256
+	vle32.v		K0, (t0)
+	addi		t0, t0, 16
+	vle32.v		K1, (t0)
+	addi		t0, t0, 16
+	vle32.v		K2, (t0)
+	addi		t0, t0, 16
+	vle32.v		K3, (t0)
+	addi		t0, t0, 16
+	vle32.v		K4, (t0)
+	addi		t0, t0, 16
+	vle32.v		K5, (t0)
+	addi		t0, t0, 16
+	vle32.v		K6, (t0)
+	addi		t0, t0, 16
+	vle32.v		K7, (t0)
+	addi		t0, t0, 16
+	vle32.v		K8, (t0)
+	addi		t0, t0, 16
+	vle32.v		K9, (t0)
+	addi		t0, t0, 16
+	vle32.v		K10, (t0)
+	addi		t0, t0, 16
+	vle32.v		K11, (t0)
+	addi		t0, t0, 16
+	vle32.v		K12, (t0)
+	addi		t0, t0, 16
+	vle32.v		K13, (t0)
+	addi		t0, t0, 16
+	vle32.v		K14, (t0)
+	addi		t0, t0, 16
+	vle32.v		K15, (t0)
+
+	// Setup mask for the vmerge to replace the first word (idx==0) in
+	// message scheduling.  There are 4 words, so an 8-bit mask suffices.
+	vsetivli	zero, 1, e8, m1, ta, ma
+	vmv.v.i		MASK, 0x01
+
+	// Load the state.  The state is stored as {a,b,c,d,e,f,g,h}, but we
+	// need {f,e,b,a},{h,g,d,c}.  The dst vtype is e32m1 and the index vtype
+	// is e8mf4.  We use index-load with the i8 indices {20, 16, 4, 0},
+	// loaded using the 32-bit little endian value 0x00041014.
+	li		t0, 0x00041014
+	vsetivli	zero, 1, e32, m1, ta, ma
+	vmv.v.x		INDICES, t0
+	addi		STATEP_C, STATEP, 8
+	vsetivli	zero, 4, e32, m1, ta, ma
+	vluxei8.v	FEBA, (STATEP), INDICES
+	vluxei8.v	HGDC, (STATEP_C), INDICES
+
+.Lnext_block:
+	addi		NUM_BLOCKS, NUM_BLOCKS, -1
+
+	// Save the previous state, as it's needed later.
+	vmv.v.v		PREV_FEBA, FEBA
+	vmv.v.v		PREV_HGDC, HGDC
+
+	// Load the next 512-bit message block and endian-swap each 32-bit word.
+	vle32.v		W0, (DATA)
+	vrev8.v		W0, W0
+	addi		DATA, DATA, 16
+	vle32.v		W1, (DATA)
+	vrev8.v		W1, W1
+	addi		DATA, DATA, 16
+	vle32.v		W2, (DATA)
+	vrev8.v		W2, W2
+	addi		DATA, DATA, 16
+	vle32.v		W3, (DATA)
+	vrev8.v		W3, W3
+	addi		DATA, DATA, 16
+
+	// Do the 64 rounds of SHA-256.
+	sha256_16rounds	0, K0, K1, K2, K3
+	sha256_16rounds	0, K4, K5, K6, K7
+	sha256_16rounds	0, K8, K9, K10, K11
+	sha256_16rounds	1, K12, K13, K14, K15
+
+	// Add the previous state.
+	vadd.vv		FEBA, FEBA, PREV_FEBA
+	vadd.vv		HGDC, HGDC, PREV_HGDC
+
+	// Repeat if more blocks remain.
+	bnez		NUM_BLOCKS, .Lnext_block
+
+	// Store the new state and return.
+	vsuxei8.v	FEBA, (STATEP), INDICES
+	vsuxei8.v	HGDC, (STATEP_C), INDICES
+	ret
+SYM_FUNC_END(sha256_transform_zvknha_or_zvknhb_zvkb)
+
+.section ".rodata"
+.p2align 2
+.type K256, @object
+K256:
+	.word		0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5
+	.word		0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5
+	.word		0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3
+	.word		0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174
+	.word		0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc
+	.word		0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da
+	.word		0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7
+	.word		0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967
+	.word		0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13
+	.word		0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85
+	.word		0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3
+	.word		0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070
+	.word		0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5
+	.word		0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3
+	.word		0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208
+	.word		0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
+.size K256, . - K256
-- 
2.43.0


