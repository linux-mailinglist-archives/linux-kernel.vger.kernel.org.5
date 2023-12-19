Return-Path: <linux-kernel+bounces-5309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B90818941
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C005C287073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E51C2BB;
	Tue, 19 Dec 2023 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lelK8O7U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF81C293;
	Tue, 19 Dec 2023 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJDDIeX021811;
	Tue, 19 Dec 2023 14:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=BU3uM8A
	63IB1WPc96Czhh7dV7ttEGA8DGJWsLmK/nok=; b=lelK8O7U8QjLC5gIGLcrfR/
	I61jEvWoOPVETj9ZzSlSbzFjYi//UY0vWvu+e1QILWBnlavlfZM8AMZ3kVMcvQdC
	10PtSrE5D8wbskew6z+aPpSMXBlqXcE67xfvTSAknR1K5mRm+YZxK2+ncIWdBsUK
	3edF3WsaLnfCOKRW4+yV8HqZk+0Brf+26ZBk3QNyYGteZ4zxhRBsCburadCtaAea
	VLyjhSVr+34H/wwxgTL5QFT9J15OJxqfgqtONBJh0NSh0QvYTm79euFT3STIeLH3
	xN7lq3PuT1rVELl0N0ngFmvP6CxWpGgYHk64sd4dATgYmcEyhwbXd5FbKwGDHpQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35tm941p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:02:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJE2kSc013865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:02:46 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 06:02:43 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v13 0/4] add clock controller of qca8386/qca8084
Date: Tue, 19 Dec 2023 22:02:25 +0800
Message-ID: <20231219140229.19062-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ADfaI1dlGXf-e_aHMrCcWJTXVAKDpEQr
X-Proofpoint-ORIG-GUID: ADfaI1dlGXf-e_aHMrCcWJTXVAKDpEQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190105

qca8xxx is 4 * 2.5GBaseT ports chip, working as switch mode
named by qca8386, or working as PHY mode named by qca8084,
clock hardware reigster is accessed by MDIO bus.

This patch series add the clock controller of qca8363/qca8084,
and add the clock ops clk_branch2_prepare_ops to avoid spin lock
used during the clock operation of qca8k clock controller where
the sleep happens when accessing clock control register by MDIO
bus.

qca8xxx clock controller driver depends on the patch set below for the
freq_multi_tbl used for the same frequency reached by multiple configs.
https://lore.kernel.org/lkml/20231124151847.1915-3-ansuelsmth@gmail.com/

Changes in v2:
	* remove clock flag CLK_ENABLE_MUTEX_LOCK.
	* add clock ops clk_branch2_qca8k_ops.
	* improve yaml file for fixing dtschema warnings.
	* enable clock controller driver in defconfig.

Changes in v3:
	* rename clk_branch2_qca8k_ops to clk_branch2_mdio_ops.
	* fix review comments on yaml file.
	* use dev_err_probe on driver probe error.
	* only use the compatible "qcom,qca8084-nsscc".
	* remove enable clock controller driver patch.

Changes in v4:
	* add _qcom_cc_really_probe function.
	* commonizing the probe function.
	* remove flag CLK_IS_CRITICAL from clocks only needed
	to be enabled in switch device.
	* update device tree property reg to 0x10. 

Changes in v5:
	* commonize qcom_cc_really_probe.
	* add halt_check for the branch clocks.
	* fix the review comments on nsscc-qca8k.c. 

Changes in v6:
	* rename clk_branch2_mdio_ops to clk_branch2_prepare_ops.

Changes in v7:
	* remove the clock flag CLK_IS_CRITICAL.
	* optimize the file nsscc-qca8k.c.
	* identify & fix the comments from Stephen.

Changes in v8:
	* add dependency on ARM in Kconfig.

Changes in v9:
	* take the clk_ops clk_rcg2_mux_closest_ops to remove the
	  redundant freq_tbls.

Changes in v10:
        * fix the patch CHECK and improve the comments.

Changes in v11:
	* update the clock names to reflect hardware connecton.
	  NSS_CC_MAC4_SRDS1_CH2_XGMII_RX_DIV_CLK_SRC ->
	  NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_DIV_CLK_SRC

	  NSS_CC_MAC4_SRDS1_CH2_XGMII_TX_DIV_CLK_SRC ->
	  NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_DIV_CLK_SRC
        * resolve the qcom_cc_really_probe merge conflict based
	  on the latest code.

