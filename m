Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58CC7CEF43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjJSFq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjJSFq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:46:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9816EFE;
        Wed, 18 Oct 2023 22:46:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J4Hbhs014936;
        Thu, 19 Oct 2023 05:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=km7gRm6ACx7rG9KHiLRmqXBTSfodBjht7cy64SlbqLE=;
 b=JNJE29d0RMFjS+alfNDxVVwE0AH4vYmyDOUxASG8BKvG6O/EFAFHRA/4xzEX1MsstEwp
 LYdmuRd0m/EelgEhx2TURy2bRin1v3itt7GxyBLhwVaW/qx7d3XyHKwG9qQKURi2fI/f
 z5gZwiouPxOgT9908tYaOydWx9nulyHswoNs88BHnHO4seESejRHATQKgXEBXoos8yi2
 DD26Cu0HF9hvaHWJSBJR9MON1E+vbJVObYE3bKZfCI+qF6c649hCqSjwBL3AeXnm5hFs
 ZD+kaLw/wVstl/PIuAvpxgOgATnQ3OM7rv4UxzxKBMzrDoVGE0HApIlp94SXEwp2sqlW rw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt6mw34w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 05:46:19 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39J5kGtn012544;
        Thu, 19 Oct 2023 05:46:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2mbdnx-1;
        Thu, 19 Oct 2023 05:46:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J5kFaD012539;
        Thu, 19 Oct 2023 05:46:15 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39J5kF4O012534;
        Thu, 19 Oct 2023 05:46:15 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 87EBB52E7D9; Thu, 19 Oct 2023 11:16:14 +0530 (+0530)
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
Date:   Thu, 19 Oct 2023 11:16:09 +0530
Message-Id: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PV7BijeHiYumJN0XrvbEgXGZsGHaNMnB
X-Proofpoint-GUID: PV7BijeHiYumJN0XrvbEgXGZsGHaNMnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_04,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxlogscore=554 phishscore=0 adultscore=0 malwarescore=0
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

Add the ability to partially initialize the MMC device by
using device sleep/awake sequence (CMD5).
Device will be sent to sleep state during mmc runtime/system suspend
and will be woken up during mmc runtime/system resume.
By using this sequence the device doesn't need full initialization
which gives 25% time reduction in system/runtime resume path.
Also enable this feature along with mmc runtime PM for qualcomm
controllers.

Changes since V2:
	- Fixed one warning reported by kernel test robot.
	  >> drivers/mmc/core/mmc.c:1975: warning: Function parameter
	  or member 'host' not described in 'mmc_sleepawake'
	- Included name of the subystem/driver in the title of the
	  series as suggested by Bryan O'Donoghue.
	- Enabled MMC_CAP_AGGRESSIVE_PM for qualcomm controller and
	  posted as [V3,3/3] as suggested by Wenchao Chen.

Changes since V1:
	- Did minor code cleanup as suggested by Avri Altman.
	- Added _mmc_resume gain data in commit message as suggested by
	  Ulf Hansson.
	- Split patch in two patches.
	  [V2,1/2] mmc: core: Add partial initialization support
	  [V2,2/2] mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for
	  Qualcomm controllers

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

