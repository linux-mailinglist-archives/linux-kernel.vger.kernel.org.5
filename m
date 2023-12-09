Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239080B665
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjLIUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjLIUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:54:11 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B120171C;
        Sat,  9 Dec 2023 12:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155253;
        bh=C0xLCzEAO0R7G8da8+2HO7Jslwis2dNNSzbFRoiRry8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+3Y9LQ2EF/XqWMwdn3rYFEkdeec0wjfN9KT5CfsjqBo761Ajgyfusb8DkmWDDfKT
         jkc2iN/9i6IcqFtBHZRQYnxGi5g7zWC708Rgs0L79YB/v4ZVrexXk/ElU+TP70051T
         FnsobtbLEEdOrPTon+cUb19pPOZ8s1ZYGNVvaY0izNPwOYcySdJkizwSmrS9pRd1Ud
         ZErJ4/ixMM6VN2KcbnZgcyn0PI6UMnLL+j8I0xXUhsEx17u2Jg5Q0BX9oPpflLk35L
         S/PPfHOJY6EXJCDKw9dWVGROF5skYQxC0CG5j0+pZagHAE+UdwweYbLiEzCdnBGIBK
         qK8SZW1vhy0eQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE26837813EA;
        Sat,  9 Dec 2023 20:54:13 +0000 (UTC)
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
Subject: [PATCH 10/11] ASoC: amd: acp: Use correct DAI link ID for BT codec
Date:   Sat,  9 Dec 2023 22:53:49 +0200
Message-ID: <20231209205351.880797-11-cristian.ciocaltea@collabora.com>
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

Commit 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
creation for I2S BT instance") added I2S BT support in ACP common
machine driver, but using a wrong BT_BE_ID, i.e. 3 instead of 2:

[ 7.799659] snd_sof_amd_vangogh 0000:04:00.5: Firmware info: version 0:0:0-7863d
[ 7.803906] snd_sof_amd_vangogh 0000:04:00.5: Firmware: ABI 3:26:0 Kernel ABI 3:23:0
[ 7.872873] snd_sof_amd_vangogh 0000:04:00.5: Topology: ABI 3:26:0 Kernel ABI 3:23:0
[ 8.508218] sof_mach nau8821-max: ASoC: physical link acp-bt-codec (id 2) not exist
[ 8.513468] sof_mach nau8821-max: ASoC: topology: could not load header: -22
[ 8.518853] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component load failed -22
[ 8.524049] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP topology -22
[ 8.529230] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at snd_soc_component_probe on 0000:04:00.5: -22
[ 8.534465] sof_mach nau8821-max: ASoC: failed to instantiate card -22
[ 8.539820] sof_mach nau8821-max: error -EINVAL: Failed to register card(sof-nau8821-max)
[ 8.545022] sof_mach: probe of nau8821-max failed with error -22

Move BT_BE_ID to the correct position in the enum.

Fixes: 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink creation for I2S BT instance")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/acp/acp-mach.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index a48546d8d407..0c18ccd29305 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -27,8 +27,8 @@
 enum be_id {
 	HEADSET_BE_ID = 0,
 	AMP_BE_ID,
-	DMIC_BE_ID,
 	BT_BE_ID,
+	DMIC_BE_ID,
 };
 
 enum cpu_endpoints {
-- 
2.43.0

