Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67267CD08C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjJQXXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbjJQXXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0500210E;
        Tue, 17 Oct 2023 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585002; x=1729121002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KOWPP1PSMoIxt93fKxE8ER0QAdyM8P4EOniZbIxKM6g=;
  b=jp85Dww6X6I5DpOM6D508G4LP65TwVbfczhfcIVR18XPOjpI7EJCKTZk
   DsNkk8NdnrQGtMtu2WogzaIh/Nq8f7O9XIvz9avAMoBJbINw8f2nOZrSQ
   Lcrmoa3gCMeh8+VTLvl/VNAvRbuVS20aPqbURL/Zk8Gq4w4h0VN/F7P2r
   PLnE0AY1WWTZbCBSCC3ZbupXnv+ameV7vi1/lJFs81LK2szGZFaYhQvdZ
   lPkOgoCeLdNx70HvryWAFlAMHixKFzVgu+mbZTWEezzYkwG75/LLMlvZw
   mwo3hWqEnZtNUVO+KIrAudiR4zzMaoXgF48ufiOzN1p9LmiddC5PVol6M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778129"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778129"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637475"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637475"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:20 -0700
Message-ID: <a8dc2a3a-27a2-40d6-9e67-6ea475701e44@linux.intel.com>
Date:   Tue, 17 Oct 2023 17:37:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/34] ALSA: usb-audio: Prevent starting of audio
 stream if in use
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-24-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-24-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 15:00, Wesley Cheng wrote:
> With USB audio offloading, an audio session is started from the ASoC
> platform sound card and PCM devices.  Likewise, the USB SND path is still
> readily available for use, in case the non-offload path is desired.  In
> order to prevent the two entities from attempting to use the USB bus,
> introduce a flag that determines when either paths are in use.
> 
> If a PCM device is already in use, the check will return an error to
> userspace notifying that the stream is currently busy.  This ensures that
> only one path is using the USB substream.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.h                  |  1 +
>  sound/usb/pcm.c                   | 19 +++++++++++++++++--
>  sound/usb/qcom/qc_audio_offload.c | 15 ++++++++++++++-

should this be split in a generic part and a more specific qcom patch?

>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index e26292363cf0..01f7e10f30f4 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -164,6 +164,7 @@ struct snd_usb_substream {
>  	unsigned int pkt_offset_adj;	/* Bytes to drop from beginning of packets (for non-compliant devices) */
>  	unsigned int stream_offset_adj;	/* Bytes to drop from beginning of stream (for non-compliant devices) */
>  
> +	unsigned int opened:1;		/* pcm device opened */
>  	unsigned int running: 1;	/* running status */
>  	unsigned int period_elapsed_pending;	/* delay period handling */
>  
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 3adb09ce1702..c2cb52cd5d23 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -1241,8 +1241,15 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>  	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct snd_usb_substream *subs = &as->substream[direction];
> +	struct snd_usb_audio *chip = subs->stream->chip;
>  	int ret;
>  
> +	mutex_lock(&chip->mutex);
> +	if (subs->opened) {
> +		mutex_unlock(&chip->mutex);
> +		return -EBUSY;
> +	}
> +
>  	runtime->hw = snd_usb_hardware;
>  	/* need an explicit sync to catch applptr update in low-latency mode */
>  	if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
> @@ -1259,13 +1266,17 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>  
>  	ret = setup_hw_info(runtime, subs);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  	ret = snd_usb_autoresume(subs->stream->chip);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  	ret = snd_media_stream_init(subs, as->pcm, direction);
>  	if (ret < 0)
>  		snd_usb_autosuspend(subs->stream->chip);
> +	subs->opened = 1;
> +out:
> +	mutex_unlock(&chip->mutex);
> +
>  	return ret;
>  }
>  
> @@ -1274,6 +1285,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
>  	int direction = substream->stream;
>  	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
>  	struct snd_usb_substream *subs = &as->substream[direction];
> +	struct snd_usb_audio *chip = subs->stream->chip;
>  	int ret;
>  
>  	snd_media_stop_pipeline(subs);
> @@ -1287,6 +1299,9 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
>  
>  	subs->pcm_substream = NULL;
>  	snd_usb_autosuspend(subs->stream->chip);
> +	mutex_lock(&chip->mutex);
> +	subs->opened = 0;
> +	mutex_unlock(&chip->mutex);
>  
>  	return 0;
>  }
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index 320ce3a6688f..bd6b84f72c74 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -1413,12 +1413,17 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		goto response;
>  	}
>  
> +	mutex_lock(&chip->mutex);
>  	if (req_msg->enable) {
> -		if (info_idx < 0 || chip->system_suspend) {
> +		if (info_idx < 0 || chip->system_suspend || subs->opened) {
>  			ret = -EBUSY;
> +			mutex_unlock(&chip->mutex);
> +
>  			goto response;
>  		}
> +		subs->opened = 1;
>  	}
> +	mutex_unlock(&chip->mutex);
>  
>  	if (req_msg->service_interval_valid) {
>  		ret = get_data_interval_from_si(subs,
> @@ -1440,6 +1445,11 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		if (!ret)
>  			ret = prepare_qmi_response(subs, req_msg, &resp,
>  					info_idx);
> +		if (ret < 0) {
> +			mutex_lock(&chip->mutex);
> +			subs->opened = 0;
> +			mutex_unlock(&chip->mutex);
> +		}
>  	} else {
>  		info = &uadev[pcm_card_num].info[info_idx];
>  		if (info->data_ep_pipe) {
> @@ -1463,6 +1473,9 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
>  		}
>  
>  		disable_audio_stream(subs);
> +		mutex_lock(&chip->mutex);
> +		subs->opened = 0;
> +		mutex_unlock(&chip->mutex);
>  	}
>  
>  response:
