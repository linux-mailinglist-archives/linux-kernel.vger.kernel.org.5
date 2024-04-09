Return-Path: <linux-kernel+bounces-136881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A496889D95A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27246B241EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2712EBD4;
	Tue,  9 Apr 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3nXCZZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BC12E1D6;
	Tue,  9 Apr 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666649; cv=none; b=HhFwI3JnVP2U/EKkAHCHOJmcYgwfokQhx9SDmcy4pCyF+gcq9T+r+EluJEcLjoJ76SLHkw2qdSQXRdJx2mwBbCnDlkMBOgQx8OFpd+rv9bQl2pNjAihJQWp7Cfqtg5squIOVCFkrt/Tbo/cOA9M3fSyfspHHlK3p6nQAv2XsZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666649; c=relaxed/simple;
	bh=NRWqtq//XuFFbL2CASYOLSgyi5eKB8/yl5Vbq3TCI5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlEKk98wBJFdWd8f/Hu5RIRWKwgL8yeVwFL7KUgN5JESQnoezCnAOyLu+7NgtfbYaslwS+Wm/JsTb32szHVt8uPYmcUwIedb26RSKKNDVYdBSio4Yfh53X5MRX2WAcI5sFhMsxFSm7hAkKuoy3hDHyid9Bza2ffsPk64oGbZOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3nXCZZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02470C433F1;
	Tue,  9 Apr 2024 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712666649;
	bh=NRWqtq//XuFFbL2CASYOLSgyi5eKB8/yl5Vbq3TCI5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3nXCZZNxfBFFHMWQJaqFKEPnSW4UV5AE0bMyPLCds3R2cxiTrQz2UCyCNdWMZmD1
	 erzK9AC/FK3MMNcrH05df3GrO6fJ4xoiSEFqklmU/96VdXwdRXBfu/0qvZEmIl6z4F
	 a1p6Qf3M7ppT1IvWDTzt+s2XQ4Z2skG6yTQkwO6Wc0p/5AOlby1XMMw8nYSTSPDNkF
	 IiNlkXTU00w7trLFyN9tTzZsSYLhW+4ko+Gw/+hVd0p9HpIsBo0yKnq57ciXtdfrR/
	 rfqXCvBVwPm0DrVd82nHHmDc5j1Atc1HR5j5K1upjBVOnJRyEaPRVqs5DZguuYQuaJ
	 R4JeK5j/OADKw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Stefan Kanthak <stefan.kanthak@nexgo.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] crypto: x86/sha256-ni - optimize code size
Date: Tue,  9 Apr 2024 08:42:16 -0400
Message-ID: <20240409124216.9261-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409124216.9261-1-ebiggers@kernel.org>
References: <20240409124216.9261-1-ebiggers@kernel.org>
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
index e485520e3b49..4d373069448d 100644
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
 	movdqa		\m0, MSGTMP4
 	palignr		$4, \m3, MSGTMP4
 	paddd		MSGTMP4, \m1
 	sha256msg2	\m0, \m1
 .endif
-	pshufd 		$0x0E, MSG, MSG
+	punpckhqdq	MSG, MSG
 	sha256rnds2	STATE1, STATE0
 .if \i >= 4 && \i < 52
 	sha256msg1	\m0, \m3
 .endif
 .endm
@@ -133,21 +133,21 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
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
 	movdqa		STATE0, MSGTMP4
-	palignr		$8, STATE1,  STATE0		/* ABEF */
-	pblendw		$0xF0, MSGTMP4, STATE1		/* CDGH */
+	punpcklqdq	STATE1, STATE0			/* FEBA */
+	punpckhqdq	MSGTMP4, STATE1			/* DCHG */
+	pshufd		$0x1B, STATE0, STATE0		/* ABEF */
+	pshufd		$0xB1, STATE1, STATE1		/* CDGH */
 
 	movdqa		PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
-	lea		K256(%rip), SHA256CONSTANTS
+	lea		K256+32*4(%rip), SHA256CONSTANTS
 
 .Lloop0:
 	/* Save hash values for addition after rounds */
 	movdqa		STATE0, ABEF_SAVE
 	movdqa		STATE1, CDGH_SAVE
@@ -165,18 +165,18 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	add		$64, DATA_PTR
 	cmp		NUM_BLKS, DATA_PTR
 	jne		.Lloop0
 
 	/* Write hash values back in the correct order */
-	pshufd		$0x1B, STATE0,  STATE0		/* FEBA */
-	pshufd		$0xB1, STATE1,  STATE1		/* DCHG */
 	movdqa		STATE0, MSGTMP4
-	pblendw		$0xF0, STATE1,  STATE0		/* DCBA */
-	palignr		$8, MSGTMP4, STATE1		/* HGFE */
+	punpcklqdq	STATE1, STATE0			/* GHEF */
+	punpckhqdq	MSGTMP4, STATE1			/* ABCD */
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


