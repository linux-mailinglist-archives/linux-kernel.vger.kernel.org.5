Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B202279111D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbjIDFut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjIDFus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:50:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D499;
        Sun,  3 Sep 2023 22:50:45 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3845TTiZ010255;
        Mon, 4 Sep 2023 05:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=zjhRpNgu0vjVHDIbTfFwDEG4kQusBq6+Tajn6DV6nzQ=;
 b=TjGM8iZjqFiVdPEaDxrEJvaOUBEoIkZr4bAw7c4KDcI6jXvQPaUr3ASw962wULKvjpLS
 lLg5CI9+/DDkRwtPQ73swXIChTFH9oGK9kqipauxoFxybNgXyWxvYLwNTCNsOSQyPqqc
 d2VTxeNxxmVSh76+8D8pNOwDy0h3SA7+LOOUKuWaZGsz3f7LHYrLebKF74fAVaXI2uo2
 yi+OuG3s6/ndey54xUuC/Re+k7BWF6+kH3J7czBJNUowNcD+DBeKQcew10NGFm6/d18d
 m/qGSa3yBfNEqnATi9jy3A60x8ki+Hb6x2cWaHrwLo8k2VCuEGKEYfRRkxAWig6RrgcM uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw99avsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 05:50:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3845oUaM025844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 05:50:30 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 3 Sep 2023 22:50:25 -0700
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
Subject: [PATCH 0/3] Fix tcsr_mutex register for IPQ6018
Date:   Mon, 4 Sep 2023 11:20:07 +0530
Message-ID: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6G8jbNg9Oe83jDuWS11Bq6eLQQ6RIIMH
X-Proofpoint-ORIG-GUID: 6G8jbNg9Oe83jDuWS11Bq6eLQQ6RIIMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=552 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 has 32 tcsr_mutext hwlock registers of 0x1000 size each.
The compatible string qcom,ipq6018-tcsr-mutex is mapped to
of_msm8226_tcsr_mutex which has 32 locks configured with stride of 0x80
and doesn't match the HW present in IPQ6018.

This series fixes the following:
1. Fix the tcsr_mutex hwlock register size to 0x20000 in ipq6018.dtsi.
2. Remove qcom,ipq6018-tcsr-mutex compatible string for tcsr_mutex in
ipq6018.dtsi.
3. Drop unused qcom,ipq6018-tcsr-mutex compatible string from
qcom_hwspinlock driver and dt-bindings.

Vignesh Viswanathan (3):
  arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size
  hwspinlock: qcom: Drop unused qcom,ipq6018-tcsr-mutex
  dt-bindings: hwlock: Drop unused qcom,ipq6018-tcsr-mutex

 Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml | 1 -
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                         | 4 ++--
 drivers/hwspinlock/qcom_hwspinlock.c                          | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.41.0

