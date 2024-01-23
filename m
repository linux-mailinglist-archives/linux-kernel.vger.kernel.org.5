Return-Path: <linux-kernel+bounces-35668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F08394FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA131F2BF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A685C52;
	Tue, 23 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iMP9XgPc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC880038;
	Tue, 23 Jan 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027829; cv=none; b=muLM04dG9ZyZ9qD3ARCrpQf+O5lqjQRyE8oeJGGKfVk7R2A4qf7KwE26LsR8tGoE03D0w7U0vpa5Ot4fHbk6CPQBnaILgzCKcwxHfTOuiAjlOdzCMp+MGJ0Z6Cql3QOJT1asI4L8fZbYvQY7XSBlZ/f5MCi6IBjBeknOpZjGxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027829; c=relaxed/simple;
	bh=sib0TkQvj3S1W9ly1E0oQa1xEeBpUynhGEbm7l/cqP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSJZVOAuxu4prtb1mPQmfjd66+kcgcWG3CaKEJCrXTpWe9jtKbxLM2RKXIayGbpGA5KvXXKP1m6tIHff3j+umZTbVahTek4ZpG6CfMtun9bGUNrndss2in+NjW7qKdZjysO2nl8I4jD3z/qhv+yY/zAV+oN+8j55NVOIxcocVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iMP9XgPc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGawJX049972;
	Tue, 23 Jan 2024 10:36:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027818;
	bh=JWMUjBOZcHQ/24fksWKYvgsQX4RI/NkJvEhshUgeviA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iMP9XgPcygy6EiGrxD0BBYR+Q66grASUHjj7wJQZTduVIEkieRLTHqNaClS5nMPHV
	 JOPAtYUEjtswQLAm4XVw4b3YpS4Bq7hZ54uqYXmOFgMaurG2/I87Ukqq6hgVEJAbBM
	 aE/8IzTpPNvmhP8409Z7HxrT7qb3l3AT4OQB7Puw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGawP1004249
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:58 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:58 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars1123403;
	Tue, 23 Jan 2024 10:36:58 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 13/21] power: supply: wm831x: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:45 -0600
Message-ID: <20240123163653.384385-14-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123163653.384385-1-afd@ti.com>
References: <20240123163653.384385-1-afd@ti.com>
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
 drivers/power/supply/wm831x_backup.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/wm831x_backup.c b/drivers/power/supply/wm831x_backup.c
index 1a7265660adeb..9673fcf7f3afb 100644
--- a/drivers/power/supply/wm831x_backup.c
+++ b/drivers/power/supply/wm831x_backup.c
@@ -171,7 +171,6 @@ static int wm831x_backup_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	devdata->wm831x = wm831x;
-	platform_set_drvdata(pdev, devdata);
 
 	/* We ignore configuration failures since we can still read
 	 * back the status without enabling the charger (which may
@@ -191,22 +190,14 @@ static int wm831x_backup_probe(struct platform_device *pdev)
 	devdata->backup_desc.properties = wm831x_backup_props;
 	devdata->backup_desc.num_properties = ARRAY_SIZE(wm831x_backup_props);
 	devdata->backup_desc.get_property = wm831x_backup_get_prop;
-	devdata->backup = power_supply_register(&pdev->dev,
-						&devdata->backup_desc, NULL);
+	devdata->backup = devm_power_supply_register(&pdev->dev,
+						     &devdata->backup_desc, NULL);
 
 	return PTR_ERR_OR_ZERO(devdata->backup);
 }
 
-static void wm831x_backup_remove(struct platform_device *pdev)
-{
-	struct wm831x_backup *devdata = platform_get_drvdata(pdev);
-
-	power_supply_unregister(devdata->backup);
-}
-
 static struct platform_driver wm831x_backup_driver = {
 	.probe = wm831x_backup_probe,
-	.remove_new = wm831x_backup_remove,
 	.driver = {
 		.name = "wm831x-backup",
 	},
-- 
2.39.2


