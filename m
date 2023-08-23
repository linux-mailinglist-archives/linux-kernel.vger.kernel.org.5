Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E455785C63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjHWPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjHWPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C2E71;
        Wed, 23 Aug 2023 08:44:26 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NBrd7C015705;
        Wed, 23 Aug 2023 15:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=D6bHKDZ9QMKDyv2gadC3pzjbGIfbRCN+evpDghxX9DQ=;
 b=Po182Og9BpLx6kgexaknMI1DKbNkSaF6g+JpAJJForMwx8V/N5vm0P8jOHHEY9qGiLnc
 6xNDb6ZdAzTGQuncDCbH9HUeZj1oVkZrRn0k2WziCrUaVsRqs9qye7ou1ltUbn8tiOC+
 TUD5tDmlbeI3OCUWa0TZh1ce2Cn4ewN/Nu2t1g3ghk+2TEktF/UbXm/tDG52azQrQnPx
 arXqj9LcrXAzaaSNEphpuSsnOGf8rUS40a2Y3NKukLkMpTZMpzjX8mXYJRX5w457vh0h
 eb9jEliwx5kUvmax2IwgXR9A7ev30crdy0dc3zUQLqEOc3qRpYSiTnixFCR8bEYuSNsJ Bg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn3tqj65h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:44:21 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37NFiGuk029184;
        Wed, 23 Aug 2023 15:44:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptm3qe3-1;
        Wed, 23 Aug 2023 15:44:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NFiHTt029212;
        Wed, 23 Aug 2023 15:44:18 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37NFiHDb029207;
        Wed, 23 Aug 2023 15:44:18 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 2F0375000AB; Wed, 23 Aug 2023 21:14:17 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V5 4/6] scsi: ufs: qcom: Align unipro clk attributes as per Hardware specification
Date:   Wed, 23 Aug 2023 21:14:11 +0530
Message-Id: <20230823154413.23788-5-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sNlmSZy_WwPCdNgGtyC6j7UJLvO80NtF
X-Proofpoint-ORIG-GUID: sNlmSZy_WwPCdNgGtyC6j7UJLvO80NtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=970 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES are configured
in clk scaling post change ops. Move this to clk scaling pre change ops to
align with the hardware specification.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8162b19191a9..491c0173603e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1399,12 +1399,6 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
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

@@ -1414,6 +1408,11 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 	return ufs_qcom_cfg_core_clk_ctrl(hba);
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

