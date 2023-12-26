Return-Path: <linux-kernel+bounces-11201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD281E325
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155A02826A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C471D69F;
	Tue, 26 Dec 2023 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmj/Njo0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6412B88;
	Tue, 26 Dec 2023 00:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ABBC433CA;
	Tue, 26 Dec 2023 00:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550044;
	bh=0a43TKMlt0s7STIrUAP1Uw+bes7XaSooWjnfNN9gFD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rmj/Njo0ZB/G20WJSbkUCPXb4eqHT9GSrDg45R6xWFGITU3gSPYGYq6xelpskx5iX
	 vxLntghuKmYCy+S731znjMN4UE6+74Uujc4ntloswrZTS+GH5YcCrjkPV5XtvR2tZi
	 09izuSD9pWbxNqvT5yCrp0eq78Cb65qu3w0pth55pMn82BBjOuyk1KCZkV3PfPjdF2
	 /CjD/eYyxGwZriqa9RuWYtrmE13/4bvk7xXlwWZz45YJZhP3BSfN9CAAtHFrRz/JdO
	 epyZ8Ooaqll8MQQkBO0x9BqeyGJ1hTRwJLf/W5RSL43AJ/wGio0JZ5RBHdEQZt+7ba
	 YdDRSnS3owr5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/39] ASoC: cs35l45: Use modern pm_ops
Date: Mon, 25 Dec 2023 19:18:58 -0500
Message-ID: <20231226002021.4776-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>

[ Upstream commit 12e102b1bd22ee00361559d57a5876445bcb2407 ]

Make use of the recently introduced EXPORT_GPL_DEV_PM_OPS() macro, to
conditionally export the runtime/system PM functions.

Replace the old SET_{RUNTIME,SYSTEM_SLEEP,NOIRQ_SYSTEM_SLEEP}_PM_OPS()
helpers with their modern alternatives and get rid of the now
unnecessary '__maybe_unused' annotations on all PM functions.

Additionally, use the pm_ptr() macro to fix the following errors when
building with CONFIG_PM disabled:

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231206160318.1255034-2-rriveram@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l45-i2c.c | 2 +-
 sound/soc/codecs/cs35l45-spi.c | 2 +-
 sound/soc/codecs/cs35l45.c     | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l45-i2c.c b/sound/soc/codecs/cs35l45-i2c.c
index 77e0f8750f375..bc2af1ed0fe9b 100644
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
index 5efb77530cc33..39e203a5f060c 100644
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
index be4f4229576c4..b1d0f2c8f2cad 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -810,7 +810,7 @@ static int cs35l45_exit_hibernate(struct cs35l45_private *cs35l45)
 	return -ETIMEDOUT;
 }
 
-static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
+static int cs35l45_runtime_suspend(struct device *dev)
 {
 	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
 
@@ -827,7 +827,7 @@ static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l45_runtime_resume(struct device *dev)
+static int cs35l45_runtime_resume(struct device *dev)
 {
 	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
 	int ret;
@@ -1289,10 +1289,9 @@ void cs35l45_remove(struct cs35l45_private *cs35l45)
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
2.43.0


