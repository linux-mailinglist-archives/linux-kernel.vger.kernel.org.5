Return-Path: <linux-kernel+bounces-122873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C388FEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD946B21982
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456C7FBAF;
	Thu, 28 Mar 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFqublWS"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C57F489;
	Thu, 28 Mar 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627978; cv=none; b=oVHf0zBjd4tsZko4UG6KOCA4kK/w7skwmTX8x7vOnssgqDkcFSvCjgnb74a2VQrW9hHVw+xyRDwgx239URcumIhJu84falwzZKPuAy4Q5xDrGu+JXkITlL55r4M/QAnmpYJMgyNiAYseYpagB5IClWoEops++a029JVkhT5Rt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627978; c=relaxed/simple;
	bh=Q5YE1aPumt7JFmbvdJ7I7wcFxejCrBTx7WoifZdGz8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bw0m3I9It/RSMqeNipL3Z+NBsJhW5SacI5LGCyzGJ4Q9tvOEsVzWtQNuNe5DQ0r1pSEHCFT1JSV1SALZBV3gDqCr1JqpHdmB0afXbV+NHNXJz2Snl+SdWi5RN9Dcv13G064KcauaIrfKiC4/XV0k+zT9fzsY/F3+96QWVRZNrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFqublWS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso726812276.2;
        Thu, 28 Mar 2024 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627975; x=1712232775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7crQtx+2AtaDeT/4OM+Ua6ongtYXTGemk9bKab2fDbI=;
        b=QFqublWShPkwDkJn7aPy7DAKRQGiLwAExCGplPvFJYEx9SV5y6H0+QP4TjCFkA5Zvq
         7M9VniFzKKNIQzsqaeblUFEou42+WpfR/ci+hjy7EMdG3ZfqtoSFcW5DMkfJ/y/wYv7P
         GblhxNgS6HQdMqaF9XEsa//Rnitxmk9HDLA+QQTtTDw8zXefYGqc6fQ0Ne5IqvAMYOUq
         /PVHNxxc0z+fOvz+pZcVRNNZiE+aBZ1s4Mkg2O5iiZIXqF3Cybs/iPALLsHKRPbMOKya
         HIEfBXQqinDoyfDmLR3jYnqNOEveo5OkPFAVsjNLhzSbpInNx0aqwz9frrKCWDqCH6SZ
         fsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627975; x=1712232775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7crQtx+2AtaDeT/4OM+Ua6ongtYXTGemk9bKab2fDbI=;
        b=jOt7FT2Xtfjnkef/omJS+DhUT9bFip5BinE2t1mOTKrChMSHIan8JDUCdUTTGJ/LMI
         6bzmcRi+Kf+DTzSM0RL/tbjPkzTNheNuhX+5pV+MpwFbceFvZeKRve/4Vhq+XFqq2APv
         KITjK7kdrf6ftawMUyUgvlEn703EZ7z3zhVXgA0mMg+q2sJr+rcPXuJZnzkic6Nt9jqT
         NPqZGevYIStVwJx9vtSqj71hCXPb9Pcjw6aLmBCKJ1DbwxRy2fT6w1Uvkf4xY0kXKWeu
         RpEM9MI4nHPGidf1cDN1+CNgOjMe0iCa1EoauMUWGG4h4br1kMD9NAbTTXN63B+2FxG5
         kGJg==
X-Forwarded-Encrypted: i=1; AJvYcCVQv3oWkBDIqcJaGmA0KUqTQ7mJAu0czlBcnX0FrQZga1qjTKTav32QvvoCW8sm3Zfo1j6NKixdhtN5K98UZvtupHsC4sSDaJ1yuBsn
X-Gm-Message-State: AOJu0YwNr3Xb2u5mancFYYrF/9g1pdhfdtRbzhIRdq7pq+dlavRKFZum
	XOmC/UnOo3TAq6R77EFxah6mhk57YUx9iZctT0JkBT6EO2bz9FSEtXFPSvh7v/w=
