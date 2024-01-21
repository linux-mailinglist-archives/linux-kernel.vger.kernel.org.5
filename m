Return-Path: <linux-kernel+bounces-32004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AE83552D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5C92824D4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24A36AF1;
	Sun, 21 Jan 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GQeN5lYy"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9F37160;
	Sun, 21 Jan 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832299; cv=fail; b=FANVh1ReP2krs4u1gEczccJbSCGKO4KgoHDZ1RNwcSQwdrI63eoY0xwGtP8Qvxv+4HBO5RnrFW89r5uxQF1D99zhpSjjzX+LACRM1WSsi1VlcL7JU+/ASPFS2zvRCG/+gpvn7yF4oQgwsdJdL5XjOkn7EUmglWA+65jO5IosjXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832299; c=relaxed/simple;
	bh=H25+BL0Yw2a1X8e9XsoE4HuvcePj+N+6Lqf+7tdEd0M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j1hJpy4aKGd530HIi3Op5CAvAoIAyD5pRcUqjUru2nkGu1+0WqWO/S3efck2dwX2C30DwkAqZjvbAXGKeBp25lqSZHvr7fMKehfKTG35zAZhAXwogBr9duo/coL68I+O1a/T+xgBRPDS/JJA9rk8mzhO1DiFhhKXKVTxrvHwiDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GQeN5lYy; arc=fail smtp.client-ip=40.107.247.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYcdSBHgUbBAR94RWT3RbNH3chT2zzjKXeXBcaTDlSDP9d1BLKKhH+GAHvDli1njbsgybmxEGzJ395+Wx5hA2k7Aet2ppr1QOP9uboO2Uz6sqelwYbrXaodk/R7cdSy/WZxk1b7zdjTJSrou2CcYVFdfW2KRE1Ea6epFvAObAYQv1A1LP+7HCZAuw1Y12SnAUgo9W9jfWW17sxPav1RByjmk/HaQSW1II3R1+Z+JIyt2WfPURQ33cp8CGRG0SffWMgWn6Xc9vvQB8jA2SM7gpgg50TITSHq3b+yiBet96UJ8d7CCatg0nhw6ppBEt8KF8XgdouZqnhkpjWpyIrGj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNwOUfKxrwU+hA6bZreDSo4mFhd+bcnSwqXnBPPFDM4=;
 b=Ho3blxlEz4FgOlIqxJa6ls0Ify4mtoIZiII4vuykw8fvIlmEmOfmyDHR386yHpOq+LL5xhfUiVFHKa2IAhjjYZGVLW3utifY705dT0YnsVr1elOJw/MvKy8jQa+y2IJV7CvSwtmxUtU+mWrvnblKXco2cBO+gqtkQ9LqDHcKEpaEk8PU91F0v1ZP2mK8eJS+vYUFIemqKawnmgn6nmVFRwmA9ve2LtWY46qPTWAGX/E8GGEaowaQzX9FCxgNm+K4It5OquO5H1uEZdUyT+I7BRSd60I6TEQNeTwvyIGDXAU859MmnTPNSj8LRoPfQ3+c7omRsl0vbwvyR4YME40tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNwOUfKxrwU+hA6bZreDSo4mFhd+bcnSwqXnBPPFDM4=;
 b=GQeN5lYy1RZlqdxSV1EsOQEY2nNaXN2ZAq6NyjrC6oBFleiV8lsz8hGiiRnv9w+HiEAD/rraioSSWm5DjTmJ7Q/o0x41KAKBUCjJOKgKmyYnmVJ1/PQAn9FU3VqAiIjHDwXCo7tINvH9TbescAL/X5P9lMOPXXHl9CZQIqSeEiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 10:18:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 10:18:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jan 2024 18:21:53 +0800
