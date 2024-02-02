Return-Path: <linux-kernel+bounces-50113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CEE847469
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B44F1F2F2B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E703A14C5B8;
	Fri,  2 Feb 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Jrpx11WF"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2130.outbound.protection.outlook.com [40.107.8.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3A14AD3F;
	Fri,  2 Feb 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890270; cv=fail; b=JLrJ0affIn1zj2HRWdvt355up0Mmu/KGxP7BGzF0vs4G+VlzpF2JS46foVBmlbfijgu1yljQJfBYwnGFGKNp7LgAbAuYwm7mnncqcdywNHCW1xKguihWaNddzZ2w+TLGwAtNBiRbDiTe0NvZtYZXIW+JFJGuc4I4CF8nmoUTcTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890270; c=relaxed/simple;
	bh=92ZVXW4YC6ZPcqYAGAxQaXNVAjywr2YsXrwp1M2QIBQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vAxfhzqBjMuyWRNk3tll/2uqd+/UJNHeGg7f0HcqEIerLsekWMsyrWnymIKhaFCbKT4LlFAJbTvJ0LVAnA7vay8SLJc/8/+trrHWU6YWdJ0VqMCrYFtYWPZlciJl9pjWru8VR9/AHebo7nEjUljHFKWnfT7FmexXwkWFmc73tGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Jrpx11WF; arc=fail smtp.client-ip=40.107.8.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKF1VSqvi8G5twofW7APBssLJ29Vzhzl8CfDJWcAvfWZc+LckQzbKfADu6pkvGmoJOE7/IK/X0YJTSeB0el9m/YjGXg4dOzXvQL4o2/CEyoH5gqUX5FnFLjnLRpxfP0XYDi/+oq4CT96Yv6GTV1dsa66kj7xotk0eikrBc2R4m5mBOpOC8PhwwRa/AcYxNlaj5QCT3JEe+FSX/vi3Qb9nzh0X1yG60Mz0N5ckrrPx9/ecDT+ohd7xE4MRIsHphF2Q5Byc3avlDCnjKmv6zHsnmXs9OBJGeXi7YOPMgS362nOhWjP9SIfKdsRvOeoVoAacgHElOMxak5eVSNcS16bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAVYcajPH+cQj7PkDwcqf/iS4zG1WdQUnJL/lsNg9N0=;
 b=WDad9aCTNf3WP3n+i+ZQIqssbHoXSKx/BdzSYbvybSTL2RONgo14018BM7KMsGgXFMnF3xNGlf1qBHfuiZfSEm/kE53sI1gEPWTH6oWI4XkBnf2q5JkkRMqXTbDKMTg5Lz19J8++BjpK4EK8gS7aFtEERO6dlvOel+Amu2ayZwEdjMJ6mZtMRUUQnnKbLeG2cp1FaeU+3QF02p8nekVkHNGjXLrUhGMqq37YFJEGjKXmYgj5sJjcWHS/vvGe0EX4B3vQpLi7sPaIpQQeZVYppIAZqYi5YKIXszLzufR3CA5vKOjzLhQVoszUx6ErvbrdFhrqW/COWKM/pJmI2aI2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAVYcajPH+cQj7PkDwcqf/iS4zG1WdQUnJL/lsNg9N0=;
 b=Jrpx11WFCDsliTdepS9ybz8TstXCjDLEtiX2BdND4PBuyXwYRRwmqW+wETrTLInyxU9UOeowshLs6alGsFuuEfWZX1+LX0xaEGEDs3Jr4Tot/uzBz3HprrDI/sT01UuOOdvzyu8W+4H64eTmiaC6C+JyKzd/tdY/J9qL0BT1lGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 16:10:54 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:10:54 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 17:10:52 +0100
