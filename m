Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D97F103B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjKTKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKTKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:23:16 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEACD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:23:12 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AK7PVUv026140;
        Mon, 20 Nov 2023 04:23:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=y
        JWb63xfECD5H+4gZaxttDD0Ddcy302mDj0yvpHRoJw=; b=gnmrjlGKQC3EGgU2z
        k6wNAWVvr+efnaehq5yMmwT1zPXytrWR2cTjD3Kbn2ka5V80vCLCgdljjXhAq74w
        zIz0HOeFJwPgUL+frRIiHxDBI/MDpwXGzo/q88VevI1307G/SFoTjRc8bx3Lb2O9
        6OqNcQci5Xj5/ChbtNisZ5lmdmpcoojbuaaOdC++rPy2y4Jiu6IulPBkEqn14YTE
        S5s+qmzkQ++BxRTBUpFyRdtmDUcW+98/IxnwKWNl3RaCZH6WVjNGAimGbKFzQCFq
        AjTYh/DH93HJvLnrjBEtyRtv44eqPlnIrRlhLmDOHptY6DZquAwdw+OAyOu5MV0g
        zru9A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj29nq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:23:04 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 20 Nov
 2023 10:23:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 20 Nov 2023 10:23:02 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E740615B9;
        Mon, 20 Nov 2023 10:23:01 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Maciej Strozek" <mstrozek@opensource.cirrus.com>
Subject: [PATCH v2] mfd: wm831x: Remove redundant forever while loop
Date:   Mon, 20 Nov 2023 10:22:59 +0000
Message-ID: <20231120102259.74210-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rb-TZI8WviXW-LOL5NCgRV8ZShzFuKLH
X-Proofpoint-GUID: Rb-TZI8WviXW-LOL5NCgRV8ZShzFuKLH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
V1 -> V2: removed unused variable 'timeout'

 drivers/mfd/wm831x-auxadc.c | 48 +++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/wm831x-auxadc.c b/drivers/mfd/wm831x-auxadc.c
index 65b98f3fbd92..77f8e51a5753 100644
--- a/drivers/mfd/wm831x-auxadc.c
+++ b/drivers/mfd/wm831x-auxadc.c
@@ -152,7 +152,7 @@ static irqreturn_t wm831x_auxadc_irq(int irq, void *irq_data)
 static int wm831x_auxadc_read_polled(struct wm831x *wm831x,
 				     enum wm831x_auxadc input)
 {
-	int ret, src, timeout;
+	int ret, src;

 	mutex_lock(&wm831x->auxadc_lock);

@@ -179,32 +179,28 @@ static int wm831x_auxadc_read_polled(struct wm831x *wm831x,
 		goto disable;
 	}

-	/* If we're not using interrupts then poll the
-	 * interrupt status register */
-	timeout = 5;
-	while (timeout) {
-		msleep(1);
-
-		ret = wm831x_reg_read(wm831x,
-				      WM831X_INTERRUPT_STATUS_1);
-		if (ret < 0) {
-			dev_err(wm831x->dev,
-				"ISR 1 read failed: %d\n", ret);
-			goto disable;
-		}
+	/* If we're not using interrupts then read the
+	 * interrupt status register
+	 */
+	msleep(20);
+	ret = wm831x_reg_read(wm831x,
+				WM831X_INTERRUPT_STATUS_1);
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
+		wm831x_reg_write(wm831x,
+					WM831X_INTERRUPT_STATUS_1,
+					WM831X_AUXADC_DATA_EINT);
+	} else {
+		dev_err(wm831x->dev,
+			"AUXADC conversion timeout\n");
+		ret = -EBUSY;
+		goto disable;
 	}

 	ret = wm831x_reg_read(wm831x, WM831X_AUXADC_DATA);
--
2.34.1

