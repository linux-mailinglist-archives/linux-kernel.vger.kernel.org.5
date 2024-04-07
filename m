Return-Path: <linux-kernel+bounces-134645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35589B413
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F99B210BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6F244C7C;
	Sun,  7 Apr 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB10MqaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042D3BB47;
	Sun,  7 Apr 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525101; cv=none; b=eLd/cDhXV0/GT8ZQxCA5++GccBVERJWgaAE3wrLFCcViyGEOA1CuJFaS5wAZ/5/3i400QN/36CwaQi0LKhoVshEy/2RicIyOY6HodjepF/Ol2o9yOAp5p8W6/q7OtbyPzXheBfR18u6zD27mnjKbbX5G36EqKV/Geq8h81Lmn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525101; c=relaxed/simple;
	bh=wYK2fwvqFdEzdzYPqYz+I5DdPXYhrAq1dBgmwfFCr/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smuSdDuBkdcESDgtc9YlmgE7BYq/HBDhFWaixHdfndk0DMeAlI8DHKJWQvVBPQdFvOGcvaL9FU5oMT1rBXxJEypEVrPpugUSVyy4MwH2j7zsPdnDG4lXYYZcnhHaVNAEw/sUUE+NGvZrfGBgEIQUdOwXw5dgAcf8N5kATHWQmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB10MqaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E862C433F1;
	Sun,  7 Apr 2024 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712525100;
	bh=wYK2fwvqFdEzdzYPqYz+I5DdPXYhrAq1dBgmwfFCr/c=;
	h=From:To:Cc:Subject:Date:From;
	b=NB10MqaBlj+UgxCDB+pimbQMPdUrvBLNC1aFamZWquygF4fgicVZpSA9cbf1tbwY/
	 b0lWuTVcjfiLlfXX/Q1q8fZpwhvBICDuKjgqw238o4FIPrdwXGMok57HMlgBCp2KDT
	 A8ScbvYBtjaPBczWfOIX0lZZkY4q5yhH1Zwjg519/ZQpPfwJnSnveKvexBpSGVMM+7
	 K8soD5sHgZO2tk6Aermtd5SGOIzWWWm1UCFhwVNzTY99hqEA0qTdRNyNTrgdSh7jWq
	 QgikGksEUwiB9Kciabq1qihfAc7V/UYPUbmn9SuOTNB1Cdmwy/hbKaN8EetbvlZNvN
	 k3gRHKjpP/SGQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH] crypto: x86/aes-xts - make non-AVX implementation use new glue code
Date: Sun,  7 Apr 2024 17:22:31 -0400
Message-ID: <20240407212231.41781-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Make the non-AVX implementation of AES-XTS (xts-aes-aesni) use the new
glue code that was introduced for the AVX implementations of AES-XTS.
This reduces code size, and it improves the performance of xts-aes-aesni
due to the optimization for messages that don't span page boundaries.

This required moving the new glue functions higher up in the file and
allowing the IV encryption function to be specified by the caller.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S |   2 +-
 arch/x86/crypto/aesni-intel_asm.S    |  16 +-
 arch/x86/crypto/aesni-intel_glue.c   | 317 +++++++++++----------------
 3 files changed, 132 insertions(+), 203 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index b8005d0205f8..fcaf64a2f8c6 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -749,11 +749,11 @@
 	jmp		.Ldone\@
 .endm
 
 // void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 //			   u8 iv[AES_BLOCK_SIZE]);
-SYM_FUNC_START(aes_xts_encrypt_iv)
+SYM_TYPED_FUNC_START(aes_xts_encrypt_iv)
 	vmovdqu		(%rsi), %xmm0
 	vpxor		0*16(%rdi), %xmm0, %xmm0
 	vaesenc		1*16(%rdi), %xmm0, %xmm0
 	vaesenc		2*16(%rdi), %xmm0, %xmm0
 	vaesenc		3*16(%rdi), %xmm0, %xmm0
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 7ecb55cae3d6..1cb55eea2efa 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2841,14 +2841,14 @@ SYM_FUNC_END(aesni_ctr_enc)
 	psrad $31, KEY; \
 	pand GF128MUL_MASK, KEY; \
 	pxor KEY, IV;
 
 /*
- * void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			  const u8 *src, unsigned int len, le128 *iv)
+ * void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *		      const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_encrypt)
+SYM_FUNC_START(aesni_xts_enc)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
 	pushl LEN
 	pushl KEYP
@@ -2993,17 +2993,17 @@ SYM_FUNC_START(aesni_xts_encrypt)
 	call _aesni_enc1
 	pxor IV, STATE
 
 	movups STATE, (OUTP)
 	jmp .Lxts_enc_ret
-SYM_FUNC_END(aesni_xts_encrypt)
+SYM_FUNC_END(aesni_xts_enc)
 
 /*
- * void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst,
- *			  const u8 *src, unsigned int len, le128 *iv)
+ * void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *dst,
+ *		      const u8 *src, unsigned int len, le128 *iv)
  */
