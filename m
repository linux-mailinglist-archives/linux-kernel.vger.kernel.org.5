Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00C7D4E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJXLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJXLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:11:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924A112C;
        Tue, 24 Oct 2023 04:10:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OAt7ex002437;
        Tue, 24 Oct 2023 11:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=RKHcsUwcj/5VoPnr1a/q9B/c3g3rMYfwfHimA7AV0TU=;
 b=iIyNnwZwuSuO1rZcsbUFcDlgKaXoY0Zz3id476HMsRmPfqW1ZaXujpUyIoCC0epjl+Yq
 STSeSJahQu/LcWg8ZbZtU49njGpVtwXtNUH/QF2zaj/cLqvLwAhip4N7fUgriJiSUast
 WB288vOmCebGINfWWcRvEbhQHIzxjtEr0zy6hCwQH1smGZduJlTAUvc5LKM0SbUlMs3o
 6DaR5oPrLQfihHiGNY6FruY3nqICLTJ9xFQIlFMZcktfg/JAw++Q2ocp4mOm4jqYX5NJ
 3CZaF8KlmXwP6bYErDASiZidoYypmxly40RfLqNQvSFIFTkfCSu7xcnBWINjmQq9Tq9m vw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twsnntf6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 11:10:24 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39OBAMnu017209;
        Tue, 24 Oct 2023 11:10:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3tv7qkedch-1;
        Tue, 24 Oct 2023 11:10:22 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OBAMcQ017204;
        Tue, 24 Oct 2023 11:10:22 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 39OBALoG017203;
        Tue, 24 Oct 2023 11:10:22 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id D6F6E533A; Tue, 24 Oct 2023 19:10:20 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: ufs: qcom: move ufs_qcom_host_reset() to ufs_qcom_device_reset()
Date:   Tue, 24 Oct 2023 19:10:15 +0800
Message-Id: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EoyL9d-JVNstofh06Y_xquhU9LlSo8ih
X-Proofpoint-GUID: EoyL9d-JVNstofh06Y_xquhU9LlSo8ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240094
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PISI test, we found the issue that host Tx still bursting after
H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
reset host before device reset to stop tx burst.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 96cb8b5..43163d3 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -445,12 +445,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	struct phy *phy = host->generic_phy;
 	int ret;
 
-	/* Reset UFS Host Controller and PHY */
-	ret = ufs_qcom_host_reset(hba);
-	if (ret)
-		dev_warn(hba->dev, "%s: host reset returned %d\n",
-				  __func__, ret);
-
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
 	if (ret) {
@@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 static int ufs_qcom_device_reset(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	int ret = 0;
+
+	/* Reset UFS Host Controller and PHY */
+	ret = ufs_qcom_host_reset(hba);
+	if (ret)
+		dev_warn(hba->dev, "%s: host reset returned %d\n",
+				  __func__, ret);
 
 	/* reset gpio is optional */
 	if (!host->device_reset)
-- 
2.7.4

