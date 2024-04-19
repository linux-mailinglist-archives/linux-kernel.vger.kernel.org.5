Return-Path: <linux-kernel+bounces-150953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A068AA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B0428245B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061658BF7;
	Fri, 19 Apr 2024 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V6k+m86w"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316D37C;
	Fri, 19 Apr 2024 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497355; cv=fail; b=R073qmdQyIitElULa75MrYN4djkUsGKetMO83ZGG3ecHQhHkuI5QeojNDwhiiQPLDQEcL6LOV1ZE3OZLuBvIX2tivcbya0NnYY+Sh9Xfoqs8dmuBAjla8C+wYLnCw1NSldTpE+pMDDaLLHSmiIG2C+3F0BRDjq8oV9QLM4FM51Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497355; c=relaxed/simple;
	bh=rr5NYUWXjvV4jJZzKTBHcdIgsey8AYl6ydHkZ8yYU8E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bL9+xtaa1b33PE/yTtAGCjd0pXzhfFYObW6QNNn+DYN5e3kVnMXgUyI2ROvpp8scklwQDgKBl2KZRadvxjwpmAkcQsYWkdFP03oOtbfdI2u8X/dwoXlFUgL40hWb5pdYO2jXCpJmTWSmXgsBtSFhrK3CE/IP88nHv9rbsz1N2/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V6k+m86w; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llLaBVR0NQCELslv3H97JBAMZff7flHkFuygFYWQNaW5VsXzyh7cB/1MOLzovCO5IwHiY+oQTfi0XakWQkLcaS6fxjuriid9v7RBSdaKyhf/VxoB+JtIAiWlI1iciAFH8udPfOljXwOJpW5sn9pvGiVoZVoFZQxGQqxbhtSG4PNlKyFrxkSDDHcTj2ipMZX85uIQFAHdzVZR+K7FiMmc/4MKfnvdwWs8YtMJC+Iurhvca8kt60kLzPHdXDtPehvdh5b92ZOHkWIhVF7V8wAbSHZix0+hXOxNfSqs+GmCaQEfYv46G2vr5jPMxRz5TsueIfxDVZIPPxcqc9ujvhw5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGatrHSPqzsOX8j3v7C7NHDPUiqwfAqjGfAm6dWG0qY=;
 b=kXICE4BKqUeD0uHXS6kFMeT0Xr+yhyXIiXOjeaty9PBkDZQO0/imFo2LFQTd84OMdrn0UQc15LZtjsIqymEr6G39rmeA6F1U09lAnlSXEmvuPifjEViW17qLkRIG17L5zVMtsl3P5JU61GwXhtEmseADpN2jiukiFzNOqFwB6qXiWjQp0aiyLL3DJakLEPPz2yBlC1SOIsGaQLGsoKTEUG3geLJmxw2Q3UXN+WObTGwy0PrCZTbQ1bgjV7Tn0kkkqOualeauQG7RODLgyzuUhb+M94e68C0ny20iHJe23J2xv3ePGmaAa00KcVODYeqx+5e8rPxeJ2j/pN7CwrwfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGatrHSPqzsOX8j3v7C7NHDPUiqwfAqjGfAm6dWG0qY=;
 b=V6k+m86wYvwwa4WU/WtVqHJBwHPTg4G0wDnJ8O/fsnFcYk6bhzHKyYODGBt6eKowTOAZBUAGMycNtyfcpQh8BWr9jlMCleshzE9VOloyVqi5ks9Mxv5SlDr1AN0SPlCXY5GeOcRmNXd926wWQ0vOdusLIi6d/Dh/QY/OL7EwxfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/12] arm64: dts: imx93: various update
