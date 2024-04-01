Return-Path: <linux-kernel+bounces-126561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3389397A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FCC28229C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAE11CB0;
	Mon,  1 Apr 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QkU7b6/q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542B10799;
	Mon,  1 Apr 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964361; cv=none; b=MUjdOM6UY+aoqB2cE1yDguoJvYglL3sJP0SX10sdE2pw2JQCGJg4MmBznSmWC8p25hQKKWYbJmGJSKpIfn80/+gOvcNxXOZDNc/KInSTnLT2LvP1rP8hFRPGQz7LMU9fRumpbOLtiUsjBQYfApO+hEbpMHMy/D6rCHBoLpMz0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964361; c=relaxed/simple;
	bh=GDkJaI2NiV2yD5bGEtjzSyb61VjKRzyf5ADCDUWbmSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UyMe/WuvrLpW7vyoihEt4Lj1sGhKhCWN62lKs61YDsV2Ji+IjFyZP0mQndAILhkYWbiQJiKoN3LRSsLQtCFUU/vbGRd+7tNW+KWnQ+FJLOIDYWloGGWFzCx7XaxgL3lcK4iGi97Kh1lHbkstd1d7qBDXQut7YVYf+Vxh+2I5350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QkU7b6/q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4316NYdc007999;
	Mon, 1 Apr 2024 09:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=9BsDXd1
	MG4iwSsj0EEVJv6vlxpdFNHE3d7mp0aKDrK8=; b=QkU7b6/qGcOz8iVogrscTts
	nnyMZM/LtZTizyiMrix+Eue9UNAiR4feAvsDfHelI3OwJ4E/rrkdecrJCdlywvri
	Xi8/J/kU9m72cQs8sS2Fu2mBluto87nhOgu6lcd04hV9m1w51tGsMLorOWp25SKd
	kr001PK6x67ieabzqKFnbJmjOafMufnH0bU/xroM6M4b5RWXQZkiKpxk+TgGDBQW
	fileg4SjrMhQWamsivZ5qnJaiCMNnCSTltHdd7YWqa4NwVTVdFn/fI/Fph5BAoKA
	PTX854198YWhxgCvXX6nbe6VSAZrYCxwRd1e3h6IN0u37dh818W3AgbENDQ4/Vg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7maggpgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 09:39:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4319d45J001896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 09:39:04 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 02:38:57 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v6 RESEND 0/4] arm64: qcom: add AIM300 AIoT board support
Date: Mon, 1 Apr 2024 17:38:39 +0800
Message-ID: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: 1PabHd1YX6K_e6_H84-mPeo4_NfVZ9oa
X-Proofpoint-ORIG-GUID: 1PabHd1YX6K_e6_H84-mPeo4_NfVZ9oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010068

Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
and PMIC functions.
AIM300 Series is a highly optimized family of modules designed to
support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
chip etc.
Here is a diagram of AIM300 AIoT Carrie Board and SoM
 +--------------------------------------------------+
 |             AIM300 AIOT Carrie Board             |
 |                                                  |
 |           +-----------------+                    |
 |power----->| Fixed regulator |---------+          |
 |           +-----------------+         |          |
 |                                       |          |
 |                                       v VPH_PWR  |
 | +----------------------------------------------+ |
 | |                          AIM300 SOM |        | |
 | |                                     |VPH_PWR | |
 | |                                     v        | |
 | |   +-------+       +--------+     +------+    | |
 | |   | UFS   |       | QCS8550|     |PMIC  |    | |
 | |   +-------+       +--------+     +------+    | |
 | |                                              | |
 | +----------------------------------------------+ |
 |                                                  |
 |                    +----+          +------+      |
 |                    |USB |          | UART |      |
 |                    +----+          +------+      |
 +--------------------------------------------------+
The following functions have been verified:
  - uart
  - usb
  - ufs
  - PCIe
  - PMIC
  - display
  - adsp
  - cdsp
  - tlmm

Documentation for qcs8550[1] and sm8550[2]
[1] https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf
[2] https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v5 -> v6:
  - move qcs8550 board info bebind sm8550 boards info in qcom.yaml

v4 -> v5:
  - "2023-2024" instead of "2023~2024" for License
  - update patch commit message to previous comments and with an updated
    board diagram
  - use qcs8550.dtsi instead of qcm8550.dtsi
  - remove the reserved memory regions which will be handled by
    bootloader
  - remove pm8550_flash, pm8550_pwm nodes, Type-C USB/DP function node,
    remoteproc_mpss function node, audio sound DTS node, new patch will
    be updated after respective team's end to end full verification
  - address comments to vph_pwr, move vph_pwr node and related
    references to qcs8550-aim300-aiot.dts
  - use "regulator-vph-pwr" instead of "vph_pwr_regulator"
  - add pcie0I AND pcie1 support together
  - the following patches were applied, so remove these patches from new
    patch series:
      - https://lore.kernel.org/linux-arm-msm/20240119100621.11788-3-quic_tengfan@quicinc.com
      - https://lore.kernel.org/linux-arm-msm/20240119100621.11788-4-quic_tengfan@quicinc.com
  - verified with dtb check, and result is expected, because those
    warnings are not introduced by current patch series.
    DTC_CHK arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb
    arch/arm64/boot/dts/qcom/sm8550.dtsi:3015.27-3070.6: Warning
    (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary
    #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: opp-75000000:opp-hz:0: [75000000, 0, 0, 75000000, 0, 0, 0, 0] is too long
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: opp-150000000:opp-hz:0: [150000000, 0, 0, 150000000, 0, 0, 0, 0] is too long
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: opp-300000000:opp-hz:0: [300000000, 0, 0, 300000000, 0, 0, 0, 0] is too long
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
    arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
    opp-table: Unevaluated properties are not allowed ('opp-150000000', 'opp-300000000', 'opp-75000000' were unexpected)
        from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#

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
[1] v5: https://lore.kernel.org/linux-arm-msm/20240301134113.14423-1-quic_tengfan@quicinc.com
[2] v4: https://lore.kernel.org/linux-arm-msm/20240119100621.11788-1-quic_tengfan@quicinc.com
[3] v3: https://lore.kernel.org/linux-arm-msm/20231219005007.11644-1-quic_tengfan@quicinc.com
[4] v2: https://lore.kernel.org/linux-arm-msm/20231207092801.7506-1-quic_tengfan@quicinc.com
[5] v1: https://lore.kernel.org/linux-arm-msm/20231117101817.4401-1-quic_tengfan@quicinc.com



Tengfei Fan (4):
  dt-bindings: arm: qcom: Document QCS8550 SoC and the AIM300 AIoT board
  arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
  arm64: dts: qcom: add base AIM300 dtsi
  arm64: dts: qcom: aim300: add AIM300 AIoT

 .../devicetree/bindings/arm/qcom.yaml         |   8 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 384 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi  | 345 ++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8550.dtsi         | 169 ++++++++
 5 files changed, 907 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi


base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
-- 
2.25.1


