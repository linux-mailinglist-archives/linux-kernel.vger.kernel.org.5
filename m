Return-Path: <linux-kernel+bounces-127128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35E894744
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119B528257E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE7B5788F;
	Mon,  1 Apr 2024 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZgiGF49"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2133.outbound.protection.outlook.com [40.107.14.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369857323;
	Mon,  1 Apr 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010352; cv=fail; b=Eh14bzUCTjptmT9J+IaXzWeJdBmbR24p4T7J+EBa9A6cTWAeKyqKeDz9z9fH5EIxy6IsGS6WCh1sLxP1faEM3z97uD8Uoj79WdHdJk+nwbFSONhnnErNGwInE9GA2X7DrKyeI6JPM0TL6UL8NISB/hraXq7nXxFVRRFzXMyiX6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010352; c=relaxed/simple;
	bh=UihqGtMDMPc/QTYsaIIsW7589SZYMUiu0ZudQvYpP9Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rfguldNciMQXqyJyakwIr5BkBre+4AnkGBJcpTiPCOPPuWvUzOSk9AMdoSftK7nsHZ4kNssqallAHPITcL+t/oafMnt9QQ8Umxq6Y6HEbQwGx9Dk8yjdCa/iOuNnXVSLeV3gCn4cxd4AU1WPFx0yzg+W/stqDe2/B4iAqND14GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZgiGF49; arc=fail smtp.client-ip=40.107.14.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDgGdRn1HMsiTTTj8E7OdH7Riulkvzgt5gZGRR7+qUztA8w4Cfar1GoC5IG3UGope/GEZ4RnpdggEBT/LQsrQ6X3WsX/ZCRiE8XJmfPi7RPnFZzRbarGxOwldDcTm+LnsIcPFWu2xWZb1UgP4bu/zAtmYxR168D/bCCK9JwEK2/Z89K8K0qMuU7lQ5sauMt4fH+1m6D78y7LbyEs/msvaDee+hSd16JxzE/DbVsSe8G4ZgfrBJMFqcrH7n2WusZ5LFWcBOGk+3WZc7k81LLhIIV4ixPANCDiIQnCg09s8J4NgtLiT7Py9e9yOCm00o9I490GV3nbHzXiWfqnXQ508w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMwZ5jtaKe4vgTwB20lnrfZVoLaEbOpy3ozujeu8LN8=;
 b=HzWbv+IxVAGXBSe+BRCWgrNGAGUjy5sW1UY9f2+F8v7OM8zbWRwseUfsrOsQvoGraBu9si7rq+jDI54MhD16w8s+dCyrJUA0uf4sQ/nPEUWazj6130mWMobnB6VOhPnVJLggIB1/E80xyleL3ErrkZLIheu4anhOCU7+RWJfWfkrZQ1w0V2fBavNmd5jOcm2yP+hsODs8L5f2OEI6prcUySCS6NXoodGv6y5JSwaYJSb8AwlqyNfJzK4MQotq+DZUGpPj9DevYCJMaBxc9srsQXUWjO5Q7f0fQjLGYRIrDt8foObyCFBku0a7xqGhJWkb92KdQ1WfzB1M9exf9v1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMwZ5jtaKe4vgTwB20lnrfZVoLaEbOpy3ozujeu8LN8=;
 b=VZgiGF49QJospzQ3B9wOfnk1eYSVPUX1jsbh67910X+5wWOERer3T4Xlvsm14NOYWNgR38EMpGyQjO4RpncOZgQnsNoPGYVpyR/PtW5aMHZupGw1nECYCP2zORzQSsfnT8cyfFZUD9uCDegI4cP29u1aKgu9t/YzvOY4UFJG54c=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 22:25:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 22:25:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Apr 2024 18:25:05 -0400
