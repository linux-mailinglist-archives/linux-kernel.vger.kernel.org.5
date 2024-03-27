Return-Path: <linux-kernel+bounces-120568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F5988D974
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D861C27465
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67013418B;
	Wed, 27 Mar 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="kyg1DvSo"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CE1E869;
	Wed, 27 Mar 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529402; cv=fail; b=KOK3xl4pJ/Qmhf93Vll57bix2UJnft6tFcSqpMUACAqkVNSFXkICsiPl69yTuNvkBrzWu8/cg7miSzc1ZxwXrwTHSKM130al+oaHsM3+WsKQU6Mrk8y+83G6C3VLLvYH48wRgixKU4O8ZJtc8WRMLsjDBT+23gzl+mIOMSYFRT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529402; c=relaxed/simple;
	bh=6Ljwt3x6VrHZyKZuzkt61mIXUGb8e6WdaS+4Dbvblh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i8sVwxb0y/kzhoKAIqkkDvVe8Zx8Su0Avw6tb7Q1AcXlBNMysrIGW8dfKt31O2R0KlGAgm/EfkN04TLB8GMBWfv3AXWSnPB/aIEdQ7FrRldRDRnnsQqTqyWw664KfSim4LQ23WXGs8LAo7IqaY9s2km6dE2trFYT3nxOtnuYwHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=kyg1DvSo; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd8qhXUM2sEGTGYlgGM24y599LmvYRClkWmhiaP0kkDhDhIsMG4Diug/ejZhxKyPjyiROldPgWsCF+0pWL72XguvotRlE96Stx3o1rtE+9rq+N9znY3KOdYaReejnJ5eG9yEVYdJoJoLAmgOPliRhR6OT/W0BVHW4NTF4HBV6Gc/R9zMdaRqhAI30Sfw2pywHPewzwINiuTBB0iemagBMKz4jhjpGwZKwbWo+JrAMkjaNAEm7U3TnzM3D/1o3v4Tj7Wwnk3g3RcVQKAfDlMJmks0LhD08LkBv2V29vponU/Y8sQ0PNLboTSIJW/STA8bc/emwMHApRthTPfTWwmEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDdmZDt6E1pzr1KhkuN6CxAiDJlY3UMrZywhYhkgoZE=;
 b=Hxz16kx9wmrHjrJCXuMbml73dgPdsCInsvAp/bll0PbFsH50V4SqGPB2PSCdD4ad2Z8BIS9FOhxQI+v6N81TOdcRA+C6woKoeTKyBvVTcyshGmrkG6Cy0sIc2EjqTa4G2aG+DJJYUf82Xq/lM4JDRIyuN+WpCxAKcwkssx3fYwgC86jFReWNxSCZFFnlCqMttOasJOqKw12GEm5C/aXNn+M1mmKl5XRFQqrqllw1yO8tTtNctbT6shVLuAiz9rEkatHDiMMSPJt6fEOKmtsxXTNdgi2sT7EMYckGUEA1rPUdW/O8lyl/eTSzkpM4xB/64gAcnjvwPCAFIEP5mcg1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDdmZDt6E1pzr1KhkuN6CxAiDJlY3UMrZywhYhkgoZE=;
 b=kyg1DvSowEHK297vBqAIrdswbONnHDZK2kFzhpw4nEDkKZgp5OOlBWjJgCih2Q60lsqUhiUqjPCYHvuX/24o51S20mp9vWKT6aWtpwG8ksUQ5yrzuH7Xs3ofFj90mikqB/AOfEBTm3zh+EOd4Sy6Hy/w3ro3ikX0b9GhgTTlBP0=
