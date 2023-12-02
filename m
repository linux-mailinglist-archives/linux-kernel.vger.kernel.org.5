Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC37A801C95
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjLBMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLBMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:36:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0112E;
        Sat,  2 Dec 2023 04:37:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B2CaeTN027872;
        Sat, 2 Dec 2023 12:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=hI4B+En5B8Tnj5LoYIYk/lWCpU5mfeoE4ccGSVr3iU4=;
 b=Gy/MbLlopk638E+m7O4Yn07hS5x0Q7WZF9CpHTCujkNbji7g1Lm/3nx+Ay6UAg7Z6dPO
 nHtFFE+cmSBMIrLPsNpvOw50Z/QHZ3oMNof8q2lcAD5uP1sM60FrMctCVMfBLKZxWe3/
 39p0enGp9DfJ7uT9T9BrnXCd85dRoH2ScjSJ2hVKEZDL4LAk9RuW7rm8ulzo+ENUDhjx
 +CzML75Bqh0U7WZcqAzGZ5HX6Un+OkYip2TLu26cPr8y+cpxlbo3KfmFjjPSAoA4IoeG
 WeVRefjwkHCiC09qi8AU16JdfMnrcdD6B14N2vQFH7qvQLZHv5qu8VDRm98aGpu6i96k /A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqwbqggnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 02 Dec 2023 12:36:40 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B2Ca9qC017639;
        Sat, 2 Dec 2023 12:36:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3uqwnkb9qk-1;
        Sat, 02 Dec 2023 12:36:39 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B2CadXr018426;
        Sat, 2 Dec 2023 12:36:39 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3B2Cad4v018423;
        Sat, 02 Dec 2023 12:36:39 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id 661D120A90; Sat,  2 Dec 2023 04:36:38 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, vkoul@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 02/10] scsi: ufs: ufs-qcom: No need to set hs_rate after ufshcd_init_host_param()
Date:   Sat,  2 Dec 2023 04:36:08 -0800
Message-Id: <1701520577-31163-3-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3hsTozTYeMJKWV95K81hzMYBlPgR3CEf
X-Proofpoint-GUID: 3hsTozTYeMJKWV95K81hzMYBlPgR3CEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_10,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ufs_qcom_pwr_change_notify(), host_params.hs_rate has been set to
PA_HS_MODE_B by ufshcd_init_host_param(), hence remove the duplicated line
of work. Meanwhile, removed the macro UFS_QCOM_LIMIT_HS_RATE as it is only
used here.

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 1 -
 drivers/ufs/host/ufs-qcom.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 197c5a5..c21ff2c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -909,7 +909,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 	switch (status) {
 	case PRE_CHANGE:
 		ufshcd_init_host_params(&host_params);
-		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
 
 		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
 		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9950a00..82cd143 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -27,8 +27,6 @@
 #define SLOW 1
 #define FAST 2
 
-#define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
-
 /* QCOM UFS host controller vendor specific registers */
 enum {
 	REG_UFS_SYS1CLK_1US                 = 0xC0,
-- 
2.7.4

