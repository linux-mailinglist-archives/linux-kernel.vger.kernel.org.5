Return-Path: <linux-kernel+bounces-161645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CD8B4EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D111C209B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A84624;
	Mon, 29 Apr 2024 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B8Yxy/cH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2037.outbound.protection.outlook.com [40.92.40.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F207F;
	Mon, 29 Apr 2024 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350669; cv=fail; b=kdcHEkUpIkycCPlQekQ95bCt4EGFVGHi0U8atlcASz3eU81fYsU4AKRzVfLkOux5N6g5Krta000zc6p5t2fTDmcBGKw2qWysChWwoQRFmDizniYHHPtaCXuWIp5vBuojJ1oA6cbav63KyZfhOiyFW9R1h1ihkBnPLBwl5qoHvbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350669; c=relaxed/simple;
	bh=jnHjgVt/M3RoescoIr1g3FR/z3kCrkle32LPfd9gSoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEm5CYslvo5mYB4JrJff9Jo3f48Zc/mtcFC77kf/V9o0+YfQTtsIqpFPnKny9Ga8VgH96kdceU7uIp0wiADFnK4drz/uPuTuT+SKukV77wg2uMS8wyp+/6uGEHoz93sO3aU/udFLsDQcFSk2J95APtNde2qhmXbLJDf6cAKJq7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B8Yxy/cH; arc=fail smtp.client-ip=40.92.40.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwuOTyty7fAlb3oHUY/dUc1ShSrbITy1BkMWptGZW/cyMefgrPz2sUHjC5VRqyn4AO9WRvhA7NSlFHx3f2BCVqMnqFWjHicg017X+YFG+w9MhHA7Oih5kWWAvyd/l9IyBaU5xcW4HkzppwSoQmrKBLDNvliqTYQb7VCiY6ptAJmJGoNgRrTHZu3qjcKYbL5K4m1ZemO6HUKyuOv30hTwCcRYrsXcasa5diKtXbOBZwLYdWqEzZG+m49zokfJ8KwFtR76dp214wbcos+7p+BtRZQxsvugzo8d5gRXBsAlIjCmXswxbGRslQGvA8TeSzOtHhBCJbuQ0vnvZg9LihG5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki0dPVLZxhyClX7JvgRmjpK+pMAR+r4av7UlE62CZ+k=;
 b=FnFQdok0t/+wC/X7+kl9HYR+dh+ClACcDW9L/obLpd6dPrjlZLMb8TF628amJTJXyOWiPWE1P7ii7BKjBNoDOXp3vwKd90KNh/HK+29Fe3lcxZ1euAKDFkiKDWELy5L32JKXtD43T8HrGn+2pHf/YFGgN5Rx5OhbyVMhXxJ5K13+clfZMJPOlAhBdoXhoPul5MivpEFwif0blm0L4T8ttCWgBbHhC4M4a2NZe7NFSozuHsWcj6Z+u6YlF1FEZDAKFnG08jm4Zzjp7SSN6xqzIfLZ1+Lpmpl0qPSP5u2AnQZsjpWTcDQNkcYYUOuUAeaKAknQ9EF5HAIZwaGYU9m0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki0dPVLZxhyClX7JvgRmjpK+pMAR+r4av7UlE62CZ+k=;
 b=B8Yxy/cHunfFw0IP0cFfzrUvL7WEmuGwJdl4hPAoA31GrOIDuB3dqzJ8+TUUs2MTAYTU3CX8+DJUBtvxjpeuaJkeAHwVlSBq+y2/J59/jYTZOhZhPtxrSKqXFGGCD+rhRt2Z0UXbL64QVb24WNC2vAEZDIursA/2x35nT63U2GEcVXAghsm4/F3yWuBD8HDWFSUeMKPVpFyU61zBDvJJ5+lfVy9Kw3F3F2RF9HnkiV+hDtFHhNSIfiNa7QO8f9w3Ed+WSk3/oxJls8s7Q631IgalihMrISo6l9vesdwNH8GVj6OnRmeb+KoDr543fFyfuo+NvROnm6ELxibVbJzzUA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6009.namprd20.prod.outlook.com (2603:10b6:806:339::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 00:31:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 00:31:02 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Date: Mon, 29 Apr 2024 08:31:11 +0800
Message-ID:
 <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1ZlEETfDaNL6KNIE3nGTyObqvfdPfuw7MFVv478EWFM=]
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429003113.108667-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4570f98d-4455-4f09-a78e-08dc67e3a638
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	3dyePR3VoIHN3OQSzOGzDwoVk1YthDStRxw+gV8iCVINVwpBpgriYsLLBV5m9YxUgntH7UVP/9jVMUhrdTvCu8os8xvk0ANbrDQ6IWcxgtYK+TkJp8XgDt/BA1JoR74hVRFiWQsJFEItsHZEfhDtGFvsvfYW4pMdLZ+DvDLDYyexMCl5mABr2lr3M32lcSMxl+J7FTQIknoywixURj1utUZvu8pOZ2OEWYW7B7MXzTRgPVdKApHtUXVCqErfRe0JAFCKXCcvMiC2mrDWp6r3Q743P05xBYqJar38sr93RGIuQmGWDU02fLH5Jne6ySE1mvqUfQwMRhKI0a8MJrIp08SJS4X2N2K4c+8/HC2PlMoqfat2MkRY/53R232J+e1wXw342xodjwbf2XlkBHLVqUrI5WaN9Yz5TribloyFknMVr/f1j78GNJ27zMRDkwIs0GVPSqFJd+rUngKlx64KHtx3QeEYsPfVkoEoacyPmDWQKT9G8p75j0zeXnNLXeslILt0o+eE1c61kLKhFIDiLNdJ1upkNf5yTI3Icq8dtZWL79f8D7Bgh++b5okdbtUzgwWjpM9QZe5enyXPTkSzm0qMdDzVePWUE68nTyTASTVs+VUm4Ankb2VygXKJe/2XK7PXiosTQ0Z68NV6NYBZyjjJAhnG1ukbhDZCXmkEKYEUNG+ZUAIxDeVPOT61vph/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/cHperbwiuDafCKDalx1TsQn9aNu/dqxZOCkN3WQ2e1rA8r6kSD54GJDvjIm?=
 =?us-ascii?Q?FtYwSHzwZ6d6WfyugQ1jxCEwDopqSbHI1NSJYevOuxLBTPlGmky3IuaXeVgz?=
 =?us-ascii?Q?WV1kxeBLYYcEen81Jvrukf4dLfWFKFvUze015sYbNsPibqFRIvcy/lFuy4Kq?=
 =?us-ascii?Q?e8HL8KuD677i6ls1x+pq/uY2LEzl+JJyoJfIoA4vApw2RhHpJLeXo6sPzdqT?=
 =?us-ascii?Q?R48ndLc3uBoG0qxXNEIg5VD6wBMbF9C+2nT7lN+XEQpos68gFTP27AwJcGd5?=
 =?us-ascii?Q?8cY1NKVVsrPnoXuWXlFs9RKCI1hMTChgd32poYaVeTPdzp/AnmarxnZyAVoo?=
 =?us-ascii?Q?HGr4Y+8zmptEDCP8XHY8iEHtkyJcioKtc3HSfQpEhwuxxS8qsSP8km3phbt1?=
 =?us-ascii?Q?TX9KLGXirCcqs/ZbnvOsssD2Ah2UxnmoYTQqclmG7kUyfv1C7XEohePvpJNC?=
 =?us-ascii?Q?DOcSwXASaX5biu78AXeC5NRgD/CHfwzVCGA4BCBt6Kb2BNVJ83pvnGy4Irf6?=
 =?us-ascii?Q?5XuAgra3obsL+LvrGLKeCLtICz/ATITTqS31YASNW44C1u0+CbeP4fK9walX?=
 =?us-ascii?Q?KvJNjlEZZMphTp2p4cLVKEDDUFdqHcDumUkXyxkVkBpCHj0zCO7ZFJTgT4sl?=
 =?us-ascii?Q?t37oEGG4SHPszX8LtwWYthyzjNO4/ToDoWYTHKMlrJGhFGDvM1N0CakG8P5g?=
 =?us-ascii?Q?wwl/twu72sNh4GcWypF/SvixffyUSeTvZeAxNbCU0oOEnq/COlofeDREZ1AM?=
 =?us-ascii?Q?iXDL3x5dUbzvFzvpA4SK6E9q6+bvIopUtZ7roDFChpDxZXx9jA2gM7AvY92b?=
 =?us-ascii?Q?k0LwOxDwbuUJbOSWUpVgVZnjnA7jASYDBlfF8dnKuuitsi1+nUF6yZeswb2z?=
 =?us-ascii?Q?RZJMhyB2792kRnbnW00uLh2NpH+4ipiam+99SXenXQkSEMJvw/oypWn7e5Dt?=
 =?us-ascii?Q?SRernAhFFkAWWdhBlBo15xRiPr/ODJu8uMNEM0YY7Ki/ocgMXGCzUALxi/L5?=
 =?us-ascii?Q?Vtpiv5cCIWOH+AAqbzX7cC9UaWRSfaTF+S4aJOrg5l3QlwuSgV3yYvnSXFVa?=
 =?us-ascii?Q?l14urYNLv6n/4zHx4EoWwnFY3iinjo48RjHsv1RzK2jR1faBUmo09ow2usYX?=
 =?us-ascii?Q?jDCn7YCLasAUhID6Yb4zkIYE6ofvRxTnqJjN3vK6k5f48lUXqFVBzsGsdXvL?=
 =?us-ascii?Q?ZEf7tJ89WB6Sjk0kQWmUXs6nDCGNh03HSgUGFdy364rjidyu+m3PR+CQxuXp?=
 =?us-ascii?Q?rUnHwCBiiNekew9eDEwQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4570f98d-4455-4f09-a78e-08dc67e3a638
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 00:31:02.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6009

The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
"VBUS_DET" to get the right operation mode. If this pin is not
connected, it only supports setting the mode manually.

Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
new file mode 100644
index 000000000000..7e3382c18d44
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV18XX/SG200X USB 2.0 PHY
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,cv1800-usb-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: PHY clock
+      - description: PHY app clock
+      - description: PHY stb clock
+      - description: PHY lpm clock
+
+  clock-names:
+    items:
+      - const: phy
+      - const: app
+      - const: stb
+      - const: lpm
+
+  vbus_det-gpios:
+    description: GPIO to the USB OTG VBUS detect pin. This should not be
+      defined if vbus_det pin and switch pin are connected, which may
+      break the VBUS detection.
+    maxItems: 1
+
+  sophgo,switch-gpios:
+    description: GPIO array for the phy to control connected switch. For
+      host mode, the driver will set these GPIOs to low one by one. For
+      device mode, the driver will set these GPIOs to high in reverse
+      order.
+    maxItems: 2
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@48 {
+      compatible = "sophgo,cv1800-usb-phy";
+      reg = <0x48 0x4>;
+      #phy-cells = <0>;
+      clocks = <&clk 92>, <&clk 93>,
+               <&clk 94>, <&clk 95>;
+      clock-names = "phy", "app", "stb", "lpm";
+    };
+
+...
--
2.44.0


