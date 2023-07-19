Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F484758F96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGSHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGSHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:51:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A5F134
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:51:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F063B660704A;
        Wed, 19 Jul 2023 08:51:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689753070;
        bh=pH0eS322JL8A9XQUDj4YhAVk0Kl3Mp/XP1arLmFs7pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/tOVKwLVb7iMw6C/ZnKzmMECtfWtShZzz6LG2LIZ9x7CxakoAQLb+sQwYB1o2mYC
         C57V/Fq7TrgE7mZ0+XGT+oRM1DJS/UJKDOfyw6peF/PIF1f/1zfQsQjMFnU91XaruT
         Ge2/rx1bRHfY7YuGLeKI8E4tL4guS0+iNq8gZScOFQL0Wx95+vrcA6SjaWUJic/oBF
         qQYZRehZf9V76YKG+teySef8Imm5WIy9+TD0zt6iCcoKNMZ591qXe3OelZoCqsNzc3
         4vlDIOF4IyYOBv6rYMKSTNGXr3JfutHrNDyKNWiS7BWB2DTLBlyr+QlG4ZAQZMGGiJ
         DNMXlA6ZXnvkg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        fshao@chromium.org
Subject: [PATCH v2 5/6] drm/mediatek: mtk_dpi: Use devm_platform_ioremap_resource()
Date:   Wed, 19 Jul 2023 09:50:55 +0200
Message-Id: <20230719075056.72178-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com>
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the open-coded platform_get_resource, devm_ioremap_resource
switch to devm_platform_ioremap_resource(), also dropping the useless
struct resource pointer, which becomes unused.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 3a140498c98a..244340df7468 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1007,7 +1007,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_dpi *dpi;
-	struct resource *mem;
 	int ret;
 
 	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
@@ -1038,8 +1037,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 			dev_dbg(&pdev->dev, "Cannot find pinctrl active!\n");
 		}
 	}
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dpi->regs = devm_ioremap_resource(dev, mem);
+	dpi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dpi->regs))
 		return dev_err_probe(dev, PTR_ERR(dpi->regs),
 				     "Failed to ioremap mem resource\n");
-- 
2.40.1

