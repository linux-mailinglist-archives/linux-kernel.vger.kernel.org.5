Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71FB76D781
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjHBTMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:12:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BFC26B2;
        Wed,  2 Aug 2023 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l0fagwpjnO0mCXCu/hb1J7U1QL4bJjiaBDvQnvA0kiY=; b=ZJHc5KT4QuCBR5z+VPN0cY+pvX
        WORp8NjEOqITE7KRFKUnPYZq88XtaWHbNuuPPJ7/20deZo9pJflnY07ZnqZDJe7UQI3R4Y86bkLd6
        hBgQT3V0R7mfT3J0g6YIIE0IgeKl/sj7Z6kAyLcaiRb4kprANGXj3No1FuQQMRWaJpog=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:50458 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRHGM-0003z2-Ie; Wed, 02 Aug 2023 15:12:03 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        bruno.thomsen@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Wed,  2 Aug 2023 15:11:53 -0400
Message-Id: <20230802191153.952667-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230802191153.952667-1-hugo@hugovil.com>
References: <20230802191153.952667-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 2/2] rtc: pcf2127: add support for battery-related DT properties
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add support for "battery-switch-over-enable" DT property which can be
used to enable/disable the battery switch over function.

Also add support for "battery-low-detect-enable" DT property which can
be used to enable/disable the battery low detection function.

If any of these properties is not defined, then no alteration to the
PWRMNG field will occur.

These properties can be used to change the default power-on values
(PWRMNG) for battery-related functions. It is especially useful for
the PCF2131 where the default PWRMNG power-on values disable by
default the battery-related functions (contrary to the PCF2127).

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 78141bb06ab0..3bb3ad95c67e 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -48,6 +49,7 @@
 #define PCF2127_BIT_CTRL3_BLF			BIT(2)
 #define PCF2127_BIT_CTRL3_BF			BIT(3)
 #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
+#define PCF2127_CTRL3_PWRMNG_MASK		GENMASK(7, 5)
 /* Time and date registers */
 #define PCF2127_REG_TIME_BASE		0x03
 #define PCF2127_BIT_SC_OSF			BIT(7)
@@ -1080,6 +1082,57 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
 	return ret;
 }
 
+/*
+ * By default, do not reconfigure or set default power management mode,
+ * unless explicitly requested via DT properties:
+ *   battery-switch-over
+ *   battery-low-detect
+ */
+static int pcf2127_configure_power_management(struct device *dev)
+{
+	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
+	int ret;
+	u8 pwrmng;
+	u32 bat_sw_over, bat_low_detect;
+
+	/*
+	 * The PWRMNG field is defined in a peculiar way for PCF21XX
+	 * devices: there is no individual bit defined for the
+	 * battery-switch-over or battery-low-detect functions.
+	 * Therefore, we require that both properties must be defined
+	 * to alter the PWRMNG field.
+	 */
+	if (device_property_read_u32(dev, "battery-switch-over", &bat_sw_over))
+		return 0;
+
+	if (device_property_read_u32(dev, "battery-low-detect",
+				     &bat_low_detect))
+		return 0;
+
+	if (!bat_sw_over) {
+		/*
+		 * If battery-switch-over is disabled, then the
+		 * battery-low-detect function is always disabled.
+		 */
+		pwrmng = BIT(2) | BIT(1) | BIT(0);
+	} else {
+		if (bat_low_detect)
+			pwrmng = 0;
+		else
+			pwrmng = BIT(0);
+	}
+
+	ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
+				 PCF2127_CTRL3_PWRMNG_MASK,
+				 FIELD_PREP(PCF2127_CTRL3_PWRMNG_MASK, pwrmng));
+	if (ret < 0) {
+		dev_dbg(dev, "PWRMNG config failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /* Route all interrupt sources to INT A pin. */
 static int pcf2127_configure_interrupt_pins(struct device *dev)
 {
@@ -1163,6 +1216,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		pcf2127->irq_enabled = true;
 	}
 
+	ret = pcf2127_configure_power_management(dev);
+	if (ret) {
+		dev_err(dev, "failed to configure power management\n");
+		return ret;
+	}
+
 	if (alarm_irq > 0 || device_property_read_bool(dev, "wakeup-source")) {
 		device_init_wakeup(dev, true);
 		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
-- 
2.30.2

