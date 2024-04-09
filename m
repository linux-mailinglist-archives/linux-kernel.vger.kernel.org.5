Return-Path: <linux-kernel+bounces-136880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D789D958
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8948B1F2356E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374112E1E0;
	Tue,  9 Apr 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHiYsDwG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CF12D748;
	Tue,  9 Apr 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666649; cv=none; b=NCLGSvZxpa2Ibs9uDaKfIfoFcLZpLIst+Al8lw9CUqVVurPQ/18rjH1rPRNTUu7NkU6qgDNdrgY4FXkyu7EUpjK7qY+sl3i+JMurx/aqAUz2vz4SuktNBOP3aF4qOV3CiyzNZ6z4N8sIcu2iFAfpMoMMR9DJjmIWlYmCpCO2ndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666649; c=relaxed/simple;
	bh=OEEVk8vQIWgxEd5k50yk4jBZXqyGIckJ1aq747YlYQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEB9G3moJn6OKabPZknXAOJOhNZkkxnujjpNvwXMfeO2IthlgQljyig0j2ZFEBEHDWXtAuURyjKZBuqRu6F1GT/KTrftrnCF5RZqkrCwfDf9Aeu818q8F2QJKrTwcK241MEnEHye2Da8vST0PCIukBZkqs1WsscvEnMJCDScIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHiYsDwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEEFC43390;
	Tue,  9 Apr 2024 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712666648;
	bh=OEEVk8vQIWgxEd5k50yk4jBZXqyGIckJ1aq747YlYQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHiYsDwGat0m/RITmeyA9h36YhV1IQESQUD0T3OHgVUuxgW6xtmoKVR9P6tQKD43j
	 sbvlMvYKT7MXSNDZkjVzudg/cJY2Gg+vmLy9un3GnJrNGi661QO6sM6wW8o4J54A3C
	 IfcTA71toCF3dNKfSLAnLDbT04r8a3C5dURUvnFFHDTTOfaCWjncT0m+6B+js14zR6
	 T14MvV9uFJBdRy8SAWI0+4RfA4jwuTcOWnpod7CxU67IPyMrhcVCZBnPsfiPbyjpbC
	 3I7Hc0rRkLo2RdWcOCZDrZoOddZldSqa/0DufsIzTvUIzfFslO8uCNlnCGGdfv3Pfs
	 eLt1muFcMOw3A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Stefan Kanthak <stefan.kanthak@nexgo.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: x86/sha256-ni - convert to use rounds macros
Date: Tue,  9 Apr 2024 08:42:15 -0400
Message-ID: <20240409124216.9261-2-ebiggers@kernel.org>
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

To avoid source code duplication, do the SHA-256 rounds using macros.
This reduces the length of sha256_ni_asm.S by 148 lines while still
producing the exact same object file.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/sha256_ni_asm.S | 216 +++++---------------------------
 1 file changed, 34 insertions(+), 182 deletions(-)

diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 537b6dcd7ed8..e485520e3b49 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -74,23 +74,50 @@
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
+.macro do_16rounds	i
+	do_4rounds	(\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
+	do_4rounds	(\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
+	do_4rounds	(\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
+	do_4rounds	(\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
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
@@ -123,189 +150,14 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
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
+	do_16rounds	0
+	do_16rounds	16
+	do_16rounds	32
+	do_16rounds	48
 
 	/* Add current hash values with previously saved */
 	paddd		ABEF_SAVE, STATE0
 	paddd		CDGH_SAVE, STATE1
 
-- 
2.44.0


