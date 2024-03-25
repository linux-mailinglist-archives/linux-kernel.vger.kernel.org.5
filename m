Return-Path: <linux-kernel+bounces-117686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176B88AE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C7F1C60EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56D8836;
	Mon, 25 Mar 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EOy3f9ts"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C84A1E;
	Mon, 25 Mar 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390618; cv=none; b=UKDKgmbUM2BhlJhLj3RtUl8dVoDJdTeMa2h3V2MqmH9ECVRH1N9fPBd5WwFd6cgR8bqFrBXVqgQaNvMxl7Y4pRTMTAnu7bNZWvaIqNsIaiX4lRGMT1zyuQhFXBulTYegfENqEF+5eZ5hbvIzlHsHGOPWn/+LM/lmQWKUDsdendE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390618; c=relaxed/simple;
	bh=xwtZlQRSzEIncth8FBMh9U4sQS1Vy0SBOM+CfuCw/s4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXbmooyBKRj/SN7ILVl5WJflMFaoTKf7xzeiDD9rAE+/uDxRW9Tjv/ffKuSjt9ay5rkiYqBLyuddY9ye046rkjaUHLUEbsnUmef+SSCw+6LjAPr5Fwwi7F/xkmL15SFkQdXlm34942wcVI3/jGJ4xS926UqxqQgtpaMi11aIHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EOy3f9ts; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PCNPaY008401;
	Mon, 25 Mar 2024 18:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Corv7XC0jfZEvU5R/Nlwww06NiqD+/ReBLSDRFB3fHE=; b=EO
	y3f9tsUaqTH0DLTtK29t2lY/iznisjJdrqon3YM3TPSo1nMCcaf/9E7c4wEv0Gws
	FuuZd9LB9JQszsNmrD3eKwxwR7LK8m5VaEok0DTPpeTCwRlPJtq7NKredFtmTJld
	ZNtHSlEOrjBKGvlPhrQL1k7V1t1F1HVDJ4NBJK0Xt9Oj647FXBqhuhclocHmFXgS
	SEJ1SzCXmqMC2Ss0fyZcDerPZ2SGsFBcnBRQrnZpJ+0u1OaTMTGlLv15Tu+8IfCQ
	M7bInzNWpixNVIqo4aFmQWBL82p3MtL3+57QSc1z+7nLn4/yExf6ThojMQtLsTny
	4V4HpYh3+yNT6+j8w/cg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hp1khq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:16:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PIGpkL028410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 18:16:51 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 11:16:47 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
Subject: [PATCH v4 0/4] Add support for QoS configuration
Date: Mon, 25 Mar 2024 23:46:24 +0530
Message-ID: <20240325181628.9407-1-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-ORIG-GUID: yjLl1hmygz50P917MYQxC5n4yNFdKXoi
X-Proofpoint-GUID: yjLl1hmygz50P917MYQxC5n4yNFdKXoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_16,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=884
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250107

This series adds QoS support for QNOC type device which can be found on
SC7280 platform. It adds support for programming priority,
priority forward disable and urgency forwarding. This helps in
priortizing the traffic originating from different interconnect masters
at NOC(Network On Chip).

Changes in v4:
 - Addressed comments related to spacing and line wrapping.
 - Changed the print level from warn to info for regmap related errors.
 - Use of GENMASK instead of BIT_MASK for bit mask creation.

Odelu Kukatla (4):
  interconnect: qcom: icc-rpmh: Add QoS configuration support
  interconnect: qcom: sc7280: enable QoS programming
  dt-bindings: interconnect: add clock property to enable QOS on SC7280
  arm64: dts: qcom: sc7280: Add clocks for QOS configuration

 .../interconnect/qcom,sc7280-rpmh.yaml        |  14 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   3 +
 drivers/interconnect/qcom/icc-rpmh.c          |  99 ++++++
 drivers/interconnect/qcom/icc-rpmh.h          |  34 ++
 drivers/interconnect/qcom/sc7280.c            | 332 ++++++++++++++++++
 5 files changed, 482 insertions(+)

-- 
2.17.1


