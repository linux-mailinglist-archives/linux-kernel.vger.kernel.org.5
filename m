Return-Path: <linux-kernel+bounces-22458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E8829DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DD62853F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296D4CDFF;
	Wed, 10 Jan 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EvKF0Duy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261B4CB5D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c6d6cfcafd011ee9e680517dc993faa-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rVf/KyCe3y2w+HtApnhWHSc0RRmauZP3HVSAozjLxco=;
	b=EvKF0DuyyzRJVmWZEZnSiF+3zaRXOXa6F3a6ahy6mU31Zinq3KdwU+llkyEHbqUFColuS3uzGVR66TMgwh/t1HVMg3X0MLRpUFGNj4MuGra9PSL2ykpY24xL69C+aF/5Q4QnaZgnj1Ak5R/2w+PNcVxcbA3TLqV0UgjyWy+hb/g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b141a33c-e76f-4747-9cc6-b5dbbab174ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:f13d347f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2c6d6cfcafd011ee9e680517dc993faa-20240110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1242431257; Wed, 10 Jan 2024 23:51:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 23:51:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 23:51:51 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Shawn Sung
	<shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-jh Lin
	<jason-jh.lin@mediatek.corp-partner.google.com>
Subject: [PATCH 0/2] Change GCE hardware timeout to software timeout
Date: Wed, 10 Jan 2024 23:51:46 +0800
Message-ID: <20240110155148.6383-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.263700-8.000000
X-TMASE-MatchedRID: q3F3psOzl9ySm4maZcPB3bMjW/sniEQKKVrLOZD1BXT7efdnqtsaEwNx
	WPxQqGxCIivmPMAFRzSor0AhuwYJneHxFb2pjr4bXP5rFAucBUGy4iyjvVWTop2iHEDAUb20o8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtgZFlHm/gtnY0ATtLIYswSE9/RQmUBCjZHpPDPfgQysA2V8
	IOje1GckMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.263700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6C97B50913820EDC4F53C26FD1119DCA9248F4935C41D9B043801622779BF2CB2000:8
X-MTK: N

From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>

Since the max value of GCE hardware interrupt timeout for wait and poll
instructions is about 1760ms.
It is not enough for the use case of ISP driver below:
GCE Thread A: wait for SOF and set event 1.
GCE Thread B: wait for event 1 and set event 2.
GCE Thread C: wait for event 2 and set event 3.
GCE Thread D: wait for event 3 and set event 4.
GCE Thread E: wait for event 4 and set EOF.
If all GCE Threads start at the same time, the latest GCE Thread E will
wait for event more than 2 seconds.

Therefore, we changed the hardware timeout to software timeout, making it
longer, more certain, and making it configurable by CMDQ client drivers.

Jason-JH.Lin (2):
  mailbox: mtk-cmdq: Change GCE hardware timeout to software timeout
  mailbox: mtk-cmdq: Add set GCE thread timeout interface

 drivers/mailbox/mtk-cmdq-mailbox.c       | 183 +++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |   4 +
 2 files changed, 187 insertions(+)

-- 
2.18.0