Subject: [PATCH 3/7] arm64: dts: imx8-ss-dma: fix spi lpcg indices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-dts_fix-v1-3-8c51ce52d411@nxp.com>
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
In-Reply-To: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712010330; l=2937;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UihqGtMDMPc/QTYsaIIsW7589SZYMUiu0ZudQvYpP9Q=;
 b=gt32yUq15b5dZZW4A18ogLVWndfXVLzqvL0434OACcLvL8QQ16zyuS2OinnKwVnlzTOqoE2r0
 o0qr1iXHPHxC/740w4QeGwg9i/7uiOfS+XNv4jEyczqLirZYF4IXe7c
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 Faz9Tg+pZUa1ApB9TZaUOG5eVzRimxAtVPrRL0sdLDi0qBlvwd4OxFg7+ADe5kcJ9eXWlTUX4PColdpsYtFN0AhG5Mkz/4Lk39YlFV1xe/uErqdTt6sbqq6a7VvOpFea/XZOPuyrpim8fv6U+oUTDyc/Qa2q72nwENsmwj0dQxn3CXikweL3CspdfmQb2sWsFDoIVKzS6nw+Bi2ObewWkwoMuPadigZbAawW8HqgYIVhfl6olv0sIigKNhjisQdabCP3pSu0XvgY2fTobkBApXj+EkFVtrUxP+mOoXXNF1FGqXKmx9uOctb/lLFyJkcn+xY7UHxvPWwn2F1lo3wpmFSX+xgxrQi0x68BpMW6x6kwEFCNvGEg/hURifIf0jaH9NQCi/wQGimAlqZc1sBHi0b0ZixeqHgg4IW1FOOVZ3JqwH8kFtE4ZJyAtIDbBgRzANYPJEc9l45zRwulZ3p+i2CbujQtY5t/rWtW/W/GGlrb6mL6ccLpbVTcaoBkpkYrtgzrom/2y56o07BXjGDL9ETw5zg5o2CvaOg5EACLnU+tp7f/kD2BBiuDdscLS3kOESHThf3Jl/PaSA6S/tbwsBFBm7nrYvZB/2n7UxR2oTYfaWeX7HXSb2O1SQJ85s1XX9RXTmCF4Jn+kU1DNRwfHHgKa4gjWgkXrTyw6oRLcZ+EXAhO3HzHAJ7ilduIy6marVyKcZsO3XSN8Rjv+feoV3MTtu1GzneLeJ6lF+wC0mM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Qkk2M0hKL1I4NDdCQlBVSksyaFBOT29WemlTM0xGdklWdlNqcFlPTFZ5d3Rq?=
 =?utf-8?B?VTV1aDN5ZTBqRHNrSWxXL0J5R01RZ1NmSDFneDQ5bkNyUmR1NlROK3JlV0FL?=
 =?utf-8?B?Vk5KaUZuWjA5WjFSZkw3aEdhMUhNS1pyVzl5WGxnSDU0ZFVwRXZDL1Y3WHVF?=
 =?utf-8?B?UmRxb2dPTVpTeGtkL05HMW4rY2E5bzRWWEFsQUtrc1hpbmJBbXZYbDZENFdS?=
 =?utf-8?B?Mlc1REVPZ2czMVc0TUhWNXRQd0xvVVI4VjRSTjc2ZnV3WnZaSXJSU1FleWJY?=
 =?utf-8?B?NWhObGVQQkcrNGthT0pWVFFBd25OdzZjYjhKMjFDdjdTMDVJU29PNXZ0QXo5?=
 =?utf-8?B?MUtwdU9SR05LRGpvOUkwUVRHN0FjYWI3MS94cjlPUVY4MThzaUo5ckhRN0xU?=
 =?utf-8?B?OXZsT3lmbi9Ycmt2cEVKb2xncEFtNHd0YUNUdXo0dFBzWGtuMGU5L2ZKMTg4?=
 =?utf-8?B?QWhPeUJOMTl1KzEzaC9DYTlvcW5SNHY2Z0htTG5KNGtrL1A4VXNYL2NRZDYz?=
 =?utf-8?B?NDJrQjhEMlVmaHFhNzE3alJmQlV6Zll1SmJEeXlKcE5XSlNhR0tEN2ZpWFZG?=
 =?utf-8?B?Mkp5SGJWQTFRc1RrT2Vjc1hnbk9pYmdKcXFoUzV5L3NhTTljQW9ITmJpZHJh?=
 =?utf-8?B?Z3l1Nm1mOGt0dzFNdUU5TSt6amtORHNXNWxUUDk2c3hXMi8xZGNQaVMvd3cz?=
 =?utf-8?B?TjYrcFRvQWxsSDFNK0dodHptbEtheTZ5dWNUN2llSzdmM05OMmgrOHI1UmFU?=
 =?utf-8?B?U2F3cjl2NE5OaUFWWS9wSjBhODI5ci9oRDBHY1dObVE3MGlkY01hYWFVQ3JV?=
 =?utf-8?B?MnZPa05VSHRSZ2ZwdmNFL2E3T2VjVlROMkVPNUVMdjNXc1hqaGpSYW1LNloz?=
 =?utf-8?B?blQ5K0diNTZHa2tvbnZBTkNyM0dtOE9vNTZqTXdmdzdZZzU1L3dCSlBWL2Fq?=
 =?utf-8?B?TFBMS3V2WGNybnFGbXl5dWI2dmkvQW5ja3BxMGlxZUh5RTM1RTc4SlVPUEsx?=
 =?utf-8?B?VHEyYnIxWTViSVRCNDN6OXBZWDZ0bVdIWFo5R0VSMVJ6OFN2eDR4QjdFQWV5?=
 =?utf-8?B?L1ZKV3FMYUZNVlZyNWdmTzNDTUppSklXZjdJU0hPckg1cmtlL2E2TEVRWjRi?=
 =?utf-8?B?TnR3RUxPSXpYVDBGejR3RytmMHlkY3lacDk1Q3FtSHJIVDNrNjdvTGNSRWVN?=
 =?utf-8?B?MmxMNUZTMG1JbHlQMUkvZWNDOTVtQko1ejZ2VFJmTFBjdDVSeUN0dGpmcHZp?=
 =?utf-8?B?bHRqSjlwaTBuVitDVDFOWmlGWlhYZHBtZXNvcnJweHRjSGNYL2JQQ2FkTTl4?=
 =?utf-8?B?Mjd0MXBHRUVFWGU5Nk83T1RqWnZFSmxtekpXUWhuaFdkQVIvTjZSQS90Ym5T?=
 =?utf-8?B?Rzc1ZEN6bERxeHFZLzlBZHhrZjJ6V3hzNFJqa0pkNkFPSngwRDYxR0F6Z0tC?=
 =?utf-8?B?NzZ3NDhBNHpXRVdIVlo0QzV0M2QrUEYwR1RVYXlPZWV5TlVSZ3ZaOTNyKzgz?=
 =?utf-8?B?STFKM1ZvbXNZYlZmZ0gxZ21TNVlJQUV5SUUwbndSdy81TnBKZk5jVHZKU3R0?=
 =?utf-8?B?SFpMNy85cmFXcU1aQzg4Z21ZSHdUaUltdVZnWVhzV2JvTEVBM0tLeHFtM1pj?=
 =?utf-8?B?UEM4ajJmVmI1MDNvSkk2UW8vclpGM0duTFJyeTd0aW9KeG9DRUFhY0xXS25G?=
 =?utf-8?B?d2ZMaHJqNmgyclhhbmV1V1M1OS9YY0hBSlpGRjdkWXEwK1FRWUhUam9TMWlX?=
 =?utf-8?B?UzlmSVQxRUQ0eG1NaXZsc0ljbDNzc0ttYVhVTCs2R2RLbWpreTBtdnVxcm1U?=
 =?utf-8?B?eDVERUZ2VDRCaE9HbmlTQUVYUlNUMDBWcDFBa2JxZWM0Vy9zSzhyalVFQnVC?=
 =?utf-8?B?NzNJNkhUWkpOclVLQnlldzN1Z2RUWU03MStyODl1cTZhWTBoblhXdnZabG05?=
 =?utf-8?B?YlRPb0U4em5vbzdlMjRLUkp0bno2VkRWektXdkFjaUZOVThZV1NmQURtTEZF?=
 =?utf-8?B?ZURYamd4ajhrS2RnY0xXS1lYUVh0NkF6dWo5L0thRkgvaStxdUhBTVVrZXEr?=
 =?utf-8?B?V3lzbmFyZ3FOaTRyUG91bEZicU1yemFRTkNLdUEwSFdPRkVNakliUnloa1A5?=
 =?utf-8?Q?TiG4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5b979a-3e07-4e94-860e-08dc529aadf4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 22:25:47.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxD8Wm8S8mzkrTk4WEuCFKBM2JYkZxmNYDRzAXGkf7mZbzTIUa9PZhOfpobB8/o7BVHIMnnEd63yJC2zS0b5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

