Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA275DD07
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGVOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGVOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:54:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1831999
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:54:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NDziq9IyeeA2LNDziqDHuc; Sat, 22 Jul 2023 16:54:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690037649;
        bh=lfDR0mINkrCKxcAnadMKPEe9Mciru7liyonpOcMXacU=;
        h=From:To:Cc:Subject:Date;
        b=DQxDYxtDbHTvG6MFjroIFnhP/3V6nQpawqQ2gCrQEhZGf80GXIq9vw1KxfQ8FK67f
         tGELfSAPJgUCUCNmkgqoiRpHwJD+0N2OdqhjK5zu3rPd9sU4hz1u9nYERSfYVmfOTe
         ftuMWx0FeVGyzWBCBxI72EAjl7S8nWH2RNBHO6DEJKv2VRg7mnaRPEULO9XumTKLCr
         g7nIGEt6o9YlmPtObdlvQ8ApLGMeUpOsnu0NYg21FVASxN5/T6JXiAFQGvQgO9onWW
         sPYZf0O9zDSVOtFJe+lo3BJGiUKwXgPkq+x1KRsuXZQ7RP5fHl57RZN5MsMpmrARLK
         iVMIU1IinDs6A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 16:54:09 +0200
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
Subject: [PATCH 1/2] crypto: caam - Use struct_size()
Date:   Sat, 22 Jul 2023 16:53:58 +0200
Message-Id: <0fc02b533bd3c3422bec5856bc65bbb66ebf7b58.1690037578.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of hand-writing it, when allocating a structure
with a flex array.

This is less verbose, more robust and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/caam/caamhash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 80deb003f0a5..9e5924e24f2e 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -708,9 +708,8 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
-	unsigned int sg_size = sg_num * sizeof(struct sec4_sg_entry);
 
-	edesc = kzalloc(sizeof(*edesc) + sg_size, flags);
+	edesc = kzalloc(struct_size(edesc, sec4_sg, sg_num), flags);
 	if (!edesc) {
 		dev_err(ctx->jrdev, "could not allocate extended descriptor\n");
 		return NULL;
-- 
2.34.1

