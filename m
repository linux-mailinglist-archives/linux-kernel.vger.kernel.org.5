Return-Path: <linux-kernel+bounces-141316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA998A1C87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3CA1F22D48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191FD78C7D;
	Thu, 11 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy0r+0S7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1839FD5;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852745; cv=none; b=LaEjd71QHF3EaqrhFrxb4JpY7GPYgsWM+aBSvJAh5yPy/gTNC23qKTa6wqs2VuQQvPIbVB63kiNGAgCAwrjaQJOAlHbT03a86seEq3Dmg5I2Snuc0YulaSCal++YQ3Bf36WNFopemw/51qpLG+YTCUIH5PXsUG+9BDL5ebTjwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852745; c=relaxed/simple;
	bh=ybCUIXPNlE2ccFVuwilfNZMMLqA8i2CCsAuoUnxb8ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwK2sxkqVTRlILOvk4lKQjXo9sPu6N7bS78d8DMDC/nSgiHDobCJRoatLRpHDMzoGc3hQmGxBaKPpLJAdkgG0wvUdd8bdonMP8p9ee7/X6kWBpr9T2GdH/Q22SAknrO2uT6stfyXZ06JCpTQYALkZXreimqY14jQAA0Xt5VeCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy0r+0S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E13AC2BD10;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852745;
	bh=ybCUIXPNlE2ccFVuwilfNZMMLqA8i2CCsAuoUnxb8ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy0r+0S7Ig8s8KoGcJB4xrta4g4/SXKev2W4UfeR+D8c4h235pHw7Uj9zdycpuI50
	 UCZ2Hy48ur9zZk2YgeH8Bfi79B/H1JMynR7xL68rF2JnSH2W+KHzKlLPlRjPTNgygs
	 ZcvloBRklELIgBO5+Azjd7TpiFCplFLJYadwCdJGeic30nMK/+I2PrqkaVUbzJdx+/
	 4IgReIvt3R6gv8OfN5aOV6D42pizivCkIiXeFw6e6co8DPiKdXaSsB5aIGkKoVmvJQ
	 o6qsUNfCFdHQmPXR+13MlzstqaMHly6WyzccUxgdjrLafi6xCStgtmw7c2czO26W5r
	 DEHKI0bJkW5Eg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: [PATCH v2 2/4] crypto: x86/sha256-ni - rename some register aliases
Date: Thu, 11 Apr 2024 09:23:57 -0700
Message-ID: <20240411162359.39073-3-ebiggers@kernel.org>
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

MSGTMP[0-3] are used to hold the message schedule and are not temporary
registers per se.  MSGTMP4 is used as a temporary register for several
different purposes and isn't really related to MSGTMP[0-3].  Rename them
to MSG[0-3] and TMP accordingly.

Also add a comment that clarifies what MSG is.

Suggested-by: Stefan Kanthak <stefan.kanthak@nexgo.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/sha256_ni_asm.S | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 498f67727b94..b7e7001dafdf 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -60,18 +60,18 @@
 #define DATA_PTR	%rsi	/* 2nd arg */
 #define NUM_BLKS	%rdx	/* 3rd arg */
 
 #define SHA256CONSTANTS	%rax
 
-#define MSG		%xmm0
+#define MSG		%xmm0  /* sha256rnds2 implicit operand */
 #define STATE0		%xmm1
 #define STATE1		%xmm2
-#define MSGTMP0		%xmm3
-#define MSGTMP1		%xmm4
-#define MSGTMP2		%xmm5
-#define MSGTMP3		%xmm6
-#define MSGTMP4		%xmm7
+#define MSG0		%xmm3
+#define MSG1		%xmm4
+#define MSG2		%xmm5
+#define MSG3		%xmm6
+#define TMP		%xmm7
 
 #define SHUF_MASK	%xmm8
 
 #define ABEF_SAVE	%xmm9
 #define CDGH_SAVE	%xmm10
@@ -85,13 +85,13 @@
 	movdqa		\m0, MSG
 .endif
 	paddd		\i*4(SHA256CONSTANTS), MSG
 	sha256rnds2	STATE0, STATE1
 .if \i >= 12 && \i < 60
-	movdqa		\m0, MSGTMP4
-	palignr		$4, \m3, MSGTMP4
-	paddd		MSGTMP4, \m1
+	movdqa		\m0, TMP
+	palignr		$4, \m3, TMP
+	paddd		TMP, \m1
 	sha256msg2	\m0, \m1
 .endif
 	pshufd 		$0x0E, MSG, MSG
 	sha256rnds2	STATE1, STATE0
 .if \i >= 4 && \i < 52
@@ -131,27 +131,27 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	movdqu		0*16(DIGEST_PTR), STATE0
 	movdqu		1*16(DIGEST_PTR), STATE1
 
 	pshufd		$0xB1, STATE0,  STATE0		/* CDAB */
 	pshufd		$0x1B, STATE1,  STATE1		/* EFGH */
-	movdqa		STATE0, MSGTMP4
+	movdqa		STATE0, TMP
 	palignr		$8, STATE1,  STATE0		/* ABEF */
-	pblendw		$0xF0, MSGTMP4, STATE1		/* CDGH */
+	pblendw		$0xF0, TMP, STATE1		/* CDGH */
 
 	movdqa		PSHUFFLE_BYTE_FLIP_MASK(%rip), SHUF_MASK
 	lea		K256(%rip), SHA256CONSTANTS
 
 .Lloop0:
 	/* Save hash values for addition after rounds */
 	movdqa		STATE0, ABEF_SAVE
 	movdqa		STATE1, CDGH_SAVE
 
 .irp i, 0, 16, 32, 48
-	do_4rounds	(\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
-	do_4rounds	(\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
-	do_4rounds	(\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
-	do_4rounds	(\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
+	do_4rounds	(\i + 0),  MSG0, MSG1, MSG2, MSG3
+	do_4rounds	(\i + 4),  MSG1, MSG2, MSG3, MSG0
+	do_4rounds	(\i + 8),  MSG2, MSG3, MSG0, MSG1
+	do_4rounds	(\i + 12), MSG3, MSG0, MSG1, MSG2
 .endr
 
 	/* Add current hash values with previously saved */
 	paddd		ABEF_SAVE, STATE0
 	paddd		CDGH_SAVE, STATE1
@@ -162,13 +162,13 @@ SYM_TYPED_FUNC_START(sha256_ni_transform)
 	jne		.Lloop0
 
 	/* Write hash values back in the correct order */
 	pshufd		$0x1B, STATE0,  STATE0		/* FEBA */
 	pshufd		$0xB1, STATE1,  STATE1		/* DCHG */
-	movdqa		STATE0, MSGTMP4
+	movdqa		STATE0, TMP
 	pblendw		$0xF0, STATE1,  STATE0		/* DCBA */
-	palignr		$8, MSGTMP4, STATE1		/* HGFE */
+	palignr		$8, TMP, STATE1			/* HGFE */
 
 	movdqu		STATE0, 0*16(DIGEST_PTR)
 	movdqu		STATE1, 1*16(DIGEST_PTR)
 
 .Ldone_hash:
-- 
2.44.0


