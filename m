Return-Path: <linux-kernel+bounces-31921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EE833663
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487D71C20E97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E514F9D;
	Sat, 20 Jan 2024 21:17:31 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B512E69;
	Sat, 20 Jan 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705785450; cv=none; b=PEe0V6bymT4H6jJ56NfWdt0vdDWzQ4j42mbjFRbbTXfAed4GrlQ2czpEdjKP25ii3XrVwrxd+xVjC0IHuB7QWJvGoCP3tqPMpnqdU/Axi/uMuvGW+roTLdwnn39/qIrwjA8lIkQkvp/pCduv+yUkUS0xLR1nysbBUAIuJbLFLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705785450; c=relaxed/simple;
	bh=HkH+vQVtnzp58TbYVvbF+AErNiS1VapFH1SJiTr4Ntc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJmPaUfcczQHKgKcCwsUHKeWLGy6EQlEO690+1BI37DRGA910mWgNPoxRZEDzhjUK85xluafPF0s5Xs8zPw/EXF0bNc9wQ/y6uiT4VodcYUbM7RYdwLaiLRq/8t6ltIDQkZPryfuUVwdA7nfzM3VYB+5sWM8sUqM0KGSSdvQ0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id DB471858ED;
	Sat, 20 Jan 2024 22:17:18 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 20 Jan 2024 22:16:12 +0100
Subject: [PATCH v2 1/3] input: touchscreen: imagis: use FIELD_GET where
 applicable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240120-b4-imagis-keys-v2-1-d7fc16f2e106@skole.hr>
References: <20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr>
In-Reply-To: <20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr>
To: Markuss Broks <markuss.broks@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=HkH+vQVtnzp58TbYVvbF+AErNiS1VapFH1SJiTr4Ntc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrDg6E9hQFx+YWa5pOqRF78NBCoveP29c0sQXz
 AD+pSsBfHiJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZaw4OgAKCRCaEZ6wQi2W
 4SXAD/9cfdf0mVQstfUebgEAeyh511rtJcGRK0O/bVvRpVy1POWrgwRo0eh4JfGY0OpPY6yoTAG
 EA59O9DsMoSdO65Lxx8GIMkBsfrVn5Ra+1Eqm3FD9EBs1Ox9PwEBCzMyENRzBdf0QuftotFIUCs
 Qs7bXsQNx/lk/tG8rDVhI3JRrXZri5hpuFSrCPAdCj6e32Bs5aBqHWIbDE3TOzPGJTjQN2q+iiX
 J145ao0eGXhnqoQW/vWiazqU3G25vkuHOFVt2TFmnl1xQRknlZHvdyKRmp8HJJ+eLMBbvMmp1rB
 I9htluIZf2SNa9yBO4c43KUy4b2IC1TEjB/W2SSiqcmxTvJ/qs85oD3g8fER4byoqSENUNJjUCH
 6Chmj3jkHwA3lgyVN7Iw4Srcsxbb1ZbCP6no8jsVePJ1Iw042DfJ/NTsYx0AlvSd3rGTDt6w4zj
 E3TN7+W707BEsWvonMjALY5ZZFL9Q5CFW7z5Abbp4pBE7XA/Vq+M29wRgfp/xL68ZBvweUnqZIZ
 YOELf+ZZOgsOiGDTHzmXlz+LMxLoeSgARFG/ad77AHI3O/yLl+wRl7GoguUv++o8KgI6ukY6rgy
 bnrLJ/7Y4K2k7GFQGAgT1ri6Pge/8GiDR+nbIDHrO3HWwqE3yBfexd8s5VEWUffkwr3zpvX41q0
 kwEeI8PE7eB0Skw==
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
2.43.0



