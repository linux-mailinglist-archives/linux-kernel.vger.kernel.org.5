Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF37B29C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjI2Ajs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI2Ajl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:39:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64206194;
        Thu, 28 Sep 2023 17:39:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T0BwOu009656;
        Fri, 29 Sep 2023 00:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6q15nGPM0tQmnNYPNotpVcBSBoi2DT5piGxQo/oZHXc=;
 b=gqmXZ3G9DzkqGp3/0B5dpg1vwqmfFud1PVslbLuqq/E2J/kR6VFKw7oU9f994RkL8r6F
 yWvmV10Rj0A2h/M7f1J3/rMHzDpdEXGd6BexqmFivi/53bWdBqZCvCJBuZraWC9QZu4K
 kmXH9Goz/X8nkYY9oUANJ2hKadtLL+d5jUzg3TaUr2yugaMgParPXU87hGHpMl+moSLF
 n4xoIgrQjbT+i9ptUMKebI2nByIU6WwdgweiauSBnX0Xg02dZYEQy2JZ0U0kpnw6eweH
 ZSMEIvsHkurTauR5eJBcKQb36Nk50uVYRQCkXWtjwJ6/Svqhnrnm6RIR8I9Pbs9kdKij og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td24ua9wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 00:39:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T0dOnM029326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 00:39:24 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 28 Sep 2023 17:39:22 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v5 0/7] Add support for LUT PPG
Date:   Thu, 28 Sep 2023 17:38:53 -0700
Message-ID: <20230929003901.15086-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SIk62l1MpKXXoy2tfBcNGswaCttq1nEW
X-Proofpoint-ORIG-GUID: SIk62l1MpKXXoy2tfBcNGswaCttq1nEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_23,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
modules instead of LUT peripheral. This feature is called PPG.

This change series adds support for PPG. Thanks!

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

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (pmi632)

Anjelique Melendez (7):
  dt-bindings: soc: qcom: Add qcom,pbs bindings
  dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
  soc: qcom: add QCOM PBS driver
  leds: rgb: leds-qcom-lpg: Add support for single SDAM PPG
  leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
  leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT
    SDAM
  leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme

 .../bindings/leds/leds-qcom-lpg.yaml          |  89 ++++-
 .../bindings/soc/qcom/qcom,pbs.yaml           |  46 +++
 drivers/leds/rgb/leds-qcom-lpg.c              | 359 ++++++++++++++++--
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 243 ++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  30 ++
 7 files changed, 749 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.41.0

