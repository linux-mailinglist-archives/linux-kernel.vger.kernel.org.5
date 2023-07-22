Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4885175DD09
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGVOyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGVOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:54:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B051FCB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:54:16 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NDziq9IyeeA2LNDzqqDHuw; Sat, 22 Jul 2023 16:54:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690037655;
        bh=2EYI+Z2hVmisU1YN5vrLq4/s1ceNP0kl8rsGq7obraQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=skGlKg56k8xYk51FfhL+hiU3BM3fmBiRZBr7bNAl/VyQW+DF7g3PK6bJVJnHmP4hy
         T2v0H5X0K0mhNSijn+vO76Jrx0vEi7vJZ4j8me239gtzXLkRPqKlDjgsOyVtaAu7Jh
         3bFucBrc7tpBru+NiFEkQINki5LMTzdYFsieVg4OudHPl6cyvR0FvfBIRUNEFzpz1i
         XT19us1XmcGenwWJrUqaCxJebdjDRGxG+zljEzk1Y1gr7WOevYQBM06lvRtlu69tEF
         7QdRGxznks0JjiYpqZdRieQJiCGQP2yZPw1Ch49gDKPPtx5Lv4skRb71vy1jdLwyrX
         XQAMqWtkKaK/A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 16:54:15 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] crypto: caam - Remove messages related to memory allocation failure
Date:   Sat, 22 Jul 2023 16:53:59 +0200
Message-Id: <b8859de12248852f661cb051ffad79166e8dfa47.1690037578.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0fc02b533bd3c3422bec5856bc65bbb66ebf7b58.1690037578.git.christophe.jaillet@wanadoo.fr>
References: <0fc02b533bd3c3422bec5856bc65bbb66ebf7b58.1690037578.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On memory allocation failure, the function calling stack is already logged.
So there is no need to explicitly log an extra message.

Remove them, ans simplify some code accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/caam/caamhash.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 9e5924e24f2e..641c3afd59ca 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -368,10 +368,8 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	int ret;
 
 	desc = kmalloc(CAAM_CMD_SZ * 8 + CAAM_PTR_SZ * 2, GFP_KERNEL);
-	if (!desc) {
-		dev_err(jrdev, "unable to allocate key input memory\n");
+	if (!desc)
 		return -ENOMEM;
-	}
 
 	init_job_desc(desc, 0);
 
@@ -702,18 +700,14 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 					     int sg_num, u32 *sh_desc,
 					     dma_addr_t sh_desc_dma)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
 
 	edesc = kzalloc(struct_size(edesc, sec4_sg, sg_num), flags);
-	if (!edesc) {
-		dev_err(ctx->jrdev, "could not allocate extended descriptor\n");
+	if (!edesc)
 		return NULL;
-	}
 
 	state->edesc = edesc;
 
@@ -1908,10 +1902,8 @@ caam_hash_alloc(struct caam_hash_template *template,
 	struct crypto_alg *alg;
 
 	t_alg = kzalloc(sizeof(*t_alg), GFP_KERNEL);
-	if (!t_alg) {
-		pr_err("failed to allocate t_alg\n");
+	if (!t_alg)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	t_alg->ahash_alg = template->template_ahash;
 	halg = &t_alg->ahash_alg;
-- 
2.34.1

