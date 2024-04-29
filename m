Return-Path: <linux-kernel+bounces-161646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB1A8B4EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B672832B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1445CBD;
	Mon, 29 Apr 2024 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s+uBZfJk"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2049.outbound.protection.outlook.com [40.92.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC363E;
	Mon, 29 Apr 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350673; cv=fail; b=J8IyFlCeWfyx3Pam0NZPKgOqbwQiQ0yPIcIQQiy54UIFgTX1vAdI+uLnWDTTOLqObpnEx5XLpVTHBtNXdorMuTCgdSduUSCL9Thc2/9mCDs3NPhCe72HKjsSDvohSaHZu11SPDDhboIqX9Mgd8heoG1aQG37tcN3+pFhQBsrhRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350673; c=relaxed/simple;
	bh=q3zhOghq+jUJx9ChL6rw8MHTHrKYXFx1qP+i4wq7ecg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYoI4HYaP5f2DiTYvdjDOaQ0OfOD+oTFeGz8b2VRFTSlNSoqdbs+JyvUukrJCRJJsOkPcidoyByAtxxUZkyvE2ua77XQKDtL6DoLf/qBHT23ni3qK4tyY8LS8wuqXRAnU+be/hJ1R5NUwcZWapHPUV5dcBm07flMLF32hXyuBlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s+uBZfJk; arc=fail smtp.client-ip=40.92.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN9TP52hMW5qrWi7MkjWvWH83ufd6PwDp1qWKfb/O1x8ftEVndNuOZJAQDPiCOsOA8bDKZJCP85tc23LJvlWeFeR+A8MuQgUC6ME58D5eDlz4lEe7Gjw2LxKup1fzVGEnJg6QFAluIxiKq1jEzOiFW9Q7QlQDY98r1BHPOzyJn2UAe0/1aDNqvqiP2c4ZIGE7DW9dgpIES5NV9RNAxZ18qS8RF4Zfp0EfKpwvhaoEKwfsJozPzM2hG6TNsPJULgGZktPxJw/qACLloWfWpwgNxYfTDoFCuNz3GEqnvqzMhmj/t7r8A5Bn5ZLzDM8PHFEjbEG4DgXMgVOrXzy17HmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPWNq2Rhrz/9Gd+qGmqORVrVawLKy7jj1FMAz9diJfk=;
 b=noCrBS7iO3NJK1G4oCSd/jOJ6mGdEQEXNy+sI02pl2a40mow2Rg3QjJVI/bJQjuSpEn+R4mCMr+0dZgyEbGJ7VbsS4WWarmG5bQ3oTvRuXHhCD+VHkojmJv+ILHCKD9hPj+fqhR3Lr74U5tCInfafX6nfzaT7jIcwxnVibD1w1b79mT+qSpFA8qPRKZUxHxL+6zmP6TkXFm27taPxAWSuW5eCuoYDOVC22W2Rz6bGX4GJsyPba2XXfuRwgY010W47+k3vyXrXx9mS2vSLlxe0QisLu4jNjHzLiTRo3/16YZ61ut7t5lN+Jcajl6GS6TmTanhw3g9uRChSi+8fRCKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPWNq2Rhrz/9Gd+qGmqORVrVawLKy7jj1FMAz9diJfk=;
 b=s+uBZfJkfny6zF9vr6312PoumxyY0aoVBauKlWQdKVNnocDpZHlVREwMsrS5QXk5h6eWiVHT6H96t3cy9mq2nxjvpeB663fP5mCP4jN6vZqurqK0Vcbverl29LNq6gL1haFGGhgU8f9dguwf5t98CGIW1A2QOSyFHk0Nplwn0P8ENa0xmgMD8joMeeJVoHwPtZLOXb5uh55nG5jc6SYFmNsSIll1E/EuysUHm+k2BGggDTDu+0nAdB3rtp1VMpp7GsMuFWJxKgkvpux8nkEg8sX83gAK5aZkHnCHOHPo/75AhHqsoA7VBC6CxIwLR8gqOpq+P25gC3qx0TvzcliDfg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB6850.namprd20.prod.outlook.com (2603:10b6:8:1aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 00:31:07 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 00:31:07 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
Date: Mon, 29 Apr 2024 08:31:12 +0800
Message-ID:
 <IA1PR20MB4953DB56AEA1607270EC2DA9BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QZb2mJKrn7Cfq4v5V2+TAfbsFMc2unHVw3i2Se5fLG8=]
