Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811CB75FC73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGXQov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGXQor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:44:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F6E53;
        Mon, 24 Jul 2023 09:44:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ODac86017503;
        Mon, 24 Jul 2023 16:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fy1ch2k1PwNqN0ef8wBUEcnu4rrm55w3vl86KYDEliM=;
 b=mzF8prw4HnUtPQG5x+xsgeqhWVZKpyzXgphCU2jxZI/bt6BGjKPHnYDUsbNtnvgBZKQW
 nnQadOaklXCed+dv+P4Vb8ahbLfQMoPnohtY1a0JU/Dvi9FO86q/Xehp94xAaSs98fix
 ix++q8zitnjkjabeqJhhZtnQXTgadzTixJjzvQLpGV0SFxbvj1BKlGzPZh7hPyHYdbD1
 TXMHOq6zj3Jgv65B+XnWB8FX6bvR141fOMV+QhVdmr2/+IUSSdY8w91D+fCHGUjdvNmb
 7MfOGZCW48W3g6En5jFlO+tGt7IPHry5FEf0RUc4Jb/Ex98MaFIf4rGhj9YBk2egmnW1 1g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qcyrupq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:44:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OGiYaB007323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:44:34 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 09:44:33 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v2 0/3] Add qcom hvc/shmem transport
Date:   Mon, 24 Jul 2023 09:44:16 -0700
Message-ID: <20230724164419.16092-1-quic_nkela@quicinc.com>
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
X-Proofpoint-ORIG-GUID: M7mn8WvFes0i3iiTNJBZpPdrwn0s8nEL
X-Proofpoint-GUID: M7mn8WvFes0i3iiTNJBZpPdrwn0s8nEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=986 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v2 -> use allOf construct in dtb schema,
      remove wrappers from mutexes,
      use architecture independent channel layout

v1 -> original patches

Nikunj Kela (3):
  dt-bindings: arm: convert nested if-else construct to allOf
  dt-bindings: arm: Add qcom specific hvc transport for SCMI
  firmware: arm_scmi: Add qcom hvc/shmem transport

 .../bindings/firmware/arm,scmi.yaml           |  67 +++---
 drivers/firmware/arm_scmi/Kconfig             |  13 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/common.h            |   3 +
 drivers/firmware/arm_scmi/driver.c            |   4 +
 drivers/firmware/arm_scmi/qcom_hvc.c          | 224 ++++++++++++++++++
 6 files changed, 284 insertions(+), 28 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c

-- 
2.17.1

