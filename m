Return-Path: <linux-kernel+bounces-109647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605A881BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986EB1C215FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE402BB1E;
	Thu, 21 Mar 2024 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V3135EqZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AA6FB9;
	Thu, 21 Mar 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995558; cv=none; b=OsIScjcng2HQb/0ARGKqht2bGdPpS2iUHAa6As22oQ26z/aYVpAaLXZcTk2VQPb4hBu2XL20Rk8dahP2yGjIkHT/ZFB48YIBoxDwYwER2kbKgPwk6m/8NRJh2DhnshLEFfpbLX6IZBD+2rrLm2Zd0/ec8sYI8TRWguurowQTKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995558; c=relaxed/simple;
	bh=Og0wY5UlzS70CHhhOINPsqOxTR2TotlCmUAEXCZNn90=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nDVamSFbqeGbK4+EwRpEp40GtWWV1rKZ9/RRB86dxUaBt1u6tL999iD7kCpq/y2yAkQr02/yNbFFtYcmIHiAXfkxLl3xt2+kvyiy1Pv5Urlls1GS9suFNBR5l0/tRJOftcX++crXNNYHLj7e1raPKqyWKSEbzmW45RRZgdU3eWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V3135EqZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L2Ve1o024624;
	Thu, 21 Mar 2024 04:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Aq6opX9
	ZfKnMeslz2hJCg1tfG66b+q7ZXbIy3T/bUBg=; b=V3135EqZniO51MR/ZKUBCzM
	PaORUt1vsQY2s53dSPCX6EDWT2Cd0hB4PZh4vzrFOKIufQeL/gkmbP9EBywaMi1T
	4u6gxQHIhR94Oki2rDvibSbEyeMWo1pkIt9T6DL5HWEIFicAYz+osKWaUbTccswn
	8L2nHaG/tURbxS5odl9X08WaQy/lm64P0gXxSgHPlPNuGyqnOL0kK2eHJdZkCOH5
	Hrl6wGwsEHuX4d21McVb2w30JS5EduPGadQu02ef545yQPHIrtpOMFba6+lfzVet
	cAThU74owNgcE7dyAnkO97jYlkZSkh8CQ2G9ibSnvl7zqo08FX2oofBi55A3hgg=
	=
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0c67g66y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 04:32:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L4WU1p028817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 04:32:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 21:32:25 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 0/2] Add interconnect driver for IPQ9574 SoC
Date: Thu, 21 Mar 2024 10:01:47 +0530
Message-ID: <20240321043149.2739204-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pfZfUli-0J_ceVpu3I7RDYAqHcSg7x_d
X-Proofpoint-ORIG-GUID: pfZfUli-0J_ceVpu3I7RDYAqHcSg7x_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210028

MSM platforms manage NoC related clocks and scaling from RPM.
However, in IPQ SoCs, RPM is not involved in managing NoC
related clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for the accessing the peripherals present in the
system. Hence add a minimalistic interconnect driver that
establishes a path from the processor/memory to those peripherals
and vice versa.

Varadarajan Narayanan (2):
  dt-bindings: interconnect: Add Qualcomm IPQ9574 support
  clk: qcom: add IPQ9574 interconnect clocks support

 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
 drivers/clk/qcom/gcc-ipq9574.c                | 75 ++++++++++++++++++-
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

-- 
2.34.1


