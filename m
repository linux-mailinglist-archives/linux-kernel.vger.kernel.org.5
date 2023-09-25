Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D17ADB76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjIYPcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjIYPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:31:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0B95;
        Mon, 25 Sep 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655909; x=1727191909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUSbpHufyWQOufCo4M+g4wkojF2tw2umePEM+zT+GfU=;
  b=fBYaqubmIJSl3bHRpoSLqQolKmNhsGwzgSm+MHAxZM01lb+PwLXSbL3l
   DRIay0uYT5dDOjdvnYFGYTfXve8xuzs6WFCcLOoQbgbHqnuKbC+fuaHIC
   jBaFb+vJBmYVZiHiHvqNxRqm7tpIslVlu8tEFEGsUMxBTqSDPbEexXjca
   8DOPei/jVUK1ud+i75XPqwmC2J1sDLysIDr3mOLN7JNWmJiUk2aseoBwH
   Wn0Wt9HQ4EiA3BxF4FD4oD03ohWIGb9zXLFn2P6zsbFJ7ujBZPQXwDN5+
   DbNzu/6OezNmYtZQJf47au7JuVv9GP6WAPg/CbPxUH9U4Kmnlbcv8ARk6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361533596"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="361533596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725023012"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="725023012"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2023 08:31:48 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 2/3] crypto: x86/aesni - Correct the data type in struct aesni_xts_ctx
Date:   Mon, 25 Sep 2023 08:17:51 -0700
Message-Id: <20230925151752.162449-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925151752.162449-1-chang.seok.bae@intel.com>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/all/ZFWQ4sZEVu%2FLHq+Q@gmail.com/
---
 arch/x86/crypto/aesni-intel_glue.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 241d38ae1ed9..412a99e914a6 100644
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

