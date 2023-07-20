Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93075A3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjGTBcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGTBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:32:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3982106
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689816765; x=1721352765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jW1HloUIo7O6SDgsEvQybPl5isnE0/1NyJehhwwyQWs=;
  b=BZx465XHZSUDtiF/z3i1EF2VCPXvoVyU3XXivYn/GvnCMVMJrHaYSUiT
   BBiDNpStzz99N6Dgt1DmjN/s+jBwh0+AZNMLRsmEk+FgnbiRHjKVLAYWG
   6FxUuwSYQeQ2c8u9mGnpLgtpOuA5YV31wzHnq03IaNJbcMp6BYBlcsZJN
   pCEB4bdkIPT4mkLFGDH6YCZfFbJrVTqEgYNONE0nfgWopvKV0mBCFI6I1
   qi9zo7XFDa/+KCAKC4TWBcPWMuQWiyqIbl4PTg2bJiSeccvLTOq/qdUCE
   jYUO5sXDTBTr6b7Lsdn6JRysyTJi7mPArFpNZFzfcJNKr84Vho90T4KEB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="364067943"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="364067943"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 18:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867681286"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2023 18:32:42 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Date:   Thu, 20 Jul 2023 17:26:27 +0800
Message-Id: <20230720092628.758834-2-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720092628.758834-1-brent.lu@intel.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a helper function to get number of codecs from ACPI
subsystem to remove the need of quirk flag in machine driver.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_maxim_common.c | 174 +++++++++++++---------
 sound/soc/intel/boards/sof_maxim_common.h |  21 ++-
 2 files changed, 113 insertions(+), 82 deletions(-)

diff --git a/sound/soc/intel/boards/sof_maxim_common.c b/sound/soc/intel/boards/sof_maxim_common.c
index 112e89951da0..f8b44a81fec1 100644
--- a/sound/soc/intel/boards/sof_maxim_common.c
+++ b/sound/soc/intel/boards/sof_maxim_common.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dai.h>
@@ -11,6 +12,21 @@
 #include <uapi/sound/asound.h>
 #include "sof_maxim_common.h"
 
+/* helper function to get the number of specific codec */
+static int get_num_codecs(const char *hid)
+{
+	struct acpi_device *adev = NULL;
+	int dev_num = 0;
+
+	do {
+		adev = acpi_dev_get_next_match_dev(adev, hid, NULL, -1);
+		if (adev)
+			dev_num++;
+	} while (adev != NULL);
+
+	return dev_num;
+}
+
 #define MAX_98373_PIN_NAME 16
 
 const struct snd_soc_dapm_route max_98373_dapm_routes[] = {
@@ -168,17 +184,6 @@ static struct snd_soc_codec_conf max_98390_codec_conf[] = {
 		.dlc = COMP_CODEC_CONF(MAX_98390_DEV1_NAME),
 		.name_prefix = "Left",
 	},
-};
-
-static struct snd_soc_codec_conf max_98390_4spk_codec_conf[] = {
-	{
-		.dlc = COMP_CODEC_CONF(MAX_98390_DEV0_NAME),
-		.name_prefix = "Right",
-	},
-	{
-		.dlc = COMP_CODEC_CONF(MAX_98390_DEV1_NAME),
-		.name_prefix = "Left",
-	},
 	{
 		.dlc = COMP_CODEC_CONF(MAX_98390_DEV2_NAME),
 		.name_prefix = "Tweeter Right",
@@ -189,19 +194,7 @@ static struct snd_soc_codec_conf max_98390_4spk_codec_conf[] = {
 	},
 };
 
-struct snd_soc_dai_link_component max_98390_components[] = {
-	{
-		.name = MAX_98390_DEV0_NAME,
-		.dai_name = MAX_98390_CODEC_DAI,
-	},
-	{
-		.name = MAX_98390_DEV1_NAME,
-		.dai_name = MAX_98390_CODEC_DAI,
-	},
-};
-EXPORT_SYMBOL_NS(max_98390_components, SND_SOC_INTEL_SOF_MAXIM_COMMON);
-
-struct snd_soc_dai_link_component max_98390_4spk_components[] = {
+static struct snd_soc_dai_link_component max_98390_components[] = {
 	{
 		.name = MAX_98390_DEV0_NAME,
 		.dai_name = MAX_98390_CODEC_DAI,
@@ -219,62 +212,56 @@ struct snd_soc_dai_link_component max_98390_4spk_components[] = {
 		.dai_name = MAX_98390_CODEC_DAI,
 	},
 };
-EXPORT_SYMBOL_NS(max_98390_4spk_components, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+static const struct {
+	unsigned int tx;
+	unsigned int rx;
+} max_98390_tdm_mask[] = {
+	{.tx = 0x01, .rx = 0x3},
+	{.tx = 0x02, .rx = 0x3},
+	{.tx = 0x04, .rx = 0x3},
+	{.tx = 0x08, .rx = 0x3},
+};
 
 static int max_98390_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
-	int i;
+	int i, ret = 0;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		if (i >= ARRAY_SIZE(max_98390_4spk_components)) {
+		if (i >= ARRAY_SIZE(max_98390_tdm_mask)) {
 			dev_err(codec_dai->dev, "invalid codec index %d\n", i);
 			return -ENODEV;
 		}
 
-		if (!strcmp(codec_dai->component->name, MAX_98390_DEV0_NAME)) {
-			/* DEV0 tdm slot configuration Right */
-			snd_soc_dai_set_tdm_slot(codec_dai, 0x01, 3, 4, 32);
-		}
-		if (!strcmp(codec_dai->component->name, MAX_98390_DEV1_NAME)) {
-			/* DEV1 tdm slot configuration Left */
-			snd_soc_dai_set_tdm_slot(codec_dai, 0x02, 3, 4, 32);
-		}
-
-		if (!strcmp(codec_dai->component->name, MAX_98390_DEV2_NAME)) {
-			/* DEVi2 tdm slot configuration Tweeter Right */
-			snd_soc_dai_set_tdm_slot(codec_dai, 0x04, 3, 4, 32);
-		}
-		if (!strcmp(codec_dai->component->name, MAX_98390_DEV3_NAME)) {
-			/* DEV3 tdm slot configuration Tweeter Left */
-			snd_soc_dai_set_tdm_slot(codec_dai, 0x08, 3, 4, 32);
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, max_98390_tdm_mask[i].tx,
+					       max_98390_tdm_mask[i].rx, 4,
+					       params_width(params));
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "fail to set tdm slot, ret %d\n",
+				ret);
+			return ret;
 		}
 	}
 	return 0;
 }
 
-int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd)
+static int max_98390_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
+	int num_codecs = get_num_codecs(MAX_98390_ACPI_HID);
 	int ret;
 
