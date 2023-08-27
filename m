Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0778A21F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjH0Vx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjH0Vw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:52:57 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6816CCA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:52:54 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id F292C16C0048;
        Mon, 28 Aug 2023 00:52:51 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ceTVD1IBz36t; Mon, 28 Aug 2023 00:52:50 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693173170; bh=6BcomEVXBnyGVNvp37g8chRLmborGpJ522tSsRO/bp4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BfBlv4spIVT/S4AEPl9XyT1IsxwYCVZaf3glumRJUNyjT0p+QAztdNVmYgfCk3BSg
         dgfLxXHTSfc3DXUmlGbcEdiFOeYtS4awPtDQEz/f953NbrCsu/s26vlvPZ2UMeQdhr
         LZyqEAs0iwYJuFGk/tX3k9tljvhELE2eT1Z0PhhY=
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: es8316: Enable support for MCLK div by 2
In-Reply-To: <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-3-posteuca@mutex.one>
 <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk>
Date:   Mon, 28 Aug 2023 00:50:45 +0300
Message-ID: <87msyc9mtm.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:


> Given that the datasheet quotes a maximum MCLK of 51.2MHz I suspect that
> this is far too high and that performance is degrading well before this
> point, it sounds like it just so happens that you noticed issues on a
> machine with this MCLK rather than that's based on the spec.  I would
> instead suggest applying the MCLK divider in any case where we can do so
> and still generate suitable clocking for the rest of the system, or at
> least hit 256fs (the datasheet quotes 256/384fs on the front page which
> suggests it's targetting 256fs, that'd be a fairly normal number, and
> there's mention of 12/24MHz USB clocks being directly usable).  Doing
> this should either make no odds or result in better performance.

Not 100% sure what checks should be done for a MCLK to determine if it
generates suitable clocking. Would something along this patch make
sense?

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index a8f347f1affb..667648de8105 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -470,19 +470,36 @@ static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
 	u8 bclk_divider;
 	u16 lrck_divider;
 	int i;
+	unsigned int clk = es8316->sysclk / 2;
+	bool clk_valid = false;
+
+	do {
+		/* Validate supported sample rates that are autodetected from MCLK */
+		for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
+			const unsigned int ratio = supported_mclk_lrck_ratios[i];
+
+			if (clk % ratio != 0)
+				continue;
+			if (clk / ratio == params_rate(params))
+				break;
+		}
+		if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS) {
+			if (clk == es8316->sysclk)
+				return -EINVAL;
+			else
+				clk = es8316->sysclk;
+		} else {
+			clk_valid = true;
+		}
+	} while(!clk_valid);
 
-	/* Validate supported sample rates that are autodetected from MCLK */
-	for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
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
-	if (i == NR_SUPPORTED_MCLK_LRCK_RATIOS)
-		return -EINVAL;
-	lrck_divider = es8316->sysclk / params_rate(params);
+
+	lrck_divider = clk / params_rate(params);
 	bclk_divider = lrck_divider / 4;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:

