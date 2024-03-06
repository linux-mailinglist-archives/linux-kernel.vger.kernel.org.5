Return-Path: <linux-kernel+bounces-94612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33C87421B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D4B1C21FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A2A1B80B;
	Wed,  6 Mar 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KZ6KszMb"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D51B59E;
	Wed,  6 Mar 2024 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761106; cv=none; b=mfR67WrKENzu/mlFFOM0IIvcNpe0Trtv5w6KcmQVd9XZPhcaNS5E1rL9sKpT7/a1PcjWZYqeewXWdqK/Cj6+vyyWOwR0snvzKqothrukrIe/u5QROnqsARDxHiCiYbmXhj5G6MYhyXCzOxPKJMOclsFn62EXYuHWL8UlkOgmgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761106; c=relaxed/simple;
	bh=4W+IyZmp2nty8iotsRjyeg4WhTJfRAhsyZstGwA4N4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWGRbB8k1ST57SCpFInNSyfhq7Vcpe3InmU6U5Ohlu8iBEF7+EaE2Bm/RFmL9FeNU5a1SNDJ7KaZr2ouPianu01xlfnOIdd4YqXuHW1O5wk2sphsfCSJRdoxG4Rwz10IKrwT5XiOdDbfLjG8RpXXtDO2sgLNYhol/H24ncoLWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KZ6KszMb; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426IER2R005433;
	Wed, 6 Mar 2024 13:38:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=niTRz1p5
	iJfYwIdigbEiv3g0kJXGAXGFbg4wuZ2clcc=; b=KZ6KszMbqgWYzDXbc3201E1T
	HAeKDkQV5xuYhf3cXVca3fV08MRLRfnREdyLJV9NFTZpm2/IRupk9WqYMrjLhe6+
	d8XFmgylb+rsoQOWEZUtCEanNihoMMEFill7sh05p+KmC+u8u9M3s9yac5hz1Pl1
	mpn6H2AYC61bLYiBblDmZNwQHJW3yNRNOWGekTU5J+R/O4BwYWFK5J/t91wQGkjg
	PAk8ekNDK/BdI9sagaUJLdQhlzvZ/s+51w69gyQxIFKOZT7fSCf60+eRXn2+IS+e
	+7g7dItbj77RvcPo9iZdfMXV0OXI+OU8RO0qIj7+7MLnDNnMOqeg3tu+BcqY6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wpp7bk1q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 13:38:12 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 13:38:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 13:38:11 -0800
Received: from rchintakuntla-lnx3.sclab.marvell.com (unknown [10.111.142.125])
	by maili.marvell.com (Postfix) with ESMTP id A3DB33F707F;
	Wed,  6 Mar 2024 13:38:10 -0800 (PST)
From: Radha Mohan Chintakuntla <radhac@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>
CC: Radha Mohan Chintakuntla <radhac@marvell.com>
Subject: [PATCH] octeontx2-af: Increase maximum BPID channels
Date: Wed, 6 Mar 2024 13:38:06 -0800
Message-ID: <20240306213806.431830-1-radhac@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2rfgjSta9mSNriDQHLI_P7BwrRUQGQdG
X-Proofpoint-GUID: 2rfgjSta9mSNriDQHLI_P7BwrRUQGQdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02

Any NIX interface type can have maximum 256 channels. So increased the
backpressure ID count to 256 so that it can cover cn9k and cn10k SoCs that
have different NIX interface types with varied maximum channels.

Signed-off-by: Radha Mohan Chintakuntla <radhac@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index d5c4f810da61..223a2e39172c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1207,10 +1207,8 @@ struct nix_bp_cfg_req {
 	/* bpid_per_chan = 1 assigns separate bp id for each channel */
 };
 
-/* PF can be mapped to either CGX or LBK interface,
- * so maximum 64 channels are possible.
- */
-#define NIX_MAX_BPID_CHAN	64
+/* Maximum channels any single NIX interface can have */
+#define NIX_MAX_BPID_CHAN	256
 struct nix_bp_cfg_rsp {
 	struct mbox_msghdr hdr;
 	u16	chan_bpid[NIX_MAX_BPID_CHAN]; /* Channel and bpid mapping */
-- 
2.34.1


