Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757687F770D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbjKXO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjKXO7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:59:22 -0500
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 06:59:25 PST
Received: from mxout014.mail.hostpoint.ch (mxout014.mail.hostpoint.ch [IPv6:2a00:d70:0:e::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF622D72;
        Fri, 24 Nov 2023 06:59:25 -0800 (PST)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1r6Xd3-0007WZ-06;
        Fri, 24 Nov 2023 15:58:01 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad.localdomain)
        by asmtp014.mail.hostpoint.ch with esmtpa (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1r6Xd2-000C8u-1q;
        Fri, 24 Nov 2023 15:58:00 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
From:   Stefan Gloor <code@stefan-gloor.ch>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Gloor <code@stefan-gloor.ch>
Subject: [PATCH] hwmon: sht3x: read out sensor serial number
Date:   Fri, 24 Nov 2023 15:55:20 +0100
Message-ID: <20231124145519.11599-2-code@stefan-gloor.ch>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Vs-State: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the temperature/humidity sensors of the STS3x/SHT3x family are
calibrated and factory-programmed with a unique serial number. This serial
number can be used to obtain a calibration certificate via an API provided
by the manufacturer (Sensirion). The serial number is exposed as a
non-standard sysfs attribute.

This feature is only available for STS32, STS33 and SHT33. The capability
to read out the serial number is not documented for other sensors such as
the STS31, but it is implemented in the ones I tested. To be safe, the
driver will silently set the serial number to zero if it can not be read.

Tested with:
1x STS32: serial number present
2x STS31: serial number present (feature not documented)
1x SHT31: serial number present (feature not documented)

Signed-off-by: Stefan Gloor <code@stefan-gloor.ch>
---
 Documentation/hwmon/sht3x.rst |  2 ++
 drivers/hwmon/sht3x.c         | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 87864ffd1777..1727994f4a4a 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -85,4 +85,6 @@ repeatability:      write or read repeatability, higher repeatability means
                         - 0: low repeatability
                         - 1: medium repeatability
                         - 2: high repeatability
+serial_number:      unique serial number of the sensor in decimal, 0 if
+                    unavailable
 =================== ============================================================
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 79657910b79e..e4d436af1097 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -41,6 +41,7 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
 /* other commands */
 static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
 static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
+static const unsigned char sht3x_cmd_read_serial_number[]      = { 0x37, 0x80 };
 
 /* delays for single-shot mode i2c commands, both in us */
 #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
@@ -169,6 +170,7 @@ struct sht3x_data {
 	u32 wait_time;			/* in us*/
 	unsigned long last_update;	/* last update in periodic mode*/
 	enum sht3x_repeatability repeatability;
+	u32 serial_number;
 
 	/*
 	 * cached values for temperature and humidity and limits
@@ -606,6 +608,33 @@ static int update_interval_write(struct device *dev, int val)
 	return 0;
 }
 
+static int serial_number_read(struct sht3x_data *data)
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
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sht3x_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->serial_number);
+}
+
 static ssize_t repeatability_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -639,10 +668,12 @@ static ssize_t repeatability_store(struct device *dev,
 
 static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
 static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
+static SENSOR_DEVICE_ATTR_RO(serial_number, serial_number, 0);
 
 static struct attribute *sht3x_attrs[] = {
 	&sensor_dev_attr_heater_enable.dev_attr.attr,
 	&sensor_dev_attr_repeatability.dev_attr.attr,
+	&sensor_dev_attr_serial_number.dev_attr.attr,
 	NULL
 };
 
@@ -899,6 +930,14 @@ static int sht3x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	/*
+	 * Serial number readout is not documented for the whole
+	 * STS3x/SHT3x series, so we don't return on error here.
+	 */
+	ret = serial_number_read(data);
+	if (ret)
+		data->serial_number = 0;
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev,
 							 client->name,
 							 data,
-- 
2.41.0

