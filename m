Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952FE7DF87D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377164AbjKBRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjKBRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:15:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD78184;
        Thu,  2 Nov 2023 10:14:57 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2CoMAq001237;
        Thu, 2 Nov 2023 17:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UoSATDI0JClWkWGMLQJA2GrcmBkv8AT6PNP7LUJlb8I=;
 b=ptHvLNnjfN1xQMUTH3yiuXExGMleIDevFjhUtMYBnvUXsLiXhuHjnGiRBhrgvTQb7lZg
 8JSD/ukKFR7XvEUVRJM0ECT9cWgBCMlfpTJeqcSNXfRj9/CQp8KrMBCv258oA8udFBLj
 VY/VRthPjrsjsdPQDKcNn+KmZGoZlsBY1ANb5vg5Sbafpu+1d+gVgHLMTb06LJu22Oba
 v5QY5JhKotR+d55Wi+sp9Kk2FnANGrT5py6e1aehnWGu7+BCrp44vDHO8jfo5BQMgq9f
 PD9rduvrWqPsGcVIK9AgDs9YHhQsGvILqrsUGzDO39DBum4O4pLLOsoXWF8rldC3pybo 1w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u477ps4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 17:14:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A2HEoZs001550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 17:14:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 2 Nov 2023 10:14:48 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v10 3/4] firmware: qcom: scm: Rework dload mode availability check
Date:   Thu, 2 Nov 2023 22:44:06 +0530
Message-ID: <1698945247-16033-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698945247-16033-1-git-send-email-quic_mojha@quicinc.com>
References: <1698945247-16033-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jJJVNY03oNNsavL4_QnOMsUR5KpCJGki
X-Proofpoint-ORIG-GUID: jJJVNY03oNNsavL4_QnOMsUR5KpCJGki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020141
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_SCM_BOOT_SET_DLOAD_MODE was only valid for very older
target and firmware and for recent targets there is dload
mode tcsr registers is available to set the download mode.

So, it is better to keep it as fallback check instead of
checking its availability and failing it always.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 4421f219fe9a..87bcd5c02f2b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -532,18 +532,16 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 static void qcom_scm_set_download_mode(bool enable)
 {
 	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
-	bool avail;
 	int ret = 0;
 
-	avail = __qcom_scm_is_call_available(__scm->dev,
-					     QCOM_SCM_SVC_BOOT,
-					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
-	if (avail) {
-		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
-	} else if (__scm->dload_mode_addr) {
+	if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
 				      QCOM_DLOAD_MASK,
 				      FIELD_PREP(QCOM_DLOAD_MASK, val));
+	} else if (__qcom_scm_is_call_available(__scm->dev,
+						QCOM_SCM_SVC_BOOT,
+						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
+		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.7.4

