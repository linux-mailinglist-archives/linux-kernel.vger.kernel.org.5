Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4BF7FD80A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjK2N2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjK2N2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:17 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C359D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:28:23 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AT7ot2n005547;
        Wed, 29 Nov 2023 07:28:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=i
        md3WMe5eVrNHtfWcnGWTRuiNO0ihLgfVPUsvAMiNfo=; b=HUzvop2wlHgiYXToP
        JsKsj67bzYWWs8yoTiUfA/+vR7wTPvqftPXnF0JAJ6QTPtL5aNEZbqihPA1+kC6q
        cAbBOnps4d23rhf07CkKCslhtrTbnvwzg4+AUi4fufAQrxA2oRg3xzKtTt0y/9jT
        5/iTYzLnuNcsCutxC2BVyQFYtqcO9+/C21tQOIWCqDpbBevdYuOLK8r3RmLYsZ31
        00w0o0A1YjkBntvACzAPR5PMyLm4nOsGouup/o60KL55hw/DEGErGItOt0MkXwuZ
        k4jULhq3MrtmkL6PKpeBGpjOOKIIFfcEjIDTpk2bUPDCUL/7qOaNKiPxCWidGiGf
        h+jhA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3unvprrfty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 07:28:19 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 29 Nov
 2023 13:28:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Wed, 29 Nov 2023 13:28:18 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4371415A5;
        Wed, 29 Nov 2023 13:28:18 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Maciej Strozek" <mstrozek@opensource.cirrus.com>
Subject: [PATCH v3] mfd: wm831x: Remove redundant forever while loop
Date:   Wed, 29 Nov 2023 13:28:16 +0000
Message-ID: <20231129132816.15620-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: W-c20O3bmvwF7aVyemND64M72jypcTV7
X-Proofpoint-GUID: W-c20O3bmvwF7aVyemND64M72jypcTV7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code excutes only once despite the while loop, so remove the
loop. Also msleep(1) will likely result in a larger sleep, so increase
its value for clarity while keeping the same behaviour.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
V2 -> V3: formatting changes: fixed a comment and 2 line-ups, added a new line
V1 -> V2: removed unused variable 'timeout'

 drivers/mfd/wm831x-auxadc.c | 43 ++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/wm831x-auxadc.c b/drivers/mfd/wm831x-auxadc.c
index 65b98f3fbd92..18618a8f9206 100644
--- a/drivers/mfd/wm831x-auxadc.c
+++ b/drivers/mfd/wm831x-auxadc.c
@@ -152,7 +152,7 @@ static irqreturn_t wm831x_auxadc_irq(int irq, void *irq_data)
 static int wm831x_auxadc_read_polled(struct wm831x *wm831x,
 				     enum wm831x_auxadc input)
 {
-	int ret, src, timeout;
+	int ret, src;

 	mutex_lock(&wm831x->auxadc_lock);

@@ -179,32 +179,25 @@ static int wm831x_auxadc_read_polled(struct wm831x *wm831x,
 		goto disable;
 	}

-	/* If we're not using interrupts then poll the
-	 * interrupt status register */
-	timeout = 5;
-	while (timeout) {
-		msleep(1);
+	/* If we're not using interrupts then read the interrupt status register */
+	msleep(20);

-		ret = wm831x_reg_read(wm831x,
-				      WM831X_INTERRUPT_STATUS_1);
-		if (ret < 0) {
-			dev_err(wm831x->dev,
-				"ISR 1 read failed: %d\n", ret);
-			goto disable;
-		}
+	ret = wm831x_reg_read(wm831x, WM831X_INTERRUPT_STATUS_1);
+	if (ret < 0) {
+		dev_err(wm831x->dev,
+			"ISR 1 read failed: %d\n", ret);
+		goto disable;
+	}

-		/* Did it complete? */
-		if (ret & WM831X_AUXADC_DATA_EINT) {
-			wm831x_reg_write(wm831x,
-					 WM831X_INTERRUPT_STATUS_1,
-					 WM831X_AUXADC_DATA_EINT);
-			break;
-		} else {
-			dev_err(wm831x->dev,
-				"AUXADC conversion timeout\n");
-			ret = -EBUSY;
-			goto disable;
-		}
+	/* Did it complete? */
+	if (ret & WM831X_AUXADC_DATA_EINT) {
+		wm831x_reg_write(wm831x, WM831X_INTERRUPT_STATUS_1,
+				WM831X_AUXADC_DATA_EINT);
+	} else {
+		dev_err(wm831x->dev,
+			"AUXADC conversion timeout\n");
+		ret = -EBUSY;
+		goto disable;
 	}

 	ret = wm831x_reg_read(wm831x, WM831X_AUXADC_DATA);
--
2.34.1

