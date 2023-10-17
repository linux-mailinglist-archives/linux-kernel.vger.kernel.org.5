Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7417CBAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjJQGN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjJQGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:13:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558DCAB;
        Mon, 16 Oct 2023 23:13:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H4mdLo016056;
        Tue, 17 Oct 2023 06:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=w1Mol4MP7APj2xbyT9s28I1re0Vh9rW7ZHhQs98Rm90=;
 b=OiIYU1Dqh7gIZ2o5cL370nHrWF/t7z3ZODP2hz5I01dhcce9ZBJGaFOQSojOTG9PM6pj
 bvu2pzQpfWi3izJNFW/BMG87IwWfTWG4P5/1rkyMwKhwLNxHvcx/B2kuRXyIhQ2jrill
 ej+lJF73rY1qHIbqSLscHEhpR4eWIKYgUWPHuYQX6eAVpTdG9UCXeuAlWgVq+KMUz+WC
 fQRtr3jz/u59/ew27Ze3ekJeuO1qw7Lc7OPS1CV+vLdVI3C2eQlYsxgPWrYoBA8BReGO
 lFInd8LlwMCsnRLtxYQ4W7qe6Rn8vA5rnWh5DtReTOXx8HLR6lIrWcmmiAojObDtH2pa 3A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts49wac3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 06:13:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39H6Dicd029560;
        Tue, 17 Oct 2023 06:13:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2m0cbj-1;
        Tue, 17 Oct 2023 06:13:44 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39H6Dixp029555;
        Tue, 17 Oct 2023 06:13:44 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39H6DhKG029554;
        Tue, 17 Oct 2023 06:13:44 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 2978A57132F; Tue, 17 Oct 2023 11:43:43 +0530 (+0530)
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
Subject: [PATCH V3 0/3] mmc: Add partial initialization support
Date:   Tue, 17 Oct 2023 11:43:33 +0530
Message-Id: <20231017061336.9355-1-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ksO7E3iGxCc4HGDtSEFQvulYDgbIc0bl
X-Proofpoint-ORIG-GUID: ksO7E3iGxCc4HGDtSEFQvulYDgbIc0bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=630 bulkscore=0 suspectscore=0 adultscore=0
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

Add the ability to partially initialize the MMC device by
using device sleep/awake sequence (CMD5).
Device will be sent to sleep state during mmc runtime/system suspend
and will be woken up during mmc runtime/system resume.
By using this sequence the device doesn't need full initialization
which gives 25% time reduction in system/runtime resume path.
Also enable this feature along with mmc runtime PM for qualcomm
controllers.

Sarthak Garg (3):
  mmc: core: Add partial initialization support
  mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for Qualcomm controllers
  mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers

 drivers/mmc/core/mmc.c       | 163 +++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-msm.c |   2 +
 include/linux/mmc/card.h     |   4 +
 include/linux/mmc/host.h     |   2 +
 4 files changed, 162 insertions(+), 9 deletions(-)

-- 
2.17.1

