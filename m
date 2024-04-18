Return-Path: <linux-kernel+bounces-149803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5AF8A9604
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2BC1C20C25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CA15F321;
	Thu, 18 Apr 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NiL2VV3a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A815EFCD;
	Thu, 18 Apr 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432223; cv=none; b=qj1/k8b6PVuiGGojAj+C+i29icOJ6AFgIoFQi/YyPWPAPT2drF4aw6fCUQ5m86sRgRpgT2K/bsaLsvrbinw+1BbcY1sBCWFKP6xtm2ykO9PcBIewc1ADsXZgwpA5XPo2QDtElTeTHA8erwQmRqbYXghcunmLrs5n5kgJQvxfMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432223; c=relaxed/simple;
	bh=Fac+43+ZkiTIwPw+5Eung8Nlq978sDrkCo5KeRfxUBI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pk4XNlc8MV03FCQwPUmYFZCyx7J7Shmm+REXbEoBTQs/erZPv+ObbeBZiOHiUjsn3RW3LPbrm7xhpS+46K/oLpDmyqv1x3m1Yf5OhOQfKMJ6MlIVHXZAfL7IQACRX7MZVOGWS8SBxnY1VRCPwDk9kNm3cMjFoClkcpL/IoSy0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NiL2VV3a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I3kDao020377;
	Thu, 18 Apr 2024 09:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=SilJgGv
	0S/cTHjIt82kNZFIHhQaYicUU3VKMfUPu6X4=; b=NiL2VV3aw73r8jbLdtG3VcI
	ryYNZSLQ6Dk0eltAVeISrdZUCQvWR6tp/tuF2WxjQOaZ2OWK6/q++yZNzFkOjtMP
	TV+fdfHDoSpWgZqC1jrSZN/KgSQsZ+dLh51TMmqCBEpKypNq5QmMqTZPcPJaQwCW
	CwNSJs4Abs0E1CYYC3mdzNscR/kyo/qjYWtRK0ryiZJpgG7aS0/5R4QrNuScF4IA
	USj1RqwHvE8OTDaXops29OyvYbAuF5j1SSsF1+01U+cmrk+mqKVn7k6EpPEBNNKo
	MIJ82vJxgEPWJk9DnTiIXbxyycxLV/tMgXUFdb25NqhtMNkFQs+4HBT3Eu4eR5A=
	=
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xju74rs8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 09:23:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I9NYBw024740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 09:23:34 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 02:23:29 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v9 0/6] Add interconnect driver for IPQ9574 SoC
Date: Thu, 18 Apr 2024 14:52:59 +0530
Message-ID: <20240418092305.2337429-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: aenDTy-QT9pWuzS8t7P8dq6frnwxg5Nv
X-Proofpoint-ORIG-GUID: aenDTy-QT9pWuzS8t7P8dq6frnwxg5Nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_08,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=970
 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180065

MSM platforms manage NoC related clocks and scaling from RPM.
However, in IPQ SoCs, RPM is not involved in managing NoC
related clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for the accessing the peripherals present in the
system. Hence add a minimalistic interconnect driver that
establishes a path from the processor/memory to those peripherals
and vice versa.

---
v9:	Squash icc-clk driver change and cbf-msm8996 change
	Remove HWS_DATA macro
v8:	Change icc-clk driver to take master and slave ids instead
	of auto generating
	Remove ICC_xxx defines from dt-bindings header
	Define MASTER/SLAVE_xxx macros from 0 .. n

v7:	Fix macro names in dt-bindings header
	Do clock get in icc driver

v6:	Removed 'Reviewed-by: Krzysztof' from dt-bindings patch
	Remove clock get from ICC driver as suggested by Stephen Boyd
	so that the actual peripheral can do the clock get
	first_id -> icc_first_node_id
	Remove tristate from INTERCONNECT_CLK
v5:
	Split gcc-ipq9574.c and common.c changes into separate patches
	Introduce devm_icc_clk_register
	Fix error handling
v4:
gcc-ipq9574.c
	Use clk_hw instead of indices
common.c
	Do icc register in qcom_cc_probe() call stream
common.h
	Add icc clock info to qcom_cc_desc structure

v3:
qcom,ipq9574.h
	Move 'first id' define to clock driver
gcc-ipq9574.c:
	Use indexed identifiers here to avoid confusion
	Fix error messages and move code to common.c as it can be
	shared with future SoCs

v2:
qcom,ipq9574.h
	Fix license identifier
	Rename macros
qcom,ipq9574-gcc.yaml
	Include interconnect-cells
gcc-ipq9574.c
	Update commit log
	Remove IS_ENABLED(CONFIG_INTERCONNECT) and auto select it from Kconfig
ipq9574.dtsi
	Moved to separate patch
	Include interconnect-cells to clock controller node
drivers/clk/qcom/Kconfig:
	Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK

Varadarajan Narayanan (6):
  interconnect: icc-clk: Allow user to specify master/slave ids
  dt-bindings: interconnect: Add Qualcomm IPQ9574 support
  interconnect: icc-clk: Add devm_icc_clk_register
  clk: qcom: common: Add interconnect clocks support
  clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq9574: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  2 +
 drivers/clk/qcom/Kconfig                      |  2 +
 drivers/clk/qcom/clk-cbf-8996.c               |  7 ++-
 drivers/clk/qcom/common.c                     | 35 ++++++++++-
 drivers/clk/qcom/common.h                     |  9 +++
 drivers/clk/qcom/gcc-ipq9574.c                | 31 ++++++++++
 drivers/interconnect/icc-clk.c                | 24 +++++++-
 .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
 include/linux/interconnect-clk.h              |  4 ++
 10 files changed, 171 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h

-- 
2.34.1


