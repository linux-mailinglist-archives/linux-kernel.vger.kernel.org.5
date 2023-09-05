Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E519792875
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbjIEQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354143AbjIEJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:56:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBAB18C;
        Tue,  5 Sep 2023 02:56:41 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3856E2L0002916;
        Tue, 5 Sep 2023 09:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=vfgVDhvOSV2ueMzB7mhpoS2y7u+bBW8t/lA82pC8OHE=;
 b=SrwapdkkZFmYL6wYfDUk5x2Ll6C+YmEGlv3eID8ZOq9h/hd2Yi3GxMtO5snZhzKMUeSL
 nvFp0E7fpQPH7aEA7TPxITza91hCp6xDmfZaaKkj3HeD3bbuwuhhMNXOVMLwXIk6F2uc
 9s+cL3sbgU8043C+x0eU6Dw6ywTz15uXXsAGgAPoO7qyLa9wxSZcekoSCa2gqxxwP9tK
 beOdQkBvd1VJkDUyElBugF7D08MUUl4/E8zNvSnPRh+7qPSp3yHu2dvaD7oKhk90W47Y
 l3TffStk+7Zjh4VrYIsKt02w1HJY/4oihz02Fe/kjljDqTrRzcBjDfq9i2TZ8xMB4Fcx ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtyngt4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 09:56:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3859uU7l020247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 09:56:30 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 5 Sep 2023 02:56:24 -0700
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ohad@wizery.com>,
        <baolin.wang@linux.alibaba.com>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH v2 0/2] Fix tcsr_mutex register for IPQ6018
Date:   Tue, 5 Sep 2023 15:25:33 +0530
Message-ID: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XsstAehvnF8fiP26QoE4zmTSHCzg1guy
X-Proofpoint-ORIG-GUID: XsstAehvnF8fiP26QoE4zmTSHCzg1guy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=580 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 has 32 tcsr_mutex hwlock registers of 0x1000 size each.
The compatible string qcom,ipq6018-tcsr-mutex is mapped to
of_msm8226_tcsr_mutex which has 32 locks configured with stride of 0x80
and doesn't match the HW present in IPQ6018.

This series fixes the following:
 1. Fix the tcsr_mutex register size to 0x20000 in IPQ6018 DTSI.
 2. Remove IPQ6018 specific compatible in hwspinlock driver so that it
    falls back to pick of_tcsr_mutex data.

Changes in v2:
 - Drop changes to remove qcom,ipq6018-tcsr-mutex from dt-bindings
 - Drop changes to remove qcom,ipq6018-tcsr-mutex compatible from
   ipq6018.dtsi
 - Add Fixes and stable tags

Vignesh Viswanathan (2):
  arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size
  hwspinlock: qcom: Remove IPQ6018 SOC specific compatible

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 drivers/hwspinlock/qcom_hwspinlock.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.41.0

