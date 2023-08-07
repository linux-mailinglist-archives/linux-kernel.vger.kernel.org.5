Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E7B771CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjHGJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjHGJBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:01:48 -0400
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1EE6C
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
Subject: [PATCH v3 8/9] ASoC: SOF: Intel: Move binding to display driver outside of deferred probe
Date:   Mon,  7 Aug 2023 11:00:44 +0200
Message-Id: <20230807090045.198993-9-maarten.lankhorst@linux.intel.com>
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

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/soc/sof/core.c            | 19 +++++++------------
 sound/soc/sof/intel/hda-codec.c |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 30db685cc5f4..cd4d06d1800b 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -188,13 +188,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	struct snd_sof_pdata *plat_data = sdev->pdata;
 	int ret;
 
-	/* probe the DSP hardware */
-	ret = snd_sof_probe(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);
-		goto probe_err;
-	}
-
 	sof_set_fw_state(sdev, SOF_FW_BOOT_PREPARE);
 
 	/* check machine info */
@@ -325,10 +318,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 dbg_err:
 	snd_sof_free_debug(sdev);
 dsp_err:
-	snd_sof_remove(sdev);
-probe_err:
-	sof_ops_free(sdev);
-
 	/* all resources freed, update state to match */
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 	sdev->first_boot = true;
@@ -436,6 +425,12 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 
+	ret = snd_sof_probe(sdev);
+	if (ret) {
+		dev_err_probe(sdev->dev, ret, "failed to probe DSP\n");
+		return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
 		INIT_WORK(&sdev->probe_work, sof_probe_work);
 		schedule_work(&sdev->probe_work);
@@ -485,9 +480,9 @@ int snd_sof_device_remove(struct device *dev)
 
 		snd_sof_ipc_free(sdev);
 		snd_sof_free_debug(sdev);
-		snd_sof_remove(sdev);
 	}
 
+	snd_sof_remove(sdev);
 	sof_ops_free(sdev);
 
 	/* release firmware */
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index f1fd5b44aaac..344b61576c0e 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
 		return 0;
 
 	/* i915 exposes a HDA codec for HDMI audio */
-	ret = snd_hdac_i915_init(bus, true);
+	ret = snd_hdac_i915_init(bus, false);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2

