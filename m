Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03F7644E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjG0EfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjG0EfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:35:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3E2704;
        Wed, 26 Jul 2023 21:35:03 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R48XvA013662;
        Thu, 27 Jul 2023 04:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZMQ682HHLhMyrGe37gS8Chm+Rhi4J/2foIKcYpm9+Rc=;
 b=L1kpfyKQw5U8fayHcbebr60EnHOgqDeKt3EvtDJFzRbvixbSfKsIzSb+DrxANfrFen8S
 jlajwxopwuhTGK89a55qZv5BKW0LdATtKMnmorQylnlZTkD9CXFQkVn36jbQKjxlaYzI
 R/w2Qw+GQXxZCmpi9kO5wHzZdu2iSfklpPwlNjymPsB2QYSQpUfKDpIVUnREVnFEB1db
 MX681vAjlxfygQHMrF1j03rZd+pRMCjZKlPUcuDj+vBNLYWQs7IyUR3DnT+29vSP6lz3
 RNgtDGIPRYj9RCyPFdgjLU5ssmCWzbMeBBqL5ZkbceoKv2D36tO6nINCrikX1+kROikW dg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3afyrnrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:34:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R4Yunq002389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:34:56 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 21:34:52 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 0/4] Venus driver fixes to avoid possible OOB accesses 
Date:   Thu, 27 Jul 2023 10:04:25 +0530
Message-ID: <1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _neKvULE_FctP6fzXaHy8P3lvTEpmNDI
X-Proofpoint-ORIG-GUID: _neKvULE_FctP6fzXaHy8P3lvTEpmNDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=922
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series primarily adds check at relevant places in venus driver where there
are possible OOB accesses due to unexpected payload from venus firmware. The
patches describes the specific OOB possibility.

Please review and share your feedback.

Vikash Garodia (4):
  venus: hfi: add checks to perform sanity on queue pointers
  venus: hfi: fix the check to handle session buffer requirement
  venus: hfi: add checks to handle capabilities from firmware
  venus: hfi_parser: Add check to keep the number of codecs within range

 drivers/media/platform/qcom/venus/hfi_msgs.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c | 27 ++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_venus.c  |  8 ++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

