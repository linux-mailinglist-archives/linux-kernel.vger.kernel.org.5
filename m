Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B97BC260
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjJFWrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJFWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:47:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BCB186;
        Fri,  6 Oct 2023 15:47:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A622C433C8;
        Fri,  6 Oct 2023 22:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632422;
        bh=dHi+uhc5JmMdS0vOiwqKPO+fur6fetbxxWrDuMzxW9s=;
        h=From:To:Cc:Subject:Date:From;
        b=CnU8Ad18XEIdVWdtF4JdAtf7WJ2CELAZ2WRm2m0xRt8N5et7x4Wh3M8ssQJPxU9OO
         i+ZlxgeMi93T5Q8wSL1pbql+nd4RYdx320qpVRts/bDOYNH1cFXMxOay4xDWYuKQDR
         uLjSFfbacyGbia+E1IVhVntZVz4R0LgPJ/kUBITGptGytiOv8F2Cnk70aNZ+vbSOVZ
         gpcw2RJy0GRrTVWrWHactuKXXjcBO+v5vPvSM3mOWtvfONOT+v/SWNv8r7943OX+Y+
         NXdc9+9UJ8GRFojR/7KMJJpOKEvS7MA3gyH6S11aHkQ4rjmaOBUmvnwuxc5mTBnKTE
         scBjoS2MX1W5A==
Received: (nullmailer pid 445636 invoked by uid 1000);
        Fri, 06 Oct 2023 22:47:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: altera: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:46:57 -0500
Message-Id: <20231006224657.445561-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/edac/altera_edac.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..541acf5eba05 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -279,7 +280,6 @@ static int a10_unmask_irq(struct platform_device *pdev, u32 mask)
 
 static int altr_sdram_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *id;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
 	struct altr_sdram_mc_data *drvdata;
@@ -290,10 +290,6 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	int irq, irq2, res = 0;
 	unsigned long mem_size, irqflags = 0;
 
-	id = of_match_device(altr_sdram_ctrl_of_match, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-
 	/* Grab the register range from the sdr controller in device tree */
 	mc_vbase = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						   "altr,sdr-syscon");
@@ -304,8 +300,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	}
 
 	/* Check specific dependencies for the module */
-	priv = of_match_node(altr_sdram_ctrl_of_match,
-			     pdev->dev.of_node)->data;
+	priv = device_get_match_data(&pdev->dev);
 
 	/* Validate the SDRAM controller has ECC enabled */
 	if (regmap_read(mc_vbase, priv->ecc_ctrl_offset, &read_reg) ||
-- 
2.40.1

