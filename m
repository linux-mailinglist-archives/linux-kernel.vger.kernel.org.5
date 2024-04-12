Return-Path: <linux-kernel+bounces-142514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C888A2CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E2A1C23C46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1717155C3B;
	Fri, 12 Apr 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fgSVhAZJ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E4535DC;
	Fri, 12 Apr 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918379; cv=fail; b=XjZtb4KQFGq3zw7vvV2e2BmpWeCSnvAqanoW6t8Xzk5I+6eKs2Inp8kglCQ6st1z8MblA2QskDUuFZvycG0+5/rowOE00ZYGjNTd+ZvB+d6shQfFKqaeT9VfOQnXvoauautuMxr9wbS8ph22sBH6GpPYs2xptfONNZQx501Y5Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918379; c=relaxed/simple;
	bh=C4070NxHXEdRIlRISs0kV2A5J6MbWwBKttj8TBpWHOE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LPQPSmvQxhzisaIhqyFem2FXbkAU6N5YMyKjEh/d125VLnwcOSRmbO5rRLaxaEdSaPj6H8fb+wDykoBWWzUuflAAQDsxwEOGuV26yrHMz1FaRd81dkuJXzDBgid6yJAeBbTFxBnYVDDDdvzFXhPxXVUxLa6PORCqoscYgcB2gfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fgSVhAZJ; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIAGSMSkAslz5UmqUyzLR+edIgEvwlsxQMJ1dxen4FUt/3a9YcFY6eHQnHEg7ibbFhVRumh+KLX8YB44NI0uAWeHrPS+ivSfFJ5z0QuqwoilZI/4P6Cj6kcdrvGsBWud4fUks+29E691bVnxGD6K4bxMA4zNROnF93fiPqhzz2+Yn1bxwzfdNuKmjFuYHAPowqcZ50WgJUxcN2kdpmVBYIyyoveD3rtBgdmsr2UErxgxKOoxtDm7s1lkiV1GgAXVeoJQ9FfJvn3mcu9KUr+ZF/2XuuGxN/04Ryot78Qb2ipx87SdEtRJIKIL2DWV6E+6Kh6E2Sp6D3ivoviXHk3TYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6TFiOzYXzLz97ME1+nCCA5wS2Nvj09TuZS0aNywfIo=;
 b=DmIm/OeZ0fur6t3FPLMKrbBYBY95yU2CTRLBE+Im2rxyMRZtxy55eC/dw6y2nRKuN9oQnpnXGHzV5MfcExtRi3HGA8mZFFCRGAd0uVVjVhM23WUmuzoRJwxw7r/mRH0ppZAFTQRu7TQOkPoRWxy8JP7PUaCaJI4HRJPMhOjaauRzqzgBoMWGulJWaELEckB8rh7MlkzeaerQZJZx51a6H/90727jMdJyD+RTzctRUoY+CLpa6z0BcynDmrxypacjXIRyO7IW35bocM52/h2ur/DOr6z+H5QSw6Cv/oRr3TAo0YYxRYu7u4VaBxZE1clYgEneGW7s7uhq/dUAsrpRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6TFiOzYXzLz97ME1+nCCA5wS2Nvj09TuZS0aNywfIo=;
 b=fgSVhAZJojgA6BsxHtLcpAsvcwlrvF/UXl1kFvDi7ajfzWKO+/52LxxtV8HhOy+pSqY3Q4D6Zv0Xyuii7Cf4OlZJ5UgS75qOu0aXaBgwqGGZRPqI7DmI2kohkfj6MyRp/Scpv8dePNc/d1UN3h3PClXCgwBPOK2bSqWAFDOZNTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:39:34 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 18:47:10 +0800
