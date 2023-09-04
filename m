Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D850791BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352344AbjIDRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjIDRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:25:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03939CDE;
        Mon,  4 Sep 2023 10:25:39 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384Ggcq1032570;
        Mon, 4 Sep 2023 17:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=A58aGVMyp6BBZcxWu3U6AlbB27nyeUyEA4RKnkSUOZY=;
 b=G+vBgbU+pIUfN2+tibaneC3UO2Dq2RYm433WxDCgxtqFflXGzHidO0FUvhNpSWGy/jA5
 B3i3cno4Ve/0ElVa1ugSOEMnIGEL5/HmI+Ke3yskLvNngV2IoIoxHaWwWIQ8Frdvdvcq
 So29mHULjuQqHOTX7F7H1Sm9FccZ2Krvf6NHOGK1Dj/PFuoHUC087FiWyZv9BmGSPQHi
 9k1t4aD3wyIXkBzZSSRYuilqS/Hg+7yiB3pxYng8RbhhTMrEGTaXe/Ld8Q5bKtkxWCAh
 ME7UfQ7Q8s+ALGpdRW3ruymIG85GSS/2DpRzczJrrJMjKDOP8kYneSTAp2veYN4A3p+W bA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sweb50paq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 17:25:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384HPY5j029623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 17:25:35 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 4 Sep 2023 10:25:30 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH v2 0/4] Fix SMEM hwlock index for IPQ platforms
Date:   Mon, 4 Sep 2023 22:55:11 +0530
Message-ID: <20230904172516.479866-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gCeROn8YvKpVIPTSjBrBJ6SluhkSZKkc
X-Proofpoint-GUID: gCeROn8YvKpVIPTSjBrBJ6SluhkSZKkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_10,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=557 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
in SMEM region shared by the Host and FW.

Fix the SMEM hwlock index to 3 for IPQ5332, IPQ6018, IPQ8074 and IPQ9574.

Vignesh Viswanathan (4):
  arm64: dts: qcom: ipq5332: Fix hwlock index for SMEM
  arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
  arm64: dts: qcom: ipq8074: Fix hwlock index for SMEM
  arm64: dts: qcom: ipq9574: Fix hwlock index for SMEM

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0

