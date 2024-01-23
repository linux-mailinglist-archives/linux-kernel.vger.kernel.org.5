Return-Path: <linux-kernel+bounces-35508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4577839227
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B929413B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC75FEEC;
	Tue, 23 Jan 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jKbsqhg4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506555FBA4;
	Tue, 23 Jan 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022570; cv=none; b=Cn20BWazz7/vT7olKdTthiBbp35rHwQxZFqaOEJ599WVyCD23/P+jgE/OPPfLIe8fv/klq/3QYj9eHN2pmI2Q5ApBWIozNYozx9t/Ws9aUmvi5daVK2g+nRXSN2V5TtOreUY+/+rfp6T+u9PGeoWrRxqwAF7gjlmp+47yrSia/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022570; c=relaxed/simple;
	bh=iKB5PHhQJrCVqYkttAams/e+uE3rZowr9sAkkNMLjqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HC//ax2jaEnhsJpAadDj97W4nkgWQmJ7Yh/UcGZbO/tXKjnav9jL1JElaRp7iKiw5sXDDFutvEWGhGd2lHWl0xlw4yAMTybM0bpv84WP1Y/G1kqslRxJCL4Njqle8lpOyidbcga+yHMdDpzhU20bgZm1KnID6F/wawdkjWsr+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jKbsqhg4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9Ghc071718;
	Tue, 23 Jan 2024 09:09:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706022556;
	bh=U8z/mm6tvX41IgL5zXvGtQyrqKekNbTjdaLCuQcgzpg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jKbsqhg4C1Tu5lYQWhHsNyRK8qFLDXBU0N3enrghanw+IiV1VHRH1EKSkKZbAKv1k
	 sHoIKOjB2jneX+ItMas+VOzuftsD+S6mY026eR18RlPuCx695NvrIIEUqNeYNXgM8B
	 yL6Rh1Tb9YcmxJdLTe1CLtFTVjH9rA4v5qVQBjk4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NF9GSE075202
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 09:09:16 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9FE5128205;
	Tue, 23 Jan 2024 09:09:16 -0600
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/5] power: supply: bq27xxx: Add devm action to free IDA
Date: Tue, 23 Jan 2024 09:09:11 -0600
Message-ID: <20240123150914.308510-2-afd@ti.com>
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

Use a device lifecycle managed action to free the IDA. This helps
prevent mistakes like freeing out of order in cleanup functions and
forgetting to free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 35 +++++++++++-----------
 include/linux/power/bq27xxx_battery.h      |  1 -
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 86ce13a8ab9dd..019f29d13d28a 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -135,28 +135,39 @@ static int bq27xxx_battery_i2c_bulk_write(struct bq27xxx_device_info *di,
 	return 0;
 }
 
+static void bq27xxx_battery_i2c_devm_ida_free(void *data)
+{
+	int num = (long)data;
+
+	ida_free(&battery_id, num);
+}
+
 static int bq27xxx_battery_i2c_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct bq27xxx_device_info *di;
 	int ret;
 	char *name;
-	int num;
+	long num;
 
 	/* Get new ID for the new battery device */
 	num = ida_alloc(&battery_id, GFP_KERNEL);
 	if (num < 0)
 		return num;
+	ret = devm_add_action_or_reset(&client->dev,
+				       bq27xxx_battery_i2c_devm_ida_free,
+				       (void *)num);
+	if (ret)
+		return ret;
 
-	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name, num);
+	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%ld", id->name, num);
 	if (!name)
-		goto err_mem;
+		return -ENOMEM;
 
 	di = devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
-		goto err_mem;
+		return -ENOMEM;
 
-	di->id = num;
 	di->dev = &client->dev;
 	di->chip = id->driver_data;
 	di->name = name;
@@ -168,7 +179,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client)
 
 	ret = bq27xxx_battery_setup(di);
 	if (ret)
-		goto err_failed;
+		return ret;
 
 	/* Schedule a polling after about 1 min */
 	schedule_delayed_work(&di->work, 60 * HZ);
@@ -185,19 +196,11 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client)
 				"Unable to register IRQ %d error %d\n",
 				client->irq, ret);
 			bq27xxx_battery_teardown(di);
-			goto err_failed;
+			return ret;
 		}
 	}
 
 	return 0;
-
-err_mem:
-	ret = -ENOMEM;
-
-err_failed:
-	ida_free(&battery_id, num);
-
-	return ret;
 }
 
 static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
@@ -206,8 +209,6 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 
 	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
-
-	ida_free(&battery_id, di->id);
 }
 
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 7d8025fb74b70..b9e5bd2b42d36 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -61,7 +61,6 @@ struct bq27xxx_reg_cache {
 
 struct bq27xxx_device_info {
 	struct device *dev;
-	int id;
 	enum bq27xxx_chip chip;
 	u32 opts;
 	const char *name;
-- 
2.39.2


