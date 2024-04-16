Return-Path: <linux-kernel+bounces-147519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF388A758E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8D81C21097
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ADC13A3EE;
	Tue, 16 Apr 2024 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="d8ZZ7uzp"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2094.outbound.protection.outlook.com [40.92.64.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB32C6A3;
	Tue, 16 Apr 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299350; cv=fail; b=EDR+qf41r61nHV9w1gKW2eAaEqWPS/OqBnjQvzrrQDowz/3OhQg9JGnjRTUaUqxtwrIcgTUKFrnonat0HNRslbfkKi/dLjiE2C4DARVOEdc2MPbBYfrdTmOtRGfckFP3+/Z/SrSWJqIk1sFWTZ9nRWeaeE0sDicB5XjkOpoLqMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299350; c=relaxed/simple;
	bh=eacoNVBgNFQjGchp8X4ADsWcAtCaQrIBQj3b/lJ34Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uMHGqB+MXnTSJASNBarkE2UWSLxogG26Tf+WXAy8cZSg2As1pmZaOET9yX3w1I6IjJMupltGlLjgKSMTcBhlyctDYBc4zuFfGYkedzmCrahXAjBu4SFktl3FB5uytNoMf5HizeJUp/N7pj49WGfokMDv0ZH6GxTP5Kcitflluiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=d8ZZ7uzp; arc=fail smtp.client-ip=40.92.64.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md+Pc1lynjEC5PihbGe1XUyP3QYoq6r32zC2LyvP1Hb3eV1ST6MsuCa7mEy74j7IYsq99LPOh2ttwMJqjZxPsq/T/FWVhSLc6Jiw3AuCt0EE1NBpFJc9tvFLWkqbKr9bp/XmhK2i+mZbMYpFTzBhQ8M6Lra6pzB/99nvPzSEuntbb/NCkbn4tcskXzuGRLKdg5N5UP5tOgoktfxYbNylFsjYklLH9WaKflM6SF4BAmAPMYAorNoZBvEQJZZD675F3LVrMfzCc9uFux6CP3Xj6oD1LxHQfw1I4o8mRsRANhEIvf2T60Jaib9AfPSQwnKYGbRlpEzH68Lk4Fn4EBAqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2QtviUVyl6LnZa/TS9PJ+w5LsICx3NolXEtMCbVaTc=;
 b=ebcPEKb4JV+7Fn9BmCGlk7V/D+RPJECYuw/vTVRyVdwPux2cteATeEbr6jej89tMLkGJnswkkQh7fyzHvUvZ+7FKP9VtKVMq4mLC6FHf4trjc4Q7BA4QF0JhVEfG4bwBDuUiM61ysNGQ0Tv3THxc4plTdSHvHhk2XYUrRfkPlyqWzrVNd5wco9GFzXWviTHpqXF7XuRjJ7GjY+RsAFgu1AH7bjifIbBrEdb2WwxuuTcnJf/R61Ukkmj2hsdpqp2KIAlaY/71o2mTTm+x3X8TjwlYE/H+SIKQxKPqEmCwvWkuBNeIRfoJjLSYxutaeNe5egi7xHCOAwr54wslTFDudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2QtviUVyl6LnZa/TS9PJ+w5LsICx3NolXEtMCbVaTc=;
 b=d8ZZ7uzp0uap+8wPewrcWkmimfNFGiCZbIs/VFJRKk0X3MdffElW/GxSRvluMk8QfKN4rsFNoWbnNDkRfRmvUHYnfK8EQJhG6p5ToOBVpVP9CkUUKgt7DGaqow9V8p9YXiZArjYocbFpmfih2+lGEmqoHxCy0ACe4w62mgf8PNGjTrTkwBeZEQZyC0bJYCtpiHAm53saKPGFlovaL5DX9o59+oORfON9S1Q14DLizoXrZe3vXvRWRdaZe7PlI46XJJeEeGGU3TY7JMgG8js2yq9RiYqCMH7TefgZCNfsZOrXJQ16KeXWmvAktsjg+D9iRaryfFSbjMJQbsMPDRY8MA==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by VI0PR09MB7745.eurprd09.prod.outlook.com (2603:10a6:800:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 20:29:06 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:29:05 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: mgreer@animalcreek.com,
	krzk@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH] NFC: trf7970a: disable all regulators on removal
Date: Tue, 16 Apr 2024 22:28:49 +0200
Message-ID:
 <AM0PR09MB2675EDFD44EC82B6BCBB430F95082@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [soYv+R0FkcXdG5bKKTZALydyWdareuq8WKZM83j0SLjjwaR6OMHrw9K4kTxyDLd3]
X-ClientProxiedBy: AS4PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::9) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20240416202849.2315-1-paul_geurts@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|VI0PR09MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 912c2a95-f4a5-46c2-1713-08dc5e53dc43
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hlRwZXDUUfgtnjDb11SuvuJEvyzTNeSqa/YK8rCXkpyazSHrFNgy/4BFKZjmola/IVDW4rVsoC5F7gjohHzyGTJRiTm5K82yH7Trbreq8ohuiUsVIK9by7gVEaPRWec/ApDWiD9Q1C2bRCq8vdJw9Ymd4H9o1dV+f2zFWy5ANDUf0Zf5+mwvjo9idFR1EK8nXavpLAFmpoNJ+1wW12lmVn2hLgU90/2Wk4U7HhvAtJDUPdYRwWpgLOTwMGQIYnJYkgqYtXRGvj/nZVVcXEOqoWrflAoyHUL/adXbf0TZL4S4M3cblEXSDvEI1k/nGrp+P7MfQ+oEL89p90FllopxrktWGR90DOnuxfn6pet+XF3n+EPPVrQrnhhclZD35/MQZ+7GXaBVtiRx/E2RHuVR4U1srh+Bca3jWVM51NHWRQeHZm7xIv8giy52xPL36cMvC4QpA0bHucnq+SijN5jCMH1uIjrVZKjlNyXmnwNOL1BNPM2vmhs6Q+9P8amPguchthP2mUnjwyqtwFoD6avbcXBEmovHlslhQMnWZ8oxIFZcUpzfAoyTCb0qAOjmfiHHny13pnoH1MnrIKpHrdjY5T4Q+sm2+a3J/FI8gNMo4ebCFqKZ8Mn5gM4RkozNy9eh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlcKsIlSaG7Ym1QPgLk6pooCK7YfJkR5Pw5+PezhnvXBlsv0eQpgolJZ9pSL?=
 =?us-ascii?Q?JNroih0AulX+WdTqE+Wqc19di43bQIoIdebu7JadA/OpKrojM6YpbjIZLaJz?=
 =?us-ascii?Q?vHKm6cYb98ZSNd8Niqx3bfICmsT2neK7SwpmVzbxdeRCAHrkaTFkJLlnY8VW?=
 =?us-ascii?Q?jL9ReWecQPCe6KOFChMf5r9nMQikwy1MO/NTWjAHJipS+mJvQ33Z27HLBead?=
 =?us-ascii?Q?QYFGQgEwF2bJN/qDxOoQp4qf6TuMEUd5lML5j6VIeMsfiQbpKzwGK+G8cSR8?=
 =?us-ascii?Q?7TciKyVI5MecV9gRNGLmITnulv3T/c8V0sn/vUV4WNmzwSsdGE+1Md+hXeoL?=
 =?us-ascii?Q?GLPaiYavfA/CVi80Bnukh/oyt1P44avCHz3YWDJJ8IJ/mKP47uggLH1xxJXQ?=
 =?us-ascii?Q?sNE8OpP50cykkgfpvCKa2j/BQ5OdYgVatubwy2hQ5KbhBT0xFRXV++l2c2a8?=
 =?us-ascii?Q?v1PFYyySk6C+EsWDnUBHtg+ArA239Ms7Sigwz6AoqOaK0cYdGmWKoD3vrCl9?=
 =?us-ascii?Q?wEL6vo9KXNfejFZR4lVjBus+fHvYOYCIKDUh/pbpV8OGBsoJHp73/5uLpPCV?=
 =?us-ascii?Q?IYOjrUlD5q3F1hS8YFHpkYZE4/4dvy22rvaCKI8Wo5s8vpuG19xQbTqJt5vP?=
 =?us-ascii?Q?7IhCuaj8Kr/reVkMzTvHO04Hb8g2qqp/I4DvnQCM8ZRhDjR7PsIFX5mBJMCY?=
 =?us-ascii?Q?FeUCg8a13sjXpMOofNX35BC6z1nkFl2mwqf6+dMqyuF9Zf5VYM8pb4fo0wmu?=
 =?us-ascii?Q?lEzziNph1bpxIX1310xANlaErG1LwfV8Y+n1lDomMoNzErEkg+aaKnamX8Hb?=
 =?us-ascii?Q?wZn/iSluRAMFRw13wXUAg3VCebcLAq8SvNsZkQ0qVUPx0DX/7ioDzuBbHlHq?=
 =?us-ascii?Q?xWS+7IvS/9Df05CnNvg8T8jZyMczLYHOG3/NN4p1pVrC9tGIpZBECpnao/o/?=
 =?us-ascii?Q?C6Gvz84yo9VTWJ9/NWufOiXIvQMOCrg4qxT5UNCtEnESHmRpTzLQf9pSfjDg?=
 =?us-ascii?Q?Y6qQ3KiQV2F/b5LSwwrub+4yd2Xr3I5KvDdx0kXrj9Fyl7duvoNQCUm9jupb?=
 =?us-ascii?Q?BzuMs5UH5lNsIqABMInD3x55wypzokpMn95YsxzEAroLSvQmEUF4zL/wucXs?=
 =?us-ascii?Q?K92/o/3BDX6p+mo7WrIsQfaKPmMk4PCKIWunGdAvC67lj67Iv8DfG/7UMQm3?=
 =?us-ascii?Q?cVvDWyqj2qI+6REo6nYprVLPQXp8FwedBedJfXkCzUwb7u1zJOlT89d8jn7U?=
 =?us-ascii?Q?aBqa4YwFztk0GfleOUpbLIBoAnQ6A5SbxW7u/SXvAtUsO2SqyhOtbPUMPylA?=
 =?us-ascii?Q?UOk=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 912c2a95-f4a5-46c2-1713-08dc5e53dc43
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:29:05.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7745

