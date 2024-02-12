Return-Path: <linux-kernel+bounces-62120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AFD851BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4ED328AF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333D3F9C6;
	Mon, 12 Feb 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qVH2jWhq"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B84597C;
	Mon, 12 Feb 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759515; cv=fail; b=Ho21rsuWgUgk7a0KpQaOBcFqqlFpXMu1FbF6NTtqWxveIbax5L+Omga0wpe9AChEatuyhFEktd+FpLsefVFqSxwxlPvbD74iLbHqlYAgMAyh0Bq41X+HfPhrOM1MAqwvSNPv6MjqIbGEApxecZr4313Py2JI9Ax01zZf3ZH3trM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759515; c=relaxed/simple;
	bh=qjX84Ld33bqw7IjO5K31ZS6hmGnQPJ9ZeIzTlrTMabY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nAyh0g1yCFvKrZEU0/GPv7QpXPbL2C+jXP8PwB2EaVHtrDH30eOdEy8VEYIe91EdRMZind/Fvx7s8OC1/zWGk09X2T863xUib67SCrfqQrR7v4YIqr/3Jk8HQjopqtRF/4lX8lnHafPauiSLk1CnMmDQiRlOJkFBXS/QFu/3Zqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qVH2jWhq; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZXCIXPD7ZbIrZiYXoqSlbZIz39hBYpeWq8caOzmjk2SoEpZ6IeczX/5e83yNcA8leUcNq1fpsrMQpmUskVQSg7wb4QVeNYM19FYDRb3IFpBcm7q4+GREIEZLQOw7UQhna5d5EIZ2deUPd8WwUe0QauCL/95IQ+L4RC2jfmsrhKHsqX18g8HZqPz8b6YXXtpi8NT6akxa32UKlL4Ozc/X96qJgflTDqaoEzpX/mo8yH+jSZsrlnogX+8tWDgFlSg1djPmWgPjt4aZ4gVhK7ewxe6HeiTnDx4WyKPrVVCw2d3m6obwKnZL0dSGOcGOU3/rBY8JBHZdD6hK3DWU1abJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqV3jsVhpUcT1f5kpUjJ7BvVT6gZfARPAtp9a2c4V6A=;
 b=ckazdolJlo72729rAWMTMVFDx88UZrF81amWTv4BcuBnbBzQT0hMzmhus8UX67qbyozwMaYnHA4W5NYdttqVzNthJxLOIKpwkshPJ2+S7Yk8ZEhBrJ420Ox0KZJ5wlXkRjnWxGXoGHK8a+ddGJ9oe7HbSTTA8E+oIvF6E8oUt0UwjicHKt9gOCHTkMnSaQ3zNxguThbCvH74xPO+qPaTEIdOCrh1v+uCnzTf2itMmka5QShHBjOMabY5RINmyAOUtExtvRbQkwSNCf3E8aDaUN8CRqS+4O8LDQUoaay4wysHVIvDXHhbNqdpwlDqKW4soRLeDIqzICc2maG/6Niyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqV3jsVhpUcT1f5kpUjJ7BvVT6gZfARPAtp9a2c4V6A=;
 b=qVH2jWhqIUIriMNxkvSEO8l1xqt5AuXG43R4G4/OD9+IiKPw+BjXfpnKHhco3Uy7JMhrpFln2bQk4z99lnFunBVHPjtMCBqpOWlLjzsEPDaHSKFbUr+QW4OpNZqmGDAwrBfQjc3V41a7HLrlfNygC13biFSAj0jUdqKd/cJHhWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:21 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:21 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 12 Feb 2024 18:38:13 +0100
Subject: [PATCH v6 6/7] arm64: dts: add description for solidrun am642 som
 and evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-add-am64-som-v6-6-b59edb2bc8c3@solid-run.com>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
