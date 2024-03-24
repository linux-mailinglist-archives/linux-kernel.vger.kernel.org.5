Return-Path: <linux-kernel+bounces-112613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1550887BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A19E1F21794
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032D17BA5;
	Sun, 24 Mar 2024 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k3ezXKWh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D917741;
	Sun, 24 Mar 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266251; cv=fail; b=Utstecwhmw370omTDJ490qS/WvPGzJDWZssZyxz+IH4ucN+yPM2AwYP4NHNuG8CM5vRBoS7k2vAfAB2diNFwG0MZ8GRvKc3vO2KMpdIEu6GfMn8W+bjKDmxqiTDRn5QE9VlBNt4u9ZLwCayaY1bvOMb0UXtaRxbWfYL8wDQK2Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266251; c=relaxed/simple;
	bh=7tdr3h/HTTEJE3q8DazH5/K0y+BnTjed9OAXzpMGoLk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AQ6c8pIFsGAd6FSTv1nrN9h+BkoLbStYpQxHE8O3WzZyO7068Vg1qaZPw+DEQ8u7qrPWdRtuCDZ/832ic3s23ypy+uMisbmE8Rd0nP9A7y7Q+yKIxN//8NwVsjGtv2LFn+YG2ClmnouHeYOzvPAucM2lVcSatexF3Or6hx2Ndgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k3ezXKWh; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8T4ZL3JTwfhGxXdXuio/lFFf4lxq2bA2zqjpAgJ0XOHYOF4zELQfhcQkBCu0BoNhy2ejbHdMgT2DJ9lVHVA/cA8vT6RtNwbegjYLC+287g4X2xGdk/DlE2miGKoc3ui+srmFl7VX5zA7xVEJ2/dPh2IfcRE25OZ3OBNxDditr2/sGQC5zdACtFd+dLo0Q8GjnVI0/CNhvFiBpc6lMagMoxviDS74eb2idiZtqOfQqUNsRVuoPeS38ngkRfV+djxFd4seYaZ8FuZ7UXjy9LyP3ibW4jZ7eyQDz2dpMrakomAMZrbIsHpxux0jx3jAKwo0+pwaozNd6g0zCUwYiERmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6pAU5eB93W4CduMOMhCHfS66QhNiKyFrkaoZUM3IhY=;
 b=Sk7AoC8Q+gbe3xzRHM7uT7YLHnOoaoCzIvcmklcqYrufEnUAe71BUFLJQpFpmbDDcix0NyWiVP/4u7SvALAf3z7pm0K5hj+EZ/zDszRA/TqgR2yuT7C0bgHtC/cZoglzFy1KoLC1/2mvT6tR5gXj8gWyRffTFnBl8/8ocX7QeTBtPHLIEcWo/LpmkvblheSYT86IgoH/j0wy5Y8ntIXWxu/fQO/EVJDrHlBj0chBenFrY1pGCxmQI+QdsZ/CE2EzQTXYIVHi7TY1CFNgtTF33Yl5EyP68TGAMvzMOyp+qMui9sfcWQKtO9Wb+O3uG6vfNa+uTDehMo/rerZ5QbhVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6pAU5eB93W4CduMOMhCHfS66QhNiKyFrkaoZUM3IhY=;
 b=k3ezXKWh0iMhuvcMcqW0uQXT71l3BNnfb5g/fwFSv59UryXN8fCp1ris3lra1s9oFqFEUZarbLBj2h8YGc4d71HPWMYT0Z9zIiFIu2Ul0kdrFrBkRk14bLr2CQCv0pdU9xBPCn4DYCj5jazv0gZ38UslzocdXulXVbBcy35a5mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 07:44:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 07:44:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 15:52:02 +0800
