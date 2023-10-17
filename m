Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7527CD091
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjJQXXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbjJQXX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D206F1;
        Tue, 17 Oct 2023 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585004; x=1729121004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bY8IDP9nHnBzIrIijoSoaM2EG63hwL5A89taKGCs7bc=;
  b=nzdCca2dAnOsKbzNHQT0aJYy2MzsNS3w6dgjKeVPlwNmLUCrKsVs0YLp
   doZ6L/CZ3jLQgxR1ifwC2VEz8db1Ed3b/eU+mSn0hpxpEAfaI3qexabaV
   bdZtWi/MHe1JW8tjx/sRF91QUCEKI7z4v65Ok6y4B5C6lw0UZixwegIB6
   zgXpJ7pmWxwqJJtZQac+9NAmkrOpt51Pfit/8rL1+Qr1QOPyUo8nqVsJ+
   T+qR6kF7bNEpVtSsbI4IDC1LTVA+6kwtjp/oG7HPgd5CNvIreVRIMhL/p
   Wu9e1xjtj2Pb43Zdd/HM8qslk8mfjxs9fOw6SaQHq5ORH0XmWJDSgN4P7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778160"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778160"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637489"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637489"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:22 -0700
Message-ID: <d188fcef-2cc4-43b7-b296-7091e5d1a973@linux.intel.com>
Date:   Tue, 17 Oct 2023 17:41:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 27/34] ALSA: usb-audio: qcom: Populate PCM and USB chip
 information
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
 <20231017200109.11407-28-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-28-quic_wcheng@quicinc.com>
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
> Currently, only the index to the USB SND card array is passed to the USB
> backend.  Pass through more information, specifically the USB SND card
> number and the number of PCM devices available.  This allows for the DPCM
> backend to determine what USB resources are available during situations,
> such as USB audio offloading.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/qcom/qc_audio_offload.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index bd6b84f72c74..ae74098b41f5 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -173,6 +173,21 @@ enum usb_qmi_audio_format {
>  	USB_QMI_PCM_FORMAT_U32_BE,
>  };
>  
> +static int usb_qmi_get_pcm_num(struct snd_usb_audio *chip, int direction)
> +{
> +	struct snd_usb_substream *subs = NULL;
> +	struct snd_usb_stream *as;
> +	int count = 0;
> +
> +	list_for_each_entry(as, &chip->pcm_list, list) {
> +		subs = &as->substream[direction];
> +		if (subs->ep_num)
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
>  static enum usb_qmi_audio_device_speed_enum_v01
>  get_speed_info(enum usb_device_speed udev_speed)
>  {
> @@ -1592,6 +1607,8 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
>  
>  	sdev->card_idx = chip->card->number;
>  	sdev->chip_idx = chip->index;
> +	sdev->num_playback = usb_qmi_get_pcm_num(chip, 0);
> +	sdev->num_capture = usb_qmi_get_pcm_num(chip, 1);
>  	uadev[chip->card->number].sdev = sdev;
>  
>  	uaudio_qdev->last_card_num = chip->card->number;
> @@ -1706,10 +1723,8 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
>  	mutex_unlock(&chip->mutex);
>  
>  	atomic_dec(&uaudio_qdev->qdev_in_use);
> -	if (!atomic_read(&uaudio_qdev->qdev_in_use)) {
> -		snd_soc_usb_disconnect(usb_get_usb_backend(udev));

this also feels like a patch split issue, removing this
snd_soc_usb_disconnect() has nothing to do with the "populate PCM and
USB chip information" ?

> +	if (!atomic_read(&uaudio_qdev->qdev_in_use))
>  		qc_usb_audio_cleanup_qmi_dev();
> -	}
>  	mutex_unlock(&qdev_mutex);
>  }
>  
