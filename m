Return-Path: <linux-kernel+bounces-113407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2064888414
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC31C23B00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF51A50C1;
	Sun, 24 Mar 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnjAomCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09911A5952;
	Sun, 24 Mar 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320209; cv=none; b=ta50jyvJZFzrt2W7XG1Ufe3VMdCEKCFaUKYM8SaOmjQVuNYYpUJsplcdnAovnuEAzSgb6CCdSAUfvNdXbxZUY/DWo7xOR/PgjcbIUoA5ZitCoucbRhj9r6XdARK3Er+35zbYDDsxoQN5zY0wfST5psc4P5btX/Cf2QmVgYEUV9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320209; c=relaxed/simple;
	bh=eG1J2GmODm9lK0Ww4aBd5mp6oXQImbe3u0gUs1eIvrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8cjxoQCYm4IbSlgr4Ir/hmR99PqDJ0A5/QNru+UVpycr+CsaNwG3O/Ajd5cBD1xMonr1wqITenM8MYALchU6GXt9LCEVmxvn1g6cFCUujJ2s7LU5UmUdRAC2gwdb/b554wLk44HdT+j6mpdjd6YV3ncPPLTNrwGojibFiCQ8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnjAomCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A211AC433F1;
	Sun, 24 Mar 2024 22:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320209;
	bh=eG1J2GmODm9lK0Ww4aBd5mp6oXQImbe3u0gUs1eIvrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnjAomCSRxa0JEHG0MGMuBjM2LwIbJWiIYa8DfUtOGgcI+mmaO/5/J3Z/utXpCOP9
	 2Hc/ar5/M1A0LMc1UsFQc4+3Ont9B/fsgItJK0bQwjGlJV/xVnrL3fxe+n8PiZUzo2
	 zjB+aHjhFzgj1lc7DdhTiOg3YTE/kOk6PZZkFbZeVkjfaHttIF3sExBKpIy5vBzUu0
	 aHfAc8tWlOBsn3NkBPDtAjeX/4u1a4LtJ4/IhlrJnf3PV9671bnVyOr0Vb904IjWA8
	 D9KdOIg8qc0BLWmMIiGfmpBW25IK9DTPIdnNpvP+40wVV+N1FWzC5xVWgElPMzuMOj
	 qvVmKFfOPdxVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 516/715] power: supply: mm8013: fix "not charging" detection
Date: Sun, 24 Mar 2024 18:31:35 -0400
Message-ID: <20240324223455.1342824-517-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit cd38a0acca734a1117663d6f0da579d3965b6c93 ]

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
Link: https://lore.kernel.org/r/20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net
Fixes: e39257cde7e8 ("power: supply: mm8013: Add more properties")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/mm8013.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index caa272b035649..20c1651ca38e0 100644
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
2.43.0


