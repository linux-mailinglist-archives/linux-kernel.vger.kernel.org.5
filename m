Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB057D8D15
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjJ0CUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0CUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:20:13 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC46187;
        Thu, 26 Oct 2023 19:20:11 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QIoI84018729;
        Thu, 26 Oct 2023 19:20:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=58+E2NdiPRM8G/yOQoiAbQz0nAwGmwsHu+Lu5Ee2A7k=;
 b=CT1RE1UYfV4zhEGOWSC5/3oSVE3rYf4s6LAfa6M4+14L0TzgFMVV4E0xgRDUTXy+dIp/
 0hEy5Crd3nCrMEyhF9O6hdVjYVff0t8tsmYdaBEZyuditDfv7c0H/KHTqAaTtNW4zdsv
 X39Dlib8UzDNNv/0vJL1VmGBHEFI0Ka64G+5triXhvnuZd4ILWTi9QutYjmaSGcvyZP+
 V0G4MnmQ+T7QpM7aUzIU5dGRQhR0NiE9OnD+tA4GY1pkbDMLEuleSjLUZCiveOGZ05Ml
 mdKgykciVdrqTlUpP2q/1mW2NE3XwJ7DCjBSNWKSpZBX+YUGgE8Vg6iBRiefL9VQgS2Z Fg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tywr81e17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 19:20:05 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 26 Oct
 2023 19:20:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 26 Oct 2023 19:20:03 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 8E3883F7082;
        Thu, 26 Oct 2023 19:19:59 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <wojciech.drewek@intel.com>,
        "Ratheesh Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net v1 1/2] octeontx2-pf: Fix error codes
Date:   Fri, 27 Oct 2023 07:49:52 +0530
Message-ID: <20231027021953.1819959-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VMFMEzM09_6SeQ5Cf8wsf08RXU4X_KwD
X-Proofpoint-ORIG-GUID: VMFMEzM09_6SeQ5Cf8wsf08RXU4X_KwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_22,2023-10-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of error codes were wrong. Fix the same.

Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

ChangeLog
v0 -> v1: Splitted patch into two
---
 .../marvell/octeontx2/nic/otx2_struct.h       | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
index fa37b9f312ca..4e5899d8fa2e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
@@ -318,23 +318,23 @@ enum nix_snd_status_e {
 	NIX_SND_STATUS_EXT_ERR = 0x6,
 	NIX_SND_STATUS_JUMP_FAULT = 0x7,
 	NIX_SND_STATUS_JUMP_POISON = 0x8,
-	NIX_SND_STATUS_CRC_ERR = 0x9,
-	NIX_SND_STATUS_IMM_ERR = 0x10,
-	NIX_SND_STATUS_SG_ERR = 0x11,
-	NIX_SND_STATUS_MEM_ERR = 0x12,
-	NIX_SND_STATUS_INVALID_SUBDC = 0x13,
-	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x14,
-	NIX_SND_STATUS_DATA_FAULT = 0x15,
-	NIX_SND_STATUS_DATA_POISON = 0x16,
-	NIX_SND_STATUS_NPC_DROP_ACTION = 0x17,
-	NIX_SND_STATUS_LOCK_VIOL = 0x18,
-	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x19,
-	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x20,
-	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x21,
-	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x22,
-	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x23,
-	NIX_SND_STATUS_SEND_MEM_FAULT = 0x24,
-	NIX_SND_STATUS_SEND_STATS_ERR = 0x25,
+	NIX_SND_STATUS_CRC_ERR = 0x10,
+	NIX_SND_STATUS_IMM_ERR = 0x11,
+	NIX_SND_STATUS_SG_ERR = 0x12,
+	NIX_SND_STATUS_MEM_ERR = 0x13,
+	NIX_SND_STATUS_INVALID_SUBDC = 0x14,
+	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x15,
+	NIX_SND_STATUS_DATA_FAULT = 0x16,
+	NIX_SND_STATUS_DATA_POISON = 0x17,
+	NIX_SND_STATUS_NPC_DROP_ACTION = 0x20,
+	NIX_SND_STATUS_LOCK_VIOL = 0x21,
+	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x22,
+	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x23,
+	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x24,
+	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x25,
+	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x26,
+	NIX_SND_STATUS_SEND_MEM_FAULT = 0x27,
+	NIX_SND_STATUS_SEND_STATS_ERR = 0x28,
 	NIX_SND_STATUS_MAX,
 };
 
-- 
2.25.1

