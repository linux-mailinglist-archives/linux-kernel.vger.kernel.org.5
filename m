Return-Path: <linux-kernel+bounces-141754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44678A22F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6D1F22EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C85F9EC;
	Fri, 12 Apr 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J9QDXMGX"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF55DDDF;
	Fri, 12 Apr 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881301; cv=fail; b=IvSjJWLyHslV7yNGE9K4iItoQa4i0Anrp3RvRRzkQb2vZXsYLoxvRwn0PnhPnqAEu5OMe2zMa5kNVvtEgBEypgKo2iK4T/z4HmtMRUerxxnzpIANrpMUQqktGhY6/MhsWE8/bVzF2l6I41LKjkql8zF9UQ6lOILnQAm3MD/jAAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881301; c=relaxed/simple;
	bh=sTbjkh5a4aL+MAQ/wjB1CKkR1t4PZQRgc81I9MVcnXg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HP5BOcTYJRSQmw7zozmJvoCGNlAqd8ZIJMlz7/DlOaWREYDsdmEwB0n6zzNAF3S8u73kVRcoByFMk50PgPnWAopKHgtUFfQHx6lnAkgseMgBmha2xr6koGmqT57doP7pI6MfZMNvihqtS8H4+ASVCy/61xnXTjQl1UgCftvjOa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J9QDXMGX; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC7/mTKekyxxnYc/zoJLoq+EVI2X5xf9RXQMEaURp1JfQv/1WgPM55Mmn9EJvm0oh2E6OvU3m4zfXAMv5yppxVEsb2PQS0MhyAQES1dYpFtqOFpgYkYZBKg54hmEIR+H/dY42Rsp86Bwa8VN8QGNaxljjUs2/+Qi3Guopqxa3Thh2F31M9c2gO3QhZJN0duhS8+AzAtP7iZyHCCa299SDNSwIH8NKOvt8UeqE1AvzQ5aw6RCp4/rgpz+UPsVY0qAY44R9MGeEbU6ffFOcTCmZ2Dc4oq4Ialn/Tpv06+7pAv8vX0WPRaGlqnMY7zKijqb7Xot/gNHSaa2aKNXVDy7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXgMZQkn8/FX0xym20E8GQT5ndZobjEeQMFpgLdI5/0=;
 b=eDZHXTa9jAj46uaaXofmPX+OLCLwETh/VT2cRvgJ2Hy6p026yzSDyxBdJjrFchn9wELUWJeugkBx9sXrgQZHWGz3KlcapnrOFIusQ2WvjsTqDIdReNpHseonIZDdED9YMDLCYZ9pmlaz5wDtsC8DaNMhIxMmUxh7Ksd+w6wCp/DymOvxBHvE3ImWewhDlFhZCHm1oUav0wZeGrpKmOkvimEiS0Fl5qtIK890OzN8/UIv5f5rveBrxseY+J0dSHII0fUp3PWsICrhjbYIo+04h20+gQTZCd+0JPeLebydWesDSAwtICDtcTPtvD8wyvQKxbYELKOSVOAptwqJ+DVMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXgMZQkn8/FX0xym20E8GQT5ndZobjEeQMFpgLdI5/0=;
 b=J9QDXMGXfCIqnRnu2hgt4upxNnKISZmgx9UWMNpi1wHjsZGOCqCmwhGBEWMVrLMzhoCrisi36pytTA8UZpg5PAuxMQo4wNb5Mh4QAkJqLRsp71A//UfZtcSGFaqdi+rl0AXLcKKpT7JMKkVy7NAvWeZKp+/gYjmA44zpNVDJz2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:21:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:21:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:29:27 +0800
