Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F175E683
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGXBUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjGXBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8A1E53;
        Sun, 23 Jul 2023 18:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403BB60F0C;
        Mon, 24 Jul 2023 01:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89045C433C8;
        Mon, 24 Jul 2023 01:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161519;
        bh=xM3V1BhhnC+IlUeJkZSthqS7smX1WbC4G+VGgkiSEYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDmtsdPYOow57m3aFfvUBATn5ynGlr6CEQcW54BdW7xj4gpp6dl3JiSqKHYTMz6Hw
         WiD5+5ovrCsrhwpjCPLjJfOCQQrifJYNghLkO4c/XoZ730Q7iL/JH8Gr0WbNRB6a2j
         ZUWQLRuEgQg8jBUK81FBYZYHmAdHt0UWwJSoiylbmm26J04+3dgZTxBnVigcndBsRC
         fFPzCjtAf0L2w3maVgNUqwIqtnsIE5LtDuACABOA52e+7IQesdHow/+2uSxRdxpRgJ
         oLZin4MTVhmY7AX035qzDr9IIrXUhtfdzAIBBvpklBrourN5vCp+rp3RUb0wCJXAZM
         slJ/AZ7rKzL4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, me@jackdoan.com,
        jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 33/58] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Leakshield
Date:   Sun, 23 Jul 2023 21:13:01 -0400
Message-Id: <20230724011338.2298062-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksa Savic <savicaleksa83@gmail.com>

[ Upstream commit b3d3be6c4cd1908b9ffdb3d347de232a6c34a0a9 ]

Extend aquacomputer_d5next driver to expose various hardware sensors of the
Aquacomputer Leakshield leak prevention system, which communicates
through a proprietary USB HID protocol. Implemented by Noah Bergbauer [1].

Two temperature sensors are exposed, along with pressure (current, min, max
and target), reservoir volume (total and filled), pump speed and flow. Pump
speed and flow values are user provided and allow the Leakshield to
optimize its operation. Writing them to the device is subject of future
patches.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/41

Originally-from: Noah Bergbauer <main@ehvag.de>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
Link: https://lore.kernel.org/r/20230520095447.509287-3-savicaleksa83@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hwmon/aquacomputer_d5next.rst |   9 ++
 drivers/hwmon/aquacomputer_d5next.c         | 109 +++++++++++++++++++-
 2 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 14b37851af0ca..94dc2d93d1808 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -12,6 +12,7 @@ Supported devices:
 * Aquacomputer Octo fan controller
 * Aquacomputer Quadro fan controller
 * Aquacomputer High Flow Next sensor
+* Aquacomputer Leakshield leak prevention system
 * Aquacomputer Aquastream XT watercooling pump
 * Aquacomputer Aquastream Ultimate watercooling pump
 * Aquacomputer Poweradjust 3 fan controller
@@ -57,6 +58,11 @@ The High Flow Next exposes +5V voltages, water quality, conductivity and flow re
 A temperature sensor can be connected to it, in which case it provides its reading
 and an estimation of the dissipated/absorbed power in the liquid cooling loop.
 
+The Leakshield exposes two temperature sensors and coolant pressure (current, min, max and
+target readings). It also exposes the estimated reservoir volume and how much of it is
+filled with coolant. Pump RPM and flow can be set to enhance on-device calculations,
+but this is not yet implemented here.
+
 The Aquastream XT pump exposes temperature readings for the coolant, external sensor
 and fan IC. It also exposes pump and fan speeds (in RPM), voltages, as well as pump
 current.
@@ -83,6 +89,9 @@ Sysfs entries
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
 temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
+fan1_min         Minimal fan speed (in RPM)
+fan1_max         Maximal fan speed (in RPM)
+fan1_target      Target fan speed (in RPM)
 fan5_pulses      Quadro flow sensor pulses
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a4fcd4ebf76c2..ecd0a8ea5bd78 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
- * Quadro, High Flow Next, Aquaero, Aquastream Ultimate)
+ * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values, except for devices that communicate through the
@@ -29,6 +29,7 @@
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
 #define USB_PRODUCT_ID_OCTO		0xf011
 #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
