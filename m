Return-Path: <linux-kernel+bounces-141317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFA8A1C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5E21F23CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320378C86;
	Thu, 11 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFV62PX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EA3B182;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852745; cv=none; b=MdhJOt9lEpGvkUFyST70NilJ/jVYBZP03mbbHNNTbbRQg1Gwx+39oWPDQt3NqI8a37HeFX45MEUQQ7L52/FxQnsbDRiEctqvriiWe0Im1T3aR8QWwtv+5mIm+tQhbe6gvTTt4RWgiLCKnKt6Qv34c0AIl6tcATDvY/RhBS5vwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852745; c=relaxed/simple;
	bh=ZzfV+EqcBie72foxnU6KRYOCGyM6B01njeHXtkgYybc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1jJdqswbUxAH6xtwSCbvozQpE0meRGyNyxgKxXa12Vw1dOPU/vH7BWefhGaKh5rHfL/mYuu19PCbh7eqll3suze4s71jJL4yJUA0sDgb3YsaCWShPZX+5HGmMV5xXyG3rIsLY5kRs5SjZUEp6YlS5eQH7Jj2WWs7DlBLrHJuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFV62PX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D8C2BBFC;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852745;
	bh=ZzfV+EqcBie72foxnU6KRYOCGyM6B01njeHXtkgYybc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFV62PX29RmMjKa3NzIcILdjgk/KHlbOztnGagt1jHkHCycv5Biyfrvn6ulX3wI6E
	 9vL6ODjD/PbETVJJ/uANKykXhAjZEZiOeIHNC+6nJSzDTOta1bkXu3yh8Tg7PCdP78
	 7dpysnZcWYiBe3e+coGfIGSNqB0UGOeizvHukmbsFAa0f82Bnrvumrmp76SMs/HNEZ
	 rMUkMWK/p81YRVPcQ5hZzSlYXoHDtv1tRHlgSTjGCSd8eADAhxnejwIaQcHlujhqrG
	 tXVyz3iNhHeiW3IfdFlizrbj5gt9fFCsisAsuS2Wzy8cKYVKRr94FH0B+cjFBnQqx2
	 2coZWUXyab2IA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: [PATCH v2 3/4] crypto: x86/sha256-ni - optimize code size
Date: Thu, 11 Apr 2024 09:23:58 -0700
Message-ID: <20240411162359.39073-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411162359.39073-1-ebiggers@kernel.org>
References: <20240411162359.39073-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

- Load the SHA-256 round constants relative to a pointer that points
  into the middle of the constants rather than to the beginning.  Since
  x86 instructions use signed offsets, this decreases the instruction
  length required to access some of the later round constants.

- Use punpcklqdq or punpckhqdq instead of longer instructions such as
  pshufd, pblendw, and palignr.  This doesn't harm performance.

The end result is that sha256_ni_transform shrinks from 839 bytes to 791
bytes, with no loss in performance.

Suggested-by: Stefan Kanthak <stefan.kanthak@nexgo.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/sha256_ni_asm.S | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index b7e7001dafdf..ffc9f1c75c15 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -82,19 +82,19 @@
 	pshufb		SHUF_MASK, MSG
 	movdqa		MSG, \m0
 .else
 	movdqa		\m0, MSG
 .endif
-	paddd		\i*4(SHA256CONSTANTS), MSG
+	paddd		(\i-32)*4(SHA256CONSTANTS), MSG
 	sha256rnds2	STATE0, STATE1
 .if \i >= 12 && \i < 60
 	movdqa		\m0, TMP
 	palignr		$4, \m3, TMP
 	paddd		TMP, \m1
 	sha256msg2	\m0, \m1
 .endif
-	pshufd 		$0x0E, MSG, MSG
+	punpckhqdq	MSG, MSG
 	sha256rnds2	STATE1, STATE0
 .if \i >= 4 && \i < 52
 	sha256msg1	\m0, \m3
 .endif
 .endm
@@ -126,21 +126,21 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	/*
 	 * load initial hash values
 	 * Need to reorder these appropriately
 	 * DCBA, HGFE -> ABEF, CDGH
 	 */
-	movdqu		0*16(DIGEST_PTR), STATE0
-	movdqu		1*16(DIGEST_PTR), STATE1
+	movdqu		0*16(DIGEST_PTR), STATE0	/* DCBA */
+	movdqu		1*16(DIGEST_PTR), STATE1	/* HGFE */
 
-	pshufd		$0xB1, STATE0,  STATE0		/* CDAB */
-	pshufd		$0x1B, STATE1,  STATE1		/* EFGH */
 	movdqa		STATE0, TMP
-	palignr		$8, STATE1,  STATE0		/* ABEF */
-	pblendw		$0xF0, TMP, STATE1		/* CDGH */
+	punpcklqdq	STATE1, STATE0			/* FEBA */
+	punpckhqdq	TMP, STATE1			/* DCHG */
+	pshufd		$0x1B, STATE0, STATE0		/* ABEF */
+	pshufd		$0xB1, STATE1, STATE1		/* CDGH */
 
 	movdqa		PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
-	lea		K256(%rip), SHA256CONSTANTS
+	lea		K256+32*4(%rip), SHA256CONSTANTS
 
 .Lloop0:
 	/* Save hash values for addition after rounds */
 	movdqa		STATE0, ABEF_SAVE
 	movdqa		STATE1, CDGH_SAVE
@@ -160,18 +160,18 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	add		$64, DATA_PTR
 	cmp		NUM_BLKS, DATA_PTR
 	jne		.Lloop0
 
 	/* Write hash values back in the correct order */
-	pshufd		$0x1B, STATE0,  STATE0		/* FEBA */
-	pshufd		$0xB1, STATE1,  STATE1		/* DCHG */
 	movdqa		STATE0, TMP
-	pblendw		$0xF0, STATE1,  STATE0		/* DCBA */
-	palignr		$8, TMP, STATE1			/* HGFE */
+	punpcklqdq	STATE1, STATE0			/* GHEF */
+	punpckhqdq	TMP, STATE1			/* ABCD */
+	pshufd		$0xB1, STATE0, STATE0		/* HGFE */
+	pshufd		$0x1B, STATE1, STATE1		/* DCBA */
 
-	movdqu		STATE0, 0*16(DIGEST_PTR)
-	movdqu		STATE1, 1*16(DIGEST_PTR)
+	movdqu		STATE1, 0*16(DIGEST_PTR)
+	movdqu		STATE0, 1*16(DIGEST_PTR)
 
 .Ldone_hash:
 
 	RET
 SYM_FUNC_END(sha256_ni_transform)
-- 
2.44.0


