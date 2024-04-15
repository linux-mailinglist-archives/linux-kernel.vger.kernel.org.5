Return-Path: <linux-kernel+bounces-145084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B28D8A4F56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F92283CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32957173C;
	Mon, 15 Apr 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="qPRl8Z6V"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3916FE3D;
	Mon, 15 Apr 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184947; cv=fail; b=tO4X0kE3/lMEF5Ogf/5frOChjtKMrwPQkatq2OGywTTnNDr9K34WzwOdnAxtk7noXe359OTwA1wgR0aXfrPIvW6vSGNrgm0B0lzjyPL/om8zyewrehck09U9qnjGzjTga1MWmr3iVwQuaX1+/AQIJVlNs4Zwjd/R+mzT2bocMNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184947; c=relaxed/simple;
	bh=5HbvCcdOoi7dkFQrO3IwVvB+jnCiwfdjDKzf9jlte8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IMH2t+My4zj6neu7fOjfSI3yau6kMZPWItFKRxhHgtOWkmdXj7Th4wPHB1d3jTxHPX0iVGyiIjSqNRsIO7dkw63tAvDWm1BnsbuJEO9ttSLcbW5+f45wCYjyXDoQD/n/3UqdI48Za51Y6W03YK+30J7ZXed7vZkVZyhyZANq/GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=qPRl8Z6V; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY2S7ZATfVZJ5ZWuaD2QrhllucXyatFGogKxvXJdJx/RABr5ysoPkSUceWUMIEtGlCsvk0yzrHOKhFu4RXYDpG+Sw905Q+jyPxD1B6lTModB3KgMqFrJ8Be5Q8sjkU5nPx2zO0eRd9+EcMYUcJZXgklOB6fPy60bQbkx1G6tXsVfTlJ5YWMOpFfoZP0sDevuMt0USYJEunbOvpYq5QYVwdr2kIIkQEF8Iio9ghYY1rRcBCWENNmxnF0ZmxsP3LbnHP9PpZN6sN/oZiVjoxZ3EA5IwAHk0LngDKeBY4wq0z7pU/3qlE8SPcG22VIds8RMkzAsxrV1QLX4HTCBnbF13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rcz8Tzq1zwsiZ9BrrQ87txjFMqQCuGDh8bq15P4plg=;
 b=KcJpnpavnUycy/VnFyXYTNBSK+VWnZGG7EEBeGQN0iKno2u3smvPHwC21suKgRty8mhgj972N63BEJ9glv0H6re+fPglymIJs6MPRXRnHiLXqu40PzwZwZPVqF26/Dcjuhm3vouvvuNaJzN2JfmFXxvVSoWk8Ucd+GATG2R51yAjobYPFq2lGPaTTaG0N5nORH5OA1Z+RZ176ru5B3trX2bdIRlpg1RsTQ8bLaHm1FJlhsdwK99MjOnf9DBudtj+U3dE2iEKR9r1u8NZC9GvpYSUjghdmfavMRoCOJJb4mXsI6Qxheo1fBqKPPXi2Krr6cUEh6XaYt2OXqk6e6JfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rcz8Tzq1zwsiZ9BrrQ87txjFMqQCuGDh8bq15P4plg=;
 b=qPRl8Z6VcIijoAAPRIUuZElgtT2dNqjnLsIAN+07fI7cq49KHRNsSK9l5WDZNrS3lhlHOqnZXHX4xENOm7vqAM/JRlcMV8DTFVcOI5loq7XRkHyFzXvtGu6a5IloaTQf9E2Hy6fLMv94/izwtf08iLtiBlVXcWB+d+c+32VEi9I=
Received: from DB7PR03CA0080.eurprd03.prod.outlook.com (2603:10a6:10:72::21)
 by VI1PR06MB9021.eurprd06.prod.outlook.com (2603:10a6:800:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 15 Apr
 2024 12:42:22 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::20) by DB7PR03CA0080.outlook.office365.com
 (2603:10a6:10:72::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 12:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:42:22 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Apr 2024 14:42:21 +0200
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
Date: Mon, 15 Apr 2024 14:42:19 +0200
Message-Id: <20240415124219.604339-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Apr 2024 12:42:21.0758 (UTC) FILETIME=[5C1FDDE0:01DA8F32]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|VI1PR06MB9021:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79486b27-f8a3-4f06-cd08-08dc5d497ede
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmks7pHQfMvY2bnCR1L2zs8dith+3zN66b5kruqS/e0Te5bgT+Bp3NnUpmY2aXs9RWaBpfaLE0PLfOPH2gsweFjs1pdpC9k7OeExsUofrqrmHKtPQaf7D88UYdoQ0icY4VhrV6yv1g1mrWVMx/SrxqIAKSqX7V4D+kIchh4TRChtwm8mulTkg1lRmdffDntVOo3/uwiRMlLdGMrQZKbIstMAKTBriTbPlmS0WTk+L8/Ku5cZQKlfNm3lN8k4SwTIQbwQkmOcz43O3Ir3tEgacRD2NFwBYyKDLwVve6hnprxIJCwn7IQb4gGNhA5zlFhS0uroAAPk6QD9rBE/dqwyY3P7WtqtwFlw2r7ijdEhpjetZ8who2LNK0pO975/jNEOjx3o99Hf+85pP4Ntrisrk2DjhIWf1tF6Yw0MF7kgjx+SQ7KtHCcUYTI1T8Ey8jT6aXopB+hpGJ/yKNjM8nsKVUjoPHkVk81YaxDgNr7gvWhjhibnpvIyW5tJocN511SPsKFEFh3VAY9rcHvB6/O7cXRpQCwRKdn7JOoo7N9ljTAVWXtb6JC04R2TTXSjNstKDeeESh8r5r5VS4ULEgRsH5X91ajfO1wqsO3e/4NOE0NzpWdr3H+9UaTFpvGuhGtbRVU8RL9nMjH6riEqnJsYUot4ncinTKSuVu34dWKOy4xgAA/aDppiNOpgUn/pDXC4tOiV2bQKI6Ngeg3j+tpTm7aZYoFazqQctnbdTDXWk7qaq0rzqy2YwYWJWV++GdZ7
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:42:22.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79486b27-f8a3-4f06-cd08-08dc5d497ede
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB9021

According to 9FGV0241, 9FGV0441 & 9FGV0841 datasheets, the default
value for the clock amplitude is 0.8V, while the driver assumes 0.7V.

Additionally, define constants for default values for both clock
amplitude and spread spectrum and use them.

Fixes: 892e0ddea1aa ("clk: rs9: Add Renesas 9-series PCIe clock generator driver")

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
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


