Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F987EFE8E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjKRImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:42:15 -0500
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86252B9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:42:10 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4Gu0rJpY1TzFX4Gu0rZIvI; Sat, 18 Nov 2023 09:42:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700296929;
        bh=ndyYzPGfIFWFzQxlHxzHKrwnfoAbUHaX6A64uMZYaoc=;
        h=From:To:Cc:Subject:Date;
        b=gYp0LcfNEYwN0zUxtUeKOT/rQuzhU9R0EE8KjvCPmCW+wIXE3s8icUkzMQLXrDsMp
         oCpgI3aGdfkw/6e9kqYSnl86DnLlkRygox1xlhomCKruir/A9pMFR7LcVjxSJ1RV8+
         szp2/KVxKQIESghWu29zfJ1I5dHXBN92wAdYskb/5C8kfWPXvTEE/YeonTXyN9iQ74
         R5TxlbqLXxFuZFv+b+IHwIYDduCeZQ6GWO6PX3BZwcCIE6Mcc7aZwAkE/2/dHzA03e
         tn77Rbd6SEfBn/GWyZXo2wOwH9mX8HGCfeBEoh9ETjlxjX5cPsX9fF5uKV5VsuB1Qj
         +Sjsp76aHicfg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Nov 2023 09:42:09 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: pata_pxa: convert not to use dma_request_slave_channel()
Date:   Sat, 18 Nov 2023 09:42:07 +0100
Message-Id: <497fe3c81b83ea74c4850bc44ea09acf15886b7e.1700296910.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is deprecated. dma_request_chan() should
be used directly instead.

Switch to the preferred function and update the error handling accordingly.
While at it, also propagate the error code that is now available.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Propagate the error code   [Sergey Shtylyov]

v1: https://lore.kernel.org/all/f177835b7f0db810a132916c8a281bbdaf47f9d3.1699801657.git.christophe.jaillet@wanadoo.fr/
---
 drivers/ata/pata_pxa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 5275c6464f57..538bd3423d85 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -274,10 +274,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	/*
 	 * Request the DMA channel
 	 */
-	data->dma_chan =
-		dma_request_slave_channel(&pdev->dev, "data");
-	if (!data->dma_chan)
-		return -EBUSY;
+	data->dma_chan = dma_request_chan(&pdev->dev, "data");
+	if (IS_ERR(data->dma_chan))
+		return PTR_ERR(data->dma_chan);
 	ret = dmaengine_slave_config(data->dma_chan, &config);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
-- 
2.34.1

