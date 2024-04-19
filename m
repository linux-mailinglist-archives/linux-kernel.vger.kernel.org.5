Return-Path: <linux-kernel+bounces-150961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6758AA72F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1637A1F220DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E02629F;
	Fri, 19 Apr 2024 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PEpmnfpM"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6761CD25;
	Fri, 19 Apr 2024 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497388; cv=fail; b=NcO5STc+rvuVy08O5XuoWDNfDm3uZJ1nF4+PPSIwtROJnmzDXCScpHGU24eBHpUjU616DCBe6vufQXwQ9bVss6bnvLYgvkHmtIiRxWMaKi2pqhp0NiG9ma3ctwAKa0boc2Zy8Xem7/0Pp/JBqKP/36DOV0dSxJA3aqufPDjIqQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497388; c=relaxed/simple;
	bh=rCXQfCCspkzGniKwFuLpmzstHntuvG3bS66sT5PAxiM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VVTuINQ7o7xrW/C9z+pq9fpOUO5r4UOHsR3ZSjYucKUSvSDflv/E9Th3xmvFkPvleHJ2QrlTjW6yLDbjVmFEcW4M9JMwgtGA5+yE9XzYDpKUiFIvRBSDOCw8JC82/OobbB2nueBH6TBBuwTRsx1gu1XfsHEmGVdLxtUKL2yjE0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PEpmnfpM; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja2PYHrK0hnGOXIY6af3OI8Xah3txPOSHKMWNrz4LPb4P++hgu8MtewmQL2b13DqP/kytaDDwwLh5vDVqI64AnQ1RmZF40Ti14czFznzjH3MOdMNtwwn8Hb1hHyQ0IGL5rNaqQ+R1t+E375BW++WCmyzObTCFkJDYo1vjOGurG10eY3KPvxUtIznADTSS5dPVzjIjwdtAL2CmxMIDMjXjJ1qcrIU+OTQb37J1z6fXkyWV2ti6smGnA7YaYDNpfvFuqnLhYGwdGA/YA5Ae3Ac5NDwCj788GY26mHX+MIcT4S+67UuVnstdhwh/qH5uIY+tiuwGEylISqYNIgJ3mIadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Z1E91NTteX96MebwxrBMYq7DIWOfOT9dKPSgrWvQw=;
 b=HoVTvlak0zj7zLvDpES5tTB5EeZ78talZ+07dBsswmTOCxwLlMgW3kaYVnCm+jZ3jCpcK/atU5mdmSfQ8jSjU2uljmvuxg1BbGKfjyfJbjV/iPZqiyY6NyWu1SC21SlW6GgQas/ZuRXFnaxQHe0Jz7msd77cjsMdL7Qi7y3aNsomiKiTy+GqfUgBOft3/DQuvwbBkZWuziIPoXcc5tC5kWLR1T8uhmJZfpjT9+cduU5Q3w/U/mHRBagoUsXDvpPAPIwYnrkyMKgqTwyAg5okWI2VIiKh0TffCf91zqfWr+nYIyJ0twra+lbZfrPdIuejmlbZBQCqYTQKOLLyziqNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Z1E91NTteX96MebwxrBMYq7DIWOfOT9dKPSgrWvQw=;
 b=PEpmnfpMbA7YmM6RySzD//+RN88n8K2ikBihzq8J+BXDB5htgD5q2YV1jNR4NGE0KCrXu5yKUvXNaUgcbHgw2nG4HdWMcarSZztJ3UW5fMpVoryA0O6Z/xuRWSq85p1xU8/vaf0IDd452fTi+AXv/W9iAo13/A8Vfq2KwZRO3uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:03 +0800
