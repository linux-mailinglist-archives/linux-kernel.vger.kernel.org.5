Return-Path: <linux-kernel+bounces-6760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DB819D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D3AB21F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCCA225DA;
	Wed, 20 Dec 2023 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tHif4mT0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E42231D;
	Wed, 20 Dec 2023 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b9357069f2411eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6nc2v4XK4GgMWiKrx1TmkatyK/XnMtUXXUmJveqsh50=;
	b=tHif4mT0gJNrd9ufcrKnjj6SMik67nKPPEDRg1HHAuz7lY9ZorFaUNKP5L4ftznugP/LGZ9DipNlyOv8bQ0kuhH1xB9Wgvdl9oPmqwy7xPpsx6nFUMiqpMN6Jf2CGVy4OgXOe5eNaLAdZVCENoQCyigrxryNSfYoVnszGCziGLQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:961659b4-ae08-4cbd-b76d-95f1f3e37dbf,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:d5ff4b2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0b9357069f2411eeba30773df0976c77-20231220
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 680687742; Wed, 20 Dec 2023 18:39:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:39:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:39:24 +0800
From: William-tw Lin <william-tw.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH v3 3/3] nvmem: mtk-efuse: Modify driver for getting chip information
Date: Wed, 20 Dec 2023 18:39:01 +0800
Message-ID: <20231220103901.22180-4-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231220103901.22180-1-william-tw.lin@mediatek.com>
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.994400-8.000000
X-TMASE-MatchedRID: 4UDH+/Xdc14QoD+Lr/yRKcnUT+eskUQPCt59Uh3p/NVcU0dNErOD+vlY
	oV6p/cSxYZon4ysgRFrD3fsd5FfxU5zDsl2JUMqfjFUG+PWNtyOWHGENdT+VP5soi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNRqXnrxrKCOXjBIzy2yVj36aFhDRX/XeG+7AwkxltPESpGOM5kASXvdoTE
	NRNo092nMWWXdH8XCFPKAPShj3y9+iL7s3pM/O5VsfT8+GQE6MF0aD5ljt43pMcHZD6gqu7wxMj
	fifIXfowkvVoA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.994400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DF501D5E8CD1E5A7AAF290735A49D2F4108BF1F346C084B579BE8F49EED3493E2000:8

Retrieval of soc info is needed. This patch includes the following:
1. Register socinfo device in mtk-efuse.c

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
---
 drivers/nvmem/mtk-efuse.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 84f05b40a411..3914e039e288 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -68,6 +68,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config econfig = {};
 	struct mtk_efuse_priv *priv;
 	const struct mtk_efuse_pdata *pdata;
+	struct platform_device *socinfo;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -85,11 +86,19 @@ static int mtk_efuse_probe(struct platform_device *pdev)
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
+	return 0;
 }
 
 static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
-- 
2.18.0


