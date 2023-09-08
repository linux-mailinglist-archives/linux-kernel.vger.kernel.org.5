Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E93798FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbjIHTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbjIHTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:33:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE610EC;
        Fri,  8 Sep 2023 12:33:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D398C433AD;
        Fri,  8 Sep 2023 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201534;
        bh=XHZQEu/v99UNJEaKd/BeELyfqK4Oapl8sSK9J0/MXt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9CsGjPVDlPNp52zLylWSAsWG83zc/rWdn78rfCetY5Ntqp8X6LcRZjC/mWvP4mQ5
         KbXDrAUxsF8XwplLtOQyDn6Rjum2i3WHhXJkYPG+jz8KQTrU/d9KLvUmWFiZ9XW+Of
         rafp8v4TjnMUCcb+M4lvSf3U4/OCwloRFTg69opSYX9Ua5a9zR5tSjnTc22Gbhswwi
         1BQnj3st2yUauFFJE4nkgkyCTbkGUrqcnx+lsIQCq2qlm+0Ta4iR5df6L4Y50b6hzn
         VWjel5H/qmh3LhoELyqtx4+eH7DjT0tZ5UvJcOQ2EzMc9EREFaFxySIrRSvFKnRijx
         HJB7gGKWdfQ7g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, lucas.tanure@collabora.com,
        pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 04/31] ASoC: amd: vangogh: Use dmi_first_match() for DMI quirk handling
Date:   Fri,  8 Sep 2023 15:31:33 -0400
Message-Id: <20230908193201.3462957-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 3dd26e27ccb4f18b4d25c0a49e1888eca9c6a724 ]

In preparation for supporting ACPI probing, move DMI quirk handling
logic at the probe's top, to be able to return as quickly as possible in
case there is no DMI matching.

Additionally, simplify the code by replacing dmi_check_system() and
related callback with dmi_first_match(). While at it, also drop a few
unnecessary empty lines.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20230705214800.193244-3-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index e5bcd1e6eb73a..7040809b24729 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -22,7 +22,6 @@
 
 #define DRV_NAME			"acp5x_mach"
 #define DUAL_CHANNEL			2
-#define VG_JUPITER			1
 #define ACP5X_NAU8821_BCLK		3072000
 #define ACP5X_NAU8821_FREQ_OUT		12288000
 #define ACP5X_NAU8821_COMP_NAME 	"i2c-NVTN2020:00"
@@ -31,7 +30,6 @@
 #define ACP5X_CS35L41_COMP_RNAME	"spi-VLV1776:01"
 #define ACP5X_CS35L41_DAI_NAME		"cs35l41-pcm"
 
-static unsigned long acp5x_machine_id;
 static struct snd_soc_jack vg_headset;
 
 SND_SOC_DAILINK_DEF(platform,  DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
@@ -242,7 +240,6 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	return 0;
-
 }
 
 static const struct snd_soc_ops acp5x_cs35l41_play_ops = {
@@ -292,8 +289,6 @@ static struct snd_soc_dai_link acp5x_8821_35l41_dai[] = {
 	},
 };
 
-
-
 static const struct snd_soc_dapm_widget acp5x_8821_35l41_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -331,16 +326,8 @@ static struct snd_soc_card acp5x_8821_35l41_card = {
 	.num_controls = ARRAY_SIZE(acp5x_8821_controls),
 };
 
-static int acp5x_vg_quirk_cb(const struct dmi_system_id *id)
-{
-	acp5x_machine_id = VG_JUPITER;
-
-	return 1;
-}
-
 static const struct dmi_system_id acp5x_vg_quirk_table[] = {
 	{
-		.callback = acp5x_vg_quirk_cb,
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
@@ -351,23 +338,22 @@ static const struct dmi_system_id acp5x_vg_quirk_table[] = {
 
 static int acp5x_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct acp5x_platform_info *machine;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
 	int ret;
 
+	dmi_id = dmi_first_match(acp5x_vg_quirk_table);
+	if (!dmi_id)
+		return -ENODEV;
+
+	card = &acp5x_8821_35l41_card;
+
 	machine = devm_kzalloc(dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
-	dmi_check_system(acp5x_vg_quirk_table);
-	switch (acp5x_machine_id) {
-	case VG_JUPITER:
-		card = &acp5x_8821_35l41_card;
-		break;
-	default:
-		return -ENODEV;
-	}
 	card->dev = dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
-- 
2.40.1

