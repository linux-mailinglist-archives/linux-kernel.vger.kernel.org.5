Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A07BEA66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378328AbjJITPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbjJITPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:15:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896B8E;
        Mon,  9 Oct 2023 12:15:03 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399J03mq027332;
        Mon, 9 Oct 2023 19:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Au2zwI8nEPJBDnDP0Jpkk0pNWgyzzfFNkvXZiw7DZtM=;
 b=ceGsQ1J+pWFbm5+vD5NRA3tkNK4kUXzXnyXv3n4+1xwzSR+29xiTjzvNWnQI3raNE37L
 7awrBh3TdIs+6nBDyt0M95+yzCwKxgXioQoygyKoTd8x7tiBP9tDjLJLTg3IB9YtPqUx
 p9TCFNIVf37Z8j97TTIrDeZaf/yDawwEfbT3cNOubx3WJHfutYavBz6BDjlyeMJFKFBy
 zuzQrcemI+4eCLHecUqvDO7eomNvJkqwAEimYx3cxZ71nAaXrBQG8WeiEycBZdY1WeMB
 k/oJgmF60/VAk/qUYsGx5XeCYAnZcgsDXyDTyp+TFTxBjeDY/1PNhKKNVutmKMFGb0GG 2A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkhj13atw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 19:14:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399JEqbT006859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 19:14:52 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 9 Oct 2023 12:14:51 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v6 0/2] Add qcom smc/hvc transport support
Date:   Mon, 9 Oct 2023 12:14:35 -0700
Message-ID: <20231009191437.27926-1-quic_nkela@quicinc.com>
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
X-Proofpoint-ORIG-GUID: a-tP5NsJ_tIrTbKaP9YRPNZ-ddQxXUhE
X-Proofpoint-GUID: a-tP5NsJ_tIrTbKaP9YRPNZ-ddQxXUhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_17,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=898 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310090157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v6 -> use unsigned long for cap-id

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
 drivers/firmware/arm_scmi/smc.c               | 27 +++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.17.1