-SYM_FUNC_START(aesni_xts_decrypt)
+SYM_FUNC_START(aesni_xts_dec)
 	FRAME_BEGIN
 #ifndef __x86_64__
 	pushl IVP
 	pushl LEN
 	pushl KEYP
@@ -3155,6 +3155,6 @@ SYM_FUNC_START(aesni_xts_decrypt)
 	call _aesni_dec1
 	pxor STATE4, STATE
 
 	movups STATE, (OUTP)
 	jmp .Lxts_dec_ret
-SYM_FUNC_END(aesni_xts_decrypt)
+SYM_FUNC_END(aesni_xts_dec)
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 0b37a470325b..e7d21000cb05 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -105,15 +105,15 @@ asmlinkage void aesni_cts_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
 				  const u8 *in, unsigned int len, u8 *iv);
 
 #define AVX_GEN2_OPTSIZE 640
 #define AVX_GEN4_OPTSIZE 4096
 
-asmlinkage void aesni_xts_encrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				  const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void aesni_xts_enc(const struct crypto_aes_ctx *ctx, u8 *out,
+			      const u8 *in, unsigned int len, u8 *iv);
 
-asmlinkage void aesni_xts_decrypt(const struct crypto_aes_ctx *ctx, u8 *out,
-				  const u8 *in, unsigned int len, u8 *iv);
+asmlinkage void aesni_xts_dec(const struct crypto_aes_ctx *ctx, u8 *out,
+			      const u8 *in, unsigned int len, u8 *iv);
 
 #ifdef CONFIG_X86_64
 
 asmlinkage void aesni_ctr_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
@@ -873,11 +873,11 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 	return gcmaes_decrypt(req, req->assoclen - 8, ctx->hash_subkey, iv,
 			      aes_ctx);
 }
 #endif
 
-static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
+static int xts_setkey_aesni(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
 	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int err;
 
@@ -894,112 +894,156 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 
 	/* second half of xts-key is for tweak */
 	return aes_set_key_common(&ctx->tweak_ctx, key + keylen, keylen);
 }
 
-static int xts_crypt(struct skcipher_request *req, bool encrypt)
+typedef void (*xts_encrypt_iv_func)(const struct crypto_aes_ctx *tweak_key,
+				    u8 iv[AES_BLOCK_SIZE]);
+typedef void (*xts_crypt_func)(const struct crypto_aes_ctx *key,
+			       const u8 *src, u8 *dst, size_t len,
+			       u8 tweak[AES_BLOCK_SIZE]);
+
+/* This handles cases where the source and/or destination span pages. */
+static noinline int
+xts_crypt_slowpath(struct skcipher_request *req, xts_crypt_func crypt_func)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
+	const struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int tail = req->cryptlen % AES_BLOCK_SIZE;
+	struct scatterlist sg_src[2], sg_dst[2];
 	struct skcipher_request subreq;
 	struct skcipher_walk walk;
+	struct scatterlist *src, *dst;
 	int err;
 
-	if (req->cryptlen < AES_BLOCK_SIZE)
-		return -EINVAL;
-
-	err = skcipher_walk_virt(&walk, req, false);
-	if (!walk.nbytes)
-		return err;
-
-	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
-		int blocks = DIV_ROUND_UP(req->cryptlen, AES_BLOCK_SIZE) - 2;
-
-		skcipher_walk_abort(&walk);
-
+	/*
+	 * If the message length isn't divisible by the AES block size, then
+	 * separate off the last full block and the partial block.  This ensures
+	 * that they are processed in the same call to the assembly function,
+	 * which is required for ciphertext stealing.
+	 */
+	if (tail) {
 		skcipher_request_set_tfm(&subreq, tfm);
 		skcipher_request_set_callback(&subreq,
 					      skcipher_request_flags(req),
 					      NULL, NULL);
 		skcipher_request_set_crypt(&subreq, req->src, req->dst,
-					   blocks * AES_BLOCK_SIZE, req->iv);
+					   req->cryptlen - tail - AES_BLOCK_SIZE,
+					   req->iv);
 		req = &subreq;
