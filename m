Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D27979E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbjIGRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbjIGRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0C1FCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:25:13 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 108A766072F2;
        Thu,  7 Sep 2023 18:10:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694106639;
        bh=cWhyxr36AR1ENWdvICbtj9KTZjepyfpK32OIZ3BkWNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtPR6rLopKNclAGAVCXqFCW9nGaB3Xb/6gDidhUwHzU52KEBQGLdxxAI5kHDAzSBU
         /x603gTM7glnFUTXtS7wKnDTYlfX6YSpXlNm5/CxueuRjXmnRtFhc2D+2dP+P37WTA
         +NsYeSpoIeBDrYsAJk9yQvZteniuRxdu7B1sY9YrDjEvX/5qKHMJBUicucpHMjoZmz
         IkXbwnExBOKQT3ZAkYF211ybeixARg5n7B8bHPdncgobgU7l5KoC2ATgTam9X/LHO3
         +CBOOCtOq9N9jg94LIKO+fdLAigcEFKwUYNiohNIPSQ8l91pXYI/jQD91zoTZVqp3m
         cg0v7ncMNUO/Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 08/11] ASoC: cs35l41: Use modern pm_ops
Date:   Thu,  7 Sep 2023 20:10:07 +0300
Message-ID: <20230907171010.1447274-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
References: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
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
index 7ddaa9bd8911..4bc64ba71cd6 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1368,7 +1368,7 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
 }
 EXPORT_SYMBOL_GPL(cs35l41_remove);
 
-static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
+static int cs35l41_runtime_suspend(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1385,7 +1385,7 @@ static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
+static int cs35l41_runtime_resume(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 	int ret;
@@ -1414,7 +1414,7 @@ static int __maybe_unused cs35l41_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_suspend(struct device *dev)
+static int cs35l41_sys_suspend(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1424,7 +1424,7 @@ static int __maybe_unused cs35l41_sys_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_suspend_noirq(struct device *dev)
+static int cs35l41_sys_suspend_noirq(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1434,7 +1434,7 @@ static int __maybe_unused cs35l41_sys_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_resume_noirq(struct device *dev)
+static int cs35l41_sys_resume_noirq(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1444,7 +1444,7 @@ static int __maybe_unused cs35l41_sys_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cs35l41_sys_resume(struct device *dev)
+static int cs35l41_sys_resume(struct device *dev)
 {
 	struct cs35l41_private *cs35l41 = dev_get_drvdata(dev);
 
@@ -1454,13 +1454,12 @@ static int __maybe_unused cs35l41_sys_resume(struct device *dev)
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

