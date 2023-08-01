Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7676B3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjHALql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjHALqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:46:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BE1BF0;
        Tue,  1 Aug 2023 04:46:18 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37189c5k002608;
        Tue, 1 Aug 2023 11:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=UXNCaCfe8x00qYEAOnhM3SnTOV1Wu1rCLnFGmnwNIcc=;
 b=NbB50WKn4T1hheDDOo5VcsyC6O5W2KsAokHr+m9o0QLV27rd+w73Oc+W/twe/mm3zs31
 I/hXE2D/y6gbWtMuOUVojp3Q3G9qBnC+WGmwaY6se+8P7AlwYtK2mPV2+pLoyd6fgt4R
 JVoMUvr7YOyv8oMJtkrZs2wtdlVkIwB0SqYf6mRZZFnkOlGw29Mx7oIY8u0bVUPXy5/7
 u28cBBTRgUmDLJq3uIFpFG3f+rCgxwF9Am7kS+dzOlsSCo9vlmJw1WyxEIA0XgpRBvm3
 h4bGVlVNcCZT0ncOI5hDuebmhEY17mgrvTw3q+xybFLE8zNFUrY6HaYjk3PEgVm5SPNG cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a503h2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 11:46:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371Bk7Gh006901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 11:46:07 GMT
Received: from hu-ajainp-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 04:46:05 -0700
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Venkata Rao Kakani" <quic_vkakani@quicinc.com>,
        Anvesh Jain P <quic_ajainp@quicinc.com>
Subject: [PATCH] rtc: rtc-pm8xxx: control default alarm wake up capability
Date:   Tue, 1 Aug 2023 17:15:49 +0530
Message-ID: <20230801114549.26956-1-quic_ajainp@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kRKcQjerAr_8qcYxPtEWbK_kUdhLRi3o
X-Proofpoint-ORIG-GUID: kRKcQjerAr_8qcYxPtEWbK_kUdhLRi3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable & disable rtc alarm wake up capability based on
default parameter passed from device tree.

Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
---
 drivers/rtc/rtc-pm8xxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index f6b779c12ca7..bed57be602b6 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -523,6 +523,9 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	if (of_property_read_bool(pdev->dev.of_node, "disable-alarm-wakeup"))
+		device_set_wakeup_capable(&pdev->dev, false);
+
 	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
 	if (rc)
 		return rc;

base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
-- 
2.17.1

