Return-Path: <linux-kernel+bounces-63612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEAF853240
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688C9B23283
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE625647F;
	Tue, 13 Feb 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0GkEPW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F35577C;
	Tue, 13 Feb 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832207; cv=none; b=rUITkVT4/6viWtlKHZTCyyNmIa5bt514jQtNywYleyAP7shehH89+Vu8VxUWIVa23GbTLtCoub0LVSohB/EcKw8jo1tgyAFQx0mlMFBPk+8DXQyWZb4GuYdqEqVjVlUsKq33ze+scS7WK3kuahyaCiOZRae99U+S10v9+MH14WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832207; c=relaxed/simple;
	bh=jebXE4S2l9VR5ky5ojZahV3h7w5E04tMbZxudpRgGSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ro08ii1rl5uVHuRc9vcH69zwE6HEDTlQhUvjunV4hL85U/vNGi/xzc5G5tcermSa9Mc7jB+HZIw8WJ428fGYNnQi04M+H8MeyxhbUpaXu05obIL9ZE9to4y/Zv8YvwaOV5tUYRqyesdvBGo3nXI+U7wgiHF4MvkrscHqYa4BioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0GkEPW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE39C43390;
	Tue, 13 Feb 2024 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707832206;
	bh=jebXE4S2l9VR5ky5ojZahV3h7w5E04tMbZxudpRgGSY=;
	h=From:To:Cc:Subject:Date:From;
	b=Y0GkEPW9nYVaz2755BhIaDpPuFyD3qcFx46+TX74N9+5Uw6wTHUQaIXtB9ttVCAQ6
	 69nlW8eWsC1RQWeJtsy0qlowT5JzcjMqUS3ePo5n3xR+BZ+kdWghLtutcZKWsHQdGa
	 r0K+RTqEQvR8XsyqopBPw0TsfsziNCfoHP0a/4GKK4ybIUIxT2Wfo3SrWbAV/epZbk
	 AfoEpgbCSlwrtcdcPFTNkbxLE274I2YIBdEhzkmc1m1o5mH+PuIB/Z9OuDQZgJiZ1v
	 DNiRFS5+QeL2QSSodUfwRAmsxgOPg3t2IfM+1dVGcdKDfKcpDip4BfRvLAPGaNgwRh
	 +63E9Uxj07zgA==
From: Arnd Bergmann <arnd@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jussi Kivilinna <jussi.kivilinna@iki.fi>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] [v2] ARM: crypto: fix function cast warnings
Date: Tue, 13 Feb 2024 14:49:46 +0100
Message-Id: <20240213135000.3400052-1-arnd@kernel.org>
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

Fix the prototypes for the assembler functions to match the typedef.
The code already relies on the digest being the first part of the
state structure, so there is no change in behavior.

Fixes: c80ae7ca3726 ("crypto: arm/sha512 - accelerated SHA-512 using ARM generic ASM and NEON")
Fixes: b59e2ae3690c ("crypto: arm/sha256 - move SHA-224/256 ASM/NEON implementation to base layer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rewrite change as suggested by Herbert Xu.
---
 arch/arm/crypto/sha256_glue.c | 13 +++++--------
 arch/arm/crypto/sha512-glue.c | 12 +++++-------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index 433ee4ddce6c..f85933fdec75 100644
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
index 0635a65aa488..1be5bd498af3 100644
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
2.39.2


