Return-Path: <linux-kernel+bounces-35507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23EB839226
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7B2B237FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9765FDCC;
	Tue, 23 Jan 2024 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zmr98Cno"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506945FBA6;
	Tue, 23 Jan 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022569; cv=none; b=jolHawn+azd9CagB6huCHfQba+7+HjjQ60vfSc0kl4dFni+Nv/AZOuT3BTerCdkNb19xj+8mq4GAsALcs6+eZd/h73t7XRbBznDMGqOi4PVjyFW/fw0NDn6vhS2NqfalgunhqDyh+ivfEklH+JLQ/zC/6GMeRB9QzRMual0MVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022569; c=relaxed/simple;
	bh=UTIUm4JGGF1yQzAyMxxiGParwPa8ulPNa7PkwXl4NUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msjmoA+u2Ub/fe+7ba7VYXIjnjfrO5dJcR/sx8Y3iJjcljxYnkGjiW/Xhx9Hg1JFwEQ44Zd0z+qq/SrMz/tsOdPlgi15VVJv4qloSxYVhCxiNLaa+x8PdBlzoznPd+G9OfRcFrgXn4HCmi1CPTfrRZodV8GQmWSgHz+wZykM/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zmr98Cno; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9G5N071722;
	Tue, 23 Jan 2024 09:09:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706022556;
	bh=11mrXH87jJGLlmaEk7O3hQevdSFbmybFJkpPSU3t3Dg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Zmr98CnoFAvM7QkArWJSg/od1z7hULzc03vqAURbjzl/k7v4F9PAtqVp/vglfmW3C
	 h8xqdFjS28HKwnsgpLT+paD1xXQ95Yhpms1L2nfO9/Fr0xrT9mCwgZsXlmn+xK15Zv
	 wqtSXpXRWylxLESkCBNZFSOE8ppy/Z7BLmnnsSS0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NF9GDH045945
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 09:09:16 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9FE6128205;
	Tue, 23 Jan 2024 09:09:16 -0600
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 3/5] power: supply: bq27xxx: Use devm to free device mutex
Date: Tue, 23 Jan 2024 09:09:12 -0600
Message-ID: <20240123150914.308510-3-afd@ti.com>
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

Use a device lifecycle managed action to free the device mutex.
This helps prevent mistakes like freeing out of order in cleanup
functions and forgetting to free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1c4a9d1377442..d3b6327b16b56 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2101,6 +2101,13 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
+static void bq27xxx_battery_mutex_destroy(void *data)
+{
+	struct mutex *lock = data;
+
+	mutex_destroy(lock);
+}
+
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -2108,9 +2115,14 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.of_node = di->dev->of_node,
 		.drv_data = di,
 	};
+	int ret;
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
+	ret = devm_add_action_or_reset(di->dev, bq27xxx_battery_mutex_destroy,
+				       &di->lock);
+	if (ret)
+		return ret;
 
 	di->regs       = bq27xxx_chip_data[di->chip].regs;
 	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
@@ -2158,7 +2170,6 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	cancel_delayed_work_sync(&di->work);
 
 	power_supply_unregister(di->bat);
-	mutex_destroy(&di->lock);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
-- 
2.39.2


