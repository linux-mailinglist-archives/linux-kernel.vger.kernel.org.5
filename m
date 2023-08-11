Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5F779691
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbjHKR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKR5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:57:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E820273E;
        Fri, 11 Aug 2023 10:57:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BE52ed028645;
        Fri, 11 Aug 2023 17:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0bZE1JlI68uKDQ07VeJt/lM2YO/1SeoeIMLirT+TUFM=;
 b=ogLJPw2eepWCU3G7KaeFJhg0hdVEL+XUt+VHY+wPKsFcOMeLej1emwK/3AcdBFAq3nzm
 6klpG+BDzoUQV+XkDDobapJk4hNOHAy3GlSAKY4FW4EtPYdh3cWXyfYY9K6FbDmmm+t6
 tMvboVLSTp5JwHzCnX319dejPfTIRVrTv4chMhAWfNvfBHlGrC3xFZhzjdfLkkWCIiqz
 fkMCAk4AIoqabnzXDB4/HdNUTJMOBDXczKNamlLPKdUaPwPYf0vHJSK/R3h2wEhIpxjG
 VNeU856DrDlZAmi4zu7PIciaOiWVJ9Hv/n5rs8qVvVa5gq1Onz1w9tOyX6ChQoV8gVy1 Mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yaaegj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:57:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BHvYhP029339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:57:34 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 10:57:34 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v3 0/3] Add qcom hvc/shmem transport
Date:   Fri, 11 Aug 2023 10:57:16 -0700
Message-ID: <20230811175719.28378-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718160833.36397-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b8LV0jQgm1EZNuRJCPj_T3I26aPDVvWm
X-Proofpoint-ORIG-GUID: b8LV0jQgm1EZNuRJCPj_T3I26aPDVvWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=950 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduce a new transport channel for Qualcomm virtual
platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
The difference between the two transports is that a parameter is passed in
the hypervisor call to identify which doorbell to assert. This parameter is
dynamically generated at runtime on the device and insuitable to pass via
the devicetree.

The function ID and parameter are stored by firmware in the shmem region.

This has been tested on ARM64 virtual Qualcomm platform.

---
v3 -> fix the compilation error reported by the test bot,
      add support for polling based instances

v2 -> use allOf construct in dtb schema,
      remove wrappers from mutexes,
      use architecture independent channel layout

v1 -> original patches

Nikunj Kela (3):
  dt-bindings: arm: convert nested if-else construct to allOf
  dt-bindings: arm: Add qcom specific hvc transport for SCMI
  firmware: arm_scmi: Add qcom hvc/shmem transport

 .../bindings/firmware/arm,scmi.yaml           |  67 ++---
 drivers/firmware/arm_scmi/Kconfig             |  13 +
 drivers/firmware/arm_scmi/Makefile            |   2 +
 drivers/firmware/arm_scmi/common.h            |   3 +
 drivers/firmware/arm_scmi/driver.c            |   4 +
 drivers/firmware/arm_scmi/qcom_hvc.c          | 232 ++++++++++++++++++
 6 files changed, 293 insertions(+), 28 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c

-- 
2.17.1

