Return-Path: <linux-kernel+bounces-98793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA105877F84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441EA1F21EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B173FBBC;
	Mon, 11 Mar 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="muHnxhzT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE53FB8C;
	Mon, 11 Mar 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158608; cv=none; b=M+SUpEB7AKzIHc+E/yDWYmzeujDPB0hGG2FoOcDKKtEYYcBfG8JsQDSv9pdHLFxKHuCvHKVqSm+icDlWbx5CzWZ3tzGnzUmSWlq/x0ZRzLk2rfryd6Vu7kqlolciPh36j0wdHFyRsXGl+9lcE62+NJURv2G+sHWf4Kcz/2nBvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158608; c=relaxed/simple;
	bh=DxuAheAzyWyPnONKOWKLqkMFPtWTxXv+a3DCH0nAMoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Icn62o8j8HAXQNb1YJr/qfCbuNE1FH0k7bRE8NQEDJUSVNvN9R/L+3l2+BS3sI+lxjkfcGO/gZ2oZBbvrlbMxZHsF3W4pcjtOrOMuix4XoZNi4dwe3wQscny6bTssEj5wuZNbwSXTE73IHUntC+MUHVVj5NnzrZdnJnU8GXMkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=muHnxhzT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8VmU4006209;
	Mon, 11 Mar 2024 12:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jkcas11pYM1fNduuawdNyHUZ2VvlJjIxO6cqw1TYHP8=; b=mu
	HnxhzTQA6Y3DUMCItYck3EpiX8r3dUGRyNfEcbJUrM01ukH46vefZ9eTCEqnzb9d
	6Vm99h2mnlp6TBP/3/mHxkVRzC+GcO1+3yY5JIIy6k2sItZIVHOUquIjuUPd3ryy
	OHmIOwpsTk2YLQ1zO7rnD1lnA03NlnfHN0Vw4EAbBszPf4d0pgyHF6fCNC4H5ZxU
	JCeDaIA8a61db736bHp8LCamDU6H7//kTmvqPlaaSSFBYpLHsj7bGrNh3alCLg5q
	ve8PRmIXV8vg4zVGkHASUKhlJCjvWQPS68QIjAgYT4G7HpnI/UubrRkVtLWuhHh4
	lMSSL26/5aJqCxHlxE/w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxgt8hke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:03:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BC3Jav017122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:03:19 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 05:03:14 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 3/4] dt-bindings: usb: dwc3: Add QDU1000 compatible
Date: Mon, 11 Mar 2024 17:32:14 +0530
Message-ID: <20240311120215.16845-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
References: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _iZon67T-wWgaLOLGDwCGR8zOg1M7Ivz
X-Proofpoint-GUID: _iZon67T-wWgaLOLGDwCGR8zOg1M7Ivz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=740
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110091

Document the QDU1000 dwc3 compatible.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 63d150b216c5..2437777c166d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,msm8998-dwc3
           - qcom,qcm2290-dwc3
           - qcom,qcs404-dwc3
+          - qcom,qdu1000-dwc3
           - qcom,sa8775p-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
@@ -245,6 +246,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-dwc3
+              - qcom,qdu1000-dwc3
     then:
       properties:
         clocks:
@@ -440,6 +442,7 @@ allOf:
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3
               - qcom,msm8994-dwc3
+              - qcom,qdu1000-dwc3
               - qcom,sa8775p-dwc3
               - qcom,sc7180-dwc3
               - qcom,sc7280-dwc3
--
2.42.0


