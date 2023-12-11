Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6A80CBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbjLKNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbjLKNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:53:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBA3189
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFFEC4166B;
        Mon, 11 Dec 2023 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302775;
        bh=PEqivlBLW3JJ9JmqAh+FXSaYMQwIQ+g0qUYB1U47TR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+xtCVm2yvKDF2yRzmXgcLW8dgbeuUorY8DPAebjCrAX1QaRrKgb20ss/7lc+rTKp
         tZMZ3VKfy43p6yo2XavftdGWPhsWQTx+6uXrc/v9+Qvxwow8/RAeV289Q2kRyjuRGp
         BLXkQFUhKuVL6r175GyiSIeZEFpgN+lP+WOgtb9KhQL2Z9Y8MPxO+EeBqVF6ttDRf6
         pBaphw2ReHAjYcYqFKftjtmndlXwgk9JsOE/tFpD3Mv+LKagZAC0bh1bpD6t1Z/JK1
         KL0o51wMv8r6RfcGZT6wNWw9aWWfmpyT877Fwqospcai29jnyNpwkoDzAkyriru1N9
         rK+QnPggPvQIQ==
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
Subject: [PATCH AUTOSEL 6.6 23/47] ASoC: SOF: ipc4-topology: Correct data structures for the GAIN module
Date:   Mon, 11 Dec 2023 08:50:24 -0500
Message-ID: <20231211135147.380223-23-sashal@kernel.org>
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

[ Upstream commit e238b68e6dc89ddab52bd98216fe5623e94792b1 ]

Move the base_cfg to struct sof_ipc4_gain_data. This struct
describes the message payload passed to the firmware via the mailbox.

It is not wise to be 'clever' and try to use the first part of a struct
as IPC message without marking the message section as packed and aligned.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20231129131411.27516-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-control.c  | 20 ++++++++++----------
 sound/soc/sof/ipc4-topology.c | 31 +++++++++++++++----------------
 sound/soc/sof/ipc4-topology.h | 18 +++++++++++++-----
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index c6d404d440970..e4ce1b53fba65 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -89,7 +89,7 @@ sof_ipc4_set_volume_data(struct snd_sof_dev *sdev, struct snd_sof_widget *swidge
 	struct sof_ipc4_control_data *cdata = scontrol->ipc_control_data;
 	struct sof_ipc4_gain *gain = swidget->private;
 	struct sof_ipc4_msg *msg = &cdata->msg;
-	struct sof_ipc4_gain_data data;
+	struct sof_ipc4_gain_params params;
 	bool all_channels_equal = true;
 	u32 value;
 	int ret, i;
@@ -109,20 +109,20 @@ sof_ipc4_set_volume_data(struct snd_sof_dev *sdev, struct snd_sof_widget *swidge
 	 */
 	for (i = 0; i < scontrol->num_channels; i++) {
 		if (all_channels_equal) {
-			data.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
-			data.init_val = cdata->chanv[0].value;
+			params.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
+			params.init_val = cdata->chanv[0].value;
 		} else {
-			data.channels = cdata->chanv[i].channel;
-			data.init_val = cdata->chanv[i].value;
+			params.channels = cdata->chanv[i].channel;
+			params.init_val = cdata->chanv[i].value;
 		}
 
 		/* set curve type and duration from topology */
-		data.curve_duration_l = gain->data.curve_duration_l;
-		data.curve_duration_h = gain->data.curve_duration_h;
-		data.curve_type = gain->data.curve_type;
+		params.curve_duration_l = gain->data.params.curve_duration_l;
+		params.curve_duration_h = gain->data.params.curve_duration_h;
+		params.curve_type = gain->data.params.curve_type;
 
-		msg->data_ptr = &data;
-		msg->data_size = sizeof(data);
+		msg->data_ptr = &params;
+		msg->data_size = sizeof(params);
 
 		ret = sof_ipc4_set_get_kcontrol_data(scontrol, true, lock);
 		msg->data_ptr = NULL;
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 42f6a99935d16..2c075afd237ce 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -128,12 +128,12 @@ static const struct sof_topology_token comp_ext_tokens[] = {
 
 static const struct sof_topology_token gain_tokens[] = {
 	{SOF_TKN_GAIN_RAMP_TYPE, SND_SOC_TPLG_TUPLE_TYPE_WORD,
-		get_token_u32, offsetof(struct sof_ipc4_gain_data, curve_type)},
+		get_token_u32, offsetof(struct sof_ipc4_gain_params, curve_type)},
 	{SOF_TKN_GAIN_RAMP_DURATION,
 		SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
-		offsetof(struct sof_ipc4_gain_data, curve_duration_l)},
+		offsetof(struct sof_ipc4_gain_params, curve_duration_l)},
 	{SOF_TKN_GAIN_VAL, SND_SOC_TPLG_TUPLE_TYPE_WORD,
-		get_token_u32, offsetof(struct sof_ipc4_gain_data, init_val)},
+		get_token_u32, offsetof(struct sof_ipc4_gain_params, init_val)},
 };
 
 /* SRC */
@@ -721,15 +721,15 @@ static int sof_ipc4_widget_setup_comp_pga(struct snd_sof_widget *swidget)
 
 	swidget->private = gain;
 
-	gain->data.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
-	gain->data.init_val = SOF_IPC4_VOL_ZERO_DB;
+	gain->data.params.channels = SOF_IPC4_GAIN_ALL_CHANNELS_MASK;
+	gain->data.params.init_val = SOF_IPC4_VOL_ZERO_DB;
 
-	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &gain->available_fmt, &gain->base_config);
+	ret = sof_ipc4_get_audio_fmt(scomp, swidget, &gain->available_fmt, &gain->data.base_config);
 	if (ret)
 		goto err;
 
