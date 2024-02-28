Return-Path: <linux-kernel+bounces-84542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2AD86A80D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A1F283DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4E21101;
	Wed, 28 Feb 2024 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gSB7Yasx"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5017219F6;
	Wed, 28 Feb 2024 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098502; cv=fail; b=t2eMLbQh2HX+a/QvQM7Of8YHpCw0ff+JwpiAAwRpEC/ouzuIY1HREi2eI2X7A6NDGimnbKJ8prPdcdkdOdMtnfrACmfvi+d39Wk0I9vKtUrVLT5n82RxKqjVnFkQjVKLGskDWUNf8+BZWUVlWPhlwdouVktXl+S2M53gjTBh85w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098502; c=relaxed/simple;
	bh=1q00MX8Um71+MRwpaBW9Ul7j6lvDDF1JB4dPwhmP79E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ptfweI4y/YoV/AgjRKA4URf9Wlt78II69zVfsQ68XLFzDTEHIub4X/wtNg0dEkKbor5oZlkVPfDXg9+QrG8fIINX9v2o7qzKw+kTcCmeK5iVOlQh2yV7ug+n8yen1N7TzRHBz0PXHsmq7fn4IiP9KW1i+5oLgarU0s7il8xTQjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gSB7Yasx; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAbN5/QHbd4GWjmx4blEacOURqnmoNX/PieStt5mBF1vO2OXIoj3InnhEqQgwZUjwP7PNLMIvzt41bjD6l8LwTv/pPWblReiZnip8cumKdpHgfWaU6Fupnx3YvHYdMGp3U44B4lMxByKlupbrlZxcXxyf0QCpA/ViPzxtaoR62PT+6Rjj/aAeULfjSGMMBC+DEJuunl2vYVZt0uBlTUcKLuZ3s/KPt05axHuTkBto4kGUQI9mW30wzag6QQd7luFURmdZfDtNAAlEC2ylNqYynqoRM/mCes9R0KyMkx5A52f62r9U0fl26K9VJnwYd6d2lxI/Pc2YRhwhEKmK6+jkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x81XcX79x4a2Hn+MWwZJ/ftPFjjeLx5eIYSL/f/Dwg=;
 b=KzbcPWeqOQXKj7xri9WAphQXNPBNt1BPLnQDzDaA5rj3Rzijbl0UUiE0ranAV2JJp8UkhW5aln7raYn5rRozQzsEWq2PK1/H88fCwfxfLBFcpbTa2dH2NfOOunGHCUhE9e9BVjmiCXD3KEhOPfPOKQkLW5VEWlP63bWN5hCxVS2qL7pBK7/xvCa76nJPjhNkr9M43NPBojKXP0Dq+LHviBN4jeAY5WvYvizzfMJ/y/yUV0EIPaqV2i9mF59Me3iOvUvtuBXtZFjfbn3wMNRGRNT3v1De6RgRY9x7XbXUmNt3wOAQ3Oo8wMJ/6F9qdvj7txzvQU6+05u5eloGgYQR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x81XcX79x4a2Hn+MWwZJ/ftPFjjeLx5eIYSL/f/Dwg=;
 b=gSB7YasxfOQR8RYqRUs6izpTrdIEtUramUC0maLCiB94GGjpSNCH6sXVlQFnPpoUF43AML+hGrKhB8zbqZ49dIvJQA9MGx8AhdeW4p+9VMyG3MJaq/z+pNoLivJWQvBQtPb3IaHdM2g9pNM/ROElwtEisz8nWlknsXI93t1GrUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 05:34:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 05:34:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Feb 2024 13:43:05 +0800
