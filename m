Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAF777EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHJRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjHJRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:11:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930126AE;
        Thu, 10 Aug 2023 10:11:39 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A8YUgO021277;
        Thu, 10 Aug 2023 10:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=GbHNFW98eca4Qfh7V7EVB3e4FF63EwA31ytNxTv7wOw=;
 b=QC/jxLIT2K1sbxMSclxlzEQ+2cKG4/IN3RcHun1WS1f6Y/anPJy567ri5ctc+GDFcC6p
 ujlvcgiRWIHThF4MOutPvdDmd9vGTzCKMUbwedlU9qUGg8AMoyfjjgHl+HgxhEWOytYV
 VE89hl990JSiCTKveT+PdJ6QdRdIpvu24xZLUSOccvzA2cTkGbePqqhgncG7PCzxwU+T
 LxgAg+QW+mRA1BGurCtYiCEgBLT7l7k8wyVr2iOGyuzYS2xikwqsOybMCwRqQdNjwaKD
 dzje8SFj2J9D86pr/y95AK5lOS0ADD2s8xpex9aRzUBPcBo7lAs006QL92HJqIvaPioU LA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3scj5mbp80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:11:27 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 10 Aug
 2023 10:11:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 10 Aug 2023 10:11:24 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id F15BE5C68E3;
        Thu, 10 Aug 2023 10:11:20 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>
Subject: [net-next Patch] octeontx2-pf: Allow both ntuple and TC features on the interface
Date:   Thu, 10 Aug 2023 22:41:19 +0530
Message-ID: <20230810171119.23600-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v6bpB2-kcdftdEYbjWDHb6zlzocOdFUW
X-Proofpoint-GUID: v6bpB2-kcdftdEYbjWDHb6zlzocOdFUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

This patch adds the same and ensures only TC flower offload and ntuple
features are mutually exclusive.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 21 +++----------------
 .../marvell/octeontx2/nic/otx2_common.h       |  9 ++++++++
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8336cea16aff..dce3cea00032 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1905,31 +1905,16 @@ int otx2_handle_ntuple_tc_features(struct net_device *netdev, netdev_features_t
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
index 25e99fd2e3fd..5fd05d94de7c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -940,6 +940,15 @@ static inline u64 otx2_convert_rate(u64 rate)
 	return converted_rate;
 }
 
+static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
+{
+	/* return here if MCAM entries not allocated */
+	if (!pfvf->flow_cfg)
+		return 0;
+
+	return pfvf->flow_cfg->nr_flows;
+}
+
 /* MSI-X APIs */
 void otx2_free_cints(struct otx2_nic *pfvf, int n);
 void otx2_set_cints_affinity(struct otx2_nic *pfvf);
-- 
2.17.1

