Return-Path: <linux-kernel+bounces-131063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C48982A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A43C1F22334
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F10B67A0E;
	Thu,  4 Apr 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FOu5bJCt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7695D724
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217483; cv=none; b=qZ8lJPn5DEbBJw8XlaQr4SU5aFiqWHo+UFUlOjX566KqE5s03CFf8x1VryBQejtVMdo/RY+ATXbycpJYByi2uiF8CGWXac/vtOgJZ0eUitrks3PMebjPpwPBGFIiPGhkFr0eCs0qAQf5tJcPloS+fCmTe/yAr7QKffsir70v+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217483; c=relaxed/simple;
	bh=KoiSh/u/4BD9iAcBgjvWczlcgOlHoosLFr6MB3Jm8Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJY3Xx0Q+IbPs4opU9rovmm7n2zGnvKLgpST/povSj1XBoPNL0xKpftx2OjzHk9ZBGTJQ2EXlDD9Fm3fYPGlqcAjx7dQjWhhauB25zNQvMxZM/yEPF//yElVOz5DTyOV1hK3eWLwsZrJsyDgFFBKRLkfL8TQ4hD0eVRBNV7dxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FOu5bJCt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712217480;
	bh=KoiSh/u/4BD9iAcBgjvWczlcgOlHoosLFr6MB3Jm8Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOu5bJCtAyMzxdyr8jDNAhgQn9IKDDnH1uRykOEPX0qZKiHPoXewXk1vwIpt4S0eT
	 Ympln2QU6MvpjNaVYVOcQ/nxpubzcFM8tpC33KfydDSK9znFhR741BEflS3SmDfl5S
	 uZGcPPN8Oiw7kqmWiHOKGcnxUTMP3M/XWvmqRFGcZAAimGst9OqB3r9evoLeiyPFLr
	 dCkcs7u8HUMprfS3Lfe9qJgR+0tqg5yqdp+N3DlWzVRqkFMndK1ItMWp5bHMIOrNf3
	 F9seAaunCjMunY7GLDEm6ytNHZp/8ABpu0aHiAKrCZ33ynRTjoTo6GNWhBuiuUp0M6
	 xUponJyRAtm1A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 15D003782129;
	Thu,  4 Apr 2024 07:57:59 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	nancy.lin@mediatek.com,
	nathan.lu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH v2 2/3] drm/mediatek: Perform iounmap on simple DDP component destruction
Date: Thu,  4 Apr 2024 09:57:53 +0200
Message-ID: <20240404075754.83455-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404075754.83455-1-angelogioacchino.delregno@collabora.com>
References: <20240404075754.83455-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mtk_ddp_comp_destroy() function and call it in the teardown
path of mtk_drm_drv to make sure that we unmap the iospace of the
simple DDP components.

While at it, also fix iounmapping on mtk_ddp_comp_init() error path.

Fixes: ff1395609e20 ("drm/mediatek: Move mtk_ddp_comp_init() from sub driver to DRM driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 38 ++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  4 ++-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 82d7a6887f44..477fc1950a0e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -627,8 +627,11 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 
 	priv->regs = of_iomap(node, 0);
 	priv->clk = of_clk_get(node, 0);
-	if (IS_ERR(priv->clk))
+	if (IS_ERR(priv->clk)) {
+		iounmap(priv->regs);
+		priv->regs = NULL;
 		return PTR_ERR(priv->clk);
+	}
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(comp->dev, &priv->cmdq_reg, 0);
@@ -640,3 +643,36 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 
 	return 0;
 }
+
+void mtk_ddp_comp_destroy(struct mtk_ddp_comp *comp)
+{
+	struct mtk_ddp_comp_dev *priv;
+
+	if (!comp || !comp->dev)
+		return;
+
+	/* Complex components are destroyed with their own remove callback */
+	if (mtk_ddp_matches[comp->id].type == MTK_DISP_AAL ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_BLS ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_CCORR ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_COLOR ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_GAMMA ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_MERGE ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_OVL ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_OVL_2L ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_PWM ||
+	    mtk_ddp_matches[comp->id].type == MTK_DISP_RDMA ||
+	    mtk_ddp_matches[comp->id].type == MTK_DPI ||
+	    mtk_ddp_matches[comp->id].type == MTK_DP_INTF ||
+	    mtk_ddp_matches[comp->id].type == MTK_DSI)
+		return;
+
+	priv = dev_get_drvdata(comp->dev);
+	if (!priv)
+		return;
+
+	if (priv->regs) {
+		iounmap(priv->regs);
+		priv->regs = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 93d79a1366e9..3d147217caa4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -330,6 +330,7 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
 						struct device *dev);
 int mtk_ddp_comp_init(struct device_node *comp_node, struct mtk_ddp_comp *comp,
 		      unsigned int comp_id);
+void mtk_ddp_comp_destroy(struct mtk_ddp_comp *comp);
 enum mtk_ddp_comp_type mtk_ddp_comp_get_type(unsigned int comp_id);
 void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 		   struct cmdq_client_reg *cmdq_reg, void __iomem *regs,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 74832c213092..7e240d16d3e5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -946,8 +946,10 @@ static void mtk_drm_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &mtk_drm_ops);
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
-	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
+	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++) {
+		mtk_ddp_comp_destroy(&private->ddp_comp[i]);
 		of_node_put(private->comp_node[i]);
+	}
 }
 
 static int mtk_drm_sys_prepare(struct device *dev)
-- 
2.44.0


