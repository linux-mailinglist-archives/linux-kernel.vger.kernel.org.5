Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD36804B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbjLEHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjLEHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:49:21 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C3134;
        Mon,  4 Dec 2023 23:49:25 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b9b8522d91so981922b6e.0;
        Mon, 04 Dec 2023 23:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701762564; x=1702367364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BLWRQU7e2ks4OA6ZEmVZgby82HFHiFIto+WZbyqHV8=;
        b=ZSQOuTqIVACsjF7mxAozUJMRgcuR9DLzyqjpkh1AFu1zPDcUe9YrBLwZC5nVbLMh8U
         pvnld+z2EZg+IfZ9zPkPa54iqNy+0J/PBmSBAr/ldBZC3vJ2DPig6Zv4HYsPka1TaLke
         PDxZRgF2x4dlelOxc7Vh5kKlhmOM0CCDl3FTIhkFK2G1gCUIPgirSy6AHDkrl5iD5WPz
         zLxOm1v8AzXftDg09o15sHBMaPDoQIgcd54TmUBSlN59aImDBIHDvtbBNj7foRoUFuPc
         QMOOf3E2om40jBTBwUC325CFEyQfbMwc7/h6IsqDEv3AKDgOqlN8TjFIznY89RE9PYGf
         st1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762564; x=1702367364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BLWRQU7e2ks4OA6ZEmVZgby82HFHiFIto+WZbyqHV8=;
        b=B5m6J/JkAZfb2znH4Axv01m3YCsGy0Me0NkQDn3b+wvAu/hwwjHmrgD51TSZx8wJjk
         m/ODl1TQfSywVmiWn7kyQYYyHgx8v2KHhkWBb30NPssDaGV9J0hMS6CVKmaozKmPKq6j
         2L4u6k89TYRQuMqd6Oj1Yb9zpjJEk0uZ9j0DFkXWWg7JjkoA3n8kt7bbFhYhqKNsxVO7
         bvXTImU9I2bBzm/u/knGSHbU9oe/wdfzkqbqT2pnlaOtMKHRaA8xrub7C5dO6zIO9lCY
         KXGfCN67CPnnNDzEPT3x+Yr8h4CiwNZ/WFna76rHm/y8g+0mYmFlGufBLkSTn8TI28g4
         gu3Q==
X-Gm-Message-State: AOJu0YwAQPOTibyl7A6bymvq2WtJzIpFtesCNNbvPm+57b3u+RF6YYW9
        63Pnj20xY9L+tyxAACbNVao=
X-Google-Smtp-Source: AGHT+IECqJgTRaJeqghoPO27gsrGckZGXi+FtW2ydQLEvRIBjTr6cTt/rVwwuyB0U/z+KWS7YClp4Q==
X-Received: by 2002:a05:6808:1489:b0:3b8:b063:6b9b with SMTP id e9-20020a056808148900b003b8b0636b9bmr6860761oiw.74.1701762564447;
        Mon, 04 Dec 2023 23:49:24 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b006ce54e08b6asm2582529pfh.203.2023.12.04.23.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 23:49:24 -0800 (PST)
From:   Cosmo Chou <chou.cosmo@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        chou.cosmo@gmail.com, cosmo.chou@quantatw.com
Subject: [PATCH 3/3] hwmon: Add driver for Astera Labs PT516XX retimer
Date:   Tue,  5 Dec 2023 15:47:23 +0800
Message-Id: <20231205074723.3546295-4-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205074723.3546295-1-chou.cosmo@gmail.com>
References: <20231205074723.3546295-1-chou.cosmo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver implements support for temperature monitoring of Astera Labs
PT5161L series PCIe retimer chips.

