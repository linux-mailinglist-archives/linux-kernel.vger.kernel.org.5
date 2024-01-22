Return-Path: <linux-kernel+bounces-32240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A08358FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB87B22683
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D0C138;
	Mon, 22 Jan 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGYbGawk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E56112;
	Mon, 22 Jan 2024 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882983; cv=none; b=OWli02xM55cGCf2pXC/v+x3eVy/0Ri/GISDf5WLLfyKwe5O1Txd4T3nHlYjq/rmyQPZ16Q5U3xERZHHm7DI1iqNdViowe31JTVsU7/aWhqXXwE2ip90pkRBAIk4gqVht+QMBTUU+2StCWAFunpGNPhpFsL/IlrsTuOK1LFl19yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882983; c=relaxed/simple;
	bh=4Ha/UV6gXKRUBFjdEe89uT+I/5SkE6jha5EbdgOOn5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0rlmEKJJhLwDjY5nlbYB/6cuA+Z17XGb49VEH38BijUQ95+XiyRN8BLr2HhaVBVFw0JxIsx1adw7NzLEgRSddyWmSbazHnxplTCZMGWt4TrDkTRdR7flba/vCIlznuXcXo4UJ7TEvBocASQk/avv8OcwTZ1go9Knpy+pos6Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGYbGawk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8803C433C7;
	Mon, 22 Jan 2024 00:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705882983;
	bh=4Ha/UV6gXKRUBFjdEe89uT+I/5SkE6jha5EbdgOOn5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGYbGawkUAdSFn9eetZab427ugWpSngzAKn39zb/KfV0XD35hogsVid+QQonJvgsK
	 K0YdhH0oPCyaCVHqUxdXPwuH3li57cij0WEl1XaA6qD7en8IFZfig4L3rqw8LDWgA7
	 +OhxhLYQ/f7Vjh8KCEqO0A9WiIZElIP/YYOggv526y74v399aDUUbNjuvCW1m+5bHO
	 Klu8x56fG7z87ncgV9tGHnhF6UERjgInPkywTwmBB7n+iYI6yGkwVNGAb3MD/kzOrQ
	 nfZ63HyeV+OX71/NdB8x62D32KKP5afaS1hzQvlb7yWYXwJTrm50zjdjd1R5ZCv26b
	 oibqtwzpM5k8Q==
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
	hongrong.hsu@sifive.com,
	Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v3 08/10] crypto: riscv - add vector crypto accelerated SHA-{512,384}
Date: Sun, 21 Jan 2024 16:19:19 -0800
Message-ID: <20240122002024.27477-9-ebiggers@kernel.org>
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