-	/* add regular speakers dapm route */
-	ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_dapm_routes,
-				      ARRAY_SIZE(max_98390_dapm_routes));
-	if (ret) {
-		dev_err(rtd->dev, "unable to add Left/Right Speaker dapm, ret %d\n", ret);
-		return ret;
-	}
-
-	/* add widgets/controls/dapm for tweeter speakers */
-	if (acpi_dev_present("MX98390", "3", -1)) {
+	switch (num_codecs) {
+	case 4:
+		/* add widgets/controls/dapm for tweeter speakers */
 		ret = snd_soc_dapm_new_controls(&card->dapm, max_98390_tt_dapm_widgets,
 						ARRAY_SIZE(max_98390_tt_dapm_widgets));
-
 		if (ret) {
-			dev_err(rtd->dev, "unable to add tweeter dapm controls, ret %d\n", ret);
+			dev_err(rtd->dev, "unable to add tweeter dapm widgets, ret %d\n",
+				ret);
 			/* Don't need to add routes if widget addition failed */
 			return ret;
 		}
@@ -282,33 +269,80 @@ int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd)
 		ret = snd_soc_add_card_controls(card, max_98390_tt_kcontrols,
 						ARRAY_SIZE(max_98390_tt_kcontrols));
 		if (ret) {
-			dev_err(rtd->dev, "unable to add tweeter card controls, ret %d\n", ret);
+			dev_err(rtd->dev, "unable to add tweeter controls, ret %d\n",
+				ret);
 			return ret;
 		}
 
 		ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_tt_dapm_routes,
 					      ARRAY_SIZE(max_98390_tt_dapm_routes));
-		if (ret)
-			dev_err(rtd->dev,
-				"unable to add Tweeter Left/Right Speaker dapm, ret %d\n", ret);
+		if (ret) {
+			dev_err(rtd->dev, "unable to add tweeter dapm routes, ret %d\n",
+				ret);
+			return ret;
+		}
+
+		fallthrough;
+	case 2:
+		/* add regular speakers dapm route */
+		ret = snd_soc_dapm_add_routes(&card->dapm, max_98390_dapm_routes,
+					      ARRAY_SIZE(max_98390_dapm_routes));
+		if (ret) {
+			dev_err(rtd->dev, "unable to add dapm routes, ret %d\n",
+				ret);
+			return ret;
+		}
+		break;
+	default:
+		dev_err(rtd->dev, "invalid codec number %d\n", num_codecs);
+		ret = -EINVAL;
+		break;
 	}
