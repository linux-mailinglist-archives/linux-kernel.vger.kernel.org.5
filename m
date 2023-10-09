Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC617BEC76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378647AbjJIVOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5A92;
        Mon,  9 Oct 2023 14:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E11C433C9;
        Mon,  9 Oct 2023 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886050;
        bh=ap+N4R7Wc3zrVcWCqueifWjRY3gKqtLPPObPANvaRsk=;
        h=From:To:Cc:Subject:Date:From;
        b=TVSZcFjRyC7NOrF9so6qHNBtuo+KIMrX90xu8b0s84vESKo1rjdBKTP5arrqgz4dU
         vczOV3E0se5gfXpwDbWENgDdv2gyIykl4ipD6b5oW5mZrwoUw+UHdowlMhnPNfznlq
         goKjV9SX1G3g1SpdbUFQdGP8e3ZCCEF4onWxTx3x9quk3pMQ3QSBWSk8YMg4TOO3Af
         FY7n8xJQJcSZb8aHSPX1fAUBxczb/xH6oLOFdxs2C29TikoQ2nIoN95nDlJGoau2io
         MoCA05Y1aABlgrGECtgnbeupVBbR2BCORCXChMYO4/nb+UBP4Sd3HfCrlsLhSDlbwp
         Wk0FkMr0ACigg==
Received: (nullmailer pid 3245212 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: stm32-dcmi: Drop unnecessary of_match_device() call
Date:   Mon,  9 Oct 2023 16:13:32 -0500
Message-ID: <20231009211356.3242037-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If probe is reached, we've already matched the device and in the case of
DT matching, the struct device_node pointer will be set. Therefore, there
is no need to call of_match_device() in probe.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/media/platform/st/stm32/stm32-dcmi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index 8cb4fdcae137..48140fdf40bb 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -1890,7 +1889,6 @@ static int dcmi_graph_init(struct stm32_dcmi *dcmi)
 static int dcmi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match = NULL;
 	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
 	struct stm32_dcmi *dcmi;
 	struct vb2_queue *q;
@@ -1899,12 +1897,6 @@ static int dcmi_probe(struct platform_device *pdev)
 	struct clk *mclk;
 	int ret = 0;
 
-	match = of_match_device(of_match_ptr(stm32_dcmi_of_match), &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "Could not find a match in devicetree\n");
-		return -ENODEV;
-	}
-
 	dcmi = devm_kzalloc(&pdev->dev, sizeof(struct stm32_dcmi), GFP_KERNEL);
 	if (!dcmi)
 		return -ENOMEM;
-- 
2.42.0

