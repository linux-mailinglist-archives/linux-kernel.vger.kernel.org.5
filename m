Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC7757C87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGRNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjGRNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30591FD2;
        Tue, 18 Jul 2023 06:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 386A261567;
        Tue, 18 Jul 2023 13:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5AEC433C9;
        Tue, 18 Jul 2023 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685215;
        bh=/qQ5zVEDSQWgAAFuZ3X4YFEm+OAHRe8ZGR+DuY6dhnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jx99k83lQTosnEHIoqMPL/v8Bcu8QRVWYXkMeIHwWA0/2ffcR8hW88jOogx+7sbs2
         Oo0pYl+hIX4Pp22IFS4oa4moekRcfNQR08hTZRALfNVDK3/pqs25UAlPVlXZLlP6+q
         EpJutwNEnIA3Kw/vQkY38tASNdoCxNS9tY223solGfyGasrwwptAjoZTGe48e0h+zI
         TPSrbDUlsOM7TUNxUydKXy3WngrJOdvZAQOzSQ1TYX6m3kWmykBY+K8EtgbRlW6QZu
         C2p+dkrPWItiJW8Awli+goF89CkHLWZIblno2gdx8bL3KgdPNOpqvgiG51Hlqcq692
         niwAFwT5xfQYw==
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
Subject: [RFC PATCH 10/21] crypto: 842 - drop obsolete 'comp' implementation
Date:   Tue, 18 Jul 2023 14:58:36 +0200
Message-Id: <20230718125847.3869700-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3099; i=ardb@kernel.org; h=from:subject; bh=/qQ5zVEDSQWgAAFuZ3X4YFEm+OAHRe8ZGR+DuY6dhnM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT+X11++23f3U8DQ/9SjHpLTS1Zpciya+eWBSvZ27J L2uX6K1o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkhyjDf8+UdoabXwN4JvLV Kytb6q24N/1Ktl310bavz+7GLps7dS3DPxW9sh8cy1YXXAkw+/uyssR275cJZ4TP/Ptjmnv63AW eaGYA
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
 crypto/842.c | 63 +-------------------
 1 file changed, 1 insertion(+), 62 deletions(-)

diff --git a/crypto/842.c b/crypto/842.c
index e59e54d769609ba6..5001d88cf727f74e 100644
--- a/crypto/842.c
+++ b/crypto/842.c
@@ -39,38 +39,11 @@ static void *crypto842_alloc_ctx(struct crypto_scomp *tfm)
 	return ctx;
 }
 
-static int crypto842_init(struct crypto_tfm *tfm)
-{
-	struct crypto842_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->wmem = crypto842_alloc_ctx(NULL);
-	if (IS_ERR(ctx->wmem))
-		return -ENOMEM;
-
-	return 0;
-}
-
 static void crypto842_free_ctx(struct crypto_scomp *tfm, void *ctx)
 {
 	kfree(ctx);
 }
 
-static void crypto842_exit(struct crypto_tfm *tfm)
-{
-	struct crypto842_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	crypto842_free_ctx(NULL, ctx->wmem);
-}
-
-static int crypto842_compress(struct crypto_tfm *tfm,
-			      const u8 *src, unsigned int slen,
-			      u8 *dst, unsigned int *dlen)
-{
-	struct crypto842_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	return sw842_compress(src, slen, dst, dlen, ctx->wmem);
-}
-
 static int crypto842_scompress(struct crypto_scomp *tfm,
 			       const u8 *src, unsigned int slen,
 			       u8 *dst, unsigned int *dlen, void *ctx)
@@ -78,13 +51,6 @@ static int crypto842_scompress(struct crypto_scomp *tfm,
 	return sw842_compress(src, slen, dst, dlen, ctx);
 }
 
-static int crypto842_decompress(struct crypto_tfm *tfm,
-				const u8 *src, unsigned int slen,
-				u8 *dst, unsigned int *dlen)
-{
-	return sw842_decompress(src, slen, dst, dlen);
-}
-
 static int crypto842_sdecompress(struct crypto_scomp *tfm,
 				 const u8 *src, unsigned int slen,
 				 u8 *dst, unsigned int *dlen, void *ctx)
@@ -92,20 +58,6 @@ static int crypto842_sdecompress(struct crypto_scomp *tfm,
 	return sw842_decompress(src, slen, dst, dlen);
 }
 
-static struct crypto_alg alg = {
-	.cra_name		= "842",
-	.cra_driver_name	= "842-generic",
-	.cra_priority		= 100,
-	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
-	.cra_ctxsize		= sizeof(struct crypto842_ctx),
-	.cra_module		= THIS_MODULE,
-	.cra_init		= crypto842_init,
-	.cra_exit		= crypto842_exit,
-	.cra_u			= { .compress = {
-	.coa_compress		= crypto842_compress,
-	.coa_decompress		= crypto842_decompress } }
-};
-
 static struct scomp_alg scomp = {
 	.alloc_ctx		= crypto842_alloc_ctx,
 	.free_ctx		= crypto842_free_ctx,
@@ -121,25 +73,12 @@ static struct scomp_alg scomp = {
 
 static int __init crypto842_mod_init(void)
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
 subsys_initcall(crypto842_mod_init);
 
 static void __exit crypto842_mod_exit(void)
 {
-	crypto_unregister_alg(&alg);
 	crypto_unregister_scomp(&scomp);
 }
 module_exit(crypto842_mod_exit);
-- 
2.39.2

