Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DF77CDE04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbjJRN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbjJRN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:57:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC0115;
        Wed, 18 Oct 2023 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697637435; x=1729173435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5AeLSEWrRP+H5Fb6/38V6XWZBDN12WIWs+JsApoQgvk=;
  b=gIuFcSgxsUhqDqyBq9S/VGO8JDa0jd+iMqgNUAIBIy552eXuCkKGXjJO
   NOy8un5Mp26kTaL4ewZ8VUhpK8A4bLnQ1eQ1CfZafgjIDVVSnwt7/m5tH
   WQXVKrRJMhZQvDqRv0Zy7A9MlXjzcP9zzUPYlSd398qOJ2xJbl5U63J3A
   FiFbMYAZPnwrtyQr4HzdLsgx8A5YtFNA1HbFO7C6Te9VBZjzupFSZgrxU
   //5hD8CSvTW9JwHQJ8qFOQQi9lfBeLoyMmszxi+J/BpklGfc0tJRppzDc
   u0dCKZSDoKSFSKOtrvarm794X5vnU1JowAD0blCpyNrRFX3lTr53odO3t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="472242447"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472242447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930209923"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="930209923"
Received: from dmangels-mobl.amr.corp.intel.com (HELO [10.209.187.130]) ([10.209.187.130])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:57:13 -0700
Message-ID: <2f05708e-3ee8-472e-a24f-6f3eb118133c@linux.intel.com>
Date:   Wed, 18 Oct 2023 08:47:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/34] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20231017200109.11407-10-quic_wcheng@quicinc.com>
 <7aa4ea87-9d1f-400a-bcc5-b56e5b4500c6@linux.intel.com>
 <c72bcf47-af0b-8819-1c30-06b51358381e@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c72bcf47-af0b-8819-1c30-06b51358381e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Specifically, the QC ADSP can support all potential endpoints that are
>>> exposed by the audio data interface.  This includes, feedback endpoints
>>> (both implicit and explicit) as well as the isochronous (data)
>>> endpoints.
>>
>> implicit feedback means support for capture. This is confusing...
>>
> 
> I mean, a USB device can expose a capture path, but as of now, we won't
> enable the offloading to the audio DSP for it.  However, if we're
> executing playback, and device does support implicit feedback, we will
> pass that along to the audio DSP to utilize.

Not following. Implicit feedback means a capture stream *SHALL* be
started. Are you saying this capture stream is hidden and handled at the
DSP level only? If yes, what prevents you from exposing the capture
stream to userspace as well?

I must be missing something.

>>>   +static const struct snd_soc_dai_ops q6usb_ops = {
>>> +    .probe        = msm_dai_q6_dai_probe,
>>> +    .prepare    = q6afe_dai_prepare,
>>> +    .hw_params    = q6usb_hw_params,
>>
>> this is rather confusing with two different layers used for hw_params
>> and prepare? Additional comments or explanations wouldn't hurt.
>>
> 
> I thought this was how the ASoC design was.  Each DAI defined for a
> particular path has it own set of callbacks implemented to bring up any
> required resources for that entity.  So in this case, it initializes the
> "cpu" DAI, which is the main component that handles communication with
> the audio DSP.

Usually prepare and hw_params rely on the type of DAI callbacks, but
here you are mixing "q6afe" and "q6usb" which are shown in your Patch0
diagram as "cpu" and "codec" dais respectively. I don't think it's
correct to tie the two, it's a clear layering violation IMHO. The codec
dai .prepare should not invoke something that modifies the state of the
CPU dai, which should have its own .prepare callback.
