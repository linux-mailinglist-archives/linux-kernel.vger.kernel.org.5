Return-Path: <linux-kernel+bounces-45276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44737842DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FD61F23749
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AF55C02;
	Tue, 30 Jan 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="OLUhxc3O"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44571B2C;
	Tue, 30 Jan 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647067; cv=none; b=KPwGgNcAmFQe5Sv6cqlwoT+6HKftMvx7/MF5K5f48gwuVvu4z5xpprTZpsScjvr8QFslJd1snirSR3X5ilOcDSqnqpBj800J+Kx1hZ6+1LNAFcB8mjRTjNffZ12QpxALpisV99aSO2N/iueOdsbiBzjiZNiQrryon05myHsgdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647067; c=relaxed/simple;
	bh=s8gDv1BRbZ4lq/K0LWRSztHuSeHvlnMI3UYO7zLzfo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daD2+zszvr250mvjYAc8mCM0MNIZZkbcAYKo3WVJyMEN4LDkiVKZeFb3CmD2L7FjL/m+TeEd6z47bPkq9On8HYI3YNH0rFNeZ2ecYrimSo3Arakh2/3wEqA8tKyQbM7LvZb4tWKt/OYRP3g8T2O2Tsym1XyAlT5Hj0jU0HoPlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=OLUhxc3O; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B03E14661E;
	Tue, 30 Jan 2024 20:37:43 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Hans de Goede <j.w.r.degoede@gmail.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 1/5] power: supply: axp20x_usb_power: replace current_max with input_current_limit
Date: Tue, 30 Jan 2024 15:27:57 -0500
Message-ID: <20240130203714.3020464-2-aren@peacevolution.org>
In-Reply-To: <20240130203714.3020464-1-aren@peacevolution.org>
References: <20240130203714.3020464-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706647064;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=NAxGv9qMri1hf0JDQHUznnkmw1bSeEqz6JkBTbreKjQ=;
	b=OLUhxc3OTR3e4qs7eMABcduOJHq7KXwvnRR8iPxFsdEXZ4NX+B1gzVzDk2Qqm2xp9fdlzO
	MJUTRvNGYohFGLGU8kTiMzEcsVg5V3imJotjTz++QWNpa2xHRoSrqb2UxC4ns2B1zJ5mBu
	LieV+Y1RT8VDeszaAEmhY+rH2caESaI=

The current_max property is supposed to be read-only, and represent the
maximum current the supply can provide. input_current_limit is the
limit that is currently set, which is what we have here.

When determining what value to write to the register, we need to pick a
reasonable value if the requested limit doesn't exactly match one
supported by the hardware. If the requested limit is less than the
lowest value we can set, round up to the lowest value. Otherwise round
down to the nearest value supported by hardware.

Also add a dev field to the axp20x_usb_power struct, so we can use
dev_dbg and dev_err in more places.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Changes in v2:
 - Values less than the lowest supported limit are rounded up instead
   of returning -EINVAL when setting the input current limit.

 drivers/power/supply/axp20x_usb_power.c | 29 +++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e23308ad4cc7..f7f2ac2b7dae 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -59,6 +59,7 @@ struct axp_data {
 };
 
 struct axp20x_usb_power {
+	struct device *dev;
 	struct regmap *regmap;
 	struct regmap_field *curr_lim_fld;
 	struct regmap_field *vbus_valid_bit;
@@ -160,7 +161,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
-	case POWER_SUPPLY_PROP_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = regmap_field_read(power->curr_lim_fld, &v);
 		if (ret)
 			return ret;
@@ -256,19 +257,24 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
-static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power, int intval)
+static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
+						    int intval)
 {
+	unsigned int reg;
 	const unsigned int max = GENMASK(power->axp_data->curr_lim_fld.msb,
 					 power->axp_data->curr_lim_fld.lsb);
 
 	if (intval == -1)
 		return -EINVAL;
 
-	for (unsigned int i = 0; i <= max; ++i)
-		if (power->axp_data->curr_lim_table[i] == intval)
-			return regmap_field_write(power->curr_lim_fld, i);
+	for (reg = max - 1; reg > 0; reg--)
+		if (power->axp_data->curr_lim_table[reg] <= intval)
+			break;
 
-	return -EINVAL;
+	dev_dbg(power->dev, "setting input current limit reg to %d (%d uA), requested %d uA",
+		reg, power->axp_data->curr_lim_table[reg], intval);
+
+	return regmap_field_write(power->curr_lim_fld, reg);
 }
 
 static int axp20x_usb_power_set_property(struct power_supply *psy,
@@ -287,8 +293,8 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
-	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		return axp20x_usb_power_set_current_max(power, val->intval);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp20x_usb_power_set_input_current_limit(power, val->intval);
 
 	default:
 		return -EINVAL;
@@ -313,7 +319,7 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 		return power->vbus_disable_bit != NULL;
 
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
-	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
 static enum power_supply_property axp20x_usb_power_properties[] = {
@@ -322,7 +328,7 @@ static enum power_supply_property axp20x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
@@ -331,7 +337,7 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN,
-	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 static const struct power_supply_desc axp20x_usb_power_desc = {
@@ -558,6 +564,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, power);
 
+	power->dev = &pdev->dev;
 	power->axp_data = axp_data;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
-- 
2.43.0


