Return-Path: <linux-kernel+bounces-132989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81A899CF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4251288016
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BE1E52C;
	Fri,  5 Apr 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L8K6jwbQ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2098.outbound.protection.outlook.com [40.107.14.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68F16C879;
	Fri,  5 Apr 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320303; cv=fail; b=ABwn599san+K2DZps4Ss8fwpJyGgl5FBhFFFPNGGo1hWcAqNZ0rqi/vq3kTnVPR0s5ER6fh8+vURZke8/9GAMDFE5DP75xaAPevGTZY5neom2ryWktAa5/Bo29U/7I8KeXVvigdi3cN+ksd50Tx+x4sbit1WGmIVpewtPHQBmGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320303; c=relaxed/simple;
	bh=dOBkgjs/jb/HONnQGf/3KjMH4BWduYVwov2hTsuR/Og=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=e4pRvTz/caCRB8Eoa1rgldKpN3WLMnV6ixMRWVgL0QPPnQLskNgZUlBS+6phJo7R92NP7sLM6qGQmkDzyEkbeYuuhHkl7OJ3Iiwpk6NDroUw3Yn/zxAVGfTVSNUT6CEALDepoFchZYcQ2gOI1BNN0hn6/18MJob/3vmpyLUYMzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L8K6jwbQ; arc=fail smtp.client-ip=40.107.14.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0lrr1pSjw/mx2qSRX0dqvgJSxtacwifQgnLjkDAalYZJu5BW1FchtvMLg7LGrB17bwGKBxbFJsv1L7qrShNjGnz2Lediqv1wbCx3Vj7cjNvpOHoP4sXGVQzk640tOtu8HcEe9YXpr/Acf0Fhr2p7Lqhnp34KmSmnLPjlTVqRnImWS0MAPNnq6BK/6jMkgtq131oMsx0pdH3pckDKMiZk9r1gqmX1U3/kcnfoXaiAlAIDlxgOcVApT/4b+8BjUwFPl00Q2rEeMgjhkNuHgZkrLRGgCCPaRepz6WzMIE6O3/omkralD336VU22rM00TXf6BBLSVWdHcPbUMnK7qAXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7r/QbCh6yxfaNa2Ama41YWrsrix2m0n5/CpYxO2YqQ=;
 b=HuJ0iB+LVRlE+MD8YaFJRIDvzZCpb+mUJ2lMaI9kG5VVB/JExe2LmC90xA28Px4VSr5DT9AsGcLblFfcOHaYw42dSVqQ/B6K/CU+VF1ZxCUxTpVCg/NNkd9gvGmL6h7hgQ/fHJtdabpXQwQNvSymoEHTFPxUVU6S7AI3YCgsGltSz/Y5pvQu9MVLLL/rHewNZGWs0FydxbT7SpjbtnFIdF4v1S3CjaVHjAOhgdeYvihjFJ6MkKCgp6Xgs8KQZzRh7hBYSSpNkv7m0M0ysL8+XthwuRyAeh+AqbUy/wotZN2NBCa1RwRes00VIMQUj+1Yel1Dl2b5H//sJk5JhMQf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7r/QbCh6yxfaNa2Ama41YWrsrix2m0n5/CpYxO2YqQ=;
 b=L8K6jwbQa1KuR3d2P8fTnLo8UFHonHf3/0eHLB7lRcEqcETbCCSSCPqa0Vbg2CLieb4KVVqq+tRH3Wmq3fEmCyQRfyUk01coWTZ3NZlj5mtDncBnGcsaZfNPqTAjjJxpvEboHLLw7R7zWH7Ridh+WvJCyynmjnr/iC96q3Gy1i0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:31:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/6] firmware: support i.MX95 SCMI BBM/MISC Extenstion
