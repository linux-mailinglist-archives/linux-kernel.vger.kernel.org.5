Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49585757C93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjGRNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGRNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3381FF6;
        Tue, 18 Jul 2023 06:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A121E61576;
        Tue, 18 Jul 2023 13:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A75C433CA;
        Tue, 18 Jul 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685230;
        bh=ybqp9scuELh2vQqve89JuTt0+nVIyUf6Gt9BVqu5B2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7rM2DGifJvUBSsRs2TqmJFZjS7Ja3MsCYwYk4vDlyS8D/ipVSN1emtrvn1c39ITj
         t0kxALgOjR+NN2wT7NsRGLVwfw2FUMIgz5urIfIVlKjU+OwppKTlVvOoKbui8GaR6U
         YouQxeZ6C93QO3pou/o2fWQ5tzrVZBu0uQJXmvPFpO7YK/5f02xUmf6QDN0KrwXdth
         Od8H44CB7Le+By/Dc2tEPuwcEAGr8N8CDOfjY8Hc5SowM4TDRKoVKJ9ZvFWsgbOwEK
         CuvFMkl+2cU3srDp0ESxTSTljbUXUzaUZPYubFlYHnJSvt4W8HryGXhGMY2ibyTuW2
         i4dksQaVdwmKQ==
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
Subject: [RFC PATCH 13/21] crypto: lz4hc - drop obsolete 'comp' implementation
Date:   Tue, 18 Jul 2023 14:58:39 +0200
Message-Id: <20230718125847.3869700-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3050; i=ardb@kernel.org; h=from:subject; bh=ybqp9scuELh2vQqve89JuTt0+nVIyUf6Gt9BVqu5B2E=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbTw2fjrb6ghOa2x4xrH0+6/bVlX1sHR/c9z6a3fPH5 Ptym60tHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiPO8YGd41l/z1cHdIkV12 7fHt2lqOarNuqUyHkrwtX0tZX9T9Dmdk6Pu3Oi2UR+En23SXe3PaZm3RTlny7s1Mxq4EnYtFs84 +5wMA
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
 crypto/lz4hc.c | 63 +-------------------
 1 file changed, 1 insertion(+), 62 deletions(-)

diff --git a/crypto/lz4hc.c b/crypto/lz4hc.c
index d7cc94aa2fcf42fa..5d6b13319f5e7683 100644
--- a/crypto/lz4hc.c
+++ b/crypto/lz4hc.c
@@ -26,29 +26,11 @@ static void *lz4hc_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
-static int lz4hc_init(struct crypto_tfm *tfm)
-{
-	struct lz4hc_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->lz4hc_comp_mem = lz4hc_alloc_ctx(NULL);
-	if (IS_ERR(ctx->lz4hc_comp_mem))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static void lz4hc_free_ctx(struct crypto_scomp *tfm, void *ctx)
 {
 	vfree(ctx);
 }
 
-static void lz4hc_exit(struct crypto_tfm *tfm)
-{
-	struct lz4hc_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	lz4hc_free_ctx(NULL, ctx->lz4hc_comp_mem);
-}
-
 static int __lz4hc_compress_crypto(const u8 *src, unsigned int slen,
 				   u8 *dst, unsigned int *dlen, void *ctx)
 {
@@ -69,16 +51,6 @@ static int lz4hc_scompress(struct crypto_scomp *tfm, const u8 *src,
 	return __lz4hc_compress_crypto(src, slen, dst, dlen, ctx);
 }
 
-static int lz4hc_compress_crypto(struct crypto_tfm *tfm, const u8 *src,
-				 unsigned int slen, u8 *dst,
-				 unsigned int *dlen)
-{
-	struct lz4hc_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return __lz4hc_compress_crypto(src, slen, dst, dlen,
-					ctx->lz4hc_comp_mem);
-}
-
 static int __lz4hc_decompress_crypto(const u8 *src, unsigned int slen,
 				     u8 *dst, unsigned int *dlen, void *ctx)
 {
@@ -98,26 +70,6 @@ static int lz4hc_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __lz4hc_decompress_crypto(src, slen, dst, dlen, NULL);
 }
 
-static int lz4hc_decompress_crypto(struct crypto_tfm *tfm, const u8 *src,
-				   unsigned int slen, u8 *dst,
-				   unsigned int *dlen)
-{
-	return __lz4hc_decompress_crypto(src, slen, dst, dlen, NULL);
-}
-
-static struct crypto_alg alg_lz4hc = {
-	.cra_name		= "lz4hc",
-	.cra_driver_name	= "lz4hc-generic",
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct lz4hc_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= lz4hc_init,
-	.cra_exit		= lz4hc_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= lz4hc_compress_crypto,
-	.coa_decompress		= lz4hc_decompress_crypto } }
-};
-
 static struct scomp_alg scomp = {
 	.alloc_ctx		= lz4hc_alloc_ctx,
 	.free_ctx		= lz4hc_free_ctx,
@@ -132,24 +84,11 @@ static struct scomp_alg scomp = {
 
 static int __init lz4hc_mod_init(void)
 {
-	int ret;
-
-	ret = crypto_register_alg(&alg_lz4hc);
-	if (ret)
-		return ret;
-
-	ret = crypto_register_scomp(&scomp);
-	if (ret) {
-		crypto_unregister_alg(&alg_lz4hc);
-		return ret;
-	}
-
-	return ret;
+	return crypto_register_scomp(&scomp);
 }
 
 static void __exit lz4hc_mod_fini(void)
 {
-	crypto_unregister_alg(&alg_lz4hc);
 	crypto_unregister_scomp(&scomp);
 }
 
-- 
2.39.2

