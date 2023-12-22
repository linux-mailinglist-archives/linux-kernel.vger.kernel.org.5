Return-Path: <linux-kernel+bounces-9478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609EB81C639
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2689F284DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1111719;
	Fri, 22 Dec 2023 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZDQfXIaf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E264FBEC;
	Fri, 22 Dec 2023 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 30942214a0a111eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OvaT9Y5lkKN52GxhXJsTpJ0Q2R7n8u/pL6jJJhzDuVQ=;
	b=ZDQfXIafrQsClNm4wZcYFDd4TJA5lSN9D5hXz3fU/oVWD2iB9rzoRLevqWBt88Jtvaw6Y2bsgSy7HxdPwAohl19Xqq6QFHBvLWLYOaqR3eoEqzv+uXRESiTc6k+nVZkW43xOtepDdIssZNGG297uTtgjc8MBB24h+wp0yuoCQMQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:04a9dfaa-60e7-4c03-b12e-3f4a0280735e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:b8c38e7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 30942214a0a111eea5db2bebc7c28f94-20231222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 173312895; Fri, 22 Dec 2023 16:07:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:07:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:07:44 +0800
From: William-tw Lin <william-tw.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH v4 3/3] nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse
Date: Fri, 22 Dec 2023 16:07:39 +0800
Message-ID: <20231222080739.21706-4-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222080739.21706-1-william-tw.lin@mediatek.com>
References: <20231222080739.21706-1-william-tw.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The socinfo driver reads chip information from eFuses and does not need
any devicetree node. Register it from mtk-efuse.

While at it, also add the name for this driver's nvmem_config.

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 drivers/nvmem/mtk-efuse.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 84f05b40a411..f5bebcecf9bd 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -68,6 +68,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config econfig = {};
 	struct mtk_efuse_priv *priv;
 	const struct mtk_efuse_pdata *pdata;
+	struct platform_device *socinfo;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -85,11 +86,20 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
+	econfig.name = "mtk-efuse";
 	if (pdata->uses_post_processing)
 		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
 	nvmem = devm_nvmem_register(dev, &econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
 
-	return PTR_ERR_OR_ZERO(nvmem);
+	socinfo = platform_device_register_data(&pdev->dev, "mtk-socinfo",
+						PLATFORM_DEVID_AUTO, NULL, 0);
+	if (IS_ERR(socinfo))
+		dev_info(dev, "MediaTek SoC Information will be unavailable\n");
+
+	platform_set_drvdata(pdev, socinfo);
+	return 0;
 }
 
 static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
@@ -108,8 +118,17 @@ static const struct of_device_id mtk_efuse_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
 
+static void mtk_efuse_remove(struct platform_device *pdev)
+{
+	struct platform_device *socinfo = platform_get_drvdata(pdev);
+
+	if (!IS_ERR_OR_NULL(socinfo))
+		platform_device_unregister(socinfo);
+}
+
 static struct platform_driver mtk_efuse_driver = {
 	.probe = mtk_efuse_probe,
+	.remove_new = mtk_efuse_remove,
 	.driver = {
 		.name = "mediatek,efuse",
 		.of_match_table = mtk_efuse_of_match,
-- 
2.18.0