Received: from AS4P189CA0042.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::20)
 by AM9PR06MB8020.eurprd06.prod.outlook.com (2603:10a6:20b:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Wed, 27 Mar
 2024 08:49:57 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::d4) by AS4P189CA0042.outlook.office365.com
 (2603:10a6:20b:5dd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 08:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 08:49:57 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 27 Mar 2024 09:49:57 +0100
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: joel@jms.id.au
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: dps310: support negative pressure and temperature values
Date: Wed, 27 Mar 2024 09:49:36 +0100
Message-Id: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Mar 2024 08:49:57.0242 (UTC) FILETIME=[BEB255A0:01DA8023]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|AM9PR06MB8020:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22d3509b-2d07-4695-3b35-08dc4e3ae15a
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OZ8Ng4KUM+zmqXWsdmA2PcEnq3LtQYlnTrz7Ha8NdSIuHznrPyxoRfyShW8V1eQngPDJTQ6R79uCg0fzTpJf5Ox7LN++1ZgS9oq4S8mwpsDQkajqKTfUN6MKaIPaLaIAcR0y1Yo83LxL0Hfd4G4yofDrL/WSIJEOivG61DGT3Ufk29roloPSP+iIVgb5Bbw5KAiisXLWQOPery9IXA55O//PFF6J8pvEAWbRLqUst9Re3QgWodgTTOU8oikqH3QWvId0Dlhd/DAyhGT+9ydnrJkXTLJGoLAroFawx811WbdEneeo3rvEPfJVVi1EvrGDBlkDYzq8N9juBBt5FnbCENfw0dyyhArL6VBirDTwmYWGs+wAFJey9/Xpqs1Sv317lX4WdeZ1y4Wf0wWfAZT/108IBwksAgQzqVVgNl+o66sgEMW0yWwW8285Wt9UXF5RVigiPi6fv8Ycws8AwIXiO7MmaNpys3MyntqaT2D3PygDilx5NEKAUVWXBNOoVVr86IGR2lIdA2MyocFh2vyr3hdYTcDntmdmcoNENPHmlJoWylfCIWTVXWkxNP0d8y/pZmfyB80PRNyn3UPjcIk3yItFE+iL66C0M6x/O16YszR4pYD4zWFVaeJe0q94sfpZZzVFPxwOiUjbYp7OLhv+ubvK3l41EzU+mMh1JpV6Yenfcblt9Ipy6L4WQ4qTHJnLh5IyFJeqzM5/z+DiOXclKbAPxOHT7hIDvtMu4VbiGHHLQPh1GjOKXkytxdizBLeH
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:49:57.4687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d3509b-2d07-4695-3b35-08dc4e3ae15a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8020

The current implementation interprets negative values returned from
function invocation as error codes, even those that report actual data.
This has a side effect that when temperature values are calculated -
they also converted by error code, which leads to false interpretation
of results.

Fix this by using the return values only for error handling and passing
a pointer for the values.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 122 +++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1ff091b2f764..373d1c063b05 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -171,7 +171,7 @@ static int dps310_temp_workaround(struct dps310_data *data)
 	int reg;
 
 	rc = regmap_read(data->regmap, 0x32, &reg);
-	if (rc)
+	if (rc < 0)
 		return rc;
 
 	/*
@@ -256,24 +256,24 @@ static int dps310_startup(struct dps310_data *data)
 	return dps310_temp_workaround(data);
 }
 
-static int dps310_get_pres_precision(struct dps310_data *data)
+static int dps310_get_pres_precision(struct dps310_data *data, int *val)
 {
 	int rc;
-	int val;
 
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_PRS_CFG, val);
 	if (rc < 0)
 		return rc;
 
-	return BIT(val & GENMASK(2, 0));
+	*val = BIT(*val & GENMASK(2, 0));
+
+	return 0;
 }
 
-static int dps310_get_temp_precision(struct dps310_data *data)
+static int dps310_get_temp_precision(struct dps310_data *data, int *val)
 {
 	int rc;
-	int val;
 
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, val);
 	if (rc < 0)
 		return rc;
 
@@ -281,7 +281,9 @@ static int dps310_get_temp_precision(struct dps310_data *data)
 	 * Scale factor is bottom 4 bits of the register, but 1111 is
 	 * reserved so just grab bottom three
 	 */
-	return BIT(val & GENMASK(2, 0));
+	*val = BIT(*val & GENMASK(2, 0));
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
 	int rc;
-	int val;
 
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_PRS_CFG, val);
 	if (rc < 0)
 		return rc;
 
