Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6751D80566E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbjLENuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjLENuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:50:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1418B2;
        Tue,  5 Dec 2023 05:50:17 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B56mS4S002076;
        Tue, 5 Dec 2023 07:50:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=N
        E5+DSXwGrCAGjdB6rJhza2qUwOx7ACzcoH8hLHpcnQ=; b=XDrKw9/F3oREtZz9N
        cC5WHRnz86qoWZH6ISZPq8YQsWa3EpYsLtPHRuiuJdAeJVP6zg1HV56tdsUROkBa
        5rUKq9Dj8F/CQ7nliYh1t2uC8bFYp51CSNYVYkC50BNMQl2WBKzoAM4DEiE98LQb
        hvykX8lhF32I2I45kZiXfcRN+VhGq2YQae1Ljams7s4EA5M6CYZX6tSRvumQdebW
        qVxAA8d+ndLxeX4dx3HQj8uSkJ+f74E90gjvw3wc9bZUYhfKxUUDp8C8TX39ARJO
        TRS361G+rVs+KTi5EYGfIYnCd5CT+0Q16zTOff8v4911/rRR8G0MSB1pMaD4pceO
        isRyA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ur2v237sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:50:03 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 13:50:01 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 5 Dec 2023 13:50:01 +0000
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8FCF711AB;
        Tue,  5 Dec 2023 13:50:01 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <cezary.rojewski@intel.com>, <ranjani.sridharan@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: Intel: sof_sdw_cs_amp: Connect outputs to a speaker widget
Date:   Tue, 5 Dec 2023 13:50:01 +0000
Message-ID: <20231205135001.2506070-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oAYrQxspCojOdylohofqRTq4nx-S8yUR
X-Proofpoint-GUID: oAYrQxspCojOdylohofqRTq4nx-S8yUR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hookup the CS35L56 DAPM_OUTPUT widgets to a DAPM_SPK widget so
that there is a complete logical path to a speaker.

There is no particular reason to use multiple speaker widgets.
The CS35L56 are designed to work together as a set so they have
all been connected to a single speaker widget.

Instead of a hardcoded list of codec widget names, the code walks
through all the codecs on the dailink and for every cs35l56 it uses
its name prefix to construct the source end of the route. This adds
a small amount of overhead during probe but has the benefit that it
isn't dependent on every system using the same prefixes.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/intel/boards/sof_sdw_cs_amp.c | 30 +++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw_cs_amp.c b/sound/soc/intel/boards/sof_sdw_cs_amp.c
index 98f6546f484b..f88c01552a92 100644
--- a/sound/soc/intel/boards/sof_sdw_cs_amp.c
+++ b/sound/soc/intel/boards/sof_sdw_cs_amp.c
@@ -9,15 +9,24 @@
 #include <linux/errno.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
+#include <sound/soc-dai.h>
 #include "sof_sdw_common.h"
 
 #define CODEC_NAME_SIZE	8
 
+static const struct snd_soc_dapm_widget sof_widgets[] = {
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+};
+
 static int cs_spk_init(struct snd_soc_pcm_runtime *rtd)
 {
 	const char *dai_name = rtd->dai_link->codecs->dai_name;
 	struct snd_soc_card *card = rtd->card;
 	char codec_name[CODEC_NAME_SIZE];
+	char widget_name[16];
+	struct snd_soc_dapm_route route = { "Speakers", NULL, widget_name };
+	struct snd_soc_dai *codec_dai;
+	int i, ret;
 
 	snprintf(codec_name, CODEC_NAME_SIZE, "%s", dai_name);
 	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
@@ -26,17 +35,34 @@ static int cs_spk_init(struct snd_soc_pcm_runtime *rtd)
 	if (!card->components)
 		return -ENOMEM;
 
+	ret = snd_soc_dapm_new_controls(&card->dapm, sof_widgets,
+					ARRAY_SIZE(sof_widgets));
+	if (ret) {
+		dev_err(card->dev, "widgets addition failed: %d\n", ret);
+		return ret;
+	}
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		if (!strstr(codec_dai->name, "cs35l56"))
+			continue;
+
+		snprintf(widget_name, sizeof(widget_name), "%s SPK",
+			 codec_dai->component->name_prefix);
+		ret = snd_soc_dapm_add_routes(&card->dapm, &route, 1);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-
 int sof_sdw_cs_amp_init(struct snd_soc_card *card,
 			const struct snd_soc_acpi_link_adr *link,
 			struct snd_soc_dai_link *dai_links,
 			struct sof_sdw_codec_info *info,
 			bool playback)
 {
-	/* Count amp number and do init on playback link only. */
+	/* Do init on playback link only. */
 	if (!playback)
 		return 0;
 
-- 
2.30.2

