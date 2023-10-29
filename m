Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E77DAF30
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjJ2W5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjJ2W5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:57:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB02D75;
        Sun, 29 Oct 2023 15:56:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC49C43397;
        Sun, 29 Oct 2023 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620168;
        bh=YP/Bagg/FmJOMvQhIt3xBhDBmQHqsMT6vRhRKIcACBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbKWAu/Qc0Mg5kGqTfTYH6w2YCyhKwnv/fIZiFBTTy2IW1BZi5xcuyBpU56eo0Y8H
         31gzECFAbH2jtQFCltuxJkXlvQCMvDOFB+8LGrW4Y9C8SjG92+1HFZeSkpyvYqwIaX
         KgyZEJ51Z+LMuJRF1sIOi1lQ9XDpsDIqIFOHpMW5Hd521UscsHNzfborkK+ix3m+Lh
         VBm4I0KL61Ks0KafE+OGZ8wLYcU/fVFztt2TtBzH6XyXiRTLCCRN4yMGAbeLjPmq8f
         DIf0uFgv88XGSFd/pHrBZX+AmBYBbvgpZl3VdLTzDwA3o5vVojZfELUf2Ng9MEhWld
         XAZgsfsn8PbWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 37/52] ASoC: da7219: Correct the process of setting up Gnd switch in AAD
Date:   Sun, 29 Oct 2023 18:53:24 -0400
Message-ID: <20231029225441.789781-37-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rau <David.Rau.opensource@dm.renesas.com>

[ Upstream commit e8ecffd9962fe051d53a0761921b26d653b3df6b ]

Enable Gnd switch to improve stability when Jack insert event
occurs, and then disable Gnd switch after Jack type detection
is finished.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
Link: https://lore.kernel.org/r/20231017021258.5929-1-David.Rau.opensource@dm.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 581b334a6631d..3bbe850916493 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -59,9 +59,6 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 	bool micbias_up = false;
 	int retries = 0;
 
-	/* Disable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
-
 	/* Drive headphones/lineout */
 	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
 			    DA7219_HP_L_AMP_OE_MASK,
@@ -155,9 +152,6 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ_INT_OSC);
 	}
 
-	/* Disable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
-
 	/* Ensure gain ramping at fastest rate */
 	gain_ramp_ctrl = snd_soc_component_read(component, DA7219_GAIN_RAMP_CTRL);
 	snd_soc_component_write(component, DA7219_GAIN_RAMP_CTRL, DA7219_GAIN_RAMP_RATE_X8);
@@ -421,6 +415,11 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			 * handle a removal, and we can check at the end of
 			 * hptest if we have a valid result or not.
 			 */
+
+			cancel_delayed_work_sync(&da7219_aad->jack_det_work);
+			/* Disable ground switch */
+			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
+
 			if (statusa & DA7219_JACK_TYPE_STS_MASK) {
 				report |= SND_JACK_HEADSET;
 				mask |=	SND_JACK_HEADSET | SND_JACK_LINEOUT;
-- 
2.42.0