X-Google-Smtp-Source: AGHT+IGvl9aRUTYIptBImWsQQQ44LqiFxVxpW0TSFyEyPkxa2LaoUY5qT2kshHQbSZ78gSlfIRrnIg==
X-Received: by 2002:a25:b104:0:b0:dc2:421e:c943 with SMTP id g4-20020a25b104000000b00dc2421ec943mr2768353ybj.42.1711627975192;
        Thu, 28 Mar 2024 05:12:55 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6241:1610:f66b:8cff:fe8c:91ce])
        by smtp.gmail.com with ESMTPSA id 193-20020a250cca000000b00dc701e0bdbcsm268859ybm.44.2024.03.28.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:54 -0700 (PDT)
From: David Ober <dober6023@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	dober@lenovo.com,
	mpearson@lenovo.com,
	David Ober <dober6023@gmail.com>
Subject: [PATCH v5] hwmon:Add EC Chip driver for Lenovo ThinkStation motherboards
Date: Thu, 28 Mar 2024 08:12:50 -0400
Message-Id: <20240328121250.331146-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addition adds in the ability for the system to scan
the EC chip in the Lenovo ThinkStation systems to get the
current fan RPM speeds the Maximum speed value for each
fan also provides the CPU, DIMM other thermal statuses

Signed-off-by: David Ober <dober6023@gmail.com>

---
Changes in V5
added FMT for err messages
removed macros as suggested
used GENMASK as suggested
moved request region after memory allocation for local data
updated includes list
changed byte read/wrtie to word where applicable
---
---
 drivers/hwmon/Kconfig             |  10 +
 drivers/hwmon/Makefile            |   1 +
 drivers/hwmon/lenovo-ec-sensors.c | 605 ++++++++++++++++++++++++++++++
 3 files changed, 616 insertions(+)
 create mode 100644 drivers/hwmon/lenovo-ec-sensors.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..a4bb403bd4ad 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -862,6 +862,16 @@ config SENSORS_LAN966X
 	  This driver can also be built as a module. If so, the module
 	  will be called lan966x-hwmon.
 
+config SENSORS_LENOVO_EC
+        tristate "Sensor reader for Lenovo ThinkStations"
+        depends on X86
+        help
+          If you say yes here you get support for LENOVO
+          EC Sensor data on newer ThinkStation systems
+
+          This driver can also be built as a module. If so, the module
+          will be called lenovo_ec_sensors.
+
 config SENSORS_LINEAGE
 	tristate "Lineage Compact Power Line Power Entry Module"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4ac9452b5430..aa3c2dc390ec 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
 obj-$(CONFIG_SENSORS_LAN966X)	+= lan966x-hwmon.o
+obj-$(CONFIG_SENSORS_LENOVO_EC)	+= lenovo-ec-sensors.o
 obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
 obj-$(CONFIG_SENSORS_LOCHNAGAR)	+= lochnagar-hwmon.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
