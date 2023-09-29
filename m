Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805EC7B360C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjI2Ov7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjI2Ovq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:51:46 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99011B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:51:44 -0700 (PDT)
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: [PATCH v5 06/12] ALSA: hda/i915: Add an allow_modprobe argument to snd_hdac_i915_init
Date:   Fri, 29 Sep 2023 16:51:20 +0200
Message-Id: <20230929145123.233838-7-maarten.lankhorst@linux.intel.com>
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

Xe is a new GPU driver that re-uses the display (and sound) code from
i915. It's no longer possible to load i915, as the GPU can be driven
by the xe driver instead.

The new behavior will return -EPROBE_DEFER, and wait for a compatible
driver to be loaded instead of modprobing i915.

Converting all drivers at the same time is a lot of work, instead we
will convert each user one by one.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hda_i915.h        | 4 ++--
 sound/hda/hdac_i915.c           | 8 ++++----
 sound/pci/hda/hda_intel.c       | 2 +-
 sound/soc/intel/avs/core.c      | 2 +-
 sound/soc/intel/skylake/skl.c   | 2 +-
 sound/soc/sof/intel/hda-codec.c | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index 6b79614a893b9..f91bd66360865 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -9,12 +9,12 @@
 
 #ifdef CONFIG_SND_HDA_I915
 void snd_hdac_i915_set_bclk(struct hdac_bus *bus);
-int snd_hdac_i915_init(struct hdac_bus *bus);
+int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe);
 #else
 static inline void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 {
 }
-static inline int snd_hdac_i915_init(struct hdac_bus *bus)
+static inline int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
 {
 	return -ENODEV;
 }
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index a4a712c795c3d..ffa35d7a367c0 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -155,7 +155,7 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
  *
  * Returns zero for success or a negative error code.
  */
-int snd_hdac_i915_init(struct hdac_bus *bus)
+int snd_hdac_i915_init(struct hdac_bus *bus, bool allow_modprobe)
 {
 	struct drm_audio_component *acomp;
 	int err;
@@ -171,7 +171,7 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
 	acomp = bus->audio_component;
 	if (!acomp)
 		return -ENODEV;
-	if (!acomp->ops) {
+	if (allow_modprobe && !acomp->ops) {
 		if (!IS_ENABLED(CONFIG_MODULES) ||
 		    !request_module("i915")) {
 			/* 60s timeout */
@@ -180,9 +180,9 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
 		}
 	}
 	if (!acomp->ops) {
-		dev_info(bus->dev, "couldn't bind with audio component\n");
+		int err = allow_modprobe ? -ENODEV : -EPROBE_DEFER;
 		snd_hdac_acomp_exit(bus);
-		return -ENODEV;
+		return dev_err_probe(bus->dev, err, "couldn't bind with audio component\n");
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b4ac0d43c09bc..bfe6232bb0e0e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2266,7 +2266,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	/* bind with i915 if needed */
 	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
-		err = snd_hdac_i915_init(bus);
+		err = snd_hdac_i915_init(bus, true);
 		if (err < 0) {
 			/* if the controller is bound only with HDMI/DP
 			 * (for HSW and BDW), we need to abort the probe;
diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 859b217fc761b..bbb40339c75f4 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -191,7 +191,7 @@ static void avs_hda_probe_work(struct work_struct *work)
 
 	pm_runtime_set_active(bus->dev); /* clear runtime_error flag */
 
-	ret = snd_hdac_i915_init(bus);
+	ret = snd_hdac_i915_init(bus, true);
 	if (ret < 0)
 		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 77408a981b977..4f7acb4f6680b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -791,7 +791,7 @@ static int skl_i915_init(struct hdac_bus *bus)
 	 * The HDMI codec is in GPU so we need to ensure that it is powered
 	 * up and ready for probe
 	 */
-	err = snd_hdac_i915_init(bus);
+	err = snd_hdac_i915_init(bus, true);
 	if (err < 0)
 		return err;
 
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 8a5e99a898ecb..f1fd5b44aaac9 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
 		return 0;
 
 	/* i915 exposes a HDA codec for HDMI audio */
-	ret = snd_hdac_i915_init(bus);
+	ret = snd_hdac_i915_init(bus, true);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2

