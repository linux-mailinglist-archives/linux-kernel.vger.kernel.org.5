Return-Path: <linux-kernel+bounces-35509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC383922B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280C21C229C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124D5FB86;
	Tue, 23 Jan 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NtZoKrAz"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15435FEFF;
	Tue, 23 Jan 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022573; cv=none; b=cdPX6AhALA1zVXAD2T/U0fvxfXDc6AkUOrnbEcWOOm/P+iSbhOicy7vJMp7K/WV23QypW7H3+JUyRAybhl1Xc0q4TLuV8pCCjqqU3raWGwn7XVLD9t1lTiYqWIzGfIWDVsWly5kUH4WVebzlYinvzK8M/a6FLFgTpzqSi4WRJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022573; c=relaxed/simple;
	bh=TR+JZ2LAe+2IY3y6XWtBU3J7Q30KfFb19RmcJWo9PP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uC8NTff8/5jKMgwAB5LaY2y7Y5LnB17IdNIYBcWf0+cdvE2mKpy+HJRcfpybXQIloWGDHTCsBHK1+0yqPrTK1l3RVszVsraXRD4dAUEz2+TDpWr4uV4LBWFj5Z8rH9bj50kAO6sT52up4oMqpQQ27/EKuM1RLJIAkr9U1Hocr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NtZoKrAz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9Hlr057182;
	Tue, 23 Jan 2024 09:09:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706022557;
	bh=XBxIuTPwoOzGfB8OHKOyASLbyJf1pzgDv1spHNZWZnA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NtZoKrAzdeflXcYyaO4MnxJWiDUedOzLGDYD+cHGriwdfFifV1VzWWxS3l9/CXAxV
	 rUT6ss1YkQQMq/jsZLUE6ubRXXBEeSZ9jTikXLJmQERnucifNazjGWjjrpRMYQfx1C
	 xXdcMLzRtqzrrY0eSQDrBWtzMAp808iOyVyyVjqk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NF9H8O075316
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 09:09:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9FE7128205;
	Tue, 23 Jan 2024 09:09:16 -0600
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 4/5] power: supply: bq27xxx: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 09:09:13 -0600
Message-ID: <20240123150914.308510-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123150914.308510-1-afd@ti.com>
References: <20240123150914.308510-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed register function. This helps prevent
mistakes like unregistering out of order in cleanup functions and
forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d3b6327b16b56..2bf5e007f16b2 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2140,7 +2140,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
-	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
+	di->bat = devm_power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return dev_err_probe(di->dev, PTR_ERR(di->bat),
 				     "failed to register battery\n");
@@ -2168,8 +2168,6 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	mutex_unlock(&di->lock);
 
 	cancel_delayed_work_sync(&di->work);
-
-	power_supply_unregister(di->bat);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
-- 
2.39.2


