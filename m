Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B911797018
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjIGF1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjIGF1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:27:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310CE19BD;
        Wed,  6 Sep 2023 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694064410; x=1694669210; i=w_armin@gmx.de;
 bh=Bd7Jv8IQ6Bj8YdBWcXJYUXfXEz4MZnDbXV7P6IqE1GM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iV5Mz/Xj25IUk2xdr9DOKlGqT3qQXyCL7AUhUeSrGsySfuR4BjcJ2cg2w8FsiV3xsxWFSrN
 SihuPukRgFdgDFnNEdH+LFQwJM1dTIuo0t3wx8HcXhh2hQzazQqh8U/BhwwmcTmS5IZZkukuT
 RFJNItOY+ZPTGnTPuWgwPMg5YEwzhgWFi/O4PctIBIKqiGAlb1MmvrAofbDnErcrpUDWVo6us
 x/T6P8RLFqVMdgEK9oFPhxNzGp+nx4YVSd742oL6/JJ7TwNvdOEmBOyrx4+kJruFDp+fZEFaS
 mb/5SSQK3QQOLCzeMEkee+z5IKnFogElYFR3ENMOS7uK9S11u5Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MlNp7-1puuIh2f4X-00lo5Q; Thu, 07 Sep 2023 07:26:50 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] hwmon: (sch5627) Add support for writing limit registers
Date:   Thu,  7 Sep 2023 07:26:38 +0200
Message-Id: <20230907052639.16491-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907052639.16491-1-W_Armin@gmx.de>
References: <20230907052639.16491-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bO/fm+gtn/wHOYl6rtDRSHs30LhPVSrgZkWjTXnmv8tu/7FujYz
 6rNsicYDQdr+AHoIksAMAAZZak5QAOGv+gKY1uoifIVx/xzH73cFckxOtnXRnJehbXlCzUG
 CHvifCOFHuzrtbmP1v7lkGoC/uD6DOPQHn8LIMeUdSfyTZU/SRo5t053dzthn+IbWaZYQY5
 OTDJb9j0Liew2lYc16lmg==
UI-OutboundReport: notjunk:1;M01:P0:tqSn9Z+iWdo=;BMUPFO7s16sflGbvmlsyfbvo8kz
 /PAsNlVutt27IXznm85h12+R5j6VWrFNCnDHqKwqnrLJWMqRnCH/p5KzrgXXepSxZNLR/rz5z
 bKWLNn9ZjAOPssAQqu5noL9GsAuG/NtCBBIy5wyT9uhZca//DKTE9/D2GNWJ30n38BkcrXMxP
 GdHTlZcyVzTsJ7rpYEeMwuTGyHNTBj9N6DTUtoTybQAO+zeW0pPY7af74bhlTl7rJoJ2UTKCM
 DRYHBxdMUbth7FOSOOHnx/bnpBsu6Z0x/x26OXXmS7kfg3e9EaIlsuKZXKpUDyO98GA6Yabwe
 11DkaoPo8o5TrVqZsxOJYSxlCqKJnlWvTwJHT/NdNX+zLAw7fpEfAiowq+c3NS5m7QvG56gaW
 8gviMIHw40+RqjEKIfgftG+Z/HgarFQd3DScXFmGQDGBY48ikpCHySE2T2FSWG2bTDVDiiwhu
 kDhTH6Kx4pbAWLWMmNC415w4XQp6BvAojmP3GIYiJ6huq8IXdAjilOtz3lTasbLjx99IdYtrk
 Ia24MjBB3r2kzyZU14cvuwKlPJA/zVYFTI3WQOfNTZjPJUy8GCh93/Foprr1RffUGcMXMjyrT
 yeE8vmcv4O58G8EbVQVBbqOeZdncoUZW9JKgI4fJW2w/tCtD+htRpcfxN8YohgjZbzfgbICco
 IqpJk2GG4yLezFUHspr0vgOvmHv5DhqRZ2qCtagTu70U0lXq9brGN1J3qc9NqyalUYfhXCD+/
 30C5As5pR3ZvsQI08Lf3D5Thyfh9HnrmelbJtNptqUHhMQpJSSONYfuCZVx2XyHqYdg16bKLS
 bwfdGJyomIk2obCGrUCLCMq5aBXypKzR9sVBgLIRlR49LfeX4jK6k3mZhPDa4TgRcr5ajH9UP
 UNiKOJ924JwqsqiWm78mv/s7Uw12yQgfGAx7T4dJ4HYm7Rg5P6PEZrq/MsieOG+XAz+xthTZB
 CiR0IfclX9cygNvkI6znEipDfqw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some testing on a Fujitsu Esprimo P720, it turned out that
