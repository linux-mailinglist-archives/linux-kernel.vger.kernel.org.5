Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61B7BBD1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjJFQnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjJFQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:43:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC24191;
        Fri,  6 Oct 2023 09:42:45 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396Et2vt006118;
        Fri, 6 Oct 2023 16:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HKd9xrK3zkUUSOIzOYk53A/BFWHivrHqCJQpned/qx8=;
 b=PN4u4UwVHbqq3pc6Y6QhRViGaM9k131KKUzFf8JXE8rGRkF5W2bk1aFWYtmcXPaP0wdV
 +1V0sPe8+Pct6b70dpbE0c7PK9N/vKt1SirxBKi33WpQbQSk/VF/J2Zh8y312qZqrDim
 P8IMW3Ip64HYca9uk3K/54hIIF/KVSdhebRvQOd8yIvZAr2fyzD0BlHRTL9dR0yzt68T
 LkKOOmjqi1dbc9nnGTgQN8AUPHdwtz4v/sdfcIw6ITG35muqgkWa7EwEzU+g5yPaM1pK
 iCtZGtbdKVRxLTQEZQfjYPbzYPsO5oC3vop+UB2tjtlt81YF1cqtaH0OM2t8agoc8eai aA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thg7hvmpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 16:42:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 396GgLZH013298
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 16:42:21 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 09:42:20 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v5 0/2] Add qcom smc/hvc transport support
Date:   Fri, 6 Oct 2023 09:42:04 -0700
Message-ID: <20231006164206.40710-1-quic_nkela@quicinc.com>
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
X-Proofpoint-GUID: XHvjQ-152ByeRUhpUpxxNChZhZTU_Bnr
X-Proofpoint-ORIG-GUID: XHvjQ-152ByeRUhpUpxxNChZhZTU_Bnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=868 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change augments smc transport to include support for Qualcomm virtual
platforms by passing a parameter(capability-id) in the hypervisor call to
identify which doorbell to assert. This parameter is dynamically generated
at runtime on the device and insuitable to pass via the devicetree.

The capability-id is stored by firmware in the shmem region.

This has been tested on ARM64 virtual Qualcomm platform.

---
v5 -> changed compatible, removed polling support patch,
      make use of smc-id binding for function-id

v4 -> port the changes into smc.c

v3 -> fix the compilation error reported by the test bot,
      add support for polling based instances

v2 -> use allOf construct in dtb schema,
      remove wrappers from mutexes,
      use architecture independent channel layout

v1 -> original patches

Nikunj Kela (2):
  dt-bindings: arm: Add new compatible for smc/hvc transport for SCMI
  firmware: arm_scmi: Add qcom smc/hvc transport support

 .../bindings/firmware/arm,scmi.yaml           |  4 +++
 drivers/firmware/arm_scmi/driver.c            |  1 +
 drivers/firmware/arm_scmi/smc.c               | 33 +++++++++++++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1

