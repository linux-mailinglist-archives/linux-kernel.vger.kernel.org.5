Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C0771CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjHGJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHGJBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:01:48 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465221991
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:01:38 -0700 (PDT)
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
Subject: [PATCH v3 7/9] ALSA: hda/intel: Move snd_hdac_i915_init to before probe_work.
Date:   Mon,  7 Aug 2023 11:00:43 +0200
Message-Id: <20230807090045.198993-8-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can use -EPROBE_DEFER, it's no longer required to spin off
the snd_hdac_i915_init into a workqueue.

Use the -EPROBE_DEFER mechanism instead, which must be returned in the
probe function.

Changes since v1:
- Use dev_err_probe()
- Don't move probed_devs bitmap unnecessarily. (tiwai)
- Move snd_hdac_i915_init slightly upward, to ensure
  it's always initialised before vga-switcheroo is called.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 59 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 11cf9907f039..e3128d7d742e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2147,6 +2147,36 @@ static int azx_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(pci, card);
 
+#ifdef CONFIG_SND_HDA_I915
+	/* bind with i915 if needed */
+	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
+		err = snd_hdac_i915_init(azx_bus(chip), false);
+		if (err < 0) {
+			/* if the controller is bound only with HDMI/DP
+			 * (for HSW and BDW), we need to abort the probe;
+			 * for other chips, still continue probing as other
+			 * codecs can be on the same link.
+			 */
+			if (CONTROLLER_IN_GPU(pci)) {
+				dev_err_probe(card->dev, err,
+					     "HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
+
+				goto out_free;
+			} else {
+				/* don't bother any longer */
+				chip->driver_caps &= ~AZX_DCAPS_I915_COMPONENT;
+			}
+		}
+
+		/* HSW/BDW controllers need this power */
+		if (CONTROLLER_IN_GPU(pci))
+			hda->need_i915_power = true;
+	}
+#else
+	if (CONTROLLER_IN_GPU(pci))
+		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
+#endif
+
 	err = register_vga_switcheroo(chip);
 	if (err < 0) {
 		dev_err(card->dev, "Error registering vga_switcheroo client\n");
@@ -2174,11 +2204,6 @@ static int azx_probe(struct pci_dev *pci,
 	}
 #endif /* CONFIG_SND_HDA_PATCH_LOADER */
 
-#ifndef CONFIG_SND_HDA_I915
-	if (CONTROLLER_IN_GPU(pci))
-		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
-#endif
-
 	if (schedule_probe)
 		schedule_delayed_work(&hda->probe_work, 0);
 
@@ -2275,30 +2300,6 @@ static int azx_probe_continue(struct azx *chip)
 	to_hda_bus(bus)->bus_probing = 1;
 	hda->probe_continued = 1;
 
-	/* bind with i915 if needed */
-	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
-		err = snd_hdac_i915_init(bus, true);
-		if (err < 0) {
-			/* if the controller is bound only with HDMI/DP
-			 * (for HSW and BDW), we need to abort the probe;
-			 * for other chips, still continue probing as other
-			 * codecs can be on the same link.
-			 */
-			if (CONTROLLER_IN_GPU(pci)) {
-				dev_err(chip->card->dev,
-					"HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
-				goto out_free;
-			} else {
-				/* don't bother any longer */
-				chip->driver_caps &= ~AZX_DCAPS_I915_COMPONENT;
-			}
-		}
-
-		/* HSW/BDW controllers need this power */
-		if (CONTROLLER_IN_GPU(pci))
-			hda->need_i915_power = true;
-	}
-
 	/* Request display power well for the HDA controller or codec. For
 	 * Haswell/Broadwell, both the display HDA controller and codec need
 	 * this power. For other platforms, like Baytrail/Braswell, only the
-- 
2.39.2

