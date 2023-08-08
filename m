Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5658D7741A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjHHRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjHHRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DD20266;
        Tue,  8 Aug 2023 09:10:56 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37850XFA031800;
        Mon, 7 Aug 2023 23:36:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=Rnc+ftKUsU8eyg4zrqM5+4m4+vz7nG9t59GvON4rMOw=;
 b=i8EK9lYl+wPfemlwDonxA+Iz7GnPdE40Yd19AOd6MhX25UDZtYUeP63J19CpgCGOe43e
 o/Lu2vOgeMVYNJehccMrbclnbdHW8MKiURIQYLbMRa+/Gy1t/+uupTyzX9Kveou3JDaA
 cGAaKjOz0xqUYtnpkScM8EhV9sH35ZcjbeECSJy74JR+LRj3Pqt8Iz8vvPcifKEqYZ5Q
 K/dyVilXU1jsdXylvY6Z9R9c8kym3kPdhsn9HB+ipmtZLFBdUoJb88JwWezWlMkCtk0I
 Fw9dQOvtu4m4YbLbwdyEj+YzJowoQRLdzqeF8+AlOCrnYLjNHfE6Pm+cTv3CrQ5erYyg /A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s9nxkyh5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 23:36:30 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Aug
 2023 23:36:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 7 Aug 2023 23:36:28 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 996E53F70A3;
        Mon,  7 Aug 2023 23:36:24 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net Patch] octeontx2-pf: Allow both ntuple and TC features on the interface
Date:   Tue, 8 Aug 2023 12:06:23 +0530
Message-ID: <20230808063623.22595-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Ah_hQFYnFgNkRrnJGMjQGZIz9w_WJyqc
X-Proofpoint-ORIG-GUID: Ah_hQFYnFgNkRrnJGMjQGZIz9w_WJyqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_04,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation does not allow the user to enable both
hw-tc-offload and ntuple features on the interface. These checks
are added as TC flower offload and ntuple features internally configures
the same hardware resource MCAM. But TC HTB offload configures the
transmit scheduler which can be safely enabled on the interface with
ntuple feature.

This patch fixes the issue by relaxing the checks and ensures
only TC flower offload and ntuple features are mutually exclusive.

Fixes: 4b0385bc8e6a ("octeontx2-pf: Add TC feature for VFs")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 21 +++----------------
 .../marvell/octeontx2/nic/otx2_common.h       | 18 ++++++++++++++++
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  6 ++++++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  6 ++++++
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 77c8f650f7ac..731ef60ef7ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1903,31 +1903,16 @@ int otx2_handle_ntuple_tc_features(struct net_device *netdev, netdev_features_t
 		}
 	}
 
-	if ((changed & NETIF_F_HW_TC) && tc) {
-		if (!pfvf->flow_cfg->max_flows) {
-			netdev_err(netdev,
-				   "Can't enable TC, MCAM entries not allocated\n");
-			return -EINVAL;
-		}
-	}
-
 	if ((changed & NETIF_F_HW_TC) && !tc &&
-	    pfvf->flow_cfg && pfvf->flow_cfg->nr_flows) {
+	    otx2_tc_flower_rule_cnt(pfvf)) {
 		netdev_err(netdev, "Can't disable TC hardware offload while flows are active\n");
 		return -EBUSY;
 	}
 
 	if ((changed & NETIF_F_NTUPLE) && ntuple &&
-	    (netdev->features & NETIF_F_HW_TC) && !(changed & NETIF_F_HW_TC)) {
-		netdev_err(netdev,
-			   "Can't enable NTUPLE when TC is active, disable TC and retry\n");
-		return -EINVAL;
-	}
-
-	if ((changed & NETIF_F_HW_TC) && tc &&
-	    (netdev->features & NETIF_F_NTUPLE) && !(changed & NETIF_F_NTUPLE)) {
+	    otx2_tc_flower_rule_cnt(pfvf) && !(changed & NETIF_F_HW_TC)) {
 		netdev_err(netdev,
-			   "Can't enable TC when NTUPLE is active, disable NTUPLE and retry\n");
+			   "Can't enable NTUPLE when TC flower offload is active, disable TC rules and retry\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index ba8091131ec0..c44ccdd67911 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -945,6 +945,24 @@ static inline u64 otx2_convert_rate(u64 rate)
 	return converted_rate;
 }
 
+static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
+{
+	/* return here if MCAM entries not allocated */
+	if (!pfvf->flow_cfg)
+		return 0;
+
+	return bitmap_weight(pfvf->tc_info.tc_entries_bitmap,
+			     pfvf->flow_cfg->max_flows);
+}
+
+static inline int otx2_is_ntuple_rule_installed(struct otx2_nic *pfvf)
+{
+	if (!pfvf->flow_cfg)
+		return false;
+
+	return (!otx2_tc_flower_rule_cnt(pfvf) && pfvf->flow_cfg->nr_flows);
+}
+
 /* MSI-X APIs */
 void otx2_free_cints(struct otx2_nic *pfvf, int n);
 void otx2_set_cints_affinity(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index c47d91da32dc..2d3d78c5e9e5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -731,6 +731,12 @@ static int otx2_get_rxnfc(struct net_device *dev,
 	struct otx2_nic *pfvf = netdev_priv(dev);
 	int ret = -EOPNOTSUPP;
 
+	if (otx2_tc_flower_rule_cnt(pfvf)) {
+		netdev_err(pfvf->netdev,
+			   "Can't enable NTUPLE when TC flower offload is active, disable TC rules and retry\n");
+		return -EINVAL;
+	}
+
 	switch (nfc->cmd) {
 	case ETHTOOL_GRXRINGS:
 		nfc->data = pfvf->hw.rx_queues;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 5e56b6c3e60a..848bc4e8f1e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1059,6 +1059,12 @@ static int otx2_setup_tc_block_ingress_cb(enum tc_setup_type type,
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
+		if (otx2_is_ntuple_rule_installed(nic)) {
+			netdev_warn(nic->netdev,
+				    "Can't install TC flower offload rule when NTUPLE is active");
+			return -EOPNOTSUPP;
+		}
+
 		return otx2_setup_tc_cls_flower(nic, type_data);
 	case TC_SETUP_CLSMATCHALL:
 		return otx2_setup_tc_ingress_matchall(nic, type_data);
-- 
2.17.1