During module probe, regulator 'vin' and 'vdd-io' are used and enabled,
but the vdd-io regulator overwrites the 'vin' regulator pointer. During
remove, only the vdd-io is disabled, as the vin regulator pointer is not
available anymore. When regulator_put() is called during resource
cleanup a kernel warning is given, as the regulator is still enabled.

Store the two regulators in separate pointers and disable both the
regulators on module remove.

Fixes: 49d22c70aaf0 ("NFC: trf7970a: Add device tree option of 1.8 Volt IO voltage")

Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
 drivers/nfc/trf7970a.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 7eb17f46a815..9e1a34e23af2 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -424,7 +424,8 @@ struct trf7970a {
 	enum trf7970a_state		state;
 	struct device			*dev;
 	struct spi_device		*spi;
-	struct regulator		*regulator;
+	struct regulator		*vin_regulator;
+	struct regulator		*vddio_regulator;
 	struct nfc_digital_dev		*ddev;
 	u32				quirks;
 	bool				is_initiator;
@@ -1883,7 +1884,7 @@ static int trf7970a_power_up(struct trf7970a *trf)
 	if (trf->state != TRF7970A_ST_PWR_OFF)
 		return 0;
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "%s - Can't enable VIN: %d\n", __func__, ret);
 		return ret;
@@ -1926,7 +1927,7 @@ static int trf7970a_power_down(struct trf7970a *trf)
 	if (trf->en2_gpiod && !(trf->quirks & TRF7970A_QUIRK_EN2_MUST_STAY_LOW))
 		gpiod_set_value_cansleep(trf->en2_gpiod, 0);
 
