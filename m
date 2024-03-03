Return-Path: <linux-kernel+bounces-89801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B788886F5E6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D8AB22A05
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118D67E8A;
	Sun,  3 Mar 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qSBoFGGm"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941E5A107;
	Sun,  3 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479893; cv=none; b=ik2hEOg8TGy26MmcESy3uWbPHMa3DvgxnFhdp3oM5GrCgQJObfHsoyh3oXAfhT+GDzlEPxoUTqnU9wGzYDuV6ZB0x9DN+XzLLGJ9PvhlfnPbLkSjEyqn1Akw9Odo8Z3q3HxA6UZNEK2CIcr3l+ODKeDaRX4cMIxUPPDQImjIFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479893; c=relaxed/simple;
	bh=7Y+sg6xU/tnRXb7nijX/qTcZu9YebnvPyPbqD2+B3oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFEqHrQbs5HVUddafAtxPkvg+kErF6/cRJdMRJciNjMIp+ck15Ia/n1xFxv8PNY6IFDdlGCOQIx83254RLoOf2VFKUOys8PkzPbJKkD2/SPpxhpAp10p6yGBIWQGaOP0oJ5JSlRclrb/B8tfCOhxPZ0LKNC6Mdwu4MURdqnFUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qSBoFGGm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709479880;
	bh=7Y+sg6xU/tnRXb7nijX/qTcZu9YebnvPyPbqD2+B3oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qSBoFGGmRDRvcBmdFarxZfB6CRYQi137tHupqZF9EWxtpaBPBOwUoC20rfFZAO/uq
	 pJbuKtX5zxcrYjLkLSpk1H2LjNfHk8piSbazm+d9J8uytHCANIyC/iG6CuMc2ej277
	 kQDEZaI7GJu14tYkKHbt++UDSxhVe5rlTdqWUyHs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Mar 2024 16:31:13 +0100
Subject: [PATCH v2 1/4] power: supply: mm8013: fix "not charging" detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709479879; l=2437;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7Y+sg6xU/tnRXb7nijX/qTcZu9YebnvPyPbqD2+B3oc=;
 b=IQvGhFBz5UJ3o+kOa80uOHlJwACcG9eD17Q1U+K31JZAr2mT1CIU5BeoN15u290SdZ83ox6S8
 N2XHc5u5mhOBfFp7yyPtJNSJ8C2Q7UBqtgG6bVtYx1hrhLL4x7i1Zam
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The charge_behaviours property is meant as a control-knob that can be
changed by the user.

Page 23 of [0] which documents the flag CHG_INH as follows:

  CHG_INH : Charge Inhibit      When the current is more than or equal to charge
                                threshold current,
                                charge inhibit temperature (upper/lower limit) ：1
                                charge permission temperature or the current is
                                less than charge threshold current ：0

So this is pure read-only information which is better represented as
POWER_SUPPLY_STATUS_NOT_CHARGING.

[0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/mm8013.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index caa272b03564..20c1651ca38e 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -71,7 +71,6 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
 
 static enum power_supply_property mm8013_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
@@ -103,16 +102,6 @@ static int mm8013_get_property(struct power_supply *psy,
 
 		val->intval = regval;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
-		ret = regmap_read(chip->regmap, REG_FLAGS, &regval);
-		if (ret < 0)
-			return ret;
-
-		if (regval & MM8013_FLAG_CHG_INH)
-			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
-		else
-			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
-		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
 		if (ret < 0)
@@ -187,6 +176,8 @@ static int mm8013_get_property(struct power_supply *psy,
 
 		if (regval & MM8013_FLAG_DSG)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (regval & MM8013_FLAG_CHG_INH)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (regval & MM8013_FLAG_CHG)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (regval & MM8013_FLAG_FC)

-- 
2.44.0


