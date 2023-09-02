Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7055F7909AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjIBVHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjIBVHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:07:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324719A9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:51 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28AF36607285;
        Sat,  2 Sep 2023 22:06:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688810;
        bh=tEMH7gxlfQzbbvPh3ZrLYJvkNudGdOtShkFuAU3tALI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJ/DMTDrah6kmvoCynnPx55LbGjSsfuv3LEMVpJa7qO2g2opQzLprOlevTQF+2aJF
         C9QDwpxmEjCEQAB9GhHJ5OGItG7HVJ8YiWq4cZBfpFFIH9gSjAgGFNmVTeh2YKFh2w
         Iev2PKqBF9qU+LuB3hATvVTw4MhXMJ4mboJGZE3LbVDaNrCJXpmWvqWslXnZ21EevW
         68I/KSw4IYn/kmn5ZbWgPGkTT0dJI8SoA7ZTUngJ66JA+q772vdCFZANDZZiTRpLtX
         4LOmh+G7fbQpVit2S7qbZorb6Xg8EIfv+uYjVzV56fsj7vrmPqixR8TbN+4Huc5kHg
         OG3u4H2Iaj1aQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 8/9] ASoC: cs35l41: Use modern pm_ops
Date:   Sun,  3 Sep 2023 00:06:20 +0300
Message-ID: <20230902210621.1184693-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

ERROR: modpost: "cs35l41_pm_ops" [sound/soc/codecs/snd-soc-cs35l41-spi.ko] undefined!
ERROR: modpost: "cs35l41_pm_ops" [sound/soc/codecs/snd-soc-cs35l41-i2c.ko] undefined!

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41-i2c.c |  2 +-
 sound/soc/codecs/cs35l41-spi.c |  2 +-
 sound/soc/codecs/cs35l41.c     | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-i2c.c b/sound/soc/codecs/cs35l41-i2c.c
index 9109203a7f25..96414ee35285 100644
--- a/sound/soc/codecs/cs35l41-i2c.c
+++ b/sound/soc/codecs/cs35l41-i2c.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_match);
 static struct i2c_driver cs35l41_i2c_driver = {
 	.driver = {
 		.name		= "cs35l41",
-		.pm		= &cs35l41_pm_ops,
+		.pm		= pm_ptr(&cs35l41_pm_ops),
 		.of_match_table = of_match_ptr(cs35l41_of_match),
 		.acpi_match_table = ACPI_PTR(cs35l41_acpi_match),
 	},
diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index 28e9c9473e60..a6db44520c06 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_match);
 static struct spi_driver cs35l41_spi_driver = {
 	.driver = {
 		.name		= "cs35l41",
-		.pm		= &cs35l41_pm_ops,
+		.pm		= pm_ptr(&cs35l41_pm_ops),
 		.of_match_table = of_match_ptr(cs35l41_of_match),
 		.acpi_match_table = ACPI_PTR(cs35l41_acpi_match),
 	},
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 66418547a4dd..5655758063ae 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1394,7 +1394,7 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
 }
 EXPORT_SYMBOL_GPL(cs35l41_remove);
 
-static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
+static int cs35l41_runtime_suspend(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1411,7 +1411,7 @@ static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
+static int cs35l41_runtime_resume(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 	int ret;
@@ -1440,7 +1440,7 @@ static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_suspend(struct device *dev)
+static int cs35l41_sys_suspend(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1450,7 +1450,7 @@ static int __maybe_unused cs35l41_sys_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_suspend_noirq(struct device *dev)
+static int cs35l41_sys_suspend_noirq(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1460,7 +1460,7 @@ static int __maybe_unused cs35l41_sys_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_resume_noirq(struct device *dev)
+static int cs35l41_sys_resume_noirq(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1470,7 +1470,7 @@ static int __maybe_unused cs35l41_sys_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_resume(struct device *dev)
+static int cs35l41_sys_resume(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1480,13 +1480,12 @@ static int __maybe_unused cs35l41_sys_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops cs35l41_pm_ops = {
-	SET_RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
+EXPORT_GPL_DEV_PM_OPS(cs35l41_pm_ops) = {
+	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
 
-	SET_SYSTEM_SLEEP_PM_OPS(cs35l41_sys_suspend, cs35l41_sys_resume)
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l41_sys_suspend_noirq, cs35l41_sys_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(cs35l41_sys_suspend, cs35l41_sys_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l41_sys_suspend_noirq, cs35l41_sys_resume_noirq)
 };
-EXPORT_SYMBOL_GPL(cs35l41_pm_ops);
 
 MODULE_DESCRIPTION("ASoC CS35L41 driver");
 MODULE_AUTHOR("David Rhodes, Cirrus Logic Inc, <david.rhodes@cirrus.com>");
-- 
2.41.0