Subject: [PATCH v2 08/12] arm64: dts: imx93-11x11-evk: add sleep pinctrl
 for eqos and fec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-8-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=2999;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nfM6Wo+VmL/ZWUcSpFUHf0VCuNybDxhQy3VHzlu51Ro=;
 b=69zHQHnyBiNGfTmNdO5DvJ5B/vcZW1QwtzpEGBQjR5jPpMMnUSV4+0+I/DYUjMYskxm5b+ycb
 2y2TOiq41lRAvBdOPOHHuZQ6MtkZX3ACEC1FJuE3KAfkGHt28I5z6WM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: a937934d-59ac-484d-cf2d-08dc6020f37a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CqQHaG0u3cD/FFYqjH/nVuF88lZmbvzeLduA1e7I0jE0opeenkYuRWIqy3jI5YtWXTqNoebHUz3eFHvnQUpxwVV8OLO1acRDi8uMZnqF00q+4zbUQIv1NuAmEDZIwM/PyRpJnVc9sAL/dSb+nTFp7k93x6+KNuDF8YN9MUC34kohIA8RgKO1ktA2u5T76F4mjrOjEPjKhpcEwT24Kz2s0pRfezA9YcC6oFd0wFuRSk8eropcAlz3XvYVLq+feJOXHL4b5EvJ6JHp5YYJ59NZUUcVga1ebdJswL9hBDQdF12WKH9bb+AwIJqGROJQjXeJ0cs0XH5ogBKc9/J70n7gFFfalj2yyB+THauuKO1rclQhpM9mkcvcTIWI62tA4O13YgHg9k4b8K7h6NyLLSePW8A4cC1hd+YI4HZ+8F+YAVWkHwCA6RJCdEjuSxSeB7heFm1m70cbeK+D1MwSxtH2nmGjFGxRKBrTtvv/gVIqe1dbMvL/FjghfWw124GyjZ41CuFTG2agKOfq0WEhimM0xlsuoTxfwDbRSWls1+Iobio7NAeFYRmI6Gb5v3aZFvELz0Xr9n+SVzP2SCOyl67Kj29f5s6HW1wjNfI3KGI+5ycb9eFAc8Pl45nOsJBsshhW1D3+jSDGKjy4A3sorbuOlSMNv4qR57IQnUeAgKobcXtLu1MlL61dlKNhtd8Dief3FE/r+jhTnQD8jveaCqU6nEJuG84pcZdcyTXMTmnqHg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5GelZRNWJSU2JBaDZMVXRreDFFS1BGVVpQU0VvbmdkUHo1ZVJmZWtTWVRB?=
 =?utf-8?B?MFZ1MC81UUU3LzJXZGowWkdvZHlEOGR3aVo3d0FxQlJNMTloN2RwRjhEcVRq?=
 =?utf-8?B?VmhydWMrQXh6S1pqRXJzTTRxc3I4MXVJb09FNHA4R2JjQjZ2R3NvZ1plaXF3?=
 =?utf-8?B?L1dyTHN3QW9KWVppTHZpZkY3bGJ4eTFURVpEWHdKWlFMVUhKV1JzYW5ReVJq?=
 =?utf-8?B?Q3lPK1QvKys1ajdZZDhEcFBKQWdBeWlScGVmWEdIUEVTQ1BVSGVXSmtDdWJu?=
 =?utf-8?B?UW55NXBMR2ZhWDhQNHF1bEdZVTM1TTFjYnhoNW1qb05BcmtRRjk0Mk5zMmx4?=
 =?utf-8?B?bElIT2Jwclh0dUdWeW84OVl2ODd3V0xVUlI3L1NlWFk1am9lRTcwNnhqVEZ3?=
 =?utf-8?B?MzNydFk2bm5rWEhsZ1N3dTdZRjBrbDlkeGFzd0toaXJYVXg0Y0JJcnhFMU4y?=
 =?utf-8?B?SHNLNzBScVVlZ1QvQ2VoZTFjTkdmbFNoZDF5ZjVQK0hlNmdvakMwTGNWbG9w?=
 =?utf-8?B?SmtIZG42NmRrOHNjOFhMRFVVaGRacXNzMEdCZGVpd1ZxRTc4UFBtQWNDRUdq?=
 =?utf-8?B?M1FLVWRoR1FmSEZ5bnFMQkFSTWhPMEYxbVNDRkJkbmFTeVZidU1zOTZSZllX?=
 =?utf-8?B?VFdRZHMvaGdZVkFIWmkzQnYyaXVVaDgrOEZNSG1EZEJqWENlMUkvVXlMZ3B0?=
 =?utf-8?B?Q1IraTRxZmp6U05DT0VDMFN0SEM2SzhNcSs3ZWJYd0JNNW5RSW9SeHBUYnQz?=
 =?utf-8?B?NENRN3l3VTlCVVQxczhjL1FWd1Y3dXpkUG9EOFFrNnBsZWk2TWptaWJzTTFo?=
 =?utf-8?B?UU9iaWRYZ3Z3Yi9ETnB6clZaMXFwYkZKWFJ1Wk40dUY4SFY0Q0VQZ0taTDEw?=
 =?utf-8?B?ekpuOHFyQm83NkUrWDNuRm9MK3dYNy95anYySVd4cTRvVzFwMzBrVlFZNk1h?=
 =?utf-8?B?L0VZbWRYYkVLL0VOemUrei9GV2o0M2RCL2lXRFFRTXFXZWNENnk4TWdTeUtX?=
 =?utf-8?B?aGc4TnlJMGJTSmxMeGFZbGlWV2V2QkwrcjU2Vkw0UkNtYlVrOEoyS0NYUkZy?=
 =?utf-8?B?YXZicHpHeWxqNjVxT0dOZWxycklwM0pWUlVtUk1rT2QvaGwxc2xCYWh6UVMz?=
 =?utf-8?B?UEZVUnZjK2h4a2RsM2kxSFllTFp1dU1oZWlYb3IxZEl5VVdyU01hU1dZMXB4?=
 =?utf-8?B?WHlJZHBmOWRlb2xzWloyak96ajVOVTlFN3ZVS3BLaUtmRnUybWtKbU1oZ2tD?=
 =?utf-8?B?QW00RnFmZVZPajdxMEZ1UXF5eTRTQmJ1czJUSUlBU0RMWTJMekRZcnk0bXlx?=
 =?utf-8?B?RDF5R1JGS25CbnlzMi9Yek1BQ3J4OHl1VW9Hc3JENGtWT0dMajlSVUYvZjJL?=
 =?utf-8?B?ZzVDVVN3dTMzbXI2WmdmcWR1ZTExa2tIZlRkUWJ6Yy9IMCtuNE9XZS8xUGtj?=
 =?utf-8?B?MEhXVzZhMFR1WEtHcVBla1QzeWlvcVlYVGhCclVxWklKTys2VVRSYzBiSStj?=
 =?utf-8?B?VUh2TTArTDlpNjNFaWtiNzFCalg0aFAvZXJYSERmSEdIaEVwZStzdFpyQjdT?=
 =?utf-8?B?V1kxRGs3cXFHYVI3eEhqLy9ocExFanE0WUVwNEFQWEVhK1JwMW8ybUV0Mk1V?=
 =?utf-8?B?bFZhcWdRVGk3RE1Qam1KK3JOYVdMdkVsbEVjTGVqTnJBWkx2cmxhUURkNEtj?=
 =?utf-8?B?dE81NFRicGdTZWRWekJBQ3BiaDNZeThla3pscTEzK3VZZXUrRDBMaFlNM1hw?=
 =?utf-8?B?czEwaGFZZSs2UU9MUGZzcEsxZlA4Yk5GcThmeExVaGlhUytBQVU1UmE2TmNX?=
 =?utf-8?B?UytUZFEwWExOMXlHSkRmajFKeWRRaXJUbmJOOUNaM2IyYzVGZTB3bXdKeEVv?=
 =?utf-8?B?TGRFdlVMSFE5bWJoNmY0Q0g5KzN0R0NtVU56aUdmVmpNN2t4Tk55ZTE5VDE0?=
 =?utf-8?B?VDFEZjI5aWJSODJ3YktXeW1HRGtYWXBpRUhLOGtUZ2FtNjN6L3gxUWEyQ3M2?=
 =?utf-8?B?NjkwOFhBMUMrdGVHWDRzY2l2Z0JXT3g4S2hEQUFNVmZGMEliOHNLemdFUCt2?=
 =?utf-8?B?T3lvWFRjaWIwOEhWVmdNOVpEcUxCamIvbmhtN2FpLzdxUHNkd3dyZi9ldlpH?=
 =?utf-8?Q?0GsvzxrXkUx0sG94mxwg8vtlo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a937934d-59ac-484d-cf2d-08dc6020f37a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:42.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4W2wmHD7Nonx8xPql0MSfIt+36pk1l8QFpWcvsRiDBunbP9iQ2bs9LLddd0BQkfDE57Ogv/2eDHJ+3ByhA3QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Add sleep pinctrl settings for EQoS and FEC to save power when suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 44 +++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index b7b52576586f..2b67724db685 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -105,8 +105,9 @@ &mu2 {
 };
 
 &eqos {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
 	status = "okay";
@@ -125,8 +126,9 @@ ethphy1: ethernet-phy@1 {
 };
 
 &fec {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 	fsl,magic-packet;
@@ -301,6 +303,25 @@ MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
 		>;
 	};
 
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__GPIO4_IO00				0x31e
+			MX93_PAD_ENET1_MDIO__GPIO4_IO01				0x31e
+			MX93_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX93_PAD_ENET1_RD1__GPIO4_IO11				0x31e
+			MX93_PAD_ENET1_RD2__GPIO4_IO12				0x31e
+			MX93_PAD_ENET1_RD3__GPIO4_IO13				0x31e
+			MX93_PAD_ENET1_RXC__GPIO4_IO09                          0x31e
+			MX93_PAD_ENET1_RX_CTL__GPIO4_IO08			0x31e
+			MX93_PAD_ENET1_TD0__GPIO4_IO05                          0x31e
+			MX93_PAD_ENET1_TD1__GPIO4_IO04                          0x31e
+			MX93_PAD_ENET1_TD2__GPIO4_IO03				0x31e
+			MX93_PAD_ENET1_TD3__GPIO4_IO02				0x31e
+			MX93_PAD_ENET1_TXC__GPIO4_IO07                          0x31e
+			MX93_PAD_ENET1_TX_CTL__GPIO4_IO06                       0x31e
+		>;
+	};
+
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
@@ -320,6 +341,25 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
 		>;
 	};
 
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX93_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX93_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX93_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX93_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX93_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
+			MX93_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX93_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX93_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX93_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX93_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX93_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
+			MX93_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e

-- 
2.37.1