Date: Fri, 19 Apr 2024 11:36:55 +0800
Message-Id: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfmIWYC/13NTQrDIBCG4auEWXeKf4TYVe9RsrBqmlnEBA1iC
 d69NtBNl+8H88wByUfyCW7dAdFnSrSGFuLSgZ1NeHkk1xoEE4opLpGWoiW6PaHClj1zWlo9cfs
 U0I626CcqJ/gYW8+U9jW+Tz/z7/qj+n8qc2TozGAsE35ov+6hbFe7LjDWWj9y/L9HqgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, 
 Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=1868;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rr5NYUWXjvV4jJZzKTBHcdIgsey8AYl6ydHkZ8yYU8E=;
 b=xNLOFetVKNmeGNVofGqZXujm1dkvBVh/ta1MB9qGJryEofQrXyIDeAN0c/RSHLHSmpsiIBJkk
 0f3zqMYujTTCth13v43tZ3osdla7158PfHnMxwhE14iqVjJ5JkWAIjA
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4233f0fd-b02f-4621-86c4-08dc6020e043
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w6hBH4fNiaL1L940OM9u8d+yo1ZiJSG9WUF3QarBpMpXErxx1DZnnA6RqylIbMz+TBrTrnVtrJbYtC6MoGLKGvLoQF+hbL47B+AqAZc9lR8TvBvMEC7rWcUQ14VVZ/5FwUrwvBDhw/f3JabhVFTSno2QtuuoApx+dMXwqOHuKFAvLuywIXrZeA0mMIXv9ugGVbp3373KvzlM53z0HoeThrc7zYG+L86dhBmVQIYKarstbo0Nmmcl+FeC2OggrvslDYD7MCClXI/7IeDnsNvl62FAiwYvjHIyixQN7yOdMieshEE38BWKhU/ilrK8uaR9/IlfPmJYUkIJkwJcKjAmR0fAJ+Xa28kL6U+eYvTQnK+xlyLBUXJW4bJyFFbz9kijQBEQ/yA7PTacXBADBvdHo2C3T5gwaB2IybDDSgMrcCA8SKcobWGKpK0uzexAj+AxwKNiG1+gBX9uVkzLRGBrKJrK0eMEbqv9J3ztj4KUtkBkaM782lCx2KKc7R4xKAzx9t0Z2ImEGd6k/Xa2ihGnvUUkCd+DqvoYRg2qeeshgrCAaULlue3b1+38XVkWZ9ayZYO+yRya59BwVaYSuJCM8zGglNu5st3Z+X1f4QdWDhFWRpy93wORMzH7AIOmF05pPUaHcIt35hyaWyZIJoUi4ienI6PCEIQ5LhY6oH6cpVLKwmlVCM60HoGT6iyIA4C3GISoPm+oqQ6kqPOLOiwadT5f8MeNFRjE5kzG6tSCGHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXkrOUtSekcrRnBtYUhPU0dkVEFRMHZaN2pLalJUeVdxbmFoTnYwZExxM0Fs?=
 =?utf-8?B?WUpDRHZHMlA2cGNLa29IaFVpSitlSWxJVVlYbllLc0s2V1U1WWljdEdZVEM3?=
 =?utf-8?B?blBOQ2RGeXNiNnB0dDVPTGFsWk1PN1JLTUVtaFJtTHZjdzhaR0diWUMvd2hu?=
 =?utf-8?B?eUt3UFFzVmZoR3JNcEhLbWVyV29aYmlXbFdFM3F6VUhmQTBUalFWQmVpZUpx?=
 =?utf-8?B?VGY5TldjMHdJVXVSZWNZQXZacWhScjFDRlJWVWl3UzcyNGtRU3dBTkVNek41?=
 =?utf-8?B?TnAvOU9hcEhQQXg2c2xMa2M2dzVVZFJIeVhNSGpNR0had09ud3dKUEdKN1BE?=
 =?utf-8?B?SnNHZHBYczZRUmtBbUtTM1d5aXlET3VHcmR5U1JCN1BWZjEwY1VHZDhudXp6?=
 =?utf-8?B?VTMzUVlmYWdyb2hWS0tPSU1IY3E3TVlUV25QTTk4ZVRuOHJvU2VYQXBTNndF?=
 =?utf-8?B?STNQMnp2aitkcjVaWE1zQzFnVHhVWEQ0SGVTWjAweGFtVnhXUjhoTGFhQmxD?=
 =?utf-8?B?dHpBUVVOQVhoV2l4c3NxUHFTYkhJZGRlaWJFMnpXVzhONzBqUDI1VG40NER1?=
 =?utf-8?B?dHdtb3c4YWtzUUUzemFpbmFYZ1JiUGUyaTFUalFRd0pSOUcydjByWnRkNUhL?=
 =?utf-8?B?Vk5vZExBY3lxV1JmVVNpdm5GQkoyMXhTcmtUMGJmQ2NRSGF0cVhDVnpkd3lF?=
 =?utf-8?B?WGd0OHZpSS83aXh5dFM3bW1sK0dCYklnNDFqb3Y0VmNPZWIxUHZLbk9HMkEy?=
 =?utf-8?B?UzM2aHFCTDZiT3VKZ3RHc0crOGw5U1dFanFrK05OZGg4RTJaZW41OThIVy9Z?=
 =?utf-8?B?WkJnWjFSOFluczZXQ05TU1MxdjJRUi9CekE1SEtNdllleVBPRDdjQ2lEMG92?=
 =?utf-8?B?Z0dUY2IwbEw3Z0tpUzQ2TG9EUXlBeUVoa3IvRjJyVGs5b0JQYi93amdQeGR5?=
 =?utf-8?B?dGlKVkViRnBTRExiMjdmZGE3YjdzbWIyYlpZYWI3TUgrRjNMdmYyak5mRnNa?=
 =?utf-8?B?eDUyUER5YWFkS0J1UW5YNkFuL0h5dkk5L3A0T1kvZVIza0VGSTJmSmhDRzdi?=
 =?utf-8?B?MXorQ2h4Wmkvb0s5MDV4Qm1QdzQ2czNaM1U0bXZEVXByTVN3YjFucWR3clZD?=
 =?utf-8?B?M1VVMXM5bFpEbGV1NFJpMi9VQTZrQkx2RW9rSEJWaHJjL2cxVkw0dFZha2E4?=
 =?utf-8?B?aVU3dWRabkRDaHF4cFdOOHlaVTllZDA4ZXExU0IyeFp1T05aVEd1aDRWVFd6?=
 =?utf-8?B?Z1gyeUNlT2M1ZXowT05tSWgwUnYreVVzUm1KbTlybTBxVGhPNFhiT284RkIv?=
 =?utf-8?B?K2M2bTFFVVRvOWcrWFF1aytiWll1RUFMSWp2MGlOYmtWQXdOeXJKZ0tieCs0?=
 =?utf-8?B?RXRXekM5akZxUUxUSzFCRFhwNVRKMS9ES0hGU2UxMUtEcmg4bi85VW9Hb2R5?=
 =?utf-8?B?SXdWVHl1NWlHdTQ0UVpndmw2Lzd2bmxEeFZxZ09xWFdvSlNzU1E4T1I3eDJv?=
 =?utf-8?B?ZmJKa2FaVUpmQ3hVRklqZUhKcUtRcHZ3Q0hlMkxvN3lObzJtL21ia0J0MW5q?=
 =?utf-8?B?MXlhY0pFNzJrVWpBT2o5c0kwN2VyRzB0ZXdxZ1JKMk9pb21ValIwZDU5NnR4?=
 =?utf-8?B?bnU3djhSUDIwcTdnNld2L2JWNGErQ2hML0VMUmRCYnhZOVJ4ZXQxMGU5OXoz?=
 =?utf-8?B?MHhLOWR3K2kxUGs5Y2t4S0hXT3luRTFHNTdKdk1ocW9TS1U1elBOU1h6WkJE?=
 =?utf-8?B?bHVKOHFCYVc0NUFyRkxYMUVhNFk4NXExODZ2SGFmMGs0NjAwRVJhaVRseWRo?=
 =?utf-8?B?bWRQY0Nrdm03QTdEaE0xeTR2V0F4VWNZd3BJdlU5TkpDNm5WNy95UlQzeGhF?=
 =?utf-8?B?NTZXdldzRGdwdFBvTGVmZmtSTUMvRkpkSUh5c3JpdERJbUZWbHhZYWQyWVJr?=
 =?utf-8?B?MnJyanpNVmZyOXJCd0cxdnd5WG00S21MbFBESmd5dDNFbmlZbFl3ZS9saUVB?=
 =?utf-8?B?Zk5TOWxvTXRXZHlZVzNldkpoT3JkQS8yOFFGZkF3RW1oaitxZnVRZ2dmRE1N?=
 =?utf-8?B?VU90Ny81SjV1ZTNyNDg2VkpWNG9xTGM5VGIxUjZlZmdjZFgrN3ZjWC9uaTE5?=
 =?utf-8?Q?1BYKb6v1rjwreqyHQqzsPtGCc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4233f0fd-b02f-4621-86c4-08dc6020e043
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:10.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdK2qrHzPiCIQetu/eRoNs0p5sZRPCey/TX6Gvc8E+etcA8lyvHkeXMrrJ4pNJyLlvPbbLL2m+pQuCYBcY5Apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

