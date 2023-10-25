Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE987D7083
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbjJYPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbjJYPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:13:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDDD18B;
        Wed, 25 Oct 2023 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698246792; x=1729782792;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qG0Y2Ghox01DubYjKMylpuit6aghA5t5cZDXXmTDT/4=;
  b=OVgYxmCg08bVWbi2PVLWBJ6ZqIDCqhBnY4STIiDvx7hMvRJvzOBghLh9
   9s3nr9j2mV9HDovpEb6SwitfJV60yEBBGJUKteVmsQK/5dtBcNIREXFQ1
   KnVGEWo0oPcoo+hyyU28DvcrRrwl4HdvdE8cWsm7IbsL4nX3FpWHc4RW7
   A+vvrMbS43DDHzqzHPCTNGv39iMKrcFUhxaDsRaMMeO4UU9f/a55MNTm6
   tvp7ofW6hmNeBTexT7VHaR+9I6wktFZgpSwbZ88B5dP8MEm1/TPtZWApl
   ImSdAh3/JEQKWJKYbjTd4Pc4ZF+rpWSk8jqVh3Npzc1ijahJWrEOdiTqG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="5943362"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="5943362"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829259469"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="829259469"
Received: from rswenton-mobl.amr.corp.intel.com (HELO [10.212.132.169]) ([10.212.132.169])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:13:06 -0700
Message-ID: <3c6e3877-1bb6-403d-a67e-fdda0aef548e@linux.intel.com>
Date:   Wed, 25 Oct 2023 10:08:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soundwire: qcom: set owner device of runtime stream
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
 <20231025144601.268645-2-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231025144601.268645-2-krzysztof.kozlowski@linaro.org>
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
> Store the pointer to struct device of Soundwire controller owning this
> runtime stream.  This can be later used by Soundwire devices, to check
> if their DAI prepare callback is called for the same bus, in cases where
> multiple Soundwire buses are used in same soundcard codec list.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/soundwire/qcom.c      | 1 +
>  include/linux/soundwire/sdw.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index fe65c26c5281..a95f39563b47 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1298,6 +1298,7 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
>  		goto err_alloc;
>  	}
>  
> +	sruntime->dev = ctrl->bus.dev;
>  	ctrl->sruntime[dai->id] = sruntime;
>  
>  	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 4f3d14bb1538..650334adc261 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -1023,6 +1023,7 @@ struct sdw_stream_params {
>   * master_list can contain only one m_rt per Master instance
>   * for a stream
>   * @m_rt_count: Count of Master runtime(s) in this stream
> + * @dev: SoundWire controller owning this runtime stream

A stream connects multiple managers and multiple peripherals. The
definition above does not make a lot of sense and doesn't work in
general since there's no 'owner' really.

And nothing prevents the use of multiple controllers, there are not
restrictions in the MIPI DisCo spec that prevent a stream from relying
on different controllers.

>   */
>  struct sdw_stream_runtime {
>  	const char *name;
> @@ -1031,6 +1032,7 @@ struct sdw_stream_runtime {
>  	enum sdw_stream_type type;
>  	struct list_head master_list;
>  	int m_rt_count;
> +	struct device *dev;
>  };
>  
>  struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