X-ClientProxiedBy: TYCPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429003113.108667-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d15848-6386-4a66-7d2d-08dc67e3a8f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	YpGSDBwb7+jMlOCLz6T/A37qQfi7V8aGiel4Qs+l6LpPx2OwHG4HPRJEpGJhv6cJnlNK/E5KWPpjWZi4/sHdaeuCFscKXB8W9DGK4rTeuWvwu0HWwzZNeWx12Iz6uR+SPh+6B6zpzv8QsfBYk8oMxckfDtM6zHNkk1IB8GU2zSxphOB95ujajDvBvtH+Vu4KNctwYpgG8S/ooMc/WmHvXOsJ07Z5W5Qdb5dVpmFW8PifwFKEvmEtCAXJDzHWkIN8k8sm3SHWqkHSKkW5FUfuDSDcd9KhIvyYoSlRn0BBhgJhY428aCO9JQoCJKpn6rsyC1l5tvhvKWDCp/jdeVHYAga230I8LXsh8w4ss0s8rYsNc/uq5eu76MKtglumh6uXl5EWTbWUdEJd64sF1M6vDq0cN2yP0Bh1ugjLIMXGwjpADRyjQ/oibsjaOMpe26EFjn/t66/Vu9itGkeCDD/yAwxmo9ZVxIp6rhkNy9oVWumheyUu8FI2fc/mjpEzMqDOzcvNDUxWBx6U9hJQx7BgK080x+Q/WhhTMg8VUmaNKR68SpNigOvhVIDRFnYe31nmrurvLRWOpqmRdZCNAw0kCm/9oOgS3Rc6AjVQfKjMLNWPno9ZrFjWhaobYDs9bYEA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQP+p24g5rM8GnKo4K4bMhnm6U5VcInQE8JCEbm4nDXl9SPjJ/JRbuu7BOsJ?=
 =?us-ascii?Q?MuQCkIWEnmAevMHgNhN5BXrlSapo1Q0tPG+w6yRlHWeGck/jiqlOK/VwYr2c?=
 =?us-ascii?Q?zm6pzmG4fVpbQEQZNJIpPhVA95bjHnG8fmxt/tUUK0WNtq1W3AJeruBDMgf5?=
 =?us-ascii?Q?T2yNHzgm4l7UYWdv4MZQ1cZO9w7uqXnzwQMYuZ7VrB23Q2zuWlAkHZ1V60p/?=
 =?us-ascii?Q?FrO/C4dlgeqEcpeA9hSvDpZFh3Qsd561q7l0gQrTpQulMouzfVwjHjzl3rpb?=
 =?us-ascii?Q?AnYsKFsMtUQGdri0spHxgOYCe+G5ITh23ysAQSNHZ+f4uR4kvMAyjFyZDW0F?=
 =?us-ascii?Q?E7HxKBsBAKq3ch9Kx0/Vs9FyTJfjvZHPJ67XpHolK7RHfMY0Tc5Ge2r/zphA?=
 =?us-ascii?Q?JTd2fvOI2TslTNe06ZGyAQbuMrCP67EtaF2aoGFxuK/gZ/QPttbvGObOBZXY?=
 =?us-ascii?Q?kiZFi0AdkPvOmVE/rtktCJNqX9CUw5R8ctkN/+ohjEFdNPaVpWMpdzqXsmy3?=
 =?us-ascii?Q?cJHb7tx0WJEt5bJbIMj/tq+1Inul1ZJBZO2ktAGx7ekbD+FKqwaLzky3F54Z?=
 =?us-ascii?Q?eI1oTLrCp20No6ya0wYkC/vhft0Bn/YztctgjSmY3q36AOdcQ4wqVT6FPIJb?=
 =?us-ascii?Q?tDSPT6SpqScJVqvkp4DQsAvt2IGSO62iqXXZvrQDR0OgdicN9x/zxAV743MA?=
 =?us-ascii?Q?daijF7s7Viy5fZO1xyyjrDDu7dTrFTAtEm/BxSDHor1er0hiszYMcjSXH/Fi?=
 =?us-ascii?Q?8MR4nD8mXr1zAbWTK/YGZ9UbN6qwesjT5jkY9mb0g/DP1xFojdimH7jbc8nm?=
 =?us-ascii?Q?owfFRH3yI8/KGOhIS74BJdLb8IPqhvaGYqfhIKUiSHn+/R5UePm8Ws/cWw40?=
 =?us-ascii?Q?laFddxg9Rbnzs5QlOj8jPnq12RxmFa9H1W5EH6dL0B2QzWE4+Xd6ymb/dtJu?=
 =?us-ascii?Q?DUdCkvDpqySeDhYWyyIQdB525JCb/acJI0+v1uBxAb7+/I3hNfr6zF+yFx8q?=
 =?us-ascii?Q?xzQF9Xjo4I5eBZFSNrk2RGnFzF/X8KUSffchDo4JqHRQltTZpLKd6gyRHzZd?=
 =?us-ascii?Q?3Qcol1Ytgp5da3LxIxsxyo/WoGI5MgR5UZLiTtJKKV3Q3MJ0aqfewM5pMFr0?=
 =?us-ascii?Q?bYtHRScmNM0wtmdrtW+VLwi0I2Hv9zdbJFTqXxCat1GZBqk2Ufuhr4pHIySo?=
 =?us-ascii?Q?WlHy+7lDiHk08wbY6UmHCNrmWOdBNH99qRonH7QOSniWldmiMz/69F/25qrP?=
 =?us-ascii?Q?K10e6hOum3YTapHAXFwH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d15848-6386-4a66-7d2d-08dc67e3a8f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 00:31:07.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6850

Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/phy/Kconfig                 |   1 +
 drivers/phy/Makefile                |   1 +
 drivers/phy/sophgo/Kconfig          |  19 ++
 drivers/phy/sophgo/Makefile         |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c | 378 ++++++++++++++++++++++++++++
 5 files changed, 401 insertions(+)
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 787354b849c7..596b37ab3191 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -92,6 +92,7 @@ source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
+source "drivers/phy/sophgo/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 868a220ed0f6..7ff32f0ae08a 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
 					   rockchip/	\
 					   samsung/	\
 					   socionext/	\
