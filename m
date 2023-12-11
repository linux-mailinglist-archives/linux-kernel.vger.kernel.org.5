Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327980CBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjLKNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbjLKNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39E120
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFECDC433C7;
        Mon, 11 Dec 2023 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302760;
        bh=5eTUfLAs5dNNGo6U3I5S3mD2bWixkOLW1aVTlKfHDcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fixqfHhfON9eL2ARtGWtxTYr+owU+LztZlcuUnunFqJXdXfRUHrIn848sWbNyaLHb
         jpHYOB3I+MYOmk4km4Lc+aJGyWtyTA0Xc/rprxykP00DJ318fVdPyOp2jSc48EiKAk
         IdKrkVNKGDE8b4MlsPjMglAZQTMngfSUmrSZPUv2n1IPVeU1Dz6KLTV1i0LGFl9IpL
         gXRfWFSlm3CisRdja8p6ZlE04y2zr6V+WxKuD3CmL0yd/KHUKwa7L3tO1lVGQfIVe8
         TRGOeHH7sYQSu5bmVFV7nOty57MsuYaJx8DQqix0gbRpCPC4gLWf9V5G2DBiLaJGIu
         5HFlyV6DRWB+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, daniel.baluta@nxp.com,
        perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/47] ASoC: SOF: sof-audio: Modify logic for enabling/disabling topology cores
Date:   Mon, 11 Dec 2023 08:50:19 -0500
Message-ID: <20231211135147.380223-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 31ed8da1c8e5e504710bb36863700e3389f8fc81 ]

In the current code, we enable a widget core when it is set up and
disable it when it is freed. This is problematic with IPC4 because
widget free is essentially a NOP and all widgets are freed in the
firmware when the pipeline is deleted. This results in a crash during
pipeline deletion when one of it's widgets is scheduled to run on a
secondary core and is powered off when widget is freed. So, change the
logic to enable all cores needed by all the modules in a pipeline when
the pipeline widget is set up and disable them after the pipeline
widget is freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20231124135743.24674-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-audio.c | 65 ++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 563fe6f7789f7..77cc64ac71131 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -46,6 +46,7 @@ static int sof_widget_free_unlocked(struct snd_sof_dev *sdev,
 				    struct snd_sof_widget *swidget)
 {
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	struct snd_sof_widget *pipe_widget;
 	int err = 0;
 	int ret;
@@ -87,15 +88,22 @@ static int sof_widget_free_unlocked(struct snd_sof_dev *sdev,
 	}
 
 	/*
-	 * disable widget core. continue to route setup status and complete flag
-	 * even if this fails and return the appropriate error
+	 * decrement ref count for cores associated with all modules in the pipeline and clear
+	 * the complete flag
 	 */
-	ret = snd_sof_dsp_core_put(sdev, swidget->core);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to disable target core: %d for widget %s\n",
-			swidget->core, swidget->widget->name);
-		if (!err)
-			err = ret;
+	if (swidget->id == snd_soc_dapm_scheduler) {
+		int i;
+
+		for_each_set_bit(i, &spipe->core_mask, sdev->num_cores) {
+			ret = snd_sof_dsp_core_put(sdev, i);
+			if (ret < 0) {
+				dev_err(sdev->dev, "failed to disable target core: %d for pipeline %s\n",
+					i, swidget->widget->name);
+				if (!err)
+					err = ret;
+			}
+		}
+		swidget->spipe->complete = 0;
 	}
 
 	/*
@@ -108,10 +116,6 @@ static int sof_widget_free_unlocked(struct snd_sof_dev *sdev,
 			err = ret;
 	}
 
-	/* clear pipeline complete */
-	if (swidget->id == snd_soc_dapm_scheduler)
-		swidget->spipe->complete = 0;
-
 	if (!err)
 		dev_dbg(sdev->dev, "widget %s freed\n", swidget->widget->name);
 
@@ -134,8 +138,10 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 				     struct snd_sof_widget *swidget)
 {
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
+	struct snd_sof_pipeline *spipe = swidget->spipe;
 	bool use_count_decremented = false;
 	int ret;
+	int i;
 
 	/* skip if there is no private data */
 	if (!swidget->private)
@@ -166,19 +172,23 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 			goto use_count_dec;
 	}
 
-	/* enable widget core */
-	ret = snd_sof_dsp_core_get(sdev, swidget->core);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to enable target core for widget %s\n",
-			swidget->widget->name);
-		goto pipe_widget_free;
+	/* update ref count for cores associated with all modules in the pipeline */
+	if (swidget->id == snd_soc_dapm_scheduler) {
+		for_each_set_bit(i, &spipe->core_mask, sdev->num_cores) {
+			ret = snd_sof_dsp_core_get(sdev, i);
+			if (ret < 0) {
+				dev_err(sdev->dev, "failed to enable target core %d for pipeline %s\n",
+					i, swidget->widget->name);
+				goto pipe_widget_free;
+			}
+		}
 	}
 
 	/* setup widget in the DSP */
 	if (tplg_ops && tplg_ops->widget_setup) {
 		ret = tplg_ops->widget_setup(sdev, swidget);
 		if (ret < 0)
-			goto core_put;
+			goto pipe_widget_free;
 	}
 
 	/* send config for DAI components */
@@ -208,15 +218,22 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 	return 0;
 
 widget_free:
-	/* widget use_count and core ref_count will both be decremented by sof_widget_free() */
+	/* widget use_count will be decremented by sof_widget_free() */
 	sof_widget_free_unlocked(sdev, swidget);
 	use_count_decremented = true;
-core_put:
-	if (!use_count_decremented)
-		snd_sof_dsp_core_put(sdev, swidget->core);
 pipe_widget_free:
-	if (swidget->id != snd_soc_dapm_scheduler)
+	if (swidget->id != snd_soc_dapm_scheduler) {
 		sof_widget_free_unlocked(sdev, swidget->spipe->pipe_widget);
+	} else {
+		int j;
+
+		/* decrement ref count for all cores that were updated previously */
+		for_each_set_bit(j, &spipe->core_mask, sdev->num_cores) {
+			if (j >= i)
+				break;
+			snd_sof_dsp_core_put(sdev, j);
+		}
+	}
 use_count_dec:
 	if (!use_count_decremented)
 		swidget->use_count--;
-- 
2.42.0

