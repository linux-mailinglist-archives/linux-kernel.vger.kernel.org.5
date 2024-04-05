Return-Path: <linux-kernel+bounces-132993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DD899D01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1923AB24BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C2516C69E;
	Fri,  5 Apr 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ht0GXMeb"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2133.outbound.protection.outlook.com [40.107.14.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40D16D4F0;
	Fri,  5 Apr 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320319; cv=fail; b=QdXJS9nQVKAwPrgT6V9SGEESfls5TPgQvBI7SOBeNH0VuneSiXlEgdyA734ebKMQl61TO/26b7qnuq6L4XTLssGf1wJRVg6IJo6b0U/GT+6Rfj3Pf2a89/11yN2UWVXX/9gywZpku94g1hi3y7N9h6lAiDRtd/6TGH0jLATY5no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320319; c=relaxed/simple;
	bh=gXR57Xut5a8ONa6Atrdt+b0uy3ceNM/RhwV1jyV72ds=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hxdp7q/Wrdpd6jXCVc7fzooT62z3F9hE2W+6eAN0aRLsINCuY0vj5KyFV0z8dQakSRVdR++gWtwoVEYl0aqgduc/rvV9+Ydr6zJ+lQVLPt0E57Wim8LaIMolbHX/RurEi5bXU6lgNfSKyFxh3o5VweK0uQyh00kGHXwNujPR8Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ht0GXMeb; arc=fail smtp.client-ip=40.107.14.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONdWn7swiRA54sUpikZXF+QZuoMC8g8zn3a600GRlZC30svFvW7yjnA5cLPXlXC4eOrOi7Hidgm10ieiFOXAQDrmVvCrbu76f8M3MPZgXMaEAToXVqLkoDwb0FaMVAxyHXAoaIqiFHbq4cWpp+4iuuBbsGj8DX47efJLnvIY5Kf+KCMbLCQfb6Gy5YVHziYEeADpaQh7HsozUEhpqpC9ZnAltZwPgFqy85ackFk4Kr7yD0JZYU3Pna3pwTT38el0yO2i0LcQMghEBFrmnQvvwUpuRNGqHgDP5hQQOBfrYht8ne9x4na7/27nq1BlGrlT7J1lwPAP4o6V6QA8H+prRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5Rvxu6VWR+sA8gXWI+TbHy2yE4Vhh5l648QXsDxvRM=;
 b=f/3AP0l++fKSKcGT/K7DaOTm+yu+tv0YL0W2VzwCOYJg4tuCpP7nJ8WVK9ynnDksADl7FK6YGK4cwUBEW9yHBj6tSyrkSDzPHI1kjwlhvp+4fCH3lWjmy3XKjQIB5UDXmpgAimLFuXZK1aEzLSaai4cVSPaw8B+tE6niXyBOqkRSKtADcdI0w181Ovjaog2Ph3xIhO/MOla2L/Z4Yxa23YLGhG0wE6+LqFHGbkUudy24zWoJhIFPHt1C0eA4xty1f4Ta7HgTueju5dT6ixtictN5tGMAFUg4QHdJEbElfyBElVH5Bpnj6CTdDjVJlNRd7N8/bKlW6rq+cKUlHUyfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5Rvxu6VWR+sA8gXWI+TbHy2yE4Vhh5l648QXsDxvRM=;
 b=Ht0GXMebaAD4/zu+354zodaoN9rLM0QNeFt2LdDMUdy3F5yAy7Y+L8aPFE5v3yOxXaFVqN2TW9EZT00iJgNuUWyXSB1S69BJIfQVfjFAnqB60tiHbWQJ3N9qYUhq6l1oFNSf5nJkWlLRtm7Ub1W2suXskzaOpEbmW+vgENlGJJg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:31:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 12:31:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 05 Apr 2024 20:39:26 +0800
