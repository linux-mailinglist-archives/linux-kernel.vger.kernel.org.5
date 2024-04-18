Return-Path: <linux-kernel+bounces-150578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C628AA12F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178EB282263
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E1174EFA;
	Thu, 18 Apr 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ucUznlry"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B316F90B;
	Thu, 18 Apr 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461679; cv=none; b=Xq4t3Rp3HHAdBj5rvWfoTabuZHAOkxj6C7vC386+GfHqANpLzVHD1m6V5ghXkvjHl6MpfKpar5c/GNDWkOwDhO3t7nTVeLEKdQz+lu2Qx+B35Nhpg+DNKWSUC+lptXKWEx//LamwcLaQYsn8tffgW3VUB92hDAsb7ds+hWlUMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461679; c=relaxed/simple;
	bh=aSOlDtXfnoNb1Z9CPHP6trAdAlR49xjDenwsvM/gJEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZDVDYKghP6WRNr0q39kSX6cdYFzfNSFxoUeLODILLmuee06gAe8XyW39+1NHTZ5BJu1LYi7XRacpLbdkxtcf6ssLA6oJhiyTTZA7Yf1zNm7IhQzKkFCsrJbrctDBEeRfsRcAeXqEQZT1xNmAAdw9BDWTRWXEl/ycSosswB2b6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ucUznlry; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713461676;
	bh=aSOlDtXfnoNb1Z9CPHP6trAdAlR49xjDenwsvM/gJEM=;
	h=From:Date:Subject:To:Cc:From;
	b=ucUznlryLKYWpQsLIHxnESZSs/IzNNXQLGoKo1TYGEfeg2ISLBfyFpbAU9QPPQEl8
	 Hh6BtolN7Xa2q8wTvnVPGtOBmJTkDdW1asTyLC1nsR+a8loYcF5kUruoszw55QPrO9
	 LQylunK/2kLQQmyrh+4kwBkwyHNxQmCI00HjtUVtlCe45o+h9sIWLOHwtUz0oBq2kQ
	 BFxZY/lQeAadpni9G5cKnlYdCxW8H8SjEK41c/Qu2klsdMkar2QndAvWGX9ur3qcLd
	 IYMDeoh7UYO8cDSDTkXf9SskpHsE2HUzLO4juRXt9iwDmBvhf2rCuIrs4FR4ipK1SQ
	 2pE8lLKfcQaoA==
Received: from [192.168.1.156] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 881C237813E3;
	Thu, 18 Apr 2024 17:34:34 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 18 Apr 2024 13:34:23 -0400
Subject: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJ5ZIWYC/43NwQrCMAyA4VcZPVvp0kqLJ99DPHRt5grbKumoj
 rF3t9tF8CCS0x/Il4UlpICJnauFEeaQQhxLyEPFXGfHO/LgSzMQoIQUmqcm8SkMyHF4TDMf45M
 jUSQuARontPKyBVbOH4RteO309Va6C2mKNO+fcr1t/0BzzcsYL1qjBUgpLi72vW0i2aOLA9vgD
 B9M1acfGBRMgjdWK41SmG9sXdc3S78KnhEBAAA=
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
specification as required, it seems that not all batteries implement it.
On platforms with such batteries, reading the property will cause an
error to be printed:

power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5

This not only pollutes the log, distracting from real problems on the
device, but also prevents the uevent file from being read since it
contains all properties, including the faulty one.

The following table summarizes the findings for a handful of platforms:

Platform                                Status  Manufacturer    Model
------------------------------------------------------------------------
mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
rk3399-gru-kevin                        OK      SDI             4352D51

Detect if this is one of the quirky batteries during presence update, so
that hot-plugging works as expected, and if so report -ENODATA for
POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
prevents throwing errors.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v3:
- Reordered variable declarations and removed unneeded initialization
- Link to v2: https://lore.kernel.org/r/20240415-sbs-time-empty-now-error-v2-1-32d8a747e308@collabora.com

Changes in v2:
- Reworked patch to lay down and use a proper quirk infrastructure, and
  update the quirks on the presence update callback so it works properly
  even when hot-plugging different batteries
- Link to v1: https://lore.kernel.org/r/20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com
---
 drivers/power/supply/sbs-battery.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a6c204c08232..2b1481b81b78 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -214,6 +214,7 @@ struct sbs_info {
 	struct delayed_work		work;
 	struct mutex			mode_lock;
 	u32				flags;
+	u32				quirks;
 	int				technology;
 	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
 };
@@ -263,6 +264,54 @@ static void sbs_disable_charger_broadcasts(struct sbs_info *chip)
 		dev_dbg(&chip->client->dev, "%s\n", __func__);
 }
 
+/* Required by the spec, but missing in some implementations */
+#define SBS_QUIRK_BROKEN_TTE_NOW	BIT(0)
+
+struct sbs_quirk_entry {
+	const char *manufacturer;
+	const char *model;
+	u32 flags;
+};
+
+static const struct sbs_quirk_entry sbs_quirks[] = {
+	{"PANASON", "AP16L5J", SBS_QUIRK_BROKEN_TTE_NOW},
+	{"PANASON", "AP15O5L", SBS_QUIRK_BROKEN_TTE_NOW},
+	{"LGC KT0", "AP16L8J", SBS_QUIRK_BROKEN_TTE_NOW},
+	{"Murata", "AP18C4K", SBS_QUIRK_BROKEN_TTE_NOW},
+	{"333-AC-0D-A", "GG02047XL", SBS_QUIRK_BROKEN_TTE_NOW},
+};
+
+static const char *sbs_get_constant_string(struct sbs_info *chip,
+					   enum power_supply_property psp);
+
+static void sbs_update_quirks(struct sbs_info *chip)
+{
+	const char *manufacturer;
+	const char *model;
+	unsigned int i;
+
+	/* reset quirks from battery before the hot-plug event */
+	chip->quirks = 0;
+
+	manufacturer = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MANUFACTURER);
+	model = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NAME);
+	if (IS_ERR(manufacturer) || IS_ERR(model)) {
+		dev_warn(&chip->client->dev, "Couldn't read manufacturer and model to set quirks\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sbs_quirks); i++) {
+		if (strcmp(manufacturer, sbs_quirks[i].manufacturer))
+			continue;
+		if (strcmp(model, sbs_quirks[i].model))
+			continue;
+		chip->quirks |= sbs_quirks[i].flags;
+	}
+
+	if (chip->quirks & SBS_QUIRK_BROKEN_TTE_NOW)
+		dev_info(&chip->client->dev, "Added quirk disabling TIME_TO_EMPTY_NOW\n");
+}
+
 static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 {
 	struct i2c_client *client = chip->client;
@@ -323,6 +372,8 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
 		"enabled" : "disabled");
 
+	sbs_update_quirks(chip);
+
 	if (!chip->is_present && is_present && !chip->charger_broadcasts)
 		sbs_disable_charger_broadcasts(chip);
 
@@ -614,6 +665,10 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	s32 ret;
 
+	if (psp == POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW &&
+	    chip->quirks & SBS_QUIRK_BROKEN_TTE_NOW)
+		return -ENODATA;
+
 	ret = sbs_read_word_data(client, sbs_data[reg_offset].addr);
 	if (ret < 0)
 		return ret;

---
base-commit: 7b4f2bc91c15fdcf948bb2d9741a9d7d54303f8d
change-id: 20240307-sbs-time-empty-now-error-322bc074d3f2

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


