Return-Path: <linux-kernel+bounces-141743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C88A22DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DC71C21E52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5E4A21;
	Fri, 12 Apr 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VDJHk7dG"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B46259C;
	Fri, 12 Apr 2024 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880821; cv=fail; b=CFo79iyVfFvmDUw/mDj848ViDeQDNS5dK3Lm9RtrEFHuwDTURc+awFqkPyyV3CQwEBdJtSeo6BGrcakzTzKuvXFYGYfNPqierDZvzHgiSMk7OtME+rL3sDvIgm7lC+O9mVvDlZymQ6gRchJXI32sq86hDpBC5tzc7ZRlLhbKy5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880821; c=relaxed/simple;
	bh=7Z2tRgO6oRQ0/W9Dx1T02HNy3A7OLUJWRAQZ2S2tEB4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=afCTxXoiyzdlwqjpGLHYVmNdfnEK7x/sOqO0YKX4zjnb8kpUkUg3EzCwqA1q1TfmNcGmihe4hEreNELUPdhzWPXrJFwujXC9u0XL5q8zWMXpvGat3b5GvLmgOlbQnH0eMHBVxPyMsXP6Ely16aK32TUeya3/rzNG2lIZ86rDAeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VDJHk7dG; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afk1iKxT57EDUxt7Wt1CxTE8Fa46gb1EjSU8Z8uCu4ejTGOZ8+0eEgYoq9J0Lwj2AmzlymFZfTvyI1HfvcTO9iSBehKFt0iYnMJ8dA2lWXuSf4moV4WZwVsniloB1paqKNmDinVE9Fky3uxjPWxGI2J5E217+OVeD9BjcXiYFrPWZG/1eHAwk9AtkZM/jJRPGBneA2YDiYT2sHiqEfmUHmweveJVuv/Rnr/gsPWiXPtgDodCDeyQjGjSwx9j8LtxBUJxvMFERIjI2DoYmFzATlJJumLID3W8BaSgabm5eY5dxg6/EcOTspfBIek+Q8uM5/bkcCA0KNt8cRX1xJ7mIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrWyZTDNukgiNUCKnVSqOjv6er7VIX9OOGY0qRGlBcQ=;
 b=AGl9xgBq2lBWvSa4NJ1TXk4BWX78cmNNTlCGuoT57GjIeYQVQs5qPf0/LKJYtVDDjPd6fL92WwanurMKKDzxx9DRO7EL+oySsUv87qdUnQ7Ux0HblEUtPko+chwpHHrBpjjnwq+HuD+YfuRbIyxQT5hU8CaQhIOOFBBsDXVwV/SeTZm3aF45KjobfMQb6O7bDWGC2AvZ92mGfAHXx9BtCcQkR1yD8TaeKY+1AnATUgtqGbawE1lAkBAlJux/odu/WxAjx2FeI/fJEDZiaKHg1PqzrbPi5HHujVuGRiUpm1DCy/sUWSVqRNhReFrBOaKRaY1LXwRCwxEliG7odEUNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrWyZTDNukgiNUCKnVSqOjv6er7VIX9OOGY0qRGlBcQ=;
 b=VDJHk7dG9KsetRMYVYC58f+/QJ4Zbo7ZQkUJU6I6hMz+8w12r+51hdYoMYo+hjDb8hJ1MkMNglvtvMbgOm37lvD42WvI/qmNs19omJbjX51aJ+32yxIfpqSvp6ueq4u/UbK/X+65UoecCFH3u6XE3n2wTt8qMC0BzVXLbi4gpcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 00:13:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 12 Apr 2024
 00:13:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 08:21:22 +0800
