Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF58136AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjLNQqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjLNQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:46:25 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140F8136;
        Thu, 14 Dec 2023 08:46:28 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9LVfp016648;
        Thu, 14 Dec 2023 08:45:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=LpoDtyE+w9Xed/N7elFQtxdF+ieDBaduGI3brFLSz8M=; b=kaa
        uxF6n+C63WHO8OrFd4mwUEwtJHBbI/4EFOewk56jl7GqJS96wGlXIUO/JWNHoiBr
        /+CgU4c5K3scnqufxw+Dcplcz/3NILZMNfW7VR0HLqZ0kfvfc7aiQl8+i7hpvty3
        7fb1pZv/1mylxPOSf8/zyofzXd6COJxYlJHC+VHt/jC0xcJslXYXr9RxH7y5ERXL
        yhx32Rn7yk3TPyS4iK3LBidZnFADFC6VTVIX/qsrOGn4RDK3kp5oFgU8Sx1Y936L
        OKkN331M9wDxlol2rdxp7GFcVb+AiT25hRtwEUl36YT9d62otjkBQpWne3tumXSr
        4QZp3boi8/LrMnETHgA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0nsjgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 08:45:58 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 08:45:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 08:45:56 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 75FD43F7088;
        Thu, 14 Dec 2023 08:45:56 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        <shenijian15@huawei.com>, "Shinas Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v5 3/4] octeon_ep: control net framework to support VF offloads
Date:   Thu, 14 Dec 2023 08:45:35 -0800
Message-ID: <20231214164536.2670006-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214164536.2670006-1-srasheed@marvell.com>
References: <20231214164536.2670006-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kewcW7sEkT1kWkLe5AlniGxLvb9C-1Tn
X-Proofpoint-GUID: kewcW7sEkT1kWkLe5AlniGxLvb9C-1Tn
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
V5:
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