-
-		err = skcipher_walk_virt(&walk, req, false);
-		if (!walk.nbytes)
-			return err;
-	} else {
-		tail = 0;
 	}
 
-	kernel_fpu_begin();
-
-	/* calculate first value of T */
-	aesni_enc(&ctx->tweak_ctx, walk.iv, walk.iv);
+	err = skcipher_walk_virt(&walk, req, false);
 
-	while (walk.nbytes > 0) {
-		int nbytes = walk.nbytes;
+	while (walk.nbytes) {
+		unsigned int nbytes = walk.nbytes;
 
 		if (nbytes < walk.total)
-			nbytes &= ~(AES_BLOCK_SIZE - 1);
-
-		if (encrypt)
-			aesni_xts_encrypt(&ctx->crypt_ctx,
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  nbytes, walk.iv);
-		else
-			aesni_xts_decrypt(&ctx->crypt_ctx,
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  nbytes, walk.iv);
-		kernel_fpu_end();
+			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
 
+		kernel_fpu_begin();
+		(*crypt_func)(&ctx->crypt_ctx, walk.src.virt.addr,
+			      walk.dst.virt.addr, nbytes, req->iv);
+		kernel_fpu_end();
 		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-
-		if (walk.nbytes > 0)
-			kernel_fpu_begin();
 	}
 
-	if (unlikely(tail > 0 && !err)) {
-		struct scatterlist sg_src[2], sg_dst[2];
-		struct scatterlist *src, *dst;
+	if (err || !tail)
+		return err;
 
-		dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
-		if (req->dst != req->src)
-			dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
+	/* Do ciphertext stealing with the last full block and partial block. */
 
-		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
-					   req->iv);
+	dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
+	if (req->dst != req->src)
+		dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
 
-		err = skcipher_walk_virt(&walk, &subreq, false);
-		if (err)
-			return err;
+	skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
+				   req->iv);
 
-		kernel_fpu_begin();
-		if (encrypt)
-			aesni_xts_encrypt(&ctx->crypt_ctx,
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  walk.nbytes, walk.iv);
-		else
-			aesni_xts_decrypt(&ctx->crypt_ctx,
-					  walk.dst.virt.addr, walk.src.virt.addr,
-					  walk.nbytes, walk.iv);
-		kernel_fpu_end();
+	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
 
-		err = skcipher_walk_done(&walk, 0);
+	kernel_fpu_begin();
+	(*crypt_func)(&ctx->crypt_ctx, walk.src.virt.addr, walk.dst.virt.addr,
+		      walk.nbytes, req->iv);
+	kernel_fpu_end();
+
+	return skcipher_walk_done(&walk, 0);
+}
+
+/* __always_inline to avoid indirect call in fastpath */
+static __always_inline int
+xts_crypt(struct skcipher_request *req, xts_encrypt_iv_func encrypt_iv,
+	  xts_crypt_func crypt_func)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	const struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
+	const unsigned int cryptlen = req->cryptlen;
+	struct scatterlist *src = req->src;
+	struct scatterlist *dst = req->dst;
+
+	if (unlikely(cryptlen < AES_BLOCK_SIZE))
+		return -EINVAL;
+
+	kernel_fpu_begin();
+	(*encrypt_iv)(&ctx->tweak_ctx, req->iv);
+
+	/*
+	 * In practice, virtually all XTS plaintexts and ciphertexts are either
+	 * 512 or 4096 bytes, aligned such that they don't span page boundaries.
+	 * To optimize the performance of these cases, and also any other case
+	 * where no page boundary is spanned, the below fast-path handles
+	 * single-page sources and destinations as efficiently as possible.
+	 */
+	if (likely(src->length >= cryptlen && dst->length >= cryptlen &&
+		   src->offset + cryptlen <= PAGE_SIZE &&
+		   dst->offset + cryptlen <= PAGE_SIZE)) {
+		struct page *src_page = sg_page(src);
+		struct page *dst_page = sg_page(dst);
+		void *src_virt = kmap_local_page(src_page) + src->offset;
+		void *dst_virt = kmap_local_page(dst_page) + dst->offset;
+
+		(*crypt_func)(&ctx->crypt_ctx, src_virt, dst_virt, cryptlen,
+			      req->iv);
+		kunmap_local(dst_virt);
+		kunmap_local(src_virt);
+		kernel_fpu_end();
+		return 0;
 	}
