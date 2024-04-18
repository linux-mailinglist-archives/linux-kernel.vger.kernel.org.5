Return-Path: <linux-kernel+bounces-149451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF098A9147
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F6B28275A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511354679;
	Thu, 18 Apr 2024 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GDNujn8/"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DB537FC;
	Thu, 18 Apr 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408331; cv=fail; b=f7HG1Aq7vm9yML5sORymoAw5S8k9iJOyv+lUdnvU2IN3/+cdNWbWnBKPYsFYkMXcvRJ/2vOp5rNMskJEuvuAfwKPQunwjptY3J29TcuBBAuEm07oFGy26FKcFC4SmSyWlmAw4GZpGxQlK5cNCPtfGYA2dJaTHAQADH7i9ZyDi3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408331; c=relaxed/simple;
	bh=Gk4hU2r+iaIIfBmi9wqN/jM0lkrvMeT46nOOAxus8Z8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Tojb3/TtAxdtJgIBTyhm2PVnKo+l1kwB39oNLYdKpkb8EW7ukN0lM4bvgGGhCgrwYmOcpxsEHOH+8v+pkHjBFTdDmDXbVbyfKTdj0OhMZESBVVOPS+Numa6/yf+oIW+pei7FXYrL52i9IjW9jQXveXrqS4gO0ja4o/SNG3k5AYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GDNujn8/; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUcYmNe86cMQ2rtOvc+/XC8tLwX/u3WuQpIW8Xk7xkIaiAWsqU4sBYEDC76l8xNHfDvZJYKi9LJ/jDEaNqrJ/6CX3+34xmP43J57rItmq9lpEuhOSgfX5wLbPFrvgnEI54tqCx/3useFWlgarOfCUC0DUlbYP6hoZh1TsjESqQp/nngfSh8KFMB9VjyL+yYZOJKj5Gfg0qQkSnMW+kz0Cu9A0GzS19ZvDd4Xgirn9r/49GZ8NFoVBurjHmk3Eex3y5V746J2YuV9ZKzxVnQ5WqlduURQFuViPuZMqpJf3qH5rKsSa1XWCzCUXll7u7t7lU50RlJPhuenZlHbcilirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS1364QTWuqHKoS3BSH6dxCAfRcqyGmb5slDWU3QQDs=;
 b=Azy7O/oMUXZ+9C4/HfKYI5uJIwzvojiO92alKMDPfPigJdFnnrE+ml2aPF1+PjPWF2sODj+1HGRChZOHUsAVwamc7exKFtlCFH4SLn6n84bCiXdxenRkd655IKX5lhZ2S1JFN4DIFiWlgtxrjD42/NbnMXXi4tkW1K5R83ciRBgf09Qji+UWJ95hMCK3atDwpjIqku1kL68tcAaQjA/R9NjMuP8Xv9lzEsBHJb5SQuGNQOdHnIaFteIBHDsuVCDf9APMhYQq/sNvjE4ZTU6IbRwbKNzb1uQ9PPXHBJifIJBL+aOOgQAY6fc5165XrGAq9JIjowhC6sIeku1kTpp/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS1364QTWuqHKoS3BSH6dxCAfRcqyGmb5slDWU3QQDs=;
 b=GDNujn8/AtTm9yXVH6I0O/9w4114vTuIhxG9rX8pJt/n3vEsAFr6EkabATCRfsk1B9zKtdVkwXe9kgjPbUJOLwggTlfrCuMJVGW8U2PlPPo8Z9D2iYyVp24lwPcxsgQ8UAFgcmHRVOmrUPwZy6T3vRZZJoDsz/kO8Xth0OL7jFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 02:45:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 02:45:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 18 Apr 2024 10:53:18 +0800
