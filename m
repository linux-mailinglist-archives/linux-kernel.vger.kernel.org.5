Return-Path: <linux-kernel+bounces-60816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE38509D7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5352828245D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F175BAC0;
	Sun, 11 Feb 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="JAdL1bIK"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA75B5C5;
	Sun, 11 Feb 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664083; cv=fail; b=j/Ly6fC8Da8tLGiLHb4r9yIwAfFoRswOX4lBGzCJByjbLyLdP1binvRB14UY7viGaBNbJMU4ojfKPeApJty9oh6CoG9bQf/4ZEVBEUwUZetKpGt4bjn+UC5b9j9UBGHdXKg/O0t057j887S3ArnG4aXg+myppyrjjpiJbI3New0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664083; c=relaxed/simple;
	bh=/AFhwce9jy00uSMBqBN1uM60wnY3CtRqra+U5vm2Qik=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uQ+vARhDHAxcyGByu5uswhNOGLHhVc9FPRkIvLEIVKNtT2zu4vwwkJjFc00CIAVLxfE/NA9M3gWjYUz6RZNMzNPmO0ExzMkE5ExlBs5gCbAW9Ei7Z9bFKcGjL/LJ9TBPXRD3hv0gHKpdx18Zw0w5vf4RgPuus1jEGrorA2HPKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=JAdL1bIK; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDVySquCHdk3av/l7FD4cBYEhi/fsCAr/gU5TFFnHXqOwLwK4ktjxlw/MZYJNda9HuneGkKARDEHpy2E5HwrMobwUbMvbL8Y5c0slJ6RVtfgClEsnTqjBB9l2+4KCNnhoRjNgIA23rMrGSWe9CWXUkw1ptmnSkcoF5105pll14QKIG6H7qyaYYK8q6O+3RhgXNeITo9lE/jttz5kkLQHECuse/aXkhktXWE/1IUL66Mv5mRpXojWQa/B+aX+KaFnz+3GepMgM8oMRyYj8W2U7R5XH4UxJTmCSFKpdDGssESoYfVaDpdwomS/9uM9C5wQh2Z3wWhltoNVBGcZcuZA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=FXtXRgzXniMvNtxKwYrjsmNF53NL3zlSulBOL9POul0kZmEFyKuCP6U5SG4F1IXi33GPSov0IelBqIT12sjIhgH/o79lIRAeSPOGYKj3dTtguEIxAUNP5wDsV1HBNMHNHQiqnL+zwtGsAEKyiUxJ0YtpoFh/u2oXhrfX3lJsgmb30Ypx3V3MyL8TkivjHI0aZ2ANB8+TrbDhtrgYgXTsRdGeHq+VH1Rr3kSk7g6Q6S0ArM+S//PNs1+CfSgLK+4hJGPO/MuOY+Wz7jRHMWBxqOH2bwxmVWuIpFJVerukLQXlDto0aKrdfKrq5MxfKMi3jrDbD/NZ1XygiTkZk3zSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=JAdL1bIK1YMun6EZk7tnRRIHJ7ISI80UltOmoZqGhZ0AyVgB3n8cPXnO2XZRLdViteuyts3+mkqRaFe/J25UKMmicHFWrSfDyQqryF+WWl/D1kCId9dfFUWuDVox+8YVegSpm3cn1AjM437s0GnB659dpPRDATRtENhcCC0l1hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 15:07:58 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 15:07:58 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 11 Feb 2024 16:07:56 +0100
Subject: [PATCH v5 1/5] dt-bindings: arm: ti: Add bindings for SolidRun
 AM642 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-add-am64-som-v5-1-790ed7121249@solid-run.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
