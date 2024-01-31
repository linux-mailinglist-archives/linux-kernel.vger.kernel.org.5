Return-Path: <linux-kernel+bounces-46334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA1843E58
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC0B34258
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82878B6B;
	Wed, 31 Jan 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="djT64s+n"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A616DD19;
	Wed, 31 Jan 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699836; cv=none; b=JWqyWpWtwZ/VUV+WYWUKtPXkKjw9RZZjWr92wK42/GeQmfBsJktmBlFtk88wT4UQrumyrt4oV8W2egf66Hwhk2XxJ5pua/ZnauoUzfRKFPlGvEWm9dijd4hJdyQisMQsA/v4Ti0oMMx+jsuDVgMWY48AQe6Z5511+rMvAFeaEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699836; c=relaxed/simple;
	bh=+eZF0r081+xn/evibHPbfm7R+U27ETVCw7Buxo/7YCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQ/Cvsqj4l2YakAyLSdclVGgsimda7Vl9jAQLKeMbddAuWeMa+SzR0NHnc70fnKWoPyNb7PqTTBO/sEEBXGpjZzfinth517TJ9rOntFsHh9HNFkZT3AeEFivZsY9PjiO1b2kYZLPQ38gyu1rHbPGBtC6MoRvX20UxOkdrUFzzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=djT64s+n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706699824; x=1707304624; i=w_armin@gmx.de;
	bh=+eZF0r081+xn/evibHPbfm7R+U27ETVCw7Buxo/7YCA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=djT64s+nCYNMz/JIHAnyyajM68i+yJez5JgQS32x1quOmseqsylG1Ep+AbQGqBa3
	 0AIcMAOlqya/nwhc55hcvVaMiaQrJVOMctoISImK2XiEU9yJBsBgW/XI5ZwZLLUQ4
	 Uk8B4U6EfpWfj9z5uBRJ1UOxIXmQVfl/kbP5XhaGBrTHT0LYm0pAK5LVk4Mw3W/Hp
	 8LUf6puPZLvJQK9WcEuAJADsDv2SkmAPcj2SavPNmlVvtihhJfa5Cj50We72ph9PW
	 Jc/4s0dfKyLJL6kBgFluu3pN5RqM1nOu7eHWGLqUxqqQAJk7BtMGKJULXPGOkzBDG
	 yfRF0PVXxKKKrX0xaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbzyP-1quh2t1AEB-00dauX; Wed, 31 Jan 2024 12:17:04 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: dennisn@dennisn.mooo.com,
	lkml@vorpal.se,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: coproscefalo@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: toshiba_acpi: Add quirk for buttons on Z830
Date: Wed, 31 Jan 2024 12:16:41 +0100
Message-Id: <20240131111641.4418-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131111641.4418-1-W_Armin@gmx.de>
References: <20240131111641.4418-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gzUwrmSZvTtEfG9zz0+z4kEHKGKIyCQF+ZfQR9NZszSj4+HlunY
 vjtHM/RaGYNkhn0cSxxzDpaxc3TjszACNZD6cSBRHCELcRM8qUKBDtDUqjzp+oeYg92UgBj
 KOuvYHks5EGX75L7qB0CF+mrQjf9D8C5M3cNs0IR6OVAlH7OuKQJsCQaOC8Dz/TIMsPDrag
 ahoOXqXrWNtUwva0rINwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZXL9fYsXktY=;7GMb/vSrp/+mWn3J8QrIV+z2Sug
 mOBYcvxBMH7Lqhx8AVnvGRhi/A77FKa/wiELHR6Xx6exd1viov0Vdgp9SLK8RIlJfOX6sx4kd
 DZECY+YShUqamUrQPzkdBNKNvSGOvGmhxnSm/U/95RTuyKB+coKG71zi+OBNiQVt3p/yCkx66
 PN5QFfxY4yYfnuyFYjhR7IcHWCXwp7h5sZFmefHFR7vQM7BTk1shTsdzWzIxaml9qErx6zE9y
 PE3X2DwDm/t5/pYV6I5hjeapffBulIsbGmkF9yk6BbhV8SWWSQbRWopMON8sBHVnlUoAUJVE/
 z8Nwxw1vob1Kv4binIdOIJMtSQKUbfwjwl9uh+Dufn0D0Rt2d1rwyT++IFYXb3c5dmK7cXTcT
 9/8/k4sZzhfVl1Enq9EhSpNdPEB0pYWhn5FlO/dM2YoNxZ3V5hAn8LIr6IHjM+R4DMVjAEYOZ
 1NWhFENQJOmP3Ds5N+BForYnr1OdwZGHW6vy1CCwQvw9gEbZegG4UJ1BjbdIp1lwanBZUNAVg
 83wIcSMqT9TQfqOX3dmaSmRkiBypn4LinJUwv599mZ7qb/oVtnfjXCsb8XbTEZg1ejsPQlK6X
 Og69/uYaYa+GhtCH8xGnwSFT3dP/TT+gfolqJeZnw987/iT/WDRjUYUFeoJyDsVik6EkIUegG
 n2kgEyTmSgzteCKN6LesQ1jrtuTfZEgxHq/o/ciCW8NkRXSMgTQh0vaYjub5mqGfA5U9FZU1w
 HUGwpKyqOR0oFUnmEKquL3z4A8Yz9nGyp2/AbyYZlvQHrfHY1f+jE7L+w0WSh0TaMFM7neE+g
 I6gPY/8adn1ZZtqnv3xNnA8cugyN29X4dfRtXUp94JWAyOvDTfU4T1dgu7IVBP0hv75JMQxTc
 nJTXwcRRVNKljbF0gppZ09v1Un8VWHx+iVu6A2gKitVwQUVDDWALVHVL5SneyLgGO7EesFyrn
 eKI16HFBi3sdW9FlqtDaJEIrJ9c=

