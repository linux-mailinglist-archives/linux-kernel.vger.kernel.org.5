Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2744378DFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245087AbjH3TPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbjH3PhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:37:17 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D6113
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:37:14 -0700 (PDT)
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
Subject: [PATCH v4 10/11] ASoC: SOF: Intel: Move binding to display driver outside of deferred probe
Date:   Wed, 30 Aug 2023 17:36:51 +0200
Message-Id: <20230830153652.217855-11-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
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

Now that we can use -EPROBE_DEFER, it's no longer required to spin off
the snd_hdac_i915_init into a workqueue.

Use the -EPROBE_DEFER mechanism instead, which must be returned in the
probe function.

The previously added probe_no_wq can be used for this,
and we also use the newly added remove_no_wq for unbinding afterwards.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-common-ops.c |  1 +
 sound/soc/sof/intel/hda.c            | 15 ++++++---------
 sound/soc/sof/intel/hda.h            |  1 +
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index 803b5e9087782..1e2e9b6a5c1c2 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -17,6 +17,7 @@
 struct snd_sof_dsp_ops sof_hda_common_ops = {
 	/* probe/remove/shutdown */
 	.probe_no_wq	= hda_dsp_probe_no_wq,
+	.remove_no_wq	= hda_dsp_remove_no_wq,
 	.probe		= hda_dsp_probe,
 	.remove		= hda_dsp_remove,
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e918b5dadfa02..886073598e40f 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1160,6 +1160,7 @@ int hda_dsp_probe_no_wq(struct snd_sof_dev *sdev)
 		return -ENOMEM;
 	sdev->pdata->hw_pdata = hdev;
 	hdev->desc = chip;
+	ret = hda_init(sdev);
 
 err:
 	return ret;
@@ -1195,9 +1196,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 
 	/* set up HDA base */
 	bus = sof_to_bus(sdev);
-	ret = hda_init(sdev);
-	if (ret < 0)
-		goto hdac_bus_unmap;
 
 	if (sdev->dspless_mode_selected)
 		goto skip_dsp_setup;
@@ -1307,8 +1305,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		iounmap(sdev->bar[HDA_DSP_BAR]);
 hdac_bus_unmap:
 	platform_device_unregister(hdev->dmic_dev);
-	iounmap(bus->remap_addr);
-	hda_codec_i915_exit(sdev);
 
 	return ret;
 }
@@ -1317,7 +1313,6 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
-	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	struct nhlt_acpi_table *nhlt = hda->nhlt;
 
@@ -1368,10 +1363,12 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	if (!sdev->dspless_mode_selected)
 		iounmap(sdev->bar[HDA_DSP_BAR]);
 
-	iounmap(bus->remap_addr);
-
-	sof_hda_bus_exit(sdev);
+	return 0;
+}
 
+int hda_dsp_remove_no_wq(struct snd_sof_dev *sdev)
+{
+	iounmap(sof_to_bus(sdev)->remap_addr);
 	hda_codec_i915_exit(sdev);
 
 	return 0;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 89b8c239e9a5e..26ae11e4e1240 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -574,6 +574,7 @@ struct sof_intel_hda_stream {
  * DSP Core services.
  */
 int hda_dsp_probe_no_wq(struct snd_sof_dev *sdev);
+int hda_dsp_remove_no_wq(struct snd_sof_dev *sdev);
 int hda_dsp_probe(struct snd_sof_dev *sdev);
 int hda_dsp_remove(struct snd_sof_dev *sdev);
 int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mask);
-- 
2.39.2

