Return-Path: <linux-kernel+bounces-142126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6F8A27DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C501C229D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5904655D;
	Fri, 12 Apr 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TyTbYu4C"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2016.outbound.protection.outlook.com [40.92.47.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8A4C62B;
	Fri, 12 Apr 2024 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906541; cv=fail; b=qFfSBEWV/7swvFHTX5whcfAOYPOFfdNrjMIXNYALMqDE0XjvcfqdoI2sbe1OD/AL5kfTO1AzDlGAo+LVMD5i4PsWlnJDr7xp6eusF0udNu4d1jetZwmbpiGCzfs/W75+GcpVclHeCKZzgWDYjBzmr1lJkNNtj4o2CC406E/MACI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906541; c=relaxed/simple;
	bh=CftCITtWZ9KPZlPszXVfNtiRz90uGbANi8qBkc2nVxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeWDumiS7vUP26IuKqA6ApI5U6VxkKmorJBLLSy558jersP0joaxmhZc7ZZa410BX5sOnIHv3x3NLpLx67C/TbaXfWrYf3s9Flc/A9vAWBKom58972XKKzyir2PBvt+7uuzkN+vO7qZG/yvqLpWTPFh3XZpGYp/P0c6JJiW/gms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TyTbYu4C; arc=fail smtp.client-ip=40.92.47.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFXAG3Rg4bwutkEUg//0Mt9gUbnMQ5BhnICHwpII0Zcbe/8WtXibrP+Vg1Bv+aQWFg5KW6fsGlKax+XZ2ukcIxqoEAk8di2BljQF11FPxg0qLnIcSt37XK0SZMOyvRZ6OotFQUZOHDJ5XCgnqKo7+m5LBEmS8B7YoqkC9vjh0BmIL7sjpGa5ChXefRhXfStnlPK3T7qzF2KVL+5aX1oLobJCxgsdNknEGT/VlU9Adf4O8XiknJM6Lge9dpB6Z9CB1p2So7nvLozfRhCB7isECTWpDSFv/guKLEZ0QYxfqcUOzydeH0l0VbSsiolHt21n0OV0a/YBnYkHDxFywAgAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju23PTcTtkB511M9VHKydJnZnYIB2wUwPBdnUS1njZ8=;
 b=BFVmThucm9jTouY9l+KXP3Rv4kFyoNgqQEe9K2ClDHUNUnI4hT/DtOkFPCHOVSjf3AnjMLzsm9lCarr1Hm+Cl2vYQl3d2rn7O4QzJR9fZF5jeYxzxKXQxY8rfDaNCEa2j1OfGLdNvnY7zsCJLDJ0+Tl7VQNPOQ/UojmrwVEhbJUqUjMnv9ungSg77Andf8vuR1EMk21dyOQtQhs9jadABFD7VOyVkyEFmAegw6nFHfJvJOjd2VSsfH4MIcUdHL/hsMO3Tav3wZiRcAyhEzCoYY2Z7UXSWRRje5Igz57cu9oID6Bs5jZCS19pZF60HnICY3BdC+EgcTH768fPf2TxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju23PTcTtkB511M9VHKydJnZnYIB2wUwPBdnUS1njZ8=;
 b=TyTbYu4CcE48exfETzVBksS9jjJr9H9IBeUy5dAoQvFbAcxJl2iD1lCUpOGjFjtYT+hqFM7Z0u61WgQqkNQq0KchNzAgVL1QT8rLF4LwtdaR5NxVcYPrdc/u3kvyn5tLT9qZ9A4BJ5FrkEncehXkG3sezw/sDDGhGW7Q36kTxwuwDaZWDL7mkkdmT3dl57YJjjKqEFvptjxUF6fy576r67YzqGoplhlFwR5pVXyo1s8069ppCMcECr3EyA7goH/DdVqkF2eojddBKNx2x9uMTqMSusA2Z7LQlBdhskevyygM0NrHPJffBBa7p5ssnUj5UEFGCCOvTxLg8onyZs3tHQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5795.namprd20.prod.outlook.com (2603:10b6:806:32b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 12 Apr
 2024 07:22:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:22:16 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
Date: Fri, 12 Apr 2024 15:22:25 +0800
Message-ID:
 <IA1PR20MB4953EB2E2BF9D5F1EE30E2D4BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [yq4qnxpe3SiTsrS9fnOd/a0G7RcGkYS9CTREQRbJ/S8=]
X-ClientProxiedBy: TY2PR06CA0033.apcprd06.prod.outlook.com
 (2603:1096:404:2e::21) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412072226.121769-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ba5707-859e-474d-c16a-08dc5ac1482b
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3iy6B2zcPcTG6CIJGEFnGZSp+nktjiXkQBlvyKwCg2A0Pt6JrVKgmiqSiJUR9Pvcv/s5IVhihynVxxOvh2h7zh5mpjk+nKHrN7zqrXBVN+hSGli5Ed4vOCWOPOGgAozMGLIsKXwZUeG3JUgGE/lW54Q8zrlH0t0SoMUCThlh1jNGVrGBO0glAZpwGWT+2eZT4GtMdKgRn7z5lUbMUvAEW7VQIGARGgqiuQtGPfeUlbUtwE1JBNa0OhgPPQhZHpG6+jeDFnIKF9/BGj8iZq+o3D2C3jjfpe67I2gsoSpUFQy8Jca2LZawc9aDc+P5x48cs7qukMJH5CILnBp0fv4aDomEPvlmoAidBfTGq6hViWYYS3vjwHcNJ/8edTnwzk2IvwkSWRZ5N53T3YCqW1wFxu3nEP9PyOut1mB6tS1EWXpn3SlkMuj8Gs77b5ZC2AWYtM/VFPlf1EYy7D8Zq4eEjhZI3PcijpdoYhu8knLM6GjR5p09P7RMKalO3YSSQaumJlzkm9iS+geMr0L+/3SRFB4HCeIOTysyxV6TzgFPGvFkTh78HFbg97PJlKGINLtH/axio8uwIuU/nqRIU0Dn0RNrV2gaXrzEsJgX6oT+MqTB7R87F9Lt0GDwijJFMNJkwdXo9SCAEXuGHFBUn4BhlzmpgJDilu3NowWdpZ/kF3+ws8N7cIPrvvJys5dXbKxDz9XUnSa30ZOjM1supzTg0kfXFN+Q+1N726bRaGt43Y7L2Cy4IsneWZLrwlJr0uk/v3GA53BCmr4VCw4dPBcEJZT13WlDFsKYmU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/MWEg06hOtRf+IV8qdKJyzOC9b9pt1YMP7n5HATThQoB84ms3RiTJVuUZarMKtbuFX07QHCd46DiM2rgJpVHNoaAXb3MgzjgppL0U3+WdadhxM4aM3dBjFEEo4/NHcXwGuvoGh0g74D9QrOMTo0DXpLhaXMFHCe+FIK4VM7SOAXRzwappw//a5oPySaygAYdlrX2Xvw92D8ZLpqdjApHhtWU8haGamW7wLB0XSGTg3yMNTFbLxa/0KiNiKUkp2Ru7B2VB7+6lfeJJJbfVodh8vjDM4jIrdGtAm5URC6oGHYRvQ1I7v08Ut4C3y2VeWzgtqThlWB08MUdFzoqpI5WKJGd6QQPZr+aFhLPd8gOwl51Q1mwUf5PLO85dblki21CQjbx8Pfg8gq4xoDe8xc1lrzkkgCZi4m7PuSj6DwwWtLmIaMRim9Aps3MncbBEr+D7JZsBVGR2fTpBtuu3MTlWlh1xHBK8ELBQJCzyQPb0vGhH9VSrrcP82xRkkxEgBj0FKYwMAagozT6q0dP+QHxq47xANuzW/WjsbmPWQDBDXj10J2MKoOu+DEE+/de/tmNCRDJJPAiFZ7BRNTszmO6jVfn//Y6NsxZT4ZzXfNYg/8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dsP1LkP1UUkiKDA5a9MOf69a9/tL2DFrNrCHBbN5IEDCHcSWYO/OtD0v6o2?=
 =?us-ascii?Q?BjoXbPXAd2fe0aeH93ObRPorEaJ1o7Z1lYhA9u9R1umCnK2vxUxJRLn4W6cY?=
 =?us-ascii?Q?cm/TJRo5F2EIrJt4Jmfy3R7A7HvQXU3MZpqa3OBgaIGwPYoqWSMeBDmxqfn7?=
 =?us-ascii?Q?pWKOqs3sBqFOQRI6MEIz2ph+dj6LmJFRSPDdv6+hXwITpe+AxtImZyTbdmvx?=
 =?us-ascii?Q?j2FFl0+woiGCaWh+BQUiY23TgmNYVnFYu65Nu9/QPGMtleOFMXAxzz3R/dka?=
 =?us-ascii?Q?yX5vJItzWTu8ijsyITVJBJswEGPiA/skk9CdE0t8RuVgpbk60F9Z7t/2YYxr?=
 =?us-ascii?Q?Wd1B/oDXYwZOcg4nT6uTJDl0UkrsSx23mcy2hDqzPKU7OcwvBIUKkW+CLyMj?=
 =?us-ascii?Q?jlcvMyYvSK2NnTGFBxLH2eTH1FfhoztWXkprd3QIBK1L5gCAJ5uOsJAvA+1b?=
 =?us-ascii?Q?oZEY9cMA9jR8mRLw1e1BvU1JW0zFKKLef25vwtUVZTr+qYQ7mhBxCYWn/cGc?=
 =?us-ascii?Q?Bc7e0lzLEAgflkCNsqFMKASYAW2Hw34JLTnmPH6C3sHxU3mUwCQTiGye5IYQ?=
 =?us-ascii?Q?e/6Dg1tZwx6d04J/ZlMS+K59BkRJsjDoJjUfEg+7Ms9kyqtbEWjf+FY5biGO?=
 =?us-ascii?Q?ER8RWHpZrQMQm3QZ5uvJ8Bvd0U1SKpK1PsLxSwALHLdqbqD/USxLZyiWazPq?=
 =?us-ascii?Q?e6MH2GIHAoxpIPAjZTsFRtkLqtzs3DVEFowXXMquC6UXvx4/WNfDkw2xHajm?=
 =?us-ascii?Q?0+4kKx6wD/Xd2osJPT9644L6dQBDUZoAnYjkSkFmLfwyrf/Dr4VMFUrPF+F3?=
 =?us-ascii?Q?vjWiwbS0gWJ0dzEJbmzukjSv5fcEp++zOJ9ZQMrcplyPFJXrZQX207yUz0NL?=
 =?us-ascii?Q?YQqPBa2hWYs+xPjhSPKDDbNw5pe1esLvsXsZaEBKh3krhb/URcUrzLGkPfTc?=
 =?us-ascii?Q?7UVSoBMbc/VbY3aUTy/iXZJ+9DnAvilBjkNCkz12LUBwR4fG5YmN9VkWJ5FH?=
 =?us-ascii?Q?Z5C6cgvOHvqiPdfTTa77Uh5lQFrp/p+g+Ys+Tltf86xXAjgoZGnVxyRcZYVK?=
 =?us-ascii?Q?UenEqeU8n3T1KZwHW02mmYVxjRCsnmZRyCcd370uzA+IiEs/AD+Ot7gCrGSn?=
 =?us-ascii?Q?XluwS2iJZprfCj7AvqTGxZFJ3j63Am6Jay1Sgys+qQJaDFRVCNb++EGBCwWQ?=
 =?us-ascii?Q?2yDanDCO+RPzP2H5m+1HiX9lY+lbOM4JlKvsyf1wBimgp0n2VcLrStHsLH5H?=
 =?us-ascii?Q?qtNatoXTYy0bYSS7xFXx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ba5707-859e-474d-c16a-08dc5ac1482b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:22:16.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5795

Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/phy/Kconfig                 |   1 +
 drivers/phy/Makefile                |   1 +
 drivers/phy/sophgo/Kconfig          |  19 ++
 drivers/phy/sophgo/Makefile         |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c | 381 ++++++++++++++++++++++++++++
 5 files changed, 404 insertions(+)
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
index 000000000000..a9c7f41406b4
--- /dev/null
+++ b/drivers/phy/sophgo/phy-cv1800-usb.c
@@ -0,0 +1,381 @@
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
+static ssize_t dr_mode_write(struct file *file, const char __user *_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct seq_file *seq = file->private_data;
+	struct cv1800_usb_phy *phy = seq->private;
+	bool is_host;
+	char buf[16];
+
+	if (copy_from_user(&buf, _buf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (sysfs_streq(buf, "host")) {
+		phy->enable_otg = false;
+		is_host = true;
+	} else if (sysfs_streq(buf, "peripheral")) {
+		phy->enable_otg = false;
+		is_host = false;
+	} else if (sysfs_streq(buf, "otg") && phy->vbus_det_irq > 0) {
+		phy->enable_otg = true;
+	} else
+		return -EINVAL;
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work,
+				   PHY_VBUS_DET_DEBOUNCE_TIME);
+	else
+		cv1800_usb_phy_set_mode_internal(phy, is_host);
+
+	return count;
+}
+
+static int dr_mode_show(struct seq_file *seq, void *v)
+{
+	struct cv1800_usb_phy *phy = seq->private;
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
+	if (phy->enable_otg)
+		seq_puts(seq, "otg: ");
+	seq_puts(seq, is_host ? "host\n" : "peripheral\n");
+
+	return 0;
+}
+
+DEFINE_SHOW_STORE_ATTRIBUTE(dr_mode);
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
+	const char *mode;
+	bool is_host;
+
+	phy->enable_otg = false;
+
+	device_property_read_string(dev, "dr_mode", &mode);
+	if (!mode)
+		mode = "host";
+
+	if (!strcmp(mode, "host"))
+		is_host = true;
+	else if (!strcmp(mode, "peripheral"))
+		is_host = false;
+	else if (phy->vbus_det_irq > 0)
+		phy->enable_otg = true;
+
+	if (phy->enable_otg)
+		queue_delayed_work(system_wq, &phy->vbus_work, 0);
+	else
+		cv1800_usb_phy_set_mode_internal(phy, is_host);
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
+	debugfs_create_file("dr_mode", 0644, phy->phy->debugfs,
+			    phy, &dr_mode_fops);
+
+	phy_set_drvdata(phy->phy, phy);
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


