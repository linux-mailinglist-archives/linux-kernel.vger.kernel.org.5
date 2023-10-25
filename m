Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4298F7D68D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjJYKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjJYKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F7171A;
        Wed, 25 Oct 2023 03:34:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 732DBC433B6;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698230089; bh=DtHEPpID31tWjOLNIsg0s4zUFeieNUVEZ4/N6Xx8pBg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BjiBDWUMuj2tkWUwTUmXk+7PGrVIGz3zwiAzUlyvkvPp4VSCBA9MDde6zGjkgQOIR
         +N8gsK0fk7EF3dkwYdCFXB+4GHIAxC/+1Npnj7ZZNjgX8FvG3t5RKQtskoGVjq9Psm
         wkk1VeOCjKG18kaHLbgBzXqLcilm9k5W9YMqUkEI=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD4BC25B47;
        Wed, 25 Oct 2023 10:34:49 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Wed, 25 Oct 2023 10:34:13 +0000
Subject: [PATCH 3/4] hwmon: ina238: add ina237 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231025-ina237-v1-3-a0196119720c@linux.dev>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
In-Reply-To: <20231025-ina237-v1-0-a0196119720c@linux.dev>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698230088; l=1834;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=DtHEPpID31tWjOLNIsg0s4zUFeieNUVEZ4/N6Xx8pBg=; =?utf-8?q?b=3Dcbexpn9jwDnL?=
 =?utf-8?q?m+iezslfz1ab3VC6XgcxtDK5rB8jqIMYOYfLU10JVG6RexSObUWxYfv/lSVZWjUN?=
 mndptX2xClpQW5585VXATi/o+DZCXtdCE+kJlqIZpCmvIIwi3Ljr
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=ZYa5+0m9RFYtnNU6DLet7sHyPehnVHa0ucJlYiAu2NU=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20231025 with auth_id=90
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INA237 "85-V, 16-Bit, Precision Power Monitor With I2C Interface" is
basically the same as INA328. Therefore add a corresponding compatible
to the driver.

According to the datasheet the main difference is the current and power
monitoring accuracy:

+------------------------+---------------+---------------+
|                        | INA238        | INA237        |
+------------------------+---------------+---------------+
| Offset voltage         | +/- 5µV       | +/- 50µV      |
| Offset drift           | +/- 0.02µV/°C | +/- 0.02µV/°C |
| Gain error             | +/- 0.1%      | +/- 0.3%      |
| Gain error drift       | +/- 25ppm/°C  | +/- 50ppm/°C  |
| Common mode rejection  | 140dB         | 120dB         |
| Power accuracy         | 0.7%          | 1.6%          |
+------------------------+---------------+---------------+

As well as the missing DEVICE_ID register at 0x3F, which is currently
not in use by the driver.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 drivers/hwmon/ina238.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index f519c22d3907..ca9f5d2c811b 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -33,7 +33,7 @@
 #define INA238_BUS_UNDER_VOLTAGE	0xf
 #define INA238_TEMP_LIMIT		0x10
 #define INA238_POWER_LIMIT		0x11
-#define INA238_DEVICE_ID		0x3f
+#define INA238_DEVICE_ID		0x3f /* not available on INA237 */
 
 #define INA238_CONFIG_ADCRANGE		BIT(4)
 
@@ -622,6 +622,7 @@ static const struct i2c_device_id ina238_id[] = {
 MODULE_DEVICE_TABLE(i2c, ina238_id);
 
 static const struct of_device_id __maybe_unused ina238_of_match[] = {
+	{ .compatible = "ti,ina237" },
 	{ .compatible = "ti,ina238" },
 	{ },
 };

-- 
2.40.1

