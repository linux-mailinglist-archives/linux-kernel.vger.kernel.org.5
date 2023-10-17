Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67777CBAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjJQGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjJQGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:13:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91ECAB;
        Mon, 16 Oct 2023 23:13:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H4qhHo013255;
        Tue, 17 Oct 2023 06:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CUQyzaS/rAzu/i//gN/H3XFAidpt6/VMRPrMfGI20Zw=;
 b=KNEOJtIvJAA8UyOirlkHCY18PZDnWVaUoZ29A+J3iTq89lQxJDokVECHI42mvnon5odO
 mYXqLSplcaKoleEvA/177fy0ouWyC3utunKip0H6ZgB3euBeDOZQRrq90JqYWf79V7KJ
 avWJ0F8W7dtIA8HODe9CF1ZKz7CLgOg/mvN2G7JFk233q+0B3ktlZPcccJtSvZJyUexV
 Dwui9YE9rdR7UIhCn8ksp31ZP/4LlOqUTdFOzL80XYKN64o+wdrZnCBea8ONwEReLlmk
 1B44CDfUMmhs4B2byKP+LLgB+BeVsSux9FwpnET9qzJjfUi3qpSTaZ5FVLulSf6jebFU qg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaf0s7ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 06:13:51 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39H6DlAO029592;
        Tue, 17 Oct 2023 06:13:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2m0cc5-1;
        Tue, 17 Oct 2023 06:13:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39H6DmIT029600;
        Tue, 17 Oct 2023 06:13:48 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39H6DlWo029599;
        Tue, 17 Oct 2023 06:13:48 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 59EBF57132F; Tue, 17 Oct 2023 11:43:47 +0530 (+0530)
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
Date:   Tue, 17 Oct 2023 11:43:36 +0530
Message-Id: <20231017061336.9355-4-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017061336.9355-1-quic_sartgarg@quicinc.com>
References: <20231017061336.9355-1-quic_sartgarg@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rCLz6Mac_WWNiJ_Lp2mQv3xIOlHvUHAA
X-Proofpoint-ORIG-GUID: rCLz6Mac_WWNiJ_Lp2mQv3xIOlHvUHAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=959 malwarescore=0
 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170049
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

