Return-Path: <linux-kernel+bounces-56828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8984CFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA8E1C25770
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674682897;
	Wed,  7 Feb 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="ZeojYU6J"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2126.outbound.protection.outlook.com [40.107.100.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6A81AC2;
	Wed,  7 Feb 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326924; cv=fail; b=B99/A2r3AoWGWjlkyLOEXE9EefVypOXKKld98Ig9WEs6LmplXgHyh7xy33W21ppcxc7PCWpFUNCx7emSnQ2NzPfgeETr9QlWjL/frUXNrOKSlvH3Qo1SSJ8xTxFp+83d6MemtA4/85aEzYKwqrvVL17W6DeRV2FZUi3RNUQ3dEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326924; c=relaxed/simple;
	bh=J1hlcozeGzr8OfYSueGI4qI4mfDZCrDQ76ixxTjC71E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UvF0O+05483cpAgx9mQ736+kvFDckcHhHm0GElLt2l3iQs6fOaDy16NDiOY6w+Q1kLywP+IWeUfOjWH6aNuGZ0P2SVkpBvdXXJmdGejuhopVXkoNoEtxPM5AN12jupGWBUvGHmlpRLTwRGKU+2Q4yApUxQwXMuKzcWjvtV7yM94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b=ZeojYU6J; arc=fail smtp.client-ip=40.107.100.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtlx3N5rUOG04gUum4l7u6CQ2dEQ+bCT7/488q32TJVgwJTrb720/DnZ7jxRN/BiYUylXsgJd0pi2n6P4JwxHLFdO/A+7m6mLhocJ4VYRlpqAVgjjuagdyEDymbKw35mLZUxzN6DTorrdblt4zFHhE/kpt00Teo9MIB7YRXiDRyFKryC4ltz56CwV9/s+3niQy3wtGFLEhUccfCEXo7HA4cL/3Hi2zYE6kgo6XrjXCJtpO/43ulLXZgin7u53NacpdEgt7zoJ8olVeQozZC3ZDbmvjaaZZNBRa0IvqWFjb5vqLDU+TN3XsXG1YJHj4REJXcKO/mS6df2wAGvg42FYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG053cT3p+fOUVgJ50JKKHtA0A8WHDQTRWq70i03JEo=;
 b=Ay7mAsVsJwviXW86TDP/nBIHn4awYFz44YvjDTVlqwxGrgBj4ll98qlxxSxc0SLzg55R5CMuTs3bfarj5qegKTx2zJEfKeK7wutOihIXZlCq8+xnHa1tYCILxgaHDaGPr2Q6nxGzWuolbKAbXjeFUFYBmc/dyW6/C8fMrE4NbSr1BZVWFpAVcboZHMy5GjeUbOhlYtZLRKgZ8YF/qd4O6Xdo8O/nTz3tZ7B5Ofc7h+zQxzKJSWI+OmuHFpAtc9luI/OufSqpr/W5smhuTb2djAH+opRKG1EcfO6cqjszx9bbFAa6pKbOWYQzXAikprp75q6/wP8lwXpBUTGvmXR1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG053cT3p+fOUVgJ50JKKHtA0A8WHDQTRWq70i03JEo=;
 b=ZeojYU6J9CyLp3bBJpmVybgsEVuyKjJE2Bwj00F24KXj9Nom2aXdS8H5NAyO+lLxUsTKpWbQgTfwu4YNuh6bCXKGRMx1L3FmgZPKo8R2PucTWv1LlwFQ223HVMbwfDi9EmV6p0VoMrrW152LiLIa9bjkdxSRqAnudwBRcE9H+ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SN4PR22MB2822.namprd22.prod.outlook.com (2603:10b6:806:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 17:28:39 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e2ac:f990:32c6:334b]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e2ac:f990:32c6:334b%6]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 17:28:38 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan
