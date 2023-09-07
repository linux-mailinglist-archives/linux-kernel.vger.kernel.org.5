Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5954797014
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbjIGF1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjIGF1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:27:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC119A5;
        Wed,  6 Sep 2023 22:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694064408; x=1694669208; i=w_armin@gmx.de;
 bh=HBQIPXlFsmWvlVKIzZw0COze2AuYo9xUc/mY/PUIOA8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gBoITLXD/DgIqUg5gmxdvEfsZ89puU0UgRg0eFkKZbiEU4bRgUhWAhZpRz4/flbbx6b1vd6
 D1kO+8DF9xRUTBvMirEmZl4HgmMx1OMaN2UrJIUdRZ3lTWgOUssRlzt7DW/8b33GK1CH0VyFd
 a3iy39M6cTfODdQI4LVuVZZOReldBljCrcsIV2nBwqN1suz8KyucwRoK65a+UFff703Gy26gd
 z23Fk0lfJHzJMw2LT2SDXuvSN5Vs28tZwenhVvO82GDUxT8/f0mRImNsBR+hbJgGNcoxzVhey
 C/LWo0LSXa6hmZhOcWKezLrStLaorCKOyK9WpPE10XcoK1ScbRMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mg6Zw-1q04xC2lnK-00hi4d; Thu, 07 Sep 2023 07:26:48 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] hwmon: (sch5627) Use regmap for pwm map register caching
Date:   Thu,  7 Sep 2023 07:26:37 +0200
Message-Id: <20230907052639.16491-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907052639.16491-1-W_Armin@gmx.de>
References: <20230907052639.16491-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H5lbivJ4Y/njBPLw1JtYYcaz8XiywCbrQK5WqQfcjplBWBAUQji
 DLIE2ugi65c3BmzCsGCZxQIFQoBX+Ur3623qLiRorKevMekB+cwziq6XblVvYPABiBIR9Nf
 omM8UetVfYdKG73k2evQXqvNc/FUUh0M1wvHfJC9A/zdB5Nm+vySdOuHYpPFLcAC0A7ND2m
 z1cOlOxPyI6UXNyxFCYQg==
UI-OutboundReport: notjunk:1;M01:P0:H7S92kz38Rk=;KexKrBP0gxdY2awkSiOe1OGqTX7
 g4h2ebJnwCuBmCW69HJYr+i+38Sr4DftA5R9eVHr55XHmHizh4j85T9vy9sEuaCKHvzt1ygYI
 KDcIYRgWMc1XVrY+MD6Wlk9W33d1rvxA+N4jtud2gMnZXPLHHM38Qo5dq4DISEdjY/6Ch5sD9
 ADaBjbHKB3wIzNlK9SdaHnW1kBPEcJV/H2UYeak1LnC3q29JJSmQ+1+bIuMzaAJFPbvqn/dEp
 pXyAOHO2DjiwWx0ZCvADjV5YrjJ+y2sTLRgMT8SHGYn94wDDtWVu4BnwbbJfgelXME4Cka3Vn
 uyXcU+RL01qDNB+DjLoaoVuQ/risIQ8wKf3VYO7UZgp7Frkdv6zMgH888giagZ6l9X4aUNWZc
 vnKL8XGwh6iNAMXFi2mFVHFWZxw4KL8A/82vUpOMKq+ZWAJdiqCMTJJUQSPGC+dG+eZog05Iw
 evKnGVBKvIiouU/hzz5ph5xXj2nD9776prW/zUD31eVlT5fzuxXPfwcydv1Mhi8MI1t7URYpW
 mqp1v8G327k7IViLVGTEtwEh6UP8zOK0kwRFOHTbQZIi4P2n/6Dpp6kOozWT17H50VMNhpNFp
 kzHNEuJlGJ/Oecy61F02ab3WPYCVzMWo1DEormIqX7QHrLcdPKhPXRIO2+h1KC6+U4M4CLhR7
 Rf4qJ6qYn8pSdv2bHKKK+RB8uhVzViD6UA2MRXsierCXsM+RfrciGAFWK04Q/xhZycH+K5heH
 U4LJ2BgYgBFpL4cyR48TLY3VGBISz9YPdLTYujQrM6Ui2iw8moMd6KScnkva71vhVdHowrkJ2
 65mp4DLHVByE6nFkhq6ml6kfhHYLcCwntV+naEUrYwwMWsIk4/W+4wLrJqvWcSWgdrB3id908
 6h/AqrBZO4gOJNkSUEuXFSKYjWJC7o1kZqBSWLaET2ZjVr/kbAAB7JxjGZ3u/Hxy4FDyYO6F8
 nApavVYp7UlHDrNKrC2kXg/Gqvk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing virtual registers is very inefficient, so pwm map values
