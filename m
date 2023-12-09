Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F380B65D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjLIUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:53:59 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD610E;
        Sat,  9 Dec 2023 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155244;
        bh=S3lSsYPoY4wxI/kfv2j5W1QtfvDEhUSxemjQq9PNSFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hb1tucFHItmP7GsGeZj9EpHQRCoVyF11SXdZd42UQ5ol0CfZuSRvqsX3ireCuF0Tn
         w3ccJBSXwAjX9zHCQzntJNUSCeUi1MVMlJBn5fyP68U2dSoR0p/93kzVCBpTyFGxOZ
         FwDYDBP0ivhNJ28/pG0VqANtnlWBgzs5qiKq+T0Dj3KqCVUX39z7kJPC2VdNG4O9eD
         0u9O8jMxitu1GmLvba9EAl8rqIfSoLhXArkvnvAhfE9J5qAkmOO2GJwA/H8j0XqVrN
         hVG9eEtBQxXkfPkp6VCW+JyO9D/1UzcYDPFaOg7eP3f+Q7AAeB6jf9LJ8PDxx/Z4LJ
         o5zhXPq96KnEQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5E99937813DB;
        Sat,  9 Dec 2023 20:54:04 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 02/11] ASoC: amd: acp: Make use of existing *_CODEC_DAI macros
Date:   Sat,  9 Dec 2023 22:53:41 +0200
Message-ID: <20231209205351.880797-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic ACP machine driver provides macros for NAU88221 and MAX98388
codec DAI names, but in places it is still using directly the related
strings.

For consistency, replace all strings with the equivalent macros.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index c90ec3419247..346f7514c81a 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -821,8 +821,8 @@ static const struct snd_soc_ops acp_card_maxim_ops = {
 };
 
 SND_SOC_DAILINK_DEF(max98388,
-		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ADS8388:00", "max98388-aif1"),
-				       COMP_CODEC("i2c-ADS8388:01", "max98388-aif1")));
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ADS8388:00", MAX98388_CODEC_DAI),
+				       COMP_CODEC("i2c-ADS8388:01", MAX98388_CODEC_DAI)));
 
 static const struct snd_kcontrol_new max98388_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Left Spk"),
@@ -1273,7 +1273,7 @@ static const struct snd_soc_ops acp_8821_ops = {
 
 SND_SOC_DAILINK_DEF(nau8821,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00",
-						  "nau8821-hifi")));
+						  NAU8821_CODEC_DAI)));
 
 /* Declare DMIC codec components */
 SND_SOC_DAILINK_DEF(dmic_codec,
-- 
2.43.0

