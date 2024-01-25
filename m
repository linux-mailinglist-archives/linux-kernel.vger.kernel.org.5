Return-Path: <linux-kernel+bounces-38388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB983BEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2729B28ABDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC361CD32;
	Thu, 25 Jan 2024 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mxPiAgwQ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7251CA8D;
	Thu, 25 Jan 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178364; cv=none; b=AvYDHaaVLKKGYuW+8rTBMG3JmecNKL1J8v3tKunreMThqRmJ6LxRWkqqsmNn5QC3qMm0hzYWWY7zbupmZgDQlAewqxITXQS8+vZgppQ1yP+Sc2cS9K7+qNtHzStWSq7kkdYD+o5oslVjjeo6KR+72oILxnIIxHL1b+/+JbrKi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178364; c=relaxed/simple;
	bh=t62XeC0sIkJTMObk34vpixyT5zAm6lF6NKRpesJWxNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jk96s0rMZQFJhs2+GkYL4IXIc4PLoRzVXfU5KwUH+zMhhbyFnZNP2MPk1fHD4+hNOUqLTWJPKWpJ9eM9gjwTPnH0JxBQF3BLcvZE463uFRXfITfN8hfPTSwsksECZ32Wric2RDpZdR6cgL7zgtylkaPbhMSXiPyBF27HRnGLMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mxPiAgwQ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P7paSP014010;
	Thu, 25 Jan 2024 04:25:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=j90Mf6OkRSzIU7rEhMFiV0AA6YyW5HkH5qDLq7dYUq4=; b=
	mxPiAgwQpqvEyYfZvyQworPmtBDUJOCe8K7VcV6qXNr4WVp8Fv+AWgsRErWGM8s2
	sqiLagvUtCH+4biGI+wCNbisbZ0UhfFats4X53HdtlL2ZdWG8DCQXOy/N6ucNgmq
	m8NfkpaETBAmnzLIR8b9arUS4QQdnJxB4L21tRepPhIEh8MaQ0fdPjgExNrj6Xum
	2zILntRMDJOp0cxtNPcibP4++rq79bh5hLA6pf/MtYxj/bN+R2p3wIBeD8OCAZCg
	Fs0qVCxnPCqhNk6tZh5CMHXCHUFb7YNmcMtPpV5rdvsXqnG49MDBZfDs55Rx+Ep8
	QpdSsvj1+JjZoZrTvFqBPg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2gh-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:25:58 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:25:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:25:55 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 84DDD82024A;
	Thu, 25 Jan 2024 10:25:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 5/6] mfd: cs42l43: Add some missing dev_err_probe()s
Date: Thu, 25 Jan 2024 10:25:54 +0000
Message-ID: <20240125102555.2621736-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: T9mzWiA5OUZ5Nu-OMIbXlIU_Uh41-Fey
X-Proofpoint-ORIG-GUID: T9mzWiA5OUZ5Nu-OMIbXlIU_Uh41-Fey
X-Proofpoint-Spam-Reason: safe

Use of dev_err_probe() was missed in the i2c and sdw parts of the code,
update the missing parts.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Added brackets in the commit message for functions

Thanks,
Charles

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


