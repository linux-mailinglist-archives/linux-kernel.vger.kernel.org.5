Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB88136A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjLNQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjLNQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:46:07 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB912D;
        Thu, 14 Dec 2023 08:46:13 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEFKh18001581;
        Thu, 14 Dec 2023 08:45:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=RvfpBnCACTU6sC+JJ6zDpSUjvbw9f20fkg5+4vx5i0o=; b=dCr
        cq6ZhHuiQyl0UTDVFE5FoAnO1QGEN91F9SN0G7SMaMD7azJbDjI4P+NIgu38l8dJ
        p8s+fR0KvjXprY7zpUQp0BHfLChgPoiJbVV9GZkHjHf8Xjh8bdYrKeTYomq/UwXD
        9KAHUY6e6VhaRQjdzOGAG+CZegNrbQStufK4xS0RhWQiCMfM57Pu70K1ZN6GfaEl
        yOVB4lNa3yBCsN3uQqiwe4Q/YAS5Pmv4Dpo/+Q8pYJ6MzEySa9YdQ/KgV/gr/rYz
        cHexBPLyeJExwVmDUx8ZmBJmnFjEBHNKvySY7deKmbyo/ppiNeg+gzB7GPPQs5bF
        iJNQWSKAdp4rvhOl9ag==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0m9fy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 08:45:56 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 08:45:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 08:45:55 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id B76D13F708A;
        Thu, 14 Dec 2023 08:45:54 -0800 (PST)
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
Subject: [PATCH net-next v5 2/4] octeon_ep: PF-VF mailbox version support
Date:   Thu, 14 Dec 2023 08:45:34 -0800
Message-ID: <20231214164536.2670006-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214164536.2670006-1-srasheed@marvell.com>
References: <20231214164536.2670006-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hwzTw8l1G7Qdky8kjixDMxS3Nor8fI-l
X-Proofpoint-ORIG-GUID: hwzTw8l1G7Qdky8kjixDMxS3Nor8fI-l
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

Add PF-VF mailbox initial version support

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V5:
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