Add an implementation of SHA-512 and SHA-384 using the Zvknhb extension.
The assembly code is derived from OpenSSL code (openssl/openssl#21923)
that was dual-licensed so that it could be reused in the kernel.
Nevertheless, the assembly has been significantly reworked for
integration with the kernel, for example by using a regular .S file
instead of the so-called perlasm, using the assembler instead of bare
'.inst', and greatly reducing code duplication.

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
 arch/riscv/crypto/sha512-riscv64-glue.c       | 133 ++++++++++++
 .../riscv/crypto/sha512-riscv64-zvknhb-zvkb.S | 203 ++++++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 687dbb71f7d50..0fd0bf46c9099 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -43,11 +43,22 @@ config CRYPTO_SHA256_RISCV64
 	tristate "Hash functions: SHA-224 and SHA-256"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_SHA256
 	help
 	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
 
 	  Architecture: riscv64 using:
 	  - Zvknha or Zvknhb vector crypto extensions
 	  - Zvkb vector crypto extension
 
+config CRYPTO_SHA512_RISCV64
+	tristate "Hash functions: SHA-384 and SHA-512"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_SHA512
+	help
+	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64 using:
+	  - Zvknhb vector crypto extension
+	  - Zvkb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 56064ea6e3efe..356a931db0eb7 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -5,10 +5,13 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
 		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
 obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
 chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
 
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
 obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
 sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
+
+obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
+sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
diff --git a/arch/riscv/crypto/sha512-riscv64-glue.c b/arch/riscv/crypto/sha512-riscv64-glue.c
new file mode 100644
index 0000000000000..43b56a08aeb51
--- /dev/null
+++ b/arch/riscv/crypto/sha512-riscv64-glue.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-512 and SHA-384 using the RISC-V vector crypto extensions
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
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha512_base.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+/*
+ * Note: the asm function only uses the 'state' field of struct sha512_state.
+ * It is assumed to be the first field.
+ */
+asmlinkage void sha512_transform_zvknhb_zvkb(
+	struct sha512_state *state, const u8 *data, int num_blocks);
+
+static int riscv64_sha512_update(struct shash_desc *desc, const u8 *data,
+				 unsigned int len)
+{
+	/*
+	 * Ensure struct sha512_state begins directly with the SHA-512
+	 * 512-bit internal state, as this is what the asm function expects.
+	 */
+	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		sha512_base_do_update(desc, data, len,
+				      sha512_transform_zvknhb_zvkb);
+		kernel_vector_end();
+	} else {
+		crypto_sha512_update(desc, data, len);
+	}
+	return 0;
+}
+
+static int riscv64_sha512_finup(struct shash_desc *desc, const u8 *data,
+				unsigned int len, u8 *out)
+{
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sha512_base_do_update(desc, data, len,
+					      sha512_transform_zvknhb_zvkb);
+		sha512_base_do_finalize(desc, sha512_transform_zvknhb_zvkb);
+		kernel_vector_end();
+
+		return sha512_base_finish(desc, out);
+	}
+
+	return crypto_sha512_finup(desc, data, len, out);
+}
+
+static int riscv64_sha512_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sha512_finup(desc, NULL, 0, out);
+}
+
+static int riscv64_sha512_digest(struct shash_desc *desc, const u8 *data,
+				 unsigned int len, u8 *out)
+{
+	return sha512_base_init(desc) ?:
+	       riscv64_sha512_finup(desc, data, len, out);
+}
+
+static struct shash_alg riscv64_sha512_algs[] = {
+	{
+		.init = sha512_base_init,
+		.update = riscv64_sha512_update,
+		.final = riscv64_sha512_final,
+		.finup = riscv64_sha512_finup,
+		.digest = riscv64_sha512_digest,
+		.descsize = sizeof(struct sha512_state),
+		.digestsize = SHA512_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA512_BLOCK_SIZE,
+			.cra_priority = 300,
+			.cra_name = "sha512",
+			.cra_driver_name = "sha512-riscv64-zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.init = sha384_base_init,
+		.update = riscv64_sha512_update,
+		.final = riscv64_sha512_final,
+		.finup = riscv64_sha512_finup,
+		.descsize = sizeof(struct sha512_state),
+		.digestsize = SHA384_DIGEST_SIZE,
+		.base = {
+			.cra_blocksize = SHA384_BLOCK_SIZE,
+			.cra_priority = 300,
+			.cra_name = "sha384",
+			.cra_driver_name = "sha384-riscv64-zvknhb-zvkb",
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+static int __init riscv64_sha512_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKNHB) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_shashes(riscv64_sha512_algs,
+					       ARRAY_SIZE(riscv64_sha512_algs));
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sha512_mod_exit(void)
+{
+	crypto_unregister_shashes(riscv64_sha512_algs,
+				  ARRAY_SIZE(riscv64_sha512_algs));
+}
+
+module_init(riscv64_sha512_mod_init);
+module_exit(riscv64_sha512_mod_exit);
+
+MODULE_DESCRIPTION("SHA-512 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sha512");
+MODULE_ALIAS_CRYPTO("sha384");
diff --git a/arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S b/arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S
new file mode 100644
index 0000000000000..3a9ae210f9158
--- /dev/null
+++ b/arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S
@@ -0,0 +1,203 @@
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
+// - RISC-V Vector SHA-2 Secure Hash extension ('Zvknhb')
+// - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+#include <linux/cfi_types.h>
+
+.text
+.option arch, +zvknhb, +zvkb
+
+#define STATEP		a0
+#define DATA		a1
+#define NUM_BLOCKS	a2
+
+#define STATEP_C	a3
+#define K		a4
+
+#define MASK		v0
+#define INDICES		v1
+#define W0		v10	// LMUL=2
+#define W1		v12	// LMUL=2
+#define W2		v14	// LMUL=2
+#define W3		v16	// LMUL=2
+#define VTMP		v20	// LMUL=2
+#define FEBA		v22	// LMUL=2
+#define HGDC		v24	// LMUL=2
+#define PREV_FEBA	v26	// LMUL=2
+#define PREV_HGDC	v28	// LMUL=2
+
+// Do 4 rounds of SHA-512.  w0 contains the current 4 message schedule words.
+//
+// If not all the message schedule words have been computed yet, then this also
+// computes 4 more message schedule words.  w1-w3 contain the next 3 groups of 4
+// message schedule words; this macro computes the group after w3 and writes it
+// to w0.  This means that the next (w0, w1, w2, w3) is the current (w1, w2, w3,
+// w0), so the caller must cycle through the registers accordingly.
+.macro	sha512_4rounds	last, w0, w1, w2, w3
+	vle64.v		VTMP, (K)
+	addi		K, K, 32
+	vadd.vv		VTMP, VTMP, \w0
+	vsha2cl.vv	HGDC, FEBA, VTMP
+	vsha2ch.vv	FEBA, HGDC, VTMP
+.if !\last
+	vmerge.vvm	VTMP, \w2, \w1, MASK
+	vsha2ms.vv	\w0, VTMP, \w3
+.endif
+.endm
+
+.macro	sha512_16rounds	last
+	sha512_4rounds	\last, W0, W1, W2, W3
+	sha512_4rounds	\last, W1, W2, W3, W0
+	sha512_4rounds	\last, W2, W3, W0, W1
+	sha512_4rounds	\last, W3, W0, W1, W2
+.endm
+
+// void sha512_transform_zvknhb_zvkb(u64 state[8], const u8 *data,
+//				     int num_blocks);
+SYM_TYPED_FUNC_START(sha512_transform_zvknhb_zvkb)
+
+	// Setup mask for the vmerge to replace the first word (idx==0) in
+	// message scheduling.  There are 4 words, so an 8-bit mask suffices.
+	vsetivli	zero, 1, e8, m1, ta, ma
+	vmv.v.i		MASK, 0x01
+
+	// Load the state.  The state is stored as {a,b,c,d,e,f,g,h}, but we
+	// need {f,e,b,a},{h,g,d,c}.  The dst vtype is e64m2 and the index vtype
+	// is e8mf4.  We use index-load with the i8 indices {40, 32, 8, 0},
+	// loaded using the 32-bit little endian value 0x00082028.
+	li		t0, 0x00082028
+	vsetivli	zero, 1, e32, m1, ta, ma
+	vmv.v.x		INDICES, t0
+	addi		STATEP_C, STATEP, 16
+	vsetivli	zero, 4, e64, m2, ta, ma
+	vluxei8.v	FEBA, (STATEP), INDICES
+	vluxei8.v	HGDC, (STATEP_C), INDICES
+
+.Lnext_block:
+	la		K, K512
+	addi		NUM_BLOCKS, NUM_BLOCKS, -1
+
+	// Save the previous state, as it's needed later.
+	vmv.v.v		PREV_FEBA, FEBA
+	vmv.v.v		PREV_HGDC, HGDC
+
+	// Load the next 1024-bit message block and endian-swap each 64-bit word
+	vle64.v		W0, (DATA)
+	vrev8.v		W0, W0
+	addi		DATA, DATA, 32
+	vle64.v		W1, (DATA)
+	vrev8.v		W1, W1
+	addi		DATA, DATA, 32
+	vle64.v		W2, (DATA)
+	vrev8.v		W2, W2
+	addi		DATA, DATA, 32
+	vle64.v		W3, (DATA)
+	vrev8.v		W3, W3
+	addi		DATA, DATA, 32
+
+	// Do the 80 rounds of SHA-512.
+	sha512_16rounds 0
+	sha512_16rounds 0
+	sha512_16rounds 0
+	sha512_16rounds 0
+	sha512_16rounds 1
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
+SYM_FUNC_END(sha512_transform_zvknhb_zvkb)
+
+.section ".rodata"
+.p2align 3
+.type K512, @object
+K512:
+	.dword		0x428a2f98d728ae22, 0x7137449123ef65cd
+	.dword		0xb5c0fbcfec4d3b2f, 0xe9b5dba58189dbbc
+	.dword		0x3956c25bf348b538, 0x59f111f1b605d019
+	.dword		0x923f82a4af194f9b, 0xab1c5ed5da6d8118
+	.dword		0xd807aa98a3030242, 0x12835b0145706fbe
+	.dword		0x243185be4ee4b28c, 0x550c7dc3d5ffb4e2
+	.dword		0x72be5d74f27b896f, 0x80deb1fe3b1696b1
+	.dword		0x9bdc06a725c71235, 0xc19bf174cf692694
+	.dword		0xe49b69c19ef14ad2, 0xefbe4786384f25e3
+	.dword		0x0fc19dc68b8cd5b5, 0x240ca1cc77ac9c65
+	.dword		0x2de92c6f592b0275, 0x4a7484aa6ea6e483
+	.dword		0x5cb0a9dcbd41fbd4, 0x76f988da831153b5
+	.dword		0x983e5152ee66dfab, 0xa831c66d2db43210
+	.dword		0xb00327c898fb213f, 0xbf597fc7beef0ee4
+	.dword		0xc6e00bf33da88fc2, 0xd5a79147930aa725
+	.dword		0x06ca6351e003826f, 0x142929670a0e6e70
+	.dword		0x27b70a8546d22ffc, 0x2e1b21385c26c926
+	.dword		0x4d2c6dfc5ac42aed, 0x53380d139d95b3df
+	.dword		0x650a73548baf63de, 0x766a0abb3c77b2a8
+	.dword		0x81c2c92e47edaee6, 0x92722c851482353b
+	.dword		0xa2bfe8a14cf10364, 0xa81a664bbc423001
+	.dword		0xc24b8b70d0f89791, 0xc76c51a30654be30
+	.dword		0xd192e819d6ef5218, 0xd69906245565a910
+	.dword		0xf40e35855771202a, 0x106aa07032bbd1b8
+	.dword		0x19a4c116b8d2d0c8, 0x1e376c085141ab53
+	.dword		0x2748774cdf8eeb99, 0x34b0bcb5e19b48a8
+	.dword		0x391c0cb3c5c95a63, 0x4ed8aa4ae3418acb
+	.dword		0x5b9cca4f7763e373, 0x682e6ff3d6b2b8a3
+	.dword		0x748f82ee5defb2fc, 0x78a5636f43172f60
+	.dword		0x84c87814a1f0ab72, 0x8cc702081a6439ec
+	.dword		0x90befffa23631e28, 0xa4506cebde82bde9
+	.dword		0xbef9a3f7b2c67915, 0xc67178f2e372532b
+	.dword		0xca273eceea26619c, 0xd186b8c721c0c207
+	.dword		0xeada7dd6cde0eb1e, 0xf57d4f7fee6ed178
+	.dword		0x06f067aa72176fba, 0x0a637dc5a2c898a6
+	.dword		0x113f9804bef90dae, 0x1b710b35131c471b
+	.dword		0x28db77f523047d84, 0x32caab7b40c72493
+	.dword		0x3c9ebe0a15c9bebc, 0x431d67c49c100d4c
+	.dword		0x4cc5d4becb3e42b6, 0x597f299cfc657e2a
+	.dword		0x5fcb6fab3ad6faec, 0x6c44198c4a475817
+.size K512, . - K512
-- 
2.43.0


