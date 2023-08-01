Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD20676B433
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjHAL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjHAL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:59:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C78019AD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:59:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30348660719D;
        Tue,  1 Aug 2023 12:59:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690891149;
        bh=bIIKYPpYUW37n4evWOm2DHgCvgnXkZJWa85NMhhI5KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8L3xSkhM43WY2zCAVf4lrFLzu0YDc4g8Rvuvsws+5WWL2Dsg6KEitCIF42I7IAu7
         hHepBpPfvYvfGjcEJSju1h1pMBubK4y7+isthEAX9vQvSFRE3QKekb43FZj+n2YV90
         IYd8Uo3r672x0TTsf6rr2xxSmCz3kHCLewi/JKxgdOqq4BBijppuht0VodxK/p4i08
         gAm4Wn/2yrAYuCJYZyY+0cLN1DHiO9Q0JM4n2LUrStTNEzEDfOv99lZj4Vj9inuAFn
         SYBwIbk0SKuhFQKWm+d8Ga8usVC6838e5cpqlxfIRetgJxTdQVWduylSi4o/wgC5wL
         tsJBAEPJzgppw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v8 10/13] drm/mediatek: gamma: Make sure relay mode is disabled
Date:   Tue,  1 Aug 2023 13:58:51 +0200
Message-ID: <20230801115854.150346-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
References: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable relay mode at the end of LUT programming to make sure that the
processed image goes through.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 12614cc26bf8..6591797ed10c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -19,6 +19,7 @@
 #define DISP_GAMMA_EN				0x0000
 #define GAMMA_EN					BIT(0)
 #define DISP_GAMMA_CFG				0x0020
+#define GAMMA_RELAY_MODE				BIT(0)
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
@@ -192,6 +193,9 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs,
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
+	/* Disable RELAY mode to pass the processed image */
+	cfg_val &= ~GAMMA_RELAY_MODE;
+
 	writel(cfg_val, regs + DISP_GAMMA_CFG);
 }
 
-- 
2.41.0

