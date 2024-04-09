Return-Path: <linux-kernel+bounces-136030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983689CF25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF7E1C21EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AB818;
	Tue,  9 Apr 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ficKkfdm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E07382;
	Tue,  9 Apr 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620935; cv=none; b=F5s2Ywha8qHHrawQlT15NuxhMeZmoN84UIDuX8aod9gsfTndeNRVi6HRITrRq6klDw/mYgCgvBN8zJ+ON3wv2zqq0H6wKDu7Kw/lFq8lH1b6574kYGPH6l1qCvqy8qsVd5EMMsaF6n4rfr5iztw+404f0qxJHvmYOZsA+fYNXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620935; c=relaxed/simple;
	bh=yhXntb+BygzkvYcAgq9T0aPC7O5Ntbn9Mam2SrrYtK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPR2TDbm5KOHxGbgSR5qUWa9S+bggx8anSdT/ve83hMobSAc2bQcOyifuH8Thvzeub7Xukth3/D+4ksK72YR0ZGT9cplpHESs0DOpmOeKhDaXzOk9jXVH+KqbYxqG/BZGIWBMMN7NdhQmUjAw4Osb2FjRr8OpwAl00Lcoo50XAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ficKkfdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E332FC433F1;
	Tue,  9 Apr 2024 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712620935;
	bh=yhXntb+BygzkvYcAgq9T0aPC7O5Ntbn9Mam2SrrYtK0=;
	h=From:To:Cc:Subject:Date:From;
	b=ficKkfdmWW7fW5iH/R4pSHL3wZ2VRnCZp89hyZnIYfLB/gmUKf1mLgQABghp6ooBM
	 6Krko6sTeTGm2UmygE2nsMXK6W90v874yJUcZOa2LBS4yiF7UdE2RVikAxEu4bzd26
	 6op3BjXxYA4twN9tjHy/9s4pAW8uHhZGAAzIn++anYV6FvC8o4nnFq10sFgmunzaJs
	 i5i99HGS8J3VWRYksLaZn+4/h4APD1Z5+VtXJkqInEVWI8BcjxDZlPmUxDjYsC2jDq
	 FeA9ykObzh3bwUYFmwtdZ95/qsJEBb3FTlRYUEGTpfTpcoP1ar8+hXnT63d+i36Sbw
	 QYBy3HYPZrhcw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: [PATCH] crypto: x86/aes-xts - access round keys using single-byte offsets
Date: Mon,  8 Apr 2024 20:01:54 -0400
Message-ID: <20240409000154.29799-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Access the AES round keys using offsets -7*16 through 7*16, instead of
0*16 through 14*16.  This allows VEX-encoded instructions to address all
round keys using 1-byte offsets, whereas before some needed 4-byte
offsets.  This decreases the code size of aes-xts-avx-x86_64.o by 4.2%.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 81 +++++++++++++++-------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index fcaf64a2f8c6..95e412e7601d 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -80,11 +80,11 @@
 	.byte	0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
 .text
 
 // Function parameters
 .set	KEY,		%rdi	// Initially points to crypto_aes_ctx, then is
-				// advanced to point directly to the round keys
+				// advanced to point directly to 7th round key
 .set	SRC,		%rsi	// Pointer to next source data
 .set	DST,		%rdx	// Pointer to next destination data
 .set	LEN,		%rcx	// Remaining length in bytes
 .set	TWEAK,		%r8	// Pointer to next tweak
 
@@ -406,28 +406,28 @@
 .endif
 .endm
 
 // Load the round keys: just the first one if !USE_AVX10, otherwise all of them.
 .macro	_load_round_keys
-	_vbroadcast128	0*16(KEY), KEY0
+	_vbroadcast128	-7*16(KEY), KEY0
 .if USE_AVX10
