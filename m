Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3781677D7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbjHPBjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjHPBj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:39:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE11FDE;
        Tue, 15 Aug 2023 18:39:27 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G1cgS4008875;
        Wed, 16 Aug 2023 01:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1h7x2LAT852xPcHkKmLQfJ+8rJh7doh2ik0+V80+rkc=;
 b=fjY++XMvXhDD3PcnAGzmn94SUwaFBqI6XBB5crgqyA8ALlQiN964bmn4EgNzRcODHWJY
 gULGBBqAuxnc3g3mNipVnXzNNU+kaC0yAhctBG5ZTWKWWYzeDzj+6uafyNBBADpT8KMY
 8SOf1zeGynwdSjtSiPdV3RkF6rEET+L1Anhvd0x21OAtUqh9JZmzwuzJ4X2CrHm4Qi7l
 7+9sI4qwTlVCxzPb4TuiRmapE1iMo9EITwL6PXXRal9HariWQqajPgRX0XoLUUVmH3tK
 HIXyTbaVpazucEyH2Fshs/rIfdB6xFMz1GwH/Ppmxdb5qQXNgiRoy/f6p8LYpNNAFUUT kA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfuj8jm8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 01:38:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G1clc0014693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 01:38:47 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 18:38:46 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_cang@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] scsi: ufs: mcq: Fix the search/wrap around logic
Date:   Tue, 15 Aug 2023 18:38:29 -0700
Message-ID: <ff49c15be205135ed3ec186f3086694c02867dbd.1692149603.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D8O-W_2VdTQcsN6Pf0dxwEdCjOmkej29
X-Proofpoint-GUID: D8O-W_2VdTQcsN6Pf0dxwEdCjOmkej29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_22,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The search and wrap around logic in the ufshcd_mcq_sqe_search()
function does not work correctly when the hwq's queue depth
is not a power of two number. Correct it so that any queue depth
with a positive integer value within the supported range would work.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 66a4e24..2ba8ec2 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -578,7 +578,6 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 {
 	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
 	struct utp_transfer_req_desc *utrd;
-	u32 mask = hwq->max_entries - 1;
 	__le64  cmd_desc_base_addr;
 	bool ret = false;
 	u64 addr, match;
@@ -606,7 +605,10 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 			ret = true;
 			goto out;
 		}
-		sq_head_slot = (sq_head_slot + 1) & mask;
+
+		sq_head_slot++;
+		if (sq_head_slot == hwq->max_entries)
+			sq_head_slot = 0;
 	}
 
 out:
-- 
2.7.4

