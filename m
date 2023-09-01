Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8002578FC90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349265AbjIALpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbjIALop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:44:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E210F6;
        Fri,  1 Sep 2023 04:44:05 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3813FuYj016687;
        Fri, 1 Sep 2023 11:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=757RbEy32EQ3FR5D5IKdaYUd6cyg5UrJAOt22DA7McY=;
 b=Os7gpJZG8GzUg+JF2Lzdi4PinG2wLn3qnBKpIZIPYfmnCimf5Wir5VgYoHDrZj6Oktg7
 3704688eDXLFj8xnRPl7je7t1+vGH35ltnM20bsNnsI11QqqNJhXIMBb0gL03DfXXmYr
 dBzSou7C6Jw4MhjFDIYhNN03KKCydGz+qEx9ZoSaLy4ND6gFyMy5wXwxO1dso7pxbKBq
 hEOzetDkGfvRwij2RzIK/fvnhvlx5GZ2A28yXki5aXdG1Ao8s5GwbyzMM2SVLJ8DdQlG
 vGZD9fxRuz9fWwlxI+i5sZ6yg9HsgG92MN9jVXWTl9GHv2hQexbfsDzEEVxFTQCS1LPp Kw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy9bq22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:43:45 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381Bgm9K013931;
        Fri, 1 Sep 2023 11:43:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj08d-1;
        Fri, 01 Sep 2023 11:43:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381BhgGc014697;
        Fri, 1 Sep 2023 11:43:42 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381Bhfwd014695;
        Fri, 01 Sep 2023 11:43:42 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 3FFAA5006A8; Fri,  1 Sep 2023 17:13:41 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V6 4/6] scsi: ufs: qcom: Align unipro clk attributes configuration as per HPG
Date:   Fri,  1 Sep 2023 17:13:34 +0530
Message-Id: <20230901114336.31339-5-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NeLZrueTS5iRuVmK-fp4c_Krn7i1NIAT
X-Proofpoint-GUID: NeLZrueTS5iRuVmK-fp4c_Krn7i1NIAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=902 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010109
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
in clk scaling post change ops.

Move this to clk scaling pre change ops to align completely with hardware
specification. This doesn't bring any functionality change.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index e3648e936498..d670fcc27ffb 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1410,12 +1410,6 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
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

@@ -1425,6 +1419,11 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
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

