Return-Path: <linux-kernel+bounces-43127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4B840BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BEA1F25144
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4896515A482;
	Mon, 29 Jan 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b="mdH6IaVD"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24E15A493;
	Mon, 29 Jan 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546202; cv=none; b=Y2lgSsLxp4gOdJGMcgfP0FaqQFuEjzFNYTa4f0FvEPlhcNhj5x10WBBaHWfsLPyC6Kq1CwQA1z+v8YgqKZRMHQKUKJMofcwPKo5RPqQ+caLsjlVI5v88ofieojq5rZ444kHglWr0FAXV6XPT8Ilypr2HaqJcAuaTb6h4jtdPJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546202; c=relaxed/simple;
	bh=l8roFfgwgVf/q6EsSpxj+S5HWm0zPj8ehUUy6GtK4j8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iIR/VFbakn1ac71nQ2P5TpfJPMMQPVcUvRk/GpaiU/p0CaELi2gr4fkyV/Cnq87qH2VMlQ8JicrsT3arFPK3Go18OrFkwJZt4c80ZGR4c5NpYEKeFOilQNvqiOvr7E2JRvJgw9Q6ad6QfseRE0pdl0A0FEL5gl+FASZRzJwFq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art; spf=pass smtp.mailfrom=bluemarch.art; dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b=mdH6IaVD; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemarch.art
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
	s=protonmail; t=1706546188; x=1706805388;
	bh=Pz5S2tybGQXBc/sGlP5HtlTloY+yieTdkiBNNBw2Rds=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mdH6IaVDjHg+RLsD1E8Ka3HL8wHZLvcxukkgQN3VQJwTKbXQ/HQ1WwsOKapXWCEh0
	 1BwJzVPCYBtyHtcgcTWj5VwHPC8Mkdi0vyDxx9Kg6fbp3GHFFWEcAsAqp2DrSLuX/q
	 dtCA7C8dzMQ3fD1aToy6dfrUhJeMLXvusWGGp9RlyuGEJrd/O4ENN7fSAk+Bvmvnkq
	 iE+PUiqEbQH/Qoek41mqsPZ0yBCDaLEBIi90crJkRJOdDwcjrulNmfzoSMP1ZJ2ldh
	 hrfEVwRw+g31JeJTDTrQmwUaw7bOV3sKrUzxCVEXfp305dV3rtYMkO5oTQ9lZUazvJ
	 ugwzxn9syRALg==
Date: Mon, 29 Jan 2024 16:36:21 +0000
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, jwoithe@just42.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
From: Szilard Fabian <szfabian@bluemarch.art>
Cc: Szilard Fabian <szfabian@bluemarch.art>
Subject: [RFC PATCH] platform/x86/fujitsu-laptop: Add battery charge control support
Message-ID: <20240129163502.161409-2-szfabian@bluemarch.art>
Feedback-ID: 87830438:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch adds battery charge control support on Fujitsu notebooks
via the S006 method of the FUJ02E3 ACPI device. With this method it's
possible to set charge_control_end_threshold between 50 and 100%.

Tested on Lifebook E5411 and Lifebook U728. Sadly I can't test this
patch on a dual battery one, but I didn't find any clue about
independent battery charge control on dual battery Fujitsu notebooks
either. And by that I mean checking the DSDT table of various Lifebook
notebooks and reverse engineering FUJ02E3.dll.
---
 drivers/platform/x86/fujitsu-laptop.c | 95 +++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/f=
ujitsu-laptop.c
index 085e044e888e..bf3df74e4d63 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -49,6 +49,8 @@
 #include <linux/kfifo.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <acpi/battery.h>
 #include <acpi/video.h>
=20
 #define FUJITSU_DRIVER_VERSION=09=09"0.6.0"
@@ -97,6 +99,10 @@
 #define BACKLIGHT_OFF=09=09=09(BIT(0) | BIT(1))
 #define BACKLIGHT_ON=09=09=090
