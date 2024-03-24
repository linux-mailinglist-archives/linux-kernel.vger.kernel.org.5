Return-Path: <linux-kernel+bounces-112612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3285887BF2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C911C2127D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19601175B1;
	Sun, 24 Mar 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aDwcCscQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DCE1759E;
	Sun, 24 Mar 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266246; cv=fail; b=mm/qCEw6MMmMSycBaim35gDI/jcHd2E2ji9zSRHNRKqRdH35FLXeXTVisj2RsfVsc8ST7Ba/erdydZlK2MT4S+5P0JJq7UgTZsrT7iQyhZY81PW1jarABmEbMJg6VCiPmweq6t9Z5znOgCIl7zc/GM6f56RcVE4XlXhJnpJ9IRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266246; c=relaxed/simple;
	bh=Q6Nt0YKU5hxvxIwloORUOKG4BW0yxRrF8UJL2yq05wU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ji9ihRF6c7qaZCYvLBA7yJrADcNG5TRMGfu98BGVVWYoWtxCQNc8h1yBGI7kqIMyg6NOXI6nUgK3gMwhYzZGzVAIqBpWonOXtilOFP06FVo0hpmU9UaNIYqd9AEV4IyNrGpRd9Wzh4yCUK7xcVKLMhLYmAIzIsEfyuTUfPDeZUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aDwcCscQ; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djpd+Fc/UjvUBdHcAVYU14KAfB9TFJn9VVr83Ybk7vpYWH1lAB4MaHqkic/CM+5ocUn2Dk6UNSfZHQ+YWvouefiI0U9DA2w8pmFMsYqwTnCNwoxnH7/z9SukT1agG9XR4coQGJYY7DzlmrL35NmtH7luwfTzLg2kb3at1hLCSEps4rYywvNfkTRd8gYDkop1BkLOrIoqguCxsbSYRmOPopwQzWlpGM74X4LqknDc36nzZ5yGGiiwfpwfFozaPPBG20lX+uVwhxba+xaX3TgHl1TobNKAsM981xrH9PDZpJjFoBNp4enKz4AQgKs7d0ee9r2PE6+MMPhAKLL4FfugWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXn7A4A42e0zMGYz7OukSr4fWxtPhi4VfBmYQ8wzWBE=;
 b=Wm2NZ69mzK5tIErq5itBWu8tTIxUp9IckOVgXNe+vHR5VbzA4QE0hA3W2Svlcd2lmve3xicaIRaLD8tNVxck8k2C1K7yRhOS4bAFGhDwvz63qTrtw6U9vh0fuya3n6c6W2Mxcg83+ATPX1wdZBbRcK/vE4I5CwOKoHZ38ctrgdQC/KEUKMAXcMVBhw3HRg3hutLlKPDfdLmUvYy27kf5hkxkR5CA+Z1F3g29IOO/EQXvDSr8rKNXukLV8EBNw6kSaHO2o7bdk+V1k1u/S+84vK1z/zravkVXeiY9Dfmj0c/hvckuyY5jIToO3/rrParOTQ/j+e6zGQGbRWQ9rWsFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXn7A4A42e0zMGYz7OukSr4fWxtPhi4VfBmYQ8wzWBE=;
 b=aDwcCscQIWoozx264zBTXf+/w6RurI0fUW/zbUyme0XYC/AuPwl8YTDP6YMX1htyC1+HMvIyJXhzErr45y+rnhJrPJlCMmzvLHczE7pX4m1ig/Xfut+LFz4Ru+qgtXb4dD3o0svq1GGbYLwYtWFxJmrJzC6PyZ35N8sejEOKHK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 07:44:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 07:44:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 15:52:01 +0800
Subject: [PATCH v5 2/4] dt-bindings: clock: support i.MX95 Display Master
 CSR module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-imx95-blk-ctl-v5-2-7a706174078a@nxp.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