Subject: [PATCH v4 5/5] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v4-5-5f8b12af5e71@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
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
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f7158d-3db4-4b7d-3eab-08dc24098855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dTclFWHIjCC2vb7RB/kcKE5rJT+YoODHCW/Wgv3BlLbdNH1mcpBgGuwRNI5cNcOpCCTLnnetnRJfgI3tiam4X/YfdlRpY3GTAReUiTCjix7zEeptod5FhbEYx3slfoYFJ0vs/YLe5NA7J+oJkKdaGQKodRE29cN4gtZMk+YsNt9BCarMgMJSzeDHE579lDC7d3H+dLmo6OXpx6vx+vAvMVOvClu/NHcTGRx4Zo7/YFHjl5mmJD59OWjUTuwcJWDGmwILcMLahY2GipKT6K/JOrbAlKM03B9N9DzCN9//fcjuVW/i8a/F20pVWWS00fy3yp824Z7BPCGHY66B4d+Q4MKtxGM+epE5jYQt2Vna1Ub3XzLFySC+eIG3ZUCQwUiInmqyHq77AQw7ICgijd9IzmkbIOHu1uKyPyHEWNNrZ0hYfOeiMCyR7ADsWQYXR9ZmIDtRrY1JgT1ekCYPK/wFJzFMjMKLJkKnp0NjjqXn9sfN8iJo1j8pIgSpm3mdn4cui6fvmEozZMIACz+8kxpujss3eISIgsaQU34K+yto+NiceItgY5n5uC0tSReKX053Rcp0raEIZwDQlI4zEKWIBRbogaE8agePqsXR2wF/3yI4htncxKAr8Npy6JXSSgBH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39840400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(7416002)(478600001)(6512007)(6486002)(6506007)(83380400001)(52116002)(86362001)(8676002)(4326008)(8936002)(66476007)(54906003)(66946007)(66556008)(110136005)(316002)(36756003)(38100700002)(41300700001)(26005)(107886003)(2616005)(38350700005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHgvVlN6UXJVYlRhSkRjMkI1Q2NNVlAvSFFIYkVHUVNRVzRzODJLQ3pUby9p?=
 =?utf-8?B?UHRDeXJidU5KSFJzKzVZRkROMDF1RnF0UDBiQXJORHB0ZXBldUJxUWhabXZQ?=
 =?utf-8?B?UjZwTFpPSDBZL2FWRlVHRnhGYVBIR1hYVnpkR3pqMDhvKzUvSkpXbCthUW1B?=
 =?utf-8?B?TTh0SnY3cjhNNWY1UStGSjhFM21DNGsyc2JmQnJ3S243VnJDeWtySm8vbHJl?=
 =?utf-8?B?M0ZkRmVzUFB4TFZ5SDhnYTVHb3hRZmJFS3MyQ0Q1d0ZwMWJJQkVkYWI5c0R5?=
 =?utf-8?B?cWFNdERob0hxMy9wNTcvMTVaOFJtY2p0VnNKMnJ6S3NtUjQxMWJqa2VSdEpN?=
 =?utf-8?B?SkJxakNRblV3emFCRkhRR2lvRWxZbnNDcHY5V3hwRk5LNlNidlZTV1VRNGpH?=
 =?utf-8?B?T2VjS1J2Y3Z0TFRraWtNenhBbDcyUVNRQ2YxQjc4cGE5dWZYU2VXMFZ5NzBC?=
 =?utf-8?B?Uk9XMDI1K0g1UFVTWXUydzhMSzRKRHJiNWJnSWF3ZWpzOUNwWE55bG5QdE9v?=
 =?utf-8?B?TTV5clpNRG9DSmNiM3ArU0UwUnBuYjl3NU5KUXJiVms5KzY1K0p4bmNDb1NG?=
 =?utf-8?B?ZVRnWk5KOVhUUWdwRUN2enBqRTRoYU44OEtNTy9oNWNXSTNTY1VEaklONjNK?=
 =?utf-8?B?azMzQ2kvVkpYRjZjYTFyalZWRVdrUlhvNXpjZTZvM3pPaC9raE9KbXFWWkli?=
 =?utf-8?B?RE1yeEpTMlpNMXFkZU8vYTB5RlE3V04reGlCN3JhMXR1dkpLQ2hvSGp5ajBx?=
 =?utf-8?B?NGVKaXJ4OUE3dmVjMmRBdGMvMHhSSTBHLzduK0VabElIalM3L3laMVFscHp4?=
 =?utf-8?B?NVAwU1FBU2UwRkJoTHBsVGc1RkF3SGpPM201SXRnaXUraEZrS0M5MEJFdlVO?=
 =?utf-8?B?cmtnbEtFb2lDeHB3Wm1qZGp5aGZWWDRPZU5JOTJpSitaL0NJam1PaHdMQzVn?=
 =?utf-8?B?dGhTK2VqVUlMVDU2QTZqQjN3bEdOVmdHcmJndG9NRFdQdDhLYW9XcU0weEtj?=
 =?utf-8?B?U291dUFvSEJINktwaE95dFQ0d1pnU3R2YmhkK2hKemJ6aXB3SlhONjJLTG9Y?=
 =?utf-8?B?c0ZmT21Bbm56SmtqUVh2NC90aFhMU0V2Tk5kQi8ydjQ5ckxyS3lkT3NVYUdp?=
 =?utf-8?B?QUZsS2xralpLblBNWHR1OFNlUy9WdDJNRVhNK0o3eFhjaXBoUHFjb2xwYUZE?=
 =?utf-8?B?ejN2U3ZYU2tVamRqWXoxWkY5T2w1enNkS3hib3dkZnh3M0pnOFEwb2RXOStK?=
 =?utf-8?B?M3FoZVIzcUpzYjMxdGJBYWFZcFVaQVl0NG0rNkM0STZTajJlZDd2OHdkbHFh?=
 =?utf-8?B?UTdyT3B3VzlMZXlFTUN6cWlsWElpc1ZkVXc5QmRMRkFScGtiMVM2eTRDcTAx?=
 =?utf-8?B?WnF5ZHFNVmpqc1BsOEJxU3J4ZkkrKzR1SjdNaHpSSWpiaEljVnRheG5MOFJa?=
 =?utf-8?B?dVR1Ym0wNytFVDlIYllaRGNlLytZMk84QUpHTnVJNlFXcGFKQUFaRi9tdjJK?=
 =?utf-8?B?eVQyWEVNVHJ6cXNGZDdxUDhsa2pMMHMwcFhjVlloc3BaN3lDdkg3ZFF4Wmth?=
 =?utf-8?B?SVpHS29ObzZ0WWN1Ri9pVDRnck5TWDNTMzdOSlVlWmJhRXJLOWJzem41bElL?=
 =?utf-8?B?bW9nZk9oOXdQM3ZPVkowdVp1Z2JaU2g4QnZsZ1Z2eHlRaXpRTi9iMTdNSTBG?=
 =?utf-8?B?VUZ1VlYvY3FIbFlST1lobldVWTcrenlqYkpNQlUrOHZMRE53alNDcHVXNWp6?=
 =?utf-8?B?Wjlvekp2eEVvMm5FQWVadHQ0aVpvbnNLckRhTmFQWmw5TWQzcnhVWjdRNmJp?=
 =?utf-8?B?eXZYZzdkSTJGd3hQeUhPbWJVMzl6bHZXZHNjSlM4ZmpUS2kyUnl5cmZhaUlo?=
 =?utf-8?B?a2NnZEFiMmNYMG8vdWZ5Q0FTSVA5YXV2TjJ4R2NpVDg1elBkQ3lFdC8zSUZU?=
 =?utf-8?B?MnNaeXk2YWZ4TmcxdDNTMEc3ZEVYYXBOSTJUWE5TT29jMFo5WE1iNzlvNEd6?=
 =?utf-8?B?RXZyQU1jUHRGT2xFaW9oaXJsbmtLRlJ2Z2ZZQys4MlhxTFI3VlJ5MjVVc2kr?=
 =?utf-8?B?TmZ4ZnJGWVNFWWltV1FyQlVZaE1BRU5pLzZ1c1l4eTlMdVl5NlFKU3BSR3A4?=
 =?utf-8?Q?29Epfczk9yFyoyoLR4Xl6q6hh?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f7158d-3db4-4b7d-3eab-08dc24098855
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:10:54.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbnOy1xpE+A8FJDXIQp8QkNsg3PktqcXa629ZxMrlaRwKLO0gCR1bWI9WiVe24NnXiXGXu6SbpUBrvC2SQnRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

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


