Return-Path: <linux-kernel+bounces-144784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F98A4AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B46D1F2561D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2063CF6A;
	Mon, 15 Apr 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iZLFVl7n"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301613BBED;
	Mon, 15 Apr 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170592; cv=fail; b=StBUbSE7zUJpYC8PgWtx6b4wVgz+Q7DhRxIPgVyOD7duQUSoswEWQztDp1xARh0CNty8/tKpWBngcV1IJ02XnwkwkmjPhMb/XquS9CO/jkoSB+C5AEbJzQCxlWQqmjNoTlzOaSTM8qVUS0pbjdqDhFIBBwDKgMAfr6qWPrIJc4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170592; c=relaxed/simple;
	bh=AvzxO31Yu586w3gH8nWJhGzdFPRo+HRDNDutGR9pavs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lLYUs8PQNET+UpPnpOBe7RYo7jE4+F4meHKi65yfyJ1pWkeJRRJZx9a2kuXBMc3WIeiEYpkUCh64fBTmO+/d5Pf5uxDJOKYjzCcuRVUVAY6wDHRMlfQur5tFYlk3dK7xTwOmsInsiG7k8x2vgFczyqv2MjLP31N370TgnU6HACs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iZLFVl7n; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDa+XzHAaZgpMqsBTwOFRImsJN2U90sKQaW4b91N5gSEvGOsVLHICvzY3dwaNDWsLVl91zyuf1KRhHEiY81hGDhbQTLZcLMCwYHZT8cYlIE05o7DfTEVPIbf6T9MlTQZxnnZgWAD1X0vsL3cJ6TetoagFVQ3MST1lsljKDmilYSRWza2BqbUQ9IamD2zs2smn/1we39ofSEX5KCBbigfYrP0OjCinCRf7N8SAeB2CEHIZsmeMv0DJF0a8eqPbgZeLAIaMukMoe5UTQhSq6wglgSKFz1nseBAtEk16HXWN3QaK7xrbQ2tSCc9KxteFqSYoSViQViM+j32EdB7pxvFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxmDk/2iSI+UsJu28/ANZ/il3ws1Kfhx5WW+Jf0xHt4=;
 b=Zz7xgtSNSc+FH88XZGepxJVn5Tqjsrre0QkIzbdglNc2Tdvbie50rW0z3DYd9e/PD2PEImiunrfhVM5rV7r/CJfnFvRPDk8p+uD3PuIPPyoGFpIvu9lD+ghP/likbWhYPTVWW53SvPPud6NpG4i87j5wSYijg5uC7Tno2LTr1dwCrRh6kY0g59N+3w4J7d+jjrw4/FvQZELvtsgdJdTiXnQ2N/hCFuThPbBqdXp3gFHz7BUwyYBiAD+QQx2xTbnA3be0SratJDvCZ/vuqrnB42D2kXXPJU1273psBJ7KnVSm6XhU1OmYgt+iPBpFew6dzqLGvGFJyEyacXJ8+9a4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxmDk/2iSI+UsJu28/ANZ/il3ws1Kfhx5WW+Jf0xHt4=;
 b=iZLFVl7npbn1Khe0XUBL9p04eGiTDuBz534VdBH8SUtuFmKS1z3dV42KgulSBJIKmy28sJpX/no0GEkru9pnpiPS8ZbzS7eA73o0Knpkx7uiwlKEjNDPI42+kpQEVvpMkll6K5MjhgfvuDm3pLEFjE2rE2HGR94uukWtuI08Nbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:43:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 08:43:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 15 Apr 2024 16:50:52 +0800
