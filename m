Return-Path: <linux-kernel+bounces-10976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69881DF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C752818B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9B18C14;
	Mon, 25 Dec 2023 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mYNF7VsR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1A15E93;
	Mon, 25 Dec 2023 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 677e187ea30911eea5db2bebc7c28f94-20231225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Qtc/UT0sxKoldwIN+ov3bFvbcaNDnm1oh+icAmEqNDI=;
	b=mYNF7VsRRurLSLTIcHRZPcVfT7XKTDOIhhqYvQu5/kSZz56sEm2JX63fF9Z8D9cDVh5bhHvgvXoDryvdnVsOa4qREpSAaOGJHu6uZqvzKf3OENAnknup8olyFr2fKzN+B4qPoYhT9uu07zktpHjmBKy35YMSUsS++5NBChjgv78=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d495ea9a-b4c7-4fb7-8a09-356ff2ab2620,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:5d391d7,CLOUDID:f7882482-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 677e187ea30911eea5db2bebc7c28f94-20231225
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 115111500; Mon, 25 Dec 2023 17:38:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Dec 2023 17:38:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Dec 2023 17:38:46 +0800
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
To: <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
	<matthias.bgg@gmail.com>, <mengqi.zhang@mediatek.com>,
	<wenbin.mei@mediatek.com>
CC: <yangyingliang@huawei.com>, <adrian.hunter@intel.com>,
	<avri.altman@wdc.com>, <vincent.whitchurch@axis.com>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/1] mmc: core: Add HS400 tuning in HS400es initialization
Date: Mon, 25 Dec 2023 17:38:38 +0800
Message-ID: <20231225093839.22931-1-mengqi.zhang@mediatek.com>
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
X-TM-AS-Result: No-10--0.214900-8.000000
X-TMASE-MatchedRID: K5X4qC6dTGXHO8eAxCOj9g5KPhGIg0MRmdrHMkUHHq/d1Nq3SV2z16PF
	jJEFr+olAmPpbGBYlhvkwjHXXC/4I8ZW5ai5WKlyUbuU0PqmIHzXf6gk5EUc2PO6QeGRZiXtToE
	IiXyM+vCS0844xDjSIhz+PhojlLUuev0YPTN868QBqq+/+aGCsQhzL04Or2eZVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.214900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6200C6012DED93DD56A71F42AC0FB3308455ADF6E74D051D7356F2AB2D2A06A92000:8

change v3
1. remove mmc_retune_disable() and mmc_retune_enable() from
   hs400es initialization.

change v2
1. remove hs400 tuning from mmc_retune.
2. remove mmc_retune_enable() from hs400es initialization.

Mengqi Zhang (1):
  mmc: core: Add HS400 tuning in HS400es initialization

 drivers/mmc/core/mmc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1


