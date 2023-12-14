Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139288136A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443572AbjLNQqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjLNQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:46:08 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0536112;
        Thu, 14 Dec 2023 08:46:14 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEFFfMN028410;
        Thu, 14 Dec 2023 08:46:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=77RVZ2pQEuJiIgnQ10J5215bqYx8vDdSeXsSEqsaZQs=; b=b1P
        ZSONAnIYeCjr/FOQQD6zvXhsOtVgiCh3oWkjbMK+QnGDOC/EikvWI0qyF42smPMo
        xshspRw+eNcc7m7hrRPhfo3Ipp1xfdwucqVbj0aGoz9L5ISFhEd1AhiCglrwlxwp
        5z75XCcF0/40PLPaGdmVwZK+U2GFBIX6ozhloKT3BCBvjs7hOsAN5PHWr6irRIq8
        ejokvRtEVH5Uz0CjMesw/sHnGrtHQxT/wZd79BMbW76Ge3AOGWS/8/nWyD+nif3u
        7RW1UWc+vjvlcWRNX96RTyBB/kww3fmaq/JPtiGKD7jWyuzlCl2Y2Ebz281Jz1pA
        cXAez5OGmsbW7RJffHw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0m9fy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 08:46:00 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 08:45:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 08:45:58 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 6E4623F708A;
        Thu, 14 Dec 2023 08:45:58 -0800 (PST)
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
Subject: [PATCH net-next v5 4/4] octeon_ep: support firmware notifications for VFs
Date:   Thu, 14 Dec 2023 08:45:36 -0800
Message-ID: <20231214164536.2670006-5-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214164536.2670006-1-srasheed@marvell.com>
References: <20231214164536.2670006-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UW04w0R5lqrvggGlezbjiPrERPl8r7eK
X-Proofpoint-ORIG-GUID: UW04w0R5lqrvggGlezbjiPrERPl8r7eK
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

Notifications from firmware to vf has to pass through PF
control mbox and via PF-VF mailboxes. The notifications have to
be parsed out from the control mbox and passed to the
PF-VF mailbox in order to reach the corresponding VF.
Version compatibility should also be checked before messages
are passed to the mailboxes.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V5:
  - No changes

V4: https://lore.kernel.org/all/20231213035816.2656851-5-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20231211063355.2630028-5-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231209081450.2613561-5-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231208070352.2606192-5-srasheed@marvell.com/

 .../marvell/octeon_ep/octep_ctrl_net.c        |  6 ++
 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 58 +++++++++++++++++++
 .../marvell/octeon_ep/octep_pfvf_mbox.h       |  2 +
 3 files changed, 66 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 9dff2166dbb7..01b7be154c38 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -13,6 +13,7 @@
 #include "octep_config.h"
 #include "octep_main.h"
 #include "octep_ctrl_net.h"
+#include "octep_pfvf_mbox.h"
 
 /* Control plane version */
 #define OCTEP_CP_VERSION_CURRENT	OCTEP_CP_VERSION(1, 0, 0)
@@ -329,6 +330,11 @@ static int process_mbox_notify(struct octep_device *oct,
 	    octep_ctrl_net_f2h_cmd_versions[cmd] < OCTEP_CP_VERSION_CURRENT)
 		return -EOPNOTSUPP;
 
