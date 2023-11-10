Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD567E7692
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjKJB3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjKJB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:29:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B744A4;
        Thu,  9 Nov 2023 17:29:41 -0800 (PST)
X-UUID: 950de4be7f6811eea33bb35ae8d461a2-20231110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LwLaIgMGWJSJFkr+2QiUxV9wT496qyWwMkmiQeFkrzA=;
        b=jkMz74ilxxBQnU1Jowy7OJpCrgiO4UuC9KTmUS3wkxl7aYyJkhvvuZ9LDBdZ/DrH1JuL4pf6FNlpxh7e9kowRnXasVaexpvSzMcEUCjBRiajXIaMMxhL/ri/4J4HrrEipPD1pUbEKlahNPcQ248uB1jVjT+YuR40HLdUwCo0OIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:bbf98bbb-3440-49ba-a266-59a448a05438,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:714f5cfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 950de4be7f6811eea33bb35ae8d461a2-20231110
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <stuart.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 14454135; Fri, 10 Nov 2023 09:29:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Nov 2023 09:29:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Nov 2023 09:29:24 +0800
From:   Stuart Lee <stuart.lee@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Stuart Lee <stuart.lee@mediatek.com>,
        Lancelot Wu <lancelot.wu@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/1] drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get
Date:   Fri, 10 Nov 2023 09:29:14 +0800
Message-ID: <20231110012914.14884-2-stuart.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231110012914.14884-1-stuart.lee@mediatek.com>
References: <20231110012914.14884-1-stuart.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error handling to check NULL input in
mtk_drm_crtc_dma_dev_get function.

While display path is not configured correctly, none of crtc is
established. So the caller of mtk_drm_crtc_dma_dev_get may pass
input parameter *crtc as NULL, Which may cause coredump when
we try to get the container of NULL pointer.

Fixes: cb1d6bcca542 ("drm/mediatek: Add dma dev get function")
Signed-off-by: Stuart Lee <stuart.lee@mediatek.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c277b9fae950..047c9a31d306 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -921,7 +921,14 @@ static int mtk_drm_crtc_init_comp_planes(struct drm_device *drm_dev,
 
 struct device *mtk_drm_crtc_dma_dev_get(struct drm_crtc *crtc)
 {
-	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_drm_crtc *mtk_crtc = NULL;
+
+	if (!crtc)
+		return NULL;
+
+	mtk_crtc = to_mtk_crtc(crtc);
+	if (!mtk_crtc)
+		return NULL;
 
 	return mtk_crtc->dma_dev;
 }
-- 
2.18.0