-	_vbroadcast128	1*16(KEY), KEY1
-	_vbroadcast128	2*16(KEY), KEY2
-	_vbroadcast128	3*16(KEY), KEY3
-	_vbroadcast128	4*16(KEY), KEY4
-	_vbroadcast128	5*16(KEY), KEY5
-	_vbroadcast128	6*16(KEY), KEY6
-	_vbroadcast128	7*16(KEY), KEY7
-	_vbroadcast128	8*16(KEY), KEY8
-	_vbroadcast128	9*16(KEY), KEY9
-	_vbroadcast128	10*16(KEY), KEY10
+	_vbroadcast128	-6*16(KEY), KEY1
+	_vbroadcast128	-5*16(KEY), KEY2
+	_vbroadcast128	-4*16(KEY), KEY3
+	_vbroadcast128	-3*16(KEY), KEY4
+	_vbroadcast128	-2*16(KEY), KEY5
+	_vbroadcast128	-1*16(KEY), KEY6
+	_vbroadcast128	0*16(KEY), KEY7
+	_vbroadcast128	1*16(KEY), KEY8
+	_vbroadcast128	2*16(KEY), KEY9
+	_vbroadcast128	3*16(KEY), KEY10
 	// Note: if it's AES-128 or AES-192, the last several round keys won't
 	// be used.  We do the loads anyway to save a conditional jump.
-	_vbroadcast128	11*16(KEY), KEY11
-	_vbroadcast128	12*16(KEY), KEY12
-	_vbroadcast128	13*16(KEY), KEY13
-	_vbroadcast128	14*16(KEY), KEY14
+	_vbroadcast128	4*16(KEY), KEY11
+	_vbroadcast128	5*16(KEY), KEY12
+	_vbroadcast128	6*16(KEY), KEY13
+	_vbroadcast128	7*16(KEY), KEY14
 .endif
 .endm
 
 // Do a single round of AES encryption (if \enc==1) or decryption (if \enc==0)
 // on the block(s) in \data using the round key(s) in \key.  The register length
@@ -454,13 +454,13 @@
 .macro _vaes_1x		enc, last, i, xmm_suffix, data
 .if USE_AVX10
 	_vaes		\enc, \last, KEY\i\xmm_suffix, \data
 .else
 .ifnb \xmm_suffix
-	_vaes		\enc, \last, \i*16(KEY), \data
+	_vaes		\enc, \last, (\i-7)*16(KEY), \data
 .else
-	_vbroadcast128	\i*16(KEY), V4
+	_vbroadcast128	(\i-7)*16(KEY), V4
 	_vaes		\enc, \last, V4, \data
 .endif
 .endif
 .endm
 
@@ -475,11 +475,11 @@
 	_vaes		\enc, \last, KEY\i, V1
 	_tweak_step	(2*(\i-1) + 1)
 	_vaes		\enc, \last, KEY\i, V2
 	_vaes		\enc, \last, KEY\i, V3
 .else
-	_vbroadcast128	\i*16(KEY), V4
+	_vbroadcast128	(\i-7)*16(KEY), V4
 	_tweak_step	(2*(\i-1))
 	_vaes		\enc, \last, V4, V0
 	_vaes		\enc, \last, V4, V1
 	_tweak_step	(2*(\i-1) + 1)
 	_vaes		\enc, \last, V4, V2
@@ -526,13 +526,19 @@
 	_define_aliases
 
 	// Load the AES key length: 16 (AES-128), 24 (AES-192), or 32 (AES-256).
 	movl		480(KEY), KEYLEN
 
-	// If decrypting, advance KEY to the decryption round keys.
-.if !\enc
-	add		$240, KEY
+	// Advance KEY to point to the 7th encryption round key (if encrypting)
+	// or the 7th decryption round key (if decrypting).  This makes the
+	// offset to any round key be in the range [-112, 112], fitting in a
+	// signed byte.  This shortens VEX-encoded instructions that access the
+	// 8th and later round keys which otherwise would need 4-byte offsets.
+.if \enc
+	add		$7*16, KEY
+.else
+	add		$(15+7)*16, KEY
 .endif
 
 	// Check whether the data length is a multiple of the AES block length.
 	test		$15, LEN
 	jnz		.Lneed_cts\@
