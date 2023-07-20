Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558775A731
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGTHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjGTHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:04:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4157269E;
        Thu, 20 Jul 2023 00:04:47 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K5uBqS024037;
        Thu, 20 Jul 2023 07:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=JCRlLyaALX/rXk8AiIWHO2CzHuqrO8zJFdqQXkQj7bA=;
 b=K5a2q+MADzd/EG4Fk9Wzpfb0Jc2RIym+2gFg3bBwF4PW0rd7z57q2EIgnuml5jzaIWZN
 oDWejbTriIrTy5EHTC4wEqZTHscncqClvEcDMskvLS+23KfTiC9f6S3fL/I2bg31Jjjn
 kajadVnu5p5yzs+UrUSUgUfdJTMPtkP5hcXFz+1Cf6pQCM7OgPCuF7MaiQym26rFKbKP
 k7NpFQBdlupZFetwBxkHc0tHtEjYyFq0Cd84pjJOffFRQNBcvAPeH2Yp8KISLxxhgIKe
 2fo+PAlQMc4z7kuhHmQrOI2nfrNZQbZoj2J1RNAZ4kHdqkqM8w2SHTfpLA8O3+lRZd+f MA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxjtjscrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:04:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K74g7x029488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:04:42 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:04:37 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V5 3/3] firmware: scm: Modify only the download bits in TCSR register
Date:   Thu, 20 Jul 2023 12:34:08 +0530
Message-ID: <20230720070408.1093698-4-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vmt_JrVqa_Ko09e4moRsAiwNffYmUtmv
X-Proofpoint-ORIG-GUID: Vmt_JrVqa_Ko09e4moRsAiwNffYmUtmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Ojha <quic_mojha@quicinc.com>

CrashDump collection is based on the DLOAD bit of TCSR register. To retain
other bits, we read the register and modify only the DLOAD bit as the
other bits have their own significance.

Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V5:
	- Added the Signed-off-by tag for user Poovendhan
	- Dropped the macro QCOM_DOWNLOAD_MODE_SHIFT in the favor of
	  PREP_FIELD

 drivers/firmware/qcom_scm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 104d86e49b97..3830dcf14326 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -30,6 +30,10 @@ module_param(download_mode, bool, 0);
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+#define QCOM_DOWNLOAD_FULLDUMP		0x1
+#define QCOM_DOWNLOAD_NODUMP		0x0
+#define QCOM_DOWNLOAD_MODE_MASK		BIT(4)
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -440,6 +444,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 static void qcom_scm_set_download_mode(bool enable)
 {
 	bool avail;
+	int val;
 	int ret = 0;
 
 	avail = __qcom_scm_is_call_available(__scm->dev,
@@ -448,8 +453,10 @@ static void qcom_scm_set_download_mode(bool enable)
 	if (avail) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
-		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+		val = enable ? QCOM_DOWNLOAD_FULLDUMP : QCOM_DOWNLOAD_NODUMP;
+		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
+					       QCOM_DOWNLOAD_MODE_MASK,
+					       FIELD_PREP(QCOM_DOWNLOAD_MODE_MASK, val));
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.34.1

