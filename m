Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC67CBEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjJQJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjJQJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:19:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D74FE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27cfb84432aso3543013a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=himax-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1697534358; x=1698139158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE2KMBHyui9ZW4TpLNbrRCx9Maze02CGTTvrcnFy4KU=;
        b=U+Lv6JXss2ME2kqv9j/yVHTFJuLPKTcUox1jRhsLHsYaw+byZaxQRv75y/ae23SYKO
         YjK7MfUPrarFwE02F4RRXJJfLBGW5aFbFOSLGaZHTY3TEuhK32XoUhn0aFVYSmi2hTQq
         glwZKm0KHdl2uijPYVerZBzFoGf0VgpAdom2tDRrjeK4W4c0IHM9iKUGpZ4DvNbz+0sT
         BTH5pSdv+nlXzjlyCR1seO/CQ+vuHDdcNRvgvWKHInkPZ208/qmFJTKtvy6k/rx5WXo/
         2yF+SgpEN10gZiOM+Xrkmt22wNZpcsv1YFUyRIDWafA0srx+5fwj0f/8BI8RDtIvzEuz
         cCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534358; x=1698139158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE2KMBHyui9ZW4TpLNbrRCx9Maze02CGTTvrcnFy4KU=;
        b=u/H9Sq63JhsVxadDgQgc+aS+orlHMw6/z3s0I/ZvTZWQzTPRhx0zHNdKYemTNbBCms
         IVzian5r/pNtk1ei5C47m6LwzgKSXTxEXjiWESv3Jwqy1qVbe/j8rEt8T6f02PTb8gOX
         sJ7OTeZlLiHivdRB76LBvzAk05ZMs82Fo3pIbkx/LU/DOY4YWIT9zqnT6L/aSXWZgGwu
         /ilcBPMLAk8F0yP5FP4iYVpHhuZHaw0+HNFt14+JsNnTk+OdMNWCeSXcxqszvlucWC42
         LqrF3vUv9kT9kfOXPF0cCRftVeTOQlB3BKiggQ92mCBZbLSwblnd3iq5AMKmt1ifMkCr
         P72g==
X-Gm-Message-State: AOJu0Yx4nmJmE3DlC72lyu98Ls7aRML/jXcrjupqBqm7gdi49OqFAT27
        bcy3vyPv1LEMYc69j+WacDnGpHx5HAbFL6Zwhk/47Q==
X-Google-Smtp-Source: AGHT+IEAvah8skLtUO7sXJQ6B92MsgD+cdEGVgAjB1nVQlRZ90sfPSO/bJENoha0yKUBePguzhIhSw==
X-Received: by 2002:a17:90a:3049:b0:27d:e5d:33bf with SMTP id q9-20020a17090a304900b0027d0e5d33bfmr1404025pjl.15.1697534357262;
        Tue, 17 Oct 2023 02:19:17 -0700 (PDT)
Received: from tylor-mini-server.net ([101.9.190.154])
        by smtp.gmail.com with ESMTPSA id pl17-20020a17090b269100b00274de7c8aacsm6003963pjb.45.2023.10.17.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:19:16 -0700 (PDT)
From:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: [PATCH v3 2/4] HID: touchscreen: Add initial support for Himax HID-over-SPI
Date:   Tue, 17 Oct 2023 17:18:58 +0800
Message-Id: <20231017091900.801989-3-tylor_yang@himax.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Due to patch size is too big, separate into 3 part. This is part 1.

Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
---
 MAINTAINERS                       |    1 +
 drivers/hid/hx-hid/hx_acpi.c      |   81 ++
 drivers/hid/hx-hid/hx_core.c      | 1605 +++++++++++++++++++++++++++++
 drivers/hid/hx-hid/hx_core.h      |  489 +++++++++
 drivers/hid/hx-hid/hx_hid.c       |  753 ++++++++++++++
 drivers/hid/hx-hid/hx_hid.h       |   96 ++
 drivers/hid/hx-hid/hx_ic_83102j.c |  340 ++++++
 drivers/hid/hx-hid/hx_ic_83102j.h |   42 +
 8 files changed, 3407 insertions(+)
 create mode 100644 drivers/hid/hx-hid/hx_acpi.c
 create mode 100644 drivers/hid/hx-hid/hx_core.c
 create mode 100644 drivers/hid/hx-hid/hx_core.h
 create mode 100644 drivers/hid/hx-hid/hx_hid.c
 create mode 100644 drivers/hid/hx-hid/hx_hid.h
 create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.c
 create mode 100644 drivers/hid/hx-hid/hx_ic_83102j.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 883870ab316f..95ea8159eced 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9345,6 +9345,7 @@ M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
 L:	linux-input@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/input/himax,hid.yaml
