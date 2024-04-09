Return-Path: <linux-kernel+bounces-137032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88E89DB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567551F220B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A961304AD;
	Tue,  9 Apr 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="VJPgVwCq"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2111.outbound.protection.outlook.com [40.107.14.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C767441A;
	Tue,  9 Apr 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670902; cv=fail; b=qEctxdjZ4yctO+2JT/1d5zhxMzvKHsNjl9GDSK7PrpZ+7jom86euuUxuvoR4n+3R3/XOkl028dt2WwbTwAjw1t+N2zesul2tR7TONsy8WtLikBRfa00qL2r909JawAk0B1Kh+wLZ0whqTEfSTdyQ+4Uyu/0A7IuIee5vGt0pFZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670902; c=relaxed/simple;
	bh=V3IoyQPlYVRN0zTYoA/SBKNNG0+pwbmAfVkTcycMy2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=unsVkZaL8V5WDE3+iG3ygxoLdL2wsVCrdQ4NDq67SA2fys7RG3nvUGR6Pwt/0Ge4KkY0PJrTQm1f+SqNsJkn80un9JTQilWpTMrOcWLc9j8AVEfN84Rwlx1uTMdm2M5L9TblTh9JxY0ce9nNEM7wPoBrYYI2kMe6XsHepfc8Ffc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=VJPgVwCq; arc=fail smtp.client-ip=40.107.14.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cScMfa4Na+Hq/LtJhKHkbqJEGE4/wM6zHIMC0DkSnqx+NCxdT64nVvkk8ydg9wK03UepWKjVCkiLlFm+r+hJybwQLaSBlHSIoQTjP5UUWd0IyKt2ZwA1JoSFdmm5JbwXdSG+WZnEj0LzhSjgwnUJN7b55RZUpgNgcXdSI8SXFWjUiCoq2q9EvPq6WrCEVwaLXGeNa1I24721PvwkZtUnusl0oEFdKxoDpTMwZDrQAIYCSWLEkFhuMuobZ+xd2AyM19cznnJAo7ZeT6ZNOTdN/gZ2/42T14lezoDWp2t3CAL3h8J8VhBydla7lj6SjhHiLvPDEoSDtWduDdMugHdO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUnxNurspwOQDTcytuu6PKQIopLOS5c87zx4dYmefcA=;
 b=cHtTgbJOzrfAauM1xw10+NMrdtzda5/LLzBdOLLSN1teN8FxFRWIJeQngr8lkuL+fa5DmOX7tq+dRpsP27muDXtnAMX6G0TcBd2MiUNGRZ2/o1XFQu/TproEhKADhD9idMR41tOV5cPda2v+WFBgRaCV2i8tqAHN2KeAJ5R8jQljcRIx51rYfgXOF8vBn19GelFNiiuKOlAaIRBp3rcX0ZRklI2KTJSRJKU3pR5g0+lFtreJb2vmxXEriFYz+PIiqLm5CVUP7LlZumaMAjVMJus6zCPSzSLDOEDgOyeTZX25u0dxOGgc0eFevwe82Vz7ts+LpwsR2O80Tu2Ea3yH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUnxNurspwOQDTcytuu6PKQIopLOS5c87zx4dYmefcA=;
 b=VJPgVwCqFTLMtsDdxSAMHibSSlTMOijJCGGETj+51eiOPO8B6OYv3r8vLL4FloJdptUc2+ZGkyR4B64CCLLyIZcqtoa89Wb9y4RXkqjjjyBEgcEC7ZjCZE8JddFyOCsulcWTawUWVhaMskyf0oaglcJSrnw/XGrzvTyknoSvOOL2H4i0utqL8RwEYEhcjbsDk8lGE/4HxUdJSC7Exy0lwOrqqzomMCCwUJhl6FUi+p9Wmw9/k0dkPhnpBW4eLPi7lb4DVGuf/KlX0ZQva0vbqILbq6ukHoJe9Ad6JonI9qDmKIsIKwY8hrSvpQvGV1TWSrui0A/GnbVyUYrlwvYtQg==
Received: from AM9P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::8)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:54:53 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:21c:cafe::5) by AM9P250CA0003.outlook.office365.com
 (2603:10a6:20b:21c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 13:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 13:54:53 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 Apr 2024 13:54:51 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:54:48 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 13:54:48 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] power: supply: ltc3350-charger: Add driver
