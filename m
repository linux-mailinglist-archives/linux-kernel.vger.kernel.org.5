Return-Path: <linux-kernel+bounces-52236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEF8495C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BD928381E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ADF125DC;
	Mon,  5 Feb 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdKnnOnG"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9D125BC;
	Mon,  5 Feb 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123674; cv=none; b=EwbM/oX0G691LsOpVQ3oDA0AqP1hVpbzPmkzNvTlXiHkSBdVyMPDrYSKM5Yn/ULl7jHVwC/bkBsJZUsC2JNHP6TO5fOp8Q8P1k9t3ZvJ7TU02WiBEVvv5f0/GrxCAjTRfx8GKDEvoOdtx7jRsTHo72Dv5EryOK1LPFrIu9RhU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123674; c=relaxed/simple;
	bh=MtCVmkyd73igsHfqhm9GVwH5JT8L8I7oiOceUhAzTic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6NfbmA0+ZRwO8Qma/ijtP0UFKqsrmFGw1wBVbV1fjPt23VmwwZRr92qHwiImtTcgZDbLMXKXl7qXsyQpqgUlKET3b7RCiD1+Wl43tEK1dDItMLw7hhczekq9ZXxOTNKRaXutz4y831fWhZh4zv4HILkK97cBuL51SPX85iB3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdKnnOnG; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707123672; x=1738659672;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MtCVmkyd73igsHfqhm9GVwH5JT8L8I7oiOceUhAzTic=;
  b=FdKnnOnGi7I6RLoz9/EUW4nBr2skpAaowep/Wh5vu1v1KVslKXs9vuZy
   8pGLCL5+bRcIt35a9JJ3ccHMB8qxfxIw3V42e8TyLD5dkTvwGEj1vs33b
   WHAcfXqznxiZAzZU2cyJ2AkDu5pjNgsIwTdmU//X6Xe2av3hAaruFu1E3
   x/AvHp6aYzr1Isaz8/Egl/SVyo9+UjiOdW2BBigMFGrzcLqRLvBd/e44t
   fNRxWbIqlhcVMr2Wv/phUQ7/xdMJftcG6z0MLBM+tP2AGT/h64C22HZoo
   eXMUFnOcx9xLO3y7t354Z8i0bCv1j/jdww0zl2sW8omTWQyXbxo+b5H20
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="435614850"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="435614850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:01:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933099575"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="933099575"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:01:05 -0800
Message-ID: <aaa76d7a-4299-4e1c-83f1-cbbea763927f@linux.intel.com>
Date: Mon, 5 Feb 2024 10:01:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 50/53] ALSA: usb-audio: Allow for rediscovery of
 connected USB SND devices
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh+dt@kernel.org, konrad.dybcio@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-51-quic_wcheng@quicinc.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240203023645.31105-51-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/2024 3:36 AM, Wesley Cheng wrote:
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
>   sound/usb/card.c                  | 19 +++++++++++++++++++
>   sound/usb/card.h                  |  2 ++
>   sound/usb/qcom/qc_audio_offload.c |  2 ++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 11b827b7a2a5..995b2df676ab 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -202,6 +202,25 @@ struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>   }
>   EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
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

if inside if, it can just be && or maybe move callback check before 
mutex lock and just return early if it is not present?

> +	}
> +	mutex_unlock(&register_mutex);
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_rediscover_devices);
> +
>   /*
>    * disconnect streams
>    * called from usb_audio_disconnect()
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 6d59995440c3..3a0d68f453a1 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -222,11 +222,13 @@ int snd_usb_unregister_platform_ops(void);
>   #if IS_ENABLED(CONFIG_SND_USB_AUDIO)
>   struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>   			struct snd_pcm_hw_params *params, int direction);
> +void snd_usb_rediscover_devices(void);
>   #else
>   static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>   			struct snd_pcm_hw_params *params, int direction)
>   {
>   	return NULL;
>   }
> +static void snd_usb_rediscover_devices(void) { }
>   #endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
>   #endif /* __USBAUDIO_CARD_H */
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index 08af82ec22ad..9b0f98600e58 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -1867,6 +1867,8 @@ static int __init qc_usb_audio_offload_init(void)
>   	if (ret < 0)
>   		goto release_qmi;
>   
> +	snd_usb_rediscover_devices();
> +
>   	return 0;
>   
>   release_qmi:
> 


