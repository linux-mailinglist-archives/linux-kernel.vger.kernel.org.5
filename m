Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA775833C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGRRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGRRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:08:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D920BBE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689700084; x=1721236084;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LowChJyNpWySLgzTtjQDu+vchcaLd6zgP20alhFs/kY=;
  b=jQ7fVBqnLwS+wCzDQ7hgmZq5yk3u7UVf6Wm/Fai16XV76Sx4Ee1T7kiz
   22QMMQITscuSzoH0a8GoYxLky/i3TDDlnPxVVI7KBxzRLdopOPZG0WlOj
   Spn1juwhQ57DzyrqGd8ZdmNtzstQJ58AOGTCH1iIFJxaXb+t1r+/oWbqy
   AHPWolIrNC5yp17bgLm7aLjLnLrZSld9qbjxhV3K1VMDOOgtJQXjlRlZK
   ha1zDxAta4vzEA7CUXXe45VfDZgViEWfpohYJe9I9ocvOOZSUwpxL0bKA
   q4EiGM/YxVXUEPN1aqNtNPZCCmfCWQWwJADKepRv5lAuMxEOMIzIGdHxA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430025055"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="430025055"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="717674959"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="717674959"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:08:00 -0700
Date:   Tue, 18 Jul 2023 20:04:41 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH 6/7] ASoC: SOF: Intel: Remove deferred probe for SOF
In-Reply-To: <20230718084522.116952-7-maarten.lankhorst@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2307181922160.3532114@eliteleevi.tm.intel.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com> <20230718084522.116952-7-maarten.lankhorst@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you Maarten for doing the series! I think a lot of people will be 
happy to get rid of the 60sec timeout. 

I kicked off a CI run SOF public infra for the whole series at
https://github.com/thesofproject/linux/pull/4478
Some results still in progress but so far so good.

Some concerns inline:

On Tue, 18 Jul 2023, Maarten Lankhorst wrote:

> This was only used to allow modprobing i915, by converting to the
> -EPROBE_DEFER mechanism, it can be completely removed, and is in
> fact counterproductive since -EPROBE_DEFER otherwise won't be
> handled correctly.

We actually have a request_module() for the regular HDA codec drivers as 
well (sof_probe_continue() -> snd_sof_probe() -> hda_dsp_probe() -> 
hda_init_caps() -> hda_codec_probe_bus(). But right, this is not 
necessarily a problem on its own, so it looks we indeed can drop the work 
queue. Nice!

> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index f1fd5b44aaac9..344b61576c0e3 100644
> --- a/sound/soc/sof/intel/hda-codec.c
> +++ b/sound/soc/sof/intel/hda-codec.c
> @@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
>  		return 0;
>  
>  	/* i915 exposes a HDA codec for HDMI audio */
> -	ret = snd_hdac_i915_init(bus, true);
> +	ret = snd_hdac_i915_init(bus, false);
>  	if (ret < 0)
>  		return ret;

My only bigger concern is corner cases where the display PCI device is on 
the bus and visible to kernel, but for some reason there is no working 
driver in the system or it is disabled.

With this patch, not having a workign display driver means that there is 
also no audio in the system as the SOF driver will never get probed.

In current mainline, one will get the 60sec timeout warning and then
audio driver will proceed to probe and you'll have audio support (minus 
HDMI/DP).

This is mostly an issue with very new hardware (e.g. hw is still 
behind force_probe flag in xe/i915 driver), but we've had some odd
cases with e.g. systems with both Intel IGFX and other vendors' DGPU. 
Audio drivers see the Intel VGA controller in system and will
call snd_hdac_i915_init(), but the audio component bind will never
succeed if the the Intel IGFX is not in actual use.

Will need a bit of time to think about possible scenarios. Possibly this 
is not an issue outside early development systems. In theory if IGFX is 
disabled in BIOS, and not visible to OS, we are good, and if it's visible, 
the i915/xe driver should be loaded, so we are good again.

Br, Kai