Date: Tue, 9 Apr 2024 15:54:41 +0200
Message-ID: <20240409135442.37732-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409135442.37732-1-mike.looijmans@topic.nl>
References: <20240409135442.37732-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dab85cfc-973d-4930-8fea-324aa26b5801@emailsignatures365.codetwo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::26) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM8PR04MB7251:EE_|AM3PEPF0000A791:EE_|PA4PR04MB9639:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Q3VJezC2C/quzLXK4J1dMRw5YqU/z/dtONs+IugCGS+Lz03zq6sIIKJVM6PjThy5Odxq9358pjDZBANp7tu7LXWSbMTnjnVik414FscdkEtBAx3JvL+FqJd5Wg7lvgd5A3zBAxceO9W3zZXMwOcUmv2Yii5FD7VVrCKu+uWt7ufuh56yXxcch/nlG+Sgn04jA+Rub9IX5Eu0WYqhD9yEghwd8EmLLAv24JghL7Rvb9sCgrWo1jMV3g41sEMS/TTfnFCAlaj0PuAkqs8pM+pI3Fm7rr6g5ukbip2hsLYN0q8bPdk+o/HSuuoUahfInNozk7NtPnj2VMBuuODNISTtUQsCHb1O6MRPOiW8SWuadQDb0sQjaIKqaF/HWgsHub2fXJEjVxXlMrSUigeFJZI22QC2+Gt9EMMAF69VZUqcUjpAXTMCkcEcKPsLWDZNnUv6sK5XO2hwDkC/V+0TlMpvKdyFULjwrqozJq+KobA8LyAleuKvv9jepWUID6Jfu9lIMN9h5PNE7Jfm+L6JLPM0qP9KBbqXk/K6DbZQJQJNsgnip54XggBgOq8QNBlI133vkq4qCC0ksm35oCLgSVpx29cGPdv/D9PoGKHZ5tbU0MnGWuagZry4ABPaP7N8a2i/vNiqGry6Kd+c89c42V01wWutwy53JzGULek1Eyp5niP07ifECqDj7JeR/3lWyBx7K6lnIsKWKJoXlLl2cy4OjvyEu9HugifsUGPftbYAMqY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251
X-CodeTwo-MessageID: b5d33d15-a206-495d-8c41-f143b08493b9.20240409135451@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e00242ca-f06b-4238-0e4f-08dc589ca1e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HHmXNZ9YoDXff+q2awcLlu2Bbe4fEdWxNH3QNte5dYGAVfeY/fZPpkj+ObHWXpEpfoz+c1B67X9a+hRQzdrA5Xqj6JmF+HK4abywJJBbFY2xp8AaqrhsMcxVFgqnVtxS8Dx5rO0c5yT1wHjTzwbBZua/Ij3XaYHmKV6AOFpxF+xNEcOVsq8AVMKzKkvHc00iBlcfeW8YO0lhgc2DwodYcK0jElZ5GnE5Uwyt0w3jQQ2O/sni0z/d+isHpRDuZvHlEmuobUcOcXTH13Fl0IJmS6dVbIyhokcWx7wEffPUORlrKULwAajLRjcwhQT1cTQyyy8w+jAWibLCP4RvuKgixMqWylDMxzIHfC7RHdJmv04L3Vl9BvLd9GPBcJFm4nOT8Erg13bo3CoMmLXQ4p2mzxqhes90cZTv9+inMZUId5v9mOYqX9gwoiPZVJd5xwoeNcPgclhVABxaMa8Ri1ryohWtETo3GLOc2NDz58yagrsPwzK5LYa+tkXE9Vm4oR+W9wC5emtHW5V36D94Az7AcYq9IDvgdqP+8TzYdZD5kHNaW+ge21kWMbduSlN9BNGwo/VPmh6GmfZu7fgHe/E4henW4WmKksFs/KcS0OwkMj+CKEsRpR+BE0oSaaW9CuDqUSfU93RUhZ+C6ti+0MzlFM6c8OFpAdrZTpruydK3izv4FhpWpMguDT60c5kfbO/NSsjD/TmWrSUpZIBJzOAryg==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:54:53.3625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00242ca-f06b-4238-0e4f-08dc589ca1e8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

(no changes since v2)

Changes in v2:
Duplicate "vin_ov" and "vin_uv" attributes

 drivers/power/supply/Kconfig           |  10 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/ltc3350-charger.c | 718 +++++++++++++++++++++++++
 3 files changed, 729 insertions(+)
 create mode 100644 drivers/power/supply/ltc3350-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..7cb1a66e522d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -514,6 +514,16 @@ config CHARGER_LT3651
 	  Say Y to include support for the Analog Devices (Linear Technology)
 	  LT3651 battery charger which reports its status via GPIO lines.
