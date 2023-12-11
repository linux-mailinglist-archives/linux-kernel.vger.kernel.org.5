Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856C280CBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjLKNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbjLKNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:53:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3C1BF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B83BC433C7;
        Mon, 11 Dec 2023 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302773;
        bh=c5vY8fBRhxmqlanXxO0Jh66l9SSihX3emMSxI5nzs3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sY36gFDyLql8fS8ntRvKMGsxY6op7QHkX5NT5twX6iHSuTTjRbHU91Q0iuuBkiatM
         cMFNP6cKF+lPvn69SUx+e1H2fcP38uZ/VSr6KgdsMopvRTfnIdpCxGqm3SHdL9w93y
         L+7evuGJ1JNGzqtTdD0gKvBjeqCM9d3cSMXXmog51F2wTZT9kAj8IaMP3oTRkdCK+6
         E2b/7IBmqS/Tm0+AblyvapySkUv7/nfoZCGCCawrKrJwcQFhRI0ngwhgfGOIlKyc0i
         GusByPQXrq8avnMVD/gVOwgmmG2ymWjk6Sv6sDnHVoBbmYm2tX4R27quEm3vojsWzt
         yj/vpIzFlK0/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/47] ASoC: SOF: ipc4-topology: Correct data structures for the SRC module
Date:   Mon, 11 Dec 2023 08:50:23 -0500
Message-ID: <20231211135147.380223-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit c447636970e3409ac39f0bb8c2dcff6b726f36b0 ]

Separate the IPC message part as struct sof_ipc4_src_data. This struct
describes the message payload passed to the firmware via the mailbox.

It is not wise to be 'clever' and try to use the first part of a struct
as IPC message without marking the message section as packed and aligned.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20231129131411.27516-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 21 +++++++++++----------
 sound/soc/sof/ipc4-topology.h | 16 ++++++++++++----
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 05c3b1153a91c..42f6a99935d16 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -139,7 +139,7 @@ static const struct sof_topology_token gain_tokens[] = {
 /* SRC */
 static const struct sof_topology_token src_tokens[] = {
 	{SOF_TKN_SRC_RATE_OUT, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
-		offsetof(struct sof_ipc4_src, sink_rate)},
+		offsetof(struct sof_ipc4_src_data, sink_rate)},
 };
 
 static const struct sof_token_info ipc4_token_list[SOF_TOKEN_COUNT] = {
@@ -812,11 +812,12 @@ static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
 
 	swidget->private = src;
 
-	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &src->available_fmt, &src->base_config);
+	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &src->available_fmt,
+				     &src->data.base_config);
 	if (ret)
 		goto err;
 
-	ret = sof_update_ipc_object(scomp, src, SOF_SRC_TOKENS, swidget->tuples,
+	ret = sof_update_ipc_object(scomp, &src->data, SOF_SRC_TOKENS, swidget->tuples,
 				    swidget->num_tuples, sizeof(*src), 1);
 	if (ret) {
 		dev_err(scomp->dev, "Parsing SRC tokens failed\n");
@@ -825,7 +826,7 @@ static int sof_ipc4_widget_setup_comp_src(struct snd_sof_widget *swidget)
 
 	spipe->core_mask |= BIT(swidget->core);
 
-	dev_dbg(scomp->dev, "SRC sink rate %d\n", src->sink_rate);
+	dev_dbg(scomp->dev, "SRC sink rate %d\n", src->data.sink_rate);
 
 	ret = sof_ipc4_widget_setup_msg(swidget, &src->msg);
 	if (ret)
@@ -1896,7 +1897,7 @@ static int sof_ipc4_prepare_src_module(struct snd_sof_widget *swidget,
 	u32 out_ref_rate, out_ref_channels, out_ref_valid_bits;
 	int output_format_index, input_format_index;
 
-	input_format_index = sof_ipc4_init_input_audio_fmt(sdev, swidget, &src->base_config,
+	input_format_index = sof_ipc4_init_input_audio_fmt(sdev, swidget, &src->data.base_config,
 							   pipeline_params, available_fmt);
 	if (input_format_index < 0)
 		return input_format_index;
@@ -1926,7 +1927,7 @@ static int sof_ipc4_prepare_src_module(struct snd_sof_widget *swidget,
 	 */
 	out_ref_rate = params_rate(fe_params);
 
-	output_format_index = sof_ipc4_init_output_audio_fmt(sdev, &src->base_config,
+	output_format_index = sof_ipc4_init_output_audio_fmt(sdev, &src->data.base_config,
 							     available_fmt, out_ref_rate,
 							     out_ref_channels, out_ref_valid_bits);
 	if (output_format_index < 0) {
@@ -1936,10 +1937,10 @@ static int sof_ipc4_prepare_src_module(struct snd_sof_widget *swidget,
 	}
 
 	/* update pipeline memory usage */
-	sof_ipc4_update_resource_usage(sdev, swidget, &src->base_config);
+	sof_ipc4_update_resource_usage(sdev, swidget, &src->data.base_config);
 
 	out_audio_fmt = &available_fmt->output_pin_fmts[output_format_index].audio_fmt;
-	src->sink_rate = out_audio_fmt->sampling_frequency;
+	src->data.sink_rate = out_audio_fmt->sampling_frequency;
 
 	/* update pipeline_params for sink widgets */
 	return sof_ipc4_update_hw_params(sdev, pipeline_params, out_audio_fmt);
@@ -2297,8 +2298,8 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct sof_ipc4_src *src = swidget->private;
 
-		ipc_size = sizeof(struct sof_ipc4_base_module_cfg) + sizeof(src->sink_rate);
-		ipc_data = src;
+		ipc_size = sizeof(src->data);
+		ipc_data = &src->data;
 
 		msg = &src->msg;
 		break;
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index d75f17f4749c6..f96536dbaee55 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -387,16 +387,24 @@ struct sof_ipc4_mixer {
 	struct sof_ipc4_msg msg;
 };
 
-/**
- * struct sof_ipc4_src SRC config data
+/*
+ * struct sof_ipc4_src_data - IPC data for SRC
  * @base_config: IPC base config data
  * @sink_rate: Output rate for sink module
+ */
+struct sof_ipc4_src_data {
+	struct sof_ipc4_base_module_cfg base_config;
+	uint32_t sink_rate;
+} __packed __aligned(4);
+
+/**
+ * struct sof_ipc4_src - SRC config data
+ * @data: IPC base config data
  * @available_fmt: Available audio format
  * @msg: IPC4 message struct containing header and data info
  */
 struct sof_ipc4_src {
-	struct sof_ipc4_base_module_cfg base_config;
-	uint32_t sink_rate;
+	struct sof_ipc4_src_data data;
 	struct sof_ipc4_available_audio_format available_fmt;
 	struct sof_ipc4_msg msg;
 };
-- 
2.42.0

