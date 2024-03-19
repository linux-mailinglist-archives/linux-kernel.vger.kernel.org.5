Return-Path: <linux-kernel+bounces-107286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C107187FA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23AC1C21B90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB17C6D4;
	Tue, 19 Mar 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JUFyfIUU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4865190;
	Tue, 19 Mar 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839443; cv=none; b=tWOoJVsLs9wEYm/Y2XMUwfbzXPF+28ROrHnDrb62P+IOg8akS7Dr10oYarYrM2vDdiupjZ5SEPJYEuNbO+luX2lcADoyvA9RgOdu54XCC6z4grhfJHr9EM6sgznSTvI792Dm/pdNpW13jRwfqQ+WEPXvfO/d4ZX1QDc6fxklops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839443; c=relaxed/simple;
	bh=2tB6cMW/aJEc9kuea2J/O2S4dbUvWBNBbPbKYg7UBZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PNUbW1bevzVkGDjgO4uW9AlvrCiM2AqzDFFzS0MX8HjfLf21n4R2Za2/4aAcKtvYgpHtP31Htj2FwZv2CtSSC4n9X5bxN+TBN7qRhDCZ9GXeW3ZhE4h5QckxhmdO0upFTXMkejvOWgH1J3majOMI1v0U0sRcjCKA+rxOSKoKTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JUFyfIUU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J20wLL002182;
	Tue, 19 Mar 2024 09:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=7O3bXAV
	6zbaVG8kl5oGpOsKQfTyYBPqJa8P7i6BlG/w=; b=JUFyfIUUFxdUoCb/8TswBh9
	MJ6gRy+cSsMSw6iqgjjhjO72FLTTnzGQ5rBEPsHIBNnKSRfDPZQDZvWvoocVIdCQ
	aiypzT5M4cLyD7Jkg7i2HNs/dUKGqgzsiQvlIsblcJNCxzzpAkMsK4C6BBsHEvUU
	2Cy4tYkfv5HqW6rSZUTdUKWES8uNIGP0qjR20UYP5obU2Q7ZC659MD9M6ph9FHRb
	pMVvatekf6XVuhtz52e+nrMmfzsZtPUVwZPTMgfI/BWVD5CwN6CkvL/Rr76f+ibb
	3Fu+qV/nGbRIkHNO+1rtxyPDougKbiq25tO8XIjTnQ2G423To0pgx8W4tGtZ0rA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1j2gsgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J9AdUg002446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:10:39 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 02:10:35 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 0/3] Add devicetree support of USB for QDU/QRU1000
Date: Tue, 19 Mar 2024 14:40:17 +0530
Message-ID: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XjS2X4FByJT0sg03bnSavW6y0wyH4MTL
X-Proofpoint-ORIG-GUID: XjS2X4FByJT0sg03bnSavW6y0wyH4MTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=166 spamscore=2 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190070

This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
This is based on previously sent driver series[1].
[1]
https://lore.kernel.org/linux-arm-msm/20240319090729.14674-1-quic_kbajaj@quicinc.com/

------
Changes in v2:
* Changes qmpphy node name
* Changes dr_mode to otg and added USB-B port USB role switch
* Dropped maximum-speed property from usb dwc3 node
* Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/

Komal Bajaj (3):
  arm64: dts: qcom: qdu1000: Add USB3 and PHY support
  arm64: dts: qcom: qdu1000-idp: enable USB nodes
  arm64: dts: qcom: qru1000-idp: enable USB nodes

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  65 +++++++++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 133 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  65 +++++++++++
 3 files changed, 263 insertions(+)

--
2.42.0