Subject: [PATCH v5 3/4] dt-bindings: clock: add i.MX95 clock header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-imx95-blk-ctl-v5-3-7a706174078a@nxp.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
In-Reply-To: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711266729; l=1454;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6c81DhzZwxP9cW4ETMKqIYeVfbSUSl1cFIcvnIyWuH4=;
 b=TxXcyR9ZB4Prtd/4AicN/aDgYIxz8Wp+Y0yrojWoLkWJ0ukMsWYde8EMe4M0dux+r6TaMFutQ
 jUeTCh1Xyx/AyJSy2bhReDimQlpNSX60nQLSrj9MXJ06+I1Tsc3wvDC
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 48732bac-3505-454b-12c0-08dc4bd62ee9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	odd00kEPB0L+xmGMerHJ5wsqdjRNJT/ulV26LopASP7traTbKPQttt2+6YJb9SFcSguREu++AN9PGUCHgYReuvTcI57lB2ULuxzxkbDDUp8UzB1zo3TzfH37noTtzKFJlRoEookv68zoJQnK0/YPf0gKYGjKC7lTVRL8QtVMNLAjYNsW9830KE+xkGjghBqkKrg9Psju2FTOj91vd2KRIaJrRo0SJ0UdD/qIZ3boxo5l5xSZpNKtGB9OG8beIzi/Srihuu9fDjGxO5Y05SJJNxHOilsgJE7NHaa/o0/07Ipj8hC1iKN1gqRYdJShwvcQN/ONk7HX0RLdfVTFh97c1Xl2mru/9NJ2+NprBH/wkWIctE4q7FoSIoLu61JYtOK3cBcx7lVkJBO9sJAKZpCZe2NCVxG+BuZFNkIP2SXsGO2DzV5RcdQwVVeVWZj6YV0WWfuFCqHABIERKAAI23RLrfcevLdLdKj5wuQ3c6gEv752+xtDjkJUgbpD9G1gpffHBtsW8G0yT2jwqFmy9e1xbkgngtf1v4jkvt0Lr1RLoFbd9pNIz770Jpz7nXBUA2Y5oLWPUxL6mypcR/FdT9nBhin1z3J6EothZZSO3uRjdZYOQYJ6Hb/n4W6bTMC4fUaeSnu1m6fJ8mHTdnOzHrea5ADUP4daG0M/kuHvVlAcrrmVrt8Ha6Go2E69+Iot/5Yo36jzuA6JvH2gDn2MLWAphanYs5D6UEoeEaK6CAleuzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhKN1ZGS3c1Um02SjE5L2MwdWxVMkR0RDRPS25nRE5oaFQydEZrWW9qRWMy?=
 =?utf-8?B?aEVKQ3JrRXZDMHhtNXpNSmlZeVdoZndxUytUbDRleGlPRE8reHJ3a2RSU01n?=
 =?utf-8?B?cTE1RWJNbnBCZU9oTVZQU1RJTk96dHlzM0ZPenE5OU85aEdVOGJvQ0ZHWlcy?=
 =?utf-8?B?ZFNOZ0pzV3ZORFA3dVhSM2oxbVpjeEZrNlFkeFpnSUNLUEt1cER1Mk55VDBi?=
 =?utf-8?B?c1lKVVNTRkpxamc2TUxTMTcwb1lpOGw0anVUbGRkd1dtSTBTZ3RBa1NnT0VD?=
 =?utf-8?B?bG9SYkJSVXN5Qm12RWp2bmNleUlxVUprakdoalloL3g2VlpPbGVXY1Z2bUNR?=
 =?utf-8?B?VnZvN3VrS3M3dmlSYzlKS1hxZmo2ajJhbUFBeW1sL0tmQWdBUWYxdmwrbHlL?=
 =?utf-8?B?TGg4bTBSSlc5MjNFbVZERXVqNjkrZHRBbzYxTEt2YU1ETkNBUG5PNEV0djBK?=
 =?utf-8?B?N3YvVmRaa1BzZGVXV21RNFNxOEIyV1NDVWFsRXVoN3hPT1BJVm15dmZIdHQ5?=
 =?utf-8?B?YlprQnM3TTljbU1SQUIwYXUxVFRoa3RUSlBZWDgwR29kUUlQU2NIemtrNENP?=
 =?utf-8?B?VWtEQlpwdFFSbHA5TU9jaFUveXBMb2s0UTVFWWdCOEY2akRHMnhMcTdHclVt?=
 =?utf-8?B?VG5SY0JONFFxOXhzS1VMODNDTnlVR3hBTzVoWVlWcFIxOVMzZTZBSm5sN3R5?=
 =?utf-8?B?WjRnQmRjZis2aDZTRnNWL3JJT1NlelB1N3pxRThNY0VJQVlCZWhZK1NjMTNZ?=
 =?utf-8?B?YlJnc1BRVWFWL2hRaFpBMUg0WS9FaW8zcDE0ZHBwMGhkR0Fxa2lWMjdDbDh6?=
 =?utf-8?B?a2NiT25VcHFZbGhKL3cycWE4TDA4dHNidWI0enBOUHFZS080VDZjVXZlZ05T?=
 =?utf-8?B?bEdZQkdGYXUwTUp3dWdkRkdHbCtnZWVxMHFCWmh1RldicG5KWGt0ZEh6dGVh?=
 =?utf-8?B?M2NSVVdLVzlxYkFpZHFqNWhuZWdNbzY4RFBXNmp5QkZCSkFHUlFJTWhpUitZ?=
 =?utf-8?B?czYzcHZ5TlBicEE1YUhOb080TzBIV2NkdHR6K0E4UXhvYjdOM2tYaVUzSXB5?=
 =?utf-8?B?bWdrckRhbVpCQjBPQVBnYlovTkVza2l4VEJLamQ5SUl0aXBoUkZRVG1yMjNl?=
 =?utf-8?B?Nkx0b1NSaUswM0V3LzNKcis2VWZIYVc2N2JvMmRVcStXSjkrdjJkMHU5cFh6?=
 =?utf-8?B?b2xGb3BIdmY1Z0hQWXZ2aVFnQnhlRFE3WGVZTGdSdzZLb1huU29TR3JyVlNS?=
 =?utf-8?B?Q3Z0UDRCSTdURU95VXpmY0I3WTY2Ukx3Sk9VcUlFdHhXT1lTU0JjN1RaRDNm?=
 =?utf-8?B?YTJlU2RPRkhQc21UUHZNcUZwNG9VTWtMSlVrdDFXSmJiRDZGQlR5aUlmUFc4?=
 =?utf-8?B?dEgzaFFhQ216R3dFSzJ5amdYTklkcUlRZ2NqUEtrM0REOC91RnNabVQ5UW05?=
 =?utf-8?B?RG5MeWZDcUo0ZXdyZStJRzZvVkV4T3MvQlo5K2RIU1hjWjRhdi9iOStvdENh?=
 =?utf-8?B?L0dLWVBLZUxNV1NYOVdDMGpFV2FDL1JTeDZ1VHJoN3p5WmY2LzZrc2sxS1Vr?=
 =?utf-8?B?ZGtPRFNycUJINmo2QlU4WjFHTWp1TVRoTXpWTklrZGRZbDNSUGlaK1Q4QzJS?=
 =?utf-8?B?TTc5bG42VHpaUThITks2ZkRrWVczNGRsSVFjaVQxVDdUNXVxak9yRWtPcHgr?=
 =?utf-8?B?eHczc3JSSjRCOFNyWDZOZ2lLbjNudGd0TWplQzNvWEZCZTFmT1ZOZ285WDYz?=
 =?utf-8?B?eExBU00yQzlOL2REcExkNEFnd2h1bXQ0UW8vQmR5aXZqZC9xTkdvY1pzOENC?=
 =?utf-8?B?YW5mUUhjU2pYd0IrYmlENDRhbEtUNVMrQlZ2NlRHWG1jVHBuemRWZGdXcm55?=
 =?utf-8?B?VnE0WmREdTFRSjdudmN2U0dMNWVQVDlTclY3ajNUN2FQNzBmSXBqdDAybkh0?=
 =?utf-8?B?dEszaDJEZklDR0VFak5raXY4cUFaUi9UQkhlOTBUR2FJN2pVSXNkeDZmRm1X?=
 =?utf-8?B?d1k5YURxTG0zK0c5T29LeUc3NUdMSDNjNXBVR1d5bVVjVFF5SWhYNENKZWZG?=
 =?utf-8?B?eGtEdy84S2VEdU8xS1JDKzJhWG9mVHI4Um9QNUZrcjlhaXZUL1RXUlpUMG00?=
 =?utf-8?Q?z1wz01dFPGXyhXXC2ECAElxnI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48732bac-3505-454b-12c0-08dc4bd62ee9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 07:44:06.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vefhOPMjH1YdFb6Q4/kbC8WG3StjZ1rNpO+7UU8eRpmWUe1ejsQip78feg2QfzGzGEIunqEwUzLMxF3vRHe+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

