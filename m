Return-Path: <linux-kernel+bounces-62775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71866852591
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965FB1C2426D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712261EA8F;
	Tue, 13 Feb 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="SQJHBn+V"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2090.outbound.protection.outlook.com [40.107.223.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C308BE3;
	Tue, 13 Feb 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785586; cv=fail; b=e2bsLWOHJ9Pa/qwf2icAoPbpSTGYT0KAFiL9zpRixWeC/VVO/SPg3tMc44dYFVNNKTUnkj/Li+44Ku4kBXq0d9MmI450Kx72FxYtmJqFUtWsmgCey1ldOVquuuahDa5G0UWFq7lpNdYDitv30/QYDag8DKIWnGiWzhrVsttq28s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785586; c=relaxed/simple;
	bh=GFE8vj4/TIefGU5yuDDBr9Q21hamCF2WCswoWB/cT+c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hrh8nWxFlhVPA6hBAXz3jr4scmiY+QZ4rWUFLdr6J+h5BLQcobJ54ZFv4F00t5mHc+tq0Ckx4EC92VBhP407PjJdkEJQXSnRDPliAotswCPZbl0vhUme9Aq4hCidbG7z4TIu+zSqqjvs84PvpxR7iUyxXAgTvYsaW2uj9+sT9P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=SQJHBn+V; arc=fail smtp.client-ip=40.107.223.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um78Ieeg4IpThnvo1ltGZZviRUBdHvhl8M56zjuC1/UgCXnbGHhuOoS+mvESC188vm4F6w+0fmntFHj3E1fCjQmQUxIiij6LkOtF0xbuGCMg7SmFmkJG3CXnezJfF4JX4bdNS2sjxq4rF9arkBqFT6HPuYXkkbjzjCx5Xc45xp/wrxdIaxTy0r6uRlCeUO+6H3Lqjhesx0Sfz/qr7sRcRQbCDWhahbFf3jzG0qzOhgPYOplvYXs4bNJ1H6NQtcuEjuQx58GWLC/9fDQ70NQBLhHGfctkU4rH5c/m7c2m8pKMqzi+Urq4nEh4hm1P5u0VhvHi8p0m7WM1PIXeLwzYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOoMI4jBEfOTxj/K6M0amllauXxJhG+uYIbIGmmtrYs=;
 b=Onoxc6XkBXj5sM7VCwBOJiBg5z8dYralgSi8WxsL5vf2Fi+TeXDJ8isO60ak5gb08tbbE6yG+T3gv4zdj1SWTO9qxT2Tcu4YSXjNGTTwdE+eRladOR3MJmlYrmnNsiFjCEOswryULD4VbBgh7zEK6Xj/P9OlFj9s3Ow97LXQni/k320MnI9ttFvT9BgeyCchiP70lNRq5Q/TaJmN+PSaKGDUSSuf6YIJT4D+rj7dJ6gqrvEapcLTUS39pOsSQkm1Rn0a2Pv2ZJtJh/srSfxw3bVOC9y1KcOK6374YzZ4lqZ6Obx+Ai57Z/IJa5mi7SRzKECP8zEsYMFb2PEYWqiW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOoMI4jBEfOTxj/K6M0amllauXxJhG+uYIbIGmmtrYs=;
 b=SQJHBn+VplWnaG0WZFOKaRo+fwN0EY/yu9ryeqnrS3tgr+kCr2Mh3y7dL0fzXuxLOgPn/BhmGczacQwZh7wMqDCc+HV8ecU1Rk+thW4ds1e2gAuTlxWA2Lvx6JTCMfrB1Ipd7JrDMc7Lz390NE81Vlr8lZV92Q4IkAKHhOpia0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH7PR22MB5397.namprd22.prod.outlook.com (2603:10b6:510:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 00:52:59 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e2ac:f990:32c6:334b]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e2ac:f990:32c6:334b%6]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 00:52:59 +0000
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
Subject: [PATCH v3] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan
Date: Mon, 12 Feb 2024 16:52:48 -0800
Message-Id: <20240213005248.1027842-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:610:4f::26) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH7PR22MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1a2dcf-8d19-448c-6ca5-08dc2c2e1fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IbI8C/G6y/dtyq8rDoxew8q0DjlI265GfcHdPju1zVnIZHl/axjJ65hIw23N5L3L4fGhWRhyyZMfDbFke22Yw1Z3hke+6vEg+EDLpK64GqpvQapFgzltHjlhVnNIbI7p6FOOK1xZcwgYdeFiuyinK+moznjZtsoQz56ueWGLp14YVSqFh9rSBra/ksGWvm4gcmoHVo6k5w+84GcPQ3YDraRRZqiy4qtm/WvGXEICKTTK4eD7LumKMZ4lV4eXZ7hCqH27/WS6DDddUoyD+HAGHOUFWZ34u98rUykbO6/V3AAaelzDLziFmYWPNDkFGkXoy9UPqftrV34bJfhA0QTFo12LPYO4Dkr1Yv6n5yNP8wJGiok8y6323DGlIBQ8BEs7PMU4o7vZ8uYdML0h/ayDA+Hq44v8WG2XMFlmj2Oklc/xRDiDLJN7/l37ZUw1IHGTT4mecH45zLxNKohAc/UteuLnEyC9SxX5qbILtsT5pnx1zZdLNVTBQln2pb4LQNIpop1+Xj4MB1KIcc9UsvmE4V6LNSV/Nxbi/LMCenV7Aec/iQXimCi8XdvK1jcFvVBAUvSnVQoUyQq2FZYE28Szp0eXVsX2G6D5EdzKFCpj8MRUedtWYPTtFeOxq/lwtlMs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(136003)(366004)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(36756003)(38100700002)(52116002)(6506007)(6512007)(316002)(478600001)(6486002)(6666004)(26005)(83380400001)(2616005)(41300700001)(1076003)(38350700005)(4326008)(2906002)(7416002)(8936002)(8676002)(66946007)(66476007)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJ3eEvKFvvEw67YOJ6yvPOl+B6PEkHXltPhxmhjWAEwv4i+p5igWpK55yCeA?=
 =?us-ascii?Q?XIPfbRlRUM7poRoDWG6OiWhOniAxFFph4rIHmMkCN/JSdM5hyKBimOAJ5Plq?=
 =?us-ascii?Q?lyEn7o+jwqW96y0G1qNG/LI/T8lqsFNwlahkYlZ8vFsJVqfn1ATK54k7lll6?=
 =?us-ascii?Q?ZAfJb06ebrAs/+OCvMtK00NOGK/K4GwTetYK0Lli3rzmf9h+givhlfmX0F92?=
 =?us-ascii?Q?/DLEGiSSzDctRiQGIezBKo5swhvgRpL6qbZT+XPSLifZa/fe44JoBB0/xmGG?=
 =?us-ascii?Q?oxj2HLUyAGn4G2pyeWiuv5Yj0wk0Okc/yysFYJGCefB8AUOxpzh1Jh6n3AOw?=
 =?us-ascii?Q?dccutbGjnPq86A6p5gCfuZdDsCuJ3BGxbxEzbJw3WdLxO02mrjoUKivb+aAn?=
 =?us-ascii?Q?L5Jwz5Rnd+6cySxi0LxOtqEMTPYfqE9POSAHCbsPH/ashBRYR8GwsS0BYnhB?=
 =?us-ascii?Q?ieXSbqDMOdtdrjD0Y+TX0+Aq3l1oLTtX9hFpTdpyLkd2H8gsGl71GFUh2kh3?=
 =?us-ascii?Q?4jQthvsg2QVUIhV9UoBUNuCS5nm6mGkDB9XpOpR8mN5nCwO3W945DDSxWaRL?=
 =?us-ascii?Q?GGtR5TQgglNp6+65ppr/MaNpRUWHlZc7okjJRBoLZoiddy8rmacaDZMApXNw?=
 =?us-ascii?Q?oAPBUAIPMd/aPDriJbKNrw4XuDUCijtrw8vgYychA6mUCZPUA9krdA/1i0Ph?=
 =?us-ascii?Q?rgsFk5so+sFj+jgTF4VVXPyGSZGIzZWNJOA5Uxfv6oWZ7RK5Pzu22+B7euMT?=
 =?us-ascii?Q?fBZTbn/xPzvjCkfk7XS0GuaSGifRL0KkT5cg+IxdQtmw0kg4UfXT/cXL+zpq?=
 =?us-ascii?Q?896B4Mjnej1MB5d82WXQxJa10oTeWdZsSKyjKS0h9TsJ+xIapicBCQpMq7Ko?=
 =?us-ascii?Q?bLx0CmFI8IOhzZuL59VvqoEX0IVPIJW2PFiWnc5co/UrJkgxr+ykNsRJMowC?=
 =?us-ascii?Q?8RY3KcYn/TD9ekV2EoZZ33ChNLU5Z9bpjPaH2WPo8GO9Der+zF4xZ3ckVCTc?=
 =?us-ascii?Q?pH9g0bxLLS9r0GS4/qhgZO13zIxSikXifDF9GKXDqcbyR7qistSnQJCELkKX?=
 =?us-ascii?Q?RUEHCEteiUlBDNGI0C2Z/ZpENh9iag8sqrjME4yfwaDsmq7uiGjipf8ewH1F?=
 =?us-ascii?Q?shQPiq0B9GQIlqwvfP6XoBjADvBIk+eKg953vkXbb/bMmWB9QExgKZ7CqhZX?=
 =?us-ascii?Q?WV1k+luU/aAauidjFgRXsOkbJjKfKn2kqc6ie47l/y4DpRgQo7qPk6OZJ6wP?=
 =?us-ascii?Q?fQZJ/hC8aXoWHzxB1Py2EAxaQwNW8GUJNm5udi90OmqABqBleX1W/kqs/MW+?=
 =?us-ascii?Q?e25RQcdmc5Pv6Nos9DXp90AcHjHrwcXXpsaAITxMgq/+v9jlTAFN/mP/6UBw?=
 =?us-ascii?Q?jX98ySrWR2CjZqOvGr4yMP6r+IyOk5gDdHnVa5waXVeOOA+UQV6xUk4sJ89G?=
 =?us-ascii?Q?/nYsWDQKpXyVH2dAnlyG7HVqQe3B+s9Mi35DO/f9NYFDTceGAGq7kKxYZWyV?=
 =?us-ascii?Q?jnub6JNYuG1iy2V8M+bwzsE57I5Crt+LGkthJwWXiCgtOZqRddejThkjd4PB?=
 =?us-ascii?Q?5fvYQi/UhpAYV9LieJNn5UnQerypqSsEsHnTC9Dz?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1a2dcf-8d19-448c-6ca5-08dc2c2e1fc8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 00:52:59.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0FEdp7mOJ9K+xx5weKRGwm3ecdWRLxDWVECqlI7UCSdjEkgxFm7adLSJHb0TCz38E+X+oMzfEb/Llq05+nqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB5397

The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
header and sets the fan to turn on at 65C.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v3:
- Remove fan status okay

v2:
- Change overlay name from k3-am62-... to k3-am62x-...
- Add compile time test

 arch/arm64/boot/dts/ti/Makefile               |  3 ++
 .../ti/k3-am62x-phyboard-lyra-gpio-fan.dtso   | 50 +++++++++++++++++++
 2 files changed, 53 insertions(+)
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
index 000000000000..f0b2fd4165a7
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
@@ -0,0 +1,50 @@
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


