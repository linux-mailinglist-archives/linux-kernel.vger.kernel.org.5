Return-Path: <linux-kernel+bounces-14097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC28217D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A06DB2168D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBA4693;
	Tue,  2 Jan 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0gCyuAo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A02591;
	Tue,  2 Jan 2024 06:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0801CC433CB;
	Tue,  2 Jan 2024 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178231;
	bh=ZGtxgJUGwp5+BYvs6i7REFrmemh/CvgwkqXJpJBfeuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0gCyuAoB1ydjOWOtkLEJ/P8F9hrImk1EKFtFsQVVAQSYkzaDyJmfLj1ToQsWq64i
	 UNvuLzPd60yCKxNY1yVMkjwWri7rAPZQI6KzL0Z2Sr536Kxe6cSwYVPxWGrlSfz3+/
	 WiJe5S7u6mTsyGyfOyYS4IpwTVyMxkTCAR5yag+qkr/3SOPtob84VMZHltENj2VtLM
	 MxjjgL5B2BVUIF64oVQC01bILojxhRdHJqjNshtxnRoYT3i21y7ebBCGEcNikRcl/e
	 MnrsEyWTO6N3DRuLL58mUgYZSuibwogd7WX2xEMZJaaoTHkywl6uqAvk98MVlR4kdD
	 wFZ1GIF58ouAQ==
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
	Andy Chiu <andy.chiu@sifive.com>
Subject: [RFC PATCH 07/13] crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
Date: Tue,  2 Jan 2024 00:47:33 -0600
Message-ID: <20240102064743.220490-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
References: <20240102064743.220490-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jerry Shih <jerry.shih@sifive.com>

Add implementations of AES-ECB, AES-CBC, AES-CTR, and AES-XTS using the
RISC-V vector crypto extensions.  The assembly code is derived from
OpenSSL code (openssl/openssl#21923) that was dual-licensed so that it
could be reused in the kernel.  Nevertheless, the assembly has been
significantly reworked for integration with the kernel, for example by
using regular .S files instead of the so-called perlasm, using the
assembler instead of bare '.inst', greatly reducing code duplication,
supporting AES-192, and making the code use the same AES key structure
as the C code.

Co-developed-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Phoebe Chen <phoebe.chen@sifive.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                     |  20 +
 arch/riscv/crypto/Makefile                    |   3 +
 .../crypto/aes-riscv64-block-mode-glue.c      | 435 ++++++++++++++++++
 .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 300 ++++++++++++
 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 ++++++
 arch/riscv/crypto/aes-riscv64-zvkned.S        |  96 ++++
 6 files changed, 1000 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 2a7c365f2a86c..db8a5bcbea785 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -6,11 +6,31 @@ config CRYPTO_AES_RISCV64
 	tristate "Ciphers: AES"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 
 	  Architecture: riscv64 using:
 	  - Zvkned vector crypto extension
 
+config CRYPTO_AES_BLOCK_RISCV64
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_AES_RISCV64
+	select CRYPTO_SKCIPHER
+	help
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP 800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP 800-38A)
+	  - CTR (Counter) mode (NIST SP 800-38A)
+	  - XTS (XOR Encrypt XOR Tweakable Block Cipher with Ciphertext
+	    Stealing) mode (NIST SP 800-38E and IEEE 1619)
+
+	  Architecture: riscv64 using:
+	  - Zvkned vector crypto extension
+	  - Zvbb vector extension (XTS)
+	  - Zvkb vector crypto extension (CTR/XTS)
+	  - Zvkg vector crypto extension (XTS)
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index dca698c5cba3e..5dd91f34f0d52 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # linux/arch/riscv/crypto/Makefile
 #
 
 obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
 aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
