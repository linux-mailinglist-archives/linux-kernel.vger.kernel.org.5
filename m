Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036D578FC69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbjIALnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjIALnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:43:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D211B5;
        Fri,  1 Sep 2023 04:42:59 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381AP0Ni014467;
        Fri, 1 Sep 2023 11:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=hGIutL91aY9hwSH+dPE+AwLowgqEpYAT7pl1HJrZzqc=;
 b=EcCAS+DWPQghb7BM4FSzBO37GzOllpgzHptdHYWn2vZFn1v0nSbnZMaosRikXhr7wVIe
 sdBbXXeE9oIMFqXCwlqP21G2U/MOUeVlRj9/Kmiq3O6lUGNjnN+mf/Oa4axRQf12js8X
 zjm5oaXz1YrZO33M/b4cUUsPcoVMvXPAimDgJdI1LGiKrgfu9xgr19jFQOxvoZgbhvVO
 tTZ120C/LsKzADpb4W1Fa9dDf+T0AEjPRi45fPo7vM0nT6nS9+zhhCv6B7zDSCUl/vZA
 DXkXNb9VbDox9WLJ+7nQqmosrhQMEjhrT54ke8xwYeF83hINu/6KNB3sF5fDWpCZCLva Wg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stku2br46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:42:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381BgmjA013920;
        Fri, 1 Sep 2023 11:42:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj03q-1;
        Fri, 01 Sep 2023 11:42:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381BglhD013913;
        Fri, 1 Sep 2023 11:42:47 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381BglS4013912;
        Fri, 01 Sep 2023 11:42:47 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id E8F735006A6; Fri,  1 Sep 2023 17:12:46 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V6 0/6] scsi: ufs: qcom: Align programming sequence as per HW spec
Date:   Fri,  1 Sep 2023 17:12:36 +0530
Message-Id: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j5M9jHuAG9BFFt7Hgfx4NshadS9g6rwm
X-Proofpoint-ORIG-GUID: j5M9jHuAG9BFFt7Hgfx4NshadS9g6rwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010109
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

