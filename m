Return-Path: <linux-kernel+bounces-145838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D208A5BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D021F25170
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094E15FA79;
	Mon, 15 Apr 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlwFZY2/"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FA15F323;
	Mon, 15 Apr 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210442; cv=fail; b=XVFd3UCK2yCkIMs/0FZ5Yy/V/9Vjk8pL265/gNTdahF0VpLV331JvP7MOeP+f0A7NeHYkcVLSROZPrMK3KerKBsBKtiU5k8LBbh70XN4nrqChEv/MO0Jvb64F9O7Utc+3ui2MUZOthpIraTuWPAhHlPVpj1scv+JE25Vvq0uYnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210442; c=relaxed/simple;
	bh=VHH6arrzvDcTaHiMwsWAYkCtbrr4WW/mWFOXowZ4taA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aY+yqXlE4wfn2AiC8q9ykGDZHvYDleneQYI/gfLHR8nwvEf47oIf2Hrkxj9qItvWJ2iQOlt9hqGHjBkyTLDfeyMCM0oEh5Fmqcu6tGb83GK7X8IrulE4n3BSylDxKVUMoNbUZE1cY/w8bTrt0xmndHPMN13feRno5HdENwbO27E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlwFZY2/; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAgm7uEo4KiAIJRIhTx4VHg7R3xX6WEfadIBp3+sU2+1xDJp8EO+lgm/3PfHHWQNbHMyBoRSQ/gML8CdtIdVR4FOBR81Q9fjRzb71tS4BdhXxTYf6LRETkCVmm+OkjCM3AzrgJptUCAEkkn0yk+1oUQPi8aT6OSkdJqtIab46dMaEBfh9p8ktqCpCI328beTwmg3yjF2WwqjZLxIqXfnEuT77d3TS/+BxQNaRD45YmvZuvU9zS1mFL9HNfLG02yRM8Us/SAncWJynGZZsWQvYTJK1bdFnRKCOGygK7NJFIWycHIaiVMxVsY/h9SzqXmgkNAH4qDkWwOkkDLj9BuLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXgJzOIyGUcJMXJkINb0HdMod46tJoDTML9Di3ewAyI=;
 b=jbciq9Qq9t0VWyJiqJJxfWwpYV8mMd40lZQbUFyGzxgPP5pA4HZV/Fvw2NTDuAledGd6nHdU4wllwCzw/7DfK87DFE9rS2nn6xGY+HTL7vUHqTeXkDYpa0GcDa+coaoesQGhp33AR8AgHQFdzkF4HghStLwzSe+1JjrRQPou/NICwqO2bnYEX3wKqHl08fg1hyxRsb08P4R0TYmpmozzmliSjUkfVVb7s1TGfjcoRxQiw8LHQ57GaWiPR5O7/HZhZSt/WPdjC5aonhVdUFdlYwdu4BwxxAw2H0BQNN1sUqbHDjYngAU7x5fhiDFRxipqRZkXwCeLdEouTKACjXKv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXgJzOIyGUcJMXJkINb0HdMod46tJoDTML9Di3ewAyI=;
 b=JlwFZY2/YChbMV9i1kMEJayFifWfxtimyrs6c+Ew9xhE3Ncn1wwYadCUbRk6hFaANRYdAWa6XnkhZDWI4CFhExsHMwYKW8mRsdzUrJGRAlSnhgtvR3xt4+IHdUgE8bOZV3ZFOYTdF4deVj0So+xiOTHHCyDSHtq3V9QxiWhx5x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:41 -0400