In-Reply-To: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Eugene Zaikonnikov <ez@norophonic.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 linux-mtd@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de04dfc-69a5-46b2-21a1-08dc2bf1682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KukAfgStOx19KLQ2mTlGrS+jWNu3vlV27fVHwLINqG8FOOvs+2DVadA/uoIVJkdXw5Ss7fiCPVvi5tPvCYfxnjTJ4DkzLOEz9/fORZFVnQRm1oc7VZvg9y9cQBQGEku2FGVnYk8uU7PuYLLBvaQ1odipTDB4GJn+tOCTyfXoCQtVlHQRxzjwMOwXyQeJEef55QPIyEGhpW8R0XR3vdOzJ5t2SPpmb4I4RAUsgVeahzVQrjicdvAhMj0pW+PG9yZERybM+egjh8msM7p++S7+zRsKzUYXvSxDJe8pfMB88KctbebUky4tjodp18JpxOc3W9cm7paXPjMW+MrmCqaO/tT4APgpW8olBuZJXtc08cTaOHtjwnORieMi2pVagmb/e29SQyY8KwfsjRFyiGSe9yVbO2Y8dGCfjU8FPcU8p9LjJEaqpquIXQwN7z1ol3SDyVKm/OImo0OLP7rPzl1b1/GJjvmP48H5RWQUel37h4oLR9HusE4TMj8LPwJRoWso3xHlP2ACX3zRKpxW6NEXuy3Qv7fWk1kJcgd5wcnfNPQFttFRUakM7Up779reDtA5Y9Iec4lqCjdXSkIeumaOxhrNshPf4m6kwROO9bl/cI0OzEJkaxlrmDPmSiBXKpW1lpwe3Xnx+f3nbM1FrbjXzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(30864003)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(107886003)(38100700002)(86362001)(19627235002)(83380400001)(110136005)(54906003)(52116002)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME1heXBjTGRUbEdMajJSZGs1bjV0aThkbDBmaldNU2J4ZS96bndMMm1QNmZ4?=
 =?utf-8?B?Rlc4enNHRDlCV0I1dWpMVW55UU1DaklYQWdMM3VVaHR3V1JzN0hxRFppejY3?=
 =?utf-8?B?azhWVHlVZjhDVDg4NXFIVlh6UkFFWVk1Wm5tQWJYbjZnd3ljaW5kQ25RRHZK?=
 =?utf-8?B?QVM4UjNPMHk4cVBuS00wU25mMW1zb01EVGJEdFdpQnp0K0pRbUVVK1NYc2lI?=
 =?utf-8?B?bXY4Tnp4SFl4NTVLdzYxWlpiSlNac25KZW8veUdLMXcxRmxkaE1nZ2ZIcVlZ?=
 =?utf-8?B?aGhmTERTNDBsR0VNSHg5UUYyeUlPL1ltSUc1UHJQalJsMnptUWQ2SkNiNFlG?=
 =?utf-8?B?dzQwYXNHbEgrNE9IYXUxR0lzOVZYOGlTdDl6aStaeU5kd01BYUVHbHNEL0Qw?=
 =?utf-8?B?cC8yY0xFNkR0WTlvTituWjh2ZEhaaTV3ZDdNd0hYT2NqdVlXNzZLQUYrTVoy?=
 =?utf-8?B?OThRZndzaFNTK3lZWTd0VDhISllMY1FCdXhBYTVWSEF4cEZOUXBoQ1F5bnhM?=
 =?utf-8?B?a0IrUStYcGxLclBlVS83OVRZbzZhSFZWZWVXeHNHSjVHSlRXMHVhVm1GZFRY?=
 =?utf-8?B?QW5RRE16YjI1eTNiL3RHMTN3THNnNjhBWlhpQlVMbWlaYTJSUnZrYWROeTRI?=
 =?utf-8?B?VzlDME5YdzhFVGZMUlRBR2lPSklpeUVMSCtMVC9RZ2krRTBkUTdGZzU3T2hs?=
 =?utf-8?B?cDRnTHZPcllqZCt1Nm9HUG1ZUXVGNnRNcUVwOHp1QlZpcXdTYUNYQzNpcDRs?=
 =?utf-8?B?b3E0RWdhZEdYeVVDMzc1elhMZ1VsY0JaSUpFbCtpRWlKbThUTFN3UzF2a0lu?=
 =?utf-8?B?amQxaXZRbjRqRXZmWlR0amhxVXNuZEszb095ZERndzc2VTlWSkN2WFIrTFVy?=
 =?utf-8?B?RnVzMUZkSUQ3UzNVby9KcWc1SVBSOVBwbVcwRTJCbDBON2ZXS2Z3ajhVd0o5?=
 =?utf-8?B?VHZ0dkJoU04yY1VqdWk4TitRdG5DcHFaa3VSM1F2anc2MHlIYVF6Sm5RZXZT?=
 =?utf-8?B?QWlHZ0c5Q21IV05oTXBZT3Y3a3dXdmx0bVN5MWx3YnB1SVRSQU5RWGwxM3Nh?=
 =?utf-8?B?aGtlN3Q3OGRZMXUrTWR4a2JCcGQrdzcrM0RjRmh6QnVMSWFNSnVTdEl4eWNW?=
 =?utf-8?B?L0NpU0Z6ZzhmTmNkdTZCTUJ2WEFhN0xScU05S0tzTFU1dXIrY25aR2lYWEFm?=
 =?utf-8?B?Smc3RG9qOEwzdWNFQ0pwejNxeHZZRGRqMFhKWHJwV3RuT2dDMDhEeEtJeGx5?=
 =?utf-8?B?Ums5VVYwMzhJaHY1bU5vb3RtOE42Nit3d1ZUUjkzOUtqdHVYSEpKcmhmRjNN?=
 =?utf-8?B?bHpwLzgxL01YNzk1VEJaVm1BMUI1U1lyY0xGR1Fqb2RiRjRDM0hXWVZGMWFn?=
 =?utf-8?B?TkpxbFdHVDN3d2swSDNRQXEzS0h2NzIyRTlXZlpocG1ERnR6ZmRzeXgraGVW?=
 =?utf-8?B?YjhNaWUrWGRzeERzWXZiL3ZQVlAzRzhtdU5rM1lPcUxSL3pzZlMvYUdLN3FS?=
 =?utf-8?B?VDY3aFRpVzMvakpWUDBOTXJsSFdzVGo1Ym8yNlVBUVVwVklSdTA4RG9JQzRX?=
 =?utf-8?B?cE50aGZFaGFwZHFzdFVHK0hnenFqMEkxWDNNWFVhMjkwTmxOeU0xVHRxclNB?=
 =?utf-8?B?ZTZFMU1xN0FJT0xaT0lzWmZMcWpEVndiWUEwemV3NVJRWVRTR25QaU16SzNF?=
 =?utf-8?B?VG5nU1NQalJIekRKSE9Oc3pNYkE4TFFGZlNWc2lqd3hFVkFiZnNKWmlLWmdU?=
 =?utf-8?B?aHpQN0NOOU1VTUpQQmd2bEgyYlhFWm85RDZSaTdyK2ZKN3d6ZmFUc0kvRFAx?=
 =?utf-8?B?blhRVERKZDZha1IrZzY0SGVCcjFkWG9LS3hXMmw2MFVWakRzSXdTVnFSK1BS?=
 =?utf-8?B?Nk94MEhmM05va1RGYnJlQ0wrRkpZTWhZaWxhbXoyYy9xbVp1c3hZb0FYbCtB?=
 =?utf-8?B?NTJlOTFyUDRLK3BCTlJ2QjlHelkrczh5RDUvSUZnNFNLaXR2cS85QmxGelQ4?=
 =?utf-8?B?cmUxa0lDb0dLOTBUY3hSQXJPTDUxU0VqTFVWSDcxZm5vdXh4OTM0YldOTEdz?=
 =?utf-8?B?Q0U1Z0p0MlJTdzdpVnQ4VXNVdzVrcnVwNGptVmgxaCtlMk1XTXRoNllFS1pN?=
 =?utf-8?Q?kKoWkbLIgVnoQbJ5jSQ6ebaB4?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de04dfc-69a5-46b2-21a1-08dc2bf1682a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:21.5286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqchd+859zZLJ8GBZorfahttVH0tDM2n5m0v9S37yik84mZF6kTg4BJmtn2t7rN0yPPLadNhJb4gaMpIT3v4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Add description for the SolidRun AM642 SoM, and HummingBoard-T
