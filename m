Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7EA7EF57D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbjKQPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbjKQPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:40:58 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088819A9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:40:43 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8U57Q031440;
        Fri, 17 Nov 2023 09:40:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=j
        Mxjx8uYfygMEBvu13m8vNG/QwpnvhsuVDVBW53JuLQ=; b=NFND+pwkfQaGCHEDg
        hEL3kuAwf0maHl/alm6givWDqRrHHsC+8tsASAjAL3frbGHu8/dqTj5JDp5vJCtk
        ucWawa/gUoNS+oTrWWF27Io6Kjn3s8AeNcZ12jf9IfDSo36FKlJyiH94OY0j7neZ
        2GiENXm/O7YnWPtQXernuM8e9GDEzH470hI/76gFH8pZRIgfqbfvVAfDRLnig++l
        vzpfEBwSd/jbrRL5iXTbzfjWnZZODTUX0JMiWCFX5GbmVEGo/CduHbRtqPH3Jq0f
        TdNpgNHvj6eELiSx127YbnEEpohbbQCU/6rs6JpYthbvDTZfnhScSFX34Iwq5Tbo
        TjdSA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qnn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:40:41 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 15:40:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 15:40:39 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 690F815B9;
        Fri, 17 Nov 2023 15:40:39 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Maciej Strozek" <mstrozek@opensource.cirrus.com>
Subject: [PATCH] mfd: wm831x: Remove redundant forever while loop
Date:   Fri, 17 Nov 2023 15:40:37 +0000
Message-ID: <20231117154037.67676-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zz1A7v9YFHpkHZtSVefFpphCyF_5_8Hp
X-Proofpoint-GUID: Zz1A7v9YFHpkHZtSVefFpphCyF_5_8Hp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/mfd/wm831x-auxadc.c | 46 +++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/wm831x-auxadc.c b/drivers/mfd/wm831x-auxadc.c
index 65b98f3fbd92..49f0ffd68d47 100644
--- a/drivers/mfd/wm831x-auxadc.c
+++ b/drivers/mfd/wm831x-auxadc.c
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

