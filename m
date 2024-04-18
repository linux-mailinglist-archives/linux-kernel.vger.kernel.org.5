Return-Path: <linux-kernel+bounces-149450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E38A9144
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A611F21C51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BDC53383;
	Thu, 18 Apr 2024 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lXv4s2sq"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFD4F606;
	Thu, 18 Apr 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408326; cv=fail; b=pqmOPHPXneXYp74lT4ykyhXFucZCcwoLdiUmM9VqOj3um6b5K7drVaHtC0JYe0ovdVDIxjcDuVgZo8m0Hya/JbV2p49/HUq9d+zK7olg2NQd05ychsKabVbeFZjqRaQtoadqYTx9aaAbWkytO2WH8A2XcOzav4rN/BVUFonLywo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408326; c=relaxed/simple;
	bh=Q9IkV9ZFEu+joVFxQw9v/YBh8rk0TmnDpt8k6zp8ZL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BcGLawTScGIjCtO3c5vKTfv2QwbpH1MAa4jC1MIwiS0X5999YffwM9QFv1AlE3TBNWQLU/KaB11uB57jbRwxFHxoo4K4FwSN68bhYJLhTUS+5MXwlTP2pe5CMszFDaMIcUfjeBrF6o9OAOkwRT7k8ybp5RBXZ9d6FwCyWKO2Wj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lXv4s2sq; arc=fail smtp.client-ip=40.107.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILUSno7JXGvKBk2FStG9SGc19X1z9BGPjQvk0AR2DeaE5PN/5rfVZbc9Lbn3uPVWf5qhvrNnLbu5IX0b0KxxbUoV28IaUV+AYdFQ8DTC1UYklqqsFUFZl6l/nevKD9S21qcwOI71ForZeeuvCUHUPsBWQJ2ksZUXj9NI6OD6GI9+h6lB+Pngsm7w4RD485DqeVlA6JqtNcgsLNZuaQZkDEVLyRfwZAjKhHXdWN60qeD/jh0XUBoWXFSDWd8PbZDGY6iPkBoRS/4UklI8W5IEDvWlT1cmabhTSo7SRMi/G/YSALLAyqdA88CVs6A7bturAMj7lTRD1hTmsBbOpwOVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsIKXvBWwLhlWdVwW+K4sYBPSMZkEJEFp0qf/XeYMw8=;
 b=ObaP8KiZEZs5V2CzAapA/FhKLI0rZzqilHjTd8PDFrGcTqNhiZYW+bgyRjlRXZVCdSpUCZ+4R41bBHvfuPy8eF3kepA5Xwkn5jWa3x2lQuA736TWezYdLEAZ7iD3oJHtVtSZEW2qNlRirpgINxhJCg75nfwmbRKs4/pMUq6YHgTAtp3yPkUSLfVrTW1qEuabD8FHPXjn57NazdVsW9ReIfGdxqDHEjDVCTSgqsXRhkKy2XWLXfLtdIJTG8qY7JAeXFxy2IMSgQKNxT4TCBOhLrI16jAlwTy1PuWQLygNOmqM7gJqAqsgAMtFNhUAmFIYEdz16mbEAcwj5gMaIfztYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsIKXvBWwLhlWdVwW+K4sYBPSMZkEJEFp0qf/XeYMw8=;
 b=lXv4s2sqDNs8VpovFJhgfeMHlyYU3F1SwDQ7wtjJdKigGVIJ+JvOzVCLeUtRiNdObYre6vhfzqOdyV4tuyZ2NBCWB3icPKVxE1/dtlGVVP2z42ETj8vXuGb7NcR/tZcmX1XXPxvYvLORioR/IK9O93RbbLUOY0KGXNZ9L88u9t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 02:45:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 02:45:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 18 Apr 2024 10:53:17 +0800
Subject: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties for
 i.MX95 Pinctrl OEM extensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
