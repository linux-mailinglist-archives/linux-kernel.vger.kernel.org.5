Return-Path: <linux-kernel+bounces-58043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B284E093
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2387E28D06C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039B74E32;
	Thu,  8 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="TFRwaAP7"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B674E19;
	Thu,  8 Feb 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394825; cv=fail; b=NXywF9wPTJwB9QSd8UsFhPITPa6DhiGf1Dwv+TJWFNdLwFq5c76ufMa5UCMbgb2L30Uvp45hjLz74/n/NUCQwjNfQ2pJTt6jzWSLuOA6lQIpw3mUqlbMIMvpCCtpefQvJ2g/zVUCcOI5tpl/r830+TBEj4ov7GRyRK7Jr+c0C5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394825; c=relaxed/simple;
	bh=L49zHV4dxHOH32WpUi+XH6Q/MaMpRoh3sKY39+rSkAU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VabjF+TiAMO/nNieAF9MnK8puffO55cWm+xGUbfsAJAaapRGYCX790Nom6f4HtE4plY0ITo8t32q6HU7ATZJUobhZ0FjB+DRwYA4mAM9R9jBX7U9niIXDWBZ6OJx4qMfBjsLNKRAo2qaA6bpFw/C8e3e0RZAscDerzct1ccyUOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=pass smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=TFRwaAP7; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uln4S1+eFdo/7yeT9Axrqw4dQtRouqYk/Ul+71lGxNFkcx3Yoj9onXNdrrHCiFLDws8nCVNlCF3IUarxjHll3/AuKylN20qnitBQbFHFasl4CVbjS/moZXI20cr5XRs8lYMVCE5uTnNIw9Ds+FscuxuvRCznJgu106W/sqkDAxGhECAsykvl928kAqnyYgEOQKdNS+tNRsLwCD5Q8PmKmn9wyeAK1PHoiI53dbnCoTZk0A3r/cvYqONi8Lf9g9j53bYSh07ftc6epcPVU1S6B7wix9ewxGuEKK9O5M01w9M6RmYUjoC9aL76wFRMJzmGTMJBBsKxsGvGPtCgTHruCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/3vH3OU9aObav3xmRZR5zM/kcEsKkuLGe3CWLUfxI4=;
 b=bCgqlzBrSpjYuHC4ary4r8PhWhSTtxVF1HoaHlK1pzbTABufRX0csy0CaehIjgoSI2LW4oPdSNKI9xA2GMhRGmAAYySXrHlN3ZEFNoGU1UChOh87I8s/EbfdfS9eUZAH2Yna2w96tghsJzgF77/IBNoGge57b5VVGi/GPR45IewRnq5gddkRLrm2Kli/hZc99m3t3E3D44TG6qWbRzR4HWxjfu8aTHLT+WzmIuUq+oXt8PD9wMyeVwZGjMAF0Ihb5DpIo4qphHab6LzGlmoga/DwsK9K+47LhlvvgtrVeDkHsdbpsUR02N2sWTrLONASqjxEwGv2+AAQsbeZUlyKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/3vH3OU9aObav3xmRZR5zM/kcEsKkuLGe3CWLUfxI4=;
 b=TFRwaAP7QHUeJBVb2sIMgaal2fKT030duwVLNoCirVVn4ZCZ1pigM/JLR7q6Lx3xaVpf7t5IQezNFZEGraVwdC0EZ1jzbIaIj0mbQKRO4M4AGv9PkzOA51CHBVlPaY7uug4hRGmEGDS718xZTS218nXxb4fSyqea2oa3GCBtEwVqeLABFjXstBWjnECeWAcuskSr5vIJiIJ82sZGP1OIpR7zl1DvMk4zF8O7YZoR1aZTiaHIwZTqZgqNpgZC50QCqaZuhGc2csiQundbgyJpp2F40WWdqcyBlb2ieZlYqik7xr4sBJ5BphdnSecq5w3ri2fMaJCdBsEwZWqxijljwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS8PR03MB7524.eurprd03.prod.outlook.com (2603:10a6:20b:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 12:20:19 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::8148:9ff7:84ba:6dd2]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::8148:9ff7:84ba:6dd2%3]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 12:20:19 +0000
