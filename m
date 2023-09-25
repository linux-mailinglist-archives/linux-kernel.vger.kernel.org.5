Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9512D7ADB77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjIYPcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjIYPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:31:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AC109;
        Mon, 25 Sep 2023 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655910; x=1727191910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eY/JIAPvntiiqrDrvRdcoHfSNg9uoZBoHI1Bx3x9qIU=;
  b=M+nojskkojeLMaS5lcfjtjcW6K0konJ7AM25ICqXu7uUeF+bgXxygMaI
   fPSOGqVOslw5a57qHnL2eWV5/yuTCLZTaBH6HMhY0WepcWzbRLVIe0bUj
   LIf65AUMBg9J1z4GvYuk9lDwa9qCyRf2EJoh5St+lVrUaytTKdoOxp8Jk
   tyZmvyY5rgmegHfglCVJcxMHZIxhiBUrzYacnlvgpksGoFhxK2E7bm+5l
   PqDDEFEdV8Y1O5dEB0lRX8W9QW/xKXn73s0YsmgNvSGdjNqR6HLhjD5rQ
   xkgM9kuUvRSntV3191857hjzdqkLUzgwhjeeIgQKHTMMmHPHjxVrTAh61
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361533603"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="361533603"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725023015"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="725023015"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2023 08:31:49 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 3/3] crypto: x86/aesni - Perform address alignment early for XTS mode
Date:   Mon, 25 Sep 2023 08:17:52 -0700
Message-Id: <20230925151752.162449-4-chang.seok.bae@intel.com>
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

Currently, the alignment of each field in struct aesni_xts_ctx occurs
right before every access. However, it's possible to perform this
alignment ahead of time.

Introduce a helper function that converts struct crypto_skcipher *tfm
to struct aesni_xts_ctx *ctx and returns an aligned address. Utilize
this helper function at the beginning of each XTS function and then
eliminate redundant alignment code.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/all/ZFWQ4sZEVu%2FLHq+Q@gmail.com/
---
 arch/x86/crypto/aesni-intel_glue.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 412a99e914a6..b344652510a3 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -223,6 +223,11 @@ static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 	return (struct crypto_aes_ctx *)aes_align_addr(raw_ctx);
 }
 
+static inline struct aesni_xts_ctx *aes_xts_ctx(struct crypto_skcipher *tfm)
+{
+	return (struct aesni_xts_ctx *)aes_align_addr(crypto_skcipher_ctx(tfm));
+}
+
 static int aes_set_key_common(struct crypto_aes_ctx *ctx,
 			      const u8 *in_key, unsigned int key_len)
 {
@@ -875,7 +880,7 @@ static int helper_rfc4106_decrypt(struct aead_request *req)
 static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			    unsigned int keylen)
 {
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int err;
 
 	err = xts_verify_key(tfm, key, keylen);
@@ -885,18 +890,18 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	keylen /= 2;
 
 	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(aes_ctx(&ctx->crypt_ctx), key, keylen);
+	err = aes_set_key_common(&ctx->crypt_ctx, key, keylen);
 	if (err)
 		return err;
 
 	/* second half of xts-key is for tweak */
-	return aes_set_key_common(aes_ctx(&ctx->tweak_ctx), key + keylen, keylen);
+	return aes_set_key_common(&ctx->tweak_ctx, key + keylen, keylen);
 }
 
 static int xts_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct aesni_xts_ctx *ctx = aes_xts_ctx(tfm);
 	int tail = req->cryptlen % AES_BLOCK_SIZE;
 	struct skcipher_request subreq;
 	struct skcipher_walk walk;
@@ -932,7 +937,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 	kernel_fpu_begin();
 
 	/* calculate first value of T */
-	aesni_enc(aes_ctx(&ctx->tweak_ctx), walk.iv, walk.iv);
+	aesni_enc(&ctx->tweak_ctx, walk.iv, walk.iv);
 
 	while (walk.nbytes > 0) {
 		int nbytes = walk.nbytes;
@@ -941,11 +946,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 			nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(&ctx->crypt_ctx),
+			aesni_xts_encrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  nbytes, walk.iv);
 		else
-			aesni_xts_decrypt(aes_ctx(&ctx->crypt_ctx),
+			aesni_xts_decrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  nbytes, walk.iv);
 		kernel_fpu_end();
@@ -973,11 +978,11 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 
 		kernel_fpu_begin();
 		if (encrypt)
-			aesni_xts_encrypt(aes_ctx(&ctx->crypt_ctx),
+			aesni_xts_encrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  walk.nbytes, walk.iv);
 		else
-			aesni_xts_decrypt(aes_ctx(&ctx->crypt_ctx),
+			aesni_xts_decrypt(&ctx->crypt_ctx,
 					  walk.dst.virt.addr, walk.src.virt.addr,
 					  walk.nbytes, walk.iv);
 		kernel_fpu_end();
-- 
2.34.1

