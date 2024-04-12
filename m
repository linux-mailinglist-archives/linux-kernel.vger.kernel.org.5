Return-Path: <linux-kernel+bounces-142975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B38A32CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3019B231BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1117D1487D9;
	Fri, 12 Apr 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgdV7FEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6CF1487EB;
	Fri, 12 Apr 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936774; cv=none; b=LzA/Df5aGj/SLIFQUXvrAZ7jeS6BMazG1olOqb5T5f8rFJT+PDGBhHLoemElItjPQiwJnuO8vywTrXdLpRiL5W7fO94PLymDLidZ3fv64F4qLiHFWg/GxPQSL3hgw+gCrIhs2a5AmidL7v6+QF4OszfZQXF4LeMI5Kc1HGpZvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936774; c=relaxed/simple;
	bh=X332GSNFEsSKBitRLS+i17dScXamCkeOUyYWvT4bMRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTMxxDCzzMcgpZxhr8atL0LvgTtAeDmbNlYLQRV9qoRsByoA02Zpygx+RDvVOfQvlFrRy1J1txQtvwpYzRYJawaSp5z85aHz2T5ClUekrYu2BOFJFNdROK/H+gxOlPRBUcE4E0IMMfIQ/9DG+v4xtiuMTjDhafwnNMXB4MAa4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgdV7FEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D67C113CC;
	Fri, 12 Apr 2024 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712936773;
	bh=X332GSNFEsSKBitRLS+i17dScXamCkeOUyYWvT4bMRE=;
	h=From:To:Cc:Subject:Date:From;
	b=DgdV7FEXvDi3slnyg1m/1wMZwoWyACw01LT8rYRb4Ue8G0b1FPiAg+xNnigIs982T
	 U1u3ByYc1cwq7UKuT8Mqn/KhRoFJILO2pg/c9fjp51cLseOvGiD6fZymz4x3wzuy+n
	 V9Em8nnGBdXLKkg5jttrPVngzbp1SxYV1cj88kb07OLWZVoYyzk+W7x3Zal1U7Lfu7
	 RBuN1usgSynouI/s9TjjUpaEsija10sSom4/LR3gSb/9eebuDSPBiZEuEMLknv8Jfs
	 n9+w0BsNkdQSN1VSo6ml3GIYkNxoCH/TCXUZHUGLd1bb73W4uzx2IM5Sw2GyMvWT0G
	 G9aHXceDqEj6A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH] crypto: x86/aes-xts - handle CTS encryption more efficiently
Date: Fri, 12 Apr 2024 08:45:59 -0700
Message-ID: <20240412154559.91807-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

When encrypting a message whose length isn't a multiple of 16 bytes,
encrypt the last full block in the main loop.  This works because only
decryption uses the last two tweaks in reverse order, not encryption.

This improves the performance of decrypting messages whose length isn't
a multiple of the AES block length, shrinks the size of
aes-xts-avx-x86_64.o by 5.0%, and eliminates two instructions (a test
and a not-taken conditional jump) when encrypting a message whose length
*is* a multiple of the AES block length.

While it's not super useful to optimize for ciphertext stealing given
that it's rarely needed in practice, the other two benefits mentioned
above make this optimization worthwhile.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 53 +++++++++++++++-------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 95e412e7601d..52f1997ed05a 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -535,16 +535,20 @@
 	// 8th and later round keys which otherwise would need 4-byte offsets.
 .if \enc
 	add		$7*16, KEY
 .else
 	add		$(15+7)*16, KEY
-.endif
 
-	// Check whether the data length is a multiple of the AES block length.
+	// When decrypting a message whose length isn't a multiple of the AES
+	// block length, exclude the last full block from the main loop by
+	// subtracting 16 from LEN.  This is needed because ciphertext stealing
+	// decryption uses the last two tweaks in reverse order.  We'll handle
+	// the last full block and the partial block specially at the end.
 	test		$15, LEN
-	jnz		.Lneed_cts\@
+	jnz		.Lneed_cts_dec\@
 .Lxts_init\@:
