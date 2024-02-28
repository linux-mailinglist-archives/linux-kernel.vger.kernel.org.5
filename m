Return-Path: <linux-kernel+bounces-84504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77386A794
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093AE1F22295
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D3208B9;
	Wed, 28 Feb 2024 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dsKPkKbD"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FB320DC4;
	Wed, 28 Feb 2024 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094179; cv=fail; b=AY0sOTDHJ7ftbztiArWKkziTywyViqnO1YEBpfDgk1VEuJ/HeUnIFBvmA9zw13xDFTUt+lQ7bfluV47eNY7rHUcjHk61Ekisj7WfsWPUkVqkn8O7dijUm1pkj0pM47RwOg/Zq6HnqcjIU4ljCL+0f60tYwrQ7nIekA3kzxVLrh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094179; c=relaxed/simple;
	bh=5DOsik1wDRbUZ7qMAaqfB502N0prxXrOIeMzu6qFcUk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=m6ipz36GocS+WDzSGfyG1lMkWF+qpR5iueppwcrebFEI5cex/8LYad+3vxJTuzBVg+V2xh2UJTjQbBmBmxnMOby587WJ+bK0JhqPyyECZj+VAiIq7YE9zCUjtVL5CZw9hT9so3N8vFNw9oKYypD9EVBmiHX4Yz8FLwcc/sQo3DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dsKPkKbD; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYYgERNyI8VfwoVFEbW76B4W1rraVEkfd9Z5VbK405VpYfgZ1MZRQOQnZ4TC//tJhH6+PmFiH2F+5B9Z88aFbr1mLhJFG8W/QbN3zdsH7mtnkRp2whe4Xd01vp80qhStepVW6SqAYeXt40Fb1321U76+f3JVteIZyT5q4ds2fDwbzDa6TSy5h+roplhENPl5YSpiwDSIi85aTY4pKAUzAj8KtQNXI0KaF/DBiCNx1aIiGoG8E/4qlwJ+crd8WekHdyR6gbCXZUfO0mZ7vq5rqQiG4UvW6PITJFKhd0mUPYiR8FKe/iVTig3mMw4YFliLToWnord2GVv/FoCjClY77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wwrfX1IwlIguc4Y7oDZbd6tQ+UpejCFrdOPjNDdyLA=;
 b=gDIMkCNpVVgQv1l7iMo30UD8YiTQmSRx8QgAYzd5twY93sCQ3A4XaDgJKs4BHXhGqnhIXZXKigO8PwF9euTxdPBiLwtx13V9DUl3h4mC7ac71d2P8hVzzeXIm+FPt47AtpG7ucryanvkdCFQ9bQAhDKubaVjwvf2WsxarnILpnOsEPAIrHs6fhoLmQW2P0ZlWk/8AMeCeQlAi8C8o9iEf9mHyBn1DG+eBHcOVCRyiQSDcBCaGt0BULIVEZspDRTuZZH7zJEp02SAqIZF1WyN24r/aCET1HGf8xpowB3SyfBhjZCHXOyoP6pdjZR6ovDwyp+D/AlI+jp5wrXXXGl5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wwrfX1IwlIguc4Y7oDZbd6tQ+UpejCFrdOPjNDdyLA=;
 b=dsKPkKbDT9ssbU/N2JumQk+ch/Tt7WBQ+ZZP8KKHD79+F7RWfrjMl/Q1dkTld8RkLNfUz9BCZZkD48tuxmaXw3c+N8wUgDaw3RLgCfi9kCqq5zZMeS4omcrx5Mrn3eyoNMaWSvMOT7drpWnbLGhqtRwgHvDd0mutyVT1rmLNS10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 04:22:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 04:22:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] Add support i.MX95 BLK CTL module clock features
