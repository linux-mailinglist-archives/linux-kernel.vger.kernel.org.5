Return-Path: <linux-kernel+bounces-145318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0D8A52A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8817EB23E16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F34745C2;
	Mon, 15 Apr 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="BpUtNbOd"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108474419;
	Mon, 15 Apr 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189838; cv=fail; b=ENxy+YI3t30vnIbVoE+UcZAtqf4F0bU83ppKnGrjF132mVeRhaHzOwoC9aKjMc2cwdOhL3hWnfFOhqxf/uv2dwwyFHkU7xYuAkxkh25Fn+PuTF77V8ylSF3U813tpPr29bRFmUEKRF0tTCAB2wlkPMngw3xeD2Vm8ByGjoFvE30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189838; c=relaxed/simple;
	bh=ERPh+2UpeqEw2s12TqjQunx1e/KhdmNEjrkFNQG0SvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uZEECtvIC7Y2VoGJbFGr1HSZYJV2kuWRX3NMLs7+YmkHvRvF4dKUmrkOyoT8sB8tDs006QDTms8roDZZw87XYWDlQtX5QQlvl73zG3ciEj509EuNB7WQqNGTT7LzZGgyEny2gvhwHCT9Z3OwEtaanB9qxBipfgv5xo7aCdAQbaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=BpUtNbOd; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N13zNJAz1/B4hrcTCRXX5Q9kTo8B50j9U40Z5W52jENm7EUU/qCylxjkEd+RYxA/4AI4OFYvZcJy79HrT2A1hH/9eJJ3IA7/4JgaopYy1ywsoRZ8ObjMmY9UyYrGGPVcpNdw4GfujvP+l/XownaE0TlfM8wjZhK/a5YvNqn1TjG1MgGdZaow+I3fkkj25qTCqJsDbaihOnAzmwNBi3E9VJfhLV450t9Zw17tnpwpgv5coNrkVKbjzz0tj4xitnNDSigPnFdpEMu0lL1Rzvpa0IOLC8wQQNyF+xm77eNcpOyNHeDbUUKTbu0hMkUYH7IO46KBoHkRXo3pHNRAtEmYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3altQvcuH74wLvD7UssQMWjCCULLwAF+nIE/HR9KDNU=;
 b=S7TkDf3uExHK/G0+DAnQVNnBeyCLhEG7mJMQd3N9GEGh3JO2KycAwx1MOwlZLe43Mue4n9w9lgaTjIJaXP58NtHDVB/ZsT5gcE1ey637YRnf8LBKMOVQavEYpgQXhFvLmjXifCa/4Sk5ItUCcQrwRuYM4oQPnVKKzfzhy3/wwDnUk57t6+X6TjC4BtfBBkskpXeDykAqK7bRcT7fga/I0qMkA/f6so1pXPPrVcabkvRtKSQStjlqvqj2wnQWzA9lPy/VzTtyJwyM/rBYjMNo/8+p+dOmE1Uj2AaOXJglkcGovuQ2feZVODuU2fimMbrFsT/fEJBzu0Rn/lnhQRHbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3altQvcuH74wLvD7UssQMWjCCULLwAF+nIE/HR9KDNU=;
 b=BpUtNbOdrxdSQE7+CVZIVVjS+rwFmqsWLDIb7Z6OJ7GaqCxcN1m/lvz/jMwg3u7mYex7vyK2RCKYSL/WeruaLrY/eBdOHbrNts02Q4vK4w/gqyE65rRcvzlmYGiz5sgQ5heF3C0wuHaRG99o8Wve80e0TRKMdOq1f7CFh/G+SXk=
Received: from AS4P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::10)
 by AS8PR06MB7557.eurprd06.prod.outlook.com (2603:10a6:20b:337::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 14:03:50 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::cf) by AS4P250CA0009.outlook.office365.com
 (2603:10a6:20b:5df::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30 via Frontend
 Transport; Mon, 15 Apr 2024 14:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 14:03:50 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Apr 2024 16:03:50 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: marex@denx.de,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	biju.das.jz@bp.renesas.com,
	marek.vasut+renesas@mailbox.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH] clk: rs9: fix wrong default value for clock amplitude
