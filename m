Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C072E791A76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbjIDPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIDPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:21:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641F7CC3;
        Mon,  4 Sep 2023 08:21:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384De4Z2030606;
        Mon, 4 Sep 2023 15:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=GcLUXjzUdhpweJxHZ5fmA+/tlvPY2Hmed2O/mMfSVQA=;
 b=EOCJ5humHxwCX6OqeD7gAR3gEiR588wQQpjq6YDQsjaLXd/XjwtR0lnFu+aSR4bR/kIu
 WDYeumwgw+V3qclnsaC3/cACsQzfkneMBToIjMoOleOvM903y6J0z3foaZbhfY3lgT80
 L9UgSV4m74RY54grrKJSf+CR/m52Jdy3W2RC7aDRgKPmiNPwpMgPwt0o90Jsc1hfIUPp
 Q5Zqf+VHiVROwwnGJVYtHqJKxgl0KRIdXBBMQ6gxYe4hETTcavjHTZ/13PNqIcb60XGq
 +VRfW6wCcV1woWj5GWD4CFPoEgobinLcJxhTTfy0fGO2FPoWyW1LddoaJ8GfxDo2En9J Dw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suwtpv2h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:21:07 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 384FL35N023832;
        Mon, 4 Sep 2023 15:21:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4k8yq6-1;
        Mon, 04 Sep 2023 15:21:03 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384FL3lS023827;
        Mon, 4 Sep 2023 15:21:03 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 384FL3hn023826;
        Mon, 04 Sep 2023 15:21:03 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 3ED0E504920; Mon,  4 Sep 2023 20:51:02 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V7 0/5] scsi: ufs: qcom: Align programming sequence as per HW spec
Date:   Mon,  4 Sep 2023 20:50:55 +0530
Message-Id: <20230904152100.30404-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AVVZ91rqFeQfQk6sqtr0AdVYWbOWXMB4
X-Proofpoint-GUID: AVVZ91rqFeQfQk6sqtr0AdVYWbOWXMB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_08,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=645
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds programming support for Qualcomm UFS V4 and above
to align avoid with Hardware Specification. This patch series will address
stability and performance issues.

In this patch series below changes are taken care.

1) Register layout for DME_VS_CORE_CLK_CTRL has changed for v4 and above.
2) Adds Support to configure PA_VS_CORE_CLK_40NS_CYCLES attibute for UFS V4
   and above.
3) Adds Support to configure multiple unipro frequencies like 403MHz,
   300MHz, 202MHz, 150 MHz, 75Mhz, 37.5 MHz for Qualcomm UFS Controller V4
   and above.
4) Allow configuration of SYS1CLK_1US_REG for UFS V4 and above.

Changes from v6:
- Addressed bjorn comment to optimize the code.
- Addressed bjorn comment to update commit message
- removed clean up part related for clk div configuration comapared to v6

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

Nitin Rawat (5):
  scsi: ufs: qcom: Update MAX_CORE_CLK_1US_CYCLES for UFS V4 and above
  scsi: ufs: qcom: Add multiple frequency support for
    MAX_CORE_CLK_1US_CYCLES
  scsi: ufs: qcom: Add support to Configure PA_VS_CORE_CLK_40NS_CYCLES
  scsi: ufs: qcom: Align programing of unipro clk attributes
  scsi: ufs: qcom: Configure SYS1CLK_1US_REG for UFS V4 and above

 drivers/ufs/host/ufs-qcom.c | 201 ++++++++++++++++++++++++++++--------
 drivers/ufs/host/ufs-qcom.h |  18 +++-
 2 files changed, 174 insertions(+), 45 deletions(-)

--
2.17.1

