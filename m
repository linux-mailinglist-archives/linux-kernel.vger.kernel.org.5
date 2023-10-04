Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113427B8672
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbjJDR0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbjJDR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:26:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F22DC9;
        Wed,  4 Oct 2023 10:26:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FA2KA028553;
        Wed, 4 Oct 2023 17:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TNus+WyEPPAM4ApHnIG0b4ppmXi2u90fh5BMwyWbLes=;
 b=lavwh1KPe2bf5rZhEHjinJ7DreqFh7gkfY8YFFksXY81gk07WK+aYDUoVuFIrughFLxu
 BxP3bdQfnnFeEoXkO5yKvOsPwMdMXCKsWQvQ++Bn3D6vdsfng3UH9GBJlR9oaZjHXTX9
 sZDijhJm8hTBUBVFz6y1doaMyN8VTl+/BqVbRwsGqIajxZyWPI/vLyrA/SbZfaC6LUuQ
 OVG9+D5lT7LxouKLphc5S9X5oaxeePOg6m6/byM2UAO2mrFVVmToCcGc8X3YwNA1onow
 LoaAi8pUXDGWD/VPSNxTd6XN3mTLWvKI5eYJQXSF6sZ5gJRJqr6CWMo4hl7+UFXU4wWl ew== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgxrjt345-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 17:26:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394HQ38p003666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 17:26:03 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 10:26:00 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Subject: [PATCH v7 3/3] firmware: scm: Modify only the download bits in TCSR register
Date:   Wed, 4 Oct 2023 22:55:38 +0530
Message-ID: <1696440338-12561-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2zDRKGbJcVPRRNiFHdheXzVUwDXlN75R
X-Proofpoint-ORIG-GUID: 2zDRKGbJcVPRRNiFHdheXzVUwDXlN75R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_09,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashdump collection is based on the DLOAD bit of TCSR register.
To retain other bits, we read the register and modify only the
DLOAD bit as the other bits have their own significance.

Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
---
 drivers/firmware/qcom_scm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 084e4782b88d..da3d028f6451 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -27,6 +29,10 @@
 static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
 module_param(download_mode, bool, 0);
 
+#define QCOM_DLOAD_MASK		GENMASK(5, 4)
+#define QCOM_DLOAD_FULLDUMP	0x1
+#define QCOM_DLOAD_NODUMP	0x0
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
@@ -518,6 +524,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 
 static void qcom_scm_set_download_mode(bool enable)
 {
+	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
 	bool avail;
 	int ret = 0;
 
@@ -527,8 +534,9 @@ static void qcom_scm_set_download_mode(bool enable)
 	if (avail) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
-		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
+					       QCOM_DLOAD_MASK,
+					       FIELD_PREP(QCOM_DLOAD_MASK, val));
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
-- 
2.7.4

