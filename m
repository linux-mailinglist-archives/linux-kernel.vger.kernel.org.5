Return-Path: <linux-kernel+bounces-52889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC788849DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BE61F25F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64F2D03D;
	Mon,  5 Feb 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcsEEDZW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5C2C6B9;
	Mon,  5 Feb 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146463; cv=none; b=fxdv6w3SQg+h29p1kp9L7O6oRjrys13lGJP2Tm5vu2O2Au3jadZSBJ7wqKy9pytPF7lIJhhodSIXfTfyGzdg6T6ayq0SkUhHOtpusBF8Pwf1R7JbKCAinRePL/TeYulmUlIticgq0ikqaRvCy9gxQEIMunwGtgxAjohsvUs/HNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146463; c=relaxed/simple;
	bh=Phk4fDv6jAw8C7MpJeocXfq0wLJWRjKpV1hPRsgIVeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6QilEdDRZW3hJ3TUkfGjD2mzKwDRDwVZQ4kJkRsOZM7k6MkqUvYnPUIfqnvvcCyNAMexnhFuzbdz4xGWzselUkfMeYt5PZ0PEDeKUe/XAHtbTXcmxJYBUeM6CKFCni+FpzoHBL0TGdIHlRcN4pwfUPFyA4mOlA3Gg2dtbm6IOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcsEEDZW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d74045c463so35188685ad.3;
        Mon, 05 Feb 2024 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707146461; x=1707751261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZiOfl26jWwturtPM6ebcQgMxasBZSOJJ9bhG1a6OJo=;
        b=jcsEEDZW2WvIsEq/YQPNqkt3HO7Eh8VP47A03ySQkEv8QlXYe11djqJ/nJazA+YAt2
         gtseAnHBc8EGVq53IKNplTgNveJWC5q5Jfkb7521Dr+hiylSQP16a5MZpWZsUxBPZUje
         k12uYrMnzA8SGLpI+ncAj25ndCUC8KWD7/4t2/046GLg4zu8JextwlHiDIqq0jRpHdKH
         mmxrhwACqdYm/76wSsyyCvh9e4a8WtGkrzq96ZOTvhp7hNBybF8YZsuQIjn3j2M/3eGe
         c/+rxB1YX6uTVMet5wYSoMijaWoVA26jt4UHHwpfOQnl5dwjLONTz/X5Ksw2lNXOtZus
         gDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146461; x=1707751261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZiOfl26jWwturtPM6ebcQgMxasBZSOJJ9bhG1a6OJo=;
        b=NJRpwdzMM8cbC4zu5ttJnXkxPILkoYfd/WViVCLikeXJpwBpJHXoOhFyTnrMT3D5eL
         R2qDMAK5Uh47iOdM5Y7u/7a/VQIA+R00gnw+rUFYTJYxEOHOauH/sSX65ILWyX+aXXX5
         fR7QT14kwPfP7xP0+whRqZ1iKtrr32KNEsY9+Y12Tdp2TRuNSbHcbXpxUb+R4OteWzvK
         Vkm9k+BmhLf19MzDEWyMrtm+rj/cgN6n4hnU0ezlduiOwp0Ix6DT5rZmtwm8onFJrsmx
         2w2RFYAMhrVmz68Rnr9RXKAQHyUo/9tZaLvZzjeLVwm8wtsmrjjyeK34pwrBFg5v54FR
         jlgw==
X-Gm-Message-State: AOJu0YxuI6L58XjDfHVQ4+B1BpA8xEaxwdghJi00gTPw4rIziLB/J6KC
	J6mDpljmEl8ek9z6OTLUfdjTUhmochALYbxVDvAJC2bE+cglTq3+
