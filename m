Return-Path: <linux-kernel+bounces-51819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B452848FB1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3113283273
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73124A0F;
	Sun,  4 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tyLZio+5"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B45249E8;
	Sun,  4 Feb 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067628; cv=none; b=EZ7FYJXUXQWJM/Xtf3+0xJCPGadATpKP/5XAontJt9KVuxUeB7UdXbUmdD6JOAp4KWQWcerDEhxj4/sZ4fOtcMdTqo3s2uR23F1dEyuPYWz3HHsxNspwWmzJeqY4ZdB9IzSrPkI+wbRLDfc2e9IjKXLtsZzYzYsxPXROdAo0E7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067628; c=relaxed/simple;
	bh=jhC9MrS/DvTlCbbFDLlt5Ex7tBPY1h+Ja6j31zHqUDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlO350l4PLBz0TdlfPLYd8s4EzW091M/4QKycQ0xmyTRhCE5lVqZOWOQiSdMCOGH5F2Z+4tjH15i0l7ujyrNxQw2+26DPYryog4/T9N4/ZSJ9gfbRqJ0lWc8R0J/A+ODOhCCYGn0I7J+kv7ORBbSmZ9uWqc26zhrcq7KbFeCtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tyLZio+5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707067616;
	bh=jhC9MrS/DvTlCbbFDLlt5Ex7tBPY1h+Ja6j31zHqUDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tyLZio+5j4b83kcLgkgcckSZaIgFsNQpbcTS228yUnQNV8ZI6km4TWXHLG1bCwH6C
	 CWl20AY27g3aXB2SnNMk2/QLNALVygFjQbkzndbxx/lnW6vR3eBYHOZ8zMp7BFt3DT
	 XSsjyK7mYpPFBMTaXQmpknrPiGoEYpVRWpS8OG3g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Feb 2024 18:26:48 +0100
Subject: [PATCH 2/4] power: supply: test-power: implement charge_behaviour
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240204-power_supply-charge_behaviour_prop-v1-2-06a20c958f96@weissschuh.net>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707067615; l=1449;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jhC9MrS/DvTlCbbFDLlt5Ex7tBPY1h+Ja6j31zHqUDY=;
 b=zSfoi6za/QSGlccGGbzM0jSxDfpkVUL9clLjL0HYWEfz4XEYhYCjmCPGJL/T6t+imjLVgXj4F
 SwJNzFhUwv5BECr78yk3M/Ssle1fo8sJaciCuX9QHRWxbIXPlGWbObj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To validate the special formatting of the "charge_behaviour" sysfs
property add it to the example driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/test_power.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 0d0a77584c5d..4da0420996c9 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -123,6 +123,14 @@ static int test_power_get_battery_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		val->intval = battery_current;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE:
+		val->intval = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
+			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
+			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
+		break;
 	default:
 		pr_info("%s: some properties deliberately report errors.\n",
 			__func__);
@@ -156,6 +164,8 @@ static enum power_supply_property test_power_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
 };
 
 static char *test_power_ac_supplied_to[] = {

-- 
2.43.0


