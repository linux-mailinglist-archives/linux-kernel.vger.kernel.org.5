Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C82A75660B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjGQOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjGQOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:14:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE01A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:14:46 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A4BF16607014;
        Mon, 17 Jul 2023 15:14:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689603284;
        bh=9oUBdhJxcjM5c8eCCSSOcqllo9ke9sPNjeRntNkLNoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeYzdmgz451EjrdZo/zdtYmOyZJdAqLoIhaELRWmIqur4GlMcs3zKmEo90E72X8Ty
         3HVRCAt2HIi3mYzFGcG808hwhyH2r3PVBb78RQ8gRjoOzHlNdFReAc1xMiudCTe3ph
         1tFbXQLW3OpziaEM8CIatOvs/QJerwnhFza1tA4RtdQ9cc/yOA621C+xxGk7ztRUpe
         /wYMEc7oK6M0TRiPp8Bk2ds0C7RBLmpaGKd/iC0iFjt/KsJvWCG+ugSc8g4P3wNo6d
         u5vQfYYh7hc3HDfWv53eyb+5WwQzF+Km0k0CZZaaoZncB246/sYKB8FAvAYiqRc8+k
         mCnkzDomm7B4Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v6 01/11] drm/mediatek: dp: Add missing error checks in mtk_dp_parse_capabilities
Date:   Mon, 17 Jul 2023 16:14:28 +0200
Message-Id: <20230717141438.274419-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If reading the RX capabilities fails the training pattern will be set
wrongly: add error checking for drm_dp_read_dpcd_caps() and return if
anything went wrong with it.

While at it, also add a less critical error check when writing to
clear the ESI0 IRQ vector.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 64eee77452c0..c58b775877a3 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1588,7 +1588,9 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 	u8 val;
 	ssize_t ret;
 
-	drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
+	ret = drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
+	if (ret < 0)
+		return ret;
 
 	if (drm_dp_tps4_supported(mtk_dp->rx_cap))
 		mtk_dp->train_info.channel_eq_pattern = DP_TRAINING_PATTERN_4;
@@ -1615,10 +1617,13 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 			return ret == 0 ? -EIO : ret;
 		}
 
-		if (val)
-			drm_dp_dpcd_writeb(&mtk_dp->aux,
-					   DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
-					   val);
+		if (val) {
+			ret = drm_dp_dpcd_writeb(&mtk_dp->aux,
+						 DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
+						 val);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.40.1

