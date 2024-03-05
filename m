Return-Path: <linux-kernel+bounces-92640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268A872348
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811621C23A66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F83128376;
	Tue,  5 Mar 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BH1OYFlz"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0391292E9;
	Tue,  5 Mar 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654123; cv=fail; b=trk8DQJFR6aWPnUW2KSZFMKKlFPQ3V3xEHv2BKGr0SrK1BfZqSiLXWCaoVhCntRPurOLedNP/gIK65eLV5pBtdvjwfbah/mgCODr10PLoNeFm4UVtPeXqCB+i+RrT+KPUmJ1+8makzE+Cj3nmkG+YP3yKJ3RXcZn0W2kpSHhx0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654123; c=relaxed/simple;
	bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F9vJNgbvsk9y+iC3zWUY4XRDBye+/gTckUn0KTfeOTKV1sIBeZTXQAAai9JNo9m8pQroo3puNZWB8MOb5156pfI4z/3XWEXhvayoaearTz2NkH2po5hAsE1iFlHUrYWoko7Rv1B+EfeUVCx9IaQ7j5LwKyU/TIi2ysyDAgCQBzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BH1OYFlz; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRE/TnY3N3bC5HcB5kHeiHCQKt8L7MOwB8FQ8S977d6wtq4phhwCa1CQ7gsGN7cSxSf3npjQnu2yjY2N8GNQ1SWQhCj4H9Buothvxr+ruL2JiKYvJVJJe+1fKR/bDuf6xLMrzBWKT6icx8T40a8wpff4r+bD1AGB6lOPxG2OC3zd9NxN0p12GS9RmKlFLugnlVpzeQEnJnXwIRqgoNoGTRpB9Oz27DJOBbiXA9UlO8mIlSj1b/H31Kxub7rla8wqsJV8oVc2xsM6hb9EYT4Tk1qAYP+U6M3IDB9O7OqyCvcB2/845QUgCSIkWndAD+HMz9IN8uBOAeB9vclb+BJY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=jlliERDoPs883niEqFPjkUWsdVgv5hsnn0sK1hLLsrkktNDdIVR8zlOqMOvx8sVIcKNywnL7nnNtbvV6LKrldQLyA1Z6M0U+ZssNAA5nFoE1odUdlkvBsPHAvhxox4PN/oWslhwN77jBLtwA5ZNa/CVM2lMq0VoAbljp2GP//7+MoUHNXmsKz+r2ZBNeiCNpGEdizRiOhoI5qAhcrjdFEv+gRfdNdzw6o//0gkrQvyRo0PLzmvYlRPgWIyCpqgNaqY/XVLXS457ryyexX87rX8wo/hARB1gT6qbGKHbn9VG8ptcdfODkPAysh3860Ia/jWadUgNrc032PK185VphwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=BH1OYFlzU/ycCcClSmvaTzfruPBBLpYvZ9vWnnJZdA6Cu66VV0z8rX9Mtkc3/SJRIiD7reapzrrQKLC7RMVieO/vidEdfrmEorNFis/P5MV+JuuUEAaZ97+DDAsbsMljkx5SNlE1EWMPC+amsYvEPICc/9I745VD0nNS6KnTsa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:55:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:55:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 10:54:57 -0500
