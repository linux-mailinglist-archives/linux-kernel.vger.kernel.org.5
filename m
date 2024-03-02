Return-Path: <linux-kernel+bounces-89506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C986F14F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B2EB20EC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FA2BB00;
	Sat,  2 Mar 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="keCRlk+n"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD124A11;
	Sat,  2 Mar 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396902; cv=fail; b=eFCFTD2qAlMnAN/hfcVY6uiX1esdinXDAHqlJfodTfLBRK/qRwuf9lN/ttESx65EbcT2iraPZDnklHOxgxCNArX0cb7Gkg3TBHbMwjMIlvz5GWBJEe/0hn2fChEP3Iou5smKdhWeOGwqMw+TjyvYEpI0hh02EYaroG2tsJzED58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396902; c=relaxed/simple;
	bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D6lNf20RZsTOjJU8Ff30ZV1/YIVWHcE4JwBiVkx14ZxMkf8I/I5xedpvowBpxwU1NcvUJFPEIJAW/eLE8UTXMl2gz4CAmNmjRETpSGh6Q7HEFG2SYofpOaeUwlLhYpOaZJ0hEMCIxH3b641tBVIvjswABboYvxsE3/5Bl8hEA9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=keCRlk+n; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIqc/XzETAwSEk8MK/Ojuw7cRiq3S2wjE3dHUF50pnnrsjBijokEvNI8MvzqgFeHYqIOJMw3oKk3zkyX6VLpqUUZ0PrjGCzsxSkPrqFT5MXn0r+cpinB0J1QwM5UgbZy/vlANhIc/m4ZEZTyfaByzd+DAp5VVNPN5wHlGS5vdBywy3DR4mBo1Xf1VSJgCNiDqDJBLUtndR+LMsuxkd5S6AU8vRGFlGM67hJTo8p8g7QKD1XxPNYNwiW/4UE7h/fL3QNU2kM/Llxf7OzuRPGk6ojG1ZbfFOmk9IDkIbEL/k4f0i/EvLeXt8iJTXE0t+TSq/wuiEEAIlHfaXWIJnAFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=PAfK53vCbDe48LM1sPagw1/fRbFmpbKwCh6cLBVGB2idrB6thGukAapmTcB19TxsP/ZsjAlWU3cS8uQ1Hq9l8qnpr3HixLXbt58S43xr1dyPKCYSSKlNjFmtWEw15+MkqyXvgNbLELp90AOoayzE5ObCAS9nHJpaN3lvoKx2C4qAyw8soVr6dEWUJ3LXnejWPUtrQHUg8fj089fmkN63u5hifLQcoxeEOX/qqp1IMajsh+XRgI50a11RGVJEZJ0A49P75vwrYVXSjcI95HXvwhpgB8+XuRLaisx+vNl2tzq5xGE4ldOuc+rs6DZ0OfNj31aGDWMgUDoTu04umX6WjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAf0wXPMiy5mNWdTYpNC6OPlTOZOVg75scNFCY/e9qo=;
 b=keCRlk+nYMQXQnb0U74lUsBo/ED4jUxnjOS3GRZl5wSSpvCdeXuBVaPBgGmg/fccSjIS5zCUEh5QTgX92vzGCbI5avNGPnRnJNHI4eRK+IIXrfer7Gk2L+PP76OsJ1Ry8bSiKVSZYPWEhL0Y5xwbhSA/gV2UOeubJ/md1hXqX2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Sat, 2 Mar
 2024 16:28:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:28:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 02 Mar 2024 11:27:46 -0500
