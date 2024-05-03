Return-Path: <linux-kernel+bounces-167180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2F8BA549
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E492840AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF54E168B8;
	Fri,  3 May 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H9Emarml"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2022.outbound.protection.outlook.com [40.92.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C5182B5;
	Fri,  3 May 2024 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702787; cv=fail; b=PlCVG/OB4ziIylT4LRnZ881Ly01kWhBbZ9lV/9I92kBbmPdoyBdl/Asin300t/tSkEd/35++wE2Bf/0ats7b/vJhEed5GkgqwzI/LHgbUYSemiqs9TcLHfV9ZfZVPAle8GBLP7sHCZmr44PRJ8Go46M166u6vEqLdXgbsSiuNwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702787; c=relaxed/simple;
	bh=UOXD7oESxSDM9L1DddGNDAQDyzvfQKom5z72nGzYGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPH89z82YIfnc84AF5YW5DLtYWqc7mDCI3A4mRbx/veGqhkiakwFmr1rSlGZuItVEv7KC9njYT8QmyWsvmJmKv7dlAAt2nlx7wLwi2vSmTH7X+V1REfbiZVPbu/qIYrbD6slHvYqsENZOqAxBnQoLPROlpz1B+HyB01TrQm75j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H9Emarml; arc=fail smtp.client-ip=40.92.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOlU4vgehLarxgynBPn/MTf1WSpO9Qrp2rYKdgMUxlqDG0NKn6xey7Yb55PpsVRR74Z7m4J65Psy+DYzO8HMGgpCIrE05gQGkTg4YYECzXZaSnAggUbI3y88o5gC3y3D6NLsm191NnaNPp8zh9lVzvKxCfekmKTBfsC+7P/K8uTzvBzA+tgBUfMesAlb4j/KYwCcNsQTZeqQwPR0l6vJew2uSZkMj22FaIRKHNNso//hk2Bj/TCOtzYSqSL2BARZ7zUuctIBD/ePu9ywe2dlPUE+EJrdLqut7l3QL5VPxSQuL9VDCa5CkwgyVrtGLgkLWGQ3cdMx7sIQ4guny7ipJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfKGx+3F24RUPtNhntDfK/IPkKknFtR+bbfD4w60T6U=;
 b=E3pBUOkQAEXmBEdQG7E9WmnhGtrBaJ1rjp5QDLB+/chFVPjufCYj3nmQOZI3WUAEz5PDm0HJOIG/8zVgLVefpqY6f2VgBHEN5fqmZLobYyYIEymWGsTh8Gbu2ico8BEnXDGyOLPHISK7toVEbhqwLzVSI6VBMiImOWGrJyMDc389QzplE0KQs46/Kp91b5sw1nr5BYu5NNgBJKAv73g7MFekcAHGlN/cnZAwrklPpECkds2aXq0gnMdlvSWejypwe2XvuSvsHEvqb3D0o0JmSNHeCfjdQFWBv562ZhDiRFp0h7kzqMeGjyHUefC8JeEvePCv/azluVYU7NZsEjljJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfKGx+3F24RUPtNhntDfK/IPkKknFtR+bbfD4w60T6U=;
 b=H9EmarmldRGDa4Yj53vTQDTLxIXXma/HN44fuExsZV3sigjksNhpJ8ONBTC8ThHMMQ6gvpvD+sG1BSfZgas0aWGIlEmYuhIOWYZvFcDHgdViT+DknBG5bMdduj71nn5YS2G90uuzAur5gVSsWOYx4UUIWo7u7CurwWHxgk9PNQFf5DCKXY2+RylkhGMM9UFKh0AS//tH7VcXRgGHBUmU9RJDWgUwGc16BfNigGmd8GbUadC3GTiCcuVWsiDhb56VUx++OTYRZR4CJWERyccp1EAdIwo12EZF2zCWqLt6LFnr2pU/kRm3kWk8w7dInCBxfboo8zJL8G4Q/Sx9hYbSdw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7419.namprd20.prod.outlook.com (2603:10b6:610:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Fri, 3 May
 2024 02:19:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 02:19:42 +0000
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
Subject: [PATCH v4 2/2] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Fri,  3 May 2024 10:20:08 +0800
Message-ID:
 <IA1PR20MB49532195DEDCEE3E2F75529ABB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <IA1PR20MB49534B54403ECFB15D952A8BBB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534B54403ECFB15D952A8BBB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [h/FTG8uNFkQZST6fy36zcKYOkPkORbTofbMJuCbm+lo=]
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240503022008.898271-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e115acf-6c05-4146-371d-08dc6b177e08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	S639RViHBdNFMoOA5ItavljTvd7rAQGjgnlfU03/GWjMScw7CU40nXpjTwcUzZphspLJ8kqfElc4/3vy3OA9sqnWpB1QMu9cb3kswPJDjw7oTFEx4mpqs0FMKaAKF71ociZ4xe0RwmQQLQp+Xwga5V0hWDq9FcmndeXf/MS0MAPRQ7fI3+nRpz0kxmue4a7EDkEDrqWd1QXnc2H9pfzl5mNdiDTueLnlI+YuUChd0kb4YZ5mZCbXRD4AGfyoFl3FAQfJjZh4uEMzkXzPqVlowM/BynwAFruy/zuEqyLqSx1IJ6VhFVxR2dAx6N6T/nrYNNR2YcbhhtC5w7j4/mB1YGzTDgDHtrJpJmo2ORXEAvtF/jKT3mQSq4nzR6YkQdhYpszFkGSkM29MzbGJyHgW/fLZOF8kf2ixTUzyMQeuYauxU9kwCkxJIjyhkgvYsSVNPqqC72PQab6DQ0bcirVMMPO5TrWIzAirn3q5HI3BW8g4Nb2oPDz6r73ZqKgr9w045k0RMr+NEYi0M+1BgPzPBoaYMagRDoCmWVcEMXc8ZER5LrtMzfGuzSQzBN/EnHpn44FhhtrUvFwE7SOZ3AXheI459H7dRjLP9F1lP0tYMedDFTzR2OYmTDyULwfsqx3S
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kIDOaXYce7Ih4zsteUpSgUVigA20ufhzMRCxqXSZbBTQiJacyaQ+jTA6Ehx5?=
 =?us-ascii?Q?s/pY8BtDgHSw8SmuSppHhzx6Qm7JRsih9b4PcywbqObcMvgKJoGf29lfX85b?=
 =?us-ascii?Q?SDJm4x7K6U4Z+FMp0pPJS136CRCMpcu1vNutwWQ9GdEx1cJgvU0ryKADMrge?=
 =?us-ascii?Q?06Ty/2I09u7YqATTpgpAoC4+eYljb9bdgPo9zOR42fdTuIsFvMXJZXYYL1jK?=
 =?us-ascii?Q?f/gqRxF61pkG2MRUuKyC92ym2UZySkXOlviAnUoz4x/zNyhJZpqkhSQSbTWW?=
 =?us-ascii?Q?/X5xQuOf9wkHntKw8iMQIu56RuctHM2TdVU2bmOg7ucyx0ovrULl1B2SCFaX?=
 =?us-ascii?Q?yWXV/lWgWJbRZTy7O8JVEt8VZfBbcIYIWJ2OcZN4pFMK5LAqLWrKKFG/5RGp?=
 =?us-ascii?Q?5yRjFSy0LI+lSkM75Ea7ud2CSPeWgEZI1lWQip+u+j/kjSLSyeuCIn39h9bU?=
 =?us-ascii?Q?5sQz37Yc7571Sr+473p/j9/VgJ3aiiH8Jk1jHcN3ro/n5xFZ70Yd0JV5NU/s?=
 =?us-ascii?Q?NYOOEXpYkSMOibAP9BTf2m0cxS6/Oe5Xm685sr5o5fjLJJg3EyEs7jCpgs6n?=
 =?us-ascii?Q?aolR8mXQqY5F6ga1iEqbQ42Rn5ftVvkm165A320zqpCnytWboYZxW6Gmmdc1?=
 =?us-ascii?Q?xlK7FhJTsmuyIsDQJBbXZTS0J7OzBGGguIwZccBG51njniSm+2gQrAmUBfK2?=
 =?us-ascii?Q?WDlSdCdIiRxILCddqME/PeIak16xZhEhtymlCizsXVblSGMVAksj4dLcuIrw?=
 =?us-ascii?Q?reXwqzdyx+JpCtHrlqEDkHSci9lw81MBq7Tb1lmp2qkvJ2dDWy9jDpq0eMKk?=
 =?us-ascii?Q?PYRgErKuQxhMDXQQTZFVOv8lUrx/OCtCV37wtNsIDalP50jDAMkLmKd8TjoX?=
 =?us-ascii?Q?pT6dLzDuO8FhCsyalO9esZmJC72fDluKB4il9ZjCtGij+jmOtVw4v7BDTYTf?=
 =?us-ascii?Q?nRro+Qe2B2RtPDaUQqG7sHaF17TxudDX3vDB63x8UL05SS3bcJLJjGGuVo6l?=
 =?us-ascii?Q?hgGk1I9iRHDx+f1OY3xm7pXA19Jjyci1mq619is+daHhCEyjZWv+YdRKX0O9?=
 =?us-ascii?Q?8ji75gheD47u9iHV7Hs/1/U49RnX5nl7xoN3P1VL6ZB5EYktXgPMO/tWRKl1?=
 =?us-ascii?Q?3mt3bEYSljPwWf02R3JxidfQhyq7LuDUpoJSkeyPaKk+6GTBaL3tR7WPw2M/?=
 =?us-ascii?Q?sSxkxh/Kt5pIatLJO8XtoaE6VCggOq/Fm2f95ljZqlp7LMYqIH19cStvSR4e?=
 =?us-ascii?Q?H6dKTg9RC6r87bfFGFbF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e115acf-6c05-4146-371d-08dc6b177e08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 02:19:42.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7419

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
2.45.0


