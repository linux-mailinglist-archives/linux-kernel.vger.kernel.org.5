Return-Path: <linux-kernel+bounces-126677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA4893B57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310B6B20A64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835823F9DA;
	Mon,  1 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="diGlBmlA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2119.outbound.protection.outlook.com [40.107.20.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57093FB31;
	Mon,  1 Apr 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977636; cv=fail; b=A3srslT1NCS99lARiLCptrUXdlnH/86pjyszdqugaXiIklNKAzxTCuw3sOjgKTl1x9T3Eg5xcWYY8iA7XWeePQ7UiXIRr0Chb81nvnlUBHuGadP9d9gw74oWS441Cx+f5c+CAVGmg3q0tJMP1VXnSZbF4NlczW5R3rqljJ1lWT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977636; c=relaxed/simple;
	bh=b9oMncqMy1SFzaG8fmW0ogJJl7kSZ9VDjUs7hQX2RxA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nqdisp6fAgcObiNOOv3aAHFOkL9T8kLxvJ5kkr2hKK1IeKPM1md4zzVYUItzsXVbRuBX+i5X91kfssLtVTmUcBx5K+9sZbygIeY6qvDiumsYTxG2r+mZABTIS3P9G9MKLL9FFwsxFmAoMau4TFMe7oO8L+oelXcY8C/fd2A4l88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=diGlBmlA; arc=fail smtp.client-ip=40.107.20.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7BX6//+W4/aq5YOSFB0iKYY2hRYy9KCeUhv4I5mViirrNsk9kWMgkMoYOmNprgDF2AC49n3BhfvDihIMKaBHo+vxiGdpKRa4QH1234KguJYva/cOJVKbKxKz8avzFa5GYTK91U6w05jNmlpRloRTIxxmJqPrkmcjMHZJVJLhlg2KOQ8Y1pbH0B8Kkx/Uyq/AUkiOkp/GGITrEI9dyZ60GJzpfmbCAQUfR9Hgz36hmkAAnxJq8peKbpe0herYP4xO5iKhl55YIjP7p75aBeT9W0VJcQ0K9cg5xBt6W54noAs3wS7URYvbdmjHTJNWPWDJGoFDH/V0/wAWSTCe6SzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9cjUNBbS/2+yqRJTLFBW4RKtnfpS9k2aW+uA7CbNVQ=;
 b=lfU6XoYn30l+mBhG7UTS/lQ9Yq6TXu3nEvkcti/EpMMWqUszJivdCyUPrpLBJs5cvxv38B7oFm9AagqLFYtps/kx+xQnlfbJcI8rviAd09si1VY6SLczfTgu7wDj4J9LBqbCGmJvBG0euTti4pgA/5E9CEi+icyN39K2L7PlLvtIaaQJm8g1fqe1jnplf4Klj/VW10HFiPlSlSz0DlLQzpK6u+DbRBGyRzfYYiTx46Ouan1hs/vgo4K7yVMFuIXK/VJcxUgw5969wMW4Non/MVwYqOndZg68SSgFz7mztWWbkP+NQ4OZdWskUGz5JjJBw1V9v027h3Ke3dtzM6yRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9cjUNBbS/2+yqRJTLFBW4RKtnfpS9k2aW+uA7CbNVQ=;
 b=diGlBmlAuYFTXTYzpABBl6Pm/oQmZhtOAyE6QdohNFCoiQigPNZF666UY74mjZr2w1OpMy7qhQ94yxbAKWB4caCv9x0s2QmmiNU463yO1gvPTRJfS+4qnnd3+3cwtPU0nI96bNyAnSWfxYOiwYrkJ0IA3bSJFflBgwp1LPvGDBY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 13:20:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 1 Apr 2024
 13:20:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 01 Apr 2024 21:28:16 +0800