X-Google-Smtp-Source: AGHT+IFcQv7izAOH5r7FlST0GcACXQXJ/Co5lfhFxOY8/qcNc8vRP5f7BbsPZjNxrLDEvrFJmmHIjQ==
X-Received: by 2002:a17:903:643:b0:1d9:464b:68a5 with SMTP id kh3-20020a170903064300b001d9464b68a5mr8378461plb.56.1707146460736;
        Mon, 05 Feb 2024 07:21:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUG2FUNxjBvi28sw6SH0KmuuoTdM/iDzciz0cGpMkrXNe6znBpFC+pX32BOpV3cE3cVLcnfku2td/ASgefJ0FrjpHOFeZnmYw0hhDbeob2O9HJsMhCNd7+965U0gE9QfrScK7DuVxbbTQzBHcjfdh+p7WRr9+Sasqh0H72gdjizL9LuDiX+2GZY9tZVWt9arOEL/0fuGWwN+fw9wYimqTLAVCoUQXHdbEJq+41q2caissDxho88WFR8uCcJShxxqM6+eobBzVeZ1brVdJMrI4bN5IrN6HT+SNNYWF4U4/sGaZZG1+m+kX97vL/wQAVUiKyxLo1QXYwbxhNf5Q3WAW9YTAhXeVm1BB8QTR9LYizD6NdVA8CQI5pCddBUG14+qP9XCSfVeXMJf1RkJ4X789GjNLOA58T+QF7V59wvthnOSg5G7YbpME6SbXiXIS29Rt9jYa0NdT5fe2IIpMbVO4sEicXUOr4fJd+MiTu26/xJo0myJSfquZvhEiYi/C+ksB7vwp5yzzJ+V/Y7eTw/GW4gElegfFpIJ44oRgnskeI2mP/j5cpdRNk5vUfBG/URIXlbswvpUve6BPhzO1ulkM/NTf7DTtKq0dZYR3Vm9widOE7MyPhlHQE8EB958J6bxEKmAnkznwImn6XNcHXa5d6POEuqigNsEY/W6g52jFaIvxZjJkQGtCrHd2MDVmjFKFAhrl8Pl0gFn1auKcDP0haJpn3lu/A7WKN5oR3NqrhktFm6AFQR8iWWK64lbLdGTgfTS9KGRMhRltaTGPt9n3wpVJPkU7ScFSBCNq5Em0yh/QF6UHjPdCnfNy1UcvKGUT75tq5DOg==
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902f29500b001d94a3f3987sm6444393plc.184.2024.02.05.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:20:59 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	naresh.solanki@9elements.com,
	vincent@vtremblay.dev,
	patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com,
	bhelgaas@google.com,
	festevam@denx.de,
	alexander.stein@ew.tq-group.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	macromorgan@hotmail.com,
	forbidden405@foxmail.com,
	sre@kernel.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com
Subject: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Date: Mon,  5 Feb 2024 23:20:13 +0800
Message-Id: <20240205152013.3833940-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205152013.3833940-1-chou.cosmo@gmail.com>
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver implements support for temperature monitoring of Astera Labs
PT5161L series PCIe retimer chips.

This driver implementation originates from the CSDK available at
Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
The communication protocol utilized is based on the I2C/SMBus standard.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/pt5161l.rst |  42 ++
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/pt5161l.c         | 673 ++++++++++++++++++++++++++++++++
 6 files changed, 734 insertions(+)
 create mode 100644 Documentation/hwmon/pt5161l.rst
 create mode 100644 drivers/hwmon/pt5161l.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c7ed1f73ac06..9f5f215fcb2d 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -185,6 +185,7 @@ Hardware Monitoring Kernel Drivers
    pmbus
    powerz
    powr1220
+   pt5161l
    pxe1610
    pwm-fan
    q54sj108a2
diff --git a/Documentation/hwmon/pt5161l.rst b/Documentation/hwmon/pt5161l.rst
new file mode 100644
index 000000000000..1b97336991ea
--- /dev/null
+++ b/Documentation/hwmon/pt5161l.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver pt5161l
+=====================
+
+Supported chips:
+
+  * Astera Labs PT5161L
+
+    Prefix: 'pt5161l'
+
+    Addresses scanned: I2C 0x20 - 0x27
+
+    Datasheet: Not publicly available.
+
+Authors: Cosmo Chou <cosmo.chou@quantatw.com>
+
+Description
+-----------
+
+This driver implements support for temperature monitoring of Astera Labs
+PT5161L series PCIe retimer chips.
+
+This driver implementation originates from the CSDK available at
+https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
+The communication protocol utilized is based on the I2C/SMBus standard.
+
+Sysfs entries
+----------------
+
+================ ==============================================
+temp1_input      Measured temperature (in millidegrees Celsius)
+================ ==============================================
+
+Debugfs entries
+----------------
+
+================ ===============================
+fw_load_status   Firmware load status
+fw_ver           Firmware version of the retimer
+heartbeat_status Heartbeat status
+================ ===============================
diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..a656b98971ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17679,6 +17679,13 @@ F:	fs/pstore/
 F:	include/linux/pstore*
 K:	\b(pstore|ramoops)
 
