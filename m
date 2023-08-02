Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945DA76C506
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHBFve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHBFvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:51:31 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C310FF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690955490; x=1722491490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VVqZYO0rARdOBU1oajHtmOXAGKSye6Y9eY3xVnlO75w=;
  b=XkMEsCaAClfC5RMeTlfiOuVGqt4Y1dzatcw1cSMQrfvOP6r913Y/44Am
   qawJNrLx6j25dQxNWqbZRKJAswmKPwf/WesEU5PWDG4jp15zs4LTPb2tC
   hb1xQQ4jx7aPUiRyTS6VKVXIi5xgls8f+5GqYjaOwOdo2eKPVU0Ip1okQ
   j4rwkHKcGEemjortVTJUmkDLeAp7dG1Fj7aBH2Cr8tUVhL7ez7gdEsUaC
   fmfnmG3qZi5LB1Gm8dQbhRIXw9XC3jrrYPbqAKCpUSb8hrvu2YjS6RBYm
   zVuj/3+S1s/hNq3ASO3Glr4c2x19dVUXa8Eq+slRZfPhlOkYRRqTLWWnZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455856582"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="455856582"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 22:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678920393"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="678920393"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 22:51:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel_ace2x: add DAI hw_params/prepare/hw_free callbacks
Date:   Wed,  2 Aug 2023 14:19:47 +0800
Message-Id: <20230802061947.3788679-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The code is fork-lifted from intel.c and is mostly similar *except*
for the SHIM configuration which cannot be done here with the
introduction of HDAudio Extended links. The ACE2.x SOF side also
requires the hw_free and trigger callbacks to be implemented for
HDaudio DMA management

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 283 ++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 1be0bea5f40f..a9d25ae0b73f 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -10,6 +10,7 @@
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
+#include <sound/pcm_params.h>
 #include <sound/hda-mlink.h>
 #include "cadence_master.h"
 #include "bus.h"
@@ -191,10 +192,292 @@ static bool intel_check_cmdsync_unlocked(struct sdw_intel *sdw)
 	return hdac_bus_eml_sdw_check_cmdsync_unlocked(sdw->link_res->hbus);
 }
 
+/* DAI callbacks */
+static int intel_params_stream(struct sdw_intel *sdw,
+			       struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai,
+			       struct snd_pcm_hw_params *hw_params,
+			       int link_id, int alh_stream_id)
+{
+	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_intel_stream_params_data params_data;
+
+	params_data.substream = substream;
+	params_data.dai = dai;
+	params_data.hw_params = hw_params;
+	params_data.link_id = link_id;
+	params_data.alh_stream_id = alh_stream_id;
+
+	if (res->ops && res->ops->params_stream && res->dev)
+		return res->ops->params_stream(res->dev,
+					       &params_data);
+	return -EIO;
+}
+
+static int intel_free_stream(struct sdw_intel *sdw,
+			     struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai,
+			     int link_id)
+
+{
+	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_intel_stream_free_data free_data;
+
+	free_data.substream = substream;
+	free_data.dai = dai;
+	free_data.link_id = link_id;
+
+	if (res->ops && res->ops->free_stream && res->dev)
+		return res->ops->free_stream(res->dev,
+					     &free_data);
+
+	return 0;
+}
+
 /*
  * DAI operations
  */
