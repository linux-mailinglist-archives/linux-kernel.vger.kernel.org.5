Return-Path: <linux-kernel+bounces-144939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982D08A4CED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ECE1C22252
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A455D8F6;
	Mon, 15 Apr 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="EUoFiyFl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D345C919;
	Mon, 15 Apr 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178243; cv=fail; b=r77Awnv8OYbgSTKHF7GJJ8D4ZdzpnES3KfMoLK1iuIgSFM3VDAgOr5NJva3ufqTHoZnFEs+UCXBp7eijNteQUVWcwa5kejljh2ttP92FgtoeaPAKpjQVXJFtUDucm8qYQXoX7VDALB/7IcPfVw8jW7ghl1Nye9aLwnXURRfWWbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178243; c=relaxed/simple;
	bh=nLX1To4bTiAj3irPsvV86JRP4raH4RiZ4W07HOb3sJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THPrYrPyQ/Bi40NIr97JPXsk/Gqb4rSmXS2cQSm6LPQfLEA5XSN5UgQmf+RByJfObsH3DHK/pzNKv6zk0bo2BU0gwAMrYuchQsElMjKylfU34W6kRmTop++6NHwbuqA3G7GXTREsJVNHTdxONuXZELZP5a/80S18Y4DvuIapE4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=EUoFiyFl; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYgwLdH/emMb4Og4YSpirHMta4cbV733xmW+i19MAR3lr0XT2HAWxM48dDMYU9UwGMI7FA3tLbp42erlClejqYiZ7moo8a783oO9kx8y00zX8E4rMA6ax34H59KY0Ok40HTQ8813R3vBlJA41RwwP4VDddYOCISzdBI8fMIp0qEcrhy+7mIgd419iLjFx3BWacT2BVMloa0fHcUyY/pDDvSGPZq0kMB28XxQxcenzDlvdwKeFRo9Nx0hPPzEVQoHghAplE9/r4cD42Xp7J4TyX6g6saPEPGCcDzfhHdNDiYo+EcRKBkvs9Bn7Q75wXIbq1ibndX+Tb+Pha01txMOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkajLhmjkzHPSpZXj7DXb86D2ZcCwjCKYUCJycdRkj0=;
 b=ilBBtkzkuR+zyo0aQCmL1HxsfL7aHoslPNfFcaJFh3SwUlgR4cA2bfPkk+uvs0pGm7mWPhLEHwnFXhW/tX2f5AiUGCdmEboFBuPN15pqaXNKk1PWEtlZf9Gpp8T4A/Vae5eD4Qlq3fkhQpN7S7KfgUyQmlz7Yep8RE+FefWAE37kI3NCqDUIPOpAhuslgaki7I2gzronYFDbw+kRKzibp1GjXdCk4b92SFutogS60+M0E/d//n52Fc+wyvDHgk1wEF8viUnibyvmkK5z9o6IXknnaeLwFdhg9bX0jwHls3cqnFLYnr9Y4mcb5r3NpUXLtrqf/3UesKDDsBch3TKPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkajLhmjkzHPSpZXj7DXb86D2ZcCwjCKYUCJycdRkj0=;
 b=EUoFiyFlfXUKEL2KgTXTPrx0YmEUVM5ykYAkxP964ju0q8BGFIJDISfjQzYnuplpVRddef/uYcPfSWdixn31KJtZny8tyvrVVdkoymKsOZUypP5W+QEdHVzdQJzXD/B6YnF43rkJVji+595wYWd+Pndy140fGQPlV6UMuRnJU5I=
Received: from AS4P192CA0029.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::14)
 by DUZPR06MB8848.eurprd06.prod.outlook.com (2603:10a6:10:4d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Mon, 15 Apr
 2024 10:50:39 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::e7) by AS4P192CA0029.outlook.office365.com
 (2603:10a6:20b:5e1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 10:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 10:50:38 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Apr 2024 12:50:38 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: jic23@kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] iio: pressure: dps310: simplify scale factor reading
Date: Mon, 15 Apr 2024 12:50:30 +0200
Message-Id: <20240415105030.1161770-5-thomas.haemmerle@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415105030.1161770-1-thomas.haemmerle@leica-geosystems.com>
References: <20240415105030.1161770-1-thomas.haemmerle@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Apr 2024 10:50:38.0756 (UTC) FILETIME=[C0D2EE40:01DA8F22]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|DUZPR06MB8848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22116911-ff0d-45c4-7058-08dc5d39e378
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DDUoHxCG92fraNbwzyY+FJOxBLMaziCO7DW4L/6zVheonZi/H1jiOipIEHTg6cI+U0nhwVwU5JcMFprypEHgNqpSYYPiBho5Z2ZZ47iWTWvedZANVfumWprwof0IFmgFFQbuwVdmdqhnqwnMQAoL0QkQf6u+5M1IuJtcXmxOYk8u1yGYbSKdYFtOV1IjnGfbGcydA0CmbSCKXFziX/O03j2/iUhUure6KaF+qr9n9nXU7s2MMeVbN37vjsNXvt+IUTRCY5iyJgDIYnRolNzY8K7lyyerz5YLDm0M2BHr2PIyWxawoMRXrN4hyF5W1hWdoVlykLGJEAEmRcNIuW+n5adFWivSytF9a9Sw7Hix3pxfxddAow7LmUTIglbbQM/EisoVX4Ke4HnGnLfXSzt65hCA087csjsVWxaMNJ//WnElzLqittYsi+42Hxkz0GUHEcjfqSGa9I06OJ5ZyVgvFCvtK9cADL5Z3UY9lv73aSXwpcyI2DIMw3TCw6LGUX1KwiOBtXI0Hr3UNgYQ8Hifii9seUQgE3Tx+ak7h/nN8WG+VwN8swp1fFMLlIIrU+SdotgbcY12Kevj9ORhJBaYUagbD2Hc+ymIZAvs/odmP7iHnZPozh97MOBzq8OSF1NkIea1NIqbCq8lB1RQW26xOfN1aPaor7B5hT8upM4dBd0MdgS/840+w4SSt5uUawhwx9VOLZfVTDblVac6lKGb69mu8Qqk+//8zFrHQU0Bhxaz9jt9/C3YglsTix+hg2XR
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:50:38.9826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22116911-ff0d-45c4-7058-08dc5d39e378
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8848

Both functions `dps310_get_pres_precision` and
`dps310_get_temp_precision` provide the oversampling rate by calling the
`BIT()` macro. However, to look up the corresponding scale factor, we
need the register value itself. Currently, this is achieved by undoing
the calculation of the oversampling rate with `ilog2()`.

Simplify the two functions for getting the scale factor and directly
use the register content for the lookup.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c30623d96f0e..7d882e15e556 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -382,11 +382,11 @@ static int dps310_get_pres_k(struct dps310_data *data, int *val)
 {
 	int reg_val, rc;
 
-	rc = dps310_get_pres_precision(data, &reg_val);
-	if (rc)
+	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
+	if (rc < 0)
 		return rc;
 
-	*val = scale_factors[ilog2(reg_val)];
+	*val = scale_factors[reg_val & GENMASK(2, 0)];
 
 	return 0;
 }
@@ -395,11 +395,11 @@ static int dps310_get_temp_k(struct dps310_data *data, int *val)
 {
 	int reg_val, rc;
 
-	rc = dps310_get_temp_precision(data, &reg_val);
-	if (rc)
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
+	if (rc < 0)
 		return rc;
 
-	*val = scale_factors[ilog2(reg_val)];
+	*val = scale_factors[reg_val & GENMASK(2, 0)];
 
 	return 0;
 }
-- 
2.34.1