Changes in v12:
	* fix the compile error caused by the parameter of
	  qcom_cc_really_probe updated from pdev to &pdev->dev in the
	  new merged clock driver gcc-sm4450.c and camcc-sm8550.c.

Changes in v13:
	* fix the compile error caused by the parameter of
	  qcom_cc_really_probe from pdev to &pdev->dev in the new
	  merged gcc drivers.
	* use the freq_multi_tbl for the same frequency config, which
	  is introduced by Christian's patch set below.
	  <clk: qcom: clk-rcg2: introduce support for multiple conf
	  for same freq>.
	* add dependent patch set link.

Luo Jie (4):
  clk: qcom: branch: Add clk_branch2_prepare_ops
  dt-bindings: clock: add qca8386/qca8084 clock and reset definitions
  clk: qcom: common: commonize qcom_cc_really_probe
  clk: qcom: add clock controller driver for qca8386/qca8084

 .../bindings/clock/qcom,qca8k-nsscc.yaml      |   79 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/apss-ipq6018.c               |    2 +-
 drivers/clk/qcom/camcc-sc7180.c               |    2 +-
 drivers/clk/qcom/camcc-sc7280.c               |    2 +-
 drivers/clk/qcom/camcc-sc8280xp.c             |    2 +-
 drivers/clk/qcom/camcc-sdm845.c               |    2 +-
 drivers/clk/qcom/camcc-sm6350.c               |    2 +-
 drivers/clk/qcom/camcc-sm8250.c               |    2 +-
 drivers/clk/qcom/camcc-sm8450.c               |    2 +-
 drivers/clk/qcom/camcc-sm8550.c               |    2 +-
 drivers/clk/qcom/clk-branch.c                 |    7 +
 drivers/clk/qcom/clk-branch.h                 |    1 +
 drivers/clk/qcom/common.c                     |    7 +-
 drivers/clk/qcom/common.h                     |    2 +-
 drivers/clk/qcom/dispcc-qcm2290.c             |    2 +-
 drivers/clk/qcom/dispcc-sc7180.c              |    2 +-
 drivers/clk/qcom/dispcc-sc7280.c              |    2 +-
 drivers/clk/qcom/dispcc-sc8280xp.c            |    2 +-
 drivers/clk/qcom/dispcc-sdm845.c              |    2 +-
 drivers/clk/qcom/dispcc-sm6115.c              |    2 +-
 drivers/clk/qcom/dispcc-sm6125.c              |    2 +-
 drivers/clk/qcom/dispcc-sm6350.c              |    2 +-
 drivers/clk/qcom/dispcc-sm6375.c              |    2 +-
 drivers/clk/qcom/dispcc-sm8250.c              |    2 +-
 drivers/clk/qcom/dispcc-sm8450.c              |    2 +-
 drivers/clk/qcom/dispcc-sm8550.c              |    2 +-
 drivers/clk/qcom/dispcc-sm8650.c              |    2 +-
 drivers/clk/qcom/ecpricc-qdu1000.c            |    2 +-
 drivers/clk/qcom/gcc-ipq5018.c                |    2 +-
 drivers/clk/qcom/gcc-ipq6018.c                |    2 +-
 drivers/clk/qcom/gcc-ipq8074.c                |    2 +-
 drivers/clk/qcom/gcc-mdm9607.c                |    2 +-
 drivers/clk/qcom/gcc-mdm9615.c                |    2 +-
 drivers/clk/qcom/gcc-msm8917.c                |    2 +-
 drivers/clk/qcom/gcc-msm8939.c                |    2 +-
 drivers/clk/qcom/gcc-msm8953.c                |    2 +-
 drivers/clk/qcom/gcc-msm8976.c                |    2 +-
 drivers/clk/qcom/gcc-msm8996.c                |    2 +-
 drivers/clk/qcom/gcc-msm8998.c                |    2 +-
 drivers/clk/qcom/gcc-qcm2290.c                |    2 +-
 drivers/clk/qcom/gcc-qcs404.c                 |    2 +-
 drivers/clk/qcom/gcc-qdu1000.c                |    2 +-
 drivers/clk/qcom/gcc-sa8775p.c                |    2 +-
 drivers/clk/qcom/gcc-sc7180.c                 |    2 +-
 drivers/clk/qcom/gcc-sc7280.c                 |    2 +-
 drivers/clk/qcom/gcc-sc8180x.c                |    2 +-
 drivers/clk/qcom/gcc-sc8280xp.c               |    2 +-
 drivers/clk/qcom/gcc-sdm660.c                 |    2 +-
 drivers/clk/qcom/gcc-sdm845.c                 |    2 +-
 drivers/clk/qcom/gcc-sdx55.c                  |    2 +-
 drivers/clk/qcom/gcc-sdx65.c                  |    2 +-
 drivers/clk/qcom/gcc-sdx75.c                  |    2 +-
 drivers/clk/qcom/gcc-sm4450.c                 |    2 +-
 drivers/clk/qcom/gcc-sm6115.c                 |    2 +-
 drivers/clk/qcom/gcc-sm6125.c                 |    2 +-
 drivers/clk/qcom/gcc-sm6350.c                 |    2 +-
 drivers/clk/qcom/gcc-sm6375.c                 |    2 +-
 drivers/clk/qcom/gcc-sm7150.c                 |    2 +-
 drivers/clk/qcom/gcc-sm8150.c                 |    2 +-
 drivers/clk/qcom/gcc-sm8250.c                 |    2 +-
 drivers/clk/qcom/gcc-sm8350.c                 |    2 +-
 drivers/clk/qcom/gcc-sm8450.c                 |    2 +-
 drivers/clk/qcom/gcc-sm8550.c                 |    2 +-
 drivers/clk/qcom/gcc-sm8650.c                 |    2 +-
 drivers/clk/qcom/gcc-x1e80100.c               |    2 +-
 drivers/clk/qcom/gpucc-msm8998.c              |    2 +-
 drivers/clk/qcom/gpucc-sa8775p.c              |    2 +-
 drivers/clk/qcom/gpucc-sc7180.c               |    2 +-
 drivers/clk/qcom/gpucc-sc7280.c               |    2 +-
 drivers/clk/qcom/gpucc-sc8280xp.c             |    2 +-
 drivers/clk/qcom/gpucc-sdm660.c               |    2 +-
 drivers/clk/qcom/gpucc-sdm845.c               |    2 +-
 drivers/clk/qcom/gpucc-sm6115.c               |    2 +-
 drivers/clk/qcom/gpucc-sm6125.c               |    2 +-
 drivers/clk/qcom/gpucc-sm6350.c               |    2 +-
 drivers/clk/qcom/gpucc-sm6375.c               |    2 +-
 drivers/clk/qcom/gpucc-sm8150.c               |    2 +-
 drivers/clk/qcom/gpucc-sm8250.c               |    2 +-
 drivers/clk/qcom/gpucc-sm8350.c               |    2 +-
 drivers/clk/qcom/gpucc-sm8450.c               |    2 +-
 drivers/clk/qcom/gpucc-sm8550.c               |    2 +-
 drivers/clk/qcom/gpucc-sm8650.c               |    2 +-
 drivers/clk/qcom/lcc-ipq806x.c                |    2 +-
 drivers/clk/qcom/lcc-msm8960.c                |    2 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c        |    4 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c         |    2 +-
 drivers/clk/qcom/lpasscorecc-sc7280.c         |    2 +-
 drivers/clk/qcom/mmcc-msm8960.c               |    2 +-
 drivers/clk/qcom/mmcc-msm8974.c               |    2 +-
 drivers/clk/qcom/mmcc-msm8994.c               |    2 +-
 drivers/clk/qcom/mmcc-msm8996.c               |    2 +-
 drivers/clk/qcom/mmcc-msm8998.c               |    2 +-
 drivers/clk/qcom/mmcc-sdm660.c                |    2 +-
 drivers/clk/qcom/nsscc-qca8k.c                | 2189 +++++++++++++++++
 drivers/clk/qcom/tcsrcc-sm8550.c              |    2 +-
 drivers/clk/qcom/videocc-sc7180.c             |    2 +-
 drivers/clk/qcom/videocc-sc7280.c             |    2 +-
 drivers/clk/qcom/videocc-sdm845.c             |    2 +-
 drivers/clk/qcom/videocc-sm8150.c             |    2 +-
 drivers/clk/qcom/videocc-sm8250.c             |    2 +-
 drivers/clk/qcom/videocc-sm8350.c             |    2 +-
 drivers/clk/qcom/videocc-sm8450.c             |    2 +-
 drivers/clk/qcom/videocc-sm8550.c             |    2 +-
 include/dt-bindings/clock/qcom,qca8k-nsscc.h  |  101 +
 include/dt-bindings/reset/qcom,qca8k-nsscc.h  |   75 +
 107 files changed, 2564 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
 create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
 create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
 create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h


base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
-- 
2.42.0


