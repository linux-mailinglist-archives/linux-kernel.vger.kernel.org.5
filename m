Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB47D7B24
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjJZDCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZDC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:02:27 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE318C;
        Wed, 25 Oct 2023 20:02:25 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PJwThe015247;
        Wed, 25 Oct 2023 20:02:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=kyPnr25U7XCn3GEnW0XrY5a9Wi8LocbeayKKqDZ8C+Y=;
 b=JQuSjx4+jIlHZNTLqSicah/igfOLAG7Sm5jwjgUHgDcvbvtpWARhMP6In1DQoE86j5rU
 17ctZxZt87MvQUwkP+22pthyLklV+tA3VXO5Hj5bZR8mt+j0P0MVpbg3/BVFFXqSNBO0
 PyyiPEL01M/u9JzR5i07d68TQUNLagk+65LZLR4ydTiD8Ls0mhNVTRasmpWdeN1ay4aI
 fkdD/QxiDwNoo0ZMgqwzNc5YSKygak3hDlQrC0pHWCDOSE4eRwSCbU3Cdstaydtuye/Z
 E4rqqZLHxgqmGKztLBkDur6eDxgkozTaGJ+jDrZU5La3EvKI58xTeG8JMqRU46SIqcpH YA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ty0vrbt29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 20:02:07 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 25 Oct
 2023 20:02:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 25 Oct 2023 20:02:00 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id D1C7D3F7097;
        Wed, 25 Oct 2023 20:01:56 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-pf: Fix holes in error code
Date:   Thu, 26 Oct 2023 08:31:54 +0530
Message-ID: <20231026030154.1317011-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uU_82npvhk0qncD9hR83J1j7-38HOtU4
X-Proofpoint-ORIG-GUID: uU_82npvhk0qncD9hR83J1j7-38HOtU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error code strings are not getting printed properly
due to holes. Print error code as well.

Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 65 ++++++++++---------
 .../marvell/octeontx2/nic/otx2_struct.h       | 34 +++++-----
 2 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6daf4d58c25d..e82724f69406 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1193,31 +1193,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] = {
 };
 
 static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =  {
-	"NIX_SND_STATUS_GOOD",
-	"NIX_SND_STATUS_SQ_CTX_FAULT",
-	"NIX_SND_STATUS_SQ_CTX_POISON",
-	"NIX_SND_STATUS_SQB_FAULT",
-	"NIX_SND_STATUS_SQB_POISON",
-	"NIX_SND_STATUS_HDR_ERR",
-	"NIX_SND_STATUS_EXT_ERR",
-	"NIX_SND_STATUS_JUMP_FAULT",
-	"NIX_SND_STATUS_JUMP_POISON",
-	"NIX_SND_STATUS_CRC_ERR",
-	"NIX_SND_STATUS_IMM_ERR",
-	"NIX_SND_STATUS_SG_ERR",
-	"NIX_SND_STATUS_MEM_ERR",
-	"NIX_SND_STATUS_INVALID_SUBDC",
-	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
-	"NIX_SND_STATUS_DATA_FAULT",
-	"NIX_SND_STATUS_DATA_POISON",
-	"NIX_SND_STATUS_NPC_DROP_ACTION",
-	"NIX_SND_STATUS_LOCK_VIOL",
-	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
-	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
-	"NIX_SND_STATUS_NPC_MCAST_ABORT",
-	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
-	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
-	"NIX_SND_STATUS_SEND_STATS_ERR",
+	[NIX_SND_STATUS_GOOD] = "NIX_SND_STATUS_GOOD",
+	[NIX_SND_STATUS_SQ_CTX_FAULT] = "NIX_SND_STATUS_SQ_CTX_FAULT",
+	[NIX_SND_STATUS_SQ_CTX_POISON] = "NIX_SND_STATUS_SQ_CTX_POISON",
+	[NIX_SND_STATUS_SQB_FAULT] = "NIX_SND_STATUS_SQB_FAULT",
+	[NIX_SND_STATUS_SQB_POISON] = "NIX_SND_STATUS_SQB_POISON",
+	[NIX_SND_STATUS_HDR_ERR] = "NIX_SND_STATUS_HDR_ERR",
+	[NIX_SND_STATUS_EXT_ERR] = "NIX_SND_STATUS_EXT_ERR",
+	[NIX_SND_STATUS_JUMP_FAULT] = "NIX_SND_STATUS_JUMP_FAULT",
+	[NIX_SND_STATUS_JUMP_POISON] = "NIX_SND_STATUS_JUMP_POISON",
+	[NIX_SND_STATUS_CRC_ERR] = "NIX_SND_STATUS_CRC_ERR",
+	[NIX_SND_STATUS_IMM_ERR] = "NIX_SND_STATUS_IMM_ERR",
+	[NIX_SND_STATUS_SG_ERR] = "NIX_SND_STATUS_SG_ERR",
+	[NIX_SND_STATUS_MEM_ERR] = "NIX_SND_STATUS_MEM_ERR",
+	[NIX_SND_STATUS_INVALID_SUBDC] = "NIX_SND_STATUS_INVALID_SUBDC",
+	[NIX_SND_STATUS_SUBDC_ORDER_ERR] = "NIX_SND_STATUS_SUBDC_ORDER_ERR",
+	[NIX_SND_STATUS_DATA_FAULT] = "NIX_SND_STATUS_DATA_FAULT",
+	[NIX_SND_STATUS_DATA_POISON] = "NIX_SND_STATUS_DATA_POISON",
+	[NIX_SND_STATUS_NPC_DROP_ACTION] = "NIX_SND_STATUS_NPC_DROP_ACTION",
+	[NIX_SND_STATUS_LOCK_VIOL] = "NIX_SND_STATUS_LOCK_VIOL",
+	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] = "NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
+	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] = "NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
+	[NIX_SND_STATUS_NPC_MCAST_ABORT] = "NIX_SND_STATUS_NPC_MCAST_ABORT",
+	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] = "NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
+	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] = "NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
+	[NIX_SND_STATUS_SEND_MEM_FAULT] = "NIX_SND_STATUS_SEND_MEM_FAULT",
+	[NIX_SND_STATUS_SEND_STATS_ERR] = "NIX_SND_STATUS_SEND_STATS_ERR",
 };
 
 static irqreturn_t otx2_q_intr_handler(int irq, void *data)
@@ -1282,8 +1283,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			goto chk_mnq_err_dbg;
 
 		sq_op_err_code = FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
-		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=%s\n",
-			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
+		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=%s(%#x)\n",
+			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code], sq_op_err_code);
 
 		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
 
@@ -1300,16 +1301,18 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			goto chk_snd_err_dbg;
 
 		mnq_err_code = FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
-		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=%s\n",
-			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
+		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=%s(%#x)\n",
+			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code], mnq_err_code);
 		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
 
 chk_snd_err_dbg:
 		snd_err_dbg = otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
 		if (snd_err_dbg & BIT(44)) {
 			snd_err_code = FIELD_GET(GENMASK(7, 0), snd_err_dbg);
-			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s\n",
-				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
+			netdev_err(pf->netdev,
+				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s(%#x)\n",
+				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code],
+				   snd_err_code);
 			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
 		}
 
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