spi0_lpcg: clock-controller@5a400000 {
	...                                                  Col0   Col1
	clocks = <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>,//   0      1
		 <&dma_ipg_clk>;                         //   1      4
	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
};

Col1: index, which exited dts try to get.
Col2: actual index in lpcg driver.

lpspi0: spi@5a000000 {
	...
	clocks = <&spi0_lpcg 0>, <&spi0_lpcg 1>;
			     ^		     ^
Should be:
	clocks = <&spi0_lpcg IMX_LPCG_CLK_0>, <&spi0_lpcg IMX_LPCG_CLK_4>;
};

Arg0 is divided by 4 in lpcg driver. <&spi0_lpcg 0> and <&spi0_lpcg 1> are
IMX_SC_PM_CLK_PER. Although code can work, code logic is wrong. It should
use IMX_LPCG_CLK_0 and IMX_LPCG_CLK_4 for lpcg arg0.

Cc: stable@vger.kernel.org
Fixes: c4098885e790 ("arm64: dts: imx8dxl: add lpspi support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index b0bb77150adcc..a124d6598406d 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -27,8 +27,8 @@ lpspi0: spi@5a000000 {
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&spi0_lpcg 0>,
-			 <&spi0_lpcg 1>;
+		clocks = <&spi0_lpcg IMX_LPCG_CLK_0>,
+			 <&spi0_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
@@ -43,8 +43,8 @@ lpspi1: spi@5a010000 {
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&spi1_lpcg 0>,
-			 <&spi1_lpcg 1>;
+		clocks = <&spi1_lpcg IMX_LPCG_CLK_0>,
+			 <&spi1_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_SPI_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
@@ -59,8 +59,8 @@ lpspi2: spi@5a020000 {
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&spi2_lpcg 0>,
-			 <&spi2_lpcg 1>;
+		clocks = <&spi2_lpcg IMX_LPCG_CLK_0>,
+			 <&spi2_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_SPI_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
@@ -75,8 +75,8 @@ lpspi3: spi@5a030000 {
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		clocks = <&spi3_lpcg 0>,
-			 <&spi3_lpcg 1>;
+		clocks = <&spi3_lpcg IMX_LPCG_CLK_0>,
+			 <&spi3_lpcg IMX_LPCG_CLK_4>;
 		clock-names = "per", "ipg";
 		assigned-clocks = <&clk IMX_SC_R_SPI_3 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;

-- 
2.34.1


