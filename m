Return-Path: <linux-kernel+bounces-1508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34443814F88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EA9285C53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D213E490;
	Fri, 15 Dec 2023 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CrgzMm0k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327082EFC;
	Fri, 15 Dec 2023 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFIAhn5020035;
	Fri, 15 Dec 2023 10:14:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=mQVLXNpooPpwhwNeNGEYlx5okSGIB93VV5qvRvbIhJ8=; b=Crg
	zMm0kbs0UwlM48ystGPsjs9Fi8DaByUDAi4QGEZDxHlQ457SAFJ1rpS2fCpQ7K4M
	9BkE4gu49uuQOeiJeeBYBrxCtTBj0vSsxtDWjiK8NfbwofBWqOlWaWoVVw19GqZL
	AmWCzceMjdGNHyb8oL0rKSwj2xMhL3wQGFBf2Tb66odgC8vxjf6qfj9aBg89YUn7
	ebvEVdLfZHV4Gm9A1GDsq7/VwxZm8KZcqa36ce6CAMEMpqoDMgffXpqCfn8CaRBP
	CsnX2janEH8qM6YUOpsLiy8d/gg8mkL1BtHbeqt8pnqQtQKFIEILWt9GnLa6GW3y
	744EDgf/X4I0gCcqUlA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v06m0v7ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:14:38 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 10:14:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 15 Dec 2023 10:14:36 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 3D4263F703F;
	Fri, 15 Dec 2023 10:14:36 -0800 (PST)
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
Subject: [PATCH net-next v6 3/4] octeon_ep: control net framework to support VF offloads
Date: Fri, 15 Dec 2023 10:14:24 -0800
Message-ID: <20231215181425.2681426-4-srasheed@marvell.com>
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
X-Proofpoint-GUID: _knN-d5v8FW7bBMjGIG2HdTHUF8QlWfO
X-Proofpoint-ORIG-GUID: _knN-d5v8FW7bBMjGIG2HdTHUF8QlWfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Inquire firmware on supported offloads, as well as convey offloads
enabled dynamically to firmware for the VFs. Implement control net API
to support the same.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
  - No changes

V5: https://lore.kernel.org/all/20231214164536.2670006-4-srasheed@marvell.com/
  - No changes

V4: https://lore.kernel.org/all/20231213035816.2656851-4-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20231211063355.2630028-4-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231209081450.2613561-4-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231208070352.2606192-4-srasheed@marvell.com/

 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 47 +++++++++++++++++++
 .../marvell/octeon_ep/octep_pfvf_mbox.h       | 21 ++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index fb4da72e5193..dbb5b8f4ef30 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -158,6 +158,47 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
 	rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
 }
 
+static void octep_pfvf_get_fw_info(struct octep_device *oct,  u32 vf_id,
+				   union octep_pfvf_mbox_word cmd,
+				   union octep_pfvf_mbox_word *rsp)
+{
+	struct octep_fw_info fw_info;
+	int err;
+
+	err = octep_ctrl_net_get_info(oct, vf_id, &fw_info);
+	if (err) {
+		rsp->s_fw_info.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Get VF info failed via host control Mbox\n");
+		return;
+	}
+
+	rsp->s_fw_info.pkind = fw_info.pkind;
+	rsp->s_fw_info.fsz = fw_info.fsz;
+	rsp->s_fw_info.rx_ol_flags = fw_info.rx_ol_flags;
+	rsp->s_fw_info.tx_ol_flags = fw_info.tx_ol_flags;
+
+	rsp->s_fw_info.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+static void octep_pfvf_set_offloads(struct octep_device *oct, u32 vf_id,
+				    union octep_pfvf_mbox_word cmd,
+				    union octep_pfvf_mbox_word *rsp)
+{
+	struct octep_ctrl_net_offloads offloads = {
+		.rx_offloads = cmd.s_offloads.rx_ol_flags,
+		.tx_offloads = cmd.s_offloads.tx_ol_flags
+	};
+	int err;
+
+	err = octep_ctrl_net_set_offloads(oct, vf_id, &offloads, true);
+	if (err) {
+		rsp->s_offloads.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Set VF offloads failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_offloads.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
 int octep_setup_pfvf_mbox(struct octep_device *oct)
 {
 	int i = 0, num_vfs = 0, rings_per_vf = 0;
@@ -334,6 +375,12 @@ void octep_pfvf_mbox_work(struct work_struct *work)
 	case OCTEP_PFVF_MBOX_CMD_DEV_REMOVE:
 		octep_pfvf_dev_remove(oct, vf_id, cmd, &rsp);
 		break;
+	case OCTEP_PFVF_MBOX_CMD_GET_FW_INFO:
+		octep_pfvf_get_fw_info(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_SET_OFFLOADS:
+		octep_pfvf_set_offloads(oct, vf_id, cmd, &rsp);
+		break;
 	default:
 		dev_err(&oct->pdev->dev, "PF-VF mailbox: invalid opcode %d\n", cmd.s.opcode);
 		rsp.s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
index af4dcf5ef7f1..c18a9f26fc31 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
@@ -18,9 +18,10 @@
 enum octep_pfvf_mbox_version {
 	OCTEP_PFVF_MBOX_VERSION_V0,
 	OCTEP_PFVF_MBOX_VERSION_V1,
+	OCTEP_PFVF_MBOX_VERSION_V2,
 };
 
-#define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V1
+#define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V2
 
 enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_VERSION,
@@ -34,6 +35,8 @@ enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS,
 	OCTEP_PFVF_MBOX_CMD_GET_MTU,
 	OCTEP_PFVF_MBOX_CMD_DEV_REMOVE,
+	OCTEP_PFVF_MBOX_CMD_GET_FW_INFO,
+	OCTEP_PFVF_MBOX_CMD_SET_OFFLOADS,
 	OCTEP_PFVF_MBOX_CMD_MAX,
 };
 
@@ -138,6 +141,22 @@ union octep_pfvf_mbox_word {
 		u64 status:1;
 		u64 rsvd:53;
 	} s_link_status;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 pkind:8;
+		u64 fsz:8;
+		u64 rx_ol_flags:16;
+		u64 tx_ol_flags:16;
+		u64 rsvd:6;
+	} s_fw_info;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:22;
+		u64 rx_ol_flags:16;
+		u64 tx_ol_flags:16;
+	} s_offloads;
 } __packed;
 
 void octep_pfvf_mbox_work(struct work_struct *work);
-- 
2.25.1


