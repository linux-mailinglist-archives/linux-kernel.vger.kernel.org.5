Return-Path: <linux-kernel+bounces-49270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A2484680F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F51E1F24CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1917542;
	Fri,  2 Feb 2024 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e0KUlduK"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823117996;
	Fri,  2 Feb 2024 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855440; cv=fail; b=kMQGVB7nNjCpgcvtk/EW8CUyzZrwuh2DyzkjkTRmwZs6XyjpxOJBp/oi6hq3C1hZGgCzd0c7InOfShIZPkzRv02j3JZO4IY/s45zCjWJhU4+mO+FoTd3EZ43oVESzYW8G5qRcIfenFsYIUqkyk1RqHvWN9/sKxRKI3e4nuL91ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855440; c=relaxed/simple;
	bh=jf9t5oFMjDiewN5WNTJRUSr9qK1+BoR2X6zXl+qBA3U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=R1tm9jp0QiI0qCmOLHLXHeYuoQUPaEli/SP+a/lkv8jslljUd1USyzOn/BQ+qSJ05y8zWan8yCzvAvsgcE/8nb1gmUMhmsO9iNt4hO/2Y47ly0OE0+OwDAPMB0i8zD1eglVfd7ZuXRz4vWHezcVovAx7Ai430en+MLyg9pqxVvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e0KUlduK; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuvFTd5NcbxVbex+DdnK3oEfAXu1PUG3EpX4AtwJiAIZ0xZGlQDdRhpLOaimwIvQ8Lh0m62IPssNNfUV6chA7gdtIHdE2gVvz+VneEvGkzq/5tfJy7dmrjV/WveZmaiXydvPPnZ4UjQ3nOLYWPWgcZInmrnRB0MVkO0OC6TjvOJaZizE6VdFeqUVBIWjla5Aq1THNBUqLEAqCg+Snk8+ZJQjtrpXR4D/A50kBKgsLqX9YDvoa9tQxDRMkPD+EiQvu1tqBMt0vf0faP+58LZlaQKUl0Na6QGcXEigl1DjwmRxYOmKaVt7Z8SEUWIwSPauK/sR7CJ8bVB5DV5J3xPV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDdJ05RhwufQkaXVU6j+MQLL2DZqoQcZuNvMQa4WyyE=;
 b=cuVa97ea1uj79zAEtOiHZfkOni084Ss6RiJV/gRz/SIXu+dahBDqEO0FS4rYV2lzXrArJlqh+h6CKkTezkCTBK3QnUYojkcAfOqHXyfM5fCW6lP/ZJvQffmnGamy4b1uT5nRpsjzvMgruRfdDROQzb/f73mHCDIipjUf4TPa5p3fcpfI04rNhWGi8yl5STd6OovtUFi2ShwPgb/L6M4kVdQF/l3fdZo/qG9eDcumodF0L/IXHnZbROXexXou4DQ7WgUTBEasELxmlyMXIBb9IzIPYTyoKPNJK/PeKr/Fk0NyAJaxXirf0Y0Kvpb/QD7ZpQ1esln8617CzvglN+cWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDdJ05RhwufQkaXVU6j+MQLL2DZqoQcZuNvMQa4WyyE=;
 b=e0KUlduKhoKq6aeoJfpFu8N/PSzVw/QEid0aiySOSG8hMO9XUQPKCSXuz0Tdo98mCvTTWwcMaWzvSMKxss3Tu5vg6TDO/BwSwjGP1UOKeUyDVx/aXxnhAD1S0pSi4hm/6Sfsv90JBWqtNPIkzGZe/FGWRlDwlCcxFHxImgITRgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 06:30:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 06:30:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 02 Feb 2024 14:34:40 +0800
