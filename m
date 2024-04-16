Return-Path: <linux-kernel+bounces-147117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE28A6FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE372861C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60FE131749;
	Tue, 16 Apr 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jVjC+8bG"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087613664B;
	Tue, 16 Apr 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280780; cv=fail; b=rR74JffiqDjv8chLeHWlO9gmZ3JzPjPr/BO/B0nJfsvKZAW1iJUiao/FK66opxfRa0rLwi9p38Kty5edUUJV/WVJtqrFjrWD2qCOW7u3HsZZryUOrq583PwruoItOjcdsieUuGovljvOvm279co+cJsReAOsiOlIyZk2z8Cutho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280780; c=relaxed/simple;
	bh=XuzHMzG6XAn3GvDIZJ0vCGIZ6eLXQfvlrOXBMMAlHOs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PpZ9B8+5EqAq/Vy0I8ApnXDj8ZfclSQWpH6OOotxDdD7+VFlWxHVtU0P1EoY7eDJS7p8aAD81ICw9pt14CmdSLasRRwBA254SXXUasI94qJKHroXFYW65oUGP/A49r3gbPq5u2CA6tuTUEquNWs5eElOvt41X7sqSIwMGwmFtr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jVjC+8bG; arc=fail smtp.client-ip=40.107.247.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDt1wqdAZiaVRs8ZNacgb85TY07H7gAu8AsUNU8lVAX/qJirRV4AMXuIbp4oD2iVNOQmOiQQZV4LkWxQruVzKiYxP9Zx4c4fpZmZ+tzPeViaLIWPpbt43B8JIdRBr1gHuWQ/innSfIZRjkxAP13QAKBf0wFEqkX/vjBsZcGec4apfuY/k0bgYl96xKVylfrPARo5RhM1Vs3KoMVE1Nqg8iPIrHcVJSC89SyDLnBqmd396666W2TjsjQKW1jtoM63ed+dCFhrJkK2q4x7tV5n2kQK0c+mHW3UuB1DE1WDT2P3IyWhgK8RGvcmo4tfxLwshqqkYGWDb2bpHBhnmQMtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40VyR+bbbDdzXJDNuAMSQzwuFFzejMNjxD9W5yvxzbs=;
 b=dd1ASq4ytZU4OtOQ7G3SFPn9M1N1LCZHicSUCh55YvMJkLrw3aczYvfQ6/a4uejkLo+SsJ/lhjZI4HdA94Vo2NnjqOhotGUtR7Nh7bpICAIn+RDo9kHocLS8oddnui+VavH77paZZCp0Fo1FjkULAl9PKQDk4i3HRirf92730741IppNfeHEE+dvt0OPfn9uPaPA0XyYSwOhJwZ/tauzc2pk4u0HCTV6bFUMQuZcVXQHeLNisMj8rlz/mOcB9QXlmamW29+C+RxPCPlq7eacpMO1RwE3OGMxtE1FsEYKBjgHyOlAtKRuWHgdk+534BCBGn7t0rxFy0qCKuMQxgjD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40VyR+bbbDdzXJDNuAMSQzwuFFzejMNjxD9W5yvxzbs=;
 b=jVjC+8bGksngP0B0M31o+TYfrPDLsRVDdoXArdqDnYun2Mwc0yzU+iAJBl6aDS9xRVVYWZlpgF7llTdmtv8e5U/SYg09Aw9LY6OEtZGPI8dW9StUbuzJm1fH+sQT9tmFDhw1dUacl+PSmGec/qpvFw8ZHsUarQmSlSA0zAWo6Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:47 +0800
