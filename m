Return-Path: <linux-kernel+bounces-132319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245FE8992F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE381F21EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887A1C687;
	Fri,  5 Apr 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IkKhv8iN"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2131.outbound.protection.outlook.com [40.107.247.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B379E574;
	Fri,  5 Apr 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281911; cv=fail; b=Ifq1hRI9WfeRfb6ygE8hGrHwyqj1A16BvAJl+yxJtHzfAq8rqfSrGvMTkpOVpsHlYR6CCNi6Vuep7WxtiUCUwhemdyOHUZcFCAFH2HV+1XZ/HZnM0R+gVkoZ70HZ1ej6y7+GRhmpk5aofvha2WTDGQ4jLI0+xmipIaKVgTXwEU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281911; c=relaxed/simple;
	bh=1ttx/K+ylZQ/pr5TJ+cDOsVLuXyiYxZzI5tgqGW/sCA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hF6kNbEmwYS8/ewEHLHd84i4mYb5OTS7KG8YMevDiQrC5HEpiLXCqOn9Hy3ex5AykCB/eHwb5MZQUAYHKt5czdqUpRaXvVAXySd9Aua6NcJsDoiSJh2EsrSgsQo7kUJPrbspwMVdhM0x1dBeYOeXELCBeEsDekmNf2qBt32pvgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IkKhv8iN; arc=fail smtp.client-ip=40.107.247.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCBF/5QJY7FpawfVVAfJNFjHw+fE0u1R6BxsQ+eXWXRnBL2MFoA4bcTDT+dss2HQEwB5awhvhEFhaqsOrFFmI7IHEErvtcPb4uX/Snv1EBeKMWmxSf3wr9HfCtKAGVJXmj14qneVJxjBQN+WK90xrVxQhq9m9NpsLzx46ERIProjwvgzQ0cPEQyL/YJC85uHuZgCyVtXhvQ0X/wJ0AjvgI3rHmWBVP5Rwav8oXX1mO3j1SFTyxB0lfitSnpWpODjVFx9kaNOVSozb30AqSi335bgQCs3/hLgmPXnuPQB64PDaJOFccShAX9PsSiBCjMQ+08wJ7kEQswYLfIZBsYmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZpY0FB4CcuIWdsXFpbNhSUGvrVt0Nr/jyeCFpYOnlU=;
 b=eWTcZDeQHUweCZDq39zaQUpD+FJlO5o+hkgDx5Fu2g+n/yop0Wyvgb8vkhRy/Ve18zf51jZlq7w3wHDMVkmNCJWPmC01iwAij8BFzSxTH4P0hjZI4Vb8xYH27UXfcMPPik9z3HWNggljTbf/vRE4Q5iUx9fZzTaQekPIzX4kb9zSso32fEG2O1SdRiy80mSchEBho7tEPbqHjKlVU2UqyhLI2HtzPL2A6QLfS4gOUNWUKpzu0krWjtCCfouzDgp2hAIwJq/TbgmpIlOfqkt4Iay1RFWbB2+EY0D9Aj35CltvZlKQzpS/QJg6DIKmHbnWePPKXiBw6sjycBmR5s8Vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZpY0FB4CcuIWdsXFpbNhSUGvrVt0Nr/jyeCFpYOnlU=;
 b=IkKhv8iNwoI7+0Z0B61oZZjYYL1/S9Df6IWgIaJZLhio45vgFYsEaYnXVc51KQ/QWxdAi5WnceYGVPO5j5xWQ1b4Z/qTo4kvhzM8hFuAj3it6f4BlQ+WkbmveOrvwJAljxSPshipJstvjEjmPymE/XEMoOvSrDuqiGmorxTMttY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 01:51:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 01:51:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 09:59:35 +0800
