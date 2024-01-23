Return-Path: <linux-kernel+bounces-35510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5583922C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A3C1C22D29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6760267;
	Tue, 23 Jan 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BBdgU6u/"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FD5F55B;
	Tue, 23 Jan 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022573; cv=none; b=JavfFm1sCZWOA8NquMh3hSDj/bku16C2YBACS1WbCZe6/2I6pIgEzCmyRw1n7g6YoRzlr85sGYgO+3muJe4dsCQpBGxyAqjb1Gt5O8/LBVEGVNeZA4JDdyGAZTxEVXAlt41nRHjUD6k8YIGY1aMW4lCcG9rzheeTeFO9XECX+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022573; c=relaxed/simple;
	bh=OmY52dAJtLk+DFU1yWAq3MiNuVQtFcHtaahSuJx1y14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfoILR6mTuiGLfQB2XiUP+rHSG4GSLTHX3WOkGpRO+JTnHu84UWDMgtVRoc+//KCH1+nizUgyZ52eFyx2jFfcLg5A0gBOUgdbEKAZLi069iROxKrKHGEqMoTcf/5rubhx25hIl/I43VfEJR3qdrGoteCTmbCtM9LoKMaSOWCDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BBdgU6u/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9Hr8057186;
	Tue, 23 Jan 2024 09:09:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706022557;
	bh=cQO8AG1imo5nzL+9z6gHt9JLJg6ArVzr0rRl02yudVg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BBdgU6u/z+LChgmxrc5nlwoJaikDTChA8orEgn51eKY/21RZg0+jjF9RTptBCQuk+
	 inu7Z+X4efNUluSmyiL4wA7xOb8NqJXzDa0eaQUKgcOfQU5yavn/uVq4ysgDl0GSI5
	 IDfv2R8GjaOnnB8ILEeJA4Ecldgq+2bVTdqO/Cj8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NF9Hjg029596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 09:09:17 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 09:09:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 09:09:17 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9FE8128205;
	Tue, 23 Jan 2024 09:09:16 -0600
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 5/5] power: supply: bq27xxx: Move one time design full read out of poll
Date: Tue, 23 Jan 2024 09:09:14 -0600
Message-ID: <20240123150914.308510-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123150914.308510-1-afd@ti.com>
References: <20240123150914.308510-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This value only needs read once. Move that read into the function
that returns the value to keep the logic all in one place. This
also avoids doing this check every time we read in values in
the device update poll worker.

While here, correct this function's error message.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2bf5e007f16b2..363428530ee60 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1595,17 +1595,24 @@ static inline int bq27xxx_battery_read_fcc(struct bq27xxx_device_info *di)
  * Return the Design Capacity in µAh
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
+static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di,
+				     union power_supply_propval *val)
 {
 	int dcap;
 
+	/* We only have to read charge design full once */
+	if (di->charge_design_full > 0) {
+		val->intval = di->charge_design_full;
+		return 0;
+	}
+
 	if (di->opts & BQ27XXX_O_ZERO)
 		dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, true);
 	else
 		dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
 
 	if (dcap < 0) {
-		dev_dbg(di->dev, "error reading initial last measured discharge\n");
+		dev_dbg(di->dev, "error reading design capacity\n");
 		return dcap;
 	}
 
@@ -1614,7 +1621,12 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
 	else
 		dcap *= 1000;
 
-	return dcap;
+	/* Save for later reads */
+	di->charge_design_full = dcap;
+
+	val->intval = dcap;
+
+	return 0;
 }
 
 /*
@@ -1865,10 +1877,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		 */
 		if (!(di->opts & BQ27XXX_O_ZERO))
 			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
-
-		/* We only have to read charge design full once */
-		if (di->charge_design_full <= 0)
-			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
 	if ((di->cache.capacity != cache.capacity) ||
@@ -2062,7 +2070,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_simple_value(di->cache.charge_full, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		ret = bq27xxx_simple_value(di->charge_design_full, val);
+		ret = bq27xxx_battery_read_dcap(di, val);
 		break;
 	/*
 	 * TODO: Implement these to make registers set from
-- 
2.39.2


