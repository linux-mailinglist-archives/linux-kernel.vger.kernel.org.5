Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116D97CEF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjJSFqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjJSFqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:46:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6339113;
        Wed, 18 Oct 2023 22:46:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J46XtH025115;
        Thu, 19 Oct 2023 05:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CUQyzaS/rAzu/i//gN/H3XFAidpt6/VMRPrMfGI20Zw=;
 b=GG384XzD7Kz4ZbMxclb9rUGf7IexjRTKzGV5/2h0Mis6FGFYscEGoE181ky4EuG6VY9y
 M6VQvbPcAO3zSmhExXcczAiNQtgrsfSkfLLwTYsD64s/sgtzFr1ztmhRUtrcohVm506z
 d7GWij5J5T14NOQZ0rzG41AF2qiT4zYCfByRh5xmIGCcZpmoGc+CbMq8gjTLPXyioIkl
 +qVnk0W16I6mCIGkMnClmppysHiSqPwBTr9wvQUfnuQj57zw7Pb+WvD5fdDHaQeZPYai
 5/6JJYjzUdrejJFMkHNpV0j2va34G8x2Oj5nImvYRHLe/BOlBAicuQYhDYUC+0tEECPZ Xw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt6mw34w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 05:46:22 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39J5kJS3012592;
        Thu, 19 Oct 2023 05:46:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2mbdph-1;
        Thu, 19 Oct 2023 05:46:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J5kIYU012566;
        Thu, 19 Oct 2023 05:46:19 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39J5kIPi012564;
        Thu, 19 Oct 2023 05:46:19 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 522FC5714EA; Thu, 19 Oct 2023 11:16:18 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
        kernel@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: [PATCH V3 3/3] mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers
Date:   Thu, 19 Oct 2023 11:16:12 +0530
Message-Id: <20231019054612.9192-4-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
References: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c1DqPkXGYZnRvU7NdplHJu0mvwWkDGHA
X-Proofpoint-GUID: c1DqPkXGYZnRvU7NdplHJu0mvwWkDGHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_04,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxlogscore=958 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190049
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers to let them use
sleep/awake functionality for faster eMMC resume instead of
doing full initialization.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 93c662e28b3b..edcf18c02bf7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2628,6 +2628,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 	msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
+	msm_host->mmc->caps2 |= MMC_CAP2_SLEEP_AWAKE;
 
 	/* Set the timeout value to max possible */
 	host->max_timeout_count = 0xF;
-- 
2.17.1

