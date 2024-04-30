Return-Path: <linux-kernel+bounces-164146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A478B79D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFAC2889F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1D143747;
	Tue, 30 Apr 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KBZjaFKF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83714373E;
	Tue, 30 Apr 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487426; cv=none; b=EZrDeHGNU0ug2ElsitU6VHC7dBNBj+vVBp1lvXj1V90dFSyhk/blFH7OMCO9qddqxhFVg8zTSN0O+2VKfEO/c/nHDOqHLWb2aJNZVn0yY7/96FC4A+7PQi8H9VZ6PuCKQeq7/F5DJJ9x6WeCQa++rnGv1MeHbfIm47o/HIzINS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487426; c=relaxed/simple;
	bh=Sk3EMIVGnDX+IXhJwDnotDadG2kubVXVlJSnVukq+r0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dQsQ25k4+sLXhrGCZQIazMAafIhlgBdsADWOJFuQgcIcuQ/TwnZaPNW+IFedjJ0tIcvGZ505rItoaux0hWtFRo20vbc8pN+913NSVQgvNFlhB4/n+hSxneLbdo5UPB101IuXbKq7/WQ+/7O+a7sJ2NR627JAhjoCCRlddubA9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KBZjaFKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UD9gaF014746;
	Tue, 30 Apr 2024 14:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=eiScpcg
	hYJXZwIUI+wNiwCUPnWtB95AeIvA6e+mjE0Y=; b=KBZjaFKFI80ZSrJj6xeD0mK
	NmjihOOstg/yI6N7XvncoSnLvalYy9xpUPNrzlfbOxU687cZFwf5CKhlr/oIXY1e
	OuX6TN7OX1QSrmbE0n8XTich/K0EDTA2axsrXAf9pWzz16AUcj1ZrjYNmhdNyqM2
	bvnUIvX76xdiYxo2hAWxxU0oi4EKvjKSl37uKWtfcD7+co/itYCRBrRcUz5GwCDi
	DklZ8pIktjD5OdrbhES7jMgN+0pFvr9CQBfZanPRQnFyYJHMarGC3+PRkef7bHTn
	2hGcXMOCYQqycD7gbQlosi+2bWWxaTthxCyDcMOFyQZOiiv+cmyVNx6Rb8dM6kA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu199063n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUH33021137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:17 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:11 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH V3 0/8] Add support for videocc and camcc on SM8650
Date: Tue, 30 Apr 2024 19:57:49 +0530
Message-ID: <20240430142757.16872-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sQ-8O9UDvntGhcYPZEjeo3pDapc9qItW
X-Proofpoint-GUID: sQ-8O9UDvntGhcYPZEjeo3pDapc9qItW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300102

Add support for video and camera clock controllers on Qualcomm SM8650
platform.

Changes in V3:
[PATCH 1/8]: Split incorrect header file name in SM8450 videocc bindings
             into a separate patch and added fixes tag
[PATCH 2/8]: Added new header file for SM8650 videocc to define the extra clocks
             and resets on top of SM8450 videocc bindings, Dropped Krzysztof
             R-By tag due to these changes
[PATCH 3/8]: Updated SM8550 videocc driver to use new SM8650 videocc header file,
             added Dmitry and Konrad R-By tags
[PATCH 4/8]: Updated offset variable name to sleep_clk_offset in probe and added
             Dmitry R-By tag
[PATCH 5/8]: This patch is newly added to fix the incorrect order for SC8280XP
             camcc header file in bindings
[PATCH 6/8]: Fixed the incorrect alphabetical order for SM8650 camcc compatible
             and header files, added Krzysztof R-By tag and Vladimir Acked-By tags
[PATCH 7/8]: No changes, added R-By tags received till V2 series
[PATCH 8/8]: Dropped required-opps property in videocc and camcc nodes and
             updated DT file to use new SM8650 videocc header file, added Vladimir R-By tag

Previous series:
V2 RESEND: https://lore.kernel.org/all/20240321092529.13362-1-quic_jkona@quicinc.com/
V2: https://lore.kernel.org/all/20240220135121.22578-1-quic_jkona@quicinc.com/
V1: https://lore.kernel.org/linux-kernel/20240206113145.31096-1-quic_jkona@quicinc.com/T/

Jagadeesh Kona (8):
  dt-bindings: clock: qcom: Fix SM8450 videocc incorrect header file
    name
  dt-bindings: clock: qcom: Add SM8650 video clock controller
  clk: qcom: videocc-sm8550: Add support for videocc XO clk ares
  clk: qcom: videocc-sm8550: Add SM8650 video clock controller
  dt-bindings: clock: qcom: Fix the incorrect order of SC8280XP camcc
    header
  dt-bindings: clock: qcom: Add SM8650 camera clock controller
  clk: qcom: camcc-sm8650: Add SM8650 camera clock controller driver
  arm64: dts: qcom: sm8650: Add video and camera clock controllers

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    5 +-
 .../bindings/clock/qcom,sm8450-videocc.yaml   |    6 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   26 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8650.c               | 3591 +++++++++++++++++
 drivers/clk/qcom/videocc-sm8550.c             |  156 +-
 include/dt-bindings/clock/qcom,sm8650-camcc.h |  195 +
 .../dt-bindings/clock/qcom,sm8650-videocc.h   |   23 +
 9 files changed, 4004 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8650.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-videocc.h

-- 
2.43.0


