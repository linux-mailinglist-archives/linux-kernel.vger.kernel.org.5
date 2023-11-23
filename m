Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7667F5AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjKWI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:56:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF56A3;
        Thu, 23 Nov 2023 00:56:10 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN6JD3K015853;
        Thu, 23 Nov 2023 08:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=mP3Zh3ghe1QobYCFwkdhcpkOdhL0iT2Q9aPGVoVes/U=;
 b=k4tZR+tMtlstqkBrgmETuO33SOlNJohMaUUZ0TdHEH8dqkb+6Ymh+sH2sOiGTvqBsf28
 H5rBltfC2U+zbthuX6u2BBsvbFXztlvj2AIvcA1QHo8vmvsRnm0rJeQ3zwa12WKxeukQ
 EZ1DPYoX00yVsKZBPSe4fo8y0eF2xVxx6ZLIv8CIOtXdb+zJXE1qHnhb4qXlEFjcwImI
 YGFWJ8iIxASFtOSN5LuK9YGf6AQke7v/jjebnjvvYS7EfX7g8npioGkdx+CWzz3x73j/
 HTArXLU3KnI8K7wryrBF7Kg0Vm22+xk68swqUUUhDEycNuTN+AdMnn1hEmnc3wtoqvgE Cg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhwme8v49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 08:47:03 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AN8VFWN001797;
        Thu, 23 Nov 2023 08:47:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3uhcusvt7e-1;
        Thu, 23 Nov 2023 08:47:03 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN8UVqs000883;
        Thu, 23 Nov 2023 08:47:02 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3AN8l2K3022937;
        Thu, 23 Nov 2023 08:47:02 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
        id CFB9D20A68; Thu, 23 Nov 2023 00:47:01 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/10] scsi: ufs: ufs-qcom: No need to set hs_rate after ufshcd_init_host_param()
Date:   Thu, 23 Nov 2023 00:46:22 -0800
Message-Id: <1700729190-17268-3-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ld5psP53TjFfSqKqOc215_i6Ck2Rsu6n
X-Proofpoint-ORIG-GUID: ld5psP53TjFfSqKqOc215_i6Ck2Rsu6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230062
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ufs_qcom_pwr_change_notify(), host_params.hs_rate has been set to
PA_HS_MODE_B by ufshcd_init_host_param(), hence remove the duplicated line
of work. Meanwhile, removed the macro UFS_QCOM_LIMIT_HS_RATE as it is only
used here.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 1 -
 drivers/ufs/host/ufs-qcom.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index aee66a3..cc30ad9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -909,7 +909,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 	switch (status) {
 	case PRE_CHANGE:
 		ufshcd_init_host_param(&host_params);
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

