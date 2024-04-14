Return-Path: <linux-kernel+bounces-143535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E18A3AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2EA1C227CF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E111BDC4;
	Sat, 13 Apr 2024 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLfj+tZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46DEEDB;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978479; cv=none; b=fdACn77Lg42PtVhLvdMLf3UaeOD+4yETbusVMS0xyHe0R5vfk+AeiOeiPc1Dv+Rttq3FaSpuJChc2W+DYIqsLUDuRJBj3sorI2NA76cqLfuqesjapyYiqy0ZCEig/DbhkVUoQj3OjNMiT6SeFheHnRM8Mcy5jnBJLTrr16FGTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978479; c=relaxed/simple;
	bh=CllIiD3tn6cFwJ63Rz3Y0INqIuTRFjBW46llCI7TCwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ple1yvgaWjZ71nY4cLE5tSigZGakYhI1LDqDoemcwJbhkohAeAqfC5+QxWd0GOnXnjgGJEELFjlj+rDDJoOXfAn76dHu7yXMtQ9nlxBom369LzXidvbsMXPiQCYFaMrO7t4vt3QmR24ObTL8VKFeHzv5YUJ68FukRmL5DZrtZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLfj+tZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D1EC2BD11;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712978478;
	bh=CllIiD3tn6cFwJ63Rz3Y0INqIuTRFjBW46llCI7TCwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLfj+tZedYDCnO0PE5j+h5XtoVdtIH0fb6eSRqv1A1kihVkNZ7t9q61lptrbXuKdl
	 EXvKQ0wdHEx63LN7hn+1F3By+lPsiTIPra1EzgS7cofU167/pZ2fsrDSDHRrmFTWw3
	 DrXRvyYPVM5Zg9AfJ1DDy8Febr74y1Id987+IrQFf1hpDwZ9MKYghq5/KeuRa0wlw9
	 MVZEqXHdK6A3V/qq8uW3diyfKOjtO7Q7h7qsVqRztOHxwXOIs4TcGLTEDvZvjfWKBa
	 GsWn/KpMkBc/jbSYNa2TlXysoP3uuKy0XbOtedJD9DLPQTP5w7pcEsj5kIM1nB+S78
	 vhU1ZXFUCs0sg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 1/3] crypto: x86/aes-xts - handle AES-128 and AES-192 more efficiently
Date: Fri, 12 Apr 2024 20:17:26 -0700
Message-ID: <20240413031728.159495-2-ebiggers@kernel.org>
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

Decrease the amount of code specific to the different AES variants by
"right-aligning" the sequence of round keys, and for AES-128 and AES-192
just skipping irrelevant rounds at the beginning.

This shrinks the size of aes-xts-avx-x86_64.o by 13.3%, and it improves
the efficiency of AES-128 and AES-192.  The tradeoff is that for AES-256
some additional not-taken conditional jumps are now executed.  But these
are predicted well and are cheap on x86.

Note that the ARMv8 CE based AES-XTS implementation uses a similar
strategy to handle the different AES variants.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 178 ++++++++++++++-------------
 1 file changed, 92 insertions(+), 86 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index 52f1997ed05a..f5e7ab739105 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -80,18 +80,19 @@
 	.byte	0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
 .text
 
 // Function parameters
 .set	KEY,		%rdi	// Initially points to crypto_aes_ctx, then is
-				// advanced to point directly to 7th round key
+				// advanced to point to 7th-from-last round key
 .set	SRC,		%rsi	// Pointer to next source data
 .set	DST,		%rdx	// Pointer to next destination data
 .set	LEN,		%rcx	// Remaining length in bytes
 .set	TWEAK,		%r8	// Pointer to next tweak
 
-// %r9d holds the AES key length in bytes.
+// %r9 holds the AES key length in bytes.
 .set	KEYLEN,		%r9d
+.set	KEYLEN64,	%r9
 
 // %rax and %r10-r11 are available as temporaries.
 
 .macro	_define_Vi	i
 .if VL == 16