This patchset has several updates in imx93 dtsi and imx93-11x11-evk dts
- add dma for lpspi/lpi2c
- add nvmem for fec/eqos
- update sdhc assigned clocks
- update resource table for m33
- add sleep pinctrl
- add reset gpios for network phys
- includes a defconfig patch to build in OCOTP ELE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add new patch 1 to convert dma bit mask to FSL_EDMA_RX
- Use FSL_EDMA_RX for patch 2,3
- Update commit log for patch 7. Add Fixes tag for patch 7.
- Link to v1: https://lore.kernel.org/r/20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com

---
Haibo Chen (1):
      arm64: dts: imx93: assign usdhc[1..3] root clock to 400MHz

Luke Wang (1):
      arm64: dts: imx93-11x11-evk: add different usdhc pinctrl for different timing usage

Peng Fan (9):
      arm64: dts: imx93: use FSL_EDMA_RX for rx channel
      arm64: dts: imx93: add dma support for lpi2c[1..8]
      arm64: dts: imx93: add dma support for lpspi[1..8]
      arm64: dts: imx93: add nvmem property for fec1
      arm64: dts: imx93: add nvmem property for eqos
      arm64: dts: imx93-11x11-evk: update resource table address
      arm64: dts: imx93-11x11-evk: add sleep pinctrl for eqos and fec
      arm64: dts: imx93-11x11-evk: add sleep pinctrl for sdhc2
      arm64: defconfig: build in OCOTP ELE

Wei Fang (1):
      arm64: dts: imx93-11x11-evk: add reset gpios for ethernet PHYs

 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 146 ++++++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx93.dtsi          |  79 ++++++++++--
 arch/arm64/configs/defconfig                      |   2 +-
 3 files changed, 204 insertions(+), 23 deletions(-)
---
base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
change-id: 20240413-imx93-dts-4-13-60d93c9f1cb2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


