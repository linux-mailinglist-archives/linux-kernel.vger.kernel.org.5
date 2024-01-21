Return-Path: <linux-kernel+bounces-32006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B997835533
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4DBB22F78
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F5B376E8;
	Sun, 21 Jan 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jKBiqPaX"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F377374EB;
	Sun, 21 Jan 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832308; cv=fail; b=ADLHkir7ZCaJZgHw/oyB5/MqfLFeb610kq09zRYqGxO5wi+yXTS1trHeOa3EBBerkwCsAWt1Piib+/q0MTF4EX/O3v57JqGBwjF0cM0NTyateguEGns+Jsr/RuBstR3nK/K0+vFmJSFINZRGmT+UczsfYVO5io0hsR+XcbhStRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832308; c=relaxed/simple;
	bh=GaICLxMsZK3e9JMRNwEsklvaRIVuhjYndnvA9emggKY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=agl57XfiTARqlZR48T4RuLQW9WR+HfeTthQKUmkD57LJw0msDIkNNVyYieUvy9R1qP22D5iZZ63S9WdkIDSznBC5U8I5Ks/U1jZo+D2P5Fy036Trd5620vGjytc2bd5mh5lscxPcrfhH4p2jw+2nmr5/rJC5hHZCYJNimjAkRYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jKBiqPaX; arc=fail smtp.client-ip=40.107.247.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiWIzb1KDXD1o0akawS8Tl26xnqzlX6RDUR3xw6PpdinMsh21DMcnI5kO3LdpUYhQXGjqadHeZoFXp/VNx2oxNlhOSRgV7ql+2ff4h34/blA8W4kWr72hs1a0XrQwFwUoNGSptEcSyd7aCClVIs6E/yof+uShuTspZIBETKWAcoCgu37xRzZaNT2ft82Z++wnConPSH74LiqrTXStxnIK8dTHzsdqFdMMpyGxOxWzDJZq7riGXA7hBsV2GyGDiJEDHLs39RhqOjw6qheCSjUS/0DIrjppoNIGM+rLmFs3CMyMEiaPb3/Fy8z4nioX0QX34h9SZJP3qOK3LvfCZB6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az/JPkv80H0f/HWm70IyArsUCr7S/cEbjdthQdD78eI=;
 b=iV/W/9TAEUQVIZlIIpeJX4BhFxU+KDHa2yH8EvzHJG5AV7OGwwnljdeq8ee+eQ0i9LbCxtwB8gcmilXooryNv2F5SJ9zT6+58tC8a5wyEs/9s2XzDTxglr4Wh3GbRSudAQEmrxVUgBHqkz7r8G3PpwMr9yQfs0USCUkyWc0ZJfh18QzQEBuBu2vwHyBWzPNtsz7Sp1nrSfuOzGxPdhPKXawQ1gsLcZQ5L3VBQUmm4ii+QzvTUPGHR2JPg1hyXgXBxVPX8xi/CHXw1WOSlDHMqScaS1uKF4qMOIqkma2VkomkDxPyVC+Hj9y1OQ4iVmsMPacSHGPVJegysPJTyCOcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az/JPkv80H0f/HWm70IyArsUCr7S/cEbjdthQdD78eI=;
 b=jKBiqPaXRhz5DSeQmIyREvE0EadUxmY2KmMwT30rUrZLhs23g28/pJfufUWx6xAMHkMtcFg6827h5Sbv4Jks5yaPQaUR1DM4Y+ye0plcvV4+28uKRQcgHalsSCPJGpbYXjhdAlwURqUt7Q0y2DCzi5FHa9uMKaCc25iQxiu5JhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 10:18:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 10:18:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jan 2024 18:21:55 +0800
