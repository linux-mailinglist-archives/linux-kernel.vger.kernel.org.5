Return-Path: <linux-kernel+bounces-44196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F4841EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EAC1C2543A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BBB605D6;
	Tue, 30 Jan 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nmxzPiiJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE32605B1;
	Tue, 30 Jan 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605422; cv=none; b=k+9rPLRQQp4jtgm40sl7N22JR5lK6Ppcg5+En3cY8pEfz9rmjxuG5jdPxlJ0eghjModtMZlKgrDtgFhFdJ+ueotDcM7KbKNb2XcU0HvGXyzsVZMb2/H44xRf/OJ1MjDvhLCM8WGT4bU7vcaen7r6/zpjwV99PCF6LpGoz7SKCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605422; c=relaxed/simple;
	bh=dRK9ZcIvw7xnHtArNEw0Rcwfr6xVM1nirOoXi4GN47U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GW77/meKOllz9UdD8r5sC7zjevl53DAGeLQaWOCYZ5H2ykQJBGoQ9J9XYDccb0+8+z9uvqmlIhYhnzYxpQQlG6o0VZpg5rbEMGRg7Sqpfr+/x6SeUdIh5Ml3RSNMf0Rcim75eIW9fK7eRpnMvFsknAWbsmRGIrTkAlWnHH2iz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nmxzPiiJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U81bMM002901;
	Tue, 30 Jan 2024 09:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=jLMYgyOfuG3gi7PvjMiA
	yTvmRN59hiahq2AsJjUrgnY=; b=nmxzPiiJtOecID/fmxOvpwvuzx5TqkdYj5so
	9cKaXg91XwinQSGQMZyziWBgb7yGlyhqOLuQDVGWH+kuURU3afFELPfEB6ir4VLQ
	FL8bjb2dGjDuD7yVXTMJ67d+ucnqFoSuhslUIPm7+UoU/2+Og503mnOJaipTr1D7
	utuFtqGysB/eYFDGv6pSNSP5dEryL0nE+4pDqM17Rgzk3pEcd1EJTD7KNPCjyaJE
	aMeUbTv7ZsO5cxs8Q6yzgq+61CrNoo7ZThDFGllZg00M61AZECa2d2jZm2bvWqTz
	mNGTuubVn1auxs3NMMN3t0MRSXeKz5T4NwZrZoivAlFNaQJ1Fw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxsc20ht5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:03:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U93P5o022001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:03:25 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 01:03:21 -0800
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH v5 03/10] dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element size
Date: Tue, 30 Jan 2024 17:02:39 +0800
Message-ID: <1706605366-31705-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NpPB87KVemWrWl29tpDR0fDyOxPythLf
X-Proofpoint-ORIG-GUID: NpPB87KVemWrWl29tpDR0fDyOxPythLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_03,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=905 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300065

Add property "qcom,cmb-elem-bits" to support CMB(Continuous
Multi-Bit) element for TPDM. The associated aggregator will read
this size before it is enabled. CMB element size currently only
supports 8-bit, 32-bit and 64-bit. Because the existing example
tpdm "tpdm@684c000" which only supports dsb sub-unit, I introduce
a new example "tpdm@6c29000" to describe the usage of this new
property.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 61ddc3b5b247..2320b5445900 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -52,6 +52,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8
     enum: [32, 64]
 
+  qcom,cmb-element-bits:
+    description:
+      Specifies the CMB(Continuous Multi-Bit) element size supported by
+      the monitor. The associated aggregator will read this size before it
+      is enabled. CMB element size currently only supports 8-bit, 32-bit
+      and 64-bit.
+    enum: [8, 32, 64]
+
   qcom,dsb-msrs-num:
     description:
       Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
@@ -110,4 +118,21 @@ examples:
       };
     };
 
+    tpdm@6c29000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x06c29000 0x1000>;
+
+      qcom,cmb-element-bits = <64>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_ipcc_out_funnel_center: endpoint {
+            remote-endpoint = <&funnel_center_in_tpdm_ipcc>;
+          };
+        };
+      };
+    };
 ...
-- 
2.17.1


