Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD447BF8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjJJKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJJKtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:49:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203794
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696934990; x=1728470990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TCxtOEOHqePHEFVdddBUAHs1oAZDQvzfb5xAjEMMhLc=;
  b=EqCpuRw257hSvcgjFOmJ2rb3Mu9i1BIlGb6EnmjD3kiOlBPjMpJQhKh+
   S2USwvtaXQfdIGFSXvSiDnJHd9VurtvBbvPLFnwa6EeAiKA8adyuwLwve
   1px7BOb2Z7Aip5qe0zIS3aQTvjD3I+y/S/I4l2WQdsTHGafH4iwfCz7ok
   ostlu7mIKgZf3m0HHHfx1Cs0uc+tFBhA3+eYighA22UJ4rl6IXTuuRoL6
   cOVBdyGfxeBZMmpBAe7vYKMPu2RtC89Aaj0sF99ZK3mxj/AMkT3Sn8VTm
   D9Qf/PDE7cZDcQF6l3DxBpzn0FZqjrQi+sA8v//nDYOu49m16dov6boNa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374704406"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374704406"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="703262298"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="703262298"
Received: from smirnovi-mobl2.ger.corp.intel.com (HELO [10.249.36.74]) ([10.249.36.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:49:20 -0700
Message-ID: <fe03aa27-697a-4bfb-bd9c-7866da198f6c@linux.intel.com>
Date:   Tue, 10 Oct 2023 13:49:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20231009115437.99976-1-maarten.lankhorst@linux.intel.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20231009115437.99976-1-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maarteen,

On 09/10/2023 14:54, Maarten Lankhorst wrote:
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
> Compared to previous version, I added the patch
> "ASoC: SOF: Intel: Fix error handling in hda_init()"

Thank you for the updates.

to all:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

and for sound/soc/sof/ :
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>


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
> Maarten Lankhorst (11):
>   ASoC: SOF: core: Ensure sof_ops_free() is still called when probe
>     never ran.
>   ASoC: SOF: Intel: Fix error handling in hda_init()
>   ALSA: hda: Intel: Fix error handling in azx_probe()
>   ALSA: hda: i915: Allow override of gpu binding.
>   ALSA: hda: i915: Add an allow_modprobe argument to snd_hdac_i915_init
>   ALSA: hda: i915: Allow xe as match for i915_component_master_match
>   ASoC: Intel: avs: Move snd_hdac_i915_init to before probe_work.
>   ALSA: hda: Intel: Move snd_hdac_i915_init to before probe_work.
>   ASoC: Intel: Skylake: Move snd_hdac_i915_init to before probe_work.
>   ASoC: SOF: Intel: Move binding to display driver outside of deferred
>     probe
>   ALSA: hda: i915: Remove extra argument from snd_hdac_i915_init
> 
> Pierre-Louis Bossart (2):
>   ASoC: SOF: core: Add probe_early and remove_late callbacks
>   ASoC: SOF: Intel: hda: start splitting the probe
> 
>  sound/hda/hdac_i915.c                | 24 ++++++-----
>  sound/pci/hda/hda_intel.c            | 60 ++++++++++++++--------------
>  sound/soc/intel/avs/core.c           | 13 ++++--
>  sound/soc/intel/skylake/skl.c        | 31 +++++---------
>  sound/soc/sof/core.c                 | 17 +++++++-
>  sound/soc/sof/intel/hda-common-ops.c |  2 +
>  sound/soc/sof/intel/hda.c            | 46 +++++++++++++--------
>  sound/soc/sof/intel/hda.h            |  2 +
>  sound/soc/sof/ops.h                  | 16 ++++++++
>  sound/soc/sof/sof-priv.h             |  2 +
>  10 files changed, 129 insertions(+), 84 deletions(-)
> 

-- 
Péter
