Return-Path: <linux-kernel+bounces-143537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875818A3AA2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87831C22807
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0381BF33;
	Sat, 13 Apr 2024 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fovUMSMb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C918E20;
	Sat, 13 Apr 2024 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978479; cv=none; b=WuPur8dGskylmcEFooXw/91Mkkq9r6YAP5jGkvsmOZM34ohRhd+MyKmQ1W7TddNv9m6zKkS6uOVRH4WgTvnOu/pxcVHs5l5lscIKiJNpDyolEh3nvt39wNiMN9aFcEPfaesDelDBzgo9IID6cW28+iJfqEmXPEcHLy8VDMjCO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978479; c=relaxed/simple;
	bh=2YTRDnluqLJ6SJdgJANZogX29mh3u1GYlUugT+10bXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoJFGuKIbZeOiZ70J8WvsdTymLmDKE4Mqeng0hbuoJJUSEp1j1eX3KpcrwNW8hAuHcUOMRiDREVwOk02PW0hjuhNsssxdo2ogx6afwiOSdswYCrCC3oWUfeVZuWGsURJKgUflqxadBqvBgvxCv4WglDMAzvB2tR7OPYpiRXsZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fovUMSMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA154C32786;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712978479;
	bh=2YTRDnluqLJ6SJdgJANZogX29mh3u1GYlUugT+10bXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fovUMSMbcEH12dA5gIr1A9+/nXgWv4IJIaJnfHlOdeBx4O+/V0Bqx/cpWtNdhi+hU
	 Fw+D6Wp2jPzrzTDl9cHuUwqA5NzWWE80llTGZNzCytOwiW72Dd1tkE2n3GZ1NT5WHP
	 YG4eGFv5G2inueQckcG2s5ps4eP79RKUCi8w0kSXhg6b1csy/c9TUbuPPJVHa2X2ol
	 tuLwy9k5ya61L2olLtsJFYJLrSzrLZJucBOyJWzXzKy+OSfrhvmcjdqAMkgKzoYJ8D
	 VsKLF6bxupnNWNFoCFlyUm5PNfE/0ICRidQW74FFvtdRy4fG2R9OrCu7dbUvXiaQ2/
	 Gb7xevDo83nZg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 3/3] crypto: x86/aes-xts - optimize size of instructions operating on lengths
Date: Fri, 12 Apr 2024 20:17:28 -0700
Message-ID: <20240413031728.159495-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413031728.159495-1-ebiggers@kernel.org>
References: <20240413031728.159495-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

x86_64 has the "interesting" property that the instruction size is
generally a bit shorter for instructions that operate on the 32-bit (or
less) part of registers, or registers that are in the original set of 8.

