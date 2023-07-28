Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB3766180
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjG1ByR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjG1ByP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:54:15 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACFB0173F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=gjJMd9nkH4Mf0R1Uns
        gI9bP8PjpttgyTbr+YjirneSA=; b=ERFKW72sPyoH8chSxXlX4yviepByxXzHVh
        AiL0uaXDWFArT0jOV3jmXcuIGyEAuXmZgZcZ7xWZuB6h1GezdtdcatpMfDtNYJDm
        /tjuY8Xh6GXs4SlQenMlrJkZoZ+2G8sws7//HOnRQNe0Zs6EAN6AKxsIop402LJT
        UbFqqpS9I=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDXBuOkH8NkZOP4BQ--.61958S4;
        Fri, 28 Jul 2023 09:53:48 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     christophe.jaillet@wanadoo.fr
Cc:     airlied@gmail.com, andrew@aj.id.au, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, ruc_gongyuanjun@163.com
Subject: [PATCH v2 1/1] gpu: drm: aspeed: use devm_clk_get_enabled() in aspeed_gfx_load()
Date:   Fri, 28 Jul 2023 09:53:35 +0800
Message-Id: <20230728015335.5021-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2419973d-1e21-5754-d309-436dc9c62be8@wanadoo.fr>
References: <2419973d-1e21-5754-d309-436dc9c62be8@wanadoo.fr>
X-CM-TRANSID: _____wDXBuOkH8NkZOP4BQ--.61958S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfJw1xJF13tw4UAFyUGFg_yoWkAFXE9r
        4xursxXrsruFyDCw1rZwn3JFWxKFZ5urWFgry09w4FyF9ruryDW3yDGFy5Zw43Ww47Cr95
        tF1UAFW3Cr18GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUO6pDUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBiA665VaEF9HHCQAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in aspeed_gfx_load(), clk_prepare_enable() might return an
unexpected value. using devm_clk_get_enabled() instead of
devm_clk_get() and clk_prepare_enable() can avoid this problem.

Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index c8c7f8215155..3d3ee70fb5ea 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -193,13 +193,12 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	}
 	reset_control_deassert(priv->rst);
 
-	priv->clk = devm_clk_get(drm->dev, NULL);
+	priv->clk = devm_clk_get_enabled(drm->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev,
 			"missing or invalid clk device tree entry");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
 
 	/* Sanitize control registers */
 	writel(0, priv->base + CRT_CTRL1);
-- 
2.17.1

