Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB72776DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHJCZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJCZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:25:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3A41999;
        Wed,  9 Aug 2023 19:25:48 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A0hVGt000399;
        Thu, 10 Aug 2023 02:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=QLPvBN7d9PMpt4rx2AO6LBiTmpVLVOKiVm9TDrvteC4=;
 b=chTQuSWutgMpsfP0716lxuBiWuV53aEV9+X+sqDu8Fcn/dLdm8Yrw4Z9r9dcyHmVSNsU
 teQVCfKrO7ZvCp8+9B+Ti+0VZ2hS97+VZDHht4jeln1fH3jb67d8othLxvtnFN/tqZ9r
 Vx2ZX4kDF8R4Kn7Jg+6AOcL2qd/DQYaRa+91JEW4upHAOx+mEcaq2/M9dHgFC0LPfYKs
 EqhQvKcV5TdLsTnrXXPlxNFP2MC4NOdH2huOXy0WmKhSIBFNOPZh+v2201OMN2QdfMMM
 jaweCbOPbADRupr8KPY4r/XG86GbnJ3UXmWDQMDe1v5pnX4sqrQXbhJl3WQMAGlrFGzh /A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbmrqm84h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:25:32 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A2PVMX019256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:25:31 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 19:25:27 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH v2 0/4] Venus driver fixes to avoid possible OOB accesses
Date:   Thu, 10 Aug 2023 07:55:00 +0530
Message-ID: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kvjiKjLyg4Jcm8Xj7C-u7VaQal2D_s4J
X-Proofpoint-ORIG-GUID: kvjiKjLyg4Jcm8Xj7C-u7VaQal2D_s4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_01,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=933
 impostorscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
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

v1 -> v2:
- Address the comment to reduce size of queue pointer from queue size
- Consider the data size during memcpy to avoid OOB write
- Use hweight_long() to count the setbits representing the supported codecs

v1: https://lore.kernel.org/all/1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com/

This series primarily adds check at relevant places in venus driver where there are possible OOB
accesses due to unexpected payload from venus firmware. The patches describes the specific OOB
possibility.

Please review and share your feedback.

Vikash Garodia (4):
  venus: hfi: add checks to perform sanity on queue pointers
  venus: hfi: fix the check to handle session buffer requirement
  venus: hfi: add checks to handle capabilities from firmware
  venus: hfi_parser: Add check to keep the number of codecs within range

 drivers/media/platform/qcom/venus/hfi_msgs.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c | 15 +++++++++++++++
 drivers/media/platform/qcom/venus/hfi_venus.c  | 10 ++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.7.4

