Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40080760E57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjGYJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjGYJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:19:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5819BD;
        Tue, 25 Jul 2023 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276754; x=1721812754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OmPXnBpjFbasw+T9ea6wqRGGLgB3z7Oa0ef3fv0n3bc=;
  b=U1TZhelfw7Bd9rL2Kfl4Gxa2LGz6DR30Sxjx3zbuebejLxkM2miE53Y1
   sigEhynVmBSJrZUYIW2yiLYMNUYv01bGJWbiB+yYU+x9QbU70DYzTAJ8z
   4gq1KrKQsJgTg2/kYRALT64ZiHrA9TmUeBkP34dW13uq0UdnLNDRIkFWb
   PQ46+qIDKvFXzdhWFX4Ln4+66HlSuOVmjZtJZfHUoaTVo9umsfSGTZ7uG
   ++cVY9/XQjVAEWAJtkblyK+MvFycCkjbiJbqhkGfhDQsgYfrFqZj7SX0t
   S9UtSMycNsOEYVuQNKgyzTP1ndT6IULsmna0qgHsY9Ylg04Kv3XSGAKHc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367691068"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367691068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719980536"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719980536"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:19:07 -0700
Message-ID: <671a524d-b4c8-78d8-33de-40170a23d189@linux.intel.com>
Date:   Tue, 25 Jul 2023 11:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 31/32] sound: usb: card: Allow for rediscovery of
 connected USB SND devices
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, oneukum@suse.com, albertccwang@google.com,
        o-takashi@sakamocchi.jp
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-32-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230725023416.11205-32-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 04:34, Wesley Cheng wrote:
> In case of notifying SND platform drivers of connection events, some of
> these use cases, such as offloading, require an ASoC USB backend device to
> be initialized before the events can be handled.  If the USB backend device
> has not yet been probed, this leads to missing initial USB audio device
> connection events.
> 
> Expose an API that traverses the usb_chip array for connected devices, and
> to call the respective connection callback registered to the SND platform
> driver.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 19 +++++++++++++++++++
>  sound/usb/card.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 365f6d978608..27a89aaa0bf3 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -170,6 +170,25 @@ struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>  }
>  EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
>  
> +/*
> + * in case the platform driver was not ready at the time of USB SND
> + * device connect, expose an API to discover all connected USB devices
> + * so it can populate any dependent resources/structures.
> + */
> +void snd_usb_rediscover_devices(void)
> +{
> +	int i;
> +
> +	mutex_lock(&register_mutex);
> +	for (i = 0; i < SNDRV_CARDS; i++) {
> +		if (usb_chip[i])
> +			if (platform_ops && platform_ops->connect_cb)
> +				platform_ops->connect_cb(usb_chip[i]);

what happens if the USB device is removed while the platform device adds
a port?

This sounds super-racy to me. It's the same set of problems we're having
between audio and display/DRM, I would be surprised if this function
dealt with all corner cases of insertion/removal, bind/unbind.


> +	}
> +	mutex_unlock(&register_mutex);
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_rediscover_devices);
> +
>  /*
>   * disconnect streams
>   * called from usb_audio_disconnect()
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index db735680d155..dfd241334e3d 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -219,6 +219,7 @@ int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
>  int snd_usb_unregister_platform_ops(void);
>  struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>  			struct snd_pcm_hw_params *params, int direction);
> +void snd_usb_rediscover_devices(void);
>  #else
>  static int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
>  {
> @@ -235,5 +236,6 @@ static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>  {
>  	return NULL;
>  }
> +void snd_usb_rediscover_devices(void) { }
>  #endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
>  #endif /* __USBAUDIO_CARD_H */
