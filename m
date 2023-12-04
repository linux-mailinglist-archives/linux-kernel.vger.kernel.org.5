Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC65803ADB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjLDQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjLDQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:51:43 -0500
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B3C6;
        Mon,  4 Dec 2023 08:51:48 -0800 (PST)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1rACAV-000EP8-2S;
        Mon, 04 Dec 2023 17:51:39 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad.localdomain)
        by asmtp013.mail.hostpoint.ch with esmtpa (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1rACAV-000JX2-1i;
        Mon, 04 Dec 2023 17:51:39 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
From:   Stefan Gloor <code@stefan-gloor.ch>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Gloor <code@stefan-gloor.ch>
Subject: [PATCH v2 2/2] hwmon: sht3x: read out sensor serial number
Date:   Mon,  4 Dec 2023 17:50:04 +0100
Message-ID: <20231204165004.8491-3-code@stefan-gloor.ch>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204165004.8491-1-code@stefan-gloor.ch>
References: <20231204165004.8491-1-code@stefan-gloor.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Vs-State: 0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temperature/humidity sensors of the STS3x/SHT3x family are
calibrated and factory-programmed with a unique serial number.
For some sensors, this serial number can be used to obtain a calibration
certificate via an API provided by the manufacturer (Sensirion).
Expose the serial number via debugfs.

Tested with: 2x STS31, 1x STS32, 1x SHT31

Signed-off-by: Stefan Gloor <code@stefan-gloor.ch>
---
 Documentation/hwmon/sht3x.rst | 11 +++++++
 drivers/hwmon/sht3x.c         | 55 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 79657910b79e..537365c6213b 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -10,6 +10,7 @@
 
 #include <asm/page.h>
 #include <linux/crc8.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
@@ -41,6 +42,7 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
 /* other commands */
 static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
 static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
+static const unsigned char sht3x_cmd_read_serial_number[]      = { 0x37, 0x80 };
 
 /* delays for single-shot mode i2c commands, both in us */
 #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
@@ -163,12 +165,14 @@ struct sht3x_data {
 	enum sht3x_chips chip_id;
 	struct mutex i2c_lock; /* lock for sending i2c commands */
 	struct mutex data_lock; /* lock for updating driver data */
+	struct dentry *debugfs;
 
 	u8 mode;
 	const unsigned char *command;
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
 	enum sht3x_repeatability repeatability;
+	u32 serial_number;
 
 	/*
 	 * cached values for temperature and humidity and limits
@@ -831,6 +835,50 @@ static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+static void sht3x_debugfs_init(struct sht3x_data *data)
+{
+	char name[32];
+	struct dentry *sensor_dir;
+
+	data->debugfs = debugfs_lookup("sht3x", NULL);
+	if (IS_ERR_OR_NULL(data->debugfs))
+		data->debugfs = debugfs_create_dir("sht3x", NULL);
+
+	snprintf(name, sizeof(name), "i2c%u-%02x",
+		 data->client->adapter->nr, data->client->addr);
+	sensor_dir = debugfs_create_dir(name, data->debugfs);
+	debugfs_create_u32("serial_number", 0444,
+			   sensor_dir, &data->serial_number);
+}
+
+#else
+
+static void sht3x_debugfs_init(struct sht3x_data *data)
+{
+}
+
+#endif
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
@@ -899,6 +947,13 @@ static int sht3x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = sht3x_serial_number_read(data);
+	if (ret) {
+		dev_dbg(dev, "unable to read serial number\n");
+		data->serial_number = 0;
+	}
+	sht3x_debugfs_init(data);
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev,
 							 client->name,
 							 data,
-- 
2.41.0