Subject: [PATCH v3 4/6] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-pinctrl-scmi-v3-4-8d94ba79dca8@nxp.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705832540; l=19069;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=QOmdjROwxTNQVC7LpvTrngwoqS9y6OB626mDN90vaOU=;
 b=bkmmOWTyWqZ0TaLytqeVbWHJWTy9MAbxwd8oor9UOrxz2kh9sS+ApADIUo0pDZseZ7t/3JhN+
 4FFLtC5lZI1C6DLnrexOoKmyuuXytSZ7ecwUWYtRInZ3TZHGffaw/RG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 5251d127-09e3-4275-54ec-08dc1a6a466e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FsYh7puNeXwx4N9YBVGdNwvgwW8dOdJoXWWjIjPm+Eep/4z6vCOnJeeGrYypvszx0BNTiMHW3t18Ty0XQi9ns+QYnPgWLa+YspUqcA9RUoKgVPZIpwqcxBgWN3VwCQdHT7WfZqq5BuK68TpIcqTlEvbUzbLjWZEqvl/2o6fO0mtWVTt7utxgJjd7MfgE7dhi/vWyrTU+Q/qALpLx4Fzubl1md08Pxz+eV8yFaAzFUFrdccyRwTBDiHWB7V4Tgox5sVyOQm/0CQSSfBBOcoWiBOukyPbk7vK2/QQOOh83hfosBuW/HDYsXzEv8ZaAKLCKhhGU8BR69zxfPalMVxRKKZiptPGlwOXET32TeMDFO5ZuDdpPazWalNnKt+oWKM4yy3BDvTyjwtLJvBPjiqcDrQ/sgomYLZN8eyzmP8I/HfZblKXpFPUP4Q5pVYWUtTQuwGdO/BbA4ORfprzOXWXQdz0gjAcXZwRAgR4zyAg1ysvG1DmgRZ5f7VLBEbMRYECHsOSPufkAol+mDwq4OFfKZk7k+lyzsGTcMU7OJAncWfhKJJy2ltKGXm2ssay/QMRP8I+C2uTN141cm9eybg4/BSy7LxmBisKN+oD4mPpEaQQntpB+XyNNSzUx0lJ9vKCtCMdtpe0CtgstLscufZ2us8/YzfaMYyiJZxPukm2fCY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(26005)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(7416002)(30864003)(478600001)(52116002)(6486002)(6512007)(6666004)(9686003)(66556008)(6506007)(54906003)(66946007)(316002)(66476007)(110136005)(921011)(38350700005)(36756003)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFZqa01vVzJmOW54RnBjTzgzRkQxL0o1dnlUaE5rdHZacjJqS0I2elpwT1pp?=
 =?utf-8?B?SHBES3V4K05Vc0M2eDhvaHdJcTk1ajNpdzN0TEl6VnYzYlRPNlRLalhuWFpT?=
 =?utf-8?B?bUtVVWRkMzZuTG1KZk5Ob0lkUm84T2ZaWktjMkMrcmZTTng3MEUzUzM0VXRa?=
 =?utf-8?B?MGxEelVxZklYSDd6Zk5mSVBENk5aZGpCUHU5Wk1OREsyTlcwQS9vNVExYzI5?=
 =?utf-8?B?d1I0cmJGRUpJUURGZ1F6ZU9oOVRHKy9Jd0JmMDlnaGlkRjUrcklPK2NVc3dX?=
 =?utf-8?B?dy9PaEEwcmxsNXZkZG5sNGkreHpmUmlEbDBjNHpMRHZzKys2eGxOZklwZ09u?=
 =?utf-8?B?QzI1S0liTDBMd0dkSTZYRlZnYnBybjBDVW4zOGMxQ3hyWFpsaDJ5b2lGQS9n?=
 =?utf-8?B?d0dYNmhhVXh4ZW5rUlh3VEp1ZnZnbTlSMS9NVER2QkZ5RStxdGtnL0hSQkhX?=
 =?utf-8?B?SG1rYUJDNEdSTWlwNm0rMFl3T25kVzNCYytwWitqOFBJVFU1Z2huVXN6Qkg4?=
 =?utf-8?B?bGF5VmtvTlJXbkhIOGgyNGdvUTh0UVhWdHRCaytRaVFIVExycEcxTGUyK3lo?=
 =?utf-8?B?djVaZklqQWY1WXpBV1F2VGo2TmdETFlsMVJDZUtwQnI2ZURBNE9hMXNiMVNX?=
 =?utf-8?B?TXl4c29yK0NxM1dKbmNzMFFsS0pvODNLYzIwb3puZ3drODZZSkMxd2ZxUFRG?=
 =?utf-8?B?TmlQYnczYjdFMzlpWW5hT2VmWU9jdkJBYWJoRG0rd3B5eldSV25XcjFoV1No?=
 =?utf-8?B?YVQ2dDhDc3kwRjNaWG1qNGlpNXg3c3lVYTd4R0RHb2o0TXRDUHJxcUxyK1By?=
 =?utf-8?B?ZmZzSHcrUWwvWHEyd0tkUzJRY3NXL0ZEQXhpbzkzT29zUmNoWGU0M2xNRlZt?=
 =?utf-8?B?d3B0WDc2SlhQVXNEOFZyYTNCN2RCUEplcTRnK2FCcFBFV1NYNzRtLzU3L0x2?=
 =?utf-8?B?eG5OeTJHSUk3T3RNZDBoZWRVMGNJUmFRdDRka2lacFRKUU5jT2F4RHA5MWI1?=
 =?utf-8?B?SGoyV21BRUMyRjBLQkNwbFBOMkExYWZNZnJVZmo4SWg0UFcxM21qS2ZjM3ZK?=
 =?utf-8?B?dlpvUFNlTFBZN1JEbm1rWUxReDIvQXlvcThGZUpteDQ4MjZQeUVpZmUzeWY5?=
 =?utf-8?B?dTFYUFdKNUlnVVBIdmxYeHlWcklydW81S2EvS0hzL09ucjhPc3lLQi9xL0Vo?=
 =?utf-8?B?ZXNSRExHdlV1ZkIrUzVXVUJKd2IyUC9JWHFDbGl1L21GRk1PQzhsbUdIc1Zn?=
 =?utf-8?B?TVdRaFRJWXVNdS9IOHZ0a296ODZsUkdMSzhyRVcrbkgyMjIvc1NNdk4yTFE1?=
 =?utf-8?B?NXpJd29oVmYyYXRMMUVBMGQ0elBDb05JeHhROU5FZHJEaVR6Z3VMOVlHVGda?=
 =?utf-8?B?TzBoK0VyQ0RhcDIrOWFiWDJkWTRQc2NiSms0Mmxla3NYODF6Yk9BM0pqejlC?=
 =?utf-8?B?SjJwYkhIdm54SlVFM1haZzJRcVZRMENQTGpUWTlhUm1ocHNuUnIxZGtIQTU5?=
 =?utf-8?B?YjdWS0o2VjNXRzlqNG4xTC9PQ0MybHI5eUUvNHNVS3B4OUl2SXpTUHUzRlU4?=
 =?utf-8?B?WThuckNBV2R4amFKc2owQkp6emFvNEVBZjJZWVN1VHBVclpkOTJVUmszeW02?=
 =?utf-8?B?RjJrQ1RpYWZrK2tJZDdiZ3puSW1sVStyQ3Y3ZEdBd0VaS3lYa2RuN1Bkc3pC?=
 =?utf-8?B?ZFVCRk9lNlJUYUhXaHc1VFE4WkQ4M0x5d0s2YytOOTU2eWtQVzVRZElPM2sy?=
 =?utf-8?B?UW05U2VVSTRyckxTVjhFbXZoZzZRT0t6WGhEWWg4YmVWdjFSelJVTExVeHRi?=
 =?utf-8?B?dlR5eGNnR0ZzbUhQYmJtU3Fic3FmMkFZWE9md3pqODdDWjJZdURGZER0WG4w?=
 =?utf-8?B?VFBsY2lQcW5ORkM3c3lmVWpuYVRuMjlzYWs3YzRrMjJwV3V5YnlqMExXUWhH?=
 =?utf-8?B?d2ZqUEJSQ2hQSDVrSFNRWVg1TVg5MFdVZDNiTnh1cFlOS3lTWHVUcXVmMjdR?=
 =?utf-8?B?VlpMd24rRDU3SDlRNmtkc0FmYWppSW9JTXF2b1pQaTlEalNBZUxDY2ZhYzNF?=
 =?utf-8?B?V1g5L1JmVW5uNTBQZVlmaFU2bzIyWTY0cnplTncxQlBiUVk5R01uY0ZTTmZz?=
 =?utf-8?Q?/9Jykj/nwWtED4L4gH+LT8bcG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5251d127-09e3-4275-54ec-08dc1a6a466e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 10:18:13.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aovYoZvFYR83UFAKk5gdISBe1Tnlk5wX456G3jxqd67dlthIhFocqh6wEqi9q8yIy0PwQYHFbu0ZrJegCbktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

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
 drivers/pinctrl/pinctrl-scmi.c | 593 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 606 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa33def310..d1b6f889e79c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21313,6 +21313,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/firmware/arm_scpi.c
