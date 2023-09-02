Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94CC790872
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjIBPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjIBPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:22:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ADD10D2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:22:32 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cSRzqoXOCUaEwcSSEqaS1G; Sat, 02 Sep 2023 17:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693668151;
        bh=tjkg9rcvcouWu8UqYIEWp20ZVBqNAubtdKin1b09hDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A8HFEMdoFVUCWZZwAjO9TsAAB+Td2ZkYpd+UXL4SNmwsP6CCwxmWLWF4+sFFRKfCC
         Px0OuqkMud5HmKYPiDSQBGQ4hox9MSgeJtI6R3nf6o9ONT9WuTwPjXRb2ZJ5UKhQ/p
         GzSa7ELWNjpgEP/PjJ2XeNk9Lio5xrPTUGwcTXKcaQJ+l1b42D9kaSXBpyPd5/jw9m
         JqWV0dDvQYvhAm29GfukT7WPWvgOFcEE+6CDO7W4pDk60GLd91yirsuLv6FouVdMpZ
         18cchkTgx82/baT9ZbjAhp5bW6Ng0rGpqDFgK34HZTs1coctjO4rvEPZBYo3xbg3I5
         m1MljsxO+HNbw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Sep 2023 17:22:31 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
        daniel@ffwll.ch, jonathanh@nvidia.com, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/6] drm/tegra: hdmi: Fix some error handling paths in tegra_hdmi_probe()
Date:   Sat,  2 Sep 2023 17:22:10 +0200
Message-Id: <9b7c564eb71977678b20abd73ee52001a51cf327.1693667005.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling tegra_output_probe(),
tegra_output_remove() should be called as already done in the remove
function.

Fixes: 59d29c0ec93f ("drm/tegra: Allocate resources at probe time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/tegra/hdmi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 80c760986d9e..c73e7fb1877e 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1854,12 +1854,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 		return err;
 
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hdmi->regs))
-		return PTR_ERR(hdmi->regs);
+	if (IS_ERR(hdmi->regs)) {
+		err = PTR_ERR(hdmi->regs);
+		goto tegra_remove;
+	}
 
 	err = platform_get_irq(pdev, 0);
 	if (err < 0)
-		return err;
+		goto tegra_remove;
 
 	hdmi->irq = err;
 
@@ -1868,18 +1870,18 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
 			hdmi->irq, err);
-		return err;
+		goto tegra_remove;
 	}
 
 	platform_set_drvdata(pdev, hdmi);
 
 	err = devm_pm_runtime_enable(&pdev->dev);
 	if (err)
-		return err;
+		goto tegra_remove;
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (err)
-		return err;
+		goto tegra_remove;
 
 	INIT_LIST_HEAD(&hdmi->client.list);
 	hdmi->client.ops = &hdmi_client_ops;
@@ -1889,10 +1891,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto tegra_remove;
 	}
 
 	return 0;
+
+tegra_remove:
+	tegra_output_remove(&hdmi->output);
+	return err;
 }
 
 static void tegra_hdmi_remove(struct platform_device *pdev)
-- 
2.34.1

