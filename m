Return-Path: <linux-kernel+bounces-140262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE38A10D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB81C21FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282421474A8;
	Thu, 11 Apr 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ceTi2qW5"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CD79FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831866; cv=none; b=t3tIodRshdz6Wg6LIIL7TSwbOKFwbYgsviXmqyXgR6gjl6N8ujalDllWM5aUn55Bmob33dyNiPad2TAUWNVpuZnn3wwS0YLAIzv42rqQoYvDTDD8pN6b/ieZjM7Zvl0ZDpB8cqtSgD8egHY1K1/cWorSJy1a2i9xvN++tz5QFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831866; c=relaxed/simple;
	bh=yGDwdS8G5IPmO/P/GFqviCJqM4zJyGEjJ0OFzK+FTJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rqu+jbyi1S5sPplo7GBTe2tJxQ/7qwNBLIlGHc95PL2we0SNV03vhl4G9SY1WXCoXbTDGp4gILywEjQfiEuvvfin3FzTukt+hWShFMp4zCh4PcqPaxo1FnAZ82eC5+Q5mO11YkDEwiBA1Ksn69RPvO+nuyNKND95T8CUSXIbr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ceTi2qW5; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B40AwN009489;
	Thu, 11 Apr 2024 05:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=x
	/Rv8HG0vC5pESaW0vY6lracWwK23L2HWXB9hmoYiOE=; b=ceTi2qW5KVTzHRIhO
	Hr1ix27jz6Enuxbyqv071dSbuJzDO21/G96+58ZLidUkEfWdrihBgcrpTYNh7hcn
	tmM4OauqjLH+7RohMMSgrb88lFlpKiZ5PjTAlf7XZyUv1NiGWwwgMmUbHJd47hTk
	ItQdz390Wd6r2mV6uJr3++Jl9rCwbfvtvtgBsPUZ2b7spwxf+NBE+R0c19pirVkq
	1OTsN/O6icNclkKA8u4Y2tUu0wszxTIm5JL0wEtoBX0U5qoCQrhCKjFIFx3VpChr
	NLFsGa39TuXiFJs3oh0CoqopNUaSAuk8SEYhks1m+bfyZT72DYJFxnt6VZh3Wxyu
	KCSAg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxptn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 05:37:27 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 11:37:24 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 11:37:24 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D17E5820243;
	Thu, 11 Apr 2024 10:37:24 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] regmap: kunit: Fix memory leaks in gen_regmap() and gen_raw_regmap()
Date: Thu, 11 Apr 2024 11:37:24 +0100
Message-ID: <20240411103724.54063-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kZueMepPqvc3KGk8W4fkEMBRAzafDydS
X-Proofpoint-GUID: kZueMepPqvc3KGk8W4fkEMBRAzafDydS
X-Proofpoint-Spam-Reason: safe

- Use kunit_kcalloc() to allocate the defaults table so that it will be
  freed when the test case ends.
- kfree() the buf and *data buffers on the error paths.
- Use kunit_add_action_or_reset() instead of kunit_add_action() so that
  if it fails it will call regmap_exit().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 72 +++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 44265dc2313d..55d00e86c71c 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -145,9 +145,9 @@ static struct regmap *gen_regmap(struct kunit *test,
 	const struct regmap_test_param *param = test->param_value;
 	struct regmap_test_priv *priv = test->priv;
 	unsigned int *buf;
-	struct regmap *ret;
+	struct regmap *ret = ERR_PTR(-ENOMEM);
 	size_t size;
-	int i;
+	int i, error;
 	struct reg_default *defaults;
 
 	config->cache_type = param->cache;
@@ -172,15 +172,17 @@ static struct regmap *gen_regmap(struct kunit *test,
 
 	*data = kzalloc(sizeof(**data), GFP_KERNEL);
 	if (!(*data))
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
 	(*data)->vals = buf;
 
 	if (config->num_reg_defaults) {
-		defaults = kcalloc(config->num_reg_defaults,
-				   sizeof(struct reg_default),
-				   GFP_KERNEL);
+		defaults = kunit_kcalloc(test,
+					 config->num_reg_defaults,
+					 sizeof(struct reg_default),
+					 GFP_KERNEL);
 		if (!defaults)
-			return ERR_PTR(-ENOMEM);
+			goto out_free;
+
 		config->reg_defaults = defaults;
 
 		for (i = 0; i < config->num_reg_defaults; i++) {
@@ -190,12 +192,19 @@ static struct regmap *gen_regmap(struct kunit *test,
 	}
 
 	ret = regmap_init_ram(priv->dev, config, *data);
-	if (IS_ERR(ret)) {
-		kfree(buf);
-		kfree(*data);
-	} else {
-		kunit_add_action(test, regmap_exit_action, ret);
-	}
+	if (IS_ERR(ret))
+		goto out_free;
+
+	/* This calls regmap_exit() on failure, which frees buf and *data */
+	error = kunit_add_action_or_reset(test, regmap_exit_action, ret);
+	if (error)
+		ret = ERR_PTR(error);
+
+	return ret;
+
+out_free:
+	kfree(buf);
+	kfree(*data);
 
 	return ret;
 }
@@ -1490,9 +1499,9 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 	struct regmap_test_priv *priv = test->priv;
 	const struct regmap_test_param *param = test->param_value;
 	u16 *buf;
-	struct regmap *ret;
+	struct regmap *ret = ERR_PTR(-ENOMEM);
 	size_t size = (config->max_register + 1) * config->reg_bits / 8;
-	int i;
+	int i, error;
 	struct reg_default *defaults;
 
 	config->cache_type = param->cache;
@@ -1508,15 +1517,16 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 
 	*data = kzalloc(sizeof(**data), GFP_KERNEL);
 	if (!(*data))
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
 	(*data)->vals = (void *)buf;
 
 	config->num_reg_defaults = config->max_register + 1;
-	defaults = kcalloc(config->num_reg_defaults,
-			   sizeof(struct reg_default),
-			   GFP_KERNEL);
+	defaults = kunit_kcalloc(test,
+				 config->num_reg_defaults,
+				 sizeof(struct reg_default),
+				 GFP_KERNEL);
 	if (!defaults)
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
 	config->reg_defaults = defaults;
 
 	for (i = 0; i < config->num_reg_defaults; i++) {
@@ -1529,7 +1539,8 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 			defaults[i].def = be16_to_cpu(buf[i]);
 			break;
 		default:
-			return ERR_PTR(-EINVAL);
+			ret = ERR_PTR(-EINVAL);
+			goto out_free;
 		}
 	}
 
@@ -1541,12 +1552,19 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 		config->num_reg_defaults = 0;
 
 	ret = regmap_init_raw_ram(priv->dev, config, *data);
-	if (IS_ERR(ret)) {
-		kfree(buf);
-		kfree(*data);
-	} else {
-		kunit_add_action(test, regmap_exit_action, ret);
-	}
+	if (IS_ERR(ret))
+		goto out_free;
+
+	/* This calls regmap_exit() on failure, which frees buf and *data */
+	error = kunit_add_action_or_reset(test, regmap_exit_action, ret);
+	if (error)
+		ret = ERR_PTR(error);
+
+	return ret;
+
+out_free:
+	kfree(buf);
+	kfree(*data);
 
 	return ret;
 }
-- 
2.39.2


