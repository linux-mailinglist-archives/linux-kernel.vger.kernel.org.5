Return-Path: <linux-kernel+bounces-141315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060A8A1C89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24A51C238A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690278C73;
	Thu, 11 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr+l+LH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDB39852;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852745; cv=none; b=SlpPqhn2K3O5j4BkJQprBBa3mxZD/hUjlnWOvm82II5VaCePzwYq8nFVXd3mUrd2m5Ndec4AWrkSRZ3+JCCpXnAZ5CD9zZUKOPdjmlU02nhTx/NgHP5JWhO2Df5VU5pi5MX7s1Xo8zItsxwnnZS9v7rOqX2e5efok4TK3of0/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852745; c=relaxed/simple;
	bh=eXsDIArs6R5/jsyxwL5zTJAABCCAYPruwqOVMEDiLPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm9KwcIA9aTXLVv8iECPsX3FhOiE5MEc/k27V2qk5lY3ZjOv6zm8XmGN0SwEnKE4sDn4g6ThWiVrrDcPsXqRlkggi0iGnyvMbQUsnrjkCSbiofkKw8L0BqkAVjCZILXKDCwNBxzgVBJvKvXfTQeJ7IjUZKWjZ8HBVSpq6hF73cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr+l+LH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0877C113CE;
	Thu, 11 Apr 2024 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852744;
	bh=eXsDIArs6R5/jsyxwL5zTJAABCCAYPruwqOVMEDiLPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cr+l+LH4m/4IXUA5EJnO5drYzGgurAjyrwBYaKQfqK7ki2HuLHAOhyby3jSfAD33r
	 T8dMJ2FxuI/oRyYNIDsq9F6MBmlG/t80T2Pps02rw9gFhSmrqz8az/fdODh+7wSmJJ
	 PtmcChBNdyNIQt7cSVO0vY4uu8WXSIBhtq4P41qojjpIKWtQ6ndsSlbgXEi1+QxoX/
	 QBCALeOGLwShRt3/Hou49KLr7BVjmhFsxZ0XFB/JQ9dCaAICUQM6Z2Pu57w9Z8HjBc
	 VTIEhVpnqByWPAnwaEAKHCIGGFktH9xRNVJtbIMYN/GPsNUpoHD8g5PoFuZEmkiwhY
	 18Vv/7Tb9KnQQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: [PATCH v2 1/4] crypto: x86/sha256-ni - convert to use rounds macros
Date: Thu, 11 Apr 2024 09:23:56 -0700
Message-ID: <20240411162359.39073-2-ebiggers@kernel.org>
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

To avoid source code duplication, do the SHA-256 rounds using macros.
This reduces the length of sha256_ni_asm.S by 153 lines while still
producing the exact same object file.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/sha256_ni_asm.S | 211 +++++---------------------------
 1 file changed, 29 insertions(+), 182 deletions(-)

diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 537b6dcd7ed8..498f67727b94 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -74,23 +74,43 @@
 #define SHUF_MASK	%xmm8
 
 #define ABEF_SAVE	%xmm9
 #define CDGH_SAVE	%xmm10
 
+.macro do_4rounds	i, m0, m1, m2, m3
+.if \i < 16
+	movdqu		\i*4(DATA_PTR), MSG
+	pshufb		SHUF_MASK, MSG
+	movdqa		MSG, \m0
+.else
+	movdqa		\m0, MSG
+.endif
+	paddd		\i*4(SHA256CONSTANTS), MSG
+	sha256rnds2	STATE0, STATE1
+.if \i >= 12 && \i < 60
+	movdqa		\m0, MSGTMP4
+	palignr		$4, \m3, MSGTMP4
+	paddd		MSGTMP4, \m1
+	sha256msg2	\m0, \m1
+.endif
+	pshufd 		$0x0E, MSG, MSG
+	sha256rnds2	STATE1, STATE0
+.if \i >= 4 && \i < 52
+	sha256msg1	\m0, \m3
+.endif
+.endm
+
 /*
  * Intel SHA Extensions optimized implementation of a SHA-256 update function
  *
  * The function takes a pointer to the current hash values, a pointer to the
  * input data, and a number of 64 byte blocks to process.  Once all blocks have
  * been processed, the digest pointer is  updated with the resulting hash value.
  * The function only processes complete blocks, there is no functionality to
  * store partial blocks.  All message padding and hash value initialization must
  * be done outside the update function.
  *
- * The indented lines in the loop are instructions related to rounds processing.
- * The non-indented lines are instructions related to the message schedule.
- *
  * void sha256_ni_transform(uint32_t *digest, const void *data,
 		uint32_t numBlocks);
  * digest : pointer to digest
  * data: pointer to input data
  * numBlocks: Number of blocks to process
@@ -123,189 +143,16 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 .Lloop0:
 	/* Save hash values for addition after rounds */
 	movdqa		STATE0, ABEF_SAVE
 	movdqa		STATE1, CDGH_SAVE
 