In-Reply-To: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: b12b61d5-c78d-4dec-333d-08dc2b133bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AaXS4XAM4rv3roNS/onONJitgfXdKIVoJshkBm1G51CsELdfYLA9f56dZmIvws7Aq5o6ZZIYj2401OWV4eEsY+1kai0zvtCmQ5Q9pzHpDj1cGL32drbX6ZvQjjon/Hueu61kC5ax1vkM90ZgoU4cs6IT0+axCZ1+g36LO5GztqYuWrt79anvaBws+auzimk3rC8br/Ctxx4jLXHXu90NqG0/wFDASTdqDci8H4DT3ctbS+o4+AI2/flLXpcSArQufAjhc+WUZcJCo7dgH8hUqiG+hfjspUTOaZpcxE0btX8gfkhaDXn/cgJXM0GJPFd0/kx2TRJHLi8yfEhCOCBjbXOmSPlCpMW9RR+UDlMKg/q4Uug1uO/Kfj9j1M5NRzljZ+43wmmm4mBVgJ+K73kftP7UFLvydjbBrsRVB+HLb6PbpK0WfYFcRlmLJtt9kxPrmLSHGN399lusn63vFoY5J06pXW1Gna/9PXw6ojZlhmXSqOkLtocJA+SnhIwUQLJya8bLJ+YObO3ZK/34FZhxL6B+aps7gUojSzfBUj4Uor8s+ySmpiB4z5LrINx9ZjihhrGee1vBPfZvnVxalVsU+fsUC6BGtoWcEj8zKGFlufFWasLN1/rZGhUQhgRPc6ng
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(2616005)(316002)(36756003)(6512007)(6486002)(66476007)(66946007)(8676002)(54906003)(478600001)(52116002)(6506007)(66556008)(38350700005)(4326008)(8936002)(86362001)(38100700002)(110136005)(26005)(5660300002)(2906002)(4744005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFWQU0zbGdkLzcra2w2aDVLSVBoUStoMnBkNWloNC8zNVNId1lkVjZnRDFI?=
 =?utf-8?B?UVZMTmg3Y1h0YktPTHhiTW53bE5zSWF4SkZ2bElOWW1EdE1QdDV4OEc1NUc3?=
 =?utf-8?B?b3ozb2RKZ2QxV0JKSEpBM2ZXUUkwdThONTRTMmxOTTFJSUp5YmpKK3N2cTd1?=
 =?utf-8?B?Vkd2R2NBWWw4YlRZWFRSRFBQdHMvcGJlMExkWmU0aC9Gb2VQT0hRTEtjUG44?=
 =?utf-8?B?Z3NvenM5eC9yVTBUS1VKbEprTXNuazYyZDc0Q2hncUp2NEdLNFBXeVJGcVJ6?=
 =?utf-8?B?RldRL2RuMjVmQVJ0aFdlelBRVEdlZXh0T0pUeWVQcmxRclZJQzh2MXEzcWJ5?=
 =?utf-8?B?clVoTEFTWGV6YlFVajd3dS9iSlBQS29kRVl3VGlhRmVpVnUvZ1ExTFNIdTE3?=
 =?utf-8?B?SzhWMHNtTDdWRHVDY1l0Y0VqNmMvdncwQVBMMTI5L3czaGQ5Zml2LzlLUEhq?=
 =?utf-8?B?dW13TVRxeEtxTmJuVVgwZWtqMSthc2RaNEpzbUJMcktkYjNVSEZjK09tSTdH?=
 =?utf-8?B?YzVJL0FVZ0lBRzVjQzdzekJORXJzVVZieDFKWmEwNVh5aHlPcEdwZFZSK3or?=
 =?utf-8?B?OFY1R2xEZldoMWV6VkJRVWptU3dZSmpQUWVSVDBvU254ZmEyMFpRNVZPc0dq?=
 =?utf-8?B?eXlYdDBSUlVYWW5oY0VLM0FBTWkvK3NsWlJQWms2RENEMFBVY083ZTdON1VM?=
 =?utf-8?B?YVA2WDQ2WmtzK0dkSEJmTzJSb3UvZTh1ZWJnamdsdmxzOExOUFNvWjNEc3Zn?=
 =?utf-8?B?bVdVZFBEaDI1UUFkaHlGdjNOSHphYlFGMkhzbUE2WWZaRTRocDdSTVptMzA0?=
 =?utf-8?B?OStWaXpWRUorOEtwUCtSNyszZVgyLzNLVXRBQVJ0VTdkdjFaQTVCbkJmMFpQ?=
 =?utf-8?B?b0hWNm5HNy93UjFBK3RFemVHdmozdjFPNzczMGdUR0t1TXdTNXNWOWJ0VGhq?=
 =?utf-8?B?WGQ2SW5jOUpuNHNZd2ZoTy96MmVqT3UwbWtGZ2NwdDVlblhhTFdIKzY4Szkx?=
 =?utf-8?B?U1pYeU00RExlUTNlazBhUTRxNXFLeVU3eEJrVi9YNXNTOFBSVFR0U1VQeURS?=
 =?utf-8?B?ZlFxemJxTkNGMEtManRpV1pkNDQ3MThDWEExYlVyMG1RUWk2NDlPNm16NWV3?=
 =?utf-8?B?TjUxWnlOUC9hN1FHb2JxNUQySGdOWmVyNjdML09xUERBM3dDRXhEWXZacUl2?=
 =?utf-8?B?Wmx0K0diOWJSaUtLZ092N3JFMnhFeEptL0M4aCtIYmtxbzZNUVJjTXNIcVBO?=
 =?utf-8?B?alRjU0UrQmhic29TV2FlZTFmS0o2emVmK24zcEtBWW9oa2pRaG5nMVVTSUtq?=
 =?utf-8?B?VFpUNGdRUi81UDA3ZjRIUXJyQWpOT2dnRCtiT2xQZmQvZ0M5K1RpY284V0JN?=
 =?utf-8?B?UUhnTTdwbjUyZ0hmZFp4NC94a3ZFT2U2NFJ5eUdzNGkyVmRsMU0rODRtNTVv?=
 =?utf-8?B?V0FXb1RTTHAwSGRnMW9hL080WTljQ3kxMlh4aURySFZZZkdnL0xYL1NEeURi?=
 =?utf-8?B?NlVsWXVIS3hIZTg4c0thZERuUzhZdTYybUUxYmZzWVZPY0Z0N2dlZWFMV2VN?=
 =?utf-8?B?NjdWZFhVMWVaTnF1b3RsQ3VVZjZTdlVoNmdTblBGZWVoZzBsN1BUVjRVZmo4?=
 =?utf-8?B?ZVBZUlk4NWk4U3FKUk80S2l5UTdBd1Zzd0pyN0tJTVF3anNVc0FXZE5OWlBn?=
 =?utf-8?B?YW9zakxjZUhZYmtqRXQzTFVlYlErYXNLcytVTTVoYjBud1NmN1FxR2E4ZnJB?=
 =?utf-8?B?S0hJc3pucGpVRVZkUk5QVVk4ZXRGbm4xaGxhaXV1Z1IwbWlBalZnUTNGdlNR?=
 =?utf-8?B?MGUzdVhhY3JqKzNCSG9wd0NYb1dTREtRRG9Fek5iWHhTVWViWHdIZWRZL013?=
 =?utf-8?B?RkdSa0gvZkp1OUVYcDloL0xVZ0dhcnQxcDNiTERXZVBKeUJTc2g3MzNaSnRy?=
 =?utf-8?B?Q1ZobVIyZlZwM0I3OE1vUWduOTljQjR1NjZXVGc5czhQQXRGaHBzMm1SbHJG?=
 =?utf-8?B?c2oxT1k3NWpCMGVxSUxpdjNzRG82c05pS2dZdmsyUlRXcWhySFdMQm5YQlNl?=
 =?utf-8?B?Wlg1dUpOcWtEV1NmNi94c3NzMHBTV0dpdlJkMThKQkhESHdhcUsvQ1l6STM0?=
 =?utf-8?Q?AHKA987hD5BFmQPQnwA09Xu7f?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12b61d5-c78d-4dec-333d-08dc2b133bba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:07:58.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ5jIOe6vzEkSdOHA5BDxXU9bm2jrt5yLAUADe/jImNLIBYsSmtEWcdVbA/S6gjMJB6Ebr77tBBdcjhjnqIL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725

Add bindings for SolidRun AM642 HummingBoard-T Board, which is the
evaluation board for SolidRun AM642 SoM.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 03d2a0d79fb0..b9f2a8d36874 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -85,6 +85,13 @@ properties:
           - const: tq,am642-tqma6442l
           - const: ti,am642
 
+      - description: K3 AM642 SoC SolidRun SoM based boards
+        items:
+          - enum:
+              - solidrun,am642-hummingboard-t
+          - const: solidrun,am642-sr-som
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:

-- 
2.35.3


