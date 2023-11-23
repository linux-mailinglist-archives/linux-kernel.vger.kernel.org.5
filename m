Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F97F5DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbjKWLix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjKWLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:38:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE18BC;
        Thu, 23 Nov 2023 03:38:58 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN9TX74031781;
        Thu, 23 Nov 2023 11:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=cahJq3zvyMWZ26vAEszpiEN1alzkguUJCq7NtLAPzUI=;
 b=R63HcEvRKrCYdcyB3JSIBAOVShWYdv8yJHXxc/W6heEjv1FSlmblhIA7hbPW2HehIhOp
 7lbcpJKyDbC6WOS0GX3i3TYGYhhSQvPIR1HGI6ayQDru5ylzr6vGZ62wwHfPdsZyBvoZ
 I1F1W+A1s/qvVEzP+e0fvhoIxSFtFZV9krHEzCyYYban1L+gY/nqhmqxKCBChfjmc72B
 fMJBJ6JDDN37V2WdSKinBdcR9SYHr5NQ7PHNvZkp2Tr2u8wnSdxPdMHfkspvAe+HqHlX
 1NC2SXh6pEyDB1O/QQuNIIS8OmVn6Svp8Mz9zHbm6xJLWgg2cx29pWm33UbRrPyLTon5 mg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhwme96v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:38:44 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANBch2A005721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 11:38:43 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 03:38:33 -0800
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
        Andrew Halaney <ahalaney@redhat.com>
CC:     <kernel@quicinc.com>
Subject: [PATCH net-next v3 0/3] Ethernet DWMAC5 fault IRQ support
Date:   Thu, 23 Nov 2023 17:08:12 +0530
Message-ID: <cover.1700737841.git.quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LfHynSKvQqDBUD3VRGTkUQMyMX0bs5LP
X-Proofpoint-ORIG-GUID: LfHynSKvQqDBUD3VRGTkUQMyMX0bs5LP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=771 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suraj Jaiswal (3):
  dt-bindings: net: qcom,ethqos: add binding doc for fault IRQ for
    sa8775p
  arm64: dts: qcom: sa8775p: enable Fault IRQ
  net: stmmac: Add driver support for DWMAC5 fault IRQ Support

 .../devicetree/bindings/net/qcom,ethqos.yaml  |  7 +++++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 10 ++++++----
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 20 +++++++++++++++++++
 6 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.25.1

