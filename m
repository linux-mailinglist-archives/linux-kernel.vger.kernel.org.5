Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E7790193
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjIARqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjIARqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556DE5A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61B78B82515
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E9C433C8;
        Fri,  1 Sep 2023 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693590364;
        bh=z9MFcKUA2gr9p3j7guEmqBFsjLvJtfm5s1/pUyVg+9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=k/5mo1IkqXCkSxQa+gyzgn6haj2cRQXCR4ZFizjIzBSukbJhsL/7CdHHWrtyP8Oj7
         fNL/IkYS/90YeimQkiMbkRZ0wdeeUxL2upgGMOcANCUa69e74yXdMux554fF+ruGqL
         g/ck3fVYUVmRudEeBrQHKSDTSFZwHyTVX78/BGZnhzk8OKYzv8s9nN0SFFInwrJoFs
         PHE2nE11z3911CIRAE8+iM9ngoCsdK1NGz3CzRYYDNFSo/zw+ICiSU0BDxbjQRzXob
         Dh4+rszthPUp0fkr5aqSPa6Ad8CJyxansjQXNZPogGiNsZa14qFF5RgoiD5UiU0r4C
         PiHkSeqVQAAzg==
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
Subject: [PATCH v3 1/2] drm/mediatek: fix kernel oops if no crtc is found
Date:   Fri,  1 Sep 2023 19:45:56 +0200
Message-Id: <20230901174557.3617839-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_crtc_from_index(0) might return NULL if there are no CRTCs
registered at all which will lead to a kernel oops in
mtk_drm_crtc_dma_dev_get(). Add the missing return value check.

Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
v3:
 - none
v2:
 - collected tags
 - fixed typos
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 93552d76b6e7..2c582498817e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -420,6 +420,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	struct mtk_drm_private *private = drm->dev_private;
 	struct mtk_drm_private *priv_n;
 	struct device *dma_dev = NULL;
+	struct drm_crtc *crtc;
 	int ret, i, j;
 
 	if (drm_firmware_drivers_only())
@@ -494,7 +495,9 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	}
 
 	/* Use OVL device for all DMA memory allocations */
-	dma_dev = mtk_drm_crtc_dma_dev_get(drm_crtc_from_index(drm, 0));
+	crtc = drm_crtc_from_index(drm, 0);
+	if (crtc)
+		dma_dev = mtk_drm_crtc_dma_dev_get(crtc);
 	if (!dma_dev) {
 		ret = -ENODEV;
 		dev_err(drm->dev, "Need at least one OVL device\n");
-- 
2.39.2

