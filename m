Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436175E6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGXBXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGXBWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0CE66;
        Sun, 23 Jul 2023 18:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DEA960F05;
        Mon, 24 Jul 2023 01:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90E7C433C7;
        Mon, 24 Jul 2023 01:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161699;
        bh=YjmouUrr+1cMf8auTWXQnuNA3sNRN3GciSUrytcu4/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEe3b/QgOKfL2sUR8y8ELXj9UDjwq9sVYmPLYrfCXxP8li004HPprZCWDQ6RWAky6
         zIsD6+FhnzbyUOdPf1BbCW9cweFdqzbDHQYGy8CKmmBj03LIovmLUDh8ZfiTm07bAb
         WUlRtc4zGVqc4XWL+VD7Xc9958ncOSkQS6vyc3tA3K5d0O+QZOD8yE9d4y9n+KCtIb
         qA38fFj9vM/x7CP0ipBHy0EBpfhT49KWlL42GlyrWKpyafPNC/slbkhRDEGR1qt/QY
         ArHrpu9Qj1ouCksww8Vr0wAh0/wYJcsU/E4/jW6adk9XzWLHHRXAtaYVD7sR70Xwkm
         rlsWBaFJikyVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 06/41] ALSA: emu10k1: roll up loops in DSP setup code for Audigy
Date:   Sun, 23 Jul 2023 21:20:39 -0400
Message-Id: <20230724012118.2316073-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 8cabf83c7aa54530e699be56249fb44f9505c4f3 ]

There is no apparent reason for the massive code duplication.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Link: https://lore.kernel.org/r/20230510173917.3073107-3-oswald.buddenhagen@gmx.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/emu10k1/emufx.c | 112 +++-----------------------------------
 1 file changed, 9 insertions(+), 103 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 6cf7c8b1de47d..4ca65f425f39c 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1563,14 +1563,8 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	gpr += 2;
 
 	/* Master volume (will be renamed later) */
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS));
+	for (z = 0; z < 8; z++)
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "Wave Master Playback Volume", gpr, 0);
 	gpr += 2;
 
@@ -1654,102 +1648,14 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			dev_dbg(emu->card->dev, "emufx.c: gpr=0x%x, tmp=0x%x\n",
 			       gpr, tmp);
 			*/
-			/* For the EMU1010: How to get 32bit values from the DSP. High 16bits into L, low 16bits into R. */
-			/* A_P16VIN(0) is delayed by one sample,
-			 * so all other A_P16VIN channels will need to also be delayed
-			 */
-			/* Left ADC in. 1 of 2 */
 			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0) );
-			/* Right ADC in 1 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			/* Delaying by one sample: instead of copying the input
-			 * value A_P16VIN to output A_FXBUS2 as in the first channel,
-			 * we use an auxiliary register, delaying the value by one
-			 * sample
-			 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x1), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x2), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x3), A_C_00000000, A_C_00000000);
-			/* For 96kHz mode */
-			/* Left ADC in. 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x4), A_C_00000000, A_C_00000000);
-			/* Right ADC in 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x5), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x6), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x7), A_C_00000000, A_C_00000000);
-			/* Pavel Hofman - we still have voices, A_FXBUS2s, and
-			 * A_P16VINs available -
-			 * let's add 8 more capture channels - total of 16
-			 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x10));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x8),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x12));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x9),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x14));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xa),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x16));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xb),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x18));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xc),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1a));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xd),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1c));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xe),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1e));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xf),
-			     A_C_00000000, A_C_00000000);
+			/* A_P16VIN(0) is delayed by one sample, so all other A_P16VIN channels
+			 * will need to also be delayed; we use an auxiliary register for that. */
+			for (z = 1; z < 0x10; z++) {
+				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr), A_FXBUS2(z * 2) );
+				A_OP(icode, &ptr, iACC3, A_GPR(gpr), A_P16VIN(z), A_C_00000000, A_C_00000000);
+				gpr_map[gpr++] = 0x00000000;
+			}
 		}
 
 #if 0
-- 
2.39.2

