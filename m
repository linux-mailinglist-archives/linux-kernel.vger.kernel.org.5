Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953317D7082
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjJYPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344461AbjJYPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:13:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1291195;
        Wed, 25 Oct 2023 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698246792; x=1729782792;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xr4n31rJD52NyRm4bHFLlumfLPG97DcsrPmGLO2rBuc=;
  b=HWvXRdF6ROnNVSMtBhELYkt32NVPTed10kYkwNxbrbdF5cP7XcescdOT
   bxCIi5IQuxBAJJPl5h/xGpmtHv85QgRu8n58na9zbDzH9i0cuiQO8WP/o
   vF8HEe1ohutE3V/RT+iIkbmneL3ehKWenYX7uPv4Xc2YkzYE1lydo3Fp+
   iFlNtWK45uIblXNAGQMukYWL1Lb0UEYIdy94rRYBaYDJ3c4EGH4RdpF30
   VacbkVJH/hdaQrs9xMKmRw8DumpDTZc4Lq1CywYd0HCTMZssEb2si/pqb
   W4ZtEeom20Mp17LAKV/vi3Esim1tnTW7xM3jABDox3rqP8EmvIc3TPezH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="5943371"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="5943371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829259467"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="829259467"
Received: from rswenton-mobl.amr.corp.intel.com (HELO [10.212.132.169]) ([10.212.132.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:13:05 -0700
Message-ID: <8b9db87b-0f61-4824-acf1-6b5ebdf45e63@linux.intel.com>
Date:   Wed, 25 Oct 2023 10:03:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: codecs: wsa884x: check if set_stream is called
 for proper bus
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
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
 <20231025144601.268645-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231025144601.268645-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:46, Krzysztof Kozlowski wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> If multiple WSA8840 speakers, from two separate Soundwire buses, are
> used in one codec DAI link, the set_stream() should ignore calls for
> setting stream from other Soundwire controller.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wsa884x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
> index bee6e763c700..91205e8c96f1 100644
> --- a/sound/soc/codecs/wsa884x.c
> +++ b/sound/soc/codecs/wsa884x.c
> @@ -1775,6 +1775,12 @@ static int wsa884x_set_stream(struct snd_soc_dai *dai,
>  			      void *stream, int direction)
>  {
>  	struct wsa884x_priv *wsa884x = dev_get_drvdata(dai->dev);
> +	struct sdw_stream_runtime *sruntime = stream;
> +	struct sdw_slave *sdw = dev_to_sdw_dev(dai->dev);
> +
> +	/* Check if this belongs to same bus */
> +	if (sdw->bus->dev != sruntime->dev)
> +		return 0;

Sorry, maybe I am really thick or need coffee, but I can't figure out
why this is necessary. Each amplifier has its own "wsa884x_priv" context
and should have its own DAI, not following why the set_stream would
mix-up the two dais?

We've been using two buses for two amplifiers since CometLake (2019?)
and I don't see what's different?

>  
>  	wsa884x->sruntime = stream;
>  
