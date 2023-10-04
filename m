Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E237B82DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbjJDO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbjJDO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:25 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743AD9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:56:15 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v6 12/12] ALSA: hda: i915: Remove extra argument from snd_hdac_i915_init
Date:   Wed,  4 Oct 2023 16:55:40 +0200
Message-Id: <20231004145540.32321-13-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com>
References: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com>
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
 include/sound/hda_i915.h        |  4 ++--
 sound/hda/hdac_i915.c           | 14 +++-----------
 sound/pci/hda/hda_intel.c       |  2 +-
 sound/soc/intel/avs/core.c      |  2 +-
 sound/soc/intel/skylake/skl.c   |  2 +-
 sound/soc/sof/intel/hda-codec.c |  2 +-
 6 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index f91bd6636086..6b79614a893b 100644
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
index 0765e5350e7b..365c36fdf205 100644
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
index 5cf7676114dc..5255df16fbac 100644
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
index 8a2063958248..33044f353575 100644
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
index 24bdbe2a53be..f46f109d5856 100644
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
index f1fd5b44aaac..8a5e99a898ec 100644
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
2.40.1

