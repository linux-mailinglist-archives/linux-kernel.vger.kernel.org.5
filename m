Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E27FE61C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbjK3Bgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjK3Bgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:36:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB1F10D4;
        Wed, 29 Nov 2023 17:36:49 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU18KA1003803;
        Thu, 30 Nov 2023 01:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=wBdEQakk/60SrjX7AyCoDPhJVBiEEQTy8BRow6iQdgs=;
 b=kWk/XYvQBsoyY8KirPqyeYccXglymjkK/02NAOUPpZZWC5QW5cv9rz3N5g2XMsn/CYKV
 rLKCDOtqVzsq9rAbOCrNBPCEM3/aG8Z3AQKxaTZoVnUpHPr98GoU3Cj6JRaH7yM7XvxZ
 d0Hjc8M0fC4WOoi1NtG3oYj0QJOYXd+4IjCAKnNg4PlczEzwMpek1sEbJs26maY6P6Z1
 8IMbnaDHEc74TWhfWTrUT10eBkV8cNKE4j/YE5Ew7gjCzmVLQeVwnzDdB0e/fTe0z6jw
 K8uCshJSdP/2/mrgukq2/5Ui7tUeCpGjQ/Wt6BoFxbQ81zNLmW7gpRbJFbW/y+L9bHTe Zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upgfd01pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:36:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU1abA9015657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:36:37 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 17:36:36 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v7 0/7] Add support for LUT PPG
Date:   Wed, 29 Nov 2023 17:36:08 -0800
Message-ID: <20231130013615.14287-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wtl2IfxYZ9S7gVuRCuTWLgysjQtfteV1
X-Proofpoint-GUID: Wtl2IfxYZ9S7gVuRCuTWLgysjQtfteV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311300010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
modules instead of LUT peripheral. This feature is called PPG.

This change series adds support for PPG. Thanks!
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
 drivers/leds/rgb/leds-qcom-lpg.c              | 344 ++++++++++++++++--
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 243 +++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  30 ++
 7 files changed, 726 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.41.0

