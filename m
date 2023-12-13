Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41738108E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378477AbjLMD6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378467AbjLMD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:58:33 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B2E9;
        Tue, 12 Dec 2023 19:58:35 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCMH4lI019781;
        Tue, 12 Dec 2023 19:58:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=wYhhUnYpaTFB0YMoL62xpPkjL9eoZHUVOZMZb8+CVoQ=; b=PZt
        7N0/93MOIiaotiab/eGB0Egt/InSmm5ut2vnszDI2rDj1vcyY90lwJ7nZABAgEfN
        jDPJ332LmBMbboOg9o+VsvSOMoTx1++7+KrBFWTSKPHfTkxweTbApw5EApQI0mer
        iHEsTUp0/QXn34IPd5vZc9jqw6SwgXyxPvjkqXxbXxl6Gso0xDeOQCjcd+RpMM6/
        qrnLqjhiFJ4+lgHc6nn+BlOiFoauEYWQ7eJ1KDzwQKyDrtYaZKfqurEFoqXkLlQq
        bKRow3JjmPUJ/UOsoJr+NceJYj1eXUbkkktng9pFSrqABMhP1Gh4OvlUDoWkS3WJ
        Ti03VjV0h/IyXRI97gw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uvrmjv2wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 19:58:28 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Dec
 2023 19:58:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 12 Dec 2023 19:58:26 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 0692B3F7043;
        Tue, 12 Dec 2023 19:58:26 -0800 (PST)
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
Subject: [PATCH net-next v4 2/4] octeon_ep: PF-VF mailbox version support
Date:   Tue, 12 Dec 2023 19:58:07 -0800
Message-ID: <20231213035816.2656851-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213035816.2656851-1-srasheed@marvell.com>
References: <20231213035816.2656851-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EpkbNou-eJY1vRwcL_A64IsfqnD0HyKd
X-Proofpoint-ORIG-GUID: EpkbNou-eJY1vRwcL_A64IsfqnD0HyKd
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
V4:
  - No changes

V3: https://lore.kernel.org/all/20231211063355.2630028-3-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20231209081450.2613561-3-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231208070352.2606192-3-srasheed@marvell.com/

 .../net/ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c  | 15 ++++++++++++---
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.h  |  7 +++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

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
index 43b40e91f7bf..baffe298a2a0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -28,10 +28,18 @@ static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
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
@@ -167,6 +175,7 @@ int octep_setup_pfvf_mbox(struct octep_device *oct)
 			goto free_mbox;
 
 		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
+		memset(&oct->vf_info[i], 0, sizeof(struct octep_pfvf_info));
 		mutex_init(&oct->mbox[ring]->lock);
 		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
 		oct->mbox[ring]->wk.ctxptr = oct->mbox[ring];
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
index 34feeb559b0d..af4dcf5ef7f1 100644
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
@@ -30,7 +34,7 @@ enum octep_pfvf_mbox_opcode {
 	OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS,
 	OCTEP_PFVF_MBOX_CMD_GET_MTU,
 	OCTEP_PFVF_MBOX_CMD_DEV_REMOVE,
-	OCTEP_PFVF_MBOX_CMD_LAST,
+	OCTEP_PFVF_MBOX_CMD_MAX,
 };
 
 enum octep_pfvf_mbox_word_type {
@@ -79,7 +83,6 @@ enum octep_pfvf_link_autoneg {
 
 #define OCTEP_PFVF_MBOX_TIMEOUT_MS     500
 #define OCTEP_PFVF_MBOX_MAX_RETRIES    2
-#define OCTEP_PFVF_MBOX_VERSION        0
 #define OCTEP_PFVF_MBOX_MAX_DATA_SIZE  6
 #define OCTEP_PFVF_MBOX_MORE_FRAG_FLAG 1
 #define OCTEP_PFVF_MBOX_WRITE_WAIT_TIME msecs_to_jiffies(1)
-- 
2.25.1

