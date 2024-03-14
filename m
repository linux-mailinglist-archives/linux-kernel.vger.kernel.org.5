Return-Path: <linux-kernel+bounces-103222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F787BC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E6F28533E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A66FE19;
	Thu, 14 Mar 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="efy2nGud"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9E6FBB8;
	Thu, 14 Mar 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418400; cv=none; b=DngYxi9s4qJcEFBTASayrDRkixMW8sr82wNb0F33tJkitVtcwe3dQpeFZMnYx/pb0fSNec9G/2L+jieCyNgA8wCMjYF4Tyh4hvBIlEVAeP1qV5JlMZKwffBJw1ek5MoIeDvuG9VSLC7nU1ajTk6Ky0eNNMACHvOruU42tNmYuPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418400; c=relaxed/simple;
	bh=ggjWaA3TyfOC5HbQubFdLDuHfb92UY9bKjKeA3wCvAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FP5VKneC8T3XU+r8wV6SHecWlI7fPeJZqk8ci/pAs2MhLp4ZrA0X/TLmBmcTle5clx56oDs7eumkuFGCOwQzNayV1+fr8m+PX8GLn8GN4Pg1LbprrOeaQrBe49Yk01YcVxsclaM/mXuw027nZGfrjRuCJVGBu2r3O1VruQQ2TG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=efy2nGud; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E5uxSU020619;
	Thu, 14 Mar 2024 12:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=9aOw8ma95arSkhpm2Jtv
	UEM/jxcsRRTPFhWk6Fcwb5Q=; b=efy2nGudEJL6OnODQPHDd8m+TRG4YXc8XQBl
	8VU10S9wUOfGGxa6cikfqPWK+Ub48sLHAG+GOfM+LBFncLCRjXINiz+4ojaJBWX+
	Tl4ysYgEbwwRMy6mybl3mmR1lwA8bYnsDiJWurOPWtTZmjlUG6NDxdRQvCviOQNV
	mAmNvTjDqTuHLalc2N6KEMNGPaMjafpcP6hmVhDMDaLUTIapXaj4TijEAqmRLO/j
	Z8Um0H+LTDieslwmCL5Ep9qDRAQCjCgZSTLjqrgBYgsBd5YR7xUpn9L7i2bMhtrH
	lh3yQtOa6YI700QJN8J7lPAhjCSLb0SjMwcrXG/Qjr0rHNplFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuuhrrtn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 12:13:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ECDCHt018735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 12:13:12 GMT
Received: from hu-amrianan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 05:13:05 -0700
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
Subject: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for multiple DT
Date: Thu, 14 Mar 2024 17:41:52 +0530
Message-ID: <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Z6uz8jqyl86qsqBw4FdlHNEy5JaN_hZB
X-Proofpoint-GUID: Z6uz8jqyl86qsqBw4FdlHNEy5JaN_hZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_10,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403140088

Qualcomm produces a lot of "unique" boards with slight differences in
SoC's and board's configuration. For eg, there can be SM8150v1 on MTPv1,
SM8150v1 on MTPv2, SM8150v2 on MTPv2, SM8150v2 on MTPv2 with a different
PMIC, SM8150v2 with no modem support and so on. For instance, suppose we
have 3 SoC, each with 4 boards supported, along with 2 PMIC support for
each case which would lead to total of 24 DTB files. Along with these
configurations, OEMs may also add certain additional board variants. Thus
a mechanism is required to pick the correct DTB for the corresponding board.

Introduce mechanism to select required DTB using newly introduced device
tree properties "board-id" and "board-id-type". "board-id" will contain
the list of values of "qcom,soc-id", "qcom,board-id", "qcom,pmic-id" or
"qcom,oem-id". "board-id-types" contains the type of parameter which is
entered. It can be either "qcom,soc-id", "qcom,board-id", "qcom,pmic-id"
or "qcom,oem-id".

Qualcomm based bootloader will use these properties to pick the best
matched DTB to boot the device with.

Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 90 +++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7f80f48..dc66ae9 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1100,6 +1100,76 @@ properties:
       kernel
       The property is deprecated.
 