Subject: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com>
References: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
In-Reply-To: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709098992; l=3472;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lwTL7UDSac8mQFBZK5JoP0xi1Q5SdnWerxBEk85GvmI=;
 b=ma/8jMSztn6vUaLXt8ZG+eqOxkq12PI5guFPeTa2chsmGp5ywDV391JBJO5iSSzJnE54S5uDe
 ILeC4RhQ0GXCu5rLQ5R3khpzivx2Fq+nYZPm+eN3lQ40L9eR6wdaNCK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f62755-aa07-4fc1-b6c8-08dc381eff87
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eR1WYjyFwNrr7JuSX4kSFXRBb/43DtLZc5jNJHtMix1SVZ3gUoIktjIBeD1tYXAR/3+CNE7c91cGGKbGtZAAWaLtyub4D+FHYxrBfqNV0tqPAKpc8L/eJdj2sZYbdyuFJmfmudRxmY81kykRz4KoZXEbZZb5qYQrV3gcEw/cJHunHc/GMlp4bvWwTN6TZxsDcTbij6K8nkJZtFmn28j9JZc+NQvrF9724lvkAbAJmPxE7TIdOba9ecZjIRkSOZXGdbaosA6UiEOFiGU+8Z9OJEtluRGmI8TmZL3DSmSqC7CPCb1J0FwG72MCZDtJacjOeUhimjm7Vbd3CGoHmuMccYYD4xXgVgDORIt+mVo/DgmN5AzrhctQwR/aoPVSnsAoRNwyMm4HsZHAAtxHrYZj0DcLOegRS5qfzOGqoYjwmXRdZlpfiyP+Xz+7ji804tFCpNxXxSeiKDZIcHuTiawFyw448ZEo6VMGxqvVIKEGT7QVqo3sdyAQCDVhUEfMOoLSi8DxoPitOdsYnvTay99EKmL3t2LYDrN3gDRO0rOX33EUpkAxVix7nmJJEPfVNGjJKL6Z7reqRsDoJQNABFkjlMhEO0c0C0lSzV8BIY6Urdh9qSpOzsw/rlAzjfVUUMSG2PbBW1xbIhvoYdGeTOynHu18Q1znut1Cp5Havr0Zu5KoGKlqSsbS/zcPvP7Kw4rKFNtDUl4hGOnNDuUHndd+nW7LvpdYnwaZPwm1hwhCNoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zy9ybzNpbjNVVlpIMjNJdVNIaFZnb25vWEZCQnVqbDVZR3VVTEk3VEhNejBa?=
 =?utf-8?B?bGxnWUFReHQ1dEp1Z0hpYVN5eDUvelJnYVJYQTBML3ViMGhRdmFreXdkNlVD?=
 =?utf-8?B?UzJ6TElsU1h2SG42NjJuamV4VTc0Y2FkZjZXUzlzSUg2OUw1SFdwYnBCb05Y?=
 =?utf-8?B?b3JoWktVcEpSdFhISGNyMzJSbmovWFNwTUdhWFU4dm1Oeis2U0g0YnBBL3gz?=
 =?utf-8?B?NjZveG1HSWpIUjJMd2dvS3ZZYTZqcThRWEFGbFpMSTBieTVOYm1DWkRpREZn?=
 =?utf-8?B?dytYR2xGVExvQmJKQkdkZGZBaHZzQ1lBZENyUVBRdmNCWnFkUFlkTjhjK25F?=
 =?utf-8?B?Z2tmWlcyVnB0MmV4NlhOcEJuTkw4cnJUamdWRHFVZFZGcEgycW13NmdhS2VO?=
 =?utf-8?B?eWl6TnpUWVhYa1lGQjRkTW0xUUU4Ti9Lc2FMbjIwbkxkZ1QzdTFONkxjVXlV?=
 =?utf-8?B?UjVWc1RvTmw1TzBJZ1pHdEV3KzdmZHhZVDZZMkhXU2hzNlA0OC9ISXM3ZGxs?=
 =?utf-8?B?VjNyV3Mvb0MrMUc4eUhYeERGUWYyVlhKQWlYbWdMVFc0aFA1MFdEZEtWdWsr?=
 =?utf-8?B?TEg4d2pjcDZCbnFTU013MHYvZ2d2emM3Nm5sVTE5WURXL1Myb21BQ0VPUFRp?=
 =?utf-8?B?b0R1Z0JWcjY0ZFp6QzJRTFpOUFFIb2R2c2FuclZOQ2RPN1dkekd6UUw2TTk4?=
 =?utf-8?B?dVg4azZYbXc4VlZObWpDVmNUcWtvQkxvdzR0Q2loM3JZVGk5SzRsUGJMdWpP?=
 =?utf-8?B?bWVzQTdVRGFad1Zvbk1PejJCaDlZTmJreTM0N3JTWDdrM01xb01mREV2czNM?=
 =?utf-8?B?OW0xSUlFaC96aDM3aHZ6Q0wvNVZ0aVY3eFhDTkNZdTVPdWp5b0Njc1E0a2tt?=
 =?utf-8?B?cm1LSXBtbStwb1pyaHM1ZXZGWkRzWjR5MkFGeHVRb1FpMXFvdEs1b093anhJ?=
 =?utf-8?B?WjExTTh6Qk53WXVScnhrQUlHZ0RCWkhCYTZoMWxuYmNmeUpHNUlSREVVSER4?=
 =?utf-8?B?ZWxGT0x0b3lKcmIzdjExN2NYNU8zbEJkb3FNMGJ3NzJDOUxHYnhZWGRUU21T?=
 =?utf-8?B?RDZHM0lJcHB0bHdpRzkycWhJcTJ5VkkyYlF1TG9nMWRqTi9YTlZhSU5OZEhj?=
 =?utf-8?B?Y0NHNzMrVElTZTFrMURaeTkrZ1RmR0djQVY1em5YVWNqelB3d1BvMjEzbGl2?=
 =?utf-8?B?Qk5vYjV2dThpTitGcUUzNytqa1NUaUVnQjVOaHV2ZjRJSzBYNzkzUENTRHJl?=
 =?utf-8?B?dEJDNGNJUmtkb0RoNjFFSE9Ga2U3MDljby9TZEYvOU03MmpwOXhWNVEyNWZl?=
 =?utf-8?B?QkhraDVuTVV4NkJrRHV0czhJcklHT1VudGI1ZnJ0U3FGQzhvWGp5ckE4UXBP?=
 =?utf-8?B?Q09FYWNzZkp6L3phZ0IvS2loRXpES0pkUmVROXk3Vmgxc21UVnUrWDQ0anZ2?=
 =?utf-8?B?TE5QMWl3d0FndHhhZXVmT25UVmpiRm0zUjhJcXc2bVBNSUNlbmdWODVWMmFw?=
 =?utf-8?B?ODBzRVRkUEtJd0I5dGZ1S2tRV3YxcmRLZHBiMHhJMGd5amE2SktFTUs1Rmcr?=
 =?utf-8?B?ODN2K29lelVvSkZHVFI0YXYvU3NNV3RqdnFPZElBbVNFN3VSL1hvS0lFWWN2?=
 =?utf-8?B?YkFTYTMxWVFvQ3YvdE9kQXNYOE55bWxyUGVGbG1JR2ZUTnFVTzI3MStUTGZZ?=
 =?utf-8?B?SElBcHF4L1hONVVTWW9sSE5BUDdJcXVrUnNZN01FTWQveW1YWXdhWVdZSFFm?=
 =?utf-8?B?RkZQMWl1QUVJVXRPRFA5TGdaSldDMEJNYlZzY3k5L1ZkeHNWODJ1b1NJeEVN?=
 =?utf-8?B?c3RicEFUM1J0OWtKZVA4azFIMlVJYktYTWVjRTN3VEJkZmV5bi9ibHNRNTg1?=
 =?utf-8?B?MXcrRmpDT0hlcFFvL0pnVmpjYXNLNXhvOWJ0eDFESnl2aU5vMzVzRFdGbVhM?=
 =?utf-8?B?T3hSTTV5Rk9vMHFaR3BrdVlGd0NmWEhOR0d6TmZRV1RwaUdNby9OL3N0cHpz?=
 =?utf-8?B?ZGdHamxWN2dLcHpZcnNoRTZvOXJwL3hDYW9WbUUxa0dPM2hQOEpORVh4NkRj?=
 =?utf-8?B?c2w5OFdRSUNvNFgvTEFiKzFBYk1uY0RSQlBBbkdtdVFHL3Q1aS9peEI3d3hS?=
 =?utf-8?Q?VnxjnbdNlOKAmSDT0V33wt+Ms?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f62755-aa07-4fc1-b6c8-08dc381eff87
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 05:34:56.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pl5vGkhPQMwD+3clI8e7CWUdncNzkqNMfIsCtKfVw8AH31VVOaGUyfXJLFmtdccqFybvYxhga01sz2YndruQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525

