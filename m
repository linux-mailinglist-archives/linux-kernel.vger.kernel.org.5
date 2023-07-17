Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5C756616
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGQOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjGQOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:14:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4810F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:14:51 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCCD5660706D;
        Mon, 17 Jul 2023 15:14:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689603289;
        bh=CefhFqQ/uXdHAnQ63I1hQJ7LyexCUl3QyjqRS2AFcCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AK4xXbN33T2/2nMWz2vsx9EJjM6mHcA2ztaFJcKg0UWMS1zcZoQV6NAURVx5D7+zx
         xMePh/F61DvLmxQjqAvz5kIDFwtRsvj9ZOv3FS3XaAfdjopyE2dNKbwKYf+znv9TxA
         tmOKJWMVAvgenCdvRRAgO+CFWvc1pjiFhZCmWSIclWe7BBsyps67eV/bnBwi7EGu0/
         geiKRDPPE9sdD2UKYJPHtDIZtXj6oj7Kimy6XpkvwRDqK2yE01oj4GjhZZ7ZJlZMR9
         aZregpCBwM2QekulpgNx6+k5dvY8Ov4oGdYWcMNlWb9yryyYBsC90ZxXfl3R2Y0PB5
         ApKCB2TeqVGJQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org, nfraprado@collabora.com
Subject: [PATCH v6 07/11] drm/mediatek: dp: Avoid mutex locks if audio is not supported/enabled
Date:   Mon, 17 Jul 2023 16:14:34 +0200
Message-Id: <20230717141438.274419-8-angelogioacchino.delregno@collabora.com>
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

If a controller (usually, eDP!) does not support audio, or audio is not
enabled because the endpoint has no audio support, it's useless to lock
a mutex only to unlock it right after because there's no .plugged_cb().

Check if the audio is supported and enabled before locking the mutex in
mtk_dp_update_plugged_status(): if not, we simply return immediately.

While at it, since the update_plugged_status_lock mutex would not be
used if the controller doesn't support audio at all, initialize it
only if `audio_supported` is true.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 83e55f8dc84a..c1d1a882f1db 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1948,6 +1948,9 @@ static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 
 static void mtk_dp_update_plugged_status(struct mtk_dp *mtk_dp)
 {
+	if (!mtk_dp->data->audio_supported || !mtk_dp->audio_enable)
+		return;
+
 	mutex_lock(&mtk_dp->update_plugged_status_lock);
 	if (mtk_dp->plugged_cb && mtk_dp->codec_dev)
 		mtk_dp->plugged_cb(mtk_dp->codec_dev,
@@ -2520,11 +2523,11 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "failed to request mediatek dptx irq\n");
 
-	mutex_init(&mtk_dp->update_plugged_status_lock);
-
 	platform_set_drvdata(pdev, mtk_dp);
 
 	if (mtk_dp->data->audio_supported) {
+		mutex_init(&mtk_dp->update_plugged_status_lock);
+
 		ret = mtk_dp_register_audio_driver(dev);
 		if (ret) {
 			dev_err(dev, "Failed to register audio driver: %d\n",
-- 
2.40.1

