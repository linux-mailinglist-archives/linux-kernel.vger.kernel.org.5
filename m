Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F4807477
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442653AbjLFQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442566AbjLFQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:03:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA3DC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:03:55 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B67KtYi002302;
        Wed, 6 Dec 2023 10:03:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=foiFmzUEqVJ/nGA5Ch+P7eFl69ST9qdDwFB3DwnmLsM=; b=
        Z/SsmbJSKBb8eM74KWZBiOcV9HXnb62a+W6K9v0FeQy1X0W0wpieinlPnoyqmKf0
        9Bo0Xgo/DfDt+1heRifZEf4qknO1HyzA2mhJf69RJYLrKeH8Mnyxf+f0dudWCcmy
        XlacSTHAlj4EIgASTtJvCT7yRMPTqs6gbkuvuZYAmlLg/WzIbNyYPvuxmjrVt0S3
        PGQp7j2wGP0IEKuTTFrxKHY4g5kDGjC0bBamMfQmu0VFoqHiJ/QpAiiwwfY7pyT3
        11Ye8CdOQrGr0A71m5KJl+LMM+1dX5gEFzViapawS8C67K/5dTHru8ScJ5BpUeFk
        PG5UJ7IndaqgsyqBXu+0Uw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3utd1w8x5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 10:03:24 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 16:03:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 6 Dec 2023 16:03:22 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.145.40])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AF91511AB;
        Wed,  6 Dec 2023 16:03:20 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: cs35l45: Use modern pm_ops
Date:   Wed, 6 Dec 2023 10:03:16 -0600
Message-ID: <20231206160318.1255034-2-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206160318.1255034-1-rriveram@opensource.cirrus.com>
References: <20231206160318.1255034-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _Kgy0evTf8WtsM92-AuIIBWRghTlZrZZ
X-Proofpoint-ORIG-GUID: _Kgy0evTf8WtsM92-AuIIBWRghTlZrZZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the recently introduced EXPORT_GPL_DEV_PM_OPS() macro, to
conditionally export the runtime/system PM functions.

Replace the old SET_{RUNTIME,SYSTEM_SLEEP,NOIRQ_SYSTEM_SLEEP}_PM_OPS()
helpers with their modern alternatives and get rid of the now
unnecessary '__maybe_unused' annotations on all PM functions.

Additionally, use the pm_ptr() macro to fix the following errors when
building with CONFIG_PM disabled:

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45-i2c.c | 2 +-
 sound/soc/codecs/cs35l45-spi.c | 2 +-
 sound/soc/codecs/cs35l45.c     | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l45-i2c.c b/sound/soc/codecs/cs35l45-i2c.c
index 77e0f8750f37..bc2af1ed0fe9 100644
--- a/sound/soc/codecs/cs35l45-i2c.c
+++ b/sound/soc/codecs/cs35l45-i2c.c
@@ -62,7 +62,7 @@ static struct i2c_driver cs35l45_i2c_driver = {
 	.driver = {
 		.name		= "cs35l45",
 		.of_match_table = cs35l45_of_match,
-		.pm		= &cs35l45_pm_ops,
+		.pm		= pm_ptr(&cs35l45_pm_ops),
 	},
 	.id_table	= cs35l45_id_i2c,
 	.probe		= cs35l45_i2c_probe,
diff --git a/sound/soc/codecs/cs35l45-spi.c b/sound/soc/codecs/cs35l45-spi.c
index 5efb77530cc3..39e203a5f060 100644
--- a/sound/soc/codecs/cs35l45-spi.c
+++ b/sound/soc/codecs/cs35l45-spi.c
@@ -64,7 +64,7 @@ static struct spi_driver cs35l45_spi_driver = {
 	.driver = {
 		.name		= "cs35l45",
 		.of_match_table = cs35l45_of_match,
-		.pm		= &cs35l45_pm_ops,
+		.pm		= pm_ptr(&cs35l45_pm_ops),
 	},
 	.id_table	= cs35l45_id_spi,
 	.probe		= cs35l45_spi_probe,
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index b68853e42fd1..4f4df166f5f0 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -982,7 +982,7 @@ static int cs35l45_exit_hibernate(struct cs35l45_private *cs35l45)
 	return -ETIMEDOUT;
 }
 
-static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
+static int cs35l45_runtime_suspend(struct device *dev)
 {
 	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
 
@@ -999,7 +999,7 @@ static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l45_runtime_resume(struct device *dev)
+static int cs35l45_runtime_resume(struct device *dev)
 {
 	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
 	int ret;
@@ -1466,10 +1466,9 @@ void cs35l45_remove(struct cs35l45_private *cs35l45)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l45_remove, SND_SOC_CS35L45);
 
-const struct dev_pm_ops cs35l45_pm_ops = {
-	SET_RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
+EXPORT_GPL_DEV_PM_OPS(cs35l45_pm_ops) = {
+	RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_NS_GPL(cs35l45_pm_ops, SND_SOC_CS35L45);
 
 MODULE_DESCRIPTION("ASoC CS35L45 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
-- 
2.34.1

