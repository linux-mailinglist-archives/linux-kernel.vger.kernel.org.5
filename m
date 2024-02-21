Return-Path: <linux-kernel+bounces-74286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52C85D214
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F311C215F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834813D982;
	Wed, 21 Feb 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jPXdRbbH"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08483D579;
	Wed, 21 Feb 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502606; cv=fail; b=pTo3xO0BBNxVfPtztUu76dvEpjGQtwm43cdYwEykU11+HFz+mNjYejVH0Swhmz22v0mrepBpoz7xmzF5WcsgOGoX9q9egsz66hnD2X6ysNFygorfH7oQP+daOBoh43xlOEGqhqoKqfdLMEJ1Rj4dJlhisZBqfigbtpC64pltONU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502606; c=relaxed/simple;
	bh=1rOvfG3CVvw0sQpSUWtVmBbFTH39Wh/LYtTjrBe3UyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L0YruydEvLO1wGRcHft0Dnk4ht61qdYzFBftNrvFfZV5LUBu+z8D+3+a8gCxFVMGJlqFMAxIlGUr4OuO7haSCTbXg52rSL+a82rqlXufKE8MgHmGIwWVE+QrkxC717hdPWIAENxUVV/j8CDsfEwC1NDpn5ph7ryvosEeHIv4FD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jPXdRbbH; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exzMYKUvWU6IAhB1bgqCJBldd+ja82dOxqU80kL3/rqDM6gS719SzhDKFR/F/lOWn9yyEznSNqeDnD9VnSutlhOIczbCaiR3jfWH/Y9pDDmV/MfANJpOKRuX+TrA/ZEqfLGhu1lwjwNxy49pFbpoVjKYllKQZsBkRdVK/td6/rA1fgIAvLZ63CVzwQpH2bgBMA7sE/hWpesEftZQhYv9kPb0PnLfD4/c6YqIaMqw2w4/GdgJQPcqLKU9pnOSiL4WxBKfJ8/fpJEq5ltxDR14Jsxv3GYpavhkZR29lWmrgczcM6WhT72pSdUISPw8ulhx1fQcfGxi6zUMNWWBnedDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxAZWu6W5ALc+lct55lahttCBBz52BPvq60V32g4JA4=;
 b=GnSsvh11CZiDYXO+SNtezQKCutQKHVc3PgJbGxI/XhhlpXjOV2ALiHcNFI+3huypWg2qM1ld4D7wLVKBakzbiKd+8fk5d56AUtHOJEdYZzioahUsfHWPs1e/u1S9b6OXmgDsdJQhpazgI+Ml6rj+o7JD3viCxsEs5QSe5V0tFAu11X/1ThimPgQpXJhxeRdHk2DBQoR1M4LcxMg6CB0TD3zfx9LZmgvLWZHlTrZ7Q1wTa/C+iaXDN/4Tz2TUiCHvkk/sMZVsID9BuxW52V56W8WQM6WnM7YbHQkwFOMigFyvQYqLEHLOhJeL4sCGyB7GQKyuOI0PNPP8OVzcZuNnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxAZWu6W5ALc+lct55lahttCBBz52BPvq60V32g4JA4=;
 b=jPXdRbbHbKOwUc3AE5+n1iNuk+sCTq5wN2zlTQBRLPTdNRZ5KhsNLvznupIPeeu92hTC6aXfmztiE3HycX5xcNyHATegCdFy2+y8axofQWxMj4kZhRXEFNn3kAurCe0oRED449lKRRrq1oQdD++zkI2zfgM3JicNbTjop/+cRxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Wed, 21 Feb
 2024 08:03:22 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:03:22 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v6 9/9] usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
