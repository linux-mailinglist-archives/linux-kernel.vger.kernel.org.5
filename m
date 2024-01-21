Return-Path: <linux-kernel+bounces-31947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157083541A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4452228317C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F234CD5;
	Sun, 21 Jan 2024 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="lMtAffAy"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21434180;
	Sun, 21 Jan 2024 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705801457; cv=none; b=QTFXMCBdMzvdEFpNuT23E10Q6azli9KjTIXPOOheCiZBCDLqozCxea6ejfDM6I5xg2j5Vdd2k19MsD4Zj2yfM2mRIj94CyEQo/X+A3n69WOagru4/iSKhv3OJ2S/WMMloWMMgA7K6gwBbtlJ/EnvFqjPQvcCXKZ5bpitN4QXvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705801457; c=relaxed/simple;
	bh=DPa+Nkb0JVfgtnAuyOILFcJ3GBwfuVrctlhfHFq+TEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j18usTzS6BeG5Y1XOldf8EhOt2SsPhotizUIIRm6Mw5pmVqweKN16nLOmFhb+Gt1ZEzAbMW6DyNtthisa5ss3uFbDGcWpQ2eS73uXBWYgB9DQo2psoGh7iPObT9qBdN6V0UOXFIknxgTdrbmOa4GSKe/7ocnpGhEG1XWD4xxpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=lMtAffAy; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id A6DAC4620D;
	Sun, 21 Jan 2024 01:44:13 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/3] power: supply: axp20x_usb_power: add input current limit
Date: Sat, 20 Jan 2024 20:40:00 -0500
Message-ID: <20240121014057.1042466-3-aren@peacevolution.org>
In-Reply-To: <20240121014057.1042466-1-aren@peacevolution.org>
References: <20240121014057.1042466-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ***
X-Spamd-Bar: +++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705801454;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=mTTqhJZ+TXCTAU2v1OkBw9B/XAxQraalT4JO8XnSZII=;
	b=lMtAffAyNqtnakbBvalpNJNZCjKVCYzo1SnhFulzJ6j5l0GvqTznjjHx0OjR+7ZlrQXSED
	S6UNgd+Wl5jGT1DiZW3RIfJM0F9G0A2cZNIRq9oJ3gfLhSIeQbQ3gjkVkWtVxtdINQCs2i
	Cax7oMSGnjbdQEAUTSRkPbODXFBKvhA=

Add properties for setting the maximum current that will be drawn from
the usb connection.

These changes don't apply to all axp20x chips, so we need to add new
power_desc and power supply property objects for axp813 specifically.
These are copied from the axp22x variants that were used before, with
extra fields added.