+					   sophgo/	\
 					   st/		\
 					   starfive/	\
 					   sunplus/	\
diff --git a/drivers/phy/sophgo/Kconfig b/drivers/phy/sophgo/Kconfig
new file mode 100644
index 000000000000..b1c558de6616
--- /dev/null
+++ b/drivers/phy/sophgo/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for Sophgo platforms
+#
+
+if ARCH_SOPHGO || COMPILE_TEST
+
+config PHY_SOPHGO_CV1800_USB
+	tristate "Sophgo CV18XX/SG200X USB 2.0 PHY support"
+	depends on MFD_SYSCON
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB 2.0 PHY used with
+	  the DWC2 USB controller in Sophgo CV18XX/SG200X
+	  series SoC.
+	  If unsure, say N.
+
+endif # ARCH_SOPHGO || COMPILE_TEST
diff --git a/drivers/phy/sophgo/Makefile b/drivers/phy/sophgo/Makefile
new file mode 100644
index 000000000000..659537054cd4
--- /dev/null
+++ b/drivers/phy/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_SOPHGO_CV1800_USB)	+= phy-cv1800-usb.o
diff --git a/drivers/phy/sophgo/phy-cv1800-usb.c b/drivers/phy/sophgo/phy-cv1800-usb.c
new file mode 100644
index 000000000000..bf1b86f7aa1a
--- /dev/null
+++ b/drivers/phy/sophgo/phy-cv1800-usb.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/debugfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <soc/sophgo/cv1800-sysctl.h>
+
+#define PHY_IDPAD_C_OW			BIT(6)
+#define PHY_IDPAD_C_SW			BIT(7)
+
+#define PHY_BASE_CLK_RATE		300000000
+#define PHY_APP_CLK_RATE		125000000
+#define PHY_LPM_CLK_RATE		12000000
+#define PHY_STB_CLK_RATE		333334
+
+#define PHY_VBUS_DET_DEBOUNCE_TIME	usecs_to_jiffies(100)
+
+struct cv1800_usb_phy {
+	struct phy *phy;
+	struct regmap *syscon;
+	spinlock_t lock;
+	struct clk *usb_phy_clk;
+	struct clk *usb_app_clk;
+	struct clk *usb_lpm_clk;
+	struct clk *usb_stb_clk;
+	struct gpio_descs *switch_gpios;
+	struct gpio_desc *vbus_det_gpio;
+	int vbus_det_irq;
+	struct delayed_work vbus_work;
+	bool enable_otg;
+};
+
+static int cv1800_usb_phy_set_idpad(struct cv1800_usb_phy *phy,
+				    bool is_host)
+{
+	unsigned long flags;
+	unsigned int regval = 0;
+	int ret;
+
+	if (is_host)
+		regval = PHY_IDPAD_C_OW;
+	else
+		regval = PHY_IDPAD_C_OW | PHY_IDPAD_C_SW;
+
+	spin_lock_irqsave(&phy->lock, flags);
+	ret = regmap_update_bits(phy->syscon, CV1800_USB_PHY_CTRL_REG,
+				 PHY_IDPAD_C_OW | PHY_IDPAD_C_SW,
+				 regval);
+	spin_unlock_irqrestore(&phy->lock, flags);
+
+	return ret;
+}
+
+static void cv1800_usb_phy_set_gpio(struct cv1800_usb_phy *phy,
+				    bool is_host)
+{
+	unsigned int i, ndescs;
+	struct gpio_desc **gpios;
+
+	if (!phy->switch_gpios)
+		return;
+
+	ndescs = phy->switch_gpios->ndescs;
+	gpios = phy->switch_gpios->desc;
+
+	if (is_host) {
+		for (i = 0; i < ndescs; i++)
+			gpiod_set_value_cansleep(gpios[i], 0);
+	} else {
+		for (i = 0; i < ndescs; i++)
+			gpiod_set_value_cansleep(gpios[ndescs - 1 - i], 1);
+	}
+}
+
+static int cv1800_usb_phy_set_mode_internal(struct cv1800_usb_phy *phy,
+					    bool is_host)
+{
+	int ret = cv1800_usb_phy_set_idpad(phy, is_host);
+
+	if (ret < 0)
+		return ret;
+
+	cv1800_usb_phy_set_gpio(phy, is_host);
+
+	return 0;
+}
+
+static ssize_t dr_mode_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct cv1800_usb_phy *phy = dev_get_drvdata(dev);
+	bool is_host;
+
+	if (sysfs_streq(buf, "host")) {
+		phy->enable_otg = false;
+		is_host = true;
+	} else if (sysfs_streq(buf, "peripheral")) {
+		phy->enable_otg = false;
+		is_host = false;
+	} else if (sysfs_streq(buf, "otg") && phy->vbus_det_irq > 0) {
+		phy->enable_otg = true;
+	} else {
+		return -EINVAL;
+	}
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work,
+				   PHY_VBUS_DET_DEBOUNCE_TIME);
+	else
+		cv1800_usb_phy_set_mode_internal(phy, is_host);
+
+	return len;
+}
+
+static ssize_t dr_mode_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct cv1800_usb_phy *phy = dev_get_drvdata(dev);
+	unsigned long flags;
+	unsigned int regval;
+	bool is_host = true;
+	int ret;
+
+	spin_lock_irqsave(&phy->lock, flags);
+	ret = regmap_read(phy->syscon, CV1800_USB_PHY_CTRL_REG, &regval);
+	spin_unlock_irqrestore(&phy->lock, flags);
+
+	if (ret)
+		return ret;
+
+	if (regval & PHY_IDPAD_C_SW)
+		is_host = false;
+
+	return sprintf(buf, "%s%s\n",
+		       phy->enable_otg ? "otg: " : "",
+		       is_host ? "host" : "peripheral");
+}
+
+static DEVICE_ATTR_RW(dr_mode);
+
+static struct attribute *cv1800_usb_phy_attrs[] = {
+	&dev_attr_dr_mode.attr,
+	NULL
+};
+
+static const struct attribute_group cv1800_usb_phy_group = {
+	.attrs = cv1800_usb_phy_attrs,
+};
+
+static int cv1800_usb_phy_set_clock(struct cv1800_usb_phy *phy)
+{
+	int ret;
+
+	ret = clk_set_rate(phy->usb_phy_clk, PHY_BASE_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_app_clk, PHY_APP_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_lpm_clk, PHY_LPM_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_stb_clk, PHY_STB_CLK_RATE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cv1800_usb_phy_set_mode(struct phy *_phy,
+				   enum phy_mode mode, int submode)
+{
+	struct cv1800_usb_phy *phy = phy_get_drvdata(_phy);
+	bool is_host;
+
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		is_host = false;
+		phy->enable_otg = false;
+		break;
+	case PHY_MODE_USB_HOST:
+		is_host = true;
+		phy->enable_otg = false;
+		break;
+	case PHY_MODE_USB_OTG:
+		/* phy only supports soft OTG when VBUS_DET pin is connected. */
+		if (phy->vbus_det_irq > 0) {
+			phy->enable_otg = true;
+			queue_delayed_work(system_wq, &phy->vbus_work,
+					   PHY_VBUS_DET_DEBOUNCE_TIME);
+		}
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return cv1800_usb_phy_set_mode_internal(phy, is_host);
+}
+
+static const struct phy_ops cv1800_usb_phy_ops = {
+	.set_mode	= cv1800_usb_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static void cv1800_usb_phy_vbus_switch(struct work_struct *work)
+{
+	struct cv1800_usb_phy *phy =
+		container_of(work, struct cv1800_usb_phy, vbus_work.work);
+	int state = gpiod_get_value_cansleep(phy->vbus_det_gpio);
+
+	cv1800_usb_phy_set_mode_internal(phy, state == 0);
+}
+
+static irqreturn_t cv1800_usb_phy_vbus_det_irq(int irq, void *dev_id)
+{
+	struct cv1800_usb_phy *phy = dev_id;
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work,
+				   PHY_VBUS_DET_DEBOUNCE_TIME);
+	return IRQ_HANDLED;
+}
+
+static void cv1800_usb_phy_init_mode(struct device *dev,
+				     struct cv1800_usb_phy *phy)
+{
+	phy->enable_otg = false;
+
+	if (phy->vbus_det_irq > 0)
+		phy->enable_otg = true;
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work, 0);
+	else
+		cv1800_usb_phy_set_mode_internal(phy, true);
+}
+
+static int cv1800_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	struct cv1800_usb_phy *phy;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	if (!parent)
+		return -ENODEV;
+
+	phy = devm_kmalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->syscon = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR_OR_NULL(phy->syscon))
+		return -ENODEV;
+
+	spin_lock_init(&phy->lock);
+
+	phy->usb_phy_clk = devm_clk_get_enabled(dev, "phy");
+	if (IS_ERR(phy->usb_phy_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_phy_clk),
+			"Failed to get phy clock\n");
+
+	phy->usb_app_clk = devm_clk_get_enabled(dev, "app");
+	if (IS_ERR(phy->usb_app_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_app_clk),
+			"Failed to get app clock\n");
+
+	phy->usb_lpm_clk = devm_clk_get_enabled(dev, "lpm");
+	if (IS_ERR(phy->usb_lpm_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_lpm_clk),
+			"Failed to get lpm clock\n");
+
+	phy->usb_stb_clk = devm_clk_get_enabled(dev, "stb");
+	if (IS_ERR(phy->usb_stb_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_stb_clk),
+			"Failed to get stb clock\n");
+
+	phy->phy = devm_phy_create(dev, NULL, &cv1800_usb_phy_ops);
+	if (IS_ERR(phy->phy))
+		return dev_err_probe(dev, PTR_ERR(phy->phy),
+			"Failed to create phy\n");
+
+	ret = cv1800_usb_phy_set_clock(phy);
+	if (ret)
+		return ret;
+
+	phy->switch_gpios = devm_gpiod_get_array_optional(dev, "sophgo,switch",
+							  GPIOD_OUT_LOW);
+	if (IS_ERR(phy->switch_gpios))
+		return dev_err_probe(dev, PTR_ERR(phy->switch_gpios),
+			"Failed to get switch pin\n");
+
+	phy->vbus_det_gpio = devm_gpiod_get_optional(dev, "vbus_det", GPIOD_IN);
+	if (IS_ERR(phy->vbus_det_gpio))
+		return dev_err_probe(dev, PTR_ERR(phy->vbus_det_gpio),
+			"Failed to process vbus pin\n");
+
+	phy->vbus_det_irq = gpiod_to_irq(phy->vbus_det_gpio);
+	if (phy->vbus_det_irq > 0) {
+		ret = devm_request_irq(dev, phy->vbus_det_irq,
+				       cv1800_usb_phy_vbus_det_irq,
+				       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				       "usb-vbus-det", phy);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"Failed to request vbus irq\n");
+	}
+
+	INIT_DELAYED_WORK(&phy->vbus_work, cv1800_usb_phy_vbus_switch);
+
+	ret = sysfs_create_group(&dev->kobj, &cv1800_usb_phy_group);
+	if (ret)
+		dev_warn(dev, "failed to create sysfs attributes\n");
+
+	phy_set_drvdata(phy->phy, phy);
+	platform_set_drvdata(pdev, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	/*
+	 * phy needs to change mode twice after initialization,
+	 * otherwise the controller can not found devices attached
+	 * to the phy.
+	 */
+	cv1800_usb_phy_set_idpad(phy, false);
+	cv1800_usb_phy_set_idpad(phy, true);
+	cv1800_usb_phy_init_mode(dev, phy);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static void cv1800_usb_phy_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_usb_phy *phy = platform_get_drvdata(pdev);
+
+	if (phy->vbus_det_irq > 0)
+		devm_free_irq(dev, phy->vbus_det_irq, phy);
+
+	cancel_delayed_work_sync(&phy->vbus_work);
+}
+
+static const struct of_device_id cv1800_usb_phy_ids[] = {
+	{ .compatible = "sophgo,cv1800-usb-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cv1800_usb_phy_ids);
+
+static struct platform_driver cv1800_usb_phy_driver = {
+	.probe = cv1800_usb_phy_probe,
+	.remove_new = cv1800_usb_phy_remove,
+	.driver = {
+		.name = "cv1800-usb-phy",
+		.of_match_table = cv1800_usb_phy_ids,
+	 },
+};
+module_platform_driver(cv1800_usb_phy_driver);
+MODULE_DESCRIPTION("CV1800/SG2000 SoC USB 2.0 PHY driver");
+MODULE_LICENSE("GPL");
--
2.44.0


