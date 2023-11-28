Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090F7FC1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbjK1Rx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbjK1Rxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:53:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7960AB;
        Tue, 28 Nov 2023 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194040; x=1732730040;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oDaVISZ4GC9Vx7bYPRhNfZMARfbZEazvuxrRBu0LJLE=;
  b=NTDlTZNtUK0/pphaHPfsnq2jaKGtz5Czpja3nWhf5XeI4SN0XKCeA4pv
   ynAkFjPGcjIagOjqaUUKreR/54cyzqGRi1zpnSZ9vpwn4Qxck8EiPoLBv
   4aVf8LkUfL1BvrKr+JSRYo47jhTFXUTL7/wxF+B6J31Ak7BTDvu3kq0GV
   OfFs3oJ0NyCrdeNfp304uLqWG0OOB94+Vei+YocyIFiY1Rhvz4dAmpUP1
   PgW4ZdF8nYz3IIA4Y7RVMRahho6DCUndqxE3LcVNoincazJIxz1zu7McJ
   5jx5CS8YuR7h+dBvWIpvQ1qwtoeV9VMFkzsd8f6Qzo2ihMRbxluGloe99
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424127096"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424127096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:54:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834715321"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834715321"
Received: from skumarso-mobl33.amr.corp.intel.com (HELO [10.255.231.208]) ([10.255.231.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:53:57 -0800
Message-ID: <ce46c729-48de-4b71-ace3-9b88f95e8e28@linux.intel.com>
Date:   Tue, 28 Nov 2023 11:39:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: qcom: Add helper for allocating Soundwire
 stream runtime
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
> +	struct sdw_stream_runtime *sruntime;
> +	struct snd_soc_dai *codec_dai;
> +	int ret, i;
> +
> +	sruntime = sdw_alloc_stream(cpu_dai->name);
> +	if (!sruntime)
> +		return -ENOMEM;
> +
> +	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +		ret = snd_soc_dai_set_stream(codec_dai, sruntime,
> +					     substream->stream);
> +		if (ret < 0 && ret != -ENOTSUPP) {

I know this is existing code moved into a helper, but out of curiosity
why is -ENOTSUPP ignored? Isn't this problematic?

> +			dev_err(rtd->dev, "Failed to set sdw stream on %s\n",
> +				codec_dai->name);
> +			goto err_set_stream;
> +		}
> +	}

Also should the CPU DAIs also be used to set the stream information?
it's not clear to me why only the CODEC DAIs are used.

> +	return 0;
> +
> +err_set_stream:
> +	sdw_release_stream(sruntime);
> +
> +	return ret;
> +}
