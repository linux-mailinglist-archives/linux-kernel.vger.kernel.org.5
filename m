Return-Path: <linux-kernel+bounces-71537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7DB85A6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE35B2119B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886C83C697;
	Mon, 19 Feb 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q2+aSMMN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139F381AB;
	Mon, 19 Feb 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355035; cv=fail; b=Aff78fd8dUKqMCnZDxboBZOfy3y+ZtqwY2IXd0rjqmEO0nHUA/xa2QMcS2LJtf25Fh0arvnmyhIt3YncZdbBdmA5Vv4isYix3zPomuSIgkNZG2Qj/qhvm5KH46CcJrq1qf1TSaJD4siOQ34+pMEG/IkOnv58prJZSXbMy/xExso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355035; c=relaxed/simple;
	bh=ph9SmBrIBTf6R2xbWGu/syxdAkOOkeOxs2zCuKm/0u0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WavzmZao557KLIXo/LW6RfEa+hvzJbbkoGZrl8bzn3rXpWeQqSV475ijr3lDYTYjjbEx/N9G1uieeCQr0yffC/JQCLs0gGUci1Qxss+mSHwPyYF2BQp7dVFE4Whj/ykAzO9JwxFn4q55ACndHK5BRD/eDvMAJcDXLjvNuMxmTqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q2+aSMMN; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es+tigZ+7+n/1tS/+5LqfDOcP7+CINtEx65Cq9nXzGhfgtZWkNel9sfBmF7Fwofam4C3jMO5XR7ZfnrssBV+HTE+r8YqV0pr4lXAy37VVBfkKk965JuqPDN8bd12Ivqanf5dyY64Dhw7LfGK/W6RnACcrmWc0FoXSD4QZfVVSAQXfCOv4CZoxw5YFjI2OVPT6ipYd3jI6p9qg6ZaX1HWo+0bl4oDEuyOroHKflHN60OJ3tnvQIq/wn4lzZo23PXwcBeYkYS+qY58uiyD4VAAvHuHeDzE0hAPxXI2HMxLtvQa713112EZh53N89f8Z7iIFxn854z05+oJzLv9T+W3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M49RPVQDRuY+V2FKFZi99jgURfuAsNCh4dhWzC7A7ko=;
 b=eBAfI3Ch/qzQZ4bRMZElwzcCZySb1z0LuX3HVB/c8xuSSatwmsCbUxWierNQiy2LXjlj2gJPzV3ZQ0fwU7rNe7t2m2l2y9hamhngwOn8ip7QRKDyLflYfRBb6S6o+GdopRI/yv69eoEbEzB+jdhlstfsS/7PAjSqykYbJwQ3846p0rIRMQaQpYWjjOz90EQpn/MYNzsBr6y5vB8MCkesLxqAINofdpQuNdHNjnwgMFUCDhxH8It9T8cEUz9k57un+s+gQOa4FoXe610pz0RZsGRSscdgOIwqLwEdkFEp9jwXweZycK47W6UkcVGLq8FHZfnUCkYbAcF+Z2S5If1Zxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M49RPVQDRuY+V2FKFZi99jgURfuAsNCh4dhWzC7A7ko=;
 b=Q2+aSMMNDRl3xLjbJ4fAwDZibKc56jOMW+vlsfLMu8brU8aRRwp/Ryr+u+yRmfFSi91r3yb1CA1txan+oys07FZTcCR3R28CZmzM3QvBQELDXYU7TI4cVTUp3oSpQMJJVM9Jtd6i7mTmsek76j2flhge9KmtNIc0bpiYr6Z9HxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 15:03:48 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:03:48 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 19 Feb 2024 16:03:03 +0100