From: Manuel Traut <manuel.traut@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Manuel Traut <manuel.traut@mt.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6ul: Set macaddress location in ocotp
Date: Thu,  8 Feb 2024 13:19:59 +0100
Message-ID: <20240208122012.1959628-1-manuel.traut@mt.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS8PR03MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3e1f48-4930-455f-035f-08dc28a050b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TSMGvIi7PpRPEpEIAHMZBeT5VVQpUltlIwfaDCLVik9mGNcj6ZUMxZS2B1UpgsGYi5+53ISJ34w4u29WSpquT0sZ+B3Z2tfh2Wn08cFJ3nVKoCOkA/NmJeceXUR9aMWrG1zNh72nVz/jMt+e/fnV6LDtdKTEuJzjnjdbdm3tygK5GDInuitp2O/eg9hIhHarlrr6Q0RYp2JedchUX7xbUIymLMvkOZy0STWhxIYYKZf4eThE4o6OZz/Tuux/JjRCVa39X+CHBD3OjoeD3HzKwNlL3KTqg8a9S2wowLzUAQRE9Nqm2Ka8Wa3etd9YKjrr8EJ4KAEj0CRT9C6inlsBOvgG800XblHlcVYt2rdfA7/2iwUgb/Cmd5HB07Gsjbfr84c6GVxXvtcOxVm8UaoY5zuT0ayz2ktwaK/YDe5s9e8KVGkwJn28YY86VgeuhMYEateFs8ZJdTMiBnyzd3NEAvg2YB0gf4rZkeVrMILSDqwctVIgFyLRokYNbXdKZfR76xHnhw6Jl7CxUNMoevhCGNHW88eXCeaj5E/cGBTknulgEer1ZjvdlWJQ2P9S5TsXfeIDQdQgZuTcgePzcB/kOk98Yolgb0qQXD8vXjC6ymKOkAxzMSUyY2c8sSzkRK4r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(38100700002)(6666004)(83380400001)(26005)(86362001)(66476007)(1076003)(52116002)(41300700001)(2616005)(8936002)(4326008)(6512007)(36756003)(8676002)(478600001)(2906002)(5660300002)(6486002)(38350700005)(6916009)(66556008)(54906003)(44832011)(316002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23o+vxxz5Jkv98+2/rfF7+t9tSGBtWZTQMT73Y4UXJdJJahhXXzgHbhbvceB?=
 =?us-ascii?Q?O7q+WnD2hVAG7x7tflMCf4mB0baP5931nGJXvFolHJ3p2V9dKPlXh02KMOBS?=
 =?us-ascii?Q?nmeSTxpA/mcNKr6XVTGfh1bT2I2jLVcB2poM7nf/WxfLvN1Y0boAHwMWYMww?=
 =?us-ascii?Q?Poq9dvJWNWcWk7lJaUCY4UlTN5k58n0NemAr79ZSMElBDf+yINRB2vxmQdVa?=
 =?us-ascii?Q?fjJOmhagjuUbBIQSZV4cBbkb++DysHK6wT6TvYyDnZd76/Cbz0NvfFtHdjB3?=
 =?us-ascii?Q?AHQ8GMLoO0xklUufnfk5Ry8o+BLqIpQvMLa0GJUPQ3CkpFEyb7CBYZjTwH5I?=
 =?us-ascii?Q?gATP0TaMF5KVx2dWbcOm9Nk26p3eKTxbDeLjif15zzSLtaklL0usppxkTAOI?=
 =?us-ascii?Q?VTOn2lLVd/Fp/Q7t3tO0NnFfjtxMQUPSh+3Ryo4NesbJAxe/dfZuHaFjmgcS?=
 =?us-ascii?Q?9jeI5SxWRel2J0UvQDXA9EFBxq3tsrmDVAjd/ojvnI61uyoxr/lAbECemW2U?=
 =?us-ascii?Q?PBrKtNyg8ZrTlb0oPZ8vzRQYoxOYRg/Kbni4gF9lXPzYELatNHM8oWtouOTF?=
 =?us-ascii?Q?sntaAPOJskEJJAs3xiKul+CTEtb6YWET7sfGF+H2dS9NkezfRxfSoYXxAdpd?=
 =?us-ascii?Q?Y37e6OxCaqLzvwHn0bT8BKkVsRubeBVlfDLhpaqh6HZXisN6vkjHCs/onuFS?=
 =?us-ascii?Q?QDhDZbNJZ1hKn1oowT4oXRahp849LmdHwKUNsBEGO6xhn2FuXpPYir3HZV7Q?=
 =?us-ascii?Q?L+4NTL9qknSdOKeEFt6QyamoBFz6bEyEQCZLj0M5WsLUQKXK+viFqEf6X8uA?=
 =?us-ascii?Q?1TYv4cqoAEMyiAzWXkGqFW6dyQcOcwYXij9RBEL0dTpfpKLdADPsfvIZXeu3?=
 =?us-ascii?Q?t3ZmRbBQlj8V/81vPfi+da2zufEvwsqOln3XhNouekqOX5P7DprU5712hk85?=
 =?us-ascii?Q?hRHewItq5OIPjDKBPSg0nPATaA+0vdaQ+9YFaCEixdn4dGhhWohVTMcCSPjP?=
 =?us-ascii?Q?qanJxia/n9gI4oyvCzkJoQGMFSg6/GGYAriK1OMXTAiXaBmVPl2F0n0VKi56?=
 =?us-ascii?Q?h3dyJfu3BujNUB3Wj8+i364mF2uhppoJfXlJkxwQt7ao2QOwzsEjMO/l6rFz?=
 =?us-ascii?Q?r6UJHWdtfPt536khIMKUPq/oKA5dix0NDiviDUeDsEetjd4Tmp1X7h5XES7b?=
 =?us-ascii?Q?U1zYRGLkAvllj7eFrBjdpSZdQ+xGNm+/1EjMxn6EaMafIpn1GOeAMAh202CH?=
 =?us-ascii?Q?xaIi75edcfdwaJ65uhkM58j2IqCDGe1RQFS81w/VfDnQVvR5RCH2dc9FY9/h?=
 =?us-ascii?Q?jkbIz58P87tig6Vtijh7Lh5/EpbDVc/HVFPSAl30Cxzg2V4y/JagiE4g3F85?=
 =?us-ascii?Q?dYyvh3tE78Od+eJgDTFDPgVjzZLOmp0kEBo+UafKq2yAqw8aBX8GPFOra9th?=
 =?us-ascii?Q?iM4oN8VeM/aEO6IYCUvVaigfUCh5a4I601qHZOHQywt6FSFDvM0kK841KJus?=
 =?us-ascii?Q?vxb3GVSD3rcmIABgntmRER9CV5thGa+VP0dIAgw9B/Er+N9DP9Urp1YqSDqT?=
 =?us-ascii?Q?AKBs6Qobf5FkSFv+xlc9M/opjyptG00G4bAHk08c?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3e1f48-4930-455f-035f-08dc28a050b0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 12:20:19.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPS3ibthhxAO/QpeibwQ3LOxH3FXsrM2vJQZbCezS6qgWz6jHhY9pq00cD+lI0FTukkHsf+h70Uy1rkWnktHNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7524

If a bootloader does not configure the MAC address, devices come up with
a random MAC at the moment.

ocotp provides registers for storing the mac-address.
Configure those for i.MX6UL and i.MX6ULL allows net/core to retrieve it from
there.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index a27a7554c2e7..e5e8bf814f77 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -538,6 +538,8 @@ fec2: ethernet@20b4000 {
 				fsl,num-rx-queues = <1>;
 				fsl,stop-mode = <&gpr 0x10 4>;
 				fsl,magic-packet;
+				nvmem-cells = <&fec2_mac_addr>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -897,6 +899,8 @@ fec1: ethernet@2188000 {
 				fsl,num-rx-queues = <1>;
 				fsl,stop-mode = <&gpr 0x10 3>;
 				fsl,magic-packet;
+				nvmem-cells = <&fec1_mac_addr>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -1004,6 +1008,14 @@ tempmon_temp_grade: temp-grade@20 {
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
+				fec1_mac_addr: mac-addr@88 {
+					reg = <0x88 6>;
+				};
+
+				fec2_mac_addr: mac-addr@8e {
+					reg = <0x8e 6>;
+				};
+
 			};
 
 			csi: csi@21c4000 {
-- 
2.43.0


