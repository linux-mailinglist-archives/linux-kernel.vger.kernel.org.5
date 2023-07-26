Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDA7637D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjGZNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjGZNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:42:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FD118;
        Wed, 26 Jul 2023 06:42:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QCVLOk029874;
        Wed, 26 Jul 2023 13:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=A508zSLDoUseatTrtGqMUNqw8gyY6AgzMra67HU3zDg=;
 b=EIpYhdpSgguoXilVblDJrkLdzp3q/c3dsCDzdTU7w7yZrADM2XpBIIKl85ALfVJX/ncW
 hmD2blB2bxSOhHYPyXBBn9lrTKOlqUKPohLiszhbJ9TfWG1GzZMTLQLkT6UtSg5gCb8K
 MTfiNK4Oa/jfSXZWoXSaBuXMzz6Hfk1k+O4UEK8AP6WTBHFxml0qjDi2I1X8DsqxepC6
 SD4D9HRghPaG849euejCZbNPg9iv/FRwEyMyz8/wWHr+qKSxD/OEOpY12Y4PUHap3cDI
 DCGEM2LHlP8Po8aYSIuHO8cxYITBIMDFFQadXeSTzb9f5koJajvhaLImbZBlvM90zHwS EA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2fms2mg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 13:41:48 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36QDfhsl017623;
        Wed, 26 Jul 2023 13:41:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s086kxdvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 13:41:43 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36QDfh7l017614;
        Wed, 26 Jul 2023 13:41:43 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36QDfgbY017595;
        Wed, 26 Jul 2023 13:41:43 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 301455001B7; Wed, 26 Jul 2023 19:11:42 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com, mani@kernel.org,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org
Cc:     quic_ziqichen@quicinc.com, quic_nguyenb@quicinc.com,
        quic_narepall@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V2 0/2] Fix hibern8 enter failure during host reset
Date:   Wed, 26 Jul 2023 19:11:38 +0530
Message-Id: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TvkKdUcu3q5JZYPHcvUrzedI_lwgVsuZ
X-Proofpoint-ORIG-GUID: TvkKdUcu3q5JZYPHcvUrzedI_lwgVsuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=708
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260121
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V1:
- Updated commit description to explain the patch.
- Added Co-developed-by tag.

Nitin Rawat (2):
  scsi: ufs: core: Export ufshcd_is_hba_active
  scsi: ufs: ufs-qcom: check host controller state

 drivers/ufs/core/ufshcd.c   | 3 ++-
 drivers/ufs/host/ufs-qcom.c | 4 ++++
 include/ufs/ufshcd.h        | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

--
2.17.1

