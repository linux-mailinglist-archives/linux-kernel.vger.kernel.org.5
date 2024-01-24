Return-Path: <linux-kernel+bounces-37256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5AB83AD59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40DA1F2463E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4837C0BD;
	Wed, 24 Jan 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EE/CxP9H"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70417A714;
	Wed, 24 Jan 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110228; cv=none; b=RDlo6FOIa6lVB/xDl6cagZecAve23hwzloncdWSw0pJqXvaSUm/yXiVydoKCGALesJz/jUlO+reWgGUMU4RT0/CYYSH1WQnhPxw/g8QJ4Gp8/R8G81ATdEX0eOn5QETqq56Rt/lwDiG0ElEtMvofC0jfp3GTzDMkcvxzocYu2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110228; c=relaxed/simple;
	bh=t5tlNEvlXgAxKg4SMJL4JOiD4JdYo0qP/3NyA5o+14E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R03Ef0cEPDTMhhpMLyXWAhvqvCyCUVyXB0edU0HzQoBZlxRThNw2E95pynY1ILITTtFpCG4YomACJ7mAsTNZlLPk5ebOloedZL6yjUXf2x9yIIMAMK8IDMjbdPKW3DhMxYkhD0kor6yW6cEMK8BKZMEZ/72MyrxpCI4cJdtESxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EE/CxP9H; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8MvMm030107;
	Wed, 24 Jan 2024 09:30:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=T04BEboBcsX0FcHCR9rWpO+dAdCpJVUhGdtiAcCuucc=; b=
	EE/CxP9Hh7gakcwOtkYUpMdpf+PgtEoZJuAYEiI6YdJouXb7xn96CnC9gaSEk4OA
	1/xTylo8tW1MaTmG0iXlNYmt3Hp7Z2FrGPWYXlHaZvh945/kaVYW5OoJFLy71ga5
	Wxbauun9nADMllMhi3Ui6ZH6kNfw5K2mzc1xgkkN+0mKMTAdbGMX6OAcUzam700X
	2nWZXBEXcsB/Calv9vTEG9Zviy8W38YjP9udqzotIMy3Ex/vEI9gE1OiO/J8N2sY
	IzJJY8y7isJaQZ2Tui4ug6gsYJMPUbJ1NtFh4GyAIb279jds0zFxu6vknwo4NsUG
	fLAwpFGbAS78lguYJEBsfw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryqc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:30:18 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:30:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:30:16 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BE07282024A;
	Wed, 24 Jan 2024 15:30:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 5/6] mfd: cs42l43: Add some missing dev_err_probes
Date: Wed, 24 Jan 2024 15:30:15 +0000
Message-ID: <20240124153016.1541616-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OeqhVnh9doqIPa-YSbmx56hpop6DrezP
X-Proofpoint-ORIG-GUID: OeqhVnh9doqIPa-YSbmx56hpop6DrezP
X-Proofpoint-Spam-Reason: safe

Use of dev_err_probe was missed in the i2c and sdw parts of the code,
update the missing parts.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

 drivers/mfd/cs42l43-i2c.c | 9 +++------
 drivers/mfd/cs42l43-sdw.c | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cs42l43-i2c.c b/drivers/mfd/cs42l43-i2c.c
index 7162274a0b551..c9e4ea76149a8 100644
--- a/drivers/mfd/cs42l43-i2c.c
+++ b/drivers/mfd/cs42l43-i2c.c
@@ -38,7 +38,6 @@ static const struct regmap_config cs42l43_i2c_regmap = {
 static int cs42l43_i2c_probe(struct i2c_client *i2c)
 {
 	struct cs42l43 *cs42l43;
-	int ret;
 
 	cs42l43 = devm_kzalloc(&i2c->dev, sizeof(*cs42l43), GFP_KERNEL);
 	if (!cs42l43)
@@ -50,11 +49,9 @@ static int cs42l43_i2c_probe(struct i2c_client *i2c)
 	cs42l43->attached = true;
 
 	cs42l43->regmap = devm_regmap_init_i2c(i2c, &cs42l43_i2c_regmap);
-	if (IS_ERR(cs42l43->regmap)) {
-		ret = PTR_ERR(cs42l43->regmap);
-		dev_err(cs42l43->dev, "Failed to allocate regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(cs42l43->regmap))
+		return dev_err_probe(cs42l43->dev, PTR_ERR(cs42l43->regmap),
+				     "Failed to allocate regmap\n");
 
 	return cs42l43_dev_probe(cs42l43);
 }
diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index d6962a5a35f65..65f7b1d782486 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -171,7 +171,6 @@ static int cs42l43_sdw_probe(struct sdw_slave *sdw, const struct sdw_device_id *
 {
 	struct cs42l43 *cs42l43;
 	struct device *dev = &sdw->dev;
-	int ret;
 
 	cs42l43 = devm_kzalloc(dev, sizeof(*cs42l43), GFP_KERNEL);
 	if (!cs42l43)
@@ -181,11 +180,9 @@ static int cs42l43_sdw_probe(struct sdw_slave *sdw, const struct sdw_device_id *
 	cs42l43->sdw = sdw;
 
 	cs42l43->regmap = devm_regmap_init_sdw(sdw, &cs42l43_sdw_regmap);
-	if (IS_ERR(cs42l43->regmap)) {
-		ret = PTR_ERR(cs42l43->regmap);
-		dev_err(cs42l43->dev, "Failed to allocate regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(cs42l43->regmap))
+		return dev_err_probe(cs42l43->dev, PTR_ERR(cs42l43->regmap),
+				     "Failed to allocate regmap\n");
 
 	return cs42l43_dev_probe(cs42l43);
 }
-- 
2.30.2


