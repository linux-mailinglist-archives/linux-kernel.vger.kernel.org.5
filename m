Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6797878C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbjHXTjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243442AbjHXTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:39:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B324D1FF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:38:44 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4427D6607274;
        Thu, 24 Aug 2023 20:38:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692905922;
        bh=ShbjzuzSvNRLi7HZPR7I5m3AUowqtQJIB0coO7efFes=;
        h=From:To:Cc:Subject:Date:From;
        b=bXCzVVRa4paJGN/WL5847HMBA9MLps+OM8opoXmyaf28EL3wyYfJdeoLazNig7iq9
         KhM45eB12S9gwOcvg6VpPM+5Dqz4OIA3EnutXSP7YzVd1Rb3u6OkYdgalGxhMePVKm
         Q9gQVYbqfOvmQ6G8BV2RtW9a1Xj/njv7PWa6gEQvkbqqdDc21Ea8JeqJPVf10CYALw
         QYoBrkxS4bFkEoWehEd466EDcmPwW4SCLvuES5kGzBHq6mCEDb1UrKCi7S8cTSnQkf
         pdbThzZgSkXetQrtTe24yPeu/vfrv4cr+ndbLy2KkcLxvAEr0FCIKoXrm4BVh2TqQE
         7R3mwV41/EqqA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] ASoC: soc-core.c: Do not error if a DAI link component is not found
Date:   Thu, 24 Aug 2023 22:38:37 +0300
Message-ID: <20230824193837.369761-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
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

A recent cleanup of soc_dai_link_sanity_check() is responsible for
generating lots of confusing errors before returning -EPROBE_DEFER:

  acp5x_mach acp5x_mach.0: ASoC: Component acp5x_i2s_dma.0 not found for link acp5x-8821-play
  [...]
  acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:00 not found for link acp5x-CS35L41-Stereo
  [...]
  acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:01 not found for link acp5x-CS35L41-Stereo

Switch back to the initial behaviour of logging those messages on
KERN_DEBUG level instead of KERN_ERR.

While at it, use the correct form of the verb in 'component_not_find'
label.

Fixes: 0e66a2c69409 ("ASoC: soc-core.c: cleanup soc_dai_link_sanity_check()")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/soc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5b96c17633a..cc442c52cdea 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -942,7 +942,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * component list.
 		 */
 		if (!soc_find_component(dlc))
-			goto component_not_find;
+			goto component_not_found;
 	}
 
 	/* Platform check */
@@ -963,7 +963,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * component list.
 		 */
 		if (!soc_find_component(dlc))
-			goto component_not_find;
+			goto component_not_found;
 	}
 
 	/* CPU check */
@@ -988,7 +988,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 			 * Defer card registration if Component is not added
 			 */
 			if (!soc_find_component(dlc))
-				goto component_not_find;
+				goto component_not_found;
 		}
 	}
 
@@ -1002,8 +1002,8 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 	dev_err(card->dev, "ASoC: Neither Component name/of_node are set for %s\n", link->name);
 	return -EINVAL;
 
-component_not_find:
-	dev_err(card->dev, "ASoC: Component %s not found for link %s\n", dlc->name, link->name);
+component_not_found:
+	dev_dbg(card->dev, "ASoC: Component %s not found for link %s\n", dlc->name, link->name);
 	return -EPROBE_DEFER;
 
 dai_empty:
-- 
2.41.0