In-Reply-To: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711266729; l=2127;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2d9nh8kBtXx1E9vliQEQis83+mP6bDEMh2YtH/J8JOg=;
 b=PIAM+K6aWC7Bc0adGLVpq/tWe1m7e0CarnziLvZFZf7NpgZfjXWpDpe2YjSVaCTzTz//yAkMs
 1yH34JeY8HMCGTEw7x8fwCyoldQOqkh1icNtmPSU01NPAzbR7vAPsPK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: f4801788-9331-4222-17bf-08dc4bd62c15
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FpcZ3/S6hT0U5PLrRkWg1g65Zv6RCQi1CwAAck9ucqzzTeNdzcYoFzzuLJFo6drbQxdWrm0roFZi6RrRWJK0pioon4o5lS2LtqBhS0C3aPONf/98f1qzCZmhm9uLQRCJWCoYYBkIWMWGcBpjqwi6Fm+IWxQkKORRImPL4melpEV2812QcWoquiqysF2Pj4H7hE7rgnIGiA98LzNaCDbtv+wu2HSaa3tIKJSsYBWoMP4MtrR4u9GP2BjcwVi2LuG9urDk4cvInz7fpU9de7U8xza03VxAYz8cwBb9iCAcsIq0vyEdk0QtoVUxVlS7AZETAFK3ncmE65KKzjioKlY7lPKiDY6mKuFYAOKzyjWGuoidkW+hFyaZLbmzJQjG9dn5+Grz5quTCHaM2Dq8avoIna0J1iEhdyYvaKmnXVnVddKwLXYRsTKN02t/h8oTZO84wiXc0kADnDNIC9uzl70ZqQt0Uob7b++YDZKquB45ZQ25+t3/QN72Ncy2t3zGMTluc8yQeXbbxdv0Pk/VX07dd4Ll7DdwOHDXIcNqbnE+Ql4E+pHmP0Sr+hpu+6s1hT2Bto4vFFjyvaw/7EzwQrZMGZ/WRSbT+J7IFQgPdW3oja4I2fNMXNpXJEof7z2BHUuXh9kzLhu1TtA5zh/yRfMhZgNPw39O1ho4KONzZoZRM+itA76O67ZFfiv4z9/Sh8Bh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2dpS2FJc3ZQUG0yemc3UFBiWHpMRWVJMkI2NGIvYVplZWp2OXlRZlhOdzZs?=
 =?utf-8?B?a1A3U0VKVjNFKzlaMEFsWHdBamRXK1ROVEkyeGJHejE5Skd0SXROWFBOOHlL?=
 =?utf-8?B?Yk9ZakhPejRYL3d5QXBzZmsveU91cGFWUFBFOHhHaXZ1UXdXSVZGTTRaSkQx?=
 =?utf-8?B?ZVRzeUQ5dFBJWHpBUEtOVGk3Wm9wL3lQZWRrdC82TFFQNm90VzFwd1VqMDhP?=
 =?utf-8?B?MS9LNGR6SzJ0b3hhY0RhenJDZ3VLc051aDMxYUd5N1dKdWF4UW9RYWwvSk1u?=
 =?utf-8?B?MUtoWlJaV29wT2t4MG1SYXJNWEVIcXZMS2ZjQWkveXNCZG1senV3NWJVUi9j?=
 =?utf-8?B?REx4OEVxWHA5L2hqZmZXcjR1Um5tVWZBNjE3M09TZzl0SGFaYUVvRmVubElM?=
 =?utf-8?B?WncrL1pTS25UNUNXMnNaNTkwNUpLSmo5U1JXNG9UYXg2Rk10M004TE9uME1x?=
 =?utf-8?B?bWZNZDdwMTM5anBpeTUwcTYxdzE5YlhEbWpSNDVlUThxQmlSTW41V1VkU3l3?=
 =?utf-8?B?N1djeUZlSWtTbUJHOGtTQ3lPdFMyK0RldlFpcjlxZGk1TjFIcVlzTmZzaDgv?=
 =?utf-8?B?bXdoK1NEM2ZRRllPdzNYS2ZjWVdnMWN4SHVMdEQyNkRhRXpuV2VmbXBMTzJP?=
 =?utf-8?B?YzNqczhYK3BmdnZTYjdhbVg5T2lGSjYrc3FPa3NyUk05QTkyZDJUTUJLNDBq?=
 =?utf-8?B?NUJET1FxdFdjMDhGS2g3a1ZSM3BmVTNhVE0vWU03cy9mY254MG5sczgxcy9V?=
 =?utf-8?B?eVRtSHM2aFQ2ZHFmN1RZQmhBUS91LzVqVVZzVHZRWEFyM1grUUN2MWFlL2o4?=
 =?utf-8?B?MVl3VEtMdWxIWFdsSi9ad0UyekFmNTEwZmRpVkJpdDZjeXJPUnBQWU9GbEdS?=
 =?utf-8?B?eWhnZllrNFI3cVFHYW1HUlVOd01USjFENFNkaHJQdEpIalBhRkhlRmlrK0tv?=
 =?utf-8?B?dlpNYUJnbWFWWkRBSmJSSjZYdWduc2s2ZzZXOEREYlpTUmR3WWp5OGFLQU1v?=
 =?utf-8?B?RnZrQndUM2lLWCtpdnZ5ZHR2VE5tOFA0cWI2RE91Vm5oR1pvaVJUUlpNSEdB?=
 =?utf-8?B?blFMT1VXUzVwS3g0S1VPbnNzTFExMVlPNlJvTEtzNWwvNG43Y1N5blA5djI2?=
 =?utf-8?B?Vmg4QXdGUzYvUysrQVQrYU0wYndJZk9vVTlMYTdGWmJJTXI5U3dNTEFtZ2o4?=
 =?utf-8?B?QkVCRGQreWtJUytOeVpMS3VzcnliYXRieVR3UENnWnZyUDQ5b2JoNlNFNzNY?=
 =?utf-8?B?NUlveWtoUXlpWjJDVloyRC9WY0o3TzF4TmRPMUt5TDl0c3pYdjFHREsyY0NH?=
 =?utf-8?B?bFBRQkpHeURHM244ZzFET3F3QmhxZmw2QlliL3p3dHhLUlpHSXR2MUJiM3No?=
 =?utf-8?B?Rk13enpUVmw0aTY2Wk1rdndzeWVka2N2UmNhWHRKK2Z3bC9WVVQ3UjcxN3Y3?=
 =?utf-8?B?NEV2SnBsZEUxcjRqd1pMYlh4SVRwSCs5ZjFCQ0FDS2FTdUVxM3V5eXNVVGJM?=
 =?utf-8?B?RFZvRW9XeGpVSi9wMGdreWRFSzd3cnJRdDh3eGRMcS9xdlhhTWx0a3hIKzN5?=
 =?utf-8?B?Sm93QzR4cG9lT1dwenVTVFJhOERWbWh0bUZ6ODFZUWQyVE1ReCtxUG5DR2JT?=
 =?utf-8?B?QjQrUkp3NGExMCtDZnhiY3d4c09LWXJuQ21tU0VZblV5bGhwN3U3ZjR1cWU3?=
 =?utf-8?B?SFJIR21UeWFIZ29nZWpta3ZaU2d4KzVlc3djaTh2VFlHR2pGdnBFd21wVU1u?=
 =?utf-8?B?RUIyRk9USVY5R1krVXNpVjRzdkMvMndWQWp1UnpKYzZWVlg0R0FjbUV2MUVQ?=
 =?utf-8?B?bkRIUGxZTGhOY285VlNtUFpSMlY2UE9TN0ltcWx2enRscnJ4UlNMaXFxQTlD?=
 =?utf-8?B?ZWR2OGVQZXhBS0J1a2pkaHlQMEdIcmlBalQzVjZWZHZiN29oRm8xNmpzV1h4?=
 =?utf-8?B?M1NCMzFac3BGVGZKb093RHJhc3E4Q1pqbWgvcDkyUzYzTW1SUXgwZmFwUUJt?=
 =?utf-8?B?NjZva3pHZmxJZThKOFh0REcvS0hFTW9wbXN2MC9NM1lscjlBdWdDckJScHcy?=
 =?utf-8?B?UTFYWGF0aThNS1FnU1YweDh6UVFPYlRwQmVkbVRMVVNJbHBvQ3dyQUc5Vndk?=
 =?utf-8?Q?3ljtCq5yHBSr7rF+r6odsv2ih?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4801788-9331-4222-17bf-08dc4bd62c15
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 07:44:01.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XQdzTQIKhIZG6wIMUnWh3Ap7ZIBcpz+y4J/AnDzhTBC94hEomRZsQ9XHUnxr7AA9yU/B92oKYcKIyBi620tTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

From: Peng Fan <peng.fan@nxp.com>

i.MX95 DISPLAY_MASTER_CSR includes registers to control DSI clock settings,
clock gating, and pixel link select. Add dt-schema for it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../clock/nxp,imx95-display-master-csr.yaml        | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
new file mode 100644
index 000000000000..07f7412e7658
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-display-master-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Display Master Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: nxp,imx95-display-master-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See
+      include/dt-bindings/clock/nxp,imx95-clock.h
+
+  mux-controller:
+    type: object
+    $ref: /schemas/mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - mux-controller
+  - power-domains
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-display-master-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 62>;
+      power-domains = <&scmi_devpd 3>;
+
+      mux: mux-controller {
+        compatible = "mmio-mux";
+        #mux-control-cells = <1>;
+        mux-reg-masks = <0x4 0x00000001>; /* Pixel_link_sel */
+        idle-states = <0>;
+      };
+    };
+...

-- 
2.37.1


