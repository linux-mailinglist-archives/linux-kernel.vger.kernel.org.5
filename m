Return-Path: <linux-kernel+bounces-161657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE78B4F12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3D31F21D45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1253A6;
	Mon, 29 Apr 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A3ot8AYO"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2061.outbound.protection.outlook.com [40.92.18.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D17F;
	Mon, 29 Apr 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714352175; cv=fail; b=oD8l7cCRN2/AtKF4BCzKjO/Z+jGXGDywnW7aYt5cvB4Dn/oGVpBcmaWZbo7pw8Ztz6+ayuPRASABglvlpdCP4uXJVbEzroz+GilC6lboGDzOPj7UttDbJLOtA8wTmc2cLnoGseGYDjxJaY2dKTR4p4Rvaz6KYezzJ8w0co5JeBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714352175; c=relaxed/simple;
	bh=iQEgOzfjjfZgHnM6T/NBAr541rL4JaFQxRauSGV8UYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMxkz7cVCe3TSBEtuDP7RC75M/5TV/y/kC5btacVTHY+NdJcgOq0Kitxfoldkd7ETmkKlFrusswjN05Xhaeyeer2KPX5ZuEYUR3ck0HPZioyWutyqOUZjTkJzzlUm+dA4igzfWe+oIaJmDhM5s9Y5GEkan2lVqTzojx4Z8Jsv3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A3ot8AYO; arc=fail smtp.client-ip=40.92.18.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN2zFllgE9v3MArOXAJcRUX2R5LtzwN9IRJopwjKEzZga+ukphHiyWyuPLG6wb3QWw7Riq5/8GWGL1qAwMcu6Kf5/BGqWa55S7o6NMCPp09845J7HbhpOgMfPmqSzVa08sk5IOiDWbHavvmndeSucC/qDixXJdYy1dZkokxVzyVAX7hBR2NR05J4+usYuTKEWf291/guu9SlfHS6HsFmxb8o2/D2zvIFwACRe/xk4jY5uqHsdeufLbtSswSb+yMQPExZ1/elXLEba6zqvbBQTuIvqhLQsiT1lmbf4KqkJUISiUwsffdAotRgstGVz/EZO1Bl14NolRxTN3m6fQDePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuIcoG1ZnQf3LfV/hf7nM7vvOUw9AQTCzul8Tbp+zYc=;
 b=lsq/VVuMXhkWxHIS3rYUF+uc+2w6EC/O9Rh2h6AriKr6/4bNYxXJijrKS3ZU6zZ4sQWQ9Yf6pUwF0VrcU6WfhADhCCDlJu022GyGVQpe1ThRkpXfA8LdF2Rw5x2COb+6liwzB1170R6fz7SnxsarAgghJa0wBvojToYG8FfLlcrlZ/YAtXzSvKR16ANHfjAsb52nESqHmgoQOJvhYiFOmLL6is6hZtBZKqVNxusI80jkF1Z5ANhsCosk6vMa/GCMpPZQZPXIQ3Nv2mn8dR2Uq8MgOJhrd2f1PUQGUQ6sOU+DY360nB4XanrSz9Ja5ZidcmJPPbobHUQxSdTIjtSecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuIcoG1ZnQf3LfV/hf7nM7vvOUw9AQTCzul8Tbp+zYc=;
 b=A3ot8AYOeYPAJA75RhhVF6K0GDNUMXBio1HM2UoA5EPzMdeEfPeJaS0te1MEsQQGsscDIpNFPDoweaIdMSmBgEH5aZy31BtQNKip+wyC99O+u2JiNPrqiviO98CDmylpGKdFlxepiD6hPuSGwgKdiv7algnnGAKAlUfQi6YcH+tceyyWQ5CzXBXAlEFiJt9gw4wG2ncVrQ8tysfQ7IdeIgG0yYbGzn52VTP5M3U/9IVnT84aBqERJBMd10Z5SoLWwk30A7tQ/HciHWCkMpE3Hmyvo66f7chZ6apvX54IWo4xwXjqyb3mdhBbcsM3zWa7AYDV5VEmPGy9S8NHmjfwjA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4345.namprd20.prod.outlook.com (2603:10b6:806:228::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 00:56:11 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 00:56:11 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Mon, 29 Apr 2024 08:56:35 +0800
Message-ID:
 <IA1PR20MB49537C6A49F7B194AD5BDF65BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49533CA5A5D0036F373308DBBB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533CA5A5D0036F373308DBBB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0BCmrFvkkek7vSkCtRHAAVo1HQswwQqNnL2GO/882Xk=]
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429005636.160596-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0345a9-72fb-408d-68e4-08dc67e72960
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	/l+2ZRdRJoZ0faQt2e0pdNFsODrCrswEi8N75oiJjQXBCYzmUnKIkItpFpVZEiYR6YkxNWoSjY8w3aaGzktAJSnjPcVaFKehAqDEndKWpOlwyOqyBLKPcYifqKPEkyfLx8Vwhp/kfGFTmnBmC15cZfKCUGDuArIW3MERgQE50PIbvvPXTaeJEBvSAic1s7zqrextRaCVr5/GcRgxuaV9qnzgLFNk0CHgowmF/xqY2ZZQBOPNYUwuxomu+aNnuzf63AuE+K1bYui/LF2yJaDbS1FMd9L9sCn9XRqip3PMIeO9Kp/2p6Y1DocCFZvMc4VfBkSIpdKG+WcnsKbFypBkVENGthKyaHJZwy6Cq+pGgkaMYBWLPzZCBIILJvoAIe6sXp/4J0rfqLfjTmiOa94cWkb5ETdSS0gsJMXaD2sLgBqcJm0XN+jXrKer8Ap4szsNdl5vRCET5icelXcSlbw7a5YvDjshR2eFBKQ1LUDphd7o3jeWpcwYAgWCgz4KDDDztOoVmrj5f1SkwBgckecrCQ4BGBzLnnhnGXcOGo+qfd85SQ35U9SP3x0ZeVt/tS40Z3VvJSUS7H2DABL2IlPUZMHguBaagB40FF9kA6rZtNtCq0x8s0zdI8WJrZyCb+Tb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXm4R1M9eZfSHtv83pHpt2QVQk5v2+8SpOyWfO3yrWeLUP7Voojuc4pqludI?=
 =?us-ascii?Q?f2aFE/2ZrFw+7xWodIYHMgQfWWpjkj3LdnX+jUT1/Fd87lvWWfZSK61/yhmk?=
 =?us-ascii?Q?AAtqMdgILViCir74OsLHfHW3lp63Qm/f0do1H7X8lB73L8/BWUMGV64h3eQO?=
 =?us-ascii?Q?83EJF+MHD+Ez16vbnBV7eeQEOD3lEAmtWf5NjqX+EXwr/xHs7Bi0JRqTROkO?=
 =?us-ascii?Q?Ie9EBe2FxLdframj2v20ylk9buDfQ1sQhOk3iPIZaX9JXZZ9DZNvITuXKvOf?=
 =?us-ascii?Q?yZbA1ibnRTGwOdDN85WmVNf1n5KdWwGpnNXar+a9MJhTwVGWvjOh77L6YYn/?=
 =?us-ascii?Q?CZ25FcHd4rBqUlmimAjX+RzjeeSradHah7t8kXkkIgsxRAXHCSLEDWjYwrnD?=
 =?us-ascii?Q?q8qprQPDiqKp2SliCFMXHMjKCA0Nfsma24/XWEIf+82BhJsmkHqTdizLHwsi?=
 =?us-ascii?Q?6Cu5dVtVPxrWGpnF1q7imsou/OewR8Uxz8PS0yzd7tOennu1QcFqGqLKI2jW?=
 =?us-ascii?Q?xCtF5KhXClGkCdSRnyykPKmg08B8eHg+9FtgbMoT8pI1FLKtJfeyfuyDkzTU?=
 =?us-ascii?Q?DYPxlHznpTeHMzyb4g2Iny3z+UHylmSVO0GnXruVW9tY17bh9AuNWBLbsBGU?=
 =?us-ascii?Q?ErtUGyWRrkzgyLRj2gFE0fBxoXR5TUZJjpa1zNsglHWl4Szkk+u/bc3lWaV1?=
 =?us-ascii?Q?L2xn6zMUglVxCDSpDJxA+sc5M4wwc0+A+C11149L7O+xSkahLvesHEYeGj3B?=
 =?us-ascii?Q?QMkbgY66GqMGg0fCACkjSuFkQ9vo/SHLOOc60jNZfkKhSOT9nxKZyGgOYl/6?=
 =?us-ascii?Q?FbFTSvw7fQOMNibh/xzH08Ch6QzmnJ1BF5dRa7UxYxWoWb7nxc2y0KPykvpp?=
 =?us-ascii?Q?zg5n9rCE7DkCLNfmfB3utHVhaMIMrrrJuRjpwcoi5zlLPpacInw6SBVtRj9Z?=
 =?us-ascii?Q?viFuigR0AOoPfOZh0fAu9UdFy/VWz42b9ecFZf5hThPz0wPh7rkTFZdiDdGt?=
 =?us-ascii?Q?W7ZHezyE6WTtro2YjVLR7zFpa+WZBDPKJ10K0ykPAjAqdHH3yixntKYoYcmn?=
 =?us-ascii?Q?WrcAriCWEzdUBbGBo6JrYE3mN1RuaAW1w9tIRemCc0t2S7eyaX04O9rlI231?=
 =?us-ascii?Q?3/2REHv6wYlSywYRpwgmoHiLSflt2/GSVTUtijGJ5fWptVTrGcQdU15/vOQk?=
 =?us-ascii?Q?LiPHbGE9zuVRiNnyXYdG4PN79Z7TVPfCoST79xAl8tlu+DnDgogcQ+2+DHIJ?=
 =?us-ascii?Q?skzyvZrCDbbYFYVmxNvm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0345a9-72fb-408d-68e4-08dc67e72960
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 00:56:11.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4345

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/hwmon/Kconfig            |  11 +
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++++++++++
 3 files changed, 543 insertions(+)
 create mode 100644 drivers/hwmon/sg2042-hwmon-mcu.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..3efaae91cacb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2056,6 +2056,17 @@ config SENSORS_SFCTEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called sfctemp.