Subject: [PATCH 3/3] pinctrl: scmi: support i.MX OEM pin configuration type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-oem-v1-v1-3-704f242544c1@nxp.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881775; l=2796;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Tzl0BI+t0SHnhwCwshMQRPsrD5//1fkJuvy5P2j38Qw=;
 b=U8QZ0gz5dmnXOpcBoRMlG0SqXZMbJHlRQrzOm3IdqicR2+AGnAGWKcEeKxfieDMDY6jm5+nZe
 lLpidbGXt0EC+z2xoV54NEIm/H9Ev9zJ5P+PPm67iG1t/I+1Xg+Sqap
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: bce5f7d8-d249-466b-1a81-08dc5a868465
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4kvyoMR6JtEaeCcNw43N4gTq24QTR21nFWNnSwcFR2Bp5WVcHkqO8fv6jk5NyYii3gpcT6OFSc04l7/Z/Gw66Jukw4Owg75Zy7UqS0R67GGcRAwPLfm5/K4r+/Uygp5Es9x72+e7J66dfob6OFC4XEAJhCNQriEHlpg1hxBq4LtXXA/ykQfQYLj8IVXys8UDECGjIfVSl3VTyfyvTB8e6sBWAdJvkXarqZT9oR3NXBLRg08kisY+qcUWn1GPaigHBuzU/IZDDwwRzUEwfjVi/LEEffDbf1NQ1n4rY5DEuqNQsv7LJkpViwcuiWvmxkGXPst2PfvlxERiYObyUJ72JfmtzXLqVBxHtpPKSwFuPT/ZQd5PsOW8LJYb5fGAVMj0rSmvdQc+Ae2TJZ10gxHQNcX/YurLOeb+/uXd+TtzfeSOhNMH9Lz27JUUHmpqxF4kamoE98ENQqwOdcM1Q1rm2cKg19oULi7HednkaNTY5F9GlG8thmaaREgxYeyBG1uPABY60W2uNq40VSRSQvqTJHNwy/Kx4CCXXDVl9MMUIhjgsFJEsqdJetONtLUQDWwFAvOQ9MYIJk6GpHk0Mt3ToJKNaiagxVCMbDj+NcG/5INzjjN53VE5TZZhnCM6Enl7tyx03vlkkbItQyGunahkUrmOuL7JrAt8UWk+IMtVJmK4X+UuvtNM28fsDbp6uqbemhxNbFOqBIflIUGfcBkkkaPW+R85jv4KaTmx+f66qLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2R5ZnFMME5SY1crRHhIcGo5eHFFZ1BkcTFyV1U3a2FlLzg2VmFXTXZVMGV2?=
 =?utf-8?B?LzNXZCtEeDh0amZQM0F0aVJmN0xkREkzMEJ2S2gxVWRpM1NlVnZTOE9qdGJ1?=
 =?utf-8?B?VExyN0JyN0pxbUJsSm1SSXoxeWJBcEN5bTErOW42YVcrUC9FRnluRG55bkQx?=
 =?utf-8?B?Mzl1Z0tMTlBuQy96dlRpb2Rvamp3a254bjlvSnZVeDYzQkErOHVmYmxlenNC?=
 =?utf-8?B?MFJXbk51M3pwR29IQVhSTHgyYlJCcXk1TVA0Z3A3WTJsRmVEVy9xcnpra3hx?=
 =?utf-8?B?WWlnN2sxVXB6TUJFM3JGeC9Qa0lWcmQ5Y25LSU1sWXMyRkFpZEcvdHBHdm4x?=
 =?utf-8?B?Y2dYZzNXbGZzVDlOS2p6OUk1SkZDNVVkZThzT1k1dzF4VXM1cFd6U0FUalRQ?=
 =?utf-8?B?V05GS2JtTC9GRHBFblhBSXJxQ2hyTW11WGpPdDZFRU9IeVVUcmVhRnFNcUVC?=
 =?utf-8?B?RENPSlN4K3dsSU00N1dBcTNmNWlXdTJMV2tLTG42YUh3dWFFNHRuajc3aXUr?=
 =?utf-8?B?bXhNWHdGSzJDbHNnZ2wxRG45dEF1QkVwOXBBVXpMRTV1QndsYU8vVEhQKzVL?=
 =?utf-8?B?NUJBUGF1K1JwTVpXdEpISjEwZ0syaE9TaWxQWGcrZllBN21GcnV6dnFXREsy?=
 =?utf-8?B?M3dCTlVVQnZ3TjAra1R4TXE1R3kvcUtBZFkwZVUzdUQ3aTVWUWc0VWxjaHpk?=
 =?utf-8?B?K1lvVWVxL0dpc2grbTlmYmFrODJla3Zrdy9henlPZHpIaFppQVNhOWR3RXNv?=
 =?utf-8?B?eFc2MGJNNG9uS0hHRVJtS1BJV2doVU1kM2wxcGNPNzN1YjJMZFpBMFJYc1BL?=
 =?utf-8?B?MytNNDU2M3ViMDRVWExWK24vVnVKamptQ0hHMWFjVkxrTlVSRmVzTEw5Ky9Y?=
 =?utf-8?B?VkUxM1g0VWdCZDZIR29KelhDU01GY3FzaXRrMk04YUd2eU9wdmtQTkxRQjFo?=
 =?utf-8?B?SUkxSy82TWcxSERWWHd1SVc5QjFEekg0OUxKSC9DMklsNGxUQVJObldNQlJK?=
 =?utf-8?B?Nlo2QWZkMDdUMno3U0Zma255Z3VHYnhaU2NOQ1crM2xMZm96T0UrOFBxeXVh?=
 =?utf-8?B?OGYrSVVQTEptV3dGRUp5dExUMXpNY1dONm5Cd2dYZ2VDbzVzR1NvQkZHcm9r?=
 =?utf-8?B?Q25ReTg4djRHOFhTTWJGT3hCaUNJaWFHVlRtWWtuZ3g3QUtSQjVjamNGSUht?=
 =?utf-8?B?cTBEMVdOSTB0Y0xabmNzdllJWFBKRmRBajFPRnoxdy9MQ09qclFaMS90Z011?=
 =?utf-8?B?dzV4aEpiZzcxUEtlTXFxYXdTUVlXL25WTEp4N28yeWZJSDBQSlM2M3hYOXNm?=
 =?utf-8?B?RmhPaGcwVzNNdXM1dFNOSXF6bDVUSlRHVS84K0NGeFl5SnI2eEtNL3NjMHNs?=
 =?utf-8?B?UXFDS3QrQXNjMXVBS0VsckNYNVNYS0YwY0Z0OHA1ekVxbmpLOXJ6UGw3TVdU?=
 =?utf-8?B?c2gyWFR1WWwxVXQ3b3UrZ0x4WkxvQlRwbEdLQitZZnJtSlduVW5TODZDbXJY?=
 =?utf-8?B?VzRrTjIvb3BvcTZtTmRObGdnNUV1a0lxbHZyNnVRcEJpZy8yU0V2MGJXQ05y?=
 =?utf-8?B?eWM0SFhoSHNTT3lWOW82a3ExZElML1ROZlBIM1ZUNWlFT1JseFBPS1lIMk0x?=
 =?utf-8?B?R3lCMnRmcG1jMUY1aDVhTXVaUml5L2tKKzNSL1UvVXh2cXNtUjY1WUNqVHlj?=
 =?utf-8?B?Sm5jNDRoWmp2QTJ6NEJRQ253OEZZVytrUmZ6WWJ1R2lwc1BCRXc4bzdtNlJQ?=
 =?utf-8?B?QlIyakVOK1IxN3kzZnp6NVZnMTByNTJKYnhjdjljRDdUalpOWHBYS1AzNW9F?=
 =?utf-8?B?MWdyaDNNNncyZEo3aDBCWWMydkpRRSt4UVVpZjhjc01NZ1BYOGNMa2dQMkxv?=
 =?utf-8?B?NmYva3BQV0prd3lYTW9YUlZXM1RLVGVFazF1Ky81cE9LZERocmFYUEpXOC9Q?=
 =?utf-8?B?NDR4ZFk3N0xPakRUQ3drNitaNTYzZmxHdVdpOVF1bUJvaEZ1WTB3M25QVExJ?=
 =?utf-8?B?aFpBMHpUOFVXNUJvYWFROVZwQUtoS3dYOFFmWlZXOUNKak5JOW11TVdDbWlC?=
 =?utf-8?B?amozMXFValNPZktuUEM0LzJEZTNvaldKbXEwbWVmbDBjQTRjOE5jUzJnZml1?=
 =?utf-8?Q?GgwiixZYbonrUZUIAVcr7Wfhf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce5f7d8-d249-466b-1a81-08dc5a868465
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:21:37.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keGm/0zTyPPysGP2SYw5Je4wbwNkoPPi/UNipdYfBBAwlmw0/fellq0R1SV04sH672b704XndmEjMg8iiGRCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so extend the driver to support custom
params.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-scmi.c | 23 +++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.h | 15 +++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 0f55f000a679..97c3d9d4634b 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -20,6 +20,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -462,6 +463,23 @@ static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
 	.pin_config_config_dbg_show = pinconf_generic_dump_config,
 };
 
