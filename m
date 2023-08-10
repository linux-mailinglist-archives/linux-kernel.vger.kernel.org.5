Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBEA776E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjHJC0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjHJC0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:26:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9AA2132;
        Wed,  9 Aug 2023 19:26:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A27wbd013577;
        Thu, 10 Aug 2023 02:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qnnfa/E2csSoEJfzcMjz6VRCrhnXshNrlw1QRh2X2YU=;
 b=ggcipcEMktPwU5XxEfwvspOlXm1GSbPGBkV62okWvwekGlEeh8zs06blBJnFiDCdVnmV
 aV9YqxdBB+gdOLekoGwIZzwLhVQxDbuUzQWqs42P6D0nzDJMLEd12Jff62ghp1uofjAt
 Mq7pgDUlNstjyAwjZUGEhY947db1qkZtHPeANXejQUka0cHuRxu0yAmmpX/fyAZDDGbW
 ie3iTVh0efBPqx5/TvAJePMcNPqFuxJUh4kfoaHppUI2hIM86/JDHecTi9oelHV0cmHv
 X7cwpdVd9WCw3gXXqGCEZeqCbDAUx4YOOTJYLeis3qwtekqGO53A+nY3zyn0rfNFJEVz Tg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbcghbrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:26:03 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A2Q0Jd008904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:26:00 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 19:25:56 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of codecs within range
Date:   Thu, 10 Aug 2023 07:55:04 +0530
Message-ID: <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZYW-dGODzw6ay9RIlfUHdLJyQ7XjRCKE
X-Proofpoint-ORIG-GUID: ZYW-dGODzw6ay9RIlfUHdLJyQ7XjRCKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_01,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=925 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supported codec bitmask is populated from the payload from venus firmware.
There is a possible case when all the bits in the codec bitmask is set. In
such case, core cap for decoder is filled  and MAX_CODEC_NUM is utilized.
Now while filling the caps for encoder, it can lead to access the caps
array beyong 32 index. Hence leading to OOB write.
The fix counts the supported encoder and decoder. If the count is more than
max, then it skips accessing the caps.

Cc: stable@vger.kernel.org
Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 9d6ba22..c438395 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,9 @@ static void init_codecs(struct venus_core *core)
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
+		return;
+
 	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
 		cap = &caps[core->codecs_count++];
 		cap->codec = BIT(bit);
-- 
2.7.4

