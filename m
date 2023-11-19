Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E097F058F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjKSLAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:00:00 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43718129
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:59:56 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4fWqr551gODaN4fWrr4GNd; Sun, 19 Nov 2023 11:59:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700391593;
        bh=MntiypTvXcH5bZA1OG0dGkr+lu0AvoaryKrACfMPtnw=;
        h=From:To:Cc:Subject:Date;
        b=bMrCvuAgtvmmR0/etLtFuypEUjyUp6OYUcbQWc8r6Q0IkSR3kSUM2I3BcjG+ferfY
         lscEi6ZhMVjr6zYkHhxEA+O3FZ74e0VoO+IwTROi4Yluj0666jCVd1STwnJ56EjbCW
         OyrCVDTu1NsvlMHnsPL86jn72PW65Np2L2N4VLh5D0qXovLk41ODZVtcOKuBwMxtRC
         uU7VjVF00AzOGFpZ9+SdAAJUvQBQsGJyWZ+GSRn2c9zjZgjzjnn6/rrW+u5Nxo3e2x
         XGN+j0ZtFYR974bT5LsVsooavhk2yFfOvjULJFCPwSZFkXA9L2lf3NDIxQjSLobqpM
         Bn1ZQGIl6fYJg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 11:59:53 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: ingenic: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 11:59:50 +0100
Message-Id: <1c88236b5d6bff0af902492ea9e066c8cb0dfef5.1700391566.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is deprecated. dma_request_chan() should
be used directly instead.

Switch to the preferred function and update the error handling accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-ingenic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index cc366936d72b..003a6d21c4c3 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -346,14 +346,17 @@ static bool spi_ingenic_can_dma(struct spi_controller *ctlr,
 static int spi_ingenic_request_dma(struct spi_controller *ctlr,
 				   struct device *dev)
 {
-	ctlr->dma_tx = dma_request_slave_channel(dev, "tx");
-	if (!ctlr->dma_tx)
-		return -ENODEV;
+	struct dma_chan *chan;
 
-	ctlr->dma_rx = dma_request_slave_channel(dev, "rx");
+	chan = dma_request_chan(dev, "tx");
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+	ctlr->dma_tx = chan;
 
-	if (!ctlr->dma_rx)
-		return -ENODEV;
+	chan = dma_request_chan(dev, "rx");
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+	ctlr->dma_rx = chan;
 
 	ctlr->can_dma = spi_ingenic_can_dma;
 
-- 
2.34.1

