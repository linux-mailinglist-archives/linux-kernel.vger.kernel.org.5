Return-Path: <linux-kernel+bounces-49585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011D846C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A84294363
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17F77F2B;
	Fri,  2 Feb 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LfdYq9td"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8E65BA5;
	Fri,  2 Feb 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866424; cv=none; b=pv6SE9r2wdYqYRPRy39zPKlQoTEeyzx4EJ/FaG0neNpv2ezNQXDlD2iaKu6azsI0z/6Dc6PrtA5lAfMHyd4WTsXXBZ0lJzzQWOPfdXzUezOtfPuybwkRsOVSQgWqxU0MvXhGr3RBmnouKbrmiJ+yiILq1r4OtUsJfzWBkhvGO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866424; c=relaxed/simple;
	bh=M+aWPuLCB+CFfRhAbs9PuOpoT5UnSdPTM1qXrm+Q10Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG52tk0TuT5zAIHu5OZ/C83BtOa5XrT77uIYHGDuASWeJEUsIFBPcM5BqS7Hlb+vHt/WABWKHT6VsnWH6erf+7h3r9zIE1YF1a1cns8V8JCw8X5D34ICtEx3bmI29B/mk01NAFtUN6fXloHFqnb4t3NUWN33MZhPyei1ez9H34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LfdYq9td; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4123KDno012854;
	Fri, 2 Feb 2024 09:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=0Smu9OPbuIZJeQjZ3sBY
	nzjPuVxq+g/6HsHgM4EhnTk=; b=LfdYq9tdWnwUYoZdyCs2aMKbTkaROTTOe2ro
	esrXww+0LH0MLVqfSXkkbdggQ1Fz8fnSr7BQCTRK0R7u64ib5ooNX6wQra5tmblx
	GxPkXt0xPPSpVepmm5s4s5uu+I77zyyOmvsybtQcRp7T0a951HaN50PB/g9hcBV0
	Kzsh3MGBvMKzjM6RCGHMFdjzpkGxlm4Qyax1JVrhyzEovd42NsVRdaH8CXkz8RfP
	w37qeZFfI2rnArweU8Hbz/ptv2TuHwjzlJ5vl13JKdB7yDe/djD5UMyhHZvg2xoV
	VXbRJ/E3qidRrLuRR3Z1iN/lhAzx8ObN4Fe+ZIX+0tEUK1vgcg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1s0fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 09:33:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4129XTu4009821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 09:33:29 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 01:33:25 -0800
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
Subject: [PATCH v6 03/10] dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element size
Date: Fri, 2 Feb 2024 17:32:37 +0800
Message-ID: <1706866364-19861-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1706866364-19861-1-git-send-email-quic_taozha@quicinc.com>
References: <1706866364-19861-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: klIzg2aq6Sb7LcvmnEExHR3B4YJQpf5p
X-Proofpoint-ORIG-GUID: klIzg2aq6Sb7LcvmnEExHR3B4YJQpf5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=930 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020068

Add property "qcom,cmb-elem-bits" to support CMB(Continuous
Multi-Bit) element for TPDM. The associated aggregator will read
this size before it is enabled. CMB element size currently only
supports 8-bit, 32-bit and 64-bit. Because the existing example
tpdm "tpdm@684c000" which only supports dsb sub-unit, I introduce
a new example "tpdm@6c29000" to describe the usage of this new
property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


