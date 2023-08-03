Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB476E642
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHCLDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjHCLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:02:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65830ED
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:02:28 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 208ED66071A3;
        Thu,  3 Aug 2023 12:02:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691060547;
        bh=ozW4byw7zGTKaXL8BQX+fQ96tzc29duKFdiPZzdm3yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3gfGe/IZJORkDKC1SAjovki/4zP/YwX2c7qYeKxY/wsSpaFFtE4N36/CnSsQEd7c
         O1FRXDn0wJRKIEa78Kw9ZpnypykA8qz0oa5pfUmSnXc+kbnto+syVj7MQ1oB1AoiA1
         SASjNvSlaiLjMCoRvkGasYM5buYhXnNO1ESfMbtFKz8dvId1+7IC3as6PMqsLv95+H
         +8QP91+OPxPKyLbB+asc+Ey6eS9dWmDUH0iDLmUTi+29TeGymHry4jmlwpLwu/zXmf
         iY9eL8ILqgGsF4DxgdA2jEo3Ly8SsPN42oIh4wLULGD2Rh9wkA5eqpIKCJq3HxHjB2
         mhxUnrUDu3Yqw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: [PATCH v9 07/16] drm/mediatek: aal: Use bitfield macros
Date:   Thu,  3 Aug 2023 13:02:05 +0200
Message-ID: <20230803110214.163645-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803110214.163645-1-angelogioacchino.delregno@collabora.com>
References: <20230803110214.163645-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more robust and improve readability by using bitfield
macros instead of open coding bit operations.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index e2e4155faf01..05790b444e17 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -18,6 +18,8 @@
 #define DISP_AAL_EN				0x0000
 #define AAL_EN						BIT(0)
 #define DISP_AAL_SIZE				0x0030
+#define DISP_AAL_SIZE_HSIZE				GENMASK(28, 16)
+#define DISP_AAL_SIZE_VSIZE				GENMASK(12, 0)
 #define DISP_AAL_OUTPUT_SIZE			0x04d8
 #define DISP_AAL_LUT_SIZE			512
 
@@ -56,9 +58,13 @@ void mtk_aal_config(struct device *dev, unsigned int w,
 			   unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
 	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
+	u32 sz;
 
-	mtk_ddp_write(cmdq_pkt, w << 16 | h, &aal->cmdq_reg, aal->regs, DISP_AAL_SIZE);
-	mtk_ddp_write(cmdq_pkt, w << 16 | h, &aal->cmdq_reg, aal->regs, DISP_AAL_OUTPUT_SIZE);
+	sz = FIELD_PREP(DISP_GAMMA_SIZE_HSIZE, w);
+	sz |= FIELD_PREP(DISP_GAMMA_SIZE_VSIZE, h);
+
+	mtk_ddp_write(cmdq_pkt, sz, &aal->cmdq_reg, aal->regs, DISP_AAL_SIZE);
+	mtk_ddp_write(cmdq_pkt, sz, &aal->cmdq_reg, aal->regs, DISP_AAL_OUTPUT_SIZE);
 }
 
 /**
-- 
2.41.0

