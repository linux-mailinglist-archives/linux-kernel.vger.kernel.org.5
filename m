Return-Path: <linux-kernel+bounces-144940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC68A4CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2748E28563B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F215FB82;
	Mon, 15 Apr 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="LCLsb/X1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7025C911;
	Mon, 15 Apr 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178243; cv=fail; b=HVGp1QKFaQ1pRzxsKwgVKH95SjWl1gLhF7vcLp6KWL3eMIcU12sfx5UWEQnYG45PmKMboGt+2Gg06ZinvM2nKPO0P+ASiz/0eDycfun++oMNcrvcR/WbBrmQdxVBuHj4+0vbXDUmNSIfH6nvOKgF0A6j77VjbEzoprOmkqrm/Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178243; c=relaxed/simple;
	bh=52HJWjbDoWXK3goAO57q8lNu3XaRenR4xvmJht8KA9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNYvTQMkt63dDIQzFgxq8GxEjkgxUnfFHiI1szzOQUj+WMC+HrMaM8fbZ3s1DesmZ8kdTKwMS/T/g/mQ/CFdK9M4ocRxo/2kmUPSzLKt+yCTk9CRDEu59RVO0+1jCFJmecWKK/wNqZDLE+44oLRe39TDSun8uvDaJeYye/gohaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=LCLsb/X1; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrzpOQ6/zzCdzzK+BOYarvrmyevyBxPwETv9rEqlAzG0e+aX30rynVIw8BHt8HGrjniNzDZ7cSMKgIKG9A8qO5hEsO4boGTXUqqde5FBRJNcvjGNvxW8N/thQEeS+l54Ab54/uUjBbIHlhE6nnGREGjyF6BPX9jM9LI7XdNue5aMTkcunU1ASJcvWKmFKW61ds38yTMzPgRVnuNpJYyImgVih8A4SYqcOQiU/V5C/LF4JYgw4tqAu7GwylGNnbHJUKWDRSVwdt8FvRwswTm9VEqi2852BmgM8LQBbeTyHk6vMJghOJhSjONdB1AeZ+uWaffydyUoz5KWvKwhyF9Asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4kU4QLT4SQSuRz5oZgBmVOSVOJMLovL9GhhS9+KzAM=;
 b=egcdKkNLSk7B4Ixl9z8WglOytaV+DWO3C2I7PGKbqso8Sm58XYiSqg9mvwFK0ioB+zz9QE890NAEbuZ2iLEozI2KBBJ+fmJjJB0yQH8Zo1JDcAlxqFxEuMftaf6ykwpAes/1UcPa+mfIyi8fQ7ecrY+ePmmqIn5AWUYSG3TjuybH2chnoho0Uxl2rcxEF/sCxl0qnRvMUmywijbnURvzSFLaobRvkLxv3fLn50CFOK0GLLy2qpAagvYgRVgcDgVsY+apU3NcTgKbpsqB0NVXlC+c8WwsRwPipNZ5ggw2g+4ld34me+81yu4QrZSwBuWeiUL3ZRFcJQAReHFdjyQE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4kU4QLT4SQSuRz5oZgBmVOSVOJMLovL9GhhS9+KzAM=;
 b=LCLsb/X1fS13EPafCEisEEomSrDLWfCWrqMQN1VzqUxVQwdffgrTptdOe6IX2W+2cM0VO8IB1z3+SSNWx3PFkAFhbstIfq/lZI2FUQ9DdiyN/99LMW8JFIoNJWlp6AGH35+xsQdlJVh1cCvXXB9LKkKDhqllUltHUXuD5vAr33Q=
Received: from DUZPR01CA0275.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::6) by DU2PR06MB8365.eurprd06.prod.outlook.com
 (2603:10a6:10:2f0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 10:50:37 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::d9) by DUZPR01CA0275.outlook.office365.com
 (2603:10a6:10:4b9::6) with Microsoft SMTP Server (version=TLS1_2,
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
	 Mon, 15 Apr 2024 12:50:35 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: jic23@kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Joel Stanley <joel@jms.id.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] iio: pressure: dps310: introduce consistent error handling