+#define USB_PRODUCT_ID_LEAKSHIELD	0xf014
 #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
 #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
 #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
@@ -36,7 +37,7 @@
 enum kinds {
 	d5next, farbwerk, farbwerk360, octo, quadro,
 	highflownext, aquaero, poweradjust3, aquastreamult,
-	aquastreamxt
+	aquastreamxt, leakshield
 };
 
 static const char *const aqc_device_names[] = {
@@ -46,6 +47,7 @@ static const char *const aqc_device_names[] = {
 	[octo] = "octo",
 	[quadro] = "quadro",
 	[highflownext] = "highflownext",
+	[leakshield] = "leakshield",
 	[aquastreamxt] = "aquastreamxt",
 	[aquaero] = "aquaero",
 	[aquastreamult] = "aquastreamultimate",
@@ -236,6 +238,21 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 #define HIGHFLOWNEXT_5V_VOLTAGE		97
 #define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
 
+/* Specs of the Leakshield */
+#define LEAKSHIELD_NUM_SENSORS		2
+
+/* Sensor report offsets for Leakshield */
+#define LEAKSHIELD_PRESSURE_ADJUSTED	285
+#define LEAKSHIELD_TEMPERATURE_1	265
+#define LEAKSHIELD_TEMPERATURE_2	287
+#define LEAKSHIELD_PRESSURE_MIN		291
+#define LEAKSHIELD_PRESSURE_TARGET	293
+#define LEAKSHIELD_PRESSURE_MAX		295
+#define LEAKSHIELD_PUMP_RPM_IN		101
+#define LEAKSHIELD_FLOW_IN		111
+#define LEAKSHIELD_RESERVOIR_VOLUME	313
+#define LEAKSHIELD_RESERVOIR_FILLED	311
+
 /* Specs of the Aquastream XT pump */
 #define AQUASTREAMXT_SERIAL_START		0x3a
 #define AQUASTREAMXT_FIRMWARE_VERSION		0x32
@@ -411,6 +428,20 @@ static const char *const label_highflownext_voltage[] = {
 	"+5V USB voltage"
 };
 
+/* Labels for Leakshield */
+static const char *const label_leakshield_temp_sensors[] = {
+	"Temperature 1",
+	"Temperature 2"
+};
+
+static const char *const label_leakshield_fan_speed[] = {
+	"Pressure [ubar]",
+	"User-Provided Pump Speed",
+	"User-Provided Flow [dL/h]",
+	"Reservoir Volume [ml]",
+	"Reservoir Filled [ml]",
+};
+
 /* Labels for Aquastream XT */
 static const char *const label_aquastreamxt_temp_sensors[] = {
 	"Fan IC temp",
@@ -529,7 +560,10 @@ struct aqc_data {
 
 	/* Sensor values */
 	s32 temp_input[20];	/* Max 4 physical and 16 virtual or 8 physical and 12 virtual */
-	u16 speed_input[8];
+	s32 speed_input[8];
+	u32 speed_input_min[1];
+	u32 speed_input_target[1];
+	u32 speed_input_max[1];
 	u32 power_input[8];
 	u16 voltage_input[8];
 	u16 current_input[8];
@@ -747,6 +781,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 				if (channel < 3)
 					return 0444;
 				break;
+			case leakshield:
+				/* Special case for Leakshield sensors */
+				if (channel < 5)
+					return 0444;
+				break;
 			case aquaero:
 			case quadro:
 				/* Special case to support flow sensors */
@@ -764,6 +803,13 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			if (priv->kind == quadro && channel == priv->num_fans)
 				return 0644;
 			break;
+		case hwmon_fan_min:
+		case hwmon_fan_max:
+		case hwmon_fan_target:
+			/* Special case for Leakshield pressure sensor */
+			if (priv->kind == leakshield && channel == 0)
+				return 0444;
+			break;
 		default:
 			break;
 		}
@@ -938,8 +984,20 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
+			if (priv->speed_input[channel] == -ENODATA)
+				return -ENODATA;
+
 			*val = priv->speed_input[channel];
 			break;
+		case hwmon_fan_min:
+			*val = priv->speed_input_min[channel];
+			break;
+		case hwmon_fan_max:
+			*val = priv->speed_input_max[channel];
+			break;
+		case hwmon_fan_target:
+			*val = priv->speed_input_target[channel];
+			break;
 		case hwmon_fan_pulses:
 			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
 					       val, AQC_BE16);
@@ -1151,7 +1209,8 @@ static const struct hwmon_channel_info * const aqc_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
+			   HWMON_F_TARGET,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
@@ -1314,6 +1373,28 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->speed_input[1] = get_unaligned_be16(data + HIGHFLOWNEXT_WATER_QUALITY);
 		priv->speed_input[2] = get_unaligned_be16(data + HIGHFLOWNEXT_CONDUCTIVITY);
 		break;
+	case leakshield:
+		priv->speed_input[0] =
+		    ((s16)get_unaligned_be16(data + LEAKSHIELD_PRESSURE_ADJUSTED)) * 100;
+		priv->speed_input_min[0] = get_unaligned_be16(data + LEAKSHIELD_PRESSURE_MIN) * 100;
+		priv->speed_input_target[0] =
+		    get_unaligned_be16(data + LEAKSHIELD_PRESSURE_TARGET) * 100;
+		priv->speed_input_max[0] = get_unaligned_be16(data + LEAKSHIELD_PRESSURE_MAX) * 100;
+
+		priv->speed_input[1] = get_unaligned_be16(data + LEAKSHIELD_PUMP_RPM_IN);
+		if (priv->speed_input[1] == AQC_SENSOR_NA)
+			priv->speed_input[1] = -ENODATA;
+
+		priv->speed_input[2] = get_unaligned_be16(data + LEAKSHIELD_FLOW_IN);
+		if (priv->speed_input[2] == AQC_SENSOR_NA)
+			priv->speed_input[2] = -ENODATA;
+
+		priv->speed_input[3] = get_unaligned_be16(data + LEAKSHIELD_RESERVOIR_VOLUME);
+		priv->speed_input[4] = get_unaligned_be16(data + LEAKSHIELD_RESERVOIR_FILLED);
+
+		/* Second temp sensor is not positioned after the first one, read it here */
+		priv->temp_input[1] = get_unaligned_be16(data + LEAKSHIELD_TEMPERATURE_2) * 10;
+		break;
 	default:
 		break;
 	}
@@ -1571,6 +1652,25 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_highflownext_power;
 		priv->voltage_label = label_highflownext_voltage;
 		break;
+	case USB_PRODUCT_ID_LEAKSHIELD:
+		/*
+		 * Choose the right Leakshield device, because
+		 * the other one acts as a keyboard
+		 */
+		if (hdev->type != 2) {
+			ret = -ENODEV;
+			goto fail_and_close;
+		}
+
+		priv->kind = leakshield;
+
+		priv->num_fans = 0;
+		priv->num_temp_sensors = LEAKSHIELD_NUM_SENSORS;
+		priv->temp_sensor_start_offset = LEAKSHIELD_TEMPERATURE_1;
+
+		priv->temp_label = label_leakshield_temp_sensors;
+		priv->speed_label = label_leakshield_fan_speed;
+		break;
 	case USB_PRODUCT_ID_AQUASTREAMXT:
 		priv->kind = aquastreamxt;
 
@@ -1707,6 +1807,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_LEAKSHIELD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
-- 
2.39.2

