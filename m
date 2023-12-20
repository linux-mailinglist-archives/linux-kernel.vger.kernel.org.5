Return-Path: <linux-kernel+bounces-6720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767BC819C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C2CB21D45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8120326;
	Wed, 20 Dec 2023 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Uqc9QLJc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19A2030C;
	Wed, 20 Dec 2023 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 252672be9f2111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xW752tpTPFMC17bGKgP0Se5gHibWuW19EVYb5yBViY0=;
	b=Uqc9QLJcEqQ2EROJVrgyrsNDyY8zoP1p+cOxJfTz3oliTpo1qIyMpE1mL1qUO0ezpJmTIUAqSsK2zqav4+XEBiEoshiGMp4xaSDbIAPCsn4mhFN0SFc8UOHOtipZ9bMIixwJKX50/L6rhua8oY/9wTzsmat50dti+TUMkX+lU58=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a2b9478d-daef-405a-831f-01fec3aa7dc1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:2fda4b2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 252672be9f2111eea5db2bebc7c28f94-20231220
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1081529620; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:18:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:18:39 +0800
From: Moudy Ho <moudy.ho@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v9 06/12] media: platform: mtk-mdp3: avoid multiple driver registrations
Date: Wed, 20 Dec 2023 18:18:32 +0800
Message-ID: <20231220101838.21510-7-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231220101838.21510-1-moudy.ho@mediatek.com>
References: <20231220101838.21510-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The amount of MDP3 driver probes is determined by the registered
clocks of MMSYS.
Since MT8195 MDP3 utilizes VPPSYS0 and VPPSYS1, it's necessary to
prevent multiple driver registrations.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c  | 1 +
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 8 ++++++++
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index fe92c0474bfa..6f77c33074ec 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -410,6 +410,7 @@ static const struct mdp_pipe_info mt8183_pipe_info[] = {
 
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_plat_id = MT8183,
+	.mdp_con_res = 0x14001000,
 	.mdp_probe_infra = mt8183_mdp_probe_infra,
 	.mdp_cfg = &mt8183_plat_cfg,
 	.mdp_mutex_table_idx = mt8183_mutex_idx,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 4802b20d7f20..6ddb5e075f5d 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -211,6 +211,7 @@ static int mdp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mdp_dev *mdp;
 	struct platform_device *mm_pdev;
+	struct resource *res;
 	int ret, i, mutex_id;
 
 	mdp = kzalloc(sizeof(*mdp), GFP_KERNEL);
@@ -222,6 +223,12 @@ static int mdp_probe(struct platform_device *pdev)
 	mdp->pdev = pdev;
 	mdp->mdp_data = of_device_get_match_data(&pdev->dev);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res->start != mdp->mdp_data->mdp_con_res) {
+		platform_set_drvdata(pdev, mdp);
+		goto success_return;
+	}
+
 	ret = mdp_mm_subsys_deploy(mdp, MDP_INFRA_MMSYS);
 	if (ret)
 		goto err_destroy_device;
@@ -311,6 +318,7 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_unregister_device;
 	}
 
+success_return:
 	dev_dbg(dev, "mdp-%d registered successfully\n", pdev->id);
 	return 0;
 
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index ece6509666fd..22d1b17ef2fc 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -71,6 +71,7 @@ enum mdp_pipe_id {
 
 struct mtk_mdp_driver_data {
 	const int mdp_plat_id;
+	const resource_size_t mdp_con_res;
 	const struct of_device_id *mdp_probe_infra;
 	const struct mdp_platform_config *mdp_cfg;
 	const u32 *mdp_mutex_table_idx;
-- 
2.18.0