Subject: [PATCH v3 3/4] arm64: dts: imx8dxl: update cm40 irq number
 informaiton
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-m4_lpuart-v3-3-592463ef1d22@nxp.com>
References: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
In-Reply-To: <20240305-m4_lpuart-v3-0-592463ef1d22@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709654104; l=974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
 b=rgIgyWlaYSVI2r2Dr4bXutrDON1w6cgpX6Ed1UPM0GGdV8DPDs7/MLQFsSwZesZHQDq1x9dPM
 HL51lrjXVuOClt5GAFC0u0Vy2y26wyeRt5SbjqNHeotA4DzEQ7cABhi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f31b73-e89d-47ba-8627-08dc3d2ca770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TYJRlTDJTC15CPw9X75OXCfZeAhAEMY7hopKU8F5bhFzbW+DPAy6O0VMTVws2rGnJm2ZSqyVhdO7ClIdEpj0S6Vtdd0CJFz6kEfMB9t3poWU+PzWKscfDZSVUCQfu9BPXeqsPD7KHKBcBfDMFATBsiCtT8CW/CoTRem7rOVz5a3G/0Lvi4RJfPWPvOu6B7ISlVA045lAkxYOlfedxqSqEDUE582LNtY6eQ6UhB+hwloWoQaNC0lTFWEqhagcr3nhzOIawPILfE3F9sAlTJKukk/071dqvIsJjOuJ3rFpcsVn4pwGkAgN/DznUg6lYx0hV5HVmNSJteDJi4a5noGQjPDy72clJBegYxJLuZZ0UOq0oJPIT+N7kenX6JNBYftmd7h50xz9oIXdhDh34Udpdvhr3hlSqgpjK6/VXXCr4WdFKSiWz6MXztGWsR76sla+GQqpD/wRdYmnjVQ60fuHLSbpAcbQ7swLiXEIa9MHQBRicLVXN8HDHTYdjOZ0Tkab99TQbnlLg4QzyU2ErtNUxwWDy5htETqFG+5M3hevhj7yHqrvJHPqVNPNdPhfxskfHp/i62yrxvnis6X30DW+2XculJvXWngzI/grrrRWccPNWhBqN+cvn3Ko4On5mUpOa6M3CphoLiYHd9doL/sm+FwYLZJWLLP1b1ggfEdZe/JScfjI8dRfterr/jt6jFXnlY3eVzmS2evsntvxZi76VNHq7AzQ0IJyEqlgO1j6YNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtnMDR2elQwUWU0dGNmcDlETFZxS3RQZEV4NjFDTkRFdmQ3R1ZFY2VJalFU?=
 =?utf-8?B?YUx2ZHRlZFp2WXN3bkxUZnpBak1tUUcxc0RLaWFJNXdkK044NEJVb3p6cDVC?=
 =?utf-8?B?QXU3V2pCY3RuYkhLZDlzNlgzTktkWkt0STltRlFzTlBlVDVsWG5uY3I1SUNZ?=
 =?utf-8?B?TFdCdDhzWEVFbUdmSHpBNVIzNkpZOHJYQ0JtM3ZoVnQ5dytaQmJTeHZiS0dt?=
 =?utf-8?B?TzNFQ0pPRk1Hc3NmTHhaWExrTEpISTdnMVltVDVObVNTWmh2OElIaHVjQWVN?=
 =?utf-8?B?RlZrdi8xQVpYT0dCT3MwVDZzeHV5RGpQUkpDYURBODZNWWVqLzgyTElMdStr?=
 =?utf-8?B?cjYrck9SVmNpM01MTU5XYVVBYVlyQjBZdU5adW1jSDNsZGR5TjZmTDVyUVdQ?=
 =?utf-8?B?b2wrN0pCVkp3VGJRZFVac2dQclNoYk1rRUJnM1lUQ1h1dlptYWFXNWRnWDF0?=
 =?utf-8?B?WFV1ZGVvOFdOcHNQSmRDOXFRS3B5MTlYZkNiVjdESUNEamc0S21xU1A2bmNX?=
 =?utf-8?B?WitHQ0hPRVFkTmRYQUN1ZU5aUFhUd2VPVEdZbzFWRW9tQ3ZCbGY3MGRoRWd0?=
 =?utf-8?B?Y3c0aW8wODZBRy8zejUvaXRSTytiVHVoUFNYRkgyZHhDbzRyS2t5MkRKaElF?=
 =?utf-8?B?WUNUN2dLNXc3ZmU0aDJMTU1jN0Nrc01PRVRzUW0zYy9tTjkrbk9iZEdDRVN4?=
 =?utf-8?B?OHZFMksyZ1NrWFpEZVBUalRjNGZMM09JRDhnbHdtTklsdUpYK0NROFJPcm16?=
 =?utf-8?B?ZzJCd3JKbkc1eXZManFBTnk5UlQrcmMzT0o4Y0YzRG9FOXorUlc4a05XTnM1?=
 =?utf-8?B?S0pleFZjNm1rcWJPL0FmUnRPeTVtUnE0b0J2blZjeDZNdENJYlY1L1VHL1M0?=
 =?utf-8?B?N1BoRzVSMFJacFQvZmkrbkJXUzZXbmZ1dThCR3RqLzdObngvSTExa1pMVWZL?=
 =?utf-8?B?OUNYZGJwUFlybkhZK3FqazVsdklMN0F5WWphcTk0L2p3QWsvd3p1aFJUTm91?=
 =?utf-8?B?RXQ5UmFYc1BmMVBjME85ck9OUnhMMDcvUTVSWnJIOGRqWW5JVHZyaHRlZndo?=
 =?utf-8?B?V0V5SGFWNmNJbGhMTUMrYm84MkFFWVdkMXR0RW1CdmwwVmFqcnprc1I3WnpU?=
 =?utf-8?B?RHQwNGRwNEhwcVVzVHhSNTVscEE3M3NoZkV0ZkI3TmN4YkRXUWljUW55V0JG?=
 =?utf-8?B?ck9CblpKYTNxSHhLVE5OTzRDaGtKZUZHRk9XTThEM2Zid0VGQXJwYlJNeUMy?=
 =?utf-8?B?dUpHeDNhOUMvbzdNdW1GLyt5T1ZPU2Qya0hSUjVXQlFnQXZNbi96NHBTVGVt?=
 =?utf-8?B?d2ZDMTF1RlRTRkthck1uazBUelZIWVh1eTBKbVFzU0ZDYUR3Y0lXOUV4UjBa?=
 =?utf-8?B?cGh6NEErUEhNL1ZQMzBWRDBFTWQ1YUJKQ09KTld4UWozU3VvUDFCTXlPd1d6?=
 =?utf-8?B?eUQ4MG1IeWsxUGx4NVRSSUNpSEp0TmxIQjdHd0NWNnpBd0VkdEFFcVZmK1BS?=
 =?utf-8?B?KzQ3NmFHRE1WbkRncWdBTEtYQ0crRVdNYTVqbk9FNi9YVVZRTStiRzRXRVZr?=
 =?utf-8?B?VWlydmdsWnRibEpES2dIdEpLSnRMYUQ4eWhUdVVwRWpCTXNDVXhoS1hqN3JN?=
 =?utf-8?B?T2ZzZThoc2Y1MFVPZ0xoN1p6bldTMDdoT1dxUnRsTTR0QXRMcncrMnRjRVVK?=
 =?utf-8?B?SHVtUkZHV0EzK0I5RnJXdTdjRU1GOWt4ZHNQZVl3Q3BTazVFT3dWeWhudWZY?=
 =?utf-8?B?OHcvV09nOGh6eEU0OCtlM1BHaDN6b2lrRlFMM0tvSzVPNlJ0R1dWSlI5cjhU?=
 =?utf-8?B?NkttbGJtWGRZYU5MMXpXTXZpNzhwZkJNQVdVMUlIRjVHelpRTlpNMEEyTTNI?=
 =?utf-8?B?T0RnNDhTWHdUR041OEMrN2U0TTBUNCtmZFdUOVllc0Q3ZFR6bWhjK0lPVVEz?=
 =?utf-8?B?Q2F4MnhaanRERmdkZFZUTExXWGJqcWpva21HcHFqZFYzSXhZakNRU1Nsb0ww?=
 =?utf-8?B?UWlHTzEyVStVTGlwR3Y0a21kcG5TQUhkS2pzOEhSayszalFCczEyRmNwOWhu?=
 =?utf-8?B?cWwwYWh5OHdMMzFhR0NhVW5nL1c5NWFJV3QxVXVGWTBycVc2bHRFODVoSFpD?=
 =?utf-8?Q?DrDpYa379ayrTOjKCjJW0T6h5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f31b73-e89d-47ba-8627-08dc3d2ca770
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:55:17.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbqHfkcYMjcsCsx2r6qP7xMIZ+nobZQdd7k5O01Cv1r7BN6GbroMyjXGxEU/hKbHZe9g+icGduRk8s1Pnm9fSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

Update cm40 irq number for imx8dxl chip.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 9d49c75a26222..b9d137d69f5a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -243,3 +243,14 @@ xtal24m: clock-xtal24m {
 #include "imx8dxl-ss-conn.dtsi"
 #include "imx8dxl-ss-lsio.dtsi"
 #include "imx8dxl-ss-ddr.dtsi"
+
+&cm40_intmux {
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+};

-- 
2.34.1