Date: Wed,  7 Feb 2024 09:28:20 -0800
Message-Id: <20240207172820.478332-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:b0::22) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SN4PR22MB2822:EE_
X-MS-Office365-Filtering-Correlation-Id: f49c0699-1a97-45ac-a0e3-08dc280238b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ndyiwrjQUeP+W2c52Ney+Z6rTtHhL5+vyIGPWln+rG5BXx9NEbotEw69ryFS/j7XNJaUfz01+Pe7IPFZ1kUoTStha/Fab6OF61ZdpWZPSIEmG4lQJiYWnGV5gQ5q/dVHgrUvzoAS+BKE8vN7pFZPguGIbJAbTDEzWXlSvDq71NqC7yXfLVbGdmOqNJrQEkDsQ5qfq79vzVzROkn1rw1GLkvHi1VYfD57jYnqGFxF/XEIolycPtr+mZKSWiL7bHPqFIAa2cbYUe2ybuWZq8rOSW9A7UzRWqXKnKHgmvlw7xZV4ovyNNXuRizHr4j2u8SeN4fJd38bzgXR3cFhaaYOzgSNtsa5ArIpHhSOuVk3vWGlK+MQTpJTVlE6rIre7CiEc+RVtj5AyELV86XeyJuyvdBhHmPJ/hflz/1TYkos5mComfqIlGEVJBKPo/UG4TSJyOnci40Q2nqn+qHTqENe2A9QTgeTup8GcYLgu3UpyykM30n+FLH0qfia3TpAbUEtkMYiZQX+iQ5vkcnhBpL6yhHrqBhC3nViLLTdYYN7oCdBN3oKwmkKfqT+ZB/A8Ckq2s+EimFZn+JYs9l7WeBo9p68kb5fm7a9UMn2kq7DSV22krlM9f6HAYKCI4LDa9Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(1076003)(2616005)(86362001)(26005)(41300700001)(5660300002)(6486002)(2906002)(38350700005)(316002)(66946007)(478600001)(66476007)(66556008)(8676002)(36756003)(8936002)(4326008)(6512007)(7416002)(6666004)(52116002)(38100700002)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONc4tzpuAhiOaoIw4MXqiA6LGV+azTjg6pmhZlQcMqPpFP22LZo8uqQQUIQw?=
 =?us-ascii?Q?vDLW4JfmnEgFSxbuLRtcWwuiKnwNrodlXpOMvcPkSplTRletiyENKlK/EqAa?=
 =?us-ascii?Q?Y0OiBgLHF3TSPWGTBjJw3dCZA0y5qVrVV4BWczzd4whxEpX1eZmk/ZMaCgVG?=
 =?us-ascii?Q?dLSLTrYHK+U4AeC/49vZcyTbx3yQpPqyt8Yja+nVRofT7zN8K0zZZkjP4dzY?=
 =?us-ascii?Q?3HJ/osAjIlzFEdz5HRevUkIOuNpzvRovlE7EP0hBRXKs+IK+CVZkKvdn+C3i?=
 =?us-ascii?Q?XugwSu2sJ1gvzEn5s60MKZrqcTspxEPJvh3ZqL0/Y3+L5LZ4cO6auH0DCUdw?=
 =?us-ascii?Q?7GclvPTVPfiQh9U9on1ZU6mmF3zhW5QzyZ9UYMuJl01PUl3b1NYjzrIADrJv?=
 =?us-ascii?Q?27MGOxil49ycu1/cBysWvwxJvslPzTt74X28HkNXSGcUCtD1r6XZMGHzkx8h?=
 =?us-ascii?Q?cP8r02ZlE3DpaqSpHXz+4KxDHf9wIk6BlrZ8b39yVtXNmJTMy7LEyRi43B7p?=
 =?us-ascii?Q?vGy3/vq2HwiEJlW97sjo5oED64ReElQdmYy2mp8HIyhybq/dO/b5jhPBgreM?=
 =?us-ascii?Q?J7fSbwlhMEuBca+7Hvu1U46bJtqK6CcfjNbxlw05JQVFImg/SHOZns68Yx9m?=
 =?us-ascii?Q?+qZBFabcH8utQTZUsLOP/mqbLhs4AiB6Jo9YgPNOThdoiCbt+qF21HTuWOcV?=
 =?us-ascii?Q?35OicM7AenaTjoy/6GFEuvNx2Cod2/ya5KE5bpBxfSAQdEMxb4xHpHSdp0AE?=
 =?us-ascii?Q?Ce5Pc3bjEXZOVe/jea4tlOyBpCVxMXRd0WL/rsTs1YhfXE33agNW5q1n2Mm1?=
 =?us-ascii?Q?FYh+CtI+wpt4MH0qXEEdZ6CRIMN/yDELiA9f+VVqI1V8BGNpnwGbEOr2nBqp?=
 =?us-ascii?Q?sFHxHvh04wRXa3nJeM59QALJYPHRvVV0ridW5a/R/7ypY7z9UJTKifLFfRXG?=
 =?us-ascii?Q?zNSRYSsy6nGs48xP1BqYfUHJLUrsEk3D2AZsQTQ4QCzDB3DtVF+EkRET87qL?=
 =?us-ascii?Q?MdJyb4Zkkgcpyq9KjpzfOmEWl5NpwUHBnjhfDKAHmUtV08o3wF6vm/yi4TsZ?=
 =?us-ascii?Q?pniSovpcBR+UBBtu+OG9u0NM8szpCl+cEpT3PkB3BCeuQPmdfE0CoOkwqecG?=
 =?us-ascii?Q?0oZt/CEMHTssoCadgzCFCiokDv8j2qwiV7Unovg7fG4sbhR4YJSM4JTBmnMG?=
 =?us-ascii?Q?3pRPR2Dpg9qzySakxMqjWy1l4FDOaHcwXeg81/XMBlYlS2B1B7tXntsi127O?=
 =?us-ascii?Q?7KABNIRgtXryCuIV7yggnhOcsS/44R905NxUmxQAY6tftMbB7yI+yDl7mfEX?=
 =?us-ascii?Q?/DS/W5zofk8mpBu8wU9ckb/Tli0ixO2w1ckkmSx6GQm6w6Ot6EpHK+H8MgLg?=
 =?us-ascii?Q?kHG3qc6Uw+BcZdEQXguLj6NzGDuB0m8k1qC8g4lT3hvf6oHcVW6epshhVK4O?=
 =?us-ascii?Q?CBlKsZwwiTArPjIKntjB4LCv/k9mp5qZx1twcovc7bqFk+2Vlde5kZyE8rxu?=
 =?us-ascii?Q?HUhnZKUJ9IYrUehZI91AoxiWqUz+2dgT/xu4uvQouvmJUrOF0DvheJoYAtnh?=
 =?us-ascii?Q?1om8ArGsMdZJ/HT8rVRE6z0fIBP6OB4NLC7QJ/xm?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49c0699-1a97-45ac-a0e3-08dc280238b6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 17:28:38.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSkmKVs4UOaoqw5ZoV19xgSw1U0CRWC24IQqrnjscLav4QVHkpGXjZkAqTd8rZGzaBEDa+u693QsRI4iF9gFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR22MB2822

The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
header and sets the fan to turn on at 65C.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  1 +
 .../ti/k3-am62-phyboard-lyra-gpio-fan.dtso    | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..379fb4f31a1f 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62-phyboard-lyra-gpio-fan.dtbo
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
new file mode 100644
index 000000000000..9c05748bdd9d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
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


