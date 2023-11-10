Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D057E7E93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjKJRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjKJRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161AE2BE15;
        Fri, 10 Nov 2023 01:20:51 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gEvI022691;
        Fri, 10 Nov 2023 09:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BnzvfX965d57FCX6Rbr2bvB/qlAev6go7tnJ3+qta8k=;
 b=hA3HWVuHa9Irgi9a/Q6fyGhqhtDFwNOlBFAD3Woysx5gkUkmf6vJ3+D+16H4K41OBKcc
 Ej8BLpolgZQInuzMpAH5nCSrOhONqZEmkXlOeS7gG65498Y8C1WIap9tQNc/W6+S/1qz
 eIDcDF3Ggaj18kABloUBnpUFdb5H4Pe597Rvx0bhBfkzvBiDBvujUoEYG9gh+aBQ8Dpd
 lWxX/4REZ3VePL+Wncic3XzhdQAn5A5Hu0GqE/nY4KT3qek2j8fux6I6fh1kz3K6HY9w
 CiC3QrDSfNqqFkeCUQTJDc9H6G1ZItjQzZ2Tbg9NOHJ7Zt0YEX6pcuRXWOpO5tydOJKa Dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8u2tu9vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:20:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA9Kkfa011054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:20:46 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 01:20:38 -0800
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <quic_mmanikan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v6 06/11] firmware: qcom_scm: ipq5332: add support to pass metadata size
Date:   Fri, 10 Nov 2023 14:49:34 +0530
Message-ID: <20231110091939.3025413-7-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110091939.3025413-1-quic_mmanikan@quicinc.com>
References: <20231110091939.3025413-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XciGlSmQLrOybwj9S31g9qjNwxGA4s2B
X-Proofpoint-GUID: XciGlSmQLrOybwj9S31g9qjNwxGA4s2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 security software running under trustzone
requires metadata size. With V2 cmd, pass metadata
size as well.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in v6:
	- Rebased on linux-next

Changes in v5:
	- Rebased on linux-next

Changes in v4:
	- Rebased on linux-next

 drivers/firmware/qcom/qcom_scm.c | 8 ++++++++
 drivers/firmware/qcom/qcom_scm.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..865f07c020a7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -573,6 +573,14 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 
 	desc.args[1] = mdata_phys;
 
+	if (__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
+					 QCOM_SCM_PAS_INIT_IMAGE_V2)) {
+		desc.cmd = QCOM_SCM_PAS_INIT_IMAGE_V2;
+		desc.arginfo =
+			QCOM_SCM_ARGS(3, QCOM_SCM_VAL, QCOM_SCM_RW, QCOM_SCM_VAL);
+		desc.args[2] = size;
+	}
+
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 
 	qcom_scm_bw_disable();
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 4532907e8489..4342d795940b 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -93,6 +93,7 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 
 #define QCOM_SCM_SVC_PIL		0x02
 #define QCOM_SCM_PIL_PAS_INIT_IMAGE	0x01
+#define QCOM_SCM_PAS_INIT_IMAGE_V2	0x1a
 #define QCOM_SCM_PIL_PAS_MEM_SETUP	0x02
 #define QCOM_SCM_PIL_PAS_AUTH_AND_RESET	0x05
 #define QCOM_SCM_PIL_PAS_SHUTDOWN	0x06
-- 
2.34.1

