Return-Path: <linux-kernel+bounces-150965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007558AA737
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FFF1C214AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1B1079D;
	Fri, 19 Apr 2024 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LrMBUJZK"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC3DF62;
	Fri, 19 Apr 2024 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497403; cv=fail; b=VAVO1IXIPSgK4Neu34aPQ38RMzk5jEdH9eY0lcbObX3E0Fs/Zi/HZXZqQBxJKk25V9TF2Vh2BKA1iIL27zkpqjMeonKg85qCKmQNU6vZmvow+XVRHddjJfu5z3Hzk0/tU+sw/Z1G5ulCVbNsOpc0/FUYaQbYkF23t/prEwXXWZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497403; c=relaxed/simple;
	bh=XuzHMzG6XAn3GvDIZJ0vCGIZ6eLXQfvlrOXBMMAlHOs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pBXrtCDxhi8p8Ggk8DrItfFnbT3ovYvi6ejIV5S9luv2Towyohjy648NSrwLNL77+5ttNOKWJVy2E7ndAxv0RzTJnHTPRL7JUsbogo+SSEi7hRP02ZnT2gN5053Ge13IC/GJHJ8PVCQxLl1Uzln6Uiae3r5WupzG4qGEM8Gah/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LrMBUJZK; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ4El+MJ+hLABJt6R2g+CcwgrTpylO/BqcvhEnGG3sqnO9z1I92BAuyTn6jf3dzfSnbPsjNL1Ph3IBrpxhbt/m7oNvbJWyY77fL/xSQnvfIlSfUXsNFGKyL9G9EXV3qyeNi//43vW6BtKVLd+iLCUD4UVaYNHtZg1qXytZbokPY5cNrWax0yOqVxAq0swFGxSmkX/12wihkCgq5qwf4Nfq36MkEz3pOdG0ByZ9ALjejgEZmrmJP2wMc59d/Q7n7/eqDSqpWD6VgetnRi+P+Eh7rz9ETHMcMSeDsV5y71vCcpt0RIkzD+DbY5DZqQvs9teW7CKcQYs9O1QTD/dtMWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40VyR+bbbDdzXJDNuAMSQzwuFFzejMNjxD9W5yvxzbs=;
 b=aNdAcqqXMMv7bQJvoqBrg294mKA2mxDNxtUwAvAdTvbsVdF5ehzVh/wmY8JnmhUUFVryTfGCOmixowyPHxC7B0X2ltbd0OgRoDhrauQX6dqRxK1XkhN0L3A2KSIzr2RGWuDrnKC8NQiXegRBpRROz+h4tIxStxhm96tnNadU9O9Fub/FUmC4uRpKqe+6bbp64hxNc0mIO8mXFk7NVHZRPM7aq3hDv7SOch0w9qqiEPh67K8E5FBB9b0ZHgRLcFg/+6z9XfHtHVihJOm/KJ6X8UFsehg+jMYiT1E6bEkRY6jZgjIj0b9hj6m0QGg0/skifr9toeb5w1j+Gx1Qc0CGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40VyR+bbbDdzXJDNuAMSQzwuFFzejMNjxD9W5yvxzbs=;
 b=LrMBUJZKn+BJ4SRQiaBBo2dhfqmT4HJu9dysWzc4WyFqlQGXsCxBIiGcXyUEvMkkbIYT98LfVFhVo3XBz9AzSrAngaDBTRnlrxN3ClKVStzvbFaIwikG8JJIe13O9fVRnaFilnlWvAJY1tseVd+TLDSIA4EQMsP/dQrpL5wMRGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 03:29:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:07 +0800
