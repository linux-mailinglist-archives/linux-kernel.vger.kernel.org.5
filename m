Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E778CF55
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjH2WBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbjH2WBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:01:30 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56583194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:01:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id D79EF16C0055;
        Wed, 30 Aug 2023 01:01:25 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P4aYD75tWZSX; Wed, 30 Aug 2023 01:01:24 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693346484; bh=LABLKY8cGdghJhYahx98998a8gcU3xlpMvrXzGnf6a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFvBbT2fFvhcNjvMZZJV6XHR214q10qz2f3nbDu7BhKVyhEeZjWUr15pfX7ZZUBXf
         vzVSFPPYzR+0pBXXGw6+4ab35uuxPkxjasoSjGOvXOSlmi6kU1M7SnX2pHah+4pN/M
         NEc+xm4nN6RruGgrm72R3ZwJCTy5ym3MvYetq+A8=
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH v3 2/5] ASoC: es8316: Replace NR_SUPPORTED_MCLK_LRCK_RATIOS with ARRAY_SIZE()
Date:   Wed, 30 Aug 2023 01:01:13 +0300
Message-ID: <20230829220116.1159-3-posteuca@mutex.one>
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

No need for a special define since we can use ARRAY_SIZE() directly,
and won't need to worry to keep it in sync.

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 sound/soc/codecs/es8316.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 09fc0b25f600..a1c3e10c3cf1 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -27,7 +27,6 @@
  * MCLK/LRCK ratios, but we also add ratio 400, which is commonly used on
  * Intel Cherry Trail platforms (19.2MHz MCLK, 48kHz LRCK).
  */
-#define NR_SUPPORTED_MCLK_LRCK_RATIOS ARRAY_SIZE(supported_mclk_lrck_ratios)
 static const unsigned int supported_mclk_lrck_ratios[] = {
 	256, 384, 400, 500, 512, 768, 1024
 };
@@ -40,7 +39,7 @@ struct es8316_priv {
 	struct snd_soc_jack *jack;
 	int irq;
 	unsigned int sysclk;
-	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
+	unsigned int allowed_rates[ARRAY_SIZE(supported_mclk_lrck_ratios)];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
 	bool jd_inverted;
 };
@@ -382,7 +381,7 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	/* Limit supported sample rates to ones that can be autodetected
 	 * by the codec running in slave mode.
 	 */
-	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+	for (i = 0; i < ARRAY_SIZE(supported_mclk_lrck_ratios); i++) {
 		const unsigned int ratio = supported_mclk_lrck_ratios[i];
 
 		if (freq % ratio == 0)
@@ -472,7 +471,7 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i;
 
 	/* Validate supported sample rates that are autodetected from MCLK */
-	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+	for (i = 0; i < ARRAY_SIZE(supported_mclk_lrck_ratios); i++) {
 		const unsigned int ratio = supported_mclk_lrck_ratios[i];
 
 		if (es8316->sysclk % ratio != 0)
@@ -480,7 +479,7 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 		if (es8316->sysclk / ratio == params_rate(params))
 			break;
 	}
-	if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS)
+	if (i == ARRAY_SIZE(supported_mclk_lrck_ratios))
 		return -EINVAL;
 	lrck_divider = es8316->sysclk / params_rate(params);
 	bclk_divider = lrck_divider / 4;
-- 
2.41.0

