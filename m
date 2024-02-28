Return-Path: <linux-kernel+bounces-85649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821C86B8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2799528585F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF715E5B2;
	Wed, 28 Feb 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sZVPlTk/"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112695E086;
	Wed, 28 Feb 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150139; cv=fail; b=f8XCjRluaWrlRNIt924npmH8sucmNAE497zi9dTVEp/PT4U0EVN3Fp85bqV+H6O+bZ/Wi3rckXf/cA7iMqbOwFehnyYGp7SRmQ5C0QyHVLACrP7dHSbrtRT2ervSm/xoUKWN8N+VK1cXmuePVIJbMY9c4wRx5GMhlPtUfJQUCPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150139; c=relaxed/simple;
	bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UXYhapm1uFMUK6UnM1EWO6BralJy2rmNwGIUr4f2jf2JCKMbO0UGcDvjR5kShDpNgEeZky8BKMRMCYxFzVZCMVaz7ePrXwiVK287IvsWNKFynTgIBjyYJvZE4fJTIGxrmTQ9dla1musPFrs/Q6EfiI8NU/EPZjIxCps3IdeINyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sZVPlTk/; arc=fail smtp.client-ip=40.107.13.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQOfDMyhjwwBtACLIruKpwICf3MTYa5eo40ABzC6eLtfwqcUwfz94FUayoO5CooI87wAKQ4waCxfXGVAXNmrN28Hmmgbin4/larc9tGJu98c17yQ9Z1vVHoRT8MyiHpZoRvABZk5fwI3zfD7zdqZmnhGJq0TMPWYs8Bafuv6t9VZlj2zHN3i/spqTlRBOb9DeWt1q75KUpV2UVcjoQLH3DjyitdH9aJZ42HcNO/ZYlW51XAYLPK5wmcNbduWtZguFv22eKLX8m45flwtf3UCj+F02bFlzOzCrp7D1P1zwwNJ/BHqbIMaYOFNvDZNw0T/f9BYF4XIMTNuatFMVGL/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=eEDtTNanJ2gzujh6hc6g3r2HzjHcocC8qYWho3+c95d4VBqbxKl4h2DMvxmFM9dps4XqUCzHF83Whdw0OWm9ovHISz7EzvzTZBrq4G1hOHNnpgqE5SGfiEvH5pt0Jk7S1vVwXwK6lzkHm9mBMOuSCSDfLUqJ/Pr7l9MATPoYnOMbc7DiPjMer965GRFDurmUkdlHjFlCCV3K3zJJZjw1Wr+C+qd7VhIum+Ixt+rwye46KFKAW/yZPSizMFuESjqXBfA0OH18bwg/fIIu7XRrWQ+Z/esjN3eZe2Ql/GL3znaIWx4Q6IgGXc7JWf1DnWd20NKlemQWWsrW6EyLyUcoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=sZVPlTk/BLnLFrAuPWl+4ChtoRF60PttwKzkCQtL6G0AEUYF5sN/t/WNci9H62wJZz2oampb6fz1/wbb7uTjyAL1s0pinqURlWAHTRySiG/Cj3gEwBYVJmECoTOYJqI7FjEfOOAi4YuRK+xE4R3RoySe2byHTfzTe4CLUKKN2zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 28 Feb
 2024 19:55:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:55:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:54:59 -0500