Date: Wed, 28 Feb 2024 12:31:03 +0800
Message-Id: <20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAi33mUC/x3MSwqAMAwA0atI1gY0VGi9irjQmGrwSysiiHe3u
 HyLmQeiBJUIdfZAkEuj7ltCmWfAU7eNgjokAxVkCiKLut6uwn6Zkc8FnXjLpWfDRJCaI4jX+/8
 17ft+IHetvF8AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709094675; l=894;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5DOsik1wDRbUZ7qMAaqfB502N0prxXrOIeMzu6qFcUk=;
 b=yAdhmTpxaXts5muPn73G/n3IgPNr0rpw1QuZX2h5L3KndURuniYeEwHga5SB1UO0i7WPT54aw
 lD5pZPgDKu8D8qVsDH92/LHEfkFTSchb+Uo7lYuV5dZkeuF9FoUmzbd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 210faa37-3d49-4efb-1390-08dc3814ee27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iX4D+p24FlUTbMasvIUX0NWYDqzDc/Wccjm7vgQ7i1CbI8JAXqBHKdag/1hFrZQzuIh7SiKSQCMRPi+Dai2Ape4yV7gr6h9Ck+CuuMa11wlOW0L3jfjVAqqAsN1BkPnk94HlRQX4jV/qAcmjLeCCBYYoA/0JLkPYJbFzZopQ/cqzHA1Souvj/aRJonwhWeUezV9c4The1KVpWTfKTup82KqujLZlwC/oasUYC7Ca2nFVCkrMxm9BPZA05m+zq+LZPh6Js5LZKuVLo9CuAvg47VV1QCobw1F4CU3odJpg2tQ4x7qz0JjC1j/VnyVAwiW8SE0o2jWLOEj/MC1oaBEcp3+ThT0o8uQtQrDUi2SCmKluFaEY1U9ydsxdKD82eaF5ejmB0V04NJrCvZZ2rZWOa49SQZZ5bj8VoGJjzA+3jUoSfs907op2weOy0aENjBD1p+CCGeIiboB8ijWML3Ccr/1ZR33zYvMJQBPcD7g3WCy7nP+FRBuz4KJY1UlhieFY1gOMWTQR5Kc416LVF2dIiwgOUGo+ktwyPYrIcZN8NgxRK/0GW/FEuLFgEQsjFNQGNYINrJmiUpkru2SkNuYSdIGWULcGioS+oTIWhPrBl7XBeQvF57IDR5NuiQRDetiy50iGTYGoTFYqNcaSk4FkWWYhgbeTQFohF5pqZQ7WOhRWKVIJatuqkXBd0ArHKjXqtnnVh5nfsfzWQSH6owdgHIDot2BI/rA0+dGpeXgbhVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJMSE9XaDFBQ1YzajMzbXJKZ1dvTGpyYTNLWnBzcnIzQjRWekJnUmJneGQw?=
 =?utf-8?B?elNYd1VySGRrUmFlZ09uS0VNanVtVHlkN2hmYWVqSW5PWWZlNkhJbWY2L0U5?=
 =?utf-8?B?L1FkTWl3cEkzUWRJZW9LQ2kreXR1UEQrc2lqWFJ0WEJDUUl2aDByMWZYVlZK?=
 =?utf-8?B?Mk5hMGQ3UUNBYWsybXlMNzVvcGdIR29mZzFzWHlvRjArY0Z4T29lRnRpRzVL?=
 =?utf-8?B?dG5ENWRzVEg2TFI5TmtPN3hDSzFYUEdOY0p1U2xTVTVxNWJKaG41Uy8zcExB?=
 =?utf-8?B?NXFZenFQVDl3YUUvQXFRQXowTjZIdUR6ald2ZjFUM0hpczE1UkxrcUsyTkxw?=
 =?utf-8?B?S0ErNnJtTHZZUkwwcXZqNm5FRXQ0ellTRitkMGJUTEJKazBLRGgxbVd6R200?=
 =?utf-8?B?QzljTTFXcnpBWVVZMW52dE9ZcVJNZFVBVEdObGpIcmx2WXVORzV4Zmt5N0VL?=
 =?utf-8?B?em1vOXY2N0N5WHpORUs4N1BEc2RTc3V0b2FLTFQ5blVMQlJZcGVmRUNHeTlz?=
 =?utf-8?B?Q2J1NW1WaFE4NkFMTWtXT3hHelJKMEQvUWtJYXhERlFDcDgwbHZIcmZ5VUtR?=
 =?utf-8?B?d1ovc1Y2YnE0bkMvQW8yR0liWCtiYUFEVmxHVm5VcjNWOGJQTTBJTHlRNElR?=
 =?utf-8?B?NEJkS0RtVTYzb1hqaUVMM2tRMkxRVXZRYlBURXE3TmpPd0JqVUtvT3djcTNr?=
 =?utf-8?B?bkV4RmZ3VDFtSFVucktGOEwzcCs4MGRrQXpFSUMxdzJiWGp5Vms5VG52eXlu?=
 =?utf-8?B?NzlVOWtDaHE0OUtUbFJ2OFJVRldWTFF6MzFaMVNvL3l3eWNXNzJtdStVeWFL?=
 =?utf-8?B?K1FKQ2c3b3NBdVVDRmVCVVM3S2tkZWNONUJRb1ZONktrQmxoN3VIVmcrNjRK?=
 =?utf-8?B?WHB3WDROK0xCTjA2cC9PQUcyclJDUGJzOFpLcWlacUJPNC8zNUcrNzNnTzFw?=
 =?utf-8?B?ZXZ4RmliWlF0NC9zd1h4N2VrK1NVbktiUlV1dVVKTFlxM09rNEVncWRTZzVG?=
 =?utf-8?B?WlBsaFhkUDMrMWVBSzJnWWJ1RTBBNkFsdk9tS2g3dUFQdlpiaWZ0VjNXV1hp?=
 =?utf-8?B?Y0RzYkpTeXdvVlFhTzBnVW5SWGc4RWc2UUpKSTJEMzZtMk92TkQxWlhobllK?=
 =?utf-8?B?ell1Z0d2WmtxY1VaR0ZaVlE4blp1L09NbnhPZnV3RzRobmhFV0RmWXl0MjlJ?=
 =?utf-8?B?QUkwdi9laEVGZkdyanE1cmZ4WWFXSUxxcThZYnQxUHhLNXZkK3hmUG1QODBJ?=
 =?utf-8?B?M1FqVStybHkxNC96cUhVQzB3MmlmUXkwa3pQeng1RVNVeHFZVmlNK0lHZTFN?=
 =?utf-8?B?WnN2YzJHemVXOVYvcXE4Z1dFNHc3WktRZWhxMGRpVXFxWG8wMDRTWjZiVkZz?=
 =?utf-8?B?ZVFKdWozcEl5SDhnZTkwanpKWlRNZmtYc000VlpZZWdYTUlwQTB5MGpXMUFs?=
 =?utf-8?B?YXhscHNsdkZHRlNhdzNKNURqbnpHWEU5WUZwc1h4ZEJaRkFHbjVKdTJSR1p0?=
 =?utf-8?B?K2ErNmovWlFndUc5bmt2dW45aEpGNGM4TkhHYXZtMW1Ea3N3K0RiejlxbFpS?=
 =?utf-8?B?VVppbk94eXFkemhiZzRITzlNd1VKQ3kyVHdQVm5EcUhDNXFMWkFHVEdGaXQ3?=
 =?utf-8?B?b0xhOEF5OWVmVXlDS0dKaXlNZUhMQXF4bEYvdm40UHNWZHJMdkx4elZTcW1J?=
 =?utf-8?B?d05NV1cvV3NPemFTUnJiT2F3QTZETGZWY1dpR2pObHlUaTdsMERSckRFbTk3?=
 =?utf-8?B?Rk5rVlBTWGZnTDJnRlRBVkhacFNiQlk1d3U5d1VjcjlUZUxFTE40RjhQdGda?=
 =?utf-8?B?VlprcmQ4UGgwS2plYWo4cE4xMkw1TGliMWpzQ0M3T3daaERNblFYbUtCc3JN?=
 =?utf-8?B?TjZ6REpXdlhiSkNHTWtuNGMwTHVzZXo5NjVwazArSWNWYldBNVp0dXcxalJ4?=
 =?utf-8?B?TStUeFNGSEVibTl1dXVlaEJROGNyeDJXSnRwc0w1eFNud0sremViNHRDMTYr?=
 =?utf-8?B?Q1VPeDdTVTM4bFBlWU10SzZ0MWVlZUZiNEJwcHRyTXJGNUYrY29qMHVES0dI?=
 =?utf-8?B?NzdFenNKTTkxNU4yUjZ5S0N2cFNOVlcrd1FtVlZzMmNkcGl3RXVqV25GK3NX?=
 =?utf-8?Q?V+qt2nrTXwNIuGRbHXrqz0Iuk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210faa37-3d49-4efb-1390-08dc3814ee27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:22:52.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n0FV353dLrsl2GI4YGZ8AMzALwpB47ySXW1bKVbeiW2U7ymJt8tUTWLPPdVAZP0Ma0z6UjAXGAObVOEyYO4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

i.MX95's several MIXes has BLK CTL module which could be used for
clk settings, QoS settings, Misc settings for a MIX. This patchset
is to add the clk feature support, including dt-bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      dt-bindindgs: clock: support NXP i.MX95 BLK CTL module
      clk: imx: add i.MX95 BLK CTL clk driver

 .../devicetree/bindings/clock/imx95-blk-ctl.yaml   |  61 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
 5 files changed, 539 insertions(+)
---
base-commit: 22ba90670a51a18c6b36d285fddf92b9887c0bc3
change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


