Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF680B337
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjLIIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjLIIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:15:12 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D910C9;
        Sat,  9 Dec 2023 00:15:18 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B984onU022969;
        Sat, 9 Dec 2023 00:15:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=fYfZDluIUc9BcJbK8+wtS2GbcOZbk8jSWxTqDAuPdrI=;
 b=R3OC0PcbwmDtlfe1qo3Q5XVy91GwwDVKP+74nVxDn/xQBvmgNTvhSC/USGQrJ4uMVLjU
 yF+z5qw0k/+Tuj5oOVezmeMxHXn4fNwBqpuFnhuCExZoWmsXloy/ilhmQKX0XdanYc2r
 nFi2TY2Twgp/BaOM/PQm7uu2x/HPsg/kqGWchNnQHqOf/y4U8cO5Ozff+aTxXtJOAPqM
 RvOVNyBz0L8Rg8viWnSj0LY7oVtstJRDQYhjbkh3i+55zMn7tfe7A+mzMTsQvjukuwiX
 2l3lqfAF2s/zF2eltdmvHwrPpZZd3vOLRAHrgc1cxxhhaLHsJJhGYkKBaLOcz6hNvkc7 8w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubddfkhp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 09 Dec 2023 00:15:10 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Dec
 2023 00:15:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 9 Dec 2023 00:15:00 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 839C93F7093;
        Sat,  9 Dec 2023 00:15:00 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2 3/4] octeon_ep: control net framework to support VF offloads
Date:   Sat, 9 Dec 2023 00:14:49 -0800
Message-ID: <20231209081450.2613561-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231209081450.2613561-1-srasheed@marvell.com>
References: <20231209081450.2613561-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t2L4MjTJYs7rKG1z1IpbxdhTQJphFUkX
X-Proofpoint-GUID: t2L4MjTJYs7rKG1z1IpbxdhTQJphFUkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inquire firmware on supported offloads, as well as convey offloads
enabled dynamically to firmware for the VFs. Implement control net API
to support the same.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - No changes

V1: https://lore.kernel.org/all/20231208070352.2606192-4-srasheed@marvell.com/

 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 47 +++++++++++++++++++
 .../marvell/octeon_ep/octep_pfvf_mbox.h       | 21 ++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index baffe298a2a0..57e0184840c2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -159,6 +159,47 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
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
@@ -335,6 +376,12 @@ void octep_pfvf_mbox_work(struct work_struct *work)
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

