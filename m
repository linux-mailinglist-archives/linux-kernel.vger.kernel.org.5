Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399217AEA97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjIZKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjIZKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:39:52 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55710C;
        Tue, 26 Sep 2023 03:39:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 4FF9E240009;
        Tue, 26 Sep 2023 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695724782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=94FNtphCbsWf6wCGl8UYRRa0JtnR+dm/mDW23d094II=;
        b=WRyxdFvXLksA6Pezj20twQfdaS+eTI02SlJ4ynpJJBSt5GJ/AEj9SwrqaPcq8Nu5dOdMuo
        0gHsRIrdhFnlBX9Bzf9OAi2SGOOyMjeqkKP3MONwTOgLIH3mDbu8TjiOCwwPfy6v+owRe+
        J9mWIWlv9g7qOoTI/7sIIoNQtxUwnD26w5qLEBqVCgxFXs4UdrZmmnSQLRahEMTMVaGVb0
        xccXrdEfOcDETefUKbXE3888YuFjvFP4dlIDlqqs0lcnZgcw7w4Sqavlgx1LWWODQThzPT
        FkFBN0IjzvQr+gB9fu40G8Cdyvv/6KT0VFW7IOATuidFhbDm74aDqI6AZIz0PA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] pinctrl: tegra: add OF node when logging OF parsing errors
Date:   Tue, 26 Sep 2023 12:39:38 +0200
Message-Id: <20230926103938.334055-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These errors are not quite clear without also logging they device tree node
being parsed, especially when the pinmux node has lots of subnodes. Adding
the node name helps a lot in finding the node that triggers the error.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 734c71ef005b..6bf8db424bec 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -120,7 +120,7 @@ static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		/* EINVAL=missing, which is fine since it's optional */
 		if (ret != -EINVAL)
 			dev_err(dev,
-				"could not parse property nvidia,function\n");
+				"%pOF: could not parse property nvidia,function\n", np);
 		function = NULL;
 	}
 
@@ -134,8 +134,8 @@ static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				goto exit;
 		/* EINVAL=missing, which is fine since it's optional */
 		} else if (ret != -EINVAL) {
-			dev_err(dev, "could not parse property %s\n",
-				cfg_params[i].property);
+			dev_err(dev, "%pOF: could not parse property %s\n",
+				np, cfg_params[i].property);
 		}
 	}
 
@@ -146,7 +146,7 @@ static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		reserve++;
 	ret = of_property_count_strings(np, "nvidia,pins");
 	if (ret < 0) {
-		dev_err(dev, "could not parse property nvidia,pins\n");
+		dev_err(dev, "%pOF: could not parse property nvidia,pins\n", np);
 		goto exit;
 	}
 	reserve *= ret;
-- 
2.34.1