-	return BIT((val & DPS310_PRS_RATE_BITS) >> 4);
+	*val = BIT((*val & DPS310_PRS_RATE_BITS) >> 4);
+
+	return 0;
 }
 
-static int dps310_get_temp_samp_freq(struct dps310_data *data)
+static int dps310_get_temp_samp_freq(struct dps310_data *data, int *val)
 {
 	int rc;
-	int val;
 
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
+	rc = regmap_read(data->regmap, DPS310_TMP_CFG, val);
 	if (rc < 0)
 		return rc;
 
-	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
+	*val = BIT((*val & DPS310_TMP_RATE_BITS) >> 4);
+
+	return 0;
 }
 
-static int dps310_get_pres_k(struct dps310_data *data)
+static int dps310_get_pres_k(struct dps310_data *data, int *val)
 {
-	int rc = dps310_get_pres_precision(data);
+	int rc;
 
-	if (rc < 0)
+	rc = dps310_get_pres_precision(data, val);
+	if (rc)
 		return rc;
 
-	return scale_factors[ilog2(rc)];
+	*val = scale_factors[ilog2(*val)];
+
+	return 0;
 }
 
-static int dps310_get_temp_k(struct dps310_data *data)
+static int dps310_get_temp_k(struct dps310_data *data, int *val)
 {
-	int rc = dps310_get_temp_precision(data);
+	int rc;
 
-	if (rc < 0)
+	rc = dps310_get_temp_precision(data, val);
+	if (rc)
 		return rc;
 
-	return scale_factors[ilog2(rc)];
+	*val = scale_factors[ilog2(*val)];
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
+	if (rc < 0)
+		return rc;
 
-	if (kti < 0)
-		return kti;
+	rc = dps310_get_temp_k(data, &kti);
+	if (rc < 0)
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
+		rc = dps310_get_pres_samp_freq(data, val);
 		if (rc < 0)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
@@ -709,20 +728,17 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_pressure(data);
+		rc = dps310_calculate_pressure(data, val);
 		if (rc < 0)
 			return rc;
 
-		*val = rc;
 		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		rc = dps310_get_pres_precision(data);
+		rc = dps310_get_pres_precision(data, val);
 		if (rc < 0)
 			return rc;
-
-		*val = rc;
 		return IIO_VAL_INT;
 
 	default:
@@ -730,14 +746,15 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_calculate_temp(struct dps310_data *data)
+static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
-	int kt = dps310_get_temp_k(data);
+	int kt, rc;
 
-	if (kt < 0)
-		return kt;
+	rc = dps310_get_temp_k(data, &kt);
+	if (rc < 0)
+		return rc;
 
 	/* Obtain inverse-scaled offset */
 	c0 = div_s64((s64)kt * (s64)data->c0, 2);
@@ -746,7 +763,9 @@ static int dps310_calculate_temp(struct dps310_data *data)
 	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
 
 	/* Convert to milliCelsius and scale the temperature */
-	return (int)div_s64(t * 1000LL, kt);
+	*val = (int)div_s64(t * 1000LL, kt);
+
+	return 0;
 }
 
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
@@ -756,11 +775,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = dps310_get_temp_samp_freq(data);
+		rc = dps310_get_temp_samp_freq(data, val);
 		if (rc < 0)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
@@ -768,19 +786,17 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_temp(data);
+		rc = dps310_calculate_temp(data, val);
 		if (rc < 0)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		rc = dps310_get_temp_precision(data);
+		rc = dps310_get_temp_precision(data, val);
 		if (rc < 0)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	default:
-- 
2.34.1


