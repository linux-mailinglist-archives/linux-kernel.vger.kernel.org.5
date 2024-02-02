Return-Path: <linux-kernel+bounces-49941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C48471D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355731F27C79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCC145B3B;
	Fri,  2 Feb 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iyoOfk27"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2094.outbound.protection.outlook.com [40.107.6.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07018145358;
	Fri,  2 Feb 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883750; cv=fail; b=pi5GW/NttnMRKw5guNT6G+Gb/CXBNvzNaGUW5dOfuaWNyc1k/X/qqzt6r2d0q4cALAnlFtPgBZWm3/0q3HCSvLefBWXy2xJn5Mu2Q7KnoNF4GovJwpwlGhjGw/4O1dXmQ+7EMu6Z8gcmyy9+x937wms5ccchDmsdph4cfUoclRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883750; c=relaxed/simple;
	bh=92ZVXW4YC6ZPcqYAGAxQaXNVAjywr2YsXrwp1M2QIBQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W/AFz5LnULpiq4zFrBQbPOMB6BArFGx1C/uylN6L+7xBu4tJugsDu0AeDB3Do2XKWSlgglgVQxc4nLO2NmH7xcMcg69h8Gj0i/QeAyQAYnqiZiUbqJ7zpZSfqIJbrK5D0pvqyFk0NRFz3MMoK9dVjgEZcXKAenEDKFzTx/2iScs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=iyoOfk27; arc=fail smtp.client-ip=40.107.6.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfebksbi+JfZvReZhlG4wEJ3knvZ2S3CZvHYXYAIE2Q13nmgDrBbnurnbYQBeY0B+6SNahDARs+xetixXPuv9hdmXWMg5rkNbZFTaowYi2yQ51+llRnLyKeXr8TBNWG7ALTtGzBty7XADs71Eg/7+pHeXikDqnbcI7TRw8PHoeNWhMM2ESjuIqgE6oPg1AYjyX3X9QJk1E4Lw1/USL5t+C1CuYGqhSCEV4zF6rKjvGx8tgB7RUWNzw9HsP7paDs7l0T+bCsK6URMi7V6e3FYyryMPrHhQiDBEWIUju63J6/8ZXP9T2Bm5SapDLEc9+J3Ss8G7YzqHBRzjMcQ2O9wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAVYcajPH+cQj7PkDwcqf/iS4zG1WdQUnJL/lsNg9N0=;
 b=GWSrvFye7SxzqmjPGa7sR9yXipSN06kB+NEz/ZEJmcZugL0QMd7gE8ie7nwtS6gKhTT94VsrNongsYRsDYQ+dI89MQ4nWXF2ZcgmrG+NJuRTMA09OI+7hE2+Ofv7thPtLRgtAyirE3XAGQUtB5NPMsDCigwIiWjx51Mdak+oojdTN9dgNiTu1JDe4q2W3ccm63S65MzGoHnSDgW5Ovjpaov87Edb/JLox1rbB4Mkb4L7FL39c3drhCt7LQgcX1An1sRAcf58kPxWwNlNpyOPVf4VPxQClUTPkOUtQT/45SUualmvOFUPyQk8FeZEWEwdSRpqAPkhD+T4VHQQ5JnmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAVYcajPH+cQj7PkDwcqf/iS4zG1WdQUnJL/lsNg9N0=;
 b=iyoOfk275Nc06DIwvieCgK8WqlFlYlFJOLn0eZTXpWRm8DQHlvDS76kPbYd/9QDO1qJ7Lif5qmTLq4h+OyYpYAkEBJfldVc+ZjpUr2EwU1D5nnY1TKUirOHc7vIe7Lgkr8UlmusrHIr3PjzfvOi7FLr4iF58T3y2xzBz4WJ2uQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DUZPR04MB10063.eurprd04.prod.outlook.com (2603:10a6:10:4af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:22:25 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:22:25 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 15:22:21 +0100
Subject: [PATCH v3 5/5] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v3-5-2f44023d50e9@solid-run.com>
References: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DUZPR04MB10063:EE_
X-MS-Office365-Filtering-Correlation-Id: 04499e16-1d1c-48c8-c440-08dc23fa609d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G83ePnLPmBRVOdgEa3tPjI06NxrnCcDUMy5oCSuchDPwzTwC4/0vazHfIMaZqeNOgAP7ttoAxpuSSBP5uahf8FeDpBedyzAXOx4B2zy0O61lRyje4p2jF2xE28+uJV3G60MwEiI/JaPd4RfRzkanGpOugz+W7wNSokCG3hfxfTLsdlz2TsVRbQo+nDpW6S6rNQxxRqy5gPgZe6RcK1XXYRRhiJTWMQfRZR5PYiu6c224mNq03BZwVzYv5Rd73JyEPFZS2eKSkRo+GHWwzitZFpyGlaIFlglQRoVI7o/4ybYEcDOfQtP5hmXm3O31Vw+B7D6fTBLpn+7iuOUFbpjldMecw4YsHBOPbaUjIw51YAGfd3jgYMYazc476B6rlgaw06+tJI3r1mms24xDr2y+TUWMNpn4+NJUtbJI2mkFpjk/wZuyYCU7EVrk5z32xMZ5tJRikPn8KsGlNzgrImHyFPK5qaV5DXmlTbN55+YsDMgGPU4sQDRymAQJxBcpr3Z75HtlVzAzhJoPGB2UiW6lp4lK8lcL+R6HY2ptc9UzpNTiijYPPck7/tfPzLrNiFMFI8WxNy3mZCb/kSl5pR8Ah9SgAYjkpiBevKJjIPcBnSfsNLPw1FGnjvsPix8vk6ku
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(52116002)(6506007)(83380400001)(2616005)(6512007)(4326008)(8676002)(2906002)(7416002)(54906003)(86362001)(5660300002)(38350700005)(36756003)(316002)(8936002)(6666004)(110136005)(66556008)(66476007)(66946007)(6486002)(41300700001)(107886003)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3lidkRIczJqdllCYUNlay9IZlZZeWtUY25WT0hkZlFVeTlYWWNGUVZ5aHJu?=
 =?utf-8?B?QTV2SFRPVDkvLzdJUmVWOEVaZG1BWVVXVVRrV3p4Tnc0QVpjNTM2bGZUVTdt?=
 =?utf-8?B?NHRkRTYzR1ozcVVVYUc3dURmQ2dzNk1kd2Zjc3RTbVJKbEZjY1pyNnU3YlV6?=
 =?utf-8?B?WU9HVWEzaGlrajBCczMzbWVicGd0SVFkK3B2SUR5dEZYQzF1MVJZZjhmRkEy?=
 =?utf-8?B?YWliWXloZnZ3YndJbVpKcVAxT3VMcTVyUisvY3Q1NitZandMOE9FNUNMRHRO?=
 =?utf-8?B?aDcwV085a2RrdmFuQ1RadmxhVzRFVXVCZUtSSFdxVEdMWm5Mby9COHRTb0Nr?=
 =?utf-8?B?WDdDdkdRNjh3c01WdTgvdTROdUg0K2V6cW4raUtwejluWXp0NnB5RkNKd0ZZ?=
 =?utf-8?B?V1pGVWc0aU90UlRmT3VnaFdDK2lrdW5IK3NBMG1DZ1NRQVROV3JXSG9nOVhN?=
 =?utf-8?B?OE93TEVCanZ6M1FFMmlNU1FTRnJFelhjeDlzOEdBVjlKZEdxNEcwUE8xK1NH?=
 =?utf-8?B?UCtsVEp3N09MZkQ3d25FSlN6V21hUmRLVTEzMlVsR0pCaE8zNnN3WHI2a2lG?=
 =?utf-8?B?cUJiTWY1eWJDTVpBbi9jRFZ6MFZwV2syVzZvZmVzNVZJVFBKU1dTRXdjbzNF?=
 =?utf-8?B?dlVRK2RocnA4VkUvRGtYcFZpU2RTYU0xN0hPNkxkT0dxVW9iQVM5WFFyU0w5?=
 =?utf-8?B?eFlWc0Q0NGIzZkRKeUFXd0YySkl2Qjdrc09VZE1JdVNzcDFGRHpPWThvQmtz?=
 =?utf-8?B?WldKQWo3aXdUUUNabEsvRGhJQ0xVcEFiVTh6UTB1Zk9mamdHZnkvRllrMHJY?=
 =?utf-8?B?b25idXlScTZ4dzREbVdybk5lMUZ6cUxZeTB0dm4zOWJVQ3VTbG04OVF2WlJO?=
 =?utf-8?B?SUhPbXVGdklFNU54UG5GUnhJK3ZoMUt5OWwyazJwdWl6M1ZVT0dDRWd3WUlP?=
 =?utf-8?B?V2RwMUNvSEJORGdjdmZhaXJrektZZk5xUjBDQmF3cURPUCtvbDc1N3hab3I4?=
 =?utf-8?B?bVpCRUtXREtlbElMNFdneTFLSzVIc1ROV3dBcmxrcGRzWmJ1TlZUbVFyQk9T?=
 =?utf-8?B?L3JGbVRqeGt1OUZBblJTZlc0K2pFTVNObUxhc0VCc1BPQyttdHhVTC9XZzFP?=
 =?utf-8?B?VUMvaG1MUlhCQW5RY1hoUVlndmN0OVZ3SjdFcnY0VmtLVUREdkFyRGx0WkdP?=
 =?utf-8?B?dnV2bVlrdmhVa1RTRkIrZVVEWWZydUExTHgvUmFzd0NNQjVUcGd0VmNRaGNQ?=
 =?utf-8?B?cnBDQjZ1eTd3TmRRT1N2SHhjbDZGbVNvQ2JhQWdVREZJZWRSYWdxdkVIQUVm?=
 =?utf-8?B?S25wYjlUWGRTSm9vWmg3a0hPSk9QNEk2WXhnYStVNDE4bmF4ZTRyQkk5NFlk?=
 =?utf-8?B?c0g5c2I0Qzd2YXZjaGZRRkNpT2FmeWVNZjkyZDlScm5yTHF3NldyR2JVT0Rr?=
 =?utf-8?B?aHord0dtdWhZaEpQQS9kZmV1ZVFONlg1WjdkeU9zZmxiMUIrRTJXT1FZenJs?=
 =?utf-8?B?NzdkbzlZb2ptbmVyVXVVb0dsSm9uZDdOYjUwV0lnaVVKd0M1WTIrdDVZc3Nw?=
 =?utf-8?B?MHNlWjBpeEJmRm1WZGFZbDBLdmg4d1JVZXFMTTVkYW1BeFBZaHNUelhkUWJK?=
 =?utf-8?B?VFE2RXNNUGprSHE3SHRrdm1sU2ZCNTNUbTAwbG9jbG9yVjZiclp5TzFaUW4x?=
 =?utf-8?B?RG0zQVNMaUdvSk1SY3J5Rml4T0EvZGJmWDIwQTgyeFcyVU00YUliUThsbzFG?=
 =?utf-8?B?Y3ZKeXZiSUFYTUl4NmxESjdiMWxtQkJpWTdWM3IzSE12cDVqTWdFT0d3RndO?=
 =?utf-8?B?VE9SLzU3aUcyblBka1JXVmM1dnJMc2ViTGg4UjhUeTNDbXFBanQyRTFSYlBs?=
 =?utf-8?B?OVp6ZndFZEt2UjlWL25TMGxFVEZLdXh0TDJVYzV3SXg1UGRjTlR2RWErMklM?=
 =?utf-8?B?NXp6aDdhNEJKTFRnQk5QL2NwVnRVek4zM1FWcDRQNGZtUmVrTURwQ2xDVjEx?=
 =?utf-8?B?bWtXSUdhM3RJN293T2E3eG8wZlNtenluQmpPbktTYUk3VzBOcVRMa2UzK1Nk?=
 =?utf-8?B?MG9UV0dFcFBIYWZyS3AvcVpFMHhXVVdTUUpPa1lCUU5FNzRaQ011MWwzekRq?=
 =?utf-8?Q?Uz9Ojfa0iwSG1V8koW1t5WiLe?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04499e16-1d1c-48c8-c440-08dc23fa609d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:22:25.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBPGeb/vcKcQzp8MWG83jqw4DUzABxOMhTshKo50UHz2LoCZyauajULhiD2IeilYJmc3dcSO9SCJxOLw3UskOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10063

HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
The single SerDes lane of the SoC can be routed to either M1 pci-e
signals, or M2 usb-3 signals by a gpio-controlled mux.

Add overlays for each configuration.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  6 +++
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  | 45 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  | 44 +++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 041c3b71155e..ace72b4b85b0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -31,8 +31,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
 # Boards with AM64x SoC
+k3-am642-hummingboard-t-pcie-dtbs := \
+	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-pcie.dtbo
+k3-am642-hummingboard-t-usb3-dtbs := \
+	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
new file mode 100644
index 000000000000..fd3f8d00c56a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * Overlay for SolidRun AM642 HummingBoard-T to enable PCI-E.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes_mux {
+	idle-state = <1>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
new file mode 100644
index 000000000000..ffcc3bd3c7bc
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-serdes.h"
+
+&serdes0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes_mux {
+	idle-state = <0>;
+};
+
+&usbss0 {
+	/delete-property/ ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	phys = <&serdes0_link>;
+	phy-names = "cdns3,usb3-phy";
+};

-- 
2.35.3


