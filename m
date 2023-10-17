Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE47CD098
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjJQXYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344346AbjJQXXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C86111;
        Tue, 17 Oct 2023 16:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585010; x=1729121010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZMpdPFeaFAxYR/4q025izaH0wmquZAWUlNrQl8oKEZE=;
  b=ecV+tUaUU2CCH93H4+X2KJowtr7OItAUeLOqkBKxdDxE/syiScfvhiTh
   gg/w+9AOjwa0a+XrCATxz4caf+JUZoKA5x6oFx13xO/y0XMYlKx+dFLzG
   2eM+M67cmGObER6op3MzgjGBqruTjI5z2UnDklzec3R/eus1Z/QydVQ1l
   XbDe8wZdfj8Yecn1cHJb4RbZbMuHcc6tSuusxhHLrXbZcloyVlOElREai
   8+aEfLQ7WipH7EShb0TNVm0mZtQXd5DgTYSk8/rI/WkQyCCQyse4M0rnU
   wYkqTREGe4TjMdHLpmeuYvf/kztNjy6DmgGuK2Z/socznO2BLyBsZOrZO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778224"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778224"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637517"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637517"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:28 -0700
Message-ID: <34d0ce88-e006-43d3-bab3-c884c997de4c@linux.intel.com>
Date:   Tue, 17 Oct 2023 18:03:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 31/34] ASoC: qcom: qdsp6: Add headphone jack for
 offload connection status
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
 <20231017200109.11407-32-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-32-quic_wcheng@quicinc.com>
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
> The headphone jack framework has a well defined infrastructure for
> notifying userspace entities through input devices.  Expose a jack device
> that carries information about if an offload capable device is connected.
> Applications can further identify specific offloading information through
> other SND kcontrols.

maybe I am mistaken but if you expose a jack, is there not a need to
implement a .set_jack callback in the component driver?

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
> +	if (ret)
> +		return;

Also if you report a jack then usually there's a difference between
SND_JACK_HEADPHONE and SND_JACK_HEADSET - where the latter case hints at
capture support.

Clearly you don't have capture support for now, so should this be
SND_JACK_HEADPHONE ?

I must say I still don't get how this entire patchset would be used, for
playback userspace *may* use offload but for any sort of voice call then
userspace *shall* rely on the legacy USB card. Is this not a
show-stopper for CRAS or PipeWire?
