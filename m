Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C88277D076
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbjHOQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHOQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:56:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA2010DA;
        Tue, 15 Aug 2023 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692118569; x=1692723369; i=w_armin@gmx.de;
 bh=tZdXrSiMf+AoMDFfcB32Ulkj5pQw1BnUA0haj5JgN9E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DuFEogtJoHkodfkcHX64pLXnSnd73QMlXGwpOSm/FqMh6zuVgyNJg028oLzzPt/CSIIR3u3
 y0oNH9fonrirpSe/+u5zFI3/AtACF526Mbk7F96aJis85wa0ysvmgko0xZ7dbSk4xCTbg5WHI
 umre1IvGPcQaR+S0l5o5y4vyuADRhFEw2ph55zBlJR0B+YTGX6pSrEAzRX4RZZ/PyW9ESZEHs
 EiRHmTE4MpVf2pLAfZGSrMSkbZ1LTuZdCOi0wjTqJ3IfRvClc3knCEFspHyb0rxcTSeDJ/Kb4
 Lrx5h8IYYOMePzyJIHVunL9Ji8Z8vNRBUD1/ZW8Kc2L5iBf9h8ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M72oB-1qPdPq1QJb-008Z0w; Tue, 15 Aug 2023 18:56:09 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (sch5627) Add support for writing limit registers
Date:   Tue, 15 Aug 2023 18:55:58 +0200
Message-Id: <20230815165558.4176-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815165558.4176-1-W_Armin@gmx.de>
References: <20230815165558.4176-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s56ZeIKqatv5yibvc+Mb+QAOTGz5Ss2XMYA1k+5JCS/+CuQTHdn
 sJTLY2gaf9KvILuFMubCRImCX9yW2VzYmZvzeNEJlRPwX5Hs2qojWzsvCeSF/iTKrr8SOKe
 AgtendtyqVv4J+eM7WfJyH5aX98ho3BqIg2sbl/Qi7NFAUrkYhkaOe74lHD7MPfRQedW7zk
 emASfggfICxP/DoKrJCIA==
UI-OutboundReport: notjunk:1;M01:P0:MkR31oRwQoc=;DYg8crSgljYlU07Y6RF6xcqm3Ow
 fsVK0rLlIDOY3xHbo1ot7Qb5ToDgJE62JsXdVm2mrsTFsGyuYjphCAR6fikQJE19nzbvPlTTO
 pGf0/XHQUyfnAmDopEDRJfJwjYeeyWki49NFMgaxSy1Yrb3HvM7Cv8qrjkZQuyUx4XIM1ln+t
 X8ft9dB0cBNY7O66w1U+yDQtMzKB1ECDFLoF0ePO1vRlWFICkcpjST7xXa3yCwZW7KHmMLZNz
 xgLhTeRMdWZJBJ7kJpULz2T67yYS0f8QKaaKEwtJpkt3k83t6GuiHxriQwh/J57vZ6eyV72Ng
 kPcana6BXvivNKmGT67WkZVKqTYBBu020BQunGxu5fF2U/Fdf0a2qqZkfzY5vlI7Knz2kTsmY
 s71v6V/Pc9C6q5YNOTYc6I1AboAMGcxj8biCH5UwI1wfs2371xuFh4cgJnUzZ56pPchUXyI4R
 5EJS8t6u9gFr1/RSG5HfMgwAEbz7nVFTJHSc0SaWZB0nuOCYnKSa8h/2speuN0ZysJp9Y0sL/
 mG2U8rXAn63upTaaImRSvMb/o/se0XvjpZbkHr4TWzen+uje/ymqRai96lA3kAo9+7xJuY5yL
 /avFCpmWAxe6YrJLBMy4vZyys9DauHqitFyNiNeDvJtN5+8dbRHS5W5Ql4di7NnL4cqLZFYPV
 p40PkBNRY+66zEFRhIa2ARGesYEijhXrYDjYIF9m1+8kiilGDznnzU941Oivc6RgHU9Q7njXi
 dxlYdUV42PuhPrj2w61echUFm2axPw4aT9JF3N1S6We69puBcN9dwugnI10+pBbKByppoKOyK
 I+vzzKyILWPLTFF5nDZjohMoU8LDHBJukc8P87G0MrAEEOSEzcHp4687cpbHLE1cu8B+arCOo
 0J41Iq2GzOEEIhnN9xB+at5sE+hfsMfIOMzd5BGT2cCZ0ESTQaXuCXoABf58skLWaZaU0pa1e
 H/ShYtp8IhvH6I/kuryHfeK4YAU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some testing on a Fujitsu Esprimo P720, it turned out that
the limit registers are indeed writable and affect the fan control
algorithm. This is supported by the datasheet, which says that the
fan control functions are based on the limit and parameter registers.
Since accessing those registers is very inefficient, the regmap cache
is used to cache registers values.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/Kconfig          |   1 +
 drivers/hwmon/sch5627.c        | 246 ++++++++++++++++++++++++---------
 drivers/hwmon/sch56xx-common.c | 107 ++++++++++++++
 drivers/hwmon/sch56xx-common.h |   6 +
 4 files changed, 291 insertions(+), 69 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..1c672195b5b3 100644