Subject: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
In-Reply-To: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e98fa8-a72d-4dbd-5f2e-08dc315bf9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WAAxZ2L1/51t/eD9wgUg7X1qOBa+gbdpa/pmFiZXk6W49FJ40anjk4jE8zA+pa9LAGYSANarWeY4niuWvcCVIWBnueaCkKrU3AnNXvujLYUTnRL/vdQLiSmMW6YO/VOsGpCYSi/kaNz1/LgHluomIY3WyDXAoH0P/8b64JiSkbir2CICk/fKtneYxWAmFQ73Xza5icxHMPAUsoBUKxfZytFIaPqGDB9NxB0bnONcSKZQdbsJwvmoUu8D8YxRwl8qBwWkDOH3LsnAjMZvDKqqdRZajg2kTplL8+oURax7D2wUxDfHKHh0w7EAhCAk/pIWuW67B85EPehjZFK19+4B9Dstpz/1CqrCRkLxUM6ntRGQ5+AKpkfOxVAU5031g/8Tt+CVxT5ySL+YvGDIL25tTXqODwjgRutHpM31bhuU3YVgmX8Ub0Xl6ByaU9vEd7NcyQiJkU2FDcoR+dHP6jAQm+DtthWYXylmZEl1oCI99qByYnaCe0Zkz0SPndC4enwy9y/WvCGg+dSYWlXmQmjJsSz1qd7QaR4vyAyiePvw8lKDdYrUnW4NV1b6GZnY2MzQ9qkkPBWdZZXuZo7/VpF9OcQmF9Qx2KtDIWCau/Z5mYi1OU17iOrQoqlKsS1AgDjw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHErZFhpeGtKVStlMVY5OThyK3lDS1NoejlKcUtOT21nMmpBaHIraGl5OHZU?=
 =?utf-8?B?TUxIQnlVYWJJQ1NJcTc1TWF3M3V6L3ZjaUMreDk3S25tTForM1RQUG1aRFdw?=
 =?utf-8?B?OVE1N2FJZnNGTlFmcU5NbWFZV3kybTN3bmFYcXlaRWNDRysxTmR5VlgzV2Zx?=
 =?utf-8?B?VTdrL3FNdENWZnlocXI0UEgvenFBRkRWVGd2S25vVDVOOW5xQWZmNWR3NGRu?=
 =?utf-8?B?aDNiSjEveWNtUU9JeExGS05BcFVmZWRCRkZlbjRoMkdTTWs1NFBEbHZqcG1H?=
 =?utf-8?B?WWp2NGxXM3EvSCtqQkYzVHhyRlI2TjA1UW5LcW5BRy82UlY5T0F6TWdVdkp5?=
 =?utf-8?B?d0poS0FVb3UxVUUrRGpYcTkrY0p6ZGM2RkRUbU51aHlJUUhhOGdMc3lOVjlJ?=
 =?utf-8?B?OEhpQ0V2T05qaFg5dCsyVGJiSVNFZTJ0VzR1YVYvbnpxQ0ZCb1JFUHRoV3FI?=
 =?utf-8?B?Tnp1R0gzZ0w1Y1lJMDJZcGNDb0M2QWRqWGhWdG1VTU1TQkM1TG5QUUpydFpQ?=
 =?utf-8?B?eW5KMEN1OHAwdTlVYUc0cDhqL3B4aGhFUnU2ckxTK0hES01UZHNkRzUzNlNl?=
 =?utf-8?B?enI2SmVFS200RnhIOCtSWXpML1gwNHBaK3N1SHFXSE1xUStyZ1FvcWxNZXJm?=
 =?utf-8?B?b1JRdWxFY0hBUXQ0UWhUTGxqK0I5U0pnQU03VkVhQjRDbTdUSjA4UUJCS1FI?=
 =?utf-8?B?dGVRcVZqUlRQMHc0Z2lDbnI5SW5ML01Td3MvVVZzZENRMFBNK1p5bk0rdzdL?=
 =?utf-8?B?bWJULzEwNHBFcmIzaVJMRWMyemE3N0RRaXJrUmIySUlDR0ZJNFVEeUFCRWV5?=
 =?utf-8?B?RkMvSUY3T25IS3FqclpnTE1SVkpDRjJ4K0NOY2c2NGkwbWk1dVhCMVJ4dGtG?=
 =?utf-8?B?UWFTS3hzQzV0NHJxYTh5ajI5eU9vT1ZsVXdIckVtaElKaWxmbjRsTUdrWDhL?=
 =?utf-8?B?dUttU2RXWGhuWkZNdExPbm5iSEtUejJ2bjdUblRKRXZFL1grNVBpMDdXVVJv?=
 =?utf-8?B?VjAvMCtCK3hnVE5tWVNiY2FJZG5qSndnSGpmNjhDdmFrVEtXSWtwSk1hKy8v?=
 =?utf-8?B?QnNOcHV2d2JCanRVWnRLcTUzWG5KM0d0SUsyQkZIZmoxRktaQktJTE0wbzk2?=
 =?utf-8?B?SHNvNVYvRVRiRUMwWkVvZ1d4UUZyblRndTRnNHYxQVpRUWNKSENOblJiaGpV?=
 =?utf-8?B?WUFFS29pMk1xZk5vejQ2YllDcUt4S2syVkJ2RFZQS05BRVNISkRySnNtaW85?=
 =?utf-8?B?YjNvbG1ySElRM2owYncrSGhyNDZzdE1wcGI4UnlmZTd2ZVBYcm9YbXdKQkoz?=
 =?utf-8?B?TWhlRlNBT0E4bFRreFhPNEdzWU02ZVhRODYxT0FXWk9XV056amNFSFZzZWpk?=
 =?utf-8?B?WTYxRk13V2dZUXNTYzFhSE1saVI0UENNd1NvNllsYzJWdlIrV0dva1ZyWUtS?=
 =?utf-8?B?b3RocTNQa2E5eDNsU25uNnI4U1NaUzFLdDRpS21PZWNkVTR2WGhGdktPYVBv?=
 =?utf-8?B?dkZoWFpnQmdTWVVTQTcwU2ZNSzBiR21rWkllMnlvZHVkYnBBYVBXUFFrR2Zi?=
 =?utf-8?B?YTRzMlR0NGdGaVppWHo1aGF6ZFNqR09paHF3d1AzUllnRWhPeGxqeWsycUdj?=
 =?utf-8?B?aVBTRThQUXNwRGZ6U1FrV2VRZ09GTDdhZHVscHdIUnJWYS9CcW1vUXhIaHJh?=
 =?utf-8?B?UTdaKzg4NUlEK29EOVlNQ3A2bzJ6WGhHQmUrN1VJUW5CZzUyOTN1SGk4c2Na?=
 =?utf-8?B?RjNWcjRXUHJKZ05oZmNJYklwTWo3dVd3R2IwdXMrRHRMeFE0N3VXSnd3ZHNW?=
 =?utf-8?B?TFBXakJlNGRFTDZic2VpN2FIeWQ5S1gzMVlkK0NjNS8zVXgyK2xoNFVYU3Fh?=
 =?utf-8?B?MTg0MFBDTlFQUmlTTFkrNHpHdWFNWlU1K1J3YzBFaUlYWnc2RjQwQ1pmZDc3?=
 =?utf-8?B?ZFlSa0VZNWdGSHNPSlFMN0k4YldHVDI1elJEUEpuWnNEQTkvbnh4QzdBSVJ4?=
 =?utf-8?B?aGZzdkdORjByYjc1TkRHVDN3OEpFMExCOEhUYVEvTFFvZVkrdWJRRFRnWHEv?=
 =?utf-8?B?RmhHUmpCQnV6RlhQUm0ycXkyajJOK2RSYnZYTUo4UFhRR01Vc05XQjc5SWs3?=
 =?utf-8?Q?Bnp/Skj4kgm7jVzBjDjq7nGsV?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e98fa8-a72d-4dbd-5f2e-08dc315bf9be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:03:48.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCLN4Oz3WdxFj2PPbbGGWSoE6sXh2AgMHzSuYwixHqvaJp7HY5nBAZx8yKbrou76sonunYCXGwmvxcoSLB44GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

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
index bd73ce06acba..cd12720638c7 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -37,8 +37,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
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
index 000000000000..bd9a5caf20da
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
+	pinctrl-0 = <&pcie0_default_pins>;
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


