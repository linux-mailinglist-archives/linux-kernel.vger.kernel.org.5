Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55BC7C5A89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjJKRuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJKRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:50:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780A98;
        Wed, 11 Oct 2023 10:50:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40566f8a093so1606925e9.3;
        Wed, 11 Oct 2023 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697046644; x=1697651444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP+zcpcY4L8UQr12IXOv8iX0tyZpjo9Hcziw+ngC5Ew=;
        b=eClB0p8IfHWHrHOWn8Qy2fG6s5mBrLkirEMvafky0vDCOlRZauN1ya7cj2pZh+dAIX
         WXLpZ2l/U+2z49CIlwdTVD48YeKnOCJIrrMcY8Mv8PH0JsfjkLHBuY6aegslllcL55qB
         0gwz//9HUmO6hRHvRyhFBfpJ+DFJMvoJsCRnh5D8mzNvka22t/pvmEC/N5gW+paRNuVu
         c7UpIRCk+maxFkvugY13UmLGLDlUwhlS0X/IZnrb8mCEXcRlVrKUGvfqdTFDcXFwBb//
         AdYSWmjPgJlqBIChi3yy4xWq8rRNQ3HOoozT8S48tS1EYLWIOLQMISGvM9kS6IXFx3et
         NVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046644; x=1697651444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP+zcpcY4L8UQr12IXOv8iX0tyZpjo9Hcziw+ngC5Ew=;
        b=oKtXztxlbEVv18jmnDvMP1+pkpvcK6KyM9VasjgHa2xPS4cJJGgGaGU4PIGdsKXVi4
         luiVNbY+kQAhrw7ZQebBLjmdRyytYOLcbDfeKPgHgZtOUFvZyevV4r/Bi8PjWcaIX9sU
         mGgfXaRo8sxkF4MQ7Tu+hDGKC5l/T6StvHQOzrJd3FGKVTVKeaAoOhhEkjn3i6f5ydj4
         oN3iPDlsL8aZm/bb1t1GHgOdlZnu0nDOVJeDnZs7WOV7xMOiB5kd5kDYSudfKzUiujyS
         0eYk3A8vCiNg47GXd5lPGCyg0mykzHeUxh+9Yuceh46p7dqH3rTnoYv4OhaNa2aLTRH3
         bWCg==
X-Gm-Message-State: AOJu0YzwwrZap3UIMKuEV3oPGG0Yb6IfNTGPS4OE8+kz1W7NHRC95lVK
        nhAwRWFDnhFYX2UELOvz0En0bBigrparueP+FM8=
X-Google-Smtp-Source: AGHT+IGnLacLwFRfiKUzu/I423WVEyqhmENuuVZ09ysfbGiuIbod3nrnsXuldgoCDGsvlZIzf6l/kQ==
X-Received: by 2002:a05:600c:2146:b0:405:458d:d54 with SMTP id v6-20020a05600c214600b00405458d0d54mr19668199wml.33.1697046643995;
        Wed, 11 Oct 2023 10:50:43 -0700 (PDT)
Received: from dell.intranet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b00406847c988asm19658788wmb.12.2023.10.11.10.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:50:43 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] ARM: OMAP1: ams-delta: Fix MODEM initialization failure
Date:   Wed, 11 Oct 2023 19:49:55 +0200
Message-ID: <20231011175038.1907629-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator drivers were modified to use asynchronous device probe.  Since
then, the board .init_late hook fails to acquire a GPIO based fixed
regulator needed by an on-board voice MODEM device, and unregisters the
MODEM.  That in turn triggers a so far not discovered bug of device
unregister function called for a device with no associated release() op.

serial8250 serial8250.1: incomplete constraints, dummy supplies not allowed
WARNING: CPU: 0 PID: 1 at drivers/base/core.c:2486 device_release+0x98/0xa8
Device 'serial8250.1' does not have a release() function, it is broken and
 must be fixed. See Documentation/core-api/kobject.rst.