+F:	drivers/hid/hx-hid/
 
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
diff --git a/drivers/hid/hx-hid/hx_acpi.c b/drivers/hid/hx-hid/hx_acpi.c
new file mode 100644
index 000000000000..2dc7c611a61a
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_acpi.c
@@ -0,0 +1,81 @@
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
+	const char *interrupt_pin_dsd_name = "irq"; // to name "irq-gpios"
+	const char *reset_pin_dsd_name = "reset"; // to name "reset-gpios"
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
+	I("[ACPI]irq gpio %d, reset gpio %d",
+	  pdata->gpio_irq, pdata->gpio_reset);
+
+END:
+	return ret;
+}
diff --git a/drivers/hid/hx-hid/hx_core.c b/drivers/hid/hx-hid/hx_core.c
new file mode 100644
index 000000000000..071f723c6c28
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_core.c
@@ -0,0 +1,1605 @@
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
+		himax_boot_upgrade(&ts->work_boot_upgrade.work);
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
+	int ret = 0;
+
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
+	if (ts->pdata) {
+		if (ts->pdata->power_off_3v3) {
+			if (ts->pdata->vcca_supply)
+				ret = regulator_disable(ts->pdata->vcca_supply);
+		}
+	}
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
+	if (ts->pdata) {
+		if (ts->pdata->power_off_3v3) {
+			if (ts->pdata->vcca_supply)
+				ret = regulator_enable(ts->pdata->vcca_supply);
+		}
+	}
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
+	{ .compatible = "himax,hid" },
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
+	pdata->ts = ts;
+	ts->rst_gpio = pdata->gpio_reset;
+
+	if (himax_gpio_power_config(ts, pdata) < 0) {
+		E("gpio config fail, exit!");
+		goto err_power_config_failed;
+	}
+
+	I("Completed.");
+
+	return true;
+
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
+	pdata.ts = ts;
+	ts->dev = &spi->dev;
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
+	ts->ic_data->has_flash = !pdata.is_zf;
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
index 000000000000..d2775b3f6c84
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_core.h
@@ -0,0 +1,489 @@
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
+#include <linux/of_irq.h>
+#include <linux/proc_fs.h>
+#include <linux/version.h>
+#include <linux/firmware.h>
+#include <linux/acpi.h>
+#include <linux/stddef.h>
+#include "hx_hid.h"
+
+#define HIMAX_DRIVER_VER "1.0.0"
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
+	struct himax_ts_data *ts;
+	u16 pid;
+	bool power_off_3v3;
+	u8 cable_config[2];
+	int gpio_irq;
+	int of_irq;
+	int gpio_reset;
+	int ic_det_delay;
+	int ic_resume_delay;
+	int panel_id;
+	bool is_zf;
+	struct regulator *vccd_supply;
+	struct regulator *vcca_supply;
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
+		u8 heatmap_info_desc[29];
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
+#define HEAT_MAP_HID_HDR_SZ (12)
+#define HEAT_MAP_DATA_HDR_SZ (8)
+#define HEAT_MAP_INFO_SZ (HEAT_MAP_HID_HDR_SZ + HEAT_MAP_DATA_HDR_SZ)
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
index 000000000000..f48499988457
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_hid.c
@@ -0,0 +1,753 @@
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
+		0x09, 0x6B,// Usage (0x6B)
+		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
+		0x27, 0xFF, 0xFF, 0xFF, 0xFF,// Logical Maximum (-1)
+		0x75, 0x20,// Report Size (32)
+		0x09, 0x56,// Usage (0x56)
+		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
+		0x05, 0x01,// Usage Page (Generic Desktop)
+		0x09, 0x3B,// Usage (0x3B)
+		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
+		0x05, 0x0D,// Usage Page (Digitizers)
+		0x26, 0xFF, 0x00,// Logical Maximum (255)
+		0x09, 0x6C,// Usage (0x6C)
+		0x75, 0x08,// Report Size (8)
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
index 000000000000..09c6d84f21c8
--- /dev/null
+++ b/drivers/hid/hx-hid/hx_ic_83102j.c
@@ -0,0 +1,340 @@
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
-- 
2.25.1

