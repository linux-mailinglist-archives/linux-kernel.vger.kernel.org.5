Return-Path: <linux-kernel+bounces-42997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756EB8409DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AAF1F23469
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F91552F2;
	Mon, 29 Jan 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FnLpyXIN"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69221153BD1;
	Mon, 29 Jan 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541969; cv=none; b=TcTDT36xaQvAPrWrzgMFWX/LEnVXTwfIRXbr36Dnwi7x4dMi2yKk3POmH6UkUBrrfsdB40ywjMv/pphvWK+VaPYs31SqiQsWc5m8uTAKd90QLCP/TksWztQdWnHOu4XF4cAiWK8jaLZx917EQwmtYVQjgKq8iRULbNVekUf0hY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541969; c=relaxed/simple;
	bh=YLgcv+MksptIyuKoYuQwWHnWo1FWh5tVnpSCXF8cu5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MG8VTCmh6K4CkfV0ADlKCm8KEOm6q6YFdmWQV7CSMnY7j6kBW8cTCjmihinwILBd7cj2bcDAMIxlMJzZ4S+dgXdlkJ5lGhroA+Etkg5CPH+O7kqeju7pdUsNWlc0B/tl3isM+X/ArL6GiFtqpjL1eHi4gM7Z70GYpM7rPWa7tIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FnLpyXIN; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7djLD025835;
	Mon, 29 Jan 2024 09:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=jv3N4/orHK/tu+hqh1ucmB1KxC83pTKued3P6djDN/g=; b=
	FnLpyXINzo/1628IRcVUYvafxA+djw02t+1i/+GktF6K5P8orrEdtu2/E5YNU+VD
	meMqSPsRbioiZEQawSwQiylX+i1L4jApI80eISAg2Hbuq3twaZ7a+KQ65D4QApxr
	d8BumFPSsAQo4JrdqaO1Lt098VipkBoOcHVGHXDbHYfdaqOL3q+EweYX7TUXMbZm
	NanzvUeVZ+4LABXRzmHHiLqTb6cpmpd/AEZwhIClArhARA8MUim9l/yDugSZglx+
	UaG/u1ftfz+fnjSVEebaB3po6UguPADMZxFZnw//f6TH0YOEii4sazd6XiC/4vpf
	Pbafd1XAiYkEx4QUuvNg0Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043t6cm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:26:03 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 15:25:58 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 15:25:58 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DC34B82024A;
	Mon, 29 Jan 2024 15:25:57 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 5/6] mfd: cs42l43: Add some missing dev_err_probe()s
Date: Mon, 29 Jan 2024 15:25:56 +0000
Message-ID: <20240129152557.3221212-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RsjHCOk4fFS9ASlWM_hBTbS3r9vQpI1C
X-Proofpoint-GUID: RsjHCOk4fFS9ASlWM_hBTbS3r9vQpI1C
X-Proofpoint-Spam-Reason: safe

Use of dev_err_probe() was missed in the i2c and sdw parts of the code,
update the missing parts.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v3.

Thanks,
Charles

 drivers/mfd/cs42l43-i2c.c | 9 +++------
 drivers/mfd/cs42l43-sdw.c | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cs42l43-i2c.c b/drivers/mfd/cs42l43-i2c.c
index 7162274a0b55..c9e4ea76149a 100644
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
index d6962a5a35f6..65f7b1d78248 100644
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