...
put_device from platform_device_put+0x1c/0x24
platform_device_put from ams_delta_init_late+0x4c/0x68
ams_delta_init_late from init_machine_late+0x1c/0x94
init_machine_late from do_one_initcall+0x60/0x1d4

As a consequence, ASoC CODEC driver is no longer able to control its
device over the voice MODEM's tty interface.

cx20442-codec: ASoC: error at soc_component_write_no_lock
 on cx20442-codec for register: [0x00000000] -5
cx20442-codec: ASoC: error at snd_soc_component_update_bits_legacy
 on cx20442-codec for register: [0x00000000] -5
cx20442-codec: ASoC: error at snd_soc_component_update_bits
 on cx20442-codec for register: [0x00000000] -5

The regulator hangs of a GPIO pin controlled by basic-mmio-gpio driver.
Unlike most GPIO drivers, that driver doesn't probe for devices before
device_initcall, then GPIO pins under its control are not availabele to
majority of devices probed at that phase, including regulators.  On the
other hand, serial8250 driver used by the MODEM device neither accepts via
platform data nor handles regulators, then the board file is not able to
teach that driver to return -EPROBE_DEFER when the regulator is not ready
so the failed probe is retried after late_initcall.

Resolve the issue by extending description of the MODEM device with a
dedicated power management domain.  Acquire the regulator from the
domain's .activate hook and return -EPROBE_DEFER if the regulator is not
available.  Having that under control, add the regulator device
description to the list of platform devices initialized from .init_machine
and drop the no longer needed custom .init_late hook.

v2: Trim down the warning for prettier git log output (Tony).

Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org # v6.4+
---
 arch/arm/mach-omap1/board-ams-delta.c | 60 +++++++--------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 9808cd27e2cf..67de96c7717d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -550,6 +550,7 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 	&cx20442_codec_device,
+	&modem_nreset_device,
 };
 
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
@@ -782,26 +783,28 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{ },
 };
 
+static int ams_delta_modem_pm_activate(struct device *dev)
+{
+	modem_priv.regulator = regulator_get(dev, "RESET#");
+	if (IS_ERR(modem_priv.regulator))
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
+static struct dev_pm_domain ams_delta_modem_pm_domain = {
+	.activate	= ams_delta_modem_pm_activate,
+};
+
 static struct platform_device ams_delta_modem_device = {
 	.name	= "serial8250",
 	.id	= PLAT8250_DEV_PLATFORM1,
 	.dev		= {
 		.platform_data = ams_delta_modem_ports,
+		.pm_domain = &ams_delta_modem_pm_domain,
 	},
 };
 
-static int __init modem_nreset_init(void)
-{
-	int err;
-
-	err = platform_device_register(&modem_nreset_device);
-	if (err)
-		pr_err("Couldn't register the modem regulator device\n");
-
-	return err;
-}
-
-
 /*
  * This function expects MODEM IRQ number already assigned to the port.
  * The MODEM device requires its RESET# pin kept high during probe.
@@ -833,37 +836,6 @@ static int __init ams_delta_modem_init(void)
 }
 arch_initcall_sync(ams_delta_modem_init);
 
-static int __init late_init(void)
-{
-	int err;
-
-	err = modem_nreset_init();
-	if (err)
-		return err;
-
-	/*
-	 * Once the modem device is registered, the modem_nreset
-	 * regulator can be requested on behalf of that device.
-	 */
-	modem_priv.regulator = regulator_get(&ams_delta_modem_device.dev,
-			"RESET#");
-	if (IS_ERR(modem_priv.regulator)) {
-		err = PTR_ERR(modem_priv.regulator);
-		goto unregister;
-	}
-	return 0;
-
-unregister:
-	platform_device_unregister(&ams_delta_modem_device);
-	return err;
-}
-
-static void __init ams_delta_init_late(void)
-{
-	omap1_init_late();
-	late_init();
-}
-
 static void __init ams_delta_map_io(void)
 {
 	omap1_map_io();
@@ -877,7 +849,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
-	.init_late	= ams_delta_init_late,
+	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
 	.restart	= omap1_restart,
 MACHINE_END
-- 
2.42.0

