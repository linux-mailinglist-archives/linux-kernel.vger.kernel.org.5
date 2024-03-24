Return-Path: <linux-kernel+bounces-115244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB5888DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474131F2CA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D256E313E8A;
	Mon, 25 Mar 2024 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAk6ySa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB63297D41;
	Sun, 24 Mar 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324342; cv=none; b=spo4SSWRUveUxtSxAwQzwSWRZUXYWuEWvEyVmI0KICLh0YH0wojyxTibSGTzf1WEh25VhCLh7YF1ptBF7GtGy/bO1ckxKvdpY6l+ss7pHXFP4+cAb5Aa1YmtB1yn3ojxm+YlFuomGL5Ek+Y0am+4hK9D4TJJ4/2UITfJ8SRueUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324342; c=relaxed/simple;
	bh=r+RjWSfVA/ZL2fgpwGCGbqFq5ybAzwUc5uRZndVc73A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPCsWzhrliP7nYwxvSrCrNvWw096nAezGRDKZOz9ziL/QbLJaDZ1IRms9G1fg01I7e6aDtwau3O3Nm8xGvalxa2abp8nSGLQX5qmb8XwQvNCeKMEK3C9Z+HdIIxOO+VVtLFd4J3gVx7szMXezCodYzG2pl1uQ2e7gzJ1diOnX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAk6ySa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D340C433F1;
	Sun, 24 Mar 2024 23:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324341;
	bh=r+RjWSfVA/ZL2fgpwGCGbqFq5ybAzwUc5uRZndVc73A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAk6ySa/RZLXKI1ZLFEQJQ6nRhLoqTlr7bHdgTfZUsr7nIGMSV6An69i/VdrOoo7P
	 29vvCc79TG/f7+eEfqqwofvIB0QEh9JlKacDPDqwE5x/Y2dP7iyfT08I6BfiveGMV2
	 72RahaDyw9dWfNA10N/0M6Gp2jCZHC0zeUx9uFHUFjG+0riOsVZhOSHChyAp9QU/RD
	 4eig9g9XAL4RP4jvCbKweAb5/+JdEkY5XCqwy3pqdVcvNWr1NlWWdVCN6bNrEx9Pg9
	 TPY7dxfaNvGe1x/OF62TY7XI0ztNlD86S2eYvgl/dnI8zSzzjthAApNdpWeCHXN7ac
	 0yn1ggEpSrXjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 111/148] crypto: arm/sha - fix function cast warnings
Date: Sun, 24 Mar 2024 19:49:35 -0400
Message-ID: <20240324235012.1356413-112-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 040c744ef9f50..a46878560d77d 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -30,8 +30,8 @@
 
 #include "sha256_glue.h"
 
-asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
-					unsigned int num_blks);
+asmlinkage void sha256_block_data_order(struct sha256_state *state,
+					const u8 *data, int num_blks);
 
 int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
@@ -39,23 +39,20 @@ int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
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
index 86540cd4a6faa..242d0ef08dfef 100644
--- a/arch/arm/crypto/sha512-glue.c
+++ b/arch/arm/crypto/sha512-glue.c
@@ -28,27 +28,25 @@ MODULE_ALIAS_CRYPTO("sha512");
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
 
 int sha512_arm_final(struct shash_desc *desc, u8 *out)
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