@@ -163,16 +164,22 @@
 
 	// V14 holds the constant from .Lgf_poly, copied to all 128-bit lanes.
 	.set	GF_POLY_XMM,	%xmm14
 	.set	GF_POLY,	V14
 
-	// V15 holds the first AES round key, copied to all 128-bit lanes.
+	// V15 holds the key for AES "round 0", copied to all 128-bit lanes.
 	.set	KEY0_XMM,	%xmm15
 	.set	KEY0,		V15
 
 	// If 32 SIMD registers are available, then V16-V29 hold the remaining
 	// AES round keys, copied to all 128-bit lanes.
+	//
+	// AES-128, AES-192, and AES-256 use different numbers of round keys.
+	// To allow handling all three variants efficiently, we align the round
+	// keys to the *end* of this register range.  I.e., AES-128 uses
+	// KEY5-KEY14, AES-192 uses KEY3-KEY14, and AES-256 uses KEY1-KEY14.
+	// (All also use KEY0 for the XOR-only "round" at the beginning.)
 .if USE_AVX10
 	.set	KEY1_XMM,	%xmm16
 	.set	KEY1,		V16
 	.set	KEY2_XMM,	%xmm17
 	.set	KEY2,		V17
@@ -338,19 +345,19 @@
 	.set NEXT_TWEAK, NEXT_TWEAK2
 .elseif \i == 15
 	.set PREV_TWEAK, NEXT_TWEAK2
 	.set NEXT_TWEAK, NEXT_TWEAK3
 .endif
-.if \i < 20 && \i % 5 == 0
+.if \i >= 0 && \i < 20 && \i % 5 == 0
 	vpshufd		$0x13, PREV_TWEAK, V5
-.elseif \i < 20 && \i % 5 == 1
+.elseif \i >= 0 && \i < 20 && \i % 5 == 1
 	vpaddq		PREV_TWEAK, PREV_TWEAK, NEXT_TWEAK
-.elseif \i < 20 && \i % 5 == 2
+.elseif \i >= 0 && \i < 20 && \i % 5 == 2
 	vpsrad		$31, V5, V5
-.elseif \i < 20 && \i % 5 == 3
+.elseif \i >= 0 && \i < 20 && \i % 5 == 3
 	vpand		GF_POLY, V5, V5
-.elseif \i < 20 && \i % 5 == 4
+.elseif \i >= 0 && \i < 20 && \i % 5 == 4
 	vpxor		V5, NEXT_TWEAK, NEXT_TWEAK
 .elseif \i == 1000
 	vmovdqa		NEXT_TWEAK0, TWEAK0
 	vmovdqa		NEXT_TWEAK1, TWEAK1
 	vmovdqa		NEXT_TWEAK2, TWEAK2
@@ -362,25 +369,25 @@
 // (the same method _next_tweakvec uses for VL > 16).  This means multiplying
 // each tweak by x^(4*VL/16) independently.  Since 4*VL/16 is a multiple of 8
 // when VL > 16 (which it is here), the needed shift amounts are byte-aligned,
 // which allows the use of vpsrldq and vpslldq to do 128-bit wide shifts.
 .macro	_tweak_step_pclmul	i
-.if \i == 2
+.if \i == 0
 	vpsrldq		$(128 - 4*VL/16) / 8, TWEAK0, NEXT_TWEAK0
-.elseif \i == 4
+.elseif \i == 2
 	vpsrldq		$(128 - 4*VL/16) / 8, TWEAK1, NEXT_TWEAK1
-.elseif \i == 6
+.elseif \i == 4
 	vpsrldq		$(128 - 4*VL/16) / 8, TWEAK2, NEXT_TWEAK2
-.elseif \i == 8
+.elseif \i == 6
 	vpsrldq		$(128 - 4*VL/16) / 8, TWEAK3, NEXT_TWEAK3
