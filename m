Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D267754A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjHIIB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:01:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9561736;
        Wed,  9 Aug 2023 01:01:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3794PRGu003898;
        Wed, 9 Aug 2023 08:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AbOc98dY5ZGro70b02+NKzOFZD0bpyfmPo/r2PE8aMo=;
 b=TlXh+k43EW0d36/bru5bBRywjMXQlU3ZikClz9+7by0bZDqXlK6pRW/txsxRImVOfZ+u
 cjHNJQ/vSJEgjuNrt+wNt+f22YWGPo9FdbFDyS29vq4+Ml60gUDszBvPEcSsIjqjGQI3
 8FX09lBhvLSKk2FTPYc4TW0TzcMzNOMxTqxjY60iNXk72y8AfYYaYjm/Tj685sWJx6sE
 936pX4vXxLvmUyrqnvX1gkUu7msSzfkpc5mc0DYw9K4VQjr9jEBqe93Bf5Ur+ts3sYkc
 GxmSSBviXyUoApPbIqqxcWeESOk2/yQ1wSz7uEaeTdN5vrEVZ1EXuypq+/jvdk04LlhG Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbcacu52e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:01:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379816QI007105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 08:01:06 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 01:01:01 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v1 0/4] add clock controller of qca8386/qca8084
Date:   Wed, 9 Aug 2023 16:00:43 +0800
Message-ID: <20230809080047.19877-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8xsSeEklYJC-PYnZumnZbOSzDq88anBi
X-Proofpoint-ORIG-GUID: 8xsSeEklYJC-PYnZumnZbOSzDq88anBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_06,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=814 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qca8xxx is 4 * 2.5GBaseT ports chip, working as switch mode
named by qca8386, or working as PHY mode named by qca8084,
clock hardware reigster is accessed by MDIO bus.

This patch series add the clock controller of qca8363/qca8084,
and add the clock ops clk_branch2_qca8k_ops to avoid spin lock
used during the clock operation of qca8k clock controller where
the sleep happens when accessing clock control register by MDIO
bus.

Changes in v1:
	* remove clock flag CLK_ENABLE_MUTEX_LOCK.
	* add clock ops clk_branch2_qca8k_ops.
	* improve yaml file for fixing dtschema warnings.
	* enable clock controller driver in defconfig.

Luo Jie (4):
  clk: qcom: branch: Add clk_branch2_qca8k_ops
  dt-bindings: clock: add qca8386/qca8084 clock and reset definitions
  clk: qcom: add clock controller driver for qca8386/qca8084
  arm64: defconfig: Enable qca8k nss clock controller

 .../bindings/clock/qcom,qca8k-nsscc.yaml      |   79 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-branch.c                 |    8 +
 drivers/clk/qcom/clk-branch.h                 |    2 +
 drivers/clk/qcom/nsscc-qca8k.c                | 2195 +++++++++++++++++
 include/dt-bindings/clock/qcom,qca8k-nsscc.h  |  101 +
 include/dt-bindings/reset/qcom,qca8k-nsscc.h  |   75 +
 9 files changed, 2470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
 create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
 create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
 create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h


base-commit: 1c2c8c3517b3ba43a964afe1ff7926b13dc51492
-- 
2.17.1

