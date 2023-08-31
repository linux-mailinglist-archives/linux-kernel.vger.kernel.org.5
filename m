Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053478F120
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346797AbjHaQVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjHaQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:21:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F510C7;
        Thu, 31 Aug 2023 09:21:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37VF9lpT009908;
        Thu, 31 Aug 2023 11:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=KxaoXeqFYIEnZu6KbS/zohWD3joz0j1CP25czl4VYXE=; b=
        RGSjDTnNIyn6AtnkVYwc4q1qn6bYWmLGJtU5HELrxujRwRS4egMBi9KYpUuR+g4I
        /D488KbYcO6Lli3yI/hXkt195klsJErRgOrLYioNPQK0ut2TdMWnUQNNbHhtqIit
        TmmiFkkgTUQtDhD7mz8Ic+iOaqSEbmeskJS7rw291d3yoq+H/vpNKpByN7936kbW
        UeyisHDo91Wua3h5CSjGIHeeUsppNJiGMZ+lyMjtdjyvw9MG87qX2H31485zlv8o
        k5nXLS2KDzVNXgYkHVpCXN3PDQQ0j+300meBUgAMkdKo8Tt3cPRw+JhXzbOmzqzx
        zuBeGhtUZFbcR8oH6Bo3nA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyep1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 11:21:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 31 Aug
 2023 17:21:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 31 Aug 2023 17:21:01 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 38A3911D6;
        Thu, 31 Aug 2023 16:20:59 +0000 (UTC)
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
Subject: [PATCH v3 4/4] ASoC: cs35l45: Add AMP Enable Switch control
Date:   Thu, 31 Aug 2023 11:20:42 -0500
Message-ID: <20230831162042.471801-4-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T-Wdx9XIUGTEFpyL4cYYEPwKN7DCtJqQ
X-Proofpoint-GUID: T-Wdx9XIUGTEFpyL4cYYEPwKN7DCtJqQ
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

