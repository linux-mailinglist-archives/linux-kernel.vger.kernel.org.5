Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D967D697A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjJYKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:49:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168BBB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:49:46 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADE27660731F;
        Wed, 25 Oct 2023 11:49:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698230985;
        bh=9Tz11dV1gF0knOECb4CmRHRhrmCR7btgyLRsf9oipxs=;
        h=From:To:Cc:Subject:Date:From;
        b=XMHQ/lu2klLU+B4oEWjXysMybAukvNjzrEsnN9hr53/HTq1YluCERrAL2wjoeNi74
         l+FI7+M9qp+Fk3wBaZYqgI0JdLG0ZKj5hDYGBSYITpDGD6z2ILDTH/ERfv8lh++DUd
         evnPHO/MQhGpG2xJUOz/SKqre0ZipRzs5IXbbhPdx72nKGsfv5B9xDka9LjM7ZLEcm
         WgB/7Hw44JxYkEhHvaulUumQl3tCmQqduHEbWjy8hgqSf84Flsj5warXCP31p63nq5
         M7zPPqiCAgwQshKuzoJ0I8RbMWEtUsKFUrTBXSJamJnGftGE2U9eccewFQYKfmkOAH
         14SkEm/DXGrAg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        ck.hu@mediatek.com, nfraprado@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] drm: mediatek: mtk_disp_gamma: Fix breakage due to merge issue
Date:   Wed, 25 Oct 2023 12:49:40 +0200
Message-ID: <20231025104940.140605-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the commit that was sent to the mailing lists was fine, something
happened during merge and the mtk_gamma_set() function got broken as
a writel() was turned into a readl().

Fix that by changing that back to the expected writel().

Fixes: a6b39cd248f3 ("drm/mediatek: De-commonize disp_aal/disp_gamma gamma_set functions")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 2fada9d6c95f..52c752bc5f41 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -203,7 +203,7 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
 	/* Disable RELAY mode to pass the processed image */
 	cfg_val &= ~GAMMA_RELAY_MODE;
 
-	cfg_val = readl(gamma->regs + DISP_GAMMA_CFG);
+	writel(cfg_val, gamma->regs + DISP_GAMMA_CFG);
 }
 
 void mtk_gamma_config(struct device *dev, unsigned int w,
-- 
2.42.0