-	return err;
+	kernel_fpu_end();
+	return xts_crypt_slowpath(req, crypt_func);
+}
+
+static void aesni_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
+				 u8 iv[AES_BLOCK_SIZE])
+{
+	aesni_enc(tweak_key, iv, iv);
+}
+
+static void aesni_xts_encrypt(const struct crypto_aes_ctx *key,
+			      const u8 *src, u8 *dst, size_t len,
+			      u8 tweak[AES_BLOCK_SIZE])
+{
+	aesni_xts_enc(key, dst, src, len, tweak);
 }
 
-static int xts_encrypt(struct skcipher_request *req)
+static void aesni_xts_decrypt(const struct crypto_aes_ctx *key,
+			      const u8 *src, u8 *dst, size_t len,
+			      u8 tweak[AES_BLOCK_SIZE])
 {
-	return xts_crypt(req, true);
+	aesni_xts_dec(key, dst, src, len, tweak);
 }
 
-static int xts_decrypt(struct skcipher_request *req)
+static int xts_encrypt_aesni(struct skcipher_request *req)
 {
-	return xts_crypt(req, false);
+	return xts_crypt(req, aesni_xts_encrypt_iv, aesni_xts_encrypt);
+}
+
+static int xts_decrypt_aesni(struct skcipher_request *req)
+{
+	return xts_crypt(req, aesni_xts_encrypt_iv, aesni_xts_decrypt);
 }
 
 static struct crypto_alg aesni_cipher_alg = {
 	.cra_name		= "aes",
 	.cra_driver_name	= "aes-aesni",
@@ -1099,13 +1143,13 @@ static struct skcipher_alg aesni_skciphers[] = {
 		},
 		.min_keysize	= 2 * AES_MIN_KEY_SIZE,
 		.max_keysize	= 2 * AES_MAX_KEY_SIZE,
 		.ivsize		= AES_BLOCK_SIZE,
 		.walksize	= 2 * AES_BLOCK_SIZE,
-		.setkey		= xts_aesni_setkey,
-		.encrypt	= xts_encrypt,
-		.decrypt	= xts_decrypt,
+		.setkey		= xts_setkey_aesni,
+		.encrypt	= xts_encrypt_aesni,
+		.decrypt	= xts_decrypt_aesni,
 	}
 };
 
 static
 struct simd_skcipher_alg *aesni_simd_skciphers[ARRAY_SIZE(aesni_skciphers)];
@@ -1137,125 +1181,10 @@ static struct skcipher_alg aesni_xctr = {
 static struct simd_skcipher_alg *aesni_simd_xctr;
 
 asmlinkage void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 				   u8 iv[AES_BLOCK_SIZE]);
 