Subject: [PATCH 11/11] arm64: defconfig: build in OCOTP ELE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-11-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281224; l=833;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=95/or8YNovtRYwaReL52ZgU1R6CLxV7qrF0J7lepSt8=;
 b=zfRoOdxdMRLA8Pzv29u3UhOIq3URwSC0B7mC0FM7v6H51/78XQHRkQo+ZD1epNNBImSXlH7Zh
 Y/WGnMU9S8XAQEFZZKim8YRy4IjOQCwGQryUTaQrjgnbB6FT6nbYjGj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f9c98a-feaa-4165-acf8-08dc5e28a072
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NAox48oz6ddYlNWqH5n/yXf2cLVgfbHPwOvXqunFSLDlcfzaSnx/tOn+aLmvLOgLrdGxoSfszwi9+WY9Eoq9exQWu2/KtpskeMqvzr4OBd3btxwTiuv2ewa9gWKfUGjF7TY2iEQbQQVhJQmVlZivAaktX108Y9fvHdWZ4Lj5XCCEjBLKMHvhPKVWrb8A3a0YFaMAfepMmImtdFd6S6YxyvF+tSo0c/zOES4xCN7Qnczgrw692oh/WblBSi23e2bFnnFNp19/O6AJFwbKBSlMLcKdDXWPY4VskhULE6bvL14MHc2qri5E19QFBfHkqIwsQqH7e+GCz3EUHYTFmn3PvrOI2ehYzGXMJr0AGKXZj+0bH6thU2kCWtM90o9ywg6eCXm+fpk7KLQrDSmdKVHo6js4gur5S70rrC4rWe3Mjl5f5RS1GzvLtlKyweUbEJSVZMR2l7ls5TPehMc986qiCqkLpKmcIADTuAqZa7VdND41hBnzzmNQr0RFnKwnSnsVoYc/jxL8/a4648LYVMbcMfaM1x0aIommr1wJTCePSb9rGvNGXQDmzctkl6eKdT2YoLvtoLyMHvRLtfukyO3szP+TJROuUqd8YsAfOeDGVwDebEqEGb7WsJYlKE7mVYKfwWrXGieOpa1tuIdfzLbYsufYwyuqrz1sTi8vW3hYcErxw4Za03FGHIYqmKtVU3jwtKhQHiuIVTSBD2uH/gOStPGuhX6BbBi5B2oogbmigZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDFmVkY0bnkwNmg5NjhGL0dVU1dkajRxVldTd0w2Vzh3RWpCVHhUdUNpLzNU?=
 =?utf-8?B?ZkRjZS9sSXlkZjdhZE5rZVhDZmZMaXdyRXZQeTR0TUtjeHFGSE9RVnBFYjRp?=
 =?utf-8?B?dmxDUDd3T1FpbkxnbFRiMnREU3hBcTBWVTdVUGhtS1huL3UvNStKNHdpb1pq?=
 =?utf-8?B?cmZtWTErWXBXZVlIY2F6VTJVMjJTSjhPZkdJd0cyS2RVb2srL1V0NDdMRTZk?=
 =?utf-8?B?V0hZN1U4TVJ3QW1ETDRHd0I5aTkveWR6RXNkbFk1bmp0SE1sWFpkaHRjMGQ0?=
 =?utf-8?B?aW9ob2VmZnYvT1ZZeHcxdS9iejRvNG51Zm5JaFMvZUR4WU94RUw5ZkNScDJy?=
 =?utf-8?B?czRsTkt1VTFNdksvWEUzSzFsMnZUMjNDWC8rWjZCQ0hwSWJlNm1XUVJMTWZC?=
 =?utf-8?B?Q3hCVW9JekFKbk5pUkRWUjFjZU1aTzhSODQzWm4wWllUeVpFK3V1RkRaaUJI?=
 =?utf-8?B?NlBLSkI0Q3pEakFwazhYa0xvQ2ZNODBWakNJUWovQTREVnU5VVk5blVYNWdY?=
 =?utf-8?B?RGtPa2NRRWdDZnkwbW5FRDlGa3M0bGJjemFqT2VoQzloU25QTURaZTQ1ZG5J?=
 =?utf-8?B?OE1rbXNFMVltQzFpNTV2OGk5ZlVnYjZPeitMSTZzU0RWTmRWM2V6bkFOU2c4?=
 =?utf-8?B?elJiMkN6STAxckJ3NUJZS1B2ZzA2K0V2d3RKV3Z2QTg5azFrdFl4Y2pXSnVh?=
 =?utf-8?B?Vll6RDlRWHhpaGhvd1RIQWhINWNocTJ6UmVITnRFSm00dVdlWG9WMmk3N3Uy?=
 =?utf-8?B?aWlEQ1ZCQmNvVVdZWGFZdnRaeVdYb0hoWmQ5N2hxaGxwbjRML2g5WWlSOW5G?=
 =?utf-8?B?OHQvV1BhckpMb2FTbVNOTU9pS3NESDRCMzVEZG9wMi95VmkwMjE3bUhsd3Y1?=
 =?utf-8?B?eWlHSUhVN2NyLzhRTm1zVXZVRTErV3hoOXB2ajlmN3FpNk9rRXZFMkJYVEZN?=
 =?utf-8?B?dDliK2FtQ3dqamU5eU5JelJMNmI2b3VzODRXcGRrQzFiVCtSVEVpeWM3OXhS?=
 =?utf-8?B?cXpCU040OW93QkdwWVlFR2dWb3ZWSkIvQm0yYUhDblMza3NjK21VSHBIampt?=
 =?utf-8?B?TDBpdEZOc3YyNkRPNWo4WGp4Z3N0djZ1RUxpMGdUZURPVU03bnVhN0F6ay93?=
 =?utf-8?B?NEI2aHhGVFVSNlorSTBCcXBvUURKRE1JR3JaNlJaOUZKY3ZlY3hnT083S285?=
 =?utf-8?B?OVhqLzZHamhzemc0U2VMR2hUZzlwY0pNYUFtMy9EaDBHYkFmUE5LZ1JPbEdC?=
 =?utf-8?B?R3lmN09tcTRwNTRkK1JaV2o0b0VCUG9IbDRhTUxTSFYrYVJCZi9nYkxlYUs4?=
 =?utf-8?B?dFNIQkFUdVNTSndmVGtnRGJLV1IyNDZHem1HQVlQaFd4NDY5VHpkUnZFTzc1?=
 =?utf-8?B?Z3JHU1d2UEFvNDJCRGVzZlR4eWFwSUsyS1JhbUpWaGZUNUV3YTUzdldDSDNP?=
 =?utf-8?B?WHRvUW5EZzFTT3ZNZWpjaU9Na1EzbXBQNm1wYVpPV25YWW5tRm8zZFhwNHA0?=
 =?utf-8?B?bHNrTFRzVTN6MnB4VHhqR2JzbTE3UmpVdllSYk4zOHd4bjBSRkNaaHp0MEcz?=
 =?utf-8?B?cEpvLzNmbWJObUtsaThFc092RUlaSXIyM3ppZkU5RXZIWTBOOWNlN1hMbkpK?=
 =?utf-8?B?QkhZN2pXci96MUU4MThISFk0Q3B2WmwwUjAzOVFWUUd3QTBxWkdOVGNSd1pp?=
 =?utf-8?B?VVczdnNyUDdEQzhKUk0rZjRzN1J5d0h6cmNjRlZ0bGtxUXgwbys3ZWNXczcv?=
 =?utf-8?B?dHdmRzBFVGNnV0VMU2xRM2UwMVV3QUcrRk82WjRLWERBQndBd2xoRUpaS05z?=
 =?utf-8?B?MTNPczlUN0lkL0FVZElVVjFqMkx0WHpHblI4T2IvRHByMS9GUkhFcmxIU2F5?=
 =?utf-8?B?REl4dEIvQ1lNcE93SDBDOURBU21sUGZuWW9OZ2VuSzVZNHhrR0lkb29JSE9z?=
 =?utf-8?B?TXFOUjFVTlpTcUdVL0dySG9rTjZ2VHp3M1pLREU1THdkM093ZVMzZ0Y3Q1pv?=
 =?utf-8?B?VW5IT3VXeFV5SXpkVERxVnNWN1Y2Zm8wTEFTd1huZ0Exem1SaDVVMkVHR0hE?=
 =?utf-8?B?bm55WlY2M0krRlZDUDE5NTVmY09haFBWdm5KbGRyQ09KbjIweVVPZ3lnc05H?=
 =?utf-8?Q?QDeCB8qJcz5VdEKn+3RwKfZEq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f9c98a-feaa-4165-acf8-08dc5e28a072
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:36.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGIh3/DPALUAZsFHC250zGWSC9rvcAzQicOJ7r9HNXNAtQRDaMmUDXi9n+SmlmUdqf6/t20n0ZxkYR+r+WJM2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

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