+static const struct pinconf_generic_params pinctrl_scmi_oem_dt_params[] = {
+	{"nxp,func-id", IMX_SCMI_PIN_MUX, -1},
+	{"nxp,daisy-id", IMX_SCMI_PIN_DAISY_ID, -1},
+	{"nxp,daisy-conf", IMX_SCMI_PIN_DAISY_CFG, -1},
+	{"nxp,pin-conf", IMX_SCMI_PIN_CONF, -1},
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const
+struct pin_config_item pinctrl_scmi_oem_conf_items[ARRAY_SIZE(pinctrl_scmi_oem_dt_params)] = {
+	PCONFDUMP(IMX_SCMI_PIN_MUX, "FUNC-ID", NULL, true),
+	PCONFDUMP(IMX_SCMI_PIN_DAISY_ID, "DAISY-ID", NULL, true),
+	PCONFDUMP(IMX_SCMI_PIN_DAISY_CFG, "DAISY-CFG", NULL, true),
+	PCONFDUMP(IMX_SCMI_PIN_CONF, "PIN-CONF", NULL, true),
+};
+#endif
+
 static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 				 struct pinctrl_desc *desc)
 {
@@ -526,6 +544,11 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
 	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
 	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
+	pmx->pctl_desc.custom_params = pinctrl_scmi_oem_dt_params;
+	pmx->pctl_desc.num_custom_params = ARRAY_SIZE(pinctrl_scmi_oem_dt_params);
+#ifdef CONFIG_DEBUG_FS
+	pmx->pctl_desc.custom_conf_items = pinctrl_scmi_oem_conf_items;
+#endif
 
 	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
new file mode 100644
index 000000000000..fcc61bc19c98
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DRIVERS_PINCTRL_SCMI_H
+#define __DRIVERS_PINCTRL_SCMI_H
+
+/* OEM VENDOR Pin Configuration Type */
+#define IMX_SCMI_PIN_MUX	192
+#define IMX_SCMI_PIN_CONF	193
+#define IMX_SCMI_PIN_DAISY_ID	194
+#define IMX_SCMI_PIN_DAISY_CFG	195
+
+#endif /* __DRIVERS_PINCTRL_SCMI_H */

-- 
2.37.1


