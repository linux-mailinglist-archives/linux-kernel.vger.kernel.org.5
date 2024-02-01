Return-Path: <linux-kernel+bounces-48173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B484583A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE971C29C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ACF5337D;
	Thu,  1 Feb 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FLckKJ25"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19365336C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791998; cv=none; b=sMW3pjhsUPVIe7pRHB8RTdBJXk+i6l3Pk6E/sFQbUxDVSOSZ2VximRGKuq/iETkTTft86hnVxXi2c/E6tzN+Pvzd2Ptmdj0aEL3StHIkvzeRXdCwWLWeOx+AruSNh8Z4SgAOHL69DzqTNyXsfOZUAzaQwgxqJl1JTlCMJTKiepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791998; c=relaxed/simple;
	bh=soGWShtp1fE1scZOoOivLMJWWmkLBlGxzNtJ8q6CdrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jd7XVypZC7ZXH4aKRfKeV6Yo4GXVDQxTSD2iOLtByfoS5yPLj7bXkgxczPg8cNxZIPcvwzzh5XZhX0yb9arKbb9Je9TNWZ1Cbd7buVeRayymS0dmgcwH71jIIKpHpR2gsPG6WIBTs0dxbGW4hUx01yIMsnv0u1XwxMd2Ev4/7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FLckKJ25; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706791995;
	bh=soGWShtp1fE1scZOoOivLMJWWmkLBlGxzNtJ8q6CdrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLckKJ25YStrCwmV5MWq9MkI58ksS265iNzGTCslvCL7vXFE/iaCWN+y/AbxvW/wr
	 /AWfHHLIw1Jj2gPYOyGWpMiGHNebUb0hqknVb2A1EdrIxi8+WK3OJqA6/zKuxHL81d
	 gBAd7nCFnQW+KPC1BxbLJ9Z5V7iTkAQQps5Cw5C0xzhoLNRoDZm4carNn7fF8VgKlG
	 5wUx/DJ5Fq0/S/0KDldTsfIM1TwkXWPu7v773LjRdSBRa+dWmc3JFjJDVoQLsRSt3T
	 yFaaSqo0D5sMcwUCiB1xdYr6IDbSOlEzhLyvriE6h2i58sn/hmlm9TCZngXmW3bbIw
	 NWp6Wy4es1BkQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 48339378208F;
	Thu,  1 Feb 2024 12:53:14 +0000 (UTC)
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
Subject: [PATCH 3/3] drm/mediatek: drm_ddp_comp: Add mtk_ddp_is_simple_comp() internal helper
Date: Thu,  1 Feb 2024 13:53:04 +0100
Message-ID: <20240201125304.218467-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
References: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the simple component check to a new mtk_ddp_is_simple_comp()
internal helper to reduce code duplication.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 57 +++++++++++----------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 539b526a6b0a..4ca2a02ada3c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -575,6 +575,29 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
 	return ret;
 }
 
+static bool mtk_ddp_is_simple_comp(enum mtk_ddp_comp_type type)
+{
+	switch (type) {
+	case MTK_DISP_AAL:
+	case MTK_DISP_BLS:
+	case MTK_DISP_CCORR:
+	case MTK_DISP_COLOR:
+	case MTK_DISP_GAMMA:
+	case MTK_DISP_MERGE:
+	case MTK_DISP_OVL:
+	case MTK_DISP_OVL_2L:
+	case MTK_DISP_OVL_ADAPTOR:
+	case MTK_DISP_PWM:
+	case MTK_DISP_RDMA:
+	case MTK_DP_INTF:
+	case MTK_DPI:
+	case MTK_DSI:
+		return false;
+	default:
+		return true;
+	}
+}
+
 int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 		      unsigned int comp_id)
 {
@@ -605,19 +628,13 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	}
 	comp->dev = &comp_pdev->dev;
 
-	if (type == MTK_DISP_AAL ||
-	    type == MTK_DISP_BLS ||
-	    type == MTK_DISP_CCORR ||
-	    type == MTK_DISP_COLOR ||
-	    type == MTK_DISP_GAMMA ||
-	    type == MTK_DISP_MERGE ||
-	    type == MTK_DISP_OVL ||
-	    type == MTK_DISP_OVL_2L ||
-	    type == MTK_DISP_PWM ||
-	    type == MTK_DISP_RDMA ||
-	    type == MTK_DPI ||
-	    type == MTK_DP_INTF ||
-	    type == MTK_DSI)
+	/*
+	 * Resources for simple components are retrieved here as those are
+	 * managed in here without the need of more complex drivers; for
+	 * the latter, their respective probe function will do the job, so
+	 * we must avoid getting their resources here.
+	 */
+	if (!mtk_ddp_is_simple_comp(type))
 		return 0;
 
 	priv = devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
@@ -651,19 +668,7 @@ void mtk_ddp_comp_destroy(struct mtk_ddp_comp *comp)
 		return;
 
 	/* Complex components are destroyed with their own remove callback */
-	if (type == MTK_DISP_AAL ||
-	    type == MTK_DISP_BLS ||
-	    type == MTK_DISP_CCORR ||
-	    type == MTK_DISP_COLOR ||
-	    type == MTK_DISP_GAMMA ||
-	    type == MTK_DISP_MERGE ||
-	    type == MTK_DISP_OVL ||
-	    type == MTK_DISP_OVL_2L ||
-	    type == MTK_DISP_PWM ||
-	    type == MTK_DISP_RDMA ||
-	    type == MTK_DPI ||
-	    type == MTK_DP_INTF ||
-	    type == MTK_DSI)
+	if (!mtk_ddp_is_simple_comp(mtk_ddp_matches[comp->id].type))
 		return;
 
 	priv = dev_get_drvdata(comp->dev);
-- 
2.43.0


