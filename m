Return-Path: <linux-kernel+bounces-45278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B181842DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0C728B185
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649671B49;
	Tue, 30 Jan 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="U+/RvjVy"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4285762E3;
	Tue, 30 Jan 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647079; cv=none; b=n1khRLRVbXefZss6W3M2X+9hVg7im29sO8OxHw8MGCZD/JmT3upED5G/Xr5G95oC2dOAnbgU2LZ0+zOESbuiM3Yt82H40cxhHuMbqD4i6e6Rb4zmqzyGwZL9AZ4rz+HSK7TtzpvML8mGQMw2pomkBwqtyLPNJZMzjejql58LvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647079; c=relaxed/simple;
	bh=5wkPN+b1GbrWti66iOp/WvMt1+CJTyRFqQ9LVlL8Vbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mL4UoaMK/V/TOEhNuLQsHOES8E70IFGSugX71ObtZ7gI+mXroIjCdt6Eu3X8ExEgikDWjYibZ2oYmeNn0JxNFkU6+YfayDvSTWm+dxpSBAYJQrc2+YrJSMlI1Yjsa7fhZIamYa/7My8sFZMc3vScxjpQvK1NaizjsEYjm4ulVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=U+/RvjVy; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 34C324661E;
	Tue, 30 Jan 2024 20:37:56 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Hans de Goede <j.w.r.degoede@gmail.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 3/5] power: supply: axp20x_usb_power: fix race condition with usb bc
Date: Tue, 30 Jan 2024 15:27:59 -0500
Message-ID: <20240130203714.3020464-4-aren@peacevolution.org>
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
	s=dkim; t=1706647076;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=Qh62TYzJLJF3IVftKmbgHbTDldqXGopKOhOQHQ3kQso=;
	b=U+/RvjVyLg9rgo6Oo3xomEgxwmZY4yPcXiiG5NSEHVPEGGvkIh7KC08MSXFRMuYPUBjLfm
	pAbKcOHABZ0sew05lCJqlptrUvklUCjBX/HtAA1DkoLGoEzcJUlH1IZggCEbQh//6TIo06
	gB9uo4oy3n2R9pYmuiNPvWBQ1SL2eGA=

When input_current_limit is set while USB BC is in progress, the BC
module will overwrite the value that was set when it finishes detection.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Changes in v2:
  - Split into sepereate commit, it was part of addig the input current
    limit before.

 drivers/power/supply/axp20x_usb_power.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 923121b23d5f..ac5a3f126df6 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -117,6 +117,15 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
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
 
@@ -265,12 +274,26 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
 						    int intval)
 {
+	int ret;
 	unsigned int reg;
 	const unsigned int max = power->axp_data->curr_lim_table_size;
 
 	if (intval == -1)
 		return -EINVAL;
 
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
 	for (reg = max - 1; reg > 0; reg--)
 		if (power->axp_data->curr_lim_table[reg] <= intval)
 			break;
-- 
2.43.0


