Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9269D80EB12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbjLLL7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:59:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A7AAF;
        Tue, 12 Dec 2023 03:59:25 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBvjei009276;
        Tue, 12 Dec 2023 11:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=0Jed8Jl
        yIG9jJN1AB2L0rEbo+u9qwlyCqYa69UD8+vM=; b=LsDXLx6M1DQYojV643uF3NC
        UyVTkBWhzUm4ZBDkHmm4tDg3eJictt1D4ozadw6kE5MU7+JTH3QrxJHF/o5Oi8oC
        KCJ40sy+/vZ0WVeH5a4eQSO0sGIh7Dxmubu8e1uAHahNoBWtjoiPSW1qOWv4+5GI
        DHh4lA6etb4Nufn+zwXgrx6ZrqP4/zg/XI+YvWYxwYwPY8RoPdS6i8UnJQVVVq2g
        2HKj4n9nZa7QGL4NxNmB8Sug89TsY+DjcFRNJ7kiLmtCgExVlBKRvz5rsUl94Pr5
        Aae1B+YKG3chhd9YdnK2a1ith7uhAkNTg03LUw3sTe0/9c/VN5TB/GrP2Mc36pQ=
        =
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxa8jhn0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:59:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBxBOb009258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:59:11 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:59:00 -0800
From:   Suraj Jaiswal <quic_jsuraj@quicinc.com>
To:     <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Rob Herring <robh@kernel.org>
CC:     <kernel@quicinc.com>
Subject: [PATCH net-next v6 0/3] Ethernet DWMAC5 fault IRQ support
Date:   Tue, 12 Dec 2023 17:28:38 +0530
Message-ID: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3vWE-nz7g9Whx4a54Knfev2rr72c0sNk
X-Proofpoint-ORIG-GUID: 3vWE-nz7g9Whx4a54Knfev2rr72c0sNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to listen Ethernet HW common safery IRQ for correctable and 
uncorrectable fault. The safety IRQ will be triggered for ECC(error
correction code), DPP(data path parity, FSM(finite state machine) error.

Changes since v6:
- use name sfty_irq instead of safety_common_irq.

Changes since v5:
- Add description of ECC, DPP, FSM

Changes since v4:
- Fix DT_CHECKER warning
- use name safety for the IRQ.

Suraj Jaiswal (3):
  dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
    sa8775p
  arm64: dts: qcom: sa8775p: enable safety IRQ
  net: stmmac: Add driver support for DWMAC5 common safety IRQ

 .../devicetree/bindings/net/qcom,ethqos.yaml  |  9 +++++---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 ++++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 10 +++++----
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  9 ++++++++
 7 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.25.1

