Return-Path: <linux-kernel+bounces-116976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05588A5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369302E4B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DA17DC18;
	Mon, 25 Mar 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBh/sJsF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84C1843;
	Mon, 25 Mar 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368602; cv=none; b=IgWaf652s05fmfvlmtTw7AkqzBRUhonBAalA5rIfsRNX5aHacTG+W27Zq2QQ+iMzdL2V6C861dQ2Hc4zsbTQqSBgpfRJmBGuG5teVGfV/F4bk2V9YlbI5I7qpaeu8vhCAGV3d32bk3qjy9eLVMvkUIPXIjYaFBz58v8sL6YlSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368602; c=relaxed/simple;
	bh=OmCFaQ0QL0ZY3hfBw/hp9a6NNGjTQFwFe46YUfQbR4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRMhzZEjuU9t/lNwiEhz0mFVg2f64pU4Ne9iJEDr2ap7t6fQNvFVn8ZkQ0Bie5x/yIXfEvj2w4VSkswVUv+m6xlTunHW7THa8gsBn68RH3dXtghCIWg3umUqeIxVM2FNhMLDA2Pi5YVNjmL0YxDg2d8N852AxipWlSxx8mC9F6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBh/sJsF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711368600; x=1742904600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmCFaQ0QL0ZY3hfBw/hp9a6NNGjTQFwFe46YUfQbR4g=;
  b=EBh/sJsFqXSE9SkJUrMVTvvDaSt7ZD9dVTeFjFZWszzgQjpbjj1E4cmQ
   iIiCLNoqu3S0e1vqvUyHJyoMLft/m6yPvOz/axnBLFWc0KiDemKFcnpRA
   V924Fc4xqQxwgzLu4S3SjuzqBhFtVAbljpHp6PZYY8qvRt+7Ybbu0jyC5
   ouwVayKEPgkPE+Bo+mA3yOmlEsYqjFg8QzA+rz5d1+3Bh01V/QyZxq110
   vL9OokUbq7ALb4cLNEiJrMQK3zVTjzG5uDynnYCWAaPorZMVRRdlgcBLv
   +hQjejNVh7oAA1kJZe+gtsjPL+BcNyAHJqhKI70XQmkkB6h2/jQcYyZVf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17757437"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17757437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070314"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070314"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 22530233; Mon, 25 Mar 2024 14:09:53 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] hwmon: (pmbus/mp2975) Use i2c_get_match_data()
Date: Mon, 25 Mar 2024 14:07:44 +0200
Message-ID: <20240325120952.3019767-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use preferred i2c_get_match_data() instead of of_device_get_match_data()
to get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/pmbus/mp2975.c | 54 +++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index bc7558dc87ee..79b4ea325cb2 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -10,8 +10,9 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+
 #include "pmbus.h"
 
 /* Vendor specific registers. */
@@ -98,6 +99,11 @@ static const int mp2975_max_phases[][MP2975_PAGE_NUM] = {
 	[mp2971] = { MP2971_MAX_PHASE_RAIL1, MP2971_MAX_PHASE_RAIL2 },
 };
 
+struct mp2975_driver_info {
+	const struct pmbus_driver_info *info;
+	enum chips chip_id;
+};
+
 struct mp2975_data {
 	struct pmbus_driver_info info;
 	enum chips chip_id;
@@ -111,15 +117,6 @@ struct mp2975_data {
 	int curr_sense_gain[MP2975_PAGE_NUM];
 };
 
-static const struct i2c_device_id mp2975_id[] = {
-	{"mp2971", mp2971},
-	{"mp2973", mp2973},
-	{"mp2975", mp2975},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, mp2975_id);
-
 static const struct regulator_desc __maybe_unused mp2975_reg_desc[] = {
 	PMBUS_REGULATOR("vout", 0),
 	PMBUS_REGULATOR("vout", 1),
@@ -989,29 +986,34 @@ static const struct pmbus_driver_info mp2973_info = {
 #endif
 };
 
+static const struct mp2975_driver_info mp2975_ddinfo[] = {
+	[mp2975] = { .info = &mp2975_info, .chip_id = mp2975 },
+	[mp2973] = { .info = &mp2973_info, .chip_id = mp2973 },
+	[mp2971] = { .info = &mp2973_info, .chip_id = mp2971 },
+};
+
 static int mp2975_probe(struct i2c_client *client)
 {
+	const struct mp2975_driver_info *ddinfo;
 	struct pmbus_driver_info *info;
 	struct mp2975_data *data;
 	int ret;
 
+	ddinfo = i2c_get_match_data(client);
+	if (!ddinfo)
+		return -ENODEV;
+
 	data = devm_kzalloc(&client->dev, sizeof(struct mp2975_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	if (client->dev.of_node)
-		data->chip_id = (enum chips)(unsigned long)of_device_get_match_data(&client->dev);
-	else
-		data->chip_id = i2c_match_id(mp2975_id, client)->driver_data;
+	data->chip_id = ddinfo->chip_id;
 
 	memcpy(data->max_phases, mp2975_max_phases[data->chip_id],
 	       sizeof(data->max_phases));
 
-	if (data->chip_id == mp2975)
-		memcpy(&data->info, &mp2975_info, sizeof(*info));
-	else
-		memcpy(&data->info, &mp2973_info, sizeof(*info));
+	memcpy(&data->info, ddinfo->info, sizeof(data->info));
 
 	info = &data->info;
 
@@ -1070,17 +1072,25 @@ static int mp2975_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id __maybe_unused mp2975_of_match[] = {
-	{.compatible = "mps,mp2971", .data = (void *)mp2971},
-	{.compatible = "mps,mp2973", .data = (void *)mp2973},
-	{.compatible = "mps,mp2975", .data = (void *)mp2975},
+	{.compatible = "mps,mp2971", .data = &mp2975_ddinfo[mp2971]},
+	{.compatible = "mps,mp2973", .data = &mp2975_ddinfo[mp2973]},
+	{.compatible = "mps,mp2975", .data = &mp2975_ddinfo[mp2975]},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mp2975_of_match);
 
+static const struct i2c_device_id mp2975_id[] = {
+	{"mp2971", (kernel_ulong_t)&mp2975_ddinfo[mp2971]},
+	{"mp2973", (kernel_ulong_t)&mp2975_ddinfo[mp2973]},
+	{"mp2975", (kernel_ulong_t)&mp2975_ddinfo[mp2975]},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp2975_id);
+
 static struct i2c_driver mp2975_driver = {
 	.driver = {
 		.name = "mp2975",
-		.of_match_table = of_match_ptr(mp2975_of_match),
+		.of_match_table = mp2975_of_match,
 	},
 	.probe = mp2975_probe,
 	.id_table = mp2975_id,
-- 
2.43.0.rc1.1.gbec44491f096


