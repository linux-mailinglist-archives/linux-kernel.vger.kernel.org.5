Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2157E01F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbjKCK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjKCK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:58:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F38D42;
        Fri,  3 Nov 2023 03:58:01 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3AT90C027808;
        Fri, 3 Nov 2023 10:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=4ZKPEwIL60Kky4JhFsXaBH4NbcdaBJSYfiUyyX8ABJM=;
 b=WjTFGuRs0iEmhFgIn/Sac2uAnJLvspIIbVTnPVo/rF++cSFuV2sDXFI1ZUcDvVg7BY0v
 SrQbLuMh7l/eOZ/IW0WFss5XE9uSHbsVFVQTUR0XXZtY0qBhR786UmRwQC5wyV0Q2p67
 842fcoLIbigiOTiKGQHecE0zHqUmLSPjDj/ZmKxtFf6rjfe03OOARamXYUklTaECIyHE
 +MsefgkEjgw7paYQ8t3V5rEY+EuUNTkz8drfanJfsDGMdMHDIybNkHhx/LlL1fF2KIky
 +cYgBJQUu/NNuRnlmddPWEp3fYJduEdw+yYuZqs0TSltHJoTyqstw3qpafa4Jf7dlaef wg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4rev8ts8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 10:57:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A3AvQpU006334;
        Fri, 3 Nov 2023 10:57:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3u0ucm1wb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 10:57:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3AvQ0x006328;
        Fri, 3 Nov 2023 10:57:26 GMT
Received: from hyd-e160-a01-1-07.qualcomm.com (hyd-e160-a01-1-07.qualcomm.com [10.147.154.235])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3A3AvPPc006326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 10:57:26 +0000
Received: by hyd-e160-a01-1-07.qualcomm.com (Postfix, from userid 67733)
        id 053BBB91; Fri,  3 Nov 2023 16:27:25 +0530 (IST)
From:   Atul Dhudase <quic_adhudase@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        swboyd@chromium.org, isaacm@codeaurora.org, dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Atul Dhudase <quic_adhudase@quicinc.com>
Subject: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
Date:   Fri,  3 Nov 2023 16:27:12 +0530
Message-Id: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nWDxns4Kdfx8Ry8s96mSFQvdPcOhoajM
X-Proofpoint-ORIG-GUID: nWDxns4Kdfx8Ry8s96mSFQvdPcOhoajM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=793
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030090
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While programming dis_cap_alloc and retain_on_pc, set a bit
corresponding to a specific SCID without disturbing the
previously configured bits.

Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 674abd0d6700..509d972c1bd9 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 		u32 disable_cap_alloc, retain_pc;

 		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
-		ret = regmap_write(drv_data->bcast_regmap,
-				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
+				BIT(config->slice_id), disable_cap_alloc);
 		if (ret)
 			return ret;

 		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
 			retain_pc = config->retain_on_pc << config->slice_id;
-			ret = regmap_write(drv_data->bcast_regmap,
-					LLCC_TRP_PCB_ACT, retain_pc);
+			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
+					BIT(config->slice_id), retain_pc);
 			if (ret)
 				return ret;
 		}
--
2.25.1

