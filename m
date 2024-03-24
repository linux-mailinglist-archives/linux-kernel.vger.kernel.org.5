Return-Path: <linux-kernel+bounces-116191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCD889D70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CD1F36C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090283BA336;
	Mon, 25 Mar 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myp0yT1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224228453C;
	Sun, 24 Mar 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323788; cv=none; b=kDyKSX+Jwf7pg9owMsCHfykKTb3DeRh+65WjbAHgxJUKXhAmHCWyIo31l93srZvdtUzzvsbP4bQpd0d/5W8GbyoEM8fkYh+2yyYsnH8M6eEMlVlSj5KBToFvDgbFZq+8l80GcEl/RnbkJTw7YSI/4E90nt/CkrKRpWUCyHKJPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323788; c=relaxed/simple;
	bh=zgQrOjZW4qBjJzPmkQSm5dt0f2A5Yy9lx+0k9g5jAnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhYCh1Y/zOxX/Z1ODINuOagiOMmYrFiypgK23Ta8FJlyqR3anBrOdcyU1qaFQ4tgbr6ENREomCd3DoKnbvMik2SX/I+cUvYI+NkNVLx5Sc1XkA14XYZbRsinn5SP5SlIEOTpG5Kl9X2t8CyRpazelZ1vDgYfoPym2XcfW+Cyvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myp0yT1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D24C433C7;
	Sun, 24 Mar 2024 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323788;
	bh=zgQrOjZW4qBjJzPmkQSm5dt0f2A5Yy9lx+0k9g5jAnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Myp0yT1fG4nNR8ktFs52zZZss+KuNv13mr8sjIAKave+wz4iNU7RPTBUpoT8nVYBF
	 12Wg7k8+p9sxIIVtQ+As0MEX3/0zIY9p0mwm9Yk3wyOMGAXF30NETbI9UIrk633pF8
	 DyZkj5jG11Il1M0TyJ+DE6FdFG7rQHqeRR2KHcDoPKtlknova/qu0wNvxCwmI/WpW9
	 79wY4bffI1sB2X8KHMUfhHBsTJevtdOXIQ5XoId/f8ohLHgW9rosBHIP5yyvlYOieo
	 zo2Q0v2MXMKW8yCg3/Gk9pPDlVTJOT3vq1PIcM+F4DnZuUlCoOSxRcMG/6RuBQ7lRq
	 AKZVJKIA1RdSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 165/238] crypto: arm/sha - fix function cast warnings
Date: Sun, 24 Mar 2024 19:39:13 -0400
Message-ID: <20240324234027.1354210-166-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 53cc9baeb9bc2a187eb9c9790d30995148852b12 ]

clang-16 warns about casting between incompatible function types:

arch/arm/crypto/sha256_glue.c:37:5: error: cast from 'void (*)(u32 *, const void *, unsigned int)' (aka 'void (*)(unsigned int *, const void *, unsigned int)') to 'sha256_block_fn *' (aka 'void (*)(struct sha256_state *, const unsigned char *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   37 |                                 (sha256_block_fn *)sha256_block_data_order);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm/crypto/sha512-glue.c:34:3: error: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   34 |                 (sha512_block_fn *)sha512_block_data_order);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix the prototypes for the assembler functions to match the typedef.
The code already relies on the digest being the first part of the
state structure, so there is no change in behavior.

Fixes: c80ae7ca3726 ("crypto: arm/sha512 - accelerated SHA-512 using ARM generic ASM and NEON")
Fixes: b59e2ae3690c ("crypto: arm/sha256 - move SHA-224/256 ASM/NEON implementation to base layer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/sha256_glue.c | 13 +++++--------
 arch/arm/crypto/sha512-glue.c | 12 +++++-------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index b8a4f79020cf8..e36b86778468e 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -24,8 +24,8 @@
 
 #include "sha256_glue.h"
 
-asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
-					unsigned int num_blks);
+asmlinkage void sha256_block_data_order(struct sha256_state *state,
+					const u8 *data, int num_blks);
 
 int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
@@ -33,23 +33,20 @@ int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 	/* make sure casting to sha256_block_fn() is safe */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	return sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
+	return sha256_base_do_update(desc, data, len, sha256_block_data_order);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_update);
 
 static int crypto_sha256_arm_final(struct shash_desc *desc, u8 *out)
 {
-	sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+	sha256_base_do_finalize(desc, sha256_block_data_order);
 	return sha256_base_finish(desc, out);
 }
 
 int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
 			    unsigned int len, u8 *out)
 {
-	sha256_base_do_update(desc, data, len,
-			      (sha256_block_fn *)sha256_block_data_order);
+	sha256_base_do_update(desc, data, len, sha256_block_data_order);
 	return crypto_sha256_arm_final(desc, out);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_finup);
diff --git a/arch/arm/crypto/sha512-glue.c b/arch/arm/crypto/sha512-glue.c
index 8775aa42bbbe8..1a16b98ec1085 100644
--- a/arch/arm/crypto/sha512-glue.c
+++ b/arch/arm/crypto/sha512-glue.c
@@ -25,27 +25,25 @@ MODULE_ALIAS_CRYPTO("sha512");
 MODULE_ALIAS_CRYPTO("sha384-arm");
 MODULE_ALIAS_CRYPTO("sha512-arm");
 
-asmlinkage void sha512_block_data_order(u64 *state, u8 const *src, int blocks);
+asmlinkage void sha512_block_data_order(struct sha512_state *state,
+					u8 const *src, int blocks);
 
 int sha512_arm_update(struct shash_desc *desc, const u8 *data,
 		      unsigned int len)
 {
-	return sha512_base_do_update(desc, data, len,
-		(sha512_block_fn *)sha512_block_data_order);
+	return sha512_base_do_update(desc, data, len, sha512_block_data_order);
 }
 
 static int sha512_arm_final(struct shash_desc *desc, u8 *out)
 {
-	sha512_base_do_finalize(desc,
-		(sha512_block_fn *)sha512_block_data_order);
+	sha512_base_do_finalize(desc, sha512_block_data_order);
 	return sha512_base_finish(desc, out);
 }
 
 int sha512_arm_finup(struct shash_desc *desc, const u8 *data,
 		     unsigned int len, u8 *out)
 {
-	sha512_base_do_update(desc, data, len,
-		(sha512_block_fn *)sha512_block_data_order);
+	sha512_base_do_update(desc, data, len, sha512_block_data_order);
 	return sha512_arm_final(desc, out);
 }
 
-- 
2.43.0


