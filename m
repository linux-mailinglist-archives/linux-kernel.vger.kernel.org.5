Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB87D7080
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjJYPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbjJYPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:13:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4D198;
        Wed, 25 Oct 2023 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698246793; x=1729782793;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4AB1mlCoTUhDm9/eS/vpI2QL7TeGXM3DYMZnJsK9evs=;
  b=H0HTiA7ttpU2W7jNNbFXTh942G9+zNehnixD2bVVmM9MzLEGxF+dJnpk
   mAbd56UsAi0sdH9y4++2Pvx2WQale/Nd3UKcAyKOln+b+eUxaEng7OjR6
   d2faiRexaZ50oQpe0JXTSVopeNfZ+/0rX1uBxeyaE5pOYcvbJfG03ocDb
   10qMkiv4TRI9fZID0fNHkkcKecqaatAOR3LaGI0K7Er7x2NwLMmZxb9zp
   vY5NIUNS8ZkjV8jaqCQG6JpY18S1nurYnrM+1aZtBL2Fgd+qySdh6isgw
   W8aLYLHxAhJa5g0EKeV1I5TPq+Lw8cbihFPyyIuOLlq3BhkGsCD4YNKf6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="5943377"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="5943377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829259475"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="829259475"
Received: from rswenton-mobl.amr.corp.intel.com (HELO [10.212.132.169]) ([10.212.132.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:13:08 -0700
Message-ID: <322002af-09e8-4d4c-bc85-81654c6b5f9d@linux.intel.com>
Date:   Wed, 25 Oct 2023 10:12:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] soundwire: qcom: drop unneeded DAI .set_stream
 callback
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
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
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



On 10/25/23 09:45, Krzysztof Kozlowski wrote:
> Qualcomm Soundwire controller drivers do not support multi-link setups,
> so DAI .set_stream() callback will not be used.  What's more, if called
> it will overwrite the sdw_stream_runtime runtime set in DAI .startup
> (qcom_swrm_startup()) causing issues (unsupported multi-link error) when
> two Soundwire controllers are passed as codec DAIs.

This last sentence is confusing at best.

A controller can have one or more managers, each of whom can have one or
more peripherals.

only peripherals should expose codec DAIs, managers should expose CPU DAIs.

Put differently, the controller is the host part while the peripheral is
the codec part. "controllers passed as codec DAIs" is not really
possible, or this was a typo?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index f1b8d6ac5140..fe65c26c5281 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1267,16 +1267,6 @@ static int qcom_swrm_hw_free(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> -static int qcom_swrm_set_sdw_stream(struct snd_soc_dai *dai,
> -				    void *stream, int direction)
> -{
> -	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
> -
> -	ctrl->sruntime[dai->id] = stream;
> -
> -	return 0;
> -}
> -
>  static void *qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)
>  {
>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
> @@ -1349,7 +1339,6 @@ static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
>  	.hw_free = qcom_swrm_hw_free,
>  	.startup = qcom_swrm_startup,
>  	.shutdown = qcom_swrm_shutdown,
> -	.set_stream = qcom_swrm_set_sdw_stream,
>  	.get_stream = qcom_swrm_get_sdw_stream,
>  };
>  