Subject: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-imx95-bbm-misc-v2-v2-4-9fc9186856c2@nxp.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712320792; l=10991;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rrwtI122rbdiOSHcoQ2WEjSVLO8kCScFoHvALXkpUaY=;
 b=8pE4c7enfC7R06e7yxYJe18mFkJKnIckLHzsu/npK1ghcbL16r7XRNgm0VfWGirDF/GDxSYZt
 qj15SWy99yoD/jUAbG4hkkD+rXUmjGW86u6EN48pE4Ncky0sTZ1cTxX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7744:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+IUiZ3/W8x4xBj4VBQEsKXHWwgDuj++PGXyKd2KdLANZ11QVBcPGbxLf7jSc0nTRarUDp/ohB6enWjSrSDdFqlM3djQjMHYtncQjx7JjUrpumLH5UIBkqkEl/S+v39+Ex0Yae1pzDcmsRx4QwKt5fEkjVu/RrmopkKdTvvlEsPtN24124EhscMZM07kiGzRezyPEFamPmkgDWo4PoNiBeHtkdZdRolwdkgn/bpvesNFhRsg0R10Gj2QeYXSC44lzhYYiNZQFBVX3DuqXaycmFxsfN4k68A13941U0cS4rOeGFpIJ0yDE+yQM4EZ24PLdXhGnHIuDZDcjUAE1WaeuF+TjI7U36lxabONv/Pio9Kt009l7CX35G/OykFk6Gcvx8iBGfmHJgqyKrpM4AJbLlDmv9zj0MtDHeyBcP1+ZU+KTWs0M35+56YuP1TRgBcTwnKmjJV70UXNG9FOa9QYjkQNa78FSWdzyzpnM17MyuD03d1lcdrKY1WUVybWS+63GVNYkfO16l+6feXIWvzxM7suknsFexdlkIbXAhnaXcEIB7y05zezu0a8nZyaJFOU/G1HH0e9jcz6Y3eFvyEEhsi3zv8ArZbOF4zHsglhAtKzEbfurt+rrbn0byixU3rZ7d2tOERny13FDcppwwetB6Q/AghGJM7B3acRB8+OI8gQ7C5a+QyuuDOyCyYZ85tcGFMoPbI1uKNE5AXsS6kdvNwp2+U5N/KKqck8VqgUNDrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFExYXU1OHNWdFMvS0JEWWFvRDhidCtMK0FuOCszcWhzRHQ0MzZWL2piWWNj?=
 =?utf-8?B?ZENEcitrYVBoMisxTWowRlp0YVJ6b0oySXJPUVJzZDEzSktzQ2lpQUVaOS9p?=
 =?utf-8?B?SWVIQXhKOXlBNXZ2aXB6dzJkc1dyUmswZndPckhmdzFtSmQxTHZTS1JxV2FG?=
 =?utf-8?B?Skt2YjNkeERheFpEOG9JWlY3cURtTzcxN01tN29kU1JSNXVVVTdsNGROV3hh?=
 =?utf-8?B?UzgxRkRvUnNwSURPUVg5emFwMm5Yb29RcE5FYVlyN3owcWpTcVdMbVlRQjNJ?=
 =?utf-8?B?eTFmL01ic1R5ZWR4czNQS2RYTG1zaUVHbllLRzBqeU5aQ1NIcEZEbXUzWUZH?=
 =?utf-8?B?ZmQvQ2p4MTZOYnZXTUxBMnczakdnREpFOGpFUVNTRXBESitmWG5VTTFCbTdG?=
 =?utf-8?B?cGwvTE9qQ0w0UXJqTkYwU3VKNENpUURzNlI4YmUzNVY2NHp3SGNBSFVUbEwy?=
 =?utf-8?B?Rkc5SG94bkR0RzVodHhhd2VSczNkRzRxVEpmRmswNUMyRHJBVEN3TGI3eEFY?=
 =?utf-8?B?UkdINDkrWkEvYk9NZVdaYktiUy9ORkVGREg0Z0JCeGVYcFVvK2VVSHBoRFVE?=
 =?utf-8?B?Rlg5d2dwL2tVWDJzMTJFejBvbVRFaWdmOEJjeW9ESnNWeCt5T2tIS0FNc0kw?=
 =?utf-8?B?TTRWWjd1eEhmeU9DeDl5VzlweXFXbDZYanBVdW5BWDJVblBJZHQ1K214eTNa?=
 =?utf-8?B?OGJSSnlMSDl2Wk16NmdPUFU2TS9GUjJMNDdqakZCQkRDZjBOaTk3cWxwNkxw?=
 =?utf-8?B?eDhPQzd5M3lta1pnQ2I0SzNvbjNLODdpa1JySUVTblgwRk8xNTFUR1pncmtQ?=
 =?utf-8?B?ZjNQSU4yNXRINWpGSWJOY2FibHVzdEM1cjBBbXVzZFAySnVWVy9ac3ZDRmdQ?=
 =?utf-8?B?VGpaOGdZczBnanNKUnl3OWNROWwwOVEyL1VRRVM2cGpsTEo3dGt1TEwzci9Y?=
 =?utf-8?B?MW5GUWNqaWRBWEVmaVJ1UFpwT2xncGpyVGJoTTJBUG13cDJ1Sk1ZTElKVldC?=
 =?utf-8?B?SFREZStQWTA5c09sQ3hpdnlJdVFOL3hZY0FId3NnV2MybXhXYTFSRHF3bVZO?=
 =?utf-8?B?QVVRdng1QWNObldnMWZnaUdTVVBMMGVDNGpHTURXZFo0aHZkYkV1YVczeWJM?=
 =?utf-8?B?VmVXRTQxb2F2cWkzajJpcW95dVRMUHdBeHZ1dnF3Y29ONE5PbEV6VkZqTjhR?=
 =?utf-8?B?Mmw4V0xCWEJ0R0sxUDM5b1pvSENwYTk1d09RM0d1QXBEODd6M1lvSzdFSEdi?=
 =?utf-8?B?M3dsL1V4V0hyUEhRVWtkVC9hVitaWTAxZWVENVhUcUFaSmxXZUFyYndna3oz?=
 =?utf-8?B?UVduUzNuOTROUDZZWFpWT0hBWER5UlRTUUN0WG8xTUR2U2ZCU3hPWHRxZFlM?=
 =?utf-8?B?ZW9xNXZiRVFhWGRRZDJwUXZiRlBBc29aNWFoVUhkcWthMXRBSlNZTTYyZUZs?=
 =?utf-8?B?OE45emhkMUlUVEdKdW0yekZPMCtGdHdkcHlESG9Nb2hGOVJoMldEMkNVT0g3?=
 =?utf-8?B?bmJQNS92U3V0Mkozcnoxb1Z2NWlBTGx5dTB5bVkxa3Ayd1JpSHI1UU1EaERu?=
 =?utf-8?B?aDgweDQrTlRNSHRGSi9OZXZTM3lWd0s2N0RNbEIyNlQ2NG5xZWZUTjBwbmF1?=
 =?utf-8?B?dVdFUktaZkJhNDdQUzNETVB4V1NDOG5OOGY4VTh0QndWWGdMM0hNc0Jnam8r?=
 =?utf-8?B?M1dPd2RuZjlqR21QYVVGY0tSTjV2aTZ4bytmYlh5aDcvdDdaVk9HeEN5S2Y1?=
 =?utf-8?B?VTJ2RTVuV1pPdkNXaVVRQm5BTzgydW5wMHF1NXVOVEJMR0VQb1hsRmlpcG9F?=
 =?utf-8?B?eVI1YjJGUHowTFB2UkFhRWpveFhXQ2lGTmR3YjNYeWd3dXNDbGhELzI5Nmo0?=
 =?utf-8?B?THJJV3FDdGMrQjJyNk9ySmVNQVRFQ3hmWEhsR0JhaWdYU2lORFJzZFpXczNO?=
 =?utf-8?B?NXV5T3ZoVDVwaXB2MjdramhlRE9jbEVtMGZBc0NNN1U0eG1sbUpoczdkWDE3?=
 =?utf-8?B?OUJ1cUl3eXBESG5WVVg3STBNRWg3KzNCRjdnVWhsaWdxQnlWbzF3MFkzc3Rt?=
 =?utf-8?B?QnFmVHBNNUFKR05PdjBxbklTNm1PODRXcmM5ZkJEWmd3bU5MSFJaQjVudzBu?=
 =?utf-8?Q?yGD0M76LbIbqXLoUAzwoxr7uF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08614db7-91af-4a15-612c-08dc556c60ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:31:54.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23lQLKN4fKH5d2gUeFncJTW0mEY2PBmThuvYvc4aFW8WQGEkT6AH+LI+6cfZHvEX3L1BXhF+6xxetoWhALwYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

