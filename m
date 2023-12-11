Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214680CCD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbjLKOEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbjLKODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:03:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C30D65
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:01:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66004C433C8;
        Mon, 11 Dec 2023 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303312;
        bh=TuVggnxu9ShxSMN3u4mLZoB2JnPKQkI71cau9glhJFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxgKqYEUkLmd+P7h8rCQ2IB/Yr7jmmDIqiHi7i4pLFiLyVbovOlii0HBESXAZRzal
         1aFU+qB05T7jgS96u8D93eAraspKbMSOPlcHm9pEfjotEzpGfHRQGve+UcChyST0JO
         eJ53RoCOvuZsstkphzxKwi9aMB0oqVXs74RABsV5DkskSe+2moqcc1VI3KWhqSI8wa
         KqVkZORqSM1It7pZRvkZznsLZSR5KO94TNgWD55MAT9fUW6JrX9wjYt/U6u3u/q6h1
         qIDATlA2DaoDLXFkgnkopC5Hu5YHrUaeIDkKNtpdtbhSIWyxjD5wb6ysUA1Mz7rYC2
         PVUcwPb6Xph3g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        yung-chuan.liao@linux.intel.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/16] ASoC: hdac_hda: Conditionally register dais for HDMI and Analog
Date:   Mon, 11 Dec 2023 09:00:34 -0500
Message-ID: <20231211140116.391986-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit a0575b4add21a243cc3257e75ad913cd5377d5f2 ]

The current driver is registering the same dais for each hdev found in the
system which results duplicated widgets to be registered and the kernel
log contains similar prints:
snd_hda_codec_realtek ehdaudio0D0: ASoC: sink widget AIF1TX overwritten
snd_hda_codec_realtek ehdaudio0D0: ASoC: source widget AIF1RX overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi3 overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi2 overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi1 overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Codec Output Pin1 overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Codec Input Pin1 overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Analog Codec Playback overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Digital Codec Playback overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Alt Analog Codec Playback overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Analog Codec Capture overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Digital Codec Capture overwritten
skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Alt Analog Codec Capture overwritten

To avoid such issue, split the dai array into HDMI and non HDMI array and
register them conditionally:
for HDMI hdev only register the dais needed for HDMI
for non HDMI hdev do not  register the HDMI dais.

Depends-on: 3d1dc8b1030d ("ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available")
Link: https://github.com/thesofproject/linux/issues/4509
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20231128123914.3986-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index de5955db0a5f0..0bbe248c0728e 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -124,6 +124,9 @@ static struct snd_soc_dai_driver hdac_hda_dais[] = {
 		.sig_bits = 24,
 	},
 },
+};
+
+static struct snd_soc_dai_driver hdac_hda_hdmi_dais[] = {
 {
 	.id = HDAC_HDMI_0_DAI_ID,
 	.name = "intel-hdmi-hifi1",
@@ -575,8 +578,16 @@ static const struct snd_soc_component_driver hdac_hda_codec = {
 	.num_dapm_routes        = ARRAY_SIZE(hdac_hda_dapm_routes),
 };
 
+static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
+	.probe			= hdac_hda_codec_probe,
+	.remove			= hdac_hda_codec_remove,
+	.idle_bias_on		= false,
+	.endianness		= 1,
+};
+
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
+	struct hdac_hda_priv *hda_pvt = dev_get_drvdata(&hdev->dev);
 	struct hdac_ext_link *hlink;
 	struct hdac_hda_priv *hda_pvt;
 	int ret;
@@ -594,9 +605,15 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 		return -ENOMEM;
 
 	/* ASoC specific initialization */
-	ret = devm_snd_soc_register_component(&hdev->dev,
-					 &hdac_hda_codec, hdac_hda_dais,
-					 ARRAY_SIZE(hdac_hda_dais));
+	if (hda_pvt->need_display_power)
+		ret = devm_snd_soc_register_component(&hdev->dev,
+						&hdac_hda_hdmi_codec, hdac_hda_hdmi_dais,
+						ARRAY_SIZE(hdac_hda_hdmi_dais));
+	else
+		ret = devm_snd_soc_register_component(&hdev->dev,
+						&hdac_hda_codec, hdac_hda_dais,
+						ARRAY_SIZE(hdac_hda_dais));
+
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
 		return ret;
-- 
2.42.0