Subject: [PATCH v2 12/12] arm64: defconfig: build in OCOTP ELE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-12-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=833;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=95/or8YNovtRYwaReL52ZgU1R6CLxV7qrF0J7lepSt8=;
 b=eCcGqBFC/eh9x3iqIH/GhNCtxuzA8ZkFSUyvEnfsKEnCUkwBziO/rlUI5+p7zbH85PdO02Shc
 N9Gto8uXpcmCYsn8gAon4P2+ml3nVusGY/Lh0gpDNLcuZwNNGYfL4rn
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c521ffa-4b8f-49f1-0ddb-08dc6020fd18
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I84SQXUFQlcJmdGsV98LdTCUWoQJG0WSDP0oLH7vchohlWVuUpfCiGa5L1s8nLLCC5HW2lDwFB5yLrtmB/jYJuryPhtCIj5W17gwQAAp63d5lM0zwXRdre2ONOCMenUpEy3xBSt83NjUBSjCGYZxcOWubha+R97Pmhry7jwfGCfxhOyl9hrPW93wsLBwmsQH9uF8xr5oVhzm9c6n5uJAniLatkHq3QbPEd80mur/ICsG737BqUpbsCjWk2o4K431MtvLWkS01dIA8DDh5bfBul/jeECYmXwQuaH1rP4NHKebVIe4+kNPrBwbYoDWLtaVOfqKl5olj8//YcFmG0/pYriYncutjhHgsWK3315OJ4cJA9hx4oZkfCR8I74vTOLJliwmaGGnOLO1T1+5gtUJ3+r9kwVJe9X0UXXZ2Ak/OWWWEbPmSZwbnM/tP8oaCbsHB8ruTDPLR+RMLAkHM3hyM9ApmjqH5RZxhD1pz0GM57fs3NKZezsol8yfQhSnWFCHCEnTiB983WjI1DYBgGVcaXWLiVl90U1ZJQg99F8fUDK7/HmpMKZq6mQGfHjK9c5q/mzfY64FbFe4JIaAt+uCujSDdDlPoYHNj9C0PShxa26+KLDYYzigRBM8zOjZMvv3JT9EA15O7yPcSjxbvE+UMXn689UUHOvR+g324Xdh/uS0R63uihfxpZIt+bCNmhiXL1DreTuW3Uy5K6PXQJcBPnCL+AJDBMetcLeccUOYSiA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFgyTENFWVdsVEJEcm1vb09ManJUeHprdDVjWVAzSFgxcjBvOHNzalBiTHp1?=
 =?utf-8?B?T0JYR0dCTVJBT21RcDJsVXZESFRzVjE5K1dwNnM0c2JBMXMzRml4UEJhb3RK?=
 =?utf-8?B?bHpwS08xeFNZYXBqTGJzYjNrUU5INDArb3FKemZoZHJKdU1LSWwzVGQrb2tD?=
 =?utf-8?B?MzQzRmpRSUJsSExzSjBPdG81Z1ViL3hWMWZzMzRlamFucGc3WFZaV0pwamxQ?=
 =?utf-8?B?bk1CTGlVNHhQSUhPWWdmQ3M0cUlPKzJkbVNiUTZSVThpS1pCd2dtV0NqNVpQ?=
 =?utf-8?B?TGZ4L0kvNVFNQkE4N0UzalBSTXJUeFR2WEROZWhwci9GR1dHSWxYYVdPbzhN?=
 =?utf-8?B?S0FTYjZCejZKaDdPLzBVSnh5RTZZUW5mdkhsU3puR3ZDZmxKTC9HSFlORkFw?=
 =?utf-8?B?SHdnTGdJVmJOQU5jL250TGlLSVlzblhxOUFkTEdiU3FsQ0tlRXJnYU9JdzdL?=
 =?utf-8?B?UXM1NC9udWxKUytXbHFVM1ZzbjVGYm9lQ2NwYTZoaUFkTjJ0VGxWWDBtcFZp?=
 =?utf-8?B?REQwUm1KOGRHWCtwMTFGeVRha3lPanIrRktzZWhuRWo2R0RmOUgwaEd6VDdB?=
 =?utf-8?B?RzYvM1FSQThoL0I0M3F2anlRUktxVTNYOUYvTGNaQkxReDJmSTN5ZkU0Wk1X?=
 =?utf-8?B?Uk04VGQxc1VuOFBhQ1B5cm5wQVJLK0RDZXd4NTNtZXJsaHQxb0FBOE1LYW43?=
 =?utf-8?B?S05VVGhUc3k5UmVjMVhwL2NYd0ZXc1Q5cDJOd2piR0NETXgvc1hFQ0NMemFt?=
 =?utf-8?B?TTFMdEhpd0l2eHJOa20vV1dMUTVPV3BleGlZTTNBN0ZqYk9VUFJtLzB2a3l5?=
 =?utf-8?B?MmxnSkJWenNLMGRwOHdJd0VGcDJKaGRHc2ZERXB4cU8xL3RVb2NEN1grU3pO?=
 =?utf-8?B?eTVDRGpWK0RYMDJ5bCtPcENVOXR6aE9YZGt4d2laeVNtcUljRmpNS0RwT05s?=
 =?utf-8?B?MjVXRTI5VGRoY0o1aWw3aGRIYkFEemNjWmdjQTNWMHZSTEd6bnd4bU5rdkc0?=
 =?utf-8?B?L3NhWjl2WUZGWnMvREhDbVBrRlRDQXpnbWRuZEZ0ZDUyZFRQdWZaVG55YVdU?=
 =?utf-8?B?NEtoQVNtcklqZ00vTmluK2xvN2hpOGUxd1Qrd0t3K2x4S3NhcDdyZGxLcFhy?=
 =?utf-8?B?OEZZMWFhUmVmVjlRVWZ1Mkwyc2NTVXFnM1NjN3k3ZWh3SzlET1pmV1FsVEsx?=
 =?utf-8?B?WGVhcE96K0ovdWN6YWNncFBscmZ4NHdRVEgycE9BZzJPcXZmQ2FZdmRPMGpz?=
 =?utf-8?B?TkRITkwxc3lIanpjQVdiWlVjclZlNnlWYitoTTZSMkVaZzVGcWVYc3ljU3dI?=
 =?utf-8?B?V3hrdHN6NGZlQm4rSWtOdG9uRXRDR3VXOGhLMHJ3MjU5NmtqYStuckdlejRI?=
 =?utf-8?B?ZFZCTWxCVE5TZUdiMnNNYk5NZ25kc3lQNGxFNVJ6YS9vUm90SXM3Z2FleWZC?=
 =?utf-8?B?WnFMNy9kVmc5VHBaRWUzQ20wYUFIYldscVhEMisrdkFybVNmS2ZUSGllUm5Y?=
 =?utf-8?B?RFJBcEpVQzFrRlpaWVhOV3J2NC82ZjlXYkVRQkxtTkFWMHlYc3dSaHVuSkxo?=
 =?utf-8?B?QnlWbmIvSlQwYnd6dVQxTHFEZy9nVHNyUjVjV1ZiRDJsdHFvSmlMVWpBdVQr?=
 =?utf-8?B?Tm8wbFN2SjFQb0FnRUxseUxUVUN2dVpKaElDVHB1b3JMS3NVWW5JT2Z6VGJk?=
 =?utf-8?B?cllBTHlYRHpDUkhEeWJKUWpNWThQTjJ4WEc1Q3FjMlRhZGU4ankzam5YY1hG?=
 =?utf-8?B?Z1lKazhXaHhMRnYvNGlINjRGZWJoSVo5UUFpVnBzQ09jcitSMkV0YW54d1Jl?=
 =?utf-8?B?bXB0ZEs0cEFFU1NXdXZXTFpId1BqczhHVU9WNlA2Q0cyOHF4SEIreEVmc3Bq?=
 =?utf-8?B?SUw3SnBCdTJwb3cxcit6aS9xOU9WU1k1MWpYeVBySnE1eGF3TVhXNlE5NTB6?=
 =?utf-8?B?TW5ZR2FLbi9NZGYzVHVTTkZEWU1mVlhOblBaRmxWUGlqL0Zhc3FmMHBiSkxs?=
 =?utf-8?B?czYrKzJPcll4MU5hRHNIb0taUUNFNndsZy81RlJoWU1xVGJRbHk3cnV1bTN0?=
 =?utf-8?B?VkdEb203ZmYzWG9Fcks4enZyN21JRGxvTkk0dTRrUGFiWGxiYnBycE1Vd0VO?=
 =?utf-8?Q?rd02nKf7pGHS25CKZc3RIsEMm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c521ffa-4b8f-49f1-0ddb-08dc6020fd18
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:58.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a+JMvZjMKpMdhlxrDOWVQx9OR/DxCqtrLpMEBlY/9/zqrNyNT2Ke0Aqri8eTnfVHkGkyqpWorA+tTd+zGG+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358

From: Peng Fan <peng.fan@nxp.com>

The FEC network driver is built in, with OCOTP ELE built as module,
the FEC drive will defer probe because nvmem provider not ready and
nfsboot not work. So build in OCOTP ELE driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9957e126e32d..b9f0805abeef 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1553,7 +1553,7 @@ CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_MESON_DDR_PMU=m
 CONFIG_NVMEM_LAYOUT_SL28_VPD=m
 CONFIG_NVMEM_IMX_OCOTP=y
-CONFIG_NVMEM_IMX_OCOTP_ELE=m
+CONFIG_NVMEM_IMX_OCOTP_ELE=y
 CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_NVMEM_LAYERSCAPE_SFP=m
 CONFIG_NVMEM_MESON_EFUSE=m

-- 
2.37.1


