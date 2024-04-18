Return-Path: <linux-kernel+bounces-149398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57EF8A909D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C732283033
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BC5339A;
	Thu, 18 Apr 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vz9E2+yH"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552A4F8A3;
	Thu, 18 Apr 2024 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403496; cv=fail; b=p2CrjWscKAfxA5VHWXfJEOtz3uGAGqAoHprBf16eqJM4/MET1xet6dpbpWwYdGHuKfY3oZ8p2sFYayCotISEDjr1q17czIbWvMEIrwjyQCoXzxo0Qufl8YJGGntRU6IE5RzGlx1yYDszB56kGateOAWa8ihVbLh4gncCBK7Gs6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403496; c=relaxed/simple;
	bh=7p7R760b36eQQgH4IIwL9zI1uBEyJ1P1JaWJObXpa5U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PFf1WyYNrFgnUjqbdz0rl3bJnKE24plnINkXGUFRh6ufmRQF5wPweZl4RMj0VfHbXYBY4NBuJL58TNI7PvT+ojmWuiJ/LNa6p+O/+mr6e3l4etQ5la7qyu69W9lgtOMYt/Q2/5A2bpquCclPZM2w46r6m0EK5r1RC1LLJAOAfR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Vz9E2+yH; arc=fail smtp.client-ip=40.107.247.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwBQ8xdcIqtgLfVipuFUISbOFRNue5MydRnp28ak92h4py0oFoYa2ztc7U/mTKgxS5LpfF5SkMYQ3kPt4Vsbp1huG+5YHY0HT6Bm/X+LRHRoPiH6/StU6nYXDCjIEDAHvOVoKcD0aJG44R9TiEI4C1bnZy7yVLW2XLEEbxFS/F4J0JGV7dqZFRAEqLoMo725eOBCe2dvo/PfH+SHRRJIKPOc6qnRt6V1Wfj++d8Ph2B1lmZA0ObmwiQLnQxoxOr7awCwhXJsHZSjynj8apWYhisewyIftsXbNCsqZVwJbJTAAxYwF7Qf49L6iffLTuKjNw63aJsWAmbGTWhgxUkcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdTqCJnUPXMf0EXaB/2Sjjabw4CHiCSwDMNNHya1rMM=;
 b=Bm6b9lwBUe2bfe3ynm8kbn5fhI1Q+G2T40OkwDBHh0I/ViTtVI68Rhj4FjrmGbxBMvU7HDwracYVO59OXydphX2ejirQL4RTQzuIWp4/j2zmb+PesHdM2jufoGhqINNqAQ/xK4zA2nFxO1RBZUg4xlAJPJ27Hrgwd4H+iLdBQ8ltyWO3IggLnxqzY0kGGdB3syY3ocMbImNPbJDRJFJJuQkHQge8hc/XyirE68h4bdpTzqYbcKyMukz+hvqyenxhk5JU7pBDXsh2gYIyPRgLLJTZMuqWXSF5K4hoVzwM8bj0vCk4nKgRVEa9phoYB5klqhY9kVV7AZbBcJ5Nlyt0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdTqCJnUPXMf0EXaB/2Sjjabw4CHiCSwDMNNHya1rMM=;
 b=Vz9E2+yHPcST3Mt66JkU59ahCrpq6FAHut7x+DVP6adGgE3vdC8wwIoisv2YpRvASY4Bf/TWSKIeM5at6yxEmIVFfMZM26EZK4mEpLkOc+eiKreBHSgdZfu7Qvil+pI1RV35UdFzWdN6nc44n0IUPuHrkBzmpnoBXpzjEEuGqRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 01:24:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 01:24:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 18 Apr 2024 09:32:31 +0800
