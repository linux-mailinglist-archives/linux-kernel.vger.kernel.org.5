Return-Path: <linux-kernel+bounces-77486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0331C86063D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F81F2546F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F92231C;
	Thu, 22 Feb 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n0dgbacE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57181864A;
	Thu, 22 Feb 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643298; cv=none; b=ePU7KbzYAlQQZQR971ansi3Qbcn0ZvVQ+2jSZSy9FcTQk3Yzqoa6vv8HQ7H0MmRrBdpav4xO/fAdycBCUTrIls616WYGthtiGrWpBs8icELO0RG4sA+8RoJIl4XxxUtJCWtOAuapTxaEs840B7wRxW8D5fOJCcSeKEHbiiI8pPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643298; c=relaxed/simple;
	bh=1D67/mPVlMD7ke1rp9N2k/nIv32BdFuF+09t2rgxBz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fJY5bw3WYu59xfzA0ZNEOx965SigU1z0RfUe4SziuNqWuaW7zf9AQgcmfvQWwvm9RqRaurwVueWVP9hZ3Xk21su4tEariZr/GFCA8Op/s+OcfV2sYrIHHn+LLoJ8lp9IW5ZbNabwFLJ4oya63JoD1kv8HgfPNm3VEQzXrivaV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n0dgbacE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLiPtB021602;
	Thu, 22 Feb 2024 23:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=XPoJMjX
	mGQ4kcptMPlhI6nE0j7PL7Mx3eZx7q5qBBdw=; b=n0dgbacE/5SRUUGztg4CDKL
	CM2GIETcKevippfcJSgApNECCICy0T07N4sGseOwgA+JJsEQTyl7Ij8xBL2KLp84
	hExPvPYoK8itzW3HkQaw6Vu9yGrFdbUGxF2nZEDX18qjHDk8L8N/whyQ2KMr/ZrR
	Qq/lcdFn9x0vHXPJFI/hqV+0Fr2giWnGiKuapb1XHhbKmr4UrBSjov7QoZ9fLxWQ
	n2j1BPEqHPrVrbCMdKT5L9pjHxrKW2RF0yGTqUTQSOxW7x72E0NOdDXohiCHZB3C
	xwGPjPS9eE3yPKyBhbcNoaol8jhyHwu5EHLXGLn3s7ecO29er4v1zahREmMUpbQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we2kf9pcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MN89Ff017666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:09 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:08:07 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH v3 0/5] LLCC: Support for Broadcast_AND region
Date: Thu, 22 Feb 2024 15:07:52 -0800
Message-ID: <cover.1708551850.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VDSipTSQMxikcqQczaHUmArNjg7Z_-Ax
X-Proofpoint-GUID: VDSipTSQMxikcqQczaHUmArNjg7Z_-Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=528 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220178

This series adds:
1. Device tree register mapping for Broadcast_AND region in SM8450,
SM8550, SM8650.
2. LLCC driver updates to reflect addition of Broadcast_AND regmap.

To support CSR programming, a broadcast interface is used to program all
channels in a single command. Until SM8450 there was only one broadcast
region (Broadcast_OR) used to broadcast write and check for status bit
0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
added which checks for status bit 1.

This series updates the device trees from SM8450 onwards to have a
mapping to this Broadcast_AND region. It also updates the llcc_drv_data
structure with a regmap for Broadcast_AND region and corrects the
broadcast region used to check for status bit 1.

Changes in v3:
- Removed new example in dt-bindings patch and ran 'make
DT_CHECKER_FLAGS=-m dt_binding_check'
- Use of ternary operator in llcc_update_act_ctrl()
- Add comment before initialization of Broadcast_AND regmap in probe
function
- Move DeviceTree patches to the end

Changes in v2:
- Added an additional check in the case old DT files are used for
above mentioned chipsets for backwards compatibility
- Moved addition of if check in llcc_update_act_ctrl() to a separate
"Fixes" patch; not part of this series

Link to v2: https://lore.kernel.org/all/cover.1707202761.git.quic_uchalich@quicinc.com/
Link to v1: https://lore.kernel.org/all/cover.1706296015.git.quic_uchalich@quicinc.com/

Unnathi Chalicheemala (5):
  dt-bindings: arm: msm: Add llcc Broadcast_AND register
  soc: qcom: llcc: Add regmap for Broadcast_AND region
  arm64: dts: qcom: sm8450: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8550: Add mapping to llcc Broadcast_AND region
  arm64: dts: qcom: sm8650: Add mapping to llcc Broadcast_AND region

 .../devicetree/bindings/cache/qcom,llcc.yaml  | 27 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  5 ++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  6 +++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  6 +++--
 drivers/soc/qcom/llcc-qcom.c                  | 15 ++++++++++-
 include/linux/soc/qcom/llcc-qcom.h            |  4 ++-
 6 files changed, 54 insertions(+), 9 deletions(-)

-- 
2.25.1