From: Peng Fan <peng.fan@nxp.com>

Add clock header for i.MX95 BLK CTL modules

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/nxp,imx95-clock.h | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
new file mode 100644
index 000000000000..83fa3ffe78a8
--- /dev/null
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX95_H
+#define __DT_BINDINGS_CLOCK_IMX95_H
+
+#define IMX95_CLK_VPUBLK_WAVE			0
+#define IMX95_CLK_VPUBLK_JPEG_ENC		1
+#define IMX95_CLK_VPUBLK_JPEG_DEC		2
+#define IMX95_CLK_VPUBLK_END			3
+
+#define IMX95_CLK_CAMBLK_CSI2_FOR0		0
+#define IMX95_CLK_CAMBLK_CSI2_FOR1		1
+#define IMX95_CLK_CAMBLK_ISP_AXI		2
+#define IMX95_CLK_CAMBLK_ISP_PIXEL		3
+#define IMX95_CLK_CAMBLK_ISP			4
+#define IMX95_CLK_CAMBLK_END			5
+
+#define IMX95_CLK_DISPMIX_LVDS_PHY_DIV		0
+#define IMX95_CLK_DISPMIX_LVDS_CH0_GATE		1
+#define IMX95_CLK_DISPMIX_LVDS_CH1_GATE		2
+#define IMX95_CLK_DISPMIX_PIX_DI0_GATE		3
+#define IMX95_CLK_DISPMIX_PIX_DI1_GATE		4
+#define IMX95_CLK_DISPMIX_LVDS_CSR_END		5
+
+#define IMX95_CLK_DISPMIX_ENG0_SEL	0
+#define IMX95_CLK_DISPMIX_ENG1_SEL	1
+#define IMX95_CLK_DISPMIX_END		2
+
+#endif	/* __DT_BINDINGS_CLOCK_IMX95_H */

-- 
2.37.1


