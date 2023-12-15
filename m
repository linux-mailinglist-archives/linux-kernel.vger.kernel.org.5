Return-Path: <linux-kernel+bounces-776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB01A8145E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2171F235DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161E1C2A8;
	Fri, 15 Dec 2023 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pb8PJbqp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350C1A70D;
	Fri, 15 Dec 2023 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702637164;
	bh=vBgnugLtJ2ksG5oto5YXrGX8SezSV/Kyn/381DDZeYc=;
	h=From:To:Cc:Subject:Date:From;
	b=pb8PJbqphVWYId84ZtJMvFx1CSLEHxwibQFvmpAV6BPTT5zPu4AEd59vDh7i6d1By
	 y53CNsHbMrgc2CEi94oADY0uGtBCNQpWRRCyDBK/Zc0BcZ891quCtKhe6q+6gcLx+j
	 L2UJkfxoaFXO69OGz+62j0dy0CsX1J8KsDhd6ZBEAokxqtSSZU+rJvmefOEwkb9D7W
	 FS6I+6ZMMAuNnWIMGFxtMOw+IKwTr/On/GaIMWe2x+10JqnFqyfnqnqtitpUjs3b8L
	 xbvoEaKKSxY7c9Q9sonGldx3Bg0Gs+GfsA6nhU9zxm2IwMAbsSe9imTTo99Ty3Q72y
	 K0Hq1FGidKiCA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3207378107D;
	Fri, 15 Dec 2023 10:46:03 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	linux-media@vger.kernel.org,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2 1/7] media: mediatek: vcodec: fix possible unbalanced PM counter
Date: Fri, 15 Dec 2023 12:45:45 +0200
Message-Id: <20231215104551.233679-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible that mtk_vcodec_enc_pw_on fails, and in that scenario
the PM counter is not incremented, and subsequent call to
mtk_vcodec_enc_pw_off decrements the counter, leading to a PM imbalance.
Fix by bailing out of venc_if_encode in the case when mtk_vcodec_enc_pw_on
fails.

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes in v2:
- collect R-b

 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c     | 4 +++-
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h     | 2 +-
 drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c | 5 ++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
index a22b7dfc656e..1a2b14a3e219 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
@@ -58,13 +58,15 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *mtkdev)
 	return 0;
 }
 
-void mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm)
+int mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm)
 {
 	int ret;
 
 	ret = pm_runtime_resume_and_get(pm->dev);
 	if (ret)
 		dev_err(pm->dev, "pm_runtime_resume_and_get fail: %d", ret);
+
+	return ret;
 }
 
 void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm)
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
index 157ea08ba9e3..2e28f25e36cc 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
@@ -10,7 +10,7 @@
 #include "mtk_vcodec_enc_drv.h"
 
 int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *dev);
-void mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm);
+int mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
index c402a686f3cb..e83747b8d69a 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
@@ -64,7 +64,9 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	ctx->dev->curr_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
-	mtk_vcodec_enc_pw_on(&ctx->dev->pm);
+	ret = mtk_vcodec_enc_pw_on(&ctx->dev->pm);
+	if (ret)
+		goto venc_if_encode_pw_on_err;
 	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->encode(ctx->drv_handle, opt, frm_buf,
 				  bs_buf, result);
@@ -75,6 +77,7 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	ctx->dev->curr_ctx = NULL;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
+venc_if_encode_pw_on_err:
 	mtk_venc_unlock(ctx);
 	return ret;
 }
-- 
2.34.1


