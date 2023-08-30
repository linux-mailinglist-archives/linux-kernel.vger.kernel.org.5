Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5BE78E21B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbjH3WJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244996AbjH3WJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:09:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05651BF;
        Wed, 30 Aug 2023 15:09:08 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37UHsJsY002018;
        Wed, 30 Aug 2023 14:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=KxaoXeqFYIEnZu6KbS/zohWD3joz0j1CP25czl4VYXE=; b=
        Og4455vfK5csAfTULguC6o+ZqVnJ58GyzvQKT09m/H+XWSeJGl5aVt8ghJmTc6lD
        PW8iBe8Fmd3/i+jfy5V2saroRdf7urANI7xiuwDXpnCCwOJE7SO+7BgChY9YCyn5
        mFp9lGKhW07E8ybqysh8X0OMJBB/2B2ZhYH1fGHlZaqE4jHmag628ZngZ8MuI18Q
        RHNHVmlJM/kS15aMVnAD18JyWiVurLUQASx33xIfDs+E+kZjjTJZ19Nx8pSp5Dxz
        HDImuLAdR7CjM6swlVZxlQ1C2caJNMHdQ+DHsRIBFT6276u5zjtfp6ivvvF3t5ta
        TZb6CRMxASnQ/8nZUftk3A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj4k02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 14:56:09 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 20:56:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 30 Aug 2023 20:56:07 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4CFD011D4;
        Wed, 30 Aug 2023 19:56:05 +0000 (UTC)
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: [PATCH v2 4/4] ASoC: cs35l45: Add AMP Enable Switch control
Date:   Wed, 30 Aug 2023 14:55:36 -0500
Message-ID: <20230830195536.448884-4-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
References: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KxpIFz8N4jbsvR254Sa91GY3TkSWXF_n
X-Proofpoint-GUID: KxpIFz8N4jbsvR254Sa91GY3TkSWXF_n
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "AMP Enable Switch" is useful in systems with multiple
amplifiers connected to the same audio bus
but not all of them are needed for all use cases.

Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 4abc922ef210..f8646de20c36 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -417,6 +417,8 @@ static const struct snd_kcontrol_new cs35l45_dsp_muxes[] = {
 static const struct snd_kcontrol_new cs35l45_dac_muxes[] = {
 	SOC_DAPM_ENUM("DACPCM Source", cs35l45_dacpcm_enums[0]),
 };
+static const struct snd_kcontrol_new amp_en_ctl =
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0);
 
 static const struct snd_soc_dapm_widget cs35l45_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("DSP1 Preload", NULL),
@@ -479,6 +481,8 @@ static const struct snd_soc_dapm_widget cs35l45_dapm_widgets[] = {
 
 	SND_SOC_DAPM_MUX("DACPCM Source", SND_SOC_NOPM, 0, 0, &cs35l45_dac_muxes[0]),
 
+	SND_SOC_DAPM_SWITCH("AMP Enable", SND_SOC_NOPM, 0, 0, &amp_en_ctl),
+
 	SND_SOC_DAPM_OUT_DRV("AMP", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_OUTPUT("SPK"),
@@ -586,7 +590,8 @@ static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
 
 	CS35L45_DAC_MUX_ROUTE("DACPCM"),
 
-	{ "SPK", NULL, "AMP"},
+	{ "AMP Enable", "Switch", "AMP" },
+	{ "SPK", NULL, "AMP Enable"},
 };
 
 static const char * const amplifier_mode_texts[] = {"SPK", "RCV"};
-- 
2.25.1

