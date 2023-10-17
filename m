Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277387CD08D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbjJQXXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjJQXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:23:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9C106;
        Tue, 17 Oct 2023 16:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585006; x=1729121006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pF8IBdEF07grRH7GYvQAySp8FBnNSNeSKgymBJPeJEU=;
  b=DP7id0dAt1aAAZAda4S2cOETyXlny0o70cge4vEmqIlP8zHzAsIqBZrf
   mZkZqyz8A1u7GOcuJ9/VSy0rn5fVwEs3rKNHcMFurNZMzIIck4RRzpQh2
   Oje6pz4jbamYx7fvyxkgvB++324kPRHPdN2Iax6KtPX6QJn9/0hBvqeV5
   Rkh4zyks4M0QXwdBSzZJEQRNgFpick0iyBJgbZcPI0QC/obtxEC/amCNz
   wO2aRAbLxPcFXkgkCOsdcyzQizxnqQjre+p0VVfyVL/OTk7FF5atFG0Ac
   RAYitPGHD/TIU43nUJhtqyoKmCqRdpHXx19UX2mFOSDTlftGmiMMidxat
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778180"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778180"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637494"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637494"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:24 -0700
Message-ID: <7d596a0a-fb98-458a-bd74-d22f15c0f0d8@linux.intel.com>
Date:   Tue, 17 Oct 2023 17:43:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 28/34] ASoC: qcom: qdsp6: Add support to track
 available USB PCM devices
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
 <20231017200109.11407-29-quic_wcheng@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231017200109.11407-29-quic_wcheng@quicinc.com>
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
> The USB backend should know about which sound resources are being shared
> between the ASoC and USB SND paths.  This can be utilized to properly
> select and maintain the offloading devices.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/soc/qcom/qdsp6/q6usb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
> index 329a7d4a3c01..d697cbe7f184 100644
> --- a/sound/soc/qcom/qdsp6/q6usb.c
> +++ b/sound/soc/qcom/qdsp6/q6usb.c
> @@ -25,10 +25,18 @@
>  
>  #define SID_MASK	0xF
>  
> +struct q6usb_status {
> +	unsigned int num_pcm;

how would one know which ones are capture and which ones are playback?

This really looks like a playback-only assumption, despite earlier
mentions of capture supported.

> +	unsigned int chip_index;
> +	unsigned int pcm_index;
> +};
> +
>  struct q6usb_port_data {
>  	struct q6afe_usb_cfg usb_cfg;
>  	struct snd_soc_usb *usb;
>  	struct q6usb_offload priv;
> +	unsigned long available_card_slot;
> +	struct q6usb_status status[SNDRV_CARDS];
>  	int active_idx;
>  };
>  
> @@ -110,6 +118,14 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
>  	if (connected) {
>  		/* We only track the latest USB headset plugged in */
>  		data->active_idx = sdev->card_idx;
> +
> +		set_bit(sdev->card_idx, &data->available_card_slot);
> +		data->status[sdev->card_idx].num_pcm = sdev->num_playback;

there you go...

> +		data->status[sdev->card_idx].chip_index = sdev->chip_idx;
> +	} else {
> +		clear_bit(sdev->card_idx, &data->available_card_slot);
> +		data->status[sdev->card_idx].num_pcm = 0;
> +		data->status[sdev->card_idx].chip_index = 0;
>  	}
>  
>  	return 0;