-.elseif \i == 10
+.elseif \i == 8
 	vpclmulqdq	$0x00, GF_POLY, NEXT_TWEAK0, NEXT_TWEAK0
-.elseif \i == 12
+.elseif \i == 10
 	vpclmulqdq	$0x00, GF_POLY, NEXT_TWEAK1, NEXT_TWEAK1
-.elseif \i == 14
+.elseif \i == 12
 	vpclmulqdq	$0x00, GF_POLY, NEXT_TWEAK2, NEXT_TWEAK2
-.elseif \i == 16
+.elseif \i == 14
 	vpclmulqdq	$0x00, GF_POLY, NEXT_TWEAK3, NEXT_TWEAK3
 .elseif \i == 1000
 	vpslldq		$(4*VL/16) / 8, TWEAK0, TWEAK0
 	vpslldq		$(4*VL/16) / 8, TWEAK1, TWEAK1
 	vpslldq		$(4*VL/16) / 8, TWEAK2, TWEAK2
@@ -391,12 +398,12 @@
 	_vpxor		NEXT_TWEAK3, TWEAK3, TWEAK3
 .endif
 .endm
 
 // _tweak_step does one step of the computation of the next set of tweaks from
-// TWEAK[0-3].  To complete all steps, this must be invoked with \i values 0
-// through at least 19, then 1000 which signals the last step.
+// TWEAK[0-3].  To complete all steps, this is invoked with increasing values of
+// \i that include at least 0 through 19, then 1000 which signals the last step.
 //
 // This is used to interleave the computation of the next set of tweaks with the
 // AES en/decryptions, which increases performance in some cases.
 .macro	_tweak_step	i
 .if VL == 16
@@ -404,26 +411,60 @@
 .else
 	_tweak_step_pclmul	\i
 .endif
 .endm
 
-// Load the round keys: just the first one if !USE_AVX10, otherwise all of them.
-.macro	_load_round_keys
-	_vbroadcast128	-7*16(KEY), KEY0
+.macro	_setup_round_keys	enc
+
+	// Select either the encryption round keys or the decryption round keys.
+.if \enc
+	.set	OFFS, 0
+.else
+	.set	OFFS, 240
+.endif
+
+	// Load the round key for "round 0".
+	_vbroadcast128	OFFS(KEY), KEY0
+
+	// Increment KEY to make it so that 7*16(KEY) is the last round key.
+	// For AES-128, increment by 3*16, resulting in the 10 round keys (not
+	// counting the zero-th round key which was just loaded into KEY0) being
+	// -2*16(KEY) through 7*16(KEY).  For AES-192, increment by 5*16 and use
+	// 12 round keys -4*16(KEY) through 7*16(KEY).  For AES-256, increment
+	// by 7*16 and use 14 round keys -6*16(KEY) through 7*16(KEY).
+	//
+	// This rebasing provides two benefits.  First, it makes the offset to
+	// any round key be in the range [-96, 112], fitting in a signed byte.
+	// This shortens VEX-encoded instructions that access the later round
+	// keys which otherwise would need 4-byte offsets.  Second, it makes it
+	// easy to do AES-128 and AES-192 by skipping irrelevant rounds at the
+	// beginning.  Skipping rounds at the end doesn't work as well because
+	// the last round needs different instructions.
+	//
+	// An alternative approach would be to roll up all the round loops.  We
+	// don't do that because it isn't compatible with caching the round keys
+	// in registers which we do when possible (see below), and also because
+	// it seems unwise to rely *too* heavily on the CPU's branch predictor.
+	lea		OFFS-16(KEY, KEYLEN64, 4), KEY
+
+	// If all 32 SIMD registers are available, cache all the round keys.
 .if USE_AVX10
+	cmp		$24, KEYLEN
+	jl		.Laes128\@
+	je		.Laes192\@
 	_vbroadcast128	-6*16(KEY), KEY1
 	_vbroadcast128	-5*16(KEY), KEY2