This driver implementation originates from the CSDK available at
Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
The communication protocol utilized is based on the I2C/SMBus standard.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/pt516xx.rst |  48 +++
 MAINTAINERS                     |   8 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/pt516xx.c         | 648 ++++++++++++++++++++++++++++++++
 6 files changed, 716 insertions(+)
 create mode 100644 Documentation/hwmon/pt516xx.rst
 create mode 100644 drivers/hwmon/pt516xx.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 72f4e6065bae..2c4df18db663 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -181,6 +181,7 @@ Hardware Monitoring Kernel Drivers
    pmbus
    powerz
    powr1220
+   pt516xx
    pxe1610
    pwm-fan
    q54sj108a2
diff --git a/Documentation/hwmon/pt516xx.rst b/Documentation/hwmon/pt516xx.rst
new file mode 100644
index 000000000000..945194f9a804
--- /dev/null
+++ b/Documentation/hwmon/pt516xx.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver pt516xx
+====================
+
+Supported chips:
+
+  * Astera Labs PT5161L
+
+    Prefix: 'pt5161l'
+
+    Addresses: I2C 0x24
+
+    Datasheet: http://www.asteralabs.com/wp-content/uploads/2021/03/Astera_Labs_PT5161L_Product_Brief.pdf
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
+For more detailed information and specific implementation details, it is
+recommended to refer to the CSDK source code available at the provided GitHub
+link.
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
+================ ====================================
+fw_ver           Firmware version of the retimer
+health           Health status (8 bits)
+                 [0]: Heartbeat Okay (1'b1: OK)
+                 [1]: Firmware loaded Okay (1'b1: OK)
+                 [7:2]: Reserved
+================ ====================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b73..492002ffd12c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17482,6 +17482,14 @@ F:	fs/pstore/
 F:	include/linux/pstore*
 K:	\b(pstore|ramoops)
 
+PT516XX HARDWARE MONITOR DRIVER
+M:	Cosmo Chou <cosmo.chou@quantatw.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
+F:	Documentation/hwmon/pt516xx.rst
+F:	drivers/hwmon/pt516xx.c
+
 PTP HARDWARE CLOCK SUPPORT
 M:	Richard Cochran <richardcochran@gmail.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index cf27523eed5a..3965bec7774a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1703,6 +1703,16 @@ source "drivers/hwmon/peci/Kconfig"
 
 source "drivers/hwmon/pmbus/Kconfig"
 
+config SENSORS_PT516XX
+	tristate "Astera Labs PT516XX PCIe retimer hardware monitoring"
+	depends on I2C
+	help
+	  If you say yes here you get support for temperature monitoring
+	  on the Astera Labs PT516XX PCIe retimer.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pt516xx.
+
 config SENSORS_PWM_FAN
 	tristate "PWM fan"
 	depends on (PWM && OF) || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e84bd9685b5c..1942064cd4e9 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -179,6 +179,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
+obj-$(CONFIG_SENSORS_PT516XX)	+= pt516xx.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
 obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
diff --git a/drivers/hwmon/pt516xx.c b/drivers/hwmon/pt516xx.c
new file mode 100644
index 000000000000..824798559fe1
--- /dev/null
+++ b/drivers/hwmon/pt516xx.c
@@ -0,0 +1,648 @@
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
+#include <linux/of_device.h>
+
+/** Main-micro-assisted access command codes */
+// Wide register reads
+#define ARIES_MM_RD_WIDE_REG_2B 0x1d
+#define ARIES_MM_RD_WIDE_REG_3B 0x1e
+#define ARIES_MM_RD_WIDE_REG_4B 0x1f
+#define ARIES_MM_RD_WIDE_REG_5B 0x20
+// Wide register writes
+#define ARIES_MM_WR_WIDE_REG_2B 0x21
+#define ARIES_MM_WR_WIDE_REG_3B 0x22
+#define ARIES_MM_WR_WIDE_REG_4B 0x23
+#define ARIES_MM_WR_WIDE_REG_5B 0x24
+
+/** Temperature measurement constants */
+// Aries current average temp ADC code CSR
+#define ARIES_CURRENT_AVG_TEMP_ADC_CSR 0x42c
+
+// Main Micro Heartbeat reg
+#define ARIES_MM_HEARTBEAT_ADDR 0x923
+
+/** Main SRAM */
+// AL Main SRAM DMEM offset (A0)
+#define AL_MAIN_SRAM_DMEM_OFFSET (64 * 1024)
+// SRAM read command
+#define AL_TG_RD_LOC_IND_SRAM 0x16
+
+/** Micros */
+// Offset for main micro FW info
+#define ARIES_MAIN_MICRO_FW_INFO (96 * 1024 - 128)
+
+/** Path Micro Members */
+// FW Info (Major) offset location in struct
+#define ARIES_MM_FW_VERSION_MAJOR 0
+// FW Info (Minor) offset location in struct
+#define ARIES_MM_FW_VERSION_MINOR 1
+// FW Info (Build no.) offset location in struct
+#define ARIES_MM_FW_VERSION_BUILD 2
+
+/** Offsets for MM assisted accesses */
+// Legacy Address and Data registers (using wide registers)
+// Reg offset to specify Address for MM assisted accesses
+#define ARIES_MM_ASSIST_REG_ADDR_OFFSET 0xd99
+// Reg offset to specify Command
+#define ARIES_MM_ASSIST_CMD_OFFSET 0xd9d
+
+// New Address and Data registers (not using wide registers)
+// Reg offset to MM SPARE 0 used specify Address[7:0]
+#define ARIES_MM_ASSIST_SPARE_0_OFFSET 0xd9f
+// Reg offset to MM SPARE 3 used specify Data Byte 0
+#define ARIES_MM_ASSIST_SPARE_3_OFFSET 0xda2
+
+/** Misc block offsets */
+// Device Load check register
+#define ARIES_CODE_LOAD_REG 0x605
+
+/** Value indicating FW was loaded properly */
+#define ARIES_LOAD_CODE 0xe
+
+/** EEPROM parameters */
+// Time delay between checking MM status of EEPROM write (microseconds)
+#define ARIES_MM_STATUS_TIME 5000
+
+#define ARIES_TEMP_CAL_CODE_DEFAULT 84
+
+/* Struct defining FW version loaded on an Aries device */
+struct pt516xx_fw_ver {
+	u8 major; // FW version major release value
+	u8 minor; // FW version minor release value
+	u16 build; // FW version build release value
+};
+
+/* Each client has this additional data */
+struct pt516xx_data {
+	struct i2c_client *client;
+	struct dentry *debugfs;
+	struct pt516xx_fw_ver fw_ver;
+	struct mutex lock;
+	bool init_done;
+	bool pec_enable; // Enable PEC
+	bool code_load_okay; // indicate if code load reg value is expected
+	bool mm_heartbeat_okay; // indicate if Main Micro heartbeat is good
+	bool mm_wide_reg_valid; // MM assisted Wide Register access
+	u8 temp_cal_code_avg;
+};
+
+static struct dentry *pt516xx_debugfs_dir;
+
+/*
+ * Write multiple data bytes to Aries over I2C
+ */
+static int pt516xx_write_block_data(struct pt516xx_data *data, u32 address,
+				    u8 len, u8 *val)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+	u8 remain_len = len;
+	u8 xfer_len, curr_len;
+	u8 buf[16];
+	u8 cmd = 0x0F; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start, [0]:end
+	u8 config = 0x40; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 of address
+
+	if (data->pec_enable)
+		cmd |= 0x80;
+
+	// If byte count is greater than 4, perform multiple iterations
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
+static int pt516xx_read_block_data(struct pt516xx_data *data, u32 address,
+				   u8 len, u8 *val)
+{
+	struct i2c_client *client = data->client;
+	int ret, tries;
+	u8 remain_len = len;
+	u8 curr_len;
+	u8 wbuf[16], rbuf[24];
+	u8 cmd = 0x08; // [7]:pec_en, [6:5]:rsvd, [4:2]:func, [1]:start, [0]:end
+	u8 config = 0x00; // [6]:cfg_type, [4:1]:burst_len, [0]:bit16 of address
+
+	if (data->pec_enable)
+		cmd |= 0x80;
+
+	// If byte count is greater than 16, perform multiple iterations
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
+		// Perform read operation
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
+			return -ENODATA;
+
+		memcpy(val, rbuf, curr_len);
+		val += curr_len;
+		address += curr_len;
+	}
+
+	return 0;
+}
+
+static int pt516xx_read_wide_reg(struct pt516xx_data *data, u32 address,
+				 u8 width, u8 *val)
+{
+	int ret, tries;
+	u8 buf[8];
+	u8 status;
+
+	if (data->mm_wide_reg_valid) {
+		// Write address (3 bytes)
+		buf[0] = address & 0xff;
+		buf[1] = (address >> 8) & 0xff;
+		buf[2] = (address >> 16) & 0x1;
+		ret = pt516xx_write_block_data(
+			data, ARIES_MM_ASSIST_SPARE_0_OFFSET, 3, buf);
+		if (ret)
+			return ret;
+
+		// Set command based on width
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
+		ret = pt516xx_write_block_data(data, ARIES_MM_ASSIST_CMD_OFFSET,
+					       1, buf);
+		if (ret)
+			return ret;
+
+		// Check access status
+		status = 0xff;
+		for (tries = 0; tries < 100; tries++) {
+			ret = pt516xx_read_block_data(
+				data, ARIES_MM_ASSIST_CMD_OFFSET, 1, &status);
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
+		// Read N bytes of data based on width
+		ret = pt516xx_read_block_data(
+			data, ARIES_MM_ASSIST_SPARE_3_OFFSET, width, val);
+		if (ret)
+			return ret;
+	} else {
+		return pt516xx_read_block_data(data, address, width, val);
+	}
+
+	return 0;
+}
+
+/*
+ * Read multiple (up to eight) data bytes from micro SRAM over I2C
+ */
+static int
+pt516xx_read_block_data_main_micro_indirect(struct pt516xx_data *data,
+					    u32 address, u8 len, u8 *val)
+{
+	int ret, tries;
+	u8 buf[8];
+	u8 i, status;
+	u32 uind_offs = ARIES_MM_ASSIST_REG_ADDR_OFFSET;
+	u32 eeprom_base, eeprom_addr;
+
+	// No multi-byte indirect support here. Hence read a byte at a time
+	eeprom_base = address - AL_MAIN_SRAM_DMEM_OFFSET;
+	for (i = 0; i < len; i++) {
+		// Write eeprom addr
+		eeprom_addr = eeprom_base + i;
+		buf[0] = eeprom_addr & 0xff;
+		buf[1] = (eeprom_addr >> 8) & 0xff;
+		buf[2] = (eeprom_addr >> 16) & 0xff;
+		ret = pt516xx_write_block_data(data, uind_offs, 3, buf);
+		if (ret)
+			return ret;
+
+		// Write eeprom cmd
+		buf[0] = AL_TG_RD_LOC_IND_SRAM;
+		ret = pt516xx_write_block_data(data, uind_offs + 4, 1, buf);
+		if (ret)
+			return ret;
+
+		// Test successful access
+		status = 0xff;
+		for (tries = 0; tries < 255; tries++) {
+			ret = pt516xx_read_block_data(data, uind_offs + 4, 1,
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
+		ret = pt516xx_read_block_data(data, uind_offs + 3, 1, buf);
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
+ * Check the status of firmware
+ */
+static int pt516xx_fwsts_check(struct pt516xx_data *data)
+{
+	int ret, tries;
+	u8 buf[8];
+	u8 heartbeat, major = 0, minor = 0;
+	u16 build = 0;
+	bool hb_changed = false;
+
+	// Read Code Load reg
+	ret = pt516xx_read_block_data(data, ARIES_CODE_LOAD_REG, 1, buf);
+	if (ret)
+		return ret;
+
+	if (buf[0] < ARIES_LOAD_CODE) {
+		dev_warn(
+			&data->client->dev,
+			"Code Load reg unexpected. Not all modules are loaded %x\n",
+			buf[0]);
+		data->code_load_okay = false;
+	} else {
+		data->code_load_okay = true;
+	}
+
+	// Check Main Micro heartbeat
+	// If heartbeat value does not change for 100 tries, no MM heartbeat
+	// Else heartbeat present even if one value changes
+	ret = pt516xx_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1, buf);
+	if (ret)
+		return ret;
+
+	heartbeat = buf[0];
+	for (tries = 0; tries < 100; tries++) {
+		ret = pt516xx_read_block_data(data, ARIES_MM_HEARTBEAT_ADDR, 1,
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
+	// Read FW version
+	// If heartbeat not there, set default FW values to 0.0.0
+	// and return success
+	if (data->mm_heartbeat_okay) {
+		// Get FW version (major)
+		ret = pt516xx_read_block_data_main_micro_indirect(
+			data,
+			ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MAJOR, 1,
+			&major);
+		if (ret)
+			return ret;
+
+		// Get FW version (minor)
+		ret = pt516xx_read_block_data_main_micro_indirect(
+			data,
+			ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_MINOR, 1,
+			&minor);
+		if (ret)
+			return ret;
+
+		// Get FW version (build)
+		ret = pt516xx_read_block_data_main_micro_indirect(
+			data,
+			ARIES_MAIN_MICRO_FW_INFO + ARIES_MM_FW_VERSION_BUILD, 2,
+			(u8 *)&build);
+		if (ret)
+			return ret;
+	} else {
+		dev_warn(&data->client->dev, "No Main Micro Heartbeat\n");
+	}
+	data->fw_ver.major = major;
+	data->fw_ver.minor = minor;
+	data->fw_ver.build = build;
+
+	return 0;
+}
+
+static int pt516xx_fw_is_at_least(struct pt516xx_data *data, u8 major, u8 minor,
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
+static int pt516xx_init_dev(struct pt516xx_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = pt516xx_fwsts_check(data);
+	mutex_unlock(&data->lock);
+	if (ret)
+		return ret;
+
+	dev_info(&data->client->dev, "fw_ver: %u.%u.%u\n", data->fw_ver.major,
+		 data->fw_ver.minor, data->fw_ver.build);
+
+	if (pt516xx_fw_is_at_least(data, 2, 2, 0))
+		data->mm_wide_reg_valid = true;
+
+	data->temp_cal_code_avg = ARIES_TEMP_CAL_CODE_DEFAULT;
+	data->init_done = true;
+
+	return 0;
+}
+
+static int pt516xx_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct pt516xx_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+	long adc_code = 0;
+
+	if (!data->init_done) {
+		ret = pt516xx_init_dev(data);
+		if (ret) {
+			dev_err(dev, "pt516xx_init_dev failed %d\n", ret);
+			return ret;
+		}
+	}
+
+	switch (attr) {
+	case hwmon_temp_input:
+		mutex_lock(&data->lock);
+		ret = pt516xx_read_wide_reg(data,
+					    ARIES_CURRENT_AVG_TEMP_ADC_CSR, 4,
+					    (u8 *)&adc_code);
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (ret) {
+		dev_err(dev, "Read adc_code failed %d\n", ret);
+		return ret;
+	}
+	if (adc_code == 0 || adc_code >= 0x3ff) {
+		dev_err(dev, "Invalid adc_code %lx\n", adc_code);
+		return -EINVAL;
+	}
+
+	*val = 110000 + ((adc_code - (data->temp_cal_code_avg + 250)) * -320);
+
+	return 0;
+}
+
+static umode_t pt516xx_is_visible(const void *data,
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
+static const struct hwmon_channel_info *pt516xx_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops pt516xx_hwmon_ops = {
+	.is_visible = pt516xx_is_visible,
+	.read = pt516xx_read,
+};
+
+static const struct hwmon_chip_info pt516xx_chip_info = {
+	.ops = &pt516xx_hwmon_ops,
+	.info = pt516xx_info,
+};
+
+static ssize_t pt516xx_debugfs_read_fw_ver(struct file *file, char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	struct pt516xx_data *data = file->private_data;
+	int ret;
+	char ver[32];
+
+	mutex_lock(&data->lock);
+	ret = pt516xx_fwsts_check(data);
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
+static const struct file_operations pt516xx_debugfs_ops_fw_ver = {
+	.read = pt516xx_debugfs_read_fw_ver,
+	.open = simple_open,
+};
+
+static ssize_t pt516xx_debugfs_read_health(struct file *file, char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	struct pt516xx_data *data = file->private_data;
+	int ret;
+	u8 status = 0;
+	char health[8];
+
+	mutex_lock(&data->lock);
+	ret = pt516xx_fwsts_check(data);
+	mutex_unlock(&data->lock);
+	if (ret == 0) {
+		status |= data->mm_heartbeat_okay ? 1 : 0; // bit0
+		status |= data->code_load_okay ? 2 : 0; // bit1
+	}
+
+	ret = snprintf(health, sizeof(health), "0x%02x\n", status);
+	if (ret < 0)
+		return ret;
+
+	return simple_read_from_buffer(buf, count, ppos, health, ret + 1);
+}
+
+static const struct file_operations pt516xx_debugfs_ops_health = {
+	.read = pt516xx_debugfs_read_health,
+	.open = simple_open,
+};
+
+static int pt516xx_init_debugfs(struct pt516xx_data *data)
+{
+	if (!pt516xx_debugfs_dir)
+		return -ENOENT;
+
+	data->debugfs = debugfs_create_dir(dev_name(&data->client->dev),
+					   pt516xx_debugfs_dir);
+	if (IS_ERR_OR_NULL(data->debugfs))
+		return -ENOENT;
+
+	debugfs_create_file("fw_ver", 0444, data->debugfs, data,
+			    &pt516xx_debugfs_ops_fw_ver);
+
+	debugfs_create_file("health", 0444, data->debugfs, data,
+			    &pt516xx_debugfs_ops_health);
+
+	return 0;
+}
+
+static int pt516xx_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct pt516xx_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct pt516xx_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->lock);
+	pt516xx_init_dev(data);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(
+		dev, client->name, data, &pt516xx_chip_info, NULL);
+
+	if (pt516xx_init_debugfs(data))
+		dev_warn(dev, "Failed to register debugfs\n");
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id pt516xx_id[] = {
+	{ "pt5161l", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pt516xx_id);
+
+static const struct of_device_id __maybe_unused pt516xx_of_match[] = {
+	{ .compatible = "asteralabs,pt5161l" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pt516xx_of_match);
+
+static struct i2c_driver pt516xx_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "pt516xx",
+		.of_match_table = of_match_ptr(pt516xx_of_match),
+	},
+	.probe = pt516xx_probe,
+	.id_table = pt516xx_id,
+};
+
+module_i2c_driver(pt516xx_driver);
+
+static int __init pt516xx_core_init(void)
+{
+	pt516xx_debugfs_dir = debugfs_create_dir("pt516xx", NULL);
+	if (IS_ERR(pt516xx_debugfs_dir))
+		pt516xx_debugfs_dir = NULL;
+
+	return 0;
+}
+
+static void __exit pt516xx_core_exit(void)
+{
+	debugfs_remove_recursive(pt516xx_debugfs_dir);
+}
+
+module_init(pt516xx_core_init);
+module_exit(pt516xx_core_exit);
+
+MODULE_AUTHOR("Cosmo Chou <cosmo.chou@quantatw.com>");
+MODULE_DESCRIPTION("Hwmon driver for Astera Labs Aries PCIe retimer");
+MODULE_LICENSE("GPL");
-- 
2.34.1

