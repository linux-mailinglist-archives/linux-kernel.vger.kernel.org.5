Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C6791A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353230AbjIDPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbjIDPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:21:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6021CDA;
        Mon,  4 Sep 2023 08:21:21 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384FJBMb002392;
        Mon, 4 Sep 2023 15:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=lNsXw8LlWHNxrOt8TlUasAzMMA23yvnCrmTO0Zvklak=;
 b=Vu7sa2yAKSrEyxobHuiX8c3pC/b/WccbLcqakzobrq0yMnOh+MhIaAyBAnWM+HcIOzdL
 5AL3qj4K/fIKh09Nltq2yXB3kVyUXNyyD3shkma3g8mnkzkk46TcX01JzJ74u4rHY8uY
 NheUHLSuNQUcTyJNG+/5EBDGEx9KF/9t3XY62LdTtHeP46Y1ckKyZ1oNZwTBmiALXzKD
 FL90UFCSuc6w+ceAT4VJIaQKoJE9eN7ceQZUA+parvVmYeBmqGjNanGjgJBsBSZDH3ST
 yRciWm4vcofGtIH+Y5pwUY4Xyyx2wCCTdeK1gZlSgfRf7qdyD/PtzCc4AoJwbaOOz/+K Kw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suwtpv2h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:21:12 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 384FL9h9023942;
        Mon, 4 Sep 2023 15:21:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4k8yqy-1;
        Mon, 04 Sep 2023 15:21:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384FL9cM023936;
        Mon, 4 Sep 2023 15:21:09 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 384FL9qY023934;
        Mon, 04 Sep 2023 15:21:09 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 5FE81504920; Mon,  4 Sep 2023 20:51:08 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V7 4/5] scsi: ufs: qcom: Align programing of unipro clk attributes
Date:   Mon,  4 Sep 2023 20:50:59 +0530
Message-Id: <20230904152100.30404-5-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
References: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7bTD0CtswEv7rE_nXRnjJXY1B4nUrXh3
X-Proofpoint-GUID: 7bTD0CtswEv7rE_nXRnjJXY1B4nUrXh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES are configured
in clk scaling post change ops. This is not aligning to HPG.

Move this to clk scaling pre change ops to align completely with hardware
specification.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index a4855f0b93b0..d437c75c8e14 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1416,12 +1416,6 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 }

 static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
-{
-	/* nothing to do as of now */
-	return 0;
-}
-
-static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);

@@ -1432,6 +1426,11 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 	return ufs_qcom_set_core_clk_ctrl(hba, true);
 }

+static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
+{
+	return 0;
+}
+
 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
--
2.17.1