Date: Fri, 05 Apr 2024 20:39:22 +0800
Message-Id: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPrwD2YC/x3MTQqAIBBA4avIrBuQQRd2lWjhz1Sz0EJBgujuS
 ctv8d4Djatwg1k9ULlLk7MM0KQgHr7sjJKGgTQZbbRFybezGELGLC1iJwyWXSLjUzQEo7sqb3L
 /z2V93w8VX8hQYwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=2568;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dOBkgjs/jb/HONnQGf/3KjMH4BWduYVwov2hTsuR/Og=;
 b=TK8qY4ZqbMBehn5Ahf1xeSB9pvdYdp1Gbudq3FAA1jfADeGIzYrFTCr9xomhCaxg7YxvlWo2Z
 FVkfnEATm/aD/v8rZJpjsp/pwap3G8WV/tiFhQRWF7f3jp/1DGdU9//
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pdif9JdbFNt70bh7vLKKQMBVjM3GJ9503/0mc+FBl3/6lhOt8wGcY2kkML07GrJyk17OQ6k8VT77LIbWMc7sneYHcaacLCMcAvrMFodUDn+q6p0fTpM81ouLy9JmZ35FLwtqJfTnhC01my2NqrKJjBbCbGPA6r/dUR0DfTnyxAr/is+i+n0p8HB4qlNcUHFWOuKEkELFjFHE1aYd9Xu6MkdnLFMUck8BQCxbfaHn3mdTbb2cXIzQqgYyGjq8o7dP0ituP0ajGT9x4mZfDq+eUzESWFt8z3C284Kt4JBETMioqXK7sbTuv3OxG6XkMwTK1zWebWxpDpRvJuQ/qYgB9+NZ7EE4NC7jlpaMjxWb/X2g2IRYfHgREqAMOVe2TC4SJn19+5jDK9N/lVhlUdKjawXXgij+oySkF0DoltyXfX7qm7vJ5aAwyS/0EUR5Qc/xaDaNSV3Zel/X8tu7PCXB6/m5q9TE42oNqmsXTLRv3xeK4AU/UapYEWGIaGjI5grXm2HjH2EuMBMacX8831xJkNHA4jrVVtlI4rkHoKjevtHB8/zFq87yO2Q2+4nwhEBUI9sh2AYnRuWKUeFPS/OWRVQnJ6EA7UWPHycGbmfrGTtAR5ZFF2nm0iBfhVCKemT6Dv7V0gilg//6QmgsdUGe9aRIC2heJ6pHYinkGYXO7t0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlIMUQwMTlNQWEwaEw4SXhkcG9Bb3F4VHZESk9GM0hTdnVDRnFOS1hzVFF5?=
 =?utf-8?B?RnJTTDVrRXNzRFBRYTZoRzdENDJLNlh2MzVyeThaMVZ1QlFta3JFUFh1OXV2?=
 =?utf-8?B?YnJxekpvb05obVhLd2tHTUhmOUZGSXVML0t0b0g1T1V4KzA1dlpkMHo4UTdP?=
 =?utf-8?B?ZWJNQW1OcllaYndkajA2WDRiRit1TWJXTE1hSGlqOW5wb2l3czJMQmhrQ1pi?=
 =?utf-8?B?WUdYNmFFVlcwSWc3cU5LNjVVaEhUbndrQ1Q4TXQ2STBoS1RiVTFqN3lzY1Fx?=
 =?utf-8?B?WFgwREpQY0JTVmRycGIwTFBUTHNCUERyaDJsMWJFcjNnNnkrZ2VSckVDZWlV?=
 =?utf-8?B?cG9vWEJwd0V6SHJoSjRBRUJLMHZ0NVFoaDduaEV3SGMwdm15ZEdtNDJEeDRi?=
 =?utf-8?B?TTBFaUwySXYrYWE3UnJXL2VXYU5WSDI2QzZsWnpkZmhuajBZaWpPcmpwR3c4?=
 =?utf-8?B?ZG01ZkQ1UEJONzFsaDd4MFcrWG9SczFUZDVIbEMxU25yOElYdlgzRkIyZ3d3?=
 =?utf-8?B?cEVyMktJVlFVNXpZSWpoZHJIVnJYbWY4M2tmOGJESjdWU3ZRMUx2aWNsZER4?=
 =?utf-8?B?UXovNEg1RU0rWVMwa3UxbkplMzdzTENoMXB1M1cwclpUc3lJRW41eXNNQXNI?=
 =?utf-8?B?cmdPNHdpTGNiQUVMdndkUGJoRk5RNUVOWFJuR3V1MmZFanJMaDU3enJibmlR?=
 =?utf-8?B?aVVMYXZiY092b0lwUFBsSjg1WUh0Z1IzU3lJNWVld2QwSmlwRWxtdVdrcDkx?=
 =?utf-8?B?ZW1aUkh0T09udUJJekIyMno1cVNOMWMvK2JUK29zVHR5dG9ZNVg4NDFBWUhW?=
 =?utf-8?B?c29obHlkWnJ3Zk96amljbDVIZVdTZFBYWmhqeS9mbm5MZzhYWWRXZlBFbStP?=
 =?utf-8?B?TEx5ZkJ3ZTVPcnl1aHEzZTc4ci9OdkRKcDdoT1hlNmF0WXZISTEzcnpNOUU0?=
 =?utf-8?B?NWtxTWl0Y2xybTEzWG0xT1dYdUpsakJUc1dqbjJIcUpJYTVpU0N3NkgvM2VL?=
 =?utf-8?B?LytFejhnUVVHdHdqU2syM2FZNjduaE91cmxzb2UwenVVTGFlK1FJalIvVGVZ?=
 =?utf-8?B?ZjhHcUhicWJ1QUI3YkNLbG1wTHFpZ1BRRS9ERDFiVXBYSnlnRTZHUTEvZ3Vu?=
 =?utf-8?B?OXErOHhZQzhEVnFVTjEvclBlOVpSdVF1ZU1hRGlpNjJuc3hENjI3aVVLSDA2?=
 =?utf-8?B?U1BWcEhjeXdlRmJyRUNVYzlaMmVyQWlVd0Rkd2lnVXY3NzFSN0E5RUxkcGJt?=
 =?utf-8?B?eHBlMWlCUURSdEtXNDkwd1A1WElOZVpudloxRFlkK2hJNENLKy9Wa2FKUnM3?=
 =?utf-8?B?cVR0M3B3TnBKRy85bHo0NkV4MnljbjRId3ZreFhZNlgwS3dxekQ2cHpybmpO?=
 =?utf-8?B?U3ZLU1l1U2paUVNiY3RoQXp1cmFTaGpGNGpLRzZPZlBHTTdOK0cxZDVwcnFy?=
 =?utf-8?B?dGVRYXdqVmhhSFZra3YvMWM2MFpqTzJEQ1RSMUhGc2JJWm1DeDY1ekJnRUFP?=
 =?utf-8?B?ZGFpSlNQaEhEaml0VWRkbzVkOEV1S3l4czhmR2V1OTdRaUNhKy9NWE5aM25C?=
 =?utf-8?B?eG9DWkQzK2VkOUg0eWR4Ync3d3pMMGFhU3VSRDFGWGQ1ZVp2RHRHRnFlNW1F?=
 =?utf-8?B?ZUJGZGNUcUpsellicTNCMmE1NG9EbHpXbG9SNGZGMGluaytvb2taVWZETkR4?=
 =?utf-8?B?clZNRjQ2bmZqNmNYQmgvWmsybFVXNzNVWXZER0xYOStnMFRhZ3JoSUwreGtj?=
 =?utf-8?B?cStVNWFJV2FEcE5pTnZlV3BsQ2t1dTN0YjJockgvSmtrWkQrclJlL1hIaFE4?=
 =?utf-8?B?NUo1RWt5a01jZmRFWWRkRHF2M0VwbmFZZUFjbEhXazdRMnpJZ2prNXd0YURx?=
 =?utf-8?B?bGZTWkN6ZFRIUUQvUWJGckh1SzFiYVpRWlpzQnA2RkVWcVVGaXhPOUk5Q21F?=
 =?utf-8?B?QmIweFFrSGJPYlA5YTdwaTFXSHkyRkhUVGJtL2hyci9rQVE3RGpqQXNZSXB2?=
 =?utf-8?B?VWcyU3lMSGJBY0R5U3RMOS9GR3FMYUt0RTcrUXBtYStHaTYyMDNoNml3dkVl?=
 =?utf-8?B?bUV4VkxaY2p4WEFCT05GVnRWRUFLa1c1RDRSV0NuNVFNM0FMc3JJUTlzWmtl?=
 =?utf-8?Q?1NRMCvFXJo4M/5xeLmE/8vIT3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c838cc8-4ddc-41c0-cbc7-08dc556c560e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:37.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8RSrtnnEazJlZ5dgBgh3dODl+JY+jJmmYNnCdgi1ZLEClBNVVzAmxt5Q1a0ISIgRORxPQOg59NYfrRlkzCRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