Date: Mon, 15 Apr 2024 12:50:28 +0200
Message-Id: <20240415105030.1161770-3-thomas.haemmerle@leica-geosystems.com>
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
X-OriginalArrivalTime: 15 Apr 2024 10:50:35.0694 (UTC) FILETIME=[BEFFB4E0:01DA8F22]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DU2PR06MB8365:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ecb9ac94-45bb-48d4-bf0f-08dc5d39e281
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M8QoToNsxyTGmi4dhAn0OzeY3oIhl/uPxuAALSuk1X0PavPQZxexYP0i/3+7b/TNo2OBF9DwfWNNj347ImYhnAQR3LLcTA+LRHL7I+S6rhoccpMvvovU4sEX8OucLaMcwthWzkFhkcRUS1fj/Wle+S4BYnk9x7KffnNcl9SknraxseePAAqcTejoZVqSIKnZIVtWG70svHnaQvBv2Bk5ZLpZK/YuMtGhgH/AVr9L8whSduX4vgrqgeI9H2VH/LckEbp/rhdDBcBuRJaFieWpgpka4WAEtWf0F8gVThxH/38+Naiinih8M6PUSesiNrQN4Fv7nCHF8dzjTIff56PFY5VHyZsTaiD2zlBd2zNTC/JEaXThcSsvaRzLm1NNUpkLvtcrZqfn+H50LegdWzXNfiIDckOBox4Dq46Mt3blL7Hs6VAwvD0h+m48G/M7RxqnBYVe7sd05cE7kGK9WzJ5sQCPIyPz6xfyQqpPWz/82JpyMJiw/Anf8VBKb9U86PW017bILHmr3Jkjwcxj2TWOKHFfoYF3g1m6By3lsoFfw2Q7EvU+XXW2WKj/TQL6ombCqFSUNb8aqLhloRZH68ZP3ZmJaZvwwNSUEwx5sFopuGeRLiA34+IlVdbFTh/CVFsXGmnxfU6kmnShsKyq7KpvgRjq5cfYZvHDfPDzENn+OpkDH10b5n9QK/w14AGvyMMSzRraotaJ4Q2G7pBtbowAFQ8EhhuZYrgR2EoDlv5xGoRSAX92oV0hcRMiMttBaKUq
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:50:37.3034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb9ac94-45bb-48d4-bf0f-08dc5d39e281
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8365

Align error handling with `dps310_calculate_temp`, where it's not
possible to differentiate between errors and valid calculations by
checking if the returned value is negative.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 129 +++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index d0a516d56da4..3fc436f36fa7 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -256,24 +256,24 @@ static int dps310_startup(struct dps310_data *data)
 	return dps310_temp_workaround(data);
 }
 
-static int dps310_get_pres_precision(struct dps310_data *data)
+static int dps310_get_pres_precision(struct dps310_data *data, int *val)
 {
-	int rc;
-	int val;
+	int reg_val, rc;
 
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
 	if (rc < 0)
 		return rc;
 
-	return BIT(val & GENMASK(2, 0));
+	*val = BIT(reg_val & GENMASK(2, 0));
+
+	return 0;
 }
 
-static int dps310_get_temp_precision(struct dps310_data *data)
+static int dps310_get_temp_precision(struct dps310_data *data, int *val)
 {
-	int rc;
-	int val;
+	int reg_val, rc;
 
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
 	if (rc < 0)
 		return rc;
 
@@ -281,7 +281,9 @@ static int dps310_get_temp_precision(struct dps310_data *data)
 	 * Scale factor is bottom 4 bits of the register, but 1111 is
 	 * reserved so just grab bottom three
 	 */
-	return BIT(val & GENMASK(2, 0));
+	*val = BIT(reg_val & GENMASK(2, 0));
+
+	return 0;
 }
 
 /* Called with lock held */
@@ -350,48 +352,56 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 				  DPS310_TMP_RATE_BITS, val);
 }
 
-static int dps310_get_pres_samp_freq(struct dps310_data *data)
+static int dps310_get_pres_samp_freq(struct dps310_data *data, int *val)
 {
-	int rc;
-	int val;
+	int reg_val, rc;
 
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
 	if (rc < 0)
 		return rc;
 
-	return BIT((val & DPS310_PRS_RATE_BITS) >> 4);
+	*val = BIT((reg_val & DPS310_PRS_RATE_BITS) >> 4);
+
+	return 0;
 }
 