From: Arvid Norlander <lkml@vorpal.se>

The Z830 has some buttons that will only work properly as "quickstart"
buttons. To enable them in that mode, a value between 1 and 7 must be
used for HCI_HOTKEY_EVENT. Windows uses 0x5 on this laptop so use that for
maximum predictability and compatibility.

As there is not yet a known way of auto detection, this patch uses a DMI
quirk table. A module parameter is exposed to allow setting this on other
models for testing.

Signed-off-by: Arvid Norlander <lkml@vorpal.se>
=2D--
 drivers/platform/x86/toshiba_acpi.c | 36 ++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index 291f14ef6702..2a5a651235fe 100644
=2D-- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -57,6 +57,11 @@ module_param(turn_on_panel_on_resume, int, 0644);
 MODULE_PARM_DESC(turn_on_panel_on_resume,
 	"Call HCI_PANEL_POWER_ON on resume (-1 =3D auto, 0 =3D no, 1 =3D yes");

+static int hci_hotkey_quickstart =3D -1;
+module_param(hci_hotkey_quickstart, int, 0644);
+MODULE_PARM_DESC(hci_hotkey_quickstart,
+		 "Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support (-=
1 =3D auto, 0 =3D no, 1 =3D yes");
+
 #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"

 /* Scan code for Fn key on TOS1900 models */
@@ -136,6 +141,7 @@ MODULE_PARM_DESC(turn_on_panel_on_resume,
 #define HCI_ACCEL_MASK			0x7fff
 #define HCI_ACCEL_DIRECTION_MASK	0x8000
 #define HCI_HOTKEY_DISABLE		0x0b
+#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
 #define HCI_HOTKEY_ENABLE		0x09
 #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
 #define HCI_LCD_BRIGHTNESS_BITS		3
@@ -2730,10 +2736,15 @@ static int toshiba_acpi_enable_hotkeys(struct tosh=
iba_acpi_dev *dev)
 		return -ENODEV;

 	/*
+	 * Enable quickstart buttons if supported.
+	 *
 	 * Enable the "Special Functions" mode only if they are
 	 * supported and if they are activated.
 	 */
-	if (dev->kbd_function_keys_supported && dev->special_functions)
+	if (hci_hotkey_quickstart)
+		result =3D hci_write(dev, HCI_HOTKEY_EVENT,
+				   HCI_HOTKEY_ENABLE_QUICKSTART);
+	else if (dev->kbd_function_keys_supported && dev->special_functions)
 		result =3D hci_write(dev, HCI_HOTKEY_EVENT,
 				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
 	else
@@ -3257,7 +3268,14 @@ static const char *find_hci_method(acpi_handle hand=
le)
  * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
  * the configured brightness level.
  */
-static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] =3D {
+#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
+/*
+ * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must u=
se
+ * the value HCI_HOTKEY_ENABLE_QUICKSTART.
+ */
+#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
+
+static const struct dmi_system_id toshiba_dmi_quirks[] =3D {
 	{
 	 /* Toshiba Port=C3=A9g=C3=A9 R700 */
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D21012 */
@@ -3265,6 +3283,7 @@ static const struct dmi_system_id turn_on_panel_on_r=
esume_dmi_ids[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
 		},
+	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 R830 */
@@ -3274,6 +3293,7 @@ static const struct dmi_system_id turn_on_panel_on_r=
esume_dmi_ids[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
 		},
+	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
 	},
 	{
 	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 Z830 */
@@ -3281,6 +3301,7 @@ static const struct dmi_system_id turn_on_panel_on_r=
esume_dmi_ids[] =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
 		},
+	 .driver_data =3D (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOT=
KEY_QUICKSTART),
 	},
 };

@@ -3289,6 +3310,8 @@ static int toshiba_acpi_add(struct acpi_device *acpi=
_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
+	const struct dmi_system_id *dmi_id;
+	long quirks =3D 0;
 	int ret =3D 0;

 	if (toshiba_acpi)
@@ -3441,8 +3464,15 @@ static int toshiba_acpi_add(struct acpi_device *acp=
i_dev)
 	}
 #endif

+	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
+	if (dmi_id)
+		quirks =3D (long)dmi_id->driver_data;
+
 	if (turn_on_panel_on_resume =3D=3D -1)
-		turn_on_panel_on_resume =3D dmi_check_system(turn_on_panel_on_resume_dm=
i_ids);
+		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
+
+	if (hci_hotkey_quickstart =3D=3D -1)
+		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);

 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
=2D-
2.39.2


