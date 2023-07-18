Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0483757C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjGRNCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGRNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E61733;
        Tue, 18 Jul 2023 06:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A63161572;
        Tue, 18 Jul 2023 13:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F118C433CB;
        Tue, 18 Jul 2023 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685239;
        bh=B1nBFJJhWHao7x/jd7i5fuI23+yDZ6JoStSpKA85T9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhcyEI485FT2QOQtXBfhXcNDTACc7aPZfUqUqG3O9OToL0ZEx0lz7onOEKWJPzF9a
         29V0dmzfrrJ3bCKgXlMuwbIUdTvTm+1Zpoe+tGs6TZti2ETR6FJ1FgdzwzaSvekHmr
         c8yV+dQ2XrHtLMqI7Vg2esHe763q3vsZ7ZM/UIhrdy4i+AbmkEaxlGPqCzCZMOZyix
         ShrupEhmBq/x4aJ6cfMqPlbAT/aHBEWz10wyt3zwdM+RIAFOkK7WZLz3QX6ltlCYT4
         7BfiQ4z+MIU14wMhRhIlW7ioLMEBdLH5L7qx293zEXFht84tDeGivetAZTv7LWIhuC
         Qj9M8ywZ/Mz2w==
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
Subject: [RFC PATCH 15/21] crypto: lzo - drop obsolete 'comp' implementation
Date:   Tue, 18 Jul 2023 14:58:41 +0200
Message-Id: <20230718125847.3869700-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3060; i=ardb@kernel.org; h=from:subject; bh=B1nBFJJhWHao7x/jd7i5fuI23+yDZ6JoStSpKA85T9w=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT/2Ni1NiPvWy+jZsEfB5cPNcUclCmTWb/9o7t6rL7 P3yrMm5o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExklT8jw7eu5YnnXnr2v3/k /iTKISblY5WU5XlVNdWz8+re3l2YNouRYdar/jru1XfPPjn586Ufp6+6Aeu1+6/7rfx5ZuZ8ePL YhRMA
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
 crypto/lzo.c | 60 +-------------------
 1 file changed, 1 insertion(+), 59 deletions(-)

diff --git a/crypto/lzo.c b/crypto/lzo.c
index ebda132dd22bf543..52558f9d41f3dcea 100644
--- a/crypto/lzo.c
+++ b/crypto/lzo.c
@@ -26,29 +26,11 @@ static void *lzo_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
-static int lzo_init(struct crypto_tfm *tfm)
-{
-	struct lzo_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->lzo_comp_mem = lzo_alloc_ctx(NULL);
-	if (IS_ERR(ctx->lzo_comp_mem))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static void lzo_free_ctx(struct crypto_scomp *tfm, void *ctx)
 {
 	kvfree(ctx);
 }
 
-static void lzo_exit(struct crypto_tfm *tfm)
-{
-	struct lzo_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	lzo_free_ctx(NULL, ctx->lzo_comp_mem);
-}
-
 static int __lzo_compress(const u8 *src, unsigned int slen,
 			  u8 *dst, unsigned int *dlen, void *ctx)
 {
@@ -64,14 +46,6 @@ static int __lzo_compress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int lzo_compress(struct crypto_tfm *tfm, const u8 *src,
-			unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	struct lzo_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __lzo_compress(src, slen, dst, dlen, ctx->lzo_comp_mem);
-}
-
 static int lzo_scompress(struct crypto_scomp *tfm, const u8 *src,
 			 unsigned int slen, u8 *dst, unsigned int *dlen,
 			 void *ctx)
@@ -94,12 +68,6 @@ static int __lzo_decompress(const u8 *src, unsigned int slen,
 	return 0;
 }
 
-static int lzo_decompress(struct crypto_tfm *tfm, const u8 *src,
-			  unsigned int slen, u8 *dst, unsigned int *dlen)
-{
-	return __lzo_decompress(src, slen, dst, dlen);
-}
-
 static int lzo_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 			   unsigned int slen, u8 *dst, unsigned int *dlen,
 			   void *ctx)
@@ -107,19 +75,6 @@ static int lzo_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __lzo_decompress(src, slen, dst, dlen);
 }
 
-static struct crypto_alg alg = {
-	.cra_name		= "lzo",
-	.cra_driver_name	= "lzo-generic",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct lzo_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= lzo_init,
-	.cra_exit		= lzo_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= lzo_compress,
-	.coa_decompress		= lzo_decompress } }
-};
-
 static struct scomp_alg scomp = {
 	.alloc_ctx		= lzo_alloc_ctx,
 	.free_ctx		= lzo_free_ctx,
@@ -134,24 +89,11 @@ static struct scomp_alg scomp = {
 
 static int __init lzo_mod_init(void)
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
 
 static void __exit lzo_mod_fini(void)
 {
-	crypto_unregister_alg(&alg);
 	crypto_unregister_scomp(&scomp);
 }
 
-- 
2.39.2

