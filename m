Return-Path: <linux-kernel+bounces-144937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7E8A4CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE74328561F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489535CDDB;
	Mon, 15 Apr 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ogr+XwR5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09ED5C900;
	Mon, 15 Apr 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178241; cv=fail; b=OHFpCFdzcAX/gCqBT/mv75goPh0E9TFstX9nFGTNiwk/MT9xraSsH/EL6wwvf4pwTg+FYHSYTgJCqGB9KgPAzsUvRtknxtvmpzToUrcrw1CYZKLvJ08r99w04KsM0KCleM2KlGku2OZNXjCRIugrQtr4HnyF3p6g0+UrVGFCTCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178241; c=relaxed/simple;
	bh=U+J6y+7jl6TlckUmz5u5h9laca3pWwmI9CqGvncdL88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8urehiLgxRkvJIhXAYGsEcJtfLOUl3/iCmX4d96vPVWCArO/xNwp+gtTn522AhhSkZqEeBGxhrLpsrY4fzQS08mZPJFt1dV87cbFqh2dcMOr5b5c0QQB2O9aB7piACFGBnrDSreMCHgEAVdM6ug7O6eFhpDUXV9e+5MObc7tHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ogr+XwR5; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHnQxpsP3EnA01y8yD3a8xvBUJ9DmHzjtUhsGHWQ99lgR6D6cyZYlwppRZZ/G7btB+3qmu8h3lq/P1c0vdfxJHySDAkkQ/UseaQudzEYUx9qv2bD9z64AeZmf433WwQUsSISMzQqOugRuAOMCmoC8pBTG82uY8d1qq5EMdmjUBLgfo71zkKQMJVW9OPRUnDq+1GINPFI8cF5P99JRSOHWqW9O0c0tYcnb7hYot0utsTdQ/0cO+s3oA8DEkASKqGDcozAUlVkUDdo79LmzGGTy87SBbPdaNXfFQDuh1lvXfp47R3y8eIvjQ3Wdesxxg2Q6IYxKWzzADxVz5l0O0yW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP6ADPSU3O+zHwfdZg4R+PXEk/FHqyuYmvRjtxC2TRw=;
 b=GCPZK+1GH7I3xs2PePy40s27chjKEirb21PY5LfDTLt0tPBxZUVqLniVL8idNLqpIReLtiq/abZEMcJ42TNymLpMsI2EpN+zWB9RmQ4OASo/z9y9dwx2X7PtRMXyXPp1Lm44C0Q7oFYANJj50FbmtHnsz+1AqDrrCPu12VH9q7Nlg7ODhXcrS8vpYnRnyoGgJMksTdJ9BsjKHnL6qIrvnO+HqX3fWKoZdKXEF7Xc3RCkAy0LzPiqtwu87zpVdlWBREFZQcFZn81ZPYJnmwSYqF7MKjfsYp854g0yxepJK8MJZi4ji/LRmvv7b3SjA3GxTAkbkPOG2U0tSx7MjAaVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP6ADPSU3O+zHwfdZg4R+PXEk/FHqyuYmvRjtxC2TRw=;
 b=ogr+XwR5K2WGFQI/VprVzgWe3h8ETyVEW+7baWqImuGK0s8Xah9GwnFi82imaJ+PHRYTjVa1nCWtXbBpDTLQqpIo2J7U1XHjVF6zW/X46N01VHA21nT2Oy9uZlTj6TgXWIEYp4wE9vKr7JZQdPcY2cRZDtihG/0u8Jk8EuqK9jM=
Received: from DUZPR01CA0263.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::11) by PR3PR06MB7162.eurprd06.prod.outlook.com
 (2603:10a6:102:89::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 10:50:37 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::5a) by DUZPR01CA0263.outlook.office365.com
 (2603:10a6:10:4b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 10:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 10:50:36 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Apr 2024 12:50:34 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: jic23@kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] iio: pressure: dps310: support negative temperature values
Date: Mon, 15 Apr 2024 12:50:27 +0200
Message-Id: <20240415105030.1161770-2-thomas.haemmerle@leica-geosystems.com>
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
X-OriginalArrivalTime: 15 Apr 2024 10:50:34.0225 (UTC) FILETIME=[BE1F8E10:01DA8F22]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|PR3PR06MB7162:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 02db2af0-2196-454a-ea24-08dc5d39e22b
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YeEDdw1iF6BSkCj6kfjbh4OCjIsw3x8EFGTPVw2iQFOY8WksGPxOaIbgsOvMJysKwT2lMDmc+4G3G3N7+nrVEf7dEh3qAmym7BbE43222Z00JwcLfI0RYVUbVg6o6y3anJR/vKQ+Me0GyhLD6EGX/LBuTIb1dClQEjwbnuLjAeomGdcA+np0cjFSwfaLgd+228aT+fqNyJvslZc/9FTSVV/MO8i2iwdObP64g0TRX5ctRCtBnGArbVXOmnOvn3Det2wszLM4x+/qhUSA/+CqnHG5FIEqgxu+wh+vS624z66sUqmmf+fjFD+VPCdiBJlkKMUs+892yiVG0ZP+EO//rSuuA3D1xzTaoOW33AXefuMeUNOZ6fun1tvgLVh2JvWJbBdhLHcxQ21oBom1GBamp9ty6ARKsT1kevf2lb35Prc6rzmZE5yW5UsUY/MpnlbS8mydNoE6xcg1T1PzH0bU+OPUZWl5dbrj+w1A/XokVNmZWxbzexFug6F/GNESrtRZL34c4SjGYz6yxnM1aHZsyxsn0OSM/HmdsaGgFFAd1XgjelPwXH+6SL1lc8nyjajbVZe/8vtJVXGw0UV1wss26alRIyLHCcYdRWqky0IjsmkiubpFmkOcgAv19MYA/3VGKhPob/S9mTrzJuM9sVXxyKZlluh90yYnnl1m30Z6vvJT7xNF4wWT5yyMxKv8CJ4AT6KnD8ImH+HAJRNHsTWbVtI65JeEGGm5pUf7til041ad55liqWtU6XsEFfLF9E3q
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:50:36.7409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02db2af0-2196-454a-ea24-08dc5d39e22b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7162

The current implementation interprets negative values returned from
`dps310_calculate_temp` as error codes.
This has a side effect that when negative temperature values are
calculated, they are interpreted as error.

Fix this by using the return value only for error handling and passing a
pointer for the value.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1ff091b2f764..d0a516d56da4 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -730,7 +730,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_calculate_temp(struct dps310_data *data)
+static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
@@ -746,7 +746,9 @@ static int dps310_calculate_temp(struct dps310_data *data)
 	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
 
 	/* Convert to milliCelsius and scale the temperature */
-	return (int)div_s64(t * 1000LL, kt);
+	*val = (int)div_s64(t * 1000LL, kt);
+
+	return 0;
 }
 
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
@@ -768,11 +770,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_temp(data);
-		if (rc < 0)
+		rc = dps310_calculate_temp(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.34.1


