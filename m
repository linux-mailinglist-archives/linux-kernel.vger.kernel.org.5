Return-Path: <linux-kernel+bounces-1509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B967D814F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70682285CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080754185F;
	Fri, 15 Dec 2023 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZELBEQWq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A683FE4C;
	Fri, 15 Dec 2023 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFHboTC020184;
	Fri, 15 Dec 2023 10:14:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=UqjJbo4e9wtnm5S1WqGbyMZPTKmSLprZIU4FVvzvLhY=; b=ZEL
	BEQWq7Jk/Dgo9AYtWhEkr+dkEs0opgQHcFJbXsYwBUF/8ch2M+1UX2YqUWPqBztA
	ZXG8lGYMUgHsgKESNQt2mvyfkC85JC4qadNurM0GTM6W48bYGhyt5JNCKKfPsxtc
	VS/4JvMFFJXeUzOm+U20q3xL1NqCesDudkLZaL+kS1Z0sBWdLfs7VVj2MPRc8XnR
	fkg+5+9g9ea3SDxOzvaA+sx7z5yruWWvLHezc93KTlTbsCDLeUS1u6DLOUuD03uj
	fTQoGwVVIeYvYuQCY++oeS1vvNiT8BszIssSSsLXHwrzMiQYgXPLe9wdTgLPqTcK
	BLatvQkEeQI2lrBrHiw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v06m0v7v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:14:42 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 10:14:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 15 Dec 2023 10:14:40 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id A384B3F703F;
	Fri, 15 Dec 2023 10:14:39 -0800 (PST)
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
Subject: [PATCH net-next v6 4/4] octeon_ep: support firmware notifications for VFs
Date: Fri, 15 Dec 2023 10:14:25 -0800
Message-ID: <20231215181425.2681426-5-srasheed@marvell.com>
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
X-Proofpoint-GUID: Jgi-pnKGEXj_0Gqe6RRrcVQtl8V1hRxy
X-Proofpoint-ORIG-GUID: Jgi-pnKGEXj_0Gqe6RRrcVQtl8V1hRxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Notifications from firmware to vf has to pass through PF
control mbox and via PF-VF mailboxes. The notifications have to
be parsed out from the control mbox and passed to the
PF-VF mailbox in order to reach the corresponding VF.
Version compatibility should also be checked before messages
are passed to the mailboxes.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V6:
  - No changes

V5: https://lore.kernel.org/all/20231214164536.2670006-5-srasheed@marvell.com/
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