From: Peng Fan <peng.fan@nxp.com>

The i.MX MISC protocol is for misc settings, such as gpio expander
wakeup.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig       |  10 ++
 drivers/firmware/arm_scmi/Makefile      |   1 +
 drivers/firmware/arm_scmi/imx-sm-misc.c | 305 ++++++++++++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h       |  17 ++
 4 files changed, 333 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 56d11c9d9f47..bfeae92f6420 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
 	  and BUTTON.
 
 	  This driver can also be built as a module.
+
+config IMX_SCMI_MISC_EXT
+	tristate "i.MX SCMI MISC EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System MISC control logic such as gpio expander
+	  wakeup
+
+	  This driver can also be built as a module.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 327687acf857..a23fde721222 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -12,6 +12,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx-sm-misc.c
new file mode 100644
index 000000000000..1b0ec2281518
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP MISC Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_misc_protocol_cmd {
+	SCMI_IMX_MISC_CTRL_SET	= 0x3,
+	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
+};
+
+struct scmi_imx_misc_info {
+	u32 version;
+	u32 nr_dev_ctrl;
+	u32 nr_brd_ctrl;
+	u32 nr_reason;
+};
+
+struct scmi_msg_imx_misc_protocol_attributes {
+	__le32 attributes;
+};
+
+#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31, 24))
+#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+#define BRD_CTRL_START_ID	BIT(15)
+
+struct scmi_imx_misc_ctrl_set_in {
+	__le32 id;
+	__le32 num;
+	__le32 value[MISC_MAX_VAL];
+};
+
+struct scmi_imx_misc_ctrl_notify_in {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_notify_payld {
+	__le32 ctrl_id;
+	__le32 flags;
+};
+
+struct scmi_imx_misc_ctrl_get_out {
+	__le32 num;
+	__le32 *val;
+};
+
+static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
+					struct scmi_imx_misc_info *mi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_misc_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		mi->nr_dev_ctrl = GET_DEV_CTRLS_NR(attr->attributes);
+		mi->nr_brd_ctrl = GET_BRD_CTRLS_NR(attr->attributes);
+		mi->nr_reason = GET_REASONS_NR(attr->attributes);
+		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM BRD CTRL: %d,NUM Reason: %d\n",
+			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_validate_id(const struct scmi_protocol_handle *ph,
+					  u32 ctrl_id)
+{
+	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
+
+	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
+		return -EINVAL;
+	if (ctrl_id >= BRD_CTRL_START_ID + mi->nr_brd_ctrl)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
+				     u32 ctrl_id, u32 flags)
+{
+	struct scmi_imx_misc_ctrl_notify_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
+				      sizeof(*in), 0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->ctrl_id = cpu_to_le32(ctrl_id);
+	in->flags = cpu_to_le32(flags);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0);
+	if (ret)
+		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
+			evt_id, src_id, ret);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	return GENMASK(15, 0);
+}
+
+static void *
+scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
+				      u8 evt_id, ktime_t timestamp,
+				      const void *payld, size_t payld_sz,
+				      void *report, u32 *src_id)
+{
+	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
+	struct scmi_imx_misc_ctrl_notify_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->ctrl_id = p->ctrl_id;
+	r->flags = p->flags;
+	*src_id = r->ctrl_id;
+	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
+		r->ctrl_id, r->flags);
+
+	return r;
+}
+
+static const struct scmi_event_ops scmi_imx_misc_event_ops = {
+	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
+	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
+	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
+};
+
+static const struct scmi_event scmi_imx_misc_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
+		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
+	}
+};
+
+static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_misc_event_ops,
+	.evts = scmi_imx_misc_events,
+	.num_events = ARRAY_SIZE(scmi_imx_misc_events),
+};
+
+static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_info *minfo;
+	u32 version;
+	int ret;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
+	if (!minfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_misc_attributes_get(ph, minfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, minfo, version);
+}
+
+static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 *num, u32 *val)
+{
+	struct scmi_imx_misc_ctrl_get_out *out;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(ctrl_id, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		*num = le32_to_cpu(out->num);
+		for (i = 0; i < *num && i < MISC_MAX_VAL; i++)
+			val[i] = le32_to_cpu(out->val[i]);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
+				  u32 ctrl_id, u32 num, u32 *val)
+{
+	struct scmi_imx_misc_ctrl_set_in *in;
+	struct scmi_xfer *t;
+	int ret, i;
+
+	ret = scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
+	if (ret)
+		return ret;
+
+	if (num > MISC_MAX_VAL)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->id = cpu_to_le32(ctrl_id);
+	in->num = cpu_to_le32(num);
+	for (i = 0; i < num; i++)
+		in->value[i] = cpu_to_le32(val[i]);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
+	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
+	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
+};
+
+static const struct scmi_protocol scmi_imx_misc = {
+	.id = SCMI_PROTOCOL_IMX_MISC,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_misc_protocol_init,
+	.ops = &scmi_imx_misc_proto_ops,
+	.events = &scmi_imx_misc_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+module_scmi_protocol(scmi_imx_misc);
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 90ce011a4429..a69bd4a20f0f 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -13,8 +13,14 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
+
 enum scmi_nxp_protocol {
 	SCMI_PROTOCOL_IMX_BBM = 0x81,
+	SCMI_PROTOCOL_IMX_MISC = 0x84,
 };
 
 struct scmi_imx_bbm_proto_ops {
@@ -42,4 +48,15 @@ struct scmi_imx_bbm_notif_report {
 	unsigned int		rtc_id;
 	unsigned int		rtc_evt;
 };
+
+struct scmi_imx_misc_ctrl_notify_report {
+	ktime_t			timestamp;
+	unsigned int		ctrl_id;
+	unsigned int		flags;
+};
+
+struct scmi_imx_misc_proto_ops {
+	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id, u32 num, u32 *val);
+	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id, u32 *num, u32 *val);
+};
 #endif

-- 
2.37.1