Subject: [PATCH v6 2/4] dt-bindings: clock: support i.MX95 BLK CTL module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-imx95-blk-ctl-v6-2-84d4eca1e759@nxp.com>
References: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
In-Reply-To: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711978117; l=2065;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=14zs4M8vnABfcYUX1QG8YthnsTqVy2eJQp7DkrjxGEk=;
 b=hUBvINlPWbiqkl7mnRNewN4nrNn/BLQuLsieiWEfwx/pKwOz9Bu2TkPFNn4D38Eg5SU/b7LM6
 aziEaS4LNYIBSmPUo6y6vR/2zNQIJry5lx9VIx+xWuMVpC5mjeRXGQz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8766:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ssOBAmBqrC0L5qrDilYBitCuSQNa+Yj0jru3h/Jb6WuwaopUz8V0NncmVV9Jpa1S/aS8vP2ghTrnV+OmCRlSHOHqaRUldIlxm1Zbukwdu98IHZ+SnhI8XEGBQIcnwcO3YvDHibKtuaQI2Yo1cb0TE0rYCCuDoaaPMuJ6GI1wowBUu1XrkA3SiyY3d/n0fhNy9uDwyW5IsZn/QkWrTRLkgwJgitpVAq0fvENSO/0N1AFxrh4wJiMxDFAzBPkyIHUyAadQXo4so84Bi0ViqydqUYRgeXQ6ku/cxXPhvxI9FJko8aCtld60IHxQ5KLrLX8tTyi6P64f+Nszgd8hJEHpLSFlnuXarlho0T2pYQ5XEnByKPZR2HXVCBj95eAYtz544UxYvy+G1mEWvsKY7DN7tE7req5Hz6XXc1Q8Kr0ysB4rhgZ93DBxFohmyrUwDeSlCALmGqiognWp+yb+1CKsgHR8Nggph2v6OHNihM9boVt+lXw1jiDwHHqlvdIFF6kFdsUjxTrl/vcSr17CWpMHz9+77XoLAw5c3moa/j+3WZylRyrMRpg9luU02JKZc77ZNCuSe2YeHGk/ov8ZSwW2kCFGlXPlDQLtp0kT8284sRpyoloYzebPZKvrvBz2NxMqWo4ie8QJ8yp1QNo/5kJyvVIbyjcgtOKpq4t9Rmbgep/8SK6IVo9DD3slL0TT+Kkx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE40enhLd2k3UnRicEdrN2k2b25SSkQya0ZsWUt3VXJjdFZyOVRyOTExc013?=
 =?utf-8?B?MFgrVStZczZZSHNTVEdiTzlycGF5b2hFdTZ3SWg4RUJ1Zk16SWpzbE0wSlpk?=
 =?utf-8?B?MlpwUkQ5eEJsL2IrWWpwcW5yZTAvcTBTcFBOaWh6NGt6NGNYWS9nK1VkcHRG?=
 =?utf-8?B?dVduTkNaank1TVA5MExBcndIT0E5VlZLdU5XVzlTU1Q4Q1FadnkwdjlsZUFS?=
 =?utf-8?B?M3hXZDZ3aG1WNjJ1VjNVR3ZRNDdUNmZxblh0VjB2L2xGOWl6SHEyaEJxc0ph?=
 =?utf-8?B?bFZFOTNwVnhRZXUzVmNkU2VteVh3MDk0aE9ER1JZZ3RUb0VUd01yVkNJMk9a?=
 =?utf-8?B?Qnl1Yy9mTXRoNlZpVVZ4OXE4eGIyMGpCbHUyaTN1UFQyVm40a25Ya2l4ZlJO?=
 =?utf-8?B?R0dlTjNEUHV5bnR4eGdnOEQ3MjNZYzh1VytoSkZwVVpia2tOMGZzU21COVZB?=
 =?utf-8?B?ZDQyc2pOR1hnTGUrRFlRSStPSWdmWW1HSndFaWFNUFVVUDhJREM5OWNKSzV5?=
 =?utf-8?B?UFBrN01WNnlUMDJRdENwYzczUGRDRFRSVW12NlVpTVRCV3dUbE5UdnNacEl0?=
 =?utf-8?B?Vm9PbmtaRWpZZEZaQnpRRUVmSVBXRFVxTy9ZVU1IcmFQNG5DUVM1dHhRVEhG?=
 =?utf-8?B?ZjMzVkM1SGY0d1RZVWlRUmpLVThNbXFtQVZkcEdXdmdZYmJHM252UDZuMjQ1?=
 =?utf-8?B?cEE2V3dsRXNvVE5JQXNJN3d4T3MyditWQnpMSDBHMDh0OUNEemFjalI5M25F?=
 =?utf-8?B?bnFCYnYrK3ROT05JaHNHSlp1YXdmYStDbzk4MDlUVXQ4MVc3UmQvOHBaV05n?=
 =?utf-8?B?MXBTdURaOWgyL0hvUjhRVjdkb0lScHEwRkdGd1VMKzZsNkp5MWpsc1MwUEQz?=
 =?utf-8?B?OXVBOUlLTkdWY0p2dURlZkpnV29rTTlway9DN3JzRDM1UzBPcDBHbDFCcEs1?=
 =?utf-8?B?YTBUTzArNVFPbjluclhQU1BxSnpJRzBicUJicUdTek1WYWRibjRmd25XU2RV?=
 =?utf-8?B?S0pLRkZMdVpia3V4ZjVNdkpoVDBablkxaCs4R0s5akhhN0pBNE9rUmZDZEpQ?=
 =?utf-8?B?UmRjb0ZmK3l4NlE1NzZuV1RBb2QwZG14cWc2QlJLTG42UUZueS8xWnNhMGJa?=
 =?utf-8?B?TXVOZ0F1a055ZGtyalkwWE9yVHpvN3BEYlZianltZXk3ZTVoam5kOFF0clVU?=
 =?utf-8?B?TldOeEVtbHdvU0puVGhnVjBpK1phL3lsK2M1ZnR0VFFPdEtyYWdpeTZBdEV2?=
 =?utf-8?B?d2pJS21hZExiVU5pZHZHWGZablJaai85NitYc1BqVTlEbjZMOXJBQUNHcUwv?=
 =?utf-8?B?cVBWeTVyblVKcGdCdVdJaDY1aFF5R3c5MmRoK3NMbDBvOWpiZzN3WDk5OEpz?=
 =?utf-8?B?S0E1YUVpNnhmMkUveWp4MWFXRng0VUptU2VXTjE4VzlJTTMyZlpReXFLcHdD?=
 =?utf-8?B?T2RXLzBxUjhnSExWd1pDSmJrVDNKVWZHVmM1WFZQTDk0N1pVUGwzYWVqemdz?=
 =?utf-8?B?VTZvdm5pVjhjc3dKaEVvbS9icUxFSnR2MDRLSDQrS29lWHRIRDFuM1BpWnJp?=
 =?utf-8?B?dUVJVUIvbzRUdmUzamk1ZVZBZ01VOXByU2ZMWlcvVzJtNFh2VVZDZGpRRk1H?=
 =?utf-8?B?ZGxpS1VIOTBWajBUQk93RFRhdi9CekVNWFY1aERRWEh0SDV4ajZNZEhJSkhu?=
 =?utf-8?B?WTgwZndad1JXSnB1dlZodTFhT0EvNjhYVG5RV0J6NnpsWXhGak96RW51elBw?=
 =?utf-8?B?Y0VYbk1SSGV1SzArS0pSZ1d2K3RHSEQ2eE56dkMyT3NLSkhBTWtCa1l3enF2?=
 =?utf-8?B?eURoYys3Q212TkJHZkZzVCtHa2NsN2VDb2ZsVlhhdWRIK3QyeXNhU2orRDBv?=
 =?utf-8?B?eEVYRXBwUndUMVliNXJGaFNKd1RBZzcwNkxpTU12YTN0MVZqeU9CNktWNDMz?=
 =?utf-8?B?ejVDS3FXNUxucmZucmUwZEdYSHA3YlVML3Z5dXByelNFVTB1aHcraktGcHVY?=
 =?utf-8?B?akY1MnAreURCSm10QUovd29lcVBtcFlhS0dTa3VvR05GVmRrK1ZUOXlHVjIr?=
 =?utf-8?B?bngwRmpHUHEvWXNqUEhUVFJ5aVRhZUJVZlZ5d0RUVWNheU5QS05aY2NMSVVW?=
 =?utf-8?Q?YGXfnDc3npBlQwwNyO9slTYhh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3ff671-a7b4-4ddf-8479-08dc524e81de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 13:20:32.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCeBkDdRJASQrxm+IDJFEGYMx3jLNTHsCNET7ymVjHy+ekEl7deerjpIJx81VZLuxzcuAXczf0aQOIOCgt0peg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766

From: Peng Fan <peng.fan@nxp.com>

i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
VPUMIX, CAMERA_CSR in CAMERAMIX and etc.

The BLK CTL module is used for various settings of a specific MIX, such
as clock, QoS and etc.

This patch is to add some BLK CTL modules that has clock features.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
new file mode 100644
index 000000000000..2dffc02dcd8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nxp,imx95-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX95 Block Control
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx95-lvds-csr
+          - nxp,imx95-display-csr
+          - nxp,imx95-camera-csr
+          - nxp,imx95-vpu-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See
+      include/dt-bindings/clock/nxp,imx95-clock.h
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - power-domains
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@4c410000 {
+      compatible = "nxp,imx95-vpu-csr", "syscon";
+      reg = <0x4c410000 0x10000>;
+      #clock-cells = <1>;
+      clocks = <&scmi_clk 114>;
+      power-domains = <&scmi_devpd 21>;
+    };
+...

-- 
2.37.1