Subject: [PATCH v10 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pinctrl-scmi-v10-4-59c6e7a586ee@nxp.com>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
In-Reply-To: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713171062; l=18530;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IOtzx+YMGFm2KwYZUPsN0IKPwxoPPQzwf7S9Idob8PY=;
 b=TDKDJBMyJqWgKdpXkEyMIVG5reXKpC9Ze1YguHscePhoz72v/EEo/GYdZfyDYKZ7qXukS8pBx
 Kw2w24gH90wAsis3+rPU1mSocKFc81NwgxWcYm6DyHtC+9xtVuH9k8g
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 245d0cc5-ca46-446f-6d19-08dc5d2812d1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	keFvhVwOMrpECebxKeC2SDXybr2JZ2jPPnX5W8FSjiBtu53O+EHs+iagOTl/tVMpBRd7WsquNYH9Qcg4YppvRKHg8YLwMjJlDpACgs2fA6xRGp00jPIMtw6xBwXC2qClYCe67Cqfmxk5NtcBLkoVZRmSHkNTDCSC/UmgGdQtPWiq3jqo7JZbITcLfEiHCOV9GtECJrZqzAOnr378udEwFi4G3IiGK0hH/HrhnT8oVDrTrvFMfGRlAxEG97ubOBk+LD5J/7QzwscZSTaoBCb5BH/mOQ/KpDwsPjeAMMyq83uYViXxlc+H+qMcjVNptvQxBQCOIiw6SsPJmRINPZe1yeA3QSt0lJCYYtWOGIXSCqPIlhsUd9RKj7HDOUToaFTCZ/3aR8pIcuKxuW0wA2MkSE0ru0G8duzKljQubw+qrzMuMrf/8BbNCbx6lKyzyqQ9GxaJSf+UjXh+VijWH57FnoNIAwlRLseGUyWpHt4Qkg3OU774hPOcEbwR6bCSAfwkDdaXCJzsIvdOOv7rEjoRdy4I0ag0NQg3AWxw6ZL80DiRSeG+/zZGVOlKg3UmeNCnuDwDJW8OZQ+dew4vjI4IdWcoMKOC7TVUpxiiwAwaHmUFI4RpA7zkQj26MB3pELctOyn3yimFuY5+DIbJ1fzIlJwjpA6yiBpeQnZVC9djFpQ8TDKNJr0Z2i12RKs5jHGuL3DcRbRACvpvzCaBpOUVlQbUUeH9SIAIsI/IUBqtUBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a09oZHFWenl3blU0dEN0MVVpTE15eHJJdWtacC9QRHFycWpTbFNxNk5qc2pi?=
 =?utf-8?B?MGlWQm1VWDZWb2dYTkxjclZycE9ZVlBnVHJPRm1hUk9JWXZ1RGN4NmxvUWxq?=
 =?utf-8?B?Q2lvcjlhd2dGYkIrOTRnZElRa1dpeC9BcG4yWnZab1pmOE1ETy84OSs0WTVa?=
 =?utf-8?B?ZE9MMFprdVhFUGFCZGo3b01QWUtOMlk4YlpPang2RG4xL00rcEhVQW80cENW?=
 =?utf-8?B?QlJ3UmZBNFY2L1RqS2h6ak8wSlduREhaU3ZTVVBFZUtnQ2MxT082UmhmcW9H?=
 =?utf-8?B?SzRLcDJaclpScWxGOGxCcld5SnZBVEowTjdRcHJ5N0doMmw4b3hrZzg1L0N3?=
 =?utf-8?B?c1pOSkJFbGwrSFNZUmJraDNYQ0VJaHA4ZVg5RVh4WG9RR1YyNnlMejJpbkh5?=
 =?utf-8?B?OHJad2cyS1d0dld3b1Z0RkNnNDM2ZTJzUXFjMUpsSENFaHFvL2srbCs1dEFO?=
 =?utf-8?B?eklFWjVENnozOTc5aXRqeEhGRERtSFJhOGNXOWxxOHU0ekZGOUprbUlNbWs3?=
 =?utf-8?B?M1N0VW9JVHFPRTlZbys1eStldWMwQXhMNnF2dmg4OFlTWEtNS2s4SXJMclFM?=
 =?utf-8?B?ek8wTStQSXVsM0MrNS9NY29KTFVYbEIwZldsRi9PbkFLMGkzaktvWU5CMjla?=
 =?utf-8?B?clNiVDI1eE10enYzWlVUUzJLVXd1bGgyTUlTWVFCRUtQa2VrM3ZJTTByN2xo?=
 =?utf-8?B?eFZST09ENDFhODN6eEZreTJheUUyekNwNE5XeUFVVWRZQ3A0V3dHN0ROaVY0?=
 =?utf-8?B?ZmlDWUJ2V0pEZ2NZdEcxTTlqSXpxWXVVWW5INEZONWwwWkx2SWlETGR2MW8w?=
 =?utf-8?B?SjgyS1pna0lxTUZPQ2t2Zk1DY0NMY21FMjF1djBrMWllTDZaQmx4aEJHVzRD?=
 =?utf-8?B?bzlnK1Vod0MrQTRUb0Zjd2I5cy85bk9LSWgvakZIVXVHM2Rxd0RsQW10MkxU?=
 =?utf-8?B?K2FITGpsRUpYNmRvVnhmZkFkSXVRV3lIYllyaW9vWVB2RlJlaXUwSVZla2ZW?=
 =?utf-8?B?SDcralFzT0Vxd3VxOTJ3M0xmQmNIb1JaMW1PSDU0RGo1OTQ2dGI0SjRQckRE?=
 =?utf-8?B?OVJvWWFtR1hRTSt3YVAvYVNrZVVZOVk2ZmRLcjA1TDdpMHJ4V1BoV0xxYW03?=
 =?utf-8?B?OVJzSENTbmxIUzl1OSs3VzQwd01YbSs1SmQvSWw4MUpoS0VOU2dVZXE2N3Za?=
 =?utf-8?B?RWZKQmJQZ3pEdVdMZUpwZ3h2RUpyeGI0ZzZtYXEwaVB2RTI1V1g3V3VlODFW?=
 =?utf-8?B?YlN6UkYxNUVaYkhLdEszaDZhbThjb0s3Wjlhdk5oNXRWNnNYUWZPblhMY1pw?=
 =?utf-8?B?NHN2RFJWUDQzaUlSdk5jNHVLSjM5bHlFSndpS3dBOTlTbHgxMVRudkZWcmcw?=
 =?utf-8?B?WlNqUVV3eFFpcXlTbFhFZk9pejlONCtoWmhQUzd3UEpoTkd5a09XdGhYTnh5?=
 =?utf-8?B?VEhMZE03YWtuN0hKYm9ndmJKNUUwV205OTRaQVJGRTZuTFVIU3pJbCt1cGhY?=
 =?utf-8?B?ZGtQU1J5eTN6RTRWeUlucVJjRTgrZlo0cTZHU3ZndnJuY2toWXQzcGxuaGR0?=
 =?utf-8?B?SXRjbWNReFMyQSt0Y05zQnFneVVURXN5VnNGcVlERGRTTCtkUWZnODEvZ1F4?=
 =?utf-8?B?MGYyK0EyaXdTRU0zRnVsMnMyZGJGTk56M3ZacENDRmFjQUtYWXpDTVp0YTFG?=
 =?utf-8?B?clB1U01hSmNmT0cyRE41bC9HRXFLRVk1UnJ4TFEwQjQyVHlibHR2Y2VvOFJq?=
 =?utf-8?B?cnMyMUZ5OEVvbDd3VFFZRFpOZm00ZkpYeHZwcDEzNUlRV1dGZ0ZJL2VRRE9E?=
 =?utf-8?B?eFoxR3NGMEVFNGtLcy9XY3F0UzQyN0FMaW0reWw2Y29wMzVRODlZaExlMzdJ?=
 =?utf-8?B?cjBDdlExTFpYUll1emZjMGs3K1c2eUY4eERheEJpYlUzWmJDY1hHMFdwUWg1?=
 =?utf-8?B?YzFHNVhsL21rdW5GNjZ1MStXL21nS056cFFtdGo4amdOZU5lVTM2elA0bG5t?=
 =?utf-8?B?aFJwbjdncFBOZ21veXVYUVdjNFFIWEdUSUMxVmRyUDdEcEJMQ3ZKZlZCU1o3?=
 =?utf-8?B?bWMyclZud0UxbnNjWEhKdnpoK2VtUHBSa0pNWDl4dkFWdDk1cDVNS3RSeHJj?=
 =?utf-8?Q?anWoURbb00jRVuD8mit9rGdYA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245d0cc5-ca46-446f-6d19-08dc5d2812d1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:43:07.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1ntymxtmttbz/pYt6mTvGHs8IYzu4gzrVt5lAe3uL9p1yidmd0PJEshJVxTbJFC+RAwtKHNqgdnQNmxP6S/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506

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
 drivers/pinctrl/pinctrl-scmi.c | 572 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 585 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1b074ce2cf3..a37aaff190c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21615,6 +21615,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
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
index 000000000000..accebe3f0706
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,572 @@
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
+	if (ret) {
+		/* Convert SCMI error code to PINCTRL expected error code */
+		if (ret == -EOPNOTSUPP)
+			ret = -ENOTSUPP;
+		return ret;
+	}
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
+	if (ret) {
+		/* Convert SCMI error code to PINCTRL expected error code */
+		if (ret == -EOPNOTSUPP)
+			ret = -ENOTSUPP;
+		return ret;
+	}
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