Subject: [PATCH 3/4] arm64: dts: imx8dxl: update cm40 irq number
 informaiton
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-m4_lpuart-v1-3-9e6947be15e7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709150122; l=974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
 b=YpOh4n/SMRafQoBS/Qut79OQ2XMKXpyQUXg9U8dBr9UFssa+Lf0XBPhbHVjXGwoIep6iWUYMp
 KCSwxtIlZYyAqdcz0B8rpLp+BJpkXu43JuJCjn1UPe5xKUbWYxdbHQP
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
X-MS-Office365-Filtering-Correlation-Id: bfb35d95-23c6-4d46-4f77-08dc38973ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0+Qaa/xc2rm45qV24alITSz5/tTclrCEKn8LX9IZ1WtoFf2sEEygx4xx5bzMh04lK4OjMV616zbmz5GlUz3ncmWONP10Io8RilQlokdUGG2z1Eq3n+z62BjVFTwnIfrPvASRIdHCXPeD+208lKXSBKEjSzkWpG3Xun7PPDA55KYM4w+wbGTdiAURzU5l7KkybCCABM9jd2t9TmXhlwRLKT8Tg6SmKEhZnUPPU675IMF+C25qnw3R7H1tK86bP8adYkB3sT0HcpCQL2U6h2uYaQuPwa1f7xSVLM59aQzMk5E2vj3qqmWrq09GpIUjjCxg0gDcXRaKabz+7Vavklw0eDxga3pbcJPECL55nED4Q6cFqJ6oNbaxan+szDm6DsLzrVpvb5m/SzF78GegJxuT6dxdIfQI34G0uSUKyijC6JnQq074UpJxABvkEn1zlOyFkjRzllX/Eug8oQCrQ5X7+CPYK5Awt8tLT3J+GNyRqwNvdcpPbjkYdg9A2OmdV7lQdaf4+mXoADdS5enxXG1zVnxYXeWjgWZdtZKK2ErCVyVUpjwaHwGnj4MDqlF2qUX2CJWHE4S4fk2/elc8UGha17gwPfmxHDRrcbACJeQy0DqSvLBZErDk4p3QfCgd/W10J7feN/E/aLIDjxs6EKEb59HRv9wx/Gx1NiVqdV3HBh8k1k2OtyynGhRACoFLqva/UkmU76+C4PAKRmLTIE2Ofiqw/1H6RKjTmMp/7kDtr8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDE3ZU1Gb2tPczlWQ0xQY1JlREpBTTBrMjNIYlB2N3N4Y2RXbzkrWTdjTGE2?=
 =?utf-8?B?UG02ZVBjQXp4Qzkzako0dzV6OFVmcVRPTTlJYnB3TFZyWmdzMWxxa3VScEZz?=
 =?utf-8?B?RFFkN0J6Ym5IWHFOVWVLUlVKUnhta0R4bms0Ti80YmN4Q0ZtdXozVlppZG5l?=
 =?utf-8?B?YmEzRDdkTWRrTWZIYnpUYnYrVEFVMEh6a1BsUWxwa1lUMnpwMjBDOFJJU0Zi?=
 =?utf-8?B?amQzSnI1MWxiRlNCOTFiYlBrOTVLQVZqOXVoai9IUkw2d2hzRXlRdUk2NFdF?=
 =?utf-8?B?VWpiTGtBYXl6Z0ltV0Y1eURMWDNUSk8vSllia3M5d3FnNVh6R242eFpUZVlK?=
 =?utf-8?B?Ty9VQXdubTZUUWZWNlhpQkdLY1dSUjE2Z3g1Y1dkLzBLS1hnaVliUW02OFBQ?=
 =?utf-8?B?V1h0VURTNU9wZ09vWkJyQ1JHS1Rock1CUzlHSEFZaXdnenNRVHlwSDkzK2NG?=
 =?utf-8?B?ZDFsLzdIYk1aSXl0M1F5SWppUStkYllLTWk0aEN2VkhBNHI4L3FCVVBCcXQw?=
 =?utf-8?B?enVyNXZOYmYydkR5TE5JRCsrTUlPS29TV0J1RVVvY1BmNVJXNFFMMGhaZnY5?=
 =?utf-8?B?SEU5Q1MvWE16dGQvY3R3UkUvUGpkdTI2TFh6NUJwU2FvUExHM0tZV2ROWlh1?=
 =?utf-8?B?eHhRNXVDNXZaUEZ6UVlMaXdaaGQ3dzlBbjhZK21pdjl3bEVoaHNMYjhWazNB?=
 =?utf-8?B?cXdIOW56aFdDcTJERHpWMFhUMnFqZVFablJURlVtMkhYMUZTbFdqYWlHbGc1?=
 =?utf-8?B?Z0NReUZnd3NZaE5tQllNYkpBRkh1N0g4RTVmQXhwOEpHMmRZU2FRN3BjR09x?=
 =?utf-8?B?TXdPRXc4V1JOeWR4dUd0cVd3MkxScGNvc2J3c1NNRnRoRDI3UEJhRG9TeXRR?=
 =?utf-8?B?ODR0VWFVQi9pQkhNWUE3YTNwdENxR1JYTlg0Ny9iTFZGNW1RZ1JmVnhkWFhi?=
 =?utf-8?B?WGF3WlhGeVBxOGJOWUI0U3dDbzByL2FHYnJpSmVsa0syU3RoUWQxbk5ERm9z?=
 =?utf-8?B?YXJqK2pmUkFROHJHdEhoRHVzWFVISnZVQUdaYm9Lc3FiaXgxV1dmbU9PSjBV?=
 =?utf-8?B?dmFTcFhOR2tyRjQwT0NPWjFZQmw5eXZkOEVGcFVjNFlYSmpGb0lkNzRkZUtq?=
 =?utf-8?B?TUFDQVE0MmdvQW1BM0pxam9tZmprUlJpRUtwZlV1SHA4SEhKODJ4c1huR29q?=
 =?utf-8?B?dXBlRGptYmJORVh4SWpVcWJ0UjJXeDFXaFdPYTdwUXErWVNJNVQ5RG1vMkFQ?=
 =?utf-8?B?WExqQUhaODd4eHVJRUNUSkdiVXpkd0Y5MlVOcE56N3lXWEszclJHWWZwQjBG?=
 =?utf-8?B?RVVJMU9TaFRQek9qVVNrMGZwTG9FNm5qSFdJNVZPdjhPZXJxZFgvTURJL3RB?=
 =?utf-8?B?N20xVWd1LzQvSlk3NkhLN0V0QnhXL2FlTXZ4YlhQMXBrL29xM3dZTHljNnRk?=
 =?utf-8?B?N1lzRDdZaFROTDcrdzlXMEtTREVNeGhyV2hvN3BpTlpocW5IRFNjdXNHMVFh?=
 =?utf-8?B?VHNXVEhQZnJkbHRXUktCbVVQSGRLZW1NTmZNaHJYeGN6bzBzMnkzNXVuMXB2?=
 =?utf-8?B?OGppUWxJUTRYdElOeHp5RWJ6dGhmZVlhRlJFc2FMOFdKT2dwZjBISnJ5UTNH?=
 =?utf-8?B?cm5vai9jeE53RGZaWW9aMXppWjdlbUFCOXVzOTdtYlc5UFZqeHg2STl5YTNJ?=
 =?utf-8?B?MThHZlhPMXdBLytZN0EyQTIvMTRBQVdOT0JieENSUzV5TXJLSzFVYkJjMXlC?=
 =?utf-8?B?M2Y3eVVFUzJ4Ym11UmhoNGVjanc3RVRlU3lNa3F2MnJLRmUzbVpPblA3Qmox?=
 =?utf-8?B?cFg4cm03a05tNTNLR0RTMVpyYjBYdk9YZytodjlhNFNrYUkrWVNMcWJsMDBQ?=
 =?utf-8?B?Z3llV3pnL25wam5IcjV5ZEdkYUU1SXZ6eituZVo1MnByTEJkc2pNbDc3Z0Fy?=
 =?utf-8?B?bHN5Nkd6cFFzWkJNOS9XZjladFRVU3RoeCszYWJ1VVRkK0hMV252OVVUYWJr?=
 =?utf-8?B?NUV6MmwzL2cwOHNWOXpvL2hNSVlJN0dTQS9xUUQxNGpZaDRYRWZkQWNQUWF5?=
 =?utf-8?B?Nk55eFVZbno2ZW9TeURGR0FYTlNsRzlFWk9CRWtPL3diNndzNEc5aGdHVVNJ?=
 =?utf-8?Q?iyggNc4CkBLFIJJ0gl99On9hE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb35d95-23c6-4d46-4f77-08dc38973ad1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:55:35.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkvz5gpEiGD9ELsVF8+ifHG3QhVb6nQ3newj5du/5zTq/7eCpuVqV8bJK40/V+qpIkPFnc+dtrsFIxoLUIg0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732

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