=2D-- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1909,6 +1909,7 @@ config SENSORS_SMSC47B397

 config SENSORS_SCH56XX_COMMON
 	tristate
+	select REGMAP

 config SENSORS_SCH5627
 	tristate "SMSC SCH5627"
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index bf408e35e2c3..1891d4d75aa9 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -7,9 +7,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/bits.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
@@ -72,11 +75,9 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_=
IN] =3D {
 	"VCC", "VTT", "VBAT", "VTR", "V_IN" };

 struct sch5627_data {
+	struct regmap *regmap;
 	unsigned short addr;
 	u8 control;
-	u8 temp_max[SCH5627_NO_TEMPS];
-	u8 temp_crit[SCH5627_NO_TEMPS];
-	u16 fan_min[SCH5627_NO_FANS];

 	struct mutex update_lock;
 	unsigned long last_battery;	/* In jiffies */
@@ -91,6 +92,36 @@ struct sch5627_data {
 	u16 in[SCH5627_NO_IN];
 };

+static const struct regmap_range sch5627_tunables_ranges[] =3D {
+	regmap_reg_range(0x57, 0x57),
+	regmap_reg_range(0x59, 0x59),
+	regmap_reg_range(0x5B, 0x5B),
+	regmap_reg_range(0x5D, 0x5D),
+	regmap_reg_range(0x5F, 0x5F),
+	regmap_reg_range(0x61, 0x69),
+	regmap_reg_range(0x96, 0x9B),
+	regmap_reg_range(0xA0, 0xA3),
+	regmap_reg_range(0x184, 0x184),
+	regmap_reg_range(0x186, 0x186),
+	regmap_reg_range(0x1A8, 0x1A9),
+};
+
+static const struct regmap_access_table sch5627_tunables_table =3D {
+	.yes_ranges =3D sch5627_tunables_ranges,
+	.n_yes_ranges =3D ARRAY_SIZE(sch5627_tunables_ranges),
+};
+
+static const struct regmap_config sch5627_regmap_config =3D {
+	.reg_bits =3D 16,
+	.val_bits =3D 8,
+	.wr_table =3D &sch5627_tunables_table,
+	.rd_table =3D &sch5627_tunables_table,
+	.cache_type =3D REGCACHE_RBTREE,
+	.use_single_read =3D true,
+	.use_single_write =3D true,
+	.can_sleep =3D true,
+};
+
 static int sch5627_update_temp(struct sch5627_data *data)
 {
 	int ret =3D 0;
@@ -177,38 +208,6 @@ static int sch5627_update_in(struct sch5627_data *dat=
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
@@ -229,6 +228,25 @@ static int reg_to_rpm(u16 reg)
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
@@ -240,8 +258,35 @@ static umode_t sch5627_is_visible(const void *drvdata=
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
@@ -250,24 +295,37 @@ static int sch5627_read(struct device *dev, enum hwm=
on_sensor_types type, u32 at
 			long *val)
 {
 	struct sch5627_data *data =3D dev_get_drvdata(dev);
-	int ret;
+	int ret, value;

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
@@ -275,23 +333,35 @@ static int sch5627_read(struct device *dev, enum hwm=
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
@@ -301,15 +371,11 @@ static int sch5627_read(struct device *dev, enum hwm=
on_sensor_types type, u32 at
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_auto_channels_temp:
-			mutex_lock(&data->update_lock);
-			ret =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[chann=
el]);
-			mutex_unlock(&data->update_lock);
-
+			ret =3D regmap_read(data->regmap, SCH5627_REG_PWM_MAP[channel], &value=
);
 			if (ret < 0)
 				return ret;

-			*val =3D ret;
-
+			*val =3D value;
 			return 0;
 		default:
 			break;
@@ -359,9 +425,33 @@ static int sch5627_write(struct device *dev, enum hwm=
on_sensor_types type, u32 a
 			 long val)
 {
 	struct sch5627_data *data =3D dev_get_drvdata(dev);
-	int ret;
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
@@ -369,12 +459,7 @@ static int sch5627_write(struct device *dev, enum hwm=
on_sensor_types type, u32 a
 			if (val > U8_MAX || val < 0)
 				return -EINVAL;

-			mutex_lock(&data->update_lock);
-			ret =3D sch56xx_write_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[chan=
nel],
-							val);
-			mutex_unlock(&data->update_lock);
-
-			return ret;
+			return regmap_write(data->regmap, SCH5627_REG_PWM_MAP[channel], val);
 		default:
 			break;
 		}
@@ -436,7 +521,7 @@ static int sch5627_probe(struct platform_device *pdev)
 {
 	struct sch5627_data *data;
 	struct device *hwmon_dev;
-	int err, build_code, build_id, hwmon_rev, val;
+	int build_code, build_id, hwmon_rev, val;

 	data =3D devm_kzalloc(&pdev->dev, sizeof(struct sch5627_data),
 			    GFP_KERNEL);
@@ -501,19 +586,17 @@ static int sch5627_probe(struct platform_device *pde=
v)
 		pr_err("hardware monitoring not enabled\n");
 		return -ENODEV;
 	}
+
+	data->regmap =3D devm_regmap_init_sch56xx(&pdev->dev, &data->update_lock=
, data->addr,
+						&sch5627_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
 	/* Trigger a Vbat voltage measurement, so that we get a valid reading
 	   the first time we read Vbat */
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
@@ -531,6 +614,30 @@ static int sch5627_probe(struct platform_device *pdev=
)
 	return 0;
 }

+static int sch5627_suspend(struct device *dev)
+{
+	struct sch5627_data *data =3D dev_get_drvdata(dev);
+
+	regcache_cache_only(data->regmap, true);
+	regcache_mark_dirty(data->regmap);
+
+	return 0;
+}
+
+static int sch5627_resume(struct device *dev)
+{
+	struct sch5627_data *data =3D dev_get_drvdata(dev);
+
+	regcache_cache_only(data->regmap, false);
+	/* We must not access the virtual registers when the lock bit is set */
+	if (data->control & SCH5627_CTRL_LOCK)
+		return regcache_drop_region(data->regmap, 0, U16_MAX);
+
+	return regcache_sync(data->regmap);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sch5627_dev_pm_ops, sch5627_suspend, sch5=
627_resume);
+
 static const struct platform_device_id sch5627_device_id[] =3D {
 	{
 		.name =3D "sch5627",
@@ -542,6 +649,7 @@ MODULE_DEVICE_TABLE(platform, sch5627_device_id);
 static struct platform_driver sch5627_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
+		.pm	=3D pm_sleep_ptr(&sch5627_dev_pm_ops),
 	},
 	.probe		=3D sch5627_probe,
 	.id_table	=3D sch5627_device_id,
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index de3a0886c2f7..36b38626dcdf 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -64,6 +65,11 @@ struct sch56xx_watchdog_data {
 	u8 watchdog_output_enable;
 };

+struct sch56xx_bus_context {
+	struct mutex *lock;	/* Used to serialize access to the mailbox registers=
 */
+	u16 addr;
+};
+
 static struct platform_device *sch56xx_pdev;

 /* Super I/O functions */
@@ -243,6 +249,107 @@ int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg=
, u16 lsn_reg,
 }
 EXPORT_SYMBOL(sch56xx_read_virtual_reg12);

+/*
+ * Regmap support
+ */
+
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
+static int sch56xx_reg_write(void *context, unsigned int reg, unsigned in=
t val)
+{
+	struct sch56xx_bus_context *bus =3D context;
+	int ret;
+
+	mutex_lock(bus->lock);
+	ret =3D sch56xx_write_virtual_reg(bus->addr, (u16)reg, (u8)val);
+	mutex_unlock(bus->lock);
+
+	return ret;
+}
+
+static int sch56xx_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
+{
+	struct sch56xx_bus_context *bus =3D context;
+	int ret;
+
+	mutex_lock(bus->lock);
+	ret =3D sch56xx_read_virtual_reg(bus->addr, (u16)reg);
+	mutex_unlock(bus->lock);
+
+	if (ret < 0)
+		return ret;
+
+	*val =3D ret;
+
+	return 0;
+}
+
+static void sch56xx_free_context(void *context)
+{
+	kfree(context);
+}
+
+static const struct regmap_bus sch56xx_bus =3D {
+	.reg_write =3D sch56xx_reg_write,
+	.reg_read =3D sch56xx_reg_read,
+	.free_context =3D sch56xx_free_context,
+	.reg_format_endian_default =3D REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default =3D REGMAP_ENDIAN_LITTLE,
+};
+
+struct regmap *devm_regmap_init_sch56xx(struct device *dev, struct mutex =
*lock, u16 addr,
+					const struct regmap_config *config)
+{
+	struct sch56xx_bus_context *context;
+	struct regmap *map;
+
+	if (config->reg_bits !=3D 16 && config->val_bits !=3D 8)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	context =3D kzalloc(sizeof(*context), GFP_KERNEL);
+	if (!context)
+		return ERR_PTR(-ENOMEM);
+
+	context->lock =3D lock;
+	context->addr =3D addr;
+
+	map =3D devm_regmap_init(dev, &sch56xx_bus, context, config);
+	if (IS_ERR(map))
+		kfree(context);
+
+	return map;
+}
+EXPORT_SYMBOL(devm_regmap_init_sch56xx);
+
 /*
  * Watchdog routines
  */
diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common=
.h
index e907d9da0dd5..7479a549a026 100644
=2D-- a/drivers/hwmon/sch56xx-common.h
+++ b/drivers/hwmon/sch56xx-common.h
@@ -5,9 +5,15 @@
  ************************************************************************=
***/

 #include <linux/mutex.h>
+#include <linux/regmap.h>

 struct sch56xx_watchdog_data;

+struct regmap *devm_regmap_init_sch56xx(struct device *dev, struct mutex =
*lock, u16 addr,
+					const struct regmap_config *config);
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