Subject: [PATCH 2/5] firmware: arm_scmi: add initial support for i.MX BBM
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-imx95-bbm-misc-v1-2-3cb743020933@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706855688; l=13433;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=oRArFReJUPXPh7xJfujn3ilyJwTRG/9bXnkyCVvqurw=;
 b=fOG8CrzLnU0ZaBJqY9LNB65g3odJOEl/9MbQmiTr/jN923qoTM6eMu9Hw1CZ/zi7+Iqt24OId
 7NFnFjSfUosAW/Yn4BQgW0coJf2Eg7A2zaUa/DUXwW1pIJuSSyJ30oA
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
X-MS-Office365-Filtering-Correlation-Id: 29299557-7343-4a96-c67e-08dc23b8750a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SoOJjFp+Xtf9bxzu7GoRnJ8CEJ28+eDQRZdonD7Fm0sEjjKqsqliT+18JG6ErY/wH8GOSgEArFuT2B5iMpgXX1X4WRcX/JODDEJ17m9loTsVASMME5HHbQgm/QhEzrE92/fAN9jn0iyL76Lb081cUr8VOfJiebalWtwHFkTfErU4xF4oINQRhOF+zDrU7MjUDDM2x5tup0aG26qiQsn5c//qRV0zA5+GASMGf/y3NxMeIxXW5422/6bKjPCqgY0GtlI0ZGcWeyEndix7HtXc5ejLoJD7S0qEGlYm0xxrRjpp4P6D4EkWf7cE8X6jYylHy2FiplNeTe5eazFmFMvvavziESdLEK0DTEV1OqdEN4QiEr8EUNuyDFCbFGNEu93CsnQicrpkYtzy/CnRQqahM2kslH/lHhevFigZaPQKHNjM2aFiDKxVwAUAccOYmB3RIGk6IPCl9Icn/YDnm2K16vfEMWQBHvP2Z4nUg0bXzBFmJkzXO/VB6YkRxtFuCfx1g84BLVuZryTHBov/+AlRXjNY1pYJHdvPfMa/L9CWqGYwIOmKTDbPoLanxCoHNnwEYe6dEXeIU2IElc3nsVwWr2/dmmT42CzZ+7o32RTrUersFzUsvpZaamkrqXgNgmSt89QIDXSQZyPrFvmrsHOoDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(6512007)(6666004)(6506007)(30864003)(52116002)(8936002)(921011)(4326008)(7416002)(2906002)(5660300002)(316002)(8676002)(66476007)(86362001)(66556008)(66946007)(38350700005)(26005)(36756003)(110136005)(41300700001)(6486002)(478600001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNwSGtWaDN4YXM0RTFpQmxsK2dhb3EvbHN3bC9KMkJ0RENwalZQZnovak16?=
 =?utf-8?B?Mjd1NVBweFBEMlVKVEoxMXhVOHdPMUxYZUY2enFpVEZtejJQNlliSitJR0xB?=
 =?utf-8?B?VVhQaWNPeG80b1pOOFB1VUxKY09iUlZCVHlVcFo5bEh4Q0prN3NWWDdiUEtR?=
 =?utf-8?B?NTFpaXlHSlZtV2pVdDBlRlQ3YnI0SkZOa0oyakExdFo1akVpNUpTaXo0V2J2?=
 =?utf-8?B?TklNT0VqVFRBdW5FM2ZwQXEwRWYrRmZ0b0FMTGY5bnlKVHYvSVB3N1NnMXhz?=
 =?utf-8?B?NTdSb0QrVHZFQU94Sk03dHNrTS9qdzdnUnFrWWlmaVhmbHZMSS8zaFRrbGp6?=
 =?utf-8?B?V0JjaHh3eHVqcnMwYXIrMVo4RWF0czRZenZ0T0trdzE0MVFUOS9PRXhDSkdH?=
 =?utf-8?B?Y3NZcGpqcDNkUWZNMWd1RTJxTVZRT2xCRThqanRMT1VKTWZBNWRmaStnQmt3?=
 =?utf-8?B?aXpReDc3MTNwWnljNUFzL1VDTnJ3TGd5TWh3ODFtd3l4Uk80ZkljTFF2L0xY?=
 =?utf-8?B?M0ZRYzN6MWZMK0s2UExiZjhCN3ZiL3hJbUU2b05Qd2w3dEZEcmc4blBZR1dx?=
 =?utf-8?B?NE9sWHV6cGZaREl3OU1UM1dvZTdET3B1b3gvcFJ6a0NPZTh2V3Y4bFJ4T281?=
 =?utf-8?B?ZFV0WWFYaXhtWXhlb0pLVzVPb2pqQWNVL2RNYjc2SmVrZ1VBSXVmdXBlQWdv?=
 =?utf-8?B?NXl3TVdROFJuZlBDeGZ5eDI0UGhJNWZPQ1NrV29kNEMrR05PZWxIdk53d3Vr?=
 =?utf-8?B?emVqcnpnLzlZckk4VEJwa3FyK2V0eFVTaThQLzFIMVptcWZpTkFncmhlMklH?=
 =?utf-8?B?bDk2WHVJYUMybmpsVnJodzltcFFPNEo4TVdNWHVvSE1pajY2T0hpV0NlcWc4?=
 =?utf-8?B?L3hqVDI0aWVwODkzN2lQeUdWWXVyeS9Nemx2WDlCZ2Z2MDFrVnNERWtuejJw?=
 =?utf-8?B?YjQ2SEs1ZkpXcGtjSGE1VC90MVFvUDJpTGg4N1dTc1loODUyT1ZEMmdDQXpD?=
 =?utf-8?B?REJ2K25tOFFjT0UrekhvTjR1enRaZ2w2dEdLOGFHUzBacUN0TTdGQ2gySHpo?=
 =?utf-8?B?a2REZnVVVHR2ZEQ1aG1RN2FybFhvRDE3L1VUcVk1SFVhckExYlVnckpZSTR1?=
 =?utf-8?B?MWhWVVR3L2tyQmF5S0VsWGVaS0hPOWM4a24vTGZIVnJFeTc5QkNJRVhrSWNZ?=
 =?utf-8?B?V24xeFNGSUZHc3BmbmVWcThLejFzVGdxNHE3TVJUMFJMUmRXVFZGeFc4ZjNk?=
 =?utf-8?B?NkJxWG5vVUovbTdHSGdVcjRSYmh5WGcvT0FySjY3NmNReWxXWDZWaXpYcDFM?=
 =?utf-8?B?Nkk0T21oQ0ZRN2VUdjBjQW4vZUo1a0NvckVqOUh6WTlWNVFEbTJ0OFZIMnpy?=
 =?utf-8?B?R1lGeis0MDJiZHVJY2pnR2ZReDd2WFdlK0J2WTdTdnViY1l3blRtYTVsUHZT?=
 =?utf-8?B?MHJKQ1RyL0JMenZDQ1VGVXNLLzllY2R3QjFTa21mVmJORWpxdkxsWUwweWVU?=
 =?utf-8?B?RnBLQ1ZvVDQwVFBJT2Uxb3lBb1NzTmtMaWY5eHVTdFkvNVJEMEd3Qkx6Q0JH?=
 =?utf-8?B?TDVEOHJodS9zclpxeW5wV0xGNnBCVWNlc0Q2d2F4YTdVUXZ2UStOWVFpQisw?=
 =?utf-8?B?QmkwaUpHNTJEME9VTUZOK3E1QzZNbmNFU3VMek9MRy9ySlVkYmhJYnZVejNZ?=
 =?utf-8?B?MCtCZWhvUHcxT2kzamNKMGkzTk5WU0JVQktBWnV0YmV6SkVnWkxtbmp5QzBR?=
 =?utf-8?B?ZUQ5eHVMcUZlWloyckdkRDR4UUFVcmo2dmdpYXhSNXAxSXgrdW00ODcveXRy?=
 =?utf-8?B?MlhrbzZTa0VWQzFnVHRnejhRZUkvN1AvYWtpam5HVTgxbldJNEttc2FCaXps?=
 =?utf-8?B?MTlkdSs3bTR4Y2U3cFlmMlUyMlF0b0YzMHBYSlNpZzUydGpsY3F4dGUyRFdO?=
 =?utf-8?B?MGdxY3pQeXFQbnV5UWJCMWlNTlh2RXdRVFFvSnEzeFc1eWxraXZwazk3S2JX?=
 =?utf-8?B?YS8zcWRlVVlxWW01NmJwYTRwVWlsdnA0Ky9zNk5QU0pFZ0hHY2YzcDdVZ3VW?=
 =?utf-8?B?ZVN2YlRjdkxiRkRBYmtEVmhWVFBqOWtuYTBzamZxVHZIeXNOOFVyUVdLamFJ?=
 =?utf-8?Q?CoxlZ6fnNyuMwpFLgtMWDdVlZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29299557-7343-4a96-c67e-08dc23b8750a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:30:32.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnm7l1UNd9ZduhFn4Nqe9ygwVkLgckA/1+TnmGdHxRdHEWkdcC5H4MDLIQHDHcWJKYwD1OgPW111HqzmGENF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

