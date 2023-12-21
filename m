Return-Path: <linux-kernel+bounces-8966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCF81BEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0641F25878
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E462697A6;
	Thu, 21 Dec 2023 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JjtQylcU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B565195;
	Thu, 21 Dec 2023 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6u9Im023368;
	Thu, 21 Dec 2023 18:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=hpHPtZW
	aw3gLN2+ydRk1QiUGlappUp3Wu5lFIFS1vhQ=; b=JjtQylcUf+iqihlf1CZdkRX
	TgkTCDPPEHMQ5yEs9moVTMDp9nPB6XTEcg2N8k605FRU3RKSuKDHw2+Y2SCHggd6
	L0O/ppokeDacV2h9D3GyQVsEpUg0pdhiVLC+CByvBGdbr/GJka0rpqXa7lVHsUmf
	AhPyGJVUtxWemBAxoucqmz2QUE88Bqha/W2PL8xHhOAn57DPiRGKUtl9P9BG1kU2
	xY0jRGIuYDL2OsieS7WR+lh12AUhGAcgSIP3JgKo22GA7leg7dy/XEx3qqi2Djqh
	YzXmQe8mjH0F54T+dgBWTD8VKdqXif7fE47DGlrgCQDnYTbJn7n3C0XoViiXmCA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4d89k19u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:58:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLIwuqn008603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:58:56 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 10:58:56 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v8 0/7] Add support for LUT PPG
Date: Thu, 21 Dec 2023 10:58:30 -0800
Message-ID: <20231221185838.28440-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gQ3n5OTmzJQImalnt7ef-tEsESk8A8te
X-Proofpoint-ORIG-GUID: gQ3n5OTmzJQImalnt7ef-tEsESk8A8te
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210144

In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
modules instead of LUT peripheral. This feature is called PPG.

This change series adds support for PPG. Thanks!
Changes since v7:
  - Patch 4/7
    - Initialize hi/lo_pause variables in lpg_pattern_set()
Changes since v6:
  - Patch 2/7
    - Removed required by constraint on PPG dt properties
Changes since v5:
  - Patch 4/7
    - Update logic so that multicolor led device triggers pattern
      on all LEDs at the same time
    - Update nitpicks from Lee
  - Patch 5/7
    - Update nitpicks from Lee
Changes since v4:
  - Patch 3/7
    - Get rid of r/w helpers
    - Use regmap_read_poll_timeout() in qcom_pbs_wait_for_ack()
    - Update error path in qcom_pbs_trigger_event()
    - Fix reverse christmas tree
  - Patch 4/7
    - Get rid of r/w helpers
    - Update variables to use "sdam" instead of "nvmem"
    - Fix comments
    - Fix reverse christmas tree
    - Update lpg_pattern_set() logic
  - Patch 5/7
    - Removed sdam_lut_base from lpg_data
Changes since v3:
  - Patch 4/7
    - Fix function returns
    - Move register definition to top of file
    - Revert max_brightness and probe accidental changes
    - Combine init_sdam() and parse_sdam()
    - Change error prints in probe to use dev_err_probe
    - Remove ppg_en variable
    - Update when pbs triggers are set/cleared
  - Patch 6/7
    - Remove use of nvmem_count
    - Move register definition to top of file
    - Remove lpg_get_sdam_lut_idx()
Changes since v2:
  - Patch 1/7
    - Fix dt_binding_check error
    - Rename binding file to match compatible
    - Iclude SoC specific comptaibles
  - Patch 2/7
    - Update nvmem-names list
  - Patch 3/7
    - Update EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
    - Fix return/break logic in qcom_pbs_wait_for_ack()
    - Update iterators to be int
    - Add constants
    - Fix function calls in qcom_pbs_trigger_event()
    - Remove unnessary comments
    - Return -EPROBE_DEFER from get_pbs_client_device()
Changes since v1:
  - Patch 1/7
    - Fix dt_binding_check errors
    - Update binding description
  - Path 2/7
    - Fix dt_binding_check errors
    - Update per variant constraints
    - Update nvmem description
  - Patch 3/7
    - Update get_pbs_client_device()
    - Drop use of printk
    - Remove unused function

Anjelique Melendez (7):
  dt-bindings: soc: qcom: Add qcom,pbs bindings
  dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
  soc: qcom: add QCOM PBS driver
  leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
  leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
  leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT
    SDAM
  leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme

 .../bindings/leds/leds-qcom-lpg.yaml          |  82 ++++-
 .../bindings/soc/qcom/qcom,pbs.yaml           |  46 +++
 drivers/leds/rgb/leds-qcom-lpg.c              | 348 ++++++++++++++++--
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 243 ++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  30 ++
 7 files changed, 728 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.41.0