+static int intel_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns_dai_runtime *dai_runtime;
+	struct sdw_cdns_pdi *pdi;
+	struct sdw_stream_config sconfig;
+	struct sdw_port_config *pconfig;
+	int ch, dir;
+	int ret;
+
+	dai_runtime = cdns->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return -EIO;
+
+	ch = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dir = SDW_DATA_DIR_RX;
+	else
+		dir = SDW_DATA_DIR_TX;
+
+	pdi = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
+
+	if (!pdi) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* the SHIM will be configured in the callback functions */
+
+	sdw_cdns_config_stream(cdns, ch, dir, pdi);
+
+	/* store pdi and state, may be needed in prepare step */
+	dai_runtime->paused = false;
+	dai_runtime->suspended = false;
+	dai_runtime->pdi = pdi;
+
+	/* Inform DSP about PDI stream number */
+	ret = intel_params_stream(sdw, substream, dai, params,
+				  sdw->instance,
+				  pdi->intel_alh_id);
+	if (ret)
+		goto error;
+
+	sconfig.direction = dir;
+	sconfig.ch_count = ch;
+	sconfig.frame_rate = params_rate(params);
+	sconfig.type = dai_runtime->stream_type;
+
+	sconfig.bps = snd_pcm_format_width(params_format(params));
+
+	/* Port configuration */
+	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
+	if (!pconfig) {
+		ret =  -ENOMEM;
+		goto error;
+	}
+
+	pconfig->num = pdi->num;
+	pconfig->ch_mask = (1 << ch) - 1;
+
+	ret = sdw_stream_add_master(&cdns->bus, &sconfig,
+				    pconfig, 1, dai_runtime->stream);
+	if (ret)
+		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
+
+	kfree(pconfig);
+error:
+	return ret;
+}
+
+static int intel_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns_dai_runtime *dai_runtime;
+	int ch, dir;
+	int ret = 0;
+
+	dai_runtime = cdns->dai_runtime_array[dai->id];
+	if (!dai_runtime) {
+		dev_err(dai->dev, "failed to get dai runtime in %s\n",
+			__func__);
+		return -EIO;
+	}
+
+	if (dai_runtime->suspended) {
+		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+		struct snd_pcm_hw_params *hw_params;
+
+		hw_params = &rtd->dpcm[substream->stream].hw_params;
+
+		dai_runtime->suspended = false;
+
+		/*
+		 * .prepare() is called after system resume, where we
+		 * need to reinitialize the SHIM/ALH/Cadence IP.
+		 * .prepare() is also called to deal with underflows,
+		 * but in those cases we cannot touch ALH/SHIM
+		 * registers
+		 */
+
+		/* configure stream */
+		ch = params_channels(hw_params);
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			dir = SDW_DATA_DIR_RX;
+		else
+			dir = SDW_DATA_DIR_TX;
+
+		/* the SHIM will be configured in the callback functions */
+
+		sdw_cdns_config_stream(cdns, ch, dir, dai_runtime->pdi);
+
+		/* Inform DSP about PDI stream number */
+		ret = intel_params_stream(sdw, substream, dai,
+					  hw_params,
+					  sdw->instance,
+					  dai_runtime->pdi->intel_alh_id);
+	}
+
+	return ret;
+}
+
+static int
+intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns_dai_runtime *dai_runtime;
+	int ret;
+
+	dai_runtime = cdns->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return -EIO;
+
+	/*
+	 * The sdw stream state will transition to RELEASED when stream->
+	 * master_list is empty. So the stream state will transition to
+	 * DEPREPARED for the first cpu-dai and to RELEASED for the last
+	 * cpu-dai.
+	 */
+	ret = sdw_stream_remove_master(&cdns->bus, dai_runtime->stream);
+	if (ret < 0) {
+		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
+			dai_runtime->stream->name, ret);
+		return ret;
+	}
+
+	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
+	if (ret < 0) {
+		dev_err(dai->dev, "intel_free_stream: failed %d\n", ret);
+		return ret;
+	}
+
+	dai_runtime->pdi = NULL;
+
+	return 0;
+}
+
+static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
+				    void *stream, int direction)
+{
+	return cdns_set_sdw_stream(dai, stream, direction);
+}
+
+static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
+				  int direction)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_cdns_dai_runtime *dai_runtime;
+
+	dai_runtime = cdns->dai_runtime_array[dai->id];
+	if (!dai_runtime)
+		return ERR_PTR(-EINVAL);
+
+	return dai_runtime->stream;
+}
+
+static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_cdns_dai_runtime *dai_runtime;
+	int ret = 0;
+
+	/*
+	 * The .trigger callback is used to program HDaudio DMA and send required IPC to audio
+	 * firmware.
+	 */
+	if (res->ops && res->ops->trigger) {
+		ret = res->ops->trigger(substream, cmd, dai);
+		if (ret < 0)
+			return ret;
+	}
+
+	dai_runtime = cdns->dai_runtime_array[dai->id];
+	if (!dai_runtime) {
+		dev_err(dai->dev, "failed to get dai runtime in %s\n",
+			__func__);
+		return -EIO;
+	}
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+
+		/*
+		 * The .prepare callback is used to deal with xruns and resume operations.
+		 * In the case of xruns, the DMAs and SHIM registers cannot be touched,
+		 * but for resume operations the DMAs and SHIM registers need to be initialized.
+		 * the .trigger callback is used to track the suspend case only.
+		 */
+
+		dai_runtime->suspended = true;
+
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dai_runtime->paused = true;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dai_runtime->paused = false;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
+	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
+	.hw_free = intel_hw_free,
+	.trigger = intel_trigger,
+	.set_stream = intel_pcm_set_sdw_stream,
+	.get_stream = intel_get_sdw_stream,
 };
 
 static const struct snd_soc_component_driver dai_component = {
-- 
2.25.1

