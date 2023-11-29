Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632717FD6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjK2MlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjK2MlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:41:05 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5DF610D4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=C9pbxi/4On2uizg/mt
        LqDiesLQ/rTQR6z5ASO0iY7R0=; b=Vu9/fmZupquMIwiW9wtZ+ZCmEhKvfb74BT
        aAAjJYGPvsjHI9qlV2PnqrM9oBqnakGouNzht8XhdvO0SaxDObuxIlwrWk/+4Nli
        IZB29FSVePhhuy1xynHDMrL/ZnOegX7jAeygF20XopG26bClC+u7EUA0PaiC6hfD
        sJQ4piNLo=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wDX1o5NMWdlf2UAEQ--.41802S2;
        Wed, 29 Nov 2023 20:40:46 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     vkoul@kernel.org
Cc:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [phy/renesas] phy-rcar-gen2: Add error handling
Date:   Wed, 29 Nov 2023 04:40:43 -0800
Message-Id: <20231129124043.33526-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDX1o5NMWdlf2UAEQ--.41802S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW5uF13Aw43Cr4DAr4fKrg_yoW8GrWkpF
        WkGaySyrW8JFsrtrZxtr45ZFn0kw4xK343tFW3Ka4fZF1UAr909a4a9a4YvF1Ygr4vyF4Y
        qr18tFykAF1UZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUOeOdUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwg83glc6610M6QAAsG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the clk_prepare_enable
call in the rcar_gen2_phy_init function within
drivers/phy/renesas/phy-rcar-gen2.c. Previously, the function
lacked appropriate handling for potential failures of
clk_prepare_enable, which could lead to instability if the clock
preparation failed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/phy/renesas/phy-rcar-gen2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
index 507435af2656..c84eeaf1f607 100644
--- a/drivers/phy/renesas/phy-rcar-gen2.c
+++ b/drivers/phy/renesas/phy-rcar-gen2.c
@@ -80,6 +80,7 @@ static int rcar_gen2_phy_init(struct phy *p)
 	struct rcar_gen2_phy_driver *drv = channel->drv;
 	unsigned long flags;
 	u32 ugctrl2;
+	int ret;
 
 	/*
 	 * Try to acquire exclusive access to PHY.  The first driver calling
@@ -90,7 +91,11 @@ static int rcar_gen2_phy_init(struct phy *p)
 	if (cmpxchg(&channel->selected_phy, -1, phy->number) != -1)
 		return -EBUSY;
 
-	clk_prepare_enable(drv->clk);
+	ret = clk_prepare_enable(drv->clk);
+	if (ret) {
+		dev_err(&p->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
 
 	spin_lock_irqsave(&drv->lock, flags);
 	ugctrl2 = readl(drv->base + USBHS_UGCTRL2);
-- 
2.17.1

