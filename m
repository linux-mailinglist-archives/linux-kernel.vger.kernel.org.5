Return-Path: <linux-kernel+bounces-27110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F382EAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E491C20840
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719A11717;
	Tue, 16 Jan 2024 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="srv4G6D9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF511701
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da8268e6b44511eea2298b7352fd921d-20240116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lRLsvt6AN8BxywW0Vx62uPuBT/N5koDEut1R2l7E42k=;
	b=srv4G6D9zqpRYC4UQhr1ttQkoiaVrJPpgAmKe1cAn7wH76J5umoahk4nNfdfoUBCk+MfYD5fmFlf0PTrld6ko02DYEtkcZeCXtj+nAGVlMKjJD41nEBPGTiEF/DWfUwaOd1JX+D3wN984sAnKLMEC4pZREfckAHRc1XOxDx7tKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:dd078bcf-ba71-4d8c-bf73-f5686a434fba,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:e7464d8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: da8268e6b44511eea2298b7352fd921d-20240116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 927899709; Tue, 16 Jan 2024 16:04:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jan 2024 16:04:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jan 2024 16:04:19 +0800
From: Hsiao Chien Sung <shawn.sung@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Hsiao Chien Sung
	<shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH 0/1] Filter modes according to hardware capability
Date: Tue, 16 Jan 2024 16:04:17 +0800
Message-ID: <20240116080418.28991-1-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

This series is based on mediatek-drm-next branch of
kernel/git/chunkuang.hu/linux.git

Hsiao Chien Sung (1):
  drm/mediatek: Filter modes according to hardware capability

 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  3 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  7 +++
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 15 +++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 62 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  8 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |  2 +
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |  7 +++
 9 files changed, 107 insertions(+)

--
2.18.0


