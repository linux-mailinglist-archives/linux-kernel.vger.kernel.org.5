Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A87A90EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjIUCh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUChz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:37:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E98DD;
        Wed, 20 Sep 2023 19:37:49 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L22tG8006520;
        Thu, 21 Sep 2023 02:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=IfFz9BrB4bkgqUsTjtG5Gh1B+KFWE47RWaA23PuDYKM=;
 b=PjG+G+kH5DCJKcGOvaHRrKWxR8xigTkMhfmpTNzOPPWYvGkqJaatisGQshXBaUsHYZ8M
 ev4JYSjnEYQ0LXrShUv+TBus8vb1Vxsgvm17TCG+nc+iHftl7Pl5Wzva6NwuYBh4giEH
 bvkyNrVjxk92/TCrrGg3dhcrrhzYpYpSxpb3SdozF+o5LemwB7/ovK1xk2LkN2rzajQO
 8/Zmjb/4shzwOxBCQ+qmqaM0pHRMva/MVHMNXJ0nHah4Z0KL4yd0pe3Y8FgOY3rfXc2Y
 Yypv4mCJDGOYndUnvzdhDt3n3Zr1zlktOKkhtLSTi4gXm0iboSX8z8TRO9ydhdIxVR8B 7Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7r8w2nbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38L2bihs009388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 20 Sep 2023 19:37:43 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v3 0/3] soc: qcom: rmtfs: Support dynamic allocation
Date:   Wed, 20 Sep 2023 19:37:29 -0700
Message-ID: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmsC2UC/0WNwQrCMBBEf6Xk7JaYjUU9+R8ikibbNtIkNWlFK
 P13Vy9eBt7Am1lFoeypiHO1ikwvX3yKDLirhB1M7Am8YxZKKpQnJSGHuSsQKEC/mOxgMj0VcOg
 kOWlbiY1gtzWFoM0m2oHtuIwjl1Omzr9/Z9cbc5dTgHnIZP4XB+TERmOtpdZHhbCH5+LtvX0kn
 nN0+ZKPtrYpiG37AL+sWUPBAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695263863; l=1445;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=hVXyDKVlFdGuI9dLXSkJSn9oxA0b2xMTPu+VuroV7Yw=;
 b=pxG+lKUM41Ore1tkQRCk6f2SMLx6mXPzjWR6DvCQ761b97uOnYyzsS8J0fmsiqyY7ygvpO1dodF/
 D8pJr/uyCmBoAC6hiiCpbjztql1vJ5SQV/CFK2HfOzVh+f/QWEat
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VViAIUONxjDXdtmjCnA9hs18-39ejrB_
X-Proofpoint-ORIG-GUID: VViAIUONxjDXdtmjCnA9hs18-39ejrB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=608 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms have laxed requirements on the placement of the rmtfs
memory region, introduce support for guard pages to allow the DeviceTree
author to rely on the OS/Linux for placement of the region.

Changes since v2:
- Rewrote DeviceTree binding description, to avoid dictating the OS
  behavior.
- Adjusted addr and size before memremap(), to avoid mapping the guard
  pages, and unnecessarily have to adjust the base pointer.

Changes since v1:
- Drop qcom,alloc-size in favour of using reserved-memory/size
- Introduce explicit property to signal that guard pages should be
  carved out from this region (rather than always do it in the dynamic
  case).
- Drop the dma_alloc_coherent() based approach and just add support for
  the guard pages.
- Added handling of failed reserved-memory allocation (patch 3)

---
Bjorn Andersson (3):
      dt-bindings: reserved-memory: rmtfs: Allow guard pages
      soc: qcom: rmtfs: Support discarding guard pages
      soc: qcom: rtmfs: Handle reserved-memory allocation issues

 .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml   | 11 +++++++++++
 drivers/soc/qcom/rmtfs_mem.c                                  | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: 926f75c8a5ab70567eb4c2d82fbc96963313e564
change-id: 20230920-rmtfs-mem-guard-pages-d3d0ed0cb036

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