-typedef void (*xts_asm_func)(const struct crypto_aes_ctx *key,
-			     const u8 *src, u8 *dst, size_t len,
-			     u8 tweak[AES_BLOCK_SIZE]);
-
-/* This handles cases where the source and/or destination span pages. */
-static noinline int
-xts_crypt_slowpath(struct skcipher_request *req, xts_asm_func asm_func)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	const struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
-	int tail = req->cryptlen % AES_BLOCK_SIZE;
-	struct scatterlist sg_src[2], sg_dst[2];
-	struct skcipher_request subreq;
-	struct skcipher_walk walk;
-	struct scatterlist *src, *dst;
-	int err;
-
-	/*
-	 * If the message length isn't divisible by the AES block size, then
-	 * separate off the last full block and the partial block.  This ensures
-	 * that they are processed in the same call to the assembly function,
-	 * which is required for ciphertext stealing.
-	 */
-	if (tail) {
-		skcipher_request_set_tfm(&subreq, tfm);
-		skcipher_request_set_callback(&subreq,
-					      skcipher_request_flags(req),
-					      NULL, NULL);
-		skcipher_request_set_crypt(&subreq, req->src, req->dst,
-					   req->cryptlen - tail - AES_BLOCK_SIZE,
-					   req->iv);
-		req = &subreq;
-	}
-
-	err = skcipher_walk_virt(&walk, req, false);
-
-	while (walk.nbytes) {
-		unsigned int nbytes = walk.nbytes;
-
-		if (nbytes < walk.total)
-			nbytes = round_down(nbytes, AES_BLOCK_SIZE);
-
-		kernel_fpu_begin();
-		(*asm_func)(&ctx->crypt_ctx, walk.src.virt.addr,
-			    walk.dst.virt.addr, nbytes, req->iv);
-		kernel_fpu_end();
-		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
-	}
-
-	if (err || !tail)
-		return err;
-
-	/* Do ciphertext stealing with the last full block and partial block. */
-
-	dst = src = scatterwalk_ffwd(sg_src, req->src, req->cryptlen);
-	if (req->dst != req->src)
-		dst = scatterwalk_ffwd(sg_dst, req->dst, req->cryptlen);
-
-	skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
-				   req->iv);
-
-	err = skcipher_walk_virt(&walk, req, false);
-	if (err)
-		return err;
-
-	kernel_fpu_begin();
-	(*asm_func)(&ctx->crypt_ctx, walk.src.virt.addr, walk.dst.virt.addr,
-		    walk.nbytes, req->iv);
-	kernel_fpu_end();
-
-	return skcipher_walk_done(&walk, 0);
-}
-
-/* __always_inline to avoid indirect call in fastpath */
-static __always_inline int
-xts_crypt2(struct skcipher_request *req, xts_asm_func asm_func)
-{
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	const struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
-	const unsigned int cryptlen = req->cryptlen;
-	struct scatterlist *src = req->src;
-	struct scatterlist *dst = req->dst;
-
-	if (unlikely(cryptlen < AES_BLOCK_SIZE))
-		return -EINVAL;
-
-	kernel_fpu_begin();
-	aes_xts_encrypt_iv(&ctx->tweak_ctx, req->iv);
-
-	/*
-	 * In practice, virtually all XTS plaintexts and ciphertexts are either
-	 * 512 or 4096 bytes, aligned such that they don't span page boundaries.
-	 * To optimize the performance of these cases, and also any other case
-	 * where no page boundary is spanned, the below fast-path handles
-	 * single-page sources and destinations as efficiently as possible.
-	 */
-	if (likely(src->length >= cryptlen && dst->length >= cryptlen &&
-		   src->offset + cryptlen <= PAGE_SIZE &&
-		   dst->offset + cryptlen <= PAGE_SIZE)) {
-		struct page *src_page = sg_page(src);
-		struct page *dst_page = sg_page(dst);
-		void *src_virt = kmap_local_page(src_page) + src->offset;
-		void *dst_virt = kmap_local_page(dst_page) + dst->offset;
-
-		(*asm_func)(&ctx->crypt_ctx, src_virt, dst_virt, cryptlen,
-			    req->iv);
-		kunmap_local(dst_virt);
-		kunmap_local(src_virt);
-		kernel_fpu_end();
-		return 0;
-	}
-	kernel_fpu_end();
-	return xts_crypt_slowpath(req, asm_func);
-}
-
 #define DEFINE_XTS_ALG(suffix, driver_name, priority)			       \
 									       \
 asmlinkage void aes_xts_encrypt_##suffix(const struct crypto_aes_ctx *key,     \
 					 const u8 *src, u8 *dst, size_t len,   \
 					 u8 tweak[AES_BLOCK_SIZE]);	       \
@@ -1263,16 +1192,16 @@ asmlinkage void aes_xts_decrypt_##suffix(const struct crypto_aes_ctx *key,     \
 					 const u8 *src, u8 *dst, size_t len,   \
 					 u8 tweak[AES_BLOCK_SIZE]);	       \
 									       \
 static int xts_encrypt_##suffix(struct skcipher_request *req)		       \
 {									       \
-	return xts_crypt2(req, aes_xts_encrypt_##suffix);		       \
+	return xts_crypt(req, aes_xts_encrypt_iv, aes_xts_encrypt_##suffix);   \
 }									       \
 									       \
 static int xts_decrypt_##suffix(struct skcipher_request *req)		       \
 {									       \
-	return xts_crypt2(req, aes_xts_decrypt_##suffix);		       \
+	return xts_crypt(req, aes_xts_encrypt_iv, aes_xts_decrypt_##suffix);   \
 }									       \
 									       \
 static struct skcipher_alg aes_xts_alg_##suffix = {			       \
 	.base = {							       \
 		.cra_name		= "__xts(aes)",			       \
@@ -1285,11 +1214,11 @@ static struct skcipher_alg aes_xts_alg_##suffix = {			       \
 	},								       \
 	.min_keysize	= 2 * AES_MIN_KEY_SIZE,				       \
 	.max_keysize	= 2 * AES_MAX_KEY_SIZE,				       \
 	.ivsize		= AES_BLOCK_SIZE,				       \
 	.walksize	= 2 * AES_BLOCK_SIZE,				       \
-	.setkey		= xts_aesni_setkey,				       \
+	.setkey		= xts_setkey_aesni,				       \
 	.encrypt	= xts_encrypt_##suffix,				       \
 	.decrypt	= xts_decrypt_##suffix,				       \
 };									       \
 									       \
 static struct simd_skcipher_alg *aes_xts_simdalg_##suffix

base-commit: 4ad27a8be9dbefd4820da0f60da879d512b2f659
-- 
2.44.0