=20
+config CHARGER_LTC3350
+	tristate "LTC3350 Supercapacitor Backup Controller and System Monitor"
+	depends on I2C
+	select REGMAP_I2C
+	select I2C_SMBUS
+	help
+	  Say Y to include support for the Analog Devices (Linear Technology)
+	  LTC3350 Supercapacitor Backup Controller and System Monitor connected
+	  to I2C.
+
 config CHARGER_LTC4162L
 	tristate "LTC4162-L charger"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..a8d618e4ac91 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
 obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
+obj-$(CONFIG_CHARGER_LTC3350)	+=3D ltc3350-charger.o
 obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
diff --git a/drivers/power/supply/ltc3350-charger.c b/drivers/power/supply/=
ltc3350-charger.c
new file mode 100644
index 000000000000..84c7a3ca914e
--- /dev/null
+++ b/drivers/power/supply/ltc3350-charger.c
@@ -0,0 +1,718 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Analog Devices (Linear Technology) LTC3350
+ * High Current Supercapacitor Backup Controller and System Monitor
+ * Copyright (C) 2024, Topic Embedded Products
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/power_supply.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+/* Registers (names based on what datasheet uses) */
+#define LTC3350_REG_CLR_ALARMS		0x00
+#define LTC3350_REG_MSK_ALARMS		0x01
+#define LTC3350_REG_MSK_MON_STATUS	0x02
+#define LTC3350_REG_CAP_ESR_PER		0x04
+#define LTC3350_REG_VCAPFB_DAC		0x05
+#define LTC3350_REG_VSHUNT		0x06
+#define LTC3350_REG_CAP_UV_LVL		0x07
+#define LTC3350_REG_CAP_OV_LVL		0x08
+#define LTC3350_REG_GPI_UV_LVL		0x09
+#define LTC3350_REG_GPI_OV_LVL		0x0A
+#define LTC3350_REG_VIN_UV_LVL		0x0B
+#define LTC3350_REG_VIN_OV_LVL		0x0C
+#define LTC3350_REG_VCAP_UV_LVL		0x0D
+#define LTC3350_REG_VCAP_OV_LVL		0x0E
+#define LTC3350_REG_VOUT_UV_LVL		0x0F
+#define LTC3350_REG_VOUT_OV_LVL		0x10
+#define LTC3350_REG_IIN_OC_LVL		0x11
+#define LTC3350_REG_ICHG_UC_LVL		0x12
+#define LTC3350_REG_DTEMP_COLD_LVL	0x13
+#define LTC3350_REG_DTEMP_HOT_LVL	0x14
+#define LTC3350_REG_ESR_HI_LVL		0x15
+#define LTC3350_REG_CAP_LO_LVL		0x16
+#define LTC3350_REG_CTL_REG		0x17
+#define LTC3350_REG_NUM_CAPS		0x1A
+#define LTC3350_REG_CHRG_STATUS		0x1B
+#define LTC3350_REG_MON_STATUS		0x1C
+#define LTC3350_REG_ALARM_REG		0x1D
+#define LTC3350_REG_MEAS_CAP		0x1E
+#define LTC3350_REG_MEAS_ESR		0x1F
+#define LTC3350_REG_MEAS_VCAP1		0x20
+#define LTC3350_REG_MEAS_VCAP2		0x21
+#define LTC3350_REG_MEAS_VCAP3		0x22
+#define LTC3350_REG_MEAS_VCAP4		0x23
+#define LTC3350_REG_MEAS_GPI		0x24
+#define LTC3350_REG_MEAS_VIN		0x25
+#define LTC3350_REG_MEAS_VCAP		0x26
+#define LTC3350_REG_MEAS_VOUT		0x27
+#define LTC3350_REG_MEAS_IIN		0x28
+#define LTC3350_REG_MEAS_ICHG		0x29
+#define LTC3350_REG_MEAS_DTEMP		0x2A
+
+/* LTC3350_REG_CLR_ALARMS, LTC3350_REG_MASK_ALARMS, LTC3350_REG_ALARM_REG =
*/
+#define LTC3350_MSK_CAP_UV	BIT(0)	/* capacitor undervoltage alarm */
+#define LTC3350_MSK_CAP_OV	BIT(1)	/* capacitor overvoltage alarm */
+#define LTC3350_MSK_GPI_UV	BIT(2)	/* GPI undervoltage alarm */
+#define LTC3350_MSK_GPI_OV	BIT(3)	/* GPI overvoltage alarm */
+#define LTC3350_MSK_VIN_UV	BIT(4)	/* VIN undervoltage alarm */
+#define LTC3350_MSK_VIN_OV	BIT(5)	/* VIN overvoltage alarm */
+#define LTC3350_MSK_VCAP_UV	BIT(6)	/* VCAP undervoltage alarm */
+#define LTC3350_MSK_VCAP_OV	BIT(7)	/* VCAP overvoltage alarm */
+#define LTC3350_MSK_VOUT_UV	BIT(8)	/* VOUT undervoltage alarm */
+#define LTC3350_MSK_VOUT_OV	BIT(9)	/* VOUT overvoltage alarm */
+#define LTC3350_MSK_IIN_OC	BIT(10)	/* input overcurrent alarm */
+#define LTC3350_MSK_ICHG_UC	BIT(11)	/* charge undercurrent alarm */
+#define LTC3350_MSK_DTEMP_COLD	BIT(12)	/* die temperature cold alarm */
+#define LTC3350_MSK_DTEMP_HOT	BIT(13)	/* die temperature hot alarm */
+#define LTC3350_MSK_ESR_HI	BIT(14)	/* ESR high alarm */
+#define LTC3350_MSK_CAP_LO	BIT(15)	/* capacitance low alarm */
+
+/* LTC3350_REG_MSK_MON_STATUS masks */
+#define LTC3350_MSK_MON_CAPESR_ACTIVE		BIT(0)
+#define LTC3350_MSK_MON_CAPESR_SCHEDULED	BIT(1)
+#define LTC3350_MSK_MON_CAPESR_PENDING		BIT(2)
+#define LTC3350_MSK_MON_CAP_DONE		BIT(3)
+#define LTC3350_MSK_MON_ESR_DONE		BIT(4)
+#define LTC3350_MSK_MON_CAP_FAILED		BIT(5)
+#define LTC3350_MSK_MON_ESR_FAILED		BIT(6)
+#define LTC3350_MSK_MON_POWER_FAILED		BIT(8)
+#define LTC3350_MSK_MON_POWER_RETURNED		BIT(9)
+
+/* LTC3350_REG_CTL_REG */
+/* Begin a capacitance and ESR measurement when possible */
+#define LTC3350_CTL_STRT_CAPESR		BIT(0)
+/* A one in this bit location enables the input buffer on the GPI pin */
+#define LTC3350_CTL_GPI_BUFFER_EN	BIT(1)
+/* Stops an active capacitance/ESR measurement */
+#define LTC3350_CTL_STOP_CAPESR		BIT(2)
+/* Increases capacitor measurement resolution by 100x for smaller capacito=
rs */
+#define LTC3350_CTL_CAP_SCALE		BIT(3)
+
+/* LTC3350_REG_CHRG_STATUS */
+#define LTC3350_CHRG_STEPDOWN	BIT(0)	/* Synchronous controller in step-dow=
n mode (charging) */
+#define LTC3350_CHRG_STEPUP	BIT(1)	/* Synchronous controller in step-up mo=
de (backup) */
+#define LTC3350_CHRG_CV		BIT(2)	/* The charger is in constant voltage mode=
 */