the limit registers are indeed writable and affect the fan control
algorithm. This is supported by the datasheet, which says that the
fan control functions are based on the limit and parameter registers.
Since accessing those registers is very inefficient, the existing
regmap cache is used to cache those registers values.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch5627.c        | 174 ++++++++++++++++++++++-----------
 drivers/hwmon/sch56xx-common.c |  31 ++++++
 drivers/hwmon/sch56xx-common.h |   3 +
 3 files changed, 153 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 85f8352cb3cf..1891d4d75aa9 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/bits.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm.h>
@@ -77,9 +78,6 @@ struct sch5627_data {
 	struct regmap *regmap;
 	unsigned short addr;
 	u8 control;
-	u8 temp_max[SCH5627_NO_TEMPS];
-	u8 temp_crit[SCH5627_NO_TEMPS];
-	u16 fan_min[SCH5627_NO_FANS];

 	struct mutex update_lock;
 	unsigned long last_battery;	/* In jiffies */
@@ -95,7 +93,17 @@ struct sch5627_data {
 };

 static const struct regmap_range sch5627_tunables_ranges[] =3D {
+	regmap_reg_range(0x57, 0x57),
+	regmap_reg_range(0x59, 0x59),
+	regmap_reg_range(0x5B, 0x5B),
+	regmap_reg_range(0x5D, 0x5D),
+	regmap_reg_range(0x5F, 0x5F),
+	regmap_reg_range(0x61, 0x69),
+	regmap_reg_range(0x96, 0x9B),
 	regmap_reg_range(0xA0, 0xA3),
+	regmap_reg_range(0x184, 0x184),
+	regmap_reg_range(0x186, 0x186),
+	regmap_reg_range(0x1A8, 0x1A9),
 };

 static const struct regmap_access_table sch5627_tunables_table =3D {
@@ -200,38 +208,6 @@ static int sch5627_update_in(struct sch5627_data *dat=
a)
 	return ret;
 }

-static int sch5627_read_limits(struct sch5627_data *data)
-{
-	int i, val;
-
-	for (i =3D 0; i < SCH5627_NO_TEMPS; i++) {
-		/*
-		 * Note what SMSC calls ABS, is what lm_sensors calls max
-		 * (aka high), and HIGH is what lm_sensors calls crit.
-		 */
-		val =3D sch56xx_read_virtual_reg(data->addr,
-					       SCH5627_REG_TEMP_ABS[i]);
-		if (val < 0)
-			return val;
-		data->temp_max[i] =3D val;
-
-		val =3D sch56xx_read_virtual_reg(data->addr,
-					       SCH5627_REG_TEMP_HIGH[i]);
-		if (val < 0)
-			return val;
-		data->temp_crit[i] =3D val;
-	}
-	for (i =3D 0; i < SCH5627_NO_FANS; i++) {
-		val =3D sch56xx_read_virtual_reg16(data->addr,
-						 SCH5627_REG_FAN_MIN[i]);
-		if (val < 0)
-			return val;
-		data->fan_min[i] =3D val;
-	}
-
-	return 0;
-}
-
 static int reg_to_temp(u16 reg)
 {
 	return (reg * 625) / 10 - 64000;
@@ -252,6 +228,25 @@ static int reg_to_rpm(u16 reg)
 	return 5400540 / reg;
 }

+static u8 sch5627_temp_limit_to_reg(long value)
+{
+	long limit =3D (value / 1000) + 64;
+
+	return clamp_val(limit, 0, U8_MAX);
+}
+
+static u16 sch5627_rpm_to_reg(long value)
+{
+	long pulses;
+
+	if (value <=3D 0)
+		return U16_MAX - 1;
+
+	pulses =3D 5400540 / value;
+
+	return clamp_val(pulses, 1, U16_MAX - 1);
+}
+
 static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_=
types type, u32 attr,
 				  int channel)
 {
@@ -263,8 +258,35 @@ static umode_t sch5627_is_visible(const void *drvdata=
, enum hwmon_sensor_types t
 	if (data->control & SCH5627_CTRL_LOCK)
 		return 0444;

-	if (type =3D=3D hwmon_pwm && attr =3D=3D hwmon_pwm_auto_channels_temp)
-		return 0644;
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_max:
+		case hwmon_temp_crit:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_min:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}

 	return 0444;
 }
