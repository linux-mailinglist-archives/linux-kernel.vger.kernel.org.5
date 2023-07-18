Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5DE757C97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGRNCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGRNB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF51723;
        Tue, 18 Jul 2023 06:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C70661579;
        Tue, 18 Jul 2023 13:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DE9C433D9;
        Tue, 18 Jul 2023 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685234;
        bh=LMbtrrL41VdEZgul85mdHBoLsIRux4jBa3a/x61Ycxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT+7oEuP4bPgj+UiAqrCeUG8s2JirqYarClLaYQ/v7t474QklYXyL0XeFjZeHBVdh
         gv6D22UjPMjlm71YbZ/F30zxtNnROq9jkGmaU6AnNvB2MtBuIPcvxAraaZNd0iDh0B
         IMs+GSjziPHc22fbdXvDp3XCm0G+Lnmz9NSwGiWDdh+mPtQmwyjVrzILqas8OPkNnT
         gWzoDk9n4OHoV1ckft0Jl7jge4Y/jOjIALGlr5nfTnwDwLWGcpc0OM7unB6x/JmeDq
         qMI9+93zX3UyQsoHYBpXuJ6Jahesute96sx0/ZWb5cr42+NaO3NjuNrMS4ULnd2uuh
         T9dfxF8HRZITw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: [RFC PATCH 14/21] crypto: lzo-rle - drop obsolete 'comp' implementation
Date:   Tue, 18 Jul 2023 14:58:40 +0200
Message-Id: <20230718125847.3869700-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=ardb@kernel.org; h=from:subject; bh=LMbtrrL41VdEZgul85mdHBoLsIRux4jBa3a/x61Ycxo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT92iOmFL6eW+FVzXLW0ihXLXO0i9eJVdGxorWFrc+ eDR0dsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJnXzP8U5K5NrOp8HTz3nm9 vE+Wqa1J2lLH4G911il0qi/fkmslLYwMe1lrDvNXerk8WPLgpeMdRTOuz4Gm+2dp7xJ/J76NUaC FGQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'comp' API is obsolete and will be removed, so remove this comp
implementation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/lzo-rle.c | 60 +-------------------
 1 file changed, 1 insertion(+), 59 deletions(-)

diff --git a/crypto/lzo-rle.c b/crypto/lzo-rle.c
index 0631d975bfac1129..658d6aa46fe21e19 100644
--- a/crypto/lzo-rle.c
+++ b/crypto/lzo-rle.c
@@ -26,29 +26,11 @@ static void *lzorle_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
-static int lzorle_init(struct crypto_tfm *tfm)
-{
-	struct lzorle_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->lzorle_comp_mem = lzorle_alloc_ctx(NULL);
-	if (IS_ERR(ctx->lzorle_comp_mem))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static void lzorle_free_ctx(struct crypto_scomp *tfm, void *ctx)
 {
 	kvfree(ctx);
 }
 
-static void lzorle_exit(struct crypto_tfm *tfm)
-{
-	struct lzorle_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	lzorle_free_ctx(NULL, ctx->lzorle_comp_mem);
-}
-
 static int __lzorle_compress(const u8 *src, unsigned int slen,
 			  u8 *dst, unsigned int *dlen, void *ctx)
 {
@@ -64,14 +46,6 @@ static int __lzorle_compress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int lzorle_compress(struct crypto_tfm *tfm, const u8 *src,
-			unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	struct lzorle_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __lzorle_compress(src, slen, dst, dlen, ctx->lzorle_comp_mem);
-}
-
 static int lzorle_scompress(struct crypto_scomp *tfm, const u8 *src,
 			 unsigned int slen, u8 *dst, unsigned int *dlen,
 			 void *ctx)
@@ -94,12 +68,6 @@ static int __lzorle_decompress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int lzorle_decompress(struct crypto_tfm *tfm, const u8 *src,
-			  unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	return __lzorle_decompress(src, slen, dst, dlen);
-}
-
 static int lzorle_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 			   unsigned int slen, u8 *dst, unsigned int *dlen,
 			   void *ctx)
@@ -107,19 +75,6 @@ static int lzorle_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __lzorle_decompress(src, slen, dst, dlen);
 }
 
-static struct crypto_alg alg = {
-	.cra_name		= "lzo-rle",
-	.cra_driver_name	= "lzo-rle-generic",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct lzorle_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= lzorle_init,
-	.cra_exit		= lzorle_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= lzorle_compress,
-	.coa_decompress		= lzorle_decompress } }
-};
-
 static struct scomp_alg scomp = {
 	.alloc_ctx		= lzorle_alloc_ctx,
 	.free_ctx		= lzorle_free_ctx,
@@ -134,24 +89,11 @@ static struct scomp_alg scomp = {
 
 static int __init lzorle_mod_init(void)
 {
-	int ret;
-
-	ret = crypto_register_alg(&alg);
-	if (ret)
-		return ret;
-
-	ret = crypto_register_scomp(&scomp);
-	if (ret) {
-		crypto_unregister_alg(&alg);
-		return ret;
-	}
-
-	return ret;
+	return crypto_register_scomp(&scomp);
 }
 
 static void __exit lzorle_mod_fini(void)
 {
-	crypto_unregister_alg(&alg);
 	crypto_unregister_scomp(&scomp);
 }
 
-- 
2.39.2