should be cached when possible, else userspace could effectively do
a DOS attack by reading pwm map values in a while loop.
Use the regmap cache to cache those values.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/Kconfig          |  1 +
 drivers/hwmon/sch5627.c        | 72 +++++++++++++++++++++++++-------
 drivers/hwmon/sch56xx-common.c | 76 ++++++++++++++++++++++++++++++++++
 drivers/hwmon/sch56xx-common.h |  3 ++
 4 files changed, 138 insertions(+), 14 deletions(-)

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
index bf408e35e2c3..85f8352cb3cf 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -9,7 +9,9 @@
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
@@ -72,6 +74,7 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_I=
N] =3D {
 	"VCC", "VTT", "VBAT", "VTR", "V_IN" };

 struct sch5627_data {
+	struct regmap *regmap;
 	unsigned short addr;
 	u8 control;
 	u8 temp_max[SCH5627_NO_TEMPS];
@@ -91,6 +94,26 @@ struct sch5627_data {
 	u16 in[SCH5627_NO_IN];
 };

+static const struct regmap_range sch5627_tunables_ranges[] =3D {
+	regmap_reg_range(0xA0, 0xA3),
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
@@ -250,7 +273,7 @@ static int sch5627_read(struct device *dev, enum hwmon=
_sensor_types type, u32 at
 			long *val)
 {
 	struct sch5627_data *data =3D dev_get_drvdata(dev);
-	int ret;
+	int ret, value;

 	switch (type) {
 	case hwmon_temp:
@@ -301,15 +324,11 @@ static int sch5627_read(struct device *dev, enum hwm=
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
@@ -359,7 +378,6 @@ static int sch5627_write(struct device *dev, enum hwmo=
n_sensor_types type, u32 a
 			 long val)
 {
 	struct sch5627_data *data =3D dev_get_drvdata(dev);
-	int ret;

 	switch (type) {
 	case hwmon_pwm:
@@ -369,12 +387,7 @@ static int sch5627_write(struct device *dev, enum hwm=
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
@@ -501,6 +514,12 @@ static int sch5627_probe(struct platform_device *pdev=
)
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
@@ -531,6 +550,30 @@ static int sch5627_probe(struct platform_device *pdev=
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
@@ -542,6 +585,7 @@ MODULE_DEVICE_TABLE(platform, sch5627_device_id);
 static struct platform_driver sch5627_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
+		.pm	=3D pm_sleep_ptr(&sch5627_dev_pm_ops),
 	},
 	.probe		=3D sch5627_probe,
 	.id_table	=3D sch5627_device_id,
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index de3a0886c2f7..a3abafdaa3e6 100644
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
@@ -243,6 +249,76 @@ int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg,=
 u16 lsn_reg,
 }
 EXPORT_SYMBOL(sch56xx_read_virtual_reg12);

+/*
+ * Regmap support
+ */
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
index e907d9da0dd5..3fb1cddbf977 100644
=2D-- a/drivers/hwmon/sch56xx-common.h
+++ b/drivers/hwmon/sch56xx-common.h
@@ -5,9 +5,12 @@
  ************************************************************************=
***/

 #include <linux/mutex.h>
+#include <linux/regmap.h>

 struct sch56xx_watchdog_data;

+struct regmap *devm_regmap_init_sch56xx(struct device *dev, struct mutex =
*lock, u16 addr,
+					const struct regmap_config *config);
 int sch56xx_read_virtual_reg(u16 addr, u16 reg);
 int sch56xx_write_virtual_reg(u16 addr, u16 reg, u8 val);
 int sch56xx_read_virtual_reg16(u16 addr, u16 reg);
=2D-
2.39.2