new file mode 100644
index 000000000000..8571b983c726
--- /dev/null
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -0,0 +1,605 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON driver for Lenovo ThinkStation based workstations
+ * via the embedded controller registers
+ *
+ * Copyright (C) 2024 David Ober (Lenovo) <dober@lenovo.com>
+ *
+ * EC provides:
+ * - CPU temperature
+ * - DIMM temperature
+ * - Chassis zone temperatures
+ * - CPU fan RPM
+ * - DIMM fan RPM
+ * - Chassis fans RPM
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#define MCHP_SING_IDX			0x0000
+#define MCHP_EMI0_APPLICATION_ID	0x090C
+#define MCHP_EMI0_EC_ADDRESS		0x0902
+#define MCHP_EMI0_EC_DATA_BYTE0		0x0904
+#define MCHP_EMI0_EC_DATA_BYTE1		0x0905
+#define MCHP_EMI0_EC_DATA_BYTE2		0x0906
+#define MCHP_EMI0_EC_DATA_BYTE3		0x0907
+#define IO_REGION_START			0x0900
+#define IO_REGION_LENGTH		0xD
+
+static inline u8
+get_ec_reg(unsigned char page, unsigned char index)
+{
+	u8 onebyte;
+	unsigned short m_index;
+	unsigned short phy_index = page * 256 + index;
+
+	outb_p(0x01, MCHP_EMI0_APPLICATION_ID);
+
+	m_index = phy_index & GENMASK(14, 2);
+	outw_p(m_index, MCHP_EMI0_EC_ADDRESS);
+
+	onebyte = inb_p(MCHP_EMI0_EC_DATA_BYTE0 + (phy_index & GENMASK(1, 0)));
+
+	outb_p(0x01, MCHP_EMI0_APPLICATION_ID);  /* write 0x01 again to clean */
+	return onebyte;
+}
+
+enum systems {
+	LENOVO_PX,
+	LENOVO_P7,
+	LENOVO_P5,
+	LENOVO_P8,
+};
+
+static int px_temp_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+
+static const char * const lenovo_px_ec_temp_label[] = {
+	"CPU1",
+	"CPU2",
+	"R_DIMM1",
+	"L_DIMM1",
+	"R_DIMM2",
+	"L_DIMM2",
+	"PCH",
+	"M2_R",
+	"M2_Z1R",
+	"M2_Z2R",
+	"PCI_Z1",
+	"PCI_Z2",
+	"PCI_Z3",
+	"PCI_Z4",
+	"AMB",
+};
+
+static int gen_temp_map[] = {0, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+
+static const char * const lenovo_gen_ec_temp_label[] = {
+	"CPU1",
+	"R_DIMM",
+	"L_DIMM",
+	"PCH",
+	"M2_R",
+	"M2_Z1R",
+	"M2_Z2R",
+	"PCI_Z1",
+	"PCI_Z2",
+	"PCI_Z3",
+	"PCI_Z4",
+	"AMB",
+};
+
+static int px_fan_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+
+static const char * const px_ec_fan_label[] = {
+	"CPU1_Fan",
+	"CPU2_Fan",
+	"Front_Fan1-1",
+	"Front_Fan1-2",
+	"Front_Fan2",
+	"Front_Fan3",
+	"MEM_Fan1",
+	"MEM_Fan2",
+	"Rear_Fan1",
+	"Rear_Fan2",
+	"Flex_Bay_Fan1",
+	"Flex_Bay_Fan2",
+	"Flex_Bay_Fan2",
+	"PSU_HDD_Fan",
+	"PSU1_Fan",
+	"PSU2_Fan",
+};
+
+static int p7_fan_map[] = {0, 2, 3, 4, 5, 6, 7, 8, 10, 11, 14};
+
+static const char * const p7_ec_fan_label[] = {
+	"CPU1_Fan",
+	"HP_CPU_Fan1",
+	"HP_CPU_Fan2",
+	"PCIE1_4_Fan",
+	"PCIE5_7_Fan",
+	"MEM_Fan1",
+	"MEM_Fan2",
+	"Rear_Fan1",
+	"BCB_Fan",
+	"Flex_Bay_Fan",
+	"PSU_Fan",
+};
+
+static int p5_fan_map[] = {0, 5, 6, 7, 8, 10, 11, 14};
+
+static const char * const p5_ec_fan_label[] = {
+	"CPU_Fan",
+	"HDD_Fan",
+	"Duct_Fan1",
+	"MEM_Fan",
+	"Rear_Fan",
+	"Front_Fan",
+	"Flex_Bay_Fan",
+	"PSU_Fan",
+};
+
+static int p8_fan_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14};
+
+static const char * const p8_ec_fan_label[] = {
+	"CPU1_Fan",
+	"CPU2_Fan",
+	"HP_CPU_Fan1",
+	"HP_CPU_Fan2",
+	"PCIE1_4_Fan",
+	"PCIE5_7_Fan",
+	"DIMM1_Fan1",
+	"DIMM1_Fan2",
+	"DIMM2_Fan1",
+	"DIMM2_Fan2",
+	"Rear_Fan",
+	"HDD_Bay_Fan",
+	"Flex_Bay_Fan",
+	"PSU_Fan",
+};
+
+struct ec_sensors_data {
+	struct mutex mec_mutex; /* lock for sensor data access */
+	const char *const *fan_labels;
+	const char *const *temp_labels;
+	const int *fan_map;
+	const int *temp_map;
+};
+
+static int
+lenovo_ec_do_read_temp(struct ec_sensors_data *data, u32 attr, int channel, long *val)
+{
+	u8 lsb;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		mutex_lock(&data->mec_mutex);
+		lsb = get_ec_reg(2, 0x81 + channel);
+		mutex_unlock(&data->mec_mutex);
+		if (lsb <= 0x40)
+			return -ENODATA;
+		*val = (lsb - 0x40) * 1000;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int channel, long *val)
+{
+	u8 lsb, msb;
+
+	channel *= 2;
+	switch (attr) {
+	case hwmon_fan_input:
+		mutex_lock(&data->mec_mutex);
+		lsb = get_ec_reg(4, 0x20 + channel);
+		msb = get_ec_reg(4, 0x21 + channel);
+		mutex_unlock(&data->mec_mutex);
+		*val = (msb << 8) + lsb;
+		return 0;
+	case hwmon_fan_max:
+		mutex_lock(&data->mec_mutex);
+		lsb = get_ec_reg(4, 0x40 + channel);
+		msb = get_ec_reg(4, 0x41 + channel);
+		mutex_unlock(&data->mec_mutex);
+		*val = (msb << 8) + lsb;
+		return 0;
+	case hwmon_fan_min:
+	case hwmon_fan_div:
+	case hwmon_fan_alarm:
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+lenovo_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, const char **str)
+{
+	struct ec_sensors_data *state = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		*str = state->temp_labels[channel];
+		return 0;
+	case hwmon_fan:
+		*str = state->fan_labels[channel];
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+		     u32 attr, int channel, long *val)
+{
+	struct ec_sensors_data *data = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		return lenovo_ec_do_read_temp(data, attr, data->temp_map[channel], val);
+	case hwmon_fan:
+		return lenovo_ec_do_read_fan(data, attr, data->fan_map[channel], val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t
+lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+			   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		if (attr == hwmon_temp_input || attr == hwmon_temp_label)
+			return 0444;
+		return 0;
+	case hwmon_fan:
+		if (attr == hwmon_fan_input || attr == hwmon_fan_max || attr == hwmon_fan_label)
+			return 0444;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_px[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p8[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p7[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p5[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
+	NULL
+};
+
+static const struct hwmon_ops lenovo_ec_hwmon_ops = {
+	.is_visible = lenovo_ec_hwmon_is_visible,
+	.read = lenovo_ec_hwmon_read,
+	.read_string = lenovo_ec_hwmon_read_string,
+};
+
+static struct hwmon_chip_info lenovo_ec_chip_info = {
+	.ops = &lenovo_ec_hwmon_ops,
+};
+
+static const struct dmi_system_id thinkstation_dmi_table[] = {
+	{
+		.ident = "LENOVO_PX",
+		.driver_data = (void *)(long)LENOVO_PX,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30EU"),
+		},
+	},
+	{
+		.ident = "LENOVO_PX",
+		.driver_data = (void *)(long)LENOVO_PX,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30EV"),
+		},
+	},
+	{
+		.ident = "LENOVO_P7",
+		.driver_data = (void *)(long)LENOVO_P7,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30F2"),
+		},
+	},
+	{
+		.ident = "LENOVO_P7",
+		.driver_data = (void *)(long)LENOVO_P7,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30F3"),
+		},
+	},
+	{
+		.ident = "LENOVO_P5",
+		.driver_data = (void *)(long)LENOVO_P5,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30G9"),
+		},
+	},
+	{
+		.ident = "LENOVO_P5",
+		.driver_data = (void *)(long)LENOVO_P5,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30GA"),
+		},
+	},
+	{
+		.ident = "LENOVO_P8",
+		.driver_data = (void *)(long)LENOVO_P8,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30HH"),
+		},
+	},
+	{
+		.ident = "LENOVO_P8",
+		.driver_data = (void *)(long)LENOVO_P8,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "30HJ"),
+		},
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, thinkstation_dmi_table);
+
+static int lenovo_ec_probe(struct platform_device *pdev)
+{
+	struct device *hwdev;
+	struct ec_sensors_data *ec_data;
+	const struct hwmon_chip_info *chip_info;
+	struct device *dev = &pdev->dev;
+	const struct dmi_system_id *dmi_id;
+	int app_id;
+
+	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNEL);
+	if (!ec_data)
+		return -ENOMEM;
+
+	if (!request_region(IO_REGION_START, IO_REGION_LENGTH, "LNV-WKS")) {
+		pr_err(":request fail\n");
+		return -EIO;
+	}
+
+	dev_set_drvdata(dev, ec_data);
+
+	chip_info = &lenovo_ec_chip_info;
+
+	mutex_init(&ec_data->mec_mutex);
+
+	mutex_lock(&ec_data->mec_mutex);
+	app_id = inb_p(MCHP_EMI0_APPLICATION_ID);
+	if (app_id) /* check EMI Application ID Value */
+		outb_p(app_id, MCHP_EMI0_APPLICATION_ID); /* set EMI Application ID to 0 */
+	outw_p(MCHP_SING_IDX, MCHP_EMI0_EC_ADDRESS);
+	mutex_unlock(&ec_data->mec_mutex);
+
+	if ((inb_p(MCHP_EMI0_EC_DATA_BYTE0) != 'M') &&
+	    (inb_p(MCHP_EMI0_EC_DATA_BYTE1) != 'C') &&
+	    (inb_p(MCHP_EMI0_EC_DATA_BYTE2) != 'H') &&
+	    (inb_p(MCHP_EMI0_EC_DATA_BYTE3) != 'P')) {
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return -ENODEV;
+	}
+
+	dmi_id = dmi_first_match(thinkstation_dmi_table);
+
+	switch ((long)dmi_id->driver_data) {
+	case 0:
+		ec_data->fan_labels = px_ec_fan_label;
+		ec_data->temp_labels = lenovo_px_ec_temp_label;
+		ec_data->fan_map = px_fan_map;
+		ec_data->temp_map = px_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_px;
+		break;
+	case 1:
+		ec_data->fan_labels = p7_ec_fan_label;
+		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->fan_map = p7_fan_map;
+		ec_data->temp_map = gen_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p7;
+		break;
+	case 2:
+		ec_data->fan_labels = p5_ec_fan_label;
+		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->fan_map = p5_fan_map;
+		ec_data->temp_map = gen_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p5;
+		break;
+	case 3:
+		ec_data->fan_labels = p8_ec_fan_label;
+		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->fan_map = p8_fan_map;
+		ec_data->temp_map = gen_temp_map;
+		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p8;
+		break;
+	default:
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return -ENODEV;
+	}
+
+	hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
+						     ec_data,
+						     chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwdev);
+}
+
+static struct platform_driver lenovo_ec_sensors_platform_driver = {
+	.driver = {
+		.name	= "lenovo-ec-sensors",
+	},
+	.probe = lenovo_ec_probe,
+};
+
+static struct platform_device *lenovo_ec_sensors_platform_device;
+
+static int __init lenovo_ec_init(void)
+{
+	if (!dmi_check_system(thinkstation_dmi_table))
+		return -ENODEV;
+
+	lenovo_ec_sensors_platform_device =
+		platform_create_bundle(&lenovo_ec_sensors_platform_driver,
+				       lenovo_ec_probe, NULL, 0, NULL, 0);
+
+	if (IS_ERR(lenovo_ec_sensors_platform_device)) {
+		release_region(IO_REGION_START, IO_REGION_LENGTH);
+		return PTR_ERR(lenovo_ec_sensors_platform_device);
+	}
+
+	return 0;
+}
+module_init(lenovo_ec_init);
+
+static void __exit lenovo_ec_exit(void)
+{
+	release_region(IO_REGION_START, IO_REGION_LENGTH);
+	platform_device_unregister(lenovo_ec_sensors_platform_device);
+	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
+}
+module_exit(lenovo_ec_exit);
+
+MODULE_AUTHOR("David Ober <dober@lenovo.com>");
+MODULE_DESCRIPTION("HWMON driver for sensors accesssible via EC in LENOVO motherboards");
+MODULE_LICENSE("GPL");
-- 
2.34.1


