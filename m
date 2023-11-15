Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477677E034B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbjKCNC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKCNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:02:26 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 06:02:19 PDT
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7E419D;
        Fri,  3 Nov 2023 06:02:19 -0700 (PDT)
Received: from MTA-12-4.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id DDF7F600D9;
        Fri,  3 Nov 2023 08:52:26 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 7DA8E18000AE;
        Fri,  3 Nov 2023 08:52:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=carlosaurelio.net;
        s=default; t=1699015944;
        bh=WBL1JGYq17psm955p8hEgdrhaDsBlcvQx7w6ZPmSUP0=;
        h=From:To:Cc:Subject:Date:From;
        b=ArwXwC/QUGjX6PM7lgV3cPU/qI38Q537setsVgWRhSRIXV+cn0ZrOTLS0zPX/XXcS
         TTolLrJayhEptdvgSXLXCqSDMl74ged0ALCBEYR/xbEtg6zWYegvssrsOSWEOIY8lS
         hTPlpSP4KFsDnu42WTN6xCBbXBUy1TAhre3b9JhtJr5P6KVTY1gLlIZsbxhBCW/gjp
         B4Cj0XvqrpmdLEmdN83og4tkS4pfuefK7X+Jr3jUz/kI5bqJmFHuhBwkGrUymxE788
         DVcTWhBw7MeLrmqsDbvy33pcUqmSxJfbZvRzOU2DWSVvcYrIqY4zkum5LQSySEoybQ
         7kench3BCgxMg==
Received: from GB2-C0476.gertec.local (unknown [187.11.35.108])
        by mta-12.privateemail.com (Postfix) with ESMTPA;
        Fri,  3 Nov 2023 08:52:09 -0400 (EDT)
From:   Carlos Menin <menin@carlosaurelio.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Carlos Menin <menin@carlosaurelio.net>,
        Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v2 1/2] rtc: add pcf85053a
Date:   Fri,  3 Nov 2023 09:51:05 -0300
Message-Id: <20231103125106.78220-1-menin@carlosaurelio.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NXP's PCF85053A RTC chip.

Signed-off-by: Carlos Menin <menin@carlosaurelio.net>
Reviewed-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 drivers/rtc/Kconfig         |   9 +
 drivers/rtc/Makefile        |   1 +
 drivers/rtc/rtc-pcf85053a.c | 689 ++++++++++++++++++++++++++++++++++++
 3 files changed, 699 insertions(+)
 create mode 100644 drivers/rtc/rtc-pcf85053a.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3814e0845e77..ab33940070d1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -460,6 +460,15 @@ config RTC_DRV_PCF8523
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8523.
 
+config RTC_DRV_PCF85053A
+	tristate "NXP PCF85053A"
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the PCF85053A RTC chip
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf85053a.
+
 config RTC_DRV_PCF85063
 	tristate "NXP PCF85063"
 	select REGMAP_I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 7b03c3abfd78..3f3a1ab8acb0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -122,6 +122,7 @@ obj-$(CONFIG_RTC_DRV_PCAP)	+= rtc-pcap.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+= rtc-pcf2123.o
 obj-$(CONFIG_RTC_DRV_PCF2127)	+= rtc-pcf2127.o
 obj-$(CONFIG_RTC_DRV_PCF50633)	+= rtc-pcf50633.o
+obj-$(CONFIG_RTC_DRV_PCF85053A)	+= rtc-pcf85053a.o
 obj-$(CONFIG_RTC_DRV_PCF85063)	+= rtc-pcf85063.o
 obj-$(CONFIG_RTC_DRV_PCF8523)	+= rtc-pcf8523.o
 obj-$(CONFIG_RTC_DRV_PCF85363)	+= rtc-pcf85363.o