Subject: [PATCH v11 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pinctrl-scmi-v11-4-499dca9864a7@nxp.com>
References: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
In-Reply-To: <20240418-pinctrl-scmi-v11-0-499dca9864a7@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713403963; l=18594;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=frIY1kOz5TJs/gHZBgAO0T8Kpa1lYIWOgEfr1Im7os4=;
 b=Z8jFpGvLlmPyD6/nOljzUOW9IO3U3UWKuF/auwzSVqvwmTLHH08OzIoCt2X7qeLXY9GAOSvqp
 mK4RcXvnUoaCk9NdLVEH9EjMgvSBmqIE+c3c0DNY4AnQvNe/mvi6Tpu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c97aac-3bd3-484e-4035-08dc5f46575d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azjz329YfckjZShlmN85hvzziDW6PmMaUV2EDgdRKoh2jddFdBuWQ/LlAkXWvtdGUeSZ63LD1RMLDRvp9ZPqSllUpESFn7HEbnyRvCakxp6CXlG9T3HQc+HxGfG8mPvSO2j5qfFNuzca1WpMrKlmTpRWzfA9dkzKtCM9alofu5IacPcWMd+cpY6GCl7JIdDTLwvIJtUgTt3jqKFt1odl9XMoZRw22FXmHW0CO9fpgQCNetUCrOR8T0Mg9ZicisgTei4W8igUYnDa/WgrdgU0csrJZQWjpbmVI75OzVJM0z3Ejk+qQFLFCz6olHxjiv7SZvAgv61OfTHvAcqDgdbhCS84NK+NojSan/BmQW9ZVTIYBnXYoDWAjQds5HaBUUf3tY5i5HgXQ9CiyxZ7cyw3UeKKsWChByX3OunatMxLA3muFiFQv1yqjjFEsUkrxtDFCNVuzBGKCoVrSxzPW52mEX0Thx3aOYo7ZzCZ074VqK1KX9EgIqqob0cIlqHGkKRUn3OY6f+wm/mzb5EcuF9tZC9SCmUvYB8oY5KvOso9HrBche/tOEzodu46dLdE723hhklfzBhYABDSqZ+TL4WAdLrDsqHVuXGYrNuOaq6OYwx/otVFcbvNR/trqwaDAB3cn7pyKC5E9mL5e6XQnHyWI9VdTn3Dw6L54THruEtwNlkiywfGl0yE2Fb7wbU5mFsQQH5QXqsX7aLXzAAR4VuPq1tafroVElp7DasH526HrTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2tRdnFVb25IVGtXS1ZwaStZS1NQU25WWWRHSUJWaS9jaWJJZHFXTUEvVmhO?=
 =?utf-8?B?ZlR4OHNjUTBLSWJNSUJTclFIR1lzSWNaaDhRV3p4eEhpbnpxeTJXUUxkOUVh?=
 =?utf-8?B?UEE5bXdmR3hraW9Od2xvbURUaUl6S1NrcW51TzJOU1dxNHVETDNyUHV4VSto?=
 =?utf-8?B?UjFHNlVEVDJnNCt0YXpqalh1YVNCOWp5eUhTS1ZvUFdBRGRuYmUvOGpJR0Zh?=
 =?utf-8?B?bWtPSlN3Uk42MGE5a280YU1Ed3ZWRXdBU2EyYWtrcUFIOEFoaGZmM3pHRzJO?=
 =?utf-8?B?aThoa1lhT1I4alkrd1JhSXFoSkQrQU9paWY0TzdxUmg3RnlmMzhNREthK20x?=
 =?utf-8?B?YjQwRitVa0tudG9GNzI1czB6MTVaVFZxUklTWVJjOWpocXFkOWMvMDg2Mk44?=
 =?utf-8?B?RmlsMm1LeEFQWXFuUFhoTks0NWZQUnMzVlVCQ0NjZFdJaUF4T0JVbjd1d1BD?=
 =?utf-8?B?Q0RhNVFXN1hsU1R0VzRJallkWEo0UzJianQ4K2ZzQUZjdEpDQUZGdzFBc2I2?=
 =?utf-8?B?VTRBLzBkR3dyekttWHNIRFhoNC9yZUszNW9xZVZVRjZUd1VtYjczaTdDcnF2?=
 =?utf-8?B?TDZZQVJuaUZxcjk3eDZ3TDFmWXlHL2ZzNHRBNU5WbFYzK2tiemhLNzVUc0hE?=
 =?utf-8?B?RXFrV25PRWFldm5LMkhTT1lJT2pueFVza0U5azZtcFZBT2V1aFJuY2owM25Y?=
 =?utf-8?B?bWtxMUFlLzUrZEg0TzRxSUJxbTdSdnBlUm1SZm1uUm8vVmVhVGV0eEJaSmo2?=
 =?utf-8?B?VHlPU1JiZkc3ak5kcW5pVFNubTNnendWYVlaMjZEblZaallqd25XSEVKSTA2?=
 =?utf-8?B?Mk9FNzFoYVhkTEJMZTRKNEYxRkVKL0dhbVZXa01LUjlaUytRbUpoYmU3WU93?=
 =?utf-8?B?MW12eGUwelRUblNFNVNzbTQ3UzRsTENJOGFWY1pqd2VPL2RkUUNVWmhnOXFV?=
 =?utf-8?B?bmlodjBwalZabnhqN2ptNU41VEFhRWR6ZEpVODh2UzhRWS9hOFRoaVdPaHIv?=
 =?utf-8?B?YUtsOU5aVG9tTlZTZm5CbWs4Q2VLejc4NGZqOFZtMnVUbFBnc3ZNVERCQWdr?=
 =?utf-8?B?blRtb3lGUHpFa08xVW4xNWtKRkpzTUVUY0JZVzBsV0RHbXh0M1hEZEtMd1Fq?=
 =?utf-8?B?YjRHSE9BK3NuTDM2NXVUbElWOFlqeElLQ0hqay94RDI4WW1Xd0lORXV0NHBX?=
 =?utf-8?B?WWlKbjVQRE9aVk41eVRnRGVGL3hlRHU2SFpRbE5NRDhkSmhFV05teXhyZ0pt?=
 =?utf-8?B?ZDJCVVN5UEdyNHoxelhXc1dpbFhaYVpFbklhTnRBSlRMbWhMYUNqaVlxcnFs?=
 =?utf-8?B?SStCclRPZWJnQkNMRkg2NlNsYlIxUFNaM1pJeHArSG1IekNCMnRPQTBoZmxB?=
 =?utf-8?B?Uk13d2h6MlIyWjBSWDJsamZWNTVLeXRneXFNdzIyUkV0RkgyRnVtYnVVUDJY?=
 =?utf-8?B?Y002bS8wUlZ2N2NERndUb3paY1ZuY2dzSnVQeExXK05IZjUxLzEzMGEremVH?=
 =?utf-8?B?OG90Q0k2Y3gzdzlNbDRDby9qQ1ZpZUNYdmgvanEyRDVVMFc1OXNOMGdHMkdT?=
 =?utf-8?B?TVk4WXhJVmIxZ2JCV2FsYnhOUENBeWdWUURWbG5SOTkxWm9iMDhJSlIwcmpv?=
 =?utf-8?B?MWR1Y2I3MTdBazJDRW5ackhRUk13UEtNeWREOXJvUWZlUEFCVGJDVU85U3V0?=
 =?utf-8?B?OWN6TFl0NlJxMCtVVWIxb0VUSlFwM0ozM0tqMlQ2b3ZxbTBCMlFJTGxURk1u?=
 =?utf-8?B?Tld3L2h5VnE2ckxlWFJYZVpscThMQVNRcDYvc250ME1yNS9zTTdpNlROcS9q?=
 =?utf-8?B?cmkyTFdySWdWcVhjN3E0QjYraHpQQTVKNWNocXRxNGdocTc2c0xNNjd3eHU2?=
 =?utf-8?B?aThUeVVXdGxDdlMxMm55QXpxMDhNVlY1STd4QnRsbEprdlN0VmlwZlhSME5y?=
 =?utf-8?B?UCtSMTU5OXN4akRPdlNNbkFxbitnVnY4cVU5YVVvYjV4TVJjUTRHSDNRKzdl?=
 =?utf-8?B?Sy9Xb3ZuNi9oWFRnUkwySkREKzAyeXZYa0w0SlhtY0w1RXRYMXZVNnMrSm12?=
 =?utf-8?B?c3ZWU3k0M3hMWTZRbEMwUXhUU3FLazkraHhhbkNMbHduU2h4NnFRZkNJUEpo?=
 =?utf-8?Q?QNocwj+Vh3z2Lm2CIYTnDya73?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c97aac-3bd3-484e-4035-08dc5f46575d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 01:24:49.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqKZ0au5J/etB26Q1TlO8/MEjFG1kBDGmFLriTSH+XNbWKijr+fFDJd9w6RFFyDjtGbfo7PjNec9OTzHPQj1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110

From: Peng Fan <peng.fan@nxp.com>

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCMI platform firmware, which does the changes in HW.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 571 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 584 insertions(+)

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
index 000000000000..036bc1e3fc6c
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
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
+/* Define num configs, if not large than 4 use stack, else use kcalloc() */
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
+	/* Convert SCMI error code to PINCTRL expected error code */
+	if (ret == -EOPNOTSUPP)
+		return -ENOTSUPP;
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
+	/* Convert SCMI error code to PINCTRL expected error code */
+	if (ret == -EOPNOTSUPP)
+		return -ENOTSUPP;
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