@@ -751,40 +757,41 @@
 
 // void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 //			   u8 iv[AES_BLOCK_SIZE]);
 SYM_TYPED_FUNC_START(aes_xts_encrypt_iv)
 	vmovdqu		(%rsi), %xmm0
-	vpxor		0*16(%rdi), %xmm0, %xmm0
+	add		$7*16, %rdi
+	vpxor		-7*16(%rdi), %xmm0, %xmm0
+	vaesenc		-6*16(%rdi), %xmm0, %xmm0
+	vaesenc		-5*16(%rdi), %xmm0, %xmm0
+	vaesenc		-4*16(%rdi), %xmm0, %xmm0
+	vaesenc		-3*16(%rdi), %xmm0, %xmm0
+	vaesenc		-2*16(%rdi), %xmm0, %xmm0
+	vaesenc		-1*16(%rdi), %xmm0, %xmm0
+	vaesenc		0*16(%rdi), %xmm0, %xmm0
 	vaesenc		1*16(%rdi), %xmm0, %xmm0
 	vaesenc		2*16(%rdi), %xmm0, %xmm0
+	cmpl		$24, 480-(7*16)(%rdi)
+	jle		.Lencrypt_iv_aes_128_or_192
 	vaesenc		3*16(%rdi), %xmm0, %xmm0
 	vaesenc		4*16(%rdi), %xmm0, %xmm0
 	vaesenc		5*16(%rdi), %xmm0, %xmm0
 	vaesenc		6*16(%rdi), %xmm0, %xmm0
-	vaesenc		7*16(%rdi), %xmm0, %xmm0
-	vaesenc		8*16(%rdi), %xmm0, %xmm0
-	vaesenc		9*16(%rdi), %xmm0, %xmm0
-	cmpl		$24, 480(%rdi)
-	jle		.Lencrypt_iv_aes_128_or_192
-	vaesenc		10*16(%rdi), %xmm0, %xmm0
-	vaesenc		11*16(%rdi), %xmm0, %xmm0
-	vaesenc		12*16(%rdi), %xmm0, %xmm0
-	vaesenc		13*16(%rdi), %xmm0, %xmm0
-	vaesenclast	14*16(%rdi), %xmm0, %xmm0
+	vaesenclast	7*16(%rdi), %xmm0, %xmm0
 .Lencrypt_iv_done:
 	vmovdqu		%xmm0, (%rsi)
 	RET
 
 	// Out-of-line handling of AES-128 and AES-192
 .Lencrypt_iv_aes_128_or_192:
 	jz		.Lencrypt_iv_aes_192
-	vaesenclast	10*16(%rdi), %xmm0, %xmm0
+	vaesenclast	3*16(%rdi), %xmm0, %xmm0
 	jmp		.Lencrypt_iv_done
 .Lencrypt_iv_aes_192:
-	vaesenc		10*16(%rdi), %xmm0, %xmm0
-	vaesenc		11*16(%rdi), %xmm0, %xmm0
-	vaesenclast	12*16(%rdi), %xmm0, %xmm0
+	vaesenc		3*16(%rdi), %xmm0, %xmm0
+	vaesenc		4*16(%rdi), %xmm0, %xmm0
+	vaesenclast	5*16(%rdi), %xmm0, %xmm0
 	jmp		.Lencrypt_iv_done
 SYM_FUNC_END(aes_xts_encrypt_iv)
 
 // Below are the actual AES-XTS encryption and decryption functions,
 // instantiated from the above macro.  They all have the following prototype:

base-commit: 4ad27a8be9dbefd4820da0f60da879d512b2f659
prerequisite-patch-id: 8d09ed747039f5e718ac7267e2a15e22504aa7f3
-- 
2.44.0


