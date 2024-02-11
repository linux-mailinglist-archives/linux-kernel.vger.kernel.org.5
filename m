Return-Path: <linux-kernel+bounces-60819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D18509E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CD28245D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB255D46A;
	Sun, 11 Feb 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EClqjaqM"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE85C60A;
	Sun, 11 Feb 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664087; cv=fail; b=ABXggl4gGPqMYSBJZQ+p4X21al8cLx+qb0rVKp2o0lDtbH8AO7JexwPg8xY+eX/aNhEYAXTd5+un4E259R3A6wmF8ylDqAFQw8STae1PoPR+plWT/KwXI+IgTKjkngWBILTgyMz7Q8hfd82QOr8+HAst7qDH6/29p29AKBRZsB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664087; c=relaxed/simple;
	bh=hMIKYwARHFl28aOlzWwWn5CF0EjqFkk4UQThGPqCf1Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=omvvZWTjKH1EEu5At7bF9J+mBd4OeCm6A2efCUQrAuaPC7UE9CbaAkBw3avmBBOfO0wxBUktRPpxCMyg7ovyT91kvMfEt871fGgQ/76mA7mfD7bO8sVcktjKllH6BeDhfSr0pwS7wHBUUjJfif34zBQruVRmZ00LrXFeTPKNTwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EClqjaqM; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm39Thu1zfY4vkTY3+gPddsOb1xw7POucZ/BiiE4QfHO/Rh932AjT3Se1rPpU9UuHmfUEli5G/7Q4R1xIeuM+yJyisC6pk1iahWqwb81MbL0guGnPToj20NdC4CikCExw/ShiRKlqPF1cdB0sDL6qiabWMwiXR4I2eTboMQq8HMeth2FkjgAONeBhvSUipM4bCAQxKtDu7skJitU9lO3nzPnRNRyln9I9dJuhYiuq6FBecojNPKHmZxKgNmzzXYtHo0vwIXaJW6qR1ZyA/+E7vUqpM0fe9B0l6IXY4ifKKFuLAF5VZa/m2K+gPgQq45VsFXOWxmzQaruHC6b8OFShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=VN7VbaotF6uN6QuxMSFkKtLGuIgZpKjxGS69jm0tZ3XH0QNbiYVYkmO2Cj4LwaSxOYi9VzyFyjtXnV9TG1eRoW+m0X1RnIXeLwnrQaddOWFTsYOlXWYFLy7g9XM/o+1XppzDcFBxuGYnNlz7inZ2mGCfDJG4TUOlOCFlJcDgLiNhC4Y1hrPbBW64E2uVjTG2DSL+IIifA3rpVD0zFGLCJq4t8xGfUR2RQRtOlExE1Q+h/0T7Khd5G5VKhV2EMayFVAcKya24ckggrp11fsoPcDm0MR+vW7hexdw9OFNpP9nabJM0Xc1Bd53AKZKgRmwm1aGFKX8ezn85+8Tmz1SSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDsVoQ8g3CQjqHclKbGCWLlS02/JOtQukIt6ZXijk5s=;
 b=EClqjaqMnIFQPfVKrgcloFisdPsCqdCCKBNt3at+drBSEbNLtNc8Far/y1LL8IAi0jdTA7XeZuz89L4092y0/QJrlGLuE9dIm4a1xcXJhAKPmnw9tVBSR8NHtSIqheSsBRj99dwIF3DRqyhSojPcJjgE/OrUrEBmv+Pn5YUS0Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 15:07:59 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 15:07:59 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 11 Feb 2024 16:07:58 +0100
