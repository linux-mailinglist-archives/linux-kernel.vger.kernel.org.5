Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CAD802B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjLDF5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjLDF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:57:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A413E5;
        Sun,  3 Dec 2023 21:57:52 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce5f4b3eefso31434b3a.3;
        Sun, 03 Dec 2023 21:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701669472; x=1702274272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71l5ptp0B0Gs2wogftvPekh9Etuxw58JkgQO28x/sRA=;
        b=CGAnEIkoqyPXNDxjwtzxbASVl9siVr8voGAyKUqLrAjzPyhgQkFLrAMo9lD3otXLAd
         MyPq4pxnb2sQ6rlmRgp5HzQyl7q4VnBetpLxwivdv3odVCfU5Ow4FSSSts4lgWX76TWG
         ZH5ls6+28Db36kkCxclOdaYU1wt8TiQ5m/vO5MGLCmrssB10NbePtX5XWp6E0O6cMczP
         o+uaPsTyv0JeUvbqIIt3pD+XExMGcMyRwoen1v/q/CRxfE6dLAsXxV46sWZGYbeA/3nf
         F1crTqwHuq4eFU4TRhbfGzjfxsTPazPnxarRLyQX0Upymo95zc6AeT7HNxWzH5o0VvV4
         ZnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669472; x=1702274272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71l5ptp0B0Gs2wogftvPekh9Etuxw58JkgQO28x/sRA=;
        b=Ci5f5OTX2kE+k4w+/eT11+pCzvZH1unAL1Jd2fdTHYgRe11Cd2Bst7WPSb+yt16r9g
         VpOTuJ+10FHWy5us9JP2lMwMBNZC/20ude9M/sk4BqdcVWLgbDRR/rWN+yf7H2cuJ6Ep
         kV5/TAwOHyaC2Jc28jW5f9WMridcCF1wPfv7RJPWW/nWh9ZWwrhQZVSHt0AbtCYLYXeE
         pI/VurST+mwspdmagL5aDS8QEgLs2yl2j2Ps0/CbQbfFj04ln9sThwEnVq/n8qdsqnCS
         ZAUiwxzvV0BmGjahz2JRCGuUhXal0P85R9oKtahVhq6U6twT/u5rWTHLrWE9nNQPb5I5
         Um4A==
X-Gm-Message-State: AOJu0YztkLKc9R1Od/0deqsNwh6jJJJJRIMG6MUN+ihdU8IIn7LsvtE9
        lJCsiJYZgT6bVJ9ky8Mah44=
X-Google-Smtp-Source: AGHT+IHLL+rxwbIaI9882+mFkKDJ92RDTSCmBy2tc0zza3hBH4+Rx+E3cSoeITYBujabMfzpA7SP1g==
X-Received: by 2002:a05:6a20:7490:b0:18f:97c:5b82 with SMTP id p16-20020a056a20749000b0018f097c5b82mr811026pzd.80.1701669471886;
        Sun, 03 Dec 2023 21:57:51 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 95-20020a17090a09e800b0028651ea5e7csm6113523pjo.33.2023.12.03.21.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:57:51 -0800 (PST)
From:   baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
        DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
Subject: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
Date:   Mon,  4 Dec 2023 13:56:50 +0800
Message-Id: <20231204055650.788388-3-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204055650.788388-1-kcfeng0@nuvoton.com>
References: <20231204055650.788388-1-kcfeng0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ban Feng <kcfeng0@nuvoton.com>

NCT736X is an I2C based hardware monitoring chip from Nuvoton.

Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/nct736x.rst |  35 +++
 MAINTAINERS                     |   2 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/nct736x.c         | 479 ++++++++++++++++++++++++++++++++
 6 files changed, 528 insertions(+)
 create mode 100644 Documentation/hwmon/nct736x.rst
 create mode 100644 drivers/hwmon/nct736x.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 72f4e6065bae..98eb0efeb121 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -161,6 +161,7 @@ Hardware Monitoring Kernel Drivers
    mp5023
    nct6683
    nct6775
+   nct736x
    nct7802
    nct7904
    npcm750-pwm-fan