diff --git a/drivers/rtc/rtc-pcf85053a.c b/drivers/rtc/rtc-pcf85053a.c
new file mode 100644
index 000000000000..0474d90ebe52
--- /dev/null
+++ b/drivers/rtc/rtc-pcf85053a.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/bcd.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/hwmon.h>
+
+#define ADDR_NVMEM	0x57
+
+#define REG_SECS	0x00
+#define REG_MINUTES	0x02
+#define REG_HOURS	0x04
+#define REG_WEEKDAYS	0x06
+#define REG_DAYS	0x07
+#define REG_MONTHS	0x08
+#define REG_YEARS	0x09
+
+#define REG_SECOND_ALM	0x01
+#define REG_MINUTE_ALM	0x03
+#define REG_HOUR_ALM	0x05
+
+#define REG_CTRL	0x0a
+#define REG_CTRL_ST	BIT(7)
+#define REG_CTRL_DM	BIT(6)
+#define REG_CTRL_HF	BIT(5)
+#define REG_CTRL_DSM	BIT(4)
+#define REG_CTRL_AIE	BIT(3)
+#define REG_CTRL_OFIE	BIT(2)
+#define REG_CTRL_CIE	BIT(1)
+#define REG_CTRL_TWO	BIT(0)
+
+#define REG_STATUS	0x0b
+#define REG_STATUS_AF	BIT(7)
+#define REG_STATUS_OF	BIT(6)
+#define REG_STATUS_RTCF	BIT(5)
+#define REG_STATUS_CIF	BIT(4)
+#define REG_STATUS_BVL	GENMASK(2, 0)
+
+#define REG_CLKOUT	0x0c
+#define REG_CLKOUT_CKE	BIT(7)
+#define REG_CLKOUT_CKD	GENMASK(1, 0)
+
+#define REG_CTRL2	0x0d
+#define REG_CTRL2_MWO	BIT(0)
+
+#define REG_SCRATCHPAD	0x0e
+
+#define REG_VERSION	0x0f
+#define REG_VENDOR	0x10
+#define REG_MODEL	0x11
+
+#define REG_OFFSET	0x12
+
+#define REG_OSCILLATOR	0x13
+#define REG_OSC_CLKIV	BIT(7)
+#define REG_OSC_OFFM	BIT(6)
+#define REG_OSC_LOWJ	BIT(4)
+#define REG_OSC_OSCD	GENMASK(3, 2)
+#define REG_OSC_CL	GENMASK(1, 0)
+
+#define REG_ACCESS	0x14
+#define REG_ACCESS_XCLK	BIT(7)
+
+#define REG_SEC_TS	0x15
+#define REG_MIN_TS	0x16
+#define REG_HOUR_TS	0x17
+#define REG_DAYWK_TS	0x18
+#define REG_DAYMON_TS	0x19
+#define REG_MON_TS	0x1a
+#define REG_YEAR_TS	0x1b
+
+#define REG_RCODE1	0x1c
+#define REG_RCODE2	0x1d
+
+#define OFFSET_STEP0	2170
+#define OFFSET_STEP1	2034
+
+struct pcf85053a {
+	struct rtc_device	*rtc;
+	struct regmap		*regmap;
+	struct regmap		*regmap_nvmem;
+};
+
+struct pcf85053a_config {
+	struct regmap_config regmap;
+	struct regmap_config regmap_nvmem;
+};
+
+static int pcf85053a_read_offset(struct device *dev, long *offset)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
+	long val;
+	u32 reg_offset, reg_oscillator;
+	int ret;
+
+	ret = regmap_read(pcf85053a->regmap, REG_OFFSET, &reg_offset);
+	if (ret)
+		return -EIO;
+
+	ret = regmap_read(pcf85053a->regmap, REG_OSCILLATOR, &reg_oscillator);
+	if (ret)
+		return -EIO;
+
+	val = sign_extend32(reg_offset, 7);
+
+	if (reg_oscillator & REG_OSC_OFFM)
+		*offset = val * OFFSET_STEP1;
+	else
+		*offset = val * OFFSET_STEP0;
+
+	return 0;
+}
+
+static int pcf85053a_set_offset(struct device *dev, long offset)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
+	s8 mode0, mode1, reg_offset;
+	unsigned int ret, error0, error1;
+
+	if (offset > OFFSET_STEP0 * 127)
+		return -ERANGE;
+	if (offset < OFFSET_STEP0 * -128)
+		return -ERANGE;
+
+	ret = regmap_set_bits(pcf85053a->regmap, REG_ACCESS, REG_ACCESS_XCLK);
+	if (ret)
+		return -EIO;
+
+	mode0 = DIV_ROUND_CLOSEST(offset, OFFSET_STEP0);
+	mode1 = DIV_ROUND_CLOSEST(offset, OFFSET_STEP1);
+
+	error0 = abs(offset - (mode0 * OFFSET_STEP0));
+	error1 = abs(offset - (mode1 * OFFSET_STEP1));
+	if (error0 < error1) {
+		reg_offset = mode0;
+		ret = regmap_clear_bits(pcf85053a->regmap, REG_OSCILLATOR,
+					REG_OSC_OFFM);
+	} else {
+		reg_offset = mode1;
+		ret = regmap_set_bits(pcf85053a->regmap, REG_OSCILLATOR,
+				      REG_OSC_OFFM);
+	}
+	if (ret)
+		return -EIO;
+
+	ret = regmap_write(pcf85053a->regmap, REG_OFFSET, reg_offset);
+
+	return ret;
+}
+
+static int pcf85053a_rtc_check_reliability(struct device *dev, u8 status_reg)
+{
+	int ret = 0;
+
+	if (status_reg & REG_STATUS_CIF) {
+		dev_warn(dev, "tamper detected,"
+			 " date/time is not reliable\n");
+		ret = -EINVAL;
+	}
+
+	if (status_reg & REG_STATUS_OF) {
+		dev_warn(dev, "oscillator fail detected,"
+			 " date/time is not reliable.\n");
+		ret = -EINVAL;
+	}
+
+	if (status_reg & REG_STATUS_RTCF) {
+		dev_warn(dev, "power loss detected,"
+			 " date/time is not reliable.\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int pcf85053a_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
+	u8 buf[REG_STATUS + 1];
+	int ret, len = sizeof(buf);
+
+	ret = regmap_bulk_read(pcf85053a->regmap, REG_SECS, buf, len);
+	if (ret) {
+		dev_err(dev, "%s: error %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = pcf85053a_rtc_check_reliability(dev, buf[REG_STATUS]);
+	if (ret)
+		return ret;
+
+	tm->tm_year = buf[REG_YEARS];
+	/* adjust for 1900 base of rtc_time */
+	tm->tm_year += 100;
+
+	tm->tm_wday = (buf[REG_WEEKDAYS] - 1) & 7; /* 1 - 7 */
+	tm->tm_sec = buf[REG_SECS];
+	tm->tm_min = buf[REG_MINUTES];
+	tm->tm_hour = buf[REG_HOURS];
+	tm->tm_mday = buf[REG_DAYS];
+	tm->tm_mon = buf[REG_MONTHS] - 1; /* 1 - 12 */
+
+	return 0;
+}
+
+static int pcf85053a_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	int ret;
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
+	struct reg_sequence regs[] = {
+		REG_SEQ0(REG_SECS, tm->tm_sec),
+		REG_SEQ0(REG_MINUTES, tm->tm_min),
+		REG_SEQ0(REG_HOURS, tm->tm_hour),
+		REG_SEQ0(REG_WEEKDAYS, (tm->tm_wday + 1) & 0x7), /* 1 - 7 */
+		REG_SEQ0(REG_DAYS, tm->tm_mday),
+		REG_SEQ0(REG_MONTHS, tm->tm_mon + 1), /* 1 - 12 */
+		REG_SEQ0(REG_YEARS, tm->tm_year % 100),
+	};
+
+	/* tamper event will clear this bit */
+	ret = regmap_set_bits(pcf85053a->regmap, REG_CTRL, REG_CTRL_TWO);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(pcf85053a->regmap, REG_CTRL, REG_CTRL_ST);
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(pcf85053a->regmap, regs, ARRAY_SIZE(regs));
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(pcf85053a->regmap, REG_CTRL, REG_CTRL_ST);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(pcf85053a->regmap, REG_STATUS, REG_STATUS_OF);
+
+	return ret;
+}
+
+static int pcf85053a_bvl_to_mv(unsigned int bvl)
+{
+	long mv_table[] = {
+		1700,
+		1900,
+		2100,
+		2300,
+		2500,
+		2700,
+		2900,
+		3100,
+	};
+	return mv_table[bvl & 7];
+}
+
+static int pcf85053a_hwmon_read_in(struct device *dev, long *mV)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(pcf85053a->regmap, REG_STATUS, &status);
+	if (ret)
+		return ret;
+
+	*mV = pcf85053a_bvl_to_mv(status & REG_STATUS_BVL);
+	return 0;
+}
+
+static umode_t pcf85053a_hwmon_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	if (type != hwmon_in)
+		return 0;
+
+	switch (attr) {
+	case hwmon_in_input:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int pcf85053a_hwmon_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *val)
+{
+	int ret;
+
+	switch (attr) {
+	case hwmon_in_input:
+		ret = pcf85053a_hwmon_read_in(dev, val);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static u32 pcf85053a_hwmon_in_config[] = {
+	HWMON_I_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info pcf85053a_hwmon_in = {
+	.type = hwmon_in,
+	.config = pcf85053a_hwmon_in_config,
+};
+
+static const struct hwmon_channel_info *pcf85053a_hwmon_info[] = {
+	&pcf85053a_hwmon_in,
+	0
+};
+
+static const struct hwmon_ops pcf85053a_hwmon_ops = {
+	.is_visible = pcf85053a_hwmon_is_visible,
+	.read = pcf85053a_hwmon_read,
+};
+
+static const struct hwmon_chip_info pcf85053a_hwmon_chip_info = {
+	.ops = &pcf85053a_hwmon_ops,
+	.info = pcf85053a_hwmon_info,
+};
+
+static int pcf85053a_hwmon_register(struct device *dev, const char *name)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev);
+	struct device *hwmon_dev;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, name, pcf85053a,
+							 &pcf85053a_hwmon_chip_info,
+							 0);
+	if (IS_ERR(hwmon_dev)) {
+		dev_err(dev, "unable to register hwmon device: %ld\n",
+			PTR_ERR(hwmon_dev));
+		return PTR_ERR(hwmon_dev);
+	}
+
+	return 0;
+}
+
+static int pcf85053a_nvmem_read(void *priv, unsigned int offset, void *val,
+				size_t num)
+{
+	int ret;
+	struct pcf85053a *pcf85053a = priv;
+	struct regmap *regmap_nvmem = pcf85053a->regmap_nvmem;
+
+	ret = regmap_bulk_read(regmap_nvmem, offset, val, num);
+	if (ret)
+		pr_warn("%s: failed to read nvmem: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int pcf85053a_nvmem_write(void *priv, unsigned int offset, void *val,
+				 size_t num)
+{
+	int ret;
+	struct pcf85053a *pcf85053a = priv;
+	struct regmap *regmap_nvmem = pcf85053a->regmap_nvmem;
+
+	/* tamper event will clear this bit */
+	ret = regmap_set_bits(pcf85053a->regmap, REG_CTRL2, REG_CTRL2_MWO);
+	if (ret) {
+		pr_warn("%s: failed to enable nvmem write: %d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_write(regmap_nvmem, offset, val, num);
+	if (ret)
+		pr_warn("%s: failed to write nvmem: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static ssize_t attr_flag_clear(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count,
+			       u8 reg, u8 flag)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev->parent);
+	int ret;
+
+	(void)attr;
+	(void)buf;
+	(void)count;
+
+	ret = regmap_clear_bits(pcf85053a->regmap, reg, flag);
+	if (ret)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t attr_flag_read(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf,
+			      u8 reg, u8 flag)
+{
+	struct pcf85053a *pcf85053a = dev_get_drvdata(dev->parent);
+	unsigned int status, val;
+	int ret;
+
+	(void)attr;
+	ret = regmap_read(pcf85053a->regmap, reg, &status);
+	if (ret)
+		return -EIO;
+
+	val = (status & flag) != 0;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+/* flags that can be read or written to be cleared */
+#define PCF85053A_ATTR_FLAG_RWC(name, reg, flag)                                \
+	static ssize_t name ## _store(                                         \
+			struct device *dev,                                    \
+			struct device_attribute *attr,                         \
+			const char *buf,                                       \
+			size_t count)                                          \
+	{                                                                      \
+		return attr_flag_clear(dev, attr, buf, count,                  \
+				REG_ ## reg, REG_ ## reg ## _ ## flag);        \
+	}                                                                      \
+	static ssize_t name ## _show(                                          \
+			struct device *dev,                                    \
+			struct device_attribute *attr,                         \
+			char *buf)                                             \
+	{                                                                      \
+		return attr_flag_read(dev, attr, buf,                          \
+				REG_ ## reg, REG_ ## reg ## _ ## flag);        \
+	}                                                                      \
+	static DEVICE_ATTR_RW(name)
+
+PCF85053A_ATTR_FLAG_RWC(rtc_fail, STATUS, RTCF);
+PCF85053A_ATTR_FLAG_RWC(oscillator_fail, STATUS, OF);
+PCF85053A_ATTR_FLAG_RWC(rtc_clear, STATUS, CIF);
+
+static struct attribute *pcf85053a_attrs_flags[] = {
+	&dev_attr_rtc_fail.attr,
+	&dev_attr_oscillator_fail.attr,
+	&dev_attr_rtc_clear.attr,
+	0,
+};
+
+static const struct attribute_group pcf85053a_attr_group = {
+	.name = "flags",
+	.attrs = pcf85053a_attrs_flags,
+};
+
+static const struct rtc_class_ops pcf85053a_rtc_ops = {
+	.read_offset		= pcf85053a_read_offset,
+	.set_offset		= pcf85053a_set_offset,
+	.read_time		= pcf85053a_rtc_read_time,
+	.set_time		= pcf85053a_rtc_set_time,
+};
+
+static const struct pcf85053a_config pcf85053a_config = {
+	.regmap = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0x1d,
+	},
+	.regmap_nvmem = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0xff,
+	},
+};
+
+static int pcf85053a_add_nvmem(struct i2c_client *client,
+			       struct pcf85053a *pcf85053a)
+{
+	int ret;
+	const struct pcf85053a_config *config = &pcf85053a_config;
+	struct i2c_client *client_nvmem;
+	struct nvmem_config nvmem_cfg = {
+		.name = "pcf85053a_nvmem",
+		.reg_read = pcf85053a_nvmem_read,
+		.reg_write = pcf85053a_nvmem_write,
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.size = 128,
+	};
+
+	client_nvmem = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						 ADDR_NVMEM);
+	if (IS_ERR(client_nvmem)) {
+		dev_warn(&client->dev, "failed to create nvmem i2c device\n");
+		return -ENODEV;
+	}
+
+	pcf85053a->regmap_nvmem = devm_regmap_init_i2c(client_nvmem,
+						       &config->regmap_nvmem);
+	if (IS_ERR(pcf85053a->regmap_nvmem)) {
+		dev_warn(&client->dev, "failed to init nvmem regmap\n");
+		return -EIO;
+	}
+
+	nvmem_cfg.priv = pcf85053a;
+	ret = devm_rtc_nvmem_register(pcf85053a->rtc, &nvmem_cfg);
+
+	return ret;
+}
+
+static void pcf85053a_set_load_capacitance(struct device *dev, u8 *reg_ctrl)
+{
+	int ret;
+	u32 val;
+	u8 regval;
+
+	ret = of_property_read_u32(dev->of_node, "quartz-load-femtofarads",
+				   &val);
+	if (ret) {
+		dev_warn(dev, "failed to read quartz-load-femtofarads property,"
+			 " assuming 12500");
+		val = 12500;
+	}
+
+	switch (val) {
+	case 7000:
+		regval = 0;
+		break;
+	case 6000:
+		regval = 1;
+		break;
+	default:
+		dev_warn(dev, "invalid quartz-load-femtofarads value: %u,"
+			 " assuming 12500", val);
+		fallthrough;
+	case 12500:
+		regval = 2;
+		break;
+	}
+
+	*reg_ctrl |= regval;
+}
+
+static void pcf85053a_set_drive_control(struct device *dev, u8 *reg_ctrl)
+{
+	int ret;
+	const char *val;
+	u8 regval;
+
+	ret = of_property_read_string(dev->of_node, "nxp,quartz-drive-control",
+				      &val);
+	if (ret) {
+		dev_warn(dev, "failed to read nxp,quartz-drive-control property,"
+			 " assuming 'normal' drive");
+		val = "normal";
+	}
+
+	if (!strcmp(val, "normal")) {
+		regval = 0;
+	} else if (!strcmp(val, "low")) {
+		regval = 1;
+	} else if (!strcmp(val, "high")) {
+		regval = 2;
+	} else {
+		dev_warn(dev, "invalid nxp,quartz-drive-control value: %s,"
+			 " assuming 'normal' drive", val);
+		regval = 0;
+	}
+
+	*reg_ctrl |= (regval << 2);
+}
+
+static void pcf85053a_set_low_jitter(struct device *dev, u8 *reg_ctrl)
+{
+	bool val;
+	u8 regval;
+
+	val = of_property_read_bool(dev->of_node, "nxp,low-jitter-mode");
+
+	regval = val ? 1 : 0;
+	*reg_ctrl |= (regval << 4);
+}
+
+static void pcf85053a_set_clk_inverted(struct device *dev, u8 *reg_ctrl)
+{
+	bool val;
+	u8 regval;
+
+	val = of_property_read_bool(dev->of_node, "nxp,clk-inverted");
+
+	regval = val ? 1 : 0;
+	*reg_ctrl |= (regval << 7);
+}
+
+static int pcf85053a_probe(struct i2c_client *client)
+{
+	int ret;
+	struct pcf85053a *pcf85053a;
+	const struct pcf85053a_config *config = &pcf85053a_config;
+	u8 reg_ctrl;
+
+	pcf85053a = devm_kzalloc(&client->dev, sizeof(*pcf85053a), GFP_KERNEL);
+	if (!pcf85053a) {
+		dev_err(&client->dev, "failed to allocate device: no memory");
+		return -ENOMEM;
+	}
+
+	pcf85053a->regmap = devm_regmap_init_i2c(client, &config->regmap);
+	if (IS_ERR(pcf85053a->regmap)) {
+		dev_err(&client->dev, "failed to allocate regmap: %ld\n",
+			PTR_ERR(pcf85053a->regmap));
+		return PTR_ERR(pcf85053a->regmap);
+	}
+
+	i2c_set_clientdata(client, pcf85053a);
+
+	pcf85053a->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(pcf85053a->rtc)) {
+		dev_err(&client->dev, "failed to allocate rtc: %ld\n",
+			PTR_ERR(pcf85053a->rtc));
+		return PTR_ERR(pcf85053a->rtc);
+	}
+
+	pcf85053a->rtc->ops = &pcf85053a_rtc_ops;
+	pcf85053a->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	pcf85053a->rtc->range_max = RTC_TIMESTAMP_END_2099;
+
+	reg_ctrl = REG_CTRL_DM | REG_CTRL_HF | REG_CTRL_CIE;
+	pcf85053a_set_load_capacitance(&client->dev, &reg_ctrl);
+	pcf85053a_set_drive_control(&client->dev, &reg_ctrl);
+	pcf85053a_set_low_jitter(&client->dev, &reg_ctrl);
+	pcf85053a_set_clk_inverted(&client->dev, &reg_ctrl);
+
+	ret = regmap_write(pcf85053a->regmap, REG_CTRL, reg_ctrl);
+	if (ret) {
+		dev_err(&client->dev, "failed to configure rtc: %d\n", ret);
+		return ret;
+	}
+
+	ret = rtc_add_group(pcf85053a->rtc, &pcf85053a_attr_group);
+	if (ret) {
+		dev_err(&client->dev, "failed to add sysfs entry: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_rtc_register_device(pcf85053a->rtc);
+	if (ret) {
+		dev_err(&client->dev, "failed to register rtc: %d\n", ret);
+		return ret;
+	}
+
+	ret = pcf85053a_add_nvmem(client, pcf85053a);
+	if (ret) {
+		dev_err(&client->dev, "failed to register nvmem: %d\n", ret);
+		return ret;
+	}
+
+	ret = pcf85053a_hwmon_register(&client->dev, client->name);
+	if (ret)
+		dev_err(&client->dev, "failed to register hwmon: %d\n", ret);
+
+	return ret;
+}
+
+static const __maybe_unused struct of_device_id dev_ids[] = {
+	{ .compatible = "nxp,pcf85053a", .data = &pcf85053a_config },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dev_ids);
+
+static struct i2c_driver pcf85053a_driver = {
+	.driver = {
+		.name = "pcf85053a",
+		.of_match_table = of_match_ptr(dev_ids),
+	},
+	.probe_new = &pcf85053a_probe,
+};
+
+module_i2c_driver(pcf85053a_driver);
+
+MODULE_AUTHOR("Carlos Menin <menin@carlosaurelio.net>");
+MODULE_DESCRIPTION("PCF85053A I2C RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

