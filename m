Return-Path: <linux-kernel+bounces-9388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D381C4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB831F22639
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D38C0C;
	Fri, 22 Dec 2023 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M2h9Kyym"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5B63C3;
	Fri, 22 Dec 2023 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 19c9dcdca09111eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WJRbxASauCmb1KyNcmBLMhUdg4GwhqhjK/hcVDdoH8E=;
	b=M2h9Kyym6CGvy4fcqPcCAdj3L2uwBQiSYdoKR0iGSxO7rvK2uh62Z6iw0Gdhdu0C0IbbY2f2Se5Jz+L/sMfdoCftEP4YnbiVHbUycUK1wYCz0NiovWNXY2Q4cm96GWzx56v+ge0CfyW9pstkfMdHCdSg+j26edZilFDOD+xT/8E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f4d598e5-7c12-4764-9f4d-317857221a89,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:5d391d7,CLOUDID:eb79748d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 19c9dcdca09111eea5db2bebc7c28f94-20231222
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 411225416; Fri, 22 Dec 2023 14:12:35 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 14:12:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 14:12:33 +0800
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
To: <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
	<matthias.bgg@gmail.com>, <mengqi.zhang@mediatek.com>,
	<wenbin.mei@mediatek.com>
CC: <yangyingliang@huawei.com>, <adrian.hunter@intel.com>,
	<avri.altman@wdc.com>, <vincent.whitchurch@axis.com>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] mmc: core: Add HS400 tuning in HS400es initialization
Date: Fri, 22 Dec 2023 14:12:19 +0800
Message-ID: <20231222061220.26270-1-mengqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.769600-8.000000
X-TMASE-MatchedRID: rrQSwUHHCeTHO8eAxCOj9odlc1JaOB1TMZm0+sEE9mu6SmGkMbaxzqPF
	jJEFr+olAmPpbGBYlhvkwjHXXC/4I8prJP8FBOIaq7gCN/wjpYsFwAumiEQt0Lc75ozeC0gH/yA
	s+Hbv3NZsfmvnlCx6y21Rjoup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnoxXRPYWkcrg25WXG
	vUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.769600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6772C341A827DC8CCB34E55DD71CF475DE73743B2AAF1CDC5C2495D2621491812000:8

change v2
1. remove hs400 tuning from mmc_retune.
2. remove mmc_retune_enable() from hs400es initialization.

Mengqi Zhang (1):
  mmc: core: Add HS400 tuning in HS400es initialization

 drivers/mmc/core/mmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1


