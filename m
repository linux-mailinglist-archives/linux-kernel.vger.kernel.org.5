Return-Path: <linux-kernel+bounces-58906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173A84EE64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3454228D50F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9D1849;
	Fri,  9 Feb 2024 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Um45UUzj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643D1859;
	Fri,  9 Feb 2024 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438610; cv=fail; b=RYwg2Sbw2RGd9s1EERsPQJdbd39qtBOcPNE+CmLnH7Ey4hl9WD6cgfzGwolA2Q9z+JO5IbOMiu7mce5iss/hELXAX7/ENulutrVirJM0cfSGGgDnjW9RD6B8rrWrOx1BEngRzQd2EpLAPHu9vkaKF/j7STja87DL4ghz6ylR0Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438610; c=relaxed/simple;
	bh=IJ9eV2kPLoouYVDvolEXZYPALe8KI9H4vlbggLFtV4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mDsE04T7EW4SbD5350oGgG5LR2vyj37UZSZoXIfFhVPPgfJUyKS0Vqo5H3LER910Z5Ylm2upYHv8qVgSQvFCtV4SZlH4zmnJsHIvGF/lQXxxqf4DdfE2ZSVRAizGxKm9KIrNXFYRUsiGq0wsvyuItJuhE4Y47AXGYMNfMPmiv9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Um45UUzj; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRhTI+v1T+Jw8sKBaEDAuIb5xD7Tdg/gdYzZqzSHFK09YBx/AplZaCPwBShlEqEVi+Fc2scNW3dAiILTLnFDM06WN3EIqKcR9qU74+6feKDaqF+ca4hVa5Ixm2z6TM1lfy7pk6mw/9/HOaILY8CBhqOmkBRMrsqrSk4gb4a49GtJ54jAnwkKWln3Gii0Ze27JCHoV/A7UjB9f4n73c0RaESbr4WK59rSV8gU3tU5Zys5wyPzy2p8sAeEA1oOcdj63ILiZRqJjD8Ths1DLSvpGTh0SmDgelJxhWDTFoVAJahlp6oRiuyyT8faNvoHZZxqSjahEm8+O0ncyZAzMZpjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHh61+24Jy9Tlvc7MBSOO7yNsx4N9V/S3p6Ac71d7io=;
 b=ATPPQpEwArGRRC7D5nLTU/vhQ4koxiTzIu6BwaMYkcv0s8W7R0P5JxtTk84SJ0Tdm+dPMpNLOnXJfJt/ltGzyMCyCDW4l/uN6mqDhIF82nXRrPy5SZovEznpe/L4ME964fz9uu+d52waZdA4bm6LfTrwsaXNOAeAjdl1w9yOKF3HJMltx7COlMg6F3n3IwjAi+Nf51h9lht484y4PAhvbnOW7tmQToZ1M1k3UNmG4s+zKPFb2V25IkM+ATy8TIUmDZGBNOlGqP3WRTxcaoPzJLgaNckEy1cOJhkuovP+gto+JRhyNbK6NlcCKiB7n+/qfMmRTWZDmz7mHu1yhvEqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHh61+24Jy9Tlvc7MBSOO7yNsx4N9V/S3p6Ac71d7io=;
 b=Um45UUzjAV/NiGaHEtihPraG+mKw+cSnxVDRTCq6Tqe8gtNSQcqDbtRwBqfRDbWdcakOJ7VxGSzaOlM/mJrq/1tr8GxkI3MiXR+0jWzXOn/CLhzLHgjtT27887OM0a3prY+NDd6Xa4P0TQqHrx0kC+bwP0LgcH5O6+1M1f1ZYcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by MW6PR22MB4174.namprd22.prod.outlook.com (2603:10b6:303:23f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Fri, 9 Feb
 2024 00:30:04 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e2ac:f990:32c6:334b]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e2ac:f990:32c6:334b%6]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 00:30:03 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	upstream@lists.phytec.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	w.egorov@phytec.de
