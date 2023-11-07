Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2587E3FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjKGNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKGNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:18:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E43F30C3;
        Tue,  7 Nov 2023 05:05:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7CnrAb028577;
        Tue, 7 Nov 2023 13:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=AB8RTa5fm3KQbRFYrmA8woJuPxXcSkavDewh7TBcHqg=;
 b=AwoCsGM/ITG04VUMs2+AWgvhF0aAxdgps31pDefsvZRwYQbsD1oEoU2jaQWt90vfm6Ne
 PJX2+hsTB+H1gdqpaIbPdhrf2d9BWQupwxp/Xn/G7hBvqdnkK+ruEa+tpxHNWr2gW2ED
 pNWuEZgIv/bZEndh/kmvOIU/Lhg/qkmJovQ/RvhrWaUH+8UthWEVZmNLHJR7tQFYDh5L
 Us4BkOY4n8QMV4K1hLMN4HJWM1fx+ChE182CBljWUWxpICttlx8iMl4RpdQSHo11F2yX
 yF0mBlitrJ2DUNGQKFFKdvlmwLFaoR/CJat053mSbx1gmDbvGB2gUk9ZdPUnU3QfhXoE DQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7n8u027h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 13:05:01 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A7D4vmU010872;
        Tue, 7 Nov 2023 13:04:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3u5f1kwjfu-1;
        Tue, 07 Nov 2023 13:04:57 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7D4vTP010865;
        Tue, 7 Nov 2023 13:04:57 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3A7D4uQs010861;
        Tue, 07 Nov 2023 13:04:57 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id B08AC4C76; Tue,  7 Nov 2023 18:34:55 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v1 0/2] arm64: qcom: sa8775p: add support for x4 EP PCIe controller
Date:   Tue,  7 Nov 2023 18:34:51 +0530
Message-Id: <1699362294-15558-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5Ky6xGbPwRgppYllu9uTgzjKw21OHXkn
X-Proofpoint-ORIG-GUID: 5Ky6xGbPwRgppYllu9uTgzjKw21OHXkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_04,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=425 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070107
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates PHY and add EP PCIe node in dtsi file for
ep pcie1 controller that supports gen4 and x4 lane width.

To verify this series we required [1]

[1] https://lore.kernel.org/all/1699361428-12802-1-git-send-email-quic_msarkar@quicinc.com/

Mrinmay Sarkar (2):
  phy: qcom-qmp-pcie: add x4 lane EP support for sa8775p
  arm64: dts: qcom: sa8775p: Add ep pcie1 controller node

 arch/arm64/boot/dts/qcom/sa8775p.dtsi    | 48 ++++++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  9 +++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.7.4

