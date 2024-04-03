Return-Path: <linux-kernel+bounces-130582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F6897A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FE61F21C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC9158DCD;
	Wed,  3 Apr 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O4/Y9Lnt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD59158851;
	Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176634; cv=none; b=AmiCOOAnr4p6Ie36qv3HbV1HwcEt9316dwjYMZAv0PsQoo3mRk8DC6PYZa8y3stRQJVmZqZ4I3WTs3R+Du4F2m+/DxMAd/4/N1yAzhDGOIodGoZyw8QZ/9N5MCXEZpSxWdD2XFvmMfkg6LO8OGdwm2KArmSri7fAZH+fa1+GWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176634; c=relaxed/simple;
	bh=+j2zDD05erOYmUDf5cAUGonJ26jb9YMO8vUCwuJEirA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHH34XEBR/NZc8fS23rDhm0qlZZ1EZ3UfrpK3Jq6f4iduldHzeB9G+3jDWl4oEo5O7t59K87NPVEg+YO6ODKlunkJqtb2I7B23qPrIkjn3gzxaEheLZWVEPl8VnDuqEiqTeHsoO4OYrNc2a4w22bLO/mPLHZdXQwu89ZoE7STtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O4/Y9Lnt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KahbW076415;
	Wed, 3 Apr 2024 15:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176603;
	bh=oeRxtViThx6D2NDyoozxbhE8Wue1F9JnFhBNbwoja0I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O4/Y9LntmUsM+sFyIZ+Iowl5/DmGoIMkGuQuUZf7638vHwEEVPmjMroPFNm7hX0tO
	 NrfE6+GYp2O2oW4eNiKFmCkWFDGNxin3ghmjwpTX8D5c224i2FjtEze9t/toQ1Vnnz
	 OGe2IQMoMlQTbpgGM+a6YXrsmh9kLoNpxWDmSlg0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kaht9052147
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:43 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG8080324;
	Wed, 3 Apr 2024 15:36:43 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 27/31] hwmon: (tmp401) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:29 -0500
Message-ID: <20240403203633.914389-28-afd@ti.com>
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
 drivers/hwmon/tmp401.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index df1b45a62e804..853dbe708ff5d 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -693,7 +693,7 @@ static int tmp401_probe(struct i2c_client *client)
 
 	data->client = client;
 	mutex_init(&data->update_lock);
-	data->kind = i2c_match_id(tmp401_id, client)->driver_data;
+	data->kind = (uintptr_t)i2c_get_match_data(client);
 
 	data->regmap = devm_regmap_init(dev, NULL, data, &tmp401_regmap_config);
 	if (IS_ERR(data->regmap))
-- 
2.39.2