From: Peng Fan <peng.fan@nxp.com>

i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX and etc.

The BLK CTL module is used for various settings of a specific MIX, such
as clock, QoS and etc.

This patch is to add some BLK CTL modules that has clock features.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61 ++++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
new file mode 100644
index 000000000000..6d33601034ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx95-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx95-cameramix-csr
+          - nxp,imx95-display-master-csr
+          - nxp,imx95-dispmix-lvds-csr
+          - nxp,imx95-dispmix-csr
+          - nxp,imx95-netcmix-blk-ctrl
+          - nxp,imx95-vpumix-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See
+      include/dt-bindings/clock/nxp,imx95-clock.h
+
+  mux-controller:
+    type: object
+    $ref: /schemas/mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/clock/nxp,imx95-clock.h>
+
+    syscon@4c410000 {
+      compatible = "fsl,imx95-vpumix-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..09120e098a97
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+#define IMX95_CLK_DISPMIX_ENG0_SEL		0
+#define IMX95_CLK_DISPMIX_ENG1_SEL		1
+#define IMX95_CLK_DISPMIX_END			2
+
+#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
+#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
+#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
+#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
+#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
+#define IMX95_CLK_DISPMIX_LVDS_CSR_END		5
+
+#define IMX95_CLK_VPUBLK_WAVE			0
+#define IMX95_CLK_VPUBLK_JPEG_ENC		1
+#define IMX95_CLK_VPUBLK_JPEG_DEC		2
+#define IMX95_CLK_VPUBLK_END			3
+
+#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
+#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
+#define IMX95_CLK_CAMBLK_ISP_AXI		2
+#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
+#define IMX95_CLK_CAMBLK_ISP			4
+#define IMX95_CLK_CAMBLK_END			5
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