diff --git a/Documentation/hwmon/nct736x.rst b/Documentation/hwmon/nct736x.rst
new file mode 100644
index 000000000000..b7d64087263a
--- /dev/null
+++ b/Documentation/hwmon/nct736x.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver nct736x
+=====================
+
+Supported chip:
+
+  * Nuvoton NCT7362Y NCT7363Y
+
+    Prefix: nct736x
+
+    Addresses: I2C 0x20, 0x21, 0x22, 0x23
+
+Author: Ban Feng <kcfeng0@nuvoton.com>
+
+
+Description
+-----------
+
+The NCT736X is a Fan controller which provides up to 16 independent
+FAN input monitors, and up to 16 independent PWM output with SMBus interface.
+Besides, NCT7363Y has a built-in watchdog timer which is used for
+conditionally generating a system reset output (INT#).
+
+
+Sysfs entries
+-------------
+
+Currently, the driver supports the following features:
+
+======================= =======================================================
+fanX_input		provide current fan rotation value in RPM
+
+pwmX			get or set PWM fan control value.
+======================= =======================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index eef44c13278c..fed10a0bc49c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,6 +14905,8 @@ M:	Ban Feng <kcfeng0@nuvoton.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
+F:	Documentation/hwmon/nct736x.rst
+F:	drivers/hwmon/nct736x.c
 
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index cf27523eed5a..b2ca07e6c03a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1605,6 +1605,16 @@ config SENSORS_NCT6775_I2C
 	  This driver can also be built as a module. If so, the module
 	  will be called nct6775-i2c.
 
+config SENSORS_NCT736X
+	tristate "Nuvoton NCT736X"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Nuvoton NCT7362Y,
+	  NCT7363Y hardware monitoring chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct736x.
+
 config SENSORS_NCT7802
 	tristate "Nuvoton NCT7802Y"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e84bd9685b5c..13f378452a4b 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -166,6 +166,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) += nct6775-core.o
 nct6775-objs			:= nct6775-platform.o
 obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
 obj-$(CONFIG_SENSORS_NCT6775_I2C) += nct6775-i2c.o
+obj-$(CONFIG_SENSORS_NCT736X)	+= nct736x.o
 obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
 obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
 obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
