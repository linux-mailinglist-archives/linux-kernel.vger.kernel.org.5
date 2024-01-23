Return-Path: <linux-kernel+bounces-35583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330888393A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669BC1C27841
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC26350D;
	Tue, 23 Jan 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PCRCpGjC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFE634F6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024600; cv=none; b=OrkkNyyDzMDYL4uZ/o0TlR32pjnZ9tl3SYd4tlEGRd/jWTm6ec2J4aZd4wNIonuLyFdx0werRFuEBaJcghnvPBdMrnnc7dCysuw/qYV5lE4SbaGZ6l5l+kagFfLLf/xC1G4Fk5Fp5DUJgiY6H0AUN01Heto+xFTEGB2ua6iOkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024600; c=relaxed/simple;
	bh=i9mRa9CFSSZXmmlLzR0bO6s1i0KxlRjtfdK0LsTa1qs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJ1ZUAhFEC1r+SkLfE8VWqReP8s+rdivQb/lXGAlMe9FSPoZFudu1t6u/Fy97qU6abhaiehhJmUu5oos+kemkeBV3qUSQbByrk8UZLkN2qUM4/i/oCxwQxahkPzTZ2VqBv3Te2Te8VA7yW7V0P2qtStSUtmLnlFO5wurigTwj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PCRCpGjC; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NFgT31011205;
	Tue, 23 Jan 2024 09:43:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=i
	md3WMe5eVrNHtfWcnGWTRuiNO0ihLgfVPUsvAMiNfo=; b=PCRCpGjCqfTekj6Ss
	M3ER9r8doEH4QL1dCjskW8N6EkHaskL9IkcVcwkAiODq8+kDGCF+h/4muG69HEUB
	+KNk1XbqRIAtjUpl+ax2l8/hXEeTl7otqk01Xl3+RCdU9Wf6H7FL9dEdYlm6sWwY
	xcgVRM8Zh+ftiM606rsyZ4CoY5NP7kUJt09f0eOyuoUDdfuC7g6GgaxqbXg1WOhf
	2AQoAMlbTRmMyA2DXwZcYfLDYgckU2GsZvfSVbMYcqgpgaIrUFC+PXBGL/VZwBkB
	b3VtIf6JH7AFgslBIZ9yl7FjydXqcL4aAOHiVuLIuyaAFA8YgFiR4ZYuODC2dis2
	siTuQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vrbfpvams-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:43:03 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 15:43:01 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 23 Jan 2024 15:43:01 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7F489820243;
	Tue, 23 Jan 2024 15:43:01 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Maciej
 Strozek" <mstrozek@opensource.cirrus.com>
Subject: [RESEND PATCH v3] mfd: wm831x: Remove redundant forever while loop
Date: Tue, 23 Jan 2024 15:42:59 +0000
Message-ID: <20240123154259.81258-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: curYr5fYArzEXiINyc_HbMWsRUp85xI9
X-Proofpoint-GUID: curYr5fYArzEXiINyc_HbMWsRUp85xI9
X-Proofpoint-Spam-Reason: safe

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