+#define LTC3350_CHRG_UVLO	BIT(3)	/* The charger is in undervoltage lockout=
 */
+#define LTC3350_CHRG_INPUT_ILIM	BIT(4)	/* The charger is in input current =
limit */
+#define LTC3350_CHRG_CAPPG	BIT(5)	/* The capacitor voltage is above power =
good threshold */
+#define LTC3350_CHRG_SHNT	BIT(6)	/* The capacitor manager is shunting */
+#define LTC3350_CHRG_BAL	BIT(7)	/* The capacitor manager is balancing */
+#define LTC3350_CHRG_DIS	BIT(8)	/* Charger disabled for capacitance measur=
ement */
+#define LTC3350_CHRG_CI		BIT(9)	/* The charger is in constant current mode=
 */
+#define LTC3350_CHRG_PFO	BIT(11)	/* Input voltage is below PFI threshold *=
/
+
+/* LTC3350_REG_MON_STATUS */
+#define LTC3350_MON_CAPESR_ACTIVE	BIT(0)	/* Capacitance/ESR measurement in=
 progress */
+#define LTC3350_MON_CAPESR_SCHEDULED	BIT(1)	/* Waiting programmed time */
+#define LTC3350_MON_CAPESR_PENDING	BIT(2)	/* Waiting for satisfactory cond=
itions */
+#define LTC3350_MON_CAP_DONE		BIT(3)	/* Capacitance measurement has comple=
ted */
+#define LTC3350_MON_ESR_DONE		BIT(4)	/* ESR Measurement has completed */
+#define LTC3350_MON_CAP_FAILED		BIT(5)	/* Last capacitance measurement fai=
led */
+#define LTC3350_MON_ESR_FAILED		BIT(6)	/* Last ESR measurement failed */
+#define LTC3350_MON_POWER_FAILED	BIT(8)	/* Unable to charge */
+#define LTC3350_MON_POWER_RETURNED	BIT(9)	/* Able to charge */
+
+
+struct ltc3350_info {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct power_supply	*charger;
+	u32 rsnsc;	/* Series resistor that sets charge current, microOhm */
+	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
+};
+
+/*
+ * About LTC3350 "alarm" functions: Setting a bit in the LTC3350_REG_MSK_A=
LARMS
+ * register enables the alarm. The alarm will trigger an SMBALERT only onc=
e.
+ * To reset the alarm, write a "1" bit to LTC3350_REG_CLR_ALARMS. Then the=
 alarm
+ * will trigger another SMBALERT when conditions are met (may be immediate=
ly).
+ * After writing to one of the corresponding level registers, enable the a=
larm,
+ * so that a UEVENT triggers when the alarm goes off.
+ */
+static void ltc3350_enable_alarm(struct ltc3350_info *info, unsigned int r=
eg)
+{
+	unsigned int mask;
+
+	/* Register locations correspond to alarm mask bits */
+	mask =3D BIT(reg - LTC3350_REG_CAP_UV_LVL);
+	/* Clear the alarm bit so it may trigger again */
+	regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, mask);
+	/* Enable the alarm */
+	regmap_update_bits(info->regmap, LTC3350_REG_MSK_ALARMS, mask, mask);
+}
+
+/* Convert enum value to POWER_SUPPLY_STATUS value */
+static int ltc3350_state_decode(unsigned int value)
+{
+	if (value & LTC3350_CHRG_STEPUP)
+		return POWER_SUPPLY_STATUS_DISCHARGING; /* running on backup */
+
+	if (value & LTC3350_CHRG_PFO)
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	if (value & LTC3350_CHRG_STEPDOWN) {
+		/* The chip remains in CV mode indefinitely, hence "full" */
+		if (value & LTC3350_CHRG_CV)
+			return POWER_SUPPLY_STATUS_FULL;
+
+		return POWER_SUPPLY_STATUS_CHARGING;
+	}
+
+	/* Not in step down? Must be full then (never seen this) */
+	return POWER_SUPPLY_STATUS_FULL;
+};
+
+static int ltc3350_get_status(struct ltc3350_info *info, union power_suppl=
y_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	val->intval =3D ltc3350_state_decode(regval);
+
+	return 0;
+}
+
+static int ltc3350_charge_status_decode(unsigned int value)
+{
+	if (!(value & LTC3350_CHRG_STEPDOWN))
+		return POWER_SUPPLY_CHARGE_TYPE_NONE;
+
+	/* constant voltage is "topping off" */
+	if (value & LTC3350_CHRG_CV)
+		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+
+	/* input limiter */
+	if (value & LTC3350_CHRG_INPUT_ILIM)
+		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
+
+	/* constant current is "fast" */
+	if (value & LTC3350_CHRG_CI)
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+
+	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+}
+
+static int ltc3350_get_charge_type(struct ltc3350_info *info, union power_=
supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	val->intval =3D ltc3350_charge_status_decode(regval);
+
+	return 0;
+}
+
+static int ltc3350_get_online(struct ltc3350_info *info, union power_suppl=
y_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MON_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	/* indicates if input voltage is sufficient to charge */
+	val->intval =3D !!(regval & LTC3350_MON_POWER_RETURNED);
+
+	return 0;
+}
+
+static int ltc3350_get_input_voltage(struct ltc3350_info *info, union powe=
r_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_VIN, &regval);
+	if (ret)
+		return ret;
+
+	/* 2.21mV/LSB */
+	val->intval =3D  regval * 2210;
+
+	return 0;
+}
+
+static int ltc3350_get_input_current(struct ltc3350_info *info, union powe=
r_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_IIN, &regval);
+	if (ret)
+		return ret;
+
+	/* 1.983=C2=B5V/RSNSI amperes per LSB */
+	ret =3D regval * 19830;
+	ret /=3D info->rsnsi;
+	ret *=3D 100;
+
+	val->intval =3D ret;
+
+	return 0;
+}
+
+static int ltc3350_get_icharge(struct ltc3350_info *info, union power_supp=
ly_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_ICHG, &regval);
+	if (ret)
+		return ret;
+
+	/* 1.983=C2=B5V/RSNSC amperes per LSB */
+	ret =3D regval * 19830;
+	ret /=3D info->rsnsc;
+	ret *=3D 100;
+
+	val->intval =3D ret;
+
+	return 0;
+}
+
+static int ltc3350_get_icharge_max(struct ltc3350_info *info, union power_=
supply_propval *val)
+{
+	/* I_CHG(MAX) =3D 32mV / RSNSC (Ampere) */
+	val->intval =3D 3200000000U / (info->rsnsc / 10);
+
+	return 0;
+}
+
+static int ltc3350_get_iin_max(struct ltc3350_info *info, union power_supp=
ly_propval *val)
+{
+	/* I_IN(MAX) =3D 32mV / RSNSI (Ampere) */
+	val->intval =3D 3200000000U / (info->rsnsi / 10);
+
+	return 0;
+}
+
+
+static int ltc3350_get_die_temp(struct ltc3350_info *info, unsigned int re=
g,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
+	ret =3D 280 * regval;
+	ret /=3D 100; /* Centidegrees scale */
+	ret -=3D 25140;
+	val->intval =3D ret;
+
+	return 0;
+}
+
+static int ltc3350_set_die_temp(struct ltc3350_info *info, unsigned int re=
g, int val)
+{
+	unsigned int regval;
+	int ret;
+
+	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
+	regval =3D val + 25140;
+	regval *=3D 100;
+	regval /=3D 280;
+
+	ret =3D regmap_write(info->regmap, reg, regval);
+	if (ret)
+		return ret;
+
+	ltc3350_enable_alarm(info, reg);
+	return 0;
+}
+
+/* Custom properties */
+
+static ssize_t ltc3350_attr_show(struct device *dev,
+				 struct device_attribute *attr, char *buf,
+				 unsigned int reg, unsigned int scale)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	regval *=3D scale; /* Scale is in 10 =CE=BCV units */
+	regval /=3D 10;
+
+	return sprintf(buf, "%u\n", regval);
+}
+
+static ssize_t ltc3350_attr_store(struct device *dev, struct device_attrib=
ute *attr,
+				  const char *buf, size_t count,
+				  unsigned int reg, unsigned int scale)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	unsigned long val;
+	int ret;
+
+	ret =3D kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	val *=3D 10;
+	val =3D DIV_ROUND_CLOSEST(val, scale); /* Scale is in 10 =CE=BCV units */
+
+	ret =3D regmap_write(info->regmap, reg, val);
+	if (ret)
+		return ret;
+
+	/* When writing to one of the LVL registers, update the alarm mask */
+	if (reg >=3D LTC3350_REG_CAP_UV_LVL && reg <=3D LTC3350_REG_CAP_LO_LVL)
+		ltc3350_enable_alarm(info, reg);
+
+	return count;
+}
+
+#define LTC3350_DEVICE_ATTR_RO(_name, _reg, _scale)				\
+static ssize_t _name##_show(struct device *dev, struct device_attribute *a=
ttr,	\
+			    char *buf)						\
+{										\
+	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
+}										\
+static DEVICE_ATTR_RO(_name)
+
+#define LTC3350_DEVICE_ATTR_RW(_name, _reg, _scale)				\
+static ssize_t _name##_show(struct device *dev, struct device_attribute *a=
ttr,	\
+			    char *buf)						\
+{										\
+	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
+}										\
+static ssize_t _name##_store(struct device *dev, struct device_attribute *=
attr, \
+			     const char *buf, size_t count)			\
+{										\
+	return ltc3350_attr_store(dev, attr, buf, count, _reg, _scale);		\
+}										\
+static DEVICE_ATTR_RW(_name)
+
+/* Shunt voltage, 183.5=CE=BCV per LSB */
+LTC3350_DEVICE_ATTR_RW(vshunt, LTC3350_REG_VSHUNT, 1835);
+
+/* Single capacitor voltages, 183.5=CE=BCV per LSB */
+LTC3350_DEVICE_ATTR_RO(vcap1, LTC3350_REG_MEAS_VCAP1, 1835);
+LTC3350_DEVICE_ATTR_RO(vcap2, LTC3350_REG_MEAS_VCAP2, 1835);
+LTC3350_DEVICE_ATTR_RO(vcap3, LTC3350_REG_MEAS_VCAP3, 1835);
+LTC3350_DEVICE_ATTR_RO(vcap4, LTC3350_REG_MEAS_VCAP4, 1835);
+LTC3350_DEVICE_ATTR_RW(cap_uv, LTC3350_REG_CAP_UV_LVL, 1835);
+LTC3350_DEVICE_ATTR_RW(cap_ov, LTC3350_REG_CAP_OV_LVL, 1835);
+
+/* General purpose input, 183.5=CE=BCV per LSB */
+LTC3350_DEVICE_ATTR_RO(gpi, LTC3350_REG_MEAS_GPI, 1835);
+LTC3350_DEVICE_ATTR_RW(gpi_uv, LTC3350_REG_GPI_UV_LVL, 1835);
+LTC3350_DEVICE_ATTR_RW(gpi_ov, LTC3350_REG_GPI_OV_LVL, 1835);
+
+/* Input voltage, 2.21mV per LSB */
+LTC3350_DEVICE_ATTR_RO(vin, LTC3350_REG_MEAS_VIN, 22100);
+LTC3350_DEVICE_ATTR_RW(vin_uv, LTC3350_REG_VIN_UV_LVL, 22100);
+LTC3350_DEVICE_ATTR_RW(vin_ov, LTC3350_REG_VIN_OV_LVL, 22100);
+
+/* Capacitor stack voltage, 1.476 mV per LSB */
+LTC3350_DEVICE_ATTR_RO(vcap, LTC3350_REG_MEAS_VCAP, 14760);
+LTC3350_DEVICE_ATTR_RW(vcap_uv, LTC3350_REG_VCAP_UV_LVL, 14760);
+LTC3350_DEVICE_ATTR_RW(vcap_ov, LTC3350_REG_VCAP_OV_LVL, 14760);
+
+/* Output, 2.21mV per LSB */
+LTC3350_DEVICE_ATTR_RO(vout, LTC3350_REG_MEAS_VOUT, 22100);
+LTC3350_DEVICE_ATTR_RW(vout_uv, LTC3350_REG_VOUT_UV_LVL, 22100);
+LTC3350_DEVICE_ATTR_RW(vout_ov, LTC3350_REG_VOUT_OV_LVL, 22100);
+
+static ssize_t num_caps_show(struct device *dev, struct device_attribute *=
attr, char *buf)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_NUM_CAPS, &regval);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", regval + 1);
+}
+static DEVICE_ATTR_RO(num_caps);
+
+static ssize_t charge_status_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", regval);
+}
+static DEVICE_ATTR_RO(charge_status);
+
+static struct attribute *ltc3350_sysfs_entries[] =3D {
+	&dev_attr_vshunt.attr,
+	&dev_attr_vcap1.attr,
+	&dev_attr_vcap2.attr,
+	&dev_attr_vcap3.attr,
+	&dev_attr_vcap4.attr,
+	&dev_attr_cap_uv.attr,
+	&dev_attr_cap_ov.attr,
+	&dev_attr_gpi.attr,
+	&dev_attr_gpi_uv.attr,
+	&dev_attr_gpi_ov.attr,
+	&dev_attr_vin.attr,
+	&dev_attr_vin_uv.attr,
+	&dev_attr_vin_ov.attr,
+	&dev_attr_vcap.attr,
+	&dev_attr_vcap_uv.attr,
+	&dev_attr_vcap_ov.attr,
+	&dev_attr_vout.attr,
+	&dev_attr_vout_uv.attr,
+	&dev_attr_vout_ov.attr,
+	&dev_attr_num_caps.attr,
+	&dev_attr_charge_status.attr,
+	NULL,
+};
+
+static const struct attribute_group ltc3350_attr_group =3D {
+	.name	=3D NULL,	/* put in device directory */
+	.attrs	=3D ltc3350_sysfs_entries,
+};
+
+static const struct attribute_group *ltc3350_attr_groups[] =3D {
+	&ltc3350_attr_group,
+	NULL,
+};
+
+static int ltc3350_get_property(struct power_supply *psy, enum power_suppl=
y_property psp,
+				union power_supply_propval *val)
+{
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return ltc3350_get_status(info, val);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return ltc3350_get_charge_type(info, val);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return ltc3350_get_online(info, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return ltc3350_get_input_voltage(info, val);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return ltc3350_get_input_current(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return ltc3350_get_icharge(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return ltc3350_get_icharge_max(info, val);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return ltc3350_get_iin_max(info, val);
+	case POWER_SUPPLY_PROP_TEMP:
+		return ltc3350_get_die_temp(info, LTC3350_REG_MEAS_DTEMP, val);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc3350_set_property(struct power_supply *psy, enum power_suppl=
y_property psp,
+				const union power_supply_propval *val)
+{
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val->intva=
l);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val->intval=
);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc3350_property_is_writeable(struct power_supply *psy, enum po=
wer_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/* Charger power supply property routines */
+static enum power_supply_property ltc3350_properties[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+};
+
+static const struct power_supply_desc ltc3350_desc =3D {
+	.name		=3D "ltc3350",
+	.type		=3D POWER_SUPPLY_TYPE_MAINS,
+	.properties	=3D ltc3350_properties,
+	.num_properties	=3D ARRAY_SIZE(ltc3350_properties),
+	.get_property	=3D ltc3350_get_property,
+	.set_property	=3D ltc3350_set_property,
+	.property_is_writeable =3D ltc3350_property_is_writeable,
+};
+
+static bool ltc3350_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	/* all registers up to this one are writeable */
+	return reg < LTC3350_REG_NUM_CAPS;
+}
+
+static bool ltc3350_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* read-only status registers and self-clearing register */
+	return reg > LTC3350_REG_NUM_CAPS || reg =3D=3D LTC3350_REG_CLR_ALARMS;
+}
+
+static const struct regmap_config ltc3350_regmap_config =3D {
+	.reg_bits	=3D 8,
+	.val_bits	=3D 16,
+	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
+	.writeable_reg	=3D ltc3350_is_writeable_reg,
+	.volatile_reg	=3D ltc3350_is_volatile_reg,
+	.max_register	=3D LTC3350_REG_MEAS_DTEMP,
+	.cache_type	=3D REGCACHE_MAPLE,
+};
+
+static int ltc3350_probe(struct i2c_client *client)
+{
+	struct i2c_adapter *adapter =3D client->adapter;
+	struct device *dev =3D &client->dev;
+	struct ltc3350_info *info;
+	struct power_supply_config ltc3350_config =3D {};
+	int ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
+		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
+		return -ENODEV;
+	}
+	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->client =3D client;
+	i2c_set_clientdata(client, info);
+
+	info->regmap =3D devm_regmap_init_i2c(client, &ltc3350_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		dev_err(dev, "Failed to initialize register map\n");
+		return PTR_ERR(info->regmap);
+	}
+
+	ret =3D device_property_read_u32(dev, "lltc,rsnsc-micro-ohms",
+				       &info->rsnsc);
+	if (ret) {
+		dev_err(dev, "Missing lltc,rsnsc-micro-ohms property\n");
+		return ret;
+	}
+	if (!info->rsnsc)
+		return -EINVAL;
+
+	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
+				       &info->rsnsi);
+	if (ret) {
+		dev_err(dev, "Missing lltc,rsnsi-micro-ohms property\n");
+		return ret;
+	}
+	if (!info->rsnsi)
+		return -EINVAL;
+
+	/* Clear and disable all interrupt sources*/
+	ret =3D regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, 0xFFFF);
+	if (ret) {
+		dev_err(dev, "Failed to write configuration\n");
+		return ret;
+	}
+	regmap_write(info->regmap, LTC3350_REG_MSK_ALARMS, 0);
+	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS, 0);
+
+	ltc3350_config.of_node =3D dev->of_node;
+	ltc3350_config.drv_data =3D info;
+	ltc3350_config.attr_grp =3D ltc3350_attr_groups;
+
+	info->charger =3D devm_power_supply_register(dev, &ltc3350_desc,
+						   &ltc3350_config);
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Failed to register charger\n");
+		return PTR_ERR(info->charger);
+	}
+
+	/* Enable interrupts on status changes */
+	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS,
+		     LTC3350_MON_POWER_FAILED | LTC3350_MON_POWER_RETURNED);
+
+	return 0;
+}
+
+static void ltc3350_alert(struct i2c_client *client, enum i2c_alert_protoc=
ol type,
+			  unsigned int flag)
+{
+	struct ltc3350_info *info =3D i2c_get_clientdata(client);
+
+	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
+		return;
+
+	power_supply_changed(info->charger);
+}
+
+static const struct i2c_device_id ltc3350_i2c_id_table[] =3D {
+	{ "ltc3350", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, ltc3350_i2c_id_table);
+
+static const struct of_device_id ltc3350_of_match[] =3D {
+	{ .compatible =3D "lltc,ltc3350", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc3350_of_match);
+
+static struct i2c_driver ltc3350_driver =3D {
+	.probe		=3D ltc3350_probe,
+	.alert		=3D ltc3350_alert,
+	.id_table	=3D ltc3350_i2c_id_table,
+	.driver =3D {
+		.name		=3D "ltc3350-charger",
+		.of_match_table	=3D of_match_ptr(ltc3350_of_match),
+	},
+};
+module_i2c_driver(ltc3350_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("LTC3350 charger driver");
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

