Return-Path: <linux-kernel+bounces-49272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC046846813
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2236D1F227AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033517BDC;
	Fri,  2 Feb 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X4zml0pn"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132E179B8;
	Fri,  2 Feb 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855447; cv=fail; b=XSuMMZaf5Rmo5Bz2Ua27w5/jivwYkgotc5BzG5exHguJTqx6YJgYIHgO/7K7wJ2h/Lwk1nvWo8dbh0TUsa3Ng1cW8lbExIQye9n+mjCEyGFkkq0GeeHJACk0VIHeY1xt0JsGkgrcM0d+8ePR25XuixE0iyCL7HKch5QbaiNeXfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855447; c=relaxed/simple;
	bh=S0DgpDTF0P3YrNym1GeURNDHJaFk3irGnKMZQJscdfY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fKCFzgnjymEv2WPde4lctUND3A41X7tuqZazIJ5aRlBkjYYkDHoG8D+FhH2m/ineVyTDZN5Wdlj/nHOQGOGwP9OvohqvXnOvH4IHPrgkZBGJv1C3SNRRmkaaGZiS4Z3VqdxNgbKzbeu/9wvqM7wCp0bjPANeLLBTnR/vDQpB4Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X4zml0pn; arc=fail smtp.client-ip=40.107.241.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkD5JFORGK175VtD63EQiLJ8HHZgCmQMLcyE7v+BcpcwOxGkOSSaIMY30iqIaBK/tTrgKpgwuQ1HI7bd5RzD1kG7lb7qZCj1Fkp6tTznWcZmNg2YxqtYTh6CM5vKUwa1ZjPBicnPTld9RpE644qVNOJIW0y3lFX8QKNt/17hPgYhIIBiW0GXKDR7ACcUMtARrOW01Jv+mC4ejIiUMsLwU2Iz3qBDWTYrBWS3EoqI5oEM3fKaUZdU3bWJp89hlW82yccoyO0gp6QIeETehUpAv2TvYq6wmhMDjhvfqs14zJt1juALl2zAWEnV33yBkaMgdY9WCMR/qSJTFq8pSeU8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY/IS7Vtj2DJ3guZOJa0tmbF3oF6souaDnCA+Gb6Uc8=;
 b=QgHZydzdJvDxExZkyknxnZmkXsN0cvHaj1x+JO/BFgSS1tOWtGKXDikbeW2Da3ooyf0rk/UtYf3eLiJWc0GalRAgP8L7p1a9JDUAWFetnaTXtz/okmm69mNtSViH3N8WOnDp+4levhoAczpz7W9laH0pgU0CYgkm/q0BSKOGzHKwP6xtgXdHaPpteYdkuclE4l6XpraAotCLNg870M+4TsYw/he0p2AxmUHJEQKYU9/wgOzGVeEbzpQt09uAlvoSWk9SIcLS2J3Vk5M57I4+mF5akBNH1+niOd9V+ehXCy6A37X6sSMCntiTxYJFlL9hBm4GgGUR16zF9HepKrPW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY/IS7Vtj2DJ3guZOJa0tmbF3oF6souaDnCA+Gb6Uc8=;
 b=X4zml0pn4WzD3V3Bshgg/5gRq7yuiesKNIb//3dnz5/wN1ETpIbUA2Ag0OTELxFs3Yd7LELeErrTkiUs63cWDjaya7pxiXxGNj6eAYHB3qCZgIuTpTUsl7lKpexWPHV4pxG5BF/u794wvtwkRqqmsZwZp/XeeyV5JSGrqtPJKL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 06:30:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 06:30:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 02 Feb 2024 14:34:42 +0800
