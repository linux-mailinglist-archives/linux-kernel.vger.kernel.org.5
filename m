Return-Path: <linux-kernel+bounces-113896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D08888731
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2509EB24CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECE20F24F;
	Sun, 24 Mar 2024 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig1DL+DI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2D1494CD;
	Sun, 24 Mar 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320975; cv=none; b=fonVaOrJxB6+u0m2yYrNUndi45NwksLa0V0noZTIPP7qnHv6H41sLnbq1xs/MZfm1uccGp5XdCzlgjFTXE6dQjHtMfBDA1xyw5nNvwiVeNk91oi6sWpAnuAgM4g16L/2cPYMvr32Oisr4whUG92IqG+5AzzkeY9PTRY2FEQ2ZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320975; c=relaxed/simple;
	bh=eG1J2GmODm9lK0Ww4aBd5mp6oXQImbe3u0gUs1eIvrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8jx7GQPS3XEFhB9Q/IR9e4Hi1ZezDy+muV8EryEmuBFYJDNEBrm6af7hcKQJlhGcxXeDvp2O5c5bMsuDBkB8/Ksz6D3jusudDg9mXnoVtiYw1BGbHJm7hhwOXKBgAZFBrhKE5HgNAfXlGcjukpt2wcWjkTTE3vnQbGLp5TkTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig1DL+DI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC499C433F1;
	Sun, 24 Mar 2024 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320974;
	bh=eG1J2GmODm9lK0Ww4aBd5mp6oXQImbe3u0gUs1eIvrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ig1DL+DIJ/WNChNr4WucATddPDx4sWlvULlgmtPzzHCq4DD/cNbPnAMOc/JNF9RUM
	 mMbLvFTin5qbZx3F2XON0af2jfiOfEjpIMBDu26dmlUf9WML8i1WRiScwNvMPdg9G5
	 bjV2BJDOriU80pD9birUvgbj4P9p29x2XEB+8hBuTre22NN0Tok7P2iGe9GWFMQbv9
	 RBmHR4pR++paLlavaIXSyG2rftmhFYsim/4G3Hvt5w2MhTZxNRdCQIh0eG8E/Ujip7
	 er8ZJDqet0SSEU+0Bys8G7WuY5hDSqCBCtPP6F5GbRHmq4lFIzb2kdxNz/IhgPFFh9
	 HtJ4ObYf9A7wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 537/713] power: supply: mm8013: fix "not charging" detection
Date: Sun, 24 Mar 2024 18:44:23 -0400
Message-ID: <20240324224720.1345309-538-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