This patch adjusts the AES-XTS code to take advantage of that property
by changing the LEN parameter from size_t to unsigned int (which is all
that's needed and is what the non-AVX implementation uses) and using the
%eax register for KEYLEN.

This decreases the size of aes-xts-avx-x86_64.o by 1.2%.

Note that changing the kmovq to kmovd was going to be needed anyway to
make the AVX10/256 code really work on CPUs that don't support 512-bit
vectors (since the AVX10 spec says that 64-bit opmask instructions will
only be supported on processors that support 512-bit vectors).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 40 +++++++++++++++-------------
 arch/x86/crypto/aesni-intel_glue.c   | 18 ++++++-------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 802d3b90d337..48f97b79f7a9 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -83,18 +83,20 @@
 // Function parameters
 .set	KEY,		%rdi	// Initially points to crypto_aes_ctx, then is
 				// advanced to point to 7th-from-last round key
 .set	SRC,		%rsi	// Pointer to next source data
 .set	DST,		%rdx	// Pointer to next destination data
-.set	LEN,		%rcx	// Remaining length in bytes
+.set	LEN,		%ecx	// Remaining length in bytes
+.set	LEN8,		%cl
+.set	LEN64,		%rcx
 .set	TWEAK,		%r8	// Pointer to next tweak
 
-// %r9 holds the AES key length in bytes.
-.set	KEYLEN,		%r9d
-.set	KEYLEN64,	%r9
+// %rax holds the AES key length in bytes.
+.set	KEYLEN,		%eax
+.set	KEYLEN64,	%rax
 
-// %rax and %r10-r11 are available as temporaries.
+// %r9-r11 are available as temporaries.
 
 .macro	_define_Vi	i
 .if VL == 16
 	.set	V\i,		%xmm\i
 .elseif VL == 32
@@ -563,13 +565,13 @@
 	// When decrypting a message whose length isn't a multiple of the AES
 	// block length, exclude the last full block from the main loop by
 	// subtracting 16 from LEN.  This is needed because ciphertext stealing
 	// decryption uses the last two tweaks in reverse order.  We'll handle
 	// the last full block and the partial block specially at the end.
-	lea		-16(LEN), %rax
-	test		$15, LEN
-	cmovnz		%rax, LEN
+	lea		-16(LEN), %eax
+	test		$15, LEN8
+	cmovnz		%eax, LEN
 .endif
 
 	// Load the AES key length: 16 (AES-128), 24 (AES-192), or 32 (AES-256).
 	movl		480(KEY), KEYLEN
 
@@ -648,11 +650,11 @@
 	jge		.Lmain_loop\@
 
 	// Check for the uncommon case where the data length isn't a multiple of
 	// 4*VL.  Handle it out-of-line in order to optimize for the common
 	// case.  In the common case, just fall through to the ret.
-	test		$4*VL-1, LEN
+	test		$4*VL-1, LEN8
 	jnz		.Lhandle_remainder\@
 .Ldone\@:
 	// Store the next tweak back to *TWEAK to support continuation calls.
 	vmovdqu		TWEAK0_XMM, (TWEAK)
 .if VL > 16
@@ -716,39 +718,39 @@
 	_aes_crypt	\enc, _XMM, TWEAK1_XMM, %xmm0
 .endif
 
 .if USE_AVX10
 	// Create a mask that has the first LEN bits set.
-	mov		$-1, %rax
-	bzhi		LEN, %rax, %rax
-	kmovq		%rax, %k1
+	mov		$-1, %r9d
+	bzhi		LEN, %r9d, %r9d
+	kmovd		%r9d, %k1
 
 	// Swap the first LEN bytes of the en/decryption of the last full block
 	// with the partial block.  Note that to support in-place en/decryption,
 	// the load from the src partial block must happen before the store to
 	// the dst partial block.
 	vmovdqa		%xmm0, %xmm1
 	vmovdqu8	16(SRC), %xmm0{%k1}
 	vmovdqu8	%xmm1, 16(DST){%k1}
 .else
-	lea		.Lcts_permute_table(%rip), %rax
+	lea		.Lcts_permute_table(%rip), %r9
 
 	// Load the src partial block, left-aligned.  Note that to support
 	// in-place en/decryption, this must happen before the store to the dst
 	// partial block.
-	vmovdqu		(SRC, LEN, 1), %xmm1
+	vmovdqu		(SRC, LEN64, 1), %xmm1
 
 	// Shift the first LEN bytes of the en/decryption of the last full block
 	// to the end of a register, then store it to DST+LEN.  This stores the
 	// dst partial block.  It also writes to the second part of the dst last
 	// full block, but that part is overwritten later.
-	vpshufb		(%rax, LEN, 1), %xmm0, %xmm2
-	vmovdqu		%xmm2, (DST, LEN, 1)
+	vpshufb		(%r9, LEN64, 1), %xmm0, %xmm2
+	vmovdqu		%xmm2, (DST, LEN64, 1)
 
 	// Make xmm3 contain [16-LEN,16-LEN+1,...,14,15,0x80,0x80,...].
-	sub		LEN, %rax
-	vmovdqu		32(%rax), %xmm3
+	sub		LEN64, %r9
+	vmovdqu		32(%r9), %xmm3
 
 	// Shift the src partial block to the beginning of its register.
 	vpshufb		%xmm3, %xmm1, %xmm1
 
 	// Do a blend to generate the src partial block followed by the second
@@ -793,11 +795,11 @@ SYM_FUNC_END(aes_xts_encrypt_iv)
 
 // Below are the actual AES-XTS encryption and decryption functions,
 // instantiated from the above macro.  They all have the following prototype:
 //
 // void (*xts_asm_func)(const struct crypto_aes_ctx *key,
-//			const u8 *src, u8 *dst, size_t len,
+//			const u8 *src, u8 *dst, unsigned int len,
 //			u8 tweak[AES_BLOCK_SIZE]);
 //
 // |key| is the data key.  |tweak| contains the next tweak; the encryption of
 // the original IV with the tweak key was already done.  This function supports
 // incremental computation, but |len| must always be >= 16 (AES_BLOCK_SIZE), and
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index e7d21000cb05..110b3282a1f2 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -897,11 +897,11 @@ static int xts_setkey_aesni(struct crypto_skcipher *tfm, const u8 *key,
 }
 
 typedef void (*xts_encrypt_iv_func)(const struct crypto_aes_ctx *tweak_key,
 				    u8 iv[AES_BLOCK_SIZE]);
 typedef void (*xts_crypt_func)(const struct crypto_aes_ctx *key,
-			       const u8 *src, u8 *dst, size_t len,
+			       const u8 *src, u8 *dst, unsigned int len,
 			       u8 tweak[AES_BLOCK_SIZE]);
 
 /* This handles cases where the source and/or destination span pages. */
 static noinline int
 xts_crypt_slowpath(struct skcipher_request *req, xts_crypt_func crypt_func)
@@ -1019,18 +1019,18 @@ static void aesni_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 {
 	aesni_enc(tweak_key, iv, iv);
 }
 
 static void aesni_xts_encrypt(const struct crypto_aes_ctx *key,
-			      const u8 *src, u8 *dst, size_t len,
+			      const u8 *src, u8 *dst, unsigned int len,
 			      u8 tweak[AES_BLOCK_SIZE])
 {
 	aesni_xts_enc(key, dst, src, len, tweak);
 }
 
 static void aesni_xts_decrypt(const struct crypto_aes_ctx *key,
-			      const u8 *src, u8 *dst, size_t len,
+			      const u8 *src, u8 *dst, unsigned int len,
 			      u8 tweak[AES_BLOCK_SIZE])
 {
 	aesni_xts_dec(key, dst, src, len, tweak);
 }
 
@@ -1183,16 +1183,16 @@ static struct simd_skcipher_alg *aesni_simd_xctr;
 asmlinkage void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 				   u8 iv[AES_BLOCK_SIZE]);
 
 #define DEFINE_XTS_ALG(suffix, driver_name, priority)			       \
 									       \
-asmlinkage void aes_xts_encrypt_##suffix(const struct crypto_aes_ctx *key,     \
-					 const u8 *src, u8 *dst, size_t len,   \
-					 u8 tweak[AES_BLOCK_SIZE]);	       \
-asmlinkage void aes_xts_decrypt_##suffix(const struct crypto_aes_ctx *key,     \
-					 const u8 *src, u8 *dst, size_t len,   \
-					 u8 tweak[AES_BLOCK_SIZE]);	       \
+asmlinkage void								       \
+aes_xts_encrypt_##suffix(const struct crypto_aes_ctx *key, const u8 *src,      \
+			 u8 *dst, unsigned int len, u8 tweak[AES_BLOCK_SIZE]); \
+asmlinkage void								       \
+aes_xts_decrypt_##suffix(const struct crypto_aes_ctx *key, const u8 *src,      \
+			 u8 *dst, unsigned int len, u8 tweak[AES_BLOCK_SIZE]); \
 									       \
 static int xts_encrypt_##suffix(struct skcipher_request *req)		       \
 {									       \
 	return xts_crypt(req, aes_xts_encrypt_iv, aes_xts_encrypt_##suffix);   \
 }									       \
-- 
2.44.0