Subject: [PATCH v5 3/5] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-add-am64-som-v5-3-790ed7121249@solid-run.com>
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
 Josua Mayer <josua@solid-run.com>, Suman Anna <s-anna@ti.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
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
X-MS-Office365-Filtering-Correlation-Id: a55ab056-88f7-4676-57ac-08dc2b133c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9KF5R6vqgUpmmXqJ4Y1ADF4ljBGiMAoSs/wTDaVlF/aTXM6G0/UGwbqiFD5x38kP4vib7a7QuwzyMngtF1Ypnr7/PlVT2+3lErn7ghC61pFo34o8mKZkEvaYN/LsYijOg+t4Ez9OzwptKLOzuZRpM/eGdzPftxdw4gVubMIHJRcku56HsbmOdorlgWkwY6hPLxyalo3KFA1VyLHXwDjmVc3XOvcIdXmvbF1hCd1nxzUW32zUFzlWkLbzI+UDDB/2Bq9elPbaeEFrvS3jF4meSgzrZRL+ANs+G5Nxl0pQtCF7ZiBvBJdgEh/Vh9TnuPQxkejdfO6pNyW+bke2QN1phQqPvWyqRWYhQWKcl4FmAhlCl8pwqZfmpNoa5piKRCasTKxJLCxfScKM1fNh7dH2lrypp02vcI60YUXgPcQJdpSVk8fF/0gtSwODt8XsgjCp97UXcxJC1t09+oa39R0MF/ahUEY5kSYAYfoTloY8TATaArCXTobPYW2LVpiqKeG0UX8NA27tjTE7TLbwAhkd4vZ0Cw9j6T4/gR2HSfXwU9nDUShUocu/OfERykLgU2CSlOMw6Ra1mg/N4yzmmSgip81fmtj7Nc5zSLxdcXrXJeIYNJlA/SG8inRTUYuS4K5N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(316002)(36756003)(6512007)(6486002)(66476007)(66946007)(8676002)(54906003)(478600001)(52116002)(6506007)(66556008)(38350700005)(4326008)(8936002)(86362001)(38100700002)(110136005)(26005)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNBWHNtbkhCY2NKcWExUmtKdTNwc3FHcUV5WHI0NUg3R2RMbU9qS2xqQkVj?=
 =?utf-8?B?V09LcDdCSUZWKy81Z2cwejlTYWkvSjc0Wll1WkJVRGJqWnpRWjRJMmgwTHVU?=
 =?utf-8?B?UTJySlprKzFmWWIyVzN6RXg5ZEJNWlZOdXA2aW0zcnQ3aHFrMHp3VnVJVWRH?=
 =?utf-8?B?SWgzRWFHdUtUS1h0REFLU3JzSmkvUzVGL01YU2ZiMHdFMXE0UHo0OWdJamFq?=
 =?utf-8?B?eVlkeTlyNEcwenlBVmhFWi9oMGRRWkM2ekNVMWNma1NQRXVnamg3c3NKZFBl?=
 =?utf-8?B?RXVCTTdvRmpIclZvTkZBcituaklFMmhxSTEwNlZaaEhnazZ0bDFnUktwS2dF?=
 =?utf-8?B?U0VYL0xpLzdib0lVR1gwK0NTQ3FLYVp6ZzZvWmpwdEl5ODh5TXovcVRXNnlk?=
 =?utf-8?B?d2FRRkRwd2gzWTNPZTNXb3BmUFIyR3N3YWYySDVRN254eEhaSnhxVVVFVjhp?=
 =?utf-8?B?Q3VoeUNUTTliUlRSMGRKNmhqekpKUDNCbDlDSHdrWjRKWVE5UDVHblRBVGk4?=
 =?utf-8?B?RnQ2N0wxVEZTdEU3cmRhTm5lNU9CcEVRZ2ZZMXFFS0lDRGhzeHJ0THFGL0V0?=
 =?utf-8?B?cFBVeUN1NFVwWW56dDU3Nm4wSEFsTHJkWHpDOVJoeGJvVlVDOTRMeDhxVFdP?=
 =?utf-8?B?bUhxZjZZU3BKUmhGdkVwVFFMV2JuWmxwWUpHdmVZRnJUSk1CMUxDYWpFTUVw?=
 =?utf-8?B?anVGRWxOS3hWaFQ1aUtCc1ZZRnU5QWxjbXlGR0JiSGEwMHIvTkhzN1FieWdz?=
 =?utf-8?B?RCtlK3ZHd21pWUFRTStwTkExbHE1bExaZDBxSFdBRW5FL1ZBV2xBclppRU9x?=
 =?utf-8?B?QkRMdHU5QWRHK1R2eW4wbERWWnNYbU9KZ05MVDI2UE1leERIaHczRS9GL2FH?=
 =?utf-8?B?bUFQMmlmUnUyUWVJYjN5clI2TEJBQnN1NmlLa1o5bkJZQWJWV0Q2NFFsNHdZ?=
 =?utf-8?B?UjJ3M25BaHU2a0hEc3plMHpuY2tiSlBBY203c3NWWC9Tb1BQRlFjT0ZNd1A4?=
 =?utf-8?B?QzR4R0RnaE9hM3UzdldQeVl0MG9QV1FLQlBCeDlXbnA2Si9CWXJPcTFsYWor?=
 =?utf-8?B?VmhWekhONnR4U29Fa1VqaERuOGVINkFWU2NhU0VNZkxTWnRkSEVYZkk3cGth?=
 =?utf-8?B?RHZqQmNabnBmY1lxNWs5T2JWcHdKYm0xOXZMNHpqRW5Pc08yMHNJQ0NmMzdy?=
 =?utf-8?B?UlZreVlvamtMYnR4QXdXeXREeWFsRzVaT3ZVcm1KZXMxRm41ejFXR0cxODhY?=
 =?utf-8?B?NjYyZlltd3dwWjBNYWtDTmFpRlU3WmQ5RUhhcTZxWE5FeDVCRHZ5THFvbG1D?=
 =?utf-8?B?Rmpzd3RGL0ZEM0o1Mmw3QlhYbzlieFMxeFNaNDZJdTVzeDVyK0NURzlqQ204?=
 =?utf-8?B?QVptV0RsTkZ1L0ZjRkx5VjVlem5TOW9sdS85ZkgvRS8zUEFLaUdZRTAzZGp0?=
 =?utf-8?B?dUhHSnoxQkVxV21QcnU4Tk5YQStITEUyY0ZacUZIbDZ1WWNWYjk0SU9XOUE0?=
 =?utf-8?B?cXZnbGk5QVJ2NU9pWTVKQ08vS1VCTWc2cUtJZGFubHEyZ0txY2JYQnJBNmdI?=
 =?utf-8?B?NFFaT3U0ZGd6MG9LUXl0TUpFZ1FKZ0NuZnhnYk1EQVRmQldGZTdMZkJ3dDhi?=
 =?utf-8?B?N1dwSXFpR01LMHJ6Q2h1dk9tZlN5NWNBUkFUeFN4Slp6U0xLakQyM2d5a0ht?=
 =?utf-8?B?bzc2RnhJL080UlNKN1FyYlZGbGQ3WXdxRkhOYVgxbFhXT2Z5VWs0QUxRK1Jo?=
 =?utf-8?B?VDlUNVdLRElSaTc2Y1ZPUDRERTZVWGdaVmNmOG9UaFljTk5Jb2ZnTTZQVEg4?=
 =?utf-8?B?WE9SdFB3VDcyWTZNQ3dpWlg5dkhvZC9hY2NtUjJKeHJ0Y1V0d2drQis2aERU?=
 =?utf-8?B?TWM4b3Mxem0wM1kvOHlxMHVMYkQ5VjdUZkQ0RHpxRmEvTzQ2dCtQS2txNTlz?=
 =?utf-8?B?YlR2d3JzRllWMUIzRldNb29VYU9FbGF3Ti9SUkJqRzN2SGI0c2FTd1hQSGx0?=
 =?utf-8?B?MU9XNEdQbUtEb1FwS3lLL2JzUVlLaWYxa0pWUkN3dDhHTDFpV0xWQ3hYWVVT?=
 =?utf-8?B?SUVhOG01WVROM3BXUk45UXhFWkRCOU1ObTc5UFMxd0l6TU5neHN4d3dBeG9r?=
 =?utf-8?Q?o+MdLrGQGSsvnwFsTFioOaWXw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ab056-88f7-4676-57ac-08dc2b133c58
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:07:59.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TT2RdfR8aOfxN37MA7o0cfdcZRLz44Nu/9yGuaYkp8GcV1IkP1pPwTXx8wUXsGx9cimF+bA5bUgx7sg5jzrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725

From: Suman Anna <s-anna@ti.com>

The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
to manage/generate Industrial Ethernet functions such as time stamping.
Each IEP sub-module is sourced from an internal clock mux that can be
derived from either of the IP instance's ICSSG_IEP_GCLK or from another
internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
instances. The IEP clock is currently configured to be derived
indirectly from the ICSSG_ICLK running at 250 MHz.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0be642bc1b86..8130ee02a3d9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1232,6 +1232,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1373,6 +1385,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;

-- 
2.35.3