In-Reply-To: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713408808; l=4565;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=AsCQbWRLuRmFvvtp1OtLsYatoniGAYFiDs/te3tgUEE=;
 b=/LmQIDZb3fL9Sd2se5hb6/KrLgMKESMzMhgdFAxWG8NSHI90MjzxTG/iP+gHKej3yqF9+y/vF
 QVv7pSH76N0BmFV9Wfii/GsR6SoNN/AzNpludXp8tOW9yihyv+IXS9N
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b605e6-0d43-41c1-ef33-08dc5f51975a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dBzW2MW4fP+hrvqCOyXp5r/e+OfueV3Whqd10jd+QI1rB3nNgP5Rcvmed9MYkboHlYem9Xo0RFtt5A5+IukFvROt6yDIs9yTMkHy4MeUcipuswdfpXcPNU0PRGWWwTSsPfvjWim3Q/TEcigOuZhrCKX4EhAM8jZAQo3pIvlNtCR5dx6o0Oc+PavjdHv4AT1IY+/3DV2PZ7+Bt8l4WilS6WiQj4WUwOs9OtrEcSlcx4yAZDau4tFqCOTT4PfoS5yuWzQrmX/znzbo7RKoBoz3mUB0oZlQPlpE6utudu9ixm8IXUAT1tli9fVoRv+LoHUoOBmKARNbbG+1U7bCdnOpxBdM9Viqt6KL7WbDFPEOIrc/5tMWQ/qBrsdbWBTzDHFtwSjUbZm9N8Gebeq4But7kpE461mHvZPcOvSBn8oKQbg+amT75T9/73fcZcsjXB+C+f1atbCLwGwPjaiDP3CWabNcUo0c0mzWSAqOhppRKDkOAb5r5k9giuKX0apDsKAdgTFhXTfsXqrr+X5gPvxhj5A9hTBWu8oza6wEDF/yC7ppG82d9DvACwV3gKp1jML/hI+PTqGyvJ2njIgPHshNYV2X8q1dNqdQCPm0qsaL7B2YEY91T+CJpK3KmjYdw758ntqWWIT+vTAuyNaKyX+UmCzsz1fdWNZWJWj14p8F/CNcm9IieAQeI5tstwZ5opGJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alNpSHFjRS9QZlBPZnhEaVI2U0U1QTZEZnFoYVBuSWdLU2k2VkxVZlZGSVBO?=
 =?utf-8?B?MVNMbE1DQXZQNzZaeDRqNXJCbHNuSHY1cWZmVWNDUnlMUlEybDRvcW8rUHdR?=
 =?utf-8?B?Z3dHUmlsdndKdk9pNUtzNzFuQWVlOTFHNGhVVURaclhlR3RwazdMSG1JUDBW?=
 =?utf-8?B?Q0JzeG1EUjZkZ3VhclA2eXRpY2dpYVhrdjY0cXlYVWgzUXBLcjYybHFJeTAy?=
 =?utf-8?B?Mmllcm50eWJnYjcvM3pOZFpHb0Nsd1hsZXg1bU1CZDQ0K0RlSW9KVE9tTUNW?=
 =?utf-8?B?QlNiOU1Ddm5RVlVsenoxbDVGTjFveE1FMExFZ1lzekNGclRHcFZPeWZHSDA5?=
 =?utf-8?B?RzhpcHBqc3lpV3gxdTdNVkNxbUsyVFowanU0UmRCWlA5aGlWQks2MjZYSDho?=
 =?utf-8?B?MXVUdDZpczZuZHFPblcyR1orTXpEc0lvcGxxTXVuaGc2ZURJcEV2clZnU1Rw?=
 =?utf-8?B?L1hEem9icE40TldxaS96Z0ZNalY1S1B1VksvSWVEdnlhWndiL3kwaVVxcGZC?=
 =?utf-8?B?aHJXYXhxejFjcnhLbE5IbTVvNWczN3BnMjVoazBFZHNwdkFrM3g3ME1tLzhY?=
 =?utf-8?B?QzFOSHh2VkU0VGtPY0VzYkk2UnV2VUFNWjRLemVWY3hVVmxudThTaXFwaThY?=
 =?utf-8?B?WEJrRFh6bk04UnhucnAzMUtnYnB6L2l1S0tMM0ljemVqV1BoY3Nkc0s2OHJP?=
 =?utf-8?B?cWJ0RDcwYUtzOFdjdkdMSEdITFh0ZngrRXF2clYyU0NjdFMxTC9HNnh3ejFE?=
 =?utf-8?B?YkJRZHlaNThqVGROUjM3Y1hvSlRLMVo5dGc3VUduZ3hOc3g2MlRCVitJemRI?=
 =?utf-8?B?VENrZzdRWUM3OC9oL3FITU1HWlRCU3M3bDJEbXdUQkx2OG1QSVFidENGMzJ2?=
 =?utf-8?B?M0JwUE0waS9NWmdMQ2VJY2dBVWRuTGdCWVdTUEVIblU4a1A2ZFJIU2R3SzRG?=
 =?utf-8?B?MlFXcXdROTI2aFptUTdVK3ArTlVHUWpJenV1dlFUcEJzMHU0bkFZWVBWZkNq?=
 =?utf-8?B?SVQxa21nUUl5UDNkWWU2bEpoQXNlODdiWWZYWENxcUFVUi9aZkdjTVZYN0dZ?=
 =?utf-8?B?MmE1eUJCZXJ0bHN6Vmg3UTE1MjZHaUovVU5uR3dPdFJzZ05YWFNsS0haNG91?=
 =?utf-8?B?RkJZLzFKK1pQR0d2WnR0eWhrRHJsZVM4b0dzOWVvS0ZYVU9LK2hpWXdRUU43?=
 =?utf-8?B?ZWtVZ3pEcUM3UmtmY3RrTnJ6WTl3ekhPY3ZpKzlESUM1OW5Kc2hBS0NERElo?=
 =?utf-8?B?N2d0LzBBbS84TG5SRm1WTGdZS0tBT25VYktpQ05GeElFQitTekRMZjlhMWRD?=
 =?utf-8?B?NjdiaTBpaHEydUFmbG5tRmZOUzg1ZDU3cHVYQURuQ1lwT25NZXRpMlY4Ry80?=
 =?utf-8?B?WUtvV2dheVRzMUhRYUZvN1VXS1lEa1lBOHJZTVdUOUY4WHNsVVRTUTQ2bk5a?=
 =?utf-8?B?VkYxRm56NGM5SlhzVEhlMGY2NzhjaFNFV0Izd3BEbFBWZHdJTDZxU1dZUDMy?=
 =?utf-8?B?Y2R3WUxMM3lpUkJ2VUI2QmJHTXFGaDROQzhmQTFaczIycS9vdGlmM0ZJVUd0?=
 =?utf-8?B?aTBHWnJ1NTMwaEMvV2pkKy94RUJQNzRMbjQzOTFSRTVlY0VDc2VJQUZrb1Jx?=
 =?utf-8?B?ZGxFaVIyRWxxS2QvMUxjZHJtM2VQSERoVnFxTitXOC9ZZkNUcXM3M3VXMUNt?=
 =?utf-8?B?VHFyUkxqL0VrQkhLU05hbGRQRXhpbjJUTDJnUXJ0YU5pMDRzZHR4M0M3clc1?=
 =?utf-8?B?dWY4RVlwd2l4N1ZXYmVac2h5dFhobTdFMmhOV1lZMXdBV3VyOE44dTUxSVdq?=
 =?utf-8?B?TG1UUHVaMCtacVhLVWVpM2I1OFMrV2FwVzhKMkV6QlVRa0dhcW5qbitESDVS?=
 =?utf-8?B?dlc4L3M1Z2IrZFV4VGtobzR6a3NzUUNXU3Q0R1JHUXRtb0NBMkFPUWpXRUEr?=
 =?utf-8?B?RzNZR0UxL1Y0dkVMWkd5RW1ud0xZQzZSc256R1JkbHgwMGMwTDh4Z3dvOFRw?=
 =?utf-8?B?dXRxZXpYZHVJbUlXWUhBRitJakk5Y2JyQ1pzUUZWZmlyMFgzNU1ZUWNHUm85?=
 =?utf-8?B?MHFXOVArYW1ra21WQmUxYUZ1TjdSMGp6aG5sS0lYYjJ2NTBudGl5U1BjT1kz?=
 =?utf-8?Q?D/IrFijroOqs47hywfkGzpy66?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b605e6-0d43-41c1-ef33-08dc5f51975a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 02:45:21.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 043fsOwVLx5pNgk9RS+4f5RWVKR1AkQ5ao6eDPrq1138vhgVGwxEpeFWSLXuHXzWW9C3B8R7/UTyAmqYHBYMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

From: Peng Fan <peng.fan@nxp.com>

i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
patch is to add i.MX95 Pinctrl OEM extensions properties.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
 .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index e9d3f043c4ed..e530bfff141a 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -262,9 +262,12 @@ properties:
     patternProperties:
       '-pins$':
         type: object
-        allOf:
-          - $ref: /schemas/pinctrl/pincfg-node.yaml#
-          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        anyOf:
+          - $ref: /schemas/firmware/nxp,imx95-scmi-pinctrl.yaml
+          - allOf:
+              - $ref: /schemas/pinctrl/pincfg-node.yaml#
+              - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
         unevaluatedProperties: false
 
         description:
diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
new file mode 100644
index 000000000000..f6c18e9fafec
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
+
+maintainers:
+  - Peng Fan <peng.fan@arm.com>
+
+patternProperties:
+  '[a-f0-9]+$':
+    type: object
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: name of the pin
+        items:
+          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotraceswo,
+                  gpioio00, gpioio01, gpioio02, gpioio03, gpioio04,
+                  gpioio05, gpioio06, gpioio07, gpioio08, gpioio09,
+                  gpioio10, gpioio11, gpioio12, gpioio13, gpioio14,
+                  gpioio15, gpioio16, gpioio17, gpioio18, gpioio19,
+                  gpioio20, gpioio21, gpioio22, gpioio23, gpioio24,
+                  gpioio25, gpioio26, gpioio27, gpioio28, gpioio29,
+                  gpioio30, gpioio31, gpioio32, gpioio33, gpioio34,
+                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmclko2,
+                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, enet1td3,
+                  enet1td2, enet1td1, enet1td0, enet1txctl, enet1txc,
+                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, enet1rd2,
+                  enet1rd3, enet2mdc, enet2mdio, enet2td3, enet2td2,
+                  enet2td1, enet2td0, enet2txctl, enet2txc, enet2rxctl,
+                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet2rd3,
+                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2, sd1data3,
+                  sd1data4, sd1data5, sd1data6, sd1data7, sd1strobe,
+                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3data1,
+                  sd3data2, sd3data3, xspi1data0, xspi1data1, xspi1data2,
+                  xspi1data3, xspi1data4, xspi1data5, xspi1data6,
+                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, xspi1ss1b,
+                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, sd2data2,
+                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2scl, i2c2sda,
+                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmclk,
+                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1txc,
+                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
+
+      nxp,func-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Indicates the PAD connections which function module
+
+      nxp,pin-conf:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The PAD configuration
+
+      nxp,daisy-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The select input register ID
+
+      nxp,daisy-conf:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The select input register value
+
+additionalProperties: true

-- 
2.37.1


