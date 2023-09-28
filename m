Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464FE7B1521
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjI1HjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjI1HjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:39:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6928F;
        Thu, 28 Sep 2023 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695886740; x=1727422740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6NgVD08pFaNhfYaWXL6vs/EBfbIYirHydA4wVPI/g0=;
  b=X3MrSzlFxhQY55MBD6P+jYyXpKnprHj54fwBn8hn9u4U3VCwbhev3qna
   loIDgZzGblzrqBHPB9Y/eUT8zci5Tj13k7883a9lZrvcy38AgV84tNSt9
   ozysf7GM02Kt4DTZonM2wTS9Il2tG7wOakrrZxg2pRvJlJv5+cPuJK70g
   uffN8I7sA8crFSDWYQJk2yhVsyxPYzH8Uur3lMpwqW5TtfTDG2YflmTri
   XZ1B/bgSzwysKzQpgBZojP85NFopR4PsS299Y1mBHSWFJI6Uft0L0uplK
   OAJ9gKfwkeEVW5jhJdWxmB+X0J2LAWd2CHojvJywYYGm/F7oC7S4MN4uU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367064867"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="367064867"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742990426"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="742990426"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2023 00:38:58 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2 2/3] crypto: x86/aesni - Correct the data type in struct aesni_xts_ctx
Date:   Thu, 28 Sep 2023 00:25:07 -0700
Message-Id: <20230928072508.218368-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928072508.218368-1-chang.seok.bae@intel.com>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
 <20230928072508.218368-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, every field in struct aesni_xts_ctx is defined as a byte
array of the same size as struct crypto_aes_ctx. This data type
is obscure and the choice lacks justification.

To rectify this, update the field type in struct aesni_xts_ctx to
match its actual structure.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/all/ZFWQ4sZEVu%2FLHq+Q@gmail.com/
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/crypto/aesni-intel_glue.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 308deeb0c974..80e28a01aa3a 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -61,8 +61,8 @@ struct generic_gcmaes_ctx {
 };
 
 struct aesni_xts_ctx {
-	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
-	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AESNI_ALIGN_ATTR;
+	struct crypto_aes_ctx tweak_ctx AESNI_ALIGN_ATTR;
+	struct crypto_aes_ctx crypt_ctx AESNI_ALIGN_ATTR;
 };
 
 #define GCM_BLOCK_LEN 16
@@ -885,13 +885,12 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	keylen /= 2;
 
 	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(aes_ctx(ctx->raw_crypt_ctx), key, keylen);
+	err = aes_set_key_common(aes_ctx(&ctx->crypt_ctx), key, keylen);
 	if (err)
 		return err;
 
 	/* second half of xts-key is for tweak */
-	return aes_set_key_common(aes_ctx(ctx->raw_tweak_ctx), key + keylen,
-				  keylen);
+	return aes_set_key_common(aes_ctx(&ctx->tweak_ctx), key + keylen, keylen);
 }
 
 static int xts_crypt(struct skcipher_request *req, bool encrypt)
@@ -933,7 +932,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 	kernel_fpu_begin();
 
 	/* calculate first value of T */
-	aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
+	aesni_enc(aes_ctx(&ctx->tweak_ctx), walk.iv, walk.iv);
 
 	while (walk.nbytes > 0) {
 		int nbytes = walk.nbytes;
@@ -942,11 +941,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_encrypt(aes_ctx(&ctx->crypt_ctx),
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  nbytes, walk.iv);
 		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_decrypt(aes_ctx(&ctx->crypt_ctx),
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  nbytes, walk.iv);
 		kernel_fpu_end();
@@ -974,11 +973,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 
 		kernel_fpu_begin();
 		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_encrypt(aes_ctx(&ctx->crypt_ctx),
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  walk.nbytes, walk.iv);
 		else
-			aesni_xts_decrypt(aes_ctx(ctx->raw_crypt_ctx),
+			aesni_xts_decrypt(aes_ctx(&ctx->crypt_ctx),
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  walk.nbytes, walk.iv);
 		kernel_fpu_end();
-- 
2.34.1

