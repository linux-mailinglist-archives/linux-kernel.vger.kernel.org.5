Return-Path: <linux-kernel+bounces-6757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E732819D16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22721F225AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533B2137D;
	Wed, 20 Dec 2023 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TR2HaB/1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9431219F9;
	Wed, 20 Dec 2023 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 067386e29f2411eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lpv9HfQqedJZ/7/otnpcKeuvMelketPSFMtA2YH1PHA=;
	b=TR2HaB/1u95Zl7n6b4va7znamDdNukvA2rheWUO1rMBb6ZQJZUkyTFwl2AzF5zA3ulFwKZVfhxb0urcLqKVyeFvobB6yqedBWm2mPIf1mklbE1kjjApDpjZWhMdwebOeIylah6VEq7W8CbRJFtXqJetNeB3irDls7kae41XbF/E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:44b02d0d-d857-4b0c-8372-6c8f99e2d3f9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:96ff4b2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 067386e29f2411eeba30773df0976c77-20231220
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1097076553; Wed, 20 Dec 2023 18:39:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:39:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:39:15 +0800
From: William-tw Lin <william-tw.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH v3 0/3] mtk-socinfo driver implementation
Date: Wed, 20 Dec 2023 18:38:58 +0800
Message-ID: <20231220103901.22180-1-william-tw.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.051100-8.000000
X-TMASE-MatchedRID: 5uxxxxIslOUBCIpkUn74FFz+axQLnAVBvhf/zJ92tsM+g2HSynO/Ai1I
	Luqb6ETyrx9lhxQSjNj/9P6O6iNEwAtbZsj4NhjsydRP56yRRA9YN1akkye0qJjk0EbtghtXRRZ
	I1R6hQzaMENdLhjEPNHATsg8MODVIHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWQR6jb3O2ykjy2X
	W59h7n3fWw4LXPaC9RJ7gxsQJMEE/KjZl3Lxot3yk1hlElDPyLpAdG928vJNq5yrMeSpGIIosfp
	jK6aPvPwZBgUyJVEbl6Fw8/PpTMRaVvmiAyeA2kc5MSfkiJFI5p3LlElBHTlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.051100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FB31B32945D164C7005F3AE2971644E26B50E308F7FF16388E9ABCAFF8E3EE382000:8

v3 changes:
changes dts:
1. remove socinfo node so mtk-socinfo can be registered from mtk-efuse
2. add unit address to mtk-socinfo nodes

mtk-socinfo.c:
1. add static to previously global variables
2. remove the check on soc_dev in mtk_socinfo_remove
3. Drop .owner from platform_driver mtk_socinfo
4. Instead of probing from devicetree, socinfo is registered from
mtk-efuse

mtk-efuse.c:
1. Add mtk-efuse name to nvmem_config to avoid confusion with future
nvmem nodes
2. register mtk-socinfo from mtk-efuse

William-tw Lin (3):
  arm64: dts: Add node for chip info driver
  soc: mediatek: mtk-socinfo: Add driver for getting chip information
  nvmem: mtk-efuse: Modify driver for getting chip information

 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   9 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi |   9 ++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi |   4 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi |   8 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi |   3 +
 drivers/nvmem/mtk-efuse.c                |  11 +-
 drivers/soc/mediatek/Kconfig             |   8 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-socinfo.c       | 186 +++++++++++++++++++++++
 9 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/mediatek/mtk-socinfo.c

-- 
2.18.0


