Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B947F5AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKWJTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWJTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:19:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FE19E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1886C433C8;
        Thu, 23 Nov 2023 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700731160;
        bh=INV4VXsAI81QuQ1I3t6WPmgl0c6clKa/3BaJIVhZGXA=;
        h=From:To:Cc:Subject:Date:From;
        b=F0JhFyVM2+BsueqEwbUbsiJI7zpElGUGGbhwNiyktyYVGV3GyH4f3LCTjpN9Z29Tp
         uhH2WNC4c3OvQZpqAP7ZVDom4noucMZ5mvFtIcAx8UTzmIXxpVL8biqaNdVnls0A2P
         k2xw4kRTC/IpYpr9GoR5INBe6vd4olAvAbcdruzuGsEbhe+h+3qcWyWoDmYuMJi/OT
         awBD8DtkO9GNwA31w8icWPi7tjr8SpwBcQRiDYPkaPq+4rlAW87ezMBB/UAHxe7p45
         jSueeQ8vMDLXarBKHQuVp/Oqj96sRrYmjrQNQPxffAxXtvOtFrdx2wwLuPG9Y8Zb/G
         Kq+ge42mcL6Zg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r65s1-0005iG-32;
        Thu, 23 Nov 2023 10:19:37 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chancel Liu <chancel.liu@nxp.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] ASoC: soc-pcm: fix up bad merge
Date:   Thu, 23 Nov 2023 10:18:15 +0100
Message-ID: <20231123091815.21933-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to address pops and clicks with codecs like WSA883X
touched the same code paths as a fix for clearing DAI parameters and
resulted in a bad merge.

Specifically, commit f0220575e65a ("ASoC: soc-dai: add flag to mute and
unmute stream during trigger") made mute at stream close conditional,
while commit 3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters
cleared if the DAI becomes inactive") moved that same mute call back to
soc_pcm_hw_clean().

Fix up the bad merge by dropping the second mute call from
soc_pcm_clean() and making sure that the call in soc_pcm_hw_clean() is
conditional as intended.

Fixes: bdb7e1922052 ("ASoC: Merge up workaround for CODECs that play noise on stopped stream")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/soc-pcm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 323e4d7b6adf..f6d1b2e11795 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -704,11 +704,6 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
 			if (snd_soc_dai_active(dai) == 0 &&
 			    (dai->rate || dai->channels || dai->sample_bits))
 				soc_pcm_set_dai_params(dai, NULL);
-
-			if (snd_soc_dai_stream_active(dai, substream->stream) ==  0) {
-				if (dai->driver->ops && !dai->driver->ops->mute_unmute_on_trigger)
-					snd_soc_dai_digital_mute(dai, 1, substream->stream);
-			}
 		}
 	}
 
@@ -947,8 +942,10 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 		if (snd_soc_dai_active(dai) == 1)
 			soc_pcm_set_dai_params(dai, NULL);
 
-		if (snd_soc_dai_stream_active(dai, substream->stream) == 1)
-			snd_soc_dai_digital_mute(dai, 1, substream->stream);
+		if (snd_soc_dai_stream_active(dai, substream->stream) == 1) {
+			if (dai->driver->ops && !dai->driver->ops->mute_unmute_on_trigger)
+				snd_soc_dai_digital_mute(dai, 1, substream->stream);
+		}
 	}
 
 	/* run the stream event */
-- 
2.41.0

