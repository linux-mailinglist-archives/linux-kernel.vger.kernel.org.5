Return-Path: <linux-kernel+bounces-50108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDBA847459
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925491F2E866
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AD146918;
	Fri,  2 Feb 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dPPyi6uN"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2098.outbound.protection.outlook.com [40.107.241.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E51474B2;
	Fri,  2 Feb 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890257; cv=fail; b=eOgGohUrfVtZTv+sn6udCBmS95snZmU7BXEvLS8eEdulqGPOWWaqUZErvGpz2lWII7aevxRuZjqSZTMr6AsQFapKZoHgaRMpP74tr49xm5QsFNzgD+O9sec3sKZYhl8GW2Mm3yP/L/TRCVv9BjtGtz99YB79l3C95vIeS45PWv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890257; c=relaxed/simple;
	bh=/AFhwce9jy00uSMBqBN1uM60wnY3CtRqra+U5vm2Qik=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nCceVzgQ3fkjoStMae+IQcuQ28JVGBru1hU79LVTAWR2TuIP8zKD95CzIFDuxCgU/SdysEdkfUzd10QQRZllDk2a051cuKyJ2pzuDpY0gJCd15+kdW3bTxF2RC0MLhz50m17dIn69368rIwPj/SVf07djYOLGdF5YSrkTHeehp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dPPyi6uN; arc=fail smtp.client-ip=40.107.241.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPMgQWDKvLPtN1k+oAUuO/gDvuYlOoKdMPNxQdjS/fP4wpJ4hPPYdP2Y87eOZsVZPd+1VcnK0dSzBQzI8zx+hyavkn9xKkqvO71o23WdcR8nS2qBGwGBjY1vRloxZZugmVNooSr7aqhmyfUjOJiCrdelV46LzsqtXBVgPIJm9QV8qyCY/D067QGlL5imEMcxftwIkA8G7M8yLy6C4UVQ/LlngY0iBOWj+n442yO79K68X2QDGkeMsAT4xsNy/xlg1u+3JfTim1uBtLwwJ4rTwFAgxQTQwHOTO3bwWq4Nb9qIaZEkVRPlfvdvLksNd1tkyri1UnNS94nYFULpQFQYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=KaqdJvbklBZqzZVZu0ysrFXvB1LR2m53MFhlXMOIrXIz54fO43yLucTsxrQVdvIp30A+0EZa4U6nXq5JpG8SYbuNxMO10azFYQ3oy9xRPDYOSuMS5VzsXr4RkcL7Q/8zjauuLsVXZBbUPrfIY4ehSRjwMf4Yqp+1BsKv6KHeql/yqaFDnu/k2hziJD9ahUaui/e0oj1hv/NXXLS2uA3jnpVD+6AwE/VbkO2b1iFhH/aa52MQES532Pe8Lb62eP7414NhspLYTFE6ZFVIfJxE646cpuYkc1fiONx9vEhFSMz4NdQsv4Um5Zq7Cj+V2pT02HCjVej6mENFgk01XC40kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=dPPyi6uNKavruJmvv7LTEl+1ExN4qHrJQMQQVtafxedqFbFARHqoGvhUCLk6ZopEmguADZwuoK9+ksn6zagViNEiMTAF8yEBl9JYr804V0M9tsnJ+6dqzA6/b17ZHGfgFv1ck7OyaEip+as+I0E3n3LfNAw7YRI3evL+8mlw8gE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8775.eurprd04.prod.outlook.com (2603:10a6:10:2e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 16:10:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:10:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 17:10:48 +0100
Subject: [PATCH v4 1/5] dt-bindings: arm: ti: Add bindings for SolidRun
 AM642 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v4-1-5f8b12af5e71@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
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
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fa7b12-59d9-4aa6-8001-08dc24098723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wHN0jmMNfg2NSRELztMI0ldowRIfS9OX20ODTWNo4D/ClNTjO3rH5UKd1oBXZOiS3WIMYiHMxpJLVZqamHszfuD1Grm+hV7dePfVj4flBI+pJJ8moSvf3f6RrmvPwMc6NumKlBzuC5hdCH7fXTldNz6KNoJpXbEX9DnIYOTUUTHTrJZppzzvfEI3nv1JrwVrDRSbRNS2wprH9LhNmpsXxiWLjSMYto+ToAQwD4XlEqyZXUKEzpy4EvepUkYiU4sbmDHudIJzPYoE1ixIGGqPaF4IJgz4GwFfHBvXxHx+X7tUnf1csoNrSni0GeAzQ9Wsvjm0b+/EtMxSRevm0oNTtP0O56VXllc4y8uPsFr08BzQVE69I/3h0TQYyL70RPFncXPLoxQRsYpmQdmFzPDVNp9IpI33p6ntCLKsIJ9K3QAiEe16WcZ/Ph4FnjadlOmrNMlcLHRJx0r+7qK9UXG9JiwdSBlFcnPrqHIwi4HvvHnoWkOszuTC+FHYl3tQgXA9gkAox38i0Zo1KOxNBQKhiFtchCs7QRKE+giD+xDRbNv2TAd1WRZS3a24mr3fKgWXOKg99pbqTLeNVJVINwRSVffWVsvjxjq1BwtbCKgxYBcXHqixuFAGbB17Pmb4uPLU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39830400003)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6666004)(52116002)(26005)(6506007)(2616005)(36756003)(8936002)(8676002)(66556008)(38350700005)(316002)(2906002)(7416002)(66476007)(5660300002)(4744005)(66946007)(86362001)(4326008)(110136005)(54906003)(41300700001)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXRDaCtNRm1EdGRwNW1ZZjMyYVovSm9EYjZvZ1FqVEFkdjJicEY5OERFdTkw?=
 =?utf-8?B?UUJxeVBpR3RlTmxiMitPTkdtMWRmZTZpY3VmRVQ2WHYvMzJFRGx1U2tKSDNu?=
 =?utf-8?B?TUY0Z25nS0JhTXFpakszUzcyQkg1TndCSXJIVTVzTW5vVVliV2tYR3M0dkJr?=
 =?utf-8?B?dEhiczBvQithd2tkMkh3L3NzTlRKYks2MDFCc2J4SjVUbXdNM0k1MzhYMld4?=
 =?utf-8?B?L2tDOGJjenhrdEJkbDladms0V2w5ajBNREhJQWJLM3FYSTFCYVhMSWtPc2VI?=
 =?utf-8?B?OWxDd21lbmE5a1gyZkR2RHdaYXV3R21OVkJtaTFDRzRsY0tmL0pPVHBwK3o4?=
 =?utf-8?B?WFcrUm81Y0ZBZVRrOWlRbHJiOEtiSXhpeWRZVk45T1BCMXV2bXMzbW04LzFU?=
 =?utf-8?B?bXc4MVRraGprN054MDFwZFczSUJ5UWNIbGtnRHB3Wnk3N0x5bkE2WTlKQkE1?=
 =?utf-8?B?blg1azNQVlZlS09VbUg3N1pxMmRCRWJMQXJNYStGUkRiNzlWaytwUzIxbytH?=
 =?utf-8?B?SUlTeGt6aERVaEdJV2VvZ1R3aVhlTXF6U3FSd2hSRGs1RUY2V005Y1RHaDFp?=
 =?utf-8?B?MkQ0dktIOTMvWk5sRUs0amxvY3NJQWZyalBtMnQzeEEvSlErcGxxVWcwV3ht?=
 =?utf-8?B?R0d6ZTlwQUd1bjlkek5JcFBPdXZQNlJuVEV1cmd2T09pVDQ1MEZ3QjFmNjE4?=
 =?utf-8?B?d2VQblh1b09XRkIxcUdlb0Q5eVl0eFZqMnZPM1BWRC9ERSswMzZaSzRoWjg3?=
 =?utf-8?B?V05TY0FaeHk1L1JEb1NxajBCRXVwSG5UamJleVNQSlNDdFY1ZDNmZndERm9j?=
 =?utf-8?B?Rk9RN2ZEVnRScFhkNTJrODdjYmR6YWN6L0VOZFpQT1hoV1dkb2ZUaEZiVzIr?=
 =?utf-8?B?YzZEYVhxcThnYzYvMDA2YnpkZ2hPZmxGbHhnVlJVOTdBSlo1b0FnVFdDTklq?=
 =?utf-8?B?a0VTUmNnTjQ5MVNrNkpGTlU4ZGh3dVFKb1VSZmx6eURiNHowMWF1UmhEN2VM?=
 =?utf-8?B?Y3NZZ3NzK3FYTEhFZitHOWdObU1OQ1hZVE9lR3BZcm54MWdGYzVYSG9semtj?=
 =?utf-8?B?U3dqS1RyNmdPZ1lvU0JDUVVFaGRZQi9MV0xaY01yamtPQVJCOUdtNC9kbXE0?=
 =?utf-8?B?UUc3WHZ0Ym9VQllsNjV6NFZHUWJnYkpadUFTWDBETmp0VDJyUTcrYnVxakVS?=
 =?utf-8?B?NUprRzVSems3anpOMEhESFZONWtIZ29aK3ZEU1JYdlU4Uld3eFFoTVU5OW5W?=
 =?utf-8?B?SWpDN3pLSzJINmIvb0lJL2JpUGMwV3FPRDNVMXZyYndpNWhRelc0ZlNhUVZ5?=
 =?utf-8?B?Z0Q0L1Qya2ltcFF1aG9QK0lNTHRiYXI1UHVJNTRHZzUrcURIaFY5NWk5N1hE?=
 =?utf-8?B?cy9xSDB0SXFQN1pBZFpBa0V6a2MyWWtWU1doRGJ0bUVPRCtJM0lUM3hSZDJq?=
 =?utf-8?B?ejR0SzlrTWlwL1paQ3lNZDA4d2hTVzdhMzZNZFFNT2c0VXduZmllWUJkejNB?=
 =?utf-8?B?ZVFJblpGc0VrSzVqV0FnbFNVcTlGOXUzcUZuU01Ba1VzN1ZSR25maUplOStx?=
 =?utf-8?B?ajBMR00vaDlmRjRuK1llcVVhUGtQdWVleVpmQUNyVEtkdk02blNsMk9sc1NN?=
 =?utf-8?B?SURyNTBuTU5mdFYrYzh5aDN3c1dENDEwM2pxRDI2NFRteFJCZlJocDlYdzRS?=
 =?utf-8?B?Y0M2Y0RWMzJqN3JjZ0JBT2h4QTRGeDhGY1pPaGRkRklVTVdGdkd6eDJYb2Rt?=
 =?utf-8?B?aU1RQ25CR3haL2pVaUFNTlVXa3FRdEhDdWtjdGxKY0ZyYkdZSGNrUzYrN3pJ?=
 =?utf-8?B?ckNkSGVZWmtZNTROdjFBQ1crR09Laml0L20zZGUzRjBwR00zU21xRFhaM0Zo?=
 =?utf-8?B?S3BvRDJMRHZCVXh1YkZMdHdaeE5JYWtFSmxNWFRocjEvU1g5YnNQRForRkgx?=
 =?utf-8?B?OVA0Z2N6bVFFcTQvTmIzREU2R0g5VnZHZzJJcng2bCtWbjYrelZYN01oVXZ2?=
 =?utf-8?B?L05TQ09rUmFJRGxvZnJHMlh5TEJwSmtMOEh5aHk4OStHNDhrQVRBVGR6aGJw?=
 =?utf-8?B?WlFlYmZtTjdxZytKVm1QeHRjNTd6dFVnLzJoYjhvUFBsaTR0YUxoOW5uZmhC?=
 =?utf-8?Q?0DoOnlWoQrEvkYyfb2y5Bg5lM?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fa7b12-59d9-4aa6-8001-08dc24098723
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:10:52.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHOmzIiK9GagaVMFQ/+Zif04DEu+dJfk4CZpPjnAU9B0W6/gfaMcHkDQ0ixGlGtCYl9OSaCJM4jYSQJ9u70NeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8775

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


