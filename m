Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0171C7644F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjG0Eft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjG0Efd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:35:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B6272A;
        Wed, 26 Jul 2023 21:35:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R1mRuk022937;
        Thu, 27 Jul 2023 04:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2wBdUaXhNzrcFd2UG4094FY4Y70VgA2XSY6v7mCJfYw=;
 b=ETbvo18XOzcrZvygoCSbh3yGhcGBHQfYHyHgkiCzxI7BO9vE8pruSaCaf2/x7EjreSnw
 j8N0o4XpncjpbKOUarH//K0zPP9WIVXE5Y6R5X7CtYzaQQNwrFT3gY0HoKAiiMAgmIPl
 8uJo5aBFDTdXH1hMt1LQDg+Gd1R+4xuseQ45uoxeQLlFu+ibDKDdOL8/a46v0H/H6p/o
 R7UT52S0idoTSC8P1jCjj4MRKXTUi+CMkiEIDCigTf/sjieOaEIqiHw6ybPkfSP+Nnlh
 GERLeEK4KLw4MzZrZ46zHv2R6KYY0XOvCh5p36q9P6T6n0n0PjGZYsGOLPjez/ENRhvE Iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s32jn1ska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:35:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R4ZICY025392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:35:18 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 21:35:14 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 3/4] venus: hfi: add checks to handle capabilities from firmware
Date:   Thu, 27 Jul 2023 10:04:28 +0530
Message-ID: <1690432469-14803-4-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-GUID: crV8lj0M-rFuQBATbimxwSFN5eCMKp_3
X-Proofpoint-ORIG-GUID: crV8lj0M-rFuQBATbimxwSFN5eCMKp_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The hfi parser, parses the capabilities received from venus firmware and
copies them to core capabilities. Consider below api, for example,
fill_caps - In this api, caps in core structure gets updated with the
number of capabilities received in firmware data payload. If the same api
is called multiple times, there is a possibility of copying beyond the max
allocated size in core caps.
Similar possibilities in fill_raw_fmts and fill_profile_level functions.

Cc: stable@vger.kernel.org
Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 6cf74b2..ec73cac 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -86,6 +86,9 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 {
 	const struct hfi_profile_level *pl = data;
 
+	if (cap->num_pl > HFI_MAX_PROFILE_COUNT)
+		return;
+
 	memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
 	cap->num_pl += num;
 }
@@ -111,6 +114,9 @@ fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 {
 	const struct hfi_capability *caps = data;
 
+	if (cap->num_caps > MAX_CAP_ENTRIES)
+		return;
+
 	memcpy(&cap->caps[cap->num_caps], caps, num * sizeof(*caps));
 	cap->num_caps += num;
 }
@@ -137,6 +143,9 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 {
 	const struct raw_formats *formats = fmts;
 
+	if (cap->num_fmts > MAX_FMT_ENTRIES)
+		return;
+
 	memcpy(&cap->fmts[cap->num_fmts], formats, num_fmts * sizeof(*formats));
 	cap->num_fmts += num_fmts;
 }
@@ -159,6 +168,9 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		rawfmts[i].buftype = fmt->buffer_type;
 		i++;
 
+		if (i >= MAX_FMT_ENTRIES)
+			return;
+
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

