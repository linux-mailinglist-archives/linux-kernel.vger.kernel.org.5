Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE47BE82D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377996AbjJIRca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377987AbjJIRc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E43DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:32:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF4C433C8;
        Mon,  9 Oct 2023 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872744;
        bh=TJcaLAvlDM/rrjbQA5dPMPlECokIUSf7lD2UtWsTWBc=;
        h=From:To:Cc:Subject:Date:From;
        b=Z40JeD4ruBmtp+Dr0QAYPc1+X2CJDGfSG9nksOlkJmRghxJQpJ1zWHgtWndh6zvsp
         BnnZD60Gjwcuh5d0deXFyL4x+SC2Pr0p97i6Fhg9IDSsEYXtSFlJ9Lpi/AXeucRcYg
         FcYUgPxHIQuXB7k4w31EKLfwRhNdiHf7CEACnajmZAmB8Gk29w8f3o+DuIgwJ/mJ8T
         EpXOTWKl6uuOw8UO5r60zrMWy0BUEPEovnOOciXQGgFZ61166vfPlI7bAXLFmGf6kH
         JtrWcoThx3kR5fRpUr4J3L/celDzBQKxEkRvqa5wl+q6yd0Gx6kC5IaWnFGVd7la+I
         daYg5AP96EkFA==
Received: (nullmailer pid 2524703 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] nvmem: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:07 -0500
Message-ID: <20231009172923.2457844-12-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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
 drivers/nvmem/mxs-ocotp.c   | 10 ++++------
 drivers/nvmem/stm32-romem.c |  7 ++++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 588ab56d75b7..7b78f18f9545 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -13,8 +13,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/stmp_device.h>
 
@@ -140,11 +141,10 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct mxs_data *data;
 	struct mxs_ocotp *otp;
-	const struct of_device_id *match;
 	int ret;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data)
+	data = device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
 	otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
@@ -169,8 +169,6 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data = match->data;
-
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 1541c20709d2..8a553b1799a8 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -10,7 +10,9 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/tee_drv.h>
 
 #include "stm32-bsec-optee-ta.h"
@@ -211,8 +213,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 
 	priv->lower = 0;
 
-	cfg = (const struct stm32_romem_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	cfg = device_get_match_data(dev);
 	if (!cfg) {
 		priv->cfg.read_only = true;
 		priv->cfg.size = resource_size(res);
-- 
2.42.0