+F:	drivers/pinctrl/pinctrl-scmi.c
 F:	drivers/pmdomain/arm/
 F:	drivers/powercap/arm_scmi_powercap.c
 F:	drivers/regulator/scmi-regulator.c
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 8163a5983166..27b26e428f60 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -432,6 +432,17 @@ config PINCTRL_ROCKCHIP
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
index 1071f301cc70..ba755ed2d46c 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
new file mode 100644
index 000000000000..f2fef3fb85ae
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,593 @@
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
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
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
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct scmi_pinctrl_funcs *functions;
+	unsigned int nr_functions;
+	char **groups;
+	unsigned int nr_groups;
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
+					    const char * const **groups,
+					    unsigned int * const num_groups)
+{
+	const unsigned int *group_ids;
+	int ret, i;
+	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (!groups || !num_groups)
+		return -EINVAL;
+
+	if (selector < pmx->nr_functions &&
+	    pmx->functions[selector].num_groups) {
+		*groups = (const char * const *)pmx->functions[selector].groups;
+		*num_groups = pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret = pinctrl_ops->function_groups_get(pmx->ph, selector,
+					       &pmx->functions[selector].num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+
+	*num_groups = pmx->functions[selector].num_groups;
+	if (!*num_groups)
+		return -EINVAL;
+
+	pmx->functions[selector].groups =
+		devm_kcalloc(pmx->dev, *num_groups,
+			     sizeof(*pmx->functions[selector].groups),
+			     GFP_KERNEL);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i = 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i] =
+			pinctrl_scmi_get_group_name(pmx->pctldev,
+						    group_ids[i]);
+		if (!pmx->functions[selector].groups[i]) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+	}
+
+	*groups = (const char * const *)pmx->functions[selector].groups;
+
+	return 0;
+
+err_free:
+	devm_kfree(pmx->dev, pmx->functions[selector].groups);
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
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
+				    unsigned int _pin, unsigned long *config)
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
+	if (ret) {
+		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type,
+				      &config_value);
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
+	*p_config_value = kcalloc(num_configs, sizeof(u32), GFP_KERNEL);
+	*p_config_type = kcalloc(num_configs,
+				 sizeof(enum scmi_pinctrl_conf_type),
+				 GFP_KERNEL);
+
+	if (!*p_config_value || !*p_config_type) {
+		kfree(*p_config_value);
+		kfree(*p_config_type);
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
+				    unsigned int _pin,
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
+	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
+				      p_config_type,  p_config_value);
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
+		ret = pinctrl_scmi_map_pinconf_type(param,
+						    &p_config_type[i]);
+		if (ret) {
+			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
+			goto free_config;
+		}
+
+		p_config_value[i] = pinconf_to_config_argument(configs[i]);
+	}
+
+	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
+				      p_config_type, p_config_value);
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
+	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type,
+				      &config_value);
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
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins = pmx->pins;
+		*nr_pins = pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
+
+	pmx->nr_pins = *nr_pins;
+	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
+				       GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i = 0; i < *nr_pins; i++) {
+		pmx->pins[i].number = i;
+		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
+					    &pmx->pins[i].name);
+		if (ret) {
+			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
+			pmx->nr_pins = 0;
+			return ret;
+		}
+	}
+
+	*pins = pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	handle = sdev->handle;
+
+	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
+						&ph);
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
+	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
+				    &pmx->pctl_desc.pins);
+	if (ret)
+		return ret;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	if (pmx->nr_functions) {
+		pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
+					      sizeof(*pmx->functions),
+					      GFP_KERNEL);
+		if (!pmx->functions)
+			return -ENOMEM;
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups = devm_kcalloc(dev, pmx->nr_groups,
+					   sizeof(*pmx->groups), GFP_KERNEL);
+		if (!pmx->groups)
+			return -ENOMEM;
+	}
+
+	return pinctrl_enable(pmx->pctldev);
+}
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


