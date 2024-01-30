Return-Path: <linux-kernel+bounces-45280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32F842E02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2911C24FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D67993B;
	Tue, 30 Jan 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="M/8nUGKs"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AB78B7B;
	Tue, 30 Jan 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647087; cv=none; b=Tvbyb7xDcMU+d9gtm190sWumB/wGJ6JHwTV851UDbs02EHAa/Zg2bHFfoY8FomvydBnL4qeX+/sTQ9bycLKLlp5xk5M366IpDXbG841Q1i7TSUJ7w2eo7COUplMMCqwX+37nmXdrRV+RHoZIsvV5j1dVYbEiflbeyXGnmp+k4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647087; c=relaxed/simple;
	bh=ItXbRSSuRULGHehgAkFOPt/p0MSJUvWQ3KbcLpvFS5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7pkK2zK2fS251z62x+ZlkNlbQpr/vdbrqmktPSRtedBZs1aFKgdnGVOsHGXt15m3nm0TCYTusrq/d+YEFFP+mmg4J0TrTMutW3IG//EWjvOlyMR+uMDHWwPIhBlOj0JUrfccdJFINIPv4QpzBP9+5LpqUWuDa5DyuBhhtoh4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=M/8nUGKs; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D42EA4661E;
	Tue, 30 Jan 2024 20:38:03 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Hans de Goede <j.w.r.degoede@gmail.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Quentin Schulz <quentin.schulz@bootlin.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 5/5] power: supply: axp20x_usb_power: set input current limit in probe
Date: Tue, 30 Jan 2024 15:28:01 -0500
Message-ID: <20240130203714.3020464-6-aren@peacevolution.org>
In-Reply-To: <20240130203714.3020464-1-aren@peacevolution.org>
References: <20240130203714.3020464-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706647084;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=eZlM22aJvF3MR5EwxjV3X6ckVSfAYjgJvEHp2kxoO6k=;
	b=M/8nUGKsclChSRKnGxLzS4IoO1E9Nt8BRog8y+x/fzhn6ORnN4xP84cIDZ4K93ex/n0XjY
	sD0Rk0yEGcDFyekb7xdkqxCLD6MFP4pqDTHf/vJ+e919wrUuYmGdFDYTggTOVkjv4d5JsR
	fizhJ0M8fVYbAy4RwiCrGadYlLng8SQ=

axp803 sets the current limit to 3A by default if it doesn't detect a
battery. The datasheet says that register 0x2D bit 6 is used to indicate
first power on status. According to it, if that bit is 0 and the battery
is not detected, it will set the input current limit to 3A, however
setting that bit to 1 doesn't to prevent the pmic from setting the
current limit to 3A.

Waiting for USB BC detection doesn't work either, because (as far as I
can tell) USB BC detection isn't performed when there isn't a battery
detected.

Fixes: c279adafe6ab ("power: supply: axp20x_usb_power: add support for AXP813")

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
I'm not sure if the pmic simply ignores the first power on field, or if
it needs to be set in a specific way / at a specific time. I tried
setting it in arm-trusted-firmware, and the pmic still set the input
current limit to 3A.

The datasheet for axp813 says it has the same first power on bit, but I
don't have hardware to test if it behaves the same way. This driver uses
the same platform data for axp803 and axp813.

(no changes since v1)

 drivers/power/supply/axp20x_usb_power.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dae7e5cfc54e..751b9f02d36f 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -51,6 +51,7 @@ struct axp_data {
 	unsigned int			num_irq_names;
 	const int			*curr_lim_table;
 	int				curr_lim_table_size;
+	int				force_curr_lim;
 	struct reg_field		curr_lim_fld;
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
@@ -545,6 +546,7 @@ static const struct axp_data axp813_data = {
 	.curr_lim_table = axp813_usb_curr_lim_table,
 	.curr_lim_table_size = ARRAY_SIZE(axp813_usb_curr_lim_table),
 	.curr_lim_fld	= REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
+	.force_curr_lim = 500000,
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
 	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
@@ -726,6 +728,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (power->axp_data->force_curr_lim) {
+		/*
+		 * Some chips set the input current limit to 3A when there is no
+		 * battery connected. Normally the default is 500mA.
+		 */
+		ret = axp20x_usb_power_set_input_current_limit(power,
+				power->axp_data->force_curr_lim);
+		if (ret)
+			return ret;
+	}
+
 	if (power->usb_bc_en_bit) {
 		/* Enable USB Battery Charging specification detection */
 		ret = regmap_field_write(power->usb_bc_en_bit, 1);
-- 
2.43.0


