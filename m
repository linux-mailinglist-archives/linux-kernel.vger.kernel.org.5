Return-Path: <linux-kernel+bounces-110205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51A885B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407B5B24A54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9086249;
	Thu, 21 Mar 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UfS6l8Bk"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2108.outbound.protection.outlook.com [40.107.8.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2FE85943;
	Thu, 21 Mar 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034019; cv=fail; b=NlRO6bsgNMzVX8N+6ggF2oMF+zK2xFErqjmO8O6tkeKjyf1Tb816P2zjbOjtgshh3AilVCZ+LdEylchRySZMTiE6AvKei2FpI0duJpFBuTZ0KanbTt8cSm3aVUeE4zt52zC/2nQo1LuA0kVIPrqv0pCaAwcxmdhiUN+DiHEI7GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034019; c=relaxed/simple;
	bh=ctlP0XhziHdMGK0XcKwrNCUso1ROP2CyzdIdHK0AG/c=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=BKmKDJQ1+Sj4BachNwDARmDpkSMrbE1h8CctlIAMh8QFvjMd9B6l+Xm4EPmyShBCu8p185fXCsMKtYwz7bAZd2KMSpRvv8Ay/6/wUyXfpVFoKYSjlEUtIUU1txERVHIfJ9ZGEoZ6/y/0SS4WampKbMNbhIBVzRbM6nNaHwQlL4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=UfS6l8Bk; arc=fail smtp.client-ip=40.107.8.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP2l8+qHYtDUQ/VaX+poothIiabEVAx7tG3ScK+28hBXLXyzi0MCnEtkjjtgCI2eEipkpjphCBgjqaut2qFyXgSRK6X1ELoa7DHde9H8cfqa0HxOMhWqmnyodxedeM3k1ni+UIsb4FAyQTU/b6cqn3x71vDnFr3+QlgShI9APO4Y+msuqoT3SvttxfowdLbgmWWsExu1tZ/dHC2vpgQ8XyKL+yuAsIR8RfrJFnNSsEfknhScdb9Q2SrtM/MyTB0OhplYAczgH5xvJ14l2fprbtjVStPHY4ZzNxcWnshPka5cp5yZhasrYV6vL0ZVZcKAxQfnC9JAPdxL2UVx6rCj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O4vxaBJfT9m0gyYqownn4cTQ5IHN0R8B4MeQnLER6A=;
 b=PXZp0E5Fbeqy3STSEkMZPosk3r+0uRQ0oT2dGP4WCRWmCatiQ+H2sMDGDaCtLpaT+Zel7dRA8o4MUKQNmUc0lKeCFKulaGD2DwGvYSuM7k17s0dngBu8UL/Mh0+l31gu9SRf0WE1C5VNd8sa7URQIfECBcw3opkhhAx5uMVtzNaiv7uBXszxLyGmRWQsEnjA4uvM7xLFCkhl5bZxjlwDMPQrkM4XIIdbfr2RRxjjxqf0jbWWTDZq0pb/LluD6udN77yH4QtYCGRePd1rIvZfCU2hIfau3rg2dwq2CMejMVJgCKgzJzWLV+sRTM0AjE5AiKoCuq7QmN92OLgylXwfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O4vxaBJfT9m0gyYqownn4cTQ5IHN0R8B4MeQnLER6A=;
 b=UfS6l8BkN+Bey5HWy5lvOUJRQoWi/x1MWj18SVwrtsrSvxsaafv6yCJ8t94xni6OGO1bREXVukhLTqQtbpys2IYkstGYZFIG+emOpJ7Qg5fv1iEMRDyL3Ojuxm4B7VIJHi6tpexMNGwHUV0KyvVwuy5CrzyHQJ75cAnvK0lgOfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS4PR04MB9691.eurprd04.prod.outlook.com (2603:10a6:20b:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 15:13:32 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 15:13:32 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 21 Mar 2024 16:13:19 +0100
Subject: [PATCH RFC] arm64: dts: lx2160a: extend 32-bit, and add 64-bit pci
 regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-lx2160-pci-v1-1-3673708f7eb6@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAI5O/GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0ML3ZwKI0MzA92C5Exdk6SUJENLs1RTizRjJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAjy/5tWEAAAA=
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::20) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS4PR04MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 9264ac89-fb8a-4532-2244-08dc49b978d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zWYlC/HVb0BgvvGi1DfztYgNsbI5SG4zU0r6Irc58QZHcTfCE3N1B39CgnAniN7bDjpXypEaE5WhpcUOmYFsCJKf24ZK+/7Jn90cgJxkK6/JfBvrrP0RdSnjh30eAMNVXv+8DMhhx2Zck6zXaareNckprawzXWvmGUNLSWBwueLw3wCTUzlRLOxFhZgvYfGOemGFhunQEHNsqu7ohIyDEukinhiNy6gNSkA70vfjKZFpKZpSbeR7PzAbhJ5s8dcpguXXZR7NFkiME4ayV/1ka5YS3WLnrlFtaLBnPE6JAWMpsrWq1X9ikUBXxFSxuBVCmhqdZa1Vp2Zll5ePJilPxtCLjVOjWffIFprjV5ZCOwZF/nBnpNlbs00hyd2rLztJ1lqddOwNBOb5aQRJIiA4XXiKqYvUHG/yQUtj097rz4gPV2CuycTgOdyYYNhjiEKRuqZx0KlxGJYx2J7hObdsZuwIs1oFDk/XafePYwoP1Fv4gRTrkyoB/5PfetbZTP4ildfJIHNNq8PMsji0GeadtlFWW1LTi00PpfdUkTGYJ6BtF3vE7B395U6V8j+XEqZAS/uASbcipQoNvACropNuHcuZaloAq35uANm2CVaz+M9iFa2aR74T2ZbgVcynOLQCbRLxZDDBdN9pjlZZda8uez+zgk77hrvmZmxM5QeXgOr07ogzTDGgAXNxV+wtLSrdYCjif6VfoScSb9gZQd4U9TGetLx6cWZry4MEbWaZ+7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VHVHNNQ0ZmOVYyTzZVOGpMb2hxNTlIT004TER6bkZVQmM1UHRmaWRhcEhq?=
 =?utf-8?B?OHZ0Y0FBUVVvODF0UDdyeW9TTzZRR3FQaU80OXFkVDJTaEU2TWo4WnJCb0Yy?=
 =?utf-8?B?VjdPa0VPNTllSGRBVE5SM2U3dFJTOGJBWlNPR2FMMmppQzc2N3EyUzRBUnRs?=
 =?utf-8?B?U0VEdHNMclFpcnBuRjVsbGlmbWdDcGZuNjc4eHNSTGJFbmdRTCtnNGp0dzZi?=
 =?utf-8?B?RWRSdkEyR1AybVNhZXpRTURmRWdKWFhXMTJwdTMrbnNyZEMwVytFQXg4eDh5?=
 =?utf-8?B?TlZCNStPa3Z2a0FJdWpMQ3FJdWM1QXZTL05mNFU0LzIvMXhaOVJQNnBocXEw?=
 =?utf-8?B?c1AyK28wdWZJRDhnVTNadllKMzQzUUZKV0pXM1VFL0pMVUhycDZndFVlbjVB?=
 =?utf-8?B?U2tWUEZQaU9ja3dxNmNGNDdreW5rTFpnWWpldkxQdVcrK3BhVnpnSUp2SEpq?=
 =?utf-8?B?eVFMbW1qYStGckZmVkF5TmZwUEIyUEJheDZDQVBtTytiSkRFOGg2NHJDVncz?=
 =?utf-8?B?dkhDTklDRDF3aGpZUVpFYUlvV2FQeXRQRVJ2NVNtQlNtM1c2d2ZNeDQ2MHNG?=
 =?utf-8?B?Z0w5VWRPRXMwM05GbUp2N1cwdGU5WVU2SXZNWXoyTnRONm90R0xOVE1ONGFm?=
 =?utf-8?B?cUJxckxVaWdERTUxKzhjRWI4dGgwRHNZd3J1SWVnMjFOakthTDNHdjBDYU9S?=
 =?utf-8?B?QlZkUC9LRXYyMTFTc1lMSndEVWtiOGxhdmdxYXJFT3lUUmJpRTI3T2dSVjV6?=
 =?utf-8?B?MWVXMHB0cFFNK0tZd0ZxR0hVeVNYSDRwd2FqbElrbjdlYzR2VHcrOWIyZFRO?=
 =?utf-8?B?YTdYN29YUDZIRWNmTnFtZ25aRDlXRnpvSnRYbXlBSEJHRUpQcG5WOE1CbndE?=
 =?utf-8?B?OWE4LzhkNEttZHByQUgycjhCcGc5dWVtdXlqSU5qd2FJUHZZMm9YWFovR2dF?=
 =?utf-8?B?eklBY25YbXlpYUJ1aGxsOVl3SkxnRnlyWmhNSTAwYk5TMGhFTWZZWm9ueVIz?=
 =?utf-8?B?eVFkSmxkQzRncUk1UEVyczQ3UW80SW1xZjFqdVZ1emt1SHRMdTUrcUI3Ni9q?=
 =?utf-8?B?Mnp3NXJ1dVhiR0ZFbDRYQzdXUWFxQVR0K0s0a1JOQXErejVWVVdWT1Z4MDNT?=
 =?utf-8?B?RkpscHJlMUZSN0RzemEyazhjQTlwcXBwZ2FZbTFyRU5FdVNwbTYzTWtPTEFF?=
 =?utf-8?B?OU5hNWpWdlZWbWVDZDNZY1VvRjBVcnBtNUIvTXlERzJrdUQ4UEdSdXhodTY4?=
 =?utf-8?B?eXlSZ0dSNFBOYmxMYjdGZDJIUEdYZTZtRCs4eWRwdjhRR1A1V0F5emxIRnNQ?=
 =?utf-8?B?YUc1MVdyVjNOTUNwUWh3YXpxNXlmUDVqcnpGNHNvZkVoSy8rbW51MitIekZQ?=
 =?utf-8?B?bHpSck56Ty9QR1RnVVFHN3l6NEovL29iZ3ZZWkdJVmlQTTRta1p1Rnd2NklZ?=
 =?utf-8?B?VFE5cTN1bGlXVVJOSXo4NitoMUFpVVRBdmdxcHRJRnB6djNNS2ozZkR3eTdk?=
 =?utf-8?B?LzNLaU1vRWdJMG9RMWhUZzZsaVBxN1FqU2I0Qjg5Y2JFT3FNTXNHcU9WZ3Zn?=
 =?utf-8?B?NUExOXhQcTRzVDVvUzV2YjFNeTc4cXFoQ2luRmlKdkZ0TjZQMFBLQzRlcVVr?=
 =?utf-8?B?VldJQjVCaUtpVityM01tWjFlYWNZQWJ4dFdjS1RCTVNoN0NSMFNMZk1EOWVo?=
 =?utf-8?B?cDlVaXd2V3NNdHFkUHljaXU1N3lnbjBIcWFmQlB0QWlOYStRYlFTQ2hCYTRh?=
 =?utf-8?B?M21wdzg4SXIzN0xEYkcwVVdiZnVEK3MzYUk4ZDdaMldRKzNsYjBpMndvK2Yz?=
 =?utf-8?B?aityeU5vVDN4SVF4aGJTbExXcS9YTFJHcElNNTVDdVB1azRNbElzdld2TUtE?=
 =?utf-8?B?U3loQ3kwWXY4YjhvVEFnZ0dNVGNLaEFEcjVITXdjV1RDaDZ2ZjJ4QzhHUjdI?=
 =?utf-8?B?WjdIdk5rVVFScWRNa1pvKys1UUVHNkhhWWlGUUVaWGRkWGdNUEFNS0NOcC93?=
 =?utf-8?B?QjhIOVROMkdla3dyMDh3bUxmOU9heWJ1RDlTaml2T3R6cktnYURieDRZVm5Q?=
 =?utf-8?B?cUdSeEUwYnpta0xkMjZIb1JsUytsUlU2UW14bGUvRTl1YTdJbTRhRlUzODBp?=
 =?utf-8?Q?CCJaHvKkOfpOUvifiHTZPAzB5?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9264ac89-fb8a-4532-2244-08dc49b978d6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:13:32.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr9ySBz83Vbp7lfvL2/Ur1pbd34QSuJinJU2VTXTIkmt278Pn1BGflWUKqYgKRq7ALE0KO86cvWtqvCBlCARUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9691