Subject: [PATCH v9 4/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-pinctrl-scmi-v9-4-b817344d3a9a@nxp.com>
References: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
In-Reply-To: <20240412-pinctrl-scmi-v9-0-b817344d3a9a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712881290; l=18286;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5LE/T4pxx22bA6Cfq3V+7W+OxEZdT/+5oGR7VGvEF0Y=;
 b=xflUItwUf3wD4CpOGAJQwizb0ZMr+I4q4FY0Om25kCn30JL7cazhu+ZodoDoFWg/fMVF+h6vl
 lq9OZb5Pg1UAyIm7zRAw1OyhHf4sLVKx8Jmxv/XOoR6iJJHwMsF2bdG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a30de4dd-2660-4af0-d4c4-08dc5a8564d1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XKGdxhRcxzu+ImpCqN7XxFslyAjAr29LDmhsNx/tvpi8lbLU0vLqEVA06qJMcUrqwOzjjTTic584GcyRtrpYZQRMrxntAJI/JX+ASxu4Fatu8tDmJNZUycU89h2vwv3QXj6j2RRPeMcMt47ABI3F81IkQK+W9sM7xHUtz+fO7RgxuAuk/A9hAvbbbTotjpbfCZqaBxG+xn5j/lFX1NE78cfUhhZ+467VY679dkdW9lfC/sQnN7w88WwuZadrQQQ3zUQ61Wbr5c+rQFbGGHkD1p9DfzxO5O/xgpKyTOyIbvUNINTL2PkrdyxRCuR3Mg/Bc/+rv7jA7Wc0t+3QYSjXL8wnRtVu8n9B6oCri7bbNCJO+kINdtU1Az/i7KnrsF+neEYeaj82++cqYA5BpDnAqSSP7HIs/xY9hn8YgrYN2xsVv0AQcvKRYzBHSIQFr0WcypHfR9ynK/XAH680wgZgLOZ9Fm6JC3TmDEnAphuHIpv41/jefzGPClSuogYdrXpmxTza56nwvbAt3mPRrDFBTfjOEXZkhhQPeV4DLp74TuvTdPvJzVND/BCtKdHam9rgBXtRLYePtxw0Y3N6CWbx1NeMGh0T/1B0OZDsDeIM1plZcNVEexrvsReHpJnHi+XEZ6uiJtNPuGBG6hoyRDJSBdtf/oLgmIyhjZ5z3hLeI+WxCHE8znZMEr1XU+2f2y0H12mQG/ivlAfqgxD3+CFZuyISfBs3vP3OIPkhLiOJj10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFNT011cWRNRzcwRWgzWG1QUmo3RXhBbEVoclY1a1o4L0NzR21oK3gvRmlP?=
 =?utf-8?B?cHBpeUVNQWY5N09McGVZaHgxQ3BNMVlhWXRoVSs4UlJ5ZjM1a1dMNXFzenpC?=
 =?utf-8?B?K1E0QmgvbnF1ZkR3cHBZazV4OC9HajhwSUJLK3F2R092aTJNSnI2WlZQdW9M?=
 =?utf-8?B?dmUyNm1HL2JVQ2toNEdZVU1oU25tSXN1ZTNJWkNsWkRmakE0V3NkT0pZckdQ?=
 =?utf-8?B?M0U4SEdjVEI2Yzg3QnZ2NDlVTktTelFDdkhDc0pwM1E5ZytTVHhWUlJQaFdw?=
 =?utf-8?B?SEg4c04vbWYrUlhqL2JSLy9mQjB5OVFxeWhaMGJsVHVKU0d4VmhLYmlNUFkx?=
 =?utf-8?B?dkRTZGptOVpIOVE2VkdtaExrY1B2T3VMNmdDaU9Fc3lYajMxM1VTUTU0SkdL?=
 =?utf-8?B?Sm5PNHJvd3c1ZDNrZHhVcXFLcXIzZks2YS9Iam41dXAvNVVkVGdFbmZTQWhG?=
 =?utf-8?B?VDdDMHF5S1EzMDNqdU5VbTc5TW1YcHY3R3RmWUNNQ1BwcWR3aTBVZWtkc2FM?=
 =?utf-8?B?UlM5SWdvNWFpWFBxdGtpWUg2ZFBGdWc0ZnVmNFQzV1JKb1dPcUYvUVVuSEUz?=
 =?utf-8?B?ckNVcXZDdmpNZlk3T012bklKRlIvM2ppOGxxOTVIMHE1RFVQZlRjeHNIT0JZ?=
 =?utf-8?B?VUU5aWtmQzRGKzd2Tldub3czRTNUVkRmQ05hV3VuakNINi9DcCttMmpiWWRq?=
 =?utf-8?B?cS84RTdUTEFPcTZNcHVyRlZEaU85VDRQTXdxVEFGODlhWHo3TDFUSXZValhP?=
 =?utf-8?B?NXBEOTJpdHlqbnVNYWM5Y3Avc1VCWmxxYzZTQm5jZ0pCUnZCL3BXWVR1KzB1?=
 =?utf-8?B?SWRreWZoQUFFV1RUTkdOd3Y4MXNIaUxDUmlTQm92a0JobnJhaDUzaEFRSE0x?=
 =?utf-8?B?VWlKOUMvaW9WMnI2ZGRpSGtCV3piMDJKdzBWaVZGV3JEVFpFRjUxRThHdVVG?=
 =?utf-8?B?d2FEUzBCektQMklMZlZReS96UUxJLyt3djdsMGh5V2FHSFZ2Z3Zkdkd5MSs0?=
 =?utf-8?B?SE9Scm9GUWVZVEE1dXVhQVV0Y1ZoVmZla1luL205QVJWYWZxcnlndlFOc3hB?=
 =?utf-8?B?Q2p5dXFNSnVXZDk2L2I3ZEpUNFlpZS9hMnJvVWZNOGRMUDI4bXh4enpKeVNN?=
 =?utf-8?B?b3VyM3B1Y0dlV0plbE1IUE4xVEtMQ0h0UE9WanBvbUQ0N3BHazJtTm4yQXVp?=
 =?utf-8?B?RFBqTVk0dno0MHpNWkM2bFkzbmxtUmRCR2l0MWh0eXVMeVBQWVNFZ3YxeFdD?=
 =?utf-8?B?NTI2dW5jT1pyTXZvZUs3SlNFTHkzRHhEeWR1M2tRc3o2aWk0emI0bm5TWHp0?=
 =?utf-8?B?dS9vcUhTenpEbFprRm0vdDUwWm02WkFZc09IWXRySkJDeEY3UlFTUzhzZlFz?=
 =?utf-8?B?bVo2bU5mamJQMEpranoycFJWN0Rud2JMcGNveElVVTExVGtPd3N3ZWI5WEJ4?=
 =?utf-8?B?emE0cmphclBpR1UyTmF4S1B4ZFpGMk02YUx5L0RjYjBtRGlKd0Jnc3BtR3Za?=
 =?utf-8?B?cDNidzV6cmpUTk1GQXlaZTFGNmgzeHQ0VkQ0Z2lZZmFVWXFUa2VNUFdQbnhv?=
 =?utf-8?B?WWdZSXphQlpzTEUxMWhseDV3UFdpMm9aVDlPcnNESE5LSW9hdmpYdnVMQ2Q3?=
 =?utf-8?B?aWtTM2NlSmZIMDNpRENGOHZNWnNtZmlnakRNWEZTQzhJM2JUUmluY1doYmJN?=
 =?utf-8?B?b043S0lqMk5RY1Zia2RuK2UwUG9RVnF2KzMrbHNXeXFhL1FUYmZPWlB3UGhk?=
 =?utf-8?B?VWRxZzZSUFViSEFhVG41eVZ0SEdzcDhjNTZTaE8vNGwzTlBSNElWRHhRWjJx?=
 =?utf-8?B?c2dURXp1SWREa0dTbS9VSVVxeW55cGRSS2IzcENaMGliS0RZR3pueXN6cU9t?=
 =?utf-8?B?S3hWK2lJNjI0MHBTakhWdC9ldUpHa0kxeXYxNWIweTBQOWxoYUlPUU8wWFRH?=
 =?utf-8?B?TFJ6WHVPR2IwZWs3OVpYU01nSzA3WStZT2xXdFhuUWFBSDdtc3RPbmhtTjRF?=
 =?utf-8?B?UlJnYXFiNmlpdWpsMTIyYnoweW1aNUtpMDhxQWk2MEZnNXhQbkEwRFdSSXVI?=
 =?utf-8?B?MWV6MkgrN202eDJoSHpLUGhMcUFjOG5rQm96a2ViV1l1QXdmdDJmL1N1Q0d3?=
 =?utf-8?Q?02dpDaiDQjaoIKcuoyysVg4yF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30de4dd-2660-4af0-d4c4-08dc5a8564d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 00:13:34.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQ01YYxaOLCwSBgIsC7QAm8qbE7kUvB+ra2i5EjaGg9Kwx57Of7QnA9jRRXY0SzVbX54hc68NSfw0xXxNBMnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 564 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 577 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfb8f4918961..ae7795413d2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21609,6 +21609,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
 F:	drivers/hwmon/scmi-hwmon.c
+F:	drivers/pinctrl/pinctrl-scmi.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 1be05efccc29..7e4f93a3bc7a 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -450,6 +450,17 @@ config PINCTRL_ROCKCHIP
 	help
           This support pinctrl and GPIO driver for Rockchip SoCs.
 
+config PINCTRL_SCMI
+	tristate "Pinctrl driver using SCMI protocol interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
 	depends on OF
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 2152539b53d5..cc809669405a 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..0f55f000a679
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+#define DRV_NAME "scmi-pinctrl"
+
+/* Define num configs, if not large than 4 use stack, else use kcalloc */
+#define SCMI_NUM_CONFIGS	4
+
+static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct pinfunction *functions;
+	unsigned int nr_functions;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+};
+
+static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
+					       unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
+}
+
+static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
+					    unsigned int selector,
+					    const char * const **p_groups,
+					    unsigned int * const p_num_groups)
+{
+	struct pinfunction *func;
+	const unsigned int *group_ids;
+	unsigned int num_groups;
+	const char **groups;
+	int ret, i;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!p_groups || !p_num_groups)
+		return -EINVAL;
+
+	if (selector >= pmx->nr_functions)
+		return -EINVAL;
+
+	func = &pmx->functions[selector];
+	if (func->ngroups)
+		goto done;
+
+	ret = pinctrl_ops->function_groups_get(pmx->ph, selector, &num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+	if (!num_groups)
+		return -EINVAL;
+
+	groups = kcalloc(num_groups, sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	for (i = 0; i < num_groups; i++) {
+		groups[i] = pinctrl_scmi_get_group_name(pctldev, group_ids[i]);
+		if (!groups[i]) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	func->ngroups = num_groups;
+	func->groups = groups;
+done:
+	*p_groups = func->groups;
+	*p_num_groups = func->ngroups;
+
+	return 0;
+
+err_free:
+	kfree(groups);
+
+	return ret;
+}
+
+static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
+				     unsigned int selector, unsigned int group)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->mux_set(pmx->ph, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
+				unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_request(pmx->ph, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
+{
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl_ops->pin_free(pmx->ph, offset);
+}
+
+static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
+	.request = pinctrl_scmi_request,
+	.free = pinctrl_scmi_free,
+	.get_functions_count = pinctrl_scmi_get_functions_count,
+	.get_function_name = pinctrl_scmi_get_function_name,
+	.get_function_groups = pinctrl_scmi_get_function_groups,
+	.set_mux = pinctrl_scmi_func_set_mux,
+};
+
+static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
+					 enum scmi_pinctrl_conf_type *type)
+{
+	u32 arg = param;
+
+	switch (arg) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		*type = SCMI_PIN_BIAS_BUS_HOLD;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		*type = SCMI_PIN_BIAS_DISABLE;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		*type = SCMI_PIN_BIAS_HIGH_IMPEDANCE;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		*type = SCMI_PIN_BIAS_PULL_DOWN;
+		break;
+	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		*type = SCMI_PIN_BIAS_PULL_DEFAULT;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		*type = SCMI_PIN_BIAS_PULL_UP;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		*type = SCMI_PIN_DRIVE_OPEN_DRAIN;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		*type = SCMI_PIN_DRIVE_OPEN_SOURCE;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		*type = SCMI_PIN_DRIVE_PUSH_PULL;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH_UA:
+		*type = SCMI_PIN_DRIVE_STRENGTH;
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		*type = SCMI_PIN_INPUT_DEBOUNCE;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT:
+		*type = SCMI_PIN_INPUT_SCHMITT;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		*type = SCMI_PIN_INPUT_MODE;
+		break;
+	case PIN_CONFIG_MODE_LOW_POWER:
+		*type = SCMI_PIN_LOW_POWER_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		*type = SCMI_PIN_OUTPUT_MODE;
+		break;
+	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
+		*type = SCMI_PIN_OUTPUT_VALUE;
+		break;
+	case PIN_CONFIG_POWER_SOURCE:
+		*type = SCMI_PIN_POWER_SOURCE;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		*type = SCMI_PIN_SLEW_RATE;
+		break;
+	case SCMI_PIN_OEM_START ... SCMI_PIN_OEM_END:
+		*type = arg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
+				    unsigned int pin, unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	enum scmi_pinctrl_conf_type type;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_ops->settings_get_one(pmx->ph, pin, PIN_TYPE, type,
+					    &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static int
+pinctrl_scmi_alloc_configs(struct pinctrl_dev *pctldev, u32 num_configs,
+			   u32 **p_config_value,
+			   enum scmi_pinctrl_conf_type **p_config_type)
+{
+	if (num_configs <= SCMI_NUM_CONFIGS)
+		return 0;
+
+	*p_config_value = kcalloc(num_configs, sizeof(**p_config_value), GFP_KERNEL);
+	if (!*p_config_value)
+		return -ENOMEM;
+
+	*p_config_type = kcalloc(num_configs, sizeof(**p_config_type), GFP_KERNEL);
+	if (!*p_config_type) {
+		kfree(*p_config_value);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void
+pinctrl_scmi_free_configs(struct pinctrl_dev *pctldev, u32 num_configs,
+			  u32 **p_config_value,
+			  enum scmi_pinctrl_conf_type **p_config_type)
+{
+	if (num_configs <= SCMI_NUM_CONFIGS)
+		return;
+
+	kfree(*p_config_value);
+	kfree(*p_config_type);
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	enum pin_config_param param;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
+					 &p_config_value);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		ret = pinctrl_scmi_map_pinconf_type(param, &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->settings_conf(pmx->ph, pin, PIN_TYPE, num_configs,
+					 p_config_type,  p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d\n", ret);
+
+free_config:
+	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
+				  &p_config_value);
+	return ret;
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *configs,
+					  unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
+	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
+	u32 config_value[SCMI_NUM_CONFIGS];
+	enum scmi_pinctrl_conf_type *p_config_type = config_type;
+	u32 *p_config_value = config_value;
+	enum pin_config_param param;
+
+	if (!configs || !num_configs)
+		return -EINVAL;
+
+	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
+					 &p_config_value);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		ret = pinctrl_scmi_map_pinconf_type(param, &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->settings_conf(pmx->ph, group, GROUP_TYPE,
+					 num_configs, p_config_type,
+					 p_config_value);
+	if (ret)
+		dev_err(pmx->dev, "Error parsing config %d", ret);
+
+free_config:
+	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
+				  &p_config_value);
+	return ret;
+};
+
+static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_type;
+	enum scmi_pinctrl_conf_type type;
+	u32 config_value;
+
+	if (!config)
+		return -EINVAL;
+
+	config_type = pinconf_to_config_param(*config);
+	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->settings_get_one(pmx->ph, group, GROUP_TYPE, type,
+					    &config_value);
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = pinctrl_scmi_pinconf_get,
+	.pin_config_set = pinctrl_scmi_pinconf_set,
+	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
+	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 struct pinctrl_desc *desc)
+{
+	struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	int ret, i;
+
+	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+	/*
+	 * npins will never be zero, the scmi pinctrl driver has bailed out
+	 * if npins is zero.
+	 */
+	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	for (i = 0; i < npins; i++) {
+		pins[i].number = i;
+		/*
+		 * The memory for name is handled by the scmi firmware driver,
+		 * no need free here
+		 */
+		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
+		if (ret)
+			return dev_err_probe(pmx->dev, ret,
+					     "Can't get name for pin %d", i);
+	}
+
+	desc->npins = npins;
+	desc->pins = pins;
+	dev_dbg(pmx->dev, "got pins %u", npins);
+
+	return 0;
+}
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev->handle)
+		return -EINVAL;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->ph = ph;
+
+	pmx->dev = dev;
+	pmx->pctl_desc.name = DRV_NAME;
+	pmx->pctl_desc.owner = THIS_MODULE;
+	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
+	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
+	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
+
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
+				      sizeof(*pmx->functions), GFP_KERNEL);
+	if (!pmx->functions)
+		return -ENOMEM;
+
+	return pinctrl_enable(pmx->pctldev);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_pinctrl_driver = {
+	.name = DRV_NAME,
+	.probe = scmi_pinctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_driver);
+
+MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