-	ret = regulator_disable(trf->regulator);
+	ret = regulator_disable(trf->vin_regulator);
 	if (ret)
 		dev_err(trf->dev, "%s - Can't disable VIN: %d\n", __func__,
 			ret);
@@ -2065,37 +2066,37 @@ static int trf7970a_probe(struct spi_device *spi)
 	mutex_init(&trf->lock);
 	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
 
-	trf->regulator = devm_regulator_get(&spi->dev, "vin");
-	if (IS_ERR(trf->regulator)) {
-		ret = PTR_ERR(trf->regulator);
+	trf->vin_regulator = devm_regulator_get(&spi->dev, "vin");
+	if (IS_ERR(trf->vin_regulator)) {
+		ret = PTR_ERR(trf->vin_regulator);
 		dev_err(trf->dev, "Can't get VIN regulator: %d\n", ret);
 		goto err_destroy_lock;
 	}
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VIN: %d\n", ret);
 		goto err_destroy_lock;
 	}
 
-	uvolts = regulator_get_voltage(trf->regulator);
+	uvolts = regulator_get_voltage(trf->vin_regulator);
 	if (uvolts > 4000000)
 		trf->chip_status_ctrl = TRF7970A_CHIP_STATUS_VRS5_3;
 
-	trf->regulator = devm_regulator_get(&spi->dev, "vdd-io");
-	if (IS_ERR(trf->regulator)) {
-		ret = PTR_ERR(trf->regulator);
+	trf->vddio_regulator = devm_regulator_get(&spi->dev, "vdd-io");
+	if (IS_ERR(trf->vddio_regulator)) {
+		ret = PTR_ERR(trf->vddio_regulator);
 		dev_err(trf->dev, "Can't get VDD_IO regulator: %d\n", ret);
-		goto err_destroy_lock;
+		goto err_disable_vin_regulator;
 	}
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vddio_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VDD_IO: %d\n", ret);
-		goto err_destroy_lock;
+		goto err_disable_vin_regulator;
 	}
 
