Return-Path: <linux-kernel+bounces-94085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AA8739B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CAB1F22659
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD1134751;
	Wed,  6 Mar 2024 14:48:26 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB9BA55;
	Wed,  6 Mar 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736506; cv=none; b=ZGS0rqGXgvAgL++wQZYRXe33vNMgTWCZNW130mTKoWbbXs7Rry2U8YAJRNmZ56vepfd5LK8W3Ia4eh34DgmGZDIsqYGeSLBridwv2Tumc/c1oIbzqnUPCo6wTRr3z3KK6zDN6ajxGQxI67mcRKvnpQbehyA4c7+BVHMMXbBcPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736506; c=relaxed/simple;
	bh=wPwFHxl685tH7blzlSHwK4TFwVDG8koIWrtaYuGT7t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e17NNAiS41h4XLxebqiWYb6uPw8eRBUh73QET2MfH+0xCCOwiVf5S3R6pmxQ7gSRrs52w20cQlptOXaJjc2MbPE9pQB+YVuH0kVkdH/Kl3Yi0qlUzdm1OSiwadiklb23HY/I/aUd9jpTVlI1Ms2KApgVUdTFwSPzNxt7NG4g8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 917F28446D;
	Wed,  6 Mar 2024 15:40:22 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 06 Mar 2024 15:40:06 +0100
Subject: [PATCH v3 1/3] input: touchscreen: imagis: use FIELD_GET where
 applicable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-b4-imagis-keys-v3-1-2c429afa8420@skole.hr>
References: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
In-Reply-To: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
To: Markuss Broks <markuss.broks@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=wPwFHxl685tH7blzlSHwK4TFwVDG8koIWrtaYuGT7t0=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBl6IBODyfcfG498TupsW/xJOdjgBHrqwUj9lBtq
 gns2lXASfWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZeiATgAKCRCaEZ6wQi2W
 4dDyD/9cqrj5jZHJ35g2PAZ5viUdLLBuYfpfTpIXlqg+NZSVCEvtlb4Jh0yjhqterXk/RRuFU3O
 qsS4AcXRRQ+MWBjtntHUXS5VVzg57JVHuxXrJtAiZrH96i+qWtzWvWlgaEm9Sd7l8N5ydVEWDWi
 ndokDa/z67MiuzFmkmTjeRExDnVxX7eh6WaXba0KZf3ie8Dzm5o4hJ1erHKWcXFVkxxhO+o8XQe
 GUcIxj0V7ypSemQ/PLraqcXvgdED7Vg7Ct1janq1m+OFkcXKR3ACbhzOIwwKr0fIb9y4RUOWBd0
 8sWb4wSm+XVyVqd+h6Px0WwGfUDiOzfAoLvFboyb3CHN0cICTG7QUNJa+F79MYK3fFqjMIG5NSv
 9wVImcG+6ql2W8uKnpjvFBaNpjGWEpQgshz0G1y/byaYYVaBfTa5flbuNOp/2T5ZvsGV3d2mcnF
 k8ZyCxTtcwcMx6JJC/eizXE2fNZC//1xtQ8kGNmlHQzqK21XzCK6jgoIqaa2puD2ulLeg+LmOWl
 iSj03TyVBlrt3XZLVNQ6HBwdP174hUVHb3RDJi9huulPmV7RomEo70ySAj/hdfzfui25zE8ln7q
 Yx8CUB9INMRMTi/lf7k89n9avKPM1PSraE6gbOlDzgGZ7g9V3V9jI1XDOLgMwBhpDfOv2Xw23/0
 6JU5CCEDaJoBWHQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Instead of manually extracting certain bits from registers with binary
ANDs and shifts, the FIELD_GET macro can be used. With this in mind, the
*_SHIFT macros can be dropped.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/input/touchscreen/imagis.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e1fafa561ee3..4eae98771bd2 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -29,12 +30,9 @@
 #define IST3038C_I2C_RETRY_COUNT	3
 #define IST3038C_MAX_FINGER_NUM		10
 #define IST3038C_X_MASK			GENMASK(23, 12)
-#define IST3038C_X_SHIFT		12
 #define IST3038C_Y_MASK			GENMASK(11, 0)
 #define IST3038C_AREA_MASK		GENMASK(27, 24)
-#define IST3038C_AREA_SHIFT		24
 #define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
-#define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
 struct imagis_properties {
@@ -106,8 +104,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	finger_count = (intr_message & IST3038C_FINGER_COUNT_MASK) >>
-				IST3038C_FINGER_COUNT_SHIFT;
+	finger_count = FIELD_GET(IST3038C_FINGER_COUNT_MASK, intr_message);
 	if (finger_count > IST3038C_MAX_FINGER_NUM) {
 		dev_err(&ts->client->dev,
 			"finger count %d is more than maximum supported\n",
@@ -115,7 +112,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
+	finger_pressed = FIELD_GET(IST3038C_FINGER_STATUS_MASK, intr_message);
 
 	for (i = 0; i < finger_count; i++) {
 		if (ts->tdata->protocol_b)
@@ -136,12 +133,10 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
 					   finger_pressed & BIT(i));
 		touchscreen_report_pos(ts->input_dev, &ts->prop,
-				       (finger_status & IST3038C_X_MASK) >>
-						IST3038C_X_SHIFT,
-				       finger_status & IST3038C_Y_MASK, 1);
+				       FIELD_GET(IST3038C_X_MASK, finger_status),
+				       FIELD_GET(IST3038C_Y_MASK, finger_status), 1);
 		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
-				 (finger_status & IST3038C_AREA_MASK) >>
-					IST3038C_AREA_SHIFT);
+				       FIELD_GET(IST3038C_AREA_MASK, finger_status));
 	}
 
 	input_mt_sync_frame(ts->input_dev);

-- 
2.44.0



