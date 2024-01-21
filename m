Return-Path: <linux-kernel+bounces-31948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52583541C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB1C1F22A24
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FB35285;
	Sun, 21 Jan 2024 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="bY6eYvsB"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279134180;
	Sun, 21 Jan 2024 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705801495; cv=none; b=t28BSom9w3FvXnGJYNhwVAmCMUoQSaQzwNqfGDgdj9koJUNkR4Qs2YSXjZhq0QVorH3fT4Fto2HqcpFSJBeAVAuxIaI0ts5dBRa0tRVu5Y0w0O1K4A+0/7/qQgRcNQ4bABwl9gTsu36t7dEd8grebmmJaJdE/lAD/l7+VrsBfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705801495; c=relaxed/simple;
	bh=uXkUwCYq0H2JtLAC7JcuuDcFZ0QN3QO/RdNy0mw0xvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ5HZC1zRhMtJ6gXMcB3uV70j3kusff6CKT7bE95jxzG8Nr+vROGXcbAyV/elcypHcJVr0POzT4HKZIJsT1RJKjXZ4hGpkA6/uTjaVS1gj3gU2cL92UvHfL94MFthtneg2oenfnCqaf6t6JxNQF+h/d6J9ynHH2lT+KAstlZZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=bY6eYvsB; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 8560743C8C;
	Sun, 21 Jan 2024 01:44:52 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/3] power: supply: axp20x_usb_power: enable usb_type reporting
Date: Sat, 20 Jan 2024 20:40:02 -0500
Message-ID: <20240121014057.1042466-5-aren@peacevolution.org>
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
	s=dkim; t=1705801493;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=1Ryn10C70a9eu2vzgWK/233iIVPb5X5KUoLMJ9eT+QI=;
	b=bY6eYvsBWw7PD/Q1sl8IgYA0nY9CiwfYHPli59OymCdke/XL10mFB3Nt3C5EPOg0fMfS8B
	TUfHmMXrWbbP0RvNqZLcvMul3Nysk4SYW9TgT+Z0JtqjCU0vEkDMvmF0BAwKrVCSGTRpDm
	+oiKXDRhR3D4hqOs0rh4yqn2DFxfkA8=

Axp803 and axp813 can report the detected usb bc mode. SDP, CDP, and DCP
are supported.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

 drivers/power/supply/axp20x_usb_power.c | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 8c0c2c25565f..5656f6e57d54 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -57,6 +57,7 @@ struct axp_data {
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
 	struct reg_field		usb_bc_en_bit;
+	struct reg_field		usb_bc_det_fld;
 	struct reg_field		vbus_disable_bit;
 	bool				vbus_needs_polling: 1;
 };
@@ -69,6 +70,7 @@ struct axp20x_usb_power {
 	struct regmap_field *vbus_valid_bit;
 	struct regmap_field *vbus_mon_bit;
 	struct regmap_field *usb_bc_en_bit;
+	struct regmap_field *usb_bc_det_fld;
 	struct regmap_field *vbus_disable_bit;
 	struct power_supply *supply;
 	const struct axp_data *axp_data;
@@ -197,6 +199,37 @@ axp20x_usb_power_get_input_current_limit(struct axp20x_usb_power *power,
 	return 0;
 }
 
+static int axp20x_get_usb_type(struct axp20x_usb_power *power,
+			       union power_supply_propval *val)
+{
+	unsigned int reg;
+	int ret;
+
+	if (!power->usb_bc_det_fld)
+		return -EINVAL;
+
+	ret = regmap_field_read(power->usb_bc_det_fld, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg) {
+	case 1:
+		val->intval = POWER_SUPPLY_USB_TYPE_SDP;
+		break;
+	case 2:
+		val->intval = POWER_SUPPLY_USB_TYPE_CDP;
+		break;
+	case 3:
+		val->intval = POWER_SUPPLY_USB_TYPE_DCP;
+		break;
+	default:
+		val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -266,6 +299,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return axp20x_usb_power_get_input_current_limit(power,
 								&val->intval);
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return axp20x_get_usb_type(power, val);
 	default:
 		break;
 	}
@@ -423,6 +458,14 @@ static enum power_supply_property axp813_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static enum power_supply_usb_type axp813_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
 };
 
 static const struct power_supply_desc axp20x_usb_power_desc = {
@@ -453,6 +496,8 @@ static const struct power_supply_desc axp813_usb_power_desc = {
 	.property_is_writeable = axp20x_usb_power_prop_writeable,
 	.get_property = axp20x_usb_power_get_property,
 	.set_property = axp20x_usb_power_set_property,
+	.usb_types = axp813_usb_types,
+	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
 };
 
 static const char * const axp20x_irq_names[] = {
@@ -555,6 +600,7 @@ static const struct axp_data axp813_data = {
 	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
 	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
+	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
 };
@@ -708,6 +754,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+						 axp_data->usb_bc_det_fld,
+						 &power->usb_bc_det_fld);
+	if (ret)
+		return ret;
+
 	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
 						 axp_data->vbus_disable_bit,
 						 &power->vbus_disable_bit);
-- 
2.43.0


