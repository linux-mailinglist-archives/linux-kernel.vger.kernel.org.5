Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3175B014
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjGTNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjGTNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55102727
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K6Acqd016432;
        Thu, 20 Jul 2023 08:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=SouSdl0krn87qnxGImLLbDeHt3AjI3/2rWOxCps/3Ts=; b=
        csSq7RS949aMbRTm92yJE/lh1RQ6faqHP0AXFhsOUbKuMQ8icvCpKr6BpeYf5b2N
        lvba1gzac5gr+Iz2vAYi5X8OzNzN0ue9yRruoLs2a/PTzYwRY28sArnG6HwF9bVO
        1NVfgVYlWkXp7Zb+7cXfFJKlFd8zsZoC4Q6KOOfdIv65FTsgx+nXLOHbcjud110z
        KnYEdc1IulsGdbn3yhUZmFHX/pUILMz3zolIciTkBWHprk+9eGbzWG9oK4D2SdSH
        lxmmx50FOZQnU0qSjZuudAfDq+MSwbQjC8P4iq6MhB3+UTi/jS0UBE7jjd6kPuin
        JMEU3LWB+wX1nf8MedWZvQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 20 Jul 2023 14:32:12 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E76A53563;
        Thu, 20 Jul 2023 13:32:11 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 11/11] ALSA: hda: cs35l41: Ensure amp is only unmuted during playback
Date:   Thu, 20 Jul 2023 14:31:47 +0100
Message-ID: <20230720133147.1294337-12-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: o6pVmOxNJF9GblLfmDxfvyfRPM7p9JtK
X-Proofpoint-GUID: o6pVmOxNJF9GblLfmDxfvyfRPM7p9JtK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we only mute after playback has finished, and unmute
prior to setting global enable. To prevent any possible pops
and clicks, mute at probe, and then only unmute after global
enable is set.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 175378cdf9dfa..98feb5ccd5866 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -58,8 +58,6 @@ static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
 	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
 	{ CS35L41_DSP1_RX5_SRC,         0x00000020 }, // DSP1RX5 SRC = ERRVOL
-	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00008000 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB
-	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
 };
 
 static const struct reg_sequence cs35l41_hda_config_dsp[] = {
@@ -82,6 +80,14 @@ static const struct reg_sequence cs35l41_hda_config_dsp[] = {
 	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
 	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
 	{ CS35L41_DSP1_RX5_SRC,         0x00000029 }, // DSP1RX5 SRC = VBSTMON
+};
+
+static const struct reg_sequence cs35l41_hda_unmute[] = {
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00008000 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB
+	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
+};
+
+static const struct reg_sequence cs35l41_hda_unmute_dsp[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00008000 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000233 }, // AMP_GAIN_PCM = 17.5dB AMP_GAIN_PDM = 19.5dB
 };
@@ -522,6 +528,13 @@ static void cs35l41_hda_play_done(struct device *dev)
 
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1, NULL,
 			      cs35l41->firmware_running);
+	if (cs35l41->firmware_running) {
+		regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
+				       ARRAY_SIZE(cs35l41_hda_unmute_dsp));
+	} else {
+		regmap_multi_reg_write(reg, cs35l41_hda_unmute,
+				       ARRAY_SIZE(cs35l41_hda_unmute));
+	}
 }
 
 static void cs35l41_hda_pause_start(struct device *dev)
@@ -1616,6 +1629,11 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (ret)
 		goto err;
 
+	ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_hda_mute,
+				     ARRAY_SIZE(cs35l41_hda_mute));
+	if (ret)
+		goto err;
+
 	INIT_WORK(&cs35l41->fw_load_work, cs35l41_fw_load_work);
 	mutex_init(&cs35l41->fw_mutex);
 
-- 
2.34.1

