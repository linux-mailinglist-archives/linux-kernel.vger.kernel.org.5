Return-Path: <linux-kernel+bounces-46333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD145843E20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C261F21164
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1378672;
	Wed, 31 Jan 2024 11:17:13 +0000 (UTC)
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [217.26.49.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCE6D1BA;
	Wed, 31 Jan 2024 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.26.49.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699833; cv=none; b=B1MbYpZCHksZU814yeTR3V0aAaP5FB039+GE80efmjMUfqVoRoR589V/feNCWU4/cQJz2AaPkpVebERPgY1pFZiIeBxL7EygqrRj3wXH5Ygt2iEC2rsTmcD70MVnDY/tJVZi7SXryZVNq1FMD3qzvi4jRodEE68qgXqe6qr/8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699833; c=relaxed/simple;
	bh=bi0Uckinvs++A9lPfNrJcVzgqzcSVsKWlDd2cPXeYj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlGuxSUirZEdjDM4vvQpfSg70TXgc1TT/a0WanqVromdLYsamfozGP/8VfRQMtsN/kI718gt4iqxgQchbk2spzx3TMH+xRT6oXWaiRZbmqi/0mQX9/V6c19n6r1d8MRS0kIM12SxuSFeDNmwFogr/U/4BhYHmGiSqZ81vAhdGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-gloor.ch; spf=pass smtp.mailfrom=stefan-gloor.ch; arc=none smtp.client-ip=217.26.49.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-gloor.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stefan-gloor.ch
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
	by mxout012.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rV8ZB-0000000055k-20LK;
	Wed, 31 Jan 2024 12:15:41 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad.localdomain)
	by asmtp014.mail.hostpoint.ch with esmtpa (Exim 4.97.1 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rV8ZB-000000009un-0gBT;
	Wed, 31 Jan 2024 12:15:41 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
From: Stefan Gloor <code@stefan-gloor.ch>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefan Gloor <code@stefan-gloor.ch>
Subject: [PATCH v4 1/1] hwmon: (sht3x) read out sensor serial number
Date: Wed, 31 Jan 2024 12:15:12 +0100
Message-ID: <20240131111512.25321-2-code@stefan-gloor.ch>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240131111512.25321-1-code@stefan-gloor.ch>
References: <20240131111512.25321-1-code@stefan-gloor.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Vs-State: 0

The temperature/humidity sensors of the STS3x/SHT3x family are
calibrated and factory-programmed with a unique serial number.
For some sensors, this serial number can be used to obtain a calibration
certificate via an API provided by the manufacturer (Sensirion).
Expose the serial number via debugfs.

Tested with: 2x STS31, 1x STS32, 1x SHT31

Signed-off-by: Stefan Gloor <code@stefan-gloor.ch>
---
 Documentation/hwmon/sht3x.rst | 11 ++++++
 drivers/hwmon/sht3x.c         | 66 ++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 957c854f5d08..9585fa7c5a5d 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -65,6 +65,10 @@ When the temperature and humidity readings move back between the hysteresis
 values, the alert bit is set to 0 and the alert pin on the sensor is set to
 low.
 
+The serial number exposed to debugfs allows for unique identification of the
+sensors. For sts32, sts33 and sht33, the manufacturer provides calibration
+certificates through an API.
+
 sysfs-Interface
 ---------------
 
@@ -99,3 +103,10 @@ repeatability:      write or read repeatability, higher repeatability means
                         - 1: medium repeatability
                         - 2: high repeatability
 =================== ============================================================
+
+debugfs-Interface
+-----------------
+
+=================== ============================================================
+serial_number:      unique serial number of the sensor in decimal
+=================== ============================================================
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 79657910b79e..c0d02fbcdb76 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -10,6 +10,7 @@
 
 #include <asm/page.h>
 #include <linux/crc8.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
@@ -41,6 +42,9 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
 /* other commands */
 static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
 static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
+static const unsigned char sht3x_cmd_read_serial_number[]      = { 0x37, 0x80 };
+
+static struct dentry *debugfs;
 
 /* delays for single-shot mode i2c commands, both in us */
 #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
@@ -163,12 +167,14 @@ struct sht3x_data {
 	enum sht3x_chips chip_id;
 	struct mutex i2c_lock; /* lock for sending i2c commands */
 	struct mutex data_lock; /* lock for updating driver data */
+	struct dentry *sensor_dir;
 
 	u8 mode;
 	const unsigned char *command;
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
 	enum sht3x_repeatability repeatability;
+	u32 serial_number;
 
 	/*
 	 * cached values for temperature and humidity and limits
@@ -831,6 +837,40 @@ static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
+static void sht3x_debugfs_init(struct sht3x_data *data)
+{
+	char name[32];
+
+	snprintf(name, sizeof(name), "i2c%u-%02x",
+		 data->client->adapter->nr, data->client->addr);
+	data->sensor_dir = debugfs_create_dir(name, debugfs);
+	debugfs_create_u32("serial_number", 0444,
+			   data->sensor_dir, &data->serial_number);
+}
+
+static void sht3x_debugfs_remove(void *sensor_dir)
+{
+	debugfs_remove_recursive(sensor_dir);
+}
+
+static int sht3x_serial_number_read(struct sht3x_data *data)
+{
+	int ret;
+	char buffer[SHT3X_RESPONSE_LENGTH];
+	struct i2c_client *client = data->client;
+
+	ret = sht3x_read_from_command(client, data,
+				      sht3x_cmd_read_serial_number,
+				      buffer,
+				      SHT3X_RESPONSE_LENGTH, 0);
+	if (ret)
+		return ret;
+
+	data->serial_number = (buffer[0] << 24) | (buffer[1] << 16) |
+			      (buffer[3] << 8) | buffer[4];
+	return ret;
+}
+
 static const struct hwmon_ops sht3x_ops = {
 	.is_visible = sht3x_is_visible,
 	.read = sht3x_read,
@@ -899,6 +939,18 @@ static int sht3x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = sht3x_serial_number_read(data);
+	if (ret) {
+		dev_dbg(dev, "unable to read serial number\n");
+	} else {
+		sht3x_debugfs_init(data);
+		ret = devm_add_action_or_reset(dev,
+					       sht3x_debugfs_remove,
+					       data->sensor_dir);
+		if (ret)
+			return ret;
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev,
 							 client->name,
 							 data,
@@ -917,7 +969,19 @@ static struct i2c_driver sht3x_i2c_driver = {
 	.id_table    = sht3x_ids,
 };
 
-module_i2c_driver(sht3x_i2c_driver);
+static int __init sht3x_init(void)
+{
+	debugfs = debugfs_create_dir("sht3x", NULL);
+	return i2c_add_driver(&sht3x_i2c_driver);
+}
+module_init(sht3x_init);
+
+static void __exit sht3x_cleanup(void)
+{
+	debugfs_remove_recursive(debugfs);
+	i2c_del_driver(&sht3x_i2c_driver);
+}
+module_exit(sht3x_cleanup);
 
 MODULE_AUTHOR("David Frey <david.frey@sensirion.com>");
 MODULE_AUTHOR("Pascal Sachs <pascal.sachs@sensirion.com>");
-- 
2.41.0


