Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4332760FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjGYJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjGYJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:57:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F11999;
        Tue, 25 Jul 2023 02:57:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P9lCi4003593;
        Tue, 25 Jul 2023 09:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=4bYZn8KsNVyvtvAHPDcH9lOPhrvBpowcdWikiFWiqms=;
 b=leABWcaEBnoyDtYSzOy4I5P/LClKtB63xyGZ0SLhff6Fm7TyTOBDCLuK3CNupe4UZjjk
 WsuVQeSlZFAEvzYOFJqWZfHSUT5Ut6hI/73rUP7Hr9VH4GJcb+geGPkIXk5ngqK4x1Vi
 89koT/QvIZIOx3OF0yS+eTk1myuWQkGmtMvseYFZAjcs6DOwTcPZi0LUbpQ0BPNTqzC/
 Q+njeH5gb76lvU6V4Uf03+ohATM0LHkPe3i8i1qrHtIBnmsPXt/WTqQCfd0FJHRY8ZHW
 I2gmctnbgPARtpTq6dotFATck5/Yezm+fuKpxUQ2t0/V4M5Absj9Swugw/qZHiBd/RW7 CQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qa3tjhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P9vebl021614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:57:40 GMT
Received: from fenglinw2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 02:57:38 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
Date:   Tue, 25 Jul 2023 17:57:20 +0800
Subject: [PATCH v2 2/3] leds: flash: leds-qcom-flash: turn off LED before
 setting flash current
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-2-0f5cbce5fed0@quicinc.com>
References: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
In-Reply-To: <20230725-leds-qcom-flash-driver-tiny-fixes-v2-0-0f5cbce5fed0@quicinc.com>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690279054; l=875;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=W/dfqC+/sx2xdVFtlxcBI6JBsWRBJdEzU7xvhTBhVQk=;
 b=mhyIsm06MIsDejy0g0TzWf+U5u/3kNjoenYLow6u3aRJqU29uOCcNmzPH8fh8IwsCVrsOiCGk
 snYrWxGXkwoCubvEpupxkY6z6h1swrqWwdsKZ8OWJ4QDxwa/vdHDbnv
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XNC7vZ8WRUeCst9iGFroJwehMG0B9RRz
X-Proofpoint-GUID: XNC7vZ8WRUeCst9iGFroJwehMG0B9RRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=545
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strobe off the LED before setting flash current to avoid it's being
enabled with an incorrect current if it has been working in torch
mode.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/leds/flash/leds-qcom-flash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index b089ca1a1901..29cf09479422 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -309,6 +309,10 @@ static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, bool stat
 	struct qcom_flash_led *led = flcdev_to_qcom_fled(fled_cdev);
 	int rc;
 
+	rc = set_flash_strobe(led, SW_STROBE, false);
+	if (rc)
+		return rc;
+
 	rc = set_flash_current(led, led->flash_current_ma, FLASH_MODE);
 	if (rc)
 		return rc;

-- 
2.25.1