Also add a dev field to the axp20x_usb_power struct, so we can use
dev_dbg and dev_err in more places.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

 drivers/power/supply/axp20x_usb_power.c | 127 +++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e23308ad4cc7..8c0c2c25565f 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -50,7 +50,10 @@ struct axp_data {
 	const char * const		*irq_names;
 	unsigned int			num_irq_names;
 	const int			*curr_lim_table;
+	int				input_curr_lim_table_size;
+	const int			*input_curr_lim_table;
 	struct reg_field		curr_lim_fld;
+	struct reg_field		input_curr_lim_fld;
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
 	struct reg_field		usb_bc_en_bit;
@@ -59,7 +62,9 @@ struct axp_data {
 };
 
 struct axp20x_usb_power {
+	struct device *dev;
 	struct regmap *regmap;
+	struct regmap_field *input_curr_lim_fld;
 	struct regmap_field *curr_lim_fld;
 	struct regmap_field *vbus_valid_bit;
 	struct regmap_field *vbus_mon_bit;
@@ -115,6 +120,15 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 	if (val != power->old_status)
 		power_supply_changed(power->supply);
 
+	if (power->usb_bc_en_bit && (val & AXP20X_PWR_STATUS_VBUS_PRESENT) !=
+		(power->old_status & AXP20X_PWR_STATUS_VBUS_PRESENT)) {
+		dev_dbg(power->dev, "Cable status changed, re-enabling USB BC");
+		ret = regmap_field_write(power->usb_bc_en_bit, 1);
+		if (ret)
+			dev_err(power->dev, "failed to enable USB BC: errno %d",
+				ret);
+	}
+
 	power->old_status = val;
 	power->online = val & AXP20X_PWR_STATUS_VBUS_USED;
 
@@ -123,6 +137,66 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
+static int
+axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
+					 int limit)
+{
+	int ret;
+	unsigned int reg;
+
+	if (!power->axp_data->input_curr_lim_table)
+		return -EINVAL;
+
+	if (limit < power->axp_data->input_curr_lim_table[0])
+		return -EINVAL;
+
+	/*
+	 * BC1.2 detection can cause a race condition if we try to set a current
+	 * limit while it's in progress. When it finishes it will overwrite the
+	 * current limit we just set.
+	 */
+	if (power->usb_bc_en_bit) {
+		dev_dbg(power->dev,
+			"disabling BC1.2 detection because current limit was set");
+		ret = regmap_field_write(power->usb_bc_en_bit, 0);
+		if (ret)
+			return ret;
+	}
+
+	for (reg = power->axp_data->input_curr_lim_table_size - 1; reg > 0; reg--) {
+		if (limit >= power->axp_data->input_curr_lim_table[reg])
+			break;
+	}
+
+	dev_dbg(power->dev, "setting input current limit reg to %d (%d uA), requested %d uA",
+		reg, power->axp_data->input_curr_lim_table[reg], limit);
+
+	return regmap_field_write(power->input_curr_lim_fld, reg);
+}
+
+static int
+axp20x_usb_power_get_input_current_limit(struct axp20x_usb_power *power,
+					 int *intval)
+{
+	int ret;
+	unsigned int v;
+
+	if (!power->axp_data->input_curr_lim_table)
+		return -EINVAL;
+
+	ret = regmap_field_read(power->input_curr_lim_fld, &v);
+	if (ret)
+		return ret;
+
+	if (v < power->axp_data->input_curr_lim_table_size)
+		*intval = power->axp_data->input_curr_lim_table[v];
+	else
+		*intval = power->axp_data->input_curr_lim_table[
+			  power->axp_data->input_curr_lim_table_size - 1];
+
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -189,6 +263,9 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = ret * 375; /* 1 step = 0.375 mA */
 		return 0;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp20x_usb_power_get_input_current_limit(power,
+								&val->intval);
 	default:
 		break;
 	}
@@ -290,6 +367,10 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp20x_usb_power_set_input_current_limit(power,
+								val->intval);
+
 	default:
 		return -EINVAL;
 	}
@@ -313,7 +394,8 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 		return power->vbus_disable_bit != NULL;
 
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
-	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
+	       psp == POWER_SUPPLY_PROP_CURRENT_MAX ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
 static enum power_supply_property axp20x_usb_power_properties[] = {
@@ -334,6 +416,15 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 };
 
+static enum power_supply_property axp813_usb_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
 static const struct power_supply_desc axp20x_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -354,6 +445,16 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.set_property = axp20x_usb_power_set_property,
 };
 
+static const struct power_supply_desc axp813_usb_power_desc = {
+	.name = "axp20x-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = axp813_usb_power_properties,
+	.num_properties = ARRAY_SIZE(axp813_usb_power_properties),
+	.property_is_writeable = axp20x_usb_power_prop_writeable,
+	.get_property = axp20x_usb_power_get_property,
+	.set_property = axp20x_usb_power_set_property,
+};
+
 static const char * const axp20x_irq_names[] = {
 	"VBUS_PLUGIN",
 	"VBUS_REMOVAL",
@@ -394,6 +495,18 @@ static int axp813_usb_curr_lim_table[] = {
 	2500000,
 };
 
+static int axp_813_usb_input_curr_lim_table[] = {
+	100000,
+	500000,
+	900000,
+	1500000,
+	2000000,
+	2500000,
+	3000000,
+	3500000,
+	4000000,
+};
+
 static const struct axp_data axp192_data = {
 	.power_desc	= &axp20x_usb_power_desc,
 	.irq_names	= axp20x_irq_names,
@@ -433,11 +546,14 @@ static const struct axp_data axp223_data = {
 };
 
 static const struct axp_data axp813_data = {
-	.power_desc	= &axp22x_usb_power_desc,
+	.power_desc	= &axp813_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.curr_lim_table = axp813_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.input_curr_lim_table_size = ARRAY_SIZE(axp_813_usb_input_curr_lim_table),
+	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
+	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
@@ -558,6 +674,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, power);
 
+	power->dev = &pdev->dev;
 	power->axp_data = axp_data;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
@@ -567,6 +684,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (IS_ERR(power->curr_lim_fld))
 		return PTR_ERR(power->curr_lim_fld);
 
+	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+						 axp_data->input_curr_lim_fld,
+						 &power->input_curr_lim_fld);
+	if (ret)
+		return ret;
+
 	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
 						 axp_data->vbus_valid_bit,
 						 &power->vbus_valid_bit);
-- 
2.43.0


