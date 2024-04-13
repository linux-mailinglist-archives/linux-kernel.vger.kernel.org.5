Return-Path: <linux-kernel+bounces-143536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C5E8A3AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF8F285592
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A791BC4F;
	Sat, 13 Apr 2024 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4tNsFmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650C18C3B;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978479; cv=none; b=MbHGdUS0gsZOAPnLevQEwzWFhDFwm1x64eLc4mm/UbS1wrwmnwzqc7VxQdIOUwxHKtKDj7i+6LTmDlqNXsHqRZT1THCcKvjvA9Uy6T7KSykWCcn1QLLF/SR9gpp6CzCsQ9s3eHBgJ8iWSJuLGg82eIevHfvbtZzDXBzYi5xZwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978479; c=relaxed/simple;
	bh=LSTQS1jCmRiEC4tiO7v3NXMYOamxlz/jPnU0IpgMQMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC+7nd+os8a8UV+PuystHeXIu7FBmgEbvDgJZ4/e4/TIlo05RdqCJup25p3MyrN5upHFQkEfwws4kFvgOvAfiWtUhiMtvg0j36yGTCiHWFrBo7uzTyzEo7pmlAn9339ooNPlKYFXURXdeQQXIY2Rm0gSrQXpzA3/2O2ixxe5dTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4tNsFmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7418C32783;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712978478;
	bh=LSTQS1jCmRiEC4tiO7v3NXMYOamxlz/jPnU0IpgMQMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4tNsFmqSJzCK0e1NHp++YXEAGAkZk0ln9Z7UklcW7eNBbLmwYIAcCAHaUjVv9Pih
	 X+KiROKP27xEouI0hAHFpFXePJ3qmnnHbiw7iUcv4+9pRYfvP0VvKnIUiFf1LmzmB8
	 Rsl5MVd0rTUQ9h39rBSeLKo5GExrbRq4leIdeHF2gH+TvhbX4wGSxG6n9swh+C+U9a
	 MKKDFtg72dr5McFm+FbBEW9i0oe6D9lIfu9E6UMEQ4EgHGUpfbVWNgFWzN95yQc6/c
	 mAyZwDk1yFoajqoSs0EkL5G1ivYJ1iJMaWM75+VQC1uXhyJPX0Wh2HUhzN4s0ms3GD
	 Bxvf5NhqD2goQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 2/3] crypto: x86/aes-xts - eliminate a few more instructions
Date: Fri, 12 Apr 2024 20:17:27 -0700
Message-ID: <20240413031728.159495-3-ebiggers@kernel.org>
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

- For conditionally subtracting 16 from LEN when decrypting a message
  whose length isn't a multiple of 16, use the cmovnz instruction.

- Fold the addition of 4*VL to LEN into the sub of VL or 16 from LEN.

- Remove an unnecessary test instruction.

This results in slightly shorter code, both source and binary.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes-xts-avx-x86_64.S | 39 ++++++++++------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-avx-x86_64.S
index f5e7ab739105..802d3b90d337 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -557,24 +557,24 @@
 .endm
 
 .macro	_aes_xts_crypt	enc
 	_define_aliases
 
-	// Load the AES key length: 16 (AES-128), 24 (AES-192), or 32 (AES-256).
-	movl		480(KEY), KEYLEN
-
 .if !\enc
 	// When decrypting a message whose length isn't a multiple of the AES
 	// block length, exclude the last full block from the main loop by
 	// subtracting 16 from LEN.  This is needed because ciphertext stealing
 	// decryption uses the last two tweaks in reverse order.  We'll handle
 	// the last full block and the partial block specially at the end.
+	lea		-16(LEN), %rax
 	test		$15, LEN
-	jnz		.Lneed_cts_dec\@
-.Lxts_init\@:
+	cmovnz		%rax, LEN
 .endif
 
+	// Load the AES key length: 16 (AES-128), 24 (AES-192), or 32 (AES-256).
+	movl		480(KEY), KEYLEN
+
 	// Setup the pointer to the round keys and cache as many as possible.
 	_setup_round_keys	\enc
 
 	// Compute the first set of tweaks TWEAK[0-3].
 	_compute_first_set_of_tweaks
@@ -659,15 +659,14 @@
 	vzeroupper
 .endif
 	RET
 
 .Lhandle_remainder\@:
-	add		$4*VL, LEN	// Undo the extra sub from earlier.
 
 	// En/decrypt any remaining full blocks, one vector at a time.
 .if VL > 16
-	sub		$VL, LEN
+	add		$3*VL, LEN	// Undo extra sub of 4*VL, then sub VL.
 	jl		.Lvec_at_a_time_done\@
 .Lvec_at_a_time\@:
 	_vmovdqu	(SRC), V0
 	_aes_crypt	\enc, , TWEAK0, V0
 	_vmovdqu	V0, (DST)
@@ -675,13 +674,13 @@
 	add		$VL, SRC
 	add		$VL, DST
 	sub		$VL, LEN
 	jge		.Lvec_at_a_time\@
 .Lvec_at_a_time_done\@:
-	add		$VL-16, LEN	// Undo the extra sub from earlier.
+	add		$VL-16, LEN	// Undo extra sub of VL, then sub 16.
 .else
-	sub		$16, LEN
+	add		$4*VL-16, LEN	// Undo extra sub of 4*VL, then sub 16.
 .endif
 
 	// En/decrypt any remaining full blocks, one at a time.
 	jl		.Lblock_at_a_time_done\@
 .Lblock_at_a_time\@:
@@ -692,28 +691,16 @@
 	add		$16, SRC
 	add		$16, DST
 	sub		$16, LEN
 	jge		.Lblock_at_a_time\@
 .Lblock_at_a_time_done\@:
-	add		$16, LEN	// Undo the extra sub from earlier.
-
-.Lfull_blocks_done\@:
-	// Now 0 <= LEN <= 15.  If LEN is nonzero, do ciphertext stealing to
-	// process the last 16 + LEN bytes.  If LEN is zero, we're done.
-	test		LEN, LEN
-	jnz		.Lcts\@
-	jmp		.Ldone\@
-
-.if !\enc
-.Lneed_cts_dec\@:
-	sub		$16, LEN
-	jmp		.Lxts_init\@
-.endif
+	add		$16, LEN	// Undo the extra sub of 16.
+	// Now 0 <= LEN <= 15.  If LEN is zero, we're done.
+	jz		.Ldone\@
 
-.Lcts\@:
-	// Do ciphertext stealing (CTS) to en/decrypt the last full block and
-	// the partial block.  TWEAK0_XMM contains the next tweak.
+	// Otherwise 1 <= LEN <= 15, but the real remaining length is 16 + LEN.
+	// Do ciphertext stealing to process the last 16 + LEN bytes.
 
 .if \enc
 	// If encrypting, the main loop already encrypted the last full block to
 	// create the CTS intermediate ciphertext.  Prepare for the rest of CTS
 	// by rewinding the pointers and loading the intermediate ciphertext.
-- 
2.44.0


