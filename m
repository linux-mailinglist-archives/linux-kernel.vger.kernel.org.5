Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17E080C28F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjLKICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjLKIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:02:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48928AF;
        Mon, 11 Dec 2023 00:02:35 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB7pGp4003640;
        Mon, 11 Dec 2023 08:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=2FOhF2C
        pXO8s3CG1kBfgubRLt0QMtmzHpEA6ccTRLDI=; b=dm1j/+y/9Gh89KDVxh2o/Fc
        oNGQZKd5ke+bxJELwS+dV+Z9ScIEYGqQXvqB6LhtzWL0TC36CVYVAv5E+ObRZiXG
        SwGKQxVcIdekt9t/jaEnPmOODtpz1DM5PxteWyTQt51j191wrIVnr6TuH7EIJ5s1
        /G8NQNNYIzoN7LZ/JC7cr01pfXfJZ3wZeYAbddpg4mAUQstnheNfuzXcGsL17x7f
        j++1gfZDtfA5O68QdtB3O3M6AyhoP1U883AgLf8bQ7CkpKrA3kAkhNliHZFqsx1v
        yfre98dq+iiA80Ke2WbEvEzbW0yYNGwTU1a39J9LJxaBp5lvTYD/CBdP4nYK3eg=
        =
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnk5tmd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 08:02:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB82I7L007748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 08:02:18 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 00:02:07 -0800
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
Subject: [PATCH net-next v5 0/3] Ethernet DWMAC5 fault IRQ support
Date:   Mon, 11 Dec 2023 13:31:50 +0530
Message-ID: <20231211080153.3005122-1-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nZXsVhzXfMxRfIzqW9yF2AqnGNwZI8EA
X-Proofpoint-GUID: nZXsVhzXfMxRfIzqW9yF2AqnGNwZI8EA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to listen Ethernet HW safery IRQ. The safety IRQ will be
triggered for ECC(error correction code), DPP(data path parity,
FSM(finite state machine) error.

Changes since v5:
- Add description of ECC, DPP, FSM

Changes since v4:
- Fix DT_CHECKER warning
- use name safety for the IRQ.

Suraj Jaiswal (3):
  dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
    sa8775p
  arm64: dts: qcom: sa8775p: enable safety IRQ
  net: stmmac: Add driver support for DWMAC5 safety IRQ support

 .../devicetree/bindings/net/qcom,ethqos.yaml   |  9 ++++++---
 .../devicetree/bindings/net/snps,dwmac.yaml    |  6 ++++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi          | 10 ++++++----
 drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
 7 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.25.1

