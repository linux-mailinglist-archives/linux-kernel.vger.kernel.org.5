Return-Path: <linux-kernel+bounces-152367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15DE8ABD01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B505CB20CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559F47F64;
	Sat, 20 Apr 2024 20:04:08 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16547F41;
	Sat, 20 Apr 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643447; cv=none; b=LzDwkP+kzujEA2gFec0PfKYuriwPsnEnD5mH3U2ZezktVGTiqollw7Cjqio2fvrgOd37XxV3bdta1u9fG31N2f+EuC6znplF5WoxesqNCyTc9WLaconojStXcGrR0zQhaIWqzN7w0Qzupc+mB1mnARZLHCYu5orKQ6PfjDcfmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643447; c=relaxed/simple;
	bh=7otAGZc9k9MKc/6B4+yMK3GVBxObnZ7gLnUmDP9hJug=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=fOGHHe6HUqFiQUT3QyN68Wn5laV0YCl15WziYN0wfjYq6BPDKV0tdzXfOQOEDL40lasaiMAsOh6HAX/jVHugGLeQzOyEVzxZNLAUArrswx55/bdYXKbJNXyNhbKapwrA8uQubJym0XV8XvGJ0WpehmGuYjcAe5BA6p4NdVyHTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 246B71003D027;
	Sat, 20 Apr 2024 22:03:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D4A3610C1A8; Sat, 20 Apr 2024 22:03:57 +0200 (CEST)
Message-ID: <23c2031acaa64f1c02f00e817c3f7e4466d17ab2.1713608122.git.lukas@wunner.de>
In-Reply-To: <cover.1713608122.git.lukas@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 20 Apr 2024 22:00:02 +0200
Subject: [PATCH 2/6] hwmon: Use device_show_string() helper for sysfs
 attributes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Deduplicate sysfs ->show() callbacks which expose a string at a static
memory location.  Use the newly introduced device_show_string() helper
in the driver core instead by declaring those sysfs attributes with
DEVICE_STRING_ATTR_RO().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/hwmon/i5k_amb.c | 15 ++++-----------
 drivers/hwmon/ibmpex.c  | 14 ++++----------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index ff48913fe6bf..02f5d35dd319 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -101,14 +101,7 @@ struct i5k_amb_data {
 	unsigned int num_attrs;
 };
 
-static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
-{
-	return sprintf(buf, "%s\n", DRVNAME);
-}
-
-
-static DEVICE_ATTR_RO(name);
+static DEVICE_STRING_ATTR_RO(name, 0444, DRVNAME);
 
 static struct platform_device *amb_pdev;
 
@@ -373,7 +366,7 @@ static int i5k_amb_hwmon_init(struct platform_device *pdev)
 		}
 	}
 
-	res = device_create_file(&pdev->dev, &dev_attr_name);
+	res = device_create_file(&pdev->dev, &dev_attr_name.attr);
 	if (res)
 		goto exit_remove;
 
@@ -386,7 +379,7 @@ static int i5k_amb_hwmon_init(struct platform_device *pdev)
 	return res;
 
 exit_remove:
-	device_remove_file(&pdev->dev, &dev_attr_name);
+	device_remove_file(&pdev->dev, &dev_attr_name.attr);
 	for (i = 0; i < data->num_attrs; i++)
 		device_remove_file(&pdev->dev, &data->attrs[i].s_attr.dev_attr);
 	kfree(data->attrs);
@@ -561,7 +554,7 @@ static void i5k_amb_remove(struct platform_device *pdev)
 	struct i5k_amb_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	device_remove_file(&pdev->dev, &dev_attr_name);
+	device_remove_file(&pdev->dev, &dev_attr_name.attr);
 	for (i = 0; i < data->num_attrs; i++)
 		device_remove_file(&pdev->dev, &data->attrs[i].s_attr.dev_attr);
 	kfree(data->attrs);
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index db066b368918..228c5f6c6f38 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -256,12 +256,7 @@ static struct ibmpex_bmc_data *get_bmc_data(int iface)
 	return NULL;
 }
 
-static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
-{
-	return sprintf(buf, "%s\n", DRVNAME);
-}
-static SENSOR_DEVICE_ATTR_RO(name, name, 0);
+static DEVICE_STRING_ATTR_RO(name, 0444, DRVNAME);
 
 static ssize_t ibmpex_show_sensor(struct device *dev,
 				  struct device_attribute *devattr,
@@ -415,8 +410,7 @@ static int ibmpex_find_sensors(struct ibmpex_bmc_data *data)
 	if (err)
 		goto exit_remove;
 
-	err = device_create_file(data->bmc_device,
-			&sensor_dev_attr_name.dev_attr);
+	err = device_create_file(data->bmc_device, &dev_attr_name.attr);
 	if (err)
 		goto exit_remove;
 
@@ -425,7 +419,7 @@ static int ibmpex_find_sensors(struct ibmpex_bmc_data *data)
 exit_remove:
 	device_remove_file(data->bmc_device,
 			   &sensor_dev_attr_reset_high_low.dev_attr);
-	device_remove_file(data->bmc_device, &sensor_dev_attr_name.dev_attr);
+	device_remove_file(data->bmc_device, &dev_attr_name.attr);
 	for (i = 0; i < data->num_sensors; i++)
 		for (j = 0; j < PEX_NUM_SENSOR_FUNCS; j++) {
 			if (!data->sensors[i].attr[j].dev_attr.attr.name)
@@ -516,7 +510,7 @@ static void ibmpex_bmc_delete(struct ibmpex_bmc_data *data)
 
 	device_remove_file(data->bmc_device,
 			   &sensor_dev_attr_reset_high_low.dev_attr);
-	device_remove_file(data->bmc_device, &sensor_dev_attr_name.dev_attr);
+	device_remove_file(data->bmc_device, &dev_attr_name.attr);
 	for (i = 0; i < data->num_sensors; i++)
 		for (j = 0; j < PEX_NUM_SENSOR_FUNCS; j++) {
 			if (!data->sensors[i].attr[j].dev_attr.attr.name)
-- 
2.43.0


