Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8077EA00F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKMPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:34:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D75D71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699889637; x=1731425637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HMywEqsO2ghezpmZYFMkJcktVwdVXA5iB3QMF0BziY4=;
  b=jgkHertV4pSAJeAg8egFyQcKFEat1KwpzZnHwvWpfm4i4x/i2KoCyDIg
   BjyoxytA5t4kKZWP3joEkSoM41tyGxYDplw/EbpVwNcqu0AYAKbbvN3WW
   2206Ta//IHZCJw+5UjtMsNbGroxsDNASrCDqeoThmUPU3VRJxrwTfsZ+r
   ZiJ9vpElHtfR+jM1Z+mWOnLXFJFW1gWa4irdWiWYk4l/6QmJ3SMi7CURj
   Cdu8cfzjCxzYuA9tTI3viv3uIMS3sl0G97h6tHM8gnAdPrdH5g5zA7iJr
   8mRcOGOBq7a2ftU3iFzK/D8Ukj31VGDcmWvPk0JiQSM6lIJ5jrd+zGLDi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375480773"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375480773"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011570185"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011570185"
Received: from renliang-mobl.amr.corp.intel.com (HELO [10.251.10.75]) ([10.251.10.75])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:33:54 -0800
Message-ID: <1569460d-30bc-47f5-a224-b14618e4eaf2@linux.intel.com>
Date:   Mon, 13 Nov 2023 08:45:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform
Content-Language: en-US
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        richgong@amd.com, posteuca@mutex.one,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
 <20231113123345.2196504-2-Syed.SabaKareem@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231113123345.2196504-2-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -195,7 +196,11 @@ static int renoir_audio_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, adata);
>  	acp_enable_interrupts(adata);
>  	acp_platform_register(dev);
> -
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>  	return 0;
>  }
>  
> @@ -208,11 +213,42 @@ static void renoir_audio_remove(struct platform_device *pdev)
>  	acp_platform_unregister(dev);
>  }
>  
> +static int __maybe_unused rn_pcm_resume(struct device *dev)
> +{
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	struct acp_stream *stream;
> +	struct snd_pcm_substream *substream;
> +	snd_pcm_uframes_t buf_in_frames;
> +	u64 buf_size;
> +
> +	spin_lock(&adata->acp_lock);
> +	list_for_each_entry(stream, &adata->stream_list, list) {
> +		substream = stream->substream;
> +		if (substream && substream->runtime) {
> +			buf_in_frames = (substream->runtime->buffer_size);
> +			buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
> +			config_pte_for_stream(adata, stream);
> +			config_acp_dma(adata, stream, buf_size);
> +			if (stream->dai_id)
> +				restore_acp_i2s_params(substream, adata, stream);
> +			else
> +				restore_acp_pdm_params(substream, adata);

when are those parameters saved...

> +		}
> +	}
> +	spin_unlock(&adata->acp_lock);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rn_dma_pm_ops = {> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rn_pcm_resume)

... since there's nothing done on suspend?

Also there's something weird here since the patch enables pm_runtime but
there's nothing related to pm_runtime here, i.e. SET_RUNTIME_PM_OPS()
is missing.

> +};
> +
>  static struct platform_driver renoir_driver = {
>  	.probe = renoir_audio_probe,
>  	.remove_new = renoir_audio_remove,
>  	.driver = {
>  		.name = "acp_asoc_renoir",
> +		.pm = &rn_dma_pm_ops,
>  	},
>  };
>  