Subject: [PATCH 4/5] firmware: imx: support BBM module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
In-Reply-To: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706855688; l=9360;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=bGPXYa2wA+R5Utwn/Cjyzw9Bhmxb9hyReBWGN67cbcg=;
 b=f7+QbG52VmdPpSl6W6bDgIfiwUzCoVU94MpctJjevbPhXzp5IIiM+MEI1ukZ2GZR83D59tIqy
 NGh15XB/XSjA7364wg8HoWHUBjd8m3zJ40NYsmBHSlCwG0Xs+cRprY6
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bcc5c5-0019-419f-82fc-08dc23b87a5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WUN5N2v1sXdDUwVh3XMWHFRrCZTpg4SMl0jcG9ok7GuUQtOuv/6Q+tj0xgr6lBINiJzx4zCrZ71yXWZSe6+fZbgrZYEPc8CQTnr5SWGN6DRQuujZqw3QkdC5MKzsCrrMI3JPwMuQyPEWvdNCDLF5dkft0VfXAsx53lellHG6JYY+J+9THzMk8lvSZjIN89xKZDixLfPAFgbsNyN9anCSNj+u/HmFE4PxVIJwFe7Rawlo35FWUBLGIAcW6co/7u/bo0Z9GKtmpDaxkELh3hcbg7xgSd/XuBxxLsT3Ap41mr7aJALLb7hL+TBRnQYQm+bJuZlnqt4TuD/RWvqTjMrBne/ua5ZMuBUrocWObVk2eEnACkwIUuIcABKKJWd7KR5sQuWmM8M808345f6UbMEB7D5wcpKqW/vyXIvl7GT7QCiVH73O50JEmttXZMFnAFobKSeDTyCdCOL2dyWkfkC6zP5RBmS7m7V2D4Ohw5Dh3GaxwIaHm7UkzLr/7E35S9F7d6MXJSqRfrRu1Sbkb1LZqYaDyKAa5umKgSU6Qbb2skMJ3R6RFKeqAY03irwoPOMKio+c1wM3hdtYNaCfeGnM5ic66ABrUpPwaNrfKjH1u/hzlZ1jIyWe1eproRkoMLgwoeXFj1AMXmmhplf3TaFosg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6506007)(52116002)(8936002)(921011)(4326008)(7416002)(2906002)(5660300002)(316002)(8676002)(66476007)(86362001)(66556008)(66946007)(38350700005)(26005)(36756003)(110136005)(41300700001)(6486002)(478600001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjU0bnhVY1JhYS9lYTNYVklBRkNBWERzNlFvQWtwRVJ6dlVJMkhRaHVsMEVv?=
 =?utf-8?B?bzFwaVZKMExaZ3phcjgwMUFEWlhMVDB1Vkt3UC9GUUJWYWZ4TU1GaDRKWTln?=
 =?utf-8?B?ek4xS2Nla0ZpTTVRWGZsYXdGcm9DaWp3cVNJaVFaMDIwb1ZQVi9yZngyYyty?=
 =?utf-8?B?dHB5aGFwcVpvdE5rbmFDM1BiY2ZnSXQ4QWIxZSt0T2JhN3k2R1VScnVET1pB?=
 =?utf-8?B?VlFaMDdncE9MNkhpLzI1VlpmT3RZR1Q0Tm04bEp6TmZua2VETVNuTW5FamFr?=
 =?utf-8?B?R2VaNjJyZ0d5ekIwcXJZMjNDdndtR29GaSt0bFlrbEZ0NXhPLzR0R3lwMkJJ?=
 =?utf-8?B?K1RVU05jemcxSXRIKzNsMTE3MFNCcnJFS2xjVHZSR0xiOWthOHZ0TFNoaXg0?=
 =?utf-8?B?dFRveDVlWHlZcE81RzVEbU0vMW9mdXhFMlVmclVsYldad05OQkI2UVQ0c3FF?=
 =?utf-8?B?TnFpa20yZDJhRlUyQm9qRVpuOEgvZVE0WDE2cWVyZytTc0V1azBGdDJFZS8x?=
 =?utf-8?B?SEJHdWV0NTdLVEZ5ZlBzdmlSY0JQMkRIRnpWZkdLUW5NdGEwbC9YOThwelNk?=
 =?utf-8?B?aFVoa09FNDgyYnR1VlNSUS9TOVdRajdRWXFjMWZrRUFNRkJtTkhYaWliY0E3?=
 =?utf-8?B?dDB3K28zM2FVcUF1eStJWTNWRmRESFFaTzFuSGowYklmYUZFNUcrTDB4LzRC?=
 =?utf-8?B?K1lFYmM5Szg2di95VWVLb1hPMDExRjFaUmpURzhlVHNYNVk2ZWlXanhpeDdI?=
 =?utf-8?B?NTVSM29BUmdOYngyek13V1crWU1KKzBLZU43eGpQZVl3RUFSdlRGUUJKL3NS?=
 =?utf-8?B?ZHF1Y2NORFdXQ2NMd3pDSG9CNi9FcnZjUi8vbUw3L3p3NlVJMUpLU0ovRWs1?=
 =?utf-8?B?dDR6b0RaNCtZaGxnUWN5V2w2SFhiMmpoZFdVTjd5N2ZTN3NZaDR6UzIzUmZZ?=
 =?utf-8?B?cUo0L0NFY3RwUUE3eFc3dnFabDIzOFVZcUdYbXJtNllHYVhnS2RJTTN3S0Vt?=
 =?utf-8?B?am5OSk15TjRIQ2lvdVZVbFU2dW1CekpVOHJybEtaNTRXU2ljTHVuTkY4cUkv?=
 =?utf-8?B?RlNyNGFxRDNPR2pyR3hLMFFiL1lMb1ZpdnZrZm92Nk5DNUM2dGIvYXdSWGto?=
 =?utf-8?B?Z1BLL2JsdDBJSUJpN1lPVGJPZUVVbXB2K3lWNUZtaXVRZG12NGNxOVFGdk9O?=
 =?utf-8?B?dnR4bkdnT2MvR2hsRmZDQ3NlSlI1UGVobWViZkplQ2dZSTJDdktQeWNiSVI4?=
 =?utf-8?B?d0JwSWhWTGczZ2QwNzZMV09EWkRSUzdSakw4MmF6ME9yL2t1c3gzNG5TeHIz?=
 =?utf-8?B?Y2gwZWhCM1gvN2pPRmtYU2dCekJIWWhHVG9kQkJnYTEvOFlzUXJhZ05wQXcr?=
 =?utf-8?B?RExJUzV3WTgxYWNKTWtYWWJ4YlU1SHdjSGRvMlZBRTk1S2I3ZDNidm5ncXlU?=
 =?utf-8?B?cGJhUCtlbW5qZ0R2dU1pU0w3WTBrcENLa1RaUkpvZVJyek5zdU9Vb21ETURQ?=
 =?utf-8?B?TnlubGFlY3h2TmlVNjYvd0VQQk1iNW1kRlFMWDAzS2RjWHBOYVdmbTNTVE0z?=
 =?utf-8?B?VVRhdXFocHg2YWMwZXdXajJsU0RvZkowdk1WMFlMbWswMzR3bm5OOTBVV3BP?=
 =?utf-8?B?cHRZV3hPRURrQU94ZWY5eEdOZjV6aTdkYUJjR1dMWDFpelZLa0kvQkh6WWR2?=
 =?utf-8?B?bWFoRGg4T0xlUm4vOTJFbWh3dU5oYmcveUU0a2MwaGF2cVRtZUVxZVl0WlhU?=
 =?utf-8?B?SmRQcU9ZeklucWR6YUppZy92QUM2ZkdzeklWdldUbTIrRFdJeEdGbktwWTdr?=
 =?utf-8?B?QjhPMjJWQ0ZRNGRaVE1mbWpKWE9JQkNicWdOT0UwMzhFc1RzRWtlbHRBanp1?=
 =?utf-8?B?VW1pNVBpL3dpQU9vUE1TVUhsR0dJSXlkUE1vc0lveG5LMTRzN1dxT3NYTHRj?=
 =?utf-8?B?RWcxT3A2b0t2bVdOeGFJWW9VWVVlMmh4dHRwSWRLSU50amZEVFlGQXYrR25X?=
 =?utf-8?B?UjRic1FHMyttYzBMNEFkSnY5K0MrQVc2dWszSXVvTklnb05GNWNqQ1NEeW03?=
 =?utf-8?B?eXI1OXNNejJETFNMa2pvVlQwSURVOGIydDV4bkczOTRveGM3ZVA2ZVVTZVVQ?=
 =?utf-8?Q?+1ObJ47NY2RK7iWsPGNU32dlW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bcc5c5-0019-419f-82fc-08dc23b87a5a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:30:41.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRqMbqmgn+fMpAD1bPy4G6Q1jl9dLfQHpAr4+A8GyRGLJN47rcDZ8swdmcw/XNfK9GU8yXNBcBxRBeB/fBinfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

From: Peng Fan <peng.fan@nxp.com>

The BBM module provides RTC and BUTTON feature. To i.MX95, this module
is managed by System Manager. Linux could use i.MX SCMI BBM Extension
protocol to use RTC and BUTTON feature.

This driver is to use SCMI interface to get/set RTC, enable pwrkey.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile |   1 +
 drivers/firmware/imx/sm-bbm.c | 317 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 318 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..fb20e22074e1 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
diff --git a/drivers/firmware/imx/sm-bbm.c b/drivers/firmware/imx/sm-bbm.c
new file mode 100644
index 000000000000..c5bc571881c7
--- /dev/null
+++ b/drivers/firmware/imx/sm-bbm.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/input.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_nxp_protocol.h>
+#include <linux/suspend.h>
+
+#define DEBOUNCE_TIME		30
+#define REPEAT_INTERVAL		60
+
+struct scmi_imx_bbm {
+	struct rtc_device *rtc_dev;
+	struct scmi_protocol_handle *ph;
+	const struct scmi_imx_bbm_proto_ops *ops;
+	struct notifier_block nb;
+	int keycode;
+	int keystate;  /* 1:pressed */
+	bool suspended;
+	struct delayed_work check_work;
+	struct input_dev *input;
+};
+
+static int scmi_imx_bbm_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	u64 val;
+	int ret;
+
+	ret = bbnsm->ops->rtc_time_get(ph, 0, &val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	rtc_time64_to_tm(val, tm);
+
+	return 0;
+}
+
+static int scmi_imx_bbm_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	u64 val;
+	int ret;
+
+	val = rtc_tm_to_time64(tm);
+
+	ret = bbnsm->ops->rtc_time_set(ph, 0, val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static int scmi_imx_bbm_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	return 0;
+}
+
+static int scmi_imx_bbm_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	struct rtc_time *alrm_tm = &alrm->time;
+	u64 val;
+	int ret;
+
+	val = rtc_tm_to_time64(alrm_tm);
+
+	ret = bbnsm->ops->rtc_alarm_set(ph, 0, val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static const struct rtc_class_ops smci_imx_bbm_rtc_ops = {
+	.read_time = scmi_imx_bbm_read_time,
+	.set_time = scmi_imx_bbm_set_time,
+	.set_alarm = scmi_imx_bbm_set_alarm,
+	.alarm_irq_enable = scmi_imx_bbm_alarm_irq_enable,
+};
+
+static void scmi_imx_bbm_pwrkey_check_for_events(struct work_struct *work)
+{
+	struct scmi_imx_bbm *bbnsm = container_of(work, struct scmi_imx_bbm, check_work.work);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	struct input_dev *input = bbnsm->input;
+	u32 state = 0;
+	int ret;
+
+	ret = bbnsm->ops->button_get(ph, &state);
+	if (ret) {
+		pr_err("%s: %d\n", __func__, ret);
+		return;
+	}
+
+	pr_debug("%s: state: %d, keystate %d\n", __func__, state, bbnsm->keystate);
+
+	/* only report new event if status changed */
+	if (state ^ bbnsm->keystate) {
+		bbnsm->keystate = state;
+		input_event(input, EV_KEY, bbnsm->keycode, state);
+		input_sync(input);
+		pm_relax(bbnsm->input->dev.parent);
+		pr_debug("EV_KEY: %x\n", bbnsm->keycode);
+	}
+
+	/* repeat check if pressed long */
+	if (state)
+		schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(REPEAT_INTERVAL));
+}
+
+static int scmi_imx_bbm_pwrkey_event(struct scmi_imx_bbm *bbnsm)
+{
+	struct input_dev *input = bbnsm->input;
+
+	schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(DEBOUNCE_TIME));
+
+	/*
+	 * Directly report key event after resume to make no key press
+	 * event is missed.
+	 */
+	if (bbnsm->suspended) {
+		bbnsm->keystate = 1;
+		input_event(input, EV_KEY, bbnsm->keycode, 1);
+		input_sync(input);
+	}
+
+	return 0;
+}
+
+static void scmi_imx_bbm_pwrkey_act(void *pdata)
+{
+	struct scmi_imx_bbm *bbnsm = pdata;
+
+	cancel_delayed_work_sync(&bbnsm->check_work);
+}
+
+static int scmi_imx_bbm_notifier(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct scmi_imx_bbm *bbnsm = container_of(nb, struct scmi_imx_bbm, nb);
+	struct scmi_imx_bbm_notif_report *r = data;
+
+	if (r->is_rtc)
+		rtc_update_irq(bbnsm->rtc_dev, 1, RTC_AF | RTC_IRQF);
+	if (r->is_button) {
+		pr_debug("BBM Button Power key pressed\n");
+		scmi_imx_bbm_pwrkey_event(bbnsm);
+	}
+
+	return 0;
+}
+
+static int scmi_imx_bbm_pwrkey_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct input_dev *input;
+	int ret;
+
+	if (device_property_read_u32(dev, "linux,code", &bbnsm->keycode)) {
+		bbnsm->keycode = KEY_POWER;
+		dev_warn(dev, "key code is not specified, using default KEY_POWER\n");
+	}
+
+	INIT_DELAYED_WORK(&bbnsm->check_work, scmi_imx_bbm_pwrkey_check_for_events);
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "failed to allocate the input device for SCMI IMX BBM\n");
+		return -ENOMEM;
+	}
+
+	input->name = dev_name(dev);
+	input->phys = "bbnsm-pwrkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, bbnsm->keycode);
+
+	ret = devm_add_action_or_reset(dev, scmi_imx_bbm_pwrkey_act, bbnsm);
+	if (ret) {
+		dev_err(dev, "failed to register remove action\n");
+		return ret;
+	}
+
+	bbnsm->input = input;
+
+	ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
+							       SCMI_EVENT_IMX_BBM_BUTTON,
+							       NULL, &bbnsm->nb);
+
+	if (ret)
+		dev_err(dev, "Failed to register BBM Button Events %d:", ret);
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "failed to register input device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int scmi_imx_bbm_rtc_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	int ret;
+
+	bbnsm->rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(bbnsm->rtc_dev))
+		return PTR_ERR(bbnsm->rtc_dev);
+
+	bbnsm->rtc_dev->ops = &smci_imx_bbm_rtc_ops;
+	bbnsm->rtc_dev->range_min = 0;
+	bbnsm->rtc_dev->range_max = U32_MAX;
+
+	ret = devm_rtc_register_device(bbnsm->rtc_dev);
+	if (ret)
+		return ret;
+
+	bbnsm->nb.notifier_call = &scmi_imx_bbm_notifier;
+	return handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
+								SCMI_EVENT_IMX_BBM_RTC,
+								NULL, &bbnsm->nb);
+}
+
+static int scmi_imx_bbm_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_protocol_handle *ph;
+	struct scmi_imx_bbm *bbnsm;
+	int ret;
+
+	if (!handle)
+		return -ENODEV;
+
+	bbnsm = devm_kzalloc(dev, sizeof(struct scmi_imx_bbm), GFP_KERNEL);
+	if (!bbnsm)
+		return -ENOMEM;
+
+	bbnsm->ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_BBM, &ph);
+	if (IS_ERR(bbnsm->ops))
+		return PTR_ERR(bbnsm->ops);
+
+	bbnsm->ph = ph;
+
+	device_init_wakeup(dev, true);
+
+	dev_set_drvdata(dev, bbnsm);
+
+	ret = scmi_imx_bbm_rtc_init(sdev);
+	if (ret) {
+		dev_err(dev, "rtc init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = scmi_imx_bbm_pwrkey_init(sdev);
+	if (ret) {
+		dev_err(dev, "pwr init failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused scmi_imx_bbm_suspend(struct device *dev)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+
+	bbnsm->suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused scmi_imx_bbm_resume(struct device *dev)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+
+	bbnsm->suspended = false;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_ops, scmi_imx_bbm_suspend, scmi_imx_bbm_resume);
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_BBM, "imx-bbm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_bbm_driver = {
+	.driver = {
+		.pm = &scmi_imx_bbm_pm_ops,
+	},
+	.name = "scmi-imx-bbm",
+	.probe = scmi_imx_bbm_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_bbm_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM BBM driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