Subject: [PATCH NOT APPLY v3 6/6] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-pinctrl-scmi-v3-6-8d94ba79dca8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705832540; l=7141;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BhkJAN3xfexI2tgqYRUX3vOWEWRG1jMGTJj5SrWkNQk=;
 b=8svA4Q/eJwtuZLsNT/Jhu73o9s5zAsHv9HlQwPNU+lF/k/LMSyELEKvTsJmCqPXAncVfcgoXr
 JlVI8hfMuNSA1zN+klWhVr7t3vUBsZ1XfqHTis0AxVUT3nFXEtP5rdo
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
X-MS-Office365-Filtering-Correlation-Id: c54a7e4e-2f34-455f-4f37-08dc1a6a4c96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/ppjWtHMgTLrBVveBSQYT6VSg1ZxkCeLsh0SgLgqWjcHs8TEhfVN7Udfc3iR1DLO97BGxIdfXPA2lq2D04vusoceqn99lVzbNdZxUCoGKJouIgo+6xJrxCTaiydUVvTHxAZfElm7osxk+UCkG5f/8+vVsWyI/Pfsag3AiyPrHMJQiY2Q+PLn4ypE/gg0DZ4EZSHQsKwuRiNCEh/EVj62uisTPcddIl5jlcN1xJRpjq168Qyn/7GtJ32WdnXQKQdA9l/I7PGrhXW0je8oBULrdZxmaP97E3b/8nG+9UeGBO4cqOvSC/w9CfpprvBstDDJw0yYfqeRbJiNqcNh35P+tMkW7dliBpf2zTLueLHVvGvMmrmEI+LHI/avyUY3/WN991/LrLXiINvQmg1B8kPkvACw0i2n4oQUEdbQ4qK4PkPRqhF0OYscO7MrBnQ0ThBcN+EFjTgFbDkwYWgHYNobcdZ2FebmQIlDKvFcA+lKMudVKkFYVxLF0RBzGkAX9r1b6uflhxyY2ftvCXcLr1R+J9H7Pk5Fm7N3W8aNsjBVeVZ311s77gysz1r34a1fpa6v7m47glPeCxci3QAKM2jGKl/xBPnoyIShznQbVYA0wzv6w+on246uWejSjs7rurUlNUTQkRVT8WGV0gOFql8Xzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(38100700002)(26005)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(7416002)(478600001)(52116002)(6486002)(6512007)(6666004)(9686003)(66556008)(6506007)(54906003)(66946007)(316002)(66476007)(110136005)(921011)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUc3VzZhbmlDaTdBNkVITVpBakszWlJHOWRqUFRlTFFuUjFxSHJ2SW54bWE5?=
 =?utf-8?B?S2VjQnl2SVlTdHBxL2lEZ2UrM1R1WUpLZXZaT1IxWFpWS3Y3bzZlWjczR25O?=
 =?utf-8?B?Tzk1THAzdUpSb3l2cnpTVmpZR3FOTjg2clVDRnlHbk4zaUlGamZLQVFYZnh5?=
 =?utf-8?B?U3ZGVHlqcFp5K2RQUTloZXhoaEJIWldoRHczVTJoblhMeVlRWUloNFlFazRo?=
 =?utf-8?B?L1U0OUxRaEpuWGpuUG1CaEs1Nlh4QXRUMzc1bzV6b2owUCtmRW1xOEo0bnIz?=
 =?utf-8?B?YkIrSGhlZEtsT1orSFl4d0RqNEVZTDI0RlJnZlhwdHJyYnQ5Y2E5bElmZE1h?=
 =?utf-8?B?S3BYbEFEeHVJZWxBK21zWGVWQnI1OFlqMEhva1FzZzFMUytCUHgvdkhpRURq?=
 =?utf-8?B?alYvWnI0NURsdHlubkFFS2srRFl3UHNyb3FrY0Y0dlhsZ3o2cUJxZ2JkbitG?=
 =?utf-8?B?cXdDVjVibTRyNWt0czhkM3hKcEsxVkNFNGYxNDZJaStlZm5TMXowd240QUFF?=
 =?utf-8?B?cVYvcVhXZDdjTUU5S0grN0VOaENSbG8yQ1puVGIvOGJhenRuVXQ5ejROeHhp?=
 =?utf-8?B?TXluOGhwb3Joc3d5NlY5Skd6TW51WFZiRWhrODdJbHNKWEZjRXlkQldSL1lk?=
 =?utf-8?B?cCs4cEpsTlV0VnVjMS9KNXo4YUd3MUFmd1V0U2RWTk1yZXUxNE5aRGJKNy9R?=
 =?utf-8?B?Q1laZFVORWMyQVFWd2VHbWZYQ1JhTkNRdThmbGpjZ0pvYTJzN21teStVZnNB?=
 =?utf-8?B?L0YyWkQ5bmlFY3hvT1MydllnREtJQlhSb2I3ZkJnZ1JyakhHeDZTUWFxcXg0?=
 =?utf-8?B?QjBoK0VMRlBmcWhPZk1SUFJPUzA3b1VlMDFTZm8wMFhsY3BkVnQwUDRoMjhX?=
 =?utf-8?B?RmZ2NmNXL2JrMGl5SHJrWk5tUE9KNk5xdzVZbnkwT1kzMUk3cGZHNy9mOE03?=
 =?utf-8?B?V2VRUzh5Y3pXR1BiRmRlbVl2RDRuQ3hDcE91T2ViNXY3NTNVMEkxSzBxZzE3?=
 =?utf-8?B?UnNDcUtRMXpkUC8vTkhsQXp5b0U5VnlEQzJ6VDMyRnltdGs2cjUwMzZkRzM4?=
 =?utf-8?B?bzU3bGVGSml4RXNyWmdoMEpwNlZEcTU2cUlWbis4Z1cyMEYrZDRaVFlZS3lw?=
 =?utf-8?B?MVJ0TUxiU1FyMU5OY3AxS0lKZ1M4TjhOd2NNUjFSK3IrME51dm9XZCtFRHZ5?=
 =?utf-8?B?V2RkZFZOMjFkV2hnR1htdGxpQ05NZ0kyYis5QmlZZzdwd3ZYYlZiSHlJTDJS?=
 =?utf-8?B?cUszUkVPMlI4bmtNNEQxOFNnemRYZlpraGxKRjFIN2VTWVEzQjR5OHhOdEJP?=
 =?utf-8?B?OTFaK2FFaThXaGdRbUc0SExKVlk4RWxoNnYxRDA4NWxUcnd5d0pUT0NaMnpQ?=
 =?utf-8?B?SnlVYm9VRGRMcS9HODZEVGVueFJmcWtlcThhZ1JmOGhZRWc4U0VRcVU1Rkw4?=
 =?utf-8?B?ZFY5UVY0aDQxc0FFcE9PWVlHT2NnT2p4Uld1Y2JhbHNIMHExclRSL3F0K0p1?=
 =?utf-8?B?RmhUZHl3K25aNkJVS1V0N0RrdjlreHlPMk5TTG9KeWZUVjJtdjk5Z1pualM3?=
 =?utf-8?B?OGI4M0VBSzZQSnY0eVFVOVFIQ0FSMmJyZjJaTWRQRVcreTgvTTFDR2htQWFI?=
 =?utf-8?B?bXRJRFZtVDBsZm53YUgyVTA5R3crODFOS0hRUi9sckhld1ZEMzFJVUEra0ZM?=
 =?utf-8?B?OXZFUnFPYmovMy9uMkk5d1U3TDk5Q3A0bmR0SWZoSHZiZi91aE56WWxPdFRq?=
 =?utf-8?B?UWV5S3J6QUFnU0Y2NnNzaytmUVVEeHVxdkFxbFlVMmZiSXNsTzI0WnozR0hp?=
 =?utf-8?B?VEVzUWdhYkRiTDNpN2poWEtEV2svY21WM0lOSm5Razd6THJZTVZTb05ZdW9s?=
 =?utf-8?B?OEpzTmZlMnByOWZFcmdtZjJnVEN0eXZiL3FYRGR2cE1kbm0yUnk5dlMzS2dT?=
 =?utf-8?B?a2FpWVN3T3FZZkd6MXgxMFRJVkVHeDhOQ0tvVnRmbXA3dWttczhubmtFb0VJ?=
 =?utf-8?B?Skh1b25BWGx3UFdVUWZNUXg1VXErOStnUHZ0L1BEdEZGTkJScEFRbjlBRms1?=
 =?utf-8?B?YTVaQjdqbEErNURsNDk5T0VGWVZ5dUluZG9OaUptVlZjVDlOc2lJUHM4aCtt?=
 =?utf-8?Q?sA6UWasOX/ODtOod00iKVf2Z0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54a7e4e-2f34-455f-4f37-08dc1a6a4c96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 10:18:23.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzHyorUatLwkdzn4qrMOT72UVQ6vK+YnhYiw6b9roXP6K1gFMmJ9Ms+uSA+S9dHeatY/Gk33gddmrpCtWNYmlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so need i.MX specific dt_node_to_map.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/Makefile           |   2 +-
 drivers/pinctrl/pinctrl-scmi-imx.c | 117 +++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.c     |  16 +++++
 drivers/pinctrl/pinctrl-scmi.h     |  12 ++++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index ba755ed2d46c..d96b7ede1355 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
-obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o pinctrl-scmi-imx.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi-imx.c b/drivers/pinctrl/pinctrl-scmi-imx.c
new file mode 100644
index 000000000000..e9d02e4c2cc1
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi-imx.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-scmi.h"
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+/* SCMI pin control types, aligned with SCMI firmware */
+#define IMX_SCMI_PIN_TYPE_MUX		192
+#define IMX_SCMI_PIN_TYPE_CONFIG	193
+#define IMX_SCMI_PIN_TYPE_DAISY_ID	194
+#define IMX_SCMI_PIN_TYPE_DAISY_CFG	195
+
+#define IMX_SCMI_NO_PAD_CTL		BIT(31)
+#define IMX_SCMI_PAD_SION		BIT(30)
+#define IMX_SCMI_IOMUXC_CONFIG_SION	BIT(4)
+
+#define IMX_SCMI_NUM_CFG	4
+#define IMX_SCMI_PIN_SIZE	24
+
+int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				    struct pinctrl_map **map, unsigned int *num_maps)
+{
+	struct pinctrl_map *new_map;
+	const __be32 *list;
+	unsigned long *configs = NULL;
+	unsigned long cfg[IMX_SCMI_NUM_CFG];
+	int map_num, size, pin_size, pin_id, num_pins;
+	int mux_reg, conf_reg, input_reg, mux_val, conf_val, input_val;
+	int i, j;
+	uint32_t ncfg;
+	static uint32_t daisy_off;
+
+	if (!daisy_off) {
+		if (of_machine_is_compatible("fsl,imx95"))
+			daisy_off = 0x408;
+		else
+			dev_err(pctldev->dev, "platform not support scmi pinctrl\n");
+	}
+
+	list = of_get_property(np, "fsl,pins", &size);
+	if (!list) {
+		dev_err(pctldev->dev, "no fsl,pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	pin_size = IMX_SCMI_PIN_SIZE;
+
+	if (!size || size % pin_size) {
+		dev_err(pctldev->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	num_pins = size / pin_size;
+	map_num = num_pins;
+
+	new_map = kmalloc_array(map_num, sizeof(struct pinctrl_map),
+				GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	*map = new_map;
+	*num_maps = map_num;
+
+	/* create config map */
+	for (i = 0; i < num_pins; i++) {
+		j = 0;
+		ncfg = IMX_SCMI_NUM_CFG;
+		mux_reg = be32_to_cpu(*list++);
+		conf_reg = be32_to_cpu(*list++);
+		input_reg = be32_to_cpu(*list++);
+		mux_val = be32_to_cpu(*list++);
+		input_val = be32_to_cpu(*list++);
+		conf_val = be32_to_cpu(*list++);
+		if (conf_val & IMX_SCMI_PAD_SION)
+			mux_val |= IMX_SCMI_IOMUXC_CONFIG_SION;
+
+		pin_id = mux_reg / 4;
+
+		cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_MUX, mux_val);
+
+		if (!conf_reg || (conf_val & IMX_SCMI_NO_PAD_CTL))
+			ncfg--;
+		else
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_CONFIG, conf_val);
+
+		if (!input_reg) {
+			ncfg -= 2;
+		} else {
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_DAISY_ID,
+							    (input_reg - daisy_off) / 4);
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_DAISY_CFG, input_val);
+		}
+
+		configs = kmemdup(cfg, ncfg * sizeof(unsigned long), GFP_KERNEL);
+
+		new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_id);
+		new_map[i].data.configs.configs = configs;
+		new_map[i].data.configs.num_configs = ncfg;
+	}
+
+	return 0;
+}
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index f2fef3fb85ae..b5bd73951aea 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/seq_file.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
@@ -19,6 +20,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -91,6 +93,16 @@ static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
 #endif
 };
 
+static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
 static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
@@ -514,6 +526,7 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl-scmi-imx", "fsl,imx95-scmi-pinctrl" },
 	{ }
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
@@ -549,6 +562,9 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
 	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
 
+	if (device_is_compatible(dev, "fsl,imx95-scmi-pinctrl"))
+		pmx->pctl_desc.pctlops = &pinctrl_scmi_imx_pinctrl_ops;
+
 	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
 				    &pmx->pctl_desc.pins);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
new file mode 100644
index 000000000000..25863b4428fe
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef __DRIVERS_PINCTRL_SCMI_H
+#define __DRIVERS_PINCTRL_SCMI_H
+
+int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				    struct pinctrl_map **map, unsigned int *num_maps);
+
+#endif /* __DRIVERS_PINCTRL_SCMI_H */

-- 
2.37.1


