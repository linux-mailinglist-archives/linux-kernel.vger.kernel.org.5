Return-Path: <linux-kernel+bounces-94086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9F8739B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17E21F25A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1A134CFA;
	Wed,  6 Mar 2024 14:48:27 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF0130E3F;
	Wed,  6 Mar 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736507; cv=none; b=PV2yt2IJs0zPsL7Gd9yW3/xTAKebIqrIlA5sviADqouA7FCCfLrOnya61rIkawHH14bEWwkBV+dO4X91QJyZe+WYXJpoVCtqg4zicQW+4Lk3L8S3Y//fPBlz7uQKdu42Z3WM6shzj7H3RXTSTmfjzzJYD6Xg9mwBh6J+6sPfhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736507; c=relaxed/simple;
	bh=Nolmyvj6Bpjp+71zbiQVcuCZkPXBALrPAzjCQpL9brk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/5fZl+7psfr/M6aOJfDZF38b8fURHiQWIdL1AT3dAhf2+WBYvwN8mnphZ3w5U5NoyWHha9fcvaJwBmP3YepR8bgZE/XBt+XI7muUODKiEHVvL9uj8/0epFFto6aBp4i1snttaVAgWMM2EUOppAV5Ry42le9qOnXrTUV0pYJdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 8388D8452B;
	Wed,  6 Mar 2024 15:40:23 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 06 Mar 2024 15:40:08 +0100
Subject: [PATCH v3 3/3] input: touchscreen: imagis: Add touch key support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-b4-imagis-keys-v3-3-2c429afa8420@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3227;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=Nolmyvj6Bpjp+71zbiQVcuCZkPXBALrPAzjCQpL9brk=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBl6IBO9ermR6in0dAPtYRcYTLrUNymtUAkTsnsy
 5NwQXVPn7iJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZeiATgAKCRCaEZ6wQi2W
 4Wv2D/4pQuqDgpZI3pAixeniIp8yNCve+TOi6Be2rHj5VnvnI8EUNUiG2tdU5SW1+RqgEDkBlV2
 /gY8oFL/mJldmnTUfApP6PHp7M9jhodPZp0wVbkUyOpF64apurUrlOEjgg1E7RRbCBEuAjSL3gO
 txbW9EgWnwRUuPmHfbGiggdBcnJbCjotMUyh6lVIDtQ+6+VitP+hlb/pEchzG+9PT4s3iYq5QH7
 Qng40r0wjkZo72M4Hsh6r36GTwur/qWYZVLXTthNw+ZE/tUDwdZ7kb7gOtzBFU4psZ1uBRYzmhV
 fbsziJjpRpWtrl9JZm4P732kvfHT8obh+4fPynsdrHzTKvdZqmDZFEeZaw40ATRaKF4+6Qzk/ki
 qGQYb27qLQ9nijosWDY38aqbiAX+mngY4NpPqXIZDxd3/6M7Lu5/XUNzj+6DYYxsK7TEFENNEkN
 BFflWCXLlGxW1L2w/1Nqrwk5jEitXmPYPjfo7x/do22iN1z9IqrKRbG2aoDNYBIQ/7y26wY2p8i
 6WP/KfdBGlaIgrHT13mbrSbbZgcLUAJRLVLwMg77wzsmg0sQTGWjIdQcBZr/fra334Jgkuj5sZO
 iMI0/5L1AUGXiI42Xc0vLDG7COi+Dx275LvHhvxjF8ND7gGTGzPHLelnaDE2M86oL0xOSdWYQW4
 WdNhyuwsYTYJL+Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

IST3032C (and possibly some other models) has touch keys. Add support
for them to the imagis driver.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/input/touchscreen/imagis.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 4eae98771bd2..625d9287eabe 100644
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
+	u32 keycodes[5];
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
 
@@ -224,6 +233,23 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
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
+
+		input_dev->keycodemax = ts->num_keycodes;
+		input_dev->keycodesize = sizeof(ts->keycodes[0]);
+		input_dev->keycode = ts->keycodes;
+	}
+
+	for (int i = 0; i < ts->num_keycodes; i++)
+		input_set_capability(input_dev, EV_KEY, ts->keycodes[i]);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
@@ -365,6 +391,7 @@ static const struct imagis_properties imagis_3032c_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3032C_WHOAMI,
+	.touch_keys_supported = true,
 };
 
 static const struct imagis_properties imagis_3038b_data = {

-- 
2.44.0



