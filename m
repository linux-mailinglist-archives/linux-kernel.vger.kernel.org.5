Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1D7B5819
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbjJBQwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbjJBQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:52:28 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D5BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:52:25 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: [PATCH v5 12/12] ALSA: hda/i915: Remove extra argument from snd_hdac_i915_init
Date:   Mon,  2 Oct 2023 18:52:21 +0200
Message-Id: <20231002165221.17916-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all drivers have moved from modprobe loading to
handling -EPROBE_DEFER, we can remove the argument again.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org

 include/sound/hda_i915.h        |  4 ++--
 sound/hda/hdac_i915.c           | 14 +++-----------
 sound/pci/hda/hda_intel.c       |  2 +-
 sound/soc/intel/avs/core.c      |  2 +-
 sound/soc/intel/skylake/skl.c   |  2 +-
 sound/soc/sof/intel/hda-codec.c |  2 +-
 6 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index f91bd66360865..6b79614a893b9 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -9,12 +9,12 @@
 
 #ifdef CONFIG_SND_HDA_I915
 void snd_hdac_i915_set_bclk(struct hdac_bus *bus);
-int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe);
+int snd_hdac_i915_init(struct hdac_bus *bus);
 #else
 static inline void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 {
 }
-static inline int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
+static inline int snd_hdac_i915_init(struct hdac_bus *bus)
 {
 	return -ENODEV;
 }
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 0765e5350e7ba..365c36fdf2058 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -156,7 +156,7 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
  *
  * Returns zero for success or a negative error code.
  */
-int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
+int snd_hdac_i915_init(struct hdac_bus *bus)
 {
 	struct drm_audio_component *acomp;
 	int err;
@@ -172,18 +172,10 @@ int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
 	acomp = bus->audio_component;
 	if (!acomp)
 		return -ENODEV;
-	if (allow_modprobe && !acomp->ops) {
-		if (!IS_ENABLED(CONFIG_MODULES) ||
-		    !request_module("i915")) {
-			/* 60s timeout */
-			wait_for_completion_killable_timeout(&acomp->master_bind_complete,
-							     msecs_to_jiffies(60 * 1000));
-		}
-	}
 	if (!acomp->ops) {
-		int err = allow_modprobe ? -ENODEV : -EPROBE_DEFER;
 		snd_hdac_acomp_exit(bus);
-		return dev_err_probe(bus->dev, err, "couldn't bind with audio component\n");
+		return dev_err_probe(bus->dev, -EPROBE_DEFER,
+				     "couldn't bind with audio component\n");
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5cf7676114dc6..5255df16fbac5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2138,7 +2138,7 @@ static int azx_probe(struct pci_dev *pci,
 #ifdef CONFIG_SND_HDA_I915
 	/* bind with i915 if needed */
 	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
-		err = snd_hdac_i915_init(azx_bus(chip), false);
+		err = snd_hdac_i915_init(azx_bus(chip));
 		if (err < 0) {
 			/* if the controller is bound only with HDMI/DP
 			 * (for HSW and BDW), we need to abort the probe;
diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 8a20639582487..33044f353575d 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -461,7 +461,7 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	pci_set_drvdata(pci, bus);
 	device_disable_async_suspend(dev);
 
-	ret = snd_hdac_i915_init(bus, false);
+	ret = snd_hdac_i915_init(bus);
 	if (ret == -EPROBE_DEFER)
 		goto err_i915_init;
 	else if (ret < 0)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 24bdbe2a53bec..f46f109d5856e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1056,7 +1056,7 @@ static int skl_probe(struct pci_dev *pci,
 	}
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		err = snd_hdac_i915_init(bus, false);
+		err = snd_hdac_i915_init(bus);
 		if (err < 0)
 			goto out_dmic_unregister;
 	}
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index f1fd5b44aaac9..8a5e99a898ecb 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
 		return 0;
 
 	/* i915 exposes a HDA codec for HDMI audio */
-	ret = snd_hdac_i915_init(bus, true);
+	ret = snd_hdac_i915_init(bus);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2

