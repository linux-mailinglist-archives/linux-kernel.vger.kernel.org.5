Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCAB785C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjHWPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjHWPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:44:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F015E70;
        Wed, 23 Aug 2023 08:44:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDDXgW012456;
        Wed, 23 Aug 2023 15:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=MHjQtJmdnklgfC97Z+9qIdhrLaowKL2QnIkLQkzJl7o=;
 b=YaPeytV9JEyP2aGwlqXUrjEui1Sh+L+xdcNTGogtu/ECuOTy52uKKk5jrKtlZ/YUi7gS
 0NNu1ZhMN9OpIZsfut/MZx3+NkL6ljt5IyLxaluyYN3WdM9FxO/OyZKazwgv/juu/J0F
 RYEFE2PnlH+lfiTxo2zv+8AZmO50MlP17Gwi35izCbv1mlFZ3qCfRPs+RqPBOR4NG7N0
 4O9ZoywfMjX/CvS1Hu3KyhkiNmfXwvvirAI7GPwW+OlScnkfcVoOotFWFhSaeN0h5DdT
 ozbqrypNjfXXkl4l/kaQ135gYH9W8mpOnvX3s+/mIh/B76lU/qWdBuUkQLEw7/gESlvw PQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2ext9ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:44:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37NFiGuj029184;
        Wed, 23 Aug 2023 15:44:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptm3qdf-1;
        Wed, 23 Aug 2023 15:44:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NFiGKq029178;
        Wed, 23 Aug 2023 15:44:16 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37NFiG7o029177;
        Wed, 23 Aug 2023 15:44:16 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 576B35000AA; Wed, 23 Aug 2023 21:14:15 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V5 0/6] scsi: ufs: qcom: Align programming sequence as per HW spec
Date:   Wed, 23 Aug 2023 21:14:07 +0530
Message-Id: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4bRYYtqvE5LG8IHvEqPo65NhqpwjjGHP
X-Proofpoint-ORIG-GUID: 4bRYYtqvE5LG8IHvEqPo65NhqpwjjGHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=720
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230142
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aligns programming sequence as per Qualcomm UFS
hardware specification.

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
  scsi: ufs: qcom: Update offset for core_clk_1us_cycles
  scsi: ufs: qcom: Configure PA_VS_CORE_CLK_40NS_CYCLES for Unipro core
    clk
  scsi: ufs: qcom: Add multiple frequency support for unipro clk
    attributes
  scsi: ufs: qcom: Align unipro clk attributes as per Hardware
    specification
  scsi: ufs: qcom: Refactor ufs_qcom_cfg_timers function.
  scsi: ufs: qcom: Handle unipro clk HW division based on scaling
    conditions.

 drivers/ufs/host/ufs-qcom.c | 239 +++++++++++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.h |  15 ++-
 2 files changed, 197 insertions(+), 57 deletions(-)

--
2.17.1

