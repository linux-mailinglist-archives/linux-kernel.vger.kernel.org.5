Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4DC7F0BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjKTFwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:52:02 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A27C5;
        Sun, 19 Nov 2023 21:51:59 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK2ixcu029495;
        Sun, 19 Nov 2023 21:51:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=S8dVyNkVOWEw+9SFPLtXKuGnffnZDVos0PuHKA1XzVc=;
 b=ig2yUXIEbcBZOdRJcwPgLO2a8vU0j4qLNBfPi9MCyZ15Xgkv2tXITZ3S+AU5aSYuV8ce
 jPAwm14lSgb/EIbclkxHTVxE28rPblFAA7P2HbCWRXcluQWH2qKRznZQQ/6/2OfGWp/A
 Qkky5I3TNSrEXH0bxPE2MFAk0aHLOdoOkYNjhoE/hQQo6DW5FSpM4rKXUFLi/X788OVY
 c/MDBTscl/loNnpw2c+U0ps/ePIPrCLNDJFy+t8BxTQTl4ASsnr2t3w1GKY5ZLYcOaCr
 LdFWzMyd6N9MuhoOEI/8l9YvmqSFLSGwriGi7vovsDiEyItWyrmvyMKo2BhV6QnNxekZ 0A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ueuguujya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 21:51:47 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 19 Nov
 2023 21:51:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 19 Nov 2023 21:51:45 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id DF4BE3F7081;
        Sun, 19 Nov 2023 21:51:41 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH] octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF
Date:   Mon, 20 Nov 2023 11:21:38 +0530
Message-ID: <20231120055138.3602102-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EHNlnzMSN3WlnvgNQPnBdJvH-4KyNsFc
X-Proofpoint-ORIG-GUID: EHNlnzMSN3WlnvgNQPnBdJvH-4KyNsFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_03,2023-11-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to add a ntuple rule which would like to direct packet to
a VF whose number of queues are greater/less than its PF's queue numbers.
For example a PF can have 2 Rx queues but a VF created on that PF can have
8 Rx queues. As of today, ntuple rule will reject rule because it is
checking the requested queue number against PF's number of Rx queues.
As a part of this fix if the action of a ntuple rule is to move a packet
to a VF's queue then the check is removed. Also, a debug information is
printed to aware user that it is user's responsibility to cross check if
the requested queue number on that VF is a valid one.

Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_flows.c        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 4762dbea64a1..4200f2d387f6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -1088,6 +1088,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	struct ethhdr *eth_hdr;
 	bool new = false;
 	int err = 0;
+	u64 vf_num;
 	u32 ring;
 
 	if (!flow_cfg->max_flows) {
@@ -1100,9 +1101,26 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
 		return -ENOMEM;
 
+	/* Number of queues on a VF can be greater or less than
+	 * the PF's queue. Hence no need to check for the
+	 * queue count. Hence no need to check queue count if PF
+	 * is installing for its VF. Below is the expected vf_num value
+	 * based on the ethtool commands.
+	 *
+	 * e.g.
+	 * 1. ethtool -U <netdev> ... action -1  ==> vf_num:255
+	 * 2. ethtool -U <netdev> ... action <queue_num>  ==> vf_num:0
+	 * 3. ethtool -U <netdev> ... vf <vf_idx> queue <queue_num>  ==>
+	 *    vf_num:vf_idx+1
+	 */
+	vf_num = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
+	if (!is_otx2_vf(pfvf->pcifunc) && vf_num)
+		goto bypass_queue_check;
+
 	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
 		return -EINVAL;
 
+bypass_queue_check:
 	if (fsp->location >= otx2_get_maxflows(flow_cfg))
 		return -EINVAL;
 
@@ -1182,6 +1200,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 		flow_cfg->nr_flows++;
 	}
 
+	if (flow->is_vf)
+		netdev_info(pfvf->netdev,
+			    "Make sure that VF's queue number is within its queue limit\n");
 	return 0;
 }
 
-- 
2.25.1

