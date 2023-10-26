Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D557D7D64
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjJZHJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:08:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915118D;
        Thu, 26 Oct 2023 00:08:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BE74C433C8;
        Thu, 26 Oct 2023 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698304136; bh=DtHEPpID31tWjOLNIsg0s4zUFeieNUVEZ4/N6Xx8pBg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=biGaYkkIUXadCEOFWeaIlYmd0qN+5dJ1N+wpmgNw8dCBl496EPn16AiOlPtfBDkaq
         Xyv9Is543zyCs79WwACLAlE4XpLIhSMHHzVGczIfJUIYM8fU+Zp0w6JTd7S1WYvYRh
         y5BCnRVy9kGS+6oIMlvAjl67lZzpi3Niqc1fd3Xc=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DAC25B6F;
        Thu, 26 Oct 2023 07:08:56 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Thu, 26 Oct 2023 09:08:49 +0200
Subject: [PATCH v2 1/2] hwmon: ina238: add ina237 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231026-ina237-v2-1-dec44811a3c9@linux.dev>
References: <20231026-ina237-v2-0-dec44811a3c9@linux.dev>
In-Reply-To: <20231026-ina237-v2-0-dec44811a3c9@linux.dev>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698304135; l=1834;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=DtHEPpID31tWjOLNIsg0s4zUFeieNUVEZ4/N6Xx8pBg=; =?utf-8?q?b=3D13wTgnzZ8eFG?=
 =?utf-8?q?RhrZN8Iy6HnVFnWae7sKkzOY1EB9lahUvsEaMjrzh58PdKXFtZqWYG1DlKwUCmNu?=
 SF/WJvJ6DCmsg0NCCMCpjc24QzR2ARIwZsT27DB5zMKxDEoZzUUd
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=ZYa5+0m9RFYtnNU6DLet7sHyPehnVHa0ucJlYiAu2NU=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20231025 with auth_id=90
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

