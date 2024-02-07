Return-Path: <linux-kernel+bounces-55855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9184C287
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A93B1C24C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA8D528;
	Wed,  7 Feb 2024 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b="izFm5+dc"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83921F9D6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273156; cv=none; b=npRrqcIc74QMuEq7mUe4hI1w0B59wivF3wVg1Ni8EYylAw+lvz/R/KmbCB//g6ECuNOuw9zv3VspKhvsVzICnY1icxXyNzQIQkg4XdS7GlXdUoP7N3FncBcykhErU74XjEN+YXHN0yZerb9AkHsgYM7EWiId8OMhBxfRbxgNvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273156; c=relaxed/simple;
	bh=eQevGGFfOKK76esWgVcR2HYNk+G4v2RPjlX7E272UoU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sbr32xhahCwkqIy7pgJmiRa6t6gu0zGxL6eFPepG5lr8RFCE7MG+HXQntPS49NayCcoFfoVMb80wfM/KKuAFDxuNeG5AcQK+Cl8A/2iZ4sxhbtTlNWqaCgWszBu+tUVoiLE/7JAf5OU8ib+1wdj+gHUBXgYuaVhkd8DGj/FkweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art; spf=pass smtp.mailfrom=bluemarch.art; dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b=izFm5+dc; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemarch.art
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
	s=protonmail; t=1707273150; x=1707532350;
	bh=RRMxXWKiNumTivPl5zD0nktyidYv+ZyY47zXaJ9WRng=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=izFm5+dctBPeBrKstTm1tQEKGYVyUykUa4MqVoIgBrkiZClB1zBzRwwIsjbWAAoAP
	 mhCkkeU1WqAKTSuBhFt3w+vt2U9ldmM9G5xLSDBLUvXSQKa8CBTHU3LobGmHKny+eS
	 Y75dsfQC8Ggjaq1h5ecPDj+JZYG5NUwkGj7dLnNtakeOpVy0UYDCV8iBopgJhEv6Y3
	 1ReLceywm4Y26XbubW+vrhkDAtKG4owDTsoQhrnm66xACVNNJSuO1m3l1IhAEzUfiP
	 29zwwnE0rSxCpoIaj4Y03i0xIteZnVG5SqhcXJcgXFOwG4gnZAIX9IOGs5trDTBzcK
	 DlV/Qt9W0cNfA==
Date: Wed, 07 Feb 2024 02:32:15 +0000
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, jwoithe@just42.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de
From: Szilard Fabian <szfabian@bluemarch.art>
Cc: Szilard Fabian <szfabian@bluemarch.art>
Subject: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge control support
Message-ID: <20240207023031.56805-2-szfabian@bluemarch.art>
In-Reply-To: <20240129175714.164326-2-szfabian@bluemarch.art>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art>
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

Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
---
v3:
* added additional error handling
* removed if statement with device_create_file(), just returning that
  function instead
* added bool charge_control_supported into struct fujitsu_laptop
* added a 'charge_control_add' and 'charge_control_remove' function to be
  called from acpi_fujitsu_laptop_add() and acpi_fujitsu_laptop_remove()
* moved FUJ02E3 S006 probing logic from the ACPI battery hooks to the new
  'charge_control_*' functions

v2:
Forgot to sign-off the original commit. Fixed, sorry for the
inconvenience.
---
 drivers/platform/x86/fujitsu-laptop.c | 125 ++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/f=
ujitsu-laptop.c
index 085e044e888e..2fcbc10a0d9d 100644
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
@@ -132,6 +138,7 @@ struct fujitsu_laptop {
 =09spinlock_t fifo_lock;
 =09int flags_supported;
 =09int flags_state;
+=09bool charge_control_supported;
 };
=20
 static struct acpi_device *fext;
@@ -164,6 +171,118 @@ static int call_fext_func(struct acpi_device *device,
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
+=09if (s006_cc_return < 0)
+=09=09return s006_cc_return;
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
+=09if (status < 0)
+=09=09return status;
+
+=09return sprintf(buf, "%d\n", status);
+}
+
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+
+/* ACPI battery hook */
+
+static int fujitsu_battery_add_hook(struct power_supply *battery,
+=09=09=09       struct acpi_battery_hook *hook)
+{
+=09return device_create_file(&battery->dev,
+=09=09=09=09  &dev_attr_charge_control_end_threshold);
+}
+
+static int fujitsu_battery_remove_hook(struct power_supply *battery,
+=09=09=09=09  struct acpi_battery_hook *hook)
+{
+=09device_remove_file(&battery->dev,
+=09=09=09   &dev_attr_charge_control_end_threshold);
+
+=09return 0;
+}
+
+static struct acpi_battery_hook battery_hook =3D {
+=09.add_battery =3D fujitsu_battery_add_hook,
+=09.remove_battery =3D fujitsu_battery_remove_hook,
+=09.name =3D "Fujitsu Battery Extension",
+};
+
+/*
+ * These functions are intended to be called from acpi_fujitsu_laptop_add =
and
+ * acpi_fujitsu_laptop_remove.
+ */
+
+static int fujitsu_battery_charge_control_add(struct acpi_device *device)
+{
+=09struct fujitsu_laptop *priv =3D acpi_driver_data(device);
+=09priv->charge_control_supported =3D false;
+
+=09/*
+=09 * Check if the S006 0x21 method exists by trying to get the current
+=09 * battery charge limit.
+=09 */
+=09int s006_cc_return;
+=09s006_cc_return =3D call_fext_func(fext, FUNC_S006_METHOD,
+=09=09=09=09=09CHARGE_CONTROL_RW, 0x21, 0x0);
+
+=09if (s006_cc_return < 0)
+=09=09return s006_cc_return;
+
+=09if (s006_cc_return =3D=3D UNSUPPORTED_CMD)
+=09=09return -ENODEV;
+
+=09priv->charge_control_supported =3D true;
+=09battery_hook_register(&battery_hook);
+
+=09return 0;
+}
+
+static void fujitsu_battery_charge_control_remove(struct acpi_device *devi=
ce)
+{
+=09struct fujitsu_laptop *priv =3D acpi_driver_data(device);
+
+=09if (priv->charge_control_supported)
+=09=09battery_hook_unregister(&battery_hook);
+}
+
 /* Hardware access for LCD brightness control */
=20
 static int set_lcd_level(struct acpi_device *device, int level)
@@ -839,6 +958,10 @@ static int acpi_fujitsu_laptop_add(struct acpi_device =
*device)
 =09if (ret)
 =09=09goto err_free_fifo;
=20
+=09ret =3D fujitsu_battery_charge_control_add(device);
+=09if (ret < 0)
+=09=09pr_warn("Unable to register battery charge control: %d\n", ret);
+
 =09return 0;
=20
 err_free_fifo:
@@ -851,6 +974,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_devi=
ce *device)
 {
 =09struct fujitsu_laptop *priv =3D acpi_driver_data(device);
=20
+=09fujitsu_battery_charge_control_remove(device);
+
 =09fujitsu_laptop_platform_remove(device);
=20
 =09kfifo_free(&priv->fifo);
--=20
2.43.0



