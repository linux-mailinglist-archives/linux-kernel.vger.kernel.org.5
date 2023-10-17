Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210B37CD083
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbjJQXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344327AbjJQXXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB1FE;
        Tue, 17 Oct 2023 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585000; x=1729121000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2UKUUSI67P7VTV+D5P7W1dLNBm5HCyoV51RKoH6boYk=;
  b=TavW5mbzx3lO9rKW69sqvxqM4dzMACsepUdqBnL3OVnk5KBuZOcxeI4B
   eS6guP+5eOYcAmg3r0m8R+VgICIuNUjltV2d0FDPg/Ka3eZ7MqWjsWYzO
   DFenq8G0jxHufCd4vp0gllAjzr6u35mL7oBqlZJ68pwXfKEj+BD+M1Xow
   ctV4/Pim70y7v/G3dauag9aD/I6vVudXeTHFSNELdEH00FUoJGXz1PhfQ
   byHWbqeE5vR+5Hi/HiYXljPW1gsBtdUxAxpDkz7QR/FKtFPYz6iNq9/mC
   xNG+YXBAObnoEQxReDh9u/FgNqGkIoaLrGhMYLtqCetOBkuJgqNpWS/wG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778101"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778101"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637465"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637465"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:17 -0700
Message-ID: <ad851c66-5c5f-4bbb-b278-7b0c49b3cb07@linux.intel.com>
Date:   Tue, 17 Oct 2023 17:29:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/34] ALSA: usb-audio: Check for support for requested
 audio format
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
 <20231017200109.11407-21-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-21-quic_wcheng@quicinc.com>
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
> Allow for checks on a specific USB audio device to see if a requested PCM
> format is supported.  This is needed for support for when playback is

This is needed for support when playback is

> initiated by the ASoC USB backend path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  sound/usb/card.h | 11 +++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index c0b312e264bf..88f431917c15 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -162,6 +162,46 @@ int snd_usb_unregister_platform_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
>  
> +/*
> + * Checks to see if requested audio profile, i.e sample rate, # of
> + * channels, etc... is supported by the substream associated to the
> + * USB audio device.
> + */
> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{
> +	struct snd_usb_audio *chip;
> +	struct snd_usb_substream *subs = NULL;

useless init?

> +	struct snd_usb_stream *as;
> +	const struct audioformat *fmt;
> +
> +	/*
> +	 * Register mutex is held when populating and clearing usb_chip
> +	 * array.
> +	 */
> +	mutex_lock(&register_mutex);
> +	chip = usb_chip[card_idx];
> +	if (!chip) {
> +		mutex_unlock(&register_mutex);
> +		return NULL;
> +	}
> +
> +	if (enable[card_idx]) {
> +		list_for_each_entry(as, &chip->pcm_list, list) {
> +			subs = &as->substream[direction];
> +			fmt = snd_usb_find_substream_format(subs, params);
> +			if (fmt) {
> +				mutex_unlock(&register_mutex);
> +				return as;
> +			}
> +		}
> +	}
> +	mutex_unlock(&register_mutex);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
> +
>  /*
>   * disconnect streams
>   * called from usb_audio_disconnect()
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 2884912adc96..e26292363cf0 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -216,4 +216,15 @@ struct snd_usb_platform_ops {
>  
>  int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
>  int snd_usb_unregister_platform_ops(void);
> +
> +#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction);
> +#else
> +static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{
> +	return NULL;
> +}
> +#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
>  #endif /* __USBAUDIO_CARD_H */
