Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB476A9F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjHAH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjHAH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:28:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482A1BC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690874874; x=1722410874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LXqZ/EC5O1gsfpYX2dvFM8tynC3rltg8zfATt1o7LNc=;
  b=DR5WEjPqUYN3xP7qSEjKZA42yydt9QS3fftJeqMm8374H7Qi4X7tsoXA
   Dc7GRHf2Spyl+3J/pjPiZiWjaX6lvy1bB3R9Tkv9+1TY3o9ZumQ2SwG+J
   txFXhQR1yHDR1yE/enzhYrrD91KmFGiwSbLRb+wS1GHcWO/AI5YNZ2al7
   IR2VhbUD3QZwU2ko/I5juqZulrioq2/htQfiKw410qOgN4YVjpv0Lg/9D
   D5x2BMOThWRPMoXjthKhMLnJxROMDo7pr3LSB2MzWFQNjSvBltv20ls0i
   M2Teh1jwGtLKOWmvewhje/Fa9HcUFmHSaQVpT6/8Z6caS8ZB/ZMaas4NN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="354152705"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="354152705"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 00:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="975166354"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="975166354"
Received: from vmastnak-mobl.ger.corp.intel.com (HELO [10.249.38.190]) ([10.249.38.190])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 00:27:50 -0700
Message-ID: <be7eadd1-a447-aeb8-b5e3-ea0a17a2a906@linux.intel.com>
Date:   Tue, 1 Aug 2023 09:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/9] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <87r0oohyea.wl-tiwai@suse.de>
 <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
 <87fs53j2qm.wl-tiwai@suse.de>
Content-Language: en-US
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <87fs53j2qm.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Den 2023-07-31 kl. 21:32, skrev Takashi Iwai:
> On Mon, 31 Jul 2023 18:37:36 +0200,
> Maarten Lankhorst wrote:
>> Hey,
>>
>> Den 2023-07-31 kl. 17:51, skrev Takashi Iwai:
>>> On Wed, 19 Jul 2023 18:41:32 +0200,
>>> Maarten Lankhorst wrote:
>>>> Explicitly loading i915 becomes a problem when upstreaming the new intel driver
>>>> for Tiger Lake and higher graphics (xe). By loading i915, it doesn't wait for
>>>> driver load of xe, and will fail completely before it loads.
>>>>
>>>> -EPROBE_DEFER has to be returned before any device is created in probe(),
>>>> otherwise the removal of the device will cause EPROBE_DEFER to try again
>>>> in an infinite loop.
>>>>
>>>> The conversion is done in gradual steps. First I add an argument to
>>>> snd_hdac_i915_init to allow for -EPROBE_DEFER so I can convert each driver
>>>> separately. Then I convert each driver to move snd_hdac_i915_init out of the
>>>> workqueue. Finally I drop the ability to choose modprobe behavior after the
>>>> last user is converted.
>>>>
>>>> I suspect the avs and skylake drivers used snd_hdac_i915_init purely for the
>>>> modprobe, but I don't have the hardware to test if it can be safely removed.
>>>> It can still be done easily in a followup patch to simplify probing.
>>>>
>>>> ---
>>>> New since first version:
>>>>
>>>> - snd_hda_core.gpu_bind is added as a mechanism to force gpu binding,
>>>>     for testing. snd_hda_core.gpu_bind=0 forces waiting for GPU bind to
>>>>     off, snd_hda_core.gpu_bind=1 forces waiting for gpu bind. Default
>>>>     setting depends on whether kernel booted with nomodeset.
>>>> - Incorporated all feedback review.
>>> Maarten, are you working on v3 patch set?
>>> Or, for moving forward, should we merge v2 now and fix the rest based
>>> on that later?
>> I've been working on a small change to keep the workqueue in SOF and
>> only move the binding to the probe function to match what
>> snd-hda-intel is doing, but I don't know if that is needed?
>>
>> It was a bit unclear to me based on feedback if I should try to kill
>> the workqueue on all drivers (but with no way to test), or keep it
>> around.
> I guess it's still safer to keep the workqueue in many drivers.  There
> can be modprobe or firmware loading at any later stage.
> We can get rid of the workqueue once after confirming that it's really
> safe, too.
>
> So, if you can work on the patch set in that regard, it's fine, I can
> wait for it.

I've finished that patch, but it caused regressions (oops) while 
rebooting. I think it's safer to kill the workqueue for SOC, and then 
convert all other drivers later.

Cheers,

~Maarten