+PT5161L HARDWARE MONITOR DRIVER
+M:	Cosmo Chou <cosmo.chou@quantatw.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/pt5161l.rst
+F:	drivers/hwmon/pt5161l.c
+
 PTP HARDWARE CLOCK SUPPORT
 M:	Richard Cochran <richardcochran@gmail.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a608264da87d..c8d86a695f66 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1714,6 +1714,16 @@ source "drivers/hwmon/peci/Kconfig"
 
 source "drivers/hwmon/pmbus/Kconfig"
 
+config SENSORS_PT5161L
+	tristate "Astera Labs PT5161L PCIe retimer hardware monitoring"
+	depends on I2C
+	help
+	  If you say yes here you get support for temperature monitoring
+	  on the Astera Labs PT5161L PCIe retimer.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pt5161l.
+
 config SENSORS_PWM_FAN
 	tristate "PWM fan"
 	depends on (PWM && OF) || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 47be39af5c03..0554d3ccb09a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -180,6 +180,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
+obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
 obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
new file mode 100644
index 000000000000..8a77513ddf3a
--- /dev/null
+++ b/drivers/hwmon/pt5161l.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+/* Aries current average temp ADC code CSR */
+#define ARIES_CURRENT_AVG_TEMP_ADC_CSR	0x42c
+
+/* Device Load check register */
+#define ARIES_CODE_LOAD_REG	0x605
+/* Value indicating FW was loaded properly, [3:1] = 3'b111 */
+#define ARIES_LOAD_CODE	0xe
+
+/* Main Micro Heartbeat register */
+#define ARIES_MM_HEARTBEAT_ADDR	0x923
+
+/* Reg offset to specify Address for MM assisted accesses */
+#define ARIES_MM_ASSIST_REG_ADDR_OFFSET	0xd99
+/* Reg offset to specify Command for MM assisted accesses */
+#define ARIES_MM_ASSIST_CMD_OFFSET	0xd9d
+/* Reg offset to MM SPARE 0 used specify Address[7:0] */
+#define ARIES_MM_ASSIST_SPARE_0_OFFSET	0xd9f
+/* Reg offset to MM SPARE 3 used specify Data Byte 0 */
+#define ARIES_MM_ASSIST_SPARE_3_OFFSET	0xda2
+/* Wide register reads */
+#define ARIES_MM_RD_WIDE_REG_2B	0x1d
+#define ARIES_MM_RD_WIDE_REG_3B	0x1e
+#define ARIES_MM_RD_WIDE_REG_4B	0x1f
+#define ARIES_MM_RD_WIDE_REG_5B	0x20
+
+/* Time delay between checking MM status of EEPROM write (microseconds) */
+#define ARIES_MM_STATUS_TIME	5000
+
+/* AL Main SRAM DMEM offset (A0) */
+#define AL_MAIN_SRAM_DMEM_OFFSET	(64 * 1024)
+/* SRAM read command */
+#define AL_TG_RD_LOC_IND_SRAM	0x16
+
+/* Offset for main micro FW info */
+#define ARIES_MAIN_MICRO_FW_INFO	(96 * 1024 - 128)
+/* FW Info (Major) offset location in struct */
+#define ARIES_MM_FW_VERSION_MAJOR	0
+/* FW Info (Minor) offset location in struct */
+#define ARIES_MM_FW_VERSION_MINOR	1
+/* FW Info (Build no.) offset location in struct */
+#define ARIES_MM_FW_VERSION_BUILD	2
+
+#define ARIES_TEMP_CAL_CODE_DEFAULT	84
+
+/* Struct defining FW version loaded on an Aries device */
+struct pt5161l_fw_ver {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
+/* Each client has this additional data */
+struct pt5161l_data {
+	struct i2c_client *client;
+	struct dentry *debugfs;
+	struct pt5161l_fw_ver fw_ver;
+	struct mutex lock; /* for atomic I2C transactions */
+	bool init_done;
+	bool code_load_okay; /* indicate if code load reg value is expected */
+	bool mm_heartbeat_okay; /* indicate if Main Micro heartbeat is good */
+	bool mm_wide_reg_access; /* MM assisted wide register access */
+};
+
+static struct dentry *pt5161l_debugfs_dir;
+
+/*
+ * Write multiple data bytes to Aries over I2C
+ */
+static int pt5161l_write_block_data(struct pt5161l_data *data, u32 address,
+				    u8 len, u8 *val)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+	u8 remain_len = len;
+	u8 xfer_len, curr_len;
+	u8 buf[16];
+	u8 cmd = 0x0F; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */
+	u8 config = 0x40; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 */
+
+	while (remain_len > 0) {
+		if (remain_len > 4) {
+			curr_len = 4;
+			remain_len -= 4;
+		} else {
+			curr_len = remain_len;
+			remain_len = 0;
+		}
+
+		buf[0] = config | (curr_len - 1) << 1 | ((address >> 16) & 0x1);
+		buf[1] = (address >> 8) & 0xff;
+		buf[2] = address & 0xff;
+		memcpy(&buf[3], val, curr_len);
+
+		xfer_len = 3 + curr_len;
+		ret = i2c_smbus_write_block_data(client, cmd, xfer_len, buf);
+		if (ret)
+			return ret;
+
+		val += curr_len;
+		address += curr_len;
+	}
+
+	return 0;
+}
+
+/*
+ * Read multiple data bytes from Aries over I2C
+ */
+static int pt5161l_read_block_data(struct pt5161l_data *data, u32 address,
+				   u8 len, u8 *val)
+{
+	struct i2c_client *client = data->client;
+	int ret, tries;
+	u8 remain_len = len;
+	u8 curr_len;
+	u8 wbuf[16], rbuf[24];
+	u8 cmd = 0x08; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */
+	u8 config = 0x00; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 */
+
+	while (remain_len > 0) {
+		if (remain_len > 16) {
+			curr_len = 16;
+			remain_len -= 16;
+		} else {
+			curr_len = remain_len;
+			remain_len = 0;
+		}
+
+		wbuf[0] = config | (curr_len - 1) << 1 |
+			  ((address >> 16) & 0x1);
+		wbuf[1] = (address >> 8) & 0xff;
+		wbuf[2] = address & 0xff;
+
+		for (tries = 0; tries < 3; tries++) {
+			ret = i2c_smbus_write_block_data(client, (cmd | 0x2), 3,
+							 wbuf);
+			if (ret)
+				return ret;
+
+			ret = i2c_smbus_read_block_data(client, (cmd | 0x1),
+							rbuf);
+			if (ret == curr_len)
+				break;
+		}
+		if (tries >= 3)
+			return ret;
+
+		memcpy(val, rbuf, curr_len);
+		val += curr_len;
+		address += curr_len;
+	}
+
+	return 0;
+}
+
+static int pt5161l_read_wide_reg(struct pt5161l_data *data, u32 address,
+				 u8 width, u8 *val)
+{
+	int ret, tries;
+	u8 buf[8];
+	u8 status;
+
+	/*
+	 * Safely access wide registers using mailbox method to prevent
+	 * risking conflict with Aries firmware; otherwise fallback to
+	 * legacy, less secure method.
+	 */
+	if (data->mm_wide_reg_access) {
+		buf[0] = address & 0xff;
+		buf[1] = (address >> 8) & 0xff;
+		buf[2] = (address >> 16) & 0x1;
+		ret = pt5161l_write_block_data(data,
+					       ARIES_MM_ASSIST_SPARE_0_OFFSET,
+					       3, buf);
+		if (ret)
+			return ret;
+
+		/* Set command based on width */
+		switch (width) {
+		case 2:
+			buf[0] = ARIES_MM_RD_WIDE_REG_2B;
+			break;
+		case 3:
+			buf[0] = ARIES_MM_RD_WIDE_REG_3B;
+			break;
+		case 4:
+			buf[0] = ARIES_MM_RD_WIDE_REG_4B;
+			break;
+		case 5:
+			buf[0] = ARIES_MM_RD_WIDE_REG_5B;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ret = pt5161l_write_block_data(data, ARIES_MM_ASSIST_CMD_OFFSET,
+					       1, buf);
+		if (ret)
+			return ret;
+
+		status = 0xff;
+		for (tries = 0; tries < 100; tries++) {
+			ret = pt5161l_read_block_data(data,
+						      ARIES_MM_ASSIST_CMD_OFFSET,
+						      1, &status);
+			if (ret)
+				return ret;
+
+			if (status == 0)
+				break;
+
+			usleep_range(ARIES_MM_STATUS_TIME,
+				     ARIES_MM_STATUS_TIME + 1000);
+		}
+		if (status != 0)
+			return -ETIMEDOUT;
+
+		ret = pt5161l_read_block_data(data,
+					      ARIES_MM_ASSIST_SPARE_3_OFFSET,
+					      width, val);
+		if (ret)
+			return ret;
+	} else {
+		return pt5161l_read_block_data(data, address, width, val);
+	}
+
+	return 0;
+}
+
+/*
+ * Read multiple (up to eight) data bytes from micro SRAM over I2C
+ */
+static int
+pt5161l_read_block_data_main_micro_indirect(struct pt5161l_data *data,
+					    u32 address, u8 len, u8 *val)
+{
+	int ret, tries;
+	u8 buf[8];
+	u8 i, status;
+	u32 uind_offs = ARIES_MM_ASSIST_REG_ADDR_OFFSET;
+	u32 eeprom_base, eeprom_addr;
+
+	/* No multi-byte indirect support here. Hence read a byte at a time */
+	eeprom_base = address - AL_MAIN_SRAM_DMEM_OFFSET;
+	for (i = 0; i < len; i++) {
+		eeprom_addr = eeprom_base + i;
+		buf[0] = eeprom_addr & 0xff;
+		buf[1] = (eeprom_addr >> 8) & 0xff;
+		buf[2] = (eeprom_addr >> 16) & 0xff;
+		ret = pt5161l_write_block_data(data, uind_offs, 3, buf);
+		if (ret)
+			return ret;
+
+		buf[0] = AL_TG_RD_LOC_IND_SRAM;
+		ret = pt5161l_write_block_data(data, uind_offs + 4, 1, buf);
+		if (ret)
+			return ret;
+
+		status = 0xff;
+		for (tries = 0; tries < 255; tries++) {
+			ret = pt5161l_read_block_data(data, uind_offs + 4, 1,
+						      &status);
+			if (ret)
+				return ret;
+
+			if (status == 0)
+				break;
+		}
+		if (status != 0)
+			return -ETIMEDOUT;
+
+		ret = pt5161l_read_block_data(data, uind_offs + 3, 1, buf);
+		if (ret)
+			return ret;
+
+		val[i] = buf[0];
+	}
+
+	return 0;
+}
+
+/*
+ * Check firmware load status
+ */
+static int pt5161l_fw_load_check(struct pt5161l_data *data)
+{
+	int ret;
+	u8 buf[8];
+
+	ret = pt5161l_read_block_data(data, ARIES_CODE_LOAD_REG, 1, buf);
+	if (ret)
+		return ret;
+
+	if (buf[0] < ARIES_LOAD_CODE) {
+		dev_dbg(&data->client->dev,
+			"Code Load reg unexpected. Not all modules are loaded %x\n",
+			buf[0]);
+		data->code_load_okay = false;
+	} else {
+		data->code_load_okay = true;
+	}
+
+	return 0;
+}
+
+/*
+ * Check main micro heartbeat
+ */
+static int pt5161l_heartbeat_check(struct pt5161l_data *data)
+{
+	int ret, tries;
+	u8 buf[8];
+	u8 heartbeat;
+	bool hb_changed = false;
+
+	ret = pt5161l_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1, buf);
+	if (ret)
+		return ret;
+
+	heartbeat = buf[0];
+	for (tries = 0; tries < 100; tries++) {
+		ret = pt5161l_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1,
+					      buf);
+		if (ret)
+			return ret;
+
+		if (buf[0] != heartbeat) {
+			hb_changed = true;
+			break;
+		}
+	}
+	data->mm_heartbeat_okay = hb_changed;
+
+	return 0;
+}
+
+/*
+ * Check the status of firmware
+ */
+static int pt5161l_fwsts_check(struct pt5161l_data *data)
+{
+	int ret;
+	u8 buf[8];
+	u8 major = 0, minor = 0;
+	u16 build = 0;
+
+	ret = pt5161l_fw_load_check(data);
+	if (ret)
+		return ret;
+
+	ret = pt5161l_heartbeat_check(data);
+	if (ret)
+		return ret;
+
+	if (data->code_load_okay && data->mm_heartbeat_okay) {
+		ret = pt5161l_read_block_data_main_micro_indirect(data, ARIES_MAIN_MICRO_FW_INFO +
+								  ARIES_MM_FW_VERSION_MAJOR,
+								  1, &major);
+		if (ret)
+			return ret;
+
+		ret = pt5161l_read_block_data_main_micro_indirect(data, ARIES_MAIN_MICRO_FW_INFO +
+								  ARIES_MM_FW_VERSION_MINOR,
+								  1, &minor);
+		if (ret)
+			return ret;
+
+		ret = pt5161l_read_block_data_main_micro_indirect(data, ARIES_MAIN_MICRO_FW_INFO +
+								  ARIES_MM_FW_VERSION_BUILD,
+								  2, buf);
+		if (ret)
+			return ret;
+		build = buf[1] << 8 | buf[0];
+	}
+	data->fw_ver.major = major;
+	data->fw_ver.minor = minor;
+	data->fw_ver.build = build;
+
+	return 0;
+}
+
+static int pt5161l_fw_is_at_least(struct pt5161l_data *data, u8 major, u8 minor,
+				  u16 build)
+{
+	u32 ver = major << 24 | minor << 16 | build;
+	u32 curr_ver = data->fw_ver.major << 24 | data->fw_ver.minor << 16 |
+		       data->fw_ver.build;
+
+	if (curr_ver >= ver)
+		return true;
+
+	return false;
+}
+
+static int pt5161l_init_dev(struct pt5161l_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = pt5161l_fwsts_check(data);
+	mutex_unlock(&data->lock);
+	if (ret)
+		return ret;
+
+	/* Firmware 2.2.0 enables safe access to wide registers */
+	if (pt5161l_fw_is_at_least(data, 2, 2, 0))
+		data->mm_wide_reg_access = true;
+
+	data->init_done = true;
+
+	return 0;
+}
+
+static int pt5161l_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct pt5161l_data *data = dev_get_drvdata(dev);
+	int ret;
+	u8 buf[8];
+	long adc_code;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		if (!data->init_done) {
+			ret = pt5161l_init_dev(data);
+			if (ret)
+				return ret;
+		}
+
+		mutex_lock(&data->lock);
+		ret = pt5161l_read_wide_reg(data,
+					    ARIES_CURRENT_AVG_TEMP_ADC_CSR, 4,
+					    buf);
+		mutex_unlock(&data->lock);
+		if (ret) {
+			dev_dbg(dev, "Read adc_code failed %d\n", ret);
+			return ret;
+		}
+
+		adc_code = buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
+		if (adc_code == 0 || adc_code >= 0x3ff) {
+			dev_dbg(dev, "Invalid adc_code %lx\n", adc_code);
+			return -EIO;
+		}
+
+		*val = 110000 +
+		       ((adc_code - (ARIES_TEMP_CAL_CODE_DEFAULT + 250)) *
+			-320);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static umode_t pt5161l_is_visible(const void *data,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *pt5161l_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops pt5161l_hwmon_ops = {
+	.is_visible = pt5161l_is_visible,
+	.read = pt5161l_read,
+};
+
+static const struct hwmon_chip_info pt5161l_chip_info = {
+	.ops = &pt5161l_hwmon_ops,
+	.info = pt5161l_info,
+};
+
+static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	struct pt5161l_data *data = file->private_data;
+	int ret;
+	char ver[32];
+
+	mutex_lock(&data->lock);
+	ret = pt5161l_fwsts_check(data);
+	mutex_unlock(&data->lock);
+	if (ret)
+		return ret;
+
+	ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
+		       data->fw_ver.minor, data->fw_ver.build);
+	if (ret < 0)
+		return ret;
+
+	return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
+}
+
+static const struct file_operations pt5161l_debugfs_ops_fw_ver = {
+	.read = pt5161l_debugfs_read_fw_ver,
+	.open = simple_open,
+};
+
+static ssize_t pt5161l_debugfs_read_fw_load_sts(struct file *file,
+						char __user *buf, size_t count,
+						loff_t *ppos)
+{
+	struct pt5161l_data *data = file->private_data;
+	int ret;
+	bool status = false;
+	char health[16];
+
+	mutex_lock(&data->lock);
+	ret = pt5161l_fw_load_check(data);
+	mutex_unlock(&data->lock);
+	if (ret == 0)
+		status = data->code_load_okay;
+
+	ret = snprintf(health, sizeof(health), "%s\n",
+		       status ? "normal" : "abnormal");
+	if (ret < 0)
+		return ret;
+
+	return simple_read_from_buffer(buf, count, ppos, health, ret + 1);
+}
+
+static const struct file_operations pt5161l_debugfs_ops_fw_load_sts = {
+	.read = pt5161l_debugfs_read_fw_load_sts,
+	.open = simple_open,
+};
+
+static ssize_t pt5161l_debugfs_read_hb_sts(struct file *file, char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	struct pt5161l_data *data = file->private_data;
+	int ret;
+	bool status = false;
+	char health[16];
+
+	mutex_lock(&data->lock);
+	ret = pt5161l_heartbeat_check(data);
+	mutex_unlock(&data->lock);
+	if (ret == 0)
+		status = data->mm_heartbeat_okay;
+
+	ret = snprintf(health, sizeof(health), "%s\n",
+		       status ? "normal" : "abnormal");
+	if (ret < 0)
+		return ret;
+
+	return simple_read_from_buffer(buf, count, ppos, health, ret + 1);
+}
+
+static const struct file_operations pt5161l_debugfs_ops_hb_sts = {
+	.read = pt5161l_debugfs_read_hb_sts,
+	.open = simple_open,
+};
+
+static int pt5161l_init_debugfs(struct pt5161l_data *data)
+{
+	data->debugfs = debugfs_create_dir(dev_name(&data->client->dev),
+					   pt5161l_debugfs_dir);
+
+	debugfs_create_file("fw_ver", 0444, data->debugfs, data,
+			    &pt5161l_debugfs_ops_fw_ver);
+
+	debugfs_create_file("fw_load_status", 0444, data->debugfs, data,
+			    &pt5161l_debugfs_ops_fw_load_sts);
+
+	debugfs_create_file("heartbeat_status", 0444, data->debugfs, data,
+			    &pt5161l_debugfs_ops_hb_sts);
+
+	return 0;
+}
+
+static int pt5161l_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct pt5161l_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct pt5161l_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->lock);
+	pt5161l_init_dev(data);
+	dev_set_drvdata(dev, data);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 data,
+							 &pt5161l_chip_info,
+							 NULL);
+
+	pt5161l_init_debugfs(data);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static void pt5161l_remove(struct i2c_client *client)
+{
+	struct pt5161l_data *data = i2c_get_clientdata(client);
+
+	debugfs_remove_recursive(data->debugfs);
+}
+
+static const struct of_device_id __maybe_unused pt5161l_of_match[] = {
+	{ .compatible = "asteralabs,pt5161l" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pt5161l_of_match);
+
+static const struct acpi_device_id __maybe_unused pt5161l_acpi_match[] = {
+	{ "PT5161L", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, pt5161l_acpi_match);
+
+static const struct i2c_device_id pt5161l_id[] = {
+	{ "pt5161l", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pt5161l_id);
+
+static struct i2c_driver pt5161l_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "pt5161l",
+		.of_match_table = of_match_ptr(pt5161l_of_match),
+		.acpi_match_table = ACPI_PTR(pt5161l_acpi_match),
+	},
+	.probe = pt5161l_probe,
+	.remove = pt5161l_remove,
+	.id_table = pt5161l_id,
+};
+
+static int __init pt5161l_init(void)
+{
+	pt5161l_debugfs_dir = debugfs_create_dir("pt5161l", NULL);
+	return i2c_add_driver(&pt5161l_driver);
+}
+
+static void __exit pt5161l_exit(void)
+{
+	i2c_del_driver(&pt5161l_driver);
+	debugfs_remove_recursive(pt5161l_debugfs_dir);
+}
+
+module_init(pt5161l_init);
+module_exit(pt5161l_exit);
+
+MODULE_AUTHOR("Cosmo Chou <cosmo.chou@quantatw.com>");
+MODULE_DESCRIPTION("Hwmon driver for Astera Labs Aries PCIe retimer");
+MODULE_LICENSE("GPL");
-- 
2.34.1


