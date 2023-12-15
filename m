Return-Path: <linux-kernel+bounces-1510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C986E814F90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733E81F2594A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18745BFB;
	Fri, 15 Dec 2023 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a8hW9nXI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652424187F;
	Fri, 15 Dec 2023 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFI6sYu019695;
	Fri, 15 Dec 2023 10:14:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=1s3nuHgK07gCQCg6SP9LLbq6jjaY2LpPRiIKtKcDNC4=; b=a8h
	W9nXIQwmA72T685J+PDZjQj9J3HuJlmzr49e34gRqtg5i7Eva0oqI5Yt4KXctMBn
	3rOZ2D/8O3f6QB1g2V9/Q62IiLDAa8pIIhPWS/iDh6NDonQmPirbVsFRkFInTz9T
	Qyz6ZQ6Yos7TxvojRCIwBfXTQLvJnA/MYLvXQNoYIoboNikbXWfVO5hf1/DtK7Ka
	oe6y8F0r4yPRNzHIBcz/xsKry6fTfcKiwu5SNJYzrXQM2N+NhbD/R29DdFk5GOxy
	MHaa53uqC9tEjJknYNB9JjCGpfVzHxBKYE0sWv01Nb6x3xmkXxYfSV+sd5Tv6IJU
	xooxJbRLxO0iog1nL0A==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v06m0v7uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:14:36 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 10:14:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 15 Dec 2023 10:14:34 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 4A6753F703F;
	Fri, 15 Dec 2023 10:14:34 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>, <shenjian15@huawei.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v6 2/4] octeon_ep: PF-VF mailbox version support
Date: Fri, 15 Dec 2023 10:14:23 -0800
Message-ID: <20231215181425.2681426-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215181425.2681426-1-srasheed@marvell.com>
References: <20231215181425.2681426-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GecFKAG9OhxT6zeUC1JJqJAQSPJ7TrtM
X-Proofpoint-ORIG-GUID: GecFKAG9OhxT6zeUC1JJqJAQSPJ7TrtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Add PF-VF mailbox initial version support

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
  - No changes

V5: https://lore.kernel.org/all/20231214164536.2670006-3-srasheed@marvell.com/
  - Refactored patch to leave out changes moved to first patch itself

V4: https://lore.kernel.org/all/20231213035816.2656851-3-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20231211063355.2630028-3-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231209081450.2613561-3-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231208070352.2606192-3-srasheed@marvell.com/

 .../net/ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c  | 15 ++++++++++++---
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.h  |  4 ++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 3223bb6f95ea..fee59e0e0138 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -220,6 +220,7 @@ struct octep_iface_link_info {
 /* The Octeon VF device specific info data structure.*/
 struct octep_pfvf_info {
 	u8 mac_addr[ETH_ALEN];
+	u32 mbox_version;
 };
 
 /* The Octeon device specific private data structure.
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index 0557c138060f..fb4da72e5193 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -27,10 +27,18 @@ static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
 {
 	u32 vf_version = (u32)cmd.s_version.version;
 
-	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
-		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF version:%d\n",
+		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
+	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
+		rsp->s_version.version = vf_version;
 	else
-		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		rsp->s_version.version = OCTEP_PFVF_MBOX_VERSION_CURRENT;
+
+	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
+	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
+		vf_id, oct->vf_info[vf_id].mbox_version);
+
+	rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
 }
 
 static void octep_pfvf_get_link_status(struct octep_device *oct, u32 vf_id,
@@ -166,6 +174,7 @@ int octep_setup_pfvf_mbox(struct octep_device *oct)
 			goto free_mbox;
 
 		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
+		memset(&oct->vf_info[i], 0, sizeof(struct octep_pfvf_info));
 		mutex_init(&oct->mbox[ring]->lock);
 		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
 		oct->mbox[ring]->wk.ctxptr = oct->mbox[ring];
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
index 83c072d97512..af4dcf5ef7f1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
@@ -13,11 +13,15 @@
 #define OCTEON_SDP_16K_HW_FRS  16380UL
 #define OCTEON_SDP_64K_HW_FRS  65531UL
 
+/* When a new command is implemented,PF Mbox version should be bumped.
+ */
 enum octep_pfvf_mbox_version {
 	OCTEP_PFVF_MBOX_VERSION_V0,
 	OCTEP_PFVF_MBOX_VERSION_V1,
 };
 
+#define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V1
+
 enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_VERSION,
 	OCTEP_PFVF_MBOX_CMD_SET_MTU,
-- 
2.25.1


