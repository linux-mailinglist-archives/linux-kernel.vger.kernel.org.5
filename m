Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E182760E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGYJUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjGYJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:19:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814DB10C9;
        Tue, 25 Jul 2023 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276763; x=1721812763;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fT7UdVgdEEl+ZFiS15hmRCtO+NdZ6vDRswmYs/CTzQQ=;
  b=iQrCyOjVDmixuP8nOaoBuPuLNpzk9ZKGtspGaX0nCFHqMCKliS+h1Qlq
   G/WxubDguxdkZYWB+38cBL/Lw1FNHTdkUP6Du8Be1lYM0Sv4RFuKUv8hN
   /s2/zVcjd2TEIKHrT4YdFjgCeqsTXSxoFvyfb1RnPXrK2vSeSrdoPH4GT
   tgQmh1NyuL2B9AAztXYlAuaDCJc+RFqh4z7JNMNd22JMSyWrwqkS5xjzy
   5jOTav220z5mEWnKGyLYDaP77jZIwv+Q7WS384z38CWr8V6tPxyEb3zLC
   47bgFaEL/au28AhxHDBuUsB6m1ndT4x0cpU9rNyhQXN+485J4+oSsJ5NY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367691144"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367691144"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719980588"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719980588"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:19:16 -0700
Message-ID: <82568c9d-05b8-54dc-47e9-05c74a9260be@linux.intel.com>
Date:   Tue, 25 Jul 2023 11:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 27/32] sound: soc: qdsp6: Add SND kcontrol to select
 offload device
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
 <20230725023416.11205-28-quic_wcheng@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230725023416.11205-28-quic_wcheng@quicinc.com>
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
> Expose a kcontrol on the platform sound card, which will allow for
> userspace to determine which USB card number and PCM device to offload.
> This allows for userspace to potentially tag an alternate path for a
> specific USB SND card and PCM device.  Previously, control was absent, and
> the offload path would be enabled on the last USB SND device which was
> connected.  This logic will continue to be applicable if no mixer input is
> received for specific device selection.
> 
> An example to configure the offload device using tinymix:
> tinymix -D 0 set 'Q6USB offload SND device select' 1 0
> 
> The above will set the Q6AFE device token to choose offload on card#1 and
> pcm#0.  Device selection is made possible by setting the Q6AFE device
> token.  The audio DSP utilizes this parameter, and will pass this field
> back to the USB offload driver within the QMI stream requests.

I must be missing something... If you have a card 0 which exposes a
control to change what the card1 does, then it means you have a card0
with a PCM device what can potentially be used concurrently with the
card1 exposing an offload device.

Is there any sort of mutual exclusion to make sure the same USB endpoint
is not used twice?

One would hope that when a device is opened the matching non-offloaded
one (or ones in the case of implicit feedback) is disabled or marked as
used?

I would guess in your Android setup you have control on such behavior at
the HAL level, but in the more generic Linux use I don't see what
would orchestrate the use of two devices, and at the kernel level what
would prevent it.


> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/soc/qcom/qdsp6/q6usb.c | 126 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
> index 2fb6159bd2a8..87e88dafd8ad 100644
> --- a/sound/soc/qcom/qdsp6/q6usb.c
> +++ b/sound/soc/qcom/qdsp6/q6usb.c
> @@ -14,6 +14,7 @@
>  #include <linux/dma-map-ops.h>
>  
>  #include <sound/pcm.h>
> +#include <sound/control.h>
>  #include <sound/soc.h>
>  #include <sound/soc-usb.h>
>  #include <sound/pcm_params.h>
> @@ -35,9 +36,12 @@ struct q6usb_port_data {
>  	struct q6afe_usb_cfg usb_cfg;
>  	struct snd_soc_usb *usb;
>  	struct q6usb_offload priv;
> +	struct mutex mutex;
>  	unsigned long available_card_slot;
>  	struct q6usb_status status[SNDRV_CARDS];
> -	int active_idx;
> +	bool idx_valid;
> +	int sel_card_idx;
> +	int sel_pcm_idx;
>  };
>  
>  static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
> @@ -53,10 +57,36 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
>  			   struct snd_soc_dai *dai)
>  {
>  	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct q6afe_port *q6usb_afe;
>  	int direction = substream->stream;
> +	int chip_idx;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	chip_idx = data->status[data->sel_card_idx].chip_index;
> +
> +	ret = snd_soc_usb_find_format(chip_idx, params, direction);
> +	if (ret < 0)
> +		goto out;
> +
> +	q6usb_afe = q6afe_port_get_from_id(cpu_dai->dev, USB_RX);
> +	if (IS_ERR(q6usb_afe))
> +		goto out;
> +
> +	ret = afe_port_send_usb_dev_param(q6usb_afe, data->sel_card_idx,
> +						data->sel_pcm_idx);
> +	if (ret < 0)
> +		goto out;
> +
> +	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
> +out:
> +	mutex_unlock(&data->mutex);
>  
> -	return snd_soc_usb_find_format(data->active_idx, params, direction);
> +	return ret;
>  }
> +
>  static const struct snd_soc_dai_ops q6usb_ops = {
>  	.hw_params = q6usb_hw_params,
>  };
> @@ -85,6 +115,89 @@ static struct snd_soc_dai_driver q6usb_be_dais[] = {
>  	},
>  };
>  
> +static int q6usb_get_offload_dev(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
> +	int pcm_idx;
> +	int card_idx;
> +
> +	mutex_lock(&data->mutex);
> +	if (!data->idx_valid) {
> +		card_idx = -1;
> +		pcm_idx = -1;
> +	} else {
> +		card_idx = data->sel_card_idx;
> +		pcm_idx = data->sel_pcm_idx;
> +	}
> +
> +	ucontrol->value.integer.value[0] = card_idx;
> +	ucontrol->value.integer.value[1] = pcm_idx;
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
> +	int changed = 0;
> +	int pcmidx;
> +	int cardidx;
> +
> +	cardidx = ucontrol->value.integer.value[0];
> +	pcmidx = ucontrol->value.integer.value[1];
> +
> +	mutex_lock(&data->mutex);
> +	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
> +		data->sel_card_idx = cardidx;
> +		changed = 1;
> +	}
> +
> +	if ((pcmidx >= 0 && pcmidx < data->status[cardidx].num_pcm)) {
> +		data->sel_pcm_idx = pcmidx;
> +		data->idx_valid = true;
> +		changed = 1;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return changed;
> +}
> +
> +static int q6usb_offload_dev_info(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 2;
> +	uinfo->value.integer.min = -1;
> +	uinfo->value.integer.max = SNDRV_CARDS;
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new q6usb_offload_dev_ctrl = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
> +	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +	.name = "Q6USB offload SND device select",
> +	.info = q6usb_offload_dev_info,
> +	.get = q6usb_get_offload_dev,
> +	.put = q6usb_put_offload_dev,
> +};
> +
> +/* Build a mixer control for a UAC connector control (jack-detect) */
> +static void q6usb_connector_control_init(struct snd_soc_component *component)
> +{
> +	int ret;
> +
> +	ret = snd_ctl_add(component->card->snd_card,
> +				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
> +	if (ret < 0)
> +		return;
> +}
> +
>  static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
>  					const struct of_phandle_args *args,
>  					const char **dai_name)
> @@ -113,10 +226,12 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>  	dapm = snd_soc_component_get_dapm(usb->component);
>  	data = dev_get_drvdata(usb->component->dev);
>  
> +	mutex_lock(&data->mutex);
>  	if (connected) {
>  		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
>  		/* We only track the latest USB headset plugged in */
> -		data->active_idx = card_idx;
> +		if (!data->idx_valid || data->sel_card_idx < 0)
> +			data->sel_card_idx = card_idx;
>  
>  		set_bit(card_idx, &data->available_card_slot);
>  		data->status[card_idx].num_pcm = num_pcm;
> @@ -129,6 +244,7 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
>  			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
>  	}
>  	snd_soc_dapm_sync(dapm);
> +	mutex_unlock(&data->mutex);
>  
>  	return 0;
>  }
> @@ -141,6 +257,8 @@ static int q6usb_component_probe(struct snd_soc_component *component)
>  	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
>  	snd_soc_dapm_sync(dapm);
>  
> +	q6usb_connector_control_init(component);
> +
>  	data->usb = snd_soc_usb_add_port(component->dev, &data->priv, q6usb_alsa_connection_cb);
>  	if (IS_ERR(data->usb)) {
>  		dev_err(component->dev, "failed to add usb port\n");
> @@ -189,6 +307,8 @@ static int q6usb_dai_dev_probe(struct platform_device *pdev)
>  
>  	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
>  
> +	mutex_init(&data->mutex);
> +
>  	data->priv.dev = dev;
>  	dev_set_drvdata(dev, data);
>  
