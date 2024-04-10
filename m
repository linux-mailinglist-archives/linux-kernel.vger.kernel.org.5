Return-Path: <linux-kernel+bounces-138345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960089EFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F481C20CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5215AAAE;
	Wed, 10 Apr 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="qQxDq+gJ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4A15958D;
	Wed, 10 Apr 2024 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745455; cv=fail; b=OINCtPEH1WBh7Jm38Vn87bbP4N0ZRYR9k9pHuefft1R3oI+s/B4UZn4q3UjiUbtTyj0WM+NwOZ7PKPDiZ6sxrBrxIy0qSH5f04bLOKhM3jUQYIO4HSZD2ldF5S150h7zdzULzvxrj5R+Hu6BgRtIX6DJCDCUasHcp4nJ7je3klM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745455; c=relaxed/simple;
	bh=e9W+JCBYvZfGTTaIiOjhKotoOPYP2T3yU81rmt3WkSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0s/6XEx2nrMPiD8rL+thCeMPkzciGpJ/zRA1rc9w4mWhHj04nb4/TkxXEzg8u6fCMeIPdDXLsl4GI2GfEJDqW8RDRRRRf2oX4N/wZgA5X2uD93vrwwhqPgznpTvhHPou/aunmuhj2IoxxCjPmrlpPRhngYqkc+jUE92lIbCv6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=qQxDq+gJ; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAcZLIAd756+qxtDfQciNEWYwVSrPbSF4O7abRlxixCJFvtVUu7XlWpyyvoaxDrCUXjNZdT9V7igW4dd9yAL0q1/n7ry6UlUa22V+fCy7MqPrT/G6UZUmvc2NB/c1vo8nk3+5exbnO6ro75Pn9zlcodYyhu97dAYHajibUS6qLoHFpJOWY35qkJ+/aGINjEU6zBRF9Is+tSSLh8gUOR998Hg1UTE9B98c815HGUiiT2NU1EjUnTsI6q7hakhBtnWJgefDWtFFTMz9zK2Jta1IOHuc09k3y/k2RtuZzgHMYVprEtOoj4aHJXk6BxinaHDuWBuXUSM5LaguudQxeroVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyCk/1KcVYWz2acTlAF9lplxehQ03IBEGAaswPnl3y0=;
 b=WQexNGIwL7sMsGh/SuEpct7S49WLFVKj/Ya8uUPpeMBY2lG9v87YUeQ8RXKXVJMJhjICT7qcoIyd3Rbara4naZb8Co3hepvZBc7ZJ1UDqHUSVaee5mKy13j4T4NlLo8IgGSO2CMxChV1oADbQMn7dO2FHP90ro9H60AlLPumSWvpl4bNn94tbMNdmWy1OeMCOYQor/vXJsiaKYTUgVQtnvK3Z9WyfcFYPL65re4JtyAucMfQFaRtKl7oJ50xT0umdtJ7ZmvED4Rg2WUzf5z48Dx1nivkAwy7Nscr2Gn+sCapCOiHPBSGT0b0EgXVbJ6blCLyDi3ha/r7oAyk4a0ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyCk/1KcVYWz2acTlAF9lplxehQ03IBEGAaswPnl3y0=;
 b=qQxDq+gJ1QPgPPbq9d8loaLp3uBCyMVndVAhkpSPHDu6jQ4jvlwJN4R7S+VCKgA+X39rQO92A3FhEf0SqBeC0nJ9SoA7n8gVW2xzI6VcgvQQo2NmFDQodwLIzGdSf6U58ccoWYFS9V8kvLBZWoi9aLaAiAoqPhR/OtfFrks5fVs=
Received: from AS8PR07CA0042.eurprd07.prod.outlook.com (2603:10a6:20b:459::29)
 by VI1PR06MB6557.eurprd06.prod.outlook.com (2603:10a6:800:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Wed, 10 Apr
 2024 10:37:29 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:459:cafe::b7) by AS8PR07CA0042.outlook.office365.com
 (2603:10a6:20b:459::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 10:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 10:37:28 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 10 Apr 2024 12:37:28 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: joel@jms.id.au
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] iio: pressure: dps310: simplify scale factor reading
Date: Wed, 10 Apr 2024 12:36:04 +0200
Message-Id: <20240410103604.992989-5-thomas.haemmerle@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
 <20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Apr 2024 10:37:28.0557 (UTC) FILETIME=[15C361D0:01DA8B33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|VI1PR06MB6557:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7bef3570-9c13-44a7-0bb3-08dc594a386a
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8GDMMj2FPAGuGd+ZD7IEHnJWxwyH2BmZD+3siewU8UNCZsy95W+k2btI7qes5vGFs39DuOE4igLLq5+oXj9Azbpgzvn+M7fytaN9uZxIW+OJ9lkSguCMr4TqmlvgOJic+Xh7g9NB98IG36Q6D6qMc1S9gifzyWpjNyRoznHSa+zaZxwnjZtUQBjSyjqpzIqG4vQL0jKL8Txb5kCXOZTdwPdDHB60rJlR4tOLXULneFDD1b2pCVuVvjKmsZ+nzHZPbRk+RbPoYm/ZV0/eNVz5+CrJbJVJifu02pNWbe2vq7g+7k94UxawZMUTeUuYNBsIj+zcXYxBTtUnx9j/5D8ubJM7/c/KYObSOPiz4u47gYaeKoI0Hk+xMLbJWRrK+BpirwObJ3PXdRGMG1lQgQJS+4o3PyJFPpDLqYw3apA5a7G/aQhKiHhkVw5aXYXESIQP+dYEx4XgW4XuJRKPLNPht/XstSO82i3bu+zFqxUmbKiWHeJnDY+XQYsv/Sl179/vzukNrI2DL1I56SXdcDAPGqKTe3dQJOW3W3Yj54oPflMOifMgkcey4RDL049KpRid4Obl3iOK8k1U+erW+gPlD2ghas9rxnEsLAGvTVvEHGObmDXPqVgw6L/w8K2gO+UXXGlApeBJiDj6YuP4loa2j9tYJp5Ia1AiSoOJs6I4XD7n99ps7rj76HXtjPVSckBthfvktZI/Tni60raOdoZWpQjawxhgM83TW396O9RkNwQa++jjaZrw6wBGkvs+TJ97
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:37:28.7756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bef3570-9c13-44a7-0bb3-08dc594a386a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6557

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
index 4abce7e40715..320e34ff9381 100644
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


