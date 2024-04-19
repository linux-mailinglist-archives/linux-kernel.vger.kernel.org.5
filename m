Return-Path: <linux-kernel+bounces-151906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6208AB593
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D62B2164C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38E13C911;
	Fri, 19 Apr 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="dQnh9YaO"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2104.outbound.protection.outlook.com [40.107.102.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4213C3F2;
	Fri, 19 Apr 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555115; cv=fail; b=KAdXHTJ5rxFbYSjjcSGvspfraCeHWA7SJb8COj12kKI92c0KrnN0DjZ7N/mK+4eDToknYuoneM1ybMLRG7SfZFxSodxAyMB0G2ZkBsiqxlfw89YK9U89xU6gJ+Rl2GWZ5aJ04SVWTNS3dXxxzUZ2tfAyjNjMP8xOvy3AYZ4Qnak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555115; c=relaxed/simple;
	bh=bwuGiDvCG0TTDjBMIqdO0YpDATla8NWfScugTj6LNBc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NpwoN/xxNfOgHu31EOeXncRob4A9RthuZISgbkPWmrorIJYtqcoH9AHSLh13rD5GzT7YUzVd1vHZrO2TwXYTbmjbnB/6TzjnhD3gQ2bk1KdBcC2xc+t8ZG22r435BYRHy9b5edXTR4w08MWcvH9S6LyR8vKD+HsaQW87NCB3TRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=dQnh9YaO; arc=fail smtp.client-ip=40.107.102.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9G0ufdAMBaG3Ihu+1Ucl/qPGMEAMu0sOBH/VsdlXuG4s/vsjogV+dhdEu41CqWWUQcT+AtB0RlO8xblJ5kSk3fSgkUmNxc4EdApuZ1IAGWl5FsuSwLJOK0NCbHBd61qA9zUfXDUQX8OSe3ZoQamsd1ydAW/KR46NTPpea20qZOF5Z8JL14/hJcQtVJ+RPPQ0AFAXyr4GH2JIZcZtfaZbj5Ej3Lw2zfVmpuY16VaQwZOaL8yBp9HSOyb7XZy54ysYUTcWBR7+UUXP2C5XHPmPG8oRNBsglo8ILw7aUIMfiJTcFwEBL5yK6hkCTBXuAWABEKq6NHDw4c7Ix4yojPtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZcrTmL4KPrJ+89g+72922MDii5M5ApLAXje3nSxJC8=;
 b=BITTzWkjxt+R+YbbBVfr3D3cverLMqF6WPFHuCr2/MRrTqTSaoMvwNQ1L/vpL6CzOAKv1hVbfGeUnG9KEyGRKafBIHX96nI6xbO+YbhGxEkkcCW7WmLoKuxpHyIUp7m+On+eVfLwNPKC8fIvef7tZXgdZCiirg55wmOCNotScc4rqRaFL6YMfuNyP+kGfEmDMrMlbvGQH7IPq3X4JLnOs3ljgyzWV/b4ZNj9NlUWBv+tKQBBU9wrYzB05PMVEHWd5M5RzY4OgMm8DfbWbb7sBiX6NOh2gN7vY2jfEOxA0fcszzZ+y631+68tWh71px6H00sRTaBuP1WE2MQ79PAuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZcrTmL4KPrJ+89g+72922MDii5M5ApLAXje3nSxJC8=;
 b=dQnh9YaOb/SQ3T6yI3fqVOGzGuWAWeNgFPlJyaN3j1LcRqFEadqe9s+QAdIpI6TNvA7593uO7qjvk2GLs9DUzMZWkx9DcRAp/wOv5QZNvQveeLTJqJIFq44QpUwCbv+yzdEnHzKE/+sHI6ARajnQ35Hf+XVjTp07kD076quqc74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from MN0PR22MB5638.namprd22.prod.outlook.com (2603:10b6:208:4a5::17)
 by PH0PR22MB3291.namprd22.prod.outlook.com (2603:10b6:510:122::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 19:31:47 +0000
Received: from MN0PR22MB5638.namprd22.prod.outlook.com
 ([fe80::2041:9d22:48c3:e667]) by MN0PR22MB5638.namprd22.prod.outlook.com
 ([fe80::2041:9d22:48c3:e667%6]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 19:31:47 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH] arm64: dts: ti: am64-phyboard-electra: Add overlay to enable a GPIO fan
Date: Fri, 19 Apr 2024 12:31:14 -0700
Message-Id: <20240419193114.3090084-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:610:53::38) To MN0PR22MB5638.namprd22.prod.outlook.com
 (2603:10b6:208:4a5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR22MB5638:EE_|PH0PR22MB3291:EE_
X-MS-Office365-Filtering-Correlation-Id: 244199d9-1384-49eb-c453-08dc60a75a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5TRc76UNKbDMk+JJu5VioJL0t8zm6GDEeO3jdTIUGga3ZLCNTx0UUywgm7hJgvn5mpOaFxm4d0BA7Qr2W47SL2Uih+IwNqGkldjNBAC/G2zNatn4OcaikVF6x2tcze3kXwzoB9kYkz2jDUFMOGayLSiPRbyWK0q63fQATxRHgkR1Y/LyXHLtIz3HcLQDktxqOJnZVbN9Of7ls91vp2lwmw/hwa2wOrmwCXBc1FDhZ3kUfswixXIbBK3jUSh+vqCYr04UbDGfez0mxERrR1WlimB+OaH7VCrOOuaghpEX+DLi3xGoT0jC3/9cS1o4lrqH+dY9mjA8dqs28XLPCw/1Ux867TxUbyJiySahi46bqkf/yOJy4WUew4AdfoAzstt7rkk5TKMtnOYpiZ2JZ9IsfznEcrN2HJlBdRghgZAMM1RlV42LPUm5Rk3quhYP/H47By54B4SEvZxSlTeQOBKg4nEanCK4a5MKRvknhChktuR19LMSYYHyV9vmMZrwgykYPExp9j+KDBjPEsA7vuPO1mhS+gISBve37AE4aLIYAUREtbGaotjgx1TyrD6O2eEeFwujJ0/L7YKBy2p389fbsghZP8acn7lFmWu+9wiVxMBCqSPePhowwcZ49cZ2X47aKOhPRvR7wXHhiIocD3rBQevm8EGgWTtLbQOHra6RvN06BSJE6kF6zuiphMzuIG/b0re7+YDDoCuxPq92zhyBbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR22MB5638.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHp+x8gO8dB6SxgLdbD1aD3SYea5auHPtxT+yBWRXkBQpVnRkdtHBOt+gAG6?=
 =?us-ascii?Q?ikxCpn7c8Mg9t+lLIOJjhto8+7s+XHh4uqm1BLR9rtMEblXCV4YyevPqgxPh?=
 =?us-ascii?Q?Cj5IfkJCVK4aFLWdateUrsadJNUhr34uoy6PwofRlbgRW8tcEICTC5Tjk4PX?=
 =?us-ascii?Q?juFqyhT39Fy4kHZmk+4DUuh63ujLvhDDz2o0mEOmXjEAhzSM7WD39JuyCmR/?=
 =?us-ascii?Q?wCR70hNYXzFyPHC8Wxf379x7rjqkq5yPJN8nFtSwmioJaJyv3UljDcBH591r?=
 =?us-ascii?Q?JAj1cVOQRFLZ+49BVfeAUrZT2vwEqLdm0p8RxucbVS8Z+NDL9RAA3t3r2Rm7?=
 =?us-ascii?Q?CNJIgxdHPOItTSDzDjo0GXI56+PDWvihuTE4egcDyoAPG9jTdkXVbuUqbQfv?=
 =?us-ascii?Q?yqyZL5yLZnV+32GDHyO2qex2O+zxplpVOPQVUdLQ4LS5WVKB4KDzLFMKfSKr?=
 =?us-ascii?Q?nntblfMNHJt0lz1qc3vweBJKA99CgYMcvmacJdFgE/jQXb+bbq5vp4FuOwnZ?=
 =?us-ascii?Q?9v22Mx/BSCquYVi2kWqDewKgMteTQTWcvIVnAUXRvTB+J3X2Yrfa9yVcBRmL?=
 =?us-ascii?Q?IsScwOLrtcxvqyzCICFaTQ3fWkIkzIpyJNVLNxLW1slfeETRBz0lDQBTR+WP?=
 =?us-ascii?Q?PnJK/HhD5J607DmGmo4hzdn3EEvW/iK6KehGo1Lx2kUOw5BOTRrTJO4dplaG?=
 =?us-ascii?Q?aDFmsFQd+SGkP34uwaxb9H800pqm6nKWh7KXuJflb0e71f+yv6emGgqwaGBb?=
 =?us-ascii?Q?/uuxUHFyoL3Gsafol6psp2YNTPbDvEiS46xZCVJqFFXGYkIW7TfD0pw6XrGG?=
 =?us-ascii?Q?aahSu5JAoN+fjyTiOP5F6rnqEVMUl5nSyyNt5h2nDFHBysmzkysnQWjTuqi6?=
 =?us-ascii?Q?AaXGgjKELGOCoAGUE4lgl1EjOVmvFujuJ7lleiMfo5fYS9w2FxOe3zG7g2+4?=
 =?us-ascii?Q?Uvdc7tZbujXW+44J6LHVm693Rfmpv7tHCrcuNLd+7YNqRKENf0Dw0469pE/L?=
 =?us-ascii?Q?9UmEbJotTBOXMNLt2sPafDCuVc4AM0EVA+nZPbQix3uwkUvtTcPS6h2NP3fc?=
 =?us-ascii?Q?gQr95PHjZFnrkaX+iZvH07pDSkMiscGfJT896cNhulCV6acdh5iFABMdjwEj?=
 =?us-ascii?Q?lN1gY6nHqjko27tcKT+f3eynI4Ajx8uQg26jru5XTc1oN4bLPCuFruXKp9di?=
 =?us-ascii?Q?Qd0+d4iNXbCa6l2f6ioyo5qjTBZBNYSFMS0lKkK7E934nJ7FaUorwFRnKEo6?=
 =?us-ascii?Q?QJkZdMFLHKdAaO1nSUWdrM7BeYQ1BtVdzzppcVJB8rOa5CA5lhMpkAxm0XOM?=
 =?us-ascii?Q?CA1Bd3i2qafMWPpu2c/i6cXU9whWRpq8QfQZHkpjZPk4wownyM96OgI93N2u?=
 =?us-ascii?Q?mVqN6D/slb55etc7ix88EKaiWLyX8uNByMsbbvYIwem+EJwd0e4pxl5tZ66Y?=
 =?us-ascii?Q?noNJ67IPkTZ1yckeJtGMcmZ5h56oQQBJtUkRu6VzqyhLmTUgbDIMx/jvW5Rd?=
 =?us-ascii?Q?FD0ydVjT1oq2riOG3grvBSn9jl0Pwu0Fu5CJg8qd++GRnZH9FnvIhgaozaft?=
 =?us-ascii?Q?wY1/W9j+xjm1PuwE7VbzcIQD+iR0tKyKueJE2PNX?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244199d9-1384-49eb-c453-08dc60a75a28
X-MS-Exchange-CrossTenant-AuthSource: MN0PR22MB5638.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 19:31:46.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpIFrzazUNarZWdrkWRZKk3axta7zdeK/BVx8YoX2vHqzswMxAsoVN3EqU+LDalW/53PF8rtWgY1g4gNjXTx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3291

The phyBOARD-Electra has a GPIO fan header. This overlay enables the fan
header and sets the fan to turn on at 65C.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  4 ++
 .../k3-am642-phyboard-electra-gpio-fan.dtso   | 50 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..fd91cf40af6d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
@@ -131,6 +132,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-phyboard-electra-gpio-fan-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
@@ -174,6 +177,7 @@ DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
 DTC_FLAGS_k3-am62p5-sk += -@
 DTC_FLAGS_k3-am642-evm += -@
+DTC_FLAGS_k3-am642-phyboard-electra-rdk += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-am68-sk-base-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso
new file mode 100644
index 000000000000..5057658061b4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpio-fan.dtso
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/thermal/thermal.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	fan: gpio-fan {
+		compatible = "gpio-fan";
+		gpio-fan,speed-map = <0 0 8600 1>;
+		gpios = <&main_gpio0 28 GPIO_ACTIVE_LOW>;
+		#cooling-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_fan_pins_default>;
+	};
+};
+
+&main_pmx0 {
+	gpio_fan_pins_default: gpio-fan-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x070, PIN_OUTPUT, 7) /* (V18) GPMC0_AD13.GPIO0_28 */
+		>;
+	};
+};
+
+&thermal_zones {
+	main0_thermal: main0-thermal {
+		trips {
+			main0_thermal_trip0: main0-thermal-trip {
+				temperature = <65000>;  /* millicelsius */
+				hysteresis = <2000>;    /* millicelsius */
+				type = "active";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&main0_thermal_trip0>;
+				cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
-- 
2.25.1


