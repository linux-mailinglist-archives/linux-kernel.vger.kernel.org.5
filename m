Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D77FDF93
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjK2Spj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjK2Sph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:45:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EA1A3;
        Wed, 29 Nov 2023 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701283544; x=1732819544;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VesGDOaehDA9Fg1TH+ih/jgS5o/DVG5HPfhsdBxy2o8=;
  b=XbXoKW2sjEJHO6CRz4nTgoPhggKRjzCQyQyPedW06hxs9B/BToDBbleF
   HU7Ko91hgjOGP2Ya8+MGkU7hTZ4mD8G+BMi5+H/qdHHzGR2e1BDI9yaPS
   xjARXf8uO0PFCFNaQR32xUQjNAUg8CSbaKNCHuUxa3CTs2EKDJcQnVyCZ
   s2/stgCTy+CwMoRhdwqIrmNaU+QkWN6TCmCh78BoOuMpGVbB0dy9sjMW3
   8RBN4HfJwTVF5FQmfRwOeC5Ma6hP0fUTeOSsFx8WJ29lN/7yTmtKylEq6
   WUEHpni5D8dNNBU+gdzUbis81y+4l0EOCyRC1mJuG8PGIf3Ny4WwP/UpI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="383602794"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="383602794"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942421671"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="942421671"
Received: from caw1-mobl1.amr.corp.intel.com (HELO [10.255.229.136]) ([10.255.229.136])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:45:42 -0800
Message-ID: <598015b0-68e1-434c-96d3-571040a3814e@linux.intel.com>
Date:   Wed, 29 Nov 2023 10:46:52 -0600
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
 <ce46c729-48de-4b71-ace3-9b88f95e8e28@linux.intel.com>
 <5ffed1e6-ac60-42e1-8322-4f5e419ef86d@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <5ffed1e6-ac60-42e1-8322-4f5e419ef86d@linaro.org>
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



On 11/29/23 10:35, Krzysztof Kozlowski wrote:
> On 28/11/2023 18:39, Pierre-Louis Bossart wrote:
>>
>>> +int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
>>> +{
>>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>>> +	struct sdw_stream_runtime *sruntime;
>>> +	struct snd_soc_dai *codec_dai;
>>> +	int ret, i;
>>> +
>>> +	sruntime = sdw_alloc_stream(cpu_dai->name);
>>> +	if (!sruntime)
>>> +		return -ENOMEM;
>>> +
>>> +	for_each_rtd_codec_dais(rtd, i, codec_dai) {
>>> +		ret = snd_soc_dai_set_stream(codec_dai, sruntime,
>>> +					     substream->stream);
>>> +		if (ret < 0 && ret != -ENOTSUPP) {
>>
>> I know this is existing code moved into a helper, but out of curiosity
>> why is -ENOTSUPP ignored? Isn't this problematic?
> 
> This is for all DAI links, so if some don't have set_stream callback, we
> assume it is not needed. For example few codecs do not need it because
> they are not on Soundwire bus at all and they don't care about the stream.

Humm, it was my understanding that the substream is mapped 1:1 with a
dailink, so not sure how SoundWire and non-SoundWire DAIs could be part
of the same dailink?

I am not saying this test is silly, just wondering if there is any case
where this error code is returned. Worst-case it's always false but
harmless.

>>
>>> +			dev_err(rtd->dev, "Failed to set sdw stream on %s\n",
>>> +				codec_dai->name);
>>> +			goto err_set_stream;
>>> +		}
>>> +	}
>>
>> Also should the CPU DAIs also be used to set the stream information?
>> it's not clear to me why only the CODEC DAIs are used.
> 
> I don't know, we never did. As you pointed out, I am just moving things
> around, so I don't really know the original intention.

Fair enough, I've been in your shoes :-)
Not always easy to grade 3+ yr code as 'miss', 'bug', 'optimization' or
'feature'...

