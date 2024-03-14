Return-Path: <linux-kernel+bounces-103221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E887BC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62992287222
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198926FE18;
	Thu, 14 Mar 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZZlD64Qz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F646FB9D;
	Thu, 14 Mar 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418400; cv=none; b=J/4RG3hklb4jpXxgbhRpFyyw5EJKgpmLPSC080ksDj4VQdh6MciiCmn/4Iz7fFEGK0wtBXE4vY2NAcM9GUhMbGZ1ajoEnh5JzqeHKqeUw0irpDTHfTMVNxZCpp0/MYG9jsEdXEvIgMXQvlQZc2RLnp4/8Lbo0MlT9/6EanbeGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418400; c=relaxed/simple;
	bh=DvgRtu778GLV2pq8rCxGtA4bmz2/9PJ6p/NClNwheFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgUX3fnoM2LxzPmHGy8oCOuo/Eq9Sd4tefnTfltoKyD78n53igBKILjZGyXBSEkRXyNtUX7uKQy0W9/cqK6qSmhYCnH11uRk6qWxwillSqxbpWrrsQuKZzD6c91S8AchHV1thEmUBJz7M1qTmzFDDH1JBx1IRdfIN5yNplvVeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZZlD64Qz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E9Lw0i018768;
	Thu, 14 Mar 2024 12:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=AsgZE0W8yK2/VbYqsd/i
	NlV6hGVNbQ9xyRtXpfB5ZK4=; b=ZZlD64Qz5pVj8aTXcAkkC32xH2sNvGgdQ2+U
	libNiVgVm2qbVit34j45/Dmhqb4arjtNovgNAhfgIJrHkRcY1h+stOEV0cBXVWJX
	HsHzuJsIsvySvL7dasO9GpQU94XVXOg53qdTWoJjBP51vb71cWfzwL676KFTrK/W
	eeYp5tN3VHIJIB6rwcoYRhf0rM0W9Xq5HVDcVg+Tug7WouTQ3i330BpBQE/BbYU7
	8yjuV4UL7y9LXSorXbCMq4XpQGVcTKjfLUKxfHCA67K4l8t7XXdt+l6qCGi8z+LV
	Wpvqh9fmMADrDaLHhawpLWZqJYU4aFqb8nGBRFiGN1xT+mKPIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wupch1d37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 12:13:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ECD7rI013769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 12:13:07 GMT
Received: from hu-amrianan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 05:13:00 -0700
From: Amrit Anand <quic_amrianan@quicinc.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        <peter.griffin@linaro.org>, <caleb.connolly@linaro.org>,
        <linux-riscv@lists.infradead.org>, <chrome-platform@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>,
        Amrit Anand <quic_amrianan@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Update Devicetree identifiers
Date: Thu, 14 Mar 2024 17:41:51 +0530
Message-ID: <1710418312-6559-2-git-send-email-quic_amrianan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wPf9l5-A9ys5MX7fpUI17M4updpB8R2-
X-Proofpoint-GUID: wPf9l5-A9ys5MX7fpUI17M4updpB8R2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_10,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=820 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140088

Update existing documentation for qcom,msm-id (interchangeably:
qcom,soc-id) and qcom,board-id. Add support for qcom,pmic-id, qcom,oem-id
to support multi-DTB selection on Qualcomm's boards.

"qcom,soc-id", "qcom,board-id" and "qcom,pmic-id" are tuples of two 32-bit
values. The "qcom,oem-id" is a tuple of one 32-bit value.
Introduce macros to help generate SOC, board, PMIC and OEM identifiers.
QCOM_SOC_ID and QCOM_SOC_REVISION can be used to generate qcom,msm-id.
QCOM_BOARD_ID and QCOM_BOARD_SUBTYPE can be used to generate qcom,board-id.
QCOM_PMIC_SID and QCOM_PMIC_MODEL can be used to generate qcom,pmic-id.
QCOM_OEM_ID can be used to generate qcom,oem-id.

Add entries for different types of SoC, boards, DDR type, Boot device
type which are currently used by Qualcomm based bootloader.

Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 86 ++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index f724834..dc24151 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -8,9 +8,14 @@
 #define _DT_BINDINGS_ARM_QCOM_IDS_H
 
 /*
- * The MSM chipset and hardware revision used by Qualcomm bootloaders, DTS for
- * older chipsets (qcom,msm-id) and in socinfo driver:
+ * The MSM chipset ID (soc-id) used by Qualcomm bootloaders,
+ * and in socinfo driver:
+ * where, "a" indicates Qualcomm supported chipsets, example MSM8260, MSM8660 etc
  */