+.Laes192\@:
 	_vbroadcast128	-4*16(KEY), KEY3
 	_vbroadcast128	-3*16(KEY), KEY4
+.Laes128\@:
 	_vbroadcast128	-2*16(KEY), KEY5
 	_vbroadcast128	-1*16(KEY), KEY6
 	_vbroadcast128	0*16(KEY), KEY7
 	_vbroadcast128	1*16(KEY), KEY8
 	_vbroadcast128	2*16(KEY), KEY9
 	_vbroadcast128	3*16(KEY), KEY10
-	// Note: if it's AES-128 or AES-192, the last several round keys won't
-	// be used.  We do the loads anyway to save a conditional jump.
 	_vbroadcast128	4*16(KEY), KEY11
 	_vbroadcast128	5*16(KEY), KEY12
 	_vbroadcast128	6*16(KEY), KEY13
 	_vbroadcast128	7*16(KEY), KEY14
 .endif
@@ -464,26 +505,26 @@
 .endif
 .endm
 
 // Do a single round of AES en/decryption on the blocks in registers V0-V3,
 // using the same key for all blocks.  The round key is loaded from the
-// appropriate register or memory location for round \i.  In addition, does step
-// \i of the computation of the next set of tweaks.  May clobber V4.
+// appropriate register or memory location for round \i.  In addition, does two
+// steps of the computation of the next set of tweaks.  May clobber V4.
 .macro	_vaes_4x	enc, last, i
 .if USE_AVX10
-	_tweak_step	(2*(\i-1))
+	_tweak_step	(2*(\i-5))
 	_vaes		\enc, \last, KEY\i, V0
 	_vaes		\enc, \last, KEY\i, V1
-	_tweak_step	(2*(\i-1) + 1)
+	_tweak_step	(2*(\i-5) + 1)
 	_vaes		\enc, \last, KEY\i, V2
 	_vaes		\enc, \last, KEY\i, V3
 .else
 	_vbroadcast128	(\i-7)*16(KEY), V4
-	_tweak_step	(2*(\i-1))
+	_tweak_step	(2*(\i-5))
 	_vaes		\enc, \last, V4, V0
 	_vaes		\enc, \last, V4, V1
-	_tweak_step	(2*(\i-1) + 1)
+	_tweak_step	(2*(\i-5) + 1)
 	_vaes		\enc, \last, V4, V2
 	_vaes		\enc, \last, V4, V3
 .endif
 .endm
 
@@ -491,78 +532,62 @@
 // then XOR with \tweak again) of the block(s) in \data.  To process a single
 // block, use xmm registers and set \xmm_suffix=_XMM.  To process a vector of
 // length VL, use V* registers and leave \xmm_suffix empty.  May clobber V4.
 .macro	_aes_crypt	enc, xmm_suffix, tweak, data
 	_xor3		KEY0\xmm_suffix, \tweak, \data
+	cmp		$24, KEYLEN
+	jl		.Laes128\@
+	je		.Laes192\@
 	_vaes_1x	\enc, 0, 1, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 2, \xmm_suffix, \data
+.Laes192\@:
 	_vaes_1x	\enc, 0, 3, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 4, \xmm_suffix, \data
+.Laes128\@:
 	_vaes_1x	\enc, 0, 5, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 6, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 7, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 8, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 9, \xmm_suffix, \data
-	cmp		$24, KEYLEN
-	jle		.Laes_128_or_192\@
 	_vaes_1x	\enc, 0, 10, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 11, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 12, \xmm_suffix, \data
 	_vaes_1x	\enc, 0, 13, \xmm_suffix, \data
 	_vaes_1x	\enc, 1, 14, \xmm_suffix, \data
