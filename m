Return-Path: <linux-kernel+bounces-103289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197D87BD87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BC91F21D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55926F071;
	Thu, 14 Mar 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bDwcXmnu"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581B70CC8;
	Thu, 14 Mar 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422284; cv=fail; b=VMThEFRZqBCKbfbJykEs2SWS0hYnOfZcuN+SH//iGkmDsyEscpTA55m4GrMynXUNHge+giyGHbEkdmmQfi+cUdyW2pUm9D4dp2AftYmCHhFuenp5x5PX5yGfWvjCo2DKsvrBCtfSHNrerzuxwT4V6NjjOR5NkUT+P8ZQh1jh4+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422284; c=relaxed/simple;
	bh=/ONMWA5HwK7f2Lau5bEiPM0rZ6FI1rljIhuFBs9ogjY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rYPp7xdo+ZKN1E2TP5HhTfzzCxl/n5uRzOgSnFTWDVYQ01nDUkxbZ4rGx4QObB9RpuJcKIGa96ULFj1PzH0LcviKvLswIUxRdswo9AzsYn6f2VLpbB04Gp15+m1upLFcmmgySZnfH6GaKibSInZ+KN0ExtoYmdtDl9IEfUskvFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bDwcXmnu; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trtz+scAnPp45UNMgaPcakwJIyNe7hFog9VLx2/M+/d4SE2C1Jf0OQ9RlSWwr4WBKFRbUkB5adeEC20KVB/UyY2Q9eDk7s5Wyt4NHcgBq65yUqmwGQpvzYB7JELAknTC4zeXUBgBG8snGVOA3PJrfvrDI9QOA1AEpT4A4O+URWbLyulA/1DEpS67oC/bz5W8/71Ic027rOfU+iUpt02SPwhrMD4Wo0S7apFyJ/Zu1amIJJmB5ACQcnNfnD8yPmry1+kHzl3AAsIrCygiu6pnCRg892UQc/0dD8fJgSWn6+O7unMqvUe52LmCZ7GypRfXw/hQmTVNuT7M2aPO9DJW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSMzMeRyEuAdBLvPMQRnGts0Y+Aedb8psU6zwGhY10I=;
 b=Myw+7QhbsildVIA47OuqIFhQ9PmG43jI8SEQGMokMvJXdEry1ElN/N8VAr/avtAarUtfcrXKDLMPRrqHKrA9SQ59vWlautQvVDUgQQwGRP8d/vFRQTpGpeUkTFAPOcH6d8e6low2APHjVOW0j0CArlXmszJoqCBOwGzINYJJcJSGZyclbEKox9alSpe6yiY1YPHFj2Vy7sYLZuLKhLMNGb77d9SFxCvWf9SxMZWcgCP2ry8OLa69FFOlojVztLOmlWXJbSQnFiStjvC5ZDaBy13tluvuEPYpe2W0CCsPPVq5s/kTytkHlbqK3QAHP3eDHmj/JrFPLTg79jJ3sDuRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSMzMeRyEuAdBLvPMQRnGts0Y+Aedb8psU6zwGhY10I=;
 b=bDwcXmnu0bwTdsAOLq8HHZz07VsfvMScYW+q/VCfjYUbkxYdqOF7Z0iHS8XKYudawd9DByfARSNevFjOXqZg+/VyVBkGETk0gr8VtzZbvsvwggGhoJGruX235PM7SeVRTv1z9DsCTbv3hwuskfTeHqlcE6Z8IbshoPivXA2edYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7510.eurprd04.prod.outlook.com (2603:10a6:20b:294::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:17:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:25:15 +0800
Subject: [PATCH v4 6/6] clk: imx: add i.MX95 BLK CTL clk driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-imx95-blk-ctl-v4-6-d23de23b6ff2@nxp.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
In-Reply-To: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=13472;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=l4DlMaNZtr5nsDFzShy8D+H0Cb79cmMx/CoZVs4+aCg=;
 b=XDX/Fi2ozcWPJ24wZ837uhbpn7DpkRs+r3ywUepDpb/DTHuk0QfZGnLO6yWK7wcOoqnGIi1H5
 kzlJrflKNJeCA9sbx3+2+KYZUuA9OMUrhRVuK0XQIRcakP1SFwjFWoN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 762877b9-be0c-4979-2639-08dc442929d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	brUTQpPhLeq12yOexll8dyP57z3TicNNA9ZFq+AwlaE0qX/ovCJs0vKuYXo/AEkDJ61Pq8UG8BlwBltNx8x5SEO7oWveABdjWcF6pF9jx/7N6PZh8adKCch3t6uQyxjjqfk7t6TST308jw6ImCAUA266RkHv1CWgwISIg0U4PEY3gubPqHbYopTu+18Qb9kG+H906UUc8Oz3vUOqsUJkoSgFRjUFd84xDuG7Hj3YR5dFry/dK+TcQ9ds/wvelrU+VixPf2ilktDjnZCY2jnPrX0kMvMmg6SsIxQ8bi90KXsrTtk/9ILlW8BAqTvox+URObAlfTi9Z+if4KSo5oaU144RQOyGzJEtUOId+xVKxbPIQqFnq3+Sw0DZKNWlNBOQqic3rX0LzY7H5zeJecYGaSkkp6g57PYBMG4Brew1XDoCrrVxMtMhLFNxOkje7qzhfZilwAZybc/ijbyvD88TaNcSbTW+AsP5xSHTnqr+UyiL7Vb95z/M+ypLcYUqLkziJBXol/UhfmTu0IDNzG2yWzv5F0EOpkmaEo0BpYCWuVprZvqmQplPePD4cNZs0d1+cCF08RJLk84L75slyBoKZkgYeniXH3zFcLwLBFTuOvRW85toJ9NrhQAokU+btEd79go3YqLJ0o0z1LFEIaaU2KPFp76sWALC2OlBF5U/Z1qEQ6wvyNQuUAZsVMS65M7MuRTvjrEXTW6xxjzYSys93wllUpORiTfWjzfR4KDku9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uy9aZFlTbUdNWU9uS1J6aWdHbnJyYU5VVlEyNmltV1czME1CVzZkaUJ4Y3Ir?=
 =?utf-8?B?WkpkM0xtWkNJc21HRi9jQ1B2S2U0QngyUGczdFpnb1hISzlGbFBsdzFQYito?=
 =?utf-8?B?MVY0U3g5SVJxMC9Ka2FVYkNQY29CQ1VlOEdIRjl2MGdFN2hRUkJBSnJrSUht?=
 =?utf-8?B?b0E2anNUdHFTQTJWTVZjYjVVRmF0RktCQnNVTE5xUWZhMUVpczJzbER3OVF5?=
 =?utf-8?B?eW96REJrRzBhdFJHblBJengxYWY4Y1E0WDl5ckFpMTQ5K2Q2RVVVVkEzbUZ2?=
 =?utf-8?B?U1RHQkdyUFZyTzBHV2QyajhsZjR5eVJ0WGp6c3VZMTFIT3k5SzhMNEZYbFNQ?=
 =?utf-8?B?YkYyVjA1enVnR3hWbnhUVDJHakxzT01nM3h6YnZxWDh4ZDArTUZjemc5NzRE?=
 =?utf-8?B?c2NXREJHU2ptekh5L00rcTdvM0Q4Y3gvS3JYS2RtWkNVenpiT05XMUhvTHBB?=
 =?utf-8?B?ZTZ0WkIvaVVWRllGekZ2MXRMb3ZFUmJUcmpDUk90TFllMjM4eGZzeUw4VVJu?=
 =?utf-8?B?cmV1Wjk1SXhlaDVaYm9IUVFuMkpVOFVIRkVsbDltT1hsclYvYThhRk1MVGx5?=
 =?utf-8?B?QmxIaW4zZUcwN1BOK3ZJM3NESStqUi9icGRsS3BWa3JFay9DbHhuV0V6YkJl?=
 =?utf-8?B?MDE3NEo4VFk0cVljd3l1MUxnMm1VZ1J3UUorMVBEZGtGQndYdzRUMktQcXRs?=
 =?utf-8?B?TTE2TEl6ZUlXdFdrUzBMOWdPZ2oxR05uV2tsUDBlbFdEdXBqUHlHZDE5Vy96?=
 =?utf-8?B?U3RldEpIRHJ1dFNnM3NuNTh4T0gyV004K21PdnFBbTlKQ01xMWJmLzRBL1Zy?=
 =?utf-8?B?cTA3Q2pQY2ljeHFScTBIWTNaV2ovZVFHbkFOcmdReTlEYlVCU3pGR0dPREFR?=
 =?utf-8?B?WHQydnZWaVdyZzZPTlR4Kyt1VFZ3WHJCMkZLb2dURTROL3p0QU5ZWEJpT2I1?=
 =?utf-8?B?allEYi9Sa1Q0TXR0ZlErVml2MlJYdksvbDF6YkVVQWYyTXB1N1ZHRG91Q2F4?=
 =?utf-8?B?Wm5GbGpad0ZVUnBNbmhqelBYZ25WeU1Sek94eUEyVHkxVzNsN1ZYa2JReEZ5?=
 =?utf-8?B?MjduSzFGVU9uTlRob1pTVWtYazA4TU9NRHhObFV3VzVyQXhsbU8rNWQzRDZB?=
 =?utf-8?B?dzhKMkZVWnpuMEdyTzVBNGhYdEFmUmZyQzE3NXBhVG1pekttZDZiMkZKcWo1?=
 =?utf-8?B?WGp3Nm9UZzRncVpUVE8yUVErM3cvVmFQdDRHRmxVdU5TcGNSZ29KU2hQbVhp?=
 =?utf-8?B?VnQ3ekxseXJiaE5xSUxlVkNsRlNua1R3TkxKSzNkRGsxN2RuNDJwUTJXTlI5?=
 =?utf-8?B?WnhYcG5ic1U5YTdXTzlnc0FpMlVBOTJ0TlVnM0pZQ1plZkZzV3pBSWJWbENi?=
 =?utf-8?B?UVZFeFljYjY1S3ljQUdtRFJITnVFMTB5bjgrU0hsN3g0cEp5WUlDNjMzdTM5?=
 =?utf-8?B?OW9XSUVzV0pqQmQ5NnpwSThjN1ZOVWNDbklvSWt5cEpWSGlkTWhMMHB4bkdL?=
 =?utf-8?B?UkNoMkZuY0NGSGV3NUs2bmZDZnRCUFAyZVIxc0pOMVV6NFpIU0VwUEt5Y3dY?=
 =?utf-8?B?OTRlYUg4akthTDA5c2NFczVmTks1TFdHLzhYeXI0bU9PWXFWMlRHOTE5N2ta?=
 =?utf-8?B?VjlqcVliZG9YOUJBc2J1NVF4clExUC8yb0o4WXZRVmVoemhPTTJZYWNpUUlk?=
 =?utf-8?B?bWxwUC9jVC9SaTZjYjQyQTdrRXlPdHhUZDRYNi90V2tyNlkrNkVHR1BWUE55?=
 =?utf-8?B?VHJ1WTlGK3hQOHVvNlc5b2d3TTkvSDE5Q3ZSbkF4VUZQV3cvVWt2VnBCQ2RN?=
 =?utf-8?B?Wk1wL2ZmekpoNzNWZ21FQXZpYWdNN210WnRlNjNDdUhZM09QRWszNHdOL0k5?=
 =?utf-8?B?eTIvVStZRlhjellWb1NrNHB4WlNkU21scWZOcG5NOWpVeVM2aGhOcGFJNE5L?=
 =?utf-8?B?K0UvU2FsR1RUSC9RNEVrMzMwYXBteUgzeVdUQmFMQ0VHRUpjaktEalFpYlFC?=
 =?utf-8?B?clRSdzVEdmdhUTdWRE5udUFSNG8rRzlIK3pTbFRxeEgzaW5LV3lvRHUzckxo?=
 =?utf-8?B?UmtjdDZkN1FWdlhsbVl5SXpYR1BUelo2bkMxVTBLRFUxQy8ybldMWlBZdGwr?=
 =?utf-8?Q?SFJPHldR0SXrc7cejFYSyswQv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762877b9-be0c-4979-2639-08dc442929d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:56.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTnO+1b0dFX9rXy2PKb6QXczdnkeQKApJ8tc5lQKVuQ5+fCqXKjDMWsN1PylzJhOTEO5nuS6twfYChnm3KNQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7510

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has BLK CTL modules in various MIXes, the BLK CTL modules
support clock features such as mux/gate/div. This patch
is to add the clock feature of BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig             |   7 +
 drivers/clk/imx/Makefile            |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c | 438 ++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db3bca5f4ec9..6da0fba68225 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -114,6 +114,13 @@ config CLK_IMX93
 	help
 	    Build the driver for i.MX93 CCM Clock Driver
 
+config CLK_IMX95_BLK_CTL
+	tristate "IMX95 Clock Driver for BLK CTL"
+	depends on ARCH_MXC || COMPILE_TEST
+	select MXC_CLK
+	help
+	    Build the clock driver for i.MX95 BLK CTL
+
 config CLK_IMXRT1050
 	tristate "IMXRT1050 CCM Clock Driver"
 	depends on SOC_IMXRT || COMPILE_TEST
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index d4b8e10b1970..03f2b2a1ab63 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-imx8mp-audiomix.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+obj-$(CONFIG_CLK_IMX95_BLK_CTL) += clk-imx95-blk-ctl.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o clk-imx-acm.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
new file mode 100644
index 000000000000..afda463e28b1
--- /dev/null
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+enum {
+	CLK_GATE,
+	CLK_DIVIDER,
+	CLK_MUX,
+};
+
+struct imx95_blk_ctl {
+	struct device *dev;
+	spinlock_t lock;
+	struct clk *clk_apb;
+
+	void __iomem *base;
+	/* clock gate register */
+	u32 clk_reg_restore;
+};
+
+struct imx95_blk_ctl_clk_dev_data {
+	const char *name;
+	const char * const *parent_names;
+	u32 num_parents;
+	u32 reg;
+	u32 bit_idx;
+	u32 bit_width;
+	u32 clk_type;
+	u32 flags;
+	u32 flags2;
+	u32 type;
+};
+
+struct imx95_blk_ctl_dev_data {
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	u32 num_clks;
+	bool rpm_enabled;
+	u32 clk_reg_offset;
+};
+
+static const struct imx95_blk_ctl_clk_dev_data vpublk_clk_dev_data[] = {
+	[IMX95_CLK_VPUBLK_WAVE] = {
+		.name = "vpublk_wave_vpu",
+		.parent_names = (const char *[]){ "vpu", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_ENC] = {
+		.name = "vpublk_jpeg_enc",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_VPUBLK_JPEG_DEC] = {
+		.name = "vpublk_jpeg_dec",
+		.parent_names = (const char *[]){ "vpujpeg", },
+		.num_parents = 1,
+		.reg = 8,
+		.bit_idx = 2,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data vpublk_dev_data = {
+	.num_clks = IMX95_CLK_VPUBLK_END,
+	.clk_dev_data = vpublk_clk_dev_data,
+	.rpm_enabled = true,
+	.clk_reg_offset = 8,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data camblk_clk_dev_data[] = {
+	[IMX95_CLK_CAMBLK_CSI2_FOR0] = {
+		.name = "camblk_csi2_for0",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_CSI2_FOR1] = {
+		.name = "camblk_csi2_for1",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_AXI] = {
+		.name = "camblk_isp_axi",
+		.parent_names = (const char *[]){ "camaxi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP_PIXEL] = {
+		.name = "camblk_isp_pixel",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 5,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_CAMBLK_ISP] = {
+		.name = "camblk_isp",
+		.parent_names = (const char *[]){ "camisi", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data camblk_dev_data = {
+	.num_clks = IMX95_CLK_CAMBLK_END,
+	.clk_dev_data = camblk_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data lvds_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
+		.name = "ldb_phy_div",
+		.parent_names = (const char *[]){ "ldbpll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 1,
+		.type = CLK_DIVIDER,
+		.flags2 = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
+		.name = "lvds_ch0_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
+		.name = "lvds_ch1_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
+		.name = "lvds_di0_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 3,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+	[IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
+		.name = "lvds_di1_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.bit_width = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+	},
+};
+
+static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_LVDS_CSR_END,
+	.clk_dev_data = lvds_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
+		.name = "disp_engine0_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 0,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
+		.name = "disp_engine1_sel",
+		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
+		.num_parents = 4,
+		.reg = 0,
+		.bit_idx = 2,
+		.bit_width = 2,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
+	.num_clks = IMX95_CLK_DISPMIX_END,
+	.clk_dev_data = dispmix_csr_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static int imx95_bc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	struct imx95_blk_ctl *bc;
+	struct clk_hw_onecell_data *clk_hw_data;
+	struct clk_hw **hws;
+	void __iomem *base;
+	int i, ret;
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return -ENOMEM;
+	bc->dev = dev;
+	dev_set_drvdata(&pdev->dev, bc);
+
+	spin_lock_init(&bc->lock);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bc->base = base;
+	bc->clk_apb = devm_clk_get(dev, NULL);
+	if (IS_ERR(bc->clk_apb))
+		return dev_err_probe(dev, PTR_ERR(bc->clk_apb), "failed to get APB clock\n");
+
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret) {
+		dev_err(dev, "failed to enable apb clock: %d\n", ret);
+		return ret;
+	}
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return devm_of_platform_populate(dev);
+
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, bc_data->num_clks),
+				   GFP_KERNEL);
+	if (!clk_hw_data)
+		return -ENOMEM;
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_enable(&pdev->dev);
+
+	clk_hw_data->num = bc_data->num_clks;
+	hws = clk_hw_data->hws;
+
+	for (i = 0; i < bc_data->num_clks; i++) {
+		const struct imx95_blk_ctl_clk_dev_data *data = &bc_data->clk_dev_data[i];
+		void __iomem *reg = base + data->reg;
+
+		if (data->type == CLK_MUX) {
+			hws[i] = clk_hw_register_mux(dev, data->name, data->parent_names,
+						     data->num_parents, data->flags, reg,
+						     data->bit_idx, data->bit_width,
+						     data->flags2, &bc->lock);
+		} else if (data->type == CLK_DIVIDER) {
+			hws[i] = clk_hw_register_divider(dev, data->name, data->parent_names[0],
+							 data->flags, reg, data->bit_idx,
+							 data->bit_width, data->flags2, &bc->lock);
+		} else {
+			hws[i] = clk_hw_register_gate(dev, data->name, data->parent_names[0],
+						      data->flags, reg, data->bit_idx,
+						      data->flags2, &bc->lock);
+		}
+		if (IS_ERR(hws[i])) {
+			ret = PTR_ERR(hws[i]);
+			dev_err(dev, "failed to register: %s:%d\n", data->name, ret);
+			goto cleanup;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret)
+		goto cleanup;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret) {
+		of_clk_del_provider(dev->of_node);
+		goto cleanup;
+	}
+
+	if (pm_runtime_enabled(bc->dev))
+		clk_disable_unprepare(bc->clk_apb);
+
+	return 0;
+
+cleanup:
+	for (i = 0; i < bc_data->num_clks; i++) {
+		if (IS_ERR_OR_NULL(hws[i]))
+			continue;
+		clk_hw_unregister(hws[i]);
+	}
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int imx95_bc_runtime_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(bc->clk_apb);
+	return 0;
+}
+
+static int imx95_bc_runtime_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(bc->clk_apb);
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int imx95_bc_suspend(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+	int ret;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	if (bc_data->rpm_enabled) {
+		ret = pm_runtime_get_sync(bc->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(bc->dev);
+			return ret;
+		}
+	}
+
+	bc->clk_reg_restore = readl(bc->base + bc_data->clk_reg_offset);
+
+	return 0;
+}
+
+static int imx95_bc_resume(struct device *dev)
+{
+	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	const struct imx95_blk_ctl_dev_data *bc_data;
+
+	bc_data = of_device_get_match_data(dev);
+	if (!bc_data)
+		return 0;
+
+	writel(bc->clk_reg_restore, bc->base + bc_data->clk_reg_offset);
+
+	if (bc_data->rpm_enabled)
+		pm_runtime_put(bc->dev);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx95_bc_pm_ops = {
+	SET_RUNTIME_PM_OPS(imx95_bc_runtime_suspend, imx95_bc_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(imx95_bc_suspend, imx95_bc_resume)
+};
+
+static const struct of_device_id imx95_bc_of_match[] = {
+	{ .compatible = "nxp,imx95-camera-csr", .data = &camblk_dev_data },
+	{ .compatible = "nxp,imx95-display-master-csr", },
+	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
+	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
+	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
+
+static struct platform_driver imx95_bc_driver = {
+	.probe = imx95_bc_probe,
+	.driver = {
+		.name = "imx95-blk-ctl",
+		.of_match_table = of_match_ptr(imx95_bc_of_match),
+		.pm = &imx95_bc_pm_ops,
+	},
+};
+module_platform_driver(imx95_bc_driver);
+
+MODULE_DESCRIPTION("NXP i.MX95 blk ctl driver");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_LICENSE("GPL");

-- 
2.37.1