Date: Wed, 21 Feb 2024 16:02:38 +0800
Message-Id: <20240221080238.1615536-9-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221080238.1615536-1-xu.yang_2@nxp.com>
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e72621f-7d2a-44b5-f118-08dc32b3929b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2eQM1p8E1UnTw0jVDfb3l+ScvMcHcCE+5BaErDqJATJ/RLH/lQBwueh+lCQUp+EXU6QJ+AJxtjGdwJO3cX/HTI88vBqerZyx267cCK6hphA6F+jOkMHk87Aff22j4YavN5ikUWlwhGy4X/fjMqWoik1P1d7Y7jyBuiEMiMjZTdvCG5g7yHvghEVFxAUf7s48hLhV5QbNB1+QLfuOS0PGzNT9VRQOCHYkYBwDPs8fMdYMSGxOajLnclqxsnplxukdf4j5OqI6oe1ipHTHCyBkGEICuTdlTDV6AOGlyd3//YEfnspICYV97ltqCNqjYRfG5eDDzLKhhTp7JUni/28QjzxmLVZ8dULLXUnuTKbtdpVOQuHRfJe731/kM1oSXpnmprQqDNqKUWmH5/1Z6m9ZW5s+GALZlXDsVjGa0yLUDW2VH+wV3qP7vLZ+uUiIqeOtcqEhu5AU0zeawKR/welUWe4JETNK12+Y7sbMgOwEqOIsSo2W+BU/O0ce5GlnsrlwU71GkJe0Fbhy7nypYpUm93gQeMwWX3QL/4IoUYvkS0pAlfchE2X9eBeXcojduVoF4N2sxInd/wvksjy3JrPkLn7cdtTYTBSS98tp61N4cAjCLE17DTRtYJ3iI27Ki6ID
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CA63DFkg+xu9RT+iJMVxbAYAmW2YMsjvCRJ0ZfiwX+Ku+FkUzIckFEczSbAt?=
 =?us-ascii?Q?EhpjOPvMI7sImwtkGCih4JijlKmbC/AA/wB9vo5GqJ7eAv/yqKNmJDztetBe?=
 =?us-ascii?Q?aDe/GigWtggnpE7xpBW7/GmvWS/PkLQzdYU5VJiy/TJIh3BMwcRG4e6Oi8ZP?=
 =?us-ascii?Q?UnDQgInZ1LtTJcJ2cNWIdV5e/U0EXkdheVmjaUTPEbj+0juVtwoQ9i3KfXxx?=
 =?us-ascii?Q?wA6I0fvbZwuWR1X98D1teIQqladgvJLDuQ/dCVe6+ixBw5hQkwRwFbBshNuE?=
 =?us-ascii?Q?w9GkAiYaT0DGsG0xHl+rROHj4dVqzPG/ndpsKi5iylyLjHIZP2Tw88F4PWaN?=
 =?us-ascii?Q?9viDSvZO6ZgdW/Xjutig+E1v6+3aUmMg4VmpWOrf4C/Wrd4uSyt9Ub6v5OSf?=
 =?us-ascii?Q?v6YojK4mpIv694sZOggSU/RcDBpSQ0XAuoQLffM7lL8CWmo7bU8DEHeq1/bI?=
 =?us-ascii?Q?v50dGNgTzOwrpk6iOkP7Jkw/NstLqZBoImTKtn3wUsM6xVLCss/S9Vg9lniz?=
 =?us-ascii?Q?DJJgahyttw83VtDPOP+B0mBGXVaRMIFWBxsweb1FQ8ls5irJqRcGMNxrRl5s?=
 =?us-ascii?Q?TaUISzTO48nD9m0V0OI3HeEh+nNZaJZ6Ce5ChMjZLE0drQzIhqVCSCx0lUqR?=
 =?us-ascii?Q?AD+Y00qv6H9r5v4vgsLHdiPhvyTQ88M81/EJ5/OtIxHRxCqikajbNjJyqj0x?=
 =?us-ascii?Q?gaTsWRDI3iTvLdTaPpoPubJQ5HpUsNGoBlM3fbidFjfrG21C1ZYNiva7i+R7?=
 =?us-ascii?Q?aPzHdyuHP7ie4CH5pzDkkYy2Enud9WBxIR8xjmeeGprA0wM8VjtVtlUji56G?=
 =?us-ascii?Q?HkDF2jhhL9kyVonu4nM243Gqp2I9TSWuFfOzKslrzA2wxUBSX9+BvyuBYhC3?=
 =?us-ascii?Q?M866l6uznZerq2N1azxhr4rMfRd6cCBkqaGGKelDoMi+tYS5BiKSOFjpv/qv?=
 =?us-ascii?Q?l9OgaocP9HyxWkSwYWFo3930g9GBTpWCiUJhguhtk/HnsuDCbpednePM8Tnf?=
 =?us-ascii?Q?7KmKvpf0RTuY3qQ1SbntX8IfZtZpGiVtwVNwXIL1nHhC/DZHPs1tG/I5L2n+?=
 =?us-ascii?Q?t2WNDm5GCUtca1lomycOZoLD61r37SRaNS8SgbbKdQKXPg0jUhtnbKF9P/Hg?=
 =?us-ascii?Q?iLYCD47lyJAIxaokeifAsF2otKKxL+vdDQtiw/LhD0lLKItlRZ0MLK7sIHqt?=
 =?us-ascii?Q?kStn1v1GnpGDyZMtgZsDzsd/JVtezXSq+6vzCH9g+i6aXLKJIMgXIeEqPbw3?=
 =?us-ascii?Q?8eW+VCP/ar8ycBQbvVCEVMzvL3moxu0s4cgCJLBzt9yR7je0vE1FLISgpIyl?=
 =?us-ascii?Q?mjc7/km9v9wbO0tZqxVyKGmd/d5vsmnBk9KikAYqZJtUmRrwiXIwE5eB03oY?=
 =?us-ascii?Q?QRYhZ5lCg+aI/C0qQXfouwVN+npvlEq/sRHh+D1tvT6Law4//hKTR8hUeCJy?=
 =?us-ascii?Q?FeZpjsM2fV6+a/jU4ga8cC5vefOTWlNdjXHyoOtLfZTK34CKsZCehfQt9AwD?=
 =?us-ascii?Q?r7Rwl9GX6FQdxfzf9hHOMu1QcfVhOQ7a+BCMZxjz3Q/mJqW9rR0pZeisSYfH?=
 =?us-ascii?Q?G0THrqnSwS6HNs/gKIo/yrfP17HV7hHQT7cuag1a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e72621f-7d2a-44b5-f118-08dc32b3929b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:03:22.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9uncaHSosn3SaIg0XldRGJ3pLlVZWwZ4uDiwrncnYx9yzpzdrBd2Fk2LneV59bEIfzXFl2e6KlifI2mIq6fww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

The dt-bindings is going to use "usb_wakeup" as wakup clock name. This will
align the change with dt-bindings.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - add Acked-by tag
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index ae9a6a17ec6e..a17b6d619305 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -212,7 +212,7 @@ static int imx_get_clks(struct device *dev)
 		/* Get wakeup clock. Not all of the platforms need to
 		 * handle this clock. So make it optional.
 		 */
-		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup_clk");
+		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup");
 		if (IS_ERR(data->clk_wakeup))
 			ret = dev_err_probe(dev, PTR_ERR(data->clk_wakeup),
 					"Failed to get wakeup clk\n");
-- 
2.34.1