+	if (msg->hdr.s.is_vf) {
+		octep_pfvf_notify(oct, msg);
+		return 0;
+	}
+
 	switch (cmd) {
 	case OCTEP_CTRL_NET_F2H_CMD_LINK_STATUS:
 		if (netif_running(netdev)) {
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index dbb5b8f4ef30..2e2c3be8a0b4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -21,6 +21,15 @@
 #include "octep_pfvf_mbox.h"
 #include "octep_ctrl_net.h"
 
+/* When a new command is implemented, the below table should be updated
+ * with new command and it's version info.
+ */
+static u32 pfvf_cmd_versions[OCTEP_PFVF_MBOX_CMD_MAX] = {
+	[0 ... OCTEP_PFVF_MBOX_CMD_DEV_REMOVE] = OCTEP_PFVF_MBOX_VERSION_V1,
+	[OCTEP_PFVF_MBOX_CMD_GET_FW_INFO ... OCTEP_PFVF_MBOX_NOTIF_LINK_STATUS] =
+		OCTEP_PFVF_MBOX_VERSION_V2
+};
+
 static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
 					union octep_pfvf_mbox_word cmd,
 					union octep_pfvf_mbox_word *rsp)
@@ -87,6 +96,34 @@ static void octep_pfvf_set_rx_state(struct octep_device *oct, u32 vf_id,
 	rsp->s_link_state.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
 }
 
+static int octep_send_notification(struct octep_device *oct, u32 vf_id,
+				   union octep_pfvf_mbox_word cmd)
+{
+	u32 max_rings_per_vf, vf_mbox_queue;
+	struct octep_mbox *mbox;
+
+	/* check if VF PF Mailbox is compatible for this notification */
+	if (pfvf_cmd_versions[cmd.s.opcode] > oct->vf_info[vf_id].mbox_version) {
+		dev_dbg(&oct->pdev->dev, "VF Mbox doesn't support Notification:%d on VF ver:%d\n",
+			cmd.s.opcode, oct->vf_info[vf_id].mbox_version);
+		return -EOPNOTSUPP;
+	}
+
+	max_rings_per_vf = CFG_GET_MAX_RPVF(oct->conf);
+	vf_mbox_queue = vf_id * max_rings_per_vf;
+	if (!oct->mbox[vf_mbox_queue]) {
+		dev_err(&oct->pdev->dev, "Notif obtained for bad mbox vf %d\n", vf_id);
+		return -EINVAL;
+	}
+	mbox = oct->mbox[vf_mbox_queue];
+
+	mutex_lock(&mbox->lock);
+	writeq(cmd.u64, mbox->pf_vf_data_reg);
+	mutex_unlock(&mbox->lock);
+
+	return 0;
+}
+
 static void octep_pfvf_set_mtu(struct octep_device *oct, u32 vf_id,
 			       union octep_pfvf_mbox_word cmd,
 			       union octep_pfvf_mbox_word *rsp)
@@ -326,6 +363,27 @@ static void octep_pfvf_pf_get_data(struct octep_device *oct,
 	}
 }
 
+void octep_pfvf_notify(struct octep_device *oct, struct octep_ctrl_mbox_msg *msg)
+{
+	union octep_pfvf_mbox_word notif = { 0 };
+	struct octep_ctrl_net_f2h_req *req;
+
+	req = (struct octep_ctrl_net_f2h_req *)msg->sg_list[0].msg;
+	switch (req->hdr.s.cmd) {
+	case OCTEP_CTRL_NET_F2H_CMD_LINK_STATUS:
+		notif.s_link_status.opcode = OCTEP_PFVF_MBOX_NOTIF_LINK_STATUS;
+		notif.s_link_status.status = req->link.state;
+		break;
+	default:
+		pr_info("Unknown mbox notif for vf: %u\n",
+			req->hdr.s.cmd);
+		return;
+	}
+
+	notif.s.type = OCTEP_PFVF_MBOX_TYPE_CMD;
+	octep_send_notification(oct, msg->hdr.s.vf_idx, notif);
+}
+
 void octep_pfvf_mbox_work(struct work_struct *work)
 {
 	struct octep_pfvf_mbox_wk *wk = container_of(work, struct octep_pfvf_mbox_wk, work);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
index c18a9f26fc31..0dc6eead292a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
@@ -37,6 +37,7 @@ enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_DEV_REMOVE,
 	OCTEP_PFVF_MBOX_CMD_GET_FW_INFO,
 	OCTEP_PFVF_MBOX_CMD_SET_OFFLOADS,
+	OCTEP_PFVF_MBOX_NOTIF_LINK_STATUS,
 	OCTEP_PFVF_MBOX_CMD_MAX,
 };
 
@@ -162,4 +163,5 @@ union octep_pfvf_mbox_word {
 void octep_pfvf_mbox_work(struct work_struct *work);
 int octep_setup_pfvf_mbox(struct octep_device *oct);
 void octep_delete_pfvf_mbox(struct octep_device *oct);
+void octep_pfvf_notify(struct octep_device *oct, struct octep_ctrl_mbox_msg *msg);
 #endif
-- 
2.25.1

