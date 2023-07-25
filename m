Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D025760E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGYJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjGYJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:19:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60631173B;
        Tue, 25 Jul 2023 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276736; x=1721812736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R72RUzt3QoJsOVNYAWhWO4uGyKekfMANgpOv6MYiNDY=;
  b=ZshymxI/qlzFeBc7F5F9wyg+kfwmFx+3sgiES9v6HqdFi6JeiyJv2U5b
   qxeM2LLVABDS2pQYWldGcdnVIxtpwOMmcUAMjpIE4Gg505XW7KPksS0WV
   K0M38ZY/Uko9gJid7dgw1+iUAVWJQVlfuj7NuriG7e5jyLoWu5d9SnSXF
   zgRD2FFEpTmQsh4JvNh0cyLmp8ZowekaFTx21OXQ0kdXMLjbLB9IyWpQx
   PvyCD/LfqVFl+xefi9VblnRcf4EQDAQgoREuFcC89AfK/lruPZGFAUhWp
   8ZXKbqoKcdkDFz33Gc4xKyb1JfvlyOOlrHvbyuNnZEIgobGym/LNbu+ac
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="454048958"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="454048958"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719980425"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719980425"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:48 -0700
Message-ID: <2ac68f83-6300-fa61-e1ca-80df07fc1494@linux.intel.com>
Date:   Tue, 25 Jul 2023 10:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 26/32] sound: Pass USB SND card and PCM information to
 SOC USB
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
 <20230725023416.11205-27-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230725023416.11205-27-quic_wcheng@quicinc.com>
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
> Currently, only the index to the USB SND card array is passed to the USB
> backend.  Pass through more information, specifically the USB SND card
> number and the number of PCM devices available.  The USB backend should
> know about which sound resources are being shared between the ASoC and USB
> SND paths.  This can be utilized to properly select and maintain the
> offloading devices.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  include/sound/soc-usb.h           |  9 +++++----
>  sound/soc/qcom/qdsp6/q6usb.c      | 20 ++++++++++++++++++--
>  sound/soc/soc-usb.c               | 12 +++++++-----
>  sound/usb/qcom/qc_audio_offload.c |  9 +++++----
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
> index 71e6e75e600a..606128332044 100644
> --- a/include/sound/soc-usb.h
> +++ b/include/sound/soc-usb.h
> @@ -19,20 +19,21 @@ struct snd_soc_usb {
>  	struct device *dev;
>  	struct snd_soc_component *component;
>  	int (*connection_status_cb)(struct snd_soc_usb *usb, int card_idx,
> -				int connected);
> +				int chip_idx, int num_pcm, int connected);

I don't know what 'chip_idx' is.

The 'num_pcm' sounds problematic if there are different devices for
playback and capture. I would guess this is for playback only, but this
doesn't scale.

>  	void *priv_data;
>  };

> +struct q6usb_status {
> +	unsigned int num_pcm;
> +	unsigned int chip_index;
> +	unsigned int pcm_index;
> +};
> +
>  struct q6usb_port_data {
>  	struct q6afe_usb_cfg usb_cfg;
>  	struct snd_soc_usb *usb;
>  	struct q6usb_offload priv;
> +	unsigned long available_card_slot;

what is a card slot?

> +	struct q6usb_status status[SNDRV_CARDS];
>  	int active_idx;
>  };
>  
> @@ -97,7 +105,7 @@ static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *compone
>  }
>  
>  static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
> -			int connected)
> +			int chip_idx, int num_pcm, int connected)
>  {
>  	struct snd_soc_dapm_context *dapm;
>  	struct q6usb_port_data *data;
> @@ -109,8 +117,16 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>  		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>  		/* We only track the latest USB headset plugged in */
>  		data->active_idx = card_idx;
> +
> +		set_bit(card_idx, &data->available_card_slot);
> +		data->status[card_idx].num_pcm = num_pcm;
> +		data->status[card_idx].chip_index = chip_idx;
>  	} else {
> -		snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> +		clear_bit(card_idx, &data->available_card_slot);
> +		data->status[card_idx].num_pcm = 0;
> +		data->status[card_idx].chip_index = 0;
> +		if (!data->available_card_slot)
> +			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");

not able to follow what this does, this patch is rather unclear and
lacks comments.

>  	}
>  	snd_soc_dapm_sync(dapm);

