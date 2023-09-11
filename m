Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D141379B925
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbjIKU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbjIKTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:44:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0122418D;
        Mon, 11 Sep 2023 12:44:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BDgOw5006536;
        Mon, 11 Sep 2023 19:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zMmdeVBXvRLbOHJSIxUrgE4tO67oN2RuTYbnjxfjIvw=;
 b=K7nafr6b5GQkkij0aVTgU5vTyvHl3Y7PyOGvaoq58J4EKkmZaV5ASCGj6wFbC6IHVhcQ
 2pLJbwCPfIXJNAxJIPVZrXGB41u2Icj1d5u9pFJThvnTRO58ua5suaknKNhXR7XgCBLH
 fVGQ3FAG+X7gqnzP6z8nDx2wB1mhXjfkVBXl5jGh265EIM49rav8NnMmEP/7uJT3ifyU
 D/JkXVZrB4wR00ahXZFkZvpb386xbxHIh/6MsXXF9xvjgXy6JWOZw9JPw9IUEnh5lvcF
 gh/M5yQU1ag+jDCHhNdg9/WkPUoY+bPa7+99qt6ZBnqrlQN3tOymtB9zHAZnxC9Ekjtz rg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1xjmsmp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BJiHUs017286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:17 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 12:44:16 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 0/4] Add qcom hvc/shmem transport support
Date:   Mon, 11 Sep 2023 12:43:55 -0700
Message-ID: <20230911194359.27547-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718160833.36397-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c8mjb6HkEqF1SGkD-7uei4nZYu3H1Q4u
X-Proofpoint-GUID: c8mjb6HkEqF1SGkD-7uei4nZYu3H1Q4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=936
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110181
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

The function ID and parameter are stored by firmware in the shmem region.

This has been tested on ARM64 virtual Qualcomm platform.

---
v4 -> port the changes into smc.c

v3 -> fix the compilation error reported by the test bot,
      add support for polling based instances

v2 -> use allOf construct in dtb schema,
      remove wrappers from mutexes,
      use architecture independent channel layout

v1 -> original patches

Nikunj Kela (4):
  firmware: arm_scmi: Add polling support for completion in smc
  dt-bindings: arm: convert nested if-else construct to allOf
  dt-bindings: arm: Add new compatible for smc/hvc transport for SCMI
  firmware: arm_scmi: Add qcom hvc/shmem transport support

 .../bindings/firmware/arm,scmi.yaml           | 67 +++++++++++--------
 drivers/firmware/arm_scmi/Kconfig             | 14 ++++
 drivers/firmware/arm_scmi/driver.c            |  1 +
 drivers/firmware/arm_scmi/smc.c               | 62 +++++++++++++++--
 4 files changed, 110 insertions(+), 34 deletions(-)

-- 
2.17.1