Subject: [PATCH v3 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx95-bbm-misc-v2-v3-4-4380a4070980@nxp.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=11303;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CgPGaPP+YJI903GGXjqbanZ6FzgOXN8sDyrSQkwxsuo=;
 b=nO2OqQETwxI/cFUeaQfBal7d7p+xBU5KcKwUO8yYPYkyHd/FqWY3vjbgQUn7I11/bMM5+eWwJ
 XhqnEPuZQ1DC060KgpZyICGd6x79BCjPmj4Zl12FiYPO0YYnG0DcyXY
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db023f7-b29d-495b-ceb3-08dc5adcd828
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hze5dTG15AT4/CTZnfMD74BUT8DQcHSak7LHtdI77KJ3xJrABIY+8JollP1F/ELAvy7aQspIGFQiAnGF+rE5+Y6xpmqOQPew7fhZdXTTltdZs9wY/116KB3guelcYE6SR38fxBHHFS2lxdzWhuBjFNnjQAd/UXPoRImcgrk2+mv9reFobUV88G0/Z0mhVOsj273zB2cT8OYzlnCG29Vs+tXhvrRlP++pspGijO9k4wllNC8gZzkq6lmGX7MJb6pmQL4L6FRUnW5RgMrVlkgbJGTCcf3DwzYTQ57S8V9kWBseWQg30VzmmV/NNcrfCyylhjkMLBFskucDLsTx+fbA9LTyS7Q6Vb6IKbWF9vbMG6gbbRi5A+U8c7FUfhTNQPUlQ99Th6fRiLuXZYg3gZ1xuHazrEli/1t8L4qHGffCibfqs3pRVGY7PhNheNVA9ZlagCoTibMgQwM9jEWb0I7b0RqoGMYbPPjA9mcfDaP7hdZi+UF/jyY5GQs6tM6EZMQPUR2t6NfSW+w6ko3Of0NzEa4K9awU1LSRcipgY4bRFA464hJPysKzjevniRFKSlmm6qkLn7+Xmt38RUsUbDyz50pJmvMxfYrt8W/b0PZkk+h7UAcYrc4soINQC4+eFqlvy8FhNzZndEu4M5hMDAuef8uDEMdGKbcNpcFln1sxtVmg0K9gKHB3KisCrc7EimFo2HVlfWNRLpfSVgFjnme3wJRefpsXHVpcqImRmeNJokU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE5RcjRLcmZTRnVPYlhWbGZKeE5XOXphUjdicWRIZ1RPNy9TNkJuNU55QWxO?=
 =?utf-8?B?L1ZFRU52OWg2K2c2b3BIY0dpRjJlNGFQUk1kdmJ4WjNNaVVqeHdNRWFIcE1a?=
 =?utf-8?B?U2ZPcnhmdVB5WS9XZzB6d0F5eHg2SGlLS25TdFNKV0tneVJCeDJvYnJtb3Bp?=
 =?utf-8?B?My94R0xlVXh5dWpmRFlnOGF0S2pEWnZBVFRSN2xFNy81SXcyTmZLVWZwVll5?=
 =?utf-8?B?YW9qRlpGV2REbk5Hcjg3SklHZ0ZZMU1TcUZSaHNvTVRZQ1Q5dFhkZ3pJc0Mv?=
 =?utf-8?B?U0thMm9lYWdxU1A0bHlKbWRNOFozUjBDWVNjRXVIU0QrM3AyMnFJYnZsa0Vi?=
 =?utf-8?B?OHZvZkJvcDhoZE8xa0VSQ0pKOTR0UWxvTSswZ2tWbng5Q2tuVDFQY1BGNkNy?=
 =?utf-8?B?dDhzK1UwdHQwRWNUVTh0TlY5VmdsYkxWZ25XSFJmT05NdmVTaFYzQlh1NnlJ?=
 =?utf-8?B?ZkprSFhvUkFpM0xZTGwydGl4VEE1ZDdUL3hOVVYweG9FMG5UcjZWZTQwU0Yv?=
 =?utf-8?B?VzZLVy9MTlVGSDZnNFNUdmpEb1NUdHl1VDNTbFJBaTRxTFVpRWd6Tzk2cEh4?=
 =?utf-8?B?NzhhT0phL0NzZ1llTWFld1JzaWFKbFhFSmVtckdyNnZ1QXVMeWJsOW53SGdI?=
 =?utf-8?B?NzR4RjRIRjFCa1g4ODVYeDB2a01SU1hEcGdvakZIWjlmaTJrdzRNTTZ3UzNr?=
 =?utf-8?B?alQxZndKVWhLbEtDTUkyc3I0WU1FYlBQa2xuMENIWWJtMDRKUUplb1d5alE5?=
 =?utf-8?B?VzE2T1dpV1RrTlU3Z3grNzE2WEQ0anZWNmhFVHVyMWJQQm5XdFpVcnRHN2RJ?=
 =?utf-8?B?UVZjeDBmVTFYMTUxNS95cHF0UE1GVUljN0g1eGd0bW9nNy9GajhRMWN3UGRl?=
 =?utf-8?B?ZWk5dEdTaG9LcEZRUmxLK1U3QmFaWWQ0K1BpSFkvVXdmeFVZdkZ5YjJodXlP?=
 =?utf-8?B?ZndtTnh5QUgrOVMrTzRaV0JTR0piL2hYV25XRWY5L3Zyc1pNNDBleE5kWXph?=
 =?utf-8?B?SkNDVlpZT2tGSmFhdmlnaUExWExxREE2ZHNOaWNhd0tYdTI5dndMZGY3QnVk?=
 =?utf-8?B?NzdrMkFNQXFVcnBaZVRzUEUrNDNNZXpXUG1WOGxMbXRZb2k4UEx0N092eWpI?=
 =?utf-8?B?TUJNeTF1VURqRHBhdEtCKzN1UmZrSnNMbVEzOWRFQUhqb3lXNDRJdE9veHNn?=
 =?utf-8?B?azR2eDMvaXNkVElWRnJXZWR3cHlKM1lQQVlBL0xtdnlSRytzZjIzVWlmSkE3?=
 =?utf-8?B?N2pkc3hkNlNmNVhLSkJFNngzUTlxYzBxVFQzVDhJZzBlZ3U3TjM1SVhzb3FU?=
 =?utf-8?B?eUhIZ2llejdGMDAxU2R4R2hrOXU3V3F0K3ljcEc2ZTVreWVvWndOcVZsbm5C?=
 =?utf-8?B?bUViQjloYlg3cEwxK0pDSlMzN0pJWEdBOXI4c2ZKbXhMczJuZTYyTEJhVDFo?=
 =?utf-8?B?REl0eGxxQ3FzcjdQdkZlRHNXYURYOUFNL1RaYjM3WngrUnJ0alJkZkQvOWxx?=
 =?utf-8?B?UlltSWJOSCs4WEY5V1ZYLzJhZDUyZnpFM2taOS9MajNlOFpSZmFNamh1ZG1Z?=
 =?utf-8?B?U1dkWjZiNm9pU0sxSUp3SmkyMjVLOGY3c1ZYUjNqeTZKdjZTeG5xYUJGTVFP?=
 =?utf-8?B?eXZJTERScnFzVmdmZml4ZlEwZUIxNmJDVW1TUnhPNjdsTTMzMTc0WmdweXY3?=
 =?utf-8?B?S3VnbjdjcmtaSllGKzIwWGg0SU5ZcmZoMEMzS2QyUlhzbndvSXJGZlBrckxC?=
 =?utf-8?B?akhOOE9HU294MVJJbC9KSTJnWXZjVzgzbzRGTEZaS1pvMjc3dkZVS3g0eU9y?=
 =?utf-8?B?N1lyT1dFSlV0Snl3RzJmYk5NOW9WaGtIblllWWZabnZsK2FTdHQ3SUlGYnBj?=
 =?utf-8?B?NjFBUVhINjdLdWRxYmwzVFhuWGNhL2RsaVVJc1MyN3JaTVA4MFQ2SU9nWjZw?=
 =?utf-8?B?dHBaZElhYjdNbEhaVXpNUmhZWEw4OHFxQll1MVY5bE9UUVpqSnAwd2l5TlVL?=
 =?utf-8?B?ZFVieU95Yll5NkZUYkV0blphdjR4bkhYc1hsOUExdG5GYTQ2WDhIK1NvTm4v?=
 =?utf-8?B?aHBGdngyWU9YZ2ZPVWFBek1kSzNOcUtIQ2VMcHBKRk55b3pPRHA5dWhEYVh5?=
 =?utf-8?Q?hVZPNX5k6v9nFXtfEprRVHAru?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db023f7-b29d-495b-ceb3-08dc5adcd828
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:34.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/YX4gJWSvKUhKxBT3zn5cUsfo8KVMipiEsGlsptBcy4fMPeS3V32Y1ggamwxaRJrP639x5cunOqU8x65rhsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager(SM) firmware includes a SCMI vendor protocol, SCMI
MISC protocol which includes controls that are misc settings/actions that
must be exposed from the SM to agents. They are device specific and are
usually define to access bit fields in various mix block control modules,
IOMUX_GPR, and other General Purpose registers, Control Status Registers
owned by the SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig       |  10 ++
 drivers/firmware/arm_scmi/Makefile      |   1 +
 drivers/firmware/arm_scmi/imx-sm-misc.c | 305 ++++++++++++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h       |  17 ++
 4 files changed, 333 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 56d11c9d9f47..bfeae92f6420 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
 	  and BUTTON.
 
 	  This driver can also be built as a module.
+
+config IMX_SCMI_MISC_EXT
+	tristate "i.MX SCMI MISC EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System MISC control logic such as gpio expander
+	  wakeup
+
+	  This driver can also be built as a module.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 327687acf857..a23fde721222 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -12,6 +12,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx-sm-misc.c
new file mode 100644
index 000000000000..1b0ec2281518
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP MISC Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_misc_protocol_cmd {
+	SCMI_IMX_MISC_CTRL_SET	= 0x3,
+	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
+};
+
+struct scmi_imx_misc_info {
+	u32 version;
+	u32 nr_dev_ctrl;
+	u32 nr_brd_ctrl;
+	u32 nr_reason;
+};
+
+struct scmi_msg_imx_misc_protocol_attributes {
+	__le32 attributes;
+};
+
+#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31, 24))
+#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+#define BRD_CTRL_START_ID	BIT(15)
+
+struct scmi_imx_misc_ctrl_set_in {
+	__le32 id;
+	__le32 num;
+	__le32 value[MISC_MAX_VAL];
+};
+
+struct scmi_imx_misc_ctrl_notify_in {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_notify_payld {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_get_out {
+	__le32 num;
+	__le32 *val;
+};
+
+static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
+					struct scmi_imx_misc_info *mi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_misc_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		mi->nr_dev_ctrl = GET_DEV_CTRLS_NR(attr->attributes);
+		mi->nr_brd_ctrl = GET_BRD_CTRLS_NR(attr->attributes);
+		mi->nr_reason = GET_REASONS_NR(attr->attributes);
+		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM BRD CTRL: %d,NUM Reason: %d\n",
+			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_validate_id(const struct scmi_protocol_handle *ph,
+					  u32 ctrl_id)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+
+	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
+		return -EINVAL;
+	if (ctrl_id >= BRD_CTRL_START_ID + mi->nr_brd_ctrl)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
+				     u32 ctrl_id, u32 flags)
+{
+	struct scmi_imx_misc_ctrl_notify_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
+				      sizeof(*in), 0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->ctrl_id = cpu_to_le32(ctrl_id);
+	in->flags = cpu_to_le32(flags);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0);
+	if (ret)
+		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
+			evt_id, src_id, ret);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	return GENMASK(15, 0);
+}
+
+static void *
+scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, ktime_t timestamp,
+				      const void *payld, size_t payld_sz,
+				      void *report, u32 *src_id)
+{
+	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
+	struct scmi_imx_misc_ctrl_notify_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->ctrl_id = p->ctrl_id;
+	r->flags = p->flags;
+	*src_id = r->ctrl_id;
+	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
+		r->ctrl_id, r->flags);
+
+	return r;
+}
+
+static const struct scmi_event_ops scmi_imx_misc_event_ops = {
+	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
+	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
+	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
+};
+
+static const struct scmi_event scmi_imx_misc_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	}
+};
+
+static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_misc_event_ops,
+	.evts = scmi_imx_misc_events,
+	.num_events = ARRAY_SIZE(scmi_imx_misc_events),
+};
+
+static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_info *minfo;
+	u32 version;
+	int ret;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
+	if (!minfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_misc_attributes_get(ph, minfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, minfo, version);
+}
+
+static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 *num, u32 *val)
+{
+	struct scmi_imx_misc_ctrl_get_out *out;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(ctrl_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		*num = le32_to_cpu(out->num);
+		for (i = 0; i < *num && i < MISC_MAX_VAL; i++)
+			val[i] = le32_to_cpu(out->val[i]);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 num, u32 *val)
+{
+	struct scmi_imx_misc_ctrl_set_in *in;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	if (num > MISC_MAX_VAL)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->id = cpu_to_le32(ctrl_id);
+	in->num = cpu_to_le32(num);
+	for (i = 0; i < num; i++)
+		in->value[i] = cpu_to_le32(val[i]);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
+	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
+	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
+};
+
+static const struct scmi_protocol scmi_imx_misc = {
+	.id = SCMI_PROTOCOL_IMX_MISC,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_misc_protocol_init,
+	.ops = &scmi_imx_misc_proto_ops,
+	.events = &scmi_imx_misc_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+module_scmi_protocol(scmi_imx_misc);
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 90ce011a4429..a69bd4a20f0f 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -13,8 +13,14 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
+
 enum scmi_nxp_protocol {
 	SCMI_PROTOCOL_IMX_BBM = 0x81,
+	SCMI_PROTOCOL_IMX_MISC = 0x84,
 };
 
 struct scmi_imx_bbm_proto_ops {
@@ -42,4 +48,15 @@ struct scmi_imx_bbm_notif_report {
 	unsigned int		rtc_id;
 	unsigned int		rtc_evt;
 };
+
+struct scmi_imx_misc_ctrl_notify_report {
+	ktime_t			timestamp;
+	unsigned int		ctrl_id;
+	unsigned int		flags;
+};
+
+struct scmi_imx_misc_proto_ops {
+	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id, u32 num, u32 *val);
+	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id, u32 *num, u32 *val);
+};
 #endif

-- 
2.37.1