+
+obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
+aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
diff --git a/arch/riscv/crypto/aes-riscv64-block-mode-glue.c b/arch/riscv/crypto/aes-riscv64-block-mode-glue.c
new file mode 100644
index 0000000000000..3250f6a0c1aae
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-block-mode-glue.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AES in ECB, CBC, CTR, and XTS modes using the RISC-V vector crypto extensions
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/aes.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/xts.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+
+#include "aes-riscv64-glue.h"
+
+struct riscv64_aes_xts_ctx {
+	struct crypto_aes_ctx ctx1;
+	struct crypto_aes_ctx ctx2;
+};
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
+static int riscv64_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			      unsigned int keylen)
+{
+	struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return __riscv64_aes_setkey(ctx, key, keylen);
+}
+
+static inline int riscv64_aes_ecb_crypt(struct skcipher_request *req, bool enc)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	/* If we have error here, the `nbytes` will be zero. */
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
+static int riscv64_aes_ctr_crypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int ctr32;
+	unsigned int nbytes;
+	unsigned int blocks;
+	unsigned int current_blocks;
+	unsigned int current_length;
+	int err;
+
+	/* the ctr iv uses big endian */
+	ctr32 = get_unaligned_be32(req->iv + 12);
+	err = skcipher_walk_virt(&walk, req, false);
+	while ((nbytes = walk.nbytes) != 0) {
+		if (nbytes != walk.total) {
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
+			blocks = nbytes / AES_BLOCK_SIZE;
+		} else {
+			/* This is the last walk. We should handle the tail data. */
+			blocks = DIV_ROUND_UP(nbytes, AES_BLOCK_SIZE);
+		}
+		ctr32 += blocks;
+
+		kernel_vector_begin();
+		/*
+		 * The `if` block below detects the overflow, which is then handled by
+		 * limiting the amount of blocks to the exact overflow point.
+		 */
+		if (ctr32 >= blocks) {
+			aes_ctr32_crypt_zvkned_zvkb(ctx, walk.src.virt.addr,
+						    walk.dst.virt.addr, nbytes,
+						    req->iv);
+		} else {
+			/* use 2 ctr32 function calls for overflow case */
+			current_blocks = blocks - ctr32;
+			current_length =
+				min(nbytes, current_blocks * AES_BLOCK_SIZE);
+			aes_ctr32_crypt_zvkned_zvkb(ctx, walk.src.virt.addr,
+						    walk.dst.virt.addr,
+						    current_length, req->iv);
+			crypto_inc(req->iv, 12);
+
+			if (ctr32) {
+				aes_ctr32_crypt_zvkned_zvkb(
+					ctx,
+					walk.src.virt.addr +
+						current_blocks * AES_BLOCK_SIZE,
+					walk.dst.virt.addr +
+						current_blocks * AES_BLOCK_SIZE,
+					nbytes - current_length, req->iv);
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
+static int riscv64_aes_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
+				  unsigned int keylen)
+{
+	struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int err;
+
+	err = xts_verify_key(tfm, key, keylen);
+	if (err)
+		return err;
+	err = __riscv64_aes_setkey(&ctx->ctx1, key, keylen / 2);
+	if (err)
+		return err;
+	return __riscv64_aes_setkey(&ctx->ctx2, key + keylen / 2, keylen / 2);
+}
+
+static int riscv64_aes_xts_crypt(struct skcipher_request *req, bool enc)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
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
+	__riscv64_aes_encrypt(&ctx->ctx2, req->iv, req->iv);
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
+		int xts_blocks = DIV_ROUND_UP(req->cryptlen,
+					      AES_BLOCK_SIZE) - 2;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(&subreq,
+					      skcipher_request_flags(req),
+					      NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst,
+					   xts_blocks * AES_BLOCK_SIZE,
+					   req->iv);
+		req = &subreq;
+		err = skcipher_walk_virt(&walk, req, false);
+	} else {
+		tail = 0;
+	}
+
+	while (walk.nbytes >= AES_BLOCK_SIZE) {
+		unsigned int nbytes = walk.nbytes;
+
+		if (walk.nbytes < walk.total)
+			nbytes &= ~(AES_BLOCK_SIZE - 1);
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
+	dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+	if (req->dst != req->src)
+		dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
+
+	skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
+				   req->iv);
+
+	err = skcipher_walk_virt(&walk, &subreq, false);
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
+static struct skcipher_alg riscv64_zvkned_aes_algs[] = {
+	{
+		.setkey = riscv64_aes_setkey,
+		.encrypt = riscv64_aes_ecb_encrypt,
+		.decrypt = riscv64_aes_ecb_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.walksize = AES_BLOCK_SIZE * 8,
+		.base = {
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct crypto_aes_ctx),
+			.cra_priority = 300,
+			.cra_name	= "ecb(aes)",
+			.cra_driver_name = "ecb-aes-riscv64-zvkned",
+			.cra_module = THIS_MODULE,
+		},
+	}, {
+		.setkey = riscv64_aes_setkey,
+		.encrypt = riscv64_aes_cbc_encrypt,
+		.decrypt = riscv64_aes_cbc_decrypt,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.walksize = AES_BLOCK_SIZE * 8,
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
+static struct skcipher_alg riscv64_zvkned_zvkb_aes_alg = {
+	.setkey = riscv64_aes_setkey,
+	.encrypt = riscv64_aes_ctr_crypt,
+	.decrypt = riscv64_aes_ctr_crypt,
+	.min_keysize = AES_MIN_KEY_SIZE,
+	.max_keysize = AES_MAX_KEY_SIZE,
+	.ivsize = AES_BLOCK_SIZE,
+	.chunksize = AES_BLOCK_SIZE,
+	.walksize = AES_BLOCK_SIZE * 8,
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
+static struct skcipher_alg riscv64_zvkned_zvbb_zvkg_aes_alg = {
+	.setkey = riscv64_aes_xts_setkey,
+	.encrypt = riscv64_aes_xts_encrypt,
+	.decrypt = riscv64_aes_xts_decrypt,
+	.min_keysize = AES_MIN_KEY_SIZE * 2,
+	.max_keysize = AES_MAX_KEY_SIZE * 2,
+	.ivsize = AES_BLOCK_SIZE,
+	.chunksize = AES_BLOCK_SIZE,
+	.walksize = AES_BLOCK_SIZE * 8,
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
+static int __init riscv64_aes_block_mod_init(void)
+{
+	int err = -ENODEV;
+
+	if (riscv_isa_extension_available(NULL, ZVKNED) &&
+	    riscv_vector_vlen() >= 128) {
+		err = crypto_register_skciphers(
+			riscv64_zvkned_aes_algs,
+			ARRAY_SIZE(riscv64_zvkned_aes_algs));
+		if (err)
+			return err;
+
+		if (riscv_isa_extension_available(NULL, ZVKB)) {
+			err = crypto_register_skcipher(
+				&riscv64_zvkned_zvkb_aes_alg);
+			if (err)
+				goto unregister_zvkned;
+		}
+
+		if (riscv_isa_extension_available(NULL, ZVBB) &&
+		    riscv_isa_extension_available(NULL, ZVKG) &&
+		    riscv_vector_vlen() < 2048 /* XTS impl limitation */) {
+			err = crypto_register_skcipher(
+				&riscv64_zvkned_zvbb_zvkg_aes_alg);
+			if (err)
+				goto unregister_zvkned_zvkb;
+		}
+	}
+
+	return err;
+
+unregister_zvkned_zvkb:
+	if (riscv_isa_extension_available(NULL, ZVKB))
+		crypto_unregister_skcipher(&riscv64_zvkned_zvkb_aes_alg);
+unregister_zvkned:
+	crypto_unregister_skciphers(riscv64_zvkned_aes_algs,
+				    ARRAY_SIZE(riscv64_zvkned_aes_algs));
+	return err;
+}
+
+static void __exit riscv64_aes_block_mod_fini(void)
+{
+	crypto_unregister_skcipher(&riscv64_zvkned_zvbb_zvkg_aes_alg);
+	crypto_unregister_skcipher(&riscv64_zvkned_zvkb_aes_alg);
+	crypto_unregister_skciphers(riscv64_zvkned_aes_algs,
+				    ARRAY_SIZE(riscv64_zvkned_aes_algs));
+}
+
+module_init(riscv64_aes_block_mod_init);
+module_exit(riscv64_aes_block_mod_fini);
+
+MODULE_DESCRIPTION("AES-ECB/CBC/CTR/XTS (RISC-V accelerated)");
+MODULE_AUTHOR("Jerry Shih <jerry.shih@sifive.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("ecb(aes)");
+MODULE_ALIAS_CRYPTO("cbc(aes)");
+MODULE_ALIAS_CRYPTO("ctr(aes)");
+MODULE_ALIAS_CRYPTO("xts(aes)");
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S b/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
new file mode 100644
index 0000000000000..41eb618e8a5d9
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
@@ -0,0 +1,300 @@
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
+	vsetvli		VL, LEN32, e32, m4, ta, ma
+	j		2f
+1:
+	vsetvli		VL, LEN32, e32, m4, ta, ma
+	// Compute the next sequence of tweaks by multiplying the previous
+	// sequence by x^N.  Store the result in both bit-reversed order and
+	// regular order (i.e. with the bit reversal undone).
+	vgmul.vv	TWEAKS_BREV, MULTS_BREV
+	vbrev8.v	TWEAKS, TWEAKS_BREV
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
+	// Repeat if more blocks remain.
+	bnez		LEN32, 1b
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
+	aes_begin	KEYP, 111f, 222f
+	__aes_xts_crypt	\enc, 256
+111:
+	__aes_xts_crypt	\enc, 128
+222:
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
index 0000000000000..4a48f2f72c927
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
+	// LEN32 = number of blocks, rounded up, in e32's
+	addi		t0, LEN, 15
+	srli		t0, t0, 4
+	slli		LEN32, t0, 2
+
+	// Create a mask that selects the last 32-bit word of each 128-bit
+	// block.  This is the word that contains the (big-endian) counter.
+	li		t0, 0b10001000
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
+	// the length in 32-bit elements, i.e. 4 times the number of blocks.
+	vsetvli		VL_E32, LEN32, e32, m4, ta, mu
+
+	// Increment the counters by the number of blocks processed in the
+	// previous iteration.
+	vadd.vx		v16, v16, VL_BLOCKS, v0.t
+2:
+	// Prepare the AES inputs into v24.
+	vmv.v.v		v24, v16
+	vrev8.v		v24, v24, v0.t	// Convert back to big-endian.
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
+	vrev8.v		v16, v16, v0.t	// Convert back to big-endian.
+	vse32.v		v16, (IVP)
+
+	ret
+.endm
+
+// void aes_ctr32_crypt_zvkned_zvkb(const struct crypto_aes_ctx *key,
+//				    const u8 *in, u8 *out, size_t len,
+//				    u8 iv[AES_BLOCK_SIZE]);
+SYM_FUNC_START(aes_ctr32_crypt_zvkned_zvkb)
+	aes_begin	KEYP, 111f, 222f
+	aes_ctr32_crypt	256
+111:
+	aes_ctr32_crypt	128
+222:
+	aes_ctr32_crypt	192
+SYM_FUNC_END(aes_ctr32_crypt_zvkned_zvkb)
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.S b/arch/riscv/crypto/aes-riscv64-zvkned.S
index 3346978b89d6a..6f7e8b0f31423 100644
--- a/arch/riscv/crypto/aes-riscv64-zvkned.S
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.S
@@ -75,10 +75,106 @@
 // void aes_encrypt_zvkned(const struct crypto_aes_ctx *key,
 //			   const u8 in[16], u8 out[16]);
 SYM_FUNC_START(aes_encrypt_zvkned)
 	aes_crypt_zvkned	1
 SYM_FUNC_END(aes_encrypt_zvkned)
 
 // Same prototype and calling convention as the encryption function
 SYM_FUNC_START(aes_decrypt_zvkned)
 	aes_crypt_zvkned	0
 SYM_FUNC_END(aes_decrypt_zvkned)
+
+.macro	__aes_ecb_crypt	enc, keylen
+	srli		t0, LEN, 2
+	// t0 is the remaining length in 32-bit words.  It's a multiple of 4.
+1:
+	vsetvli		t1, t0, e32, m4, ta, ma
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
+	aes_begin	KEYP, 111f, 222f
+	__aes_ecb_crypt	\enc, 256
+111:
+	__aes_ecb_crypt	\enc, 128
+222:
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
+	aes_begin	KEYP, 111f, 222f
+	aes_cbc_encrypt	256
+111:
+	aes_cbc_encrypt	128
+222:
+	aes_cbc_encrypt	192
+SYM_FUNC_END(aes_cbc_encrypt_zvkned)
+
+// Same prototype and calling convention as the encryption function
+SYM_FUNC_START(aes_cbc_decrypt_zvkned)
+	aes_begin	KEYP, 111f, 222f
+	aes_cbc_decrypt	256
+111:
+	aes_cbc_decrypt	128
+222:
+	aes_cbc_decrypt	192
+SYM_FUNC_END(aes_cbc_decrypt_zvkned)
-- 
2.43.0