-	ret = sof_update_ipc_object(scomp, &gain->data, SOF_GAIN_TOKENS, swidget->tuples,
-				    swidget->num_tuples, sizeof(gain->data), 1);
+	ret = sof_update_ipc_object(scomp, &gain->data.params, SOF_GAIN_TOKENS,
+				    swidget->tuples, swidget->num_tuples, sizeof(gain->data), 1);
 	if (ret) {
 		dev_err(scomp->dev, "Parsing gain tokens failed\n");
 		goto err;
@@ -737,8 +737,8 @@ static int sof_ipc4_widget_setup_comp_pga(struct snd_sof_widget *swidget)
 
 	dev_dbg(scomp->dev,
 		"pga widget %s: ramp type: %d, ramp duration %d, initial gain value: %#x\n",
-		swidget->widget->name, gain->data.curve_type, gain->data.curve_duration_l,
-		gain->data.init_val);
+		swidget->widget->name, gain->data.params.curve_type,
+		gain->data.params.curve_duration_l, gain->data.params.init_val);
 
 	ret = sof_ipc4_widget_setup_msg(swidget, &gain->msg);
 	if (ret)
@@ -1822,7 +1822,7 @@ static int sof_ipc4_prepare_gain_module(struct snd_sof_widget *swidget,
 	u32 out_ref_rate, out_ref_channels, out_ref_valid_bits;
 	int ret;
 
-	ret = sof_ipc4_init_input_audio_fmt(sdev, swidget, &gain->base_config,
+	ret = sof_ipc4_init_input_audio_fmt(sdev, swidget, &gain->data.base_config,
 					    pipeline_params, available_fmt);
 	if (ret < 0)
 		return ret;
@@ -1832,7 +1832,7 @@ static int sof_ipc4_prepare_gain_module(struct snd_sof_widget *swidget,
 	out_ref_channels = SOF_IPC4_AUDIO_FORMAT_CFG_CHANNELS_COUNT(in_fmt->fmt_cfg);
 	out_ref_valid_bits = SOF_IPC4_AUDIO_FORMAT_CFG_V_BIT_DEPTH(in_fmt->fmt_cfg);
 
-	ret = sof_ipc4_init_output_audio_fmt(sdev, &gain->base_config, available_fmt,
+	ret = sof_ipc4_init_output_audio_fmt(sdev, &gain->data.base_config, available_fmt,
 					     out_ref_rate, out_ref_channels, out_ref_valid_bits);
 	if (ret < 0) {
 		dev_err(sdev->dev, "Failed to initialize output format for %s",
@@ -1841,7 +1841,7 @@ static int sof_ipc4_prepare_gain_module(struct snd_sof_widget *swidget,
 	}
 
 	/* update pipeline memory usage */
-	sof_ipc4_update_resource_usage(sdev, swidget, &gain->base_config);
+	sof_ipc4_update_resource_usage(sdev, swidget, &gain->data.base_config);
 
 	return 0;
 }
@@ -2277,9 +2277,8 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct sof_ipc4_gain *gain = swidget->private;
 
-		ipc_size = sizeof(struct sof_ipc4_base_module_cfg) +
-			   sizeof(struct sof_ipc4_gain_data);
-		ipc_data = gain;
+		ipc_size = sizeof(gain->data);
+		ipc_data = &gain->data;
 
 		msg = &gain->msg;
 		break;
diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index f96536dbaee55..21436657ad85b 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -344,7 +344,7 @@ struct sof_ipc4_control_data {
 };
 
 /**
- * struct sof_ipc4_gain_data - IPC gain blob
+ * struct sof_ipc4_gain_params - IPC gain parameters
  * @channels: Channels
  * @init_val: Initial value
  * @curve_type: Curve type
@@ -352,24 +352,32 @@ struct sof_ipc4_control_data {
  * @curve_duration_l: Curve duration low part
  * @curve_duration_h: Curve duration high part
  */
-struct sof_ipc4_gain_data {
+struct sof_ipc4_gain_params {
 	uint32_t channels;
 	uint32_t init_val;
 	uint32_t curve_type;
 	uint32_t reserved;
 	uint32_t curve_duration_l;
 	uint32_t curve_duration_h;
-} __aligned(8);
+} __packed __aligned(4);
 
 /**
- * struct sof_ipc4_gain - gain config data
+ * struct sof_ipc4_gain_data - IPC gain init blob
  * @base_config: IPC base config data
+ * @params: Initial parameters for the gain module
+ */
+struct sof_ipc4_gain_data {
+	struct sof_ipc4_base_module_cfg base_config;
+	struct sof_ipc4_gain_params params;
+} __packed __aligned(4);
+
+/**
+ * struct sof_ipc4_gain - gain config data
  * @data: IPC gain blob
  * @available_fmt: Available audio format
  * @msg: message structure for gain
  */
 struct sof_ipc4_gain {
-	struct sof_ipc4_base_module_cfg base_config;
 	struct sof_ipc4_gain_data data;
 	struct sof_ipc4_available_audio_format available_fmt;
 	struct sof_ipc4_msg msg;
-- 
2.42.0

