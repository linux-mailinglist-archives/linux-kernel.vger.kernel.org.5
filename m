Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614717B3609
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjI2Ovs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjI2Ovl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:51:41 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5094F7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:51:39 -0700 (PDT)
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
Subject: [PATCH v5 03/12] ASoC: SOF: Intel: hda: start splitting the probe
Date:   Fri, 29 Sep 2023 16:51:17 +0200
Message-Id: <20230929145123.233838-4-maarten.lankhorst@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This patch moves the initial parts of the probe to the probe_early()
callback, which provides a much faster decision on whether the SOF
driver shall deal with a specific platform or yield to other Intel
drivers.

This is a limited functionality change, the bigger change is to move
the i915/Xe initialization to the probe_early().

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/soc/sof/intel/hda-common-ops.c |  1 +
 sound/soc/sof/intel/hda.c            | 16 +++++++++++++---
 sound/soc/sof/intel/hda.h            |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index 8e1cd0babd32c..1cc18fb2b75bb 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -16,6 +16,7 @@
 
 struct snd_sof_dsp_ops sof_hda_common_ops = {
 	/* probe/remove/shutdown */
+	.probe_early	= hda_dsp_probe_early,
 	.probe		= hda_dsp_probe,
 	.remove		= hda_dsp_remove,
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 15e6779efaa3b..86a2571488bcc 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1118,11 +1118,10 @@ static irqreturn_t hda_dsp_interrupt_thread(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
-int hda_dsp_probe(struct snd_sof_dev *sdev)
+int hda_dsp_probe_early(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	struct sof_intel_hda_dev *hdev;
-	struct hdac_bus *bus;
 	const struct sof_intel_dsp_desc *chip;
 	int ret = 0;
 
@@ -1162,6 +1161,17 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	sdev->pdata->hw_pdata = hdev;
 	hdev->desc = chip;
 
+err:
+	return ret;
+}
+
+int hda_dsp_probe(struct snd_sof_dev *sdev)
+{
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
+	struct hdac_bus *bus;
+	int ret = 0;
+
 	hdev->dmic_dev = platform_device_register_data(sdev->dev, "dmic-codec",
 						       PLATFORM_DEVID_NONE,
 						       NULL, 0);
@@ -1299,7 +1309,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	platform_device_unregister(hdev->dmic_dev);
 	iounmap(bus->remap_addr);
 	hda_codec_i915_exit(sdev);
-err:
+
 	return ret;
 }
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 5c517ec57d4a2..e13cdc933ca6b 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -573,6 +573,7 @@ struct sof_intel_hda_stream {
 /*
  * DSP Core services.
  */
+int hda_dsp_probe_early(struct snd_sof_dev *sdev);
 int hda_dsp_probe(struct snd_sof_dev *sdev);
 int hda_dsp_remove(struct snd_sof_dev *sdev);
 int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mask);
-- 
2.39.2