LX2160 SoC pci-e controller supports 64-bit memory regions up to 16GB,
32-bit regions up to 3GB and 16-bit regions up to 64k.

For each pci-e controller:
- extend the existing 32-bit regions to 3GB size
- add 16-bit region
- add 64-bit region

Marked RFC because I would like some advice on the io resource flags.

This allocation was tested on SolidRun Clearfog-CX with EDK2 firmware
(ACPI) on pcie5, and later adapted for device-tree.
The device-tree configuration was tested with pcie3 and pcie5 and nxp
lsdk-21.08 based u-boot.

Fixes allocation of large, and 64-bit BARs as requested by many pci
cards, especially graphics processors or AI accelerators, e.g.:
[    2.941187] pci 0000:01:00.0: BAR 0: no space for [mem size 0x200000000 64bit pref]
[    2.948834] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x200000000 64bit pref]

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6640b49670ae..3ab1db6f54e2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1134,7 +1134,9 @@ pcie1: pcie@3400000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x02102000 0x84 0x00000000 0x84 0x00000000 0x04 0x00000000>, /* 64-Bit Window - prefetchable */
+				 <0x82000000 0x00 0x40000000 0x80 0x40000000 0x00 0xc0000000>, /* 32-Bit Window - non-prefetchable */
+				 <0x02000000 0x00 0x00000000 0x80 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1162,7 +1164,9 @@ pcie2: pcie@3500000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x02102000 0x8c 0x00000000 0x8c 0x00000000 0x04 0x00000000>, /* 64-Bit Window - prefetchable */
+				 <0x82000000 0x00 0x40000000 0x88 0x40000000 0x00 0xc0000000>, /* 32-Bit Window - non-prefetchable */
+				 <0x02000000 0x00 0x00000000 0x88 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1190,7 +1194,9 @@ pcie3: pcie@3600000 {
 			apio-wins = <256>;
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x02102000 0x94 0x00000000 0x94 0x00000000 0x04 0x00000000>, /* 64-Bit Window - prefetchable */
+				 <0x82000000 0x00 0x40000000 0x90 0x40000000 0x00 0xc0000000>, /* 32-Bit Window - non-prefetchable */
+				 <0x02000000 0x00 0x00000000 0x90 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1218,7 +1224,9 @@ pcie4: pcie@3700000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x02102000 0x9c 0x00000000 0x9c 0x00000000 0x04 0x00000000>, /* 64-Bit Window - prefetchable */
+				 <0x82000000 0x00 0x40000000 0x98 0x40000000 0x00 0xc0000000>, /* 32-Bit Window - non-prefetchable */
+				 <0x02000000 0x00 0x00000000 0x98 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1246,7 +1254,9 @@ pcie5: pcie@3800000 {
 			apio-wins = <256>;
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x02102000 0xa4 0x00000000 0xa4 0x00000000 0x04 0x00000000>, /* 64-Bit Window - prefetchable */
+				 <0x82000000 0x00 0x40000000 0xa0 0x40000000 0x00 0xc0000000>, /* 32-Bit Window - non-prefetchable */
+				 <0x02000000 0x00 0x00000000 0xa0 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1274,7 +1284,9 @@ pcie6: pcie@3900000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x02102000 0xac 0x00000000 0xac 0x00000000 0x04 0x00000000>, /* 64-Bit Window - prefetchable */
+				 <0x82000000 0x00 0x40000000 0xa8 0x40000000 0x00 0xc0000000>, /* 32-Bit Window - non-prefetchable */
+				 <0x02000000 0x00 0x00000000 0xa8 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240118-lx2160-pci-4bdb196e58f3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


