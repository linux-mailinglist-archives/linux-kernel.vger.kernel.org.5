Return-Path: <linux-kernel+bounces-9475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816381C632
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD075B217CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B0C2DE;
	Fri, 22 Dec 2023 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W81i5+2L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D8C127;
	Fri, 22 Dec 2023 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f612090a0a111eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hDfXE4WCQi+Uero5L+lW8qc0hThlhEk0Ed8UxNuZT+I=;
	b=W81i5+2LZshrKyn6dJM6H1y8xe0660aIQJPK+iPRQE8LSBGLYyNLJYpS/JTlN959GDaohISTE6swsm6hoH6ml8weRsY6gsxbl0n37/2omj02yGaa+5lwSy3TEwI7PF2nn5WW2X28/GSsrMEpnefrrowVxTbhxT+gEYL53qCeDyk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:32c4fd37-6d9a-43ec-a241-d7bc624705a1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:e0cd758d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f612090a0a111eeba30773df0976c77-20231222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 944225377; Fri, 22 Dec 2023 16:07:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:07:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:07:41 +0800
From: William-tw Lin <william-tw.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH v4 0/3] mtk-socinfo driver implementation
Date: Fri, 22 Dec 2023 16:07:36 +0800
Message-ID: <20231222080739.21706-1-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.842800-8.000000
X-TMASE-MatchedRID: 7hQvYNNB0HPWs8uZun5F1rMjW/sniEQKrHCvytg5b477efdnqtsaE3Eg
	VCNNH68CDsWHoENn2KjwPnw702GJdY9Tk4aumaegydRP56yRRA9/aDoolm3GXTUsHjosUACSpJ3
	fC5uBqTYv64ytQjJ6boAy6p60ZV62fJ5/bZ6npdiujVRFkkVsm/MduS02EQgU8/TDBOKE/2l7+b
	tbM8Xu0GHsScaHxHAnBFOZmXZ6eOlkq0WS0Z/fHzGLhAPJMyqX2pkibEig2Kh+r27YUi2tGo6H7
	DI0GsVcMmI24qiENwrMpIbcl3IoA+q1XYAYw09quxzcuGDedhg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.842800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B7149D06EF9F63AE59B600D4E190A5935EEA42D1487B99C5F9A655F1EAEFA0892000:8

v4 changes:
dts:
1. remove phandle from socinfo-data for all platforms

mtk-socinfo.c:
1. use module_platform_driver instead of builtin_platform_driver

drivers/soc/mediatek/Kconfig:
1. add dependency for MTK_SOCINFO

mtk-efuse.c:
1. add remove function

commit message:
1. update commit message by following reviewer's comment

William-tw Lin (3):
  arm64: dts: mediatek: Add socinfo efuses to MT8173/83/96/92/95 SoCs
  soc: mediatek: mtk-socinfo: Add driver for getting chip information
  nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   9 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi |   9 ++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi |   4 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi |   8 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi |   3 +
 drivers/nvmem/mtk-efuse.c                |  21 ++-
 drivers/soc/mediatek/Kconfig             |   9 ++
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-socinfo.c       | 186 +++++++++++++++++++++++
 9 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c

-- 
2.18.0


