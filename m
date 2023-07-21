Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CD75C6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGUMTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGUMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:19:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA482106
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689941942; x=1721477942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7j7LwynwL0LMQz3oB6ergd8/nVuyEdhPBGRLEJP6bP0=;
  b=UnuwfQ/7+lM4+Nq+xo6muGKiBAiVk9ZAk8ZdpblZq2DZKqr8QseBwy1T
   xZyb8uQQPWDh3nNBsabiY8e+//aIaXamGTplAFVGA9OtmUlWPB/WOmibl
   w3D3ZZ6ZsHAyMaEUeKJLVLMFezNVgGouJfWGFQ9ZWxC4LuA/dD3qjEXO9
   ubEa76DXv30x4ByaANigH70RKyFWwm1ubuCD3qLno6UBjib8Ci5glyjnB
   9clGTndJTcSkHe0WLQYk8uSS+wTnhsPdzn2KEKI6CFlUaoORaJSZk+ZQA
   5QVYlY8L0Ak8eD4zetxjjVkFu1tQTQJNCut6wwRBGOy+M7DOEJSmChPbX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356999013"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356999013"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="675028754"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="675028754"
Received: from dhardfel-mobl1.ger.corp.intel.com (HELO [10.251.223.78]) ([10.251.223.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:18:39 -0700
Message-ID: <9b285ede-eaeb-40a2-086d-30cf74185784@linux.intel.com>
Date:   Fri, 21 Jul 2023 15:19:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/9] ALSA: hda/i915: Allow override of gpu binding.
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
 <20230719164141.228073-3-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230719164141.228073-3-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2023 19:41, Maarten Lankhorst wrote:
> Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports
> video_firmware_drivers_only(). This can be used as a first
> approximation on whether i915 will be available. It's safe to use as
> this is only built when CONFIG_SND_HDA_I915 is selected by CONFIG_I915.
> 
> It's not completely fool proof, as you can boot with "nomodeset
> i915.modeset=1" to make i915 load regardless, or use
> "i915.force_probe=!*" to never load i915, but the common case of
> booting with nomodeset to disable all GPU drivers this will work as
> intended.
> 
> Because of this, we add an extra module parameter,
> snd_hda_core.gpu_bind that can be used to signal users intent.
> -1 follows nomodeset, 0 disables binding, 1 forces wait/-EPROBE_DEFER
> on binding.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  sound/hda/hdac_i915.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index 161a9711cd63e..c32709fa4115f 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -11,6 +11,13 @@
>  #include <sound/hda_i915.h>
>  #include <sound/hda_register.h>
>  
> +#include <video/nomodeset.h>
> +
> +static int gpu_bind = -1;
> +module_param(gpu_bind, int, 0644);
> +MODULE_PARM_DESC(gpu_bind, "Whether to bind sound component to GPU "
> +			   "(1=always, 0=never, -1=on nomodeset(default))");
> +
>  #define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
>  				((pci)->device == 0x0c0c) || \
>  				((pci)->device == 0x0d0c) || \
> @@ -121,6 +128,9 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
>  {
>  	struct pci_dev *display_dev = NULL;
>  
> +	if (!gpu_bind || (gpu_bind < 0 && video_firmware_drivers_only()))
> +		return false;
> +
>  	for_each_pci_dev(display_dev) {
>  		if (display_dev->vendor == PCI_VENDOR_ID_INTEL &&
>  		    (display_dev->class >> 16) == PCI_BASE_CLASS_DISPLAY &&

-- 
Péter