=20
+/* FUNC interface - battery control interface */
+#define FUNC_S006_METHOD=09=090x1006
+#define CHARGE_CONTROL_RW=09=090x21
+
 /* Scancodes read from the GIRB register */
 #define KEY1_CODE=09=09=090x410
 #define KEY2_CODE=09=09=090x411
@@ -164,6 +170,91 @@ static int call_fext_func(struct acpi_device *device,
 =09return value;
 }
=20
+/* Battery charge control code */
+
+static ssize_t charge_control_end_threshold_store(struct device *dev,
+=09=09=09=09struct device_attribute *attr,
+=09=09=09=09const char *buf, size_t count)
+{
+=09int value, ret;
+
+=09ret =3D kstrtouint(buf, 10, &value);
+=09if (ret)
+=09=09return ret;
+
+=09if (value < 50 || value > 100)
+=09=09return -EINVAL;
+
+=09int cc_end_value, s006_cc_return;
+
+=09cc_end_value =3D value * 0x100 + 0x20;
+=09s006_cc_return =3D call_fext_func(fext, FUNC_S006_METHOD,
+=09=09=09=09=09CHARGE_CONTROL_RW, cc_end_value, 0x0);
+
+=09/*
+=09 * The S006 0x21 method returns 0x00 in case the provided value
+=09 * is invalid.
+=09 */
+=09if (s006_cc_return =3D=3D 0x00)
+=09=09return -EINVAL;
+
+=09return count;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev,
+=09=09=09=09struct device_attribute *attr,
+=09=09=09=09char *buf)
+{
+=09int status;
+=09status =3D call_fext_func(fext, FUNC_S006_METHOD,
+=09=09=09=09CHARGE_CONTROL_RW, 0x21, 0x0);
+
+=09return sprintf(buf, "%d\n", status);
+}
+
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+
+/* ACPI battery hook */
+
+static int fujitsu_battery_add(struct power_supply *battery,
+=09=09=09       struct acpi_battery_hook *hook)
+{
+=09/* Check if there is an existing FUJ02E3 ACPI device. */
+=09if (fext =3D=3D NULL)
+=09=09return -ENODEV;
+
+=09/*
+=09 * Check if the S006 0x21 method exists by trying to get the current
+=09 * battery charge limit.
+=09 */
+=09int s006_cc_return;
+=09s006_cc_return =3D call_fext_func(fext, FUNC_S006_METHOD,
+=09=09=09=09=09CHARGE_CONTROL_RW, 0x21, 0x0);
+=09if (s006_cc_return =3D=3D UNSUPPORTED_CMD)
+=09=09return -ENODEV;
+
+=09if (device_create_file(&battery->dev,
+=09=09=09       &dev_attr_charge_control_end_threshold))
+=09=09return -ENODEV;
+
+=09return 0;
+}
+
+static int fujitsu_battery_remove(struct power_supply *battery,
+=09=09=09=09  struct acpi_battery_hook *hook)
+{
+=09device_remove_file(&battery->dev,
+=09=09=09   &dev_attr_charge_control_end_threshold);
+
+=09return 0;
+}
+
+static struct acpi_battery_hook battery_hook =3D {
+=09.add_battery =3D fujitsu_battery_add,
+=09.remove_battery =3D fujitsu_battery_remove,
+=09.name =3D "Fujitsu Battery Extension",
+};
+
 /* Hardware access for LCD brightness control */
=20
 static int set_lcd_level(struct acpi_device *device, int level)
@@ -839,6 +930,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *=
device)
 =09if (ret)
 =09=09goto err_free_fifo;
=20
+=09battery_hook_register(&battery_hook);
+
 =09return 0;
=20
 err_free_fifo:
@@ -851,6 +944,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_devi=
ce *device)
 {
 =09struct fujitsu_laptop *priv =3D acpi_driver_data(device);
=20
+=09battery_hook_unregister(&battery_hook);
+
 =09fujitsu_laptop_platform_remove(device);
=20
 =09kfifo_free(&priv->fifo);
--=20
2.43.0



