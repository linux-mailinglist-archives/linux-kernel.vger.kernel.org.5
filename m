Return-Path: <linux-kernel+bounces-30996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78768832741
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CE11F2349B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E333C480;
	Fri, 19 Jan 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kq6V68qc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB683C6AB;
	Fri, 19 Jan 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658825; cv=none; b=NOlfBK/lPdskGF6gJHPuEKDz/lDKgRB0uELLZhrYGHadk5JYZchnNbmjRxtCSrFowydYj0f4UegMR/AVgh8d1OUolWquobYZAFTxV+R4SKFg9lK6z3Oa/h6RR6o6Si6j++YEnxPL53J5Tb/zJp02YX7aZqxwXyaZpwKf9iCfnxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658825; c=relaxed/simple;
	bh=/43LwgpmprSml10ONprIg7sevOYvy3ONQRZX5INwvhw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lndtVlIbIRtT7srpGGqcV4hMu5yMtQ1dGRLBMka4MbuFlNKWN/TAPPqxPa4+juAdj/Fl9HN7n9U0W0BfO9XETOI2S3CgwSLaa6ov8s6N2CAECzBW1AQGp+xc+EK6h2rTxq9uFsmJdA4GlyEnRq7iSrKj3fep2pVxbYxryivXd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kq6V68qc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J9h6LW005978;
	Fri, 19 Jan 2024 10:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=q3cWGFv9lfKijN5Q62bHG6Rdqwy7w4W1M38ezavcvmw=; b=kq
	6V68qcg2iCIt/ytRdAWNskzZqFnrdbTQmg9bv1rLOgdgGeIQQMwGEyeb+ZbJFIT4
	R7dix6dbFVIXKHF4Hf3BtU+Hx87ap7myQcDVJz5b/1BYjZIjKLQg8ouHy7SPTYAg
	j5FN3J4YFuJOGZxVYsoyY7YWSElmdWjLK25wt2C8WoFy138nYeqqAryF6YKh+gsN
	vgwQnvSKVdivOjMtuDYg2VVj8rh7FJBuwn+R2/+ypimab9g3EDwUvttpMA/gl0Yq
	SAG8ZlKIm021w1CJENFtMqFADWtwXOoxTVdAJjECnfn2wiz/nTUXDGzX23MtJUtM
	MiE6DAOh4tK1StH5ukbw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqpp401et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:06:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JA6xcu006393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:06:59 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 02:06:53 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v4 0/6] arm64: qcom: add AIM300 AIoT board support
Date: Fri, 19 Jan 2024 18:06:15 +0800
Message-ID: <20240119100621.11788-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9hlyu-tLwjvgS_Agq33Sk5FOVNuOQYPm
X-Proofpoint-ORIG-GUID: 9hlyu-tLwjvgS_Agq33Sk5FOVNuOQYPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=888 clxscore=1011
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190044

Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
sound card and PMIC functions.
AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. The module is mounted onto Qualcomm AIoT
carrier board to support verification, evaluation and development. It
integrates QCS8550 SoC, UFS and PMIC chip etc.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v3 -> v4:
  - use qcm8550.dtsi instead of qcs8550.dtsi, qcs8550 is a QCS version
    of qcm8550, another board with qcm8550 will be added later
  - add AIM300 AIoT board string in qcom.yaml file
  - add sm8550 and qcm8550 fallback compatible
  - add qcm8550 SoC id
  - add reserved memory map codes in qcm8550.dtsi
  - pm8010 and pmr73d are splited into carrier board DTS file. Because
    the regulators which in pm8550, pm8550ve and pm8550vs are present
    on the SoM. The regulators which in pm8010 and pmr73d are present
    on the carrier board.
  - stay VPH_PWR at qcs8550-aim300.dtsi file
               +----------------------------------------+
               |AIM300 SoM                              |
               |                                        |
               |                           +-----+      |
               |                      |--->| UFS |      |
               |                      |    +-----+      |
               |                      |                 |
               |                      |                 |
          3.7v |  +-----------------+ |    +---------+  |
       ---------->|       PMIC      |----->| QCS8550 |  |
               |  +-----------------+      +---------+  |
               |                      |                 |
               |                      |                 |
               |                      |    +-----+      |
               |                      |--->| ... |      |
               |                           +-----+      |
               |                                        |
               +----------------------------------------+
      VPH_PWR is obtained by vonverting 12v voltage into 3.7 voltage
      with a 3.7v buck. VPH_PWR is power supply for regulators in AIM300
      SOM. VPH_PWR regulator is defined in AIM300 SOM dtsi file.

v2 -> v3:
  - introduce qcs8550.dtsi
  - separate fix dtc W=1 warning patch to another patch series

v1 -> v2:
  - merge the splited dts patches into one patch
  - update dts file name from qcom8550-aim300.dts to qcs8550-aim300 dts
  - drop PCIe1 dts node due to it is not enabled
  - update display node name for drop sde characters

previous discussion here:
[1] v3: https://lore.kernel.org/linux-arm-msm/20231219005007.11644-1-quic_tengfan@quicinc.com
[2] v2: https://lore.kernel.org/linux-arm-msm/20231207092801.7506-1-quic_tengfan@quicinc.com
[3] v1: https://lore.kernel.org/linux-arm-msm/20231117101817.4401-1-quic_tengfan@quicinc.com

Tengfei Fan (6):
  dt-bindings: arm: qcom: Document QCM8550, QCS8550 SoC and board
  dt-bindings: arm: qcom,ids: add SoC ID for QCM8550 and QCS8550
  soc: qcom: socinfo: add SoC Info support for QCM8550 and QCS8550
    platform
  arm64: dts: qcom: qcm8550: introduce qcm8550 dtsi
  arm64: dts: qcom: add base AIM300 dtsi
  arm64: dts: qcom: aim300: add AIM300 AIoT

 .../devicetree/bindings/arm/qcom.yaml         |  11 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/qcm8550.dtsi         | 170 +++++
 .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 600 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi  | 368 +++++++++++
 drivers/soc/qcom/socinfo.c                    |   2 +
 include/dt-bindings/arm/qcom,ids.h            |   2 +
 7 files changed, 1154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcm8550.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi


base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
-- 
2.17.1


