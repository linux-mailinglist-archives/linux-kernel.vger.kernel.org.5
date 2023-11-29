Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4B7FCE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376922AbjK2EyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbjK2EyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:54:18 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFDB1BC6;
        Tue, 28 Nov 2023 20:54:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIdtw6021070;
        Tue, 28 Nov 2023 20:53:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=EEQhMICjy4DZQbWamyerRADQ92GAIF8ZCdHo2SGhyrw=;
 b=BRK/IWjeEynwFLUt/UU/qCfCr3ATctIjRm2vDpqf2lv44VHzI47yhFE8nUDLSKL8pkr3
 cjSjnukJTz+pP8diLhuBVcFsyk3u0V2iSksP9c5dadgR5EXmGTuIxHe1OO1/7JGYBWsG
 GN992H5BsQD0p7sOw/Q9wL+jzVld7PBVPYOrSRDNEFstzfDn56c55tcSkg/dGLbL/e62
 K/xL0WI9pu+8diGQ2uXqi7jwqPVRqqSGen3CcxcAQOOi7o9iVXhcFwlUWHxczIEe57J1
 cQ6l3UVNEKjJmLncxz2emriIXJrZ1YE1B2iGf9zFjgCqR68oaOODrmkko/SYABInyp6n XA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3unn869x1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 20:53:54 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 20:53:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 20:53:53 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 979BD3F7043;
        Tue, 28 Nov 2023 20:53:52 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2 1/2] octeon_ep: implement device unload control net API
Date:   Tue, 28 Nov 2023 20:53:47 -0800
Message-ID: <20231129045348.2538843-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129045348.2538843-1-srasheed@marvell.com>
References: <20231129045348.2538843-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M-DZoJauUIHW_8J3ww9emqAv7cpJNnld
X-Proofpoint-GUID: M-DZoJauUIHW_8J3ww9emqAv7cpJNnld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_01,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device unload control net function should inform firmware
of driver unload to let it take necessary actions to cleanup.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Changed dev_info print to dev_dbg in device_remove API

V1: https://lore.kernel.org/all/20231127162135.2529363-2-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_ctrl_net.c  | 16 +++++++++++++++-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.h  | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 5fa596c674da..4c39e2fabe0a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -26,7 +26,7 @@ static atomic_t ctrl_net_msg_id;
 
 /* Control plane version in which OCTEP_CTRL_NET_H2F_CMD was added */
 static const u32 octep_ctrl_net_h2f_cmd_versions[OCTEP_CTRL_NET_H2F_CMD_MAX] = {
-	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_GET_INFO] =
+	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE] =
 	 OCTEP_CP_VERSION(1, 0, 0)
 };
 
@@ -393,10 +393,24 @@ int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
 	return 0;
 }
 
+int octep_ctrl_net_dev_remove(struct octep_device *oct, int vfid)
+{
+	struct octep_ctrl_net_wait_data d = {};
+	struct octep_ctrl_net_h2f_req *req;
+
+	req = &d.data.req;
+	dev_dbg(&oct->pdev->dev, "Sending dev_unload msg to fw\n");
+	init_send_req(&d.msg, req, sizeof(int), vfid);
+	req->hdr.s.cmd = OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE;
+
+	return octep_send_mbox_req(oct, &d, false);
+}
 int octep_ctrl_net_uninit(struct octep_device *oct)
 {
 	struct octep_ctrl_net_wait_data *pos, *n;
 
+	octep_ctrl_net_dev_remove(oct, OCTEP_CTRL_NET_INVALID_VFID);
+
 	list_for_each_entry_safe(pos, n, &oct->ctrl_req_wait_list, list)
 		pos->done = 1;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index a2463b460ad9..0de4de2ceb8f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -42,6 +42,7 @@ enum octep_ctrl_net_h2f_cmd {
 	OCTEP_CTRL_NET_H2F_CMD_RX_STATE,
 	OCTEP_CTRL_NET_H2F_CMD_LINK_INFO,
 	OCTEP_CTRL_NET_H2F_CMD_GET_INFO,
+	OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE,
 	OCTEP_CTRL_NET_H2F_CMD_MAX
 };
 
@@ -370,6 +371,16 @@ void octep_ctrl_net_recv_fw_messages(struct octep_device *oct);
 int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
 			    struct octep_fw_info *info);
 
+/**
+ * octep_ctrl_net_dev_remove() - Indicate to firmware that a device unload has happened.
+ *
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ *
+ * return value: 0 on success, -errno on failure.
+ */
+int octep_ctrl_net_dev_remove(struct octep_device *oct, int vfid);
+
 /**
  * octep_ctrl_net_uninit() - Uninitialize data for ctrl net.
  *
-- 
2.25.1

