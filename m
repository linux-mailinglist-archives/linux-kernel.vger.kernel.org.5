Return-Path: <linux-kernel+bounces-63324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02B852D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5021C21360
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81499286A2;
	Tue, 13 Feb 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5u6HgeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F46250E5;
	Tue, 13 Feb 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819242; cv=none; b=eFvU8NLm8TdDIIC8omy2Hu/J76v2P78C2vrTJyPir8V2oikCfuwz9CMoMYXLMiTQaYmtLhxxbklPUy/AgI15o70HkfSlK4J6V9lXRv5DgR6ZNYfeYfp8pboA5nOg4KgmMHpTpmd2i9pDBRsFfiBgnGcLq3w24AsbVzi9lQbyI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819242; c=relaxed/simple;
	bh=pJXnaVkOmADfzOfCpLbYu/Clp0Z96iKVydBpYB8ckH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKZXkhguWaZxyoU5c9LG1H9WBdkMyDZMwy7y/mMJd+QYiS7gXomq5qkQiXmZ19Wg9PNnTgozngRRXWjvQ0uVVnI42V9AHKLAd+Y4x80n2GDzq75ELrc4KKgU5R2d/g85POtEODY53aJZTgM1TjaGMEkKFYUIBcVJ++JIirTAh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5u6HgeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40900C433F1;
	Tue, 13 Feb 2024 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819242;
	bh=pJXnaVkOmADfzOfCpLbYu/Clp0Z96iKVydBpYB8ckH0=;
	h=From:To:Cc:Subject:Date:From;
	b=B5u6HgeYAzEr5R34fLeTyjNoBpg1ig8esgtWrTsxTVmSPFRIpTNB2wf+bEsSR3UHF
	 6m1W693PjIIQsdL787qcI/AH5nNFASF4HBJ2qKmylayQMLVS2Sb1FdQjrMxtP5C18K
	 wdIJAgrFuUE/mS10P8htbTT2/iYhNA9U4lZuhrdc4lMy31bhwnor8JLqpLjV4BoKYx
	 xGI3oCP7Ciifaa7KEeAQtZzzPvJsgLD+7m0AGzVngnl+3eHIYBLCO95wDE4yyakv2C
	 mXwcnW0xBIOpDhLTi51fw1ET7SsTdyXJWHHlEe36yJ8QgMUIl1nZzvBd+wSm7h4sPI
	 jClKDXE31FRWg==
From: Arnd Bergmann <arnd@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jussi Kivilinna <jussi.kivilinna@iki.fi>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ARM: crypto: fix function cast warnings
Date: Tue, 13 Feb 2024 11:13:44 +0100
Message-Id: <20240213101356.460376-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about casting between incompatible function types:

arch/arm/crypto/sha256_glue.c:37:5: error: cast from 'void (*)(u32 *, const void *, unsigned int)' (aka 'void (*)(unsigned int *, const void *, unsigned int)') to 'sha256_block_fn *' (aka 'void (*)(struct sha256_state *, const unsigned char *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   37 |                                 (sha256_block_fn *)sha256_block_data_order);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm/crypto/sha512-glue.c:34:3: error: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   34 |                 (sha512_block_fn *)sha512_block_data_order);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rework the sha256/sha512 code to instead go through a trivial helper
function to preserve the calling conventions.

Fixes: c80ae7ca3726 ("crypto: arm/sha512 - accelerated SHA-512 using ARM generic ASM and NEON")
Fixes: b59e2ae3690c ("crypto: arm/sha256 - move SHA-224/256 ASM/NEON implementation to base layer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/crypto/sha256_glue.c | 18 ++++++++++--------
 arch/arm/crypto/sha512-glue.c | 11 ++++++++---
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index 433ee4ddce6c..d80448d96ab3 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -27,29 +27,31 @@
 asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
 					unsigned int num_blks);
 
-int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
-			     unsigned int len)
+static void sha256_block_data_order_wrapper(struct sha256_state *sst, u8 const *src, int blocks)
 {
 	/* make sure casting to sha256_block_fn() is safe */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	return sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
+	return sha256_block_data_order((u32 *)sst, src, blocks);
+}
+
+int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
+			     unsigned int len)
+{
+	return sha256_base_do_update(desc, data, len, sha256_block_data_order_wrapper);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_update);
 
 static int crypto_sha256_arm_final(struct shash_desc *desc, u8 *out)
 {
-	sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+	sha256_base_do_finalize(desc, sha256_block_data_order_wrapper);
 	return sha256_base_finish(desc, out);
 }
 
 int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
 			    unsigned int len, u8 *out)
 {
-	sha256_base_do_update(desc, data, len,
-			      (sha256_block_fn *)sha256_block_data_order);
+	sha256_base_do_update(desc, data, len, sha256_block_data_order_wrapper);
 	return crypto_sha256_arm_final(desc, out);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_finup);
diff --git a/arch/arm/crypto/sha512-glue.c b/arch/arm/crypto/sha512-glue.c
index 0635a65aa488..1b2c9c0c8a5f 100644
--- a/arch/arm/crypto/sha512-glue.c
+++ b/arch/arm/crypto/sha512-glue.c
@@ -27,17 +27,22 @@ MODULE_ALIAS_CRYPTO("sha512-arm");
 
 asmlinkage void sha512_block_data_order(u64 *state, u8 const *src, int blocks);
 
+static void sha512_block_data_order_wrapper(struct sha512_state *sst, u8 const *src, int blocks)
+{
+	return sha512_block_data_order((u64 *)sst, src, blocks);
+}
+
 int sha512_arm_update(struct shash_desc *desc, const u8 *data,
 		      unsigned int len)
 {
 	return sha512_base_do_update(desc, data, len,
-		(sha512_block_fn *)sha512_block_data_order);
+		sha512_block_data_order_wrapper);
 }
 
 static int sha512_arm_final(struct shash_desc *desc, u8 *out)
 {
 	sha512_base_do_finalize(desc,
-		(sha512_block_fn *)sha512_block_data_order);
+		sha512_block_data_order_wrapper);
 	return sha512_base_finish(desc, out);
 }
 
@@ -45,7 +50,7 @@ int sha512_arm_finup(struct shash_desc *desc, const u8 *data,
 		     unsigned int len, u8 *out)
 {
 	sha512_base_do_update(desc, data, len,
-		(sha512_block_fn *)sha512_block_data_order);
+		sha512_block_data_order_wrapper);
 	return sha512_arm_final(desc, out);
 }
 
-- 
2.39.2


