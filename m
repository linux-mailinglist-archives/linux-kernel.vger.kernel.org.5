Return-Path: <linux-kernel+bounces-88773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DE086E662
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E9C284E57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607F25601;
	Fri,  1 Mar 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="IjQhgqn6"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86990F4E1;
	Fri,  1 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311667; cv=none; b=jGBrT4v4BOvqWpVkM+J1YPmmFmYz/u5sbLOv4PrW4ZVsVRlKXpM5R8KDP0kEDLWdEZ5oJV4YF8qV4aDUlfMHmlDkuDwq+iYlNO6wBOvb2S+3TGef1tCs/cBn6CoJQ3lleTshNSWH+uF+rxenw2dy39J4p8mJNDEskrT/Un0SDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311667; c=relaxed/simple;
	bh=K8hTHNxD7+xc0Mc6CH9dFB5iscDhBxHrwGYHo/Go1Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfxMpt/XmQ0PEO3WYxYsioj2OhdVLzOS29b7H/EJliwGeKiB293r2kYirRqiqcDLN4jYSinftahWvIS0Z/wYSX2rt0cIke6RwOpJMKwJOtf5E21e2RG0TQT6mwvbWKTawlY7xm5h3I1FcxBiXOnJKhoVa/16OyKwZHURz3DSnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=IjQhgqn6; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 554D6284256;
	Fri,  1 Mar 2024 17:47:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709311656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIOJbI8z5ZyOMQWDFPQDTypDMqqUoXAjCw3t6tPK0Go=;
	b=IjQhgqn66urguwESquoCjndFHh1+oDPeuexfly/NYccDG6G8M8qDV6NgaaXTkp05QDSHJT
	PaZ+PwQ4uFnSCnWeZIM3lIhLG1MprIgmt690RqvXb0kEOgI0Q/reOo8l8UYrCtmcUPW9/q
	Y1E281nSFVy+t2ugS4RdFnX74m6375I=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 3428A4587C6;
	Fri,  1 Mar 2024 17:47:36 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	karelb@gimli.ms.mff.cuni.cz
Subject: [RESEND PATCH v5 3/5] input/touchscreen: imagis: Add support for Imagis IST3038B
Date: Fri,  1 Mar 2024 17:41:02 +0100
Message-ID: <20240301164659.13240-4-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

Imagis IST3038B is another variant of Imagis IST3038 IC, which has
a different register interface from IST3038C (possibly firmware defined).
This should also work for IST3044B (though untested), however other
variants using this interface/protocol(IST3026, IST3032, IST3026B,
IST3032B) have a different format for coordinates, and they'd need
additional effort to be supported by this driver.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v4:
    * Sort the definitions in alphanumerical order.

 drivers/input/touchscreen/imagis.c | 58 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e67fd3011027..9af8a6332ae6 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -11,9 +11,13 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
+#define IST3038B_REG_STATUS		0x20
+#define IST3038B_REG_CHIPID		0x30
+#define IST3038B_WHOAMI			0x30380b
+
 #define IST3038C_HIB_ACCESS		(0x800B << 16)
 #define IST3038C_DIRECT_ACCESS		BIT(31)
-#define IST3038C_REG_CHIPID		0x40001000
+#define IST3038C_REG_CHIPID		(0x40001000 | IST3038C_DIRECT_ACCESS)
 #define IST3038C_REG_HIB_BASE		0x30000100
 #define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
 #define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
@@ -31,8 +35,17 @@
 #define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
+struct imagis_properties {
+	unsigned int interrupt_msg_cmd;
+	unsigned int touch_coord_cmd;
+	unsigned int whoami_cmd;
+	unsigned int whoami_val;
+	bool protocol_b;
+};
+
 struct imagis_ts {
 	struct i2c_client *client;
+	const struct imagis_properties *tdata;
 	struct input_dev *input_dev;
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
@@ -84,8 +97,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	int i;
 	int error;
 
-	error = imagis_i2c_read_reg(ts, IST3038C_REG_INTR_MESSAGE,
-				    &intr_message);
+	error = imagis_i2c_read_reg(ts, ts->tdata->interrupt_msg_cmd, &intr_message);
 	if (error) {
 		dev_err(&ts->client->dev,
 			"failed to read the interrupt message: %d\n", error);
@@ -104,9 +116,13 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
 
 	for (i = 0; i < finger_count; i++) {
-		error = imagis_i2c_read_reg(ts,
-					    IST3038C_REG_TOUCH_COORD + (i * 4),
-					    &finger_status);
+		if (ts->tdata->protocol_b)
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd, &finger_status);
+		else
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd + (i * 4),
+						    &finger_status);
 		if (error) {
 			dev_err(&ts->client->dev,
 				"failed to read coordinates for finger %d: %d\n",
@@ -261,6 +277,12 @@ static int imagis_probe(struct i2c_client *i2c)
 
 	ts->client = i2c;
 
+	ts->tdata = device_get_match_data(dev);
+	if (!ts->tdata) {
+		dev_err(dev, "missing chip data\n");
+		return -EINVAL;
+	}
+
 	error = imagis_init_regulators(ts);
 	if (error) {
 		dev_err(dev, "regulator init error: %d\n", error);
@@ -279,15 +301,13 @@ static int imagis_probe(struct i2c_client *i2c)
 		return error;
 	}
 
-	error = imagis_i2c_read_reg(ts,
-			IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS,
-			&chip_id);
+	error = imagis_i2c_read_reg(ts, ts->tdata->whoami_cmd, &chip_id);
 	if (error) {
 		dev_err(dev, "chip ID read failure: %d\n", error);
 		return error;
 	}
 
-	if (chip_id != IST3038C_WHOAMI) {
+	if (chip_id != ts->tdata->whoami_val) {
 		dev_err(dev, "unknown chip ID: 0x%x\n", chip_id);
 		return -EINVAL;
 	}
@@ -343,9 +363,25 @@ static int imagis_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
+static const struct imagis_properties imagis_3038b_data = {
+	.interrupt_msg_cmd = IST3038B_REG_STATUS,
+	.touch_coord_cmd = IST3038B_REG_STATUS,
+	.whoami_cmd = IST3038B_REG_CHIPID,
+	.whoami_val = IST3038B_WHOAMI,
+	.protocol_b = true,
+};
+
+static const struct imagis_properties imagis_3038c_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST3038C_WHOAMI,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
-	{ .compatible = "imagis,ist3038c", },
+	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
+	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imagis_of_match);
-- 
2.44.0