Subject: [PATCH v2 2/2] pinctrl: scmi: support i.MX OEM pin configuration
 type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pinctrl-scmi-oem-v1-v2-2-3a555a3c58c3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713408808; l=2796;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zPpDa/61WB4JTsNH+KhyU/5a0m6RG00gkpxSuVKB/Qs=;
 b=XjNoNjaAaQ6U4pEzMhv/6Trs/JpRlXS2TEntq24sbVtXi+my5O1vvelWeu5ixiym/Aj3lRHkI
 ITJMMwyOYWZDFrtmJAkLmnPqNg+yDvCyG7C9TevQfyl+V5ic34Qj3c3
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
X-MS-Office365-Filtering-Correlation-Id: 916dbc2c-4eb7-459f-5f6e-08dc5f519a52
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vuINNb9gdi9BoHN8PCXpjB5vLlwbe7HYijRJP47t3gImjt+PLOhNAaI+nM0U1LirNSBgzebCxDitSlTWzwLV95HpcucTYcU3NrXk9TvxR7sosRpiyfTA84uN1wYPbAHpHpEHYc8bLRYS1oIiuUwODxSrDKDQaOSQNpqQnWxk8BtPNnuBPp4tPGz4FgIbgpNg9gnS/90L4jjrcyZxx4C2ltZzaNcJAXGuphzBXJRL16WjQw+0IP/mYDfIcYK9I55+EjbEno0P/1k1aQRpjYUGQqFtWUbzd5Tu1BC7Z4vA9d2kPaDCvfIVnoXGCdt9PK0ZNF6EJMDuSOejwOV+kvTlIXTUpvfCtO4PQ1AYQfrrCFF9qHaqsjLusCvzq8fRYIuJnmV9nODpuadHSpqd/odose2208vBTyfKkfNg8Q1MCd/VzUh80u8gHi9kx3v3wPW88ikohpVCoug8fbnXx9Y+0fPJWJm2qaLsBuapG5XLl3ryantS41ZClPdBKuScyHLhfwSG7DmWYaZemshztWzmvnLx2ERkDzpUSn0msUH3OVdPZz152xTJNXwJvE3e6FThPOpHKedontF6Y2SKJHK0m7V5E4lAbKKV7xIZ8SOsbn/vrPtgoXih3pDeUaO/ehIC0CuJTAZKXByzeTcgoFDBT1yMQqQZ8sAA7k3jJ99mx9iwCKtnlYqusWyiSuIHm5Z7UZqg2VO/yESiCR3/iONz4KDtkjnXl10lIH5M2YJMLCU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHIzeStaNVVjMWxnUFJCQ0lXeGE2ZTdHcnZIQjExVGxPb2ZPYjZlR0lnVWZo?=
 =?utf-8?B?NTNFek1zWnhIOXErbUx1K1A2U0FvK2dWcCs3R1A3eElZRzA4Uk5XZE1IR29R?=
 =?utf-8?B?eU1IVlI5UkNucGZOck4xdmxpdnBlZXNXRDQ0RDFMakZiSDdoTlhjTHR0YXFG?=
 =?utf-8?B?elhVVzBqaEVyR2pDUjJzczVqS0h0dmRVeUtSK3FUUzZaQ2NsRWgrOGdvT05G?=
 =?utf-8?B?Tm4vQ1lZKytRL2twRTAwcEVHdHNOR1djQThMVHdIK1YxQ3hQQ1JnZ2crK3I1?=
 =?utf-8?B?ZWVPYkh5Z0tTTS9xQzhiUlBoaFludUZmMFlEelJ4NmdvdTA1VVRsSDZWK2h3?=
 =?utf-8?B?Z3RXWU5PdmxiS052dGhVVE1odEs2NXcrdnVzWVhwOHVtMmp5TEx2VVNpaER1?=
 =?utf-8?B?dk9rd1MxNmRQdG50WW9PeDgxbXhPN1E5TVpRWGxxNjh1bHZiakg3Q0RhdFFw?=
 =?utf-8?B?b0ZZbUlxOFUxYmtqNU0yZjFBeXZoWXprK0N1NVF6dUkrT0V6ZGIrbVROT1Y1?=
 =?utf-8?B?Z05ITlJ1TGk1N3JkZG9mZHJFTWZGWXZXZXNuaXlXcVFNSjJta3lUNFlJdjl6?=
 =?utf-8?B?dk9ncEptVENjWlZBS1NDMVJxT3BjOVkyN09nUHkrZkJaMzVqY3lTT2ppQXk4?=
 =?utf-8?B?T0x5RXloVzdrVWMwaUFNQ2d3aEp6Y09peEhuYUlzQkdXM2R3UXN5ekhmWkpM?=
 =?utf-8?B?UXZXN3RaMHlldFVDM1lweDNjbUdVNmFPQWs3cysvbFZuc3ovbXFlODcyemJ1?=
 =?utf-8?B?L2JjTHFCSEwwWUY4SE81RW13Qjl4WXhCaWRrYktXOFduWW90aWtCNFhUazA4?=
 =?utf-8?B?aG9tdzBEN0M3QXRiRzUyZnpBTGQzWUpVUW5pWmRFRnlqTHk3RHBaSlUxa09F?=
 =?utf-8?B?bW14MkhmRzMzMGVKU1FEUk5MZi8wdmhCU05ic1cwOUZYTGNiZ01oejROK0F5?=
 =?utf-8?B?N3BlZUVLT3JKclhuZjVLcUo5elcyZC93NTNYL0dBNzJSODhMSXFndWEzL1BO?=
 =?utf-8?B?VUl2Tk9SRGFjajh6SDljWE1Nd2xjOHFJdFBoRXZJcEdUUFEzaVA3MmhMRkxF?=
 =?utf-8?B?bFVvZ1h1a042UTE0OGhDS24vblIxWTJrNjJwd3VnVytzTCtwYytJNjFvQnkw?=
 =?utf-8?B?S3hKUU51WmhTNUxGeUpDRFNPWHJ6cm9lcXNwalZoejc3OEl4QXlKR1loOVVG?=
 =?utf-8?B?ZjRTUG1ob0JWTlNLSlc5N0w0eFplNDBOYnZIanNpMEJNUi9NUWtaNXpROGxq?=
 =?utf-8?B?Vm9jTjNKSnVDeS9WbDUyYmNHakh1SThMaVovQlNKT0Q1eFloYS9uRU9YWFFh?=
 =?utf-8?B?c3R3aUxxS1lNZmpIS1NORVlJMU1CR0VJR1NjU2xEcEUrdWZ4WFBmK2VFZStj?=
 =?utf-8?B?WnZ6bU1EbWp1aVJjNWVWUkQ4cjFlVVFURUk0RmxoVGZITzkybEtEMkJMWXJz?=
 =?utf-8?B?ZXpsWXdzUUhleWpzb2pYTlFMZEljTlpHdmtBa0ZhbGFtc1RDNno3eS9QV25n?=
 =?utf-8?B?VGc3RHlDRnJZaHEvQU9aT3NyeEl3RndXdUpwRzhvVjlLNnBrd3BIT0hWb056?=
 =?utf-8?B?L05TWmRGakUrY2s1YjJGWEY1RVRlZHFydTBXNDhXU1RCMGlUUDdISG1DUUo4?=
 =?utf-8?B?bnpudmJGU3RzL2NUS2orUkRvQWJQK3RCc1dnVUlNQXBuUE9vbm5kd3RLanho?=
 =?utf-8?B?RHlwVUNzVi92amg2N3laTzdJVXR4Y3M0SGNNQ2dsTDhqcnNMUkFicGhKbkhy?=
 =?utf-8?B?VmorYkdhbnFncncwQ0RhcVlpZjhmbzFsQ1BHbzBHOUJtZldUYmFNQ1MwNzEy?=
 =?utf-8?B?K2ViL1RlNkZZaHVmbW9ZbTdhbkN6ajhvdW5nQWEyYzBObHN5MDlRWVdtMjlR?=
 =?utf-8?B?Z2tZdDBiYzRXUW1XaExQdndodGsraTdyakRhR0hieWZiQnlDQ0pBR1lIdWk4?=
 =?utf-8?B?ZklyOWhBZTR5ZXpIWUZ5QlpUVlBRdGNPRlV4ZFlHMzFWOW9lZ0xvUkozdFI4?=
 =?utf-8?B?WVJMQ0VsR2ZPZzl2UlpmWWd4YlF5VFlXVHlCWjlKaG83ZXQxa2NaVGg2dnJE?=
 =?utf-8?B?UzU4UURYaDdjZEpGSmZXQ2E1K0RHQXpsdHRkWFpubXNVL2I0UzdtTERyQzFN?=
 =?utf-8?Q?68sjR3Chc7dpCKZSta6P/VMQl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916dbc2c-4eb7-459f-5f6e-08dc5f519a52
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 02:45:26.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s/W9yB1s7WOJaRd9ViX5EpbCGJAI2um5p6twNmTU34MjscQXisdkecEYY3ii7iyDPRJRtj/RpN0UdmLte9PFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

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
index 036bc1e3fc6c..d051fea0dbf5 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -469,6 +470,23 @@ static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
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
@@ -533,6 +551,11 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
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


