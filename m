Return-Path: <linux-kernel+bounces-45279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4B2842E00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D1D285F96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5B78B67;
	Tue, 30 Jan 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="RdZPi4ul"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA02762EE;
	Tue, 30 Jan 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647082; cv=none; b=Q0NP8BhjHThBBxFGE0scZv6Qkf1JKb0rn2XOSL9jCXgKb8rQ0tOEwyJpTrU8lHbwcFMLwxLf+h1mo+0QLiGuj07VeRs63RWtZCG2e/CncHW+xFDeFTr9x0abC7zgnh1w5pWLY9gty7BzeOFiABwA5dk/nYU56cdD5V4Mr72/paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647082; c=relaxed/simple;
	bh=zXXGsJFbgiYzogwaULyPk2kphg0Ch0Uphvq2gjdcWj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAmqZXpsxL3Ei1wKw9b0staiwk6HVozx6Sm6XHA07Z7DeYgjC7KQ+T/rzXiYxI4uhkWQDAQgNwUrOgNYA+1xL3OHC+8/JEWaWxUsriOzn0pjk3+JfQeGCqyuKISa7u1tK+AMmP4BF/d5yXKnOnRGKD7KTOiFtNhqudlp5SlPecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=RdZPi4ul; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 2EA8046B74;
	Tue, 30 Jan 2024 20:37:59 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Hans de Goede <j.w.r.degoede@gmail.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 4/5] power: supply: axp20x_usb_power: enable usb_type reporting
Date: Tue, 30 Jan 2024 15:28:00 -0500
Message-ID: <20240130203714.3020464-5-aren@peacevolution.org>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706647079;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=6G0YmOD50/3sb0eb05V/Ra/p+656o7Ad1EWSfIxoCZI=;
	b=RdZPi4ul39i/V1pJazsVpkPeFOvR3+beShpiRU91OnRSd+nbRXbU2OYXRw/0MrUjD5TZ9+
	Qk6gvexMDXB+HIAp73g+/9Zsll64rkCaDMYD60kWRN8MkMorrj9J7sJj1ktlveT36DRvZ+
	VbgZPODoGJrA9lrmOvGmfjBzPvT6Hos=

The axp803 and axp813 chips can report the detected USB BC mode. SDP,
CDP, and DCP are supported.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

(no changes since v1)

 drivers/power/supply/axp20x_usb_power.c | 73 ++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index ac5a3f126df6..dae7e5cfc54e 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -55,6 +55,7 @@ struct axp_data {
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
 	struct reg_field		usb_bc_en_bit;
+	struct reg_field		usb_bc_det_fld;
 	struct reg_field		vbus_disable_bit;
 	bool				vbus_needs_polling: 1;
 };
@@ -66,6 +67,7 @@ struct axp20x_usb_power {
 	struct regmap_field *vbus_valid_bit;
 	struct regmap_field *vbus_mon_bit;
 	struct regmap_field *usb_bc_en_bit;
+	struct regmap_field *usb_bc_det_fld;
 	struct regmap_field *vbus_disable_bit;
 	struct power_supply *supply;
 	const struct axp_data *axp_data;
@@ -134,6 +136,37 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
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
@@ -204,6 +237,9 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 
 		val->intval = ret * 375; /* 1 step = 0.375 mA */
 		return 0;
+
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return axp20x_get_usb_type(power, val);
 	default:
 		break;
 	}
@@ -367,6 +403,22 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static enum power_supply_property axp813_usb_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static enum power_supply_usb_type axp813_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+};
+
 static const struct power_supply_desc axp20x_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -387,6 +439,18 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
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
+	.usb_types = axp813_usb_types,
+	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
+};
+
 static const char * const axp20x_irq_names[] = {
 	"VBUS_PLUGIN",
 	"VBUS_REMOVAL",
@@ -475,13 +539,14 @@ static const struct axp_data axp223_data = {
 };
 
 static const struct axp_data axp813_data = {
-	.power_desc	= &axp22x_usb_power_desc,
+	.power_desc	= &axp813_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.curr_lim_table = axp813_usb_curr_lim_table,
 	.curr_lim_table_size = ARRAY_SIZE(axp813_usb_curr_lim_table),
 	.curr_lim_fld	= REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
+	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
 };
@@ -629,6 +694,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
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