+
+#define QCOM_SOC_ID(a)  ((QCOM_ID_##a) && 0xffff)
+
+
 #define QCOM_ID_MSM8260			70
 #define QCOM_ID_MSM8660			71
 #define QCOM_ID_APQ8060			86
@@ -266,16 +271,79 @@
 #define QCOM_ID_IPQ5302			595
 #define QCOM_ID_IPQ5300			624
 
+ /* The SOC revision used by Qualcomm bootloaders (soc-revision) */
+
+#define QCOM_SOC_REVISION(a)		(a & 0xff)
+
 /*
- * The board type and revision information, used by Qualcomm bootloaders and
- * DTS for older chipsets (qcom,board-id):
+ * The board type and revision information (board-id), used by Qualcomm bootloaders
+ * where, "a" indicates board type which can be either MTP, QRD etc
  */
+
 #define QCOM_BOARD_ID(a, major, minor) \
-	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
+	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | ((QCOM_BOARD_ID_##a) & 0xff))
+
+#define QCOM_BOARD_ID_MTP		0x8
+#define QCOM_BOARD_ID_LIQUID		0x9
+#define QCOM_BOARD_ID_DRAGONBOARD	0xA
+#define QCOM_BOARD_ID_QRD		0x11
+#define QCOM_BOARD_ID_ADP		0x19
+#define QCOM_BOARD_ID_HDK		0x1F
+#define QCOM_BOARD_ID_ATP		0x21
+#define QCOM_BOARD_ID_IDP		0x22
+#define QCOM_BOARD_ID_SBC		0x24
+#define QCOM_BOARD_ID_QXR		0x26
+#define QCOM_BOARD_ID_X100		0x26
+#define QCOM_BOARD_ID_CRD		0x28
+
+/*
+ * The platform subtype is used by Qualcomm bootloaders and
+ * DTS (board-subtype)
+ * where, "a" indicates boot device type, it can be EMMC,
+ * UFS, NAND or OTHER (which can be used for default).
+ * "b" indicates DDR type which can be 128MB, 256MB,
+ * 512MB, 1024MB, 2048MB, 3072MB, 4096MB or ANY 
+ * (which can be used for default).
+ */
+#define QCOM_BOARD_SUBTYPE(a, b, SUBTYPE) \
+	(((QCOM_BOARD_BOOT_##a & 0xf) << 16) | ((QCOM_BOARD_DDRTYPE_##b & 0x7) << 8) | \
+	(SUBTYPE & 0xff))
+
+/* Board DDR Type where each value indicates higher limit */
+#define QCOM_BOARD_DDRTYPE_ANY		0x0
+#define QCOM_BOARD_DDRTYPE_128M		0x1
+#define QCOM_BOARD_DDRTYPE_256M		0x2
+#define QCOM_BOARD_DDRTYPE_512M		0x3
+#define QCOM_BOARD_DDRTYPE_1024M	0x4
+#define QCOM_BOARD_DDRTYPE_2048M	0x5
+#define QCOM_BOARD_DDRTYPE_3072M	0x6
+#define QCOM_BOARD_DDRTYPE_4096M	0x7
 
-#define QCOM_BOARD_ID_MTP			8
-#define QCOM_BOARD_ID_DRAGONBOARD		10
-#define QCOM_BOARD_ID_QRD			11
-#define QCOM_BOARD_ID_SBC			24
+/* Board Boot Device Type */
+#define QCOM_BOARD_BOOT_EMMC		0x0
+#define QCOM_BOARD_BOOT_UFS		0x1
+#define QCOM_BOARD_BOOT_NAND		0x2
+#define QCOM_BOARD_BOOT_OTHER		0x3
+
+/*
+ * The PMIC slave id is used by Qualcomm bootloaders to
+ * indicates which PMIC is attached (pmic-sid)
+ */
+
+#define QCOM_PMIC_SID(a)		(a & 0xff)
+
+/*
+ * The PMIC ID is used by Qualcomm bootloaders to describe the ID
+ * of PMIC attached to bus described by SID (pmic-model)
+ */
+
+#define QCOM_PMIC_MODEL(ID, major, minor) \
+	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | (ID & 0xff))
+
+/*
+ * The OEM ID consists of 32 bit value to support OEM boards where they
+ * have slight differences on top of Qualcomm's standard boards
+ */
+#define QCOM_OEM_ID(a)		(a & 0xffffffff)
 
 #endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */
-- 
2.7.4


