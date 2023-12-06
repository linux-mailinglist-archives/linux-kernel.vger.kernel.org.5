Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855CD8073B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379190AbjLFPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379179AbjLFPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:33:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2816AD53;
        Wed,  6 Dec 2023 07:33:09 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6EmDkd017392;
        Wed, 6 Dec 2023 15:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0+v0957d/kN/+y6AuFwlRdrAVFEWQc7Iw4PbjfhpUuo=;
 b=fkWBZvX38Y2i/BPC+otfpnZw+9GG9YDHOZ2j4zXH1NDvoeRK6rG1phRi4zZ5/4Ebr3bP
 ifkovyRtwJ8T/+jikrDmoH4FxH2Ul0fOB0X8Td4m+4LhLNGgLAA9w6sCIYz2RIKFVOAn
 35sguuV2dby6BQQPcOmCp8X7k+L3JF2DOiPw86FKo5vufyxsGFrAoCQGYqglbYS2UDV1
 rBZ2tU4Kj9huXEXhLUz5nhnRH5QiuQcQtVuXXlL4QkFGqvRqAPkYI1PMyFO/PpA64wA5
 7s3zpdPMlE7ZFwbJdEoar6evTvIRoPVHKilec240GL5aq/jzP5jfCWIMKS3665HcS5bY uQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd1n26g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 15:33:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6FX2AW016825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 15:33:03 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 07:33:00 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Atul Dhudase" <quic_adhudase@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
Date:   Wed, 6 Dec 2023 21:02:51 +0530
Message-ID: <1701876771-10695-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: idjTlTrYVDf8G4Ni8LTz4fqmx6caulYF
X-Proofpoint-GUID: idjTlTrYVDf8G4Ni8LTz4fqmx6caulYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_13,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312060125
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atul Dhudase <quic_adhudase@quicinc.com>

Commit c14e64b46944 ("soc: qcom: llcc: Support chipsets that can
 write to llcc") add the support for chipset where capacity based
allocation and retention through power collapse can be programmed
based on content of SCT table mentioned in the llcc driver where
the target like sdm845 where the entire programming related to it
is controlled in firmware. However, the commit introduces a bug
where capacity/retention register get overwritten each time it
gets programmed for each slice and that results in misconfiguration
of the register based on SCT table and that is not expected
behaviour instead it should be read modify write to retain the
configuration of other slices.

This issue is totally caught from code review and programming test
and not through any power/perf numbers so, it is not known what
impact this could make if we don't have this change however,
this feature are for these targets and they should have been
programmed accordingly as per their configuration mentioned in
SCT table like others bits information.

This change brings one difference where it keeps capacity/retention
bits of the slices that are not mentioned in SCT table in unknown
state where as earlier it was initialized to zero.

Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2: https://lore.kernel.org/lkml/20231103105712.1159213-1-quic_adhudase@quicinc.com/
 - Rewritten the commit text based on feedback in v1
 - Aligned the lines in the code.

 drivers/soc/qcom/llcc-qcom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index fb4085b7cb19..57d47dcf11b9 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -941,15 +941,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 		u32 disable_cap_alloc, retain_pc;
 
 		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
-		ret = regmap_write(drv_data->bcast_regmap,
-				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
+					 BIT(config->slice_id), disable_cap_alloc);
 		if (ret)
 			return ret;
 
 		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
 			retain_pc = config->retain_on_pc << config->slice_id;
-			ret = regmap_write(drv_data->bcast_regmap,
-					LLCC_TRP_PCB_ACT, retain_pc);
+			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
+						 BIT(config->slice_id), retain_pc);
 			if (ret)
 				return ret;
 		}
-- 
2.7.4

