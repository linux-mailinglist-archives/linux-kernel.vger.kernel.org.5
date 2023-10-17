Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F637CD086
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbjJQXXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344356AbjJQXXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338910B;
        Tue, 17 Oct 2023 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585001; x=1729121001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7I1Y4nnQBV4/2CN7n+iQSuwae/PdMJVhORVRJRUVvoo=;
  b=jPFFNwoVclAi5DEKoHsv66dtrnYSxUBDt8s2VB+aEOG73OOSEyrg9w5E
   9tjaeEGXMH04/8mbbKJAU2pKh2MublHhmmmp50eL8caH8zBbwQvCIJ7JT
   3O3jf4Rh+DwguBgF7SkVKWjPcdwst41Y2Cq6lhGlXRjxOu2kFK0h0+R7C
   wwJN6IknA30EG+A0syhM6pRhLr+FTNgS25dNyg+nMpV8y1MJBiVTsqOwC
   I8TVemjy77UPbX8m64oKLhx5DzkZhxZoYTE5RktVAQ9EWUTEWd8cMet9q
   iTE6rWw5NMf4VhxMj7bwBD7TqVP8kB7zh35XyBG4Ib3kYjPc6H/g+lIjc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778118"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637471"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637471"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:18 -0700
Message-ID: <dbb1f64b-8112-4a2f-9138-616e04bdc53c@linux.intel.com>
Date:   Tue, 17 Oct 2023 17:33:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 21/34] ASoC: usb: Add PCM format check API for USB
 backend
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
 <20231017200109.11407-22-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-22-quic_wcheng@quicinc.com>
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
> Introduce a check for if a particular PCM format is supported by the USB

Introduce a helper to check if a ...

> audio device connected.  If the USB audio device does not have an audio
> profile which can support the requested format, then notify the USB
> backend.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  include/sound/soc-usb.h |  3 +++
>  sound/soc/soc-usb.c     | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
> index 58c686f4f7ba..c6ddc055c4cd 100644
> --- a/include/sound/soc-usb.h
> +++ b/include/sound/soc-usb.h
> @@ -37,6 +37,9 @@ struct snd_soc_usb {
>  	void *priv_data;
>  };
>  
> +int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
> +			int direction);
> +
>  int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev);
>  int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev);
>  void *snd_soc_usb_find_priv_data(struct device *usbdev);
> diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
> index 73b1bcc3b506..7407678a993e 100644
> --- a/sound/soc/soc-usb.c
> +++ b/sound/soc/soc-usb.c
> @@ -63,6 +63,19 @@ void *snd_soc_usb_find_priv_data(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_usb_find_priv_data);
>  
> +int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
> +			int direction)
> +{
> +	struct snd_usb_stream *as;
> +
> +	as = snd_usb_find_suppported_substream(card_idx, params, direction);
> +	if (!as)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_usb_find_format);

Is this the right way to check for formats?

formats are defined within the scope of an endpoint, and those endpoints
are themselves defined within the scope of an interface?

I don't see a notion of endpoint here. Does this assume all endpoints
are valid, or maybe the existence of a single endpoint in a device?

Confused.
