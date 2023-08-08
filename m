Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7801774773
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjHHTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjHHTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:14:36 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C637CBA;
        Tue,  8 Aug 2023 09:37:31 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3789rD5I020282;
        Tue, 8 Aug 2023 04:42:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=cj0PB4+iw+OJxParcspUdcwyVcMKGRDC9aDS0DIq4Vg=;
 b=GcS/O3ydduOGbRgzpCa39sc+aZLa9riOxC/ua5biSaAVPMtKATxr2YF77kBn/Lguh+BD
 /uMte7EamIZ12ESG/UZgPxd0hAicAL7x7yglUUOPddC+kkZ+v+FnCn9JDTQfdwdNLVzE
 nEtq1y2+DieXhr41cKfhWA+FREnzu+lvRH3q34+Kb/ic5YrG8zxKWU4ecP19udQcaOxs
 kdtKmLuB6uLSw/LsIR5YeuvdZcSpW9Bc0/NRnyK88RNhz04NcDI+toKzC2RyRiLYBN0h
 0ltNCclx/aHMcKnTlNdIyYIo1lyTb0Cf7uCoIOaZdB0L01rqHQNCLY76IHepYuFjMUZ7 zA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkfggb5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 04:42:50 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Aug
 2023 04:42:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 8 Aug 2023 04:42:48 -0700
Received: from setup-1.sclab.marvell.com (unknown [10.106.25.74])
        by maili.marvell.com (Postfix) with ESMTP id 69EC63F703F;
        Tue,  8 Aug 2023 04:42:48 -0700 (PDT)
From:   Sathesh Edara <sedara@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <hgani@marvell.com>, <andrew@lunn.ch>
CC:     <sedara@marvell.com>
Subject: [net-next PATCH v2] octeon_ep: Add control plane host and firmware versions.
Date:   Tue, 8 Aug 2023 04:42:25 -0700
Message-ID: <20230808114225.516711-1-sedara@marvell.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FDNaP-8n6pVfty9mSsRLbqonCB_mBNIr
X-Proofpoint-GUID: FDNaP-8n6pVfty9mSsRLbqonCB_mBNIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement control plane mailbox versions for host and firmware.
Versions are published in info area of control mailbox bar4
memory structure.Firmware will publish minimum and maximum
supported versions.Control plane mailbox apis will check for
firmware version before sending any control commands to firmware.
Notifications from firmware will similarly be checked for host
version compatibility.

Signed-off-by: Sathesh Edara <sedara@marvell.com>
---
v2:
  - Addressed review comments given by Andrew Lunn
    1. Removed firmware version check
    2. Fixed compilation error by adding missed header file

 .../marvell/octeon_ep/octep_cp_version.h      | 11 ++++++++
 .../marvell/octeon_ep/octep_ctrl_mbox.c       |  9 ++++++-
 .../marvell/octeon_ep/octep_ctrl_mbox.h       |  6 +++++
 .../marvell/octeon_ep/octep_ctrl_net.c        | 25 +++++++++++++++++--
 .../marvell/octeon_ep/octep_ctrl_net.h        | 16 ++++++++++++
 5 files changed, 64 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_cp_version.h

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cp_version.h b/drivers/net/ethernet/marvell/octeon_ep/octep_cp_version.h
new file mode 100644
index 000000000000..0c741e752db6
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cp_version.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2022 Marvell.
+ */
+#ifndef __OCTEP_CP_VERSION_H__
+#define __OCTEP_CP_VERSION_H__
+
+#define OCTEP_CP_VERSION(a, b, c)	((((a) & 0xff) << 16) + \
+					 (((b) & 0xff) << 8) + \
+					  ((c) & 0xff))
+
+#endif /* __OCTEP_CP_VERSION_H__ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
index dab61cc1acb5..9d53c1402cb4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.c
@@ -37,7 +37,9 @@
 
 #define OCTEP_CTRL_MBOX_INFO_MAGIC_NUM(m)	(m)
 #define OCTEP_CTRL_MBOX_INFO_BARMEM_SZ(m)	((m) + 8)
+#define OCTEP_CTRL_MBOX_INFO_HOST_VERSION(m)   ((m) + 16)
 #define OCTEP_CTRL_MBOX_INFO_HOST_STATUS(m)	((m) + 24)
