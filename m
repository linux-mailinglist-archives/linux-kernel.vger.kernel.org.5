Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8BD78FC86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349250AbjIALot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjIALop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:44:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E26E10F0;
        Fri,  1 Sep 2023 04:44:05 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3819roS4018982;
        Fri, 1 Sep 2023 11:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=hGIutL91aY9hwSH+dPE+AwLowgqEpYAT7pl1HJrZzqc=;
 b=OdVCR6BuHLFtT91rEcRd+BTeqtCRI7XSUzPPKPzMmLV9HZB1x1ur9cf/VZ0y8XODxjDl
 efX8OBwqn60+QL9mEq/8wFEH7L5gElAeOltQAaJUSTVBytridnqq4n3cV58pBdssHDmd
 sGc6B+EMVlfh/f1FKlKoePgCkrHdwYDmpBKOqX/aeleuqxBSbiIMKZ6w1P/24A9WUZg/
 9CnJqUvH3sC4OQBycVwkGgoz5P0fF2RRYsNlxBPwYe71x1eeUqp+FCxrzLg0UdTmdHRF
 +19SCKD6A0WPnNwBxC69BhuZZiyOOPU+mVFk7wtgSMOK2571cjIJHaxkXxkXdXxI0IHh uQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stxru25fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:43:42 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381BgmW0013919;
        Fri, 1 Sep 2023 11:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj07s-1;
        Fri, 01 Sep 2023 11:43:39 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381BhdDN014633;
        Fri, 1 Sep 2023 11:43:39 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381BhciP014631;
        Fri, 01 Sep 2023 11:43:39 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 1F04D5006A6; Fri,  1 Sep 2023 17:13:38 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V6 0/6] scsi: ufs: qcom: Align programming sequence as per HW spec
Date:   Fri,  1 Sep 2023 17:13:30 +0530
Message-Id: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EmmXpl895BONTr1nmDq17SnUq4knYSYM
X-Proofpoint-ORIG-GUID: EmmXpl895BONTr1nmDq17SnUq4knYSYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=894 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010109
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aligns programming sequence as per Qualcomm UFS
hardware specification.

changes from v5:
- Addressed Mani comment to FIELD_PREP and FIELD_FIT.
- Optimised ufs_qcom_set_core_clk_ctrl API.
- Updated commit text for few patches to capture more details.

Changes from v4:
- Addressed bjorn comment to split single patch to multiple patches.

Changes from v3:
-Addressed bjorn comment to update commit msg to capture change details.

Changes from v2:
- Addressed bao comment, removed duplicate clock timer cfg API call

Changes from v1:
- Addressed bao comment, removed wrapper function
- Tab alignment

Nitin Rawat (6):
  scsi: ufs: qcom: Align mask for core_clk_1us_cycles
  scsi: ufs: qcom: Configure PA_VS_CORE_CLK_40NS_CYCLES
  scsi: ufs: qcom: Add multiple frequency support for unipro clk
    attributes
  scsi: ufs: qcom: Align unipro clk attributes configuration as per HPG
  scsi: ufs: qcom: Refactor ufs_qcom_cfg_timers function.
  scsi: ufs: qcom: Configure clk HW division based on scaling
    conditions.

 drivers/ufs/host/ufs-qcom.c | 240 ++++++++++++++++++++++++++----------
 drivers/ufs/host/ufs-qcom.h |  17 ++-
 2 files changed, 193 insertions(+), 64 deletions(-)

--
2.17.1