Subject: [PATCH v2] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan
Date: Thu,  8 Feb 2024 16:29:16 -0800
Message-Id: <20240209002916.1284433-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::15) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|MW6PR22MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: cd21294b-410d-4859-c42a-08dc29064231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0r8NVOiwfocZyriq9PoBKcAn2RkEkUDhi7zEpmavemgPtcY/qJTYMshvr9bHze1vAPriHyYpOGzO7ETOzlggsOKSyjfdBfj60bjcXM7p66NwUQO2FcBEpGWP3bdSvnOWGFHs6JBC7Wc/Y6iZpMRdSUwiKQQhyYD5aGtsVtbM3GqlQVqngYjzoMx5E3uMuoEG2KtPETmxVC7cxaKIKsOrMuLQIwrbV4rnTcmcsiRwIur7xSOMpuTtbz/HUpB1S1z1OQVae3tItSgwDwS+TtrhJ8JLhqhTsvj/8PxqnJxUYWBiQN7rqUu5zlIdTGXfA8q6DCboVu+Jg0ndhQVvnhy37LUZeueyrE/p8ke0dFnxw6DO1JWECCAUvUSia1pcJMYsuSoLWcVTMq8NVHg/IDtTOiKZwjm7k1Bxl9kaOiSPs+OXjMB3JIoqwVBoiiVr+MHYwjy+ncSLyugLtatApZwqrbka0sbuSsCl275sbeTXAzpiEbdos7bjWOKrqcTaYPee0xM+BO2Efdu248CBssxHO9if9pF5hGt6PiEXke5dUvo8WvdQDg8jRQ3qdadTHYkFD7RWcCV5rR3Cc5emdM9Qb+HRAqvB6ZosNK68gwhwFrFnWdESOGQRMlIgnSTUzuaG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39830400003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6486002)(8936002)(66476007)(66946007)(316002)(66556008)(86362001)(478600001)(4326008)(8676002)(5660300002)(38100700002)(6506007)(2906002)(6512007)(2616005)(1076003)(6666004)(26005)(52116002)(83380400001)(7416002)(38350700005)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9S5aUXP4lUwjXCV52sTOR8yO6Yin1I6mARawCCa8FOmuBslLcAoxcZwJRqQ?=
 =?us-ascii?Q?059AtNBDT6PWyGXvP6ECFRhbOdLqgZIlXaI6S2CwYEdciaWfiKZXXyhWAK1D?=
 =?us-ascii?Q?NvBiVNkt82f1yvHzVokOUvteJBYDEy3sQm6cjcHvjfVyJ9j7Fuo/af6477Ln?=
 =?us-ascii?Q?l/yKgVoJ3O+YG03uThM3JX4yEoKXkoC7jgrDVOtfLVe/SB02tuN2IwNFwkV4?=
 =?us-ascii?Q?72VGilTkjx872JHj/FjQBAPv8mxkIoEkpAj+1hzIy+IzfvnFmoVhxMtyOT+W?=
 =?us-ascii?Q?BIOHNGNmHzYDY4gZJ032cGPKhCn0EYOMPQ8AtpICkYV2FibXwUBKjQKU1oJ5?=
 =?us-ascii?Q?ZfFHmvmnP97lioHPDkZ63W3t9Jaftd28e45QOxNrb/jMafzG2mSTEqKLxoHh?=
 =?us-ascii?Q?bmlyWvGvC+0VvJGaAe/4MkggQ1ZHQbrGPc5e/lHxF68j2etKGx55DW6Mj1Il?=
 =?us-ascii?Q?lkRorIa3CxFu343N5IlPWZ3ZSAXXVZ13IbXjXWBR6bDeJJQGWWhA5ipP3mTg?=
 =?us-ascii?Q?U0FCNk8lZ9b7fdBUWlddQFb/SHMJUzDcYxf1de7Rg4cSfjCtcuPpd4uikwmG?=
 =?us-ascii?Q?BmwOf6H5jv7powd7C2BIZ3YXuMWsYKSpl/ztIw1WstAqhOt9uvz5qgYHT8iv?=
 =?us-ascii?Q?meXWqtsTShoVlRmG5sPm1p8K3BtfaYikAS8saDmq7i+5kCAAqvs1lo1Wkre9?=
 =?us-ascii?Q?HRO4M9sGipOnCHVTWnNR0+LcLxeiO8PrHwxkPS6ZOAgtfpRuDB3ucQUCbD0P?=
 =?us-ascii?Q?v5jK/GID1QO0LK6lVfo+c8KfbnT2qAvBqOG4Eq1WxJYE+vh1s49oudUSTr8d?=
 =?us-ascii?Q?pvexmkD8+hOpaHkpM4Y1cl+jt50c5iIaUU4vLqQx1uOKqFQVZfcGEZvFjcBc?=
 =?us-ascii?Q?KtVbGy++B51i1wcWRN6BigTigwIe+8gyLnK/p7cSmH4aDf6co7R5EIZdPJRa?=
 =?us-ascii?Q?JvVldOwcKjvdFLzqne3Qq+LbISAHTuxVnb1iMHXEQRsX3cGqmMNlz9L5PzDd?=
 =?us-ascii?Q?GFOd+uVmN1LiIQQaiKmoZGozDDgnChcSQOwYJUcwKLMPtj7GAcVzMTCxa2l4?=
 =?us-ascii?Q?iIsTV0O9q0Kpfqp5gRKsPFZ12Lim+dHqBn2Tc5PivhriHMxhH0IDXfc4FKS4?=
 =?us-ascii?Q?Su8RxOYv/ZD/Dsl2IJJRvAY+/MqC/MgThk5QMiTOtYyBmhdaahYK4HE0clXW?=
 =?us-ascii?Q?hshLLG290jAYEgvhf11i7Ce5bx4E+fudLn0gLED5rw0S8iUZ24A+vfbViLON?=
 =?us-ascii?Q?lDISot/K9xMXrJpYadSSOSmr3WlGu892LXHNtZTmGrijWrd2+IwDqWpvIzHE?=
 =?us-ascii?Q?PXaMJAe3e0VN4Pi4K5vtVi+SMXdlLqbrdYAytpBzfV0nYnoimvCoXtNQpOKP?=
 =?us-ascii?Q?nAQxe3AqB3EfmTXCzV5cBand4cnRojegJK1lOxkmlJMmfapqbDMY0h+dVF/5?=
 =?us-ascii?Q?En1dphUIuLJ4SCyiQaeUzpdniGIiZbF3xhWyZr41DThvxa+9watN80e1Zqhq?=
 =?us-ascii?Q?KQ9Rf1aMiXSv9aRl6+yr7b8k1BRSH/N0Z8pGPWSYD8sNL5ZsUhfpdI9wJkNG?=
 =?us-ascii?Q?Mb298+YRsowyl1CF66MG5t4wTsOJdQvnPPcomz8G?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd21294b-410d-4859-c42a-08dc29064231
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 00:30:03.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X4rnQIz5Y9QOZaB7KJZv5mhJjSV2tznJCNuU0ZLWGJRfb+wg6KAG+hBt/gtNsGUcO4L2D+5QpV1gzvlxzjklQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR22MB4174

The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
header and sets the fan to turn on at 65C.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2:
- Change overlay name from k3-am62-... to k3-am62x-...
- Add compile time test

 arch/arm64/boot/dts/ti/Makefile               |  3 ++
 .../ti/k3-am62x-phyboard-lyra-gpio-fan.dtso   | 51 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..bfeb496d5039 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
@@ -87,6 +88,8 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
 k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
 k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
new file mode 100644
index 000000000000..9c05748bdd9d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
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
+		gpios = <&main_gpio0 40 GPIO_ACTIVE_LOW>;
+		#cooling-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_fan_pins_default>;
+		status = "okay";
+	};
+};
+
+&main_pmx0 {
+	gpio_fan_pins_default: gpio-fan-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0a4, PIN_OUTPUT, 7) /* (M22) GPMC0_DIR.GPIO0_40 */
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


