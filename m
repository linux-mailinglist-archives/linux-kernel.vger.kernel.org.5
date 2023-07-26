Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEB7637D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjGZNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjGZNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:42:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14133118;
        Wed, 26 Jul 2023 06:42:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QD1f6B032532;
        Wed, 26 Jul 2023 13:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=v3fJG4hcwnQVClC9EqYXRi1q8buYQM/N3AKD0PIMSv8=;
 b=nPqdlHybAlxKpVTFKcgta9RsIPtkRZ+JZdH2nRyLP6iyf0RJkwb7uyRCQLDmbtZMOTuT
 zLST+rj/Yg5ZZeyLOBbRUEnRoJhD/ORrZ80QB+rFY4ZghJV+kipmwvnVcwzIVyNwq+ct
 kC4ZGnDUwrjznSQtnc3+WdCwjAqLBhn2qLvombXEmxxoYQ/76198STiIShHXSq6A5mTP
 dkPznSu9hvQ0ec6ObV40shfmkajprwTpPFdyoZGSQ/NkOl5punSz7MGaq7snauHhGSSF
 72PLOV9elvUOIQF5OF+XRY9Jc6ehKz1ByzawKumCY/yM5V0my77pf78rrCpwxw/Y1wms hA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2fms2mg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 13:41:48 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36QDfjqQ017649;
        Wed, 26 Jul 2023 13:41:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s086kxdvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 13:41:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36QDfi8M017644;
        Wed, 26 Jul 2023 13:41:44 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36QDfigO017642;
        Wed, 26 Jul 2023 13:41:44 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id E85455001B7; Wed, 26 Jul 2023 19:11:43 +0530 (+0530)
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
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: [PATCH V2 2/2] scsi: ufs: ufs-qcom: check host controller state
Date:   Wed, 26 Jul 2023 19:11:40 +0530
Message-Id: <20230726134140.7180-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
References: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qZ1nNmFTooGi6Xevl3uv6A18fTLficFb
X-Proofpoint-ORIG-GUID: qZ1nNmFTooGi6Xevl3uv6A18fTLficFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
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

Commit <52a518019ca1> (Fix missing clk change notification) added UFS
clock scaling notification to ufshcd_host_reset_and_restore. This
invokes hibern8 enter and exit on qualcomm platform which fails because
controller is in reset state.

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

Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8d6fd4c3324f..95412e98a598 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1254,6 +1254,10 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
 	int err = 0;

+	/* check the host controller state before sending hibern8 cmd */
+	if (!ufshcd_is_hba_active(hba))
+		return 0;
+
 	if (status == PRE_CHANGE) {
 		err = ufshcd_uic_hibern8_enter(hba);
 		if (err)
--
2.17.1

