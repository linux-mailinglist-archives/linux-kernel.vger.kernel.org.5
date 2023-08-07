Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2477285A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjHGO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHGO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:56:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5241910CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420202; x=1722956202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JqeztFeqeIb8u0ximbuaFAtMKDPtvXdzUyTKSrRS9Kk=;
  b=JpHwAzmIHNc8R5fbipuLrOWOVcsOKzelC37f2enQ8Wdcx3k1x6nC3Cvx
   zPXW5xg4o8hu8d/Lei/h6hq+5w2GfVr6bmV7Q9p4qSmF+xciHE7oCgUCc
   rxydUfiV93bDHroVy2xQt4IvHiolLuNHhmTpS4AQK7Yd64QbJspffFQpz
   wBzNVqj5PbFx+HSJPQexns1dfLOszboU6ACDlX0GC/Cw/6v5hCxIsT6O2
   f41eJqKRwI1wkVQ10SDv+LUZpCVWAY+dSMgTRLFVRM6xT+6d+DmLppc0S
   ZF1yhWd002uG8elVearrsfAI2k1aYOJQ657Re7uP4VCZAS3H6VeZapI0t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434410608"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434410608"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061623880"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061623880"
Received: from hweelee-mobl.amr.corp.intel.com (HELO [10.209.181.215]) ([10.209.181.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:39 -0700
Message-ID: <e710e29b-73a3-735e-6c78-9fd4829a25cc@linux.intel.com>
Date:   Mon, 7 Aug 2023 09:13:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/9] ASoC: Intel: avs: Move snd_hdac_i915_init to
 before probe_work.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
 <20230807090045.198993-6-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230807090045.198993-6-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/23 04:00, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
> can be destroyed, but I don't have the means to test this.
> 
> Removing the workqueue would simplify init even further, but is left
> as exercise for the reviewer.
> 
> Changes since v1:
> - Rename error label.

same issue with changes, they need to be ...
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>> ---

...here

>  sound/soc/intel/avs/core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index 3311a6f14200..64e7a4e650a8 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -191,10 +191,6 @@ static void avs_hda_probe_work(struct work_struct *work)
>  
>  	pm_runtime_set_active(bus->dev); /* clear runtime_error flag */
>  
> -	ret = snd_hdac_i915_init(bus, true);
> -	if (ret < 0)
> -		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
> -
>  	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
>  	avs_hdac_bus_init_chip(bus, true);
>  	avs_hdac_bus_probe_codecs(bus);
> @@ -465,10 +461,19 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  	pci_set_drvdata(pci, bus);
>  	device_disable_async_suspend(dev);
>  
> +	ret = snd_hdac_i915_init(bus, false);
> +	if (ret == -EPROBE_DEFER)
> +		goto err_i915_init;
> +	else if (ret < 0)
> +		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
> +
>  	schedule_work(&adev->probe_work);
>  
>  	return 0;
>  
> +err_i915_init:
> +	pci_clear_master(pci);
> +	pci_set_drvdata(pci, NULL);
>  err_acquire_irq:
>  	snd_hdac_bus_free_stream_pages(bus);
>  	snd_hdac_ext_stream_free_all(bus);