-	/* Rounds 0-3 */
-	movdqu		0*16(DATA_PTR), MSG
-	pshufb		SHUF_MASK, MSG
-	movdqa		MSG, MSGTMP0
-		paddd		0*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-
-	/* Rounds 4-7 */
-	movdqu		1*16(DATA_PTR), MSG
-	pshufb		SHUF_MASK, MSG
-	movdqa		MSG, MSGTMP1
-		paddd		1*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP1, MSGTMP0
-
-	/* Rounds 8-11 */
-	movdqu		2*16(DATA_PTR), MSG
-	pshufb		SHUF_MASK, MSG
-	movdqa		MSG, MSGTMP2
-		paddd		2*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP2, MSGTMP1
-
-	/* Rounds 12-15 */
-	movdqu		3*16(DATA_PTR), MSG
-	pshufb		SHUF_MASK, MSG
-	movdqa		MSG, MSGTMP3
-		paddd		3*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP3, MSGTMP4
-	palignr		$4, MSGTMP2, MSGTMP4
-	paddd		MSGTMP4, MSGTMP0
-	sha256msg2	MSGTMP3, MSGTMP0
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP3, MSGTMP2
-
-	/* Rounds 16-19 */
-	movdqa		MSGTMP0, MSG
-		paddd		4*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP0, MSGTMP4
-	palignr		$4, MSGTMP3, MSGTMP4
-	paddd		MSGTMP4, MSGTMP1
-	sha256msg2	MSGTMP0, MSGTMP1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP0, MSGTMP3
-
-	/* Rounds 20-23 */
-	movdqa		MSGTMP1, MSG
-		paddd		5*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP1, MSGTMP4
-	palignr		$4, MSGTMP0, MSGTMP4
-	paddd		MSGTMP4, MSGTMP2
-	sha256msg2	MSGTMP1, MSGTMP2
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP1, MSGTMP0
-
-	/* Rounds 24-27 */
-	movdqa		MSGTMP2, MSG
-		paddd		6*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP2, MSGTMP4
-	palignr		$4, MSGTMP1, MSGTMP4
-	paddd		MSGTMP4, MSGTMP3
-	sha256msg2	MSGTMP2, MSGTMP3
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP2, MSGTMP1
-
-	/* Rounds 28-31 */
-	movdqa		MSGTMP3, MSG
-		paddd		7*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP3, MSGTMP4
-	palignr		$4, MSGTMP2, MSGTMP4
-	paddd		MSGTMP4, MSGTMP0
-	sha256msg2	MSGTMP3, MSGTMP0
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP3, MSGTMP2
-
-	/* Rounds 32-35 */
-	movdqa		MSGTMP0, MSG
-		paddd		8*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP0, MSGTMP4
-	palignr		$4, MSGTMP3, MSGTMP4
-	paddd		MSGTMP4, MSGTMP1
-	sha256msg2	MSGTMP0, MSGTMP1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP0, MSGTMP3
-
-	/* Rounds 36-39 */
-	movdqa		MSGTMP1, MSG
-		paddd		9*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP1, MSGTMP4
-	palignr		$4, MSGTMP0, MSGTMP4
-	paddd		MSGTMP4, MSGTMP2
-	sha256msg2	MSGTMP1, MSGTMP2
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP1, MSGTMP0
-
-	/* Rounds 40-43 */
-	movdqa		MSGTMP2, MSG
-		paddd		10*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP2, MSGTMP4
-	palignr		$4, MSGTMP1, MSGTMP4
-	paddd		MSGTMP4, MSGTMP3
-	sha256msg2	MSGTMP2, MSGTMP3
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP2, MSGTMP1
-
-	/* Rounds 44-47 */
-	movdqa		MSGTMP3, MSG
-		paddd		11*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP3, MSGTMP4
-	palignr		$4, MSGTMP2, MSGTMP4
-	paddd		MSGTMP4, MSGTMP0
-	sha256msg2	MSGTMP3, MSGTMP0
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP3, MSGTMP2
-
-	/* Rounds 48-51 */
-	movdqa		MSGTMP0, MSG
-		paddd		12*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP0, MSGTMP4
-	palignr		$4, MSGTMP3, MSGTMP4
-	paddd		MSGTMP4, MSGTMP1
-	sha256msg2	MSGTMP0, MSGTMP1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-	sha256msg1	MSGTMP0, MSGTMP3
-
-	/* Rounds 52-55 */
-	movdqa		MSGTMP1, MSG
-		paddd		13*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP1, MSGTMP4
-	palignr		$4, MSGTMP0, MSGTMP4
-	paddd		MSGTMP4, MSGTMP2
-	sha256msg2	MSGTMP1, MSGTMP2
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-
-	/* Rounds 56-59 */
-	movdqa		MSGTMP2, MSG
-		paddd		14*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-	movdqa		MSGTMP2, MSGTMP4
-	palignr		$4, MSGTMP1, MSGTMP4
-	paddd		MSGTMP4, MSGTMP3
-	sha256msg2	MSGTMP2, MSGTMP3
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
-
-	/* Rounds 60-63 */
-	movdqa		MSGTMP3, MSG
-		paddd		15*16(SHA256CONSTANTS), MSG
-		sha256rnds2	STATE0, STATE1
-		pshufd 		$0x0E, MSG, MSG
-		sha256rnds2	STATE1, STATE0
+.irp i, 0, 16, 32, 48
+	do_4rounds	(\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
+	do_4rounds	(\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
+	do_4rounds	(\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
+	do_4rounds	(\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
+.endr
 
 	/* Add current hash values with previously saved */
 	paddd		ABEF_SAVE, STATE0
 	paddd		CDGH_SAVE, STATE1
 
-- 
2.44.0


