Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C3769CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjGaQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjGaQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:38:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D3268F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690821464; x=1722357464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NgqvfxSJUC2JHt7NcWNd2gM99VuVW9MfNgvGVYKkFho=;
  b=fcGURWdpeIyLIex8gTZtg98CXkZipCJSfgevvCX43x4OPoNeRoyaSRrp
   3curqOWSdEnk0geONeRkvpOz1BNWbO2hoXDPkEtLXux7oL1nmUObPKrae
   fwIwyYIMi+U3EH9D+TQuGnDrFSfAoflUGPMj1E8sTe6yIHN1lLsMyTnET
   xBQmRsclBv5XjwWIM1I+PV0G4un1dVLOAsblMtkf6yf/WQW3pdn2M2Qkt
   kd6Gpfatk/OuKtl+K+oFjQvOIF8LiCMC1G42I/QzhdOP1NS7bSDwLXkCx
   FBMdkVPOp6BzRQVJ/VCtGddfoTYQN/m5h4Xd8ZYLYIYVAkHgKjdFLxgQn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="371781654"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="371781654"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 09:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705491790"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="705491790"
Received: from awolfson-mobl3.ger.corp.intel.com (HELO [10.249.39.2]) ([10.249.39.2])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 09:37:40 -0700
Message-ID: <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
Date:   Mon, 31 Jul 2023 18:37:36 +0200
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
Content-Language: en-US
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <87r0oohyea.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Den 2023-07-31 kl. 17:51, skrev Takashi Iwai:
> On Wed, 19 Jul 2023 18:41:32 +0200,
> Maarten Lankhorst wrote:
>> Explicitly loading i915 becomes a problem when upstreaming the new intel driver
>> for Tiger Lake and higher graphics (xe). By loading i915, it doesn't wait for
>> driver load of xe, and will fail completely before it loads.
>>
>> -EPROBE_DEFER has to be returned before any device is created in probe(),
>> otherwise the removal of the device will cause EPROBE_DEFER to try again
>> in an infinite loop.
>>
>> The conversion is done in gradual steps. First I add an argument to
>> snd_hdac_i915_init to allow for -EPROBE_DEFER so I can convert each driver
>> separately. Then I convert each driver to move snd_hdac_i915_init out of the
>> workqueue. Finally I drop the ability to choose modprobe behavior after the
>> last user is converted.
>>
>> I suspect the avs and skylake drivers used snd_hdac_i915_init purely for the
>> modprobe, but I don't have the hardware to test if it can be safely removed.
>> It can still be done easily in a followup patch to simplify probing.
>>
>> ---
>> New since first version:
>>
>> - snd_hda_core.gpu_bind is added as a mechanism to force gpu binding,
>>    for testing. snd_hda_core.gpu_bind=0 forces waiting for GPU bind to
>>    off, snd_hda_core.gpu_bind=1 forces waiting for gpu bind. Default
>>    setting depends on whether kernel booted with nomodeset.
>> - Incorporated all feedback review.
> Maarten, are you working on v3 patch set?
> Or, for moving forward, should we merge v2 now and fix the rest based
> on that later?

I've been working on a small change to keep the workqueue in SOF and 
only move the binding to the probe function to match what snd-hda-intel 
is doing, but I don't know if that is needed?

It was a bit unclear to me based on feedback if I should try to kill the 
workqueue on all drivers (but with no way to test), or keep it around.

Cheers,

~Maarten

