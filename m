Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076687928D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349330AbjIEQYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351606AbjIEFYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:24:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1C1E8;
        Mon,  4 Sep 2023 22:24:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853ethn031037;
        Tue, 5 Sep 2023 05:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9xgGYVRyVTnI6zKARP+VFTNIkbZn9PiwqwxkFDbQpcc=;
 b=eWPxs2K1Ul3AxG5UV3TeCPE0a4lIwb+gInViP0zNr0eDtqVEeotvndxUozwSjve5vJhf
 WmhKrBq7TEq1s4WVsE2SOEc+zlfzUNQ57UpYYxvfQM4zFiLl0y8xWjOUw6Kzd2hfKeoH
 zBlhL4jLE0Fr2hXXaVToPvCB8nDF41Lw0D1BjZmNd2fyGTptoSF7Cr99J3izFeaIX9Zg
 hbXbPc9v1fIXkBUisyMRDapkk5UnPOz7iImKW2v5CcZTGAW9CkKRfO32LGbNm5164jTW
 WYZ0A6t2kp//LIewDdsyL7QXWsWSiz8BaEUPFHDC0VV4xjKsmc2PL5KVT15mZEsEpv8Z 5A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtevgaxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 05:24:07 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3855O4AO029324;
        Tue, 5 Sep 2023 05:24:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sux4kjpur-1;
        Tue, 05 Sep 2023 05:24:04 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3855O3dB029314;
        Tue, 5 Sep 2023 05:24:03 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3855O3bH029312;
        Tue, 05 Sep 2023 05:24:03 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id AFDC0504920; Tue,  5 Sep 2023 10:54:02 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V8 0/5] scsi: ufs: qcom: Align programming sequence as per HW spec
Date:   Tue,  5 Sep 2023 10:53:55 +0530
Message-Id: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vUkqhYdZvTXCb1nP1T9nfdbD0VGtYoUZ
X-Proofpoint-ORIG-GUID: vUkqhYdZvTXCb1nP1T9nfdbD0VGtYoUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=542
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050047
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

Changes From v7:
- Fix the compilation error for kernel doc

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

 drivers/ufs/host/ufs-qcom.c | 202 ++++++++++++++++++++++++++++--------
 drivers/ufs/host/ufs-qcom.h |  18 +++-
 2 files changed, 175 insertions(+), 45 deletions(-)

--
2.17.1

