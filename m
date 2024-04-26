Return-Path: <linux-kernel+bounces-159537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F18B2FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F88284867
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8813BC2A;
	Fri, 26 Apr 2024 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lR27SZD4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702C13A40D;
	Fri, 26 Apr 2024 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110820; cv=none; b=GDlMQbDecpi0giq5MSPPO43rVbqZz4Oe5N7tEibZ4s3aVIZzOo7ujI+VHO/oCcwQThYP0NsN2juE3IAFnNSifajdwWTaLtkgSqZkYev61Y8q+wPVoPxp7/W22S/VxHZeZ+yiC6OpjNYLnBWEXXBhw3/G3vAZYeNRyz0kDL6SudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110820; c=relaxed/simple;
	bh=j97wrJmhDrkFtsUT1grIZkEdJPgugxdV4Uw9WEJuSos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxNzOyqcJlDXVcDxGdzpnz05y5dALkh5FUEbwP96piDXNSjZ6SLwroxZa+MwZlC3Ee+XE+wLlTST2WDjLsdnpKApicOhRqPzTTugGnp8kOE+5z23effqDJZtK23HHYzRav/Wrv34sJfb5q9gTJmjSD9x2LZvfNZnWdlnFPhNBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lR27SZD4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q3CKKv025010;
	Fri, 26 Apr 2024 05:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=tC/Y04U
	v15aUX5P+ir6hzbsw8akIMt2s/6A0/MT9ChA=; b=lR27SZD4xyW3fSOnBvE2b8g
	GpwPCx9nvz2QtzGvHcitellisXog7TZ3dXKEw1WJO1cZY3uKkyUgc6ugVZUNaRBq
	gOFeRuP4jym2Ui4yaRQTsiaTsyKF2hd/NJ87mMTb5yjKiCfF0fgWHakrmH2ohpT6
	8cK8B8yqA0K4f6conZhFUJ/F/CfE8Gh2WZqXtGDogxDcvQfAFfJPHHnHEKfIAfvr
	IwuETJ2MfNMoEccHLFAyjiJ2uYjD6792/9vhWgW45ojki9fIDrqWxWAESPAcQss8
	EHh5+gfqa7cao0qghBGyqySMOB5SuR5bno3g06cHSMf+oVe6uVC8DL4LdXFlB9w=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhvu66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rTVU002267;
	Fri, 26 Apr 2024 05:53:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6smm8sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rU1g002317;
	Fri, 26 Apr 2024 05:53:30 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43Q5rUIP002316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:30 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id 9C9D220FFA; Fri, 26 Apr 2024 11:23:29 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, jassisinghbrar@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lee@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 6/6] arm64: dts: qcom: sdx75: Add AOSS node
Date: Fri, 26 Apr 2024 11:23:26 +0530
Message-Id: <20240426055326.3141727-7-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BQA0EkTmXJP2GKNKjdhARbfvKoSCLIyP
X-Proofpoint-GUID: BQA0EkTmXJP2GKNKjdhARbfvKoSCLIyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=720 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260034

Add AOSS channel devicetree node for Qcom's SDX75 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index f3f30bbcb37d..96e3eec57008 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sdx75.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -641,6 +642,17 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: power-controller@c310000 {
+			compatible = "qcom,sdx75-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0 0x0c310000 0 0x1000>;
+			interrupt-parent = <&ipcc>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c400000 0x0 0x3000>,
-- 
2.25.1