+  board-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 2
+    description: |
+      Qualcomm specific bootloader uses multiple different identifiers
+      (qcom,soc-id, qcom,board-id, qcom,pmic-id, qcom,oem-id) to select
+      single Devicetree among list of Devicetrees. For different identifiers,
+      the selection can be done either based on exact match (where the
+      identifiers information coming from firmware should exactly match
+      the ones described in devicetree) or best match (firmware provided
+      identifier information closely matches with the one of the Devicetree).
+      Below table describes matching criteria for each identifier::
+      |----------------------------------------------------------------------|
+      |  DT property  |  Individual fields   |   Exact  |  Best  |  Default  |
+      |----------------------------------------------------------------------|
+      | qcom,soc-id   |                                                      |
+      |               |  Chipset Id          |     Y    |    N   |     -     |
+      |               |  SoC Revision        |     N    |    Y   |     -     |
+      | qcom,board-id |                                                      |
+      |               |  Board Id            |     Y    |    N   |     -     |
+      |               |  Board Major         |     N    |    Y   |     -     |
+      |               |  Board Minor         |     N    |    Y   |     -     |
+      |               |  Subtype             |     Y    |    N   |     0     |
+      |               |  DDRtype             |     Y    |    N   |     0     |
+      |               |  BootDevice Type     |     Y    |    N   |     0     |
+      | qcom,pmic-id  |                                                      |
+      |               |  Slave Id            |     Y    |    N   |     0     |
+      |               |  PMIC Id             |     Y    |    N   |     0     |
+      |               |  PMIC Major          |     N    |    Y   |     0     |
+      |               |  PMIC Minor          |     N    |    Y   |     0     |
+      | qcom,oem-id   |                                                      |
+      |               |  OEM Id              |     Y    |    N   |     0     |
+      |----------------------------------------------------------------------|
+      For best match, identifiers are matched based on following priority order::
+      SoC Revision > Board Major > Board Minor > PMIC Major > PMIC Minor
+
+  board-id-types:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+       Each field and helper macros are defined at include/dt-bindings/arm/qcom,ids.
+    minItems: 2
+    items:
+       oneOf:
+         - const: qcom,soc-id
+           description:
+              Matches Qualcomm Technologies, Inc. boards with the specified SoC.
+              2 integers are needed to describe a soc-id. The first integer is the
+              SoC ID and the second integer is the SoC revision.
+              qcom,soc-id = <soc-id  soc-revision>
+         - const: qcom,board-id
+           description: |
+              Matches Qualcomm Technologies, Inc. boards with the specified board.
+              2 integers are needed to describe a board-id. The first integer is the
+              board ID. The second integer is the board-subtype.
+              qcom,board-id = <board-id  board-subtype>
+         - const: qcom,pmic-id
+           description: |
+              Qualcomm boards can be attached to multiple PMICs where slave-id (SID)
+              indicates the address of the bus on which the PMIC is attached. It can be
+              any number. The model for a PMIC indicates the PMIC name attached to bus
+              described by SID along with  major and minor version. 2 integers are needed
+              to describe qcom,pmic-id. The first integer is the slave-id and the second integer
+              is the pmic model.
+              qcom,pmic-id = <pmic-sid pmic-model>
+         - const: qcom,oem-id
+           description: |
+              Matches Qualcomm Technologies, Inc. boards with the specified OEM ID.
+              1 integer is needed to describe the oem-id.
+              qcom,oem-id = <oem-id>
+
 allOf:
   # Explicit allow-list for older SoCs. The legacy properties are not allowed
   # on newer SoCs.
@@ -1167,4 +1237,24 @@ allOf:
 
 additionalProperties: true
 
+examples:
+  - |
+    #include <dt-bindings/arm/qcom,ids.h>
+    / {
+         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
+         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
+
+         #board-id-cells = <2>;
+         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
+                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
+                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
+         board-id-types = "qcom,soc-id",
+                          "qcom,soc-id",
+                          "qcom,board-id";
+
+         #address-cells = <2>;
+         #size-cells = <2>;
+    };
+
+
 ...
-- 
2.7.4


