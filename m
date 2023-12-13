Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD9810E96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjLMKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjLMKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:38:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2B499;
        Wed, 13 Dec 2023 02:38:07 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD7H9Hx000429;
        Wed, 13 Dec 2023 10:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type; s=
        qcppdkim1; bh=PtcW76POK9iiqQ2qciDqBvfz80BkdqHXbeCSE0EFbQ4=; b=Uc
        aBZToU7sD1qwrDI5Zm0ivm3x10XvKcCDEk+KNLOpvtkZLDdyMonMfHOy5Dlme9T3
        I4TLYQDkzzn/NBXyPOW1tPUVtpotuxpPOgXN0oD7qIeHxZrpczqjR0cM/bUC483e
        +YVcKzYPA8eCm/o5/5RmP5o+LH6tNbb8NVSLJDnx/MhRzj643YTFavgICNpY4foz
        82YNwEmVM7e+47WujHUDGuEkDyhFtxFvMKo4LdBylUqaTPL1Bp8TROY2Z+SWZCaw
        UIzEIOuLMeoyGxXsObifqHVEm2J0L/2FQ2u7OiEii68ZaJfoiQLMqAha2cMRAmO9
        xPM5yiPHvdkkIivl0u4A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy5tvgsym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:37:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDAbiMO018800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:37:44 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 02:37:39 -0800
From:   Maramaina Naresh <quic_mnaresh@quicinc.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <stanley.chu@mediatek.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Jhu <chu.stanley@gmail.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V4 0/2] Add CPU latency QoS support for ufs driver 
Date:   Wed, 13 Dec 2023 16:06:40 +0530
Message-ID: <20231213103642.15320-1-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hs6gf9V6tF0iylPG58GBMUietw0t8wAf
X-Proofpoint-GUID: Hs6gf9V6tF0iylPG58GBMUietw0t8wAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=731 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU latency QoS support for ufs driver. This improves random io
performance by 15% for ufs.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Read(IPOS)  | 37101.3
	Random Write(IPOS) | 41065.13

2. With PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Read(IPOS)  | 42943.4
	Random Write(IPOS) | 46784.9
(Improvement with PM QoS = ~15%).

This patch is based on below patch by Stanley Chu [1]. 
Moving the PM QoS code to ufshcd.c and making it generic.

[1] https://lore.kernel.org/r/20220623035052.18802-8-stanley.chu@mediatek.com

Changes from v3:
- Removed UFSHCD_CAP_PM_QOS capability flag from patch#2.

Changes from v2:
- Addressed bvanassche and mani comments
- Provided sysfs interface to enable/disable PM QoS feature

Changes from v1:
- Addressed bvanassche comments to have the code in core ufshcd

Maramaina Naresh (2):
  ufs: core: Add CPU latency QoS support for ufs driver
  ufs: ufs-mediatek: Enable CPU latency PM QoS support for MEDIATEK SoC

 drivers/ufs/core/ufshcd.c       | 127 ++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-mediatek.c |  17 -----
 drivers/ufs/host/ufs-mediatek.h |   3 -
 include/ufs/ufshcd.h            |   6 ++
 4 files changed, 133 insertions(+), 20 deletions(-)

-- 
2.17.1

