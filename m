Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAD7EEF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjKQJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjKQJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:56:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337ACAD;
        Fri, 17 Nov 2023 01:56:25 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH50TeF016872;
        Fri, 17 Nov 2023 09:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=3p1cbONrKTbdlzdJsgu8pI+S1RbdIs3VpKRdwG6bC60=;
 b=buPgS4xZLcdSUl0xQabh/9wz9oQWRJ/QIc0Y+B0dg+O+1nGPB3Vn3z1rwV5ObyVAo542
 NeAs77Ptz+tH+9Yw7jJcNeGYlgnU1GX2bjEPhcUmYSMpmzSOZirEP21bflsdsMZNnBhR
 2q4C0NH7m0EsDsZjkiJXFFDZrVINERVPyjDL42IkK7BFyRnjOR+UGJ8JUN5giD2QVVJp
 +Z++QrY858W3FPVnsYx5afKIJaLY/xajOp7tKq9Y1Qu7Z/ECrXbdaKof7FOsDxgvWcDu
 7ZS2CMhsRjhmgEWbV/QDxsOgRKiHFs/gf1S9p/V2c4l4jxknsagq5eetYpYkIV6UbA2l 9w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udkkutgh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:56:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9uJrM001085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:56:19 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 01:56:12 -0800
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH V4 0/4] Add support for Qualcomm ECPRI clock controller
Date:   Fri, 17 Nov 2023 15:25:54 +0530
Message-ID: <20231117095558.3313877-1-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gbmrMoY8Zzq0_iUpfefc69eGAQgQZINK
X-Proofpoint-ORIG-GUID: gbmrMoY8Zzq0_iUpfefc69eGAQgQZINK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=910 clxscore=1011 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ECPRI clock controller support for QDU1000 and QRU1000. The clock
controller has a special branch which requires an additional memory to
be enabled/disabled before the branch ops.

Changes since v3:
 - Updated the bindings description as per the review comments
 - Updated mem ops and ecpricc driver patches as per the review comments

Changes since v2:
 - Updated the mem ops implementation as per the latest review comments
 - Updated the ecpricc driver as per the review comments

Changes since v1:
 - Updated the dt-bindings
 - Modified mem ops logic as per the review comments
 - Update all the hex values to lowercase
 - Aligned the clock entries in DT as per the review comment

Previous series:
v3 - https://lore.kernel.org/linux-arm-msm/20231106103027.3988871-1-quic_imrashai@quicinc.com/
v2 - https://lore.kernel.org/linux-arm-msm/20231011090028.1706653-1-quic_imrashai@quicinc.com/
v1 - https://lore.kernel.org/linux-arm-msm/20230808051407.647395-1-quic_imrashai@quicinc.com/

Imran Shaik (3):
  dt-bindings: clock: qcom: Add ECPRICC clocks for QDU1000 and QRU1000
  clk: qcom: Add ECPRICC driver support for QDU1000 and QRU1000
  arm64: dts: qcom: qdu1000: Add ECPRI clock controller

Taniya Das (1):
  clk: qcom: branch: Add mem ops support for branch2 clocks

 .../bindings/clock/qcom,qdu1000-ecpricc.yaml  |   68 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         |   14 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-branch.c                 |   39 +
 drivers/clk/qcom/clk-branch.h                 |   21 +
 drivers/clk/qcom/ecpricc-qdu1000.c            | 2456 +++++++++++++++++
 .../dt-bindings/clock/qcom,qdu1000-ecpricc.h  |  147 +
 8 files changed, 2755 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
 create mode 100644 drivers/clk/qcom/ecpricc-qdu1000.c
 create mode 100644 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h

-- 
2.25.1

