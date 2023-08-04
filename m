Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5176F939
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjHDFBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjHDFAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:00:15 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7214495;
        Thu,  3 Aug 2023 22:00:14 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373NXOTj027576;
        Thu, 3 Aug 2023 21:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Rfmeck+IvCt8OoEJtmSToyQibOTWzvh4zMDthzKkboA=;
 b=GGQEKoqd7G75sNcJaUkyIkJd23LqKNs5uFt+XrX0eGLDHMHBQSNqCEAlFMg2cnlZhYZY
 C+17TSmTCFT6bqMWuLzIrwqynkzjEbT6Uy7GB/BQyRTY4fJGFgVrBEtkXaC8u0TZec2b
 fQFNPzNDVlw/LcC9WXZyXrG16VmyP2l8cYzw5FMyQPcXZ08+MNEfwr5eo7nGvVb7G8e7
 RdJhSOZdYQ9K2BnTjgmc5efwfuMZTnzscLy0/xuODx0HF1NW3RNq3Dn6Mhjz0Ft63ual
 lnSpaEa3IJ5tjDMbIsujwo+yvF24YTC0Dl8Ew/DTzdBfZtxc9d5SxC2tju5PL/Fd28IR pw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s8p0xgnbn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 21:59:52 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 3 Aug
 2023 21:59:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 3 Aug 2023 21:59:50 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id A8C803F7072;
        Thu,  3 Aug 2023 21:59:45 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <simon.horman@corigine.com>, <jesse.brandeburg@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH V5 1/2] octeontx2-af: Code restructure to handle TC outer VLAN offload
Date:   Fri, 4 Aug 2023 10:29:34 +0530
Message-ID: <20230804045935.3010554-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804045935.3010554-1-sumang@marvell.com>
References: <20230804045935.3010554-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FynJva-qntDfR2q0GnnN92_ZyHLtsrmg
X-Proofpoint-ORIG-GUID: FynJva-qntDfR2q0GnnN92_ZyHLtsrmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_02,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved the TC outer VLAN offload support to a separate function.
This change is done to handle all VLAN related changes cleanly from
a dedicated function.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 93 +++++++++++--------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 4bb511e3cbe5..c535e8170efc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -439,6 +439,55 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 	return 0;
 }
 
+static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec,
+				struct flow_msg *flow_mask, struct flow_rule *rule,
+				struct npc_install_flow_req *req, bool is_inner)
+{
+	struct flow_match_vlan match;
+	u16 vlan_tci, vlan_tci_mask;
+
+	if (is_inner)
+		return -EOPNOTSUPP;
+
+	flow_rule_match_vlan(rule, &match);
+	if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
+		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
+			   ntohs(match.key->vlan_tpid));
+		return -EOPNOTSUPP;
+	}
+
+	if (!match.mask->vlan_id) {
+		struct flow_action_entry *act;
+		int i;
+
+		flow_action_for_each(i, act, &rule->action) {
+			if (act->id == FLOW_ACTION_DROP) {
+				netdev_err(nic->netdev,
+					   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+					   ntohs(match.key->vlan_tpid), match.key->vlan_id);
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	if (match.mask->vlan_id ||
+	    match.mask->vlan_dei ||
+	    match.mask->vlan_priority) {
+		vlan_tci = match.key->vlan_id |
+			   match.key->vlan_dei << 12 |
+			   match.key->vlan_priority << 13;
+
+		vlan_tci_mask = match.mask->vlan_id |
+				match.mask->vlan_dei << 12 |
+				match.mask->vlan_priority << 13;
+		flow_spec->vlan_tci = htons(vlan_tci);
+		flow_mask->vlan_tci = htons(vlan_tci_mask);
+		req->features |= BIT_ULL(NPC_OUTER_VID);
+	}
+
+	return 0;
+}
+
 static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 				struct flow_cls_offload *f,
 				struct npc_install_flow_req *req)
@@ -591,47 +640,11 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
-		struct flow_match_vlan match;
-		u16 vlan_tci, vlan_tci_mask;
-
-		flow_rule_match_vlan(rule, &match);
-
-		if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
-			netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
-				   ntohs(match.key->vlan_tpid));
-			return -EOPNOTSUPP;
-		}
-
-		if (!match.mask->vlan_id) {
-			struct flow_action_entry *act;
-			int i;
-
-			flow_action_for_each(i, act, &rule->action) {
-				if (act->id == FLOW_ACTION_DROP) {
-					netdev_err(nic->netdev,
-						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
-						   ntohs(match.key->vlan_tpid),
-						   match.key->vlan_id);
-					return -EOPNOTSUPP;
-				}
-			}
-		}
+		int ret;
 
-		if (match.mask->vlan_id ||
-		    match.mask->vlan_dei ||
-		    match.mask->vlan_priority) {
-			vlan_tci = match.key->vlan_id |
-				   match.key->vlan_dei << 12 |
-				   match.key->vlan_priority << 13;
-
-			vlan_tci_mask = match.mask->vlan_id |
-					match.mask->vlan_dei << 12 |
-					match.mask->vlan_priority << 13;
-
-			flow_spec->vlan_tci = htons(vlan_tci);
-			flow_mask->vlan_tci = htons(vlan_tci_mask);
-			req->features |= BIT_ULL(NPC_OUTER_VID);
-		}
+		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, false);
+		if (ret)
+			return ret;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
-- 
2.25.1