+.endif
 
 	// Cache as many round keys as possible.
 	_load_round_keys
 
 	// Compute the first set of tweaks TWEAK[0-3].
@@ -683,45 +687,46 @@
 	_vaes_4x	\enc, 0, 10
 	_vaes_4x	\enc, 0, 11
 	_vaes_4x	\enc, 1, 12
 	jmp		.Lencrypt_4x_done\@
 
-.Lneed_cts\@:
-	// The data length isn't a multiple of the AES block length, so
-	// ciphertext stealing (CTS) will be needed.  Subtract one block from
-	// LEN so that the main loop doesn't process the last full block.  The
-	// CTS step will process it specially along with the partial block.
+.if !\enc
+.Lneed_cts_dec\@:
 	sub		$16, LEN
 	jmp		.Lxts_init\@
+.endif
 
 .Lcts\@:
 	// Do ciphertext stealing (CTS) to en/decrypt the last full block and
-	// the partial block.  CTS needs two tweaks.  TWEAK0_XMM contains the
-	// next tweak; compute the one after that.  Decryption uses these two
-	// tweaks in reverse order, so also define aliases to handle that.
-	_next_tweak	TWEAK0_XMM, %xmm0, TWEAK1_XMM
+	// the partial block.  TWEAK0_XMM contains the next tweak.
+
 .if \enc
-	.set		CTS_TWEAK0,	TWEAK0_XMM
-	.set		CTS_TWEAK1,	TWEAK1_XMM
+	// If encrypting, the main loop already encrypted the last full block to
+	// create the CTS intermediate ciphertext.  Prepare for the rest of CTS
+	// by rewinding the pointers and loading the intermediate ciphertext.
+	sub		$16, SRC
+	sub		$16, DST
+	vmovdqu		(DST), %xmm0
 .else
-	.set		CTS_TWEAK0,	TWEAK1_XMM
-	.set		CTS_TWEAK1,	TWEAK0_XMM
-.endif
-
-	// En/decrypt the last full block.
+	// If decrypting, the main loop didn't decrypt the last full block
+	// because CTS decryption uses the last two tweaks in reverse order.
+	// Do it now by advancing the tweak and decrypting the last full block.
+	_next_tweak	TWEAK0_XMM, %xmm0, TWEAK1_XMM
 	vmovdqu		(SRC), %xmm0
-	_aes_crypt	\enc, _XMM, CTS_TWEAK0, %xmm0
+	_aes_crypt	\enc, _XMM, TWEAK1_XMM, %xmm0
+.endif
 
 .if USE_AVX10
 	// Create a mask that has the first LEN bits set.
 	mov		$-1, %rax
 	bzhi		LEN, %rax, %rax
 	kmovq		%rax, %k1
 
-	// Swap the first LEN bytes of the above result with the partial block.
-	// Note that to support in-place en/decryption, the load from the src
-	// partial block must happen before the store to the dst partial block.
+	// Swap the first LEN bytes of the en/decryption of the last full block
+	// with the partial block.  Note that to support in-place en/decryption,
+	// the load from the src partial block must happen before the store to
+	// the dst partial block.
 	vmovdqa		%xmm0, %xmm1
 	vmovdqu8	16(SRC), %xmm0{%k1}
 	vmovdqu8	%xmm1, 16(DST){%k1}
 .else
 	lea		.Lcts_permute_table(%rip), %rax
@@ -748,11 +753,11 @@
 	// Do a blend to generate the src partial block followed by the second
 	// part of the en/decryption of the last full block.
 	vpblendvb	%xmm3, %xmm0, %xmm1, %xmm0
 .endif
 	// En/decrypt again and store the last full block.
-	_aes_crypt	\enc, _XMM, CTS_TWEAK1, %xmm0
+	_aes_crypt	\enc, _XMM, TWEAK0_XMM, %xmm0
 	vmovdqu		%xmm0, (DST)
 	jmp		.Ldone\@
 .endm
 
 // void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,

base-commit: 751fb2528c12ef64d1e863efb196cdc968b384f6
prerequisite-patch-id: 5c1ca8ffe87136eb7bfe74d996f5e6cac01e2768
-- 
2.44.0


