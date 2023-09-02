Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4947909AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjIBVGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjIBVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:06:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260310E0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:42 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF10866072B5;
        Sat,  2 Sep 2023 22:06:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688801;
        bh=ZFbrDlGsG1v2EjUCV6bCyGa1RigZq4UWK6ZhGbIVmVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOU3U94md0KKyLr5WS0958ZrkDv99MLMNEw9B/4NusRC+u6XlZoqvf09dEyMVKyiE
         77lY+xH6013b5Hy0fgcscC8DnauGlw5D4yIgIuY/HHH3h4sCg8aqJjQlGPaaB0A8tK
         7WVPWkQAipbRYOrVBzm8xrVkg8iJIqjrI7HevXUwEaYrzfWtysorJgCSvnsV9TnjfV
         Tv9hif395vEJy9k3OsPHVA/WeTfj1m6ejgxu21PjInTPFPqcq38p4TDaZEo23ke2fO
         VmA6hxKSEXmy012ZqepADt3dbECOC0s9AMD/T/jmOUD0EiLC/CtohvPcFJG9YkWzyn
         dvhvGRrIoTgng==
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
Subject: [PATCH 5/9] ASoC: cs35l41: Rename pll_lock to pll_lock_done
Date:   Sun,  3 Sep 2023 00:06:17 +0300
Message-ID: <20230902210621.1184693-6-cristian.ciocaltea@collabora.com>
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

Use a more intuitive name for 'pll_lock' completion, which helps
improving code readability a bit.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41.c | 8 ++++----
 sound/soc/codecs/cs35l41.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 9bf70da03972..e143b0e306b1 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -459,7 +459,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 
 	if (status[2] & CS35L41_PLL_LOCK) {
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS3, CS35L41_PLL_LOCK);
-		complete(&cs35l41->pll_lock);
+		complete(&cs35l41->pll_lock_done);
 		ret = IRQ_HANDLED;
 	}
 
@@ -804,7 +804,7 @@ static int cs35l41_pcm_startup(struct snd_pcm_substream *substream,
 {
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
 
-	reinit_completion(&cs35l41->pll_lock);
+	reinit_completion(&cs35l41->pll_lock_done);
 
 	if (substream->runtime)
 		return snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -1160,7 +1160,7 @@ static void cs35l41_mdsync_up_work(struct work_struct *work)
 	struct cs35l41_private *cs35l41 = container_of(work,
 						       struct cs35l41_private,
 						       mdsync_up_work);
-	int ret = wait_for_completion_timeout(&cs35l41->pll_lock,
+	int ret = wait_for_completion_timeout(&cs35l41->pll_lock_done,
 					      msecs_to_jiffies(100));
 	if (ret == 0) {
 		dev_err(cs35l41->dev, "Timed out waiting for pll_lock signal\n");
@@ -1303,7 +1303,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 		regmap_update_bits(cs35l41->regmap, CS35L41_IRQ1_MASK3, CS35L41_INT3_PLL_LOCK_MASK,
 				   0 << CS35L41_INT3_PLL_LOCK_SHIFT);
 
-	init_completion(&cs35l41->pll_lock);
+	init_completion(&cs35l41->pll_lock_done);
 
 	ret = devm_request_threaded_irq(cs35l41->dev, cs35l41->irq, NULL, cs35l41_irq,
 					IRQF_ONESHOT | IRQF_SHARED | irq_pol,
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index f9f85796a13a..fe61c11404e7 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -34,7 +34,7 @@ struct cs35l41_private {
 	int irq;
 	/* GPIO for /RST */
 	struct gpio_desc *reset_gpio;
-	struct completion pll_lock;
+	struct completion pll_lock_done;
 	struct work_struct mdsync_up_work;
 };
 
-- 
2.41.0