+
 	return ret;
 }
-EXPORT_SYMBOL_NS(max_98390_spk_codec_init, SND_SOC_INTEL_SOF_MAXIM_COMMON);
 
-const struct snd_soc_ops max_98390_ops = {
+static const struct snd_soc_ops max_98390_ops = {
 	.hw_params = max_98390_hw_params,
 };
-EXPORT_SYMBOL_NS(max_98390_ops, SND_SOC_INTEL_SOF_MAXIM_COMMON);
 
-void max_98390_set_codec_conf(struct snd_soc_card *card, int ch)
+void max_98390_dai_link(struct snd_soc_dai_link *link)
+{
+	int num_codecs = get_num_codecs(MAX_98390_ACPI_HID);
+
+	link->codecs = max_98390_components;
+
+	switch (num_codecs) {
+	case 2:
+	case 4:
+		link->num_codecs = num_codecs;
+		break;
+	default:
+		pr_err("invalid codec number %d for %s\n", num_codecs,
+			MAX_98390_ACPI_HID);
+		break;
+	}
+
+	link->init = max_98390_init;
+	link->ops = &max_98390_ops;
+}
+EXPORT_SYMBOL_NS(max_98390_dai_link, SND_SOC_INTEL_SOF_MAXIM_COMMON);
+
+void max_98390_set_codec_conf(struct snd_soc_card *card)
 {
-	if (ch == ARRAY_SIZE(max_98390_4spk_codec_conf)) {
-		card->codec_conf = max_98390_4spk_codec_conf;
-		card->num_configs = ARRAY_SIZE(max_98390_4spk_codec_conf);
-	} else {
-		card->codec_conf = max_98390_codec_conf;
-		card->num_configs = ARRAY_SIZE(max_98390_codec_conf);
+	int num_codecs = get_num_codecs(MAX_98390_ACPI_HID);
+
+	card->codec_conf = max_98390_codec_conf;
+
+	switch (num_codecs) {
+	case 2:
+	case 4:
+		card->num_configs = num_codecs;
+		break;
+	default:
+		pr_err("invalid codec number %d for %s\n", num_codecs,
+			MAX_98390_ACPI_HID);
+		break;
 	}
 }
 EXPORT_SYMBOL_NS(max_98390_set_codec_conf, SND_SOC_INTEL_SOF_MAXIM_COMMON);
diff --git a/sound/soc/intel/boards/sof_maxim_common.h b/sound/soc/intel/boards/sof_maxim_common.h
index 7a8c53049e4d..a3676d68cc12 100644
--- a/sound/soc/intel/boards/sof_maxim_common.h
+++ b/sound/soc/intel/boards/sof_maxim_common.h
@@ -27,18 +27,15 @@ int max_98373_trigger(struct snd_pcm_substream *substream, int cmd);
 /*
  * Maxim MAX98390
  */
-#define MAX_98390_CODEC_DAI     "max98390-aif1"
-#define MAX_98390_DEV0_NAME     "i2c-MX98390:00"
-#define MAX_98390_DEV1_NAME     "i2c-MX98390:01"
-#define MAX_98390_DEV2_NAME     "i2c-MX98390:02"
-#define MAX_98390_DEV3_NAME     "i2c-MX98390:03"
-
-extern struct snd_soc_dai_link_component max_98390_components[2];
-extern struct snd_soc_dai_link_component max_98390_4spk_components[4];
-extern const struct snd_soc_ops max_98390_ops;
-
-void max_98390_set_codec_conf(struct snd_soc_card *card, int ch);
-int max_98390_spk_codec_init(struct snd_soc_pcm_runtime *rtd);
+#define MAX_98390_ACPI_HID	"MX98390"
+#define MAX_98390_CODEC_DAI	"max98390-aif1"
+#define MAX_98390_DEV0_NAME	"i2c-MX98390:00"
+#define MAX_98390_DEV1_NAME	"i2c-MX98390:01"
+#define MAX_98390_DEV2_NAME	"i2c-MX98390:02"
+#define MAX_98390_DEV3_NAME	"i2c-MX98390:03"
+
+void max_98390_dai_link(struct snd_soc_dai_link *link);
+void max_98390_set_codec_conf(struct snd_soc_card *card);
 
 /*
  * Maxim MAX98357A/MAX98360A
-- 
2.34.1

