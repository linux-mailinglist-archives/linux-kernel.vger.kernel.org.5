Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54728760E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjGYJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjGYJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:18:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5E10E7;
        Tue, 25 Jul 2023 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276715; x=1721812715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LKtaiWNgDWK8U+v+CSkjSmMLNgc+6CwnEmQrVA3o6hk=;
  b=X9Tnq3Mqr7hSM1pYrZe4MDh+iteuG93bMGwcd0dwbhDzbXB6dKtQ8wwC
   GFbgh8yfuPPUl9X/8hxurecx98oDSAzdDcC/KMxqjQYGQD23nQWVa22fa
   vjuCsCxuKaj/BUvZqtoY/Az8MPYTRLV0mLlzpii4mKt7fQzjFHY7n79qC
   NQBTuMNMtkNAwpdFo/5SHcyuop6C8zpMhxbizzhP+rgntiwBZw+bX32HP
   //4vyJ6W+lDNn2o2oYofPa/6X7A4jlCSkSWImL32c5I7gzLQRRM/yrSss
   3pfiCKNMynqbCYbxMTiDCHrKZOGl04ZqJhAG4Z9K87KF6Ss7wjzmND6xK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="454048830"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="454048830"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719980312"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719980312"
Received: from mongola-mobl.ger.corp.intel.com (HELO [10.249.37.129]) ([10.249.37.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:18:28 -0700
Message-ID: <eb1c679b-f50b-1f20-c7c8-da3f4857bec1@linux.intel.com>
Date:   Tue, 25 Jul 2023 10:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 08/32] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20230725023416.11205-9-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230725023416.11205-9-quic_wcheng@quicinc.com>
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


> +static const struct snd_soc_dai_ops q6usb_ops = {
> +	.prepare	= q6afe_dai_prepare,
> +	.hw_params	= q6usb_hw_params,
> +	.shutdown	= q6afe_dai_shutdown,

it's a bit odd to see a .shutdown without a .startup?

Is this intentional and should a comment be added?


> +/* device token of actual end USB aduio device */

audio

> +	u32                  dev_token;
> +/* endianness of this interface */
> +	u32                   endian;
> +/* service interval */
> +	u32                  service_interval;
> +} __packed;
> +
> +/**
> + * struct afe_param_id_usb_audio_dev_params
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + * @dev_token: device token of actual end USB aduio device

audio. please run a spell-checker.


> +	svc_int.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	svc_int.svc_interval = pcfg->usb_cfg.service_interval;
> +	ret = q6afe_port_set_param_v2(port, &svc_int,
> +				      AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL,
> +				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(svc_int));
> +	if (ret) {
> +		dev_err(port->afe->dev, "%s: AFE device param cmd svc_interval failed %d\n",
> +			__func__, ret);
> +		ret = -EINVAL;

why do you override the return value?

> +		goto exit;

not necessary, this is a jump to the next line. Looks like copy-paste ...

> +	}
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * q6afe_usb_port_prepare() - Prepare usb afe port.
> + *
> + * @port: Instance of afe port
> + * @cfg: USB configuration for the afe port
> + *
> + */
> +void q6afe_usb_port_prepare(struct q6afe_port *port,
> +			     struct q6afe_usb_cfg *cfg)
> +{
> +	union afe_port_config *pcfg = &port->port_cfg;
> +
> +	pcfg->usb_cfg.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
> +	pcfg->usb_cfg.sample_rate = cfg->sample_rate;
> +	pcfg->usb_cfg.num_channels = cfg->num_channels;
> +	pcfg->usb_cfg.bit_width = cfg->bit_width;
> +
> +	afe_port_send_usb_dev_param(port, cfg);
> +}
> +EXPORT_SYMBOL_GPL(q6afe_usb_port_prepare);
> +
>  /**
>   * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
>   *
> @@ -1611,7 +1791,10 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
>  		break;
>  	case AFE_PORT_ID_WSA_CODEC_DMA_RX_0 ... AFE_PORT_ID_RX_CODEC_DMA_RX_7:
>  		cfg_type = AFE_PARAM_ID_CODEC_DMA_CONFIG;
> -	break;
> +		break;
> +	case AFE_PORT_ID_USB_RX:
> +		cfg_type = AFE_PARAM_ID_USB_AUDIO_CONFIG;
> +		break;
>  	default:
>  		dev_err(dev, "Invalid port id 0x%x\n", port_id);
>  		return ERR_PTR(-EINVAL);
> diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
> index 30fd77e2f458..e098a3e15135 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.h
> +++ b/sound/soc/qcom/qdsp6/q6afe.h
> @@ -5,7 +5,7 @@
>  
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  
> -#define AFE_PORT_MAX		129
> +#define AFE_PORT_MAX		130
>  
>  #define MSM_AFE_PORT_TYPE_RX 0
>  #define MSM_AFE_PORT_TYPE_TX 1
> @@ -205,6 +205,47 @@ struct q6afe_cdc_dma_cfg {
>  	u16	active_channels_mask;
>  };
>  
> +/**
> + * struct q6afe_usb_cfg
> + * @cfg_minor_version: Minor version used for tracking USB audio device
> + * configuration.
> + * Supported values:
> + *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
> + * @sample_rate: Sampling rate of the port
> + *    Supported values:
> + *      AFE_PORT_SAMPLE_RATE_8K
> + *      AFE_PORT_SAMPLE_RATE_11025
> + *      AFE_PORT_SAMPLE_RATE_12K
> + *      AFE_PORT_SAMPLE_RATE_16K
> + *      AFE_PORT_SAMPLE_RATE_22050
> + *      AFE_PORT_SAMPLE_RATE_24K
> + *      AFE_PORT_SAMPLE_RATE_32K
> + *      AFE_PORT_SAMPLE_RATE_44P1K
> + *      AFE_PORT_SAMPLE_RATE_48K
> + *      AFE_PORT_SAMPLE_RATE_96K
> + *      AFE_PORT_SAMPLE_RATE_192K
> + * @bit_width: Bit width of the sample.
> + *    Supported values: 16, 24
> + * @num_channels: Number of channels
> + *    Supported values: 1, 2
> + * @data_format: Data format supported by the USB
> + *    Supported values: 0
> + * @reserved: this field must be 0
> + * @dev_token: device token of actual end USB audio device
> + * @endian: endianness of this interface
> + * @service_interval: service interval
> + **/
> +struct q6afe_usb_cfg {
> +	u32	cfg_minor_version;
> +	u32     sample_rate;
> +	u16	bit_width;
> +	u16	num_channels;
> +	u16	data_format;
> +	u16	reserved;
> +	u32	dev_token;
> +	u32	endian;
> +	u32	service_interval;
> +};

this definition looks exactly the same as
struct afe_param_id_usb_cfg
??


