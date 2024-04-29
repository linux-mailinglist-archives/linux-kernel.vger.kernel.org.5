Return-Path: <linux-kernel+bounces-162187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CAF8B575E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C28B20A65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAB53E17;
	Mon, 29 Apr 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MLuP6oGa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2092.outbound.protection.outlook.com [40.92.22.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE960537EC;
	Mon, 29 Apr 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392186; cv=fail; b=T45q/pjw3V3+ZC5uvdojCXrrB053hXXFNheAODghsMD2xKam2TGbgIho/qLoJGVX+OV5xm8VdWnuynUkVQd0j6Btb6L/IHm2+y8edyPQQSoLyn/Uz8PfO3fhH9B8GFoc7UkvSSBZ3KmlsvQlv586Uxk1gJ7oTx/L/B47Ak9PbV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392186; c=relaxed/simple;
	bh=iQEgOzfjjfZgHnM6T/NBAr541rL4JaFQxRauSGV8UYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OC/58MclkNUf6U6zRlCC5upXbAha7/o2JINnkcjwuTwMo4sVcGhTmGxgbXN3repVZZeYFVhRgSiCfXBnfDkKMBqHhPedQV302XBgTtcAbHOcNr34+Ahegig4hAF+8Y7Vwv4NttPH9kYc/8DJ6mdPfB6pXuozkbFkd/R3qUCkgSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MLuP6oGa; arc=fail smtp.client-ip=40.92.22.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIe1MkKbG+K9yUM9YzWFEndFHx0yIWh4nWKV5t/rhhqIDHEZUnRHhGisdNFQkBbREojQpWk9SJQSTvgBfHHj1ZPaLL9CyIgRxoVMKIwbBXv9e4Dc1PiKxoj8JK+AOZi1QdRGVre03aVKsK/k5pCik4EcrWKx5uMF/8bUvUb3hWrjqsr8Fa/Ng/s02W5EsO/94BvvIkEbenWupXzM0IyaxvbwuoXK4I26kRRf9Js4eBppDGjKJras0ls06IedYC8n4Ixphwnn22r76a46trhdFidPqHcMRJKoohMhKmoOdWh4Fwon+3EBMGhMwuhA6Jcx6Jw/PPCJZyraVWfXhi1AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuIcoG1ZnQf3LfV/hf7nM7vvOUw9AQTCzul8Tbp+zYc=;
 b=W9ZinM8ZAs15/uUucBn0SNbnNH3uwX9HZH8WWwKVqkrAodtHpc81zR1UJwLs47SIK+zZKsVOohiggGElI3qB+FmDD5WUbMNell6FAVyTaps2o1BsXa9tKHrWnCH2hPCGX/ACsoPLvzHv6XL0ZBI85XsFSarASwVb280QWxPocHJKGOSoF8O6olJ6iPPJ9fghn070AU4/fdiZRABBgpP40zPKPLjhD1pwfZgqtXWMmf+eWFOtzMYTJ8Vpnlmag4V7Ia2aPVGTzdUxnkUUMKT2StTHvZYk9VtlyosTavq+PJmKNginOljOr7SU7hf+PqnuHLu9T1Jw23QY90LphmBeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuIcoG1ZnQf3LfV/hf7nM7vvOUw9AQTCzul8Tbp+zYc=;
 b=MLuP6oGaw1aPCkR2c5JlHyi4Vd9R4sl19h8mEfe/qqdI4EeAlT1X7nRC+XeVGSZxoGB8DAC4ruTVfNbnV0NxPla/N3JxwrvQ/tAOtRDU/ifpUYB25yTOOz/7Bda04lDJN/ZBa8OSiYdxiix9pw8d4dhwZXdiE1wA/ZJQLJk9mpewuvs0ziz65gZdQz39+6dV1iM5VY0Vd6A/194+5YQ4IJVo9+BLzoRzVSd+fAnccSRqT/fLmsuU8cIGZb/2tEqJLXBLLrzBCvuUBKmCPIvTvJZiRadsMl0EyOx1J8+1nNdMpX7mP04L579Qh6Gtb1/UtuQe2vhj3Or9wjr8kZYgQA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5734.namprd20.prod.outlook.com (2603:10b6:8:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:03:00 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:03:00 +0000
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
Subject: [PATCH v3 2/2] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Mon, 29 Apr 2024 20:03:25 +0800
Message-ID:
 <IA1PR20MB49534366334538B2DA2A1C47BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953D1C509CC7F23620CCA01BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D1C509CC7F23620CCA01BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JKzDSx3o0HU12jIGMfgCQQvi6E0B9jtiQnsgpltpkOU=]
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429120326.860160-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a79ec8-cf1b-4558-cb42-08dc68445101
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	uISBTX1zM+7BwDcSRErYSUkQa2wiaaK68rk7LHZK5Xm5Ksj27NAPliYNP9Jwc6geaLyzBqK1sOllQaIyB/yMSMfwLoTybv5AZHfidi6Wkz8sstcKejXJxR43SaxZ3JdtB6vh3SHiEOhB2HhELxvJE22ETaZeeP1MJ0503qY9Adz10i6U3BmNBuU4LtifvMQIL9hX6uxYnzCYcF9FaLH8PRlPSLu5SjJyj3WAqRXxsFiysHXrGb6lFUJcZaKepPe5XRLcPf017tIacRYLgRbq7VBifMBj4kbwaZg3XYRjyX69izNWgrguy3a+eFQTSv+6FCQcJKdmyHgPFtUullSVjZfdT5f4g4txKmd7LkQWR+LcYJ940r8DuOwa1UDDrTC+jBvYMoH/oBS/HWl3G3LkXL4jB4hzhcAQSrpFCFuuaqwZ4q+BQfPRNFXjpo81U1CIV1WjV/8Wd923zwisuwGB0tCVIfzgXtZmRQJ+47eybdInSNXnae4uEBqrJAAMKzi/fjXJKVKZayU230n+65zi1Pw/wpiK2sfkPcpPfvSZgqRvrzyHmrIHnLAMVMfiNs3asqp1bjE42M6yE0QFJeSmNxOeNUmYOUtCV0EcXETUa/nFdgsafUczOFEO8uyVbxp/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KADuxZ2fXQmBDQgVAQ0diFvJeZ/t4gfWyVTyGKbu5H2TbYllZclqt46FbOLC?=
 =?us-ascii?Q?sSe1Vk5R8GHiKyrRhEzgMOiJLROvG3IoeZRj5EyZNANaERPK5cZnayVfBp3f?=
 =?us-ascii?Q?skunMliU/0372M9Wb/rUse+9RaoBn7jGfjTSq5CqOZU+62CCXiPB135g4yI1?=
 =?us-ascii?Q?jXBo+AhL/1ZAhmH0/YKU+X3bJ4fgkI6FFsZnYNiMMq+9cURSNmfMJF7g9p4W?=
 =?us-ascii?Q?9ZvQsFLi1Rm1mJes4rv1yXd7BpVv5GTfY63QNuJejkZl1uROlJsXst0l95qk?=
 =?us-ascii?Q?kqtx7ff1kC0enbekL57SJw2nLQext8y8a1NFGlvva0ju6RCRrPiaR6/ShLqd?=
 =?us-ascii?Q?RQXNvR9UHCbjc3h/5YvJVuYl24PanT1Cd+JQp/O+xRqElqeMdqE5puYRiXiG?=
 =?us-ascii?Q?PTALeo1BJ7J00C//FFduTUm6vGQg4+TKWOvJzkUPXcGluCcK8C4LhM560TbS?=
 =?us-ascii?Q?V09QaONezA3egQSFFq7EA+qUQczICS2C7rBQc/DNCkPgwzJiGs50ROfD3j6W?=
 =?us-ascii?Q?jyStgX/OG7+si6igydyFDNF3XpOr3UL80OcS4iw/L7ChdiKkG1gVjFd7bpsp?=
 =?us-ascii?Q?h7wUwOyvInPqfzdiNWdI0qKuymXgttwsqsTG0TMpNyIDXOuSPGJiddpT/4JU?=
 =?us-ascii?Q?uMQfoHsPBQic9YITOknhZNqDlWFXbCyycxq+nrGrjbFXE8RT1q2y0kYXCcJ1?=
 =?us-ascii?Q?xGbjDGJ5Mu5Xz7ONmhgrGCupkKX09GnIF4jehQfusPBkUHjztMQOQOLV6IK7?=
 =?us-ascii?Q?digDDpZivhy7COhbu0Uj6k1tPFh2lsApJjVgSjZlbJSYwXyQFj6+/7NoNPY3?=
 =?us-ascii?Q?5ejfHYx7bqiUeZiljHigQDEwiANjAHjvk+1X68HOg9O58MKCpbZehH5gmdSj?=
 =?us-ascii?Q?cm2uishgMPL7komDlrgBEEDn+ChH7Z3IlsxGYJ6Me3lNETr8YqfeMUruzx3A?=
 =?us-ascii?Q?8YC0J2/Lm8PcMxy7jVrO2CATSYtQHb1rUYgAkDzujaJT4hrEIFJvsOJj6xU2?=
 =?us-ascii?Q?n1lnpUKZlsitHCi/3CRqjlt53PYw/JCYDE7yhfYFsusAzm8oRazXH0Xek/Vw?=
 =?us-ascii?Q?esfBM8xArBD40avL4e47qTjuU9F9BP67yf1m/EL3pEOtnmhF6fJn7orUJbe0?=
 =?us-ascii?Q?5MfhFKFVbg8AOlTiTlG7gLmANB46L0JXNlaOh4I0UyHcAj81UHwrqLln9Ff7?=
 =?us-ascii?Q?fSZvzU7KVpbnqgrXwt6Xi/FbgjakiBWPeFXRU9gwerUqNCGJuAHX7c+aGzBp?=
 =?us-ascii?Q?i6/ptaFCxsz0fL75SH77?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a79ec8-cf1b-4558-cb42-08dc68445101
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:03:00.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5734

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


