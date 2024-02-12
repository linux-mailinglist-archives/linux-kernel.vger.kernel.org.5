Return-Path: <linux-kernel+bounces-61663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0AA85151B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8001C21F18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A23C464;
	Mon, 12 Feb 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LlrD02oU"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED943BB27;
	Mon, 12 Feb 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743739; cv=none; b=Rrso4MrNFV97VhHJVpJXTfvKx2doUqNX5p90hpFDT6HsDVOycqm3Jq/dEa6CiGKQtwb/PGb4/fMOWs0g60lORCDZ69oWtUPAWxSI33tvF+suTLb1mgTjTHnARYbtW6XW9e+UrOsRPhOLZwFbMFXBniBbhewvR0wykYcdUGea/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743739; c=relaxed/simple;
	bh=GPWCbl61yUJim2BdrG5iAXC+5aBMPzF/H0YW07AjBDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVC0GPMA/NmQFe7Q+33o8mD9TKVVRbKhXKn9+lS0uDsEBUuMg/P08wURa6Tz8KtUbIDsmHXe5Ep7Z7m1ZChfPEJ/vPSq1V9DHHPEln3bZtzMUQ4QrrC/200/7ohVKJZVk7EUUfLlndnlovTeArYu1AyZB8CRPLV3PPQXG4LzJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LlrD02oU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C206BR031621;
	Mon, 12 Feb 2024 05:15:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=Kde01VhYq2kfON92ENyLX1k9vjKrWScuB/POulMsTNE=; b=Llr
	D02oU/bHmATJ99708RnvGyE7J4lnclaVHM8zLwfXh9VeEsntet1CaSkE7pufqzho
	wTM4lv0oxM4oeo4dbNAtVrKVCddSUehWsvjQdnFXBksZD3x5+TEs0pJP4l1FoH2D
	2sbvgXigr4fPzhKkgL86leXvDd+TZgHyzhGOkdw9joFGeYiXod6km9akAX5MHgE5
	lYK49YMiEwZDLau8DdqWIr5h2g97f5Xjrr4n+rsFU6zoimzdWi7CLAJeXj761xj8
	a2/drfrm5a9tdcba38bCqyjZayetqnv77sd0pQytyaGZU2v7aKbXCFmMq6QXYWM4
	86ookg/PBwyx6Kvzksw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w69hkc63a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 05:15:30 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 12 Feb
 2024 05:15:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 12 Feb 2024 05:15:28 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 760A33F7076;
	Mon, 12 Feb 2024 05:15:24 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next] Octeontx2-af: Fetch MAC channel info from firmware
Date: Mon, 12 Feb 2024 18:45:23 +0530
Message-ID: <20240212131523.4522-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eK33_tzHHwuto8Przv8s5HAc7Ffr2zf5
X-Proofpoint-GUID: eK33_tzHHwuto8Przv8s5HAc7Ffr2zf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_03,2023-05-22_02

Packet ingress and egress MAC/serdes channel numbers are configurable
on CN10K series of silicons. These channel numbers inturn used while
installing MCAM rules to match ingress/egress port. Fetch these channel
numbers from firmware at driver init time.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h     | 10 +++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c |  8 ++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a1d5fc65b92d..de8eba902276 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -443,6 +443,13 @@ struct mbox_wq_info {
 	struct workqueue_struct *mbox_wq;
 };
 
+struct channel_fwdata {
+	struct sdp_node_info info;
+	u8 valid;
+#define RVU_CHANL_INFO_RESERVED	379
+	u8 reserved[RVU_CHANL_INFO_RESERVED];
+};
+
 struct rvu_fwdata {
 #define RVU_FWDATA_HEADER_MAGIC	0xCFDA	/* Custom Firmware Data*/
 #define RVU_FWDATA_VERSION	0x0001
@@ -461,7 +468,8 @@ struct rvu_fwdata {
 	u64 msixtr_base;
 	u32 ptp_ext_clk_rate;
 	u32 ptp_ext_tstamp;
-#define FWDATA_RESERVED_MEM 1022
+	struct channel_fwdata channel_data;
+#define FWDATA_RESERVED_MEM 1014
 	u64 reserved[FWDATA_RESERVED_MEM];
 #define CGX_MAX         9
 #define CGX_LMACS_MAX   4
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
index 1edfda0ae3e8..38cfe148f4b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_sdp.c
@@ -56,6 +56,14 @@ int rvu_sdp_init(struct rvu *rvu)
 	struct rvu_pfvf *pfvf;
 	u32 i = 0;
 
+	if (rvu->fwdata->channel_data.valid) {
+		sdp_pf_num[0] = 0;
+		pfvf = &rvu->pf[sdp_pf_num[0]];
+		pfvf->sdp_info = &rvu->fwdata->channel_data.info;
+
+		return 0;
+	}
+
 	while ((i < MAX_SDP) && (pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
 						       PCI_DEVID_OTX2_SDP_PF,
 						       pdev)) != NULL) {
-- 
2.17.1