@@ -277,20 +299,33 @@ static int sch5627_read(struct device *dev, enum hwm=
on_sensor_types type, u32 at

 	switch (type) {
 	case hwmon_temp:
-		ret =3D sch5627_update_temp(data);
-		if (ret < 0)
-			return ret;
 		switch (attr) {
 		case hwmon_temp_input:
+			ret =3D sch5627_update_temp(data);
+			if (ret < 0)
+				return ret;
+
 			*val =3D reg_to_temp(data->temp[channel]);
 			return 0;
 		case hwmon_temp_max:
-			*val =3D reg_to_temp_limit(data->temp_max[channel]);
+			ret =3D regmap_read(data->regmap, SCH5627_REG_TEMP_ABS[channel], &valu=
e);
+			if (ret < 0)
+				return ret;
+
+			*val =3D reg_to_temp_limit((u8)value);
 			return 0;
 		case hwmon_temp_crit:
-			*val =3D reg_to_temp_limit(data->temp_crit[channel]);
+			ret =3D regmap_read(data->regmap, SCH5627_REG_TEMP_HIGH[channel], &val=
ue);
+			if (ret < 0)
+				return ret;
+
+			*val =3D reg_to_temp_limit((u8)value);
 			return 0;
 		case hwmon_temp_fault:
+			ret =3D sch5627_update_temp(data);
+			if (ret < 0)
+				return ret;
+
 			*val =3D (data->temp[channel] =3D=3D 0);
 			return 0;
 		default:
@@ -298,23 +333,35 @@ static int sch5627_read(struct device *dev, enum hwm=
on_sensor_types type, u32 at
 		}
 		break;
 	case hwmon_fan:
-		ret =3D sch5627_update_fan(data);
-		if (ret < 0)
-			return ret;
 		switch (attr) {
 		case hwmon_fan_input:
+			ret =3D sch5627_update_fan(data);
+			if (ret < 0)
+				return ret;
+
 			ret =3D reg_to_rpm(data->fan[channel]);
 			if (ret < 0)
 				return ret;
+
 			*val =3D ret;
 			return 0;
 		case hwmon_fan_min:
-			ret =3D reg_to_rpm(data->fan_min[channel]);
+			ret =3D sch56xx_regmap_read16(data->regmap, SCH5627_REG_FAN_MIN[channe=
l],
+						    &value);
 			if (ret < 0)
 				return ret;
+
+			ret =3D reg_to_rpm((u16)value);
+			if (ret < 0)
+				return ret;
+
 			*val =3D ret;
 			return 0;
 		case hwmon_fan_fault:
+			ret =3D sch5627_update_fan(data);
+			if (ret < 0)
+				return ret;
+
 			*val =3D (data->fan[channel] =3D=3D 0xffff);
 			return 0;
 		default:
@@ -378,8 +425,33 @@ static int sch5627_write(struct device *dev, enum hwm=
on_sensor_types type, u32 a
 			 long val)
 {
 	struct sch5627_data *data =3D dev_get_drvdata(dev);
+	u16 fan;
+	u8 temp;

 	switch (type) {
+	case hwmon_temp:
+		temp =3D sch5627_temp_limit_to_reg(val);
+
+		switch (attr) {
+		case hwmon_temp_max:
+			return regmap_write(data->regmap, SCH5627_REG_TEMP_ABS[channel], temp)=
;
+		case hwmon_temp_crit:
+			return regmap_write(data->regmap, SCH5627_REG_TEMP_HIGH[channel], temp=
);
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_min:
+			fan =3D sch5627_rpm_to_reg(val);
+
+			return sch56xx_regmap_write16(data->regmap, SCH5627_REG_FAN_MIN[channe=
l],
+						      fan);
+		default:
+			break;
+		}
+		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_auto_channels_temp:
@@ -449,7 +521,7 @@ static int sch5627_probe(struct platform_device *pdev)
 {
 	struct sch5627_data *data;
 	struct device *hwmon_dev;
-	int err, build_code, build_id, hwmon_rev, val;
+	int build_code, build_id, hwmon_rev, val;

 	data =3D devm_kzalloc(&pdev->dev, sizeof(struct sch5627_data),
 			    GFP_KERNEL);
@@ -525,14 +597,6 @@ static int sch5627_probe(struct platform_device *pdev=
)
 	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control | =
SCH5627_CTRL_VBAT);
 	data->last_battery =3D jiffies;

-	/*
-	 * Read limits, we do this only once as reading a register on
-	 * the sch5627 is quite expensive (and they don't change).
-	 */
-	err =3D sch5627_read_limits(data);
-	if (err)
-		return err;
-
 	pr_info("found %s chip at %#hx\n", DEVNAME, data->addr);
 	pr_info("firmware build: code 0x%02X, id 0x%04X, hwmon: rev 0x%02X\n",
 		build_code, build_id, hwmon_rev);
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index a3abafdaa3e6..36b38626dcdf 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -253,6 +253,37 @@ EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
  * Regmap support
  */

+int sch56xx_regmap_read16(struct regmap *map, unsigned int reg, unsigned =
int *val)
+{
+	int lsb, msb, ret;
+
+	/* See sch56xx_read_virtual_reg16() */
+	ret =3D regmap_read(map, reg, &lsb);
+	if (ret < 0)
+		return ret;
+
+	ret =3D regmap_read(map, reg + 1, &msb);
+	if (ret < 0)
+		return ret;
+
+	*val =3D lsb | (msb << 8);
+
+	return 0;
+}
+EXPORT_SYMBOL(sch56xx_regmap_read16);
+
+int sch56xx_regmap_write16(struct regmap *map, unsigned int reg, unsigned=
 int val)
+{
+	int ret;
+
+	ret =3D regmap_write(map, reg, val & 0xff);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(map, reg + 1, (val >> 8) & 0xff);
+}
+EXPORT_SYMBOL(sch56xx_regmap_write16);
+
 static int sch56xx_reg_write(void *context, unsigned int reg, unsigned in=
t val)
 {
 	struct sch56xx_bus_context *bus =3D context;
diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common=
.h
index 3fb1cddbf977..7479a549a026 100644
=2D-- a/drivers/hwmon/sch56xx-common.h
+++ b/drivers/hwmon/sch56xx-common.h
@@ -11,6 +11,9 @@ struct sch56xx_watchdog_data;

 struct regmap *devm_regmap_init_sch56xx(struct device *dev, struct mutex =
*lock, u16 addr,
 					const struct regmap_config *config);
+int sch56xx_regmap_read16(struct regmap *map, unsigned int reg, unsigned =
int *val);
+int sch56xx_regmap_write16(struct regmap *map, unsigned int reg, unsigned=
 int val);
+
 int sch56xx_read_virtual_reg(u16 addr, u16 reg);
 int sch56xx_write_virtual_reg(u16 addr, u16 reg, u8 val);
 int sch56xx_read_virtual_reg16(u16 addr, u16 reg);
=2D-
2.39.2

