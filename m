Return-Path: <linux-kernel+bounces-116079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2914C889926
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E9E29E28B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE73A473D;
	Mon, 25 Mar 2024 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE3AVvfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9659177A99;
	Sun, 24 Mar 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323516; cv=none; b=GQGQXhL3kXWvTg4uxQ8fRFB8Gezg5BLVtmU/F6WDVvzTtMLCMrhH2wxkRqrKoKqWEuSyOqRP/KIrUhu+48tRvp7j/9Yuy5GncpTgoEqCjEDBS6UveAnCVyZ4e8CIHx5XwVHgt2dAgv+jJMjtVs+ojKgvLP6O/E8ao9EohFHitmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323516; c=relaxed/simple;
	bh=8NG5ryWG5HYBva078aNyd9BCSi5cg3Cn9gXeZNtAs18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBuhwRmvU7tL2HGxInECJDu2DPupZDVsgtvOowMchqxNZDX0j9ynpF1lZYObDHrjUYzKR+52FW2ENQjXYLNVHkABUCOHmQhhYLwXmlT+wEPEer0JRuaoA2IUBZCR8R+LbSkiXJTWBEB9FtZ9/uWGw/Rk5bzwJNOZz4hXcs1RAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE3AVvfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9ADC433C7;
	Sun, 24 Mar 2024 23:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323515;
	bh=8NG5ryWG5HYBva078aNyd9BCSi5cg3Cn9gXeZNtAs18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE3AVvfHoJTGNNZ4J/qm+HZLesYrNtPSEKQcQ0ytdTHX9ielZhTCkeTBYBgrym+th
	 AwkzGDRU+2PibPsvA4dK/gAc6+QVAYb5qn6rm5tzntUM7w7dv6H2gAimYtn/t2nQxs
	 pK4q/9JpAo/H+Z4hxHV7uwkueolztQVV3h4+lj40kjFwDeRJzHiQYbR3TFKUB303SP
	 83rHUxrxxHMOlqUZ+7GtXyprj2ENHq9MrdzKJnIft2wTYTzD4l90s7asSNnvu1B7fH
	 UhgL9Cj5P4umZrsgQzXechEBXHo8kx/jDXpuOlTmue1o5Kot63yhuNBEbeuMAq94B7
	 HaKbGDPUGk2GQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 222/317] crypto: arm/sha - fix function cast warnings
Date: Sun, 24 Mar 2024 19:33:22 -0400
Message-ID: <20240324233458.1352854-223-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 433ee4ddce6c8..f85933fdec75f 100644
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
index 0635a65aa488b..1be5bd498af36 100644
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


