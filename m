Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE24578CF53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbjH2WBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbjH2WBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:01:31 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17019A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:01:28 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 2155016C0048;
        Wed, 30 Aug 2023 01:01:27 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nbl6XnZaHL6p; Wed, 30 Aug 2023 01:01:25 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693346485; bh=SprIKnjxd+XbEfV+ec+7dXXthO9g9LD+yn4zC/aX/LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkqSsDP1U4E46wv7YhtutIxrTZxLoza5ePPRHLpcvq6X4374KOvMMeGuYcHwvQnZl
         NrCHGd+Xg3T8gFY69eNqQ1ZoUF171ZVjyZ5+x3IyrUV3eKLL1d+upjKWAGxXXBJDcb
         4HNOfMEhGZ2ZXMJx8QqPyVluWZjYTTDA0A3NyqHM=
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH v3 3/5] ASoC: es8316: Enable support for MCLK div by 2
Date:   Wed, 30 Aug 2023 01:01:14 +0300
Message-ID: <20230829220116.1159-4-posteuca@mutex.one>
In-Reply-To: <20230829220116.1159-1-posteuca@mutex.one>
References: <20230829220116.1159-1-posteuca@mutex.one>
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

To properly support a line of Huawei laptops with an AMD CPU
and an ES8336 codec connected to the ACP3X module, we need
to enable the codec option to divide the MCLK by 2.
This is needed because for at least one SKU that has a 48Mhz
MCLK the sound is distorted unless the MCLK div by 2 option
is enabled.

The option to divide the MCLK will first be tried. If no suitable
clocking can be generated from this frequency, then the normal
non-halved MCLK frequency will be tried.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/codecs/es8316.c | 45 +++++++++++++++++++++++++++++----------
 sound/soc/codecs/es8316.h |  3 +++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index a1c3e10c3cf1..e53b2856d625 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -469,19 +469,42 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	u8 bclk_divider;
 	u16 lrck_divider;
 	int i;
+	unsigned int clk = es8316->sysclk / 2;
+	bool clk_valid = false;
+
+	/* We will start with halved sysclk and see if we can use it
+	 * for proper clocking. This is to minimise the risk of running
+	 * the CODEC with a too high frequency. We have an SKU where
+	 * the sysclk frequency is 48Mhz and this causes the sound to be
+	 * sped up. If we can run with a halved sysclk, we will use it,
+	 * if we can't use it, then full sysclk will be used.
+	 */
+	do {
+		/* Validate supported sample rates that are autodetected from MCLK */
+		for (i = 0; i < ARRAY_SIZE(supported_mclk_lrck_ratios); i++) {
+			const unsigned int ratio = supported_mclk_lrck_ratios[i];
+
+			if (clk % ratio != 0)
+				continue;
+			if (clk / ratio == params_rate(params))
+				break;
+		}
+		if (i == ARRAY_SIZE(supported_mclk_lrck_ratios)) {
+			if (clk == es8316->sysclk)
+				return -EINVAL;
+			clk = es8316->sysclk;
+		} else {
+			clk_valid = true;
+		}
+	} while (!clk_valid);
 
-	/* Validate supported sample rates that are autodetected from MCLK */
-	for (i = 0; i < ARRAY_SIZE(supported_mclk_lrck_ratios); i++) {
-		const unsigned int ratio = supported_mclk_lrck_ratios[i];
-
-		if (es8316->sysclk % ratio != 0)
-			continue;
-		if (es8316->sysclk / ratio == params_rate(params))
-			break;
+	if (clk != es8316->sysclk) {
+		snd_soc_component_update_bits(component, ES8316_CLKMGR_CLKSW,
+					      ES8316_CLKMGR_CLKSW_MCLK_DIV,
+					      ES8316_CLKMGR_CLKSW_MCLK_DIV);
 	}
-	if (i == ARRAY_SIZE(supported_mclk_lrck_ratios))
-		return -EINVAL;
-	lrck_divider = es8316->sysclk / params_rate(params);
+
+	lrck_divider = clk / params_rate(params);
 	bclk_divider = lrck_divider / 4;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
diff --git a/sound/soc/codecs/es8316.h b/sound/soc/codecs/es8316.h
index c335138e2837..0ff16f948690 100644
--- a/sound/soc/codecs/es8316.h
+++ b/sound/soc/codecs/es8316.h
@@ -129,4 +129,7 @@
 #define ES8316_GPIO_FLAG_GM_NOT_SHORTED		0x02
 #define ES8316_GPIO_FLAG_HP_NOT_INSERTED	0x04
 
+/* ES8316_CLKMGR_CLKSW */
+#define ES8316_CLKMGR_CLKSW_MCLK_DIV	0x80
+
 #endif
-- 
2.41.0