+#define OCTEP_CTRL_MBOX_INFO_FW_VERSION(m)     ((m) + 136)
 #define OCTEP_CTRL_MBOX_INFO_FW_STATUS(m)	((m) + 144)
 
 #define OCTEP_CTRL_MBOX_H2FQ_INFO(m)	((m) + OCTEP_CTRL_MBOX_INFO_SZ)
@@ -71,7 +73,7 @@ static u32 octep_ctrl_mbox_circq_depth(u32 pi, u32 ci, u32 sz)
 
 int octep_ctrl_mbox_init(struct octep_ctrl_mbox *mbox)
 {
-	u64 magic_num, status;
+	u64 magic_num, status, fw_versions;
 
 	if (!mbox)
 		return -EINVAL;
@@ -93,6 +95,9 @@ int octep_ctrl_mbox_init(struct octep_ctrl_mbox *mbox)
 		return -EINVAL;
 	}
 
+	fw_versions = readq(OCTEP_CTRL_MBOX_INFO_FW_VERSION(mbox->barmem));
+	mbox->min_fw_version = ((fw_versions & 0xffffffff00000000ull) >> 32);
+	mbox->max_fw_version = (fw_versions & 0xffffffff);
 	mbox->barmem_sz = readl(OCTEP_CTRL_MBOX_INFO_BARMEM_SZ(mbox->barmem));
 
 	writeq(OCTEP_CTRL_MBOX_STATUS_INIT,
@@ -113,6 +118,7 @@ int octep_ctrl_mbox_init(struct octep_ctrl_mbox *mbox)
 			  OCTEP_CTRL_MBOX_TOTAL_INFO_SZ +
 			  mbox->h2fq.sz;
 
+	writeq(mbox->version, OCTEP_CTRL_MBOX_INFO_HOST_VERSION(mbox->barmem));
 	/* ensure ready state is seen after everything is initialized */
 	wmb();
 	writeq(OCTEP_CTRL_MBOX_STATUS_READY,
@@ -258,6 +264,7 @@ int octep_ctrl_mbox_uninit(struct octep_ctrl_mbox *mbox)
 	if (!mbox->barmem)
 		return -EINVAL;
 
+	writeq(0, OCTEP_CTRL_MBOX_INFO_HOST_VERSION(mbox->barmem));
 	writeq(OCTEP_CTRL_MBOX_STATUS_INVALID,
 	       OCTEP_CTRL_MBOX_INFO_HOST_STATUS(mbox->barmem));
 	/* ensure uninit state is written before uninitialization */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h
index 9c4ff0fba6a0..7f8135788efc 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h
@@ -121,6 +121,8 @@ struct octep_ctrl_mbox_q {
 };
 
 struct octep_ctrl_mbox {
+	/* control plane version */
+	u64 version;
 	/* size of bar memory */
 	u32 barmem_sz;
 	/* pointer to BAR memory */
@@ -133,6 +135,10 @@ struct octep_ctrl_mbox {
 	struct mutex h2fq_lock;
 	/* lock for f2hq */
 	struct mutex f2hq_lock;
+	/* Min control plane version supported by firmware */
+	u32 min_fw_version;
+	/* Max control plane version supported by firmware */
+	u32 max_fw_version;
 };
 
 /* Initialize control mbox.
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 1cc6af2feb38..3e9f0a88cfca 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -14,6 +14,9 @@
 #include "octep_main.h"
 #include "octep_ctrl_net.h"
 
+/* Control plane version */
+#define OCTEP_CP_VERSION_CURRENT	OCTEP_CP_VERSION(1, 0, 0)
+
 static const u32 req_hdr_sz = sizeof(union octep_ctrl_net_req_hdr);
 static const u32 mtu_sz = sizeof(struct octep_ctrl_net_h2f_req_cmd_mtu);
 static const u32 mac_sz = sizeof(struct octep_ctrl_net_h2f_req_cmd_mac);
@@ -41,7 +44,13 @@ static int octep_send_mbox_req(struct octep_device *oct,
 			       struct octep_ctrl_net_wait_data *d,
 			       bool wait_for_response)
 {
-	int err, ret;
+	int err, ret, cmd;
+
+	/* check if firmware is compatible for this request */
+	cmd = d->data.req.hdr.s.cmd;
+	if (octep_ctrl_net_h2f_cmd_versions[cmd] > oct->ctrl_mbox.max_fw_version ||
+	    octep_ctrl_net_h2f_cmd_versions[cmd] < oct->ctrl_mbox.min_fw_version)
+		return -EOPNOTSUPP;
 
 	err = octep_ctrl_mbox_send(&oct->ctrl_mbox, &d->msg);
 	if (err < 0)
@@ -84,12 +93,16 @@ int octep_ctrl_net_init(struct octep_device *oct)
 
 	/* Initialize control mbox */
 	ctrl_mbox = &oct->ctrl_mbox;
+	ctrl_mbox->version = OCTEP_CP_VERSION_CURRENT;
 	ctrl_mbox->barmem = CFG_GET_CTRL_MBOX_MEM_ADDR(oct->conf);
 	ret = octep_ctrl_mbox_init(ctrl_mbox);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize control mbox\n");
 		return ret;
 	}
+	dev_info(&pdev->dev, "Control plane versions host: %llx, firmware: %x:%x\n",
+		 ctrl_mbox->version, ctrl_mbox->min_fw_version,
+		 ctrl_mbox->max_fw_version);
 	oct->ctrl_mbox_ifstats_offset = ctrl_mbox->barmem_sz;
 
 	return 0;
@@ -273,9 +286,17 @@ static int process_mbox_notify(struct octep_device *oct,
 {
 	struct net_device *netdev = oct->netdev;
 	struct octep_ctrl_net_f2h_req *req;
+	int cmd;
 
 	req = (struct octep_ctrl_net_f2h_req *)msg->sg_list[0].msg;
-	switch (req->hdr.s.cmd) {
+	cmd = req->hdr.s.cmd;
+
+	/* check if we support this command */
+	if (octep_ctrl_net_f2h_cmd_versions[cmd] > OCTEP_CP_VERSION_CURRENT ||
+	    octep_ctrl_net_f2h_cmd_versions[cmd] < OCTEP_CP_VERSION_CURRENT)
+		return -EOPNOTSUPP;
+
+	switch (cmd) {
 	case OCTEP_CTRL_NET_F2H_CMD_LINK_STATUS:
 		if (netif_running(netdev)) {
 			if (req->link.state) {
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index 37880dd79116..dd4f055fa8da 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -7,6 +7,8 @@
 #ifndef __OCTEP_CTRL_NET_H__
 #define __OCTEP_CTRL_NET_H__
 
+#include "octep_cp_version.h"
+
 #define OCTEP_CTRL_NET_INVALID_VFID	(-1)
 
 /* Supported commands */
@@ -39,12 +41,26 @@ enum octep_ctrl_net_h2f_cmd {
 	OCTEP_CTRL_NET_H2F_CMD_LINK_STATUS,
 	OCTEP_CTRL_NET_H2F_CMD_RX_STATE,
 	OCTEP_CTRL_NET_H2F_CMD_LINK_INFO,
+	OCTEP_CTRL_NET_H2F_CMD_MAX
+};
+
+/* Control plane version in which OCTEP_CTRL_NET_H2F_CMD was added */
+static const u32 octep_ctrl_net_h2f_cmd_versions[OCTEP_CTRL_NET_H2F_CMD_MAX] = {
+	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_LINK_INFO] =
+	 OCTEP_CP_VERSION(1, 0, 0)
 };
 
 /* Supported fw to host commands */
 enum octep_ctrl_net_f2h_cmd {
 	OCTEP_CTRL_NET_F2H_CMD_INVALID = 0,
 	OCTEP_CTRL_NET_F2H_CMD_LINK_STATUS,
+	OCTEP_CTRL_NET_F2H_CMD_MAX
+};
+
+/* Control plane version in which OCTEP_CTRL_NET_F2H_CMD was added */
+static const u32 octep_ctrl_net_f2h_cmd_versions[OCTEP_CTRL_NET_F2H_CMD_MAX] = {
+	[OCTEP_CTRL_NET_F2H_CMD_INVALID ... OCTEP_CTRL_NET_F2H_CMD_LINK_STATUS] =
+	 OCTEP_CP_VERSION(1, 0, 0)
 };
 
 union octep_ctrl_net_req_hdr {
-- 
2.37.3

