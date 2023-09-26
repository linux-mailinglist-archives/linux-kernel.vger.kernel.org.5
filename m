Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923897AF200
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjIZRwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjIZRwO (ORCPT
        <RFC822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:52:14 -0400
Received: from smtp1.ms.mff.cuni.cz (smtp1.ms.mff.cuni.cz [IPv6:2001:718:1e03:801::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB610A;
        Tue, 26 Sep 2023 10:52:06 -0700 (PDT)
Received: from localhost (internet5.mraknet.com [185.200.108.250])
        (authenticated)
        by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 38QHZxsT083224
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 19:36:00 +0200 (CEST)
        (envelope-from balejk@matfyz.cz)
From:   Karel Balej <balejk@matfyz.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 2/2] input: Imagis: add support for the IST3032C touchscreen
Date:   Tue, 26 Sep 2023 19:35:24 +0200
Message-ID: <20230926173531.18715-3-balejk@matfyz.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926173531.18715-1-balejk@matfyz.cz>
References: <20230926173531.18715-1-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream driver sets the regulator voltage to 3.1 V. Without this,
the touchscreen generates random touches even after it is no longer
being touched. It is unknown whether the same problem appears with other
chips of the IST30**C series.

Co-developed-by: Duje Mihanović <duje.mihanovic@skole.hr>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../bindings/input/touchscreen/imagis,ist30xxc.yaml |  1 +
 drivers/input/touchscreen/imagis.c                  | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
index 09bf3a6acc5e..d6f75bbfaec3 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist30xxc.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3032c
       - imagis,ist3038c
 
   reg:
diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 4456f1b4d527..df9a8fbf2c5f 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -30,6 +30,7 @@
 #define IST30XXC_FINGER_COUNT_SHIFT	12
 #define IST30XXC_FINGER_STATUS_MASK	GENMASK(9, 0)
 
+#define IST3032C_WHOAMI			0x32c
 #define IST3038C_WHOAMI			0x38c
 
 struct imagis_ts {
@@ -295,6 +296,16 @@ static int imagis_probe(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
+	if (chip_id == IST3032C_WHOAMI) {
+		/*
+		 * if the regulator voltage is not set like this, the touchscreen
+		 * generates random touches without user interaction
+		 */
+		error = regulator_set_voltage(ts->supplies[0].consumer, 3100000, 3100000);
+		if (error)
+			dev_warn(dev, "failed to set regulator voltage\n");
+	}
+
 	error = devm_request_threaded_irq(dev, i2c->irq,
 					  NULL, imagis_interrupt,
 					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
@@ -348,6 +359,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
+	{ .compatible = "imagis,ist3032c", .data = (void *)IST3032C_WHOAMI, },
 	{ .compatible = "imagis,ist3038c", .data = (void *)IST3038C_WHOAMI, },
 	{ },
 };
@@ -355,6 +367,7 @@ MODULE_DEVICE_TABLE(of, imagis_of_match);
 #endif
 
 static const struct i2c_device_id imagis_ts_i2c_id[] = {
+	{ "ist3032c", IST3032C_WHOAMI, },
 	{ "ist3038c", IST3038C_WHOAMI, },
 	{ },
 };
-- 
2.42.0

