Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CDC7B3608
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjI2Ovp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjI2Ovk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:51:40 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D14D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:51:37 -0700 (PDT)
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
Subject: [PATCH v5 02/12] ASoC: SOF: core: Add probe_early and remove_late callbacks
Date:   Fri, 29 Sep 2023 16:51:16 +0200
Message-Id: <20230929145123.233838-3-maarten.lankhorst@linux.intel.com>
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

The existing DSP probe may be handled in a workqueue to allow for
extra time, typically for the i915 request_module and HDAudio codec
handling.

With the upcoming changes for i915/Xe driver relying on the
-EPROBE_DEFER mechanism, we need to have a first pass of the probe
which cannot be pushed to a workqueue. Introduce 2 new optional
callbacks.

probe_early is called before the workqueue runs. remove_late may be
called from the workqueue if load is unsuccesful, but will otherwise
be called on module unload.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/soc/sof/core.c     | 11 +++++++++++
 sound/soc/sof/ops.h      | 16 ++++++++++++++++
 sound/soc/sof/sof-priv.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 0938b259f7034..d7b090224f1b9 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -327,6 +327,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 dsp_err:
 	snd_sof_remove(sdev);
 probe_err:
+	snd_sof_remove_late(sdev);
 	sof_ops_free(sdev);
 
 	/* all resources freed, update state to match */
@@ -436,6 +437,14 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 
+	/*
+	 * first pass of probe which isn't allowed to run in a work-queue,
+	 * typically to rely on -EPROBE_DEFER dependencies
+	 */
+	ret = snd_sof_probe_early(sdev);
+	if (ret < 0)
+		return ret;
+
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
 		INIT_WORK(&sdev->probe_work, sof_probe_work);
 		schedule_work(&sdev->probe_work);
@@ -487,9 +496,11 @@ int snd_sof_device_remove(struct device *dev)
 		snd_sof_ipc_free(sdev);
 		snd_sof_free_debug(sdev);
 		snd_sof_remove(sdev);
+		snd_sof_remove_late(sdev);
 		sof_ops_free(sdev);
 	} else if (aborted) {
 		/* probe_work never ran */
+		snd_sof_remove_late(sdev);
 		sof_ops_free(sdev);
 	}
 
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 9ab7b9be765bc..3ebcfc2373854 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -38,6 +38,14 @@ static inline void sof_ops_free(struct snd_sof_dev *sdev)
 /* Mandatory operations are verified during probing */
 
 /* init */
+static inline int snd_sof_probe_early(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->probe_early)
+		return sof_ops(sdev)->probe_early(sdev);
+
+	return 0;
+}
+
 static inline int snd_sof_probe(struct snd_sof_dev *sdev)
 {
 	return sof_ops(sdev)->probe(sdev);
@@ -51,6 +59,14 @@ static inline int snd_sof_remove(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+static inline int snd_sof_remove_late(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->remove_late)
+		return sof_ops(sdev)->remove_late(sdev);
+
+	return 0;
+}
+
 static inline int snd_sof_shutdown(struct snd_sof_dev *sdev)
 {
 	if (sof_ops(sdev)->shutdown)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index d4f6702e93dcb..e73a92189fe1f 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -165,8 +165,10 @@ struct sof_firmware {
 struct snd_sof_dsp_ops {
 
 	/* probe/remove/shutdown */
+	int (*probe_early)(struct snd_sof_dev *sof_dev); /* optional */
 	int (*probe)(struct snd_sof_dev *sof_dev); /* mandatory */
 	int (*remove)(struct snd_sof_dev *sof_dev); /* optional */
+	int (*remove_late)(struct snd_sof_dev *sof_dev); /* optional */
 	int (*shutdown)(struct snd_sof_dev *sof_dev); /* optional */
 
 	/* DSP core boot / reset */
-- 
2.39.2

