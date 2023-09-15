Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB777A17E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjIOH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjIOH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:58:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9519193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:58:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4B6C433C9;
        Fri, 15 Sep 2023 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694764691;
        bh=t+ZshDk3vSry1uc6hCwYDbU+R1dULuj35xmF6dRVMrk=;
        h=From:To:Cc:Subject:Date:From;
        b=rvwj7lj8FTEWHvf1wUbhIc8CK5XVM4UyBTKgXnVGlvnMvDvIiuwrT/7wJJHf8L0/j
         DQLpHPOpajgELw/genwY5AfrHU5D1bHCuW6T49J9ge+LlUSOPyhj7o9KzuqPyblGT4
         iBeGAJoKwE5SH581mv/T5N5N1tit9oDbbA4VThjaayi07QnsmCLKIFl/rIQvc0lfUQ
         JEb+NxHkp8yCmzPRNnSUk11iIZijw9jWj90cvNjn2WzJPll/L01f1DCDP7JJVJit+l
         03onA6v36HsZ/+RKmw/UU+AOoCqlTnxeWDIm7kfiuGeBOIxMSvceyppdQTViv7Yp1p
         P5P33W5K4xkuA==
From:   Michael Walle <mwalle@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
Subject: [PATCH] drm/mediatek: dsi: Fix EOTp generation
Date:   Fri, 15 Sep 2023 09:57:56 +0200
Message-Id: <20230915075756.263591-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c87d1c4b5b9a ("drm/mediatek: dsi: Use symbolized register
definition") inverted the logic of the control bit. Maybe it was because
of the bad naming which was fixed in commit 0f3b68b66a6d ("drm/dsi: Add
_NO_ to MIPI_DSI_* flags disabling features"). In any case, the logic
wrong and there will be no EOTp on the DSI link by default. Fix it.

Fixes: c87d1c4b5b9a ("drm/mediatek: dsi: Use symbolized register definition")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index d67e5c61a9b9..8024b20f6b13 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -407,7 +407,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 	if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
 		tmp_reg |= HSTX_CKLP_EN;
 
-	if (!(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET))
+	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		tmp_reg |= DIS_EOT;
 
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
-- 
2.39.2

