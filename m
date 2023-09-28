Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454817B1524
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjI1HjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjI1HjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:39:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59B97;
        Thu, 28 Sep 2023 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695886741; x=1727422741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mw6amrAjr2FBcC2ESow/ci1eT9Msi63HLvtWx6Vudl4=;
  b=VvcmoCVRbUaXbgt3gdty7cYGyRei8e9fcYOVm8z1B3HaIR8edMwN81Jv
   EqdiwOFyYxC2mq/gqGUhGB8KROFDhdh8vtNGrfjGdYox0RTsyoKxscNr7
   pvDAwOjKyumjlVq6DVaOdIiGIUtoPqZfQqcbzwNcb/CqTNisfcSz+oKzD
   yYQjhebkK7Gsw0b2wmkr5LRw+P+8TuvsXELP2H8iYOS0t/NeDPY7HQINE
   gicQc+fdkGhejtDjDnBD9suxCeP/F4fBHv/Ipg2k3tnCRjogEOu+3tjfz
   eEsyvNgvZrGfU1lasK5v4edwaR8QJxe9CL/6G8EolBGHyLpJ32MePCQQZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367064871"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="367064871"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742990432"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="742990432"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2023 00:38:58 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2 3/3] crypto: x86/aesni - Perform address alignment early for XTS mode
Date:   Thu, 28 Sep 2023 00:25:08 -0700
Message-Id: <20230928072508.218368-4-chang.seok.bae@intel.com>
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

Currently, the alignment of each field in struct aesni_xts_ctx occurs
right before every access. However, it's possible to perform this
alignment ahead of time.

Introduce a helper function that converts struct crypto_skcipher *tfm
to struct aesni_xts_ctx *ctx and returns an aligned address. Utilize
this helper function at the beginning of each XTS function and then
eliminate redundant alignment code.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/all/ZFWQ4sZEVu%2FLHq+Q@gmail.com/
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
V1->V2: drop the cast (Eric).
---
 arch/x86/crypto/aesni-intel_glue.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 80e28a01aa3a..b1d90c25975a 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -223,6 +223,11 @@ static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 	return aes_align_addr(raw_ctx);
 }
 
+static inline struct aesni_xts_ctx *aes_xts_ctx(struct crypto_skcipher *tfm)
+{
+	return aes_align_addr(crypto_skcipher_ctx(tfm));
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