-	jmp		.Laes_done\@
-.Laes_128_or_192\@:
-	je		.Laes_192\@
-	_vaes_1x	\enc, 1, 10, \xmm_suffix, \data
-	jmp		.Laes_done\@
-.Laes_192\@:
-	_vaes_1x	\enc, 0, 10, \xmm_suffix, \data
-	_vaes_1x	\enc, 0, 11, \xmm_suffix, \data
-	_vaes_1x	\enc, 1, 12, \xmm_suffix, \data
-.Laes_done\@:
 	_vpxor		\tweak, \data, \data
 .endm
 
 .macro	_aes_xts_crypt	enc
 	_define_aliases
 
 	// Load the AES key length: 16 (AES-128), 24 (AES-192), or 32 (AES-256).
 	movl		480(KEY), KEYLEN
 
-	// Advance KEY to point to the 7th encryption round key (if encrypting)
-	// or the 7th decryption round key (if decrypting).  This makes the
-	// offset to any round key be in the range [-112, 112], fitting in a
-	// signed byte.  This shortens VEX-encoded instructions that access the
-	// 8th and later round keys which otherwise would need 4-byte offsets.
-.if \enc
-	add		$7*16, KEY
-.else
-	add		$(15+7)*16, KEY
-
+.if !\enc
 	// When decrypting a message whose length isn't a multiple of the AES
 	// block length, exclude the last full block from the main loop by
 	// subtracting 16 from LEN.  This is needed because ciphertext stealing
 	// decryption uses the last two tweaks in reverse order.  We'll handle
 	// the last full block and the partial block specially at the end.
 	test		$15, LEN
 	jnz		.Lneed_cts_dec\@
 .Lxts_init\@:
 .endif
 
-	// Cache as many round keys as possible.
-	_load_round_keys
+	// Setup the pointer to the round keys and cache as many as possible.
+	_setup_round_keys	\enc
 
 	// Compute the first set of tweaks TWEAK[0-3].
 	_compute_first_set_of_tweaks
 
 	sub		$4*VL, LEN
 	jl		.Lhandle_remainder\@
 
 .Lmain_loop\@:
 	// This is the main loop, en/decrypting 4*VL bytes per iteration.
 
-	// XOR each source block with its tweak and the first round key.
+	// XOR each source block with its tweak and the zero-th round key.
 .if USE_AVX10
 	vmovdqu8	0*VL(SRC), V0
 	vmovdqu8	1*VL(SRC), V1
 	vmovdqu8	2*VL(SRC), V2
 	vmovdqu8	3*VL(SRC), V3
@@ -578,31 +603,31 @@
 	vpxor		TWEAK0, V0, V0
 	vpxor		TWEAK1, V1, V1
 	vpxor		TWEAK2, V2, V2
 	vpxor		TWEAK3, V3, V3
 .endif
+	cmp		$24, KEYLEN
+	jl		.Laes128\@
+	je		.Laes192\@
 	// Do all the AES rounds on the data blocks, interleaved with
 	// the computation of the next set of tweaks.
 	_vaes_4x	\enc, 0, 1
 	_vaes_4x	\enc, 0, 2
+.Laes192\@:
 	_vaes_4x	\enc, 0, 3
 	_vaes_4x	\enc, 0, 4
+.Laes128\@:
 	_vaes_4x	\enc, 0, 5
 	_vaes_4x	\enc, 0, 6
 	_vaes_4x	\enc, 0, 7
 	_vaes_4x	\enc, 0, 8
 	_vaes_4x	\enc, 0, 9
-	// Try to optimize for AES-256 by keeping the code for AES-128 and
-	// AES-192 out-of-line.
-	cmp		$24, KEYLEN
-	jle		.Lencrypt_4x_aes_128_or_192\@
 	_vaes_4x	\enc, 0, 10
 	_vaes_4x	\enc, 0, 11
 	_vaes_4x	\enc, 0, 12
 	_vaes_4x	\enc, 0, 13
 	_vaes_4x	\enc, 1, 14
-.Lencrypt_4x_done\@:
 
 	// XOR in the tweaks again.
 	_vpxor		TWEAK0, V0, V0
 	_vpxor		TWEAK1, V1, V1
 	_vpxor		TWEAK2, V2, V2
