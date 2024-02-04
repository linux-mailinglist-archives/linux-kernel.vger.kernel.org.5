Return-Path: <linux-kernel+bounces-51820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2A848FB2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410E3B20CD6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66424A0E;
	Sun,  4 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fhMew4Ad"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B82249EA;
	Sun,  4 Feb 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067628; cv=none; b=jPCQTbjwN7rblAPDmUbd5r7dZdncOTNRdlYGb3xPg7rRmvXBGfhFvaIoWQi4lB232/mtOXLlQ0mPD/xtE/7minYXAEhPThO56MUt18ABENK1Q7rppb0YbfkC7AAzd770ag2fNROctgHVM5XHUIrAjWQ/iwaVfZpNt45wGIDFYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067628; c=relaxed/simple;
	bh=2bfpIaHPb+FVKiLlqv6onKrx8jugClAtzAL49QT9tj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiK54Rv1wCQuV2Cy5JWhv8TdcjTW3Oan3d46V8y/USJaJ/YpGnOkfcu5NQWjVOfs2YNIAwMvLqyiPnRb+RCADtJ8AgvoSzGv2OH6/6LZ63/l/+0fho+yHnGY+YTTeuMLVW3vfbDqeGPs4YLVgWOEWP0IJ5w8UJxyJ65s9eZEjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fhMew4Ad; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707067616;
	bh=2bfpIaHPb+FVKiLlqv6onKrx8jugClAtzAL49QT9tj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fhMew4AdtulXYoY2VpXWRvQfvCaONA9fIk0LjMdi2qR/prFTX4jXe/5paqNJRUXoT
	 Ofa50BkT4C7yjQdfSZ2q3CFDq5AVxx+TpEOwXRu5Vj8y+9xbcll7Gjz1A8vP7PV+oj
	 r0rb5D5DBG64iNSuJVBX64a1iWFdMce2R4x2dZpo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Feb 2024 18:26:49 +0100
Subject: [PATCH 3/4] power: supply: mm8013: implement
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707067615; l=1478;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2bfpIaHPb+FVKiLlqv6onKrx8jugClAtzAL49QT9tj8=;
 b=YAQ1hO1l8kQ2VYBnblYST3jQhV0wwQngktbNHMJepEyv1/a45AjNO688GAhvqu6GTPruwmRT6
 WJKAK1usPsRCQSUvaXcHAkVVdbH8TBXgd/RbKNCcpOKqPQVfpGM2BS8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs is documented to report both the current and all available
behaviours. For this POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE needs
to be implemented.

Note that this changes the format of the sysfs file
(to the documented format):

Before: "auto"
After:  "[auto] inhibit-charge"

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/mm8013.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index caa272b03564..695df8bd6cb0 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -72,6 +72,7 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
 static enum power_supply_property mm8013_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
@@ -113,6 +114,10 @@ static int mm8013_get_property(struct power_supply *psy,
 		else
 			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE:
+		val->intval = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
+			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
 		if (ret < 0)

-- 
2.43.0


