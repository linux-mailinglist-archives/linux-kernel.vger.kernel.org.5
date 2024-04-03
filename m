Return-Path: <linux-kernel+bounces-130568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF18897A02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D078C1F207C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE84E1581E5;
	Wed,  3 Apr 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lsnaymbx"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38661156678;
	Wed,  3 Apr 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176629; cv=none; b=OYnqorN0P7nCzg1n7BvBeP4eEsr1Tb5fZJZozju2xTA33LMmJ5yywJe6OlFu6gkpm94GMjrI5gLvsn0YZUQE4YrgkAeJycEINGJEdgD6pLwj1rBzkHPBTDgRa8Lx0agf7OPKUq9bBIv113JiQ933WPD7OuLKiw5m8haZ9aAzxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176629; c=relaxed/simple;
	bh=JaZ5ykun3EZOuoA4qITrLpwumorz8LR/tXPrX9mErfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV+0HGMuOpJ0Z9VDlp1vBMY/UMYfcLP6+ZjNgMc/qKyssYKAQDaXBpvAijEZzs7Mm1SxuPfOBquriP6GQGHBrYfln6rDwPjcpqPZGMCfhd9df4Gya/QTG0Ptuk5PkMWEW2bqWFUy8eRw8LdIWQApSxy/bdgq8DEPt57au24ekvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lsnaymbx; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kag3x076337;
	Wed, 3 Apr 2024 15:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176602;
	bh=o1hHdo4s+DsFSQQBlovU/5ntoW97q5VnZpY0t16RvRE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lsnaymbxCs3/ymMiHRccMeZEmIPLHjrEYfsk2ZP6luZ6M6QZIGc/UjGlLggDvskF7
	 sybFCZAgPloRsyINLy7L4raDdxuZ/HzX+Sh9yVajMGHdKGFqUjJsp2cigy5R3aXPxZ
	 JoG1nKuNk+XD76sao/DmA5aEprGEhU+UMWw2/d+I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kag7c000559
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:41 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG3080324;
	Wed, 3 Apr 2024 15:36:41 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 22/31] hwmon: (mcp3021) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:24 -0500
Message-ID: <20240403203633.914389-23-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403203633.914389-1-afd@ti.com>
References: <20240403203633.914389-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwmon/mcp3021.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index 9814eaf245644..bcddf6804d3ab 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -116,13 +116,12 @@ static const struct hwmon_chip_info mcp3021_chip_info = {
 	.info = mcp3021_info,
 };
 
-static const struct i2c_device_id mcp3021_id[];
-
 static int mcp3021_probe(struct i2c_client *client)
 {
 	struct mcp3021_data *data = NULL;
 	struct device_node *np = client->dev.of_node;
 	struct device *hwmon_dev;
+	enum chips type;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -149,7 +148,8 @@ static int mcp3021_probe(struct i2c_client *client)
 			data->vdd = MCP3021_VDD_REF_DEFAULT;
 	}
 
-	switch (i2c_match_id(mcp3021_id, client)->driver_data) {
+	type = (uintptr_t)i2c_get_match_data(client);
+	switch (type) {
 	case mcp3021:
 		data->sar_shift = MCP3021_SAR_SHIFT;
 		data->sar_mask = MCP3021_SAR_MASK;
-- 
2.39.2


