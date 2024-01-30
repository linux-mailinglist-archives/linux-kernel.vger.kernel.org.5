Return-Path: <linux-kernel+bounces-45277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6F842DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC331C24AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91B771B25;
	Tue, 30 Jan 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="peh0abvS"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CC5F555;
	Tue, 30 Jan 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647075; cv=none; b=XCoWMkl/v4hm3SdymA+GstQweqwlmVP3USp0Ni2LRMWtWo1sPbC7AG/2GPMLRK30WSinMjuUC6c3YTecj9y944axtPpa5wLwycHnhlAXgwthsiF9+gHmQG8DAaOEBkMV55GqZuN+uRuOJHs3LLNBP2XqBamxmBHUPhrd3ag3iZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647075; c=relaxed/simple;
	bh=GIUIG7+EEVMTtkYD8ypmqtjqn29llrcgXCn39fpUmBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCcwests+099a+gZUoptKTeQwDFgrHvaNT3jjzHer1Ttj+e/V9JBlrvoKOCgWMwS8YFGZ/yiqvWmZvqqUO7Jrq5I4Ob6vfr8ClTcaEUnNhnp6cMK6K06oE/K5+a/JzPib2ZjAbTcGuPxECPT/alIw1kU9T9L+Y0tnrGzWGmtlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=peh0abvS; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 5F6304661E;
	Tue, 30 Jan 2024 20:37:52 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Hans de Goede <j.w.r.degoede@gmail.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 2/5] power: supply: axp20x_usb_power: use correct register for input current limit
Date: Tue, 30 Jan 2024 15:27:58 -0500
Message-ID: <20240130203714.3020464-3-aren@peacevolution.org>
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
	s=dkim; t=1706647072;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=ivPm1WNR8FbrvYRzWgVfDM6fYhcsm1TJs7pHZ7Ec81E=;
	b=peh0abvSNH8vlLhCN6FjDCVIefhI1lavzA6yZ4ePRVf9uszqJQl7pvbQas7VjPk5ltE059
	H8xonDx9V+IngLtipZw7Wa0I/Sg/CThpmn/REyWvz4ZO1WjXMNaR9Vh2jYfcT2wg4ky8rk
	kkW4T9Lxmb5VrFDjvmmhqu1SPF3Tsis=

On the axp803 and axp813 chips register 0x30 bits 0-1 is the default
current limit that gets applied after the pmic detects a CDP or DCP
port. The correct field to set is 0x35 bits 4-7.

This field only has nine values (out of the 16 possible if it used all
the bits), so introduce a field size variable to take that into account.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Changes in v2:
 - Inline get input current logic. It's not that complicated and this
   helps to illustrate what changed more clearly.
 - Split into separate commit, it was part of adding the input current
   limit before.

 drivers/power/supply/axp20x_usb_power.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index f7f2ac2b7dae..923121b23d5f 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -50,6 +50,7 @@ struct axp_data {
 	const char * const		*irq_names;
 	unsigned int			num_irq_names;
 	const int			*curr_lim_table;
+	int				curr_lim_table_size;
 	struct reg_field		curr_lim_fld;
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
@@ -166,7 +167,11 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		val->intval = power->axp_data->curr_lim_table[v];
+		if (v < power->axp_data->curr_lim_table_size)
+			val->intval = power->axp_data->curr_lim_table[v];
+		else
+			val->intval = power->axp_data->curr_lim_table[
+				power->axp_data->curr_lim_table_size - 1];
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -261,8 +266,7 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 						    int intval)
 {
 	unsigned int reg;
-	const unsigned int max = GENMASK(power->axp_data->curr_lim_fld.msb,
-					 power->axp_data->curr_lim_fld.lsb);
+	const unsigned int max = power->axp_data->curr_lim_table_size;
 
 	if (intval == -1)
 		return -EINVAL;
@@ -394,10 +398,15 @@ static int axp221_usb_curr_lim_table[] = {
 };
 
 static int axp813_usb_curr_lim_table[] = {
+	100000,
+	500000,
 	900000,
 	1500000,
 	2000000,
 	2500000,
+	3000000,
+	3500000,
+	4000000,
 };
 
 static const struct axp_data axp192_data = {
@@ -405,6 +414,7 @@ static const struct axp_data axp192_data = {
 	.irq_names	= axp20x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.curr_lim_table = axp192_usb_curr_lim_table,
+	.curr_lim_table_size = ARRAY_SIZE(axp192_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
@@ -415,6 +425,7 @@ static const struct axp_data axp202_data = {
 	.irq_names	= axp20x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.curr_lim_table = axp20x_usb_curr_lim_table,
+	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
@@ -425,6 +436,7 @@ static const struct axp_data axp221_data = {
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.curr_lim_table = axp221_usb_curr_lim_table,
+	.curr_lim_table_size = ARRAY_SIZE(axp221_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
 };
@@ -434,6 +446,7 @@ static const struct axp_data axp223_data = {
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.curr_lim_table = axp20x_usb_curr_lim_table,
+	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
 };
@@ -443,7 +456,8 @@ static const struct axp_data axp813_data = {
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.curr_lim_table = axp813_usb_curr_lim_table,
-	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.curr_lim_table_size = ARRAY_SIZE(axp813_usb_curr_lim_table),
+	.curr_lim_fld	= REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
-- 
2.43.0


