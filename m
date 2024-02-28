Return-Path: <linux-kernel+bounces-85650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643786B8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B842FB26C31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392D15F304;
	Wed, 28 Feb 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxf+o740"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262ED15DBC5;
	Wed, 28 Feb 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150143; cv=fail; b=NdDWs/wQ74YO+wuy1dI1EwXR+FaWIAPrC2pcJzRlfZ6lCJcSQhhTNWTxr5pP05xq6tWqoAHbvIkFhF6koS595Qw2ebhhTgSZI3vkfrpgSoF53sVZOjtD4dxvRUrJgBhsjKy59on+XAZ1z80C58EsBLxzD1VKFaH+nCiLg5USfR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150143; c=relaxed/simple;
	bh=JT3HdlLeV0PuEc/pNt5nlwmQ1RAuh0NmYevKQ4XEii0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nFOvnJc3Z+QSK3v2rsG4H+lHurbtm/y9zp5KGxFWHKQNaqxcn0aTZBK0nBcjwELtk8OjykKeZGAbJ/e35Qo2O0ESenLQUbTmRmjamxcvQf4jIDgh3vXMYaq3dxirPsGWjtvlJlOAhpUR9XNIHfbalKOH3tsgZ/k3Bw2GeKfaJvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kxf+o740; arc=fail smtp.client-ip=40.107.13.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTxuyTtYFLCFxZF+rlMc9KXWBsKPL9QXbDLeKMbJg7xUzzaCXc19n9tEyqQA/Rt3W6yPnSSJgovlAlh8BpGJY+d3Gb45z5XBhqNCQlQSoXvo1yGiuvkFehcV48I9xzppWKI55VbDty6MzyhXQMWTa8y3UNFijVrCERkwh45NXLIGcPYLhozUcpz4wosGAG4CgkPJ6QaCP+2E1cmlAcimRdcae4gxLIYdXkoycATvr+g8DtNDpHjX8cHBisyKGa5dY3Gj9KI4TPaNu/N3jeLzmzZMzaNvrDTVFHubD4XKIQiEQCzLlfyFseB1OE6kR6IoPw76szk7zL87QgAALamJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVwc3EJO7Y8cg9Z/K7YKwAf8GftSeddEz3IRWf0CMF8=;
 b=IW9X3QdFWdAnh4KOWUHe75rr1hhRJlhnQab1tE8FGTug5xuCUyhYEhLmZeGOeOAViAeM8asr7+QtrJgJby8Cv9T0/80bJPDDI7H7LgCUvurxEZ7qVVHqw/vR5FzV1w/YxOryUo6986p81ctoXddiRg8YrRDGfbMYI1UAn4nNmbgZToEtlR4bwUBP8siMVkzmfFQrsTdMWwAODcLT7uuWzpn96BXc5I+YlMDmavKR0+EYcJRa7Brt7SRhU8LDxtgYeA/BvlHLUx3eQyw/B52JIONevtTCk7WpOVcszWSiqDJLenwl6ZUH+7zYKt9XpzDlUXM5HI5AZhg2yHJhaI9yXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVwc3EJO7Y8cg9Z/K7YKwAf8GftSeddEz3IRWf0CMF8=;
 b=kxf+o7405VQFCNti9Nf7og/d17VnVaYRbcl3HqBq0v1mjOCfvg9nfiDH98x3b/9w3UWOlDmM+5gxgfiFWM0XGYu3u8X2eIE4jtlrBuOTo8ry88OhVN168C3nAjkYpdzfUFwagSNjXlMxnww4pV33KmSZV3PCi375TboPYWuLJak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 28 Feb
 2024 19:55:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:55:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:55:00 -0500