-	if (regulator_get_voltage(trf->regulator) == 1800000) {
+	if (regulator_get_voltage(trf->vddio_regulator) == 1800000) {
 		trf->io_ctrl = TRF7970A_REG_IO_CTRL_IO_LOW;
 		dev_dbg(trf->dev, "trf7970a config vdd_io to 1.8V\n");
 	}
@@ -2108,7 +2109,7 @@ static int trf7970a_probe(struct spi_device *spi)
 	if (!trf->ddev) {
 		dev_err(trf->dev, "Can't allocate NFC digital device\n");
 		ret = -ENOMEM;
-		goto err_disable_regulator;
+		goto err_disable_vddio_regulator;
 	}
 
 	nfc_digital_set_parent_dev(trf->ddev, trf->dev);
@@ -2137,8 +2138,10 @@ static int trf7970a_probe(struct spi_device *spi)
 	trf7970a_shutdown(trf);
 err_free_ddev:
 	nfc_digital_free_device(trf->ddev);
-err_disable_regulator:
-	regulator_disable(trf->regulator);
+err_disable_vddio_regulator:
+	regulator_disable(trf->vddio_regulator);
+err_disable_vin_regulator:
+	regulator_disable(trf->vin_regulator);
 err_destroy_lock:
 	mutex_destroy(&trf->lock);
 	return ret;
@@ -2157,7 +2160,8 @@ static void trf7970a_remove(struct spi_device *spi)
 	nfc_digital_unregister_device(trf->ddev);
 	nfc_digital_free_device(trf->ddev);
 
-	regulator_disable(trf->regulator);
+	regulator_disable(trf->vddio_regulator);
+	regulator_disable(trf->vin_regulator);
 
 	mutex_destroy(&trf->lock);
 }
-- 
2.20.1


