Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC8762237
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGYT2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGYT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:28:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318312D;
        Tue, 25 Jul 2023 12:28:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PCFbb3027925;
        Tue, 25 Jul 2023 19:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=o60ZebcAToibFLytZmxZ6JV7DEy5Az+aLM2CqZAEvPA=;
 b=oVW8dqU4Qr11awqjUlfIJA/MehlVlvjw+QfbSJAFnJOk2f2eZ6YjWqOgCQBvF6fIlWYA
 Xp2dOlUHBQu29GaVmZUTfTtUAoiNhKp/UXodOTrPkpyYUGObRzDT3bi0nREYQVtCHRDU
 Ps7H0OWXkm+8ld4oOCYWuF2YkGHi8qQDhDXoNyVJ+ir4BfcoGFgH8+qSXzGqbct3GawN
 dBZjyB7UyZgeeG+fI4sQTYSCnCfAijO1q8OYzJhXlRxZQfkM5b3M4uNzmEQW6FAe1Ydr
 NCwz9KjgjYiBYFzh4sDFXqDMEf1irVA8Vp5M/fBe5Q1/UC4ZXDANo++ENHHDoKEKMUIk CA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2cf8sb3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:27:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36PJRE1F032629;
        Tue, 25 Jul 2023 19:27:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s086kx1xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 19:27:14 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PJRDED032617;
        Tue, 25 Jul 2023 19:27:13 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36PJRDSe032616;
        Tue, 25 Jul 2023 19:27:13 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id C4A125001B7; Wed, 26 Jul 2023 00:57:12 +0530 (+0530)
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
Subject: [PATCH V1 0/2] Fix hibern8 enter failure during host reset
Date:   Wed, 26 Jul 2023 00:57:08 +0530
Message-Id: <20230725192710.26698-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IDjxQFjw1n2NoutTSBwgCoJkwcNtEprL
X-Proofpoint-GUID: IDjxQFjw1n2NoutTSBwgCoJkwcNtEprL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=907
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250167
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit <52a518019c> ("Fix missing clk change notification on host reset")
added clock scaling notification to ufshcd_host_reset_and_restore.
This invokes hibern8 enter and exit on qualcomm platform which fails
because controller is in reset state.

Fix this by checking the Host controller state before sending
hibern8 command.

__ufshcd_wl_resume()
ufshcd_reset_and_restore()
ufshcd_host_reset_and_restore()
ufshcd_scale_clks()
ufshcd_vops_clk_scale_notify()
ufs_qcom_clk_scale_notify()
ufshcd_uic_hibern8_enter()

Fixes: 52a518019ca1 ("scsi: ufs: core: Fix missing clk change notification on host reset")

Nitin Rawat (2):
  scsi: ufs: core: Export ufshcd_is_hba_active
  scsi: ufs: ufs-qcom: check host controller state

 drivers/ufs/core/ufshcd.c   | 3 ++-
 drivers/ufs/host/ufs-qcom.c | 4 ++++
 include/ufs/ufshcd.h        | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

--
2.17.1

