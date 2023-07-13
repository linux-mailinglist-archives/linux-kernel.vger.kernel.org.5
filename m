Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C8751C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjGMJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGMJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:02:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA262D75
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:02:01 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 500256607046;
        Thu, 13 Jul 2023 10:01:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689238919;
        bh=CiPODnRZ6evrIt01xXGr3U8QXFkLTGZgP/HUd0cTANY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYlxXQ1xMwEs0myZAScFeWHdMm/4UCg1icTy8b6QnqYhmCIkR8W/mmncCYGn0TPOO
         rHH2dr5vWCTnFDDN21fY0Fa6VjypvF4FsfzauMkILP/FggMkFlGQftMu3fdCfimi84
         WX/8tU2uwyipapNpI2TW6X2EQaJoEL52whppAkCi7QJ3b7v4Ds1qAtRzW5qDs0GUu3
         2ypuluDiElEP1G87qvuDxYr12U9T3mNdnCaoNJPbp5rotfi5ELcyz0Pou8GZP86E2Y
         8umQ+UD+3LFZwPaJlgIG8mkPcxleiTowpReUfi63cdLYwiaH5NqkpR4mrHaXSV4uMy
         ZjO41WO46aNQg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v5 02/10] drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()
Date:   Thu, 13 Jul 2023 11:01:44 +0200
Message-Id: <20230713090152.140060-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
References: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
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

Change logging from drm_{err,info}() to dev_{err,info}() in functions
mtk_dp_aux_transfer() and mtk_dp_aux_do_transfer(): this will be
essential to avoid getting NULL pointer kernel panics if any kind
of error happens during AUX transfers happening before the bridge
is attached.

This may potentially start happening in a later commit implementing
aux-bus support, as AUX transfers will be triggered from the panel
driver (for EDID) before the mtk-dp bridge gets attached, and it's
done in preparation for the same.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 8b7ded1746f3..a6a05ea6a53c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -847,7 +847,7 @@ static int mtk_dp_aux_do_transfer(struct mtk_dp *mtk_dp, bool is_read, u8 cmd,
 		u32 phy_status = mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_3628) &
 				 AUX_RX_PHY_STATE_AUX_TX_P0_MASK;
 		if (phy_status != AUX_RX_PHY_STATE_AUX_TX_P0_RX_IDLE) {
-			drm_err(mtk_dp->drm_dev,
+			dev_err(mtk_dp->dev,
 				"AUX Rx Aux hang, need SW reset\n");
 			return -EIO;
 		}
@@ -2049,7 +2049,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 		is_read = true;
 		break;
 	default:
-		drm_err(mtk_aux->drm_dev, "invalid aux cmd = %d\n",
+		dev_err(mtk_dp->dev, "invalid aux cmd = %d\n",
 			msg->request);
 		ret = -EINVAL;
 		goto err;
@@ -2065,7 +2065,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 					     to_access, &msg->reply);
 
 		if (ret) {
-			drm_info(mtk_dp->drm_dev,
+			dev_info(mtk_dp->dev,
 				 "Failed to do AUX transfer: %d\n", ret);
 			goto err;
 		}
-- 
2.40.1

