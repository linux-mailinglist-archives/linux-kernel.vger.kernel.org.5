Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2260575C6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGUMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGUMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:18:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FF2D4A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689941894; x=1721477894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zqexK72UypcBtCj4L1f3PyVVDVu5mCG7mlNisYVuzdA=;
  b=DlH8zXJYz/SnXeOd1uuUML5gWYLYsTggq3KbS2P1WGmNzU6iER/ptkHZ
   mlx3QTGKyGx/G7EZIH2J72zUqE26CMAsiHnpEPwF0GtrUsZAosmbyUk6Y
   ilziQuoxi8UvFNyLUsaUrxjhE5WFQdcnb+Y7vnI7277cmES1fsfdV8lQ/
   aI5rUKTB8+YBdghZ2JwQC1nRH17/lrZ41XuSKlE09GPdkipzd7rqZqXxI
   7u5ax5MUZ8SYTLOb8pZWY1aJHxNnciVoFjrnkMTtvTXBjVjoQ1q29Yh2y
   gtBj8VF3seGL+bIJ6gFhlHvPSCbO1n62WD0MD+8Zx2Nqtil+9UYtRUVyZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364473285"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364473285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759941543"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759941543"
Received: from dhardfel-mobl1.ger.corp.intel.com (HELO [10.251.223.78]) ([10.251.223.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:18:09 -0700
Message-ID: <672adbbe-c86d-868b-2892-8e58c7a0612f@linux.intel.com>
Date:   Fri, 21 Jul 2023 15:19:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/9] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maarten,

On 19/07/2023 19:41, Maarten Lankhorst wrote:
> Explicitly loading i915 becomes a problem when upstreaming the new intel driver
> for Tiger Lake and higher graphics (xe). By loading i915, it doesn't wait for
> driver load of xe, and will fail completely before it loads.
> 
> -EPROBE_DEFER has to be returned before any device is created in probe(),
> otherwise the removal of the device will cause EPROBE_DEFER to try again
> in an infinite loop.
> 
> The conversion is done in gradual steps. First I add an argument to
> snd_hdac_i915_init to allow for -EPROBE_DEFER so I can convert each driver
> separately. Then I convert each driver to move snd_hdac_i915_init out of the
> workqueue. Finally I drop the ability to choose modprobe behavior after the
> last user is converted.
> 
> I suspect the avs and skylake drivers used snd_hdac_i915_init purely for the
> modprobe, but I don't have the hardware to test if it can be safely removed.
> It can still be done easily in a followup patch to simplify probing.

Apart from the few comments I had, this looks great and works OK on the
machines I have tested (iow, no regression so far).

Thank you for the work!
-- 
Péter

> 
> ---
> New since first version:
> 
> - snd_hda_core.gpu_bind is added as a mechanism to force gpu binding,
>   for testing. snd_hda_core.gpu_bind=0 forces waiting for GPU bind to
>   off, snd_hda_core.gpu_bind=1 forces waiting for gpu bind. Default
>   setting depends on whether kernel booted with nomodeset.
> - Incorporated all feedback review.
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> Cc: sound-open-firmware@alsa-project.org
> 
> Maarten Lankhorst (9):
>   ALSA: hda/intel: Fix error handling in azx_probe()
>   ALSA: hda/i915: Allow override of gpu binding.
>   ALSA: hda/i915: Add an allow_modprobe argument to snd_hdac_i915_init
>   ALSA: hda/i915: Allow xe as match for i915_component_master_match
>   ASoC: Intel: avs: Move snd_hdac_i915_init to before probe_work.
>   ASoC: Intel: Skylake: Move snd_hdac_i915_init to before probe_work.
>   ALSA: hda/intel: Move snd_hdac_i915_init to before probe_work.
>   ASoC: SOF: Intel: Remove deferred probe for SOF
>   ALSA: hda/i915: Remove extra argument from snd_hdac_i915_init
> 
>  sound/hda/hdac_i915.c         | 25 ++++++++-------
>  sound/pci/hda/hda_intel.c     | 60 ++++++++++++++++++-----------------
>  sound/soc/intel/avs/core.c    | 13 +++++---
>  sound/soc/intel/skylake/skl.c | 31 ++++++------------
>  sound/soc/sof/Kconfig         | 19 -----------
>  sound/soc/sof/core.c          | 38 ++--------------------
>  sound/soc/sof/intel/Kconfig   |  1 -
>  sound/soc/sof/intel/hda.c     | 32 +++++++++++--------
>  sound/soc/sof/sof-pci-dev.c   |  3 +-
>  sound/soc/sof/sof-priv.h      |  5 ---
>  10 files changed, 85 insertions(+), 142 deletions(-)
> 
