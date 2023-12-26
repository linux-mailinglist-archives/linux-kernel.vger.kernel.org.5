Return-Path: <linux-kernel+bounces-11202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E362C81E327
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692E52826E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17F27473;
	Tue, 26 Dec 2023 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJvfTL4z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8D1EB25;
	Tue, 26 Dec 2023 00:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF61C433CB;
	Tue, 26 Dec 2023 00:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550046;
	bh=66474NnbQpXbOGTsVlEmdFJME+FcWJLgFSILAVCIY2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJvfTL4zx1vmoZpe6BAe9QWa9DJP6IJWJU0grYURTmCOm6TmTXb3v6+H8uK0d3LDQ
	 +CEP4MUzv+r5HeeyihXYjJCxifu3IphDsUM6/TRdJxdInYBw3CEaZ0tEn/c2FTdyXh
	 eNuovKR6nw4G5Qw505tjvC0xCuWdNWW/dogkPZY768CbOBq8Mat7IoR7T/ycRRXFZS
	 /41xTNu/CRnyLlgh5Aeq57oeTaDtMh0USyeP0RuDMMjRUtc6I16oFeer72/Yvj2nxg
	 Izkud/69V/DLbUan9BJFh3U8O/tmUa7qW5DvSGQiQx883QNQgjV8TpToc4BLmHjs2k
	 6xA6FT0TDbFiw==
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
Subject: [PATCH AUTOSEL 6.6 09/39] ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
Date: Mon, 25 Dec 2023 19:18:59 -0500
Message-ID: <20231226002021.4776-9-sashal@kernel.org>
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

[ Upstream commit c3c8b088949b9ccb88da2f84d3c3cc06580a6a43 ]

Use the SYSTEM_SLEEP_PM_OPS handlers to prevent handling an IRQ
when the system is in the middle of suspending or resuming.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231206160318.1255034-3-rriveram@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l45.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index b1d0f2c8f2cad..310747b7689d3 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -854,6 +854,46 @@ static int cs35l45_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int cs35l45_sys_suspend(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "System suspend, disabling IRQ\n");
+	disable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_suspend_noirq(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "Late system suspend, reenabling IRQ\n");
+	enable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_resume_noirq(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "Early system resume, disabling IRQ\n");
+	disable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_resume(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "System resume, reenabling IRQ\n");
+	enable_irq(cs35l45->irq);
+
+	return 0;
+}
+
 static int cs35l45_apply_property_config(struct cs35l45_private *cs35l45)
 {
 	struct device_node *node = cs35l45->dev->of_node;
@@ -1291,6 +1331,9 @@ EXPORT_SYMBOL_NS_GPL(cs35l45_remove, SND_SOC_CS35L45);
 
 EXPORT_GPL_DEV_PM_OPS(cs35l45_pm_ops) = {
 	RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
+
+	SYSTEM_SLEEP_PM_OPS(cs35l45_sys_suspend, cs35l45_sys_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l45_sys_suspend_noirq, cs35l45_sys_resume_noirq)
 };
 
 MODULE_DESCRIPTION("ASoC CS35L45 driver");
-- 
2.43.0


