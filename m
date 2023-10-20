Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E57D15B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJTSW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:22:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B54D6A;
        Fri, 20 Oct 2023 11:22:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KI5fYJ029777;
        Fri, 20 Oct 2023 18:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=e8rxuQk/2ug768QjWGfvPaNQ15UCKIp/Vn0HPG51xrs=;
 b=G6G4L2sBwszw2r5+DJpEnqhTKTEZtw3nlpCD0lHO7FbpT2lhxzZO0avIZ+pS4EKSHN46
 uuQq4ulzCBWwt6J9m6msryCsFiuZY3t+J2PC/63dnIv+icgIH5MElerE7l1cF+wW9rxj
 m4iklosVr0+D9DjULrOXw04aC9zGA/LunF3949y/gFGlAJYbQzOgM7ptZOdHSN6K//uG
 hF0NH0EuSvVFLygLNHuDFixCfo8eSPctSmrP8LN+o+3dTJEL31wtcQOHdNcga14FAFdR
 SKgETi5TMj+T+nRmIUx+mZOLpF/MbqHzdcog204bl3bSsMevfnJBRzyvax18J9gsj6mC 9Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tuxhc0165-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 18:22:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KIMd5R003806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 18:22:39 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 11:22:38 -0700
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
Subject: [PATCH v6 0/7] Add support for LUT PPG
Date:   Fri, 20 Oct 2023 11:22:10 -0700
Message-ID: <20231020182218.22217-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aGC2Oe30_cV_nQgHf0oFNrbvJPZCh3VY
X-Proofpoint-ORIG-GUID: aGC2Oe30_cV_nQgHf0oFNrbvJPZCh3VY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200154
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

 .../bindings/leds/leds-qcom-lpg.yaml          |  89 ++++-
 .../bindings/soc/qcom/qcom,pbs.yaml           |  46 +++
 drivers/leds/rgb/leds-qcom-lpg.c              | 344 ++++++++++++++++--
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qcom-pbs.c                   | 243 +++++++++++++
 include/linux/soc/qcom/qcom-pbs.h             |  30 ++
 7 files changed, 733 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
2.41.0

