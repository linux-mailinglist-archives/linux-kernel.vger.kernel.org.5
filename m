Return-Path: <linux-kernel+bounces-31919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7183365D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D0C1F21614
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ABF14AB9;
	Sat, 20 Jan 2024 21:17:30 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E612E74;
	Sat, 20 Jan 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705785450; cv=none; b=NGf6b62eVBV13e/UY25lOJ7mITj2udyDqRrifUQGHZXrtrrSjKVxvkyZAOelJRA2t91J4gKz6vAHCQ0NlVfemQitEvRAdltkCLUOh0iuxkZr3CxAJDpKx2CrztiDyhwhJyDdb62ZBYlH2x9HS9EmYAjGBgswvDf945Chlqbc8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705785450; c=relaxed/simple;
	bh=LH6ZLfgoff66ZwAlyeYtpywp7yWss44d2lazAs30kCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cc9xHfvjOCPeqiMLSPrtUMhSc9ZuL2abGcvoR6TygOrj7sunfmPlug+PsynevG9CQpsGCDGi09Af1uDKnvywvVxvnD3zf074+IdfPVpNrfaCaCVyjLZMivxWsvWzOBquxHLPZnsZ3nRK8arrgrI69F/lvQmc9hMEAUP70aRSzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id EC665858EE;
	Sat, 20 Jan 2024 22:17:19 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 20 Jan 2024 22:16:14 +0100
Subject: [PATCH v2 3/3] input: touchscreen: imagis: Add touch key support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240120-b4-imagis-keys-v2-3-d7fc16f2e106@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=LH6ZLfgoff66ZwAlyeYtpywp7yWss44d2lazAs30kCc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrDg6qi6DWG3TGF42j2WG9tpTnc8py/AIyrOUR
 aiwjYe7UGyJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZaw4OgAKCRCaEZ6wQi2W
 4aV2D/9hp7+munQtbVCtFWxV/mJAmTdshNy21+k3SfhPbxFQt7/NQDu4rMBm0c5juAS0U1D2Fhi
 fZjQDl91vFJcvnj0V1U7evYCExv6tfqewE+ZOC4PkbyuyNEwsERh3AMITU1zAsqTcHjdTpP3bLh
 6v/8Q9YxGWNzOrBSLaAEYhcsmTsSAVQP3sNhrV/NZGf78pVYIt2ylefXspv6wjcj/9H7oerozVA
 ewUyv1fZwL5Ecs6uAbyuIrh4rsRp0p2auRd0U3GzknQ+UkqeMNDFGfjFD/4VP+paTxYCLJi4a96
 kcuoKLFICecpgE7MMciKY+OZ64YRjk40tw9HoIzcv1CBrBZbpchAd1xJ7OCvFNlFWSK/Cc8MJiO
 yeX8tOsZwwFUiseJtaP3mGkLIZzuX6O6xXlYJyuWDY99Xt09b+Yl3CIphImJ9J8Jlqi5RDdtd8q
 OTIsgmNuEKcYTfXU0yxTW/w/ma7rPeP14IGTxd9THMh5JV89S4QpnIdxe3a9385tHL+Axj7VNn9
 0uRUSQPnl01/n8fov4fXy69piJAezC46lyzCqneFcU9HnWfhwR3j0tRJ4RgQvmTXTnAq/1hpWBx
 5y9WMoCyJvskiJqIAfII8fsWUHPY8jIVzWEnDtUlN7zi8frSmYrQBuaxzGFuzlCUsz/V5FjVfLi
 R7BhC/PXFOQPcGw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

IST3032C (and possibly some other models) has touch keys. Add support
for them to the imagis driver.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/input/touchscreen/imagis.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 4eae98771bd2..6dcb82313c32 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -34,6 +34,7 @@
 #define IST3038C_AREA_MASK		GENMASK(27, 24)
 #define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
+#define IST3032C_KEY_STATUS_MASK	GENMASK(20, 16)
 
 struct imagis_properties {
 	unsigned int interrupt_msg_cmd;
@@ -41,6 +42,7 @@ struct imagis_properties {
 	unsigned int whoami_cmd;
 	unsigned int whoami_val;
 	bool protocol_b;
+	bool touch_keys_supported;
 };
 
 struct imagis_ts {
@@ -49,6 +51,8 @@ struct imagis_ts {
 	struct input_dev *input_dev;
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
+	u32 keycodes[2];
+	int num_keycodes;
 };
 
 static int imagis_i2c_read_reg(struct imagis_ts *ts,
@@ -93,7 +97,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 {
 	struct imagis_ts *ts = dev_id;
 	u32 intr_message, finger_status;
-	unsigned int finger_count, finger_pressed;
+	unsigned int finger_count, finger_pressed, key_pressed;
 	int i;
 	int error;
 
@@ -139,6 +143,11 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 				       FIELD_GET(IST3038C_AREA_MASK, finger_status));
 	}
 
+	key_pressed = FIELD_GET(IST3032C_KEY_STATUS_MASK, intr_message);
+
+	for (int i = 0; i < ts->num_keycodes; i++)
+		input_report_key(ts->input_dev, ts->keycodes[i], (key_pressed & BIT(i)));
+
 	input_mt_sync_frame(ts->input_dev);
 	input_sync(ts->input_dev);
 
@@ -224,6 +233,19 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
+	if (ts->tdata->touch_keys_supported) {
+		ts->num_keycodes = of_property_read_variable_u32_array(
+				ts->client->dev.of_node, "linux,keycodes",
+				ts->keycodes, 0, ARRAY_SIZE(ts->keycodes));
+		if (ts->num_keycodes <= 0) {
+			ts->keycodes[0] = KEY_APPSELECT;
+			ts->keycodes[1] = KEY_BACK;
+			ts->num_keycodes = 2;
+		}
+	}
+
+	for (int i = 0; i < ts->num_keycodes; i++)
+		input_set_capability(input_dev, EV_KEY, ts->keycodes[i]);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
@@ -365,6 +387,7 @@ static const struct imagis_properties imagis_3032c_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3032C_WHOAMI,
+	.touch_keys_supported = true,
 };
 
 static const struct imagis_properties imagis_3038b_data = {

-- 
2.43.0