Subject: [PATCH v2 3/4] arm64: dts: imx8dxl: update cm40 irq number
 informaiton
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-m4_lpuart-v2-3-89a5952043b6@nxp.com>
References: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
In-Reply-To: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709396885; l=974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HsPZsfvL53LQj2LlNsdi6HvujavaH3qXxrsezOkfNn8=;
 b=QYrpa1EEiRImUvgBEa7wst/EQp+rH2zmO/LaB9lQDKps+gsCmTl+Wjs+qeqLw7jBx5pSn7CRS
 u4SGaEgxuGoBbNIFT1C6r50fLqJ+OqFJO3JzxhwNiT0RKaYtx49z8Si
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 117984a6-0caf-4228-7ec3-08dc3ad5c4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kALspXHtRrT2LbFUfBH7yLlx3PQVoeNjTLqnJDu9L9sgVWYULduq6uNmo1W6ueU+SE01DtUvGB/CkYqZK2tEgHW358UIi+sNyboAvsjPCCasttNvbjqsNuRIX8lUIKdesQnYDhSFdmFMN3dQODTKAJIRlQT+/NDdmz1Wn2LVGoni35/+pDBc0al1q30Yvj+RXt14Lk7AZsNW0+g3AOf2BSg+Awvuj1LyIpAdcMeaK3+/5ugvqo5m/Us51s2ADf2CdTAhDIQJpYgdXeK9+NTU7IwRbezIj7KHGEpAU9nHIckdydqf90OYwJhXzCdk+Kj5XxCixcTGfns7vZNZuh2vDmhkgoe0sAEUkj8cL3XL/LiVrPLgMGGytl6yKlDtQZ7/0Ba7ly44r8wwVSX8h2dPqPpHUxcCCe/Sx3simwb7TdkKGxKqW0zjkhSQt4DXu7cCMNhn4NuRmp6/75tq8brJvnlY//Ggsl8Nkjx4ocqGLoYu7MG1nBqMgA1MsSI02acXtM0sExNkUOdWXERny8lu/dQLtexzIPYQankVdjdmFIAfvidUYN1YFpFtx4NO5uegMqYJvrjkkdrQPTJvKamIbyVEm8+ibPgx6zgeKgh6IZrhS8llTqqwIelg2d8s3jeirwZoANXuO87VNs8srhAe8XEuirK1tArQsbT2LxeP5D3h0cA5R9mwvA009VDvnyUl6x4jUlTMDr1b+kbPsei5tGoMj5hAKD9FN21+vh6nZ+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjJEd21BS2N6YXF1NEQ1Vkc4cVFwVzg5VVVMRGZyMnB1TWxwL3FQZzZjeDNX?=
 =?utf-8?B?VFUwcm8rNy8yYndRcXZ6TzlBbWY3NVcyMUpaNXd0b3dlSVh6YlRhWEVHRHdM?=
 =?utf-8?B?YkdHV095Y1YxdVR3SzBHRjUyUlkxN00za3FNWTMvaVBIVGR0Zm5YdFE4cmNs?=
 =?utf-8?B?MEM2cUR4aTY3Zk5yQ3cwa1FRSUhUaUZ4S1BuNDljUm4wejlNMk9yU2M3UXVw?=
 =?utf-8?B?N053ZmNzU3lOMkhYZTFWUUxjd25iNGw0cE13OXhaWlJHdUNIcStVSzQvOHc5?=
 =?utf-8?B?aEZvdm5hdTVlRXVoS2piekhWajkxK2Jza21BeEhUdzBkWXRQSENXRFFhRC9Q?=
 =?utf-8?B?dW5CUVY5WUdDckJub3EyM2phcThRbURkdno4Ujk5TXBCUDNvd3I1TGxoa2Fa?=
 =?utf-8?B?S0s1Q1NSTHRjanp2c1JSQ0RFMGx1Y3VHd1Q1WEdFSmJUQzFvMjU0dnBaWW9T?=
 =?utf-8?B?WWRXQTIrb01BREV4TUNrcm5oaXZ0M1FaUVRRWVJ0eVIrSXk0dE03UDhuVzY2?=
 =?utf-8?B?RVR6RlMvRE81cW5JWkNYNTcvaG4xZVBiTXNzN1NHSThWZ1ZZOFJmVmV0OWlN?=
 =?utf-8?B?SHJXTXN5TjVhYks2WjgxdEZKU3ZoeVlPVlhiMVdCTStuZmpHbXdqU0l6WHow?=
 =?utf-8?B?TGx3Uk9TUGRlazQ4S1dvZ1ZtQUtadFlwMW4ybUU0UElocGRGdHNyOUlmWUpV?=
 =?utf-8?B?RXlBZHkzKzlKK2ZlYTFiWW43U3dGYkRmMHd5UjFyWHFXUkV1YmlqUGVlenJT?=
 =?utf-8?B?Lyt0VDllalh2TW5OUExoUlhBK1FqUmdDU1AzQUlpTXJFd1JqcC9STHNob0lF?=
 =?utf-8?B?a1lidHl5WkR2aitoNTZBaUxDeHdZTFJnT2ZTZEJpQ1RRaG1GZTdORGxwdnpu?=
 =?utf-8?B?TzV3L1Q4RFNldWFRcXJXRnZOQTJ1NCtMWTZhUjBLYjREVzRwR2FHNFUvMk83?=
 =?utf-8?B?T09KK0R1OHBEMTkydkJETDFaSFBqWlN2OFhOdGNJeFBkS1VldEZ4TVlBb1g5?=
 =?utf-8?B?dnhOeG9xMGcwMXJIZ0NpUG1HbnNSOUhrS0FRcWdYOUg3WTBVR2YxMGtiR3U5?=
 =?utf-8?B?ZXlVek9sKzkwWGlNVDY2c3BjY2VmU0hVWHp1akR0ZjNWS1lwQ0psZ0xGcU5x?=
 =?utf-8?B?cXZ0c3FPU3UycUFBSW1MZEdaSnpVM1B5RFhEcVN0Rm05Q3J4WEZjMFlvWkw0?=
 =?utf-8?B?OWZEbnhsM1l0M3dBQkExVmloNXBoREszK0tjZGZQbUc4SHNRODNIUVVTL0lZ?=
 =?utf-8?B?UzBqVzMwTGp5V3lFVm5PVmpyc3RqTTdmU25Wak01YmdJYytXODRtZEhKUnRy?=
 =?utf-8?B?VFRyS00zQzY3TytuV2VJbGlSY0h4Nmk5ZWRYd3lTaG9LMjBpSFViQTlVcDNY?=
 =?utf-8?B?Yjg2ZFhTUXhuRlBTQXB1SWw0SzBmZDFrb3dMVFhTbjhVQ3loRnhMTWdrTnlQ?=
 =?utf-8?B?Mk1VYVgyaFRCNkkyYk5GejJRdG0xbW5xSlBoNGczMGF6WHZKeU83WkdMWTZ5?=
 =?utf-8?B?TUdRRUhDOWRzNmFIUko3Wm5HajBOcTVOU29rcStQQWNFUWZIMU41NWpuRG1U?=
 =?utf-8?B?dGNkbUhQTzJTVGRvM3AvYTBGMDAwQWkzd0Y5Z3YyZ3o5bkdJcnlxM1N2VGhI?=
 =?utf-8?B?UkpoRnRZTDFsNGhMYXlOTEpOV0lhK09waXA0TmZWN2dIOXQ2eHgyMTdBMENq?=
 =?utf-8?B?RnZBbE52SFdjRGpyU091QU5aSXFrYkMyTmxsZnJIcTVadXQ4RklTT0RuQUds?=
 =?utf-8?B?QjRNZXV3UWVvTTQ1WnNoL28zN1pEUHhseEttVS9yNGRMUVh2RW1tS1BWdTh3?=
 =?utf-8?B?UjdpZlRBeWhlVVJjbVowV0J1dks1VUtWbVVrOStZU3BYMWJ1TWVuV1NKRXM2?=
 =?utf-8?B?VGhlSTRzMDgyOTdTNGlEQWxNNG5nRzlRTUY1dVJydlhUYUNEOFBKSENyZkxx?=
 =?utf-8?B?SlQzQ1M0dHJKZFBSMXBrZmNoM1YzSmErQ1ZjYnplVk5WanhzWjNkeUNEUVhq?=
 =?utf-8?B?Q005SzUvV0hYcmtZRDVLQ1ZVMzBxYVFZSitFTE12cjNENjJOaWRlTi9NQ0sy?=
 =?utf-8?B?MGV2bHFnbDhhU0U4ZHV1Smg1cVRjd3JpZGNSTTBsNlY4NVgyc1NTaXdLVEZx?=
 =?utf-8?Q?t2vI6AGzfTWnbgOGElS4gjHFA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117984a6-0caf-4228-7ec3-08dc3ad5c4de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:28:18.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjOe6JW0gwjbBMoFQO27VgO/Zhg9eGC0xH1i6GbwIoFuJKfytGqylV+Cms5jKrx34zJh71zfkr+ZADPmh0a84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385

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


