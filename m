Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3758064C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376682AbjLFCJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376398AbjLFCJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:09:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29F18D;
        Tue,  5 Dec 2023 18:09:19 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B60GxL3030495;
        Wed, 6 Dec 2023 02:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Hpo9fz+0OdNwwsSh0GVzOIt0EvcBtEaCpkFVTj+4Vmk=;
 b=HSxQcact+A4mnerx+y1hqLbE78ktUVXPblqRNshr75O+MC4eRUabWqcoDUIfzhWVnsT5
 b9WcvqqIVSjTg6zSuz4xEVFD2oJzF1v5BUbHpX+Lx64/9WRG5ctKTfptBWoLKdKMbykn
 B6JtOVoDMRpf4EW2oP/FbjwuDrDCttiTI1BpDdfL/asRhhACNRobtWyejepN4sYvsmRq
 8sou9PbbZ11u0rFWc9QIXT84DZpdCRuGrigBiQ3Z7cm3IVet2CEIA12eYaMFyNWwwx9H
 NC+nPrIXRPkCC/8JdvUWUshtIQYIVCyBbEPmei2BVqJx5twGc6Fy9OeE4LgOna938SrT Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ute9706ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 02:09:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B629Dx3015666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 02:09:13 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 18:09:11 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v6 0/2] pinctl: qcom: sm4450: Add SM4450 pinctrl driver
Date:   Wed, 6 Dec 2023 10:08:38 +0800
Message-ID: <20231206020840.33228-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LQ8k_V0ipSd67L1PPW-wHPvOyJIU3k7D
X-Proofpoint-ORIG-GUID: LQ8k_V0ipSd67L1PPW-wHPvOyJIU3k7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=698 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM4450 pinctrl driver for support enable uart console.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
v5 -> v6:
  - squash the fixups into the newly added driver
  - drop reviewed-by due to update patch as new comments

v4 -> v5:
  - Convert to platform remove callback returning void
  - correct incorrect address offset

v3 -> v4:
  - update gpio pins pattern

v2 -> v3:
  - update example pieces
  - update gpio pins pattern

v1 -> v2:
  - update right platform name
  - update gpio-reserved-ranges have right maxItems
  - update gpio-line-names have right maxItems
  - add min/maxItems for pins properties
  - redo dt_binding_check check
  - delete reserved gpios setting
  - combine separate pinctrl functions

previous discussion here:
[1] v5: https://lore.kernel.org/linux-arm-msm/20231130024046.25938-1-quic_tengfan@quicinc.com
[2] v4: https://lore.kernel.org/linux-arm-msm/20230920082102.5744-1-quic_tengfan@quicinc.com
[3] v3: https://lore.kernel.org/linux-arm-msm/20230920064739.12562-1-quic_tengfan@quicinc.com
[4] v2: https://lore.kernel.org/linux-arm-msm/20230915015808.18296-1-quic_tengfan@quicinc.com
[5] v1: https://lore.kernel.org/linux-arm-msm/20230908063843.26835-1-quic_tengfan@quicinc.com

Tengfei Fan (2):
  dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
  pinctrl: qcom: sm4450: dd SM4450 pinctrl driver

 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    |  151 +++
 drivers/pinctrl/qcom/Kconfig.msm              |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sm4450.c         | 1014 +++++++++++++++++
 4 files changed, 1174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4450.c


base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
-- 
2.17.1

