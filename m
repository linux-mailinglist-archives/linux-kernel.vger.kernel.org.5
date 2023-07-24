Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0275F562
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGXLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGXLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:46:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F710C0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199184; x=1721735184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VOs3zQoPAAHTESws9SXZpe783/xBPR/wE76kHJu8Rmg=;
  b=Z3FAKQ70RD3JD1pbVJbrsLZbcJ4d+PfaupLhcBekBxBRCmdufWK0g62B
   deteocMbTZWTadHHp//44E/91sAweG90eA44qxBUQUJ+9YhSI3Gnmb5yu
   8HGVLGysgDrmW/lPHf3Wtm5w496HXag3XkquqnvyTBGYxhnF6RkNTTJ0g
   nzNB9AWa3TiYBr03Zi4GJ2c1ZjZBTvcN8iFivQnpia6L0sAflRp1vzVRz
   ueYHTorfsbBtNJHHB2tnyUcC6iNvnMT7Hb1kVwP+YjWwh2QzknDs21eO/
   lsXg6D4/iu3BcU/iSwbSedyrDQwLmd2MeySb7H9e8Z7F5bouWejDT7aLm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398322226"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398322226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760761962"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760761962"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56]) ([10.249.37.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:20 -0700
Message-ID: <a895de13-5320-953b-3d1c-34cee259d1d2@linux.intel.com>
Date:   Mon, 24 Jul 2023 12:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 7/9] ALSA: hda/intel: Move snd_hdac_i915_init to before
 probe_work.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-8-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230719164141.228073-8-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
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



On 7/19/23 18:41, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue.
> 
> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
> probe function.
> 
> Changes since v1:
> - Use dev_err_probe()
> - Don't move probed_devs bitmap unnecessarily. (tiwai)
> - Move snd_hdac_i915_init slightly upward, to ensure
>   it's always initialised before vga-switcheroo is called.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  sound/pci/hda/hda_intel.c | 59 ++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 11cf9907f039f..e3128d7d742e7 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2147,6 +2147,36 @@ static int azx_probe(struct pci_dev *pci,
>  
>  	pci_set_drvdata(pci, card);
>  
> +#ifdef CONFIG_SND_HDA_I915
> +	/* bind with i915 if needed */
> +	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
> +		err = snd_hdac_i915_init(azx_bus(chip), false);
> +		if (err < 0) {
> +			/* if the controller is bound only with HDMI/DP
> +			 * (for HSW and BDW), we need to abort the probe;
> +			 * for other chips, still continue probing as other
> +			 * codecs can be on the same link.
> +			 */
> +			if (CONTROLLER_IN_GPU(pci)) {
> +				dev_err_probe(card->dev, err,
> +					     "HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
> +
> +				goto out_free;
> +			} else {
> +				/* don't bother any longer */
> +				chip->driver_caps &= ~AZX_DCAPS_I915_COMPONENT;
> +			}
> +		}
> +
> +		/* HSW/BDW controllers need this power */
> +		if (CONTROLLER_IN_GPU(pci))
> +			hda->need_i915_power = true;
> +	}
> +#else
> +	if (CONTROLLER_IN_GPU(pci))
> +		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
> +#endif

Is it intentional that the display_power() is left in the probe workqueue?

this piece of code follows the stuff above in the existing code?

/* Request display power well for the HDA controller or codec. For
 * Haswell/Broadwell, both the display HDA controller and codec need
 * this power. For other platforms, like Baytrail/Braswell, only the
 * display codec needs the power and it can be released after probe.
 */
display_power(chip, true);



> +
>  	err = register_vga_switcheroo(chip);
>  	if (err < 0) {
>  		dev_err(card->dev, "Error registering vga_switcheroo client\n");
> @@ -2174,11 +2204,6 @@ static int azx_probe(struct pci_dev *pci,
>  	}
>  #endif /* CONFIG_SND_HDA_PATCH_LOADER */
>  
> -#ifndef CONFIG_SND_HDA_I915
> -	if (CONTROLLER_IN_GPU(pci))
> -		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
> -#endif
> -
>  	if (schedule_probe)
>  		schedule_delayed_work(&hda->probe_work, 0);
>  
> @@ -2275,30 +2300,6 @@ static int azx_probe_continue(struct azx *chip)
>  	to_hda_bus(bus)->bus_probing = 1;
>  	hda->probe_continued = 1;
>  
> -	/* bind with i915 if needed */
> -	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
> -		err = snd_hdac_i915_init(bus, true);
> -		if (err < 0) {
> -			/* if the controller is bound only with HDMI/DP
> -			 * (for HSW and BDW), we need to abort the probe;
> -			 * for other chips, still continue probing as other
> -			 * codecs can be on the same link.
> -			 */
> -			if (CONTROLLER_IN_GPU(pci)) {
> -				dev_err(chip->card->dev,
> -					"HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
> -				goto out_free;
> -			} else {
> -				/* don't bother any longer */
> -				chip->driver_caps &= ~AZX_DCAPS_I915_COMPONENT;
> -			}
> -		}
> -
> -		/* HSW/BDW controllers need this power */
> -		if (CONTROLLER_IN_GPU(pci))
> -			hda->need_i915_power = true;
> -	}
> -
>  	/* Request display power well for the HDA controller or codec. For
>  	 * Haswell/Broadwell, both the display HDA controller and codec need
>  	 * this power. For other platforms, like Baytrail/Braswell, only the
