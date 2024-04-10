Return-Path: <linux-kernel+bounces-138343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FCB89EFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D3EB23E91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC81598E1;
	Wed, 10 Apr 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="e3x84kve"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48715956B;
	Wed, 10 Apr 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745453; cv=fail; b=a7tH4t8nuC56DGPmWneGSIDcpSeQ4ngEtRxCPYyjxtlCqomDtONzjdFjDAKw5MBknRaoqBNTsmbEwiowpxUVgBWTvRgw93OzBedrDw2eqEXwGt/+UsqXbLCmboQebicccArSI3jGUH8yR7Zhxk+haUyEhwTyU1PeXbOpw3O8zNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745453; c=relaxed/simple;
	bh=J/Z+cgfZRjTI10Oi5x8gMZYdVEkZALltGYXPsmb60Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgEUnDxg5kHDcZGFvetvUGBCwN/JPd8w/DllAD6Krum+BZrw1yot5Y2LumHSOY8EOeCWhOjAGle/Jy4lpCsO4l1GtDLmENe284SbwVs9Zq35D0FeUFxUtbsobZeJ/IjPjiOn3oSp62ky0Lyaf1ygK8+rmetbQV1l+pqEJf56r9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=e3x84kve; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd734GgBx/VqqZ5EuB7kYfbij/DnlebkcRjVxTEdAyhQENc9zSC+DhK4bgtUKUOuVLJN+xmh2wVl5cX4PIFjBdVRfjuLtyov/Eq5LBc6v24xzURHE5O/Cgyjc9SaE7X3QVMgOn6adMJzFYHLnRvKMR6PysHfnlaCi9ngX4OQlbGSqIdlU29kCOTxyNzpYHXM8VHLUWOB7MVz4j4dbZpmGKVgtB5kKoSSEM6TDRUdIMMpMUmV6VA/Bnf4mFupPbs1b13MlLx/OiUMFTZf86TpZioO6YNtpO3cYCUXZTxCtegCfGLvtUBhMiVvddp8v7OglQ+e3qKMtHkLmfS5MN+wKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOKFOhUbeuGCzWyiFSospHVJO2QsE/EV5ojbt0OJhys=;
 b=fTIgZrTZUYIBm+Kg9Et8D6905AJL+vqwvM9SqIGmE1L8u+WcOFUJMb2rO2bUrJ/2kOE0HiNpKC8DaOcdOtDMj1O/daaJGJYRUNJqJ/V27T0Vf2WGkDwIvLBnVQtRCtHNPSupHFs9PreTPhQaFX2YOgmwr0yFeFnKxTfYXzGgxyUmTMsfb7xqgWk2iy5ZzT+qYZA8g5jAnPmOrzOruAsI0iwoQtGw7NnRSGSpinGWfba7wFAYhlCwuL0r7CMaZpI+gCZP4VObIg6QqbwsdN4sVhOfCW83t840ZDEq7tLU+FPrFGel8nM/iwRMCR+3n/TTzomERrKFrmQIcMqdq1fLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOKFOhUbeuGCzWyiFSospHVJO2QsE/EV5ojbt0OJhys=;
 b=e3x84kveM8zoz01XhBYutPVCEY0iR0ojTG74TbcmRnoQ4xtfnfGEaj/pTY4w8QHnNHnub7zoozaEWkHZfbOy9SCE3P0m73diT4xy0t5WdgbI3jwCTk2nR2XBFj90kDVPYL/xBKJAwfWi2QbPAx3aRkGxU60p0Z1UwzTSdUoy5h4=
Received: from AM6PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:20b:b2::16)
 by GV1PR06MB9194.eurprd06.prod.outlook.com (2603:10a6:150:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Wed, 10 Apr
 2024 10:37:25 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:b2:cafe::27) by AM6PR08CA0004.outlook.office365.com
 (2603:10a6:20b:b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 10:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 10:37:25 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 10 Apr 2024 12:37:25 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: joel@jms.id.au
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iio: pressure: dps310: introduce consistent error handling
Date: Wed, 10 Apr 2024 12:36:02 +0200
Message-Id: <20240410103604.992989-3-thomas.haemmerle@leica-geosystems.com>
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
X-OriginalArrivalTime: 10 Apr 2024 10:37:25.0353 (UTC) FILETIME=[13DA7D90:01DA8B33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|GV1PR06MB9194:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce1541ad-67ee-4f9f-f02c-08dc594a367f
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Mn6Xff0ebP4eHPFlCA3w1cGmq1YZ4wRnv9mt3mnk07f4wnF7xKdRRZnQAKEgj30/30+ZKnZSlJQ9yI4CCu/SmeOkYjZJ8XOb++2GxMqT2PEfXuUrOCigVT88GltH6NPRmB7sOkuSjdyl2nqdTFYI+fwjiNEbSJ01sXzIN50xrVGKa3rgI8xL/AURLJIc0ggoSAfYSL6BKMlU1CW5bNF9L4OrzczBJhAsS/Yzevo+TukDmA6FMO9esRYmlRun/8vydapftJx83jkWXadrQIv3coG39YkZLMUR1s4vFYd5DbScXRdvCcDvBGZdJEyzQ1txA5dCAcSszOP7lBJ+G02CdSwYiN1MyDEpzjCXslnnvuZYumyDqCjNjxOoMHMEXqGr2Nek5tFvwWPdjVIU3ln44UJUFwfmtOKNqJL05cbwSyHRRTOrtq1lyLgQAZTC8bue6LbEAO9MbkAstwlAqADJCam72A2rFbzZqkhnbj6AZKz1fLTUHvoctFbQhT8gBRVIQtD9NCsPfTPMBOjkvyabe2XGgAdN7CLv3RZioLAHNCpe8JsHTX9gafumrbZZomhozUcSchhcKNleNn5qm43L+Fo1JwAWj/FcSfOtWE0kZW2VbA2E4pGHdyNsLAcMn+O9fMruu99tno2LOvpAvvzfqE0gdH9hZCQRhltypqY/LkrHP2RAJU4C47juHx7554ZMts4RzcCXlLPZfZb1Kb/A7Jn2Ify2FpgujrJc0kqZZ+cqXjU4UkUgNs7yL5bPcA1
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:37:25.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1541ad-67ee-4f9f-f02c-08dc594a367f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9194

Align error handling with `dps310_calculate_temp`, where it's not
possible to differentiate between errors and valid calculations by
checking if the returned value is negative.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 129 +++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index d0a516d56da4..a48e8adf63ae 100644
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
+		return rc;
+
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
@@ -510,7 +523,10 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rate = dps310_get_temp_samp_freq(data);
+	rc = dps310_get_temp_samp_freq(data, &rate);
+	if (rc)
+		return rc;
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


