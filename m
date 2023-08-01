Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86776A951
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjHAGkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHAGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:40:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624C98;
        Mon, 31 Jul 2023 23:40:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37157E6Z014917;
        Tue, 1 Aug 2023 06:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=3WP82ESlPGg/bfk6gvQRhFnAXHPs/eyjVLNLE8TvaG0=;
 b=T+e+lsVcxbJSUb0zX7+qVB5wFZDG6XnLkKnjNh2cwruQ0Z6u95d76ZgR063QmXcr7gzv
 IxVhjwn1/KsCADAGY+7afMLYKCg3+6AoODMSfbVR5D2Oa8IlkMS2qO9QO7Jo/H9xcSFG
 sya/PpylgGF6mTT3/XlHoH8ktaGaWERNWn13eyj6fpjFE+GINjuzBuWMZwWUgNwqPAdD
 VAMsmSaYJsVioSl1JJbj0af3K/lYOvTmcKTB5LQFu4ziMFbb4loyS/xn84Cem43vAszk
 dZ/jRaU/aPeaZ47o3PFV4+6e4/iv9DaZj6NuHir7CfvAtAPH0Zh+pa8Ovv/MGDeGuxQG 6A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d61jch9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 06:40:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3716ek98014455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 06:40:46 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 23:40:42 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v6 0/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
Date:   Tue, 1 Aug 2023 12:10:23 +0530
Message-ID: <20230801064025.17381-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SdF540jN4-QPgo64ws2kY9elI3pSavLD
X-Proofpoint-ORIG-GUID: SdF540jN4-QPgo64ws2kY9elI3pSavLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=699 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6 -
 - Removed '|' from description in binding.
 - Removed the header inclusion under the example in the binding.
 - Removed devm_pm_runtime_enable() api as there is no pm runtime handlers or users
   in this driver as of now.
 - Not keeping Bjorn's reviewed tag as removing the above mentioned api.

Changes in v5 -
 - Separating this from original series [1].
 - Added description of driver to secure qfprom binding.
 - Replaced pm_runtime_enable() withh devm_pm_runtime_enable().
 - Changed module license to GPL instead of GPL v2.

This series introduces a new driver for reading secure fuse region and adding
dt-bindings for same.

[1] https://lore.kernel.org/linux-arm-msm/20230623141806.13388-1-quic_kbajaj@quicinc.com

Komal Bajaj (2):
  dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
  nvmem: sec-qfprom: Add Qualcomm secure QFPROM support

 .../bindings/nvmem/qcom,sec-qfprom.yaml       |  58 ++++++++++
 drivers/nvmem/Kconfig                         |  13 +++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/sec-qfprom.c                    | 101 ++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
 create mode 100644 drivers/nvmem/sec-qfprom.c

-- 
2.41.0

