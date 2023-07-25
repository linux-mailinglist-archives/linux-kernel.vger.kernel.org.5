Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1F760BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGYHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjGYHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:34:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ED41BF6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:32:51 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7024D6607108;
        Tue, 25 Jul 2023 08:32:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690270370;
        bh=dr99OhwRka0b6+lAYNS1mwFM6qaBC8ZcI/J5NoLdlok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSi16ofMtB8ehG3tBUD1CVjNeDNuqYAfS2USiOTgz8qYecdNQfzoPsjhIAuE8tGFM
         OQ8+y0S+IVKN2oTWSZWU7qQNESjNmiSmb5+mNl8Ot1dm6CjNjLRk7NAQW1LpspsdDN
         xXtojEbHdmtddg+K5E3VJVCiS/p181DbTFD9bAj6/8atOtdzi4b02WFRH7A66rZc/Q
         tR00Fh0S2hQnB9FB0aiTZbZPBNSP+dJfBLBqXHSy6FLUUSmKVtUlRNK2UCkp7akazj
         VZQaBZSo3Nib7cqzHrDf2nbTbvrLsXNDmseskscPM/FYqVf14iYncSdMDoQmwzQk5p
         KV2WAgO/Z8JVA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com,
        ehristev@collabora.com, CK Hu <ck.hu@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 04/11] drm/mediatek: dp: Use devm variant of drm_bridge_add()
Date:   Tue, 25 Jul 2023 09:32:27 +0200
Message-ID: <20230725073234.55892-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
References: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for aux-bus, which will add a code
path that may fail after the drm_bridge_add() call, change that to
devm_drm_bridge_add() to simplify failure paths later.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 98f63d8230e4..fc6cabf5370b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2552,7 +2552,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
 	mtk_dp->bridge.type = mtk_dp->data->bridge_type;
 
-	drm_bridge_add(&mtk_dp->bridge);
+	ret = devm_drm_bridge_add(dev, &mtk_dp->bridge);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add bridge\n");
 
 	mtk_dp->need_debounce = true;
 	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
@@ -2570,7 +2572,6 @@ static int mtk_dp_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	del_timer_sync(&mtk_dp->debounce_timer);
-	drm_bridge_remove(&mtk_dp->bridge);
 	platform_device_unregister(mtk_dp->phy_dev);
 	if (mtk_dp->audio_pdev)
 		platform_device_unregister(mtk_dp->audio_pdev);
-- 
2.41.0

