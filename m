Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F37E206D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjKFLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:53:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104B94;
        Mon,  6 Nov 2023 03:52:59 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6ASvNa005529;
        Mon, 6 Nov 2023 11:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=O7Ok2W0/XRJKfI34YipOsLcgoAANsmCKZDKdtVVLPwo=;
 b=MHhFVPhgTBBCNRVaWcvwzTcBZusbWWK2/+cZJt88d3/sWloFT1ZwxoM9rkQmKM1Sd202
 3+I0ASQzpvXMC3HZuTklVVGljjyGu7MDrYVnOE1Lx4mSkOjsnIBwXj4kijK/pilLusx2
 UcjmQH7NtKUf3DIFv9guyatfFtxz/zVs5Yd+xRFWN50xmrEs9yA9G95EoaYKPIYrb9TC
 obbYkByTAyYJfYNUd6dv3TTdNFxdSWJeGXoyeNUy3g7WE7XLqsp0OaN+k8w4oBzI5CCm
 EQ+ud3eqS2VqTnaJZrnbbnk3zo4HYlnZ0IJUCgLINCluose37lIRPK8z4iOuxI1DONKl GA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6xdu87bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 11:52:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6Bqo6r014804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 11:52:50 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 03:52:45 -0800
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH 0/2] phy: qcom-qmp-pcie: Add support to keep refclk always
 on
Date:   Mon, 6 Nov 2023 17:22:33 +0530
Message-ID: <20231106-refclk_always_on-v1-0-17a7fd8b532b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILTSGUC/x2MWwqAIBAArxL7nZAGpV0lQtS2WgoLhR6Ed0/6H
 JiZFyIGwghd8ULAkyLtPgMvC3CL8TMyGjODqETNedWwgJPbVm22yzxR754piwalUK2zEnJ2ZIP
 uf9kPKX22j9GLYgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699271564; l=1149;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=rOqRd8dUZXBv8AK+fFRgy5WFi6zRJCdIHc+U2YfEafk=;
 b=rS5if1xwJXYJ31AXMIj/0x3LJ8ePUkfqSStWanLdLMfdi/BjMDcDeO6Sh/ocSJNx/dMHP6tFy
 qhQo2K3bG+CD8Ovi1Fd7nJYl1WPot3X4mbxtMgnMEno97FfCk3tixJ0
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: daU4FlACUj3NOompZky48E78CpQgzj66
X-Proofpoint-ORIG-GUID: daU4FlACUj3NOompZky48E78CpQgzj66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=573 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to provide refclk to endpoint even in low
power states.

Due to some platform specific issues with CLKREQ signal, it is not being
propagated to the host and as host doesn't know the clkreq signal host is
not sending refclk. Due to this endpoint is seeing linkdown and going
to bad state.
To avoid those ref clk should be provided always to the endpoint. The
issue is coming only when ep intiates the L1.1 or L1.2 exit and clkreq
is not being propagated properly to the host. 

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Krishna chaitanya chundru (2):
      dt-bindings: phy: qcom,qmp: Add PCIe qcom,refclk-always-on property
      phy: qcom-qmp-pcie: Add support for keeping refclk always on

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    |  5 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c            | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 71e68e182e382e951d6248bccc3c960dcec5a718
change-id: 20231106-refclk_always_on-9beae8297cb8

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>