@@ -676,21 +701,10 @@
 	// process the last 16 + LEN bytes.  If LEN is zero, we're done.
 	test		LEN, LEN
 	jnz		.Lcts\@
 	jmp		.Ldone\@
 
-	// Out-of-line handling of AES-128 and AES-192
-.Lencrypt_4x_aes_128_or_192\@:
-	jz		.Lencrypt_4x_aes_192\@
-	_vaes_4x	\enc, 1, 10
-	jmp		.Lencrypt_4x_done\@
-.Lencrypt_4x_aes_192\@:
-	_vaes_4x	\enc, 0, 10
-	_vaes_4x	\enc, 0, 11
-	_vaes_4x	\enc, 1, 12
-	jmp		.Lencrypt_4x_done\@
-
 .if !\enc
 .Lneed_cts_dec\@:
 	sub		$16, LEN
 	jmp		.Lxts_init\@
 .endif
@@ -762,42 +776,34 @@
 
 // void aes_xts_encrypt_iv(const struct crypto_aes_ctx *tweak_key,
 //			   u8 iv[AES_BLOCK_SIZE]);
 SYM_TYPED_FUNC_START(aes_xts_encrypt_iv)
 	vmovdqu		(%rsi), %xmm0
-	add		$7*16, %rdi
-	vpxor		-7*16(%rdi), %xmm0, %xmm0
+	vpxor		(%rdi), %xmm0, %xmm0
+	movl		480(%rdi), %eax		// AES key length
+	lea		-16(%rdi, %rax, 4), %rdi
+	cmp		$24, %eax
+	jl		.Lencrypt_iv_aes128
+	je		.Lencrypt_iv_aes192
 	vaesenc		-6*16(%rdi), %xmm0, %xmm0
 	vaesenc		-5*16(%rdi), %xmm0, %xmm0
+.Lencrypt_iv_aes192:
 	vaesenc		-4*16(%rdi), %xmm0, %xmm0
 	vaesenc		-3*16(%rdi), %xmm0, %xmm0
+.Lencrypt_iv_aes128:
 	vaesenc		-2*16(%rdi), %xmm0, %xmm0
 	vaesenc		-1*16(%rdi), %xmm0, %xmm0
 	vaesenc		0*16(%rdi), %xmm0, %xmm0
 	vaesenc		1*16(%rdi), %xmm0, %xmm0
 	vaesenc		2*16(%rdi), %xmm0, %xmm0
-	cmpl		$24, 480-(7*16)(%rdi)
-	jle		.Lencrypt_iv_aes_128_or_192
 	vaesenc		3*16(%rdi), %xmm0, %xmm0
 	vaesenc		4*16(%rdi), %xmm0, %xmm0
 	vaesenc		5*16(%rdi), %xmm0, %xmm0
 	vaesenc		6*16(%rdi), %xmm0, %xmm0
 	vaesenclast	7*16(%rdi), %xmm0, %xmm0
-.Lencrypt_iv_done:
 	vmovdqu		%xmm0, (%rsi)
 	RET
-
-	// Out-of-line handling of AES-128 and AES-192
-.Lencrypt_iv_aes_128_or_192:
-	jz		.Lencrypt_iv_aes_192
-	vaesenclast	3*16(%rdi), %xmm0, %xmm0
-	jmp		.Lencrypt_iv_done
-.Lencrypt_iv_aes_192:
-	vaesenc		3*16(%rdi), %xmm0, %xmm0
-	vaesenc		4*16(%rdi), %xmm0, %xmm0
-	vaesenclast	5*16(%rdi), %xmm0, %xmm0
-	jmp		.Lencrypt_iv_done
 SYM_FUNC_END(aes_xts_encrypt_iv)
 
 // Below are the actual AES-XTS encryption and decryption functions,
 // instantiated from the above macro.  They all have the following prototype:
 //
-- 
2.44.0


