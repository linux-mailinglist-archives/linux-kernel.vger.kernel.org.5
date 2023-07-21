Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D875C23D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGUI5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGUI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:56:58 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CC2D7E;
        Fri, 21 Jul 2023 01:56:51 -0700 (PDT)
Received: from [185.206.209.215] (helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qMlwQ-0001Cf-AK; Fri, 21 Jul 2023 10:56:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] hwrng: cn10k - use dev_err_probe
Date:   Fri, 21 Jul 2023 10:54:44 +0200
Message-Id: <20230721085444.496863-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721085444.496863-1-martin@kaiser.cx>
References: <20230721085444.496863-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe in error paths of the probe function, making the code a
tiny bit simpler.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/cn10k-rng.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/cn10k-rng.c b/drivers/char/hw_random/cn10k-rng.c
index 794ec77feb2c..31935316a160 100644
--- a/drivers/char/hw_random/cn10k-rng.c
+++ b/drivers/char/hw_random/cn10k-rng.c
@@ -187,10 +187,8 @@ static int cn10k_rng_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, rng);
 
 	rng->reg_base = pcim_iomap(pdev, 0, 0);
-	if (!rng->reg_base) {
-		dev_err(&pdev->dev, "Error while mapping CSRs, exiting\n");
-		return -ENOMEM;
-	}
+	if (!rng->reg_base)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "Error while mapping CSRs, exiting\n");
 
 	rng->ops.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				       "cn10k-rng-%s", dev_name(&pdev->dev));
@@ -205,10 +203,8 @@ static int cn10k_rng_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	reset_rng_health_state(rng);
 
 	err = devm_hwrng_register(&pdev->dev, &rng->ops);
-	if (err) {
-		dev_err(&pdev->dev, "Could not register hwrng device.\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Could not register hwrng device.\n");
 
 	return 0;
 }
-- 
2.30.2

