Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD77997F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbjIIMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIIMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:35:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCCCD6;
        Sat,  9 Sep 2023 05:35:47 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389CTH8w029162;
        Sat, 9 Sep 2023 12:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FA0lskpsv9OKLCFBfBqkli5ASIBjL2TDMaHQYS69HaU=;
 b=pEjaRdloWEO9chHf7k23Y9tVROANCGUI5EE+kmc2KWWSJcZnwkbSSbulyGE3WJPjUUzM
 2kCHMP/ElQ7j/9NzWk4Eo/NX4bWWV3+RtPCjpcFyDV7Teutmtqm80Qe2zaVh4e0lgBND
 gNM9b8M1c/Jcao8WveyqvpFAzOWK1q8xqblV76BTlMOYOuSpeHMtlEY/zFX23jHPETqC
 YGQNUvoTaeD73qVBbUHjfemLPmNa39xaRhLtKoPa+gNRfqy1XeYwJGe000PpoApttDcK
 eH7gT4z24pESDHI/J0253CqiZiaVdl7F+bNFkychQsCstloNMDNhhHq1QnIQkDIkoJ3S +w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0edmgrtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 12:35:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389CZXnX008159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 12:35:33 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 05:35:28 -0700
From:   Ajit Pandey <quic_ajipan@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
CC:     Ajit Pandey <quic_ajipan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] clk: qcom: Add support for GCC and RPMHCC on SM4450
Date:   Sat, 9 Sep 2023 18:04:27 +0530
Message-ID: <20230909123431.1725728-1-quic_ajipan@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GtDPVssh3DJu8bMng3kjrEbULh7qxRtC
X-Proofpoint-GUID: GtDPVssh3DJu8bMng3kjrEbULh7qxRtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=839 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add dt-bindings and driver support for GCC and RPMHCC on
SM4450 platform.

Changes in v2:
 - Remove min-items and optional tag from bindings documentation.
 - Use qcom_branch_set_force_mem_core() wrapper API to update bits.
 - Link to v1: https://patchwork.kernel.org/project/linux-clk/list/?series=779098

Ajit Pandey (4):
  dt-bindings: clock: qcom: Add RPMHCC for SM4450
  clk: qcom: rpmh: Add RPMH clocks support for SM4450
  dt-bindings: clock: qcom: Add GCC clocks for SM4450
  clk: qcom: Add GCC driver support for SM4450

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm4450-gcc.yaml       |   55 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   21 +
 drivers/clk/qcom/gcc-sm4450.c                 | 2897 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm4450-gcc.h   |  197 ++
 7 files changed, 3181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm4450.c
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-gcc.h

-- 
2.25.1

