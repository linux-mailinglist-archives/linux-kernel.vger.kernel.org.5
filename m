Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A967644EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjG0Ef3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjG0EfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:35:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C76273C;
        Wed, 26 Jul 2023 21:35:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R3V0jd016054;
        Thu, 27 Jul 2023 04:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TugPb8tl9hbltjc7Ww0SHgYRqILvgjkw9uxYmp0Uq7Q=;
 b=MDo51uIFfI3fX9en1fAijIkp3Pv1Lixmo/hf1KtNdUQthWxiYVl17kOqf+PxUYNxxJJo
 IcH7kbYXShS8oKjqnHj/rbsPfm8QBjjPSCfYjeiA1tHnsXQ87IwPQj5Cu0EcAwn5q7Le
 Iiiz7/iOc3MAAuE+MqUf4HdG1wjvOMaEUos6Fw5SEFVspb7qsAp3LZwFGbvgFLdaMpd4
 0f2yad5xxp7dC87Ss6rIyAcnFrnBCeVNjnhXcYhRUp37gsorpxKPmiF9FcKCzFBs2FSQ
 VGopKHjm0uTejANgxRa6qkdA0TJt6TeFmOo04ueABs4fc4WNAMA55+zYu2y2WUqejw8k 3w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3f580825-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:35:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R4ZDUS025350
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:35:13 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 21:35:09 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 2/4] venus: hfi: fix the check to handle session buffer requirement
Date:   Thu, 27 Jul 2023 10:04:27 +0530
Message-ID: <1690432469-14803-3-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b-hCZTY-WtDIXt4maahSGWkjvnuP0rRk
X-Proofpoint-ORIG-GUID: b-hCZTY-WtDIXt4maahSGWkjvnuP0rRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=982 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer requirement, for different buffer type, comes from video firmware.
While copying these requirements, there is an OOB possibility when the
payload from firmware is more than expected size. Fix the check to avoid
the OOB possibility.

Cc: stable@vger.kernel.org
Fixes: 09c2845e8fe4 ("[media] media: venus: hfi: add Host Firmware Interface (HFI)")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_msgs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 3d5dadf..3e85bd8 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -398,7 +398,7 @@ session_get_prop_buf_req(struct hfi_msg_session_property_info_pkt *pkt,
 		memcpy(&bufreq[idx], buf_req, sizeof(*bufreq));
 		idx++;
 
-		if (idx > HFI_BUFFER_TYPE_MAX)
+		if (idx >= HFI_BUFFER_TYPE_MAX)
 			return HFI_ERR_SESSION_INVALID_PARAMETER;
 
 		req_bytes -= sizeof(struct hfi_buffer_requirements);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

