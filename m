Return-Path: <linux-kernel+bounces-130581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A2897A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B80286A39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17476158DA6;
	Wed,  3 Apr 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rJUoIIt0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6311586EA;
	Wed,  3 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176633; cv=none; b=KTy8pu6KdX4UmjSYeeXORX8mr+1vBS7IEoQ52i/RUuyz3zRRNMsl/CgRS1VD+2cfzdTsiG9xmXi4MZpprumZDo0zRtn2L5Uud92IlRYrIq7r677irEjVuo/gxOI2ERM3SU1z4jCcoBPpvHT0+CY7TNNJvTBsLsDMCs+yIG7FAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176633; c=relaxed/simple;
	bh=nkd6dRREHPwcpDGGNrov5m7ucRaMD8SFstXdDMojjxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jR7XwRfNZPYuHrEkJ1YZNbYJ9yCas6whaHOOHIJranRsxSiK0Eb4nEYMncQeye3byM0ZjZZsVTMYMLx/moDxg5Bvt+e6X9Wo/Xznqg2Nlbh2jts/mX5YoyU62nfQkR3PGRF0MH+s6Iv9S5OhTXeCEEQs8Rx6sHHc1xkPwdao+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rJUoIIt0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kagp7076410;
	Wed, 3 Apr 2024 15:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176602;
	bh=x+NGttmZsmEmqDB8uQHkqDv87pFr7T95SquiSR8LsvI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rJUoIIt0C0VnAbG5Fw9y+lgMo7htXwZ3UZrfrn+KyJoLI2qLEIyR57TqS+uxd9n86
	 FIKE6xGzukiYcJKly7VmQA2cSRIgc1F21rO+KekrGobrwu2NzLBTwXfT7GV0Lqk5VV
	 N/jaWyILCfg1SuvPHl+BUNZUPyPmGQOdO9mrIvWk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kags8052137
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:42 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:42 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG5080324;
	Wed, 3 Apr 2024 15:36:42 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 24/31] hwmon: (sht3x) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:26 -0500
Message-ID: <20240403203633.914389-25-afd@ti.com>
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
 drivers/hwmon/sht3x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index c0d02fbcdb76c..650b0bcc2359e 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -882,15 +882,6 @@ static const struct hwmon_chip_info sht3x_chip_info = {
 	.info = sht3x_channel_info,
 };
 
-/* device ID table */
-static const struct i2c_device_id sht3x_ids[] = {
-	{"sht3x", sht3x},
-	{"sts3x", sts3x},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, sht3x_ids);
-
 static int sht3x_probe(struct i2c_client *client)
 {
 	int ret;
@@ -920,7 +911,7 @@ static int sht3x_probe(struct i2c_client *client)
 	data->mode = 0;
 	data->last_update = jiffies - msecs_to_jiffies(3000);
 	data->client = client;
-	data->chip_id = i2c_match_id(sht3x_ids, client)->driver_data;
+	data->chip_id = (uintptr_t)i2c_get_match_data(client);
 	crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
 
 	sht3x_select_command(data);
@@ -963,6 +954,15 @@ static int sht3x_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+/* device ID table */
+static const struct i2c_device_id sht3x_ids[] = {
+	{"sht3x", sht3x},
+	{"sts3x", sts3x},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, sht3x_ids);
+
 static struct i2c_driver sht3x_i2c_driver = {
 	.driver.name = "sht3x",
 	.probe       = sht3x_probe,
-- 
2.39.2