From: Peng Fan <peng.fan@nxp.com>

The i.MX BBM protocol is for managing i.MX BBM module which provides
RTC and BUTTON feature.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Kconfig      |  10 +
 drivers/firmware/arm_scmi/Makefile     |   1 +
 drivers/firmware/arm_scmi/imx-sm-bbm.c | 381 +++++++++++++++++++++++++++++++++
 include/linux/scmi_nxp_protocol.h      |  50 +++++
 4 files changed, 442 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..56d11c9d9f47 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -181,3 +181,13 @@ config ARM_SCMI_POWER_CONTROL
 	  early shutdown/reboot SCMI requests.
 
 endmenu
+
+config IMX_SCMI_BBM_EXT
+	tristate "i.MX SCMI BBM EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System BBM control logic which supports RTC
+	  and BUTTON.
+
+	  This driver can also be built as a module.
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..327687acf857 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/imx-sm-bbm.c b/drivers/firmware/arm_scmi/imx-sm-bbm.c
new file mode 100644
index 000000000000..0e12aaeabc42
--- /dev/null
+++ b/drivers/firmware/arm_scmi/imx-sm-bbm.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) NXP BBM Protocol
+ *
+ * Copyright 2024 NXP
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications BBM - " fmt
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_nxp_protocol.h>
+
+#include "protocols.h"
+#include "notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x0
+
+enum scmi_imx_bbm_protocol_cmd {
+	IMX_BBM_GPR_SET = 0x3,
+	IMX_BBM_GPR_GET = 0x4,
+	IMX_BBM_RTC_ATTRIBUTES = 0x5,
+	IMX_BBM_RTC_TIME_SET = 0x6,
+	IMX_BBM_RTC_TIME_GET = 0x7,
+	IMX_BBM_RTC_ALARM_SET = 0x8,
+	IMX_BBM_BUTTON_GET = 0x9,
+	IMX_BBM_RTC_NOTIFY = 0xA,
+	IMX_BBM_BUTTON_NOTIFY = 0xB,
+};
+
+#define BBM_PROTO_ATTR_NUM_RTC(x)  (((x) & 0xFFU) << 16U)
+#define BBM_PROTO_ATTR_NUM_GPR(x)  (((x) & 0xFFFFU) << 0U)
+
+#define GET_RTCS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
+#define GET_GPRS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_UPDATED		BIT(2)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER	BIT(1)
+#define SCMI_IMX_BBM_NOTIFY_RTC_ALARM		BIT(0)
+
+#define SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG	BIT(0)
+
+#define SCMI_IMX_BBM_NOTIFY_RTC_FLAG	\
+	(SCMI_IMX_BBM_NOTIFY_RTC_UPDATED | \
+	 SCMI_IMX_BBM_NOTIFY_RTC_ROLLOVER | \
+	 SCMI_IMX_BBM_NOTIFY_RTC_ALARM)
+
+#define SCMI_IMX_BBM_EVENT_RTC_ID(x)        (((x) >> 24) & 0xFF)
+
+struct scmi_imx_bbm_info {
+	u32 version;
+	int nr_rtc;
+	int nr_gpr;
+};
+
+struct scmi_msg_imx_bbm_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_imx_bbm_set_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_imx_bbm_get_time {
+	__le32 id;
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_alarm_time {
+	__le32 id;
+	__le32 flags;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_msg_imx_bbm_rtc_notify {
+	__le32 rtc_id;
+	__le32 flags;
+};
+
+struct scmi_msg_imx_bbm_button_notify {
+	__le32 flags;
+};
+
+struct scmi_imx_bbm_notify_payld {
+	__le32 flags;
+};
+
+static int scmi_imx_bbm_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_imx_bbm_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_bbm_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_rtc = GET_RTCS_NR(attr->attributes);
+		pi->nr_gpr = GET_GPRS_NR(attr->attributes);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_notify(const struct scmi_protocol_handle *ph,
+			       u32 src_id, int message_id, bool enable)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_imx_bbm_rtc_notify *rtc_notify;
+	struct scmi_msg_imx_bbm_button_notify *button_notify;
+
+	if (message_id == IMX_BBM_RTC_NOTIFY) {
+		ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*rtc_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		rtc_notify = t->tx.buf;
+		rtc_notify->rtc_id = cpu_to_le32(0);
+		rtc_notify->flags = cpu_to_le32(enable ? SCMI_IMX_BBM_NOTIFY_RTC_FLAG : 0);
+	} else if (message_id == IMX_BBM_BUTTON_NOTIFY) {
+		ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*button_notify), 0, &t);
+		if (ret)
+			return ret;
+
+		button_notify = t->tx.buf;
+		button_notify->flags = cpu_to_le32(enable ? 1 : 0);
+	} else {
+		return -EINVAL;
+	}
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static enum scmi_imx_bbm_protocol_cmd evt_2_cmd[] = {
+	IMX_BBM_RTC_NOTIFY,
+	IMX_BBM_BUTTON_NOTIFY
+};
+
+static int scmi_imx_bbm_set_notify_enabled(const struct scmi_protocol_handle *ph,
+					   u8 evt_id, u32 src_id, bool enable)
+{
+	int ret, cmd_id;
+
+	if (evt_id >= ARRAY_SIZE(evt_2_cmd))
+		return -EINVAL;
+
+	cmd_id = evt_2_cmd[evt_id];
+	ret = scmi_imx_bbm_notify(ph, src_id, cmd_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+
+	return ret;
+}
+
+static void *scmi_imx_bbm_fill_custom_report(const struct scmi_protocol_handle *ph,
+					     u8 evt_id, ktime_t timestamp,
+					     const void *payld, size_t payld_sz,
+					     void *report, u32 *src_id)
+{
+	const struct scmi_imx_bbm_notify_payld *p = payld;
+	struct scmi_imx_bbm_notif_report *r = report;
+
+	if (sizeof(*p) != payld_sz)
+		return NULL;
+
+	if (evt_id == SCMI_EVENT_IMX_BBM_RTC) {
+		r->is_rtc = true;
+		r->is_button = false;
+		r->timestamp = timestamp;
+		r->rtc_id = SCMI_IMX_BBM_EVENT_RTC_ID(le32_to_cpu(p->flags));
+		r->rtc_evt = le32_to_cpu(p->flags) & SCMI_IMX_BBM_NOTIFY_RTC_FLAG;
+		dev_dbg(ph->dev, "RTC: %d evt: %x\n", r->rtc_id, r->rtc_evt);
+		*src_id = r->rtc_evt;
+	} else if (evt_id == SCMI_EVENT_IMX_BBM_BUTTON) {
+		r->is_rtc = false;
+		r->is_button = true;
+		r->timestamp = timestamp;
+		dev_dbg(ph->dev, "BBM Button\n");
+		*src_id = 0;
+	} else {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	return r;
+}
+
+static int scmi_imx_bbm_get_num_sources(const struct scmi_protocol_handle *ph)
+{
+	return 1;
+}
+
+static const struct scmi_event scmi_imx_bbm_events[] = {
+	{
+		.id = SCMI_EVENT_IMX_BBM_RTC,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+	{
+		.id = SCMI_EVENT_IMX_BBM_BUTTON,
+		.max_payld_sz = sizeof(struct scmi_imx_bbm_notify_payld),
+		.max_report_sz = sizeof(struct scmi_imx_bbm_notif_report),
+	},
+};
+
+static const struct scmi_event_ops scmi_imx_bbm_event_ops = {
+	.get_num_sources = scmi_imx_bbm_get_num_sources,
+	.set_notify_enabled = scmi_imx_bbm_set_notify_enabled,
+	.fill_custom_report = scmi_imx_bbm_fill_custom_report,
+};
+
+static const struct scmi_protocol_events scmi_imx_bbm_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &scmi_imx_bbm_event_ops,
+	.evts = scmi_imx_bbm_events,
+	.num_events = ARRAY_SIZE(scmi_imx_bbm_events),
+};
+
+static int scmi_imx_bbm_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	u32 version;
+	int ret;
+	struct scmi_imx_bbm_info *binfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM BBM Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	binfo = devm_kzalloc(ph->dev, sizeof(*binfo), GFP_KERNEL);
+	if (!binfo)
+		return -ENOMEM;
+
+	ret = scmi_imx_bbm_attributes_get(ph, binfo);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, binfo, version);
+}
+
+static int scmi_imx_bbm_rtc_time_set(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_set_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_RTC_TIME_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+	cfg->value_low = cpu_to_le32(sec & 0xffffffff);
+	cfg->value_high = cpu_to_le32(sec >> 32);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_time_get(const struct scmi_protocol_handle *ph,
+				     u32 rtc_id, u64 *value)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_get_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_RTC_TIME_GET, sizeof(*cfg), sizeof(u64), &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = 0;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*value = get_unaligned_le64(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_rtc_alarm_set(const struct scmi_protocol_handle *ph,
+				      u32 rtc_id, u64 sec)
+{
+	struct scmi_imx_bbm_info *pi = ph->get_priv(ph);
+	struct scmi_imx_bbm_alarm_time *cfg;
+	struct scmi_xfer *t;
+	int ret;
+
+	if (rtc_id >= pi->nr_rtc)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_RTC_ALARM_SET, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(rtc_id);
+	cfg->flags = SCMI_IMX_BBM_RTC_ALARM_ENABLE_FLAG;
+	cfg->value_low = cpu_to_le32(sec & 0xffffffff);
+	cfg->value_high = cpu_to_le32(sec >> 32);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_bbm_button_get(const struct scmi_protocol_handle *ph, u32 *state)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_BBM_BUTTON_GET, 0, sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*state = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_bbm_proto_ops scmi_imx_bbm_proto_ops = {
+	.rtc_time_get = scmi_imx_bbm_rtc_time_get,
+	.rtc_time_set = scmi_imx_bbm_rtc_time_set,
+	.rtc_alarm_set = scmi_imx_bbm_rtc_alarm_set,
+	.button_get = scmi_imx_bbm_button_get,
+};
+
+static const struct scmi_protocol scmi_imx_bbm = {
+	.id = SCMI_PROTOCOL_IMX_BBM,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_bbm_protocol_init,
+	.ops = &scmi_imx_bbm_proto_ops,
+	.events = &scmi_imx_bbm_protocol_events,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+
+module_scmi_protocol(scmi_imx_bbm);
diff --git a/include/linux/scmi_nxp_protocol.h b/include/linux/scmi_nxp_protocol.h
new file mode 100644
index 000000000000..a2077e1ef5d8
--- /dev/null
+++ b/include/linux/scmi_nxp_protocol.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver NXP extension header
+ *
+ * Copyright 2024 NXP.
+ */
+
+#ifndef _LINUX_SCMI_NXP_PROTOCOL_H
+#define _LINUX_SCMI_NXP_PROTOCOL_H
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+enum scmi_nxp_protocol {
+	SCMI_PROTOCOL_IMX_BBM = 0x81,
+};
+
+struct scmi_imx_bbm_proto_ops {
+	int (*rtc_time_set)(const struct scmi_protocol_handle *ph, u32 id,
+			    uint64_t sec);
+	int (*rtc_time_get)(const struct scmi_protocol_handle *ph, u32 id,
+			    u64 *val);
+	int (*rtc_alarm_set)(const struct scmi_protocol_handle *ph, u32 id,
+			     u64 sec);
+	int (*button_get)(const struct scmi_protocol_handle *ph, u32 *state);
+};
+
+enum scmi_nxp_notification_events {
+	SCMI_EVENT_IMX_BBM_RTC = 0x0,
+	SCMI_EVENT_IMX_BBM_BUTTON = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL_DISABLED = 0x0,
+	SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE = 0x1,
+	SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE = 0x2,
+};
+
+#define SCMI_IMX_BBM_RTC_TIME_SET	0x6
+#define SCMI_IMX_BBM_RTC_TIME_GET	0x7
+#define SCMI_IMX_BBM_RTC_ALARM_SET	0x8
+#define SCMI_IMX_BBM_BUTTON_GET		0x9
+
+struct scmi_imx_bbm_notif_report {
+	bool			is_rtc;
+	bool			is_button;
+	ktime_t			timestamp;
+	unsigned int		rtc_id;
+	unsigned int		rtc_evt;
+};
+#endif

-- 
2.37.1