i.MX95 System Manager Firmware support vendor extension protocol:
- Battery Backed Module(BBM) Protocol for RTC and BUTTON feature.
- MISC Protocol for misc settings, such as BLK CTRL GPR settings, GPIO
expander settings.

This patchset is to support the two protocols and users that use the
protocols.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Changes in v2:
- Sorry for late update since v1.
- Add a new patch 1
- Address imx,scmi.yaml issues
- Address comments for imx-sm-bbm.c and imx-sm-misc.c
- I not add vendor id since related patches not landed in linux-next.
- Link to v1: https://lore.kernel.org/r/20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com

---
Peng Fan (6):
      dt-bindings: firmware: arm,scmi: set additionalProperties to true
      dt-bindings: firmware: add i.MX SCMI Extension protocol
      firmware: arm_scmi: add initial support for i.MX BBM protocol
      firmware: arm_scmi: add initial support for i.MX MISC protocol
      firmware: imx: support BBM module
      firmware: imx: add i.MX95 MISC driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |   2 +-
 .../devicetree/bindings/firmware/imx,scmi.yaml     |  80 +++++
 drivers/firmware/arm_scmi/Kconfig                  |  20 ++
 drivers/firmware/arm_scmi/Makefile                 |   2 +
 drivers/firmware/arm_scmi/imx-sm-bbm.c             | 378 +++++++++++++++++++++
 drivers/firmware/arm_scmi/imx-sm-misc.c            | 305 +++++++++++++++++
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/sm-bbm.c                      | 317 +++++++++++++++++
 drivers/firmware/imx/sm-misc.c                     |  92 +++++
 include/linux/firmware/imx/sm.h                    |  33 ++
 include/linux/scmi_imx_protocol.h                  |  62 ++++
 11 files changed, 1292 insertions(+), 1 deletion(-)
---
base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
change-id: 20240405-imx95-bbm-misc-v2-b5e9d24adc42

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


