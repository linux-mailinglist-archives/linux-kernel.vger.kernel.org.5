Return-Path: <linux-kernel+bounces-10977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9581DF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26A71C2174C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CC35F13;
	Mon, 25 Dec 2023 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kGywvtXG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CC35EF6;
	Mon, 25 Dec 2023 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 88842360a30911eea5db2bebc7c28f94-20231225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=czFD26N8OYC/3DSto6FsZIsjge+0OKu4XVhJ0fL5OF4=;
	b=kGywvtXGXSAutyHvttY4edEMzHtz5sx+HKb6c2Gk50nxVBPi3rOCS39KtVHsBlcCXmikPYrX9yEpjXek9AXm8XjYaXZNyFhZcbFWGnDaEgOla1A5O8tcVM2Ttun2apNsZnRui7PWdgULYA3Yt6Glj6CIzdSHWgRoMzetEd3feSI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ac935463-ac45-42cd-9513-46564018b978,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:5d391d7,CLOUDID:a778a47e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 88842360a30911eea5db2bebc7c28f94-20231225
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 206489078; Mon, 25 Dec 2023 17:39:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Dec 2023 17:39:43 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Dec 2023 17:39:42 +0800
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
To: <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
	<matthias.bgg@gmail.com>, <mengqi.zhang@mediatek.com>,
	<wenbin.mei@mediatek.com>
CC: <yangyingliang@huawei.com>, <adrian.hunter@intel.com>,
	<avri.altman@wdc.com>, <vincent.whitchurch@axis.com>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/1] mmc: core: Add HS400 tuning in HS400es initialization
Date: Mon, 25 Dec 2023 17:38:40 +0800
Message-ID: <20231225093839.22931-2-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231225093839.22931-1-mengqi.zhang@mediatek.com>
References: <20231225093839.22931-1-mengqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

During the initialization to HS400es stage, add hs400 tuning flow as an
optional process. For Mediatek IP, HS00es mode requires a specific
tuning to ensure the correct HS400 timing setting.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
---
v1 https://patchwork.kernel.org/project/linux-mediatek/patch/20231201030547.11553-1-mengqi.zhang@mediatek.com/
v2 https://patchwork.kernel.org/project/linux-mediatek/patch/20231222062236.26370-1-mengqi.zhang@mediatek.com/
---
 drivers/mmc/core/mmc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 705942edacc6..d5173a9bb4b0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1822,8 +1822,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 		if (err)
 			goto free_card;
-
-	} else if (!mmc_card_hs400es(card)) {
+	} else if (mmc_card_hs400es(card)) {
+		if (host->ops->execute_hs400_tuning) {
+			err = host->ops->execute_hs400_tuning(host, card);
+			if (err)
+				goto free_card;
+		}
+	} else {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
 		if (err > 0 && mmc_card_hs(card)) {
-- 
2.25.1


