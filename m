Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09917760E53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGYJTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjGYJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:19:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E62100;
        Tue, 25 Jul 2023 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276748; x=1721812748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ftlTnZLDKGNw8f2OS/kJtQKY7p+STDvyqbF9dlRCEA=;
  b=jEswhuXsF+3gcluUA76NV7Ww2hZ1njxfxw33M5+FrtFaAdnkPPT39rfu
   /7pb/TPFVhRwk+xagQ7sV0RQbE3Jah4zCr8ogUarxP73WtfvQiVWICWg+
   +UUIzm9rjqVBI/PB981QwCV6qIKImQcUDxZZPaCydbW51Smam88zP/iKJ
   3Ls0K/EPJs46EwtGo9RGL9uda4qhC1FAn1cTsiDlIK9PjGVZIHE6G0F3E
   zqZexdbCPQIz2UHLxokHprzh00Qq9Neu5ozV/TPmXs1LoUWRCWrHeKong
   RBkL+8iohGYPU4gglsgbC8SX+TrJHHtjZEqWyjHsWO3yukndMErc0DXMG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367690997"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367690997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719980480"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719980480"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:58 -0700
Message-ID: <987394fd-9724-aa42-37fe-be9707565405@linux.intel.com>
Date:   Tue, 25 Jul 2023 11:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 29/32] sound: soc: qcom: q6usb: Add headphone jack for
 offload connection status
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
 <20230725023416.11205-30-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230725023416.11205-30-quic_wcheng@quicinc.com>
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
> The headphone jack framework has a well defined intrastructure for

infrastructure

> notifying userspace entities through input devices.  Expose a jack device
> that carries information about if an offload capable device is connected.
> Applications can further identify specific offloading information through
> other SND kcontrols.

What if you connect a set of USB speakers? Would they show as a
headphone/headset?

> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/soc/qcom/qdsp6/q6usb.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
> index e4ccb9d912b0..860dff8c1438 100644
> --- a/sound/soc/qcom/qdsp6/q6usb.c
> +++ b/sound/soc/qcom/qdsp6/q6usb.c
> @@ -20,6 +20,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/asound.h>
>  #include <sound/q6usboffload.h>
> +#include <sound/jack.h>
>  
>  #include "q6dsp-lpass-ports.h"
>  #include "q6afe.h"
> @@ -37,6 +38,7 @@ struct q6usb_status {
>  struct q6usb_port_data {
>  	struct q6afe_usb_cfg usb_cfg;
>  	struct snd_soc_usb *usb;
> +	struct snd_soc_jack hs_jack;
>  	struct q6usb_offload priv;
>  	struct mutex mutex;
>  	unsigned long available_card_slot;
> @@ -279,6 +281,7 @@ static const struct snd_kcontrol_new q6usb_offload_control = {
>  /* Build a mixer control for a UAC connector control (jack-detect) */
>  static void q6usb_connector_control_init(struct snd_soc_component *component)
>  {
> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
>  	int ret;
>  
>  	ret = snd_ctl_add(component->card->snd_card,
> @@ -290,6 +293,11 @@ static void q6usb_connector_control_init(struct snd_soc_component *component)
>  				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
>  	if (ret < 0)
>  		return;
> +
> +	ret = snd_soc_card_jack_new(component->card, "USB offload",
> +					SND_JACK_HEADSET, &data->hs_jack);

not all USB devices are headsets...

> +	if (ret)
> +		return;
>  }
>  
>  static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
> @@ -322,7 +330,10 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>  
>  	mutex_lock(&data->mutex);
>  	if (connected) {
> -		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
> +		if (!data->available_card_slot) {
> +			snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
> +			snd_jack_report(data->hs_jack.jack, 1);
> +		}
>  		/*
>  		 * Update the latest USB headset plugged in, if session is
>  		 * idle.
> @@ -338,8 +349,10 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>  		clear_bit(card_idx, &data->available_card_slot);
>  		data->status[card_idx].num_pcm = 0;
>  		data->status[card_idx].chip_index = 0;
> -		if (!data->available_card_slot)
> +		if (!data->available_card_slot) {
>  			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
> +			snd_jack_report(data->hs_jack.jack, 0);
> +		}
>  	}
>  	snd_soc_dapm_sync(dapm);
>  	mutex_unlock(&data->mutex);
