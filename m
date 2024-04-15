Return-Path: <linux-kernel+bounces-144938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EE8A4CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8691B214B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D05D73C;
	Mon, 15 Apr 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="auFN+FrP"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9E5C903;
	Mon, 15 Apr 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178243; cv=fail; b=EUMZQH8N02ZbjG5OuuHUSeBLWO4ugZckql5VDy1rK7cYxlM/rVtTviOkdUanx22HcvU2meaO/tvSGcHcLTGLmok4M1iSdfIQiERamU6PMYnVMTEpBpzyKiFy2tAVkVePmS3p/lpcohCXJt5l5Daj8EVEZNSenu2chLYx7LPb7og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178243; c=relaxed/simple;
	bh=3woaJPcBjqzYQjsTrASaiCvuS7IpGiPAzebHmq0bTW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRakp7F9cfbsQfXbz7ANCTrRRU6EEaAp6BvR6xgGpGfLCxL6Lm63gC5gdxIiJoxkDii0bcfpyUuhRICcMXs8k3R++kNzBXXrudOcPRjsxZA6ri72+9Oc4u9KqDczPlp1R19Ej6GN+aIUuRb/cu7fD4JDEse7USTg93qCsTzKZDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=auFN+FrP; arc=fail smtp.client-ip=40.107.6.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRPK2ub0NxMOLhzpcSQ6xEwAk8L+EEzv1g18szHJSsNQTnMMS8IgG6B7JadHjSMjmHWkS8yFkLtHRW3Gk/Feio/TMmtTEDzwLhkFpvMXpNWcMZvIJgHCfjRTUf8lnSbPngqbOuyj9TGCHZQgYG3+CoOCHYCFj0th8S+juvdqQ7Q2KD5S9m2jL3WW3Prso4SgjRMGNipgAH7p8jhVYo/ycZY2ouCUY4WM/GXmOEb246bzuthFAIDJ27eVxLEuzTCTWzDUQcWjq5MtPje7/6My7jjN/z2hCJiHoVO6oTQ8W+O/rbL3Nr6IB2MCC8UxJHZ6gQu9fpmDAcqCOsezLZ74nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DFln4Ue0k4Pnu/R21SZqZ2E2iD+MXE2ymk6EjS4Xfg=;
 b=Wbw+RyLjfPIexyNzAu1GFa3oOY0Fyz2oYJB3cQUTPRB7wITcgCRqaHBSzPQLfChW/fFWeT5TM8eHoz/c4wGLSg84Jw2SG5yrbjYk9VUsdpUw1cROpRWtqZ29USg6BK+LG1M76k2Ae7Pbvhs9pDoWCkUzLUSck6MOhJoJwmg3/m5AfLlddGeJ3OTuF4AOSCJsdVXHnwVJejrydx9AfOaftiirA7FB/wlqEQOO55FZhvT+/kdtHXGbPr2IXNU0Ls05lVOjGOUSX80AVEFlLLNbHVV3NWEFV5Vgw37wd1e/kYEZDLz85iQoW1dj6hm65WPLuXkJ+ugH6uDAqhB+9qw2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DFln4Ue0k4Pnu/R21SZqZ2E2iD+MXE2ymk6EjS4Xfg=;
 b=auFN+FrPcS3O6EkccZXeZqX+PhOkn4vVR56lFZWiTFh/uMO2rdDh8QLFSC+2suQ7cQqtccQ4uAF4zvWD3NV5zvjdkMm8qlPVPBG9GmB0FyPDLekSCtRn1bh7dI2WRrl2zZQe7A2mubamT43zutKpN+t7uDNt3bbd3XMRDS+YlgM=
Received: from DUZPR01CA0260.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::8) by PAXPR06MB8423.eurprd06.prod.outlook.com
 (2603:10a6:102:22e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 10:50:37 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::55) by DUZPR01CA0260.outlook.office365.com
 (2603:10a6:10:4b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 10:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 10:50:37 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 15 Apr 2024 12:50:37 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: jic23@kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] iio: pressure: dps310: consistently check return value of `regmap_read`
Date: Mon, 15 Apr 2024 12:50:29 +0200
Message-Id: <20240415105030.1161770-4-thomas.haemmerle@leica-geosystems.com>
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
X-OriginalArrivalTime: 15 Apr 2024 10:50:37.0131 (UTC) FILETIME=[BFDAF9B0:01DA8F22]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|PAXPR06MB8423:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f3c2750b-c812-4b4a-951b-08dc5d39e2b8
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zWP1gDDQ1ywMZWsDfH9cB0N4v0L9NEpiMaHt8mQ3/kBzMPgmI5OT0GY7WcxMF09H4jmVJI5L2mho09x97KTBGeqJxIA9STyKM1LdJbX+A4xk9HxGfU+hvxsMjcLl7XZihpNoRo+XwAXW5mZyWqSICR6Cs0dFSfzGnqNx6q9s+HwxS5QS1uQPhNzs5AwIOFMIrV1wPKqiYaZ/uI3De3qNydQ6xpp2omSFpKcpzd7K0AJt9Y9UfuhD9xzvQcERsG1kghmI96B0z68CVJvCuEutcw0AOB+R3Was+pZbRMzXMXOOd/mjRaloq+iJST6H0jBcDQ3NuWcKHRXI2Dq4bC+PL/+vPePn4dDcGA23mxLBwsTBoZ7AitbS4dz7bW8gcKoN9xoNVk/httk6hgoLfm9vQRuagBG9ZKSg8vbMOnoKzwiKSV8ccDHeUnXjRKFJsyzt8lTzPUUeFO5MTBPV1ZlwedjsCPtyp59OWhr8CnYb7fzreW4yGW2IqC7ZMnysg1NwspKYm+43biEHQpyNTWPxbz/F6CyUstOCYfqtPDdOa934cdm2eQB+5mIBFt8bDj6mxAyuMNeHRx9gB2IhvcLI9LsVcroLaXrB13c2tjNhOWGnPRLdI4qsp5jdsaREmoWIgKGIpb7Moi0z54T6ufdxurz5CPCBOENtQlNfl0lL1Z+I9M956r9rC01MPi1hYvtdUKYJP5A5FaGraBBFybfLvEo6ufrCyAJF1XlEh1OgXJhnsXxTZGvHKsU6ZS2ZoBYU
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:50:37.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c2750b-c812-4b4a-951b-08dc5d39e2b8
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8423

Align the check of return values `regmap_read` so that it's consistent
across this driver code.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 3fc436f36fa7..c30623d96f0e 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -171,7 +171,7 @@ static int dps310_temp_workaround(struct dps310_data *data)
 	int reg;
 
 	rc = regmap_read(data->regmap, 0x32, &reg);
-	if (rc)
+	if (rc < 0)
 		return rc;
 
 	/*
-- 
2.34.1