Date: Mon, 15 Apr 2024 16:03:48 +0200
Message-Id: <20240415140348.2887619-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Apr 2024 14:03:50.0057 (UTC) FILETIME=[BDC71990:01DA8F3D]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|AS8PR06MB7557:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec1677b6-ca6c-481b-80c2-08dc5d54e083
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G6ZLKknsNybUN8yThUdKcdWaTPGfq450Mrir06e5w85M3CDOAspDnk4Saxjnew3P1t0Sph+Xb8TMykXnFbtWa5rx/EJcrFooD58n/Q7aaZEhzfjR/Ge9lrXWu8U+EFcK8GJPdcWgd8OmaPumB9Cvb4w1PvzaGcBM9017BcKbpOO6XNjy/0rEMeqaa442lG8qTRw4Tdwi6X5Spsf64Y9Ozj8ir5f7xC3ktEx9ASYIVBFSmyFlhD5+ZTA6IjLXUF+lefx/49qtZkDObUyeMyx4v4bHw0DR+LBApTE7XW3UaghrXoyE+7wCtj3xDzSDsLBKapege5v3RPcqv0T3rGtSytJDJ9+LSC9GI/vBU7/K/ADOBPcA9EhzNZ1fpR6Ha70fqDi1WONy+Wnn40w32mQK/0x9adIcJZhFZ7KPP5g4y4ofgmGyi1Y7bqw1XPh2VcmJ3yd+3zdXgQceMB3KVeDnVtscBE4ygtO3FqVvn5a8b36j5SLvv+8D9DMBKTVGdEQMjRDZuTtaJ6vfG83HLgQySdzttgf5Sxsh+0/whR0+cCZC0bUkOJiFRUG5jC5iy1ZFrJsYRLSBYi/jeErcrsLN+Aki4RmI4A9VMQzVjEPJzt6obZhK4WAdq67A3KWpR2dXPVzCY0OoCUL6XR3dK/sLG3nUXxbrzwAvmK3CrNq0lPH1+gw7XDDU5ymcmYlm+mpiCRMge+KnCn02YJ534QmKVMuuFeME0iuzkbHhoBspOta9k7Fzc8SQ1sXPrm/bFBSd
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:03:50.4180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1677b6-ca6c-481b-80c2-08dc5d54e083
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7557

According to 9FGV0241, 9FGV0441 & 9FGV0841 datasheets, the default
value for the clock amplitude is 0.8V, while the driver assumes 0.7V.

Additionally, define constants for default values for both clock
amplitude and spread spectrum and use them.

Fixes: 892e0ddea1aa ("clk: rs9: Add Renesas 9-series PCIe clock generator driver")

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes in v3:
 - add reviewed-by tag

Changes in v2:
 - update commit message with "9FGV0841", document change about spread
   spectrum and add Fixes tag.
---
 drivers/clk/clk-renesas-pcie.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 53e21ac302e6..4c3a5e4eb77a 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -25,10 +25,12 @@
 #define RS9_REG_SS_AMP_0V7			0x1
 #define RS9_REG_SS_AMP_0V8			0x2
 #define RS9_REG_SS_AMP_0V9			0x3
+#define RS9_REG_SS_AMP_DEFAULT			RS9_REG_SS_AMP_0V8
 #define RS9_REG_SS_AMP_MASK			0x3
 #define RS9_REG_SS_SSC_100			0
 #define RS9_REG_SS_SSC_M025			(1 << 3)
 #define RS9_REG_SS_SSC_M050			(3 << 3)
+#define RS9_REG_SS_SSC_DEFAULT			RS9_REG_SS_SSC_100
 #define RS9_REG_SS_SSC_MASK			(3 << 3)
 #define RS9_REG_SS_SSC_LOCK			BIT(5)
 #define RS9_REG_SR				0x2
@@ -205,8 +207,8 @@ static int rs9_get_common_config(struct rs9_driver_data *rs9)
 	int ret;
 
 	/* Set defaults */
-	rs9->pll_amplitude = RS9_REG_SS_AMP_0V7;
-	rs9->pll_ssc = RS9_REG_SS_SSC_100;
+	rs9->pll_amplitude = RS9_REG_SS_AMP_DEFAULT;
+	rs9->pll_ssc = RS9_REG_SS_SSC_DEFAULT;
 
 	/* Output clock amplitude */
 	ret = of_property_read_u32(np, "renesas,out-amplitude-microvolt",
@@ -247,13 +249,13 @@ static void rs9_update_config(struct rs9_driver_data *rs9)
 	int i;
 
 	/* If amplitude is non-default, update it. */
-	if (rs9->pll_amplitude != RS9_REG_SS_AMP_0V7) {
+	if (rs9->pll_amplitude != RS9_REG_SS_AMP_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_AMP_MASK,
 				   rs9->pll_amplitude);
 	}
 
 	/* If SSC is non-default, update it. */
-	if (rs9->pll_ssc != RS9_REG_SS_SSC_100) {
+	if (rs9->pll_ssc != RS9_REG_SS_SSC_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_SSC_MASK,
 				   rs9->pll_ssc);
 	}

base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


