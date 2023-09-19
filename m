Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483727A5782
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjISCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjISCu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:50:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86371AB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:50:06 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4273762a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=himax-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695091800; x=1695696600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rVLXZ1kq1BD9knkeknmUmsVYKv/iVnnulDUJNrfnb0=;
        b=tIxWai3QPu8ol8HOwWeJh6OpU0dq9mLNxjIqMGcNUExrHvPAUnZC7RBwpy4O849Zwq
         tLlG6IHAxG28169UPTYWcqHfDn+ETOCtB67sAqXuOx86dMcXaw/a7AWgcd5uST0Jahqb
         JGRfsbQjLd8Fa5Fkbp9oCtP6fDaerMQsZrXcBJjhcfDEaX/bMaAC4PbnORxC3JmJB0UP
         E8PR4j91JEh0SgYYfMO0PkmO61OkCATI6H2K26U7pT9MrBzBCw6nc0jN1KOJMT0rK2SW
         08upvnUW/Ewr93nF7Ihe5/XlGwphZd/TE6tXZz0EPCERZ1+hG42DonJngn/no6dflPIu
         rdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695091800; x=1695696600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rVLXZ1kq1BD9knkeknmUmsVYKv/iVnnulDUJNrfnb0=;
        b=RCo50kRLl4FeHRZPuE8QXpcdJZsuMrhgFLv1uLdjk+fQTJEZ3EL0lwQ37+yE9b9XNU
         ywsqFVuQ3AHTDAH7mv9HYbdLMp0zjDkFQS0hJ7/rNiQjffKdDYru8JsyN0P/rvAVd5U+
         krbR7BoZrUw5mVHCiwvrOfDJZAyXAgJ3NBqrx60KPk4CYkn7dWDHjzMQ4ros/ngYTf9e
         172x/Cq5lG58gPGZqGb28dDFAFniJ6pmhdVVuPuVDHUmPyMpBVr/FN7eGN+QakwMcvOE
         hSObUuv/swPT/1MLABPciI9nuq+lcOb23+4k5c3yEC7B1qbZFmWi1M+AwNxDiQyzi4mq
         Dc3A==
X-Gm-Message-State: AOJu0YztIRw2NE801sbouYHPooc5lqTxTI2PMmPmnw9hIQ5XTHiFigpj
        YKOfHi3Ii6o9JxI4wfWb+UHZFQ==
X-Google-Smtp-Source: AGHT+IEd2vBGRYe8+QctxK+7rlH4BJqRQyMj7GkAyyUV35IjsCP9Lo1E6V0/U6PdMYgOn4ntXsOqIQ==
X-Received: by 2002:a05:6a20:3e20:b0:138:2fb8:6a14 with SMTP id m32-20020a056a203e2000b001382fb86a14mr7125525pzc.3.1695091799272;
        Mon, 18 Sep 2023 19:49:59 -0700 (PDT)
Received: from tylor-mini-server.net ([101.8.12.165])
        by smtp.gmail.com with ESMTPSA id i21-20020aa79095000000b0068fb8e18971sm7613042pfa.130.2023.09.18.19.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 19:49:58 -0700 (PDT)
From:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com, jingliang@chromium.org,
        hbarnor@chromium.org,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: [PATCH V2 2/2] HID: touchscreen: Add initial support for Himax HID-over-SPI
Date:   Tue, 19 Sep 2023 10:49:43 +0800
Message-Id: <20230919024943.3088916-3-tylor_yang@himax.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hx83102j is a TDDI IC (Touch with Display Driver). The
IC using SPI to transferring HID packet to host CPU. The IC also
report HID report descriptor for driver to register HID device.
The driver is designed as a framework for future expansion and
hx83102j is the first case. Each hx_spi_hid_hx8xxxxx modules are
mutual exclusive, it should be initiate one at a time.

This driver takes a position similar to i2c-hid, it initialize
and control the touch IC below and register HID to upper hid-core.
When touch ic report an interrupt, it receive the data from IC
and report as HID input to hid-core. Let hid-core dispatch input
to registered hid-protocol and report to related input sub-system.

This driver also provide advanced functions by hidraw interface:
- runtime firmware update
- debug functions, such as reg r/w
- self test for touch panel

Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
---
 MAINTAINERS                       |    1 +
 drivers/hid/Kconfig               |    2 +
 drivers/hid/Makefile              |    2 +
 drivers/hid/hx-hid/Kconfig        |   55 +
 drivers/hid/hx-hid/Makefile       |   35 +
 drivers/hid/hx-hid/hx_acpi.c      |   96 +
 drivers/hid/hx-hid/hx_core.c      | 1626 ++++++++++++++
 drivers/hid/hx-hid/hx_core.h      |  487 +++++
 drivers/hid/hx-hid/hx_hid.c       |  757 +++++++
 drivers/hid/hx-hid/hx_hid.h       |   96 +
 drivers/hid/hx-hid/hx_ic_83102j.c |  345 +++
 drivers/hid/hx-hid/hx_ic_83102j.h |   42 +
 drivers/hid/hx-hid/hx_ic_core.c   | 3260 +++++++++++++++++++++++++++++
 drivers/hid/hx-hid/hx_ic_core.h   |  792 +++++++
 drivers/hid/hx-hid/hx_inspect.c   |  652 ++++++
 drivers/hid/hx-hid/hx_inspect.h   |  104 +
 drivers/hid/hx-hid/hx_of.c        |  171 ++
 drivers/hid/hx-hid/hx_plat.c      |  480 +++++
 drivers/hid/hx-hid/hx_plat.h      |   30 +
 19 files changed, 9033 insertions(+)
 create mode 100644 drivers/hid/hx-hid/Kconfig
 create mode 100644 drivers/hid/hx-hid/Makefile
 create mode 100644 drivers/hid/hx-hid/hx_acpi.c
 create mode 100644 drivers/hid/hx-hid/hx_core.c
 create mode 100644 drivers/hid/hx-hid/hx_core.h
 create mode 100644 drivers/hid/hx-hid/hx_hid.c
 create mode 100644 drivers/hid/hx-hid/hx_hid.h
 create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.c
 create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.h
 create mode 100644 drivers/hid/hx-hid/hx_ic_core.c
 create mode 100644 drivers/hid/hx-hid/hx_ic_core.h
 create mode 100644 drivers/hid/hx-hid/hx_inspect.c
 create mode 100644 drivers/hid/hx-hid/hx_inspect.h
 create mode 100644 drivers/hid/hx-hid/hx_of.c
 create mode 100644 drivers/hid/hx-hid/hx_plat.c
 create mode 100644 drivers/hid/hx-hid/hx_plat.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 452701261bec..db96c6ece1c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9328,6 +9328,7 @@ M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
 L:	linux-input@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
+F:	drivers/hid/hx-hid/
 
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 0cea301cc9a9..e5beac24db81 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1343,4 +1343,6 @@ source "drivers/hid/amd-sfh-hid/Kconfig"
 
 source "drivers/hid/surface-hid/Kconfig"
 
+source "drivers/hid/hx-hid/Kconfig"
+
 endif # HID_SUPPORT
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8a06d0f840bc..7b948a90213a 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -169,3 +169,5 @@ obj-$(INTEL_ISH_FIRMWARE_DOWNLOADER)	+= intel-ish-hid/
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
 
 obj-$(CONFIG_SURFACE_HID_CORE)  += surface-hid/
+
+obj-$(CONFIG_HX_HID)		+= hx-hid/
diff --git a/drivers/hid/hx-hid/Kconfig b/drivers/hid/hx-hid/Kconfig
new file mode 100644
index 000000000000..9a6050f36ad0
--- /dev/null
+++ b/drivers/hid/hx-hid/Kconfig
@@ -0,0 +1,55 @@
+config HX_HID
+	tristate "Himax HID simulator for SPI"
+	default n
+	depends on SPI && INPUT
+	select HID
+	help
+	  Say Y here if you have Himax touch chipset,
+	  which is connected to your computer via SPI
+	  and you want to use it as a HID device.
+	  Revalent Firmware is required, whether from
+	  Firmware binary or in IC's flash memory.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.
+
+config HX_HID_IC_83102J
+	bool "Himax IC_83012J for Himax HID simulator"
+	default y
+	depends on HX_HID
+	help
+	  Say Y here if you have Himax touch IC HX83102J,
+	  which is connected to your computer via SPI
+	  and you want to use it as a HID device. Please
+	  note only one type of IC can be initiated at
+	  the same time.
+
+	  If unsure, say Y.
+
+config HX_HID_HEATMAP
+	bool "Transferring HEATMAP after coordinate data"
+	default y
+	depends on HX_HID
+	help
+	  Say Y here if you need heatmap after coord
+	  data. The data can be acquired from hidraw
+	  interface. The firmware bundled need to
+	  have the ability to send heatmap to make
+	  this driver act normally. When enabled,
+	  all HX_HID_IC modules are effected.
+
+	  If unsure, say Y.
+
+config HX_HID_HAS_FLASH
+	bool "Himax IC has flash memory"
+	default n
+	depends on HX_HID
+	help
+	  Say Y here if you have Himax touch IC with
+	  flash memory, which is connected to your
+	  computer via SPI and you want to use it
+	  as a HID device. Please note this is a global
+	  option, which means all modules will be effected.
+
+	  If unsure, say N.
diff --git a/drivers/hid/hx-hid/Makefile b/drivers/hid/hx-hid/Makefile
new file mode 100644
index 000000000000..243a89282a4f
--- /dev/null
+++ b/drivers/hid/hx-hid/Makefile
@@ -0,0 +1,35 @@
+ifneq ($(filter m, $(CONFIG_HX_HID)),)
+  ccflags-y += -D__HIMAX_MOD__
+endif
+
+ifneq ($(CONFIG_HX_HID_HEATMAP),)
+	ccflags-y += -DHX_HEATMAP_EN
+endif
+
+ifneq ($(KERNELRELEASE),)
+# kbuild part of makefile
+ifneq ($(CONFIG_HX_HID_IC_83102J),)
+	hx_spi_hid_hx83102j-objs := hx_ic_83102j.o
+	hx_spi_hid_hx83102j-objs += hx_plat.o \
+		hx_ic_core.o \
+		hx_core.o \
+		hx_hid.o \
+		hx_inspect.o
+ifneq ($(CONFIG_OF),)
+	hx_spi_hid_hx83102j-objs += hx_of.o
+else ifneq ($(CONFIG_ACPI),)
+	hx_spi_hid_hx83102j-objs += hx_acpi.o
+endif
+
+	obj-$(CONFIG_HX_HID) += hx_spi_hid_hx83102j.o
+endif
+
+else
+# normal makefile
+KDIR ?= /lib/modules/`uname -r`/build
+
+default:
+	$(MAKE) -C $(KDIR) M=$$PWD
+clean:
+	@rm *.o *.mod *.mod.c .*.cmd Module.symvers *.a *.ko modules.order
+endif
diff --git a/drivers/hid/hx-hid/hx_acpi.c b/drivers/hid/hx-hid/hx_acpi.c
new file mode 100644
index 000000000000..08ad9c02fa4c
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_acpi.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+
+int himax_parse_acpi(struct device *dev,
+		     struct himax_platform_data *pdata)
+{
+	int ret = 0;
+	struct gpio_desc *desc;
+	const u32 interrupt_pin_idx = 0;
+	// const u32 reset_pin_idx = 1;
+	// const u32 power3v3_pin_idx = 2;
+	const char *interrupt_pin_dsd_name = "irq"; // to name "irq-gpios"
+	const char *reset_pin_dsd_name = "reset"; // to name "reset-gpios"
+	const char *power3v3_pin_dsd_name = "power"; // to name "power-gpios"
+
+	D("Entered");
+	if (!dev || !pdata) {
+		E("ACPI: dev or pdata is NULL");
+		ret = -EINVAL;
+		goto END;
+	}
+	desc = gpiod_get(dev, interrupt_pin_dsd_name, GPIOD_IN);
+	if (IS_ERR(desc)) {
+		E("ACPI: gpiod_get(%s) failed : %ld", interrupt_pin_dsd_name,
+		  PTR_ERR(desc));
+		I("Try to get by index");
+		desc = gpiod_get_index(dev, NULL, interrupt_pin_idx, GPIOD_IN);
+		if (IS_ERR(desc)) {
+			E("ACPI: gpiod_get_index(%d) failed : %ld", interrupt_pin_idx,
+			  PTR_ERR(desc));
+			ret = -EINVAL;
+			goto END;
+		} else if (desc_to_gpio(desc) == 0) {
+			E("ACPI: gpio_irq value is not valid : %d",
+			  desc_to_gpio(desc));
+			ret = -EINVAL;
+			goto END;
+		} else {
+			pdata->gpio_irq = desc_to_gpio(desc);
+		}
+	} else if (desc_to_gpio(desc) == 0) {
+		E("ACPI: gpio_irq value is not valid : %d", desc_to_gpio(desc));
+		ret = -EINVAL;
+		goto END;
+	} else {
+		pdata->gpio_irq = desc_to_gpio(desc);
+	}
+
+	desc = gpiod_get(dev, reset_pin_dsd_name, GPIOD_OUT_LOW);
+	if (IS_ERR(desc)) {
+		E("ACPI: gpiod_get(%s) failed : %ld", reset_pin_dsd_name,
+		  PTR_ERR(desc));
+		ret = -EINVAL;
+		goto END;
+	} else if (desc_to_gpio(desc) == 0) {
+		E("ACPI: gpio-reset value is not valid : %d",
+		  desc_to_gpio(desc));
+		ret = -EINVAL;
+		goto END;
+	} else {
+		pdata->gpio_reset = desc_to_gpio(desc);
+	}
+
+	desc = gpiod_get(dev, power3v3_pin_dsd_name, GPIOD_OUT_HIGH);
+	if (IS_ERR(desc)) {
+		E("ACPI: gpiod_get(%s) failed : %ld", power3v3_pin_dsd_name,
+		  PTR_ERR(desc));
+		pdata->gpio_3v3_en = -1;
+	} else if (desc_to_gpio(desc) == 0) {
+		E("ACPI: gpio_3v3_en value is not valid : %d",
+		  desc_to_gpio(desc));
+		pdata->gpio_3v3_en = -1;
+	} else {
+		pdata->gpio_3v3_en = desc_to_gpio(desc);
+	}
+
+	I("[ACPI]irq gpio %d, reset gpio %d, 3v3_en gpio %d",
+	  pdata->gpio_irq, pdata->gpio_reset, pdata->gpio_3v3_en);
+
+END:
+	return ret;
+}
diff --git a/drivers/hid/hx-hid/hx_core.c b/drivers/hid/hx-hid/hx_core.c
new file mode 100644
index 000000000000..fe16336b262a
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_core.c
@@ -0,0 +1,1626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_ic_core.h"
+#include "hx_plat.h"
+#include "hx_hid.h"
+#include "hx_inspect.h"
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/errno.h>
+
+bool debug_flag;
+struct himax_ts_data *g_himax_ts;
+struct himax_core_fp g_core_fp;
+
+#define FW_EXT_NAME(FWNAME)	FWNAME ".bin"
+char *g_fw_boot_upgrade_name = FW_EXT_NAME(BOOT_UPGRADE_FWNAME);
+char *g_fw_mp_upgrade_name = MPAP_FWNAME;
+
+#if !defined(__HIMAX_MOD__)
+/* calculate time diff and return as milliseconds */
+static unsigned int time_diff(struct time_var *start, struct time_var *end)
+{
+	unsigned int diff = 0;
+
+	diff = (end->tv_sec - start->tv_sec) * 1000;
+	diff += (end->time_var_fine - start->time_var_fine) / time_var_fine_unit;
+
+	return diff;
+}
+#endif
+
+/* start himax_touch_get */
+static int himax_touch_get(struct himax_ts_data *ts, u8 *buf, int ts_path)
+{
+	u32 read_size = 0;
+	int ts_status = 0;
+
+	switch (ts_path) {
+	/*normal*/
+	case HX_REPORT_COORD:
+	case HX_REPORT_COORD_RAWDATA:
+		read_size = ts->touch_all_size;
+		break;
+	default:
+		break;
+	}
+
+	if (read_size == 0) {
+		E("Read size fault!");
+		ts_status = HX_TS_GET_DATA_FAIL;
+	} else {
+		if (!g_core_fp.fp_read_event_stack(ts, buf, read_size)) {
+			E("can't read data from chip!");
+			ts_status = HX_TS_GET_DATA_FAIL;
+		}
+	}
+
+	return ts_status;
+}
+
+/* start error_control*/
+static int himax_checksum_cal(struct himax_ts_data *ts, u8 *buf, int ts_path)
+{
+	u16 check_sum_cal = 0;
+	s32	i = 0;
+	int length = 0;
+	int zero_cnt = 0;
+	int ret_val = HX_TS_NORMAL_END;
+
+	/* Normal */
+	switch (ts_path) {
+	case HX_REPORT_COORD:
+	case HX_REPORT_COORD_RAWDATA:
+		length = ts->touch_info_size;
+		break;
+	default:
+		I("Neither Normal Nor SMWP error!");
+		ret_val = HX_PATH_FAIL;
+		goto END_FUNCTION;
+	}
+
+	for (i = 0; i < length; i++) {
+		check_sum_cal += buf[i];
+		if (buf[i] == 0x00)
+			zero_cnt++;
+	}
+
+	if (check_sum_cal % 0x100 != 0 && ts_path != HX_REPORT_COORD &&
+	    ts_path != HX_REPORT_COORD_RAWDATA) {
+		I("point data_checksum not match check_sum_cal: 0x%02X",
+		  check_sum_cal);
+		ret_val = HX_CHKSUM_FAIL;
+	} else if (zero_cnt == length) {
+		if (ts->use_irq)
+			I("[HIMAX TP MSG] All Zero event");
+
+		ret_val = HX_CHKSUM_FAIL;
+	} else {
+		if (ts_path == HX_REPORT_COORD ||
+		    ts_path == HX_REPORT_COORD_RAWDATA) {
+			ret_val = HX_REPORT_DATA;
+			goto END_FUNCTION;
+		}
+		/*Need to clear event stack here*/
+		g_core_fp.fp_read_event_stack(ts, buf,
+			(HX_STACK_ORG_LEN -	ts->touch_info_size));
+	}
+
+END_FUNCTION:
+	return ret_val;
+}
+
+static void himax_excp_hw_reset(struct himax_ts_data *ts)
+{
+	int result = 0;
+
+	I("START EXCEPTION Reset");
+	hx_hid_remove(ts);
+	if (!ts->ic_data->has_flash) {
+		result = g_core_fp.fp_0f_op_file_dirly(g_fw_boot_upgrade_name, ts);
+		if (result) {
+			E("update FW fail, code[%d]!!", result);
+		} else {
+			I("update FW success!!");
+			hx_hid_probe(ts);
+		}
+	} else {
+		g_core_fp.fp_excp_ic_reset(ts);
+		hx_hid_probe(ts);
+	}
+	I("END EXCEPTION Reset");
+}
+
+#if defined(HW_ED_EXCP_EVENT)
+static int himax_ts_event_check(struct himax_ts_data *ts,
+				const u8 *buf, int ts_path, int ts_status)
+{
+	u32 hx_EB_event = 0;
+	u32 hx_EC_event = 0;
+	u32 hx_EE_event = 0;
+	u32 hx_ED_event = 0;
+	u32 hx_excp_event = 0;
+	int shaking_ret = 0;
+
+	u32 i = 0;
+	u32 length = 0;
+	int ret_val = ts_status;
+
+	/* Normal */
+	switch (ts_path) {
+	case HX_REPORT_COORD:
+		length = ts->touch_info_size;
+		break;
+	case HX_REPORT_COORD_RAWDATA:
+		length = ts->touch_info_size;
+		break;
+	default:
+		I("Neither Normal Nor SMWP error!");
+		ret_val = HX_PATH_FAIL;
+		goto END_FUNCTION;
+	}
+
+	if (ts_path == HX_REPORT_COORD || ts_path == HX_REPORT_COORD_RAWDATA) {
+		for (i = 0; i < length; i++) {
+			/* case 1 EXCEEPTION recovery flow */
+			if (buf[i] == 0xEB) {
+				hx_EB_event++;
+			} else if (buf[i] == 0xEC) {
+				hx_EC_event++;
+			} else if (buf[i] == 0xEE) {
+				hx_EE_event++;
+			/* case 2 EXCEPTION recovery flow-Disable */
+			} else if (buf[i] == 0xED) {
+				hx_ED_event++;
+			} else {
+				ts->excp_zero_event_count = 0;
+				break;
+			}
+		}
+	}
+
+	if (hx_EB_event == length) {
+		hx_excp_event = length;
+		ts->excp_eb_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEB.");
+	} else if (hx_EC_event == length) {
+		hx_excp_event = length;
+		ts->excp_ec_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEC.");
+	} else if (hx_EE_event == length) {
+		hx_excp_event = length;
+		ts->excp_ee_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEE.");
+	} else if (hx_ED_event == length) {
+		g_core_fp.fp_0f_reload_to_active();
+	}
+
+	if ((hx_excp_event == length || hx_ED_event == length) &&
+	    ts->excp_reset_active == 0) {
+		shaking_ret = g_core_fp.fp_ic_excp_recovery(ts,
+			hx_excp_event, hx_ED_event, length);
+
+		if (shaking_ret == HX_EXCP_EVENT) {
+			g_core_fp.fp_read_FW_status();
+			himax_excp_hw_reset(ts);
+			ret_val = HX_EXCP_EVENT;
+		} else if (shaking_ret == HX_ZERO_EVENT_COUNT) {
+			g_core_fp.fp_read_FW_status();
+			ret_val = HX_ZERO_EVENT_COUNT;
+		} else {
+			I("IC is running. Nothing to be done!");
+			ret_val = HX_IC_RUNNING;
+		}
+
+	/* drop 1st interrupts after chip reset */
+	} else if (ts->excp_reset_active) {
+		ts->excp_reset_active = 0;
+		I("Skip by excp_reset_active.");
+		ret_val = HX_EXCP_REC_OK;
+	}
+
+END_FUNCTION:
+	if (g_ts_dbg != 0)
+		I("END, ret_val=%d!", ret_val);
+
+	return ret_val;
+}
+#else
+static int himax_ts_event_check(struct himax_ts_data *ts,
+				const u8 *buf, int ts_path)
+{
+	u32 hx_EB_event = 0;
+	u32 hx_EC_event = 0;
+	u32 hx_ED_event = 0;
+	u32 hx_excp_event = 0;
+	u32 hx_zero_event = 0;
+	int shaking_ret = 0;
+
+	u32 i = 0;
+	u32 length = 0;
+	int ret_val = 0;
+
+	/* Normal */
+	switch (ts_path) {
+	case HX_REPORT_COORD:
+		length = ts->touch_info_size;
+		break;
+	case HX_REPORT_COORD_RAWDATA:
+		length = ts->touch_info_size;
+		break;
+	default:
+		I("Neither Normal Nor SMWP error!");
+		ret_val = HX_PATH_FAIL;
+		goto END_FUNCTION;
+	}
+
+	if (ts_path == HX_REPORT_COORD || ts_path == HX_REPORT_COORD_RAWDATA) {
+		for (i = 0; i < length; i++) {
+			/* case 1 EXCEEPTION recovery flow */
+			if (buf[i] == 0xEB) {
+				hx_EB_event++;
+			} else if (buf[i] == 0xEC) {
+				hx_EC_event++;
+			} else if (buf[i] == 0xED) {
+				hx_ED_event++;
+
+			/* case 2 EXCEPTION recovery flow-Disable */
+			} else if (buf[i] == 0x00) {
+				hx_zero_event++;
+			} else {
+				ts->excp_zero_event_count = 0;
+				break;
+			}
+		}
+	}
+
+	if (hx_EB_event == length) {
+		hx_excp_event = length;
+		ts->excp_eb_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEB.");
+	} else if (hx_EC_event == length) {
+		hx_excp_event = length;
+		ts->excp_ec_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xEC.");
+	} else if (hx_ED_event == length) {
+		hx_excp_event = length;
+		ts->excp_ed_event_flag++;
+		I("[HIMAX TP MSG]: EXCEPTION event checked - ALL 0xED.");
+	}
+
+	if ((hx_excp_event == length || hx_zero_event == length) &&
+	    ts->excp_reset_active == 0) {
+		shaking_ret = g_core_fp.fp_ic_excp_recovery(ts,
+			hx_excp_event, hx_zero_event, length);
+
+		if (shaking_ret == HX_EXCP_EVENT) {
+			g_core_fp.fp_read_FW_status(ts);
+			himax_excp_hw_reset(ts);
+			ret_val = HX_EXCP_EVENT;
+		} else if (shaking_ret == HX_ZERO_EVENT_COUNT) {
+			g_core_fp.fp_read_FW_status(ts);
+			ret_val = HX_ZERO_EVENT_COUNT;
+		} else {
+			I("IC is running. Nothing to be done!");
+			ret_val = HX_IC_RUNNING;
+		}
+
+	/* drop 1st interrupts after chip reset */
+	} else if (ts->excp_reset_active) {
+		ts->excp_reset_active = 0;
+		I("Skip by excp_reset_active.");
+		ret_val = HX_EXCP_REC_OK;
+	}
+
+END_FUNCTION:
+
+	return ret_val;
+}
+#endif
+
+static int himax_err_ctrl(struct himax_ts_data *ts,
+			  u8 *buf, int ts_path)
+{
+	int ts_status = HX_CHKSUM_FAIL;
+
+	ts_status = himax_checksum_cal(ts, buf, ts_path);
+	if (ts_status == HX_CHKSUM_FAIL) {
+		goto CHK_FAIL;
+	} else {
+		/* continuous N times record, not total N times. */
+		ts->excp_zero_event_count = 0;
+		goto END_FUNCTION;
+	}
+
+CHK_FAIL:
+	ts_status = himax_ts_event_check(ts, buf, ts_path);
+END_FUNCTION:
+	return ts_status;
+}
+
+/* end error_control*/
+
+#if defined(HX_HEATMAP_EN)
+static void heatmap_decompress_12BITS(struct himax_ts_data *ts,
+				      u8 *in_buf, u8 *target)
+{
+	int i = 0, in_offset = 0;
+	u8 *in_ptr = NULL;
+	u16 *target_ptr = NULL;
+
+	target[0] = in_buf[0];
+	memcpy(&target[1], &in_buf[1], HEAT_MAP_INFO_SZ);
+	for (i = 0, in_offset = HEAT_MAP_INFO_SZ + 1;
+		i < ts->ic_data->HX_RX_NUM * ts->ic_data->HX_TX_NUM; i += 2) {
+		in_ptr = &in_buf[in_offset + i * 3 / 2];
+		target_ptr = (u16 *)&target[HEAT_MAP_INFO_SZ + 1 + i * 2];
+		*target_ptr = (u16)in_ptr[0] | ((u16)(in_ptr[2] & 0xF0) << 4);
+		*(target_ptr + 1) = (u16)(in_ptr[2] & 0x0F) << 8 | (u16)in_ptr[1];
+	}
+}
+#endif
+
+static int himax_ts_operation(struct himax_ts_data *ts,
+			      int ts_path)
+{
+	int ts_status = HX_TS_NORMAL_END;
+	int ret = 0;
+	u32 offset = 0;
+
+	memset(ts->xfer_buff,
+	       0x00,
+		ts->touch_all_size * sizeof(u8));
+	ts_status = himax_touch_get(ts, ts->xfer_buff, ts_path);
+	if (ts_status == HX_TS_GET_DATA_FAIL)
+		goto END_FUNCTION;
+
+	ts_status = himax_err_ctrl(ts, ts->xfer_buff, ts_path);
+	if (!(ts_status == HX_REPORT_DATA || ts_status == HX_TS_NORMAL_END))
+		goto END_FUNCTION;
+	if (ts->hid_probe) {
+		offset = 0;
+		if (!ts->hid_req_cfg.input_RD_de) {
+			ret = hx_hid_report(ts, ts->xfer_buff + offset + HID_REPORT_HDR_SZ,
+					    ts->hid_desc.max_input_length - HID_REPORT_HDR_SZ);
+		}
+		offset += ts->hid_desc.max_input_length;
+		if (ts->ic_data->HX_STYLUS_FUNC) {
+			if (!ts->hid_req_cfg.input_RD_de) {
+				ret += hx_hid_report(ts,
+					ts->xfer_buff + offset + HID_REPORT_HDR_SZ,
+					ts->hid_desc.max_input_length - HID_REPORT_HDR_SZ);
+			}
+			offset += ts->hid_desc.max_input_length;
+		}
+		#if defined(HX_HEATMAP_EN)
+		if (!ts->ic_data->enc16bits)
+			heatmap_decompress_12BITS(ts,
+						  ts->xfer_buff + offset + HID_REPORT_HDR_SZ,
+						  ts->hx_heatmap_buf);
+		else
+			memcpy(ts->hx_heatmap_buf,
+			       ts->xfer_buff + offset + HID_REPORT_HDR_SZ,
+			       ts->heatmap_data_size + HEAT_MAP_INFO_SZ + 1);
+
+		ret += hx_hid_report(ts, ts->hx_heatmap_buf,
+			(ts->ic_data->HX_RX_NUM * ts->ic_data->HX_TX_NUM * 2) +
+			HEAT_MAP_INFO_SZ + 1);
+		#endif
+	}
+
+	if (ret != 0)
+		ts_status = HX_TS_GET_DATA_FAIL;
+
+END_FUNCTION:
+	return ts_status;
+}
+
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew)
+{
+	/*u32 connect_status = 0;*/
+	u8 connect_status = 0;
+
+	connect_status = ts->latest_power_status;
+
+	/* I("Touch: cable status=%d, cable_config=%p, usb_connected=%d\n",*/
+	/*		connect_status, ts->cable_config, ts->usb_connected); */
+	if (ts->cable_config) {
+		if (connect_status != ts->usb_connected || force_renew) {
+			if (connect_status) {
+				ts->cable_config[1] = 0x01;
+				ts->usb_connected = 0x01;
+			} else {
+				ts->cable_config[1] = 0x00;
+				ts->usb_connected = 0x00;
+			}
+
+			g_core_fp.fp_usb_detect_set(ts, ts->cable_config);
+			I("Cable status change: 0x%2.2X",
+			  ts->usb_connected);
+		}
+	}
+}
+
+void himax_ts_work(struct himax_ts_data *ts)
+{
+	int ts_status = HX_TS_NORMAL_END;
+	int ts_path = 0;
+
+	if (ts->notouch_frame > 0) {
+		ts->notouch_frame--;
+		return;
+	}
+
+	himax_cable_detect_func(ts, false);
+
+#if defined(HX_HEATMAP_EN)
+	ts_path = HX_REPORT_COORD_RAWDATA;
+#else
+	ts_path = HX_REPORT_COORD;
+#endif
+	ts_status = himax_ts_operation(ts, ts_path);
+	if (ts_status == HX_TS_GET_DATA_FAIL) {
+		I("Now reset the Touch chip.");
+		g_core_fp.fp_ic_reset(ts, false, true);
+		if (!ts->ic_data->has_flash) {
+			if (g_core_fp.fp_0f_reload_to_active)
+				g_core_fp.fp_0f_reload_to_active(ts);
+		}
+	}
+}
+
+/*end ts_work*/
+enum hrtimer_restart himax_ts_timer_func(struct hrtimer *timer)
+{
+	struct himax_ts_data *ts;
+
+	ts = container_of(timer, struct himax_ts_data, timer);
+	queue_work(ts->himax_wq, &ts->work);
+	hrtimer_start(&ts->timer, ktime_set(0, 12500000), HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+
+static int hx_chk_flash_sts(struct himax_ts_data *ts, u32 size)
+{
+	int rslt = 0;
+
+	I("Entering, %d", size);
+
+	rslt = (!g_core_fp.fp_calculate_checksum(ts, false, size));
+	/*avoid the FW is full of zero*/
+	rslt |= g_core_fp.fp_flash_lastdata_check(ts, size);
+
+	return rslt;
+}
+
+static int i_get_FW(struct himax_ts_data *ts)
+{
+	int ret = -1;
+	int result = NO_ERR;
+
+	if (ts->hid_req_cfg.fw) {
+		ts->hxfw = ts->hid_req_cfg.fw;
+		I("get fw from hid_req_cfg");
+		result = NO_ERR;
+		goto OUT;
+	}
+
+	ret = request_firmware(&ts->hxfw, g_fw_boot_upgrade_name, ts->dev);
+	I("request file %s finished", g_fw_boot_upgrade_name);
+	if (ret < 0) {
+		E("%d: error code = %d", __LINE__, ret);
+		result = OPEN_FILE_FAIL;
+	}
+
+OUT:
+	return result;
+}
+
+static int i_update_FW(struct himax_ts_data *ts)
+{
+	int upgrade_times = 0;
+	s8 ret = 0;
+	s8 result = 0;
+
+update_retry:
+	if (!ts->ic_data->has_flash) {
+		ret = g_core_fp.fp_firmware_update_0f(ts->hxfw, ts, 0);
+		if (ret != 0) {
+			upgrade_times++;
+			E("TP upgrade error, upgrade_times = %d",
+			  upgrade_times);
+
+			if (upgrade_times < 3)
+				goto update_retry;
+			else
+				result = -1;
+
+		} else {
+			result = 1;/*upgrade success*/
+			I("TP upgrade OK");
+		}
+	} else {
+		if (ts->hxfw->size == FW_SIZE_32k)
+			ret = g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_32k(ts,
+				(unsigned char *)ts->hxfw->data, ts->hxfw->size, false);
+		else if (ts->hxfw->size == FW_SIZE_60k)
+			ret = g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_60k(ts,
+				(unsigned char *)ts->hxfw->data, ts->hxfw->size, false);
+		else if (ts->hxfw->size == FW_SIZE_64k)
+			ret = g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_64k(ts,
+				(unsigned char *)ts->hxfw->data, ts->hxfw->size, false);
+		else if (ts->hxfw->size == FW_SIZE_124k)
+			ret = g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_124k(ts,
+				(unsigned char *)ts->hxfw->data, ts->hxfw->size, false);
+		else if (ts->hxfw->size == FW_SIZE_128k)
+			ret = g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_128k(ts,
+				(unsigned char *)ts->hxfw->data, ts->hxfw->size, false);
+		else if (ts->hxfw->size == FW_SIZE_255k)
+			ret = g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_255k(ts,
+				(unsigned char *)ts->hxfw->data, ts->hxfw->size, false);
+
+		if (ret == 0) {
+			upgrade_times++;
+			E("TP upgrade error, upgrade_times = %d",
+			  upgrade_times);
+
+			if (upgrade_times < 3)
+				goto update_retry;
+			else
+				result = -1;
+
+		} else {
+			result = 1;/*upgrade success*/
+			I("TP upgrade OK");
+		}
+	}
+
+	return result;
+}
+
+static int hx_hid_rd_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+	const u32 x_num = ts->ic_data->HX_RX_NUM;
+	const u32 y_num = ts->ic_data->HX_TX_NUM;
+	unsigned int raw_data_sz = (x_num * y_num + x_num + y_num) * 2 + 4;
+	u32 rd_sz = 0;
+
+	if (ts->hid_req_cfg.input_RD_de == 0)
+		rd_sz = ts->hid_desc.report_desc_length + host_ext_report_desc_sz;
+	else
+		rd_sz = host_heatmap_report_desc_sz + host_ext_report_desc_sz;
+
+	if (FLASH_VER_GET_VAL(addr_hid_rd_desc) != 0) {
+		if (ts->hid_rd_data.rd_data &&
+		    rd_sz != ts->hid_rd_data.rd_length) {
+			kfree(ts->hid_rd_data.rd_data);
+			ts->hid_rd_data.rd_data = NULL;
+		}
+
+		if (!ts->hid_rd_data.rd_data)
+			ts->hid_rd_data.rd_data = kzalloc(rd_sz, GFP_KERNEL);
+
+		if (ts->hid_rd_data.rd_data) {
+			if (ts->hid_req_cfg.input_RD_de == 0) {
+				memcpy((void *)ts->hid_rd_data.rd_data,
+				       &ts->hxfw->data[FLASH_VER_GET_VAL(addr_hid_rd_desc)],
+				       ts->hid_desc.report_desc_length);
+				ts->hid_rd_data.rd_length = ts->hid_desc.report_desc_length;
+			} else {
+				memcpy((void *)ts->hid_rd_data.rd_data,
+				       g_heatmap_rd.host_report_descriptor,
+				       host_heatmap_report_desc_sz);
+				ts->hid_rd_data.rd_length = host_heatmap_report_desc_sz;
+			}
+			I("Re-assign HID DIAG size: original = %d, new = %d",
+			  le16_to_cpu(g_host_ext_rd.rd_struct.monitor.report_cnt),
+			  raw_data_sz);
+			g_host_ext_rd.rd_struct.monitor.report_cnt = cpu_to_le16(raw_data_sz);
+			memcpy((void *)(ts->hid_rd_data.rd_data + ts->hid_rd_data.rd_length),
+			       &g_host_ext_rd.host_report_descriptor, host_ext_report_desc_sz);
+			ts->hid_rd_data.rd_length += host_ext_report_desc_sz;
+		} else {
+			E("hid rd data alloc fail");
+			ret = -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static void hx_hid_register(struct himax_ts_data *ts)
+{
+	if (ts->hid_probe) {
+		hid_destroy_device(ts->hid);
+		ts->hid = NULL;
+		ts->hid_probe = false;
+	}
+
+	if (hx_hid_probe(ts) != 0) {
+		E("hid probe fail");
+		ts->hid_probe = false;
+	} else {
+		I("hid probe success");
+		ts->hid_probe = true;
+	}
+}
+
+static int hx_hid_report_data_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->touch_info_size = ts->hid_desc.max_input_length;
+	I("base touch_info_size = %d", ts->touch_info_size);
+	if (ts->ic_data->HX_STYLUS_FUNC) {
+		ts->touch_info_size += ts->hid_desc.max_input_length;
+		I("include stylus touch_info_size = %d", ts->touch_info_size);
+	}
+#if defined(HX_HEATMAP_EN)
+	ts->touch_info_size += HEAT_MAP_HEADER_SZ;
+	ts->touch_info_size += HEAT_MAP_INFO_SZ;
+	if (!ts->ic_data->enc16bits)
+		ts->heatmap_data_size =
+			(ts->ic_data->HX_RX_NUM * ts->ic_data->HX_TX_NUM * 3) / 2;
+	else
+		ts->heatmap_data_size =
+			(ts->ic_data->HX_RX_NUM * ts->ic_data->HX_TX_NUM * 2);
+	ts->touch_info_size += ts->heatmap_data_size;
+	I("include heatmap touch_info_size = %d", ts->touch_info_size);
+#endif
+	ts->touch_all_size = ts->touch_info_size;
+
+	if (himax_report_data_init(ts) != 0) {
+		E("report data init fail");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+
+static void himax_boot_upgrade(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_boot_upgrade.work);
+	int fw_sts = -1;
+	bool upgrade_result = false;
+	bool fw_load_status = false;
+
+	I("Entering");
+	ts->ic_boot_done = false;
+	if (!ts->ic_data->has_flash) {
+		ts->boot_upgrade_flag = true;
+	} else {
+		if (hx_chk_flash_sts(ts, ts->ic_data->flash_size) == 1) {
+			E("check flash fail, please upgrade FW");
+			goto END;
+		} else {
+			g_core_fp.fp_reload_disable(ts, 0);
+			g_core_fp.fp_power_on_init(ts);
+			g_core_fp.fp_read_FW_ver(ts);
+			g_core_fp.fp_tp_info_check(ts);
+		}
+	}
+
+	if (!ts->ic_data->has_flash) {
+		fw_sts = i_get_FW(ts);
+		if (fw_sts < NO_ERR)
+			goto err_get_fw_failed;
+
+		fw_load_status = g_core_fp.fp_bin_desc_get
+			((unsigned char *)ts->hxfw->data, ts, HX1K);
+
+		if (ts->boot_upgrade_flag) {
+			if (i_update_FW(ts) <= 0) {
+				E("Update FW fail");
+				goto err_update_fw_failed;
+			} else {
+				I("Update FW success");
+				if (!ts->has_alg_overlay) {
+					g_core_fp.fp_reload_disable(ts, 0);
+					g_core_fp.fp_power_on_init(ts);
+				}
+				// preload hid descriptors
+				if (FLASH_VER_GET_VAL(addr_hid_desc) != 0) {
+					memcpy(&ts->hid_desc,
+					       &ts->hxfw->data[FLASH_VER_GET_VAL(addr_hid_desc)],
+					       sizeof(struct hx_hid_desc_t));
+					ts->hid_desc.desc_length =
+						le16_to_cpu(ts->hid_desc.desc_length);
+					ts->hid_desc.bcd_version =
+						le16_to_cpu(ts->hid_desc.bcd_version);
+					ts->hid_desc.report_desc_length =
+						le16_to_cpu(ts->hid_desc.report_desc_length);
+					ts->hid_desc.max_input_length =
+						le16_to_cpu(ts->hid_desc.max_input_length);
+					ts->hid_desc.max_output_length =
+						le16_to_cpu(ts->hid_desc.max_output_length);
+					ts->hid_desc.max_fragment_length =
+						le16_to_cpu(ts->hid_desc.max_fragment_length);
+					ts->hid_desc.vendor_id =
+						le16_to_cpu(ts->hid_desc.vendor_id);
+					ts->hid_desc.product_id =
+						le16_to_cpu(ts->hid_desc.product_id);
+					ts->hid_desc.version_id =
+						le16_to_cpu(ts->hid_desc.version_id);
+					ts->hid_desc.flags =
+						le16_to_cpu(ts->hid_desc.flags);
+				}
+				g_core_fp.fp_tp_info_check(ts);
+				g_core_fp.fp_read_FW_ver(ts);
+				if (ts->pdata->pid != 0) {
+					if (ts->pdata->pid != ts->hid_desc.product_id) {
+						E("pid mismatch, dtsi pid = 0x%x, fw pid = 0x%x",
+						  ts->pdata->pid, ts->hid_desc.product_id);
+						goto err_pid_match_failed;
+					} else {
+						I("pid match, dtsi pid = 0x%x, fw pid = 0x%x",
+						  ts->pdata->pid, ts->hid_desc.product_id);
+					}
+				}
+				if (hx_hid_rd_init(ts) != 0) {
+					E("hid rd init fail");
+					goto err_hid_rd_init_failed;
+				} else {
+					I("hid RD init success");
+					upgrade_result = true;
+				}
+			}
+
+			if (upgrade_result) {
+				ts->hid_req_cfg.handshake_get = FWUP_ERROR_BL_COMPLETE;
+				mutex_unlock(&ts->hid_ioctl_lock);
+				usleep_range(1000 * 1000, 1000 * 1000);
+				hx_hid_register(ts);
+				if (!ts->hid_probe) {
+					goto err_hid_probe_failed;
+				} else {
+					if (hx_hid_report_data_init(ts) != 0) {
+						E("report data init fail");
+						goto err_report_data_init_failed;
+					}
+				}
+			} else {
+				ts->hid_req_cfg.handshake_get = FWUP_ERROR_FLASH_PROGRAMMING;
+				mutex_unlock(&ts->hid_ioctl_lock);
+			}
+		} else {
+			I("No need to upgrade FW");
+			ts->hid_req_cfg.handshake_get = FWUP_ERROR_BL_COMPLETE;
+			mutex_unlock(&ts->hid_ioctl_lock);
+		}
+
+		if (fw_sts == NO_ERR && !ts->hid_req_cfg.fw)
+			release_firmware(ts->hxfw);
+		ts->hxfw = NULL;
+	}
+END:
+	ts->ic_boot_done = true;
+	himax_int_enable(ts, true);
+
+	return;
+
+err_report_data_init_failed:
+	hx_hid_remove(ts);
+	ts->hid_probe = false;
+err_hid_probe_failed:
+err_hid_rd_init_failed:
+err_pid_match_failed:
+err_update_fw_failed:
+	if (fw_sts == NO_ERR && !ts->hid_req_cfg.fw)
+		release_firmware(ts->hxfw);
+	ts->hxfw = NULL;
+err_get_fw_failed:
+	mutex_unlock(&ts->hid_ioctl_lock);
+}
+
+void hx_hid_update(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_hid_update.work);
+
+	himax_int_enable(ts, false);
+
+	if (ts->hid_req_cfg.input_RD_de == 0) {
+		himax_boot_upgrade(work);
+	} else {
+		if (hx_hid_rd_init(ts) == 0) {
+			I("hid rd init success");
+			hx_hid_register(ts);
+			if (ts->hid_probe)
+				hx_hid_report_data_init(ts);
+		}
+		himax_int_enable(ts, true);
+	}
+}
+
+int himax_report_data_init(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	kfree(ts->hx_rawdata_buf);
+	ts->hx_rawdata_buf = NULL;
+
+	ts->hx_rawdata_buf = kzalloc(ts->touch_info_size, GFP_KERNEL);
+	if (!ts->hx_rawdata_buf) {
+		E("ts->hx_rawdata_buf kzalloc failed!");
+		ret = -ENOMEM;
+		goto fail_1;
+	}
+#if defined(HX_HEATMAP_EN)
+	kfree(ts->hx_heatmap_buf);
+	ts->hx_heatmap_buf = NULL;
+
+	ts->hx_heatmap_buf = kzalloc
+		((ts->ic_data->HX_RX_NUM * ts->ic_data->HX_TX_NUM) * 2 +
+		HEAT_MAP_INFO_SZ + 1, GFP_KERNEL);
+	if (!ts->hx_heatmap_buf) {
+		E("ts->hx_heatmap_buf kzalloc failed!");
+		ret = -ENOMEM;
+		goto fail_heatmap;
+	}
+#endif
+
+	return 0;
+
+#if defined(HX_HEATMAP_EN)
+fail_heatmap:
+#endif
+	kfree(ts->hx_rawdata_buf);
+	ts->hx_rawdata_buf = NULL;
+fail_1:
+
+	return ret;
+}
+
+void himax_report_data_deinit(struct himax_ts_data *ts)
+{
+#if defined(HX_HEATMAP_EN)
+	kfree(ts->hx_heatmap_buf);
+	ts->hx_heatmap_buf = NULL;
+#endif
+	kfree(ts->hx_rawdata_buf);
+	ts->hx_rawdata_buf = NULL;
+}
+
+static void print_config(void)
+{
+#if defined(__HIMAX_MOD__)
+	D("__HIMAX_MOD__ defined.");
+#endif
+#if defined(CONFIG_DRM_ROCKCHIP)
+	D("CONFIG_DRM_ROCKCHIP defined.");
+#endif
+#if defined(CONFIG_FB)
+	D("CONFIG_FB defined.");
+#endif
+#if defined(CONFIG_OF)
+	D("CONFIG_OF defined.");
+#endif
+#if defined(CONFIG_ACPI)
+	D("CONFIG_ACPI defined.");
+#endif
+#if defined(HW_ED_EXCP_EVENT)
+	D("HW_ED_EXCP_EVENT defined.");
+#endif
+#if defined(HX_HEATMAP_EN)
+	D("HX_HEATMAP_EN defined.");
+#endif
+#if defined(CONFIG_HX_HID_HAS_FLASH)
+	D("CONFIG_HX_HID_HAS_FLASH defined.");
+#endif
+#if defined(BUS_R_DLEN)
+	D("BUS_R_DLEN defined : %d.", BUS_R_DLEN);
+#endif
+#if defined(BUS_W_DLEN)
+	D("BUS_W_DLEN defined : %d.", BUS_W_DLEN);
+#endif
+#if defined(BOOT_UPGRADE_FWNAME)
+	D("BOOT_UPGRADE_FWNAME defined : %s.", BOOT_UPGRADE_FWNAME);
+#endif
+#if defined(HIMAX_DRIVER_VER)
+	D("HIMAX_DRIVER_VER defined : %s.", HIMAX_DRIVER_VER);
+#endif
+#if defined(HX_HID_PM)
+	D("HX_HID_PM defined.");
+#endif
+}
+
+int himax_chip_suspend(struct himax_ts_data *ts)
+{
+	if (ts->suspended) {
+		I("Already suspended, skip...");
+		goto END;
+	} else {
+		ts->suspended = true;
+	}
+
+	I("enter");
+	g_core_fp.fp_suspend_proc(ts, ts->suspended);
+
+	himax_int_enable(ts, false);
+
+	if (g_core_fp.fp_suspend_ic_action)
+		g_core_fp.fp_suspend_ic_action(ts);
+
+	if (!ts->use_irq) {
+		s32 cancel_state;
+
+		cancel_state = cancel_work_sync(&ts->work);
+		if (cancel_state)
+			himax_int_enable(ts, true);
+	}
+
+	atomic_set(&ts->suspend_mode, 1);
+
+	if (ts->pdata)
+		if (ts->pdata->power_off_3v3 && ts->pdata->power)
+			ts->pdata->power(0);
+
+END:
+	hx_hid_remove(ts);
+	I("END");
+
+	return 0;
+}
+
+int himax_chip_resume(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (!ts->suspended && ts->resume_success) {
+		I("Already resumed, skip...");
+		goto END;
+	} else {
+		ts->suspended = false;
+	}
+	ts->resume_success = false;
+
+	I("enter");
+	/* continuous N times record, not total N times. */
+	ts->excp_zero_event_count = 0;
+
+	atomic_set(&ts->suspend_mode, 0);
+	if (ts->pdata)
+		if (ts->pdata->power_off_3v3 && ts->pdata->power)
+			ts->pdata->power(1);
+
+	g_core_fp.fp_resume_proc(ts, ts->suspended);
+	// hx_report_all_leave_event(ts);
+	if (ts->resume_success) {
+		hx_hid_probe(ts);
+		himax_int_enable(ts, true);
+	} else {
+		E("resume failed!");
+		ret = -ECANCELED;
+	}
+END:
+	I("END");
+
+	return ret;
+}
+
+int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	I("enter");
+	if (!ts->initialized) {
+		E("init not ready, skip!");
+		return -ECANCELED;
+	}
+	himax_chip_suspend(ts);
+	return 0;
+}
+
+int himax_resume(struct device *dev)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	I("enter");
+	/*
+	 *	wait until device resume for TDDI
+	 *	TDDI: Touch and display Driver IC
+	 */
+	if (!ts->initialized) {
+#if !defined(CONFIG_FB)
+		if (himax_chip_init())
+			return -ECANCELED;
+#else
+		E("init not ready, skip!");
+		return -ECANCELED;
+#endif
+	}
+	ret = himax_chip_resume(ts);
+	if (ret < 0) {
+		E("resume failed!");
+		I("retry resume");
+		schedule_delayed_work(&ts->work_resume_delayed_work,
+				      msecs_to_jiffies(ts->pdata->ic_resume_delay));
+		// I("try int rescue");
+		// himax_int_enable(ts, 1);
+	}
+
+	return ret;
+}
+
+static void himax_resume_work_func(struct work_struct *work)
+{
+	struct himax_ts_data *ts = NULL;
+
+	ts = container_of(work, struct himax_ts_data,
+			  work_resume_delayed_work.work);
+	if (!ts) {
+		E("ts is NULL");
+		return;
+	}
+	himax_chip_resume(ts);
+}
+
+#if defined(CONFIG_PM_SLEEP)
+static const struct dev_pm_ops hx_hid_pm = {
+	.suspend = himax_suspend,
+	.resume = himax_resume,
+	.restore = himax_resume,
+};
+
+#define HX_HID_PM (&hx_hid_pm)
+#else
+#define HX_HID_PM NULL
+#endif
+
+#if defined(CONFIG_OF)
+static const struct of_device_id himax_match_table[] = {
+	{ .compatible = "himax,hid-over-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, himax_match_table);
+#define himax_match_table of_match_ptr(himax_match_table)
+#else
+#define himax_match_table NULL
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hx_acpi_spi_match[] = {
+	{ "HXSPIHID", 0 }, // _CID name should be "HXSPIHID"
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, hx_acpi_spi_match);
+#define hx_acpi_spi_table ACPI_PTR(hx_acpi_spi_match)
+#else
+#define hx_acpi_spi_table NULL
+#endif
+
+int himax_chip_init(struct himax_ts_data *ts)
+{
+	int err = PROBE_FAIL;
+	struct himax_platform_data *pdata = ts->pdata;
+
+	ts->chip_max_dsram_size = 0;
+	ts->notouch_frame = 0;
+	ts->ic_notouch_frame = 0;
+
+	if (g_core_fp.fp_chip_init) {
+		g_core_fp.fp_chip_init(ts);
+	} else {
+		E("function point of chip_init is NULL!");
+		goto error_ic_init_failed;
+	}
+	g_core_fp.fp_touch_information(ts);
+
+	spin_lock_init(&ts->irq_lock);
+
+	if (himax_ts_register_interrupt(ts)) {
+		E("register interrupt failed");
+		goto err_register_interrupt_failed;
+	}
+
+	himax_int_enable(ts, false);
+
+	if (!ts->ic_data->has_flash) {
+		ts->zf_update_cfg_buffer = kcalloc(ts->chip_max_dsram_size,
+						   sizeof(u8), GFP_KERNEL);
+		if (!ts->zf_update_cfg_buffer) {
+			err = -ENOMEM;
+			goto err_update_cfg_buf_adlled;
+		}
+	}
+
+	if (!ts->ic_data->has_flash) {
+		ts->himax_boot_upgrade_wq =
+			create_singlethread_workqueue("HX_boot_upgrade");
+		if (!ts->himax_boot_upgrade_wq) {
+			E("allocate himax_boot_upgrade_wq failed");
+			err = -ENOMEM;
+			goto err_boot_upgrade_wq_failed;
+		}
+		INIT_DELAYED_WORK(&ts->work_boot_upgrade, himax_boot_upgrade);
+		queue_delayed_work(ts->himax_boot_upgrade_wq, &ts->work_boot_upgrade,
+				   msecs_to_jiffies(HX_DELAY_BOOT_UPDATE));
+	}
+
+	ts->himax_hid_debug_wq =
+		create_singlethread_workqueue("HX_hid_debug");
+	if (!ts->himax_hid_debug_wq) {
+		E("allocate himax_hid_debug_wq failed");
+		err = -ENOMEM;
+		goto err_hid_debug_wq_failed;
+	}
+	INIT_DELAYED_WORK(&ts->work_self_test, hx_self_test);
+	INIT_DELAYED_WORK(&ts->work_hid_update, hx_hid_update);
+
+	ts->himax_resume_delayed_work_wq =
+		create_singlethread_workqueue("HX_resume_delayed_work");
+	if (!ts->himax_resume_delayed_work_wq) {
+		E("allocate himax_resume_delayed_work_wq failed");
+		err = -ENOMEM;
+		goto err_resume_delayed_work_wq_failed;
+	}
+	INIT_DELAYED_WORK(&ts->work_resume_delayed_work, himax_resume_work_func);
+
+	g_core_fp.fp_calc_touch_data_size(ts);
+
+#if defined(CONFIG_OF)
+	pdata->cable_config[0]             = 0xF0;
+	pdata->cable_config[1]             = 0x00;
+#endif
+
+	ts->suspended                      = false;
+	ts->usb_connected = 0x00;
+	ts->cable_config = pdata->cable_config;
+	ts->initialized = true;
+	return 0;
+
+	cancel_delayed_work_sync(&ts->work_resume_delayed_work);
+	destroy_workqueue(ts->himax_resume_delayed_work_wq);
+err_resume_delayed_work_wq_failed:
+	cancel_delayed_work_sync(&ts->work_self_test);
+	destroy_workqueue(ts->himax_hid_debug_wq);
+err_hid_debug_wq_failed:
+	cancel_delayed_work_sync(&ts->work_boot_upgrade);
+	destroy_workqueue(ts->himax_boot_upgrade_wq);
+err_boot_upgrade_wq_failed:
+	kfree(ts->zf_update_cfg_buffer);
+err_update_cfg_buf_adlled:
+	himax_ts_unregister_interrupt(ts);
+err_register_interrupt_failed:
+error_ic_init_failed:
+	ts->probe_fail_flag = 1;
+	return err;
+}
+
+void himax_chip_deinit(struct himax_ts_data *ts)
+{
+	kfree(ts->zf_update_cfg_buffer);
+	ts->zf_update_cfg_buffer = NULL;
+
+	himax_ts_unregister_interrupt(ts);
+
+	himax_report_data_deinit(ts);
+
+	cancel_delayed_work_sync(&ts->work_resume_delayed_work);
+	destroy_workqueue(ts->himax_resume_delayed_work_wq);
+
+	cancel_delayed_work_sync(&ts->work_self_test);
+	destroy_workqueue(ts->himax_hid_debug_wq);
+
+	if (!ts->ic_data->has_flash) {
+		cancel_delayed_work_sync(&ts->work_boot_upgrade);
+		destroy_workqueue(ts->himax_boot_upgrade_wq);
+	}
+	ts->probe_fail_flag = 0;
+
+	I("Common section deinited!");
+}
+
+static void himax_platform_deinit(struct himax_ts_data *ts)
+{
+	struct himax_platform_data *pdata = NULL;
+#if !defined(CONFIG_OF)
+	int ret = 0;
+#endif
+
+	I("entering");
+
+	if (!ts) {
+		E("ts is NULL");
+		return;
+	}
+
+	pdata = ts->pdata;
+	if (!pdata) {
+		E("pdata is NULL");
+		return;
+	}
+
+#if !defined(CONFIG_OF)
+	if (pdata->power) {
+		ret = pdata->power(0);
+		if (ret < 0)
+			E("power on failed");
+	}
+#endif
+
+	himax_gpio_power_deconfig(pdata);
+
+	kfree(ts->ic_data);
+	ts->ic_data = NULL;
+
+	kfree(pdata);
+	pdata = NULL;
+	ts->pdata = NULL;
+
+	kfree(ts->xfer_buff);
+	ts->xfer_buff = NULL;
+
+	I("exit");
+}
+
+static bool himax_platform_init(struct himax_ts_data *ts,
+				struct himax_platform_data *local_pdata)
+{
+	int err = PROBE_FAIL;
+	struct himax_platform_data *pdata;
+#if !defined(CONFIG_OF)
+	int ret = 0;
+#endif
+
+	I("entering");
+	ts->xfer_buff = kcalloc
+		(HX_FULL_STACK_RAWDATA_SIZE, sizeof(u8), GFP_KERNEL);
+	if (!ts->xfer_buff) {
+		err = -ENOMEM;
+		goto err_xfer_buff_fail;
+	}
+
+	I("PDATA START");
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) { /*Allocate Platform data space*/
+		err = -ENOMEM;
+		goto err_dt_platform_data_fail;
+	}
+
+	I("ts->ic_data START");
+	ts->ic_data = kzalloc(sizeof(*ts->ic_data), GFP_KERNEL);
+	if (!ts->ic_data) { /*Allocate IC data space*/
+		err = -ENOMEM;
+		goto err_dt_ic_data_fail;
+	}
+	memset(ts->ic_data, 0xFF, sizeof(struct himax_ic_data));
+	/* default 128k, different size please follow HX83121A style */
+	ts->ic_data->flash_size = 131072;
+
+	memcpy(pdata, local_pdata, sizeof(struct himax_platform_data));
+	ts->pdata = pdata;
+	ts->rst_gpio = pdata->gpio_reset;
+
+	if (himax_gpio_power_config(ts, pdata) < 0) {
+		E("gpio config fail, exit!");
+		goto err_power_config_failed;
+	}
+
+#if !defined(CONFIG_OF)
+	if (pdata->power) {
+		ret = pdata->power(1);
+		if (ret < 0) {
+			E("power on failed");
+			goto err_power_failed;
+		}
+	}
+#endif
+
+#if defined(CONFIG_OF)
+	ts->power = pdata->power;
+#endif
+	I("Completed.");
+
+	return true;
+
+#if !defined(CONFIG_OF)
+err_power_failed:
+#endif
+	himax_gpio_power_deconfig(pdata);
+err_power_config_failed:
+	kfree(ts->ic_data);
+	ts->ic_data = NULL;
+err_dt_ic_data_fail:
+	kfree(pdata);
+	pdata = NULL;
+err_dt_platform_data_fail:
+	kfree(ts->xfer_buff);
+	ts->xfer_buff = NULL;
+err_xfer_buff_fail:
+	return false;
+}
+
+static struct himax_ts_data *get_ts(struct device *dev)
+{
+	struct list_head *listptr = NULL;
+	struct himax_ts_data *ts = NULL;
+	struct himax_ts_data *tmp_ts = NULL;
+
+	if (!g_himax_ts->dev ||
+	    g_himax_ts->dev == dev) {
+		D("Found 1st device : %p", dev);
+		return g_himax_ts;
+	}
+
+	D("Matching for device %p", dev);
+	list_for_each(listptr, &g_himax_ts->list) {
+		tmp_ts = list_entry(listptr, struct himax_ts_data, list);
+		if (tmp_ts->dev == dev) {
+			ts = tmp_ts;
+			break;
+		}
+	}
+	if (!ts)
+		D("No matching device found");
+
+	return ts;
+}
+
+int himax_spi_drv_probe(struct spi_device *spi)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret = 0;
+	bool bret = false;
+	static struct himax_platform_data pdata = {0};
+#if !defined(__HIMAX_MOD__)
+	struct time_var current_time;
+#endif
+
+	ts = get_ts(&spi->dev);
+	if (!ts) {
+		// non exist, create new one
+		ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+		if (!ts) {
+			E("allocate himax_ts_data failed");
+			ret = -ENOMEM;
+			goto err_alloc_data_failed;
+		}
+		list_add_tail(&ts->list, &g_himax_ts->list);
+		I("Allocated himax_ts_data for new device %p", &spi->dev);
+		ts->dev = &spi->dev;
+	}
+	if (ts == g_himax_ts)
+		ts->dev = &spi->dev;
+#if !defined(__HIMAX_MOD__)
+	if ((ts->deferred_start.tv_sec != 0 ||
+	     ts->deferred_start.tv_nsec != 0) && ts->ic_det_delay) {
+		time_func(&current_time);
+		if (time_diff(&ts->deferred_start, &current_time) <
+			ts->ic_det_delay) {
+			D("delay time not reach, defer probe");
+			return -EPROBE_DEFER;
+		}
+		I("delay time reach, probe again!");
+	}
+#endif
+	D("Enter");
+	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX) {
+		E("Full duplex not supported by host");
+		return -EIO;
+	}
+
+#if defined(CONFIG_OF)
+	if (himax_parse_dt(spi->dev.of_node, &pdata) < 0) {
+		E(" parse OF data failed!");
+		if (ts != g_himax_ts) {
+			list_del(&ts->list);
+			kfree(ts);
+			D("free ts %p of dev %p", ts, &spi->dev);
+		} else {
+			ts->dev = NULL;
+		}
+		return -ENODEV;
+	}
+#elif defined(CONFIG_ACPI)
+	if (himax_parse_acpi(&spi->dev, &pdata) < 0) {
+		E(" parse acpi data failed!");
+		if (ts != g_himax_ts) {
+			list_del(&ts->list);
+			kfree(ts);
+			D("free ts %p of dev %p", ts, &spi->dev);
+		} else {
+			ts->dev = NULL;
+		}
+		return -ENODEV;
+	}
+#endif
+
+#if !defined(__HIMAX_MOD__)
+	if (pdata.ic_det_delay > 0) {
+		if (ts->deferred_start.tv_sec == 0 &&
+		    ts->deferred_start.tv_nsec == 0) {
+			I("delay %d ms for IC detect",
+			  pdata.ic_det_delay);
+			ts->ic_det_delay = pdata.ic_det_delay;
+			time_func(&ts->deferred_start);
+			return -EPROBE_DEFER;
+		}
+	}
+#endif
+
+	ts->xfer_data = kzalloc(BUS_RW_MAX_LEN, GFP_KERNEL);
+	if (!ts->xfer_data) {
+		E("allocate xfer_data failed");
+		ret = -ENOMEM;
+		goto err_alloc_xfer_data_failed;
+	}
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_3;
+	spi->chip_select = 0;
+
+	ts->spi = spi;
+	mutex_init(&ts->rw_lock);
+	mutex_init(&ts->reg_lock);
+	mutex_init(&ts->hid_ioctl_lock);
+	dev_set_drvdata(&spi->dev, ts);
+	spi_set_drvdata(spi, ts);
+
+	ts->probe_finish = false;
+	ts->initialized = false;
+	ts->ic_boot_done = false;
+	bret = himax_platform_init(ts, &pdata);
+	if (!bret) {
+		E("platform init failed");
+		ret = -ENODEV;
+		goto error_platform_init_failed;
+	}
+
+	bret = g_core_fp.fp_chip_detect(ts);
+	if (!bret) {
+		E("IC detect failed");
+		ret = -ENODEV;
+		goto error_ic_detect_failed;
+	}
+
+	ret = himax_chip_init(ts);
+	if (ret < 0)
+		goto err_init_failed;
+
+#if defined(CONFIG_FB)
+	ts->himax_att_wq = create_singlethread_workqueue("HMX_ATT_request");
+	if (!ts->himax_att_wq) {
+		E(" allocate himax_att_wq failed");
+		ret = -ENOMEM;
+		goto err_get_intr_bit_failed;
+	}
+
+	INIT_DELAYED_WORK(&ts->work_att, himax_fb_register);
+	queue_delayed_work(ts->himax_att_wq, &ts->work_att,
+			   msecs_to_jiffies(0));
+#endif
+
+	ts->himax_pwr_wq = create_singlethread_workqueue("HMX_PWR_request");
+	if (!ts->himax_pwr_wq) {
+		E(" allocate himax_pwr_wq failed");
+		ret = -ENOMEM;
+		goto err_create_pwr_wq_failed;
+	}
+
+	INIT_DELAYED_WORK(&ts->work_pwr, himax_pwr_register);
+	queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+			   msecs_to_jiffies(0));
+
+	ts->probe_finish = true;
+
+	return ret;
+
+err_create_pwr_wq_failed:
+#if defined(CONFIG_FB)
+	cancel_delayed_work_sync(&ts->work_att);
+	destroy_workqueue(ts->himax_att_wq);
+err_get_intr_bit_failed:
+#endif
+	himax_chip_deinit(ts);
+err_init_failed:
+error_ic_detect_failed:
+	himax_platform_deinit(ts);
+error_platform_init_failed:
+	kfree(ts->xfer_data);
+	ts->xfer_data = NULL;
+err_alloc_xfer_data_failed:
+	if (ts != g_himax_ts)
+		list_del(&ts->list);
+	kfree(ts);
+	ts = NULL;
+err_alloc_data_failed:
+
+	return ret;
+}
+
+static void himax_spi_drv_remove(struct spi_device *spi)
+{
+	struct himax_ts_data *ts = spi_get_drvdata(spi);
+
+	if (ts->probe_finish) {
+		if (ts->ic_boot_done) {
+			himax_int_enable(ts, false);
+
+			if (ts->hid_probe) {
+				hx_hid_remove(ts);
+				ts->hid_probe = false;
+			}
+
+			kfree(ts->hid_rd_data.rd_data);
+			ts->hid_rd_data.rd_data = NULL;
+
+			ts->ic_boot_done = false;
+		}
+		power_supply_unreg_notifier(&ts->power_notif);
+		cancel_delayed_work_sync(&ts->work_pwr);
+		destroy_workqueue(ts->himax_pwr_wq);
+	#if defined(CONFIG_FB)
+		if (fb_unregister_client(&ts->fb_notif))
+			E("Err occur while unregister fb_noti.");
+		cancel_delayed_work_sync(&ts->work_att);
+		destroy_workqueue(ts->himax_att_wq);
+	#endif
+		himax_chip_deinit(ts);
+		himax_platform_deinit(ts);
+		ts->pdata = NULL;
+		kfree(ts->ovl_idx);
+		ts->ovl_idx = NULL;
+		kfree(ts->xfer_data);
+		ts->xfer_data = NULL;
+		ts->probe_fail_flag = 0;
+		if (ts != g_himax_ts) {
+			list_del(&ts->list);
+			kfree(ts);
+			ts = NULL;
+		}
+	}
+	spi_set_drvdata(spi, NULL);
+
+	I("completed.");
+}
+
+static struct spi_driver himax_hid_over_spi_driver = {
+	.driver = {
+		.name =		himax_dev_name,
+		.owner =	THIS_MODULE,
+		.pm	= HX_HID_PM,
+		.of_match_table = himax_match_table,
+		.acpi_match_table = hx_acpi_spi_table,
+	},
+	.probe =	himax_spi_drv_probe,
+	.remove =	himax_spi_drv_remove,
+};
+
+int himax_spi_drv_init(struct himax_ts_data *ts)
+{
+	int ret;
+
+	I("Himax touch panel driver for HID init");
+	print_config();
+	ret = spi_register_driver(&himax_hid_over_spi_driver);
+
+	return ret;
+}
+
+void himax_spi_drv_exit(void)
+{
+	if (g_himax_ts) {
+		spi_unregister_driver(&himax_hid_over_spi_driver);
+		kfree(g_himax_ts);
+		g_himax_ts = NULL;
+		I("Free g_himax_ts");
+	}
+}
diff --git a/drivers/hid/hx-hid/hx_core.h b/drivers/hid/hx-hid/hx_core.h
new file mode 100644
index 000000000000..58faf0dc07e7
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_core.h
@@ -0,0 +1,487 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HX_CORE_H__
+#define __HX_CORE_H__
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/acpi.h>
+#include <linux/spi/spi.h>
+#include <linux/hid.h>
+#include <linux/sizes.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/gpio.h>
+#include <linux/types.h>
+#include <linux/spi/spi.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/proc_fs.h>
+#include <linux/version.h>
+#include <linux/firmware.h>
+#include <linux/acpi.h>
+#include <linux/stddef.h>
+#include "hx_hid.h"
+
+#define HIMAX_DRIVER_VER "0.0.11"
+
+#define HIMAX_BUS_RETRY_TIMES 3
+#define BUS_RW_MAX_LEN 0x20006
+#define BUS_R_HLEN 3
+#define BUS_R_DLEN ((BUS_RW_MAX_LEN - BUS_R_HLEN) - ((BUS_RW_MAX_LEN - BUS_R_HLEN) % 4))
+#define BUS_W_HLEN 2
+#define BUS_W_DLEN ((BUS_RW_MAX_LEN - BUS_W_HLEN) - ((BUS_RW_MAX_LEN - BUS_W_HLEN) % 4))
+#define FIX_HX_INT_IS_EDGE	(false)
+
+#define HX_DELAY_BOOT_UPDATE			(2000)
+#define HID_REG_SZ_MAX					(1 + 4 + 1 + 4 + 256)
+// #define HX_PID_FW_MAPPING
+
+enum fix_touch_info {
+	FIX_HX_RX_NUM = 48,
+	FIX_HX_TX_NUM = 32,
+	FIX_HX_BT_NUM = 0,
+	FIX_HX_MAX_PT = 10,
+	FIX_HX_STYLUS_FUNC = 1,
+	FIX_HX_STYLUS_ID_V2 = 0,
+	FIX_HX_STYLUS_RATIO = 1,
+	HX_STACK_ORG_LEN = 128
+};
+
+#define himax_dev_name "hx_spi_hid_tp"
+
+#if defined(CONFIG_FB)
+#include <linux/notifier.h>
+#include <linux/fb.h>
+#endif
+
+/* log macro */
+#define I(fmt, arg...) pr_info("[HXTP][%s]: " fmt "\n", __func__, ##arg)
+#define W(fmt, arg...) pr_warn("[HXTP][WARNING][%s]: " fmt "\n", __func__, ##arg)
+#define E(fmt, arg...) pr_err("[HXTP][ERROR][%s]: " fmt "\n", __func__, ##arg)
+#define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
+
+struct hx_hid_desc_t {
+	u16 desc_length;
+	u16 bcd_version;
+	u16 report_desc_length;
+	u16 max_input_length;
+	u16 max_output_length;
+	u16 max_fragment_length;
+	u16 vendor_id;
+	u16 product_id;
+	u16 version_id;
+	u16 flags;
+	u32 reserved;
+} __packed;
+
+struct hx_hid_rd_data_t {
+	u8 *rd_data;
+	u32 rd_length;
+};
+
+#define proc_op(name) proc_##name
+#define proc_opl(name) proc_##name
+#define proc_ops_name proc_ops
+#define time_var timespec64
+#define time_var_fine tv_nsec
+#define time_var_fine_unit (1000 * 1000)
+#define time_func ktime_get_real_ts64
+#define owner_line
+
+#define HX_TP_BIN_CHECKSUM_SW		1
+#define HX_TP_BIN_CHECKSUM_HW		2
+#define HX_TP_BIN_CHECKSUM_CRC		3
+
+#define SHIFTBITS 5
+#define RAW_DATA_HEADER_LENGTH 6
+
+#define FW_SIZE_32k		32768
+#define FW_SIZE_60k		61440
+#define FW_SIZE_64k		65536
+#define FW_SIZE_124k	126976
+#define FW_SIZE_128k	131072
+#define FW_SIZE_255k    261120
+
+#define HX83102D_ID		"HX83102D"
+#define HX83102J_ID		"HX83102J"
+#define HX83121A_ID		"HX83121A"
+
+/* origin is 20/50 */
+#define RST_LOW_PERIOD_S 5000
+#define RST_LOW_PERIOD_E 5100
+#define RST_HIGH_PERIOD_ZF_S 5000
+#define RST_HIGH_PERIOD_ZF_E 5100
+#define RST_HIGH_PERIOD_S 50000
+#define RST_HIGH_PERIOD_E 50100
+
+enum cell_type {
+	CHIP_IS_ON_CELL,
+	CHIP_IS_IN_CELL
+};
+
+#define HX_FULL_STACK_RAWDATA_SIZE \
+	(HX_STACK_ORG_LEN +\
+	(2 + FIX_HX_RX_NUM * FIX_HX_TX_NUM + FIX_HX_TX_NUM + FIX_HX_RX_NUM)\
+	* 2)
+
+struct himax_ic_data {
+	int vendor_fw_ver;
+	int vendor_config_ver;
+	int vendor_touch_cfg_ver;
+	int vendor_display_cfg_ver;
+	int vendor_cid_maj_ver;
+	int vendor_cid_min_ver;
+	int vendor_panel_ver;
+	int vendor_sensor_id;
+	int ic_adc_num;
+	u8 vendor_cus_info[12];
+	u8 vendor_proj_info[12];
+	u32 flash_size;
+	u32 HX_RX_NUM;
+	u32 HX_TX_NUM;
+	u32 HX_BT_NUM;
+	u32 HX_X_RES;
+	u32 HX_Y_RES;
+	u32 HX_MAX_PT;
+	u8 HX_INT_IS_EDGE;
+	u8 HX_STYLUS_FUNC;
+	u8 HX_STYLUS_ID_V2;
+	u8 HX_STYLUS_RATIO;
+	u32 icid;
+	bool enc16bits;
+	bool has_flash;
+};
+
+enum HX_TS_PATH {
+	HX_REPORT_COORD = 1,
+	HX_REPORT_COORD_RAWDATA,
+};
+
+enum HX_TS_STATUS {
+	HX_TS_GET_DATA_FAIL = -4,
+	HX_EXCP_EVENT,
+	HX_CHKSUM_FAIL,
+	HX_PATH_FAIL,
+	HX_TS_NORMAL_END = 0,
+	HX_EXCP_REC_OK,
+	HX_READY_SERVE,
+	HX_REPORT_DATA,
+	HX_EXCP_WARNING,
+	HX_IC_RUNNING,
+	HX_ZERO_EVENT_COUNT,
+	HX_RST_OK,
+};
+
+enum HX_ERROR_CODE {
+	NO_ERR = 0,
+	READY_TO_SERVE = 1,
+	WORK_OUT = 2,
+	HX_EMBEDDED_FW = 3,
+	BUS_FAIL = -1,
+	HX_INIT_FAIL = -1,
+	MEM_ALLOC_FAIL = -2,
+	CHECKSUM_FAIL = -3,
+	GESTURE_DETECT_FAIL = -4,
+	INPUT_REGISTER_FAIL = -5,
+	FW_NOT_READY = -6,
+	LENGTH_FAIL = -7,
+	OPEN_FILE_FAIL = -8,
+	PROBE_FAIL = -9,
+	ERR_WORK_OUT = -10,
+	ERR_STS_WRONG = -11,
+	ERR_TEST_FAIL = -12,
+	HW_CRC_FAIL = 1
+};
+
+struct himax_platform_data {
+	u16 pid;
+	u8 power_off_3v3;
+	u8 cable_config[2];
+	int gpio_irq;
+	int gpio_reset;
+	int gpio_3v3_en;
+	int lcm_rst;
+	int ic_det_delay;
+	int ic_resume_delay;
+	int panel_id;
+	bool boot_upgrade;
+	int (*power)(int on);
+	void (*reset)(void);
+};
+
+struct hx_hid_fw_unit_t {
+	u8 cmd;
+	u16 bin_start_offset;
+	u16 unit_sz;
+} __packed;
+
+struct hx_bin_desc_t {
+	u16 passwd;
+	u16 cid;
+	u8 panel_ver;
+	u16 fw_ver;
+	u8 ic_sign;
+	char customer[12];
+	char project[12];
+	char fw_major[12];
+	char fw_minor[12];
+	char date[12];
+	char ic_sign_2[12];
+} __packed;
+
+struct hx_hid_info_t {
+	struct hx_hid_fw_unit_t main_mapping[9];
+	struct hx_hid_fw_unit_t bl_mapping;
+	struct hx_bin_desc_t fw_bin_desc;
+	u16 vid;
+	u16 pid;
+	u8 cfg_info[32];
+	u8 cfg_version;
+	u8 disp_version;
+	u8 rx;
+	u8 tx;
+	u16 yres;
+	u16 xres;
+	u8 pt_num;
+	u8 mkey_num;
+	u8 debug_info[78];
+} __packed;
+
+union hx_dword_data_t {
+	u32 dword;
+	u8 byte[4];
+};
+
+enum hid_reg_action {
+	REG_READ = 0,
+	REG_WRITE = 1
+};
+
+enum hid_reg_types {
+	REG_TYPE_EXT_AHB,
+	REG_TYPE_EXT_SRAM,
+	REG_TYPE_EXT_TYPE = 0xFFFFFFFF
+};
+
+struct hx_hid_req_cfg_t {
+	u32 processing_id;
+	u32 data_type;
+	u32 self_test_type;
+	u32 handshake_set;
+	u32 handshake_get;
+	struct firmware *fw;
+	u32 current_size;
+	// HID REG READ/WRITE format:
+	// STANDARD TYPE
+	// [ID:1][READ/WRITE:1][REG_ADDR:4][REG_DATA:4] : 10 bytes
+	//  0     1             2~5         6~9
+	// EXT TYPE
+	// [ID:1][READ/WRITE:1][0xFFFFFFFF][REG_TYPE:1][REG_ADDR:1|4][REG_DATA:1~256]
+	//  0	  1             2~5         6           7|7~10        8~263|11~266
+	union hx_dword_data_t reg_addr;
+	u32 reg_addr_sz;
+	u8 reg_data[HID_REG_SZ_MAX - 1 - 4];
+	u32 reg_data_sz;
+	u32 input_RD_de;
+};
+
+struct himax_ts_data {
+	bool initialized;
+	bool probe_finish;
+	bool suspended;
+	s32 notouch_frame;
+	s32 ic_notouch_frame;
+	atomic_t suspend_mode;
+	u8 x_channel;
+	u8 y_channel;
+	char chip_name[30];
+	u8 chip_cell_type;
+	u32 chip_max_dsram_size;
+	u32 ic_checksum_type;
+	bool ic_boot_done;
+	u32 probe_fail_flag;
+	u8 *xfer_data;
+	struct himax_ic_data *ic_data;
+
+	int touch_all_size;
+	int touch_info_size;
+
+	u8 *hx_rawdata_buf;
+#if defined(HX_HEATMAP_EN)
+	u8 *hx_heatmap_buf;
+	u32 heatmap_data_size;
+#endif
+	bool boot_upgrade_flag;
+	const struct firmware *hxfw;
+	bool has_alg_overlay;
+	u8 *ovl_idx;
+	bool zf_update_flag;
+	u8 *zf_update_cfg_buffer;
+#if !defined(__HIMAX_MOD__)
+	struct time_var deferred_start;
+	unsigned int ic_det_delay;
+#endif
+
+	u8 n_finger_support;
+	u8 irq_enabled;
+
+	u32 debug_log_level;
+
+	s32 rst_gpio;
+	s32 use_irq;
+	s32 (*power)(s32 on);
+
+	struct device *dev;
+	struct workqueue_struct *himax_wq;
+	struct work_struct work;
+
+	struct hrtimer timer;
+	struct i2c_client *client;
+	struct himax_platform_data *pdata;
+	/* mutex lock for reg access */
+	struct mutex reg_lock;
+	/* mutex lock for read/write action */
+	struct mutex rw_lock;
+	/* mutex lock for hid ioctl action */
+	struct mutex hid_ioctl_lock;
+	atomic_t irq_state;
+	/* spin lock for irq */
+	spinlock_t irq_lock;
+
+/******* SPI-start *******/
+	struct spi_device	*spi;
+	s32 hx_irq;
+	u8 *xfer_buff;
+/******* SPI-end *******/
+
+	struct hid_device *hid;
+	struct hx_hid_desc_t hid_desc;
+	struct hx_hid_rd_data_t hid_rd_data;
+	struct hx_hid_info_t hid_info;
+	struct hx_hid_req_cfg_t hid_req_cfg;
+	struct hx_bin_desc_t fw_bin_desc;
+	bool hid_probe;
+	bool resume_success;
+
+	s32 in_self_test;
+	s32 suspend_resume_done;
+	s32 bus_speed;
+
+	s32 excp_reset_active;
+	s32 excp_eb_event_flag;
+	s32 excp_ec_event_flag;
+	s32 excp_ed_event_flag;
+	s32 excp_zero_event_count;
+
+#if defined(CONFIG_FB)
+	struct notifier_block fb_notif;
+	struct workqueue_struct *himax_att_wq;
+	struct delayed_work work_att;
+#endif
+
+	struct notifier_block power_notif;
+	struct workqueue_struct *himax_pwr_wq;
+	struct delayed_work work_pwr;
+
+	struct workqueue_struct *himax_boot_upgrade_wq;
+	struct delayed_work work_boot_upgrade;
+
+	struct workqueue_struct *himax_hid_debug_wq;
+	struct delayed_work work_self_test;
+	struct delayed_work work_hid_update;
+	u8 usb_connected;
+	u8 *cable_config;
+	u8 latest_power_status;
+
+	struct workqueue_struct *himax_resume_delayed_work_wq;
+	struct delayed_work work_resume_delayed_work;
+
+	u8 slave_write_reg;
+	u8 slave_read_reg;
+	bool acc_slave_reg;
+	bool select_slave_reg;
+	struct list_head list;
+};
+
+struct rd_feature_unit_t {
+	u8 id_tag;
+	u8 id;
+	u8 usage_tag;
+	u8 usage;
+	u8 report_cnt_tag;
+	u16 report_cnt;
+	u8 feature_tag[2];
+} __packed;
+
+union host_ext_rd_t {
+	struct __packed rd_struct_t {
+		u8 header[14];
+		struct rd_feature_unit_t cfg;// ID_CFG
+		struct rd_feature_unit_t reg_rw;// ID_REG_RW
+		struct rd_feature_unit_t monitor_sel;// ID_TOUCH_MONITOR_SEL
+		struct rd_feature_unit_t monitor;// ID_TOUCH_MONITOR
+		// rd_feature_unit_t monitor_partial;// ID_TOUCH_MONITOR_PARTIAL
+		struct rd_feature_unit_t fw_update;// ID_FW_UPDATE
+		struct rd_feature_unit_t fw_update_handshaking;// ID_FW_UPDATE_HANDSHAKING
+		struct rd_feature_unit_t self_test;// ID_SELF_TEST
+		struct rd_feature_unit_t input_rd_en;// ID_INPUT_RD_DE
+		u8 end_collection;
+	} rd_struct;
+	u8 host_report_descriptor[sizeof(struct rd_struct_t)];
+};
+
+union heatmap_rd_t {
+	struct __packed heatmap_struct_t {
+		u8 header[17];
+		u8 heatmap_info_desc[41];
+		u8 heatmap_data_hdr[9];
+		u8 heatmap_data_cnt_tag;
+		u16 heatmap_data_cnt;
+		u8 heatmap_input_desc[2];
+		u8 end_collection;
+	} heatmap_struct;
+	u8 host_report_descriptor[sizeof(struct heatmap_struct_t)];
+};
+
+/* used for 102e/p zero flash */
+/*#define HW_ED_EXCP_EVENT*/
+
+/* FW Auto upgrade case, you need to setup the fix_touch_info of module
+ */
+extern char *g_fw_boot_upgrade_name;
+#define BOOT_UPGRADE_FWNAME "himax_i2chid"
+extern char *g_fw_mp_upgrade_name;
+#define MPAP_FWNAME "himax_mpfw.bin"
+
+extern struct himax_ts_data *g_himax_ts;
+extern struct himax_core_fp g_core_fp;
+
+#define HID_REPORT_HDR_SZ (2)
+#if defined(HX_HEATMAP_EN)
+#define HEAT_MAP_HEADER_SZ (3)
+#define HEAT_MAP_INFO_SZ (9)
+#endif
+
+#if defined(CONFIG_OF)
+int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata);
+#endif
+#if defined(CONFIG_ACPI)
+int himax_parse_acpi(struct device *dev, struct himax_platform_data *pdata);
+#endif
+void himax_ts_work(struct himax_ts_data *ts);
+enum hrtimer_restart himax_ts_timer_func(struct hrtimer *timer);
+int himax_resume(struct device *dev);
+int himax_suspend(struct device *dev);
+
+int himax_spi_drv_init(struct himax_ts_data *ts);
+void himax_spi_drv_exit(void);
+int himax_chip_init(struct himax_ts_data *ts);
+int himax_report_data_init(struct himax_ts_data *ts);
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew);
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_hid.c b/drivers/hid/hx-hid/hx_hid.c
new file mode 100644
index 000000000000..a21161b8689d
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_hid.c
@@ -0,0 +1,757 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/hid.h>
+#include "hx_core.h"
+#include "hx_inspect.h"
+#include "hx_plat.h"
+#include "hx_ic_core.h"
+
+union host_ext_rd_t g_host_ext_rd = {
+	.host_report_descriptor = {
+		0x06, 0x00, 0xFF,// Usage Page (Vendor-defined)
+		0x09, 0x01,// Usage (0x1)
+		0xA1, 0x01,// Collection (Application)
+		0x75, 0x08,// Report Size (8)
+		0x15, 0x00,// Logical Minimum (0)
+		0x26, 0xFF, 0x00,// Logical Maximum (255)
+		0x85, 0x05,// Report ID (5)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0xFF, 0x00,// Report Count (255)
+		0xB1, 0x02,// Feature (ID: 5, sz: 2040 bits(255 bytes))
+		0x85, 0x06,// Report ID (6)
+		0x09, 0x02,// Usage (0x2)
+		0x96, (HID_REG_SZ_MAX & 0xFF), (HID_REG_SZ_MAX >> 8),
+		0xB1, 0x02,// Feature (ID: 6, sz: 72 bits(9 bytes))
+		0x85, 0x07,// Report ID (7)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x04, 0x00,// Report Count (4)
+		0xB1, 0x02,// Feature (ID: 7, sz: 32 bits(4 bytes))
+		0x85, 0x08,// Report ID (8)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x8D, 0x13,// Report Count (5005)
+		0xB1, 0x02,// Feature (ID: 8, sz: 40040 bits(5005 bytes))
+		// 0x85, 0x09,// Report ID (9)
+		// 0x09, 0x02,// Usage (0x2)
+		// 0x96, 0x4F, 0x03,// Report Count (847)
+		// 0xB1, 0x02,// Feature (ID: 9, sz: 6776 bits(847 bytes))
+		0x85, 0x0A,// Report ID (10)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x00, 0x04,// Report Count (1024)
+		0x91, 0x02,// Output (ID: 10, sz: 8192 bits(1024 bytes))
+		0x85, 0x0B,// Report ID (11)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x01, 0x00,// Report Count (1)
+		0xB1, 0x02,// Feature (ID: 11, sz: 8 bits(1 bytes))
+		0x85, 0x0C,// Report ID (12)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x01, 0x00,// Report Count (1)
+		0xB1, 0x02,// Feature (ID: 12, sz: 8 bits(1 bytes))
+		0x85, 0x31,// Report ID (49)
+		0x09, 0x02,// Usage (0x2)
+		0x96, 0x01, 0x00,// Report Count (1)
+		0xB1, 0x02,// Feature (ID: 49, sz: 8 bits(1 bytes))
+		0xC0,// End Collection
+	},
+};
+
+const unsigned int host_ext_report_desc_sz =
+	sizeof(g_host_ext_rd.host_report_descriptor);
+
+union heatmap_rd_t g_heatmap_rd = {
+	.host_report_descriptor = {
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x09, 0x0F,// Usage (0xF)
+		0xA1, 0x01,// Collection (Application)
+		0x85, 0x61,// Report ID (97)
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x15, 0x00,// Logical Minimum (0)
+		0x27, 0xFF, 0xFF, 0x00, 0x00,// Logical Maximum (65535)
+		0x75, 0x10,// Report Size (16)
+		0x95, 0x01,// Report Count (1)
+		0x09, 0x6A,// Usage (0x6A)
+		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
+		0x26, 0xFF, 0x00,// Logical Maximum (255)
+		0x75, 0x08,// Report Size (8)
+		0x09, 0x6B,// Usage (0x6B)
+		0x81, 0x02,// Input (ID: 97, sz: 8 bits(1 bytes))
+		0x27, 0xFF, 0xFF, 0x00, 0x00,// Logical Maximum (65535)
+		0x75, 0x10,// Report Size (16)
+		0x09, 0x56,// Usage (0x56)
+		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
+		0x05, 0x06,// Usage Page (Generic Device Controls)
+		0x09, 0x3B,// Usage (0x3B)
+		0x27, 0xFF, 0xFF, 0xFF, 0xFF,// Logical Maximum (-1)
+		0x75, 0x20,// Report Size (32)
+		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x26, 0xFF, 0x00,// Logical Maximum (255)
+		0x75, 0x08,// Report Size (8)
+		0x09, 0x6C,// Usage (0x6C)
+		0x96, 0x00, 0x0C,// Report Count (3072)
+		0x81, 0x02,// Input (ID: 97, sz: 24576 bits(3072 bytes))
+		0xC0,// End Collection
+	},
+};
+
+const unsigned int host_heatmap_report_desc_sz =
+	sizeof(g_heatmap_rd.host_report_descriptor);
+
+static const struct hx_hid_fw_unit_t default_main_121A[9] = {
+	{
+		.cmd = 0xA1,
+		.bin_start_offset = 0,
+		.unit_sz = 127,
+	},
+	{
+		.cmd = 0xA2,
+		.bin_start_offset = 129,
+		.unit_sz = 111,
+	},
+};
+
+static const u16 g_hx_hid_raw_data_type[HX_HID_RAW_DATA_TYPE_MAX] = {
+	HID_RAW_DATA_TYPE_DELTA,
+	HID_RAW_DATA_TYPE_RAW,
+	HID_RAW_DATA_TYPE_BASELINE,
+	HID_RAW_DATA_TYPE_NORMAL
+};
+
+static int hx_hid_parse(struct hid_device *hid)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret;
+
+	if (!hid) {
+		E("hid is NULL");
+		return -EINVAL;
+	}
+
+	ts = hid->driver_data;
+	if (!ts) {
+		E("hid->driver_data is NULL");
+		return -EINVAL;
+	}
+
+	ret = hid_parse_report(hid, ts->hid_rd_data.rd_data,
+			       ts->hid_rd_data.rd_length);
+	if (ret) {
+		E("failed parse report");
+		return	ret;
+	}
+	I("rdesc parse success");
+	return 0;
+}
+
+static int hx_hid_start(struct hid_device *hid)
+{
+	D("enter");
+	return 0;
+}
+
+static void hx_hid_stop(struct hid_device *hid)
+{
+	D("enter");
+}
+
+static int hx_hid_open(struct hid_device *hid)
+{
+	D("enter");
+	return 0;
+}
+
+static void hx_hid_close(struct hid_device *hid)
+{
+	D("enter");
+}
+
+void hx_hid_update_info(struct himax_ts_data *ts)
+{
+	memcpy(&ts->hid_info.fw_bin_desc, &ts->fw_bin_desc, sizeof(struct hx_bin_desc_t));
+	ts->hid_info.vid = cpu_to_be16(ts->hid_desc.vendor_id);
+	ts->hid_info.pid = cpu_to_be16(ts->hid_desc.product_id);
+	ts->hid_info.cfg_version = ts->ic_data->vendor_touch_cfg_ver;
+	ts->hid_info.disp_version = ts->ic_data->vendor_display_cfg_ver;
+	ts->hid_info.rx = ts->ic_data->HX_RX_NUM;
+	ts->hid_info.tx = ts->ic_data->HX_TX_NUM;
+	ts->hid_info.yres = cpu_to_be16(ts->ic_data->HX_Y_RES);
+	ts->hid_info.xres = cpu_to_be16(ts->ic_data->HX_X_RES);
+	ts->hid_info.pt_num = ts->ic_data->HX_MAX_PT;
+	ts->hid_info.mkey_num = ts->ic_data->HX_BT_NUM;
+
+	// firmware table parameters, use only bl part.
+	ts->hid_info.bl_mapping.cmd = HID_FW_UPDATE_BL_CMD;
+	ts->hid_info.bl_mapping.bin_start_offset = 0;
+	ts->hid_info.bl_mapping.unit_sz = ts->ic_data->flash_size / 1024;
+}
+
+static void free_firmware(struct firmware *fw)
+{
+	if (fw) {
+		kfree(fw->data);
+		kfree(fw->priv);
+		kfree(fw);
+	}
+}
+
+static int hx_hid_load_user_firmware(struct himax_ts_data *ts,
+				     u8 *fwdata, size_t sz)
+{
+	int ret = 0;
+
+	if (ts->hid_req_cfg.fw) {
+		if (ts->hid_req_cfg.fw->size == ts->ic_data->flash_size) {
+			I("free old fw");
+			free_firmware(ts->hid_req_cfg.fw);
+			ts->hid_req_cfg.fw = NULL;
+		}
+	}
+
+	if (!ts->hid_req_cfg.fw) {
+		ts->hid_req_cfg.fw = kzalloc(sizeof(*ts->hid_req_cfg.fw), GFP_KERNEL);
+		if (!ts->hid_req_cfg.fw) {
+			E("Allocate firmware failed");
+			ret = -ENOMEM;
+			goto ERR_OUT;
+		}
+		ts->hid_req_cfg.fw->data = kzalloc(ts->ic_data->flash_size, GFP_KERNEL);
+		if (!ts->hid_req_cfg.fw->data) {
+			E("kzalloc failed");
+			kfree(ts->hid_req_cfg.fw);
+			ts->hid_req_cfg.fw = NULL;
+			ret = -ENOMEM;
+			goto ERR_OUT;
+		}
+	}
+
+	memcpy((u8 *)ts->hid_req_cfg.fw->data + ts->hid_req_cfg.fw->size,
+	       (u8 *)fwdata + 1, sz - 1);
+	ts->hid_req_cfg.fw->size += sz - 1;
+	if (ts->hid_req_cfg.fw->size == ts->ic_data->flash_size) {
+		I("load firmware done");
+		ret = 2;
+	} else {
+		I("still loading firmware...");
+		ret = 1;
+	}
+
+ERR_OUT:
+	return ret;
+}
+
+static int hx_hid_get_raw_report(const struct hid_device *hid, unsigned char reportnum,
+				 __u8 *buf, size_t len, unsigned char report_type)
+{
+	struct himax_ts_data *ts = NULL;
+	int ret = 0;
+	u32 tmp_data = 0;
+	union hx_dword_data_t *tmp = NULL;
+
+	ts = hid->driver_data;
+	if (!ts) {
+		E("hid->driver_data is NULL");
+		return -EINVAL;
+	}
+
+	D("reportnum:%d, len:%lu, report_type:%d", reportnum, len, report_type);
+
+	switch (reportnum) {
+	case ID_CONTACT_COUNT:
+		if (!ts->ic_data) {
+			E("ts->ic_data is NULL");
+			return -EINVAL;
+		}
+		buf[1] = ts->ic_data->HX_MAX_PT;
+		ret = len;
+		break;
+	case ID_CFG:
+		memcpy(buf + 1, &ts->hid_info, sizeof(struct hx_hid_info_t));
+		ret = len;
+		break;
+	case ID_FW_UPDATE_HANDSHAKING:
+		I("id: %X, cmd: %X", buf[0], buf[1]);
+		if (ts->hid_req_cfg.processing_id == ID_FW_UPDATE_HANDSHAKING) {
+			if (ts->hid_req_cfg.handshake_set == ts->hid_info.bl_mapping.cmd) {
+				ts->hid_req_cfg.handshake_get = ts->hid_req_cfg.handshake_set;
+			} else if (ts->hid_req_cfg.handshake_set == HID_FW_UPDATE_MAIN_CMD) {
+				ts->hid_req_cfg.handshake_get = default_main_121A[0].cmd;
+				ts->hid_req_cfg.current_size = 0;
+			} else if (ts->hid_req_cfg.handshake_set == default_main_121A[0].cmd) {
+				if (ts->hid_req_cfg.current_size >= default_main_121A[0].unit_sz) {
+					ts->hid_req_cfg.handshake_get = default_main_121A[1].cmd;
+					ts->hid_req_cfg.current_size = 0;
+				}
+			} else if (ts->hid_req_cfg.handshake_set == default_main_121A[1].cmd) {
+				if (ts->hid_req_cfg.current_size >= default_main_121A[1].unit_sz) {
+					ts->hid_req_cfg.handshake_get = FWUP_ERROR_BL_COMPLETE;
+					ts->hid_req_cfg.current_size = 0;
+				}
+			} else {
+				// ts->hid_req_cfg.handshake_get = FWUP_ERROR_NO_MAIN;
+				ts->hid_req_cfg.handshake_get = FWUP_ERROR_NO_ERROR;
+			}
+			buf[1] = ts->hid_req_cfg.handshake_get;
+		} else if (ts->hid_req_cfg.processing_id == ID_FW_UPDATE) {
+			mutex_lock(&ts->hid_ioctl_lock);
+			buf[1] = ts->hid_req_cfg.handshake_get;
+			mutex_unlock(&ts->hid_ioctl_lock);
+		} else {
+			buf[1] = FWUP_ERROR_NO_ERROR;
+		}
+		ret = len;
+		break;
+	case ID_SELF_TEST:
+		mutex_lock(&ts->hid_ioctl_lock);
+		buf[1] = ts->hid_req_cfg.handshake_get;
+		ret = len;
+		himax_int_enable(ts, true);
+		mutex_unlock(&ts->hid_ioctl_lock);
+		break;
+	case ID_TOUCH_MONITOR:
+		ret = hx_get_data(ts, &buf[2], len - 2);
+		if (ret == HX_INSP_OK)
+			ret = len;
+		else
+			ret = 0;
+
+		// dummy byte for hx_util
+		buf[1] = 0;
+		break;
+	case ID_TOUCH_MONITOR_SEL:
+		ret = g_core_fp.fp_diag_register_get(ts, &tmp_data);
+		if (ret == NO_ERR) {
+			buf[1] = tmp_data & 0xFF;
+			ret = len;
+		} else {
+			ret = 0;
+		}
+
+		break;
+	case ID_REG_RW:
+		if (len == 10 &&
+		    ((union hx_dword_data_t *)&buf[2])->dword != REG_TYPE_EXT_TYPE) {
+			// standard REG RW
+			ts->hid_req_cfg.reg_addr_sz = 4;
+			ts->hid_req_cfg.reg_data_sz = 4;
+			ts->hid_req_cfg.reg_addr.dword =
+				((union hx_dword_data_t *)&buf[2])->dword;
+			ts->hid_req_cfg.reg_addr.dword =
+				cpu_to_le32(ts->hid_req_cfg.reg_addr.dword);
+			ret = g_core_fp.fp_register_read(ts,
+				ts->hid_req_cfg.reg_addr.byte,
+				ts->hid_req_cfg.reg_data,
+				ts->hid_req_cfg.reg_data_sz);
+			if (ret == NO_ERR) {
+				tmp = (union hx_dword_data_t *)ts->hid_req_cfg.reg_data;
+				tmp->dword = le32_to_cpu(tmp->dword);
+				memcpy(&buf[6], ts->hid_req_cfg.reg_data,
+				       ts->hid_req_cfg.reg_data_sz);
+				ret = len;
+			} else {
+				ret = 0;
+			}
+		} else if ((len >= 9) && (len <= (1 + HID_REG_SZ_MAX)) &&
+			(((union hx_dword_data_t *)&buf[2])->dword == REG_TYPE_EXT_TYPE)) {
+			// ext type REG RW
+			switch (buf[6]) {
+			case REG_TYPE_EXT_AHB:
+				ts->hid_req_cfg.reg_addr_sz = 1;
+				ts->hid_req_cfg.reg_data_sz = len - 1 - 1 - 4 - 1 - 1;
+				ts->hid_req_cfg.reg_addr.dword = buf[7];
+				ret = himax_bus_read(ts, ts->hid_req_cfg.reg_addr.dword,
+						     ts->hid_req_cfg.reg_data,
+						     ts->hid_req_cfg.reg_data_sz);
+				if (ret == 0) {
+					memcpy(&buf[8], ts->hid_req_cfg.reg_data,
+					       ts->hid_req_cfg.reg_data_sz);
+					ret = len;
+				}
+				break;
+			case REG_TYPE_EXT_SRAM:
+				ts->hid_req_cfg.reg_addr_sz = 4;
+				ts->hid_req_cfg.reg_data_sz = len - 1 - 1 - 4 - 1 - 4;
+				ts->hid_req_cfg.reg_addr.dword =
+					((union hx_dword_data_t *)&buf[7])->dword;
+				ts->hid_req_cfg.reg_addr.dword =
+					cpu_to_le32(ts->hid_req_cfg.reg_addr.dword);
+				ret = g_core_fp.fp_register_read(ts,
+					ts->hid_req_cfg.reg_addr.byte,
+					ts->hid_req_cfg.reg_data,
+					ts->hid_req_cfg.reg_data_sz);
+				if (ret == NO_ERR) {
+					memcpy(&buf[11], ts->hid_req_cfg.reg_data,
+					       ts->hid_req_cfg.reg_data_sz);
+					ret = len;
+				} else {
+					ret = 0;
+				}
+				break;
+			default:
+				E("Invalid ext type");
+				return -EINVAL;
+			}
+		} else {
+			E("Invalid reg format!");
+			return -EINVAL;
+		}
+		break;
+	case ID_INPUT_RD_DE:
+		buf[1] = ts->hid_req_cfg.input_RD_de;
+	    ret = len;
+		break;
+	// case ID_TOUCH_MONITOR_PARTIAL:
+	case ID_FW_UPDATE:
+	    ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+	};
+
+	if (ret > 0)
+		D("ret:%d", ret);
+
+	return ret;
+}
+
+static int hx_hid_set_raw_report(const struct hid_device *hid, unsigned char reportnum,
+				 __u8 *buf, size_t len,	unsigned char report_type)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = NULL;
+	unsigned int i = 0;
+	union hx_dword_data_t *tmp_data = NULL;
+
+	ts = hid->driver_data;
+	if (!ts) {
+		E("hid->driver_data is NULL");
+		return -EINVAL;
+	}
+	D("reportnum:%d, len:%lu, report_type:%d", reportnum, len, report_type);
+
+	switch (reportnum) {
+	case ID_FW_UPDATE:
+		if (ts->hid_req_cfg.processing_id == ID_FW_UPDATE_HANDSHAKING) {
+			if (ts->hid_req_cfg.handshake_get == default_main_121A[0].cmd) {
+				ts->hid_req_cfg.handshake_set = default_main_121A[0].cmd;
+				ts->hid_req_cfg.current_size += len - 1;
+				return 0;
+			} else if (ts->hid_req_cfg.handshake_get == default_main_121A[1].cmd) {
+				ts->hid_req_cfg.handshake_set = default_main_121A[1].cmd;
+				ts->hid_req_cfg.current_size += len - 1;
+				return 0;
+			}
+		}
+		ret = hx_hid_load_user_firmware(ts, buf, len);
+		if (ret < 0) {
+			E("load user firmware failed");
+			goto END;
+		} else if (ret == 1) {
+			I("Still loading firmware...");
+			ret = 0;
+			goto END;
+		} else {
+			I("load user firmware succeeded");
+		}
+
+		ts->hid_req_cfg.processing_id = ID_FW_UPDATE;
+		ts->hid_req_cfg.handshake_get = FWUP_ERROR_FLASH_PROGRAMMING;
+		mutex_lock(&ts->hid_ioctl_lock);
+		queue_delayed_work(ts->himax_boot_upgrade_wq, &ts->work_boot_upgrade,
+				   msecs_to_jiffies(0));
+		break;
+	case ID_FW_UPDATE_HANDSHAKING:
+		I("id: %X, cmd: %X", buf[0], buf[1]);
+		ts->hid_req_cfg.processing_id = ID_FW_UPDATE_HANDSHAKING;
+		ts->hid_req_cfg.handshake_set = buf[1];
+		break;
+	case ID_SELF_TEST:
+		ts->hid_req_cfg.processing_id = ID_SELF_TEST;
+		ts->hid_req_cfg.handshake_set = buf[1];
+		I("id: %X, cmd: %X", buf[0], buf[1]);
+		switch (buf[1]) {
+		case HID_SELF_TEST_SHORT:
+			ts->hid_req_cfg.self_test_type = HX_SHORT;
+			break;
+		case HID_SELF_TEST_OPEN:
+			ts->hid_req_cfg.self_test_type = HX_OPEN;
+			break;
+		case HID_SELF_TEST_MICRO_OPEN:
+			ts->hid_req_cfg.self_test_type = HX_MICRO_OPEN;
+			break;
+		case HID_SELF_TEST_RAWDATA:
+			ts->hid_req_cfg.self_test_type = HX_RAWDATA;
+			break;
+		case HID_SELF_TEST_NOISE:
+			ts->hid_req_cfg.self_test_type = HX_ABS_NOISE;
+			break;
+		case HID_SELF_TEST_RESET:
+			ts->hid_req_cfg.self_test_type = HX_BACK_NORMAL;
+			break;
+		default:
+			I("Not support self test type, set to default(HX_BACK_NORMAL)");
+			ts->hid_req_cfg.self_test_type = HX_BACK_NORMAL;
+		}
+		if (ts->hid_req_cfg.self_test_type == HX_BACK_NORMAL) {
+			hx_switch_data_type(ts, HX_BACK_NORMAL);
+			himax_int_enable(ts, false);
+			g_core_fp.fp_reload_disable(ts, 0);
+			g_core_fp.fp_power_on_init(ts);
+			himax_int_enable(ts, true);
+			break;
+		}
+		mutex_lock(&ts->hid_ioctl_lock);
+		himax_int_enable(ts, false);
+		queue_delayed_work(ts->himax_hid_debug_wq, &ts->work_self_test,
+				   msecs_to_jiffies(0));
+		break;
+	case ID_TOUCH_MONITOR_SEL:
+		I("id: %X, cmd: %X", buf[0], buf[1]);
+		for (i = 0; i < HX_HID_RAW_DATA_TYPE_MAX; i++) {
+			if (buf[1] == g_hx_hid_raw_data_type[i]) {
+				g_core_fp.fp_diag_register_set(ts, buf[1]);
+				break;
+			}
+		}
+		if (i == HX_HID_RAW_DATA_TYPE_MAX) {
+			E("Not support data type");
+			return -EINVAL;
+		}
+		ts->hid_req_cfg.processing_id = ID_TOUCH_MONITOR_SEL;
+		ts->hid_req_cfg.handshake_set = buf[1];
+		break;
+	case ID_REG_RW:
+		if (len == 10 &&
+		    ((union hx_dword_data_t *)&buf[2])->dword != REG_TYPE_EXT_TYPE) {
+			// standard REG RW
+			if (buf[1] == REG_READ)
+				return 0;
+			ts->hid_req_cfg.reg_addr_sz = 4;
+			ts->hid_req_cfg.reg_data_sz = 4;
+			ts->hid_req_cfg.reg_addr.dword =
+				((union hx_dword_data_t *)&buf[2])->dword;
+			ts->hid_req_cfg.reg_addr.dword =
+				cpu_to_le32(ts->hid_req_cfg.reg_addr.dword);
+			memcpy(ts->hid_req_cfg.reg_data, &buf[6], 4);
+			tmp_data = (union hx_dword_data_t *)(ts->hid_req_cfg.reg_data);
+			tmp_data->dword = cpu_to_le32(tmp_data->dword);
+			ret = g_core_fp.fp_register_write(ts,
+				ts->hid_req_cfg.reg_addr.byte,
+				ts->hid_req_cfg.reg_data, 4);
+		} else if ((len >= 9) && (len <= (1 + HID_REG_SZ_MAX)) &&
+			(((union hx_dword_data_t *)&buf[2])->dword == REG_TYPE_EXT_TYPE)) {
+			// ext type REG RW
+			if (buf[1] == REG_READ)
+				return 0;
+			switch (buf[6]) {
+			case REG_TYPE_EXT_AHB:
+				ts->hid_req_cfg.reg_addr_sz = 1;
+				ts->hid_req_cfg.reg_data_sz = len - 1 - 1 - 4 - 1 - 1;
+				ts->hid_req_cfg.reg_addr.dword = buf[7];
+				memcpy(ts->hid_req_cfg.reg_data, &buf[8],
+				       ts->hid_req_cfg.reg_data_sz);
+				ret = himax_bus_write(ts, ts->hid_req_cfg.reg_addr.dword, NULL,
+						      ts->hid_req_cfg.reg_data,
+						      ts->hid_req_cfg.reg_data_sz);
+				break;
+			case REG_TYPE_EXT_SRAM:
+				ts->hid_req_cfg.reg_addr_sz = 4;
+				ts->hid_req_cfg.reg_data_sz = len - 1 - 1 - 4 - 1 - 4;
+				ts->hid_req_cfg.reg_addr.dword =
+					((union hx_dword_data_t *)&buf[7])->dword;
+				ts->hid_req_cfg.reg_addr.dword =
+					cpu_to_le32(ts->hid_req_cfg.reg_addr.dword);
+				memcpy(ts->hid_req_cfg.reg_data, &buf[11],
+				       ts->hid_req_cfg.reg_data_sz);
+				ret = g_core_fp.fp_register_write(ts,
+					ts->hid_req_cfg.reg_addr.byte,
+					ts->hid_req_cfg.reg_data,
+					ts->hid_req_cfg.reg_data_sz);
+				break;
+			default:
+				E("Invalid ext type");
+				return -EINVAL;
+			}
+		} else {
+			E("Invalid reg format!");
+			return -EINVAL;
+		}
+		ts->hid_req_cfg.processing_id = ID_REG_RW;
+		ts->hid_req_cfg.handshake_set = ts->hid_req_cfg.reg_addr.dword;
+		break;
+	case ID_INPUT_RD_DE:
+		ts->hid_req_cfg.processing_id = ID_INPUT_RD_DE;
+		ts->hid_req_cfg.handshake_set = !!buf[1];
+		if (ts->hid_req_cfg.input_RD_de != (!!buf[1])) {
+			ts->hid_req_cfg.input_RD_de = !!buf[1];
+
+			queue_delayed_work(ts->himax_hid_debug_wq, &ts->work_hid_update,
+					   msecs_to_jiffies(0));
+		}
+		break;
+	case ID_CONTACT_COUNT:
+	case ID_CFG:
+	case ID_TOUCH_MONITOR:
+	// case ID_TOUCH_MONITOR_PARTIAL:
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+	};
+
+END:
+	return ret;
+}
+
+static int hx_raw_request(struct hid_device *hid, unsigned char reportnum,
+			  __u8 *buf, size_t len, unsigned char rtype, int reqtype)
+{
+	if (!hid) {
+		E("hid is NULL");
+		return -EINVAL;
+	}
+
+	D("report num %d, len %lu, rtype %d, reqtype %d", reportnum, len, rtype, reqtype);
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		return hx_hid_get_raw_report(hid, reportnum, buf, len, rtype);
+	case HID_REQ_SET_REPORT:
+		if (buf[0] != reportnum)
+			return -EINVAL;
+		return hx_hid_set_raw_report(hid, reportnum, buf, len, rtype);
+	default:
+		return -EIO;
+	}
+
+	return -EINVAL;
+}
+
+static struct hid_ll_driver hx_hid_ll_driver = {
+	.parse = hx_hid_parse,
+	.start = hx_hid_start,
+	.stop = hx_hid_stop,
+	.open = hx_hid_open,
+	.close = hx_hid_close,
+	.raw_request = hx_raw_request
+};
+
+#define HX_HID_HEADER_LEN	3
+#define HX_HID_COOR_LEN	84
+#define HX_HID_DIFF_LEN	(4083 + 12)
+#define HX_HID_MAX_INPUT_LEN  (HX_HID_HEADER_LEN + HX_HID_COOR_LEN + HX_HID_DIFF_LEN)
+
+int hx_hid_report(const struct himax_ts_data *ts, u8 *data, s32 len)
+{
+	int ret = 0;
+
+	if (ts->hid)
+		ret = hid_input_report(ts->hid, HID_INPUT_REPORT, data, len, 1);
+
+	return ret;
+}
+
+static int hx_hid_desc_fetch(struct himax_ts_data *ts)
+{
+	if (!ts)
+		return -EINVAL;
+
+	I("desc_length:           %d", ts->hid_desc.desc_length);
+	I("bcd_version:           0x%x", ts->hid_desc.bcd_version);
+	I("report_desc_length:    %d", ts->hid_desc.report_desc_length);
+	I("max_input_length:      %d", ts->hid_desc.max_input_length);
+	I("max_output_length:     %d", ts->hid_desc.max_output_length);
+	I("max fragment length:   %d", ts->hid_desc.max_fragment_length);
+	I("vendor_id:             0x%x", ts->hid_desc.vendor_id);
+	I("product_id:            0x%x", ts->hid_desc.product_id);
+	I("version_id:            0x%x", ts->hid_desc.version_id);
+	I("flags:                 0x%x", ts->hid_desc.flags);
+
+	return 0;
+}
+
+int hx_hid_probe(struct himax_ts_data *ts)
+{
+	int ret;
+	struct hid_device *hid = NULL;
+
+	if (!ts) {
+		E("ts is NULL");
+		return -EINVAL;
+	}
+
+	ret = hx_hid_desc_fetch(ts);
+	if (ret) {
+		E("failed get hid desc");
+		return ret;
+	}
+
+	hid = ts->hid;
+	if (hid) {
+		hid_destroy_device(hid);
+		hid = NULL;
+	}
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid)) {
+		ret = PTR_ERR(hid);
+		return ret;
+	}
+
+	hid->driver_data = ts;
+	hid->ll_driver = &hx_hid_ll_driver;
+	hid->bus = BUS_SPI;
+	hid->dev.parent = &ts->spi->dev;
+
+	hid->version = ts->hid_desc.bcd_version;
+	hid->vendor = ts->hid_desc.vendor_id;
+	hid->product = ts->hid_desc.product_id;
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-hxtp",
+		 hid->vendor, hid->product);
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		E("failed add hid device");
+		goto err_hid_data;
+	}
+	I("hid init success");
+	ts->hid = hid;
+	mutex_unlock(&ts->hid_ioctl_lock);
+	return 0;
+
+err_hid_data:
+	hid_destroy_device(hid);
+	return ret;
+}
+
+void hx_hid_remove(struct himax_ts_data *ts)
+{
+	mutex_lock(&ts->hid_ioctl_lock);
+	if (ts && ts->hid) {
+		hid_destroy_device(ts->hid);
+	} else {
+		D("ts or hid is NULL");
+		goto OUT;
+	}
+	ts->hid = NULL;
+
+	if (ts->hid_req_cfg.fw) {
+		I("free fw");
+		kfree(ts->hid_req_cfg.fw->data);
+		kfree(ts->hid_req_cfg.fw->priv);
+		kfree(ts->hid_req_cfg.fw);
+		ts->hid_req_cfg.fw = NULL;
+	}
+OUT:
+	mutex_unlock(&ts->hid_ioctl_lock);
+}
diff --git a/drivers/hid/hx-hid/hx_hid.h b/drivers/hid/hx-hid/hx_hid.h
new file mode 100644
index 000000000000..4edaa2be178d
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_hid.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HX_HID_H__
+#define __HX_HID_H__
+// #include "hx_core.h"
+
+enum HID_ID_FUNCT {
+	ID_CONTACT_COUNT = 0x03,
+	ID_CFG = 0x05,
+	ID_REG_RW = 0x06,
+	ID_TOUCH_MONITOR_SEL = 0x07,
+	ID_TOUCH_MONITOR = 0x08,
+	// ID_TOUCH_MONITOR_PARTIAL = 0x09,
+	ID_FW_UPDATE = 0x0A,
+	ID_FW_UPDATE_HANDSHAKING = 0x0B,
+	ID_SELF_TEST = 0x0C,
+	ID_INPUT_RD_DE = 0x31,
+};
+
+enum HID_SELF_TEST_TYPE {
+	HID_SELF_TEST_SHORT = 0x11,
+	HID_SELF_TEST_OPEN = 0x12,
+	HID_SELF_TEST_MICRO_OPEN = 0x13,
+	HID_SELF_TEST_RAWDATA = 0x21,
+	HID_SELF_TEST_NOISE = 0x22,
+
+	HID_SELF_TEST_RESET = 0x01,
+};
+
+enum HID_SELF_TEST_STATUS {
+	HID_SELF_TEST_INIT = 0xF1,
+	HID_SELF_TEST_START = 0xF2,
+	HID_SELF_TEST_ONGOINIG = 0xF3,
+	HID_SELF_TEST_FINISH = 0xFF,
+
+	HID_SELF_TEST_NOT_SUPPORT = 0xE1,
+	HID_SELF_TEST_ERROR = 0xEF
+};
+
+#define HID_RAW_DATA_TYPE_DELTA     (0x09)
+#define HID_RAW_DATA_TYPE_RAW       (0x0A)
+#define HID_RAW_DATA_TYPE_BASELINE  (0x0B)
+#define HID_RAW_DATA_TYPE_NORMAL	(0x00)
+
+enum HID_RAW_DATA_TYPE {
+	HX_HID_RAW_DATA_TYPE_DELTA,
+	HX_HID_RAW_DATA_TYPE_RAW,
+	HX_HID_RAW_DATA_TYPE_BASELINE,
+	HX_HID_RAW_DATA_TYPE_NORMAL,
+	HX_HID_RAW_DATA_TYPE_MAX
+};
+
+enum HID_FW_UPDATE_TYPE {
+	HID_FW_UPDATE_TYPE_BL = 0x77,
+	HID_FW_UPDATE_TYPE_MAIN = 0x55,
+};
+
+enum HID_FW_UPDATE_STATUS_CODE {
+	FWUP_ERROR_NO_ERROR = 0x77,
+	FWUP_ERROR_MCU_00 = 0x00,
+	FWUP_ERROR_MCU_A0 = 0xA0,
+	FWUP_ERROR_NO_BL = 0xC1,
+	FWUP_ERROR_NO_MAIN = 0xC2,
+	FWUP_ERROR_BL_COMPLETE = 0xB1,
+	FWUP_ERROR_BL = 0xB2,
+	FWUP_ERROR_PW = 0xB3,
+	FWUP_ERROR_ERASE_FLASH = 0xB4,
+	FWUP_ERROR_FLASH_PROGRAMMING = 0xB5,
+	FWUP_ERROR_NO_DEVICE = 0xFFFFFF00,
+	FWUP_ERROR_LOAD_FW_BIN = 0xFFFFFF01,
+	FWUP_ERROR_INITIAL = 0xFFFFFF02,
+	FWUP_ERROR_POLLING_TIMEOUT = 0xFFFFFF03,
+	FWUP_ERROR_FW_TRANSFER = 0xFFFFFF04
+};
+
+struct himax_ts_data;
+union host_ext_rd_t;
+union heatmap_rd_t;
+
+extern const unsigned int host_ext_report_desc_sz;
+extern const unsigned int host_heatmap_report_desc_sz;
+
+extern union host_ext_rd_t g_host_ext_rd;
+
+extern union heatmap_rd_t g_heatmap_rd;
+
+#define HID_FW_UPDATE_BL_CMD    (0x77)
+#define HID_FW_UPDATE_MAIN_CMD  (0x55)
+
+int hx_hid_probe(struct himax_ts_data *ts);
+void hx_hid_remove(struct himax_ts_data *ts);
+
+void hx_hid_update_info(struct himax_ts_data *ts);
+int hx_hid_report(const struct himax_ts_data *ts, u8 *data, s32 len);
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_ic_83102j.c b/drivers/hid/hx-hid/hx_ic_83102j.c
new file mode 100644
index 000000000000..6af62c0129de
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_ic_83102j.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_ic_83102j.h"
+#include "hx_plat.h"
+
+struct himax_core_command_regs g_core_regs;
+
+static void hx83102j_reload_to_active(struct himax_ts_data *ts)
+{
+	struct hx_reg_t addr = {0};
+	u8 retry_cnt = 0;
+
+	DEF_WORD_DATA(data);
+	WORD_REG(addr, 0x90000048);
+
+	do {
+		VAL_SET(data, 0xEC);
+		g_core_fp.fp_reg_write(ts, &addr, &data);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_reg_read(ts, &addr, &data);
+		I("data[1]=%d, data[0]=%d, retry_cnt=%d",
+		  data.data.byte[1], data.data.byte[0], retry_cnt);
+		retry_cnt++;
+	} while ((data.data.byte[1] != 0x01 ||
+		data.data.byte[0] != 0xEC) &&
+		retry_cnt < HIMAX_REG_RETRY_TIMES);
+}
+
+static void hx83102j_en_hw_crc(struct himax_ts_data *ts, int en)
+{
+	struct hx_reg_t addr = {0};
+	u8 retry_cnt = 0;
+
+	DEF_WORD_DATA(data);
+	DEF_WORD_DATA(wrt_data);
+	WORD_REG(addr, HX83102j_ic_addr_hw_crc);
+
+	if (en)
+		VAL_SET(data, HX83102j_data_hw_crc);
+	else
+		VAL_SET(data, fw_data_clear);
+
+	do {
+		PTR_SET(wrt_data, data.data.byte, data.len);
+		g_core_fp.fp_reg_write(ts, &addr, &data);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_reg_read(ts, &addr, &data);
+		I("ECC data[1]=%d, data[0]=%d, retry_cnt=%d",
+		  data.data.byte[1], data.data.byte[0], retry_cnt);
+		retry_cnt++;
+	} while ((data.data.byte[1] != wrt_data.data.byte[1] ||
+		data.data.byte[0] != wrt_data.data.byte[0]) &&
+		retry_cnt < HIMAX_REG_RETRY_TIMES);
+}
+
+static void hx83102j_resume_ic_action(struct himax_ts_data *ts)
+{
+	hx83102j_reload_to_active(ts);
+}
+
+static bool hx83102j_chip_detect(struct himax_ts_data *ts)
+{
+	DEF_WORD_DATA(tmp_data);
+	struct hx_reg_t tmp_addr;
+	bool ret_data = false;
+	int ret = 0;
+	int i = 0;
+	bool check_flash;
+
+	g_core_fp.fp_pin_reset(ts);
+	ret = himax_bus_read(ts, 0x13, tmp_data.data.byte, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return false;
+	}
+
+	if (!ts->ic_data->has_flash)
+		check_flash = false;
+	else
+		check_flash = true;
+
+	if (g_core_fp.fp_sense_off(ts, check_flash) == false) {
+		ret_data = false;
+		E("hx83102_sense_off Fail!");
+		return ret_data;
+	}
+
+	for (i = 0; i < 5; i++) {
+		WORD_REG(tmp_addr, 0x900000D0);
+		ret = g_core_fp.fp_reg_read(ts, &tmp_addr, &tmp_data);
+		if (ret != 0) {
+			ret_data = false;
+			E("read ic id Fail");
+			return ret_data;
+		}
+
+		if (((*tmp_data.data.word) & 0x83102900) == 0x83102900) {
+			strscpy(ts->chip_name,
+				HX83102J_ID, 30);
+			(ts->ic_data)->ic_adc_num =
+				hx83102j_data_adc_num;
+			ts->ic_data->flash_size = HX83102J_FLASH_SIZE;
+			ts->ic_data->icid = *tmp_data.data.word;
+			I("detect IC HX83102J successfully");
+			ret_data = true;
+			break;
+		}
+		E("Read driver IC ID = %X,%X,%X",
+		  tmp_data_array[3],
+		  tmp_data_array[2], tmp_data_array[1]); /*83,10,2X*/
+		ret_data = false;
+		E("Read driver ID register Fail!");
+		E("Could NOT find Himax Chipset");
+		E("Please check:\n1.VCCD,VCCA,VSP,VSN");
+		E("2. LCM_RST,TP_RST");
+		E("3. Power On Sequence");
+	}
+
+	return ret_data;
+}
+
+static void hx83102j_sense_on(struct himax_ts_data *ts, u8 flash_mode)
+{
+	int ret = 0;
+
+	DEF_WORD_DATA(tmp_data);
+
+	I("Enter");
+	ts->notouch_frame = ts->ic_notouch_frame;
+	g_core_fp.fp_interface_on(ts);
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	usleep_range(10000, 11000);
+	if (!flash_mode) {
+		g_core_fp.fp_ic_reset(ts, false, false);
+	} else {
+		tmp_data.data.half[0] = 0;
+		ret = himax_bus_write(ts, IC_GET_ARRAY(adr_i2c_psw_lb)[0], NULL,
+				      tmp_data.data.byte, 2);
+		if (ret < 0) {
+			E("cmd=%x bus access fail!",
+			  IC_GET_ARRAY(adr_i2c_psw_lb)[0]);
+		}
+	}
+	if (!ts->ic_data->has_flash) {
+		if (g_core_fp._en_hw_crc)
+			g_core_fp._en_hw_crc(ts, 1);
+		hx83102j_reload_to_active(ts);
+	}
+}
+
+static bool hx83102j_sense_off(struct himax_ts_data *ts, bool check_en)
+{
+	u32 cnt = 0;
+	struct hx_reg_t tmp_addr = {0};
+	int ret = 0;
+
+	DEF_WORD_DATA(tmp_data);
+
+	do {
+		if (cnt == 0 ||
+		    (tmp_data.data.byte[0] != 0xA5 &&
+		    tmp_data.data.byte[0] != 0x00 &&
+		    tmp_data.data.byte[0] != 0x87))
+			g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+				FW_GET_ARRAY(data_fw_stop), FW_GET_SZ(data_fw_stop));
+		usleep_range(10000, 10001);
+
+		/* check fw status */
+		g_core_fp.fp_register_read(ts, IC_GET_ARRAY(addr_cs_central_state),
+			tmp_data.data.byte, tmp_data.len);
+
+		if (tmp_data.data.byte[0] != 0x05) {
+			I("Do not need wait FW, Status = 0x%02X!", tmp_data.data.byte[0]);
+			break;
+		}
+
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+			tmp_data.data.byte, tmp_data.len);
+		I("cnt = %d, data[0] = 0x%02X!", cnt, tmp_data.data.byte[0]);
+	} while (tmp_data.data.byte[0] != 0x87 && ++cnt < 35 && check_en);
+
+	cnt = 0;
+
+	do {
+		/**
+		 * set Enter safe mode : 0x31 ==> 0x9527
+		 */
+		tmp_data.data.half[0] = 0x9527;
+		ret = himax_bus_write(ts, 0x31, NULL, tmp_data.data.byte, 2);
+		if (ret < 0) {
+			E("bus access fail!");
+			return false;
+		}
+
+		/**
+		 *Check enter_save_mode
+		 */
+		WORD_REG(tmp_addr, 0x900000A8);
+		g_core_fp.fp_reg_read(ts, &tmp_addr, &tmp_data);
+		I("Check enter_save_mode data[0]=%X", tmp_data.data.byte[0]);
+
+		if (tmp_data.data.byte[0] == 0x0C) {
+			/**
+			 *Reset TCON
+			 */
+			WORD_REG(tmp_addr, 0x80020004);
+			VAL_SET(tmp_data, 0x00000000);
+			g_core_fp.fp_reg_write(ts, &tmp_addr, &tmp_data);
+			usleep_range(1000, 1001);
+			return true;
+		}
+		usleep_range(5000, 5001);
+		g_core_fp.fp_pin_reset(ts);
+	} while (cnt++ < 5);
+
+	return false;
+}
+
+static bool hx83102j_read_event_stack(struct himax_ts_data *ts,
+				      u8 *buf, u32 length)
+{
+	int ret = 0;
+
+	ret = himax_bus_read(ts, FW_GET_ARRAY(addr_event_addr)[0], buf, length);
+
+	return (ret == NO_ERR) ? true : false;
+}
+
+static void hx83102j_chip_init(struct himax_ts_data *ts)
+{
+	ts->chip_cell_type = CHIP_IS_IN_CELL;
+	ts->chip_max_dsram_size = 73728;
+	I("IC cell type = %d", ts->chip_cell_type);
+	ts->ic_checksum_type = HX_TP_BIN_CHECKSUM_CRC;
+	/*Himax: Set FW and CFG Flash Address*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_fw_ver_major, 59397);	/*0x00E805*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_fw_ver_minor, 59398);	/*0x00E806*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cfg_ver_major, 59648);	/*0x00E900*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cfg_ver_minor, 59649);	/*0x00E901*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cid_ver_major, 59394);	/*0x00E802*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cid_ver_minor, 59395);	/*0x00E803*/
+	WORD_REG(g_core_regs.flash_ver_info.addr_cfg_table, 0x10000);
+	g_core_regs.flash_ver_info.addr_cfg_table_t.data.word =
+		g_core_regs.flash_ver_info.addr_cfg_table.data.word;
+	ts->ic_data->enc16bits = false;
+#ifdef CONFIG_HX_HID_HAS_FLASH
+	ts->ic_data->has_flash = true;
+#else
+	ts->ic_data->has_flash = false;
+#endif
+}
+
+static void himax_reg_overlay(struct himax_ts_data *ts)
+{
+	I("Entering!");
+	ts->ic_notouch_frame = hx83102j_notouch_frame;
+	WORD_REG(g_core_regs.fw_op.addr_raw_out_sel, hx83102j_fw_addr_raw_out_sel);
+	WORD_REG(g_core_regs.driver_op.data_df_rx, hx83102j_data_df_rx);
+	WORD_REG(g_core_regs.driver_op.data_df_tx, hx83102j_data_df_tx);
+	WORD_REG(g_core_regs.ic_op.addr_tcon_on_rst, hx83102j_ic_adr_tcon_rst);
+}
+
+static void hx83102j_pin_reset(struct himax_ts_data *ts)
+{
+	I("Now reset the Touch chip.");
+	himax_rst_gpio_set(ts->rst_gpio, 0);
+	usleep_range(100 * 100, 101 * 100);
+	himax_rst_gpio_set(ts->rst_gpio, 1);
+	usleep_range(200 * 100, 201 * 100);
+}
+
+static void himax_fp_overlay(void)
+{
+	I("Entering!");
+	g_core_fp.fp_chip_detect = hx83102j_chip_detect;
+	g_core_fp.fp_chip_init = hx83102j_chip_init;
+	g_core_fp.fp_sense_on = hx83102j_sense_on;
+	g_core_fp.fp_sense_off = hx83102j_sense_off;
+	g_core_fp.fp_read_event_stack = hx83102j_read_event_stack;
+	g_core_fp.fp_pin_reset = hx83102j_pin_reset;
+	g_core_fp.fp_resume_ic_action = hx83102j_resume_ic_action;
+	g_core_fp.fp_0f_reload_to_active = hx83102j_reload_to_active;
+	g_core_fp._en_hw_crc = hx83102j_en_hw_crc;
+}
+
+static int __init himax_ic_init(void)
+{
+	int ret = 0;
+	// set default regs
+	himax_ic_reg_init(&g_core_regs);
+	himax_ic_fp_init();
+	// basic struct init
+	g_himax_ts = kzalloc(sizeof(*g_himax_ts), GFP_KERNEL);
+	if (!g_himax_ts) {
+		E("allocate himax_ts_data failed");
+		ret = -ENOMEM;
+		goto err_alloc_data_failed;
+	}
+	INIT_LIST_HEAD(&g_himax_ts->list);
+	// init ic specific params
+	himax_reg_overlay(g_himax_ts);
+	himax_fp_overlay();
+
+	// add to ic module list
+	ret = himax_spi_drv_init(g_himax_ts);
+	if (ret) {
+		E("himax_spi_drv_init failed");
+		kfree(g_himax_ts);
+		g_himax_ts = NULL;
+	}
+
+err_alloc_data_failed:
+	return ret;
+}
+
+static void __exit himax_ic_exit(void)
+{
+	himax_spi_drv_exit();
+}
+
+#if defined(__HIMAX_MOD__)
+module_init(himax_ic_init);
+#else
+late_initcall(himax_ic_init);
+#endif
+module_exit(himax_ic_exit);
+
+MODULE_DESCRIPTION("Himax SPI driver for HID simulator for " HX83102J_ID);
+MODULE_AUTHOR("Himax, Inc.");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(HIMAX_DRIVER_VER);
diff --git a/drivers/hid/hx-hid/hx_ic_83102j.h b/drivers/hid/hx-hid/hx_ic_83102j.h
new file mode 100644
index 000000000000..373270e5b271
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_ic_83102j.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HX_IC_83102J_H__
+#define __HX_IC_83102J_H__
+
+#include "hx_ic_core.h"
+
+extern struct himax_core_fp g_core_fp;
+
+#define hx83102d_fw_addr_raw_out_sel      0x800204f4
+#define hx83102d_zf_data_adc_cfg_1        0x10007B00
+#define hx83102d_zf_data_adc_cfg_2        0x10006A00
+#define hx83102d_zf_data_adc_cfg_3        0x10007500
+#define hx83102d_zf_data_bor_prevent_info 0x10007268
+#define hx83102d_zf_data_notch_info       0x10007300
+#define hx83102d_zf_func_info_en          0x10007FD0
+#define hx83102d_zf_po_sub_func           0x10005A00
+#define hx83102d_zf_data_sram_start_addr  0x20000000
+#define hx83102d_adr_osc_en               0x9000009C
+#define hx83102d_adr_osc_pw               0x90000280
+#define hx83102d_data_adc_num             48
+#define hx83102d_notouch_frame            0
+
+#define hx83102e_fw_addr_raw_out_sel 0x100072EC
+#define hx83102e_ic_adr_tcon_rst     0x80020004
+#define hx83102e_data_df_rx          48
+#define hx83102e_data_df_tx          30
+#define hx83102e_data_adc_num        400 /* 200x2 */
+#define hx83102e_notouch_frame       0
+
+#define hx83102j_fw_addr_raw_out_sel 0x100072EC
+#define hx83102j_ic_adr_tcon_rst     0x80020004
+#define hx83102j_data_df_rx          48
+#define hx83102j_data_df_tx          30
+#define hx83102j_data_adc_num        400 /* 200x2 */
+#define hx83102j_notouch_frame       0
+#define HX83102J_FLASH_SIZE        261120
+
+#define HX83102j_ic_addr_hw_crc 0x80010000
+#define HX83102j_data_hw_crc 0x0000ECCE
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_ic_core.c b/drivers/hid/hx-hid/hx_ic_core.c
new file mode 100644
index 000000000000..f1a53a5b8ccf
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_ic_core.c
@@ -0,0 +1,3260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_ic_core.h"
+#include "hx_plat.h"
+#include "hx_hid.h"
+
+/* CORE_IC */
+/* IC side start*/
+static void himax_mcu_burst_enable(struct himax_ts_data *ts,
+				   u8 auto_add_4_byte)
+{
+	u8 tmp_data[DATA_LEN_4];
+	int ret;
+
+	/*I("Entering");*/
+	tmp_data[0] = IC_GET_VAL(data_conti);
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_conti), NULL, tmp_data, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return;
+	}
+
+	tmp_data[0] = (IC_GET_VAL(data_incr4) | auto_add_4_byte);
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_incr4), NULL, tmp_data, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return;
+	}
+}
+
+static int himax_mcu_register_read(struct himax_ts_data *ts, u8 *addr,
+				   u8 *buf, u32 len)
+{
+	int ret = -1;
+
+	mutex_lock(&ts->reg_lock);
+
+	if (memcmp(addr, FLASH_GET_ARRAY(addr_spi200_data), 4) == 0)
+		g_core_fp.fp_burst_enable(ts, 0);
+	else if (len > DATA_LEN_4)
+		g_core_fp.fp_burst_enable(ts, 1);
+	else
+		g_core_fp.fp_burst_enable(ts, 0);
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_addr_byte_0), addr, NULL, 4);
+	if (ret < 0) {
+		E("bus access fail!");
+		mutex_unlock(&ts->reg_lock);
+		return BUS_FAIL;
+	}
+
+	ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_access_direction), NULL,
+			      IC_GET_ARRAY(data_ahb_access_direction_read), 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		mutex_unlock(&ts->reg_lock);
+		return BUS_FAIL;
+	}
+
+	ret = himax_bus_read(ts, IC_GET_VAL(addr_ahb_rdata_byte_0), buf, len);
+	if (ret < 0) {
+		E("bus access fail!");
+		mutex_unlock(&ts->reg_lock);
+		return BUS_FAIL;
+	}
+
+	mutex_unlock(&ts->reg_lock);
+
+	return NO_ERR;
+}
+
+static int himax_mcu_reg_read(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			      struct data_pack_t *data)
+{
+	return g_core_fp.fp_register_read(ts,
+		addr->data.byte, data->data.byte, data->len);
+}
+
+static int himax_mcu_register_write(struct himax_ts_data *ts, u8 *addr,
+				    u8 *val, u32 len)
+{
+	int ret = -1;
+	const u32 max_trans_sz = 4 * 1024;
+	int i = 0;
+	u32 orig_addr = 0;
+	union hx_dword_data_t temp_addr = {0};
+	u32 temp_len = 0;
+
+	mutex_lock(&ts->reg_lock);
+
+	if (memcmp(addr, FLASH_GET_ARRAY(addr_spi200_data), 4) == 0)
+		g_core_fp.fp_burst_enable(ts, 0);
+	else if (len > DATA_LEN_4)
+		g_core_fp.fp_burst_enable(ts, 1);
+	else
+		g_core_fp.fp_burst_enable(ts, 0);
+
+	if (len > max_trans_sz) {
+		orig_addr = le32_to_cpup((__le32 *)addr);
+		for (i = 0; i < len; i += max_trans_sz) {
+			if ((len - i) > max_trans_sz)
+				temp_len = max_trans_sz;
+			else
+				temp_len = len % max_trans_sz;
+			temp_addr.dword = cpu_to_le32(orig_addr + i);
+			ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_addr_byte_0),
+					      temp_addr.byte, val + i, temp_len + ADDR_LEN_4);
+			if (ret < 0) {
+				E("xfer fail!");
+				mutex_unlock(&ts->reg_lock);
+				return BUS_FAIL;
+			}
+		}
+	} else {
+		ret = himax_bus_write(ts, IC_GET_VAL(addr_ahb_addr_byte_0), addr, val,
+				      len + ADDR_LEN_4);
+		if (ret < 0) {
+			E("xfer fail!");
+			mutex_unlock(&ts->reg_lock);
+			return BUS_FAIL;
+		}
+	}
+
+	mutex_unlock(&ts->reg_lock);
+
+	return NO_ERR;
+}
+
+static int himax_mcu_reg_write(struct himax_ts_data *ts,
+			       struct hx_reg_t *addr, struct data_pack_t *data)
+{
+	return g_core_fp.fp_register_write(ts,
+		addr->data.byte, data->data.byte, data->len);
+}
+
+static int himax_write_read_reg(struct himax_ts_data *ts, u8 *tmp_addr,
+				u8 *tmp_data, u8 hb, u8 lb)
+{
+	u16 retry = 0;
+	union hx_dword_data_t r_data = {0};
+	union hx_dword_data_t t_addr = {0};
+	union hx_dword_data_t t_data = {0};
+
+	memcpy(t_addr.byte, tmp_addr, ADDR_LEN_4);
+	memcpy(t_data.byte, tmp_data, DATA_LEN_4);
+
+	while (retry++ < 40) { /* ceil[16.6*2] */
+		g_core_fp.fp_register_read(ts, t_addr.byte, r_data.byte, DATA_LEN_4);
+		D("Read handshake = 0x%08X:0x%08X", le32_to_cpu(t_addr.dword),
+		  le32_to_cpu(r_data.dword));
+		if (r_data.byte[1] == lb && r_data.byte[0] == hb)
+			break;
+		else if (r_data.byte[1] == hb && r_data.byte[0] == lb)
+			return NO_ERR;
+
+		g_core_fp.fp_register_write(ts, t_addr.byte, t_data.byte, DATA_LEN_4);
+		D("Write handshake = 0x%08X:0x%08X", le32_to_cpu(t_addr.dword),
+		  le32_to_cpu(t_data.dword));
+		usleep_range(1000, 1100);
+	}
+
+	if (retry >= 40)
+		goto FAIL;
+
+	retry = 0;
+	while (retry++ < 200) { /* self test item might take long time */
+		g_core_fp.fp_register_read(ts, t_addr.byte, r_data.byte, DATA_LEN_4);
+		if (r_data.byte[1] == hb && r_data.byte[0] == lb)
+			return NO_ERR;
+
+		D("wait data ready %d times, handshake = 0x%08X:0x%08X", retry,
+		  le32_to_cpu(t_addr.dword), le32_to_cpu(r_data.dword));
+		usleep_range(10000, 10100);
+	}
+
+FAIL:
+	E("failed to handshaking with DSRAM");
+	E("addr = 0x%02X%02X%02X%02X; data = 0x%02X%02X%02X%02X",
+	  tmp_addr[3], tmp_addr[2], tmp_addr[1], tmp_addr[0],
+	  tmp_data[3], tmp_data[2], tmp_data[1], tmp_data[0]);
+	E("target = %02X%02X; r_data = %02X%02X",
+	  hb, lb, r_data.byte[1], r_data.byte[0]);
+
+	return HX_RW_REG_FAIL;
+}
+
+static void himax_mcu_interface_on(struct himax_ts_data *ts)
+{
+	u8 tmp_data[DATA_LEN_4];
+	u8 tmp_data2[DATA_LEN_4];
+	int cnt = 0;
+	int ret = 0;
+
+	/* Read a dummy register to wake up BUS.*/
+	ret = himax_bus_read(ts, IC_GET_VAL(addr_ahb_rdata_byte_0), tmp_data,
+			     DATA_LEN_4);
+	if (ret < 0) {/* to knock BUS*/
+		E("bus access fail!");
+		return;
+	}
+
+	do {
+		tmp_data[0] = IC_GET_VAL(data_conti);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(addr_conti), NULL, tmp_data, 1);
+		if (ret < 0) {
+			E("bus access fail!");
+			return;
+		}
+
+		tmp_data[0] = IC_GET_VAL(data_incr4);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(addr_incr4), NULL, tmp_data, 1);
+		if (ret < 0) {
+			E("bus access fail!");
+			return;
+		}
+
+		/*Check cmd*/
+		himax_bus_read(ts, IC_GET_VAL(addr_conti), tmp_data, 1);
+		himax_bus_read(ts, IC_GET_VAL(addr_incr4), tmp_data2, 1);
+
+		if (tmp_data[0] == IC_GET_VAL(data_conti) &&
+		    tmp_data2[0] == IC_GET_VAL(data_incr4))
+			break;
+
+		usleep_range(1000, 1100);
+	} while (++cnt < 10);
+
+	if (cnt > 0)
+		I("Polling burst mode: %d times", cnt);
+}
+
+static void himax_mcu_sense_on(struct himax_ts_data *ts, u8 flash_mode)
+{
+	u8 tmp_data[DATA_LEN_4];
+	int retry = 0;
+	int ret = 0;
+
+	I("Enter");
+	ts->notouch_frame = ts->ic_notouch_frame;
+	g_core_fp.fp_interface_on(ts);
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	usleep_range(10000, 11000);
+	if (!flash_mode) {
+		g_core_fp.fp_ic_reset(ts, false, false);
+	} else {
+		do {
+			g_core_fp.fp_register_read(ts,
+				FW_GET_ARRAY(addr_flag_reset_event),
+				tmp_data, DATA_LEN_4);
+			I("Read status from IC = %X,%X", tmp_data[0], tmp_data[1]);
+		} while ((tmp_data[1] != 0x01 ||
+			tmp_data[0] != 0x00) &&
+			retry++ < 5);
+
+		if (retry >= 5) {
+			E("Fail");
+			g_core_fp.fp_ic_reset(ts, false, false);
+		} else {
+			I("OK and Read status from IC = %X,%X",
+			  tmp_data[0], tmp_data[1]);
+			/* reset code*/
+			tmp_data[0] = 0x00;
+
+			ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_lb), NULL,
+					      tmp_data, 1);
+			if (ret < 0) {
+				E("cmd=%x bus access fail!",
+				  IC_GET_VAL(adr_i2c_psw_lb));
+			}
+			ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_ub), NULL,
+					      tmp_data, 1);
+			if (ret < 0) {
+				E("cmd=%x bus access fail!",
+				  IC_GET_VAL(adr_i2c_psw_ub));
+			}
+		}
+	}
+}
+
+static bool himax_mcu_sense_off(struct himax_ts_data *ts, bool check_en)
+{
+	u8 cnt = 0;
+	u8 tmp_data[DATA_LEN_4];
+	int ret = 0;
+
+	do {
+		tmp_data[0] = IC_GET_VAL(data_i2c_psw_lb);
+		tmp_data[1] = IC_GET_VAL(data_i2c_psw_ub);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_lb), NULL, tmp_data,
+				      2);
+		if (ret < 0) {
+			E("bus access fail!");
+			return false;
+		}
+
+		g_core_fp.fp_register_read(ts, IC_GET_ARRAY(addr_cs_central_state),
+			tmp_data, ADDR_LEN_4);
+		I("Check enter_save_mode data[0]=%X", tmp_data[0]);
+
+		if (tmp_data[0] == 0x0C) {
+			g_core_fp.fp_register_write(ts, IC_GET_ARRAY(addr_tcon_on_rst),
+				IC_GET_ARRAY(data_rst), DATA_LEN_4);
+			usleep_range(1000, 1100);
+
+			g_core_fp.fp_register_write(ts, IC_GET_ARRAY(addr_adc_on_rst),
+				IC_GET_ARRAY(data_rst), DATA_LEN_4);
+			usleep_range(1000, 1100);
+			tmp_data[3] = IC_GET_ARRAY(data_rst)[3];
+			tmp_data[2] = IC_GET_ARRAY(data_rst)[2];
+			tmp_data[1] = IC_GET_ARRAY(data_rst)[1];
+			tmp_data[0] = IC_GET_ARRAY(data_rst)[0] | 0x01;
+			g_core_fp.fp_register_write(ts, IC_GET_ARRAY(addr_adc_on_rst),
+				tmp_data, DATA_LEN_4);
+			goto TRUE_END;
+		} else {
+			/* usleep_range(10000, 10001); */
+			g_core_fp.fp_ic_reset(ts, false, false);
+		}
+	} while (cnt++ < 15);
+
+	return false;
+TRUE_END:
+	return true;
+}
+
+#define WIP_PRT_LOG "retry:%d, bf[0]=%d, bf[1]=%d,bf[2]=%d, bf[3]=%d"
+static bool himax_mcu_wait_wip(struct himax_ts_data *ts, int timing)
+{
+	u8 tmp_data[DATA_LEN_4];
+	int retry_cnt = 0;
+
+	g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_trans_fmt),
+		FLASH_GET_ARRAY(data_spi200_trans_fmt), DATA_LEN_4);
+	tmp_data[0] = 0x01;
+
+	do {
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+			FLASH_GET_ARRAY(data_spi200_trans_ctrl_1), DATA_LEN_4);
+
+		g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_cmd),
+			FLASH_GET_ARRAY(data_spi200_cmd_1), DATA_LEN_4);
+		memset(tmp_data, 0xFF, DATA_LEN_4);
+		g_core_fp.fp_register_read(ts, FLASH_GET_ARRAY(addr_spi200_data),
+			tmp_data, 4);
+
+		if ((tmp_data[0] & 0x01) == 0x00)
+			return true;
+
+		retry_cnt++;
+
+		if (tmp_data[0] != 0x00 ||
+		    tmp_data[1] != 0x00 ||
+		    tmp_data[2] != 0x00 ||
+		    tmp_data[3] != 0x00)
+			I(WIP_PRT_LOG,
+			  retry_cnt, tmp_data[0],
+			  tmp_data[1], tmp_data[2], tmp_data[3]);
+
+		if (retry_cnt > 100) {
+			E("Wait wip error!");
+			return false;
+		}
+
+		usleep_range(timing * 1000, timing * 1000 + 1);
+	} while ((tmp_data[0] & 0x01) == 0x01);
+
+	return true;
+}
+
+/*power saving level*/
+static void himax_mcu_init_psl(struct himax_ts_data *ts)
+{
+	g_core_fp.fp_register_write(ts, IC_GET_ARRAY(addr_psl),
+		IC_GET_ARRAY(data_rst), IC_GET_SZ(data_rst));
+	I("power saving level reset OK!");
+}
+
+static void himax_mcu_resume_ic_action(struct himax_ts_data *ts)
+{
+	/* Nothing to do */
+}
+
+static void himax_mcu_suspend_ic_action(struct himax_ts_data *ts)
+{
+	/* Nothing to do */
+}
+
+static void himax_mcu_power_on_init(struct himax_ts_data *ts)
+{
+	union hx_dword_data_t tmp_data = { .byte = {0x01, 0x00, 0x00, 0x00} };
+	u8 retry = 0;
+
+	/*RawOut select initial*/
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	/*DSRAM func initial*/
+	g_core_fp.fp_assign_sorting_mode(ts, FW_GET_ARRAY(data_clear));
+	/*N frame initial*/
+	/* reset N frame back to default value 1 for normal mode */
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_set_frame_addr),
+		tmp_data.byte, 4);
+	/*FW reload done initial*/
+	g_core_fp.fp_register_write(ts,
+		DRV_GET_ARRAY(addr_fw_define_2nd_flash_reload),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+
+	g_core_fp.fp_sense_on(ts, 0x00);
+
+	I("waiting for FW reload data");
+
+	while (retry++ < 30) {
+		g_core_fp.fp_register_read(ts,
+			DRV_GET_ARRAY(addr_fw_define_2nd_flash_reload), tmp_data.byte,
+			DATA_LEN_4);
+
+		/* use all 4 bytes to compare */
+		if (le32_to_cpu(tmp_data.dword) == 0x72C0) {
+			I("FW reload done");
+			break;
+		}
+		I("wait FW reload %d times", retry);
+		g_core_fp.fp_read_FW_status(ts);
+		usleep_range(10000, 11000);
+	}
+}
+
+/* IC side end*/
+/* CORE_IC */
+
+/* CORE_FW */
+/* FW side start*/
+static void himax_mcu_system_reset(struct himax_ts_data *ts)
+{
+	int ret = 0;
+	u8 tmp_data[DATA_LEN_4];
+	int retry = 0;
+
+	g_core_fp.fp_interface_on(ts);
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_ctrl_fw_isr),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	do {
+		/* reset code*/
+		/**
+		 * I2C_password[7:0] set Enter safe mode : 0x31 ==> 0x27
+		 */
+		tmp_data[0] = IC_GET_VAL(data_i2c_psw_lb);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_lb), NULL, tmp_data,
+				      1);
+		if (ret < 0)
+			E("bus access fail!");
+
+		/**
+		 * I2C_password[15:8] set Enter safe mode :0x32 ==> 0x95
+		 */
+		tmp_data[0] = IC_GET_VAL(data_i2c_psw_ub);
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_ub), NULL, tmp_data,
+				      1);
+		if (ret < 0)
+			E("bus access fail!");
+
+		/**
+		 * I2C_password[7:0] set Enter safe mode : 0x31 ==> 0x00
+		 */
+		tmp_data[0] = 0x00;
+
+		ret = himax_bus_write(ts, IC_GET_VAL(adr_i2c_psw_lb), NULL, tmp_data,
+				      1);
+		if (ret < 0)
+			E("bus access fail!");
+
+		usleep_range(10000, 11000);
+
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_flag_reset_event),
+			tmp_data, DATA_LEN_4);
+		I("Read status from IC = %X,%X", tmp_data[0], tmp_data[1]);
+	} while ((tmp_data[1] != 0x02 || tmp_data[0] != 0x00) && retry++ < 5);
+}
+
+static int himax_mcu_calculate_crc_with_ap(const unsigned char *FW_content,
+					   int CRC_from_FW, int len)
+{
+	int i, j, length = 0;
+	int fw_data;
+	int fw_data_2;
+	int CRC = 0xFFFFFFFF;
+	int polynomial = 0x82F63B78;
+
+	length = len / 4;
+
+	for (i = 0; i < length; i++) {
+		fw_data = FW_content[i * 4];
+
+		for (j = 1; j < 4; j++) {
+			fw_data_2 = FW_content[i * 4 + j];
+			fw_data += (fw_data_2) << (8 * j);
+		}
+		CRC = fw_data ^ CRC;
+		for (j = 0; j < 32; j++) {
+			if ((CRC % 2) != 0)
+				CRC = ((CRC >> 1) & 0x7FFFFFFF) ^ polynomial;
+			else
+				CRC = (((CRC >> 1) & 0x7FFFFFFF));
+		}
+	}
+
+	return CRC;
+}
+
+static u32 himax_mcu_check_crc(struct himax_ts_data *ts,
+			       u8 *start_addr, int reload_length)
+{
+	u32 result = 0;
+	union {
+		u8 byte[4];
+		u16 word[2];
+		u32 dword;
+	} tmp_data = {0};
+	int cnt = 0, ret = 0;
+	int length = reload_length / DATA_LEN_4;
+
+	ret = g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_reload_addr_from),
+		start_addr, DATA_LEN_4);
+	if (ret < NO_ERR) {
+		E("bus access fail!");
+		return HW_CRC_FAIL;
+	}
+
+	tmp_data.word[1] = 0x0099;
+	tmp_data.word[1] = cpu_to_le16(tmp_data.word[1]);
+	tmp_data.word[0] = length;
+	tmp_data.word[0] = cpu_to_le16(tmp_data.word[0]);
+	ret = g_core_fp.fp_register_write(ts,
+		FW_GET_ARRAY(addr_reload_addr_cmd_beat), tmp_data.byte, DATA_LEN_4);
+	if (ret < NO_ERR) {
+		E("bus access fail!");
+		return HW_CRC_FAIL;
+	}
+	tmp_data.word[0] = 0x0000;
+
+	ret = g_core_fp.fp_register_read(ts,
+		FW_GET_ARRAY(addr_reload_addr_cmd_beat), tmp_data.byte, DATA_LEN_4);
+
+	if (le16_to_cpu(tmp_data.word[0]) != length) {
+		E("Flash content is Wrong");
+		return HW_CRC_FAIL;
+	}
+
+	cnt = 0;
+
+	do {
+		ret = g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_reload_status),
+			tmp_data.byte, DATA_LEN_4);
+		if (ret < NO_ERR) {
+			E("bus access fail!");
+			return HW_CRC_FAIL;
+		}
+
+		if ((tmp_data.byte[0] & 0x01) != 0x01) {
+			ret = g_core_fp.fp_register_read(ts,
+				FW_GET_ARRAY(addr_reload_crc32_result), tmp_data.byte,
+				DATA_LEN_4);
+			if (ret < NO_ERR) {
+				E("bus access fail!");
+				return HW_CRC_FAIL;
+			}
+			I("data[3]=%X,data[2]=%X,data[1]=%X,data[0]=%X",
+			  tmp_data.byte[3],
+			  tmp_data.byte[2],
+			  tmp_data.byte[1],
+			  tmp_data.byte[0]);
+			result = tmp_data.dword;
+			goto END;
+		} else {
+			I("Waiting for HW ready!");
+			usleep_range(1000, 1100);
+			if (cnt >= 100)
+				g_core_fp.fp_read_FW_status(ts);
+		}
+
+	} while (cnt++ < 100);
+END:
+	return result;
+}
+
+static void himax_mcu_set_reload_cmd(u8 *write_data, int idx,
+				     u32 cmd_from, u32 cmd_to, u32 cmd_beat)
+{
+	int index = idx * 12;
+	int i;
+
+	for (i = 3; i >= 0; i--) {
+		write_data[index + i] = (cmd_from >> (8 * i));
+		write_data[index + 4 + i] = (cmd_to >> (8 * i));
+		write_data[index + 8 + i] = (cmd_beat >> (8 * i));
+	}
+}
+
+static bool himax_mcu_program_reload(void)
+{
+	return true;
+}
+
+static void himax_mcu_usb_detect_set(struct himax_ts_data *ts,
+				     const u8 *cable_config)
+{
+	struct hx_reg_t tmp_reg;
+	struct hx_reg_t back_reg;
+	u8 retry_cnt = 0;
+
+	do {
+		if (cable_config[1] == 0x01) {
+			WORD_REG(tmp_reg, fw_func_handshaking_pwd);
+			g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_usb_detect),
+				REG_GET_ARRAY(tmp_reg), REG_GET_SZ(tmp_reg));
+			WORD_REG(back_reg, fw_func_handshaking_pwd);
+			I("USB detect status IN!");
+		} else {
+			WORD_REG(tmp_reg, fw_data_safe_mode_release_pw_reset);
+			g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_usb_detect),
+				REG_GET_ARRAY(tmp_reg), REG_GET_SZ(tmp_reg));
+			WORD_REG(back_reg, fw_data_safe_mode_release_pw_reset);
+			I("USB detect status OUT!");
+		}
+
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_usb_detect),
+			REG_GET_ARRAY(tmp_reg), REG_GET_SZ(tmp_reg));
+		/*I("tmp_data[0]=%d, USB detect=%d, retry_cnt=%d",
+		 *	tmp_data[0], cable_config[1], retry_cnt);
+		 */
+		retry_cnt++;
+	} while ((REG_GET_ARRAY(tmp_reg)[3] != REG_GET_ARRAY(back_reg)[3] ||
+		REG_GET_ARRAY(tmp_reg)[2] != REG_GET_ARRAY(back_reg)[2] ||
+		REG_GET_ARRAY(tmp_reg)[1] != REG_GET_ARRAY(back_reg)[1] ||
+		REG_GET_ARRAY(tmp_reg)[0] != REG_GET_ARRAY(back_reg)[0]) &&
+		retry_cnt < HIMAX_REG_RETRY_TIMES);
+}
+
+#define PRT_DATA "[3]=0x%02X, [2]=0x%02X, [1]=0x%02X, [0]=0x%02X"
+static void himax_mcu_diag_register_set(struct himax_ts_data *ts,
+					u8 diag_command)
+{
+	u8 tmp_data[DATA_LEN_4];
+	u8 back_data[DATA_LEN_4];
+	u8 cnt = 50;
+
+	tmp_data[0] = diag_command;
+	I("diag_command = %d, tmp_data[0] = %X", diag_command, tmp_data[0]);
+	g_core_fp.fp_interface_on(ts);
+	tmp_data[3] = 0x00; tmp_data[2] = 0x00; tmp_data[1] = 0x00;
+	do {
+		g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+			tmp_data, DATA_LEN_4);
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_raw_out_sel), back_data,
+			DATA_LEN_4);
+		I(PRT_DATA, back_data[3], back_data[2], back_data[1], back_data[0]);
+		cnt--;
+	} while (tmp_data[0] != back_data[0] && cnt > 0);
+}
+
+static int himax_mcu_diag_register_get(struct himax_ts_data *ts,
+				       u32 *diag_value)
+{
+	int ret = 0;
+	union hx_dword_data_t *tmp_data = (union hx_dword_data_t *)diag_value;
+
+	if (tmp_data) {
+		ret = g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_raw_out_sel),
+			tmp_data->byte, DATA_LEN_4);
+	} else {
+		E("diag_value is NULL");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+#define PRT_TMP_DATA "[0]=0x%2X,[1]=0x%2X,	[2]=0x%2X,[3]=0x%2X"
+static void himax_mcu_idle_mode(struct himax_ts_data *ts, int disable)
+{
+	int retry = 20;
+	u8 tmp_data[DATA_LEN_4];
+	u8 switch_cmd = 0x00;
+
+	I("entering");
+
+	do {
+		I("now %d times!", retry);
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_mode_status),
+			tmp_data, DATA_LEN_4);
+
+		if (disable)
+			switch_cmd = FW_GET_ARRAY(data_idle_dis_pwd)[0];
+		else
+			switch_cmd = FW_GET_ARRAY(data_idle_en_pwd)[0];
+
+		tmp_data[0] = switch_cmd;
+		g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_fw_mode_status),
+			tmp_data, DATA_LEN_4);
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_mode_status),
+			tmp_data, DATA_LEN_4);
+
+		I(PRT_TMP_DATA,	tmp_data[0], tmp_data[1], tmp_data[2], tmp_data[3]);
+
+		retry--;
+		usleep_range(10000, 11000);
+	} while ((tmp_data[0] != switch_cmd) && retry > 0);
+
+	I("setting OK!");
+}
+
+static void himax_mcu_reload_disable(struct himax_ts_data *ts, int disable)
+{
+	I("entering");
+
+	if (disable) { /*reload disable*/
+		g_core_fp.fp_register_write(ts,
+			DRV_GET_ARRAY(addr_fw_define_flash_reload),
+			DRV_GET_ARRAY(data_fw_define_flash_reload_dis),
+			DATA_LEN_4);
+	} else { /*reload enable*/
+		g_core_fp.fp_register_write(ts,
+			DRV_GET_ARRAY(addr_fw_define_flash_reload),
+			DRV_GET_ARRAY(data_fw_define_flash_reload_en),
+			DATA_LEN_4);
+	}
+
+	I("setting OK!");
+}
+
+static int himax_mcu_read_ic_trigger_type(struct himax_ts_data *ts)
+{
+	u8 tmp_data[DATA_LEN_4];
+	int trigger_type = false;
+
+	g_core_fp.fp_register_read(ts, DRV_GET_ARRAY(addr_fw_define_int_is_edge),
+		tmp_data, DATA_LEN_4);
+
+	if ((tmp_data[1] & 0x01) == 1)
+		trigger_type = true;
+
+	return trigger_type;
+}
+
+/* Please call this function after FW finish reload done */
+static void himax_mcu_read_FW_ver(struct himax_ts_data *ts)
+{
+	u8 data[12] = {0};
+
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_ver_addr), data,
+		DATA_LEN_4);
+	ts->ic_data->vendor_panel_ver =  data[0];
+	ts->ic_data->vendor_fw_ver = data[1] << 8 | data[2];
+	I("PANEL_VER : %X", ts->ic_data->vendor_panel_ver);
+	I("FW_VER : %X", ts->ic_data->vendor_fw_ver);
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_cfg_addr), data,
+		DATA_LEN_4);
+	ts->ic_data->vendor_config_ver = data[2] << 8 | data[3];
+	/*I("CFG_VER : %X",ts->ic_data->vendor_config_ver);*/
+	ts->ic_data->vendor_touch_cfg_ver = data[2];
+	I("TOUCH_VER : %X", ts->ic_data->vendor_touch_cfg_ver);
+	ts->ic_data->vendor_display_cfg_ver = data[3];
+	I("DISPLAY_VER : %X", ts->ic_data->vendor_display_cfg_ver);
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_fw_vendor_addr), data,
+		DATA_LEN_4);
+	ts->ic_data->vendor_cid_maj_ver = data[2];
+	ts->ic_data->vendor_cid_min_ver = data[3];
+	I("CID_VER : %X", (ts->ic_data->vendor_cid_maj_ver << 8
+			| ts->ic_data->vendor_cid_min_ver));
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_cus_info), data, 12);
+	memcpy(ts->ic_data->vendor_cus_info, data, 12);
+	I("Cusomer ID = %s", ts->ic_data->vendor_cus_info);
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_proj_info), data, 12);
+	memcpy(ts->ic_data->vendor_proj_info, data, 12);
+	I("Project ID = %s", ts->ic_data->vendor_proj_info);
+	hx_hid_update_info(ts);
+}
+
+static bool himax_mcu_read_event_stack(struct himax_ts_data *ts, u8 *buf,
+				       u32 length)
+{
+	u8 cmd[DATA_LEN_4];
+	struct time_var t_start, t_end, t_delta;
+	int len = length;
+	int i2c_speed = 0;
+	int ret = 0;
+
+	/*  AHB_I2C Burst Read Off */
+	cmd[0] = FW_GET_VAL(data_ahb_dis);
+
+	ret = himax_bus_write(ts, FW_GET_VAL(addr_ahb_addr), NULL, cmd, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return 0;
+	}
+	if (ts->debug_log_level & BIT(2))
+		time_func(&t_start);
+
+	himax_bus_read(ts, FW_GET_VAL(addr_event_addr), buf, length);
+
+	if (ts->debug_log_level & BIT(2)) {
+		time_func(&t_end);
+		t_delta.tv_nsec = (t_end.tv_sec * 1000000000 + t_end.tv_nsec)
+			- (t_start.tv_sec * 1000000000 + t_start.tv_nsec);
+
+		i2c_speed = (len * 9 * 1000000
+			/ (int)t_delta.tv_nsec) * 13 / 10;
+		ts->bus_speed = (int)i2c_speed;
+	}
+
+	/*  AHB_I2C Burst Read On */
+	cmd[0] = FW_GET_VAL(data_ahb_en);
+
+	ret = himax_bus_write(ts, FW_GET_VAL(addr_ahb_addr), NULL, cmd, 1);
+	if (ret < 0) {
+		E("bus access fail!");
+		return 0;
+	}
+
+	return 1;
+}
+
+static void himax_mcu_return_event_stack(struct himax_ts_data *ts)
+{
+	int retry = 20, i;
+	u8 tmp_data[DATA_LEN_4];
+
+	I("entering");
+
+	do {
+		I("now %d times!", retry);
+
+		for (i = 0; i < DATA_LEN_4; i++)
+			tmp_data[i] = SRAM_GET_ARRAY(addr_rawdata_end)[i];
+
+		g_core_fp.fp_register_write(ts, SRAM_GET_ARRAY(addr_rawdata_addr),
+			tmp_data, DATA_LEN_4);
+		g_core_fp.fp_register_read(ts, SRAM_GET_ARRAY(addr_rawdata_addr),
+			tmp_data, DATA_LEN_4);
+		retry--;
+		usleep_range(10000, 11000);
+	} while ((tmp_data[1] != SRAM_GET_ARRAY(addr_rawdata_end)[1] &&
+		tmp_data[0] != SRAM_GET_ARRAY(addr_rawdata_end)[0]) &&
+		retry > 0);
+
+	I("End of setting!");
+}
+
+static bool himax_mcu_calculate_checksum(struct himax_ts_data *ts,
+					 bool change_iref, u32 size)
+{
+	u32 CRC_result = 0xFFFFFFFF;
+	u8 i;
+	u8 tmp_data[DATA_LEN_4];
+
+	I("Now size=%d", size);
+	for (i = 0; i < DATA_LEN_4; i++)
+		tmp_data[i] = SRAM_GET_ARRAY(addr_rawdata_end)[i];
+
+	CRC_result = g_core_fp.fp_check_crc(ts, tmp_data, size);
+	usleep_range(50000, 50001);
+
+	if (CRC_result != 0)
+		I("CRC Fail=%d", CRC_result);
+
+	return (CRC_result == 0) ? true : false;
+}
+
+static u32 dbg_reg_ary[4] = {fw_addr_fw_dbg_msg_addr,
+	fw_addr_chk_fw_status, fw_addr_chk_dd_status, fw_addr_flag_reset_event};
+
+static void himax_mcu_read_FW_status(struct himax_ts_data *ts)
+{
+	u8 len = 0;
+	u8 i = 0;
+	struct hx_reg_t addr_reg;
+	u8 data[4] = {0};
+
+	len = (u8)(sizeof(dbg_reg_ary) / sizeof(u32));
+
+	for (i = 0; i < len; i++) {
+		WORD_REG(addr_reg, dbg_reg_ary[i]);
+		g_core_fp.fp_register_read(ts, REG_GET_ARRAY(addr_reg),
+			data, DATA_LEN_4);
+
+		I("reg[0-3] : 0x%08X = 0x%02X, 0x%02X, 0x%02X, 0x%02X",
+		  dbg_reg_ary[i], data[0], data[1], data[2], data[3]);
+	}
+}
+
+static void himax_mcu_irq_switch(struct himax_ts_data *ts, int switch_on)
+{
+	if (switch_on) {
+		if (ts->use_irq)
+			himax_int_enable(ts, switch_on);
+		else
+			hrtimer_start(&ts->timer, ktime_set(1, 0),
+				      HRTIMER_MODE_REL);
+	} else {
+		if (ts->use_irq) {
+			himax_int_enable(ts, switch_on);
+		} else {
+			hrtimer_cancel(&ts->timer);
+			cancel_work_sync(&ts->work);
+		}
+	}
+}
+
+static int himax_mcu_assign_sorting_mode(struct himax_ts_data *ts,
+					 u8 *tmp_data_in)
+{
+	u8 retry = 0;
+	union hx_dword_data_t rdata = {0};
+	u32 sorting_addr = FW_GET_VAL(addr_sorting_mode_en);
+	union hx_dword_data_t *tmp_data = (union hx_dword_data_t *)tmp_data_in;
+
+	I("addr: 0x%08X, write: 0x%08X",
+	  sorting_addr, le32_to_cpu(tmp_data->dword));
+
+	while (retry++ < 3) {
+		g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_sorting_mode_en),
+			tmp_data->byte, DATA_LEN_4);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_sorting_mode_en),
+			rdata.byte, DATA_LEN_4);
+
+		if (rdata.dword == tmp_data->dword) {
+			I("success to write sorting mode");
+			return NO_ERR;
+		}
+		E("fail to write sorting mode");
+	}
+
+	return BUS_FAIL;
+}
+
+static int himax_mcu_check_sorting_mode(struct himax_ts_data *ts,
+					u8 *tmp_data_in)
+{
+	int ret = NO_ERR;
+	u32 sorting_addr = FW_GET_VAL(addr_sorting_mode_en);
+	union hx_dword_data_t *tmp_data = (union hx_dword_data_t *)tmp_data_in;
+
+	ret = g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_sorting_mode_en),
+		tmp_data->byte, DATA_LEN_4);
+	I("addr: 0x%08X, Now is:0x%08X",
+	  sorting_addr, le32_to_cpu(tmp_data->dword));
+	if (tmp_data->dword == 0xFFFFFFFF) {
+		ret = BUS_FAIL;
+		I("All 0xFF, Fail!");
+	}
+
+	return ret;
+}
+
+static u8 himax_mcu_read_DD_status(struct himax_ts_data *ts,
+				   u8 *cmd_set, u8 *tmp_data)
+{
+	int cnt = 0;
+	u8 req_size = cmd_set[0];
+
+	cmd_set[3] = FW_GET_ARRAY(data_dd_request)[0];
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_dd_handshak_addr),
+		cmd_set, DATA_LEN_4);
+	I("cmd set[0]=0x%2X,set[1]=0x%2X,set[2]=0x%2X,set[3]=0x%2X",
+	  cmd_set[0], cmd_set[1], cmd_set[2], cmd_set[3]);
+
+	/* Doing hand shaking 0xAA -> 0xBB */
+	for (cnt = 0; cnt < 100; cnt++) {
+		g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_dd_handshak_addr),
+			tmp_data, DATA_LEN_4);
+		usleep_range(10000, 11000);
+
+		if (tmp_data[3] == FW_GET_ARRAY(data_dd_ack)[0]) {
+			I("Data ready goto moving data");
+			goto FINALIZE;
+		} else {
+			if (cnt >= 99) {
+				I("Data not ready in FW");
+				return FW_NOT_READY;
+			}
+		}
+	}
+FINALIZE:
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_dd_data_addr), tmp_data,
+		req_size);
+	return NO_ERR;
+}
+
+static void hx_clr_fw_reord_dd_sts(struct himax_ts_data *ts)
+{
+	union hx_dword_data_t tmp_data = {0};
+
+	g_core_fp.fp_register_read(ts, IC_GET_ARRAY(addr_cs_central_state),
+		tmp_data.byte, ADDR_LEN_4);
+	I("Check enter_save_mode data[0]=%02X", tmp_data.byte[0]);
+
+	if (tmp_data.byte[0] == 0x0C) {
+		I("Enter safe mode, OK!");
+	} else {
+		E("It doen't enter safe mode, please check it again");
+		return;
+	}
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_clr_fw_record_dd_sts),
+		tmp_data.byte, DATA_LEN_4);
+	I("Before Write :Now 10007FCC=0x%08X",
+	  le32_to_cpu(tmp_data.dword));
+	usleep_range(10000, 10001);
+
+	tmp_data.byte[2] = 0x00;
+	tmp_data.byte[3] = 0x00;
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_clr_fw_record_dd_sts),
+		tmp_data.byte, DATA_LEN_4);
+	usleep_range(10000, 10001);
+
+	g_core_fp.fp_register_read(ts, FW_GET_ARRAY(addr_clr_fw_record_dd_sts),
+		tmp_data.byte, DATA_LEN_4);
+	I("After Write :Now 10007FCC=0x%08X",
+	  le32_to_cpu(tmp_data.dword));
+}
+
+static void hx_ap_notify_fw_sus(struct himax_ts_data *ts, int suspend)
+{
+	int retry = 0;
+	int read_sts = 0;
+	union hx_dword_data_t read_tmp = {0};
+	union hx_dword_data_t addr_tmp = {0};
+	union hx_dword_data_t data_tmp = {0};
+
+	addr_tmp.dword = FW_GET_VAL(addr_ap_notify_fw_sus);
+
+	if (suspend) {
+		I("Suspend mode!");
+		data_tmp.dword = FW_GET_VAL(data_ap_notify_fw_sus_en);
+	} else {
+		I("Non-Suspend mode!");
+		data_tmp.dword = FW_GET_VAL(data_ap_notify_fw_sus_dis);
+	}
+
+	I("R%08XH<-0x%08X",	addr_tmp.dword,	data_tmp.dword);
+	addr_tmp.dword = cpu_to_le32(addr_tmp.dword);
+	data_tmp.dword = cpu_to_le32(data_tmp.dword);
+	do {
+		g_core_fp.fp_register_write(ts, addr_tmp.byte, data_tmp.byte,
+			sizeof(data_tmp.byte));
+		usleep_range(1000, 1001);
+		read_sts = g_core_fp.fp_register_read(ts, addr_tmp.byte, read_tmp.byte,
+			sizeof(read_tmp.byte));
+		I("read bus status=%d", read_sts);
+		I("Now retry=%d, data=0x%08X", retry,
+		  le32_to_cpu(read_tmp.dword));
+	} while ((retry++ < 10) && (read_sts != NO_ERR) &&
+		(read_tmp.dword != data_tmp.dword));
+}
+
+/* FW side end*/
+/* CORE_FW */
+
+/* CORE_FLASH */
+/* FLASH side start*/
+static void himax_mcu_chip_erase(struct himax_ts_data *ts)
+{
+	g_core_fp.fp_interface_on(ts);
+
+	/* Reset power saving level */
+	if (g_core_fp.fp_init_psl)
+		g_core_fp.fp_init_psl(ts);
+
+	g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_trans_fmt),
+		FLASH_GET_ARRAY(data_spi200_trans_fmt), DATA_LEN_4);
+
+	g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+		FLASH_GET_ARRAY(data_spi200_trans_ctrl_2), DATA_LEN_4);
+	g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_cmd),
+		FLASH_GET_ARRAY(data_spi200_cmd_2), DATA_LEN_4);
+
+	g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_cmd),
+		FLASH_GET_ARRAY(data_spi200_cmd_3), DATA_LEN_4);
+	usleep_range(2000000, 2000001);
+
+	if (!g_core_fp.fp_wait_wip(ts, 100))
+		E("Chip_Erase Fail");
+	else
+		I("Chip_Erase Success");
+}
+
+static bool himax_mcu_block_erase(struct himax_ts_data *ts, int start_addr,
+				  int length)
+{
+	u32 page_prog_start = 0;
+	u32 block_size = 0x10000;
+
+	DEF_WORD_DATA(tmp_data);
+
+	g_core_fp.fp_interface_on(ts);
+
+	g_core_fp.fp_init_psl(ts);
+
+	g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_trans_fmt),
+		FLASH_GET_ARRAY(data_spi200_trans_fmt), DATA_LEN_4);
+
+	for (page_prog_start = start_addr;
+		page_prog_start < start_addr + length;
+		page_prog_start = page_prog_start + block_size) {
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+			FLASH_GET_ARRAY(data_spi200_trans_ctrl_2), DATA_LEN_4);
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_cmd),
+			FLASH_GET_ARRAY(data_spi200_cmd_2), DATA_LEN_4);
+
+		VAL_SET(tmp_data, page_prog_start);
+		g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_addr),
+			tmp_data.data.byte, DATA_LEN_4);
+
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+			FLASH_GET_ARRAY(data_spi200_trans_ctrl_3), DATA_LEN_4);
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_cmd),
+			FLASH_GET_ARRAY(data_spi200_cmd_4), DATA_LEN_4);
+		usleep_range(1000000, 1000001);
+
+		if (!g_core_fp.fp_wait_wip(ts, 100)) {
+			E("Erase Fail");
+			return false;
+		}
+	}
+
+	I("END");
+	return true;
+}
+
+static bool himax_mcu_sector_erase(int start_addr)
+{
+	return true;
+}
+
+static bool himax_mcu_flash_programming(struct himax_ts_data *ts,
+					u8 *FW_content, int fw_size)
+{
+	int page_prog_start = 0;
+	union hx_dword_data_t tmp_data = {0};
+	int ret = 0;
+	/* 4 bytes for padding*/
+	g_core_fp.fp_interface_on(ts);
+
+	g_core_fp.fp_register_write(ts,
+		FLASH_GET_ARRAY(addr_spi200_trans_fmt),
+		FLASH_GET_ARRAY(data_spi200_trans_fmt), DATA_LEN_4);
+
+	for (page_prog_start = 0; page_prog_start < fw_size;
+		page_prog_start += FLASH_RW_MAX_LEN) {
+		/* ===Flash Write Enable ===*/
+
+		g_core_fp.fp_register_write(ts,
+				FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+				FLASH_GET_ARRAY(data_spi200_trans_ctrl_2), DATA_LEN_4);
+
+		g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_cmd),
+				FLASH_GET_ARRAY(data_spi200_cmd_2),	DATA_LEN_4);
+
+		/* ===WEL Write Control ===*/
+		g_core_fp.fp_register_write(ts,
+				FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+				FLASH_GET_ARRAY(data_spi200_trans_ctrl_6), DATA_LEN_4);
+
+		g_core_fp.fp_register_write(ts,
+				FLASH_GET_ARRAY(addr_spi200_cmd),
+				FLASH_GET_ARRAY(data_spi200_cmd_1),	DATA_LEN_4);
+
+		g_core_fp.fp_register_read(ts, FLASH_GET_ARRAY(addr_spi200_data),
+				tmp_data.byte, DATA_LEN_4);
+
+		/* === Check WEL Fail ===*/
+		if (((tmp_data.byte[0] & 0x02) >> 1) == 0) {
+			I("SPI 0x8000002c = %d, Check WEL Fail",
+			  tmp_data.byte[0]);
+			return false;
+		}
+
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+			FLASH_GET_ARRAY(data_spi200_trans_ctrl_2), DATA_LEN_4);
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_cmd),
+			FLASH_GET_ARRAY(data_spi200_cmd_2), DATA_LEN_4);
+
+		 /*Programmable size = 1 page = 256 bytes,*/
+		 /*word_number = 256 byte / 4 = 64*/
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_trans_ctrl),
+			FLASH_GET_ARRAY(data_spi200_trans_ctrl_4), DATA_LEN_4);
+
+		/* Flash start address 1st : 0x0000_0000*/
+		tmp_data.dword = cpu_to_le32(page_prog_start);
+		g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_addr), tmp_data.byte, DATA_LEN_4);
+
+		ret = g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_data),
+			&FW_content[page_prog_start], 16);
+		if (ret < 0) {
+			E("bus access fail!");
+			return false;
+		}
+
+		g_core_fp.fp_register_write(ts, FLASH_GET_ARRAY(addr_spi200_cmd),
+			FLASH_GET_ARRAY(data_spi200_cmd_6), DATA_LEN_4);
+
+		ret = g_core_fp.fp_register_write(ts,
+			FLASH_GET_ARRAY(addr_spi200_data),
+			&FW_content[page_prog_start + 16], 240);
+		if (ret < 0) {
+			E("bus access fail!");
+			return false;
+		}
+
+		if (!g_core_fp.fp_wait_wip(ts, 1)) {
+			E("Flash_Programming Fail");
+			return false;
+		}
+	}
+	return true;
+}
+
+static void himax_mcu_flash_page_write(u8 *write_addr, int length,
+				       u8 *write_data)
+{
+}
+
+static void himax_flash_speed_set(struct himax_ts_data *ts, u8 speed)
+{
+	struct hx_reg_t reg_addr;
+	struct hx_reg_t reg_data;
+
+	reg_data.data.word = 0;
+	reg_data.data.byte[1] = 0x02; /*extand cs high to 100ns*/
+	reg_data.data.byte[0] = speed;
+	WORD_REG(reg_addr, flash_clk_setup_addr);
+	g_core_fp.fp_register_write(ts, REG_GET_ARRAY(reg_addr),
+		REG_GET_ARRAY(reg_data), 4);
+}
+
+static int himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_32k
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref)
+{
+	/* Not use */
+	return 0;
+}
+
+static int himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_60k
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref)
+{
+	/* Not use */
+	return 0;
+}
+
+static int himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_64k
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref)
+{
+	int burn_firmware_success = 0;
+	int counter = 0;
+
+	if (len != FW_SIZE_64k) {
+		E("The file size is not 64K bytes");
+		return false;
+	}
+
+	g_core_fp.fp_ic_reset(ts, false, false);
+	for (counter = 0; counter < 3; counter++) {
+		g_core_fp.fp_sense_off(ts, true);
+		himax_flash_speed_set(ts, HX_FLASH_SPEED_12p5M);
+		g_core_fp.fp_block_erase(ts, 0x00, FW_SIZE_64k);
+		if (g_core_fp.fp_flash_programming(ts, fw, FW_SIZE_64k) == false) {
+			g_core_fp.fp_ic_reset(ts, false, false);
+			continue;
+		}
+
+		if (g_core_fp.fp_check_crc(ts, FW_GET_ARRAY(addr_program_reload_from),
+					   FW_SIZE_64k) == 0) {
+			burn_firmware_success = 1;
+			break;
+		}
+	}
+	/*RawOut select initial*/
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	/*DSRAM func initial*/
+	g_core_fp.fp_assign_sorting_mode(ts, FW_GET_ARRAY(data_clear));
+	g_core_fp.fp_ic_reset(ts, false, false);
+
+	return burn_firmware_success;
+}
+
+static int himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_124k
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref)
+{
+	/* Not use */
+	return 0;
+}
+
+static int himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_128k
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref)
+{
+	int burn_firmware_success = 0;
+	int counter = 0;
+
+	if (len != FW_SIZE_128k) {
+		E("The file size is not 128K bytes");
+		return false;
+	}
+
+	g_core_fp.fp_ic_reset(ts, false, false);
+	for (counter = 0; counter < 3; counter++) {
+		g_core_fp.fp_sense_off(ts, true);
+		himax_flash_speed_set(ts, HX_FLASH_SPEED_12p5M);
+		g_core_fp.fp_block_erase(ts, 0x00, FW_SIZE_128k);
+		if (g_core_fp.fp_flash_programming(ts, fw, FW_SIZE_128k) == false) {
+			g_core_fp.fp_ic_reset(ts, false, false);
+			continue;
+		}
+
+		if (g_core_fp.fp_check_crc(ts, FW_GET_ARRAY(addr_program_reload_from),
+					   FW_SIZE_128k) == 0) {
+			burn_firmware_success = 1;
+			break;
+		}
+	}
+	/*RawOut select initial*/
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	/*DSRAM func initial*/
+	g_core_fp.fp_assign_sorting_mode(ts, FW_GET_ARRAY(data_clear));
+
+	return burn_firmware_success;
+}
+
+static int himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_255k
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref)
+{
+	int burn_firmware_success = 0;
+	int counter = 0;
+
+	if (len != FW_SIZE_255k) {
+		E("The file size is not 255K bytes");
+		return false;
+	}
+
+	g_core_fp.fp_ic_reset(ts, false, false);
+	for (counter = 0; counter < 3; counter++) {
+		g_core_fp.fp_sense_off(ts, true);
+		himax_flash_speed_set(ts, HX_FLASH_SPEED_12p5M);
+		g_core_fp.fp_block_erase(ts, 0x00, FW_SIZE_255k);
+		if (g_core_fp.fp_flash_programming(ts, fw, FW_SIZE_255k) == false) {
+			g_core_fp.fp_ic_reset(ts, false, false);
+			continue;
+		}
+		if (g_core_fp.fp_check_crc(ts, FW_GET_ARRAY(addr_program_reload_from),
+					   FW_SIZE_255k) == 0) {
+			burn_firmware_success = 1;
+			break;
+		}
+	}
+	/*RawOut select initial*/
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	/*DSRAM func initial*/
+	g_core_fp.fp_assign_sorting_mode(ts, FW_GET_ARRAY(data_clear));
+
+	return burn_firmware_success;
+}
+
+static void himax_mcu_flash_dump_func
+		(struct himax_ts_data *ts, u8 local_flash_command,
+		 int flash_size, u8 *flash_buffer)
+{
+	struct hx_reg_t tmp_addr;
+	int page_prog_start = 0;
+
+	g_core_fp.fp_sense_off(ts, true);
+
+	for (page_prog_start = 0; page_prog_start < flash_size;
+		page_prog_start += 128) {
+		WORD_REG(tmp_addr, page_prog_start);
+		g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+			flash_buffer + page_prog_start, 128);
+	}
+
+	g_core_fp.fp_sense_on(ts, 0x01);
+}
+
+static bool himax_mcu_flash_lastdata_check(struct himax_ts_data *ts,
+					   u32 size)
+{
+	struct hx_reg_t tmp_addr;
+	/* 64K - 0x80, which is the address of
+	 * the last 128bytes in 64K, default value
+	 */
+	u32 start_addr = 0xFFFFFFFF;
+	u32 temp_addr = 0;
+	u32 flash_page_len = 0x80;
+	u8 flash_tmp_buffer[128];
+
+	if (size < flash_page_len) {
+		E("flash size is wrong, terminated");
+		E("flash size = %08X; flash page len = %08X",
+		  size, flash_page_len);
+		goto FAIL;
+	}
+
+	/* In order to match other size of fw */
+	start_addr = size - flash_page_len;
+	I("Now size is %d, the start_addr is 0x%08X",
+	  size, start_addr);
+	for (temp_addr = start_addr; temp_addr < (start_addr + flash_page_len);
+		temp_addr = temp_addr + flash_page_len) {
+		/*I("temp_addr=%d,tmp_addr[0]=0x%2X, tmp_addr[1]=0x%2X,
+		 *	tmp_addr[2]=0x%2X,tmp_addr[3]=0x%2X",
+		 *	temp_addr,tmp_addr[0], tmp_addr[1],
+		 *	tmp_addr[2],tmp_addr[3]);
+		 */
+		WORD_REG(tmp_addr, temp_addr);
+		g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+			&flash_tmp_buffer[0], flash_page_len);
+	}
+
+	I("FLASH[%08X] ~ FLASH[%08X] = %02X%02X%02X%02X", size - 4, size - 1,
+	  flash_tmp_buffer[flash_page_len - 4],
+	  flash_tmp_buffer[flash_page_len - 3],
+	  flash_tmp_buffer[flash_page_len - 2],
+	  flash_tmp_buffer[flash_page_len - 1]);
+
+	if (!flash_tmp_buffer[flash_page_len - 4] &&
+	    !flash_tmp_buffer[flash_page_len - 3] &&
+		!flash_tmp_buffer[flash_page_len - 2] &&
+		!flash_tmp_buffer[flash_page_len - 1]) {
+		I("Fail, Last four Bytes are all 0x00:");
+		goto FAIL;
+	} else if (flash_tmp_buffer[flash_page_len - 4] == 0xFF &&
+			  (flash_tmp_buffer[flash_page_len - 3] == 0xFF) &&
+			  (flash_tmp_buffer[flash_page_len - 2] == 0xFF) &&
+			  (flash_tmp_buffer[flash_page_len - 1] == 0xFF)) {
+		I("Fail, Last four Bytes are all 0xFF:");
+		goto FAIL;
+	} else {
+		return 0;
+	}
+
+FAIL:
+	return 1;
+}
+
+static bool hx_bin_desc_data_get(struct himax_ts_data *ts,
+				 u32 addr, u8 *flash_buf,
+				 const u8 *fw_all_data)
+{
+	u8 data_sz = 0x10;
+	u32 i = 0, j = 0;
+	u16 chk_end = 0;
+	u16 chk_sum = 0;
+	u32 map_code = 0;
+	unsigned long flash_addr = 0;
+	u32 hid_table_addr = 0;
+	union {
+		u8 *buf;
+		u32 *word;
+	} map_data;
+
+	for (i = 0; i < FW_PAGE_SZ; i = i + data_sz) {
+		for (j = i; j < (i + data_sz); j++) {
+			chk_end |= flash_buf[j];
+			chk_sum += flash_buf[j];
+		}
+		if (!chk_end) { /*1. Check all zero*/
+			I("End in %X", i + addr);
+			return false;
+		} else if (chk_sum % 0x100) { /*2. Check sum*/
+			I("chk sum failed in %X", i + addr);
+		} else { /*3. get data*/
+			map_data.buf = &flash_buf[i];
+			map_code = le32_to_cpup(map_data.word);
+			map_data.buf = &flash_buf[i + 4];
+			flash_addr = le32_to_cpup(map_data.word);
+			switch (map_code) {
+			case FW_CID:
+				WORD_REG(g_core_regs.flash_ver_info.addr_cid_ver_major,
+					 flash_addr);
+				WORD_REG(g_core_regs.flash_ver_info.addr_cid_ver_minor,
+					 flash_addr + 1);
+				I("CID_VER in %X", FLASH_VER_GET_VAL(addr_cid_ver_major));
+				memcpy(&ts->fw_bin_desc, &fw_all_data
+					   [flash_addr - sizeof(ts->hid_info.fw_bin_desc.passwd)],
+				       sizeof(struct hx_bin_desc_t));
+				break;
+			case FW_VER:
+				WORD_REG(g_core_regs.flash_ver_info.addr_fw_ver_major,
+					 flash_addr);
+				WORD_REG(g_core_regs.flash_ver_info.addr_fw_ver_minor,
+					 flash_addr + 1);
+				I("FW_VER in %X", FLASH_VER_GET_VAL(addr_fw_ver_major));
+				break;
+			case CFG_VER:
+				WORD_REG(g_core_regs.flash_ver_info.addr_cfg_ver_major,
+					 flash_addr);
+				WORD_REG(g_core_regs.flash_ver_info.addr_cfg_ver_minor,
+					 flash_addr + 1);
+				I("CFG_VER in = %08X",	FLASH_VER_GET_VAL(addr_cfg_ver_major));
+				break;
+			case TP_CONFIG_TABLE:
+				WORD_REG(g_core_regs.flash_ver_info.addr_cfg_table,
+					 flash_addr);
+				I("CONFIG_TABLE in %X", FLASH_VER_GET_VAL(addr_cfg_table));
+				break;
+			case HID_TABLE:
+				WORD_REG(g_core_regs.flash_ver_info.addr_hid_table,
+					 flash_addr);
+				I("HID_TABLE in %X", FLASH_VER_GET_VAL(addr_hid_table));
+				hid_table_addr = FLASH_VER_GET_VAL(addr_hid_table);
+				WORD_REG(g_core_regs.flash_ver_info.addr_hid_desc,
+					 hid_table_addr);
+				I("HID_DESC in %X", FLASH_VER_GET_VAL(addr_hid_desc));
+				WORD_REG(g_core_regs.flash_ver_info.addr_hid_rd_desc,
+					 (hid_table_addr + 24));
+				I("HID_RD_DESC in %X", FLASH_VER_GET_VAL(addr_hid_rd_desc));
+				break;
+			}
+		}
+		chk_end = 0;
+		chk_sum = 0;
+	}
+
+	return true;
+}
+
+static bool hx_mcu_bin_desc_get(unsigned char *fw, struct himax_ts_data *ts,
+				u32 max_sz)
+{
+	u32 addr_t = 0;
+	unsigned char *fw_buf = NULL;
+	bool keep_on_flag = false;
+	bool bin_desc_flag = false;
+
+	do {
+		fw_buf = &fw[addr_t];
+
+		/*Check bin is with description table or not*/
+		if (!bin_desc_flag) {
+			if (fw_buf[0x00] == 0x00 && fw_buf[0x01] == 0x00 &&
+			    fw_buf[0x02] == 0x00 && fw_buf[0x03] == 0x00 &&
+			    fw_buf[0x04] == 0x00 && fw_buf[0x05] == 0x00 &&
+			    fw_buf[0x06] == 0x00 && fw_buf[0x07] == 0x00 &&
+			    fw_buf[0x0E] == 0x87)
+				bin_desc_flag = true;
+		}
+		if (!bin_desc_flag) {
+			I("fw_buf[0x00] = %2X, fw_buf[0x0E] = %2X",
+			  fw_buf[0x00], fw_buf[0x0E]);
+			I("No description table");
+			break;
+		}
+
+		/*Get related data*/
+		keep_on_flag = hx_bin_desc_data_get(ts, addr_t, fw_buf, fw);
+		if (FLASH_VER_GET_VAL(addr_hid_table) >= ts->hxfw->size ||
+		    (FLASH_VER_GET_VAL(addr_hid_rd_desc) +
+			ts->hid_rd_data.rd_length) >= ts->hxfw->size) {
+			W("hid_table_addr = %d, ts->hxfw->size = %lu!",
+			  FLASH_VER_GET_VAL(addr_hid_table), ts->hxfw->size);
+			W("hid_rd_desc_addr = %d, rd_len = %d, ts->hxfw->size = %lu!",
+			  FLASH_VER_GET_VAL(addr_hid_rd_desc),
+			  ts->hid_rd_data.rd_length,
+			  ts->hxfw->size);
+			WORD_REG(g_core_regs.flash_ver_info.addr_hid_table, 0);
+			WORD_REG(g_core_regs.flash_ver_info.addr_hid_desc, 0);
+			WORD_REG(g_core_regs.flash_ver_info.addr_hid_rd_desc, 0);
+		}
+
+		addr_t = addr_t + FW_PAGE_SZ;
+	} while (max_sz > addr_t && keep_on_flag);
+
+	return bin_desc_flag;
+}
+
+static int hx_mcu_diff_overlay_flash(struct himax_ts_data *ts)
+{
+	int rslt = 0;
+	int diff_val = 0;
+
+	diff_val = (ts->ic_data->vendor_fw_ver);
+	I("Now fw ID is 0x%04X", diff_val);
+	diff_val = (diff_val >> 12);
+	I("Now diff value=0x%04X", diff_val);
+
+	if (diff_val == 1)
+		I("Now size should be 128K!");
+	else
+		I("Now size should be 64K!");
+	rslt = diff_val;
+	return rslt;
+}
+
+/* FLASH side end*/
+/* CORE_FLASH */
+
+/* CORE_SRAM */
+/* SRAM side start*/
+static void himax_mcu_sram_write(struct himax_ts_data *ts, u8 *fw_content)
+{
+}
+
+static bool himax_mcu_sram_verify(struct himax_ts_data *ts, u8 *fw_file,
+				  int fw_size)
+{
+	return true;
+}
+
+static bool himax_mcu_get_DSRAM_data(struct himax_ts_data *ts,
+				     u8 *info_data, bool dsram_flag)
+{
+	unsigned int i = 0;
+	struct hx_reg_t tmp_addr;
+	union hx_dword_data_t tmp_data = {0};
+	unsigned int max_bus_size = MAX_I2C_TRANS_SZ;
+	const u32 x_num = ts->ic_data->HX_RX_NUM;
+	const u32 y_num = ts->ic_data->HX_TX_NUM;
+	unsigned int total_size = (x_num * y_num + x_num + y_num) * 2 + 4;
+	unsigned int remain_size;
+	u32 retry = 0;
+	unsigned int addr = 0;
+	u8  *temp_info_data = NULL; /*max mkey size = 8*/
+	u32 checksum = 0;
+	s32 fw_run_flag = -1;
+
+#if defined(BUS_R_DLEN)
+	max_bus_size = BUS_R_DLEN;
+#endif
+
+	if (strcmp(ts->chip_name, HX83121A_ID) == 0) {
+		if (max_bus_size > 4096)
+			max_bus_size = 4096;
+	}
+
+	temp_info_data = kcalloc((total_size + 8), sizeof(u8), GFP_KERNEL);
+	if (!temp_info_data) {
+		E("Failed to allocate memory");
+		return false;
+	}
+	/* 1. Read number of MKey R100070E8H to determin data size */
+	/* m_key_num = g_hx_ic_data->HX_BT_NUM; */
+	/* I("m_key_num=%d", m_key_num); */
+	/* total_size += m_key_num * 2; */
+
+	/* 2. Start DSRAM Rawdata and Wait Data Ready */
+	tmp_data.dword = SRAM_GET_VAL(passwrd_start);
+	tmp_data.dword = cpu_to_le32(tmp_data.dword);
+	fw_run_flag = himax_write_read_reg(ts, SRAM_GET_ARRAY(addr_rawdata_addr),
+					   tmp_data.byte,
+					   SRAM_GET_ARRAY(passwrd_end)[1],
+					   SRAM_GET_ARRAY(passwrd_end)[0]);
+
+	if (fw_run_flag < 0) {
+		E("Data NOT ready => bypass");
+		kfree(temp_info_data);
+		return false;
+	}
+
+	/* 3. Read RawData */
+	while (retry++ < 5) {
+		remain_size = total_size;
+		while (remain_size > 0) {
+			i = total_size - remain_size;
+			addr = sram_adr_rawdata_addr + i;
+
+			WORD_REG(tmp_addr, addr);
+
+			if (remain_size >= max_bus_size) {
+				g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+					&temp_info_data[i], max_bus_size);
+				remain_size -= max_bus_size;
+			} else {
+				g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+					&temp_info_data[i], remain_size);
+				remain_size = 0;
+			}
+		}
+
+		/* 5. Data Checksum Check */
+		/* 2 is meaning PASSWORD NOT included */
+		checksum = 0;
+		for (i = 2; i < total_size; i += 2)
+			checksum += temp_info_data[i + 1] << 8 | temp_info_data[i];
+
+		if (checksum % 0x10000 != 0) {
+			E("check_sum_cal fail=%08X", checksum);
+
+		} else {
+			memcpy(info_data, temp_info_data,
+			       total_size * sizeof(u8));
+			break;
+		}
+	}
+
+	/* 4. FW stop outputing */
+	tmp_data.dword = 0;
+	tmp_data.byte[3] = temp_info_data[3];
+	tmp_data.byte[2] = temp_info_data[2];
+	g_core_fp.fp_register_write(ts, SRAM_GET_ARRAY(addr_rawdata_addr),
+		tmp_data.byte, DATA_LEN_4);
+
+	kfree(temp_info_data);
+	if (retry >= 5)
+		return false;
+	else
+		return true;
+}
+
+/* SRAM side end*/
+/* CORE_SRAM */
+
+/* CORE_DRIVER */
+static void himax_mcu_init_ic(struct himax_ts_data *ts)
+{
+	I("use default incell init.");
+}
+
+static void himax_suspend_proc(struct himax_ts_data *ts, bool suspended)
+{
+	I("himax suspend.");
+}
+
+static void himax_resume_proc(struct himax_ts_data *ts, bool suspended)
+{
+	int result = 0;
+
+	I("himax resume.");
+	if (!ts->ic_data->has_flash) {
+		if (g_core_fp.fp_0f_op_file_dirly) {
+			result = g_core_fp.fp_0f_op_file_dirly(g_fw_boot_upgrade_name,
+				ts);
+			if (result)
+				E("update FW fail, code[%d]!!", result);
+			else
+				ts->resume_success = true;
+		}
+	} else {
+		if (g_core_fp.fp_resend_cmd_func) {
+			g_core_fp.fp_resend_cmd_func(ts, suspended);
+			ts->resume_success = true;
+		}
+	}
+
+	if (g_core_fp.fp_ap_notify_fw_sus && result == 0)
+		g_core_fp.fp_ap_notify_fw_sus(ts, 0);
+}
+
+static void himax_mcu_pin_reset(struct himax_ts_data *ts)
+{
+	const int rst_low_period_s = RST_LOW_PERIOD_S;
+	const int rst_low_period_e = RST_LOW_PERIOD_E;
+	int rst_high_period_s;
+	int rst_high_period_e;
+
+	I("Now reset the Touch chip.");
+	if (!ts->ic_data->has_flash) {
+		rst_high_period_s = RST_HIGH_PERIOD_ZF_S;
+		rst_high_period_e = RST_HIGH_PERIOD_ZF_E;
+	} else {
+		rst_high_period_s = RST_HIGH_PERIOD_S;
+		rst_high_period_e = RST_HIGH_PERIOD_E;
+	}
+	himax_rst_gpio_set(ts->rst_gpio, 0);
+	usleep_range(rst_low_period_s, rst_low_period_e);
+	himax_rst_gpio_set(ts->rst_gpio, 1);
+	usleep_range(rst_high_period_s, rst_high_period_e);
+}
+
+static void himax_mcu_ic_reset(struct himax_ts_data *ts, u8 loadconfig,
+			       u8 int_off)
+{
+	I("status: loadconfig=%d,int_off=%d", loadconfig, int_off);
+
+	if (ts->rst_gpio >= 0) {
+		if (int_off)
+			g_core_fp.fp_irq_switch(ts, 0);
+
+		g_core_fp.fp_pin_reset(ts);
+
+		if (int_off)
+			g_core_fp.fp_irq_switch(ts, 1);
+	}
+}
+
+static u8 himax_mcu_tp_info_check(struct himax_ts_data *ts)
+{
+	union hx_dword_data_t addr;
+	char data[DATA_LEN_4] = {0};
+	u32 rx_num;
+	u32 tx_num;
+	u32 bt_num;
+	u32 max_pt;
+	u32 y_res;
+	u32 x_res;
+	u8 int_is_edge;
+	u8 stylus_func;
+	u8 stylus_id_v2;
+	u8 stylus_ratio;
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_rxnum_txnum), data, DATA_LEN_4);
+	rx_num = data[2];
+	tx_num = data[3];
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_maxpt_xyrvs), data, DATA_LEN_4);
+	max_pt = data[0];
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_x_y_res), data, DATA_LEN_4);
+	y_res = be16_to_cpup((u16 *)&data[0]);
+	x_res = be16_to_cpup((u16 *)&data[2]);
+	/* I("rx_num=%d, tx_num=%d, max_pt=%d, y_res=%d, x_res=%d",
+	 *	rx_num, tx_num, max_pt, y_res, x_res);
+	 */
+
+	g_core_fp.fp_register_read(ts,
+		DRV_GET_ARRAY(addr_fw_define_int_is_edge), data, DATA_LEN_4);
+	if ((data[1] & 0x01) == 1)
+		int_is_edge = true;
+	else
+		int_is_edge = false;
+
+	/*1. Read number of MKey R100070E8H to determin data size*/
+	g_core_fp.fp_register_read(ts, SRAM_GET_ARRAY(addr_mkey), data,
+		DATA_LEN_4);
+	bt_num = data[0] & 0x03;
+	ts->ic_data->HX_BT_NUM = bt_num;
+
+	addr.dword = 0x1000719C;
+	addr.dword = cpu_to_le32(addr.dword);
+
+	g_core_fp.fp_register_read(ts, addr.byte, data, DATA_LEN_4);
+	stylus_func = data[3];
+	ts->ic_data->HX_STYLUS_FUNC = stylus_func;
+
+	ts->ic_data->HX_RX_NUM = rx_num;
+
+	ts->ic_data->HX_TX_NUM = tx_num;
+
+	ts->ic_data->HX_X_RES = x_res;
+	ts->ic_data->HX_Y_RES = y_res;
+	ts->ic_data->HX_MAX_PT = max_pt;
+	ts->ic_data->HX_INT_IS_EDGE = int_is_edge;
+
+	if (ts->ic_data->HX_STYLUS_FUNC) {
+		addr.dword = 0x100071FC;
+		addr.dword = cpu_to_le32(addr.dword);
+		g_core_fp.fp_register_read(ts, addr.byte, data, DATA_LEN_4);
+		stylus_id_v2 = data[2];/* 0x100071FE 0=off 1=on */
+		stylus_ratio = data[3];
+		/* 0x100071FF 0=ratio_1 10=ratio_10 */
+		ts->ic_data->HX_STYLUS_ID_V2 = stylus_id_v2;
+		ts->ic_data->HX_STYLUS_RATIO = stylus_ratio;
+	}
+
+	I("TOUCH_INFO updated");
+
+	return 0;
+}
+
+static void himax_mcu_touch_information(struct himax_ts_data *ts)
+{
+	if (ts->ic_data->HX_RX_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_RX_NUM = FIX_HX_RX_NUM;
+
+	if (ts->ic_data->HX_TX_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_TX_NUM = FIX_HX_TX_NUM;
+
+	if (ts->ic_data->HX_BT_NUM == 0xFFFFFFFF)
+		ts->ic_data->HX_BT_NUM = FIX_HX_BT_NUM;
+
+	if (ts->ic_data->HX_MAX_PT == 0xFFFFFFFF)
+		ts->ic_data->HX_MAX_PT = FIX_HX_MAX_PT;
+
+	if (ts->ic_data->HX_INT_IS_EDGE == 0xFF)
+		ts->ic_data->HX_INT_IS_EDGE = FIX_HX_INT_IS_EDGE;
+
+	if (ts->ic_data->HX_STYLUS_FUNC == 0xFF)
+		ts->ic_data->HX_STYLUS_FUNC = FIX_HX_STYLUS_FUNC;
+
+	if (ts->ic_data->HX_STYLUS_ID_V2 == 0xFF)
+		ts->ic_data->HX_STYLUS_ID_V2 = FIX_HX_STYLUS_ID_V2;
+
+	if (ts->ic_data->HX_STYLUS_RATIO == 0xFF)
+		ts->ic_data->HX_STYLUS_RATIO = FIX_HX_STYLUS_RATIO;
+
+	I("HX_RX_NUM = %d,HX_TX_NUM = %d",
+	  ts->ic_data->HX_RX_NUM, ts->ic_data->HX_TX_NUM);
+	I("HX_MAX_PT = %d", ts->ic_data->HX_MAX_PT);
+	I("HX_INT_IS_EDGE = %d,HX_STYLUS_FUNC = %d",
+	  ts->ic_data->HX_INT_IS_EDGE, ts->ic_data->HX_STYLUS_FUNC);
+	I("HX_STYLUS_ID_V2 = %d,HX_STYLUS_RATIO = %d",
+	  ts->ic_data->HX_STYLUS_ID_V2, ts->ic_data->HX_STYLUS_RATIO);
+}
+
+static void himax_mcu_calc_touch_data_size(struct himax_ts_data *ts)
+{
+	ts->x_channel = ts->ic_data->HX_RX_NUM;
+	ts->y_channel = ts->ic_data->HX_TX_NUM;
+	ts->n_finger_support = ts->ic_data->HX_MAX_PT;
+}
+
+static int himax_mcu_get_touch_data_size(void)
+{
+	return HIMAX_TOUCH_DATA_SIZE;
+}
+
+static int himax_mcu_hand_shaking(void)
+{
+	/* 0:Running, 1:Stop, 2:I2C Fail */
+	int result = 0;
+	return result;
+}
+
+static int himax_mcu_determin_diag_rawdata(int diag_command)
+{
+	return diag_command % 10;
+}
+
+static int himax_mcu_determin_diag_storage(int diag_command)
+{
+	return diag_command / 10;
+}
+
+static int himax_mcu_cal_data_len(int raw_cnt_rmd, int HX_MAX_PT,
+				  int raw_cnt_max)
+{
+	int raw_data_len;
+	/* rawdata checksum is 2 bytes */
+	if (raw_cnt_rmd != 0x00)
+		raw_data_len = MAX_I2C_TRANS_SZ
+			- ((HX_MAX_PT + raw_cnt_max + 3) * 4) - 2;
+	else
+		raw_data_len = MAX_I2C_TRANS_SZ
+			- ((HX_MAX_PT + raw_cnt_max + 2) * 4) - 2;
+
+	return raw_data_len;
+}
+
+static bool himax_mcu_diag_check_sum(struct himax_ts_data *ts)
+{
+	u16 check_sum_cal = 0;
+	int i;
+
+	/* Check 128th byte CRC */
+	for (i = 0, check_sum_cal = 0;
+		i < (ts->touch_all_size
+		- ts->touch_info_size);
+		i += 2) {
+		check_sum_cal += (ts->hx_rawdata_buf[i + 1]
+			* FLASH_RW_MAX_LEN
+			+ ts->hx_rawdata_buf[i]);
+	}
+
+	if (check_sum_cal % HX64K != 0) {
+		I("fail = %2X", check_sum_cal);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int himax_mcu_ic_excp_recovery
+		(struct himax_ts_data *ts,
+		 u32 hx_excp_event,
+		 u32 hx_zero_event,
+		 u32 length)
+{
+	int ret_val = NO_ERR;
+
+	if (hx_excp_event == length) {
+		ts->excp_zero_event_count = 0;
+		ret_val = HX_EXCP_EVENT;
+	} else if (hx_zero_event == length) {
+		if (ts->excp_zero_event_count > 5) {
+			ts->excp_zero_event_count = 0;
+			I("EXCEPTION event checked - ALL Zero.");
+			ret_val = HX_EXCP_EVENT;
+		} else {
+			ts->excp_zero_event_count++;
+			I("ALL Zero event is %d times.",
+			  ts->excp_zero_event_count);
+			ret_val = HX_ZERO_EVENT_COUNT;
+		}
+	}
+
+	return ret_val;
+}
+
+static void himax_mcu_excp_ic_reset(struct himax_ts_data *ts)
+{
+	ts->excp_reset_active = 0;
+	himax_mcu_pin_reset(ts);
+	I("reset!");
+}
+
+static void himax_mcu_resend_cmd_func(struct himax_ts_data *ts, bool suspended)
+{
+	himax_cable_detect_func(ts, true);
+}
+
+/* CORE_DRIVER */
+
+static int hx_turn_on_mp_func(struct himax_ts_data *ts, int on)
+{
+	int rslt = 0;
+	int retry = 3;
+	struct hx_reg_t tmp_addr;
+	struct hx_reg_t tmp_data;
+	u8 tmp_read[4] = {0};
+
+	if (strcmp(HX83102D_ID, ts->chip_name) == 0) {
+		WORD_REG(tmp_addr, fw_addr_ctrl_mpap_ovl);
+		if (on) {
+			I("Turn on MPAP mode!");
+			WORD_REG(tmp_data, fw_data_ctrl_mpap_ovl_on);
+			do {
+				g_core_fp.fp_register_write(ts, REG_GET_ARRAY(tmp_addr),
+					REG_GET_ARRAY(tmp_data), REG_GET_SZ(tmp_data));
+				usleep_range(10000, 10001);
+				g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+					tmp_read, 4);
+
+				I("read2=0x%02X,read1=0x%02X,read0=0x%02X",
+				  tmp_read[2], tmp_read[1],
+				  tmp_read[0]);
+
+				retry--;
+			} while (((retry > 0) &&
+			(tmp_read[2] != REG_GET_ARRAY(tmp_data)[2] &&
+			tmp_read[1] != REG_GET_ARRAY(tmp_data)[1] &&
+			tmp_read[0] != REG_GET_ARRAY(tmp_data)[0])));
+		} else {
+			I("Turn off MPAP mode!");
+			WORD_REG(tmp_data, fw_data_clear);
+			do {
+				g_core_fp.fp_register_write(ts, REG_GET_ARRAY(tmp_addr),
+					REG_GET_ARRAY(tmp_data), REG_GET_SZ(tmp_data));
+				usleep_range(10000, 10001);
+				g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+					tmp_read, sizeof(tmp_read));
+
+				I("read2=0x%02X,read1=0x%02X,read0=0x%02X",
+				  tmp_read[2], tmp_read[1], tmp_read[0]);
+
+				retry--;
+			} while ((retry > 0) &&
+			(tmp_read[2] != REG_GET_ARRAY(tmp_data)[2] &&
+			tmp_read[1] != REG_GET_ARRAY(tmp_data)[1] &&
+			tmp_read[0] != REG_GET_ARRAY(tmp_data)[0]));
+		}
+	} else {
+		I("Nothing to be done!");
+	}
+
+	return rslt;
+}
+
+static void hx_dis_rload_0f(struct himax_ts_data *ts, int disable)
+{
+	/*Disable Flash Reload*/
+	g_core_fp.fp_register_write(ts,
+		DRV_GET_ARRAY(addr_fw_define_flash_reload),
+		ZF_GET_ARRAY(data_dis_flash_reload), DATA_LEN_4);
+}
+
+static void himax_mcu_clean_sram_0f(struct himax_ts_data *ts, u8 *addr,
+				    int write_len, int type)
+{
+	int total_read_times = 0;
+	int max_bus_size = MAX_I2C_TRANS_SZ;
+	int total_size_temp = 0;
+	int address = 0;
+	int i = 0;
+
+	u8 fix_data = 0x00;
+	union hx_dword_data_t tmp_addr;
+	u8 tmp_data[MAX_I2C_TRANS_SZ] = {0};
+
+	I("Entering");
+
+	total_size_temp = write_len;
+
+	tmp_addr.dword = le32_to_cpup((__le32 *)addr);
+	I("addr = 0x%08X", tmp_addr.dword);
+
+	switch (type) {
+	case 0:
+		fix_data = 0x00;
+		break;
+	case 1:
+		fix_data = 0xAA;
+		break;
+	case 2:
+		fix_data = 0xBB;
+		break;
+	}
+
+	for (i = 0; i < MAX_I2C_TRANS_SZ; i++)
+		tmp_data[i] = fix_data;
+
+	I("total size=%d", total_size_temp);
+
+	if (total_size_temp % max_bus_size == 0)
+		total_read_times = total_size_temp / max_bus_size;
+	else
+		total_read_times = total_size_temp / max_bus_size + 1;
+
+	tmp_addr.dword = cpu_to_le32(tmp_addr.dword);
+	for (i = 0; i < (total_read_times); i++) {
+		I("[log]write %d time start!", i);
+		if (total_size_temp >= max_bus_size) {
+			g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data,
+				max_bus_size);
+			total_size_temp = total_size_temp - max_bus_size;
+		} else {
+			I("last total_size_temp=%d", total_size_temp);
+			g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data,
+				total_size_temp % max_bus_size);
+		}
+		address = ((i + 1) * max_bus_size);
+		tmp_addr.dword = cpu_to_le32(address);
+
+		usleep_range(10000, 11000);
+	}
+
+	I("END");
+}
+
+static void himax_mcu_write_sram_0f(struct himax_ts_data *ts,
+				    u8 *addr, const u8 *data, u32 len)
+{
+	int max_bus_size = MAX_I2C_TRANS_SZ;
+	u32 remain_len = 0;
+	u32 address = 0;
+	u32 i;
+	struct hx_reg_t tmp_addr;
+
+	I("Entering - total write size = %d", len);
+
+#if defined(BUS_W_DLEN)
+	max_bus_size = BUS_W_DLEN - ADDR_LEN_4;
+#endif
+
+	if (strcmp(ts->chip_name, HX83121A_ID) == 0) {
+		if (max_bus_size > 4096)
+			max_bus_size = 4096;
+	}
+
+	remain_len = len;
+	address = le32_to_cpup((__le32 *)addr);
+
+	while (remain_len > 0) {
+		i = len - remain_len;
+		WORD_REG(tmp_addr, address + i);
+
+		if (remain_len > max_bus_size) {
+			g_core_fp.fp_register_write(ts, REG_GET_ARRAY(tmp_addr),
+				(u8 *)data + i, max_bus_size);
+			remain_len -= max_bus_size;
+		} else {
+			g_core_fp.fp_register_write(ts, REG_GET_ARRAY(tmp_addr),
+				(u8 *)data + i, remain_len);
+			remain_len = 0;
+		}
+	}
+
+	I("End");
+}
+
+static int himax_sram_write_crc_check(struct himax_ts_data *ts,
+				      u8 *addr, const u8 *data, u32 len)
+{
+	int retry = 0;
+	int crc = -1;
+
+	do {
+		g_core_fp.fp_write_sram_0f(ts, addr, data, len);
+		crc = g_core_fp.fp_check_crc(ts, addr, len);
+		retry++;
+		I("HW CRC %s in %d time",
+		  (crc == 0) ? "OK" : "Fail", retry);
+	} while (crc != 0 && retry < 3);
+
+	return crc;
+}
+
+static int code_overlay(struct zf_info *info, const struct firmware *fw,
+			struct himax_ts_data *ts, int type)
+{
+	int ret = 0;
+	int retry = 0;
+	union hx_dword_data_t tmp_addr = { .dword = 0x10007FFC };
+	union hx_dword_data_t rdata = {0};
+	u8 code_idx_t = 0;
+	union hx_dword_data_t code_sdata = {0};
+
+	/* ovl_idx[0] - sorting */
+	/* ovl_idx[1] - gesture */
+	/* ovl_idx[2] - border	*/
+
+	code_idx_t = ts->ovl_idx[0];
+	code_sdata.dword = ovl_sorting_reply;
+
+	if (type == 0) {
+		code_idx_t = ts->ovl_idx[2];
+		code_sdata.dword = ovl_border_reply;
+	}
+	if (code_idx_t == 0 || info[code_idx_t].write_size == 0) {
+		E("wrong code overlay section[%d, %d]!",
+		  code_idx_t, info[code_idx_t].write_size);
+		ret = FW_NOT_READY;
+		goto ALOC_CFG_BUF_FAIL;
+	}
+
+	I("upgrade code overlay section[%d]", code_idx_t);
+	if (himax_sram_write_crc_check(ts, info[code_idx_t].sram_addr,
+				       &fw->data[info[code_idx_t].fw_addr],
+				       info[code_idx_t].write_size) != 0) {
+		E("code overlay HW CRC FAIL");
+		code_sdata.dword = ovl_fault;
+		ret = 2;
+	}
+
+	retry = 0;
+	tmp_addr.dword = cpu_to_le32(tmp_addr.dword);
+	code_sdata.dword = cpu_to_le32(code_sdata.dword);
+	do {
+		g_core_fp.fp_register_write(ts, tmp_addr.byte, code_sdata.byte,
+			DATA_LEN_4);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, rdata.byte,
+			DATA_LEN_4);
+		retry++;
+	} while ((code_sdata.dword != rdata.dword) &&
+		(retry < HIMAX_REG_RETRY_TIMES));
+
+	if (retry >= HIMAX_REG_RETRY_TIMES)
+		E("fail code rpl data = 0x%08X", rdata.dword);
+
+ALOC_CFG_BUF_FAIL:
+	return ret;
+}
+
+static int alg_overlay(struct himax_ts_data *ts, u8 alg_idx_t,
+		       struct zf_info *info, const struct firmware *fw)
+{
+	int ret = 0;
+	int retry = 0;
+	union hx_dword_data_t tmp_addr = { .dword = 0x10007FFC };
+	union hx_dword_data_t rdata = {0};
+	u8 i = 0;
+	union hx_dword_data_t alg_sdata = { .dword = 0xA55A5AA5 };
+	union hx_dword_data_t data = { .dword = 0x00000001 };
+
+	if (alg_idx_t == 0 || info[alg_idx_t].write_size == 0) {
+		E("wrong alg overlay section[%d, %d]!",
+		  alg_idx_t, info[alg_idx_t].write_size);
+		ret = FW_NOT_READY;
+		goto ALOC_CFG_BUF_FAIL;
+	}
+
+	// clear handshaking to 0xA55A5AA5
+
+	retry = 0;
+	tmp_addr.dword = cpu_to_le32(tmp_addr.dword);
+	alg_sdata.dword = cpu_to_le32(alg_sdata.dword);
+	do {
+		g_core_fp.fp_register_write(ts, tmp_addr.byte, alg_sdata.byte,
+			DATA_LEN_4);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, rdata.byte,
+			DATA_LEN_4);
+	} while ((rdata.dword != alg_sdata.dword) &&
+	retry++ < HIMAX_REG_RETRY_TIMES);
+
+	if (retry > HIMAX_REG_RETRY_TIMES) {
+		E("init handshaking data FAIL[0x%08X]!!",
+		  le32_to_cpu(rdata.dword));
+	}
+
+	alg_sdata.dword = ovl_alg_reply;
+
+	g_core_fp.fp_reload_disable(ts, 0);
+
+	/*Rawout Sel initial*/
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_raw_out_sel),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+	/*DSRAM func initial*/
+	g_core_fp.fp_assign_sorting_mode(ts, FW_GET_ARRAY(data_clear));
+	/* reset N frame back to default for normal mode */
+	g_core_fp.fp_register_write(ts, FW_GET_ARRAY(addr_set_frame_addr),
+		data.byte, 4);
+	/*FW reload done initial*/
+	g_core_fp.fp_register_write(ts,
+		DRV_GET_ARRAY(addr_fw_define_2nd_flash_reload),
+		FW_GET_ARRAY(data_clear), FW_GET_SZ(data_clear));
+
+	g_core_fp.fp_sense_on(ts, 0x00);
+
+	retry = 0;
+	do {
+		usleep_range(3000, 3100);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, rdata.byte, DATA_LEN_4);
+	} while ((rdata.dword != ovl_alg_request) && retry++ < 30);
+
+	if (retry > 30) {
+		E("fail req data = 0x%08X", le32_to_cpu(rdata.dword));
+		/* monitor FW status for debug */
+		for (i = 0; i < 10; i++) {
+			usleep_range(10000, 10100);
+			g_core_fp.fp_register_read(ts, tmp_addr.byte, rdata.byte,
+				DATA_LEN_4);
+			I("req data = 0x%08X", le32_to_cpu(rdata.dword));
+			g_core_fp.fp_read_FW_status(ts);
+		}
+		ret = 3;
+		goto BURN_OVL_FAIL;
+	}
+
+	I("upgrade alg overlay section[%d]", alg_idx_t);
+
+	if (himax_sram_write_crc_check(ts, info[alg_idx_t].sram_addr,
+				       &fw->data[info[alg_idx_t].fw_addr],
+				       info[alg_idx_t].write_size) != 0) {
+		E("Alg Overlay HW CRC FAIL");
+		ret = 2;
+	}
+
+	retry = 0;
+	do {
+		g_core_fp.fp_register_write(ts, tmp_addr.byte, alg_sdata.byte,
+			DATA_LEN_4);
+		usleep_range(1000, 1100);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, rdata.byte, DATA_LEN_4);
+	} while ((alg_sdata.dword != rdata.dword) &&
+	retry++ < HIMAX_REG_RETRY_TIMES);
+
+	if (retry > HIMAX_REG_RETRY_TIMES) {
+		E("fail rpl data = 0x%08X",	le32_to_cpu(rdata.dword));
+		// maybe need to reset
+	} else {
+		I("waiting for FW reload data");
+
+		retry = 0;
+		while (retry++ < 30) {
+			g_core_fp.fp_register_read(ts,
+				DRV_GET_ARRAY(addr_fw_define_2nd_flash_reload),
+				data.byte, DATA_LEN_4);
+
+			/* use all 4 bytes to compare */
+			if (le32_to_cpu(data.dword) == 0x72C0) {
+				I("FW reload done");
+					break;
+			}
+			I("wait FW reload %d times", retry);
+			g_core_fp.fp_read_FW_status(ts);
+			usleep_range(10000, 11000);
+		}
+	}
+
+BURN_OVL_FAIL:
+ALOC_CFG_BUF_FAIL:
+	return ret;
+}
+
+int himax_zf_part_info(const struct firmware *fw, struct himax_ts_data *ts,
+		       int type)
+{
+	u32 table_addr = FLASH_VER_GET_VAL(addr_cfg_table);
+	int pnum = 0;
+	int ret = 0;
+	u8 buf[16];
+	struct zf_info *info;
+	u8 sram_min[4];
+	int cfg_sz = 0;
+	int cfg_crc_sw = 0;
+	int cfg_crc_hw = 0;
+	s32 i = 0;
+	int i_max = 0;
+	int i_min = 0;
+	u32 dsram_base = 0xFFFFFFFF;
+	u32 dsram_max = 0;
+	int retry = 0;
+	int allovlidx = 0;
+	s32 alg_idx_t = 0;
+	s32 j = 0;
+	bool has_code_overlay = false;
+
+	ts->has_alg_overlay = false;
+
+	/* 1. initial check */
+	if (g_core_fp._en_hw_crc)
+		g_core_fp._en_hw_crc(ts, 1);
+	pnum = fw->data[table_addr + 12];
+	if (pnum < 2) {
+		E("partition number is not correct");
+		return FW_NOT_READY;
+	}
+
+	info = kcalloc(pnum, sizeof(struct zf_info), GFP_KERNEL);
+	if (!info) {
+		E("memory allocation fail[info]!!");
+		return 1;
+	}
+	memset(info, 0, pnum * sizeof(struct zf_info));
+	if (!ts->ovl_idx) {
+		ts->ovl_idx = kcalloc(ovl_section_num, sizeof(u8), GFP_KERNEL);
+		if (!ts->ovl_idx) {
+			E("memory allocation fail[ovl_idx]!!");
+			ret = 1;
+			goto ALOC_CFG_BUF_FAIL;
+		}
+	}
+	memset(ts->ovl_idx, 0, ovl_section_num);
+
+	/* 2. record partition information */
+	memcpy(buf, &fw->data[table_addr], 16);
+	memcpy(info[0].sram_addr, buf, 4);
+	info[0].write_size = le32_to_cpup((u32 *)&buf[4]);
+	info[0].fw_addr = le32_to_cpup((u32 *)&buf[8]);
+	I("[%d]SRAM addr=%08X, fw_addr=%08X, write_size=%d",
+	  0, info[0].cfg_addr, info[0].fw_addr,
+	  info[0].write_size);
+
+	for (i = 1; i < pnum; i++) {
+		memcpy(buf, &fw->data[i * 0x10 + table_addr], 16);
+
+		memcpy(info[i].sram_addr, buf, 4);
+		info[i].write_size = le32_to_cpup((u32 *)&buf[4]);
+		info[i].fw_addr = le32_to_cpup((u32 *)&buf[8]);
+		info[i].cfg_addr = le32_to_cpup((u32 *)&info[i].sram_addr[0]);
+
+		if (info[i].cfg_addr % 4 != 0)
+			info[i].cfg_addr -= (info[i].cfg_addr % 4);
+
+		I("[%d]SRAM addr=%08X, fw_addr=%08X, write_size=%d",
+		  i, info[i].cfg_addr, info[i].fw_addr,
+		  info[i].write_size);
+
+		/* alg overlay section */
+		if ((buf[15] == 0x77 && buf[14] == 0x88)) {
+			I("find alg overlay section in index %d", i);
+			/* record index of alg overlay section */
+			allovlidx |= 1 << i;
+			alg_idx_t = i;
+			ts->has_alg_overlay = true;
+			continue;
+		}
+
+		/* code overlay section */
+		if ((buf[15] == 0x55 && buf[14] == 0x66) ||
+		    le32_to_cpup((u32 *)&buf[0]) == 0x20008CE0) {
+			I("find code overlay section in index %d", i);
+			has_code_overlay = true;
+			/* record index of code overlay section */
+			allovlidx |= 1 << i;
+			if (buf[15] == 0x55 && buf[14] == 0x66) {
+				/* current mechanism */
+				j = buf[13];
+				if (j < ovl_section_num)
+					ts->ovl_idx[j] = i;
+			} else {
+				/* previous mechanism */
+				if (j < ovl_section_num)
+					ts->ovl_idx[j++] = i;
+			}
+			continue;
+		}
+
+		if (dsram_base > info[i].cfg_addr) {
+			dsram_base = info[i].cfg_addr;
+			i_min = i;
+		}
+		if (dsram_max < info[i].cfg_addr) {
+			dsram_max = info[i].cfg_addr;
+			i_max = i;
+		}
+	}
+
+	/* 3. prepare data to update */
+	for (i = 0; i < ADDR_LEN_4; i++)
+		sram_min[i] = (info[i_min].cfg_addr >> (8 * i)) & 0xFF;
+
+	D("dsram_max: %d, dsram_base: %d, write_size: %d",
+	  dsram_max, dsram_base, info[i_max].write_size);
+	cfg_sz = (dsram_max - dsram_base) + info[i_max].write_size;
+	if (cfg_sz % 16 != 0)
+		cfg_sz = cfg_sz + 16 - (cfg_sz % 16);
+
+	I("cfg_sz = %d!, dsram_base = %X, dsram_max = %X",
+	  cfg_sz, dsram_base, dsram_max);
+	/* config size should be smaller than DSRAM size */
+	if (cfg_sz > ts->chip_max_dsram_size) {
+		E("config size error[%d, %d]!!",
+		  cfg_sz, ts->chip_max_dsram_size);
+		ret = LENGTH_FAIL;
+		goto ALOC_CFG_BUF_FAIL;
+	}
+
+	memset(ts->zf_update_cfg_buffer, 0x00,
+	       ts->chip_max_dsram_size * sizeof(u8));
+
+	for (i = 1; i < pnum; i++) {
+		/* overlay section */
+		if (allovlidx & (1 << i)) {
+			I("skip overlay section %d", i);
+			continue;
+		}
+
+		memcpy(&ts->zf_update_cfg_buffer[info[i].cfg_addr - dsram_base],
+		       &fw->data[info[i].fw_addr], info[i].write_size);
+	}
+
+	/* 4. write to sram */
+	/* FW entity */
+	if (himax_sram_write_crc_check(ts, info[0].sram_addr,
+				       &fw->data[info[0].fw_addr], info[0].write_size) != 0) {
+		E("HW CRC FAIL");
+		ret = 2;
+		goto BURN_SRAM_FAIL;
+	}
+
+	cfg_crc_sw = g_core_fp.fp_calculate_crc_with_ap(ts->zf_update_cfg_buffer,
+		0, cfg_sz);
+	do {
+		g_core_fp.fp_write_sram_0f(ts, sram_min, ts->zf_update_cfg_buffer,
+			cfg_sz);
+		cfg_crc_hw = g_core_fp.fp_check_crc(ts, sram_min, cfg_sz);
+		if (cfg_crc_hw != cfg_crc_sw) {
+			E("Cfg CRC FAIL,HWCRC=%X,SWCRC=%X,retry=%d",
+			  cfg_crc_hw, cfg_crc_sw, retry);
+		}
+	} while (cfg_crc_hw != cfg_crc_sw && retry++ < 3);
+
+	if (retry > 3) {
+		ret = 2;
+		goto BURN_SRAM_FAIL;
+	}
+
+	/*write back system config*/
+	if (type == 0)
+		g_core_fp.fp_resend_cmd_func(ts, ts->suspended);
+
+	if (ts->has_alg_overlay)
+		ret = alg_overlay(ts, alg_idx_t, info, fw);
+	if (has_code_overlay)
+		ret = code_overlay(info, fw, ts, type);
+
+BURN_SRAM_FAIL:
+ALOC_CFG_BUF_FAIL:
+	kfree(info);
+
+	return ret;
+/* ret = 1, memory allocation fail
+ *     = 2, crc fail
+ *     = 3, flow control error
+ */
+}
+
+int himax_mcu_firmware_update_0f(const struct firmware *fw,
+				 struct himax_ts_data *ts, int type)
+{
+	int ret = 0;
+	bool bret;
+
+	I("Entering - total FW size=%d", (int)fw->size);
+
+	g_core_fp.fp_register_write(ts, ZF_GET_ARRAY(addr_system_reset),
+		ZF_GET_ARRAY(data_system_reset), 4);
+
+	bret = g_core_fp.fp_sense_off(ts, false);
+	if (!bret) {
+		E("sense off fail");
+		return -1;
+	}
+
+	if ((int)fw->size > HX64K) {
+		ret = himax_zf_part_info(fw, ts, type);
+	} else {
+		/* first 48K */
+		ret = himax_sram_write_crc_check
+			(ts, ZF_GET_ARRAY(data_sram_start_addr), &fw->data[0], HX_48K_SZ);
+		if (ret != 0)
+			E("HW CRC FAIL - Main SRAM 48K");
+
+		/*config info*/
+		if (!ts->ic_data->has_flash) {
+			ret = himax_sram_write_crc_check(ts, ZF_GET_ARRAY(data_cfg_info),
+							 &fw->data[0xc000], 128);
+			if (ret != 0)
+				E("Config info CRC Fail!");
+		} else {
+			g_core_fp.fp_clean_sram_0f(ts, ZF_GET_ARRAY(data_cfg_info),
+				128, 2);
+		}
+
+		if (!ts->ic_data->has_flash) {
+			ret = himax_sram_write_crc_check(ts, ZF_GET_ARRAY(data_fw_cfg_1),
+							 &fw->data[0xc0fe], 528);
+			if (ret != 0)
+				E("FW config 1 CRC Fail!");
+		} else {
+			g_core_fp.fp_clean_sram_0f(ts, ZF_GET_ARRAY(data_fw_cfg_1),
+				528, 1);
+		}
+
+		if (!ts->ic_data->has_flash) {
+			ret = himax_sram_write_crc_check(ts, ZF_GET_ARRAY(data_fw_cfg_3),
+							 &fw->data[0xca00], 128);
+			if (ret != 0)
+				E("FW config 3 CRC Fail!");
+		} else {
+			g_core_fp.fp_clean_sram_0f(ts, ZF_GET_ARRAY(data_fw_cfg_3),
+				128, 2);
+		}
+
+		/*ADC config*/
+		if (!ts->ic_data->has_flash) {
+			ret = himax_sram_write_crc_check(ts, ZF_GET_ARRAY(data_adc_cfg_1),
+							 &fw->data[0xd640], 1200);
+			if (ret != 0)
+				E("ADC config 1 CRC Fail!");
+		} else {
+			g_core_fp.fp_clean_sram_0f(ts, ZF_GET_ARRAY(data_adc_cfg_1),
+				1200, 2);
+		}
+
+		if (!ts->ic_data->has_flash) {
+			ret = himax_sram_write_crc_check(ts, ZF_GET_ARRAY(data_adc_cfg_2),
+							 &fw->data[0xd320], 800);
+			if (ret != 0)
+				E("ADC config 2 CRC Fail!");
+		} else {
+			g_core_fp.fp_clean_sram_0f(ts, ZF_GET_ARRAY(data_adc_cfg_2),
+				800, 2);
+		}
+
+		/*mapping table*/
+		if (!ts->ic_data->has_flash) {
+			ret = himax_sram_write_crc_check(ts, ZF_GET_ARRAY(data_map_table),
+							 &fw->data[0xe000], 1536);
+			if (ret != 0)
+				E("Mapping table CRC Fail!");
+		} else {
+			g_core_fp.fp_clean_sram_0f(ts, ZF_GET_ARRAY(data_map_table),
+				1536, 2);
+		}
+	}
+
+	I("End");
+
+	return ret;
+}
+
+int hx_0f_op_file_dirly(char *file_name, struct himax_ts_data *ts)
+{
+	const struct firmware *fw = NULL;
+	int reqret = -1;
+	int ret = -1;
+	int type = 0; /* FW type: 0, normal; 1, MPAP */
+
+	if (ts->zf_update_flag) {
+		W("Other thread is updating now!");
+		return ret;
+	}
+	ts->zf_update_flag = true;
+	I("Preparing to update %s!", file_name);
+
+	reqret = request_firmware(&fw, file_name, ts->dev);
+	if (reqret < 0) {
+		ret = reqret;
+		E("request firmware fail, code[%d]!!", ret);
+		goto END;
+	}
+
+	if (strcmp(file_name, MPAP_FWNAME) == 0)
+		type = 1;
+
+	ret = g_core_fp.fp_firmware_update_0f(fw, ts, type);
+
+	if (reqret >= 0)
+		release_firmware(fw);
+
+	if (ret < 0)
+		goto END;
+
+	if (!ts->has_alg_overlay) {
+		if (type == 1)
+			g_core_fp.fp_turn_on_mp_func(ts, 1);
+		else
+			g_core_fp.fp_turn_on_mp_func(ts, 0);
+		g_core_fp.fp_reload_disable(ts, 0);
+		g_core_fp.fp_power_on_init(ts);
+	}
+
+END:
+	ts->zf_update_flag = false;
+
+	I("END");
+	return ret;
+}
+
+static int himax_mcu_0f_excp_check(void)
+{
+	return NO_ERR;
+}
+
+void himax_mcu_read_sram_0f(struct himax_ts_data *ts,
+			    const struct firmware *fw_entry,
+			    u8 *addr, int start_index, int read_len)
+{
+	int total_read_times = 0;
+	int max_bus_size = MAX_I2C_TRANS_SZ;
+	int total_size_temp = 0;
+	int total_size = 0;
+	int address = 0;
+	int i = 0, j = 0;
+	int not_same = 0;
+	struct hx_reg_t in_addr = { .data = {0}, .len = 4 };
+	struct hx_reg_t tmp_addr = { .data = {0}, .len = 4 };
+	u8 *temp_info_data = NULL;
+	int *not_same_buff = NULL;
+
+	I("Entering");
+	PTR_SET(in_addr, addr, 4);
+	total_size = read_len;
+	total_size_temp = read_len;
+
+	if (read_len > 2048)
+		max_bus_size = 2048;
+	else
+		max_bus_size = read_len;
+
+	if (total_size % max_bus_size == 0)
+		total_read_times = total_size / max_bus_size;
+	else
+		total_read_times = total_size / max_bus_size + 1;
+
+	I("total size=%d, bus size=%d, read time=%d",
+	  total_size, max_bus_size,	total_read_times);
+
+	memcpy(REG_GET_ARRAY(tmp_addr), addr, 4);
+	I("addr[3]=0x%2X,addr[2]=0x%2X,addr[1]=0x%2X,addr[0]=0x%2X",
+	  REG_GET_ARRAY(tmp_addr)[3], REG_GET_ARRAY(tmp_addr)[2],
+	  REG_GET_ARRAY(tmp_addr)[1], REG_GET_ARRAY(tmp_addr)[0]);
+
+	temp_info_data = kcalloc(total_size, sizeof(u8), GFP_KERNEL);
+	if (!temp_info_data) {
+		E("Failed to allocate temp_info_data");
+		goto err_malloc_temp_info_data;
+	}
+
+	not_same_buff = kcalloc(total_size, sizeof(int), GFP_KERNEL);
+	if (!not_same_buff) {
+		E("Failed to allocate not_same_buff");
+		goto err_malloc_not_same_buff;
+	}
+
+	for (i = 0; i < (total_read_times); i++) {
+		if (total_size_temp >= max_bus_size) {
+			g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+				&temp_info_data[i * max_bus_size], max_bus_size);
+			total_size_temp = total_size_temp - max_bus_size;
+		} else {
+			g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+				&temp_info_data[i * max_bus_size],
+				total_size_temp % max_bus_size);
+		}
+
+		address = ((i + 1) * max_bus_size);
+		WORD_REG(tmp_addr, address + REG_GET_VAL(in_addr));
+	}
+	I("READ Start, start_index = %d", start_index);
+
+	j = start_index;
+	for (i = 0; i < read_len; i++, j++) {
+		if (fw_entry->data[j] != temp_info_data[i]) {
+			not_same++;
+			not_same_buff[i] = 1;
+		}
+
+		I("0x%2.2X, ", temp_info_data[i]);
+
+		if (i > 0 && i % 16 == 15)
+			pr_info("\n");
+	}
+	I("READ END,Not Same count=%d", not_same);
+
+	if (not_same != 0) {
+		j = start_index;
+		for (i = 0; i < read_len; i++, j++) {
+			if (not_same_buff[i] == 1)
+				I("bin=[%d] 0x%2.2X", i, fw_entry->data[j]);
+		}
+		for (i = 0; i < read_len; i++, j++) {
+			if (not_same_buff[i] == 1)
+				I("sram=[%d] 0x%2.2X", i, temp_info_data[i]);
+		}
+	}
+	I("READ END, Not Same count=%d", not_same);
+
+	kfree(not_same_buff);
+err_malloc_not_same_buff:
+	kfree(temp_info_data);
+err_malloc_temp_info_data:
+	return;
+}
+
+void himax_mcu_read_all_sram(struct himax_ts_data *ts, u8 *addr,
+			     int read_len)
+{
+	int total_read_times = 0;
+	int max_bus_size = MAX_I2C_TRANS_SZ;
+	int total_size_temp = 0;
+	int total_size = 0;
+	int address = 0;
+	int i = 0;
+	struct hx_reg_t tmp_addr = { .data = {0}, .len = 4 };
+	u8 *temp_info_data;
+
+	I("Entering");
+
+	total_size = read_len;
+	total_size_temp = read_len;
+
+	if (total_size % max_bus_size == 0)
+		total_read_times = total_size / max_bus_size;
+	else
+		total_read_times = total_size / max_bus_size + 1;
+
+	I("total size=%d", total_size);
+
+	PTR_SET(tmp_addr, addr, 4);
+	I("addr[3]=0x%2X,addr[2]=0x%2X,addr[1]=0x%2X,addr[0]=0x%2X",
+	  REG_GET_ARRAY(tmp_addr)[3], REG_GET_ARRAY(tmp_addr)[2],
+	  REG_GET_ARRAY(tmp_addr)[1], REG_GET_ARRAY(tmp_addr)[0]);
+
+	temp_info_data = kcalloc(total_size, sizeof(u8), GFP_KERNEL);
+	if (!temp_info_data) {
+		E("Failed to allocate temp_info_data");
+		return;
+	}
+
+	for (i = 0; i < (total_read_times); i++) {
+		if (total_size_temp >= max_bus_size) {
+			g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+				&temp_info_data[i * max_bus_size], max_bus_size);
+			total_size_temp = total_size_temp - max_bus_size;
+		} else {
+			g_core_fp.fp_register_read(ts, REG_GET_ARRAY(tmp_addr),
+				&temp_info_data[i * max_bus_size],
+				total_size_temp % max_bus_size);
+		}
+
+		address = ((i + 1) * max_bus_size);
+		WORD_REG(tmp_addr, address + REG_GET_VAL(tmp_addr));
+	}
+	I("addr[3]=0x%2X,addr[2]=0x%2X,addr[1]=0x%2X,addr[0]=0x%2X",
+	  REG_GET_ARRAY(tmp_addr)[3], REG_GET_ARRAY(tmp_addr)[2],
+	  REG_GET_ARRAY(tmp_addr)[1], REG_GET_ARRAY(tmp_addr)[0]);
+
+	kfree(temp_info_data);
+
+	I("END");
+}
+
+void himax_mcu_firmware_read_0f(struct himax_ts_data *ts,
+				const struct firmware *fw_entry, int type)
+{
+	u8 tmp_addr[4];
+
+	I("Entering");
+	if (type == 0) { /* first 48K */
+		g_core_fp.fp_read_sram_0f(ts, fw_entry,
+			ZF_GET_ARRAY(data_sram_start_addr),
+			0,
+			HX_48K_SZ);
+		g_core_fp.fp_read_all_sram(ts, tmp_addr, 0xC000);
+	} else { /*last 16k*/
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_cfg_info),
+			0xC000, 132);
+
+		/*FW config*/
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_fw_cfg_1),
+			0xC0FE, 484);
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_fw_cfg_2),
+			0xC9DE, 36);
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_fw_cfg_3),
+			0xCA00, 72);
+
+		/*ADC config*/
+
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_adc_cfg_1),
+			0xD630, 1188);
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_adc_cfg_2),
+			0xD318, 792);
+
+		/*mapping table*/
+		g_core_fp.fp_read_sram_0f(ts, fw_entry, ZF_GET_ARRAY(data_map_table),
+			0xE000, 1536);
+
+		/* set n frame=0*/
+		g_core_fp.fp_read_sram_0f(ts, fw_entry,
+			FW_GET_ARRAY(addr_set_frame_addr), 0xC30C, 4);
+	}
+
+	I("END");
+}
+
+void himax_ic_reg_init(struct himax_core_command_regs *reg_data)
+{
+	I("Entering!");
+/* CORE_IC -start- */
+	BYTE_REG(reg_data->ic_op.addr_ahb_addr_byte_0, ic_adr_ahb_addr_byte_0);
+	BYTE_REG(reg_data->ic_op.addr_ahb_rdata_byte_0, ic_adr_ahb_rdata_byte_0);
+	BYTE_REG(reg_data->ic_op.addr_ahb_access_direction, ic_adr_ahb_access_direction);
+	BYTE_REG(reg_data->ic_op.addr_conti, ic_adr_conti);
+	BYTE_REG(reg_data->ic_op.addr_incr4, ic_adr_incr4);
+	BYTE_REG(reg_data->ic_op.adr_i2c_psw_lb, ic_adr_i2c_psw_lb);
+	BYTE_REG(reg_data->ic_op.adr_i2c_psw_ub, ic_adr_i2c_psw_ub);
+	BYTE_REG(reg_data->ic_op.data_ahb_access_direction_read, ic_cmd_ahb_access_direction_read);
+	BYTE_REG(reg_data->ic_op.data_conti, ic_cmd_conti);
+	BYTE_REG(reg_data->ic_op.data_incr4, ic_cmd_incr4);
+	BYTE_REG(reg_data->ic_op.data_i2c_psw_lb, ic_cmd_i2c_psw_lb);
+	BYTE_REG(reg_data->ic_op.data_i2c_psw_ub, ic_cmd_i2c_psw_ub);
+	WORD_REG(reg_data->ic_op.addr_tcon_on_rst, ic_adr_tcon_on_rst);
+	WORD_REG(reg_data->ic_op.addr_adc_on_rst, ic_addr_adc_on_rst);
+	WORD_REG(reg_data->ic_op.addr_psl, ic_adr_psl);
+	WORD_REG(reg_data->ic_op.addr_cs_central_state, ic_adr_cs_central_state);
+	WORD_REG(reg_data->ic_op.data_rst, ic_cmd_rst);
+	WORD_REG(reg_data->ic_op.adr_osc_en, ic_adr_osc_en);
+	WORD_REG(reg_data->ic_op.adr_osc_pw, ic_adr_osc_pw);
+/* CORE_IC -end- */
+/* CORE_FW -start- */
+	WORD_REG(reg_data->fw_op.addr_system_reset, fw_addr_system_reset);
+	WORD_REG(reg_data->fw_op.addr_ctrl_fw_isr, fw_addr_ctrl_fw);
+	WORD_REG(reg_data->fw_op.addr_flag_reset_event, fw_addr_flag_reset_event);
+	WORD_REG(reg_data->fw_op.addr_hsen_enable, fw_addr_hsen_enable);
+	WORD_REG(reg_data->fw_op.addr_program_reload_from,
+		 fw_addr_program_reload_from);
+	WORD_REG(reg_data->fw_op.addr_program_reload_to,
+		 fw_addr_program_reload_to);
+	WORD_REG(reg_data->fw_op.addr_program_reload_page_write,
+		 fw_addr_program_reload_page_write);
+	WORD_REG(reg_data->fw_op.addr_raw_out_sel, fw_addr_raw_out_sel);
+	WORD_REG(reg_data->fw_op.addr_reload_status, fw_addr_reload_status);
+	WORD_REG(reg_data->fw_op.addr_reload_crc32_result,
+		 fw_addr_reload_crc32_result);
+	WORD_REG(reg_data->fw_op.addr_reload_addr_from, fw_addr_reload_addr_from);
+	WORD_REG(reg_data->fw_op.addr_reload_addr_cmd_beat,
+		 fw_addr_reload_addr_cmd_beat);
+	WORD_REG(reg_data->fw_op.addr_selftest_addr_en, fw_addr_selftest_addr_en);
+	WORD_REG(reg_data->fw_op.addr_criteria_addr, fw_addr_criteria_addr);
+	WORD_REG(reg_data->fw_op.addr_set_frame_addr, fw_addr_set_frame_addr);
+	WORD_REG(reg_data->fw_op.addr_selftest_result_addr,
+		 fw_addr_selftest_result_addr);
+	WORD_REG(reg_data->fw_op.addr_sorting_mode_en, fw_addr_sorting_mode_en);
+	WORD_REG(reg_data->fw_op.addr_fw_mode_status, fw_addr_fw_mode_status);
+	WORD_REG(reg_data->fw_op.addr_icid_addr, fw_addr_icid_addr);
+	WORD_REG(reg_data->fw_op.addr_fw_ver_addr, fw_addr_fw_ver_addr);
+	WORD_REG(reg_data->fw_op.addr_fw_cfg_addr, fw_addr_fw_cfg_addr);
+	WORD_REG(reg_data->fw_op.addr_fw_vendor_addr, fw_addr_fw_vendor_addr);
+	WORD_REG(reg_data->fw_op.addr_cus_info, fw_addr_cus_info);
+	WORD_REG(reg_data->fw_op.addr_proj_info, fw_addr_proj_info);
+	WORD_REG(reg_data->fw_op.addr_fw_state_addr, fw_addr_fw_state_addr);
+	WORD_REG(reg_data->fw_op.addr_fw_dbg_msg_addr, fw_addr_fw_dbg_msg_addr);
+	WORD_REG(reg_data->fw_op.addr_chk_fw_status, fw_addr_chk_fw_status);
+	WORD_REG(reg_data->fw_op.addr_dd_handshak_addr, fw_addr_dd_handshak_addr);
+	WORD_REG(reg_data->fw_op.addr_dd_data_addr, fw_addr_dd_data_addr);
+	WORD_REG(reg_data->fw_op.addr_clr_fw_record_dd_sts,
+		 fw_addr_clr_fw_record_dd_sts);
+	WORD_REG(reg_data->fw_op.addr_ap_notify_fw_sus, fw_addr_ap_notify_fw_sus);
+	WORD_REG(reg_data->fw_op.data_ap_notify_fw_sus_en,
+		 fw_data_ap_notify_fw_sus_en);
+	WORD_REG(reg_data->fw_op.data_ap_notify_fw_sus_dis,
+		 fw_data_ap_notify_fw_sus_dis);
+	WORD_REG(reg_data->fw_op.data_system_reset, fw_data_system_reset);
+	WORD_REG(reg_data->fw_op.data_safe_mode_release_pw_active,
+		 fw_data_safe_mode_release_pw_active);
+	WORD_REG(reg_data->fw_op.data_safe_mode_release_pw_reset,
+		 fw_data_safe_mode_release_pw_reset);
+	WORD_REG(reg_data->fw_op.data_clear, fw_data_clear);
+	WORD_REG(reg_data->fw_op.data_fw_stop, fw_data_fw_stop);
+	WORD_REG(reg_data->fw_op.data_program_reload_start,
+		 fw_data_program_reload_start);
+	WORD_REG(reg_data->fw_op.data_program_reload_compare,
+		 fw_data_program_reload_compare);
+	WORD_REG(reg_data->fw_op.data_program_reload_break,
+		 fw_data_program_reload_break);
+	WORD_REG(reg_data->fw_op.data_selftest_request, fw_data_selftest_request);
+	BYTE_REG(reg_data->fw_op.data_criteria_aa_top, fw_data_criteria_aa_top);
+	BYTE_REG(reg_data->fw_op.data_criteria_aa_bot, fw_data_criteria_aa_bot);
+	BYTE_REG(reg_data->fw_op.data_criteria_key_top, fw_data_criteria_key_top);
+	BYTE_REG(reg_data->fw_op.data_criteria_key_bot, fw_data_criteria_key_bot);
+	BYTE_REG(reg_data->fw_op.data_criteria_avg_top, fw_data_criteria_avg_top);
+	BYTE_REG(reg_data->fw_op.data_criteria_avg_bot, fw_data_criteria_avg_bot);
+	WORD_REG(reg_data->fw_op.data_set_frame, fw_data_set_frame);
+	BYTE_REG(reg_data->fw_op.data_selftest_ack_hb, fw_data_selftest_ack_hb);
+	BYTE_REG(reg_data->fw_op.data_selftest_ack_lb, fw_data_selftest_ack_lb);
+	BYTE_REG(reg_data->fw_op.data_selftest_pass, fw_data_selftest_pass);
+	BYTE_REG(reg_data->fw_op.data_normal_cmd, fw_data_normal_cmd);
+	BYTE_REG(reg_data->fw_op.data_normal_status, fw_data_normal_status);
+	BYTE_REG(reg_data->fw_op.data_sorting_cmd, fw_data_sorting_cmd);
+	BYTE_REG(reg_data->fw_op.data_sorting_status, fw_data_sorting_status);
+	BYTE_REG(reg_data->fw_op.data_dd_request, fw_data_dd_request);
+	BYTE_REG(reg_data->fw_op.data_dd_ack, fw_data_dd_ack);
+	BYTE_REG(reg_data->fw_op.data_idle_dis_pwd, fw_data_idle_dis_pwd);
+	BYTE_REG(reg_data->fw_op.data_idle_en_pwd, fw_data_idle_en_pwd);
+	BYTE_REG(reg_data->fw_op.data_rawdata_ready_hb, fw_data_rawdata_ready_hb);
+	BYTE_REG(reg_data->fw_op.data_rawdata_ready_lb, fw_data_rawdata_ready_lb);
+	BYTE_REG(reg_data->fw_op.addr_ahb_addr, fw_addr_ahb_addr);
+	BYTE_REG(reg_data->fw_op.data_ahb_dis, fw_data_ahb_dis);
+	BYTE_REG(reg_data->fw_op.data_ahb_en, fw_data_ahb_en);
+	BYTE_REG(reg_data->fw_op.addr_event_addr, fw_addr_event_addr);
+	WORD_REG(reg_data->fw_op.addr_usb_detect, fw_usb_detect_addr);
+/* CORE_FW -end- */
+/* CORE_FLASH -start- */
+	WORD_REG(reg_data->flash_op.addr_spi200_trans_fmt,
+		 flash_addr_spi200_trans_fmt);
+	WORD_REG(reg_data->flash_op.addr_spi200_trans_ctrl,
+		 flash_addr_spi200_trans_ctrl);
+	WORD_REG(reg_data->flash_op.addr_spi200_fifo_rst,
+		 flash_addr_spi200_fifo_rst);
+	WORD_REG(reg_data->flash_op.addr_spi200_flash_speed,
+		 flash_addr_spi200_flash_speed);
+	WORD_REG(reg_data->flash_op.addr_spi200_rst_status,
+		 flash_addr_spi200_rst_status);
+	WORD_REG(reg_data->flash_op.addr_spi200_cmd, flash_addr_spi200_cmd);
+	WORD_REG(reg_data->flash_op.addr_spi200_addr, flash_addr_spi200_addr);
+	WORD_REG(reg_data->flash_op.addr_spi200_data, flash_addr_spi200_data);
+	WORD_REG(reg_data->flash_op.addr_spi200_bt_num, flash_addr_spi200_bt_num);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_fmt,
+		 flash_data_spi200_trans_fmt);
+	WORD_REG(reg_data->flash_op.data_spi200_txfifo_rst,
+		 flash_data_spi200_txfifo_rst);
+	WORD_REG(reg_data->flash_op.data_spi200_rxfifo_rst,
+		 flash_data_spi200_rxfifo_rst);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_1,
+		 flash_data_spi200_trans_ctrl_1);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_2,
+		 flash_data_spi200_trans_ctrl_2);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_3,
+		 flash_data_spi200_trans_ctrl_3);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_4,
+		 flash_data_spi200_trans_ctrl_4);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_5,
+		 flash_data_spi200_trans_ctrl_5);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_6,
+		 flash_data_spi200_trans_ctrl_6);
+	WORD_REG(reg_data->flash_op.data_spi200_trans_ctrl_7,
+		 flash_data_spi200_trans_ctrl_7);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_1, flash_data_spi200_cmd_1);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_2, flash_data_spi200_cmd_2);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_3, flash_data_spi200_cmd_3);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_4, flash_data_spi200_cmd_4);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_5, flash_data_spi200_cmd_5);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_6, flash_data_spi200_cmd_6);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_7, flash_data_spi200_cmd_7);
+	WORD_REG(reg_data->flash_op.data_spi200_cmd_8, flash_data_spi200_cmd_8);
+	WORD_REG(reg_data->flash_op.data_spi200_addr, flash_data_spi200_addr);
+/* CORE_FLASH -end- */
+/* CORE_SRAM */
+	/* sram start*/
+	WORD_REG(reg_data->sram_op.addr_mkey, sram_adr_mkey);
+	WORD_REG(reg_data->sram_op.addr_rawdata_addr, sram_adr_rawdata_addr);
+	WORD_REG(reg_data->sram_op.addr_rawdata_end, sram_adr_rawdata_end);
+	HALF_REG(reg_data->sram_op.passwrd_start, sram_passwrd_start);
+	HALF_REG(reg_data->sram_op.passwrd_end, sram_passwrd_end);
+	/* sram end*/
+/* CORE_SRAM */
+/* CORE_DRIVER -start- */
+	WORD_REG(reg_data->driver_op.addr_fw_define_flash_reload,
+		 driver_addr_fw_define_flash_reload);
+	WORD_REG(reg_data->driver_op.addr_fw_define_2nd_flash_reload,
+		 driver_addr_fw_define_2nd_flash_reload);
+	WORD_REG(reg_data->driver_op.addr_fw_define_int_is_edge,
+		 driver_addr_fw_define_int_is_edge);
+	WORD_REG(reg_data->driver_op.addr_fw_define_rxnum_txnum,
+		 driver_addr_fw_define_rxnum_txnum);
+	WORD_REG(reg_data->driver_op.addr_fw_define_maxpt_xyrvs,
+		 driver_addr_fw_define_maxpt_xyrvs);
+	WORD_REG(reg_data->driver_op.addr_fw_define_x_y_res,
+		 driver_addr_fw_define_x_y_res);
+	BYTE_REG(reg_data->driver_op.data_df_rx, driver_data_df_rx);
+	BYTE_REG(reg_data->driver_op.data_df_tx, driver_data_df_tx);
+	BYTE_REG(reg_data->driver_op.data_df_pt, driver_data_df_pt);
+	WORD_REG(reg_data->driver_op.data_fw_define_flash_reload_dis,
+		 driver_data_fw_define_flash_reload_dis);
+	WORD_REG(reg_data->driver_op.data_fw_define_flash_reload_en,
+		 driver_data_fw_define_flash_reload_en);
+	WORD_REG(reg_data->driver_op.data_fw_define_rxnum_txnum_maxpt_sorting,
+		 driver_data_fw_define_rxnum_txnum_maxpt_sorting);
+	WORD_REG(reg_data->driver_op.data_fw_define_rxnum_txnum_maxpt_normal,
+		 driver_data_fw_define_rxnum_txnum_maxpt_normal);
+/* CORE_DRIVER -end- */
+	WORD_REG(reg_data->zf_op.data_dis_flash_reload, zf_data_dis_flash_reload);
+	WORD_REG(reg_data->zf_op.addr_system_reset, zf_addr_system_reset);
+	BYTE_REG(reg_data->zf_op.data_system_reset, zf_data_system_reset);
+	WORD_REG(reg_data->zf_op.data_sram_start_addr, zf_data_sram_start_addr);
+	WORD_REG(reg_data->zf_op.data_cfg_info, zf_data_cfg_info);
+	WORD_REG(reg_data->zf_op.data_fw_cfg_1, zf_data_fw_cfg_1);
+	WORD_REG(reg_data->zf_op.data_fw_cfg_2, zf_data_fw_cfg_2);
+	WORD_REG(reg_data->zf_op.data_fw_cfg_3, zf_data_fw_cfg_3);
+	WORD_REG(reg_data->zf_op.data_adc_cfg_1, zf_data_adc_cfg_1);
+	WORD_REG(reg_data->zf_op.data_adc_cfg_2, zf_data_adc_cfg_2);
+	WORD_REG(reg_data->zf_op.data_adc_cfg_3, zf_data_adc_cfg_3);
+	WORD_REG(reg_data->zf_op.data_map_table, zf_data_map_table);
+	WORD_REG(reg_data->zf_op.addr_sts_chk, zf_addr_sts_chk);
+	BYTE_REG(reg_data->zf_op.data_activ_sts, zf_data_activ_sts);
+	WORD_REG(reg_data->zf_op.addr_activ_relod, zf_addr_activ_relod);
+	BYTE_REG(reg_data->zf_op.data_activ_in, zf_data_activ_in);
+}
+
+/* CORE_INIT */
+/* init start */
+void himax_ic_fp_init(void)
+{
+/* CORE_IC */
+	g_core_fp.fp_burst_enable = himax_mcu_burst_enable;
+	g_core_fp.fp_register_read = himax_mcu_register_read;
+	g_core_fp.fp_reg_read = himax_mcu_reg_read;
+	/*
+	 * g_core_fp.fp_flash_write_burst = himax_mcu_flash_write_burst;
+	 */
+	/*
+	 * g_core_fp.fp_flash_write_burst_length =
+	 *	himax_mcu_flash_write_burst_length;
+	 */
+	g_core_fp.fp_register_write = himax_mcu_register_write;
+	g_core_fp.fp_reg_write = himax_mcu_reg_write;
+	g_core_fp.fp_interface_on = himax_mcu_interface_on;
+	g_core_fp.fp_sense_on = himax_mcu_sense_on;
+	g_core_fp.fp_sense_off = himax_mcu_sense_off;
+	g_core_fp.fp_wait_wip = himax_mcu_wait_wip;
+	g_core_fp.fp_init_psl = himax_mcu_init_psl;
+	g_core_fp.fp_resume_ic_action = himax_mcu_resume_ic_action;
+	g_core_fp.fp_suspend_ic_action = himax_mcu_suspend_ic_action;
+	g_core_fp.fp_power_on_init = himax_mcu_power_on_init;
+/* CORE_IC */
+/* CORE_FW */
+	g_core_fp.fp_system_reset = himax_mcu_system_reset;
+	g_core_fp.fp_calculate_crc_with_ap = himax_mcu_calculate_crc_with_ap;
+	g_core_fp.fp_check_crc = himax_mcu_check_crc;
+	g_core_fp.fp_set_reload_cmd = himax_mcu_set_reload_cmd;
+	g_core_fp.fp_program_reload = himax_mcu_program_reload;
+	g_core_fp.fp_usb_detect_set = himax_mcu_usb_detect_set;
+	g_core_fp.fp_diag_register_set = himax_mcu_diag_register_set;
+	g_core_fp.fp_diag_register_get = himax_mcu_diag_register_get;
+	g_core_fp.fp_idle_mode = himax_mcu_idle_mode;
+	g_core_fp.fp_reload_disable = himax_mcu_reload_disable;
+	g_core_fp.fp_read_ic_trigger_type = himax_mcu_read_ic_trigger_type;
+	g_core_fp.fp_read_FW_ver = himax_mcu_read_FW_ver;
+	g_core_fp.fp_read_event_stack = himax_mcu_read_event_stack;
+	g_core_fp.fp_return_event_stack = himax_mcu_return_event_stack;
+	g_core_fp.fp_calculate_checksum = himax_mcu_calculate_checksum;
+	g_core_fp.fp_read_FW_status = himax_mcu_read_FW_status;
+	g_core_fp.fp_irq_switch = himax_mcu_irq_switch;
+	g_core_fp.fp_assign_sorting_mode = himax_mcu_assign_sorting_mode;
+	g_core_fp.fp_check_sorting_mode = himax_mcu_check_sorting_mode;
+	g_core_fp.fp_read_DD_status = himax_mcu_read_DD_status;
+	g_core_fp.fp_clr_fw_reord_dd_sts = hx_clr_fw_reord_dd_sts;
+	g_core_fp.fp_ap_notify_fw_sus = hx_ap_notify_fw_sus;
+/* CORE_FW */
+/* CORE_FLASH */
+	g_core_fp.fp_chip_erase = himax_mcu_chip_erase;
+	g_core_fp.fp_block_erase = himax_mcu_block_erase;
+	g_core_fp.fp_sector_erase = himax_mcu_sector_erase;
+	g_core_fp.fp_flash_programming = himax_mcu_flash_programming;
+	g_core_fp.fp_flash_page_write = himax_mcu_flash_page_write;
+	g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_32k =
+			himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_32k;
+	g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_60k =
+			himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_60k;
+	g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_64k =
+			himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_64k;
+	g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_124k =
+			himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_124k;
+	g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_128k =
+			himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_128k;
+	g_core_fp.fp_fts_ctpm_fw_upgrade_with_sys_fs_255k =
+			himax_mcu_fts_ctpm_fw_upgrade_with_sys_fs_255k;
+	g_core_fp.fp_flash_dump_func = himax_mcu_flash_dump_func;
+	g_core_fp.fp_flash_lastdata_check = himax_mcu_flash_lastdata_check;
+	g_core_fp.fp_bin_desc_get = hx_mcu_bin_desc_get;
+	g_core_fp.fp_diff_overlay_flash = hx_mcu_diff_overlay_flash;
+/* CORE_FLASH */
+/* CORE_SRAM */
+	g_core_fp.fp_sram_write = himax_mcu_sram_write;
+	g_core_fp.fp_sram_verify = himax_mcu_sram_verify;
+	g_core_fp.fp_get_DSRAM_data = himax_mcu_get_DSRAM_data;
+/* CORE_SRAM */
+/* CORE_DRIVER */
+	g_core_fp.fp_chip_init = himax_mcu_init_ic;
+	g_core_fp.fp_pin_reset = himax_mcu_pin_reset;
+	g_core_fp.fp_ic_reset = himax_mcu_ic_reset;
+	g_core_fp.fp_tp_info_check = himax_mcu_tp_info_check;
+	g_core_fp.fp_touch_information = himax_mcu_touch_information;
+	g_core_fp.fp_calc_touch_data_size = himax_mcu_calc_touch_data_size;
+	g_core_fp.fp_get_touch_data_size = himax_mcu_get_touch_data_size;
+	g_core_fp.fp_hand_shaking = himax_mcu_hand_shaking;
+	g_core_fp.fp_determin_diag_rawdata = himax_mcu_determin_diag_rawdata;
+	g_core_fp.fp_determin_diag_storage = himax_mcu_determin_diag_storage;
+	g_core_fp.fp_cal_data_len = himax_mcu_cal_data_len;
+	g_core_fp.fp_diag_check_sum = himax_mcu_diag_check_sum;
+	g_core_fp.fp_ic_excp_recovery = himax_mcu_ic_excp_recovery;
+	g_core_fp.fp_excp_ic_reset = himax_mcu_excp_ic_reset;
+	g_core_fp.fp_resend_cmd_func = himax_mcu_resend_cmd_func;
+/* CORE_DRIVER */
+	g_core_fp.fp_turn_on_mp_func = hx_turn_on_mp_func;
+	g_core_fp.fp_reload_disable = hx_dis_rload_0f;
+	g_core_fp.fp_clean_sram_0f = himax_mcu_clean_sram_0f;
+	g_core_fp.fp_write_sram_0f = himax_mcu_write_sram_0f;
+	g_core_fp.fp_write_sram_0f_crc = himax_sram_write_crc_check;
+	g_core_fp.fp_firmware_update_0f = himax_mcu_firmware_update_0f;
+	g_core_fp.fp_0f_op_file_dirly = hx_0f_op_file_dirly;
+	g_core_fp.fp_0f_excp_check = himax_mcu_0f_excp_check;
+	g_core_fp.fp_read_sram_0f = himax_mcu_read_sram_0f;
+	g_core_fp.fp_read_all_sram = himax_mcu_read_all_sram;
+	g_core_fp.fp_firmware_read_0f = himax_mcu_firmware_read_0f;
+	g_core_fp.fp_suspend_proc = himax_suspend_proc;
+	g_core_fp.fp_resume_proc = himax_resume_proc;
+}
diff --git a/drivers/hid/hx-hid/hx_ic_core.h b/drivers/hid/hx-hid/hx_ic_core.h
new file mode 100644
index 000000000000..5c56646906fa
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_ic_core.h
@@ -0,0 +1,792 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HIMAX_IC_CORE_H__
+#define __HIMAX_IC_CORE_H__
+
+#include "hx_core.h"
+#include <linux/slab.h>
+
+#define DATA_LEN_8				8
+#define DATA_LEN_4				4
+#define ADDR_LEN_4				4
+#define FLASH_RW_MAX_LEN		256
+#define FLASH_WRITE_BURST_SZ	8
+#define MAX_I2C_TRANS_SZ		128
+#define HIMAX_REG_RETRY_TIMES	5
+#define FW_BIN_16K_SZ			0x4000
+#define HIMAX_TOUCH_DATA_SIZE	128
+#define MASK_BIT_0				0x01
+#define MASK_BIT_1				0x02
+#define MASK_BIT_2				0x04
+
+#define FW_SECTOR_PER_BLOCK		8
+#define FW_PAGE_PER_SECTOR		64
+#define FW_PAGE_SZ			128
+#define HX256B					0x100
+#define HX1K					0x400
+#define HX4K					0x1000
+#define HX_32K_SZ				0x8000
+#define HX_40K_SZ				0xA000
+#define HX_48K_SZ				0xC000
+#define HX64K					0x10000
+#define HX124K					0x1f000
+#define HX4000K					0x1000000
+
+#define HX_NORMAL_MODE			1
+#define HX_SORTING_MODE			2
+#define HX_CHANGE_MODE_FAIL		(-1)
+#define HX_RW_REG_FAIL			(-1)
+#define HX_DRIVER_MAX_IC_NUM	12
+
+/* CORE_INIT */
+/* CORE_IC */
+/* CORE_FW */
+/* CORE_FLASH */
+/* CORE_SRAM */
+/* CORE_DRIVER */
+
+void himax_mcu_in_cmd_struct_free(void);
+void himax_rst_gpio_set(int pinnum, u8 value);
+void himax_cable_detect_func(struct himax_ts_data *ts, bool force_renew);
+int himax_report_data_init(struct himax_ts_data *ts);
+
+enum HX_FLASH_SPEED_ENUM {
+	HX_FLASH_SPEED_25M = 0,
+	HX_FLASH_SPEED_12p5M = 0x01,
+	HX_FLASH_SPEED_8p3M = 0x02,
+	HX_FLASH_SPEED_6p25M = 0x03,
+};
+
+/* CORE_IC */
+	#define ic_adr_ahb_addr_byte_0           0x00
+	#define ic_adr_ahb_rdata_byte_0          0x08
+	#define ic_adr_ahb_access_direction      0x0c
+	#define ic_adr_conti                     0x13
+	#define ic_adr_incr4                     0x0D
+	#define ic_adr_i2c_psw_lb                0x31
+	#define ic_adr_i2c_psw_ub                0x32
+	#define ic_cmd_ahb_access_direction_read 0x00
+	#define ic_cmd_conti                     0x31
+	#define ic_cmd_incr4                     0x10
+	#define ic_cmd_i2c_psw_lb                0x27
+	#define ic_cmd_i2c_psw_ub                0x95
+	#define ic_adr_tcon_on_rst               0x80020020
+	#define ic_addr_adc_on_rst               0x80020094
+	#define ic_adr_psl                       0x900000A0
+	#define ic_adr_cs_central_state          0x900000A8
+	#define ic_cmd_rst                       0x00000000
+	#define ic_adr_osc_en                    0x900880A8
+	#define ic_adr_osc_pw                    0x900880E0
+/* CORE_IC */
+
+/* CORE_FW */
+	#define fw_addr_system_reset                0x90000018
+	#define fw_addr_ctrl_fw                     0x9000005c
+	#define fw_addr_flag_reset_event            0x900000e4
+	#define fw_addr_hsen_enable                 0x10007F14
+	#define fw_usb_detect_addr                  0x10007F38
+	#define fw_addr_program_reload_from         0x00000000
+	#define fw_addr_program_reload_to           0x08000000
+	#define fw_addr_program_reload_page_write   0x0000fb00
+	#define fw_addr_raw_out_sel                 0x800204b4
+	#define fw_addr_reload_status               0x80050000
+	#define fw_addr_reload_crc32_result         0x80050018
+	#define fw_addr_reload_addr_from            0x80050020
+	#define fw_addr_reload_addr_cmd_beat        0x80050028
+	#define fw_data_system_reset                0x00000055
+	#define fw_data_safe_mode_release_pw_active 0x00000053
+	#define fw_data_safe_mode_release_pw_reset  0x00000000
+	#define fw_data_clear                       0x00000000
+	#define fw_data_fw_stop                     0x000000A5
+	#define fw_data_program_reload_start        0x0A3C3000
+	#define fw_data_program_reload_compare      0x04663000
+	#define fw_data_program_reload_break        0x15E75678
+	#define fw_addr_selftest_addr_en            0x10007F18
+	#define fw_addr_selftest_result_addr        0x10007f24
+	#define fw_data_selftest_request            0x00006AA6
+	#define fw_addr_criteria_addr               0x10007f1c
+	#define fw_data_criteria_aa_top             0x64
+	#define fw_data_criteria_aa_bot             0x00
+	#define fw_data_criteria_key_top            0x64
+	#define fw_data_criteria_key_bot            0x00
+	#define fw_data_criteria_avg_top            0x64
+	#define fw_data_criteria_avg_bot            0x00
+	#define fw_addr_set_frame_addr              0x10007294
+	#define fw_data_set_frame                   0x0000000A
+	#define fw_data_selftest_ack_hb             0xa6
+	#define fw_data_selftest_ack_lb             0x6a
+	#define fw_data_selftest_pass               0xaa
+	#define fw_data_normal_cmd                  0x00
+	#define fw_data_normal_status               0x99
+	#define fw_data_sorting_cmd                 0xaa
+	#define fw_data_sorting_status              0xcc
+	#define fw_data_idle_dis_pwd                0x17
+	#define fw_data_idle_en_pwd                 0x1f
+	#define fw_addr_sorting_mode_en             0x10007f04
+	#define fw_addr_fw_mode_status              0x10007088
+	#define fw_addr_icid_addr                   0x900000d0
+	#define fw_addr_fw_ver_addr                 0x10007004
+	#define fw_addr_fw_cfg_addr                 0x10007084
+	#define fw_addr_fw_vendor_addr              0x10007000
+	#define fw_addr_cus_info                    0x10007008
+	#define fw_addr_proj_info                   0x10007014
+	#define fw_addr_fw_state_addr               0x900000f8
+	#define fw_addr_fw_dbg_msg_addr             0x10007f40
+	#define fw_addr_chk_fw_status               0x900000a8
+	#define fw_addr_chk_dd_status               0x900000E8
+	#define fw_addr_dd_handshak_addr            0x900000fc
+	#define fw_addr_dd_data_addr                0x10007f80
+	#define fw_addr_clr_fw_record_dd_sts        0x10007FCC
+	#define fw_addr_ap_notify_fw_sus            0x10007FD0
+	#define fw_data_ap_notify_fw_sus_en         0xA55AA55A
+	#define fw_data_ap_notify_fw_sus_dis        0x00000000
+	#define fw_data_dd_request                  0xaa
+	#define fw_data_dd_ack                      0xbb
+	#define fw_data_rawdata_ready_hb            0xa3
+	#define fw_data_rawdata_ready_lb            0x3a
+	#define fw_addr_ahb_addr                    0x11
+	#define fw_data_ahb_dis                     0x00
+	#define fw_data_ahb_en                      0x01
+	#define fw_addr_event_addr                  0x30
+	#define fw_func_handshaking_pwd             0xA55AA55A
+	#define fw_func_handshaking_end             0x77887788
+	#define fw_addr_ulpm_33                     0x33
+	#define fw_addr_ulpm_34                     0x34
+	#define fw_data_ulpm_11                     0x11
+	#define fw_data_ulpm_22                     0x22
+	#define fw_data_ulpm_33                     0x33
+	#define fw_data_ulpm_aa                     0xAA
+	#define fw_addr_ctrl_mpap_ovl               0x100073EC
+	#define fw_data_ctrl_mpap_ovl_on            0x107380
+/* CORE_FW */
+
+/* CORE_FLASH */
+	#define flash_addr_ctrl_base           0x80000000
+	#define flash_addr_spi200_trans_fmt    (flash_addr_ctrl_base + 0x10)
+	#define flash_addr_spi200_trans_ctrl   (flash_addr_ctrl_base + 0x20)
+	#define flash_addr_spi200_cmd          (flash_addr_ctrl_base + 0x24)
+	#define flash_addr_spi200_addr         (flash_addr_ctrl_base + 0x28)
+	#define flash_addr_spi200_data         (flash_addr_ctrl_base + 0x2c)
+	#define flash_addr_spi200_fifo_rst   (flash_addr_ctrl_base + 0x30)
+	#define flash_addr_spi200_rst_status   (flash_addr_ctrl_base + 0x34)
+	#define flash_addr_spi200_flash_speed  (flash_addr_ctrl_base + 0x40)
+	#define flash_addr_spi200_bt_num       (flash_addr_ctrl_base + 0xe8)
+	#define flash_data_spi200_txfifo_rst   0x00000004
+	#define flash_data_spi200_rxfifo_rst   0x00000002
+	#define flash_data_spi200_trans_fmt    0x00020780
+	#define flash_data_spi200_trans_ctrl_1 0x42000003
+	#define flash_data_spi200_trans_ctrl_2 0x47000000
+	#define flash_data_spi200_trans_ctrl_3 0x67000000
+	#define flash_data_spi200_trans_ctrl_4 0x610ff000
+	#define flash_data_spi200_trans_ctrl_5 0x694002ff
+	#define flash_data_spi200_trans_ctrl_6 0x42000000
+	#define flash_data_spi200_trans_ctrl_7 0x6940020f
+	#define flash_data_spi200_cmd_1        0x00000005
+	#define flash_data_spi200_cmd_2        0x00000006
+	#define flash_data_spi200_cmd_3        0x000000C7
+	#define flash_data_spi200_cmd_4        0x000000D8
+	#define flash_data_spi200_cmd_5        0x00000020
+	#define flash_data_spi200_cmd_6        0x00000002
+	#define flash_data_spi200_cmd_7        0x0000003b
+	#define flash_data_spi200_cmd_8        0x00000003
+	#define flash_data_spi200_addr         0x00000000
+	#define flash_clk_setup_addr           0x80000040
+/* CORE_FLASH */
+
+/* CORE_SRAM */
+	#define sram_adr_mkey         0x100070E8
+	#define sram_adr_rawdata_addr 0x10000000
+	#define sram_adr_rawdata_end  0x00000000
+	#define	sram_passwrd_start    0x5AA5
+	#define	sram_passwrd_end      0xA55A
+/* CORE_SRAM */
+
+/* CORE_DRIVER */
+	#define driver_addr_fw_define_flash_reload              0x10007f00
+	#define driver_addr_fw_define_2nd_flash_reload          0x100072c0
+	#define driver_data_fw_define_flash_reload_dis          0x0000a55a
+	#define driver_data_fw_define_flash_reload_en           0x00000000
+	#define driver_addr_fw_define_int_is_edge               0x10007088
+	#define driver_addr_fw_define_rxnum_txnum               0x100070f4
+	#define driver_data_fw_define_rxnum_txnum_maxpt_sorting 0x00000008
+	#define driver_data_fw_define_rxnum_txnum_maxpt_normal  0x00000014
+	#define driver_addr_fw_define_maxpt_xyrvs               0x100070f8
+	#define driver_addr_fw_define_x_y_res                   0x100070fc
+	#define driver_data_df_rx                               36
+	#define driver_data_df_tx                               18
+	#define driver_data_df_pt                               10
+/* CORE_DRIVER */
+
+	#define zf_data_dis_flash_reload 0x00009AA9
+	#define zf_addr_system_reset     0x90000018
+	#define zf_data_system_reset     0x00000055
+	#define zf_data_sram_start_addr  0x08000000
+	#define zf_data_cfg_info         0x10007000
+	#define zf_data_fw_cfg_1         0x10007084
+	#define zf_data_fw_cfg_2         0x10007264
+	#define zf_data_fw_cfg_3         0x10007300
+	#define zf_data_adc_cfg_1        0x10006A00
+	#define zf_data_adc_cfg_2        0x10007B28
+	#define zf_data_adc_cfg_3        0x10007AF0
+	#define zf_data_map_table        0x10007500
+	#define zf_addr_sts_chk          0x900000A8
+	#define zf_data_activ_sts        0x05
+	#define zf_addr_activ_relod      0x90000048
+	#define zf_data_activ_in         0xEC
+
+	#define ovl_section_num      3
+	#define ovl_gesture_request  0x11
+	#define ovl_gesture_reply    0x22
+	#define ovl_border_request   0x55
+	#define ovl_border_reply     0x66
+	#define ovl_sorting_request  0x99
+	#define ovl_sorting_reply    0xAA
+	#define ovl_fault            0xFF
+
+	#define ovl_alg_request  0x11111111
+	#define ovl_alg_reply    0x22222222
+	#define ovl_alg_fault    0xFF
+
+struct zf_info {
+	u8 sram_addr[4];
+	int write_size;
+	u32 fw_addr;
+	u32 cfg_addr;
+};
+
+/* New Version 1K*/
+enum bin_desc_map_table {
+	TP_CONFIG_TABLE = 0x00000A00,
+	FW_CID = 0x10000000,
+	FW_VER = 0x10000100,
+	CFG_VER = 0x10000600,
+	HID_TABLE = 0x30000100,
+	FW_BIN_DESC = 0x10000000
+};
+
+enum data_type {
+	HX_REG = 0xA5,
+	HX_DATA
+};
+
+struct hx_reg_t {
+	union {
+		u32 word;
+		u16 half[2];
+		u8 byte[4];
+	} data;
+	u32 len;
+	u32 data_type;
+};
+
+struct data_pack_t {
+	union {
+		u32 *word;
+		u16 *half;
+		u8 *byte;
+		void *ptr;
+	} data;
+	/* length in byte unit */
+	u32 len;
+	u32 data_type;
+};
+
+#define BYTE_REG(_reg, _data) \
+	{ \
+		_reg.data.byte[0] = (_data) & 0xFF; \
+		_reg.len = 1; \
+		_reg.data_type = HX_REG; \
+	}
+#define HALF_REG(_reg, _data) \
+	{ \
+		_reg.data.half[0] = cpu_to_le16((_data) & 0xFFFF); \
+		_reg.len = 2; \
+		_reg.data_type = HX_REG; \
+	}
+#define WORD_REG(_reg, _data) \
+	{ \
+		_reg.data.word = cpu_to_le32(_data); \
+		_reg.len = 4; \
+		_reg.data_type = HX_REG; \
+	}
+
+// set val to already defined reg/data
+#define VAL_SET(_var, _val) \
+	({ \
+		bool _ret = true; \
+		do { \
+			if (_var.data_type == HX_DATA) { \
+				memset(_var.data.byte, 0, _var.len); \
+				do { \
+					switch (_var.len) { \
+					case 1: \
+						_var.data.byte[0] = (_val) & 0xFF; \
+						break; \
+					case 2: \
+						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
+						break; \
+					case 3: \
+						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
+						_var.data.byte[2] = ((_val) >> 16) & 0xFF; \
+						break; \
+					case 4: \
+						_var.data.word[0] =\
+						cpu_to_le32((_val) & 0xFFFFFFFF); \
+						break; \
+					default: \
+						_ret = false; \
+						break; \
+					};\
+				} while (0); \
+			} else { \
+				_ret = false; \
+			} \
+		} while (0); \
+		_ret; \
+	})
+
+// set ptr/array to already defined reg/data
+#define PTR_SET(_var, _ptr, _len) \
+	({ \
+		bool _ret = true; \
+		do { \
+			if ((_len) > (_var).len) { \
+				_ret = false; \
+				break; \
+			} \
+			memcpy((_var).data.byte, _ptr, (_len)); \
+			(_var).len = (_len); \
+		} while (0); \
+		_ret; \
+	})
+
+#define DEF_WORD_DATA(_data_name) \
+	u8 _data_name##_array[4] = {0}; \
+	struct data_pack_t _data_name = { \
+		.data.byte = _data_name##_array, \
+		.len = 4, \
+		.data_type = HX_DATA \
+	}
+
+#define ARRAY_DATA(_data, _byte_len) { \
+		_data.data.byte = (uint8_t *)_data, \
+		_data.len = _byte_len, \
+		.data_type = HX_DATA \
+	}
+
+#define REG_GET_VAL(_reg) \
+	({ \
+		u32 _val = 0; \
+		do { \
+			switch (_reg.len) { \
+			case 1: \
+				_val = _reg.data.byte[0]; \
+				break; \
+			case 2: \
+				_val = le16_to_cpu(_reg.data.half[0]); \
+				break; \
+			case 3: \
+				_val = le16_to_cpu(_reg.data.half[0]) | (_reg.data.byte[2] << 16); \
+				break; \
+			case 4: \
+				_val = le32_to_cpu(_reg.data.word); \
+				break; \
+			} \
+		} while (0); \
+		_val; \
+	})
+#define FLASH_VER_GET_VAL(_reg) REG_GET_VAL(g_core_regs.flash_ver_info._reg)
+#define IC_GET_VAL(_reg) REG_GET_VAL(g_core_regs.ic_op._reg)
+#define FW_GET_VAL(_reg) REG_GET_VAL(g_core_regs.fw_op._reg)
+#define FLASH_GET_VAL(_reg) REG_GET_VAL(g_core_regs.flash_op._reg)
+#define SRAM_GET_VAL(_reg) REG_GET_VAL(g_core_regs.sram_op._reg)
+#define DRV_GET_VAL(_reg) REG_GET_VAL(g_core_regs.driver_op._reg)
+#define ZF_GET_VAL(_reg) REG_GET_VAL(g_core_regs.zf_op._reg)
+#define REG_GET_ARRAY(_reg) \
+	({ \
+		_reg.data.byte; \
+	})
+#define FLASH_VER_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.flash_ver_info._reg)
+#define IC_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.ic_op._reg)
+#define FW_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.fw_op._reg)
+#define FLASH_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.flash_op._reg)
+#define SRAM_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.sram_op._reg)
+#define DRV_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.driver_op._reg)
+#define ZF_GET_ARRAY(_reg) REG_GET_ARRAY(g_core_regs.zf_op._reg)
+#define REG_GET_SZ(_reg) \
+	({ \
+		_reg.len; \
+	})
+#define FLASH_VER_GET_SZ(_reg) REG_GET_SZ(g_core_regs.flash_ver_info._reg)
+#define IC_GET_SZ(_reg) REG_GET_SZ(g_core_regs.ic_op._reg)
+#define FW_GET_SZ(_reg) REG_GET_SZ(g_core_regs.fw_op._reg)
+#define FLASH_GET_SZ(_reg) REG_GET_SZ(g_core_regs.flash_op._reg)
+#define SRAM_GET_SZ(_reg) REG_GET_SZ(g_core_regs.sram_op._reg)
+#define DRV_GET_SZ(_reg) REG_GET_SZ(g_core_regs.driver_op._reg)
+#define ZF_GET_SZ(_reg) REG_GET_SZ(g_core_regs.zf_op._reg)
+
+struct ic_operation {
+	struct hx_reg_t addr_ahb_addr_byte_0;
+	struct hx_reg_t addr_ahb_rdata_byte_0;
+	struct hx_reg_t addr_ahb_access_direction;
+	struct hx_reg_t addr_conti;
+	struct hx_reg_t addr_incr4;
+	struct hx_reg_t adr_i2c_psw_lb;
+	struct hx_reg_t adr_i2c_psw_ub;
+	struct hx_reg_t data_ahb_access_direction_read;
+	struct hx_reg_t data_conti;
+	struct hx_reg_t data_incr4;
+	struct hx_reg_t data_i2c_psw_lb;
+	struct hx_reg_t data_i2c_psw_ub;
+	struct hx_reg_t addr_tcon_on_rst;
+	struct hx_reg_t addr_adc_on_rst;
+	struct hx_reg_t addr_psl;
+	struct hx_reg_t addr_cs_central_state;
+	struct hx_reg_t data_rst;
+	struct hx_reg_t adr_osc_en;
+	struct hx_reg_t adr_osc_pw;
+};
+
+struct fw_operation {
+	struct hx_reg_t addr_system_reset;
+	struct hx_reg_t addr_ctrl_fw_isr;
+	struct hx_reg_t addr_flag_reset_event;
+	struct hx_reg_t addr_hsen_enable;
+	struct hx_reg_t addr_program_reload_from;
+	struct hx_reg_t addr_program_reload_to;
+	struct hx_reg_t addr_program_reload_page_write;
+	struct hx_reg_t addr_raw_out_sel;
+	struct hx_reg_t addr_reload_status;
+	struct hx_reg_t addr_reload_crc32_result;
+	struct hx_reg_t addr_reload_addr_from;
+	struct hx_reg_t addr_reload_addr_cmd_beat;
+	struct hx_reg_t addr_selftest_addr_en;
+	struct hx_reg_t addr_criteria_addr;
+	struct hx_reg_t addr_set_frame_addr;
+	struct hx_reg_t addr_selftest_result_addr;
+	struct hx_reg_t addr_sorting_mode_en;
+	struct hx_reg_t addr_fw_mode_status;
+	struct hx_reg_t addr_icid_addr;
+	struct hx_reg_t addr_fw_ver_addr;
+	struct hx_reg_t addr_fw_cfg_addr;
+	struct hx_reg_t addr_fw_vendor_addr;
+	struct hx_reg_t addr_cus_info;
+	struct hx_reg_t addr_proj_info;
+	struct hx_reg_t addr_fw_state_addr;
+	struct hx_reg_t addr_fw_dbg_msg_addr;
+	struct hx_reg_t addr_chk_fw_status;
+	struct hx_reg_t addr_dd_handshak_addr;
+	struct hx_reg_t addr_dd_data_addr;
+	struct hx_reg_t addr_clr_fw_record_dd_sts;
+	struct hx_reg_t addr_ap_notify_fw_sus;
+	struct hx_reg_t data_ap_notify_fw_sus_en;
+	struct hx_reg_t data_ap_notify_fw_sus_dis;
+	struct hx_reg_t data_system_reset;
+	struct hx_reg_t data_safe_mode_release_pw_active;
+	struct hx_reg_t data_safe_mode_release_pw_reset;
+	struct hx_reg_t data_clear;
+	struct hx_reg_t data_fw_stop;
+	struct hx_reg_t data_program_reload_start;
+	struct hx_reg_t data_program_reload_compare;
+	struct hx_reg_t data_program_reload_break;
+	struct hx_reg_t data_selftest_request;
+	struct hx_reg_t data_criteria_aa_top;
+	struct hx_reg_t data_criteria_aa_bot;
+	struct hx_reg_t data_criteria_key_top;
+	struct hx_reg_t data_criteria_key_bot;
+	struct hx_reg_t data_criteria_avg_top;
+	struct hx_reg_t data_criteria_avg_bot;
+	struct hx_reg_t data_set_frame;
+	struct hx_reg_t data_selftest_ack_hb;
+	struct hx_reg_t data_selftest_ack_lb;
+	struct hx_reg_t data_selftest_pass;
+	struct hx_reg_t data_normal_cmd;
+	struct hx_reg_t data_normal_status;
+	struct hx_reg_t data_sorting_cmd;
+	struct hx_reg_t data_sorting_status;
+	struct hx_reg_t data_dd_request;
+	struct hx_reg_t data_dd_ack;
+	struct hx_reg_t data_idle_dis_pwd;
+	struct hx_reg_t data_idle_en_pwd;
+	struct hx_reg_t data_rawdata_ready_hb;
+	struct hx_reg_t data_rawdata_ready_lb;
+	struct hx_reg_t addr_ahb_addr;
+	struct hx_reg_t data_ahb_dis;
+	struct hx_reg_t data_ahb_en;
+	struct hx_reg_t addr_event_addr;
+	struct hx_reg_t addr_usb_detect;
+};
+
+struct flash_operation {
+	struct hx_reg_t addr_spi200_trans_fmt;
+	struct hx_reg_t addr_spi200_trans_ctrl;
+	struct hx_reg_t addr_spi200_fifo_rst;
+	struct hx_reg_t addr_spi200_rst_status;
+	struct hx_reg_t addr_spi200_flash_speed;
+	struct hx_reg_t addr_spi200_cmd;
+	struct hx_reg_t addr_spi200_addr;
+	struct hx_reg_t addr_spi200_data;
+	struct hx_reg_t addr_spi200_bt_num;
+
+	struct hx_reg_t data_spi200_txfifo_rst;
+	struct hx_reg_t data_spi200_rxfifo_rst;
+	struct hx_reg_t data_spi200_trans_fmt;
+	struct hx_reg_t data_spi200_trans_ctrl_1;
+	struct hx_reg_t data_spi200_trans_ctrl_2;
+	struct hx_reg_t data_spi200_trans_ctrl_3;
+	struct hx_reg_t data_spi200_trans_ctrl_4;
+	struct hx_reg_t data_spi200_trans_ctrl_5;
+	struct hx_reg_t data_spi200_trans_ctrl_6;
+	struct hx_reg_t data_spi200_trans_ctrl_7;
+	struct hx_reg_t data_spi200_cmd_1;
+	struct hx_reg_t data_spi200_cmd_2;
+	struct hx_reg_t data_spi200_cmd_3;
+	struct hx_reg_t data_spi200_cmd_4;
+	struct hx_reg_t data_spi200_cmd_5;
+	struct hx_reg_t data_spi200_cmd_6;
+	struct hx_reg_t data_spi200_cmd_7;
+	struct hx_reg_t data_spi200_cmd_8;
+	struct hx_reg_t data_spi200_addr;
+};
+
+struct sram_operation {
+	struct hx_reg_t addr_mkey;
+	struct hx_reg_t addr_rawdata_addr;
+	struct hx_reg_t addr_rawdata_end;
+	struct hx_reg_t passwrd_start;
+	struct hx_reg_t passwrd_end;
+};
+
+struct driver_operation {
+	struct hx_reg_t addr_fw_define_flash_reload;
+	struct hx_reg_t addr_fw_define_2nd_flash_reload;
+	struct hx_reg_t addr_fw_define_int_is_edge;
+	struct hx_reg_t addr_fw_define_rxnum_txnum;
+	struct hx_reg_t addr_fw_define_maxpt_xyrvs;
+	struct hx_reg_t addr_fw_define_x_y_res;
+	struct hx_reg_t data_df_rx;
+	struct hx_reg_t data_df_tx;
+	struct hx_reg_t data_df_pt;
+	struct hx_reg_t data_fw_define_flash_reload_dis;
+	struct hx_reg_t data_fw_define_flash_reload_en;
+	struct hx_reg_t data_fw_define_rxnum_txnum_maxpt_sorting;
+	struct hx_reg_t data_fw_define_rxnum_txnum_maxpt_normal;
+};
+
+struct zf_operation {
+	struct hx_reg_t data_dis_flash_reload;
+	struct hx_reg_t addr_system_reset;
+	struct hx_reg_t data_system_reset;
+	struct hx_reg_t data_sram_start_addr;
+	struct hx_reg_t data_sram_clean;
+	struct hx_reg_t data_cfg_info;
+	struct hx_reg_t data_fw_cfg_1;
+	struct hx_reg_t data_fw_cfg_2;
+	struct hx_reg_t data_fw_cfg_3;
+	struct hx_reg_t data_adc_cfg_1;
+	struct hx_reg_t data_adc_cfg_2;
+	struct hx_reg_t data_adc_cfg_3;
+	struct hx_reg_t data_map_table;
+	struct hx_reg_t addr_sts_chk;
+	struct hx_reg_t data_activ_sts;
+	struct hx_reg_t addr_activ_relod;
+	struct hx_reg_t data_activ_in;
+};
+
+struct flash_version_info {
+	struct hx_reg_t addr_fw_ver_major;
+	struct hx_reg_t addr_fw_ver_minor;
+	struct hx_reg_t addr_cfg_ver_major;
+	struct hx_reg_t addr_cfg_ver_minor;
+	struct hx_reg_t addr_cid_ver_major;
+	struct hx_reg_t addr_cid_ver_minor;
+	struct hx_reg_t addr_cfg_table;
+	struct hx_reg_t addr_cfg_table_t;
+	struct hx_reg_t addr_hid_table;
+	struct hx_reg_t addr_hid_desc;
+	struct hx_reg_t addr_hid_rd_desc;
+};
+
+struct himax_core_command_regs {
+	struct flash_version_info flash_ver_info;
+	struct ic_operation ic_op;
+	struct fw_operation fw_op;
+	struct flash_operation flash_op;
+	struct sram_operation sram_op;
+	struct driver_operation driver_op;
+	struct zf_operation zf_op;
+};
+
+struct himax_core_fp {
+/* CORE_IC */
+	void (*fp_burst_enable)(struct himax_ts_data *ts, u8 auto_add_4_byte);
+	int (*fp_register_read)(struct himax_ts_data *ts, u8 *addr,
+				u8 *buf, u32 len);
+	int (*fp_reg_read)(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			   struct data_pack_t *data);
+	int (*fp_register_write)(struct himax_ts_data *ts, u8 *addr,
+				 u8 *val, u32 len);
+	int (*fp_reg_write)(struct himax_ts_data *ts, struct hx_reg_t *addr,
+			    struct data_pack_t *data);
+	void (*fp_interface_on)(struct himax_ts_data *ts);
+	void (*fp_sense_on)(struct himax_ts_data *ts, u8 flash_mode);
+	void (*fp_tcon_on)(struct himax_ts_data *ts);
+	bool (*fp_watch_dog_off)(struct himax_ts_data *ts);
+	bool (*fp_sense_off)(struct himax_ts_data *ts, bool check_en);
+	void (*fp_sleep_in)(struct himax_ts_data *ts);
+	bool (*fp_wait_wip)(struct himax_ts_data *ts, int timing);
+	void (*fp_init_psl)(struct himax_ts_data *ts);
+	void (*fp_resume_ic_action)(struct himax_ts_data *ts);
+	void (*fp_suspend_ic_action)(struct himax_ts_data *ts);
+	void (*fp_power_on_init)(struct himax_ts_data *ts);
+	bool (*fp_slave_tcon_reset)(struct himax_ts_data *ts);
+	bool (*fp_slave_adc_reset_slave)(struct himax_ts_data *ts);
+	bool (*fp_slave_wdt_off_slave)(struct himax_ts_data *ts);
+/* CORE_IC */
+
+/* CORE_FW */
+	void (*fp_system_reset)(struct himax_ts_data *ts);
+	int (*fp_calculate_crc_with_ap)(const unsigned char *fw_content,
+					int crc_from_fw,
+			int len);
+	u32 (*fp_check_crc)(struct himax_ts_data *ts, u8 *start_addr,
+			    int reload_length);
+	void (*fp_set_reload_cmd)(u8 *write_data,
+				  int idx,
+			u32 cmd_from,
+			u32 cmd_to,
+			u32 cmd_beat);
+	bool (*fp_program_reload)(void);
+	void (*fp_diag_register_set)(struct himax_ts_data *ts,
+				     u8 diag_command);
+	int (*fp_diag_register_get)(struct himax_ts_data *ts,
+				    u32 *diag_value);
+	void (*fp_clr_fw_reord_dd_sts)(struct himax_ts_data *ts);
+	void (*fp_ap_notify_fw_sus)(struct himax_ts_data *ts, int suspend);
+	int (*fp_chip_self_test)(struct seq_file *s, void *v);
+	void (*fp_idle_mode)(struct himax_ts_data *ts, int disable);
+	void (*fp_reload_disable)(struct himax_ts_data *ts, int disable);
+	int (*fp_read_ic_trigger_type)(struct himax_ts_data *ts);
+	void (*fp_read_FW_ver)(struct himax_ts_data *ts);
+	bool (*fp_read_event_stack)(struct himax_ts_data *ts, u8 *buf,
+				    u32 length);
+	void (*fp_return_event_stack)(struct himax_ts_data *ts);
+	bool (*fp_calculate_checksum)(struct himax_ts_data *ts, bool change_iref,
+				      u32 size);
+	void (*fp_read_FW_status)(struct himax_ts_data *ts);
+	void (*fp_irq_switch)(struct himax_ts_data *ts, int switch_on);
+	int (*fp_assign_sorting_mode)(struct himax_ts_data *ts, u8 *tmp_data);
+	int (*fp_check_sorting_mode)(struct himax_ts_data *ts, u8 *tmp_data);
+	int (*fp_get_max_dc)(void);
+	u8 (*fp_read_DD_status)(struct himax_ts_data *ts, u8 *cmd_set,
+				u8 *tmp_data);
+	int (*fp_ulpm_in)(void);
+	int (*fp_black_gest_ctrl)(bool enable);
+	int	(*fp_diff_overlay_bin)(void);
+/* CORE_FW */
+
+/* CORE_FLASH */
+	void (*fp_chip_erase)(struct himax_ts_data *ts);
+	bool (*fp_block_erase)(struct himax_ts_data *ts, int start_addr,
+			       int length);
+	bool (*fp_sector_erase)(int start_addr);
+	bool (*fp_flash_programming)(struct himax_ts_data *ts,
+				     u8 *fw_content, int fw_size);
+	void (*fp_flash_page_write)(u8 *write_addr, int length,
+				    u8 *write_data);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_32k)(struct himax_ts_data *ts,
+						      unsigned char *fw, int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_60k)(struct himax_ts_data *ts,
+						      unsigned char *fw, int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_64k)(struct himax_ts_data *ts,
+						      unsigned char *fw, int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_124k)
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_128k)
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref);
+	int (*fp_fts_ctpm_fw_upgrade_with_sys_fs_255k)
+		(struct himax_ts_data *ts, unsigned char *fw,
+		 int len, bool change_iref);
+	void (*fp_flash_dump_func)(struct himax_ts_data *ts,
+				   u8 local_flash_command, int flash_size,
+				   u8 *flash_buffer);
+	bool (*fp_flash_lastdata_check)(struct himax_ts_data *ts, u32 size);
+	bool (*fp_bin_desc_get)(unsigned char *fw, struct himax_ts_data *ts,
+				u32 max_sz);
+	bool (*fp_ahb_squit)(void);
+	void (*fp_flash_read)(u8 *r_data, int start_addr, int length);
+	bool (*fp_sfr_rw)(u8 *addr, int length,
+			  u8 *data, u8 rw_ctrl);
+	bool (*fp_lock_flash)(void);
+	bool (*fp_unlock_flash)(void);
+	void (*fp_init_auto_func)(void);
+	int (*fp_diff_overlay_flash)(struct himax_ts_data *ts);
+/* CORE_FLASH */
+
+/* CORE_SRAM */
+	void (*fp_sram_write)(struct himax_ts_data *ts, u8 *FW_content);
+	bool (*fp_sram_verify)(struct himax_ts_data *ts, u8 *fw_file,
+			       int fw_size);
+	bool (*fp_get_DSRAM_data)(struct himax_ts_data *ts, u8 *info_data,
+				  bool dsram_flag);
+/* CORE_SRAM */
+
+/* CORE_DRIVER */
+	bool (*fp_chip_detect)(struct himax_ts_data *ts);
+	void (*fp_chip_init)(struct himax_ts_data *ts);
+	void (*fp_pin_reset)(struct himax_ts_data *ts);
+	u8 (*fp_tp_info_check)(struct himax_ts_data *ts);
+	void (*fp_touch_information)(struct himax_ts_data *ts);
+	void (*fp_calc_touch_data_size)(struct himax_ts_data *ts);
+	void (*fp_reload_config)(void);
+	int (*fp_get_touch_data_size)(void);
+	void (*fp_usb_detect_set)(struct himax_ts_data *ts,
+				  const u8 *cable_config);
+	int (*fp_hand_shaking)(void);
+	int (*fp_determin_diag_rawdata)(int diag_command);
+	int (*fp_determin_diag_storage)(int diag_command);
+	int (*fp_cal_data_len)(int raw_cnt_rmd, int HX_MAX_PT, int raw_cnt_max);
+	bool (*fp_diag_check_sum)(struct himax_ts_data *ts);
+
+	void (*fp_ic_reset)(struct himax_ts_data *ts,
+			    u8 loadconfig, u8 int_off);
+	int (*fp_ic_excp_recovery)
+			(struct himax_ts_data *ts,
+			u32 hx_excp_event,
+			u32 hx_zero_event, u32 length);
+	void (*fp_excp_ic_reset)(struct himax_ts_data *ts);
+	void (*fp_resend_cmd_func)(struct himax_ts_data *ts, bool suspended);
+/* CORE_DRIVER */
+	int (*fp_turn_on_mp_func)(struct himax_ts_data *ts, int on);
+	void (*fp_clean_sram_0f)(struct himax_ts_data *ts, u8 *addr,
+				 int write_len, int type);
+	void (*fp_write_sram_0f)(struct himax_ts_data *ts, u8 *addr,
+				 const u8 *data, u32 len);
+	int (*fp_write_sram_0f_crc)(struct himax_ts_data *ts, u8 *addr,
+				    const u8 *data, u32 len);
+	int (*fp_firmware_update_0f)(const struct firmware *fw_entry,
+				     struct himax_ts_data *ts, int type);
+	int (*fp_0f_op_file_dirly)(char *file_name, struct himax_ts_data *ts);
+	int (*fp_0f_excp_check)(void);
+	void (*fp_0f_reload_to_active)(struct himax_ts_data *ts);
+	void (*_en_hw_crc)(struct himax_ts_data *ts, int en);
+	void (*fp_read_sram_0f)(struct himax_ts_data *ts,
+				const struct firmware *fw_entry,
+				u8 *addr, int start_index, int read_len);
+	void (*fp_read_all_sram)(struct himax_ts_data *ts,
+				 u8 *addr, int read_len);
+	void (*fp_firmware_read_0f)(struct himax_ts_data *ts,
+				    const struct firmware *fw_entry, int type);
+	int (*fp_0f_overlay)(struct himax_ts_data *ts, int ovl_type, int mode);
+	void (*fp_suspend_proc)(struct himax_ts_data *ts, bool suspended);
+	void (*fp_resume_proc)(struct himax_ts_data *ts, bool suspended);
+};
+
+extern struct himax_core_command_regs g_core_regs;
+
+void himax_ic_reg_init(struct himax_core_command_regs *reg_data);
+void himax_ic_fp_init(void);
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_inspect.c b/drivers/hid/hx-hid/hx_inspect.c
new file mode 100644
index 000000000000..51782e390910
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_inspect.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+#include "hx_hid.h"
+#include "hx_ic_core.h"
+#include "hx_plat.h"
+#include "hx_inspect.h"
+
+#define BS_RAWDATA     8
+#define BS_NOISE       8
+#define BS_OPENSHORT   0
+#define	BS_LPWUG       1
+#define	BS_LP_IDLE     1
+#define	BS_ACT_IDLE    1
+
+#define	NOISEFRAME                      60
+#define NORMAL_IDLE_RAWDATA_NOISEFRAME  10
+#define LP_RAWDATAFRAME              1
+#define LP_NOISEFRAME                1
+#define LP_IDLE_RAWDATAFRAME         1
+#define LP_IDLE_NOISEFRAME           1
+
+#define OTHERSFRAME		2
+
+#define	UNIFMAX			500
+
+/*Himax MP Password*/
+#define	PWD_OPEN_START          0x7777
+#define	PWD_OPEN_END            0x8888
+#define	PWD_SHORT_START         0x1111
+#define	PWD_SHORT_END           0x3333
+#define	PWD_RAWDATA_START       0x0000
+#define	PWD_RAWDATA_END         0x9999
+#define	PWD_NOISE_START         0x0000
+#define	PWD_NOISE_END           0x9999
+#define	PWD_SORTING_START       0xAAAA
+#define	PWD_SORTING_END         0xCCCC
+
+#define PWD_ACT_IDLE_START      0x2222
+#define PWD_ACT_IDLE_END        0x4444
+
+#define PWD_LP_START         0x5555
+#define PWD_LP_END           0x6666
+
+#define PWD_LP_IDLE_START    0x5050
+#define PWD_LP_IDLE_END      0x6060
+
+/*Himax Data Ready Password*/
+#define	DATA_PWD       0x5AA5
+
+/*Inspection register*/
+#define addr_normal_noise_thx   0x1000708C
+#define addr_lpwug_noise_thx    0x10007090
+#define addr_noise_scale        0x10007094
+#define addr_recal_thx          0x10007090
+#define addr_palm_num           0x100070A8
+#define addr_weight_sup         0x100072C8
+#define addr_normal_weight_a    0x1000709C
+#define addr_lpwug_weight_a     0x100070A0
+#define addr_weight_b           0x10007094
+#define addr_max_dc             0x10007FC8
+#define addr_skip_frame         0x100070F4
+#define addr_neg_noise_sup      0x10007FD8
+#define data_neg_noise          0x7F0C0000
+
+/*Need to map THP_INSPECTION_ENUM*/
+static char *g_himax_inspection_mode[] = {
+	"HIMAX_OPEN",
+	"HIMAX_MICRO_OPEN",
+	"HIMAX_SHORT",
+	"HIMAX_SC",
+	"HIMAX_WEIGHT_NOISE",
+	"HIMAX_ABS_NOISE",
+	"HIMAX_RAWDATA",
+	"HIMAX_BPN_RAWDATA",
+	"HIMAX_SORTING",
+	"HIMAX_GAPTEST_RAW",
+	/*"HIMAX_GAPTEST_RAW_X",*/
+	/*"HIMAX_GAPTEST_RAW_Y",*/
+
+	"HIMAX_ACT_IDLE_NOISE",
+	"HIMAX_ACT_IDLE_RAWDATA",
+	"HIMAX_ACT_IDLE_BPN_RAWDATA",
+
+	"HIMAX_LPWUG_WEIGHT_NOISE",
+	"HIMAX_LPWUG_ABS_NOISE",
+	"HIMAX_LPWUG_RAWDATA",
+	"HIMAX_LPWUG_BPN_RAWDATA",
+
+	"HIMAX_LPWUG_IDLE_NOISE",
+	"HIMAX_LPWUG_IDLE_RAWDATA",
+	"HIMAX_LPWUG_IDLE_BPN_RAWDATA",
+
+	"HIMAX_BACK_NORMAL",
+	NULL
+};
+
+enum HX_INSPT_SETTING_IDX {
+	RAW_BS_FRAME = 0,
+	NOISE_BS_FRAME,
+	ACT_IDLE_BS_FRAME,
+	LP_BS_FRAME,
+	LP_IDLE_BS_FRAME,
+
+	NFRAME,
+	IDLE_NFRAME,
+	LP_RAW_NFRAME,
+	LP_NOISE_NFRAME,
+	LP_IDLE_RAW_NFRAME,
+	LP_IDLE_NOISE_NFRAME,
+	NFRAME_MAX,
+};
+
+static s32 g_hx_inspt_setting_val[NFRAME_MAX] = {0};
+
+static const u16 g_hx_data_type[HX_DATA_TYPE_MAX] = {
+	DATA_SORTING,
+	DATA_OPEN,
+	DATA_MICRO_OPEN,
+	DATA_SHORT,
+	DATA_RAWDATA,
+	DATA_NOISE,
+	DATA_BACK_NORMAL,
+	DATA_LP_RAWDATA,
+	DATA_LP_NOISE,
+	DATA_ACT_IDLE_RAWDATA,
+	DATA_ACT_IDLE_NOISE,
+	DATA_LP_IDLE_RAWDATA,
+	DATA_LP_IDLE_NOISE,
+};
+
+static int hx_switch_mode_inspection(struct himax_ts_data *ts, int mode)
+{
+	union hx_dword_data_t tmp_addr = {0};
+	union hx_dword_data_t tmp_data = {0};
+
+	I("Entering");
+
+	/*Stop Handshaking*/
+	tmp_addr.dword = cpu_to_le32(sram_adr_rawdata_addr);
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	/*Switch Mode*/
+	switch (mode) {
+	case HX_SORTING:
+		tmp_data.dword = cpu_to_le32(PWD_SORTING_START);
+		break;
+	case HX_OPEN:
+		tmp_data.dword = cpu_to_le32(PWD_OPEN_START);
+		break;
+	case HX_MICRO_OPEN:
+		tmp_data.dword = cpu_to_le32(PWD_OPEN_START);
+		break;
+	case HX_SHORT:
+		tmp_data.dword = cpu_to_le32(PWD_SHORT_START);
+		break;
+
+	case HX_GAPTEST_RAW:
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+		tmp_data.dword = cpu_to_le32(PWD_RAWDATA_START);
+		break;
+
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_NOISE_START);
+		break;
+
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_ACT_IDLE_START);
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_LP_START);
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		tmp_data.dword = cpu_to_le32(PWD_LP_IDLE_START);
+		break;
+
+	default:
+		I("Nothing to be done!");
+		break;
+	}
+
+	if (g_core_fp.fp_assign_sorting_mode)
+		g_core_fp.fp_assign_sorting_mode(ts, tmp_data.byte);
+	I("End of setting!");
+
+	return 0;
+}
+
+void hx_switch_data_type(struct himax_ts_data *ts, u32 type)
+{
+	u32 datatype = 0x00;
+
+	I("Expected type[%d]=%s",
+	  type, g_himax_inspection_mode[type]);
+
+	switch (type) {
+	case HX_SORTING:
+		datatype = g_hx_data_type[HX_DATA_SORTING];
+		break;
+	case HX_OPEN:
+		datatype = g_hx_data_type[HX_DATA_OPEN];
+		break;
+	case HX_MICRO_OPEN:
+		datatype = g_hx_data_type[HX_DATA_MICRO_OPEN];
+		break;
+	case HX_SHORT:
+		datatype = g_hx_data_type[HX_DATA_SHORT];
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+	case HX_GAPTEST_RAW:
+		datatype = g_hx_data_type[HX_DATA_RAWDATA];
+		break;
+
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		datatype = g_hx_data_type[HX_DATA_NOISE];
+		break;
+	case HX_BACK_NORMAL:
+		datatype = g_hx_data_type[HX_DATA_BACK_NORMAL];
+		break;
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+		datatype = g_hx_data_type[HX_DATA_ACT_IDLE_RAWDATA];
+		break;
+	case HX_ACT_IDLE_NOISE:
+		datatype = DATA_ACT_IDLE_NOISE;
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+		datatype = g_hx_data_type[HX_DATA_LP_RAWDATA];
+		break;
+	case HX_LP_WT_NOISE:
+	case HX_LP_ABS_NOISE:
+		datatype = g_hx_data_type[HX_DATA_LP_NOISE];
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+		datatype = g_hx_data_type[HX_DATA_LP_IDLE_RAWDATA];
+		break;
+	case HX_LP_IDLE_NOISE:
+		datatype = g_hx_data_type[HX_DATA_LP_IDLE_NOISE];
+		break;
+
+	default:
+		E("Wrong type=%d", type);
+		break;
+	}
+	g_core_fp.fp_diag_register_set(ts, datatype);
+}
+
+static void hx_bank_search_set(struct himax_ts_data *ts, u32 n_frame,
+			       u32 checktype)
+{
+	union hx_dword_data_t tmp_data = {0};
+	union hx_dword_data_t tmp_addr = {0};
+
+	/*skip frame 0x100070F4*/
+	tmp_addr.dword = cpu_to_le32(addr_skip_frame);
+	g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	switch (checktype) {
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		if (g_hx_inspt_setting_val[ACT_IDLE_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[ACT_IDLE_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_ACT_IDLE;
+		break;
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		if (g_hx_inspt_setting_val[LP_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[LP_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_LPWUG;
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		if (g_hx_inspt_setting_val[LP_IDLE_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[LP_IDLE_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_LP_IDLE;
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+		if (g_hx_inspt_setting_val[RAW_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[RAW_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_RAWDATA;
+		break;
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		if (g_hx_inspt_setting_val[NOISE_BS_FRAME] > 0)
+			tmp_data.byte[0] = g_hx_inspt_setting_val[NOISE_BS_FRAME];
+		else
+			tmp_data.byte[0] = BS_NOISE;
+		break;
+	default:
+		tmp_data.byte[0] = BS_OPENSHORT;
+		break;
+	}
+	D("Now BankSearch Value=%d", tmp_data.byte[0]);
+
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+}
+
+static void hx_neg_noise_sup(struct himax_ts_data *ts, u8 *data)
+{
+	union hx_dword_data_t tmp_data = {0};
+	union hx_dword_data_t tmp_addr = {0};
+
+	/*0x10007FD8 Check support negative value or not */
+	tmp_addr.dword = cpu_to_le32(addr_neg_noise_sup);
+	g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	if ((tmp_data.byte[3] & 0x04) == 0x04) {
+		tmp_data.dword = cpu_to_le32(data_neg_noise);
+		data[2] = tmp_data.byte[2]; data[3] = tmp_data.byte[3];
+	} else {
+		I("Not support negative noise");
+	}
+}
+
+static void hx_set_N_frame(struct himax_ts_data *ts, u32 n_frame,
+			   u32 checktype)
+{
+	union hx_dword_data_t tmp_data = {0};
+	union hx_dword_data_t tmp_addr = {0};
+
+	hx_bank_search_set(ts, n_frame, checktype);
+
+	/*IIR MAX - 0x10007294*/
+	tmp_addr.dword = cpu_to_le32(fw_addr_set_frame_addr);
+	tmp_data.dword = cpu_to_le32(n_frame);
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+
+	if (checktype == HX_WT_NOISE ||
+	    checktype == HX_ABS_NOISE ||
+		checktype == HX_LP_WT_NOISE ||
+		checktype == HX_LP_ABS_NOISE)
+		hx_neg_noise_sup(ts, tmp_data.byte);
+	I("Now N frame Value=0x%X",
+	  le32_to_cpu(tmp_data.dword));
+
+	g_core_fp.fp_register_write(ts, tmp_addr.byte, tmp_data.byte, 4);
+}
+
+static u32 hx_check_mode(struct himax_ts_data *ts, u8 checktype)
+{
+	int ret = 0;
+	union hx_dword_data_t tmp_data = {0};
+	u16 wait_pwd = {0};
+
+	switch (checktype) {
+	case HX_SORTING:
+		wait_pwd = PWD_SORTING_END;
+		break;
+	case HX_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_MICRO_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_SHORT:
+		wait_pwd = PWD_SHORT_END;
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+	case HX_GAPTEST_RAW:
+		wait_pwd = PWD_RAWDATA_END;
+		break;
+
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		wait_pwd = PWD_NOISE_END;
+		break;
+
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		wait_pwd = PWD_ACT_IDLE_END;
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		wait_pwd = PWD_LP_END;
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		wait_pwd = PWD_LP_IDLE_END;
+		break;
+
+	default:
+		E("Wrong type=%d", checktype);
+		break;
+	}
+
+	if (g_core_fp.fp_check_sorting_mode) {
+		ret = g_core_fp.fp_check_sorting_mode(ts, tmp_data.byte);
+		if (ret != NO_ERR)
+			return ret;
+	}
+
+	if ((le32_to_cpu(tmp_data.dword) & 0xFFFF) == wait_pwd) {
+		I("It had been changed to [%d]=%s",
+		  checktype, g_himax_inspection_mode[checktype]);
+		return NO_ERR;
+	} else {
+		return 1;
+	}
+}
+
+static u32 hx_wait_sorting_mode(struct himax_ts_data *ts,
+				u8 checktype)
+{
+	int count = 0;
+	union hx_dword_data_t tmp_addr = {0};
+	union hx_dword_data_t tmp_data = {0};
+	u16 wait_pwd = {0};
+
+	D("start!");
+
+	switch (checktype) {
+	case HX_SORTING:
+		wait_pwd = PWD_SORTING_END;
+		break;
+	case HX_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_MICRO_OPEN:
+		wait_pwd = PWD_OPEN_END;
+		break;
+	case HX_SHORT:
+		wait_pwd = PWD_SHORT_END;
+		break;
+	case HX_RAWDATA:
+	case HX_BPN_RAWDATA:
+	case HX_SC:
+	case HX_GAPTEST_RAW:
+		wait_pwd = PWD_RAWDATA_END;
+		break;
+	case HX_WT_NOISE:
+	case HX_ABS_NOISE:
+		wait_pwd = PWD_NOISE_END;
+		break;
+	case HX_ACT_IDLE_RAWDATA:
+	case HX_ACT_IDLE_BPN_RAWDATA:
+	case HX_ACT_IDLE_NOISE:
+		wait_pwd = PWD_ACT_IDLE_END;
+		break;
+
+	case HX_LP_RAWDATA:
+	case HX_LP_BPN_RAWDATA:
+	case HX_LP_ABS_NOISE:
+	case HX_LP_WT_NOISE:
+		wait_pwd = PWD_LP_END;
+		break;
+	case HX_LP_IDLE_RAWDATA:
+	case HX_LP_IDLE_BPN_RAWDATA:
+	case HX_LP_IDLE_NOISE:
+		wait_pwd = PWD_LP_IDLE_END;
+		break;
+
+	default:
+		I("No Change Mode and now type=%d", checktype);
+		break;
+	}
+	I("NowType[%d] = %s, Expected=0x%04X",
+	  checktype, g_himax_inspection_mode[checktype],
+		 wait_pwd);
+	do {
+		D("start check_sorting_mode!");
+		if (g_core_fp.fp_check_sorting_mode)
+			g_core_fp.fp_check_sorting_mode(ts, tmp_data.byte);
+		D("end check_sorting_mode!");
+		if ((le32_to_cpu(tmp_data.dword) & 0xFFFF) == wait_pwd)
+			return HX_INSP_OK;
+
+		tmp_addr.dword = cpu_to_le32(fw_addr_chk_fw_status);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+		D("0x%08X : %08X", fw_addr_chk_fw_status,
+		  le32_to_cpu(tmp_data.dword));
+
+		tmp_addr.dword = cpu_to_le32(fw_addr_flag_reset_event);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+		D("0x%08X : %08X", fw_addr_flag_reset_event,
+		  le32_to_cpu(tmp_data.dword));
+
+		tmp_addr.dword = cpu_to_le32(fw_addr_fw_dbg_msg_addr);
+		g_core_fp.fp_register_read(ts, tmp_addr.byte, tmp_data.byte, 4);
+		D("0x%08X : %08X", fw_addr_fw_dbg_msg_addr,
+		  le32_to_cpu(tmp_data.dword));
+
+		D("Now retry %d times!", count);
+
+		count++;
+		usleep_range(50000, 50001);
+	} while (count < 10);
+
+	D("end");
+	return HX_INSP_ESWITCHMODE;
+}
+
+void hx_self_test(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_self_test.work);
+	u32 checktype = ts->hid_req_cfg.self_test_type;
+	s32 n_frame = 0;
+	u32 ret_val = NO_ERR;
+	int check_sort_sts = NO_ERR;
+	int switch_mode_cnt = 0;
+
+	check_sort_sts = hx_check_mode(ts, checktype);
+	if (check_sort_sts < NO_ERR) {
+		ret_val = HX_INSP_ESWITCHMODE;
+		ts->hid_req_cfg.handshake_get = HID_SELF_TEST_ERROR;
+		goto END;
+	}
+
+	if (check_sort_sts) {
+		I("Need Change Mode, target=%s",
+		  g_himax_inspection_mode[checktype]);
+SWITCH_MODE:
+		D("start sense off!");
+		g_core_fp.fp_sense_off(ts, true);
+		D("end sense off!");
+
+		if (ts->ic_data->has_flash) {
+			g_core_fp.fp_turn_on_mp_func(ts, 1);
+			if (g_core_fp.fp_reload_disable)
+				g_core_fp.fp_reload_disable(ts, 1);
+		}
+		hx_switch_mode_inspection(ts, checktype);
+
+		switch (checktype) {
+		case HX_WT_NOISE:
+		case HX_ABS_NOISE:
+			if (g_hx_inspt_setting_val[NFRAME] > 0)
+				n_frame = g_hx_inspt_setting_val[NFRAME];
+			else
+				n_frame = NOISEFRAME;
+			break;
+		case HX_ACT_IDLE_RAWDATA:
+		case HX_ACT_IDLE_NOISE:
+		case HX_ACT_IDLE_BPN_RAWDATA:
+			if (g_hx_inspt_setting_val[IDLE_NFRAME] > 0)
+				n_frame = g_hx_inspt_setting_val[IDLE_NFRAME];
+			else
+				n_frame = NORMAL_IDLE_RAWDATA_NOISEFRAME;
+			break;
+		case HX_LP_RAWDATA:
+		case HX_LP_BPN_RAWDATA:
+			if (g_hx_inspt_setting_val[LP_RAW_NFRAME] > 0)
+				n_frame = g_hx_inspt_setting_val[LP_RAW_NFRAME];
+			else
+				n_frame = LP_RAWDATAFRAME;
+			break;
+		case HX_LP_WT_NOISE:
+		case HX_LP_ABS_NOISE:
+			if (g_hx_inspt_setting_val[LP_NOISE_NFRAME] > 0)
+				n_frame =
+					g_hx_inspt_setting_val[LP_NOISE_NFRAME];
+			else
+				n_frame = LP_NOISEFRAME;
+			break;
+		case HX_LP_IDLE_RAWDATA:
+		case HX_LP_IDLE_BPN_RAWDATA:
+			if (g_hx_inspt_setting_val[LP_IDLE_RAW_NFRAME] > 0)
+				n_frame =
+				g_hx_inspt_setting_val[LP_IDLE_RAW_NFRAME];
+			else
+				n_frame = LP_IDLE_RAWDATAFRAME;
+			break;
+		case HX_LP_IDLE_NOISE:
+			if (g_hx_inspt_setting_val[LP_IDLE_NOISE_NFRAME] > 0)
+				n_frame =
+				g_hx_inspt_setting_val[LP_IDLE_NOISE_NFRAME];
+			else
+				n_frame = LP_IDLE_NOISEFRAME;
+			break;
+		default:
+			n_frame = OTHERSFRAME;
+		}
+		hx_set_N_frame(ts, n_frame, checktype);
+		g_core_fp.fp_sense_on(ts, 1);
+	}
+
+	ret_val = hx_wait_sorting_mode(ts, checktype);
+	if (ret_val) {
+		if (ret_val == HX_INSP_ESWITCHMODE && switch_mode_cnt < 3) {
+			switch_mode_cnt++;
+			g_core_fp.fp_ic_reset(ts, false, false);
+			goto SWITCH_MODE;
+		}
+		E("himax_wait_sorting_mode FAIL");
+		ts->hid_req_cfg.handshake_get = HID_SELF_TEST_ERROR;
+		goto END;
+	}
+	hx_switch_data_type(ts, checktype);
+
+	ts->hid_req_cfg.handshake_get = HID_SELF_TEST_FINISH;
+END:
+	mutex_unlock(&ts->hid_ioctl_lock);
+}
+
+int hx_get_data(struct himax_ts_data *ts, u8 *data, s32 len)
+{
+	bool get_raw_rlst = false;
+
+	get_raw_rlst = g_core_fp.fp_get_DSRAM_data(ts, data, false);
+
+	if (get_raw_rlst)
+		return HX_INSP_OK;
+	else
+		return HX_INSP_EGETRAW;
+}
diff --git a/drivers/hid/hx-hid/hx_inspect.h b/drivers/hid/hx-hid/hx_inspect.h
new file mode 100644
index 000000000000..e601dbb81e8a
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_inspect.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __HX_INSPECT_H__
+#define __HX_INSPECT_H__
+
+#include "hx_core.h"
+#include "hx_hid.h"
+
+enum THP_INSPECTION_ENUM {
+	HX_OPEN,
+	HX_MICRO_OPEN,
+	HX_SHORT,
+	HX_SC,
+	HX_WT_NOISE,
+	HX_ABS_NOISE,
+	HX_RAWDATA,
+	HX_BPN_RAWDATA,
+	HX_SORTING,
+
+	HX_GAPTEST_RAW,
+	/*HX_GAPTEST_RAW_X,*/
+	/*HX_GAPTEST_RAW_Y,*/
+
+	HX_ACT_IDLE_NOISE,
+	HX_ACT_IDLE_RAWDATA,
+	HX_ACT_IDLE_BPN_RAWDATA,
+/*LPWUG test must put after Normal test*/
+	HX_LP_WT_NOISE,
+	HX_LP_ABS_NOISE,
+	HX_LP_RAWDATA,
+	HX_LP_BPN_RAWDATA,
+
+	HX_LP_IDLE_NOISE,
+	HX_LP_IDLE_RAWDATA,
+	HX_LP_IDLE_BPN_RAWDATA,
+
+	HX_BACK_NORMAL,/*Must put in the end*/
+};
+
+/*Himax DataType*/
+#define DATA_SORTING            0x0A
+#define DATA_OPEN               0x0B
+#define DATA_MICRO_OPEN         0x0C
+#define DATA_SHORT              0x0A
+#define DATA_RAWDATA            0x0A
+#define DATA_NOISE              0x0F
+#define DATA_BACK_NORMAL        0x00
+#define DATA_LP_RAWDATA      0x0C
+#define DATA_LP_NOISE        0x0F
+#define DATA_ACT_IDLE_RAWDATA   0x0A
+#define DATA_ACT_IDLE_NOISE     0x0F
+#define DATA_LP_IDLE_RAWDATA 0x0A
+#define DATA_LP_IDLE_NOISE   0x0F
+
+enum HX_DATA_TYPE_ENUM {
+	HX_DATA_SORTING,
+	HX_DATA_OPEN,
+	HX_DATA_MICRO_OPEN,
+	HX_DATA_SHORT,
+	HX_DATA_RAWDATA,
+	HX_DATA_NOISE,
+	HX_DATA_BACK_NORMAL,
+	HX_DATA_LP_RAWDATA,
+	HX_DATA_LP_NOISE,
+	HX_DATA_ACT_IDLE_RAWDATA,
+	HX_DATA_ACT_IDLE_NOISE,
+	HX_DATA_LP_IDLE_RAWDATA,
+	HX_DATA_LP_IDLE_NOISE,
+	HX_DATA_TYPE_MAX
+};
+
+enum HX_INSP_TEST_ERR_ENUM {
+	/* OK */
+	HX_INSP_OK = 0,
+
+	/* FAIL */
+	HX_INSP_FAIL = 1,
+
+	/* Memory allocate errors */
+	HX_INSP_MEMALLCTFAIL = 1 << 1,
+
+	/* Abnormal screen state */
+	HX_INSP_ESCREEN = 1 << 2,
+
+	/* Out of specification */
+	HX_INSP_ESPEC = 1 << 3,
+
+	/* Criteria file error*/
+	HX_INSP_EFILE = 1 << 4,
+
+	/* Switch mode error*/
+	HX_INSP_ESWITCHMODE = 1 << 5,
+
+	/* Get raw data errors */
+	HX_INSP_EGETRAW = 1 << 6,
+};
+
+void hx_self_test(struct work_struct *work);
+
+int hx_get_data(struct himax_ts_data *ts, u8 *data, s32 len);
+
+void hx_switch_data_type(struct himax_ts_data *ts, u32 type);
+
+#endif
diff --git a/drivers/hid/hx-hid/hx_of.c b/drivers/hid/hx-hid/hx_of.c
new file mode 100644
index 000000000000..0f1b5b78426e
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_of.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+
+#define UNUSED(x) ((void)(x))
+static const char default_fw_name[] = BOOT_UPGRADE_FWNAME;
+
+int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
+{
+#ifdef HX_PID_FW_MAPPING
+	static char pid_fw_name[ARRAY_SIZE(default_fw_name) + 5 + 4 + 1] = {0};
+	int tmp = 0;
+	const int pid_prop_args = 2;
+#endif
+	u32 data = 0;
+	int id_gpios[8] = {0};
+	int counter = 0;
+	int i = 0;
+	s16 id_value = -1;
+
+	if (!dt || !pdata) {
+		E("DT: dev or pdata is NULL");
+		return -EINVAL;
+	}
+	pdata->gpio_irq = of_get_named_gpio(dt, "himax,irq-gpio", 0);
+	if (!gpio_is_valid(pdata->gpio_irq)) {
+		I(" DT:gpio-irq value is not valid");
+		return -EIO;
+	}
+
+	pdata->gpio_reset = of_get_named_gpio(dt, "himax,rst-gpio", 0);
+	if (!gpio_is_valid(pdata->gpio_reset)) {
+		I(" DT:gpio-rst value is not valid");
+		return -EIO;
+	}
+
+	pdata->gpio_3v3_en = of_get_named_gpio(dt, "himax,3v3-gpio", 0);
+	if (!gpio_is_valid(pdata->gpio_3v3_en))
+		I(" DT:gpio-3v3-en value is not valid");
+
+	I(" DT:gpio-irq=%d, gpio-rst=%d, gpio-3v3-en=%d",
+	  pdata->gpio_irq, pdata->gpio_reset, pdata->gpio_3v3_en);
+
+	counter = of_gpio_named_count(dt, "himax,id-gpios");
+	if (counter > 0) {
+		for (i = 0 ; i < counter ; i++) {
+			id_gpios[i] = of_get_named_gpio(dt, "himax,id-gpios", i);
+			if (!gpio_is_valid(id_gpios[i])) {
+				I(" DT:gpio-id value is not valid");
+				return -EIO;
+			}
+			I(" DT:gpio-id[%d]=%d", i, id_gpios[i]);
+		}
+		id_value = 0;
+		for (i = 0 ; i < counter ; i++) {
+			gpio_direction_input(id_gpios[i]);
+			id_value |= gpio_get_value(id_gpios[i]) << i;
+		}
+		I(" DT:gpio-id value=%04X", id_value);
+		pdata->panel_id = id_value;
+	} else {
+		pdata->panel_id = -1;
+		D(" DT:gpio-id not found");
+	}
+
+#ifdef HX_PID_FW_MAPPING
+	UNUSED(default_fw_name);
+	/*
+	 * check himax,pid first, if exist then check if it is single.
+	 * Single case: himax,pid = <0x1002>; // 0x1002 is pid value
+	 * Multiple case: himax,pid = <id_value0 00x1001>, <id_value1 0x1002>;
+	 * When id_value >= 0, check the mapping listed to use the pid value.
+	 */
+
+	if (of_get_property(dt, "himax,pid", &data)) {
+		counter = data / (sizeof(u32) * pid_prop_args);
+
+		if (!counter) {
+			// default case, no id->pid mappings
+			if (of_property_read_u32(dt, "himax,pid", &data)) {
+				pdata->pid = 0;
+				D(" DT:himax,pid not found");
+				goto GET_PID_END;
+			} else {
+				goto GET_PID_VALUE;
+			}
+		}
+
+		if (id_value < 0) {
+			E(" DT:himax,pid has no matched for id_value=%04X", id_value);
+			pdata->pid = 0;
+			goto GET_PID_END;
+		}
+
+		for (i = 0; i < counter; i++) {
+			if (of_property_read_u32_index(dt, "himax,pid",
+						       i * pid_prop_args, &tmp)) {
+				D(" DT:himax,pid parsing error!");
+				pdata->pid = 0;
+				goto GET_PID_END;
+			}
+
+			if (of_property_read_u32_index(dt, "himax,pid",
+						       i * pid_prop_args + 1, &data)) {
+				D(" DT:himax,pid parsing error!");
+				pdata->pid = 0;
+				goto GET_PID_END;
+			}
+
+			if (tmp == id_value) {
+				I(" DT:himax,pid mapping: id=%04X => pid=%04X, matched!",
+				  tmp, data);
+				i = counter;
+			} else {
+				I(" DT:himax,pid mapping: id=%04X => pid=%04X", tmp, data);
+			}
+		}
+
+		if (counter == i) {
+			E(" DT:himax,pid has no matched for id_value=%04X", id_value);
+			pdata->pid = 0;
+			goto GET_PID_END;
+		}
+
+GET_PID_VALUE:
+		g_fw_boot_upgrade_name = pid_fw_name;
+		pdata->pid = data;
+		snprintf(pid_fw_name, sizeof(pid_fw_name), "%s_%04X%s",
+			 BOOT_UPGRADE_FWNAME, pdata->pid, ".bin");
+		I(" DT:himax,pid=%04X, fw_name=%s",
+		  pdata->pid, pid_fw_name);
+	} else {
+		pdata->pid = 0;
+		D(" DT:himax,pid not found");
+	}
+GET_PID_END:
+#endif
+
+	// himax,ic_det_delay unit is millisecond
+	if (of_property_read_u32(dt, "himax,ic-det-delay-ms", &data)) {
+		pdata->ic_det_delay = 0;
+		D(" DT:himax,ic-det-delay-ms not found");
+	} else {
+		pdata->ic_det_delay = data;
+		I(" DT:himax,ic-det-delay-ms=%d", pdata->ic_det_delay);
+	}
+
+	// himax,ic_resume_delay unit is millisecond
+	if (of_property_read_u32(dt, "himax,ic-resume-delay-ms", &data)) {
+		pdata->ic_resume_delay = 0;
+		D(" DT:himax,ic-resume-delay-ms not found");
+	} else {
+		pdata->ic_resume_delay = data;
+		I(" DT:himax,ic-resume-delay-ms=%d", pdata->ic_resume_delay);
+	}
+
+	return 0;
+}
diff --git a/drivers/hid/hx-hid/hx_plat.c b/drivers/hid/hx-hid/hx_plat.c
new file mode 100644
index 000000000000..7ed210102070
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_plat.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Himax Driver Code for Common IC to simulate HID
+ *
+ *  Copyright (C) 2023 Himax Corporation.
+ *
+ *  This software is licensed under the terms of the GNU General Public
+ *  License version 2,  as published by the Free Software Foundation,  and
+ *  may be copied,  distributed,  and modified under those terms.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include "hx_core.h"
+#include "hx_plat.h"
+
+void himax_rst_gpio_set(int pinnum, u8 value)
+{
+	gpio_direction_output(pinnum, value);
+}
+
+int himax_gpio_power_config(struct himax_ts_data *ts,
+			    struct himax_platform_data *pdata)
+{
+	int error = 0;
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		error = gpio_request(pdata->gpio_reset, "himax-reset");
+
+		if (error < 0) {
+			E("request reset pin failed");
+			goto err_gpio_reset_req;
+		}
+
+		error = gpio_direction_output(pdata->gpio_reset, 0);
+
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_reset);
+			goto err_gpio_reset_dir;
+		}
+	}
+
+	if (gpio_is_valid(pdata->gpio_3v3_en)) {
+		error = gpio_request(pdata->gpio_3v3_en, "himax-3v3_en");
+
+		if (error < 0) {
+			E("request 3v3_en pin failed");
+			goto err_gpio_3v3_req;
+		}
+
+		gpio_direction_output(pdata->gpio_3v3_en, 1);
+		I("3v3_en set 1 get pin = %d",
+		  gpio_get_value(pdata->gpio_3v3_en));
+	}
+
+	if (gpio_is_valid(pdata->gpio_irq)) {
+		/* configure touchscreen irq gpio */
+		error = gpio_request(pdata->gpio_irq, "himax_gpio_irq");
+
+		if (error) {
+			E("unable to request gpio [%d]", pdata->gpio_irq);
+			goto err_gpio_irq_req;
+		}
+
+		error = gpio_direction_input(pdata->gpio_irq);
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_irq);
+			goto err_gpio_irq_set_input;
+		}
+
+		ts->hx_irq = gpio_to_irq(pdata->gpio_irq);
+	} else {
+		E("irq gpio not provided");
+		goto err_gpio_irq_req;
+	}
+
+	usleep_range(2000, 2001);
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		error = gpio_direction_output(pdata->gpio_reset, 1);
+
+		if (error) {
+			E("unable to set direction for gpio [%d]",
+			  pdata->gpio_reset);
+			goto err_gpio_reset_set_high;
+		}
+	}
+
+	return error;
+
+err_gpio_reset_set_high:
+err_gpio_irq_set_input:
+	if (gpio_is_valid(pdata->gpio_irq))
+		gpio_free(pdata->gpio_irq);
+err_gpio_irq_req:
+	if (gpio_is_valid(pdata->gpio_3v3_en))
+		gpio_free(pdata->gpio_3v3_en);
+err_gpio_3v3_req:
+err_gpio_reset_dir:
+	if (gpio_is_valid(pdata->gpio_reset))
+		gpio_free(pdata->gpio_reset);
+err_gpio_reset_req:
+
+	return error;
+}
+
+void himax_gpio_power_deconfig(struct himax_platform_data *pdata)
+{
+	if (gpio_is_valid(pdata->gpio_irq)) {
+		I("free gpio_irq = %d", pdata->gpio_irq);
+		gpio_free(pdata->gpio_irq);
+	}
+
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		I("free gpio_reset = %d", pdata->gpio_reset);
+		gpio_free(pdata->gpio_reset);
+	}
+
+	if (gpio_is_valid(pdata->gpio_3v3_en))
+		gpio_free(pdata->gpio_3v3_en);
+}
+
+static int himax_spi_read(struct himax_ts_data *ts, u8 *cmd,
+			  u8 cmd_len, u8 *buf, u32 len)
+{
+	struct spi_message m;
+	int result = NO_ERR;
+	int retry;
+	int error;
+	struct spi_transfer	t = {
+		.len = cmd_len + len,
+	};
+
+	t.tx_buf = ts->xfer_data;
+	t.rx_buf = ts->xfer_data;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	for (retry = 0; retry < HIMAX_BUS_RETRY_TIMES; retry++) {
+		error = spi_sync(ts->spi, &m);
+		if (unlikely(error))
+			E("SPI read error: %d", error);
+		else
+			break;
+	}
+
+	if (retry == HIMAX_BUS_RETRY_TIMES) {
+		E("SPI read error retry over %d", HIMAX_BUS_RETRY_TIMES);
+		result = -EIO;
+		goto END;
+	} else {
+		memcpy(buf, ts->xfer_data + cmd_len, len);
+	}
+
+END:
+	return result;
+}
+
+static int himax_spi_write(struct himax_ts_data *ts, u8 *buf,
+			   u32 length)
+{
+	int status;
+	struct spi_message	m;
+	struct spi_transfer	t = {
+			.tx_buf		= buf,
+			.len		= length,
+	};
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	status = spi_sync(ts->spi, &m);
+
+	if (status == 0) {
+		status = m.status;
+		if (status == 0)
+			status = m.actual_length;
+	}
+
+	return status;
+}
+
+int himax_bus_read(struct himax_ts_data *ts, u8 cmd,
+		   u8 *buf, u32 len)
+{
+	int result = -1;
+	u8 hw_addr = 0x00;
+
+	if (len > BUS_R_DLEN) {
+		E("len[%d] is over %d", len, BUS_R_DLEN);
+		return result;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	if (ts->select_slave_reg) {
+		hw_addr = ts->slave_read_reg;
+		I("now addr=0x%02X!", hw_addr);
+	} else {
+		hw_addr = 0xF3;
+	}
+
+	memset(ts->xfer_data, 0, BUS_R_HLEN + len);
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	ts->xfer_data[2] = 0x00;
+	result = himax_spi_read(ts, ts->xfer_data, BUS_R_HLEN, buf, len);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+int himax_bus_write(struct himax_ts_data *ts, u8 cmd,
+		    u8 *addr, u8 *data, u32 len)
+{
+	int result = -1;
+	u8 offset = 0;
+	u32 tmp_len = len;
+	u8 hw_addr = 0x00;
+
+	if (len > BUS_W_DLEN) {
+		E("len[%d] is over %d", len, BUS_W_DLEN);
+		return -EFAULT;
+	}
+
+	mutex_lock(&ts->rw_lock);
+
+	if (ts->select_slave_reg) {
+		hw_addr = ts->slave_write_reg;
+		I("now addr=0x%02X!", hw_addr);
+	} else {
+		hw_addr = 0xF2;
+	}
+
+	ts->xfer_data[0] = hw_addr;
+	ts->xfer_data[1] = cmd;
+	offset = BUS_W_HLEN;
+
+	if (addr) {
+		memcpy(ts->xfer_data + offset, addr, 4);
+		offset += 4;
+		tmp_len -= 4;
+	}
+
+	if (data)
+		memcpy(ts->xfer_data + offset, data, tmp_len);
+
+	result = himax_spi_write(ts, ts->xfer_data, len + BUS_W_HLEN);
+
+	mutex_unlock(&ts->rw_lock);
+
+	return result;
+}
+
+void himax_int_enable(struct himax_ts_data *ts, int enable)
+{
+	unsigned long irqflags = 0;
+	int irqnum = ts->hx_irq;
+
+	spin_lock_irqsave(&ts->irq_lock, irqflags);
+	D("Entering! irqnum = %d", irqnum);
+	if (enable == 1 && atomic_read(&ts->irq_state) == 0) {
+		atomic_set(&ts->irq_state, 1);
+		enable_irq(irqnum);
+		ts->irq_enabled = 1;
+	} else if (enable == 0 && atomic_read(&ts->irq_state) == 1) {
+		atomic_set(&ts->irq_state, 0);
+		disable_irq_nosync(irqnum);
+		ts->irq_enabled = 0;
+	}
+
+	I("interrupt enable = %d", enable);
+	spin_unlock_irqrestore(&ts->irq_lock, irqflags);
+}
+
+static void himax_ts_isr_func(struct himax_ts_data *ts)
+{
+	himax_ts_work(ts);
+}
+
+irqreturn_t himax_ts_thread(int irq, void *ptr)
+{
+	himax_ts_isr_func((struct himax_ts_data *)ptr);
+
+	return IRQ_HANDLED;
+}
+
+static void himax_ts_work_func(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work,
+		struct himax_ts_data, work);
+
+	himax_ts_work(ts);
+}
+
+int himax_int_register_trigger(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	if (ts->ic_data->HX_INT_IS_EDGE) {
+		I("edge triiger falling");
+		ret = request_threaded_irq(ts->hx_irq, NULL, himax_ts_thread,
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			himax_dev_name, ts);
+	} else {
+		I("level trigger low");
+		ret = request_threaded_irq(ts->hx_irq, NULL, himax_ts_thread,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT, himax_dev_name, ts);
+	}
+
+	return ret;
+}
+
+int himax_ts_register_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	ts->irq_enabled = 0;
+
+	/* Work functon */
+	if (ts->hx_irq) {/*INT mode*/
+		ts->use_irq = 1;
+		ret = himax_int_register_trigger(ts);
+
+		if (ret == 0) {
+			ts->irq_enabled = 1;
+			atomic_set(&ts->irq_state, 1);
+			I("irq enabled at gpio: %d",
+			  ts->hx_irq);
+		} else {
+			ts->use_irq = 0;
+			E("request_irq failed");
+		}
+	} else {
+		I("ts->hx_irq is empty, use polling mode.");
+	}
+
+	/*if use polling mode need to disable HX_ESD_RECOVERY function*/
+	if (!ts->use_irq) {
+		ts->himax_wq = create_singlethread_workqueue("himax_touch");
+		INIT_WORK(&ts->work, himax_ts_work_func);
+		hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		ts->timer.function = himax_ts_timer_func;
+		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
+		I("polling mode enabled");
+	}
+
+	return ret;
+}
+
+int himax_ts_unregister_interrupt(struct himax_ts_data *ts)
+{
+	int ret = 0;
+
+	I("entered.");
+
+	/* Work functon */
+	if (ts->hx_irq && ts->use_irq) {/*INT mode*/
+		free_irq(ts->hx_irq, ts);
+		I("irq disabled at qpio: %d",
+		  ts->hx_irq);
+	}
+
+	/*if use polling mode need to disable HX_ESD_RECOVERY function*/
+	if (!ts->use_irq) {
+		hrtimer_cancel(&ts->timer);
+		cancel_work_sync(&ts->work);
+		if (ts->himax_wq)
+			destroy_workqueue(ts->himax_wq);
+		I("polling mode destroyed");
+	}
+
+	return ret;
+}
+
+#if defined(CONFIG_FB)
+int fb_notifier_callback(struct notifier_block *self,
+			 unsigned long event, void *data)
+{
+	const struct fb_event *evdata = data;
+	int *blank;
+	struct himax_ts_data *ts =
+	    container_of(self, struct himax_ts_data, fb_notif);
+
+	I("entered");
+
+	if (!ts) {
+		E("ts is NULL");
+		return -ECANCELED;
+	}
+
+	if (!ts->ic_boot_done) {
+		E("IC is booting");
+		return -ECANCELED;
+	}
+
+	if (evdata && evdata->data &&
+	    event == FB_EVENT_BLANK &&
+		ts->dev) {
+		blank = evdata->data;
+
+		switch (*blank) {
+		case FB_BLANK_UNBLANK:
+			himax_resume(ts->dev);
+			break;
+
+		case FB_BLANK_POWERDOWN:
+		case FB_BLANK_HSYNC_SUSPEND:
+		case FB_BLANK_VSYNC_SUSPEND:
+		case FB_BLANK_NORMAL:
+			himax_suspend(ts->dev);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+void himax_fb_register(struct work_struct *work)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_att.work);
+
+	ts->fb_notif.notifier_call = fb_notifier_callback;
+	ret = fb_register_client(&ts->fb_notif);
+
+	if (ret)
+		E("Unable to register fb_notifier: %d", ret);
+}
+#endif
+
+void hx_check_power_status(struct work_struct *work)
+{
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_pwr.work);
+
+	ts->latest_power_status = power_supply_is_system_supplied();
+
+	I("Update ts->latest_power_status = %X", ts->latest_power_status);
+
+	himax_cable_detect_func(ts, true);
+}
+
+int pwr_notifier_callback(struct notifier_block *self,
+			  unsigned long event, void *data)
+{
+	struct himax_ts_data *ts = container_of(self, struct himax_ts_data,
+		power_notif);
+	I("entered. event = %lX", event);
+
+	cancel_delayed_work_sync(&ts->work_pwr);
+	queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+			   msecs_to_jiffies(1100));
+
+	return 0;
+}
+
+void himax_pwr_register(struct work_struct *work)
+{
+	int ret = 0;
+	struct himax_ts_data *ts = container_of(work, struct himax_ts_data,
+			work_pwr.work);
+
+	ts->power_notif.notifier_call = pwr_notifier_callback;
+	ret = power_supply_reg_notifier(&ts->power_notif);
+	if (ret) {
+		E("Unable to register power_notif: %d", ret);
+	} else {
+		INIT_DELAYED_WORK(&ts->work_pwr, hx_check_power_status);
+		queue_delayed_work(ts->himax_pwr_wq, &ts->work_pwr,
+				   msecs_to_jiffies(3000));
+	}
+}
diff --git a/drivers/hid/hx-hid/hx_plat.h b/drivers/hid/hx-hid/hx_plat.h
new file mode 100644
index 000000000000..12f473a08d3b
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_plat.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HX_PLAT_H__
+#define __HX_PLAT_H__
+
+#include "hx_core.h"
+#include <linux/notifier.h>
+#include <linux/power_supply.h>
+
+#if defined(CONFIG_FB)
+int fb_notifier_callback(struct notifier_block *self,
+			 unsigned long event, void *data);
+void himax_fb_register(struct work_struct *work);
+#endif
+
+void himax_pwr_register(struct work_struct *work);
+
+int himax_gpio_power_config(struct himax_ts_data *ts,
+			    struct himax_platform_data *pdata);
+void himax_gpio_power_deconfig(struct himax_platform_data *pdata);
+int himax_bus_read(struct himax_ts_data *ts, u8 cmd, u8 *buf,
+		   u32 len);
+int himax_bus_write(struct himax_ts_data *ts, u8 cmd, u8 *addr,
+		    u8 *data, u32 len);
+void himax_int_enable(struct himax_ts_data *ts, int enable);
+int himax_int_register_trigger(struct himax_ts_data *ts);
+int himax_int_en_set(void);
+int himax_ts_register_interrupt(struct himax_ts_data *ts);
+int himax_ts_unregister_interrupt(struct himax_ts_data *ts);
+
+#endif
-- 
2.25.1