+config SENSORS_SG2042_HWMON_MCU
+	tristate "SG2042 onboard MCU support"
+	depends on I2C
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Support for SG2042 onboard MCU. This mcu provides power
+	  control and some basic information for SG2042 chip.
+
+	  This driver can be built as a module. If so, the module
+	  will be called sg2042-hwmon-mcu.
+
 config SENSORS_SURFACE_FAN
 	tristate "Surface Fan Driver"
 	depends on SURFACE_AGGREGATOR
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 5c31808f6378..7497b653a2c2 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
 obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
+obj-$(CONFIG_SENSORS_SG2042_HWMON_MCU) += sg2042-hwmon-mcu.o
 obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
diff --git a/drivers/hwmon/sg2042-hwmon-mcu.c b/drivers/hwmon/sg2042-hwmon-mcu.c
new file mode 100644
index 000000000000..91c4266333ed
--- /dev/null
+++ b/drivers/hwmon/sg2042-hwmon-mcu.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
+ *
+ * Sophgo power control mcu for SG2042
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/time.h>
+
+/* fixed MCU registers */
+#define REG_BOARD_TYPE				0x00
+#define REG_MCU_FIRMWARE_VERSION		0x01
+#define REG_PCB_VERSION				0x02
+#define REG_PWR_CTRL				0x03
+#define REG_SOC_TEMP				0x04
+#define REG_BOARD_TEMP				0x05
+#define REG_RST_COUNT				0x0a
+#define REG_UPTIME				0x0b
+#define REG_RESET_REASON			0x0d
+#define REG_MCU_TYPE				0x18
+#define REG_CRITICAL_ACTIONS			0x65
+#define REG_CRITICAL_TEMP			0x66
+#define REG_REPOWER_TEMP			0x67
+
+#define CRITICAL_ACTION_REBOOT			0x1
+#define CRITICAL_ACTION_POWEROFF		0x2
+
+#define DEFAULT_REPOWER_TEMP			60
+#define MAX_REPOWER_TEMP			100
+
+#define sg2042_mcu_read_byte(client, reg)			\
+	i2c_smbus_read_byte_data(client, reg)
+#define sg2042_mcu_write_byte(client, reg, value)		\
+	i2c_smbus_write_byte_data(client, reg, value)
+#define sg2042_mcu_read_block(client, reg, array)		\
+	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
+
+#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
+	static ssize_t _name##_show(struct device *dev,			\
+				    struct device_attribute *attr,	\
+				    char *buf)				\
+	{								\
+		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
+		_type ret;						\
+		ret = sg2042_mcu_get_##_name(mcu->client);		\
+		if (ret < 0)						\
+			return ret;					\
+		return sprintf(buf, _format "\n", ret);			\
+	}
+
+struct sg2042_mcu_board_data {
+	u8		id;
+	const char	*name;
+};
+
+struct sg2042_mcu_data {
+	struct i2c_client			*client;
+	const struct sg2042_mcu_board_data	*board_info;
+};
+
+static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
+	{
+		.id = 0x80,
+		.name = "SG2042 evb x8",
+	},
+	{
+		.id = 0x81,
+		.name = "SG2042R evb",
+	},
+	{
+		.id = 0x83,
+		.name = "SG2042 evb x4",
+	},
+	{
+		.id = 0x90,
+		.name = "Milk-V Pioneer",
+	},
+};
+
+static const char *sg2042_mcu_reset_reason[8] = {
+	"Power supply overheat",
+	"Power supply failure",
+	"12V power supply failure",
+	"Reset commant",
+	"Unknown",
+	"Unknown",
+	"Unknown",
+	"SoC overheat",
+};
+
+static int sg2042_mcu_get_board_type(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
+}
+
+static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
+}
+
+static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
+}
+
+static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
+}
+
+static int sg2042_mcu_get_board_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
+}
+
+static int sg2042_mcu_get_reset_count(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
+}
+
+static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
+{
+	int ret;
+	u8 time_val[2];
+
+	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
+	if (ret < 0)
+		return ret;
+
+	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
+}
+
+static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
+}
+
+static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
+}
+
+static int sg2042_mcu_get_critical_action(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
+}
+
+static int sg2042_mcu_get_critical_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
+}
+
+static int sg2042_mcu_get_repower_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
+}
+
+static int sg2042_mcu_set_critical_action(struct i2c_client *client,
+					  u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
+}
+
+static int sg2042_mcu_set_critical_temp(struct i2c_client *client,
+					u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
+}
+
+static int sg2042_mcu_set_repower_temp(struct i2c_client *client,
+				       u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
+}
+
+static ssize_t board_type_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", mcu->board_info->name ?: "Unknown");
+}
+
+DEFINE_MCU_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
+DEFINE_MCU_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
+DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
+DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
+
+static ssize_t reset_reason_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret, val, i;
+
+	val = sg2042_mcu_get_reset_reason(mcu->client);
+	if (val < 0)
+		return val;
+
+	ret = sprintf(buf, "Reason: 0x%02x\n", val);
+
+	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
+		if (val & BIT(i))
+			ret += sprintf(buf + ret, "bit %d: %s\n", i,
+						  sg2042_mcu_reset_reason[i]);
+	}
+
+	return ret;
+}
+
+static ssize_t mcu_type_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = sg2042_mcu_get_mcu_type(mcu->client);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, ret ? "GD32\n" : "STM32\n");
+}
+
+static ssize_t critical_action_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+	const char *action;
+
+	ret = sg2042_mcu_get_critical_action(mcu->client);
+	if (ret < 0)
+		return ret;
+
+	if (ret == CRITICAL_ACTION_REBOOT)
+		action = "reboot";
+	else if (ret == CRITICAL_ACTION_POWEROFF)
+		action = "poweroff";
+	else
+		action = "unknown";
+
+	return sprintf(buf, "%s\n", action);
+}
+
+static ssize_t critical_action_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int value;
+
+	if (sysfs_streq("reboot", buf))
+		value = CRITICAL_ACTION_REBOOT;
+	else if (sysfs_streq("poweroff", buf))
+		value = CRITICAL_ACTION_POWEROFF;
+	else
+		return -EINVAL;
+
+	return sg2042_mcu_set_critical_action(mcu->client, value);
+}
+
+DEFINE_MCU_ATTR_READ_FUNC(repower_temp, u32, "%u");
+
+static ssize_t repower_temp_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val == 0 || val > MAX_REPOWER_TEMP)
+		return -EINVAL;
+
+	return sg2042_mcu_set_repower_temp(mcu->client, val);
+}
+
+static DEVICE_ATTR_RO(board_type);
+static DEVICE_ATTR_RO(firmware_version);
+static DEVICE_ATTR_RO(pcb_version);
+static DEVICE_ATTR_RO(reset_count);
+static DEVICE_ATTR_RO(uptime);
+static DEVICE_ATTR_RO(reset_reason);
+static DEVICE_ATTR_RO(mcu_type);
+static DEVICE_ATTR_RW(critical_action);
+static DEVICE_ATTR_RW(repower_temp);
+
+static struct attribute *sg2042_mcu_attrs[] = {
+	&dev_attr_board_type.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_pcb_version.attr,
+	&dev_attr_reset_count.attr,
+	&dev_attr_uptime.attr,
+	&dev_attr_reset_reason.attr,
+	&dev_attr_mcu_type.attr,
+	&dev_attr_critical_action.attr,
+	&dev_attr_repower_temp.attr,
+	NULL
+};
+
+static const struct attribute_group sg2042_mcu_attr_group = {
+	.attrs	= sg2042_mcu_attrs,
+};
+
+static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT,
+				 HWMON_T_INPUT),
+	NULL
+};
+
+static int sg2042_mcu_read_temp(struct device *dev,
+				u32 attr, int channel,
+				long *val)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	long tmp;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		switch (channel) {
+		case 0:
+			tmp = sg2042_mcu_get_soc_temp(mcu->client);
+			if (tmp < 0)
+				return tmp;
+			*val = tmp * 1000;
+			break;
+		case 1:
+			tmp = sg2042_mcu_get_board_temp(mcu->client);
+			if (tmp < 0)
+				return tmp;
+			*val = tmp * 1000;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_temp_crit:
+		if (channel)
+			return -EOPNOTSUPP;
+
+		tmp = sg2042_mcu_get_critical_temp(mcu->client);
+		if (tmp < 0)
+			return tmp;
+		*val = tmp * 1000;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int sg2042_mcu_read(struct device *dev,
+			   enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_chip:
+		if (attr != hwmon_chip_update_interval)
+			return -EOPNOTSUPP;
+		*val = 1000;
+		break;
+	case hwmon_temp:
+		return sg2042_mcu_read_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int sg2042_mcu_write(struct device *dev,
+			    enum hwmon_sensor_types type,
+			    u32 attr, int channel, long val)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 down_temp, repower_temp;
+	int ret;
+
+	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
+		return -EOPNOTSUPP;
+
+	ret = sg2042_mcu_get_repower_temp(mcu->client);
+	if (ret < 0)
+		repower_temp = DEFAULT_REPOWER_TEMP;
+	else
+		repower_temp = ret;
+
+	down_temp = val / 1000;
+	if (down_temp < repower_temp)
+		return -EINVAL;
+
+	return sg2042_mcu_set_critical_temp(mcu->client, (u8)(val / 1000));
+}
+
+static umode_t sg2042_mcu_is_visible(const void *_data,
+				     enum hwmon_sensor_types type,
+				     u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval)
+			return 0444;
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			if (channel < 2)
+				return 0444;
+			break;
+		case hwmon_temp_crit:
+			if (channel == 0)
+				return 0664;
+			break;
+		default:
+			return 0;
+		}
+		break;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops sg2042_mcu_ops = {
+	.is_visible = sg2042_mcu_is_visible,
+	.read = sg2042_mcu_read,
+	.write = sg2042_mcu_write,
+};
+
+static const struct hwmon_chip_info sg2042_mcu_chip_info = {
+	.ops = &sg2042_mcu_ops,
+	.info = sg2042_mcu_info,
+};
+
+static int sg2042_mcu_check_board(u8 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
+		if (sg2042_boards_data[i].id == id)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int sg2042_mcu_i2c_probe(struct i2c_client *client)
+{
+	int ret;
+	struct device *dev = &client->dev;
+	struct sg2042_mcu_data *mcu;
+	struct device *hwmon_dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+						I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -EIO;
+
+	ret = sg2042_mcu_get_board_type(client);
+	if (ret < 0)
+		return ret;
+
+	ret = sg2042_mcu_check_board(ret);
+	if (ret < 0)
+		return ret;
+
+	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mcu->client = client;
+	mcu->board_info = &sg2042_boards_data[ret];
+
+	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
+	if (ret < 0)
+		return ret;
+
+	i2c_set_clientdata(client, mcu);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 mcu,
+							 &sg2042_mcu_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static void sg2042_mcu_i2c_remove(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+
+	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
+}
+
+static const struct i2c_device_id sg2042_mcu_id[] = {
+	{ "sg2042-hwmon-mcu", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
+
+static const struct of_device_id sg2042_mcu_of_id[] = {
+	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
+
+static struct i2c_driver sg2042_mcu_driver = {
+	.driver = {
+		.name = "sg2042-mcu",
+		.of_match_table = sg2042_mcu_of_id,
+	},
+	.probe = sg2042_mcu_i2c_probe,
+	.remove = sg2042_mcu_i2c_remove,
+	.id_table = sg2042_mcu_id,
+};
+
+module_i2c_driver(sg2042_mcu_driver);
+
+MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
+MODULE_LICENSE("GPL");
--
2.44.0