-static int dps310_get_temp_samp_freq(struct dps310_data *data)
+static int dps310_get_temp_samp_freq(struct dps310_data *data, int *val)
 {
-	int rc;
-	int val;
+	int reg_val, rc;
 
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
 	if (rc < 0)
 		return rc;
 
-	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
+	*val = BIT((reg_val & DPS310_TMP_RATE_BITS) >> 4);
+
+	return 0;
 }
 
-static int dps310_get_pres_k(struct dps310_data *data)
+static int dps310_get_pres_k(struct dps310_data *data, int *val)
 {
-	int rc = dps310_get_pres_precision(data);
+	int reg_val, rc;
 
-	if (rc < 0)
+	rc = dps310_get_pres_precision(data, &reg_val);
+	if (rc)
 		return rc;
 
-	return scale_factors[ilog2(rc)];
+	*val = scale_factors[ilog2(reg_val)];
+
+	return 0;
 }
 
-static int dps310_get_temp_k(struct dps310_data *data)
+static int dps310_get_temp_k(struct dps310_data *data, int *val)
 {
-	int rc = dps310_get_temp_precision(data);
+	int reg_val, rc;
 
-	if (rc < 0)
+	rc = dps310_get_temp_precision(data, &reg_val);
+	if (rc)
 		return rc;
 
-	return scale_factors[ilog2(rc)];
+	*val = scale_factors[ilog2(reg_val)];
+
+	return 0;
 }
 
 static int dps310_reset_wait(struct dps310_data *data)
@@ -464,7 +474,10 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rate = dps310_get_pres_samp_freq(data);
+	rc = dps310_get_pres_samp_freq(data, &rate);
+	if (rc)
+		goto done;
+
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
@@ -510,7 +523,10 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rate = dps310_get_temp_samp_freq(data);
+	rc = dps310_get_temp_samp_freq(data, &rate);
+	if (rc)
+		goto done;
+
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
@@ -612,13 +628,13 @@ static int dps310_write_raw(struct iio_dev *iio,
 	return rc;
 }
 
-static int dps310_calculate_pressure(struct dps310_data *data)
+static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 {
 	int i;
 	int rc;
 	int t_ready;
-	int kpi = dps310_get_pres_k(data);
-	int kti = dps310_get_temp_k(data);
+	int kpi;
+	int kti;
 	s64 rem = 0ULL;
 	s64 pressure = 0ULL;
 	s64 p;
@@ -629,11 +645,13 @@ static int dps310_calculate_pressure(struct dps310_data *data)
 	s64 kp;
 	s64 kt;
 
-	if (kpi < 0)
-		return kpi;
+	rc = dps310_get_pres_k(data, &kpi);
+	if (rc)
+		return rc;
 
-	if (kti < 0)
-		return kti;
+	rc = dps310_get_temp_k(data, &kti);
+	if (rc)
+		return rc;
 
 	kp = (s64)kpi;
 	kt = (s64)kti;
@@ -687,7 +705,9 @@ static int dps310_calculate_pressure(struct dps310_data *data)
 	if (pressure < 0LL)
 		return -ERANGE;
 
-	return (int)min_t(s64, pressure, INT_MAX);
+	*val = (int)min_t(s64, pressure, INT_MAX);
+
+	return 0;
 }
 
 static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
@@ -697,11 +717,10 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = dps310_get_pres_samp_freq(data);
-		if (rc < 0)
+		rc = dps310_get_pres_samp_freq(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
@@ -709,20 +728,17 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_pressure(data);
-		if (rc < 0)
+		rc = dps310_calculate_pressure(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		rc = dps310_get_pres_precision(data);
-		if (rc < 0)
+		rc = dps310_get_pres_precision(data, val);
+		if (rc)
 			return rc;
-
-		*val = rc;
 		return IIO_VAL_INT;
 
 	default:
@@ -734,10 +750,11 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
-	int kt = dps310_get_temp_k(data);
+	int kt, rc;
 
-	if (kt < 0)
-		return kt;
+	rc = dps310_get_temp_k(data, &kt);
+	if (rc)
+		return rc;
 
 	/* Obtain inverse-scaled offset */
 	c0 = div_s64((s64)kt * (s64)data->c0, 2);
@@ -758,11 +775,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = dps310_get_temp_samp_freq(data);
-		if (rc < 0)
+		rc = dps310_get_temp_samp_freq(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
@@ -777,11 +793,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		rc = dps310_get_temp_precision(data);
-		if (rc < 0)
+		rc = dps310_get_temp_precision(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	default:
-- 
2.34.1


