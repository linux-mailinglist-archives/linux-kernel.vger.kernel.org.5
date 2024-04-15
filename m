Return-Path: <linux-kernel+bounces-145747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D698A5A56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7B2B21F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47B155A32;
	Mon, 15 Apr 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0OcTwWiW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8269DE4;
	Mon, 15 Apr 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207936; cv=none; b=tWd7ZGMCYVTxwnwqqYoPtqpDwzqoc2DXAYfgDYBI0vZzJsnVNYJjQsN/kHMnPW13K3aAHLGRbxprbB1bDkzJjPVzel/4p/iCi4BVeLKWaO1Y8UpQ200wP64zGyKWPWNoJyhKrvh2meSiBz67BVfztKRJ38esVW2QNeeiGSvNPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207936; c=relaxed/simple;
	bh=X6aFBbtbhlwjSibF1VZUjZZxSmOI1D+UMTgw0IW9PEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k4wXx+pODjsdDSs/vhGbDydj7aBMDpcE0gzyIyeFpfaA92EmWF8T4DAN5hte6X5H7R7YSoBAR982ihxNj0UJZZomVWhRvOMrgjLkAfBCYM5UgYAftRJ3hlfD+YK0/BphMux3jqEazcZa4OhLP9NXg9vLFQ0EtpnJuO/V1VFSJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0OcTwWiW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713207932;
	bh=X6aFBbtbhlwjSibF1VZUjZZxSmOI1D+UMTgw0IW9PEk=;
	h=From:Date:Subject:To:Cc:From;
	b=0OcTwWiWCtRVuE77yuxqUFcIYOrmqNgQPxsN1PMsCx3xqNdqRWGp8pF9+0Wwr9x90
	 Dr1Zx8LV9kChdlcB8eQAVfeUETnsBD6FlPCwbxzhYRUiMiIep+db0+7TJJid7Cek5I
	 bsCKkqPWAMQGdDsl5NMfujf2tDGM5VNPQ4h0m49Vq+lSWtev/g91rUQEoBmR9T/WqS
	 OYaaWrfHCAlQKfhvTLuwdeHHV9aT4en78p1Eu6zU4arvAt8kZJjst0IYpy1kdQahWs
	 POr369JPCvD8z2siHYb4NIZzBqyAXoKEnyeBz7EpB4ErNeiUzbGJOQsQFNzuTMKFxl
	 lFxq1fJ+Rs4UA==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A2AB37820EF;
	Mon, 15 Apr 2024 19:05:32 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 15 Apr 2024 15:05:28 -0400
Subject: [PATCH v2] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240415-sbs-time-empty-now-error-v2-1-32d8a747e308@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHd6HWYC/42NQQqDQAxFryKzbkrMCEpXvUdxoWOsATWSEVsR7
 95pT1D+6n347x8usglHd8sOZ7xJFJ0T0CVzYWjmJ4N0iR0hFeixhNhGWGVi4GlZd5j1BWymBp6
 oDVgWne/Jpfli3Mv7p37UiQeJq9r+e9ryb/uHdMshpeqwr0ok7/EedBybVq25Bp1cfZ7nBxpTz
 OXEAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
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
Changes in v2:
- Reworked patch to lay down and use a proper quirk infrastructure, and
  update the quirks on the presence update callback so it works properly
  even when hot-plugging different batteries
- Link to v1: https://lore.kernel.org/r/20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com
---
 drivers/power/supply/sbs-battery.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a6c204c08232..92acbda9e78e 100644
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
+	const char *model;
+	const char *manufacturer;
+	unsigned int i = 0;
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
base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
change-id: 20240307-sbs-time-empty-now-error-322bc074d3f2

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


