Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE579A4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjIKHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjIKHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:43:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D6FCD8;
        Mon, 11 Sep 2023 00:42:52 -0700 (PDT)
X-UUID: cd8fe498507611ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0C3N7fE/tvZGh5zMmznktAGbJMG4wluUCFEK7cRhxCs=;
        b=YgI24/BlgMRGtCm2nIFWPDPavrPMzcQWAbu//IvFiAsi83xBWnz0zFF9wHOn9tMUeijKHDM1GA/v7KU+8Roy4/i5fX0USsalLG3JpxtwJ3Mp22H0l61azRoZwwAUAvJVdpL/tLYtWeGnZ5v/6yDWa9oC/3Sdu7cAEhUSXX49qzw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:2deba069-8acc-41aa-aba6-c40cee164130,IP:0,U
        RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-30
X-CID-META: VersionHash:0ad78a4,CLOUDID:16a7e1c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
        KR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cd8fe498507611ee8051498923ad61e6-20230911
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1094365139; Mon, 11 Sep 2023 15:42:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 15:42:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 15:42:46 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "CK Hu" <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [RESEND PATCH v6 16/20] drm/mediatek: Make sure the power-on sequence of LARB and RDMA
Date:   Mon, 11 Sep 2023 15:42:29 +0800
Message-ID: <20230911074233.31556-17-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230911074233.31556-1-shawn.sung@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.540900-8.000000
X-TMASE-MatchedRID: o2aOeZd8J5DxoFpSGnAM9RWCVBr+Ay98LJXjpJzQSNPS79T8v6s2UQYB
        5gsbo0L8o5qw/iFKtvYWHIQM6TbbE8P8cHqjv+XY9Jn/ZrGuc8GZ2scyRQcer19eTSR8I6dufdQ
        7p2bSGhbi8zVgXoAltvbGdFF9BGjiC24oEZ6SpSkj80Za3RRg8BY3H5X13jn6v2WZ8cPFBdEqjU
        pS9j1J33n5P1YVYCsQib1buoYOTUU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.540900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6A810EF2783ABCB8DC6F102D8076577B3289DD0A94703E69469DEA308EFF6EC42000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since LARBs (Local ARBiter) have to be powered on before its users,
to ensure the power-on sequence, we created a device link between
RDMA and its LARB, and when pm_runtime_get_sync is called in RDMA,
system will guarantee the LARB is powered on before the RDMA.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index c3adaeefd551..fce6fbb534b1 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -244,10 +244,23 @@ size_t mtk_mdp_rdma_get_num_formats(struct device *dev)

 int mtk_mdp_rdma_clk_enable(struct device *dev)
 {
+	int ret;
 	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);

-	clk_prepare_enable(rdma->clk);
-	return 0;
+	/*
+	 * Since LARBs (Local ARBiter) have to be powered on before its users,
+	 * to ensure the power-on sequence, we created a device link between
+	 * RDMA and its LARB, and when pm_runtime_get_sync is called in RDMA,
+	 * system will make sure the LARB is powered on before the RDMA
+	 */
+	ret = pm_runtime_get_sync(dev);
+
+	if (ret < 0)
+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
+	else
+		ret = clk_prepare_enable(rdma->clk);
+
+	return ret;
 }

 void mtk_mdp_rdma_clk_disable(struct device *dev)
@@ -255,6 +268,9 @@ void mtk_mdp_rdma_clk_disable(struct device *dev)
 	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);

 	clk_disable_unprepare(rdma->clk);
+
+	/* Same reason as when enabling clock, turn the LARB off */
+	pm_runtime_put(dev);
 }

 static int mtk_mdp_rdma_bind(struct device *dev, struct device *master,
--
2.18.0