Subject: [PATCH 05/10] arm64: dts: imx8qm-mek: add i2c0 and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-5-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=1711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VHH6arrzvDcTaHiMwsWAYkCtbrr4WW/mWFOXowZ4taA=;
 b=xILNCR3LbvyTjNk+eZMmo10vG4/RrxYb+gMUU4AXIflEr7TJ/1ajzfKwEnSZnE3zDKi2+SJaL
 3FTkxy8wXQTAJzS6Vh6aHw94VlazRqhhSqBNexzCHulyhRKatt1T4RZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c65cfd-0c7b-4761-a8a7-08dc5d84dbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5euY6FN8xHG6dLnd4Vk5BhTh6Rdh/dS4wBLd46GsAV1wNYp1KNcrumfZliWaSn/rACN3gBpYYY/ZpyHLHxJ9VVhJNgGHEWpCKUH0F+JmVecTXaZaIbVlqXnOr/k/9CN2PyI+HG0dJqnBAAwIrgCeMsNYLDOyPtfb8WaNJ206p7JhTNphFWB6RPUGCfea/Y1Fr3H4AwUL5rZTDVPsm9ziUOhqNF2uYg+IpV9smw6ky1fOdC/Ff31qsfOj2NRdccLd9jqklksMs/pXSf7+ydv/ONEcHZbPnZxi9hlnJ5JdLBcTupMW66O3Qp+WuHUdVCp7JcDn2cWRKzpeWhxbcOsyQo3xYRBAkBEvimpvSZx/RI6Ytwi0Mj6r/KIN6vlKZXbBvvxEjlog/gvrC+woBkem3JqCWJCLQ0bsO/nOFsOE6xymblXVNUB8oUssRyaY8Fz/YBoGO3MQOt1JrisKV2Hf9ArnGAowQKpJXhxeJzk5nSEbxTa40DPse0n+FLEJuWFgaEwW1k3LZuGRdUs6hHvao+oXK9vxcdHfihzIhNl6SP8aaEhZF4I3LMXbmLkPqL68bieMr6RjQ5hacNFNhTAmcqK3VtE9CQHejmFJe5z4K0anGNadMLJlXbTv5JommCu4pxklC7mvNcspxbVtoO3Cr2TpGMWZv+GjbUUvXKjsize32HnCJO9p/pf0MpBLeemoL8JzDlwi0PgoLhR3nz+jpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3h0Y285c3daTEhCdHpxNXQ0azlURjdXZC82UFVNZThiL0YwR1pZcTJzVFhD?=
 =?utf-8?B?S2hyNUZLRTdvTVo2dE12N05nc3VkeUZYMlUwN0lRMlVDQ1JMR0lOeXQyTGJQ?=
 =?utf-8?B?Zk9rQXpQb0VYOWloaGVvZEdRb1ZxRnE4Ty90ckJFQVd6YUl4U1hHRkVnTjRO?=
 =?utf-8?B?eHVuRm4yb1NnWnFtUENvTWNjbmZXQTUxYVV2V2xHQnZ0SjJydC94R2pCTFM5?=
 =?utf-8?B?Yzd6YkE1Mnl0R1FoRTFnNWdwdGtjVFFJbUdON0pJZkxlQWZ4Q3RrWDRScVZG?=
 =?utf-8?B?VTNkZHJYZFFuVEJEenFOU1huMFlTaDFBNUU4aVFIUmtLUlpOVmFodTF6aWZt?=
 =?utf-8?B?b1pQZHlybGxadWxNUWZ4azlNbklmT3ZUb0JIUnFEamowako5MEExaWFrcVBz?=
 =?utf-8?B?OVJUOWRnZm40WmZ4OUNMY2U2a2VGazluaVNzVENyK0dmZ2E5QVhaNlFNWWFO?=
 =?utf-8?B?WkZ3S3oyRWtjVGlLUDJxbVZsUDZ6MWFoMWhJcjJQYkkyZEkwbTd3VTlBZUk1?=
 =?utf-8?B?d0VheW9sT3VEN1RCYWNWTGVuREs3N0doMUZTTzhZODZmbzhzcGV1SWFHMjRy?=
 =?utf-8?B?empORWFwT2VTcGdKbUdIalVMSTQ4aFpEYnpsckVXQ0NtU1Z2bFNNMmxNMyt5?=
 =?utf-8?B?TW9ETXlNYkN0UnRvVWFsODdNV3JlU01WSzlJQk02dWlLcWNMUjVZNG10UWdC?=
 =?utf-8?B?dlZTYUVGY0RPSk4rZ2VlOTB2amhyK1ZDdi9UdTZNemgvVTVMb250Z2J0a1No?=
 =?utf-8?B?TTZlL3I1Z3hZTmVBM1lTZXNxWHdZTUVRR0lBN3BNQjNkU2hVVUpFYVlFV0N4?=
 =?utf-8?B?cy9uVGZyWUlaWUJjeXlDSXZGNU5KSExpWFFNeEptZ25pMGgwQlVZMUNmTlFT?=
 =?utf-8?B?NUNLbGt0NWdkenUwdGZHWmkvdk5qUERNWTg1emVib2RJVEhCOFV1OWJYYzM4?=
 =?utf-8?B?UkpZMDVPOTR4ZmFDSWl1VEc2WTFtaE5IU0xhUXRkRTkzckFiSWIrZVRHcmtH?=
 =?utf-8?B?b1cxZGFIL1hRbHRFQjBvZXVBeURJR2RLUTZCRzFSUG9lYk9EVWRzU0tmWkJB?=
 =?utf-8?B?bm9UY3dyUVlpVS9xV05vUGltbG5ldVV6N1Q4M1NkTWdQVXJEYmR3ZEJiSGtC?=
 =?utf-8?B?VTlFbmljd2M2c1pKWEZKU25LMDRmWmxwOHNSWHlDNnBKWFJGN3NIQlc2Znk3?=
 =?utf-8?B?SXRaN3VZbVpEelhFclNFa1pPdzc1bDdLazhRU3RQSERRNEI2c0ZpWThYdDRZ?=
 =?utf-8?B?OFhaZ2xvbXVscm93MElHRlZUcDBTZGFWSURWdFp6TVR0UyswK1ZtdkNiUnFL?=
 =?utf-8?B?bGtSOGJ5MU5UZWRXSml5MUZ4d0V4UEFSNloxYlFRZ00rTnYxckQ5RmMxRklh?=
 =?utf-8?B?ZjdVbGY3WWRnT2J6TVYra2xLSjhCUzdMRTdNWlM4S2FYMFBZNVlrWDRzRlZW?=
 =?utf-8?B?dHgvd1VaUVhiTnp5cFJSV0RlUE9oUVRkOWZXWUpmcjcxcUdmclBQZmRvVjZQ?=
 =?utf-8?B?a1k0aXpXdGdRbXJwMFp6OEliVDVMUGliR2Y5M0J5ZW1adUZkbndvSzZCbnJs?=
 =?utf-8?B?NFozZXBSUlRaZ2htSXpBZHlyLzVJMWw4OVZoSkZkTGpPT2J1cDRLbTEzSGts?=
 =?utf-8?B?RnNHWHV1TU9kYWR1OE5mZm1GZnp5bkFLeDAweUJtUnFsazhQdzJCSUo5Y1U2?=
 =?utf-8?B?WGtydG9LL0hEUS9CQlhFNTZQUzJzZm1Cb09nVXhkei92NC9GZUNFV3RLcHE1?=
 =?utf-8?B?cUZaQXdrQllkaGx4K0JHMWFPNW84OTI4RjdNV1ZQNUo2M3pmc3dyRG0xd2Vm?=
 =?utf-8?B?K1IxUFNaVXpwT09QbzBFSFdtZWUxYTRlcEhCcWduWTdxcVlWcWl1Uyt5SFBh?=
 =?utf-8?B?VUdCNVRIdXVqK3VHS0habG9qWU8vaVpRUER3bkVVSWFXNTgyaUZ0K1RnQ0FW?=
 =?utf-8?B?TGFMN0Y1VjlDR0tHY3dSODkwMG9GMXlWSS9QYkhWNlJjaCsxUVR3TFdhemxq?=
 =?utf-8?B?am5DRytRRFJpZjNYQkRGdFF1SDY2WjJGbmd6MExWcSt2NGlnUisvRGFZUnJx?=
 =?utf-8?B?NVB4MWxaMFdjL1kzQ3BWeHl2NjIxM2hVc0hxQUlBbGxnTEkydlJKZ0l6bGZv?=
 =?utf-8?Q?E+ryRCCWRk29tPwe3UQUbai3K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c65cfd-0c7b-4761-a8a7-08dc5d84dbd3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:18.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DBwEeXCUdyUJqY2Dra9q/iGV42Jkbv6HpaeZ9q6OMszVNLGRvnhsJMp8YW2ad5/kJ6Aevss8vNB+1GH8KFzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

Add i2c0 and all devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 9dd84126493ef..d321876754e9b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -96,6 +96,49 @@ &adc0 {
 	status = "okay";
 };
 
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	lsm303arg@19 {
+		compatible = "st,lsm303agr-accel";
+		reg = <0x19>;
+	};
+
+	fxas21002c@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+	};
+
+	isl29023@44 {
+		compatible = "isil,isl29023";
+		reg = <0x44>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <11 2>;
+	};
+
+	mpl3115@60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
+
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	l3g4250@69 {
+		compatible = "st,l3g4200d-gyro";
+		reg = <0x69>;
+	};
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -283,6 +326,13 @@ IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31	0x0600004c
 		>;
 	};
 
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			IMX8QM_HDMI_TX0_TS_SCL_DMA_I2C0_SCL	0x06000021
+			IMX8QM_HDMI_TX0_TS_SDA_DMA_I2C0_SDA	0x06000021
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c

-- 
2.34.1


