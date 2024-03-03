Return-Path: <linux-kernel+bounces-89803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B686F5E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8141F22B5E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F64A692E9;
	Sun,  3 Mar 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ed4xwleR"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB367A1D;
	Sun,  3 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479893; cv=none; b=cEFgVdzYyjdIxLg0U0OLypbebUSeZSydgbadap10l3oKIdTrw9BJK20dsbhJLv/VyQxei/4MyODjXZd4FNLblyOjeUw29od55EV4aV3l6K2QVU/ksZG3H8PY/in50ucx1R1wNLILotz+xSDPZcPANVip2GTpI/YlMQzIHAECClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479893; c=relaxed/simple;
	bh=uSL4zHrRtxegcQPlUUbn7PFzXuC2VWmGYlhL0gi2nWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiB9BYX8qHMrL0Wr64N1d4KRrWs+Y5Z0vtgdUy2WjvKK783BrscenvWt4fgwe0GSxcvOhAU3u2Xblp7tcMEqMyC9+G9nFlSEoKuKkMgwydoYEhb1mO9PDhymjmnQQ5GUWCBbljXOA0zkMS//sCtV67rLXOjMz/f3yGHn0v/rq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ed4xwleR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709479880;
	bh=uSL4zHrRtxegcQPlUUbn7PFzXuC2VWmGYlhL0gi2nWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ed4xwleRDJ84ipdoh3Z5HFWfQdsX7BXILqmE7GG3jjRPQF5lr5BJLJ8h9hXVYMpFh
	 n5rCJakdPL+CXQNS2Ddo8FIoqce9Rt2qcrpM2kwN5fBhzz9ToQbcj+rMJDbKaa81wo
	 /BnGmzZNRpUiT5R+i3N4dsoZADLCu9LEYLTciopg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Mar 2024 16:31:16 +0100
Subject: [PATCH v2 4/4] power: supply: test-power: implement
 charge_behaviour property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240303-power_supply-charge_behaviour_prop-v2-4-8ebb0a7c2409@weissschuh.net>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709479879; l=2814;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uSL4zHrRtxegcQPlUUbn7PFzXuC2VWmGYlhL0gi2nWI=;
 b=VBPfUTlYlMVvpfwyZ0EUwuk/b6rXS/LCIf/SFUH7VkqycelzdsFR+rB3puZy85hSyhQdRcEHX
 b2cl1z5dlIZBXQoCn83KJOKyjXaF5VEoPX0BgPmTT2e4elka/XJ+MfL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To validate the special formatting of the "charge_behaviour" sysfs
property add it to the example driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/test_power.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 0d0a77584c5d..1dfbaabb8086 100644
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
@@ -131,6 +136,26 @@ static int test_power_get_battery_property(struct power_supply *psy,
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
@@ -156,6 +181,7 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
 };
 
 static char *test_power_ac_supplied_to[] = {
@@ -178,6 +204,11 @@ static const struct power_supply_desc test_power_desc[] = {
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

-- 
2.44.0