diff --git a/drivers/hwmon/nct736x.c b/drivers/hwmon/nct736x.c
new file mode 100644
index 000000000000..4c59e823062d
--- /dev/null
+++ b/drivers/hwmon/nct736x.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Nuvoton Technology corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#define NCT736X_REG_GPIO_0_3		0x20
+#define NCT736X_REG_GPIO_4_7		0x21
+#define NCT736X_REG_GPIO_10_13		0x22
+#define NCT736X_REG_GPIO_14_17		0x23
+#define NCT7363_REG_WDT			0x2A
+#define WDT_CFG_MASK			GENMASK(3, 2)
+#define	WDT_CFG(x)			FIELD_PREP(WDT_CFG_MASK, (x))
+#define	EN_WDT				BIT(7)
+#define NCT736X_REG_PWMEN_0_7		0x38
+#define NCT736X_REG_PWMEN_8_15		0x39
+#define NCT736X_REG_FANINEN_0_7		0x41
+#define NCT736X_REG_FANINEN_8_15	0x42
+#define NCT736X_REG_FANINx_HVAL(x)	(0x48 + ((x) * 2))
+#define NCT736X_REG_FANINx_LVAL(x)	(0x49 + ((x) * 2))
+#define NCT736X_REG_FSCPxDUTY(x)	(0x90 + ((x) * 2))
+#define NCT736X_REG_VENDOR_ID		0xFD
+#define NCT736X_REG_CHIP_ID		0xFE
+#define NCT736X_REG_DEVICE_ID		0xFF
+
+#define NUVOTON_ID			0x49
+#define CHIP_ID				0x19
+#define DEVICE_ID			0x88
+
+#define PWM_SEL(x)			(BIT(0) << ((x % 4) * 2))
+#define FANIN_SEL(x)			(BIT(1) << ((x % 4) * 2))
+#define BIT_CHECK(x)			(BIT(0) << x)
+
+#define NCT736X_FANINx_LVAL_MASK	GENMASK(4, 0)
+#define NCT736X_FANIN_MASK		GENMASK(12, 0)
+
+#define NCT736X_PWM_COUNT		16
+#define NCT736X_FANIN_COUNT		16
+
+#define REFRESH_INTERVAL		(2 * HZ)
+
+static inline unsigned long FAN_FROM_REG(u16 val)
+{
+	if ((val >= NCT736X_FANIN_MASK) || (val == 0))
+		return	0;
+
+	return (1350000UL / val);
+}
+
+static const unsigned short normal_i2c[] = {
+	0x20, 0x21, 0x22, 0x23, I2C_CLIENT_END
+};
+
+enum chips { nct7362, nct7363 };
+
+struct nct736x_data {
+	struct i2c_client		*client;
+	const struct attribute_group	*groups[3];
+	struct mutex			update_lock;
+	bool				valid;
+	unsigned long			last_updated; /* In jiffies */
+
+	u16				fan_mask;
+	u16				fan[NCT736X_FANIN_COUNT];
+	u16				pwm_mask;
+	u8				pwm[NCT736X_PWM_COUNT];
+};
+
+/* Read 1-byte register. Returns unsigned reg or -ERRNO on error. */
+static int nct736x_read_reg(struct i2c_client *client, unsigned int reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, reg);
+	return ret;
+}
+
+/* Write 1-byte register. Returns 0 or -ERRNO on error. */
+static int nct736x_write_reg(struct i2c_client *client,
+			     unsigned int reg, u8 value)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, reg, value);
+	return ret;
+}
+
+static struct nct736x_data *nct736x_update_device(struct device *dev)
+{
+	struct nct736x_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (!(time_after(jiffies, data->last_updated + REFRESH_INTERVAL)
+	      || !data->valid))
+		goto no_sensor_update;
+
+	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
+		if (!(data->fan_mask & BIT_CHECK(i)))
+			continue;
+
+		data->fan[i] = ((u16)nct736x_read_reg(client,
+			NCT736X_REG_FANINx_HVAL(i))) << 5;
+		data->fan[i] |= nct736x_read_reg(client,
+			NCT736X_REG_FANINx_LVAL(i)) & NCT736X_FANINx_LVAL_MASK;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(data->pwm); i++) {
+		if (!(data->pwm_mask & BIT_CHECK(i)))
+			continue;
+
+		data->pwm[i] = nct736x_read_reg(client,
+						NCT736X_REG_FSCPxDUTY(i));
+	}
+
+	data->last_updated = jiffies;
+	data->valid = true;
+
+no_sensor_update:
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+static ssize_t
+fan_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct nct736x_data *data = nct736x_update_device(dev);
+	u16 val;
+
+	val = data->fan[sattr->index] & NCT736X_FANIN_MASK;
+
+	return sprintf(buf, "%lu\n", FAN_FROM_REG(val));
+}
+
+static ssize_t
+pwm_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct nct736x_data *data = nct736x_update_device(dev);
+	u16 val;
+
+	val = data->pwm[sattr->index];
+
+	return sprintf(buf, "%u\n", (val));
+}
+
+static ssize_t
+pwm_store(struct device *dev, struct device_attribute *attr,
+	  const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	struct nct736x_data *data = nct736x_update_device(dev);
+	struct i2c_client *client = data->client;
+	unsigned long tmpVal;
+	int err;
+
+	err = kstrtoul(buf, 10, &tmpVal);
+	if (err)
+		return err;
+
+	tmpVal = clamp_val(tmpVal, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	err = nct736x_write_reg(client, NCT736X_REG_FSCPxDUTY(sattr->index),
+				tmpVal);
+	if (err)
+		goto abort;
+
+	data->pwm[sattr->index] = tmpVal;
+
+abort:
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static umode_t nct736x_fan_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nct736x_data *data = dev_get_drvdata(dev);
+
+	if (!(data->fan_mask & BIT_CHECK(index)))
+		return 0;
+
+	return attr->mode;
+}
+
+static umode_t nct736x_pwm_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nct736x_data *data = dev_get_drvdata(dev);
+
+	if (!(data->pwm_mask & BIT_CHECK(index)))
+		return 0;
+
+	return attr->mode;
+}
+
+#define FAN_INPUT 0
+
+static SENSOR_DEVICE_ATTR_2_RO(fan1_input, fan, FAN_INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_input, fan, FAN_INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RO(fan3_input, fan, FAN_INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RO(fan4_input, fan, FAN_INPUT, 3);
+static SENSOR_DEVICE_ATTR_2_RO(fan5_input, fan, FAN_INPUT, 4);
+static SENSOR_DEVICE_ATTR_2_RO(fan6_input, fan, FAN_INPUT, 5);
+static SENSOR_DEVICE_ATTR_2_RO(fan7_input, fan, FAN_INPUT, 6);
+static SENSOR_DEVICE_ATTR_2_RO(fan8_input, fan, FAN_INPUT, 7);
+static SENSOR_DEVICE_ATTR_2_RO(fan9_input, fan, FAN_INPUT, 8);
+static SENSOR_DEVICE_ATTR_2_RO(fan10_input, fan, FAN_INPUT, 9);
+static SENSOR_DEVICE_ATTR_2_RO(fan11_input, fan, FAN_INPUT, 10);
+static SENSOR_DEVICE_ATTR_2_RO(fan12_input, fan, FAN_INPUT, 11);
+static SENSOR_DEVICE_ATTR_2_RO(fan13_input, fan, FAN_INPUT, 12);
+static SENSOR_DEVICE_ATTR_2_RO(fan14_input, fan, FAN_INPUT, 13);
+static SENSOR_DEVICE_ATTR_2_RO(fan15_input, fan, FAN_INPUT, 14);
+static SENSOR_DEVICE_ATTR_2_RO(fan16_input, fan, FAN_INPUT, 15);
+
+static struct attribute *nct736x_attributes_fan[] = {
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan5_input.dev_attr.attr,
+	&sensor_dev_attr_fan6_input.dev_attr.attr,
+	&sensor_dev_attr_fan7_input.dev_attr.attr,
+	&sensor_dev_attr_fan8_input.dev_attr.attr,
+	&sensor_dev_attr_fan9_input.dev_attr.attr,
+	&sensor_dev_attr_fan10_input.dev_attr.attr,
+	&sensor_dev_attr_fan11_input.dev_attr.attr,
+	&sensor_dev_attr_fan12_input.dev_attr.attr,
+	&sensor_dev_attr_fan13_input.dev_attr.attr,
+	&sensor_dev_attr_fan14_input.dev_attr.attr,
+	&sensor_dev_attr_fan15_input.dev_attr.attr,
+	&sensor_dev_attr_fan16_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group nct736x_group_fan = {
+	.attrs = nct736x_attributes_fan,
+	.is_visible = nct736x_fan_is_visible,
+};
+
+#define PWM_OUTPUT 0
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm1, pwm, PWM_OUTPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2, pwm, PWM_OUTPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3, pwm, PWM_OUTPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm4, pwm, PWM_OUTPUT, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm5, pwm, PWM_OUTPUT, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm6, pwm, PWM_OUTPUT, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm7, pwm, PWM_OUTPUT, 6);
+static SENSOR_DEVICE_ATTR_2_RW(pwm8, pwm, PWM_OUTPUT, 7);
+static SENSOR_DEVICE_ATTR_2_RW(pwm9, pwm, PWM_OUTPUT, 8);
+static SENSOR_DEVICE_ATTR_2_RW(pwm10, pwm, PWM_OUTPUT, 9);
+static SENSOR_DEVICE_ATTR_2_RW(pwm11, pwm, PWM_OUTPUT, 10);
+static SENSOR_DEVICE_ATTR_2_RW(pwm12, pwm, PWM_OUTPUT, 11);
+static SENSOR_DEVICE_ATTR_2_RW(pwm13, pwm, PWM_OUTPUT, 12);
+static SENSOR_DEVICE_ATTR_2_RW(pwm14, pwm, PWM_OUTPUT, 13);
+static SENSOR_DEVICE_ATTR_2_RW(pwm15, pwm, PWM_OUTPUT, 14);
+static SENSOR_DEVICE_ATTR_2_RW(pwm16, pwm, PWM_OUTPUT, 15);
+
+static struct attribute *nct736x_attributes_pwm[] = {
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	&sensor_dev_attr_pwm5.dev_attr.attr,
+	&sensor_dev_attr_pwm6.dev_attr.attr,
+	&sensor_dev_attr_pwm7.dev_attr.attr,
+	&sensor_dev_attr_pwm8.dev_attr.attr,
+	&sensor_dev_attr_pwm9.dev_attr.attr,
+	&sensor_dev_attr_pwm10.dev_attr.attr,
+	&sensor_dev_attr_pwm11.dev_attr.attr,
+	&sensor_dev_attr_pwm12.dev_attr.attr,
+	&sensor_dev_attr_pwm13.dev_attr.attr,
+	&sensor_dev_attr_pwm14.dev_attr.attr,
+	&sensor_dev_attr_pwm15.dev_attr.attr,
+	&sensor_dev_attr_pwm16.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group nct736x_group_pwm = {
+	.attrs = nct736x_attributes_pwm,
+	.is_visible = nct736x_pwm_is_visible,
+};
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int nct736x_detect(struct i2c_client *client,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int vendor, chip, device;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	vendor = i2c_smbus_read_byte_data(client, NCT736X_REG_VENDOR_ID);
+	if (vendor != NUVOTON_ID)
+		return -ENODEV;
+
+	chip = i2c_smbus_read_byte_data(client, NCT736X_REG_CHIP_ID);
+	if (chip != CHIP_ID)
+		return -ENODEV;
+
+	device = i2c_smbus_read_byte_data(client, NCT736X_REG_DEVICE_ID);
+	if (device != DEVICE_ID)
+		return -ENODEV;
+
+	strscpy(info->type, "nct736x", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static const struct i2c_device_id nct736x_id[] = {
+	{"nct7362", nct7362},
+	{"nct7363", nct7363},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, nct736x_id);
+
+static int nct736x_init_chip(struct i2c_client *client,
+			     u32 pwm_mask, u32 fanin_mask, u32 wdt_cfg)
+{
+	const struct i2c_device_id *id = i2c_match_id(nct736x_id, client);
+	u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
+	int ret;
+
+	for (i = 0; i < NCT736X_PWM_COUNT; i++) {
+		if (i < 4) {
+			if (pwm_mask & BIT_CHECK(i))
+				gpio0_3 |= PWM_SEL(i);
+			if (fanin_mask & BIT_CHECK(i))
+				gpio10_13 |= FANIN_SEL(i);
+		} else if (i < 8) {
+			if (pwm_mask & BIT_CHECK(i))
+				gpio4_7 |= PWM_SEL(i);
+			if (fanin_mask & BIT_CHECK(i))
+				gpio14_17 |= FANIN_SEL(i);
+		} else if (i < 12) {
+			if (pwm_mask & BIT_CHECK(i))
+				gpio10_13 |= PWM_SEL(i);
+			if (fanin_mask & BIT_CHECK(i))
+				gpio0_3 |= FANIN_SEL(i);
+		} else {
+			if (pwm_mask & BIT_CHECK(i))
+				gpio14_17 |= PWM_SEL(i);
+			if (fanin_mask & BIT_CHECK(i))
+				gpio4_7 |= FANIN_SEL(i);
+		}
+	}
+
+	/* Pin Function Configuration */
+	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_0_3, gpio0_3);
+	if (ret < 0)
+		return ret;
+	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_4_7, gpio4_7);
+	if (ret < 0)
+		return ret;
+	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_10_13, gpio10_13);
+	if (ret < 0)
+		return ret;
+	ret = nct736x_write_reg(client, NCT736X_REG_GPIO_14_17, gpio14_17);
+	if (ret < 0)
+		return ret;
+
+	/* PWM and FANIN Monitoring Enable */
+	ret = nct736x_write_reg(client, NCT736X_REG_PWMEN_0_7,
+				pwm_mask & 0xff);
+	if (ret < 0)
+		return ret;
+	ret = nct736x_write_reg(client,
+				NCT736X_REG_PWMEN_8_15, (pwm_mask >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+	ret = nct736x_write_reg(client, NCT736X_REG_FANINEN_0_7,
+				fanin_mask & 0xff);
+	if (ret < 0)
+		return ret;
+	ret = nct736x_write_reg(client, NCT736X_REG_FANINEN_8_15,
+				(fanin_mask >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	/* Watchdog Timer Configuration */
+	if (wdt_cfg != 0xff && id->driver_data == nct7363) {
+		ret = nct736x_write_reg(client, NCT7363_REG_WDT, wdt_cfg);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int nct736x_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct nct736x_data *data;
+	struct device *hwmon_dev;
+	u32 pwm_mask, fanin_mask, val, wdt_cfg;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(struct nct736x_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	data->client = client;
+
+	if (of_property_read_u32(dev->of_node, "nuvoton,pwm-mask", &pwm_mask))
+		pwm_mask = 0;
+	if (of_property_read_u32(dev->of_node,
+				 "nuvoton,fanin-mask", &fanin_mask))
+		fanin_mask = 0;
+	if (of_property_read_u32(dev->of_node, "nuvoton,wdt-timeout", &val))
+		wdt_cfg = 0xff;
+	else
+		wdt_cfg = WDT_CFG(val) | EN_WDT;
+
+	/* Initialize the chip */
+	ret = nct736x_init_chip(client, pwm_mask, fanin_mask, wdt_cfg);
+	if (ret)
+		return ret;
+
+	data->fan_mask = (u16)fanin_mask;
+	data->pwm_mask = (u16)pwm_mask;
+
+	data = nct736x_update_device(dev);
+
+	data->groups[0] = &nct736x_group_fan;
+	data->groups[1] = &nct736x_group_pwm;
+	data->groups[2] = NULL;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+							   client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id nct736x_of_match[] = {
+	{ .compatible = "nuvoton,nct7362" },
+	{ .compatible = "nuvoton,nct7363" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, nct736x_of_match);
+
+static struct i2c_driver nct736x_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "nct736x",
+		.of_match_table = nct736x_of_match,
+	},
+	.probe = nct736x_probe,
+	.id_table = nct736x_id,
+	.detect = nct736x_detect,
+	.address_list = normal_i2c,
+};
+
+module_i2c_driver(nct736x_driver);
+
+MODULE_AUTHOR("CWHo <cwho@nuvoton.com>");
+MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
+MODULE_DESCRIPTION("NCT736X Hardware Monitoring Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

