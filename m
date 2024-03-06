Return-Path: <linux-kernel+bounces-94488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF787408F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C8AB22E24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD013F45D;
	Wed,  6 Mar 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pefVynv8"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DA1386A3;
	Wed,  6 Mar 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753834; cv=none; b=D+49U+6Jl6lrGS3ljnjkaYx4bubtLtPY2CwMmu0nTHGoxjZkXG17e+c1v8Cc2PrdFGJk1D3uczAlmlSugvgleYydN5ubhj9ukjpVSCycF9W0H0+KXr7BSSmH+nOUVTTP6r4X/GONN0xUoMW13Qra1YwLibXkj+WcodVdHKG0KpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753834; c=relaxed/simple;
	bh=xLUEqkI4LpMh0mVULwiRUGKtpy7yUL3zf46szV7+d0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lMKlX+LzAWPZ00z0fr6ICT2VJ6wiGBptU2j7/5mKHA80IaOQqmZxNiu1hjchKCkY/bwE6F11/fFJr/tFrIPmJR7aty8THZc3MWMk9kdCrfNPTomM5S/jibDUuwN3uJ327Ebb7GIPR/BGlVF1SJkwc3h0USQXR5Gg4Y8q+prtQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pefVynv8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709753827;
	bh=xLUEqkI4LpMh0mVULwiRUGKtpy7yUL3zf46szV7+d0Y=;
	h=From:Date:Subject:To:Cc:From;
	b=pefVynv88NHSPhb2g1ZtD1+Smq2DyjExzOiNv557oMp5UzEfHx11gdDCvj7ELwDlv
	 jGQfN8H4NOdkjV4G19iQi8UHkJhINdhIqSCMLTdIFq75wBCHRo4Ls+0m2LlTKxJBEN
	 Fv9BzPep4Md7KGEIBkZWKAYiRJnAjM1Gon3QPOuU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 06 Mar 2024 20:37:04 +0100
Subject: [PATCH v3] power: supply: test-power: implement charge_behaviour
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAN/F6GUC/43NQQ6DIBAF0Ks0rEszoqXSVe/RNAZxFJJGCCjWG
 O9edNNFNy7/ZP77CwnoDQZyPy3EYzTB2D6F/HwiSsu+Q2qalAkDloNggjo7oa/C6Nx7punFd1j
 VqGU0dvSV89bRDJRqG8El55wkyHlszWcfeb5S1iYM1s/7Zsy268YXwKA4wseMAgUuGShxLVvBH
 xOaEILSo770OJBtI7Kfm0N+yGXJLbGuQd5Uqok/d13XL2FZwl4xAQAA
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709753826; l=4455;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xLUEqkI4LpMh0mVULwiRUGKtpy7yUL3zf46szV7+d0Y=;
 b=XM1O/iQ3VKSppJ/Zg38R1HM0bv/0AImI+miKd+LnML8hFdvSBJui9EDdjQR0BH82fLhaLSd7Y
 oIE1qZ01d+oCCp5OGpKAF8gkNHz3O1bx6LYgvw/ed3FqJyRTbU7lhI9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To validate the special formatting of the "charge_behaviour" sysfs
property add it to the example driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
The original submission of the charge_behaviour property did not
implement proper formatting in the default formatting handler in
power_supply_sysfs.c.

At that time it was not a problem because the only provider of the UAPI,
thinkpad_acpi, did its own formatting.

Now there is an in-tree driver, mm8013, and out-of-tree driver which use
the normal power-supply properties and are affected by the wrong
formatting.
In this revision the handling of CHARGE_BEHAVIOUR in mm8013 is dropped
as it is not the correct API for it to use.
That change was not tested by me as I don't have the hardware.
---
Changes in v3:
- Drop already applied patches
- Validate value in test_power_set_battery_property
- Link to v2: https://lore.kernel.org/r/20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net

Changes in v2:
- Simplify the backwards-compatibility logic (adds a preparatory patch)
- Extend test-power to also handle writing of charge_behaviour
- Drop incorrect CHARGE_BEHAVIOUR from mm8013 driver
- Replace special CHARGE_BEHAVIOUR_AVAILABLE property with bitmask in
  struct power_supply_desc
- Link to v1: https://lore.kernel.org/r/20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net
---
 drivers/power/supply/test_power.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 0d0a77584c5d..442ceb7795e1 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -35,6 +35,8 @@ static int battery_capacity		= 50;
 static int battery_voltage		= 3300;
 static int battery_charge_counter	= -1000;
 static int battery_current		= -1600;
+static enum power_supply_charge_behaviour battery_charge_behaviour =
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
 
 static bool module_initialized;
 
@@ -123,6 +125,9 @@ static int test_power_get_battery_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		val->intval = battery_current;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		val->intval = battery_charge_behaviour;
+		break;
 	default:
 		pr_info("%s: some properties deliberately report errors.\n",
 			__func__);
@@ -131,6 +136,31 @@ static int test_power_get_battery_property(struct power_supply *psy,
 	return 0;
 }
 
+static int test_power_battery_property_is_writeable(struct power_supply *psy,
+						    enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
+}
+
+static int test_power_set_battery_property(struct power_supply *psy,
+					   enum power_supply_property psp,
+					   const union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		if (val->intval < 0 ||
+		    val->intval >= BITS_PER_TYPE(typeof(psy->desc->charge_behaviours)) ||
+		    !(BIT(val->intval) & psy->desc->charge_behaviours)) {
+			return -EINVAL;
+		}
+		battery_charge_behaviour = val->intval;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static enum power_supply_property test_power_ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
@@ -156,6 +186,7 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
 };
 
 static char *test_power_ac_supplied_to[] = {
@@ -178,6 +209,11 @@ static const struct power_supply_desc test_power_desc[] = {
 		.properties = test_power_battery_props,
 		.num_properties = ARRAY_SIZE(test_power_battery_props),
 		.get_property = test_power_get_battery_property,
+		.set_property = test_power_set_battery_property,
+		.property_is_writeable = test_power_battery_property_is_writeable,
+		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
+				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
+				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
 	},
 	[TEST_USB] = {
 		.name = "test_usb",

---
base-commit: 4e61f1e9d58fb0765f59f47d4d1f318b36c14d95
change-id: 20230929-power_supply-charge_behaviour_prop-10ccfd96a666

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


