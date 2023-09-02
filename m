Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210AC7909AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjIBVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjIBVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:07:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D8170B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:58 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1BBAC66072B6;
        Sat,  2 Sep 2023 22:06:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688813;
        bh=G+WVbRYmwmOF6B5vQfe9gXWVIMHqOGdNIKeuQZ/LSsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQ/ossJIPvU1/N8/hhVkj5SHf3GIFg3ann4S2qkCW5qI0OOBPItps/dGZ3GDWF27o
         K/qWgTSNAXflOjOM4iyCoyjIQzJSxYEu7PD8X3qjcs9mwruwTXDMoNOYW7jmsUtdXd
         OC7u8PlXxodjIV4NS2jQROy7CuS+Y87fXVOEJfYWuba06I/FpUhZGPRT2r1sECj3Z1
         9dQw90HkJctdngMemAR49YWNq456EyXiMbI4Gcy0quEUENoOM3ASDBGTvtx/yPUXx8
         FgXBaiE8owr5B6JwEI5TRHf1VyA3Y+rLyFE5G4XjaEJs6yGjksq4vW4j3JbJfns4D2
         teeOW9W00VSTg==
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
Subject: [PATCH 9/9] ASoC: cs35l41: Use devm_pm_runtime_enable()
Date:   Sun,  3 Sep 2023 00:06:21 +0300
Message-ID: <20230902210621.1184693-10-cristian.ciocaltea@collabora.com>
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

Simplify runtime PM during probe by converting pm_runtime_enable() to
the managed version.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 5655758063ae..2e5b4633e98d 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1340,7 +1340,12 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	pm_runtime_mark_last_busy(cs35l41->dev);
 	pm_runtime_set_active(cs35l41->dev);
 	pm_runtime_get_noresume(cs35l41->dev);
-	pm_runtime_enable(cs35l41->dev);
+
+	ret = devm_pm_runtime_enable(cs35l41->dev);
+	if (ret < 0) {
+		dev_err_probe(cs35l41->dev, ret, "Failed to enable PM runtime\n");
+		goto err_pm;
+	}
 
 	ret = devm_snd_soc_register_component(cs35l41->dev,
 					      &soc_component_dev_cs35l41,
@@ -1358,9 +1363,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	return 0;
 
 err_pm:
-	pm_runtime_disable(cs35l41->dev);
 	pm_runtime_put_noidle(cs35l41->dev);
-
 	wm_adsp2_remove(&cs35l41->dsp);
 err:
 	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
@@ -1376,7 +1379,6 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
 	cancel_work_sync(&cs35l41->mdsync_up_work);
 
 	pm_runtime_get_sync(cs35l41->dev);
-	pm_runtime_disable(cs35l41->dev);
 
 	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
 	if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS ||
-- 
2.41.0

