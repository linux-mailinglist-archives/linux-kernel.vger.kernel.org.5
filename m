Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D057B3050
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjI2Kao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjI2K3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:29:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAEC19B4;
        Fri, 29 Sep 2023 03:29:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TA7LfX019893;
        Fri, 29 Sep 2023 10:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ByGrroXOiJTfy8moAhWOIIoeCJ7aCJ2ajue+54ukm/8=;
 b=XkBzTPjB7MZ1CkxB48pZT8ZHIZmQcQSdVobXdbS/rLO8jIuk1kHpsnXqyYGdzp6p/rrc
 XVRSc+oCLoKU4O+PimtV1azUNU9CqiYVwsVqCRJMjYSyk4/At2ltA+zGzoIYNVE6xKqa
 H/udWGoRI1EkRG1gSszixKgiO3pnvca37sMNhpeLHqpm8kqH0ni6anAiEaFKBJ8bC1ff
 zY8HZw4FJf5t+yKaBXNvNf7jz20ySygi2U30q3hYK7UihN4famptlD9PZM8YTyp+gUcA
 lhZGjkI8MwZtsJ0kerKV5dJeGYHc4Ojq8rN5ZDAiIToZHsOQCDqkUwkx1dBDgR7uyn2+ lQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdqmv8kw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 10:29:12 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38TAT9vm021884;
        Fri, 29 Sep 2023 10:29:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t9s3m2yhp-1;
        Fri, 29 Sep 2023 10:29:09 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TAT9Ub021797;
        Fri, 29 Sep 2023 10:29:09 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38TAT9ui021628;
        Fri, 29 Sep 2023 10:29:09 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 24C4052E7BC; Fri, 29 Sep 2023 15:59:08 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Subject: [PATCH V2 0/2] Add partial initialization support
Date:   Fri, 29 Sep 2023 15:58:29 +0530
Message-Id: <20230929102831.9702-1-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pJhYWoxOk-9NFm1COcYThX8roP1T4_z_
X-Proofpoint-ORIG-GUID: pJhYWoxOk-9NFm1COcYThX8roP1T4_z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=536 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Also enable this feature for qualcomm controllers.

Sarthak Garg (2):
  mmc: core: Add partial initialization support
  mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers

 drivers/mmc/core/mmc.c       | 162 +++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-msm.c |   1 +
 include/linux/mmc/card.h     |   4 +
 include/linux/mmc/host.h     |   2 +
 4 files changed, 160 insertions(+), 9 deletions(-)

--
2.17.1