Subject: [PATCH v8 4/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-pinctrl-scmi-v8-4-5fc8e33871bf@nxp.com>
References: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
In-Reply-To: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712282385; l=18244;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=AbjpOrl7yBEnYMIcYlspNvfej90dVHj0Zx/z0qnvcvQ=;
 b=ppGhd76dTZEbiyARreRonhXafGAg20CJ4XP2TdkrqCVpeuwmYv61D36/rCLAhxy3FBvOFNBA3
 vnmrWFGfFmpCRqkJI+GOjQYTbIRMxUqwOCZxX0mvw8EJf7SM7hNW1A7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9334:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oCkjkrW78NNUQeHAbYkoEh36bmn/Gc6Lc2Bm9sc23UEvlkBJ9J3AOR5Iw+c+0lyRweNAu05g+ihAjO9IoxeCL1MAWwrAtaryY8O3KdYqADe9wMz8DIZ4vd+ZRFjol+ICCcebRv0dqQIMJc8KQ+NjRgr/fT8gYK1o9vpaI44ne5Cv+r713RiVrH5Gn+7uIOF0j0lyYxHbAED3uEhmOkVN7/R8AAgvxWwFnVn6lDQ6WGII2lBom+KvPSy7wd/YARDJcIAiDYQhEDO1rlt4j2NCN1eM7cgNej+Ti3ckdKqlVF4VFUI0sqwVk2C0yeGXarcK9Ml4scO4Nl4ud2Lx1SmTKscaQz/xvxu14OHRq5Qmd8tstRp9bBPBEsF+17aWMGGtUxsekGnB9JzhfV7Y3mmHPwVRQw764BFzPqdRfD4+1iahaNpp4+X8weJTxaVnjl2Ewee6KvOpescdgPv16vFxVV3HfNyOR2FyiswzoBMk/m99uLOoZt7GN4s9daWmTvG1jG5FJ775cJVjs6I9orkwDyPeJfj/fV7DvJI2vdyyFgxVB4Ck16ikXg1et51AkHXpFihqkUdgfBeckTtcb+yXnreoV7TpwkbFZHjEiEM2foZhm/CXw6VNHsn4TiVpyWfzaTYROWk3E3WIttXqcsd/5XdGYGiZj8MI1kmLR5dk0EN0HIMod9wvvCH8oTbyUOvGp9nj4KMnS0J5M1J/R4taw1ceraoo2jzVb/F4LUH3AOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1B2Q1hqRFhlSUVBOExPb1MvZHlDQ1FQZ0w3SDYwK29YcnVwNEl3M3VuaGtt?=
 =?utf-8?B?VjlVWjNCOSt0ODVtL010WkxrMmVjMGxuZ01VZFo2WlViZ2xrZ1hseGxoYTlE?=
 =?utf-8?B?LzdITWJiRVFKbitETnpxSjhhblkvRTd5STloWWsyaDhQcExEeUJGN2FSOU5N?=
 =?utf-8?B?QmlSaDVMK3FTNGZ5QXVuTlM3ZkNHMjVBVmY0bTBHVGNDU3BBTHVhWFM0ZVNi?=
 =?utf-8?B?VldmMkI1QTJKMVUwS0pXZzFJY3p2ZFphaGl3SDVXVklsYXFtVHdmVG1QZXgx?=
 =?utf-8?B?ZDRSaWN1VG50bVMxTFc4MGhIN2Zta0RaRlJHdkhCb2d6R09vSkFlTjQ4QVU0?=
 =?utf-8?B?SVF4S09CUTR5SUNaejdKbFl2cVIwYUhONHpkM0dndElkZGRXZzNBUWRPbDBC?=
 =?utf-8?B?R05SSk1nNFJZU2RjNHNEMlV6d292ejRQWVc0ckJ3WDJBbDgreVJMSU5vRDBy?=
 =?utf-8?B?RHNqRHRpdzZQbldSS2dpdGxmTHAwRGZFRDBiaEVNZEFORDRiRXNkOGdXMEFS?=
 =?utf-8?B?eXNKNlF2TmZJWTQ0MnJzNDV1bVBPNmFuTlgrZHFVT3kyN1ZEUWx1MVNlRmhU?=
 =?utf-8?B?YVBFOWI3VG1ubk1UdWk4L21GcktyZW5MTVJGdm41S2U1Y0NWWWJnVjBEdXhM?=
 =?utf-8?B?WWlkanBWTEJ3OS9mcXdHYnVxUk1mcDl2VkVQZ0ZKZURCTnhRVFdzWG9SZU5w?=
 =?utf-8?B?TS9pekxHd1JVbmg5U2JlUUtkMU5xb0ViZXAvM0tNR1pEdk5RQktqeE54bWV0?=
 =?utf-8?B?SEJkbmNRVmwwZDJvbGZaOTN0UGxXTXhZMncxalpySVBRUjNadWszOXpIS2dT?=
 =?utf-8?B?c3E3Tk9raWdRMXptenhFU01OL1RxaEZWdUlaZUdHeDFLZmF2S05rRWFRYlQ3?=
 =?utf-8?B?L3M4WWJybFhCWEo0Vytjc0ZnUkNPQVdkNmN6dW8xekc3ZW5rMzJhYWE2SmFm?=
 =?utf-8?B?NWZjNTNtMVYvZ01raE1kbDlNVlVaQTR0R3htSmhFM2lWR3FNbUJONm5Ha0ZQ?=
 =?utf-8?B?RUppc2VmakQrcC8rdzdtV01neG8yNFNqT0VLa1VRNlVWNmxLVms4NGdRSndx?=
 =?utf-8?B?R3FwYkxsYi9hbFBuSy9rVld1T1l6SDNkZkV4WDNuOHhxMUhPNGRmYTJOZlNs?=
 =?utf-8?B?T1l5UjVXOEJRMTRPaHhLZWZaRmlvSjlpK1NUZkNaU1FmaFpOSUYxSFRSS2gy?=
 =?utf-8?B?TlpYQk9PV2ZPRmxXU2RlU3cyblAzTG44U2ZKR1RWUU1FSVJMV0g1cHo5cGdR?=
 =?utf-8?B?Z2gvNUphKys4ZlVDQXYzNzVKa09OTEhuOTEzZVE2d1VJZFdNa0JaT0lTQUVw?=
 =?utf-8?B?cXFNSytzN3dGR25CWndEYjV6Y3hkdFQxeEF5ZW5xNEZPdnZUVUVzM25peURY?=
 =?utf-8?B?enJkVjNqQzF3QkR5WWd1TnRieEdiM3FxcGJLMGh4YTBWcHNidkczMzU4S2NF?=
 =?utf-8?B?bHorOEdtYmxCUjE5akMrSjBaMjF6dE45cEJqVHIxeVd3aWROTXFJd01TQXds?=
 =?utf-8?B?QW9LemFIZHdVTjlvd2NiTnBJeFgwdHRlZlVNRkZlNENKZm9VUndrcVNuNkhE?=
 =?utf-8?B?S2ExTEl0RGdMNi9KR3oycmZFZ21wWnB3WkRMbnF2WHc4MDR1L0NObWdIVi9C?=
 =?utf-8?B?dmtrelN1NHpHYlFjR2lsSnEySTNEK2VHRmp4TGU0K0F5VVhtZU9IRXluZWUx?=
 =?utf-8?B?U1FIM0VjbzJYbUlOelZoNHlZUmROK1oxeXVpNVM3d1ZQZERJZFVzdUZKR3Fm?=
 =?utf-8?B?OTk4V09rSmdFa1NNbWhpeE9RYjgyNWlqanJtc0t6Z212OWg4ZWRSOUZiTVVs?=
 =?utf-8?B?c21DRmsvdXF0N2dPRGRLdUhWZUx6QUg4OXZobmJGczhNeE53RkZ2QllUMDJX?=
 =?utf-8?B?LzhtOVdCUFVzbThHTzN4K2NpeVZQRW50ZzhxWlBVMm16aEZiRFRpREZURWx1?=
 =?utf-8?B?UVRhS0hOblZocTNTYitkREU3aXppNGp6MTJGOEJjTDQ5WkNKYWJ3VjVCQ1px?=
 =?utf-8?B?OW1qNkJiNjNRWVI0NFFLTnl0TmFrUEVraGpMY2k1TW9VT1J0KzdJUDBiVkhV?=
 =?utf-8?B?b2JWUFJIZmZyS3V1ZlZ4Z2o3d0ZwTTdMUWtoMnBWbytBZUlXYlBUY0JkdVNo?=
 =?utf-8?Q?ftfj1Tlz4PONcDAGzMr2i3DoM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bef76d-0b8b-4708-b218-08dc5512f3b6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 01:51:46.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0MSOLuC7n7qalFSpMtYjkt1NeVI/0u+kUfyBbO9WduhCA2e6Luk4sZszMldsGlRcTqzup/v+HYkHMaOyn+41g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 564 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 577 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b511a55101c..d8270ac6651a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21457,6 +21457,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
 F:	drivers/hwmon/scmi-hwmon.c
+F:	drivers/pinctrl/pinctrl-scmi.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d45657aa986a..4e6f65cf0e76 100644
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