evaluation board.

The SoM features:
- 1x cpsw ethernet with phy
- 2x pru ethernet with phy
- eMMC
- spi flash (assembly option)

Additionally microSD and usb-2.0 otg are included in the SoM
description as they are supported boot sources for the SOC boot-rom.

The Carrier provides:
- 3x RJ45 connector
- 2x M.2 connector
- USB-2.0 Hub
- USB-A Connector
- LEDs
- 2x CAN transceiver
- 1x RS485 transceiver
- sensors

The M.2 connectors support either USB-3.1 or PCI-E depending on status
of a mux. By default the mux is switched off.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |   1 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
 3 files changed, 887 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..bd73ce06acba 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
new file mode 100644
index 000000000000..234d76e4e944
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-am642.dtsi"
+#include "k3-am642-sr-som.dtsi"
+
+/ {
+	model = "SolidRun AM642 HummingBoard-T";
+	compatible = "solidrun,am642-hummingboard-t", "solidrun,am642-sr-som", "ti,am642";
+
+	aliases {
+		serial5 = &main_uart3;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_default_pins>;
+
+		/* D24 */
+		led1: led-1 {
+			label = "led1";
+			gpios = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		/* D25 */
+		led2: led-2 {
+			label = "led2";
+			gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		/* D26 */
+		led3: led-3 {
+			label = "led3";
+			gpios = <&main_gpio0 33 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+	};
+
+	regulator-m2-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&regulator_pcie_3v3_default_pins>;
+		regulator-name = "m2-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&main_gpio1 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	regulator-vpp-1v8 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&regulator_vpp_1v8_default_pins>;
+		regulator-name = "vpp-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&main_gpio1 78 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	serdes_mux: mux-controller {
+		compatible = "gpio-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&serdes_mux_default_pins>;
+		#mux-control-cells = <0>;
+		/*
+		 * Mux has 2 IOs:
+		 * - select: 0 = USB-3 (M2); 1 = PCIE (M1)
+		 * - shutdown: 0 = active; 1 = disabled (high impedance)
+		 */
+		mux-gpios = <&main_gpio1 40 GPIO_ACTIVE_HIGH>, <&main_gpio1 41 GPIO_ACTIVE_HIGH>;
+		/* default disabled */
+		idle-state = <2>;
+	};
+};
+
+&main_gpio0 {
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m2-reset";
+	};
+
+	m1-m2-w-disable1-hog {
+		gpio-hog;
+		gpios = <32 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m1-m2-pcie-w-disable1";
+	};
+
+	m1-m2-w-disable2-hog {
+		gpio-hog;
+		gpios = <34 GPIO_ACTIVE_LOW>;
+		output-low; /* deasserted */
+		line-name = "m1-m2-pcie-w-disable2";
+	};
+};
+
+&main_gpio1 {
+	m1-pcie-clkreq0-hog {
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "m1-pcie-clkreq0";
+	};
+
+	m2-pcie-clkreq-hog {
+		gpio-hog;
+		gpios = <35 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "m2-pcie-clkreq";
+	};
+};
+
+&main_i2c0 {
+	pinctrl-0 = <&main_i2c0_default_pins>, <&main_i2c0_int_default_pins>;
+
+	humidity-sensor@41 {
+		compatible = "ti,hdc2010";
+		reg = <0x41>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	light-sensor@44 {
+		compatible = "ti,opt3001";
+		reg = <0x44>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	/* charger@6a */
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_default_pins>;
+	status = "okay";
+
+	rtc@69 {
+		compatible = "abracon,abx80x";
+		reg = <0x69>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_int_default_pins>;
+		abracon,tc-diode = "schottky";
+		abracon,tc-resistor = <3>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_default_pins>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <8000000>;
+	};
+};
+
+&main_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan1_default_pins>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <8000000>;
+	};
+};
+
+&main_pmx0 {
+	leds_default_pins: leds-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0074, PIN_OUTPUT, 7) /* GPMC0_AD14.GPIO0_29 */
+			AM64X_IOPAD(0x0078, PIN_OUTPUT, 7) /* GPMC0_AD15.GPIO0_30 */
+			AM64X_IOPAD(0x0088, PIN_OUTPUT, 7) /* GPMC0_OEn_REn.GPIO0_33 */
+		>;
+	};
+
+	main_i2c0_int_default_pins: main-i2c0-int-default-pins {
+		pinctrl-single,pins = <
+			/* external pull-up on Carrier */
+			AM64X_IOPAD(0x0098, PIN_INPUT, 7) /* GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+
+	main_i2c1_default_pins: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x0268, PIN_INPUT, 0) /* I2C1_SCL.I2C1_SCL */
+			AM64X_IOPAD(0x026c, PIN_INPUT, 0) /* I2C1_SDA.I2C1_SDA */
+		>;
+	};
+
+	main_mcan0_default_pins: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0254, PIN_INPUT, 0) /* MCAN0_RX.MCAN0_RX */
+			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0) /* MCAN0_TX.MCAN0_TX */
+		>;
+	};
+
+	main_mcan1_default_pins: main-mcan1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x025c, PIN_INPUT, 0) /* MCAN1_RX.MCAN1_RX */
+			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* MCAN1_TX.MCAN1_TX */
+		>;
+	};
+
+	main_uart3_default_pins: main-uart3-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x016c, PIN_INPUT, 10) /* PRG0_PRU0_GPO3.UART3_CTSn */
+			AM64X_IOPAD(0x0170, PIN_OUTPUT, 10) /* PRG0_PRU0_GPO4.UART3_TXD */
+			AM64X_IOPAD(0x0174, PIN_OUTPUT, 10) /* PRG0_PRU0_GPO5.UART3_RTSn */
+			AM64X_IOPAD(0x01ac, PIN_INPUT, 10) /* PRG0_PRU0_GPO19.UART3_RXD */
+		>;
+	};
+
+	pcie0_default_pins: pcie0-default-pins {
+		pinctrl-single,pins = <
+			/* connector M2 RESET */
+			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7) /* OSPI0_CSn1.GPIO0_12 */
+			/* connectors M1 & M2 W_DISABLE1 */
+			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7) /* GPMC0_ADVN_ALE.GPIO0_32 */
+			/* connectors M1 & M2 W_DISABLE2 */
+			AM64X_IOPAD(0x008c, PIN_OUTPUT, 7) /* GPMC0_WEN.GPIO0_34 */
+			/* connectors M1 & M2 PERST0 (PCI Reset) */
+			AM64X_IOPAD(0x019c, PIN_OUTPUT, 7) /* PRG0_PRU0_GPO15.GPIO1_15 */
+			/* connector M1 CLKREQ0 */
+			AM64X_IOPAD(0x018c, PIN_INPUT, 7) /* PRG0_PRU0_GPO11.GPIO1_11 */
+			/* connector M2 CLKREQ0 */
+			AM64X_IOPAD(0x01ec, PIN_INPUT, 7) /* PRG0_PRU1_GPO15.GPIO1_35 */
+		>;
+	};
+
+	regulator_pcie_3v3_default_pins: regulator-pcie-3v3-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01a4, PIN_OUTPUT, 7) /* PRG0_PRU0_GPO17.GPIO1_17 */
+		>;
+	};
+
+	regulator_vpp_1v8_default_pins: regulator-vpp-1v8-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x029c, PIN_OUTPUT, 7) /* MMC1_SDWP.GPIO1_78 */
+		>;
+	};
+
+	rtc_int_default_pins: rtc-int-default-pins {
+		pinctrl-single,pins = <
+			/* external pull-up on Carrier */
+			AM64X_IOPAD(0x00b4, PIN_INPUT, 7) /* GPMC0_CSn3.GPIO0_44 */
+		>;
+	};
+
+	serdes_mux_default_pins: serdes-mux-default-pins {
+		pinctrl-single,pins = <
+			/* SEL, 10k pull-down on carrier, 2.2k pullup on SoM */
+			AM64X_IOPAD(0x0200, PIN_OUTPUT, 7) /* PRG0_MDIO0_MDIO.GPIO1_40 */
+			/* EN */
+			AM64X_IOPAD(0x0204, PIN_OUTPUT, 7) /* PRG0_MDIO0_MDC.GPIO1_41 */
+		>;
+	};
+};
+
+&main_uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart3_default_pins>;
+	uart-has-rtscts;
+	rs485-rts-active-low;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
new file mode 100644
index 000000000000..c19d0b8bbf0f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/net/ti-dp83869.h>
+
+/ {
+	model = "SolidRun AM642 SoM";
+	compatible = "solidrun,am642-sr-som", "ti,am642";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &icssg1_emac0;
+		ethernet2 = &icssg1_emac1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		serial2 = &main_uart0;
+	};
+
+	chosen {
+		/* SoC default UART console */
+		stdout-path = "serial2:115200n8";
+	};
+
+	/* PRU Ethernet Controller */
+	ethernet {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pru_rgmii1_default_pins>, <&pru_rgmii2_default_pins>;
+
+		sram = <&oc_sram>;
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		/* configure internal pinmux for mii mode */
+		ti,pruss-gp-mux-sel = <2>, <2>, <2>, <2>, <2>, <2>;
+
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
+
+		/*
+		 * Configure icssg interrupt controller to map pru-internal
+		 * interrupts 8/9 via channels 0/1 to host interrupts 0/1.
+		 *
+		 * For details see interrupt controller documentation:
+		 * Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
+		 */
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethernet_phy2>;
+				phy-mode = "rgmii-id";
+			};
+
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethernet_phy1>;
+				phy-mode = "rgmii-id";
+			};
+		};
+	};
+
+	/* DDR16SS0:
+	 * - Bank 1 @ 0x080000000-0x0FFFFFFFF: max. 2GB in 32-bit address space
+	 * - Bank 2 @ 0x880000000-0x9FFFFFFFF: max. 6GB in 64-bit address space
+	 */
+	memory@80000000 {
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000001 0x80000000>;
+		device_type = "memory";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+	};
+
+	vdd_mmc0: regulator-vdd-mmc0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-mmc0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_default_pins>;
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_default_pins>;
+	status = "okay";
+
+	ethernet_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy0_default_pins>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 84 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&icssg1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru1_mdio0_default_pins>;
+	status = "okay";
+
+	ethernet_phy1: ethernet-phy@3 {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy1_default_pins>;
+		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 20 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+	};
+
+	ethernet_phy2: ethernet-phy@f {
+		compatible = "ethernet-phy-id2000.a0f1";
+		reg = <0xf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_phy2_default_pins>;
+		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
+		/*
+		 * Disable interrupts because ISR never clears 0x0040
+		 *
+		 * interrupt-parent = <&main_gpio1>;
+		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
+		 */
+		/*
+		 * Disable HW Reset because clock signal is daisy-chained
+		 *
+		 * reset-gpios = <&main_gpio0 52 GPIO_ACTIVE_LOW>;
+		 * reset-assert-us = <1>;
+		 * reset-deassert-us = <30>;
+		 */
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_default_pins>;
+	status = "okay";
+
+	som_eeprom: eeprom@50 {
+		compatible = "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&main_pmx0 {
+	/* hog global functions */
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_phy_default_pins>;
+
+	ethernet_phy_default_pins: ethernet-phy-default-pins {
+		pinctrl-single,pins = <
+			/* interrupt / power-down, external pull-up on SoM */
+			AM64X_IOPAD(0x0278, PIN_INPUT, 7) /* EXTINTn.GPIO1_70 */
+		>;
+	};
+
+	ethernet_phy0_default_pins: ethernet-phy0-default-pins {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
+			/* reference clock */
+			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
+		>;
+	};
+
+	ethernet_phy1_default_pins: ethernet-phy1-default-pins {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
+			/* led0, external pull-down on SoM */
+			AM64X_IOPAD(0x0128, PIN_INPUT, 7) /* PRG1_PRU1_GPO8.GPIO0_73 */
+			/* led1/rxer */
+			AM64X_IOPAD(0x011c, PIN_INPUT, 7) /* PRG1_PRU1_GPO5.GPIO0_70 */
+		>;
+	};
+
+	ethernet_phy2_default_pins: ethernet-phy2-default-pins {
+		pinctrl-single,pins = <
+			/* reset */
+			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */
+			/* led0, external pull-down on SoM */
+			AM64X_IOPAD(0x00d8, PIN_INPUT, 7) /* PRG1_PRU0_GPO8.GPIO0_53 */
+			/* led1/rxer */
+			AM64X_IOPAD(0x00cc, PIN_INPUT, 7) /* PRG1_PRU0_GPO5.GPIO0_50 */
+		>;
+	};
+
+	main_i2c0_default_pins: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x0260, PIN_INPUT, 0) /* I2C0_SCL.I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT, 0) /* I2C0_SDA.I2C0_SDA */
+		>;
+	};
+
+	/*
+	 * main_mmc0_default_pins: main-mmc0-default-pins
+	 *
+	 * MMC0_CMD: no padconfig
+	 * MMC0_CLK: no padconfig, external pull-up on SoM
+	 * MMC0_DAT0: no padconfig
+	 * MMC0_DAT1: no padconfig
+	 * MMC0_DAT2: no padconfig
+	 * MMC0_DAT3: no padconfig
+	 * MMC0_DAT4: no padconfig
+	 * MMC0_DAT5: no padconfig
+	 * MMC0_DAT6: no padconfig
+	 * MMC0_DAT7: no padconfig
+	 * MMC0_DS: no padconfig, external pull-down on SoM
+	 */
+
+	main_mmc1_default_pins: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0) /* (J19) MMC1_CMD */
+			AM64X_IOPAD(0x028c, PIN_INPUT, 0) /* MMC1_CLK.MMC1_CLK */
+			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0) /* MMC1_DAT0.MMC1_DAT0 */
+			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0) /* MMC1_DAT1.MMC1_DAT1 */
+			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0) /* MMC1_DAT2.MMC1_DAT2 */
+			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0) /* MMC1_DAT3.MMC1_DAT3 */
+			/* external pull-down on SoM & Carrier */
+			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0) /* MMC1_SDCD.MMC1_SDCD */
+			AM64X_IOPAD(0x0290, PIN_INPUT, 0) /* MMC1_CLKLB: clock loopback */
+		>;
+	};
+
+	main_uart0_default_pins: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0230, PIN_INPUT, 0) /* UART0_RXD.UART0_RXD */
+			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0) /* UART0_TXD.UART0_TXD */
+		>;
+	};
+
+	mdio0_default_pins: mdio0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* PRG0_PRU1_GPO19.MDIO0_MDC */
+			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* PRG0_PRU1_GPO18.MDIO0_MDIO */
+		>;
+	};
+
+	ospi0_default_pins: ospi0-default-pins {
+		pinctrl-single,pins = <
+			/* external pull-down on SoM */
+			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* OSPI0_CLK.OSPI0_CLK */
+			AM64X_IOPAD(0x0008, PIN_OUTPUT, 0) /* OSPI0_DQS.OSPI0_DQS */
+			/* external pull-up on SoM */
+			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* OSPI0_CSn0.OSPI0_CSn0 */
+			AM64X_IOPAD(0x000c, PIN_INPUT, 0) /* OSPI0_D0.OSPI0_D0 */
+			AM64X_IOPAD(0x0010, PIN_INPUT, 0) /* OSPI0_D1.OSPI0_D1 */
+			AM64X_IOPAD(0x0014, PIN_INPUT, 0) /* OSPI0_D2.OSPI0_D2 */
+			AM64X_IOPAD(0x0018, PIN_INPUT, 0) /* OSPI0_D3.OSPI0_D3 */
+			AM64X_IOPAD(0x001c, PIN_INPUT, 0) /* OSPI0_D4.OSPI0_D4 */
+			AM64X_IOPAD(0x0020, PIN_INPUT, 0) /* OSPI0_D5.OSPI0_D5 */
+			AM64X_IOPAD(0x0024, PIN_INPUT, 0) /* OSPI0_D6.OSPI0_D6 */
+			AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* OSPI0_D7.OSPI0_D7 */
+		>;
+	};
+
+	ospi0_flash0_default_pins: ospi0-flash0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0034, PIN_OUTPUT, 7) /* OSPI0_CSn2.GPIO0_13 */
+			AM64X_IOPAD(0x0038, PIN_INPUT, 7) /* OSPI0_CSn3.GPIO0_14 */
+		>;
+	};
+
+	pru1_mdio0_default_pins: pru1-mdio0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* PRG1_MDIO0_MDC.PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* PRG1_MDIO0_MDIO.PRG1_MDIO0_MDIO */
+		>;
+	};
+
+	pru_rgmii1_default_pins: pru-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+		>;
+	};
+
+	pru_rgmii2_default_pins: pru-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0108, PIN_INPUT, 2) /* PRG1_PRU1_GPO0.RGMII2_RD0 */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 2) /* PRG1_PRU1_GPO1.RGMII2_RD1 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 2) /* PRG1_PRU1_GPO2.RGMII2_RD2 */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 2) /* PRG1_PRU1_GPO3.RGMII2_RD3 */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 2) /* PRG1_PRU1_GPO6.RGMII2_RXC */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 2) /* PRG1_PRU1_GPO4.RGMII2_RX_CTL */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2) /* PRG1_PRU1_GPO11.RGMII2_TD0 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2) /* PRG1_PRU1_GPO12.RGMII2_TD1 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2) /* PRG1_PRU1_GPO13.RGMII2_TD2 */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2) /* PRG1_PRU1_GPO14.RGMII2_TD3 */
+			AM64X_IOPAD(0x0148, PIN_INPUT, 2) /* PRG1_PRU1_GPO16.RGMII2_TXC */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2) /* PRG1_PRU1_GPO15.RGMII2_TX_CTL */
+		>;
+	};
+
+	rgmii1_default_pins: rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01cc, PIN_INPUT, 4) /* PRG0_PRU1_GPO7.RGMII1_RD0 */
+			AM64X_IOPAD(0x01d4, PIN_INPUT, 4) /* PRG0_PRU1_GPO9.RGMII1_RD1 */
+			AM64X_IOPAD(0x01d8, PIN_INPUT, 4) /* PRG0_PRU1_GPO10.RGMII1_RD2 */
+			AM64X_IOPAD(0x01f4, PIN_INPUT, 4) /* PRG0_PRU1_GPO17.RGMII1_RD3 */
+			AM64X_IOPAD(0x0188, PIN_INPUT, 4) /* PRG0_PRU0_GPO10.RGMII1_RXC */
+			AM64X_IOPAD(0x0184, PIN_INPUT, 4) /* PRG0_PRU0_GPO9.RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4) /* PRG1_PRU1_GPO7.RGMII1_TD0 */
+			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4) /* PRG1_PRU1_GPO9.RGMII1_TD1 */
+			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4) /* PRG1_PRU1_GPO10.RGMII1_TD2 */
+			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4) /* PRG1_PRU1_GPO17.RGMII1_TD3 */
+			AM64X_IOPAD(0x00e0, PIN_INPUT, 4) /* PRG1_PRU0_GPO10.RGMII1_TXC */
+			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4) /* PRG1_PRU0_GPO9.RGMII1_TX_CTL */
+		>;
+	};
+
+	usb0_default_pins: usb0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* USB0_DRVVBUS.USB0_DRVVBUS */
+		>;
+	};
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
+/* SoC default UART console */
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_default_pins>;
+	status = "okay";
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_default_pins>;
+	num-cs = <1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ospi0_flash0_default_pins>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <200000000>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		cdns,read-delay = <0>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&main_gpio0 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&sdhci0 {
+	/* mmc0 pins have no padconfig */
+	bus-width = <8>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	non-removable;
+	cap-mmc-hw-reset;
+	no-sd;
+	/*
+	 * MMC controller supports switching between 1.8V and 3.3V signalling.
+	 * However MMC0 (unlike MMC1) does not integrate an LDO.
+	 * Explicitly link a regulator node for indicating to the driver which
+	 * voltages are actually usable.
+	 */
+	vqmmc-supply = <&vdd_mmc0>;
+	status = "okay";
+};
+
+/*
+ * microSD is on carrier - however since SoC can boot from it,
+ * configure it just in case.
+ */
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_default_pins>;
+	bus-width = <4>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	status = "okay";
+};
+
+/*
+ * USB settings are a carrier choice - however since SoC can boot from it,
+ * configure as USB-2.0 OTG here, keeping USB-3 serdes disabled.
+ */
+&usb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_default_pins>;
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+	ti,usb2-only;
+};

-- 
2.35.3


