Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F08758EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGSHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGSHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:20:10 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DBE43;
        Wed, 19 Jul 2023 00:20:10 -0700 (PDT)
Received: from ipservice-092-217-093-053.092.217.pools.vodafone-ip.de ([92.217.93.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qM1Tk-0008I7-MQ; Wed, 19 Jul 2023 09:20:08 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] hwrng: cctrng - don't open code init and exit functions
Date:   Wed, 19 Jul 2023 09:18:03 +0200
Message-Id: <20230719071806.335718-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230719071806.335718-1-martin@kaiser.cx>
References: <20230719071806.335718-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not open code the init and exit functions of the cctrng driver.

If we move the BUILD_BUG_ON checks into the probe function, we can use
module_platform_driver and make the code shorter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/cctrng.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 302ffa354c2f..241da7e44675 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -492,6 +492,10 @@ static int cctrng_probe(struct platform_device *pdev)
 	u32 val;
 	int irq;
 
+	/* Compile time assertion checks */
+	BUILD_BUG_ON(CCTRNG_DATA_BUF_WORDS < 6);
+	BUILD_BUG_ON((CCTRNG_DATA_BUF_WORDS & (CCTRNG_DATA_BUF_WORDS-1)) != 0);
+
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -698,21 +702,7 @@ static struct platform_driver cctrng_driver = {
 	.remove = cctrng_remove,
 };
 
-static int __init cctrng_mod_init(void)
-{
-	/* Compile time assertion checks */
-	BUILD_BUG_ON(CCTRNG_DATA_BUF_WORDS < 6);
-	BUILD_BUG_ON((CCTRNG_DATA_BUF_WORDS & (CCTRNG_DATA_BUF_WORDS-1)) != 0);
-
-	return platform_driver_register(&cctrng_driver);
-}
-module_init(cctrng_mod_init);
-
-static void __exit cctrng_mod_exit(void)
-{
-	platform_driver_unregister(&cctrng_driver);
-}
-module_exit(cctrng_mod_exit);
+module_platform_driver(cctrng_driver);
 
 /* Module description */
 MODULE_DESCRIPTION("ARM CryptoCell TRNG Driver");
-- 
2.30.2

