Return-Path: <linux-kernel+bounces-18550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A0C825F16
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1201C21483
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F463DD;
	Sat,  6 Jan 2024 10:15:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2086.outbound.protection.outlook.com [40.107.222.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FF63AD;
	Sat,  6 Jan 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emJrmf3OiPbUZNLToRiLYzJ+9xAdIT5+nsWSC5thpLW6wFO3+qgCL4OmlzsmO1sLCsiz2e9jrxO9auZPkFqn6uyn2ylKG+FbDqE/BEO9pgrqDkupO+xv71HLidFqtIQNUoCId3PeewjEunVsJOKWQY2Ny8Gn+eyH8IeEkc9qqqvmtlVaBRMOgaUsqvfzM7FHEKIzX7C2DtYbt87vrAaSpCcCTdSzbeG8trqzpM5qiGteHJK2I57iMcpmLWO+mnnHzgQH+WUkKfK+OicRo/nHj91Wss58K1qE8IerhvzLLNcBmQZYONnkIWcj0GU8/bd80pTiqe79mJbTVL8cBq1RSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKbsOvS3h/6ph5Yn17rW62p6NRXFpYAADO0Z3Sik828=;
 b=D+x4GIBCGz6HKX5YnhLOtlxJwtCfuP+RZWXyo0F8uhEIdiWEulEzIqmDEUwpjDDBN5pxyUU8vUJL6s9XYqs0RiEpIZCIGxDiKs3QfIcrnhyUL/yLb5mp+C0ZMfAEhlfCrWbTbdA2kMOyMSUH73JPCZbbYxuW+IQYxZBnC5oGZYY5uqGizFrWdckI1aNNXDHzDRIiBzdXTV/bXOcy06Ypn35MXLLqd3v9Iq7tX9dRqi9y0Ras73+KeAf3G078POtOXgwO8eV7MIRhnbxLAB99Zuj1RE9etr6KPXU1FZF7sEAk26AvE570IpuT9qeBEHCcj6s2CfMRIaePuZvRG0OxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MA0PR01MB6415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 10:15:00 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 10:14:59 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Sat,  6 Jan 2024 15:44:33 +0530
Message-Id: <20240106101435.2927116-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|MA0PR01MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 486f088f-aa27-4a7d-0643-08dc0ea0570d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dy4pHl18hYKsvOY6rbMjg1Y6gjKyozbamcrXk92S4kljc7bXZDRroykEjQEhroeO9egTJxW1RFykqNGmbD8lpth5vRFEeBzxtntnaSmgRdqv6sWxKg0gDGCLWpqC/eqZ1/Y8dg23weUALEqsk6C3kitfpF3T/Icu43oVUc8n5xw1k0AMQbJghr2yU6lbTdK6/bwGq+a2KUVIWHz4mJK8J3wYur91lCG5VZkQ+3ko4B4cg1eSq37gEuU1XbD40I0+Oeo97KtuQuxt7NziSsUI95Y+Fvmko54/1ilUBipkacilCfEvnNaaByzNh2aILq4R9SuCHasz7lVTm4UABfp8SLWscX9XSAupct6vnmTxwCV2iLi8Bt2SOFlPcwbFc2wpxHGVCQlDS9mBEO/slW3egmmPa7frSG8KhIj/TYJiw30N7m/6mR+S5UtmyTOrscMuASQfZ7CLmQpJ8owwr5zBxLo+WFL3HtKI6f0v3PrQ2OseA+EbJy6/lPF06RcUK6gEtHXUI0WdaOuatQw7SmrJvL9F7lSE6ZzuLLq5WfIh90Lrv4ouIgzU4sRNeDYVeO2K7YTMe7BuVQMPmmeu4jPFRfe8Z7MX3ISwbGggTH0HNLl14WExSEODpcSkbmSQkH6+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39830400003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(44832011)(4326008)(5660300002)(2906002)(38350700005)(6512007)(478600001)(6666004)(52116002)(6506007)(83380400001)(1076003)(26005)(2616005)(54906003)(66946007)(6916009)(36756003)(66556008)(316002)(66476007)(8936002)(8676002)(6486002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ivEnmKfwFgp7k4aGN+Nmi5hFJLhrP3h/fCmuDU3E00ZTYV5gHRu45Vnx1xGV?=
 =?us-ascii?Q?Mtqs5mmL2ROwGdZTN6GTf3+nDEszkKvhW1Rs032+sj2Wbr4C4US/pBsa5d5s?=
 =?us-ascii?Q?o8B5TYRKzpfccXGmR+tKzRr0spUwBQhBnCWYFj6iBJkvmgQdJ+Fk054Mn8+F?=
 =?us-ascii?Q?aSG/YAGU1o4jj/Hhm5JPENRtUZb+hWwhfR/7k+lKbyQWT7TkPMYcwgWIp3qL?=
 =?us-ascii?Q?Lr9c/tv9njBbZB1GGXF7Ao/9CPCc9JIGmXN3FwzshdD7glFITHjOvhylZByf?=
 =?us-ascii?Q?11DVDqrHH6qyJT30daxVQII30mDxTHwhqRqRcmpfRfj2PEJUwJ5QK9frFzMG?=
 =?us-ascii?Q?bllK73yUr/vNUErhnhbJ+R92ISg1ojbPeYExDsoFkWR1znNW0uWwR0DKpoX+?=
 =?us-ascii?Q?tFM+N27hUA6U7UPbC8H6EJ0CSkN6K6x1y33rUCkE1Ly2AMlO3CEWn4lQLLhf?=
 =?us-ascii?Q?t3wkpXkJSDl2p8SGe0Rb6GjLHFia4rjGsEbnyubDDOdZz0YaYW7WgTHjKfdF?=
 =?us-ascii?Q?Pjhm4kpQl5oK/TZGk7iPabRRiM1mashMFT5U10OSuI7cvVdgj8Gm1t3Y1etP?=
 =?us-ascii?Q?RjnIQ3Mya1G+2Y2+fpINmKJaY+V6i5ZBb1yjDx6Nz2k8+RRl8S7q5p1dND1G?=
 =?us-ascii?Q?bA2R2PM1zTHNCkrL0xUZ+Xo53pny3PgcJ3w/YiqXpTJfDx7nWG0zblp3zuis?=
 =?us-ascii?Q?XfwKSpBUMo63V09MExjc06G/yJwSqCfxuwbaZ6RNo1uDN2H4Hz+UduAPGiL7?=
 =?us-ascii?Q?AAU9lI7y3yvT9PmmKPEnUo8+jUHD+ZUjnAv1tfllTD31p/x0G0EkskzAZ/YX?=
 =?us-ascii?Q?2xdqwPa+yXpg33K7uUxxFfypZev5ddAzpcZH+4Fq/ynzrb9mDOZA3wvfp4Q/?=
 =?us-ascii?Q?8jiFxOsYNK80k81JR+oZiuyMEgyoX6dPlOKl52gcKSh6qrucs80c4G0n8NeM?=
 =?us-ascii?Q?5AlwufWRgbnVugpMOg4Xbg0vsnFyUyYYtXVexH9hmLu5iYt0H3IkAWX8Jptf?=
 =?us-ascii?Q?w7gNs7ZJAcMZEPNOlQhVgJiqrhi6r86Cv7QxNGhDl/v5arGX5ZihNMqQn0AT?=
 =?us-ascii?Q?wCBTCizQK+UQxGpQLj+KZRi+q6n5H/XNyu6I8DEU4CBiMABAEi3QIQSkpbRv?=
 =?us-ascii?Q?2hpmw5NY5JhgdpnwNl4vuEHKKOhCdTJLT/j+NDWY63ouisNcSkZuSroRuAv+?=
 =?us-ascii?Q?7mpcLE3Wdc+tsPImzlOsjQd92beqWl/rI/NY+2AIwL0h85A43gZLyKLG+IcP?=
 =?us-ascii?Q?PX4X1dCfP5XCqBXzMX7JEgXYgf7v59O6MshAWlksGbnnYWpcvqBw9OuDRQG9?=
 =?us-ascii?Q?yQ7yn4Ikr+PXfIMmFU7cZliuqA9FOkEIzYOiEYewCpO+ckht22537EP9qAR7?=
 =?us-ascii?Q?5BfjvLZM+T00qimymAuNctF+N5T3YzcYcUXPLBHv4Sz5WiIZLdKrBYYJG5dK?=
 =?us-ascii?Q?Musco3FhbXiknvt6krkZWPPrwbDB8XuRz+z9EilD4X9/Co4aNjouPQfK5Ck4?=
 =?us-ascii?Q?ULXvJxWw4qjJ7wT63mui+5Q0qqP5J9WkidQuR+IWETrSRqZg5itGpjFXUn9+?=
 =?us-ascii?Q?bSJxW5/wvr17MA6zpBPWzdG1jXZd9jMdOyRj+BYXqvBeJLy/I6CyIS9ErWOA?=
 =?us-ascii?Q?QDr2yg3Xe4BeWHEfKHhP+Ao=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 486f088f-aa27-4a7d-0643-08dc0ea0570d
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 10:14:59.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfwWCD2dhq/qc3YICx+Mvy2nYK8CqJRlsLww2ms4Bok6zP7QpMGi/mbVSVow0n1rj6uqxye7LROFLIpvyXBaPGDw1JYeiet/1H+5Yu13J4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6415

Adding support for stc3117 fuel gauge driver with
minimal functionality to read voltage level currently

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 drivers/power/supply/Kconfig              |   7 ++
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 136 ++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f21cb05815ec..02df55b0d5f0 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -875,6 +875,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+	tristate "STMicroelectronics STC3117 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for fuel gauge with STC3117
+	  PMIC chips.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..f8ed3e5a8882 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)	+= stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..bb033ac54858
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ */
+
+
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/power_supply.h>
+
+#define VOLTAGE_REG_ADDR	0x08
+#define VOLTAGE_REG_ADDR_SIZE	1		//in bytes
+#define VOLTAGE_DATA_SIZE	2		//in bytes
+#define LSB_VALUE		2200		//in micro-volts
+
+
+static int stc3117_probe(struct i2c_client *client);
+static void stc3117_dev_remove(struct i2c_client *client);
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val);
+static int stc3117_get_batt_volt(const struct i2c_client *client);
+
+const struct i2c_client *tmp_client;
+struct power_supply *stc_sply;
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117-fgu" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static const struct i2c_device_id stc3117_id[] = {
+	{"stc3117", 0},
+	{},
+};
+
+
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(stc3117_of_match),
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+	.remove = stc3117_dev_remove,
+};
+
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = stc3117_get_batt_volt(tmp_client);
+	break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+
+static int stc3117_get_batt_volt(const struct i2c_client *stc_client)
+{
+	int ret, volt = 0;
+	char i2c_tx = VOLTAGE_REG_ADDR, i2c_rx[2] = {0};
+
+	ret = i2c_master_send(stc_client, &i2c_tx, VOLTAGE_REG_ADDR_SIZE);
+	if (ret > 0) {
+
+		ret = i2c_master_recv(stc_client, i2c_rx, VOLTAGE_DATA_SIZE);
+		if (ret > 0) {
+
+			volt = (i2c_rx[1] << 8) + i2c_rx[0];
+			volt *= LSB_VALUE;
+
+			return volt;
+		}
+	}
+
+	return ret;
+}
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev;
+
+	dev = &client->dev;
+
+	psy_cfg.of_node = dev->of_node;
+
+	tmp_client = client;
+
+	stc_sply = power_supply_register(dev, &stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(stc_sply))
+		pr_err("failed to register battery\n");
+
+	return 0;
+}
+
+static void stc3117_dev_remove(struct i2c_client *client)
+{
+	power_supply_unregister(stc_sply);
+}
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
+MODULE_VERSION("v1.0");
+
-- 
2.34.1


