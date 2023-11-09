Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200AC7E67A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjKIKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjKIKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:16:26 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F4030DF;
        Thu,  9 Nov 2023 02:15:52 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A98R7U2007110;
        Thu, 9 Nov 2023 05:15:19 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3u7w2dfwhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:15:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3A9AFHAY044090
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Nov 2023 05:15:17 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Nov 2023 05:15:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Nov 2023 05:15:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 9 Nov 2023 05:15:16 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.183])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3A9AEtGT016623;
        Thu, 9 Nov 2023 05:15:10 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jean Delvare" <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH v7 2/2] rtc: max31335: add driver support
Date:   Thu, 9 Nov 2023 12:14:37 +0200
Message-ID: <20231109101449.8347-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109101449.8347-1-antoniu.miclaus@analog.com>
References: <20231109101449.8347-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: y6N--sLZGcCjvnJjIbV5GJ5hRPvJKqfL
X-Proofpoint-ORIG-GUID: y6N--sLZGcCjvnJjIbV5GJ5hRPvJKqfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_08,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311090078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC driver for MAX31335 ±2ppm Automotive Real-Time Clock with
Integrated MEMS Resonator.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - add `depends on COMMON_CLK` in Kconfig.
 MAINTAINERS                |   8 +
 drivers/rtc/Kconfig        |  13 +
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-max31335.c | 706 +++++++++++++++++++++++++++++++++++++
 4 files changed, 728 insertions(+)
 create mode 100644 drivers/rtc/rtc-max31335.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..bc484cb997ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12823,6 +12823,14 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
 F:	Documentation/hwmon/max31827.rst
 F:	drivers/hwmon/max31827.c
 
+MAX31335 RTC DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-rtc@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/rtc/adi,max31335.yaml
+F:	drivers/rtc/rtc-max31335.c
+
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 L:	linux-hwmon@vger.kernel.org
 S:	Orphan
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d7502433c78a..c8bfd74e5fa4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -373,6 +373,19 @@ config RTC_DRV_MAX8997
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max8997.
 
+config RTC_DRV_MAX31335
+	tristate "Analog Devices MAX31335"
+	depends on I2C
+	depends on COMMON_CLK
+	depends on HWMON || HWMON=n
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Analog Devices
+	  MAX31335.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-max31335.
+
 config RTC_DRV_MAX77686
 	tristate "Maxim MAX77686"
 	depends on MFD_MAX77686 || MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fd209883ee2e..99e683a48240 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
 obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
 obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
+obj-$(CONFIG_RTC_DRV_MAX31335)	+= rtc-max31335.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
 obj-$(CONFIG_RTC_DRV_MAX6916)	+= rtc-max6916.o
diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
new file mode 100644
index 000000000000..75e3266360a3
--- /dev/null
+++ b/drivers/rtc/rtc-max31335.c
@@ -0,0 +1,706 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC driver for the MAX31335
+ *
+ * Copyright (C) 2023 Analog Devices
+ *
+ * Antoniu Miclaus <antoniu.miclaus@analog.com>
+ *
+ */
+
+#include <asm-generic/unaligned.h>
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/util_macros.h>
+
+/* MAX31335 Register Map */
+#define MAX31335_STATUS1			0x00
+#define MAX31335_INT_EN1			0x01
+#define MAX31335_STATUS2			0x02
+#define MAX31335_INT_EN2			0x03
+#define MAX31335_RTC_RESET			0x04
+#define MAX31335_RTC_CONFIG			0x05
+#define MAX31335_RTC_CONFIG2			0x06
+#define MAX31335_TIMESTAMP_CONFIG		0x07
+#define MAX31335_TIMER_CONFIG			0x08
+#define MAX31335_SECONDS_1_128			0x09
+#define MAX31335_SECONDS			0x0A
+#define MAX31335_MINUTES			0x0B
+#define MAX31335_HOURS				0x0C
+#define MAX31335_DAY				0x0D
+#define MAX31335_DATE				0x0E
+#define MAX31335_MONTH				0x0F
+#define MAX31335_YEAR				0x0F
+#define MAX31335_ALM1_SEC			0x11
+#define MAX31335_ALM1_MIN			0x12
+#define MAX31335_ALM1_HRS			0x13
+#define MAX31335_ALM1_DAY_DATE			0x14
+#define MAX31335_ALM1_MON			0x15
+#define MAX31335_ALM1_YEAR			0x16
+#define MAX31335_ALM2_MIN			0x17
+#define MAX31335_ALM2_HRS			0x18
+#define MAX31335_ALM2_DAY_DATE			0x19
+#define MAX31335_TIMER_COUNT			0x1A
+#define MAX31335_TIMER_INIT			0x1B
+#define MAX31335_PWR_MGMT			0x1C
+#define MAX31335_TRICKLE_REG			0x1D
+#define MAX31335_AGING_OFFSET			0x1E
+#define MAX31335_TS_CONFIG			0x30
+#define MAX31335_TEMP_ALARM_HIGH_MSB		0x31
+#define MAX31335_TEMP_ALARM_HIGH_LSB		0x32
+#define MAX31335_TEMP_ALARM_LOW_MSB		0x33
+#define MAX31335_TEMP_ALARM_LOW_LSB		0x34
+#define MAX31335_TEMP_DATA_MSB			0x35
+#define MAX31335_TEMP_DATA_LSB			0x36
+#define MAX31335_TS0_SEC_1_128			0x40
+#define MAX31335_TS0_SEC			0x41
+#define MAX31335_TS0_MIN			0x42
+#define MAX31335_TS0_HOUR			0x43
+#define MAX31335_TS0_DATE			0x44
+#define MAX31335_TS0_MONTH			0x45
+#define MAX31335_TS0_YEAR			0x46
+#define MAX31335_TS0_FLAGS			0x47
+#define MAX31335_TS1_SEC_1_128			0x48
+#define MAX31335_TS1_SEC			0x49
+#define MAX31335_TS1_MIN			0x4A
+#define MAX31335_TS1_HOUR			0x4B
+#define MAX31335_TS1_DATE			0x4C
+#define MAX31335_TS1_MONTH			0x4D
+#define MAX31335_TS1_YEAR			0x4E
+#define MAX31335_TS1_FLAGS			0x4F
+#define MAX31335_TS2_SEC_1_128			0x50
+#define MAX31335_TS2_SEC			0x51
+#define MAX31335_TS2_MIN			0x52
+#define MAX31335_TS2_HOUR			0x53
+#define MAX31335_TS2_DATE			0x54
+#define MAX31335_TS2_MONTH			0x55
+#define MAX31335_TS2_YEAR			0x56
+#define MAX31335_TS2_FLAGS			0x57
+#define MAX31335_TS3_SEC_1_128			0x58
+#define MAX31335_TS3_SEC			0x59
+#define MAX31335_TS3_MIN			0x5A
+#define MAX31335_TS3_HOUR			0x5B
+#define MAX31335_TS3_DATE			0x5C
+#define MAX31335_TS3_MONTH			0x5D
+#define MAX31335_TS3_YEAR			0x5E
+#define MAX31335_TS3_FLAGS			0x5F
+
+/* MAX31335_STATUS1 Bit Definitions */
+#define MAX31335_STATUS1_PSDECT			BIT(7)
+#define MAX31335_STATUS1_OSF			BIT(6)
+#define MAX31335_STATUS1_PFAIL			BIT(5)
+#define MAX31335_STATUS1_VBATLOW		BIT(4)
+#define MAX31335_STATUS1_DIF			BIT(3)
+#define MAX31335_STATUS1_TIF			BIT(2)
+#define MAX31335_STATUS1_A2F			BIT(1)
+#define MAX31335_STATUS1_A1F			BIT(0)
+
+/* MAX31335_INT_EN1 Bit Definitions */
+#define MAX31335_INT_EN1_DOSF			BIT(6)
+#define MAX31335_INT_EN1_PFAILE			BIT(5)
+#define MAX31335_INT_EN1_VBATLOWE		BIT(4)
+#define MAX31335_INT_EN1_DIE			BIT(3)
+#define MAX31335_INT_EN1_TIE			BIT(2)
+#define MAX31335_INT_EN1_A2IE			BIT(1)
+#define MAX31335_INT_EN1_A1IE			BIT(0)
+
+/* MAX31335_STATUS2 Bit Definitions */
+#define MAX31335_STATUS2_TEMP_RDY		BIT(2)
+#define MAX31335_STATUS2_OTF			BIT(1)
+#define MAX31335_STATUS2_UTF			BIT(0)
+
+/* MAX31335_INT_EN2 Bit Definitions */
+#define MAX31335_INT_EN2_TEMP_RDY_EN		BIT(2)
+#define MAX31335_INT_EN2_OTIE			BIT(1)
+#define MAX31335_INT_EN2_UTIE			BIT(0)
+
+/* MAX31335_RTC_RESET Bit Definitions */
+#define MAX31335_RTC_RESET_SWRST		BIT(0)
+
+/* MAX31335_RTC_CONFIG1 Bit Definitions */
+#define MAX31335_RTC_CONFIG1_EN_IO		BIT(6)
+#define MAX31335_RTC_CONFIG1_A1AC		GENMASK(5, 4)
+#define MAX31335_RTC_CONFIG1_DIP		BIT(3)
+#define MAX31335_RTC_CONFIG1_I2C_TIMEOUT	BIT(1)
+#define MAX31335_RTC_CONFIG1_EN_OSC		BIT(0)
+
+/* MAX31335_RTC_CONFIG2 Bit Definitions */
+#define MAX31335_RTC_CONFIG2_ENCLKO		BIT(2)
+#define MAX31335_RTC_CONFIG2_CLKO_HZ		GENMASK(1, 0)
+
+/* MAX31335_TIMESTAMP_CONFIG Bit Definitions */
+#define MAX31335_TIMESTAMP_CONFIG_TSVLOW	BIT(5)
+#define MAX31335_TIMESTAMP_CONFIG_TSPWM		BIT(4)
+#define MAX31335_TIMESTAMP_CONFIG_TSDIN		BIT(3)
+#define MAX31335_TIMESTAMP_CONFIG_TSOW		BIT(2)
+#define MAX31335_TIMESTAMP_CONFIG_TSR		BIT(1)
+#define MAX31335_TIMESTAMP_CONFIG_TSE		BIT(0)
+
+/* MAX31335_TIMER_CONFIG Bit Definitions */
+#define MAX31335_TIMER_CONFIG_TE		BIT(4)
+#define MAX31335_TIMER_CONFIG_TPAUSE		BIT(3)
+#define MAX31335_TIMER_CONFIG_TRPT		BIT(2)
+#define MAX31335_TIMER_CONFIG_TFS		GENMASK(1, 0)
+
+/* MAX31335_HOURS Bit Definitions */
+#define MAX31335_HOURS_F_24_12			BIT(6)
+#define MAX31335_HOURS_HR_20_AM_PM		BIT(5)
+
+/* MAX31335_MONTH Bit Definitions */
+#define MAX31335_MONTH_CENTURY			BIT(7)
+
+/* MAX31335_PWR_MGMT Bit Definitions */
+#define MAX31335_PWR_MGMT_PFVT			BIT(0)
+
+/* MAX31335_TRICKLE_REG Bit Definitions */
+#define MAX31335_TRICKLE_REG_TRICKLE		GENMASK(3, 1)
+#define MAX31335_TRICKLE_REG_EN_TRICKLE		BIT(0)
+
+/* MAX31335_TS_CONFIG Bit Definitions */
+#define MAX31335_TS_CONFIG_AUTO			BIT(4)
+#define MAX31335_TS_CONFIG_CONVERT_T		BIT(3)
+#define MAX31335_TS_CONFIG_TSINT		GENMASK(2, 0)
+
+/* MAX31335_TS_FLAGS Bit Definitions */
+#define MAX31335_TS_FLAGS_VLOWF			BIT(3)
+#define MAX31335_TS_FLAGS_VBATF			BIT(2)
+#define MAX31335_TS_FLAGS_VCCF			BIT(1)
+#define MAX31335_TS_FLAGS_DINF			BIT(0)
+
+/* MAX31335 Miscellaneous Definitions */
+#define MAX31335_TRICKLE_SCHOTTKY_DIODE		1
+#define MAX31335_TRICKLE_STANDARD_DIODE		4
+#define MAX31335_RAM_SIZE			32
+#define MAX31335_TIME_SIZE			0x07
+
+#define clk_hw_to_max31335(_hw) container_of(_hw, struct max31335_data, clkout)
+
+struct max31335_data {
+	struct regmap *regmap;
+	struct rtc_device *rtc;
+	struct clk_hw clkout;
+};
+
+static const int max31335_clkout_freq[] = { 1, 64, 1024, 32768 };
+
+static const u16 max31335_trickle_resistors[] = {3000, 6000, 11000};
+
+static bool max31335_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* time keeping registers */
+	if (reg >= MAX31335_SECONDS &&
+	    reg < MAX31335_SECONDS + MAX31335_TIME_SIZE)
+		return true;
+
+	/* interrupt status register */
+	if (reg == MAX31335_INT_EN1_A1IE)
+		return true;
+
+	/* temperature registers */
+	if (reg == MAX31335_TEMP_DATA_MSB || MAX31335_TEMP_DATA_LSB)
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x5F,
+	.volatile_reg = max31335_volatile_reg,
+};
+
+static int max31335_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+	u8 date[7];
+	int ret;
+
+	ret = regmap_bulk_read(max31335->regmap, MAX31335_SECONDS, date,
+			       sizeof(date));
+	if (ret)
+		return ret;
+
+	tm->tm_sec  = bcd2bin(date[0] & 0x7f);
+	tm->tm_min  = bcd2bin(date[1] & 0x7f);
+	tm->tm_hour = bcd2bin(date[2] & 0x3f);
+	tm->tm_wday = bcd2bin(date[3] & 0x7) - 1;
+	tm->tm_mday = bcd2bin(date[4] & 0x3f);
+	tm->tm_mon  = bcd2bin(date[5] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(date[6]) + 100;
+
+	if (FIELD_GET(MAX31335_MONTH_CENTURY, date[5]))
+		tm->tm_year += 100;
+
+	return 0;
+}
+
+static int max31335_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+	u8 date[7];
+
+	date[0] = bin2bcd(tm->tm_sec);
+	date[1] = bin2bcd(tm->tm_min);
+	date[2] = bin2bcd(tm->tm_hour);
+	date[3] = bin2bcd(tm->tm_wday + 1);
+	date[4] = bin2bcd(tm->tm_mday);
+	date[5] = bin2bcd(tm->tm_mon + 1);
+	date[6] = bin2bcd(tm->tm_year % 100);
+
+	if (tm->tm_year >= 200)
+		date[5] |= FIELD_PREP(MAX31335_MONTH_CENTURY, 1);
+
+	return regmap_bulk_write(max31335->regmap, MAX31335_SECONDS, date,
+				 sizeof(date));
+}
+
+static int max31335_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+	int ret, ctrl, status;
+	struct rtc_time time;
+	u8 regs[6];
+
+	ret = regmap_bulk_read(max31335->regmap, MAX31335_ALM1_SEC, regs,
+			       sizeof(regs));
+	if (ret)
+		return ret;
+
+	alrm->time.tm_sec  = bcd2bin(regs[0] & 0x7f);
+	alrm->time.tm_min  = bcd2bin(regs[1] & 0x7f);
+	alrm->time.tm_hour = bcd2bin(regs[2] & 0x3f);
+	alrm->time.tm_mday = bcd2bin(regs[3] & 0x3f);
+	alrm->time.tm_mon  = bcd2bin(regs[4] & 0x1f) - 1;
+	alrm->time.tm_year = bcd2bin(regs[5]) + 100;
+
+	ret = max31335_read_time(dev, &time);
+	if (ret)
+		return ret;
+
+	if (time.tm_year >= 200)
+		alrm->time.tm_year += 100;
+
+	ret = regmap_read(max31335->regmap, MAX31335_INT_EN1, &ctrl);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
+	if (ret)
+		return ret;
+
+	alrm->enabled = FIELD_GET(MAX31335_INT_EN1_A1IE, ctrl);
+	alrm->pending = FIELD_GET(MAX31335_STATUS1_A1F, status);
+
+	return 0;
+}
+
+static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+	unsigned int reg;
+	u8 regs[6];
+	int ret;
+
+	regs[0] = bin2bcd(alrm->time.tm_sec);
+	regs[1] = bin2bcd(alrm->time.tm_min);
+	regs[2] = bin2bcd(alrm->time.tm_hour);
+	regs[3] = bin2bcd(alrm->time.tm_mday);
+	regs[4] = bin2bcd(alrm->time.tm_mon + 1);
+	regs[5] = bin2bcd(alrm->time.tm_year % 100);
+
+	ret = regmap_bulk_write(max31335->regmap, MAX31335_ALM1_SEC,
+				regs, sizeof(regs));
+	if (ret)
+		return ret;
+
+	reg = FIELD_PREP(MAX31335_INT_EN1_A1IE, alrm->enabled);
+	ret = regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
+				 MAX31335_INT_EN1_A1IE, reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
+				 MAX31335_STATUS1_A1F, 0);
+
+	return 0;
+}
+
+static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+
+	return regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
+				  MAX31335_INT_EN1_A1IE, enabled);
+}
+
+static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
+{
+	struct max31335_data *max31335 = dev_id;
+	struct mutex *lock = &max31335->rtc->ops_lock;
+	int ret, status;
+
+	mutex_lock(lock);
+
+	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
+	if (ret)
+		goto exit;
+
+	if (FIELD_GET(MAX31335_STATUS1_A1F, status)) {
+		ret = regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
+					 MAX31335_STATUS1_A1F, 0);
+		if (ret)
+			goto exit;
+
+		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
+	}
+
+exit:
+	mutex_unlock(lock);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops max31335_rtc_ops = {
+	.read_time = max31335_read_time,
+	.set_time = max31335_set_time,
+	.read_alarm = max31335_read_alarm,
+	.set_alarm = max31335_set_alarm,
+	.alarm_irq_enable = max31335_alarm_irq_enable,
+};
+
+static int max31335_trickle_charger_setup(struct device *dev,
+					  struct max31335_data *max31335)
+{
+	u32 ohms, chargeable;
+	int i, trickle_cfg;
+	const char *diode;
+
+	if (device_property_read_u32(dev, "aux-voltage-chargeable",
+				     &chargeable))
+		return 0;
+
+	if (device_property_read_u32(dev, "trickle-resistor-ohms", &ohms))
+		return 0;
+
+	if (device_property_read_string(dev, "adi,tc-diode", &diode))
+		return 0;
+
+	if (!strcmp(diode, "schottky"))
+		trickle_cfg = MAX31335_TRICKLE_SCHOTTKY_DIODE;
+	else if (!strcmp(diode, "standard+schottky"))
+		trickle_cfg = MAX31335_TRICKLE_STANDARD_DIODE;
+	else
+		dev_err_probe(dev, -EINVAL, "Invalid tc-diode value: %s\n",
+			      diode);
+
+	for (i = 0; i < ARRAY_SIZE(max31335_trickle_resistors); i++)
+		if (ohms == max31335_trickle_resistors[i])
+			break;
+
+	if (i >= ARRAY_SIZE(max31335_trickle_resistors))
+		return 0;
+
+	i = i + trickle_cfg;
+
+	return regmap_write(max31335->regmap, MAX31335_TRICKLE_REG,
+			    FIELD_PREP(MAX31335_TRICKLE_REG_TRICKLE, i) |
+			    FIELD_PREP(MAX31335_TRICKLE_REG_EN_TRICKLE,
+				       chargeable));
+}
+
+static unsigned long max31335_clkout_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
+	unsigned int freq_mask;
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(max31335->regmap, MAX31335_RTC_CONFIG2, &reg);
+	if (ret)
+		return 0;
+
+	freq_mask = __roundup_pow_of_two(ARRAY_SIZE(max31335_clkout_freq)) - 1;
+
+	return max31335_clkout_freq[reg & freq_mask];
+}
+
+static long max31335_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	int index;
+
+	index = find_closest(rate, max31335_clkout_freq,
+			     ARRAY_SIZE(max31335_clkout_freq));
+
+	return max31335_clkout_freq[index];
+}
+
+static int max31335_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
+	unsigned int freq_mask;
+	int index;
+
+	index = find_closest(rate, max31335_clkout_freq,
+			     ARRAY_SIZE(max31335_clkout_freq));
+	freq_mask = __roundup_pow_of_two(ARRAY_SIZE(max31335_clkout_freq)) - 1;
+
+	return regmap_update_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
+				  freq_mask, index);
+}
+
+static int max31335_clkout_enable(struct clk_hw *hw)
+{
+	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
+
+	return regmap_set_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
+			       MAX31335_RTC_CONFIG2_ENCLKO);
+}
+
+static void max31335_clkout_disable(struct clk_hw *hw)
+{
+	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
+
+	regmap_clear_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
+			  MAX31335_RTC_CONFIG2_ENCLKO);
+}
+
+static int max31335_clkout_is_enabled(struct clk_hw *hw)
+{
+	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(max31335->regmap, MAX31335_RTC_CONFIG2, &reg);
+	if (ret)
+		return ret;
+
+	return !!(reg & MAX31335_RTC_CONFIG2_ENCLKO);
+}
+
+static const struct clk_ops max31335_clkout_ops = {
+	.recalc_rate = max31335_clkout_recalc_rate,
+	.round_rate = max31335_clkout_round_rate,
+	.set_rate = max31335_clkout_set_rate,
+	.enable = max31335_clkout_enable,
+	.disable = max31335_clkout_disable,
+	.is_enabled = max31335_clkout_is_enabled,
+};
+
+struct clk_init_data max31335_clk_init = {
+	.name = "max31335-clkout",
+	.ops = &max31335_clkout_ops,
+};
+
+static int max31335_nvmem_reg_read(void *priv, unsigned int offset,
+				   void *val, size_t bytes)
+{
+	struct max31335_data *max31335 = priv;
+	unsigned int reg = MAX31335_TS0_SEC_1_128 + offset;
+
+	return regmap_bulk_read(max31335->regmap, reg, val, bytes);
+}
+
+static int max31335_nvmem_reg_write(void *priv, unsigned int offset,
+				    void *val, size_t bytes)
+{
+	struct max31335_data *max31335 = priv;
+	unsigned int reg = MAX31335_TS0_SEC_1_128 + offset;
+
+	return regmap_bulk_write(max31335->regmap, reg, val, bytes);
+}
+
+struct nvmem_config max31335_nvmem_cfg = {
+	.reg_read = max31335_nvmem_reg_read,
+	.reg_write = max31335_nvmem_reg_write,
+	.word_size = 8,
+	.size = MAX31335_RAM_SIZE,
+};
+
+#if IS_REACHABLE(HWMON)
+static int max31335_read_temp(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+	u8 reg[2];
+	s16 temp;
+	int ret;
+
+	if (type != hwmon_temp || attr != hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	ret = regmap_bulk_read(max31335->regmap, MAX31335_TEMP_DATA_MSB,
+			       reg, 2);
+	if (ret)
+		return ret;
+
+	temp = get_unaligned_be16(reg);
+
+	*val = (temp / 64) * 250;
+
+	return 0;
+}
+
+static umode_t max31335_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	if (type == hwmon_temp && attr == hwmon_temp_input)
+		return 0444;
+
+	return 0;
+}
+
+static const struct hwmon_channel_info *max31335_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops max31335_hwmon_ops = {
+	.is_visible = max31335_is_visible,
+	.read = max31335_read_temp,
+};
+
+static const struct hwmon_chip_info max31335_chip_info = {
+	.ops = &max31335_hwmon_ops,
+	.info = max31335_info,
+};
+#endif
+
+static int max31335_clkout_register(struct device *dev)
+{
+	struct max31335_data *max31335 = dev_get_drvdata(dev);
+	int ret;
+
+	if (!device_property_present(dev, "#clock-cells"))
+		return regmap_clear_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
+					 MAX31335_RTC_CONFIG2_ENCLKO);
+
+	max31335->clkout.init = &max31335_clk_init;
+
+	ret = devm_clk_hw_register(dev, &max31335->clkout);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot register clock\n");
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &max31335->clkout);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot add hw provider\n");
+
+	max31335->clkout.clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(max31335->clkout.clk))
+		return dev_err_probe(dev, PTR_ERR(max31335->clkout.clk),
+				     "cannot enable clkout\n");
+
+	return 0;
+}
+
+static int max31335_probe(struct i2c_client *client)
+{
+	struct max31335_data *max31335;
+#if IS_REACHABLE(HWMON)
+	struct device *hwmon;
+#endif
+	int ret;
+
+	max31335 = devm_kzalloc(&client->dev, sizeof(*max31335), GFP_KERNEL);
+	if (!max31335)
+		return -ENOMEM;
+
+	max31335->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(max31335->regmap))
+		return PTR_ERR(max31335->regmap);
+
+	i2c_set_clientdata(client, max31335);
+
+	max31335->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(max31335->rtc))
+		return PTR_ERR(max31335->rtc);
+
+	max31335->rtc->ops = &max31335_rtc_ops;
+	max31335->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	max31335->rtc->range_max = RTC_TIMESTAMP_END_2199;
+	max31335->rtc->alarm_offset_max = 24 * 60 * 60;
+
+	ret = max31335_clkout_register(&client->dev);
+	if (ret)
+		return ret;
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, max31335_handle_irq,
+						IRQF_ONESHOT,
+						"max31335", max31335);
+		if (ret) {
+			dev_warn(&client->dev,
+				 "unable to request IRQ, alarm max31335 disabled\n");
+			client->irq = 0;
+		}
+	}
+
+	if (!client->irq)
+		clear_bit(RTC_FEATURE_ALARM, max31335->rtc->features);
+
+	max31335_nvmem_cfg.priv = max31335;
+	ret = devm_rtc_nvmem_register(max31335->rtc, &max31335_nvmem_cfg);
+	if (ret)
+		dev_err_probe(&client->dev, ret, "cannot register rtc nvmem\n");
+
+#if IS_REACHABLE(HWMON)
+	hwmon = devm_hwmon_device_register_with_info(&client->dev, client->name,
+						     max31335,
+						     &max31335_chip_info,
+						     NULL);
+	if (IS_ERR(hwmon))
+		dev_err_probe(&client->dev, PTR_ERR(hwmon),
+			      "cannot register hwmon device\n");
+#endif
+
+	ret = max31335_trickle_charger_setup(&client->dev, max31335);
+	if (ret)
+		return ret;
+
+	return devm_rtc_register_device(max31335->rtc);
+}
+
+static const struct i2c_device_id max31335_id[] = {
+	{ "max31335", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, max31335_id);
+
+static const struct of_device_id max31335_of_match[] = {
+	{ .compatible = "adi,max31335" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, max31335_of_match);
+
+static struct i2c_driver max31335_driver = {
+	.driver = {
+		.name = "rtc-max31335",
+		.of_match_table = max31335_of_match,
+	},
+	.probe = max31335_probe,
+	.id_table = max31335_id,
+};
+module_i2c_driver(max31335_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("MAX31335 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