Subject: [PATCH 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-m4_lpuart-v1-4-9e6947be15e7@nxp.com>
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
In-Reply-To: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709150122; l=2217;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JT3HdlLeV0PuEc/pNt5nlwmQ1RAuh0NmYevKQ4XEii0=;
 b=qZQEJ1i/LhdfZWF1h5WgOls8IVeQdB638VjRTPixsykvzEkaEAArOYqCcF+4BIzzOfQrfjVzY
 TBH70uLwEtdBU92LEPdQqcF6e88JETfum7UmZg3EQKoKs+e9CkMzl21
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c931992-0df0-4a61-4a2e-08dc38973ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R/tXUyaKKTLyp/eNjAkeHaAVd0xQhpQrHZrKu799ZlIYUmHThdGlLHQf+JaG9Jkmn0bYJgaVGoK1IGVUCFWc2eJPQsYG5tPLNeAnFiugFSmyMyyuD1HMNZRrLw0K5y6aPuorEpW6S8kX3x2fVvrSr4J/+CjMbKQAUrge3H+E15EmabHVy3yGfB07AvL3xryP2225jC9Ojsnd+xiLZbuhwJ56RkLcOkVA29Na4OyqzYmopjq/54Bd9uxTpRYlTnPd7q876cRs0Kg+Xp6/Jc/VqVSJJSgRwnVbnv6By7cK6LAZuEZtAk+Vx5ZRUyixUTcobAlqsZm9gEJCLihR3smbqihewuc5vS+fKzEgpJOYW7anhwlCnW3fYB+6Vue2k4cqfAOj0LJ+NBRIhBdWCQ+LD8TP1BKMtxfrq9WxAhsUlNZAfSIpRfFCmRm/EubR1XnQ8x+9Gn3JhJ+N7Q4C6aqDmADekNPvZ3kdNuZXGl+QNgmMHLwQ4f5OjNsrXozI35LuwJmddt7lxM0c3QsuSdUBbDfys/Kjx7+vJsbJ1age6RpTzExXYXztEfFRJY19hf1Gz1dEv0QwjTw/Llp6nIGE46Ei8Y+ixKZFK9o7rbD/O4OH3qcoxONYV8cEft2pTqXrGY7sEK8f9FgxTIPJ1QMGKm++kR3/gQBUi05YV08ZPAuG+WQt6DZez7yzeCSREmVm/ErRi090Ban5zxMyIfmiC+Ww6950OVM+IR5ciqqsA5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3VJUk1UMHF6a3p6ZzVZbFJPbFY0VlNlZzBHd2c5Zk45NE5hblpxRGZockRi?=
 =?utf-8?B?TmhtZldJVHgwSWwzL3FXSldtU3VpTTg5YkxoV2YreFhmUzFCalQ1U3Z3cU5R?=
 =?utf-8?B?c0dSNytWSGgrcFRQdmVscE8yVWtMUEVKNGZ1OVpUY0V4NUY1MnRBOTNaNDMx?=
 =?utf-8?B?QW9KdmdrYU1kcTdoNXF0OFNxUjBsYUZlU3c5TTZoSU9TYVYwV2RzWlRDa0h0?=
 =?utf-8?B?NWd1STlVSmVGSldQTFZyYWFLUHBFS3dXak1UVGM3SmtJZkMvT2pvSWMvb0Fu?=
 =?utf-8?B?QVRJYlpqM25Ddy8zN29qMWl3UnRscGxCUm9uWHQ3cGZCMmxxdGxia1lEa3pY?=
 =?utf-8?B?WWZLTTJiQ1lXUlo4LytLOGJwMUdRbFJySW9JZnhhSnRIMWQ2NU0ybUphTlA1?=
 =?utf-8?B?N0U1Mm1JNmdMczlJWldHSnRtRndVV2ZrcGdYcnpRVzRCY01HN2l0Z0NxTjFR?=
 =?utf-8?B?RTZiUVFmTGRRRlU0emNxN3JNRHBnTzNjc0hKbENyWURlRTlDVEdoWmx6YW93?=
 =?utf-8?B?RzQvUmRQOWhCZlBQZmNCN1o1Vnovekhyd3IxWEZHTzNINEpVdnBSTG9XTUh4?=
 =?utf-8?B?djh4RGdJRWo4QzhWVVl6bTBUUDZqNjRXUjBDRjY0NS9KUjhOMzl6MTg3dlpn?=
 =?utf-8?B?YVhnRURPWUtoaDVSODAwcEpsdDZaZXdwZ3YrUjZMRWdwdFlmYnhwckdGSWRS?=
 =?utf-8?B?K29laFVtcDFZOTVjYXNiUXc4ZnYwcXNldDl5dXNWckJYclEybkJaVDBZZFJO?=
 =?utf-8?B?YU1hMSs0WUMwNmMrWDF4UWJWQ1Nvdlo0NGFFcENDcXo3aUtNWUJubUgrSDZ6?=
 =?utf-8?B?TktQS0RPZjlYUFRpL3p0eldDaCs5RGxnbk5QclQ0TmExYkpzakZQWngyOEt4?=
 =?utf-8?B?Wjl3SHBOVTI5T1FtVUMrU0lTaWs0N2o2K1Jvb1FWdTVDQkMwUWM1dUVJUzdS?=
 =?utf-8?B?S3dCOVk0QkZ4czNoU1ljUFlTdlZKS3dxdDg3QW85Vmp2ZGFicndsY3pGSW1P?=
 =?utf-8?B?V253aS93K2kva3dyQVRJQkRaQXk5ZEhmQmcyMnNCbGh4WitIWDYzNHZTeFZJ?=
 =?utf-8?B?WGx0M081UUNRTitwVjRnMWhDL0hjaGxXaHNFVUV4ZTdYSEk2SGpuMmkreVli?=
 =?utf-8?B?TWtuUFc5R1pZNkwzazg3RndQalNrUlNTb0FSbkhLdjRjRTdDTGVxQitJOWk3?=
 =?utf-8?B?bXBJU3NmL2V1ZjFuMVoyeENSYkNUa0tza1czRGlnajU0WHROOWZYdkowUnYr?=
 =?utf-8?B?S3FhSTkxaGM5S1kyaGtEVVprSFVidEVQdFJ6QjgxSlBsaWtyZERSQVpySkdL?=
 =?utf-8?B?dWtSY1U3Ukl0a3dTbjJWUlEwMFloQi9wa1RydjczWmM3UFUrclpha0VlRlJK?=
 =?utf-8?B?d2JUeURReXFtdWFnNExwWnE1SmpCTVVCalJtbmVabXFiS1NvbXR5MFhTNWc4?=
 =?utf-8?B?OEpXWXpaeEROUmQ2QXFOS3M5SXhNbkNYai9UeWhJc0tNaTA1bk9nWThvS2hh?=
 =?utf-8?B?V3YwL3RLUFpZTXJKM1lQOWFxMDZhc09FY0FrMitpNncvMWpNWVFURjk4SElS?=
 =?utf-8?B?bzBlVG83QUpDK3F5T3Zqek03VTI0NUpLaTJlN00yY1IxZlZSWWwrWWpFVHpJ?=
 =?utf-8?B?ZUxCTDd1aDVtRzhGcHZCV0hYRHdrcmtPWnZXNy9VeTJPM2VRL2Q3RkV2Q1dl?=
 =?utf-8?B?bHlsRmxHZ2doV3h2YTRUbTRFVWNaR1REWk5PUFoxck5aWU15TjV3RXhvNlZm?=
 =?utf-8?B?ZjdZSTZ4ZTZxeVNpRG52MGlnRHFnT0c5RnA3Z3ZKdVFKVmFnRnAyREl5Rnlm?=
 =?utf-8?B?OUJqYjlFUkcycC8vbTVXaE1YT3laRXRQcE05SlN5VkpXelg5Q0NOZ0R3aTBw?=
 =?utf-8?B?QmlBaEEwN3FYTWd6YkZCNEhNSFMxZHYxNnVxd09FSXQ1L1dJendLcElTZGJu?=
 =?utf-8?B?VXJMcmNBSmVyeUdDR3lucG9pZXU1WXhXMzdHZjlKSHBJRG9uaXJaMjZ6eGxw?=
 =?utf-8?B?VWZxb2s0amZSY2Y3bkNKc0hMbndJclpzVmF1cURjS0RmTEFVRUVMRkhxK1lr?=
 =?utf-8?B?cGRRbHVaS3V1ZlloUnBWd2RtdTJTaU14SlFhcHpYK2ppQ2F4cVNEVCtmWDJr?=
 =?utf-8?Q?EfMXDwrrgw3MmQRXc+hMd3m0O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c931992-0df0-4a61-4a2e-08dc38973ca7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:55:38.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE8KkrXGFh7/Ntv0PiiP72Q8z3FUhxwIGXv/wot090DvbrM+HT3h3qnY4d/fPVp/I1XrkEdaFC6rM7U3noamXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732

Add lpuart1 and cm40 uart.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 2123d431e0613..b45b0c99fe204 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -16,6 +16,8 @@ aliases {
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart0;
+		serial1 = &lpuart1;
+		serial6 = &cm40_lpuart;
 	};
 
 	chosen {
@@ -51,6 +53,24 @@ linux,cma {
 		};
 	};
 
+	modem_reset: modem-reset {
+		compatible = "gpio-reset";
+		reset-gpios = <&pca6416_2 0 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <2000>;
+		reset-post-delay-ms = <40>;
+		#reset-cells = <0>;
+	};
+
+	m2_uart1_sel: fixedregulator@101 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "m2_uart1_sel";
+		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	mux3_en: regulator-0 {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
@@ -354,6 +374,27 @@ &flexcan3 {
 	status = "okay";
 };
 
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	resets = <&modem_reset>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&cm40_intmux {
+	status = "disabled";
+};
+
+&cm40_lpuart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cm40_lpuart>;
+	status = "disabled";
+};
+
 &lsio_gpio4 {
 	status = "okay";
 };
@@ -595,6 +636,15 @@ IMX8DXL_UART0_TX_ADMA_UART0_TX		0x06000020
 		>;
 	};
 
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <
+			IMX8DXL_UART1_TX_ADMA_UART1_TX          0x06000020
+			IMX8DXL_UART1_RX_ADMA_UART1_RX          0x06000020
+			IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B    0x06000020
+			IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041

-- 
2.34.1


