Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E026B7CD089
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbjJQXXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbjJQXXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9A11A;
        Tue, 17 Oct 2023 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585002; x=1729121002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pTPWau1gXZiNQk+t/6022j9X4kWrUjddW9GC378AbPM=;
  b=TISbaAiSWyKzv0bI9kAEG1PWUjeP0g73zun1L4EoB52PaRq0MX+Riqmx
   gY0T+WyZTLwEuxwGmtig6Fyd2xa4ZKJiAr9Q7NqR/0e+jmxcxJFkNbDvr
   QCQul1hgqkkLLHQosScWZgThKvKfAogkcPi/GHnULGhu0SXPk2/prIGXJ
   DihdZJJ6tHbP4EaZbIHu7SmfHswxBRw4Nwf4SlWMFPKeZIHdJYKOq8yDF
   wPI71qZYl54oH2LfI69L7lK2eHXXfVBxfSkH/J58PYdboO4YmCEq8AjhI
   BYQj8fEExQNKsIBLwH1PudMVpr1sA2LnmdsvSarIVHd+qTdFQNFwQ39Kh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778142"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778142"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637480"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637480"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:21 -0700
Message-ID: <c6a003eb-213d-4456-bc6a-e07c08c57396@linux.intel.com>
Date:   Tue, 17 Oct 2023 17:39:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 26/34] ASoC: qcom: qdsp6: q6afe: Split USB AFE
 dev_token param into separate API
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
 <20231017200109.11407-27-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-27-quic_wcheng@quicinc.com>
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



On 10/17/23 15:01, Wesley Cheng wrote:
> The Q6USB backend can carry information about the available USB SND cards
> and PCM devices discovered on the USB bus.  The dev_token field is used by
> the audio DSP to notify the USB offload driver of which card and PCM index
> to enable playback on.  Separate this into a dedicated API, so the USB
> backend can set the dev_token accordingly.  The audio DSP does not utilize
> this information until the AFE port start command is sent, which is done
> during the PCM prepare phase.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/soc/qcom/qdsp6/q6afe.c | 49 +++++++++++++++++++++++++-----------
>  sound/soc/qcom/qdsp6/q6afe.h |  1 +
>  2 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index 72c4e6fe20c4..f09a756246f8 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -1394,10 +1394,42 @@ void q6afe_tdm_port_prepare(struct q6afe_port *port,
>  }
>  EXPORT_SYMBOL_GPL(q6afe_tdm_port_prepare);
>  
> -static int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
> +/**
> + * afe_port_send_usb_dev_param() - Send USB dev token
> + *
> + * @port: Instance of afe port
> + * @cardidx: USB SND card index to reference
> + * @pcmidx: USB SND PCM device index to reference
> + *
> + * The USB dev token carries information about which USB SND card instance and
> + * PCM device to execute the offload on.  This information is carried through
> + * to the stream enable QMI request, which is handled by the offload class
> + * driver.  The information is parsed to determine which USB device to query
> + * the required resources for.
> + */
> +int afe_port_send_usb_dev_param(struct q6afe_port *port, int cardidx, int pcmidx)
>  {
> -	union afe_port_config *pcfg = &port->port_cfg;
>  	struct afe_param_id_usb_audio_dev_params usb_dev;
> +	int ret;
> +
> +	memset(&usb_dev, 0, sizeof(usb_dev));
> +
> +	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	usb_dev.dev_token = (cardidx << 16) | (pcmidx << 8);
> +	ret = q6afe_port_set_param_v2(port, &usb_dev,
> +				AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
> +				AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
> +	if (ret)
> +		dev_err(port->afe->dev, "%s: AFE device param cmd failed %d\n",
> +			__func__, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(afe_port_send_usb_dev_param);
> +
> +static int afe_port_send_usb_params(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
> +{
> +	union afe_port_config *pcfg = &port->port_cfg;
>  	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
>  	struct afe_param_id_usb_audio_svc_interval svc_int;
>  	int ret = 0;
> @@ -1408,20 +1440,9 @@ static int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb
>  		goto exit;
>  	}
>  
> -	memset(&usb_dev, 0, sizeof(usb_dev));
>  	memset(&lpcm_fmt, 0, sizeof(lpcm_fmt));
>  	memset(&svc_int, 0, sizeof(svc_int));
>  
> -	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> -	ret = q6afe_port_set_param_v2(port, &usb_dev,
> -				      AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
> -				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
> -	if (ret) {
> -		dev_err(port->afe->dev, "%s: AFE device param cmd failed %d\n",
> -			__func__, ret);
> -		goto exit;
> -	}
> -

this feels like a questionable patch split. Why not introduce the new
helper earlier and avoid adding code then modifying the same code?

>  	lpcm_fmt.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
>  	lpcm_fmt.endian = pcfg->usb_cfg.endian;
>  	ret = q6afe_port_set_param_v2(port, &lpcm_fmt,
> @@ -1463,7 +1484,7 @@ void q6afe_usb_port_prepare(struct q6afe_port *port,
>  	pcfg->usb_cfg.num_channels = cfg->num_channels;
>  	pcfg->usb_cfg.bit_width = cfg->bit_width;
>  
> -	afe_port_send_usb_dev_param(port, cfg);
> +	afe_port_send_usb_params(port, cfg);
>  }
>  EXPORT_SYMBOL_GPL(q6afe_usb_port_prepare);
>  
> diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
> index ef47b4ae9e27..2ce5ba9dba69 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.h
> +++ b/sound/soc/qcom/qdsp6/q6afe.h
> @@ -263,6 +263,7 @@ void q6afe_tdm_port_prepare(struct q6afe_port *port, struct q6afe_tdm_cfg *cfg);
>  void q6afe_cdc_dma_port_prepare(struct q6afe_port *port,
>  				struct q6afe_cdc_dma_cfg *cfg);
>  
> +int afe_port_send_usb_dev_param(struct q6afe_port *port, int cardidx, int pcmidx);
>  int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
>  			  int clk_src, int clk_root,
>  			  unsigned int freq, int dir);
