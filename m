Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3217801CF1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjLBNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjLBNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:09:35 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5161194;
        Sat,  2 Dec 2023 05:09:39 -0800 (PST)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 2DE1428BDEB;
        Sat,  2 Dec 2023 14:00:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1701522038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FI2ta7jn+qB7+yTr05l6kHo60dhjoRkfy4IOcQxfPyc=;
        b=VpMthgQj41SEE9/KBX2BwYUZGzWQvTRXfCN+kQWc2W2DcWdAJeB+kTwCyt26Icfy37183g
        3J363KO6NMtxLsd5l2nDDJRHinrAD24+eznA+cZ69m9at38Kj/CR8/BEHGSeBV1evNs7Ks
        KGFhMzTpktx+PKPf+c11CxaaUYoVTXU=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 0D98D4443E5;
        Sat,  2 Dec 2023 14:00:38 +0100 (CET)
From:   Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH v3 3/5] input/touchscreen: imagis: Add support for Imagis IST3038B
Date:   Sat,  2 Dec 2023 13:48:34 +0100
Message-ID: <20231202125948.10345-4-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/input/touchscreen/imagis.c | 58 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e67fd3011027..84a02672ac47 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -13,7 +13,7 @@
 
 #define IST3038C_HIB_ACCESS		(0x800B << 16)
 #define IST3038C_DIRECT_ACCESS		BIT(31)
-#define IST3038C_REG_CHIPID		0x40001000
+#define IST3038C_REG_CHIPID		(0x40001000 | IST3038C_DIRECT_ACCESS)
 #define IST3038C_REG_HIB_BASE		0x30000100
 #define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
 #define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
@@ -31,8 +31,21 @@
 #define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
+#define IST3038B_REG_STATUS		0x20
+#define IST3038B_REG_CHIPID		0x30
+#define IST3038B_WHOAMI			0x30380b
+
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
2.43.0

