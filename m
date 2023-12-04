Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9905803136
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbjLDLDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjLDLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:03:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9676B9;
        Mon,  4 Dec 2023 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701687806; x=1733223806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K3LZ0ut12b0ZWweiMZsY7lTX+GonCXKoqqOWSfI90kI=;
  b=AM8OMdFO2mDBpxCb2PP44c2aK7kD27+RFkCAtbTtwpUFHb2lKi39wLrL
   rQsJABxvi5UWxEoKhapG1ZYbEDMTctJTxXGOlElNunpYfz76sMIyHXi7e
   m7kkejxXW0t8SWBXMI6TpxywYoCe8Nj9ozzhPGw7H7mJAccfYGxVvdJFp
   qU1A+EKLM7HffDQC/mdIhERxSFHbQC0/tfq5eYQddm46/zFUGBU4ogYgO
   VKTNIMMtcIBR5GfHaiX4zI7vlYwv5u6fP1rvp45fztE+Jga/GHb1xEfxI
   uGckKQ4tIBvMQk5sj/J0+ne/UJdxsgIu8qxdjllOj960ha9LavKaDkgaN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="15262688"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="15262688"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 03:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="861343646"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="861343646"
Received: from epologov-mobl2.ccr.corp.intel.com (HELO [10.249.32.181]) ([10.249.32.181])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 03:03:23 -0800
Message-ID: <ff56d56b-4b5c-42fa-bf7f-78a5746ec3be@linux.intel.com>
Date:   Mon, 4 Dec 2023 13:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Move sof_of_machine_select() to core.c from
 sof-of-dev.c
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231204033549.2020289-1-wenst@chromium.org>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20231204033549.2020289-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2023 05:35, Chen-Yu Tsai wrote:
> This reverts commit 014fdeb0d747304111cfecf93df4407c1a0c80db.
> 
> Commit 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to
> sof-of-dev.c from sof-audio.c") caused a circular dependency between
> the snd_sof and snd_sof_of modules:
> 
> 	depmod: ERROR: Cycle detected: snd_sof -> snd_sof_of -> snd_sof
> 	depmod: ERROR: Found 2 modules in dependency cycles!
> 
> Move the function back with sof_machine_select().
> 
> Fixes: 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to sof-of-dev.c from sof-audio.c")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Oh, I have re-done the compile test and that does not detect this (I
don't have ARM device to runtime test it), but looks valid.
I wonder if we should do this similarly to acpi machine select via ops
to cut the circular dependency?
That can be done in a followup patch.

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
> Not sure what the proper arrangement would be, but this gets my builds
> going again.
> 
>  sound/soc/sof/core.c       | 22 ++++++++++++++++++++++
>  sound/soc/sof/sof-of-dev.c | 23 -----------------------
>  sound/soc/sof/sof-of-dev.h |  9 ---------
>  3 files changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
> index a2afec8f5879..425b023b03b4 100644
> --- a/sound/soc/sof/core.c
> +++ b/sound/soc/sof/core.c
> @@ -144,6 +144,28 @@ void sof_set_fw_state(struct snd_sof_dev *sdev, enum sof_fw_state new_state)
>  }
>  EXPORT_SYMBOL(sof_set_fw_state);
>  
> +static struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
> +{
> +	struct snd_sof_pdata *sof_pdata = sdev->pdata;
> +	const struct sof_dev_desc *desc = sof_pdata->desc;
> +	struct snd_sof_of_mach *mach = desc->of_machines;
> +
> +	if (!mach)
> +		return NULL;
> +
> +	for (; mach->compatible; mach++) {
> +		if (of_machine_is_compatible(mach->compatible)) {
> +			sof_pdata->tplg_filename = mach->sof_tplg_filename;
> +			if (mach->fw_filename)
> +				sof_pdata->fw_filename = mach->fw_filename;
> +
> +			return mach;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>  /* SOF Driver enumeration */
>  static int sof_machine_check(struct snd_sof_dev *sdev)
>  {
> diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
> index fa92da5ee9b3..b9a499e92b9a 100644
> --- a/sound/soc/sof/sof-of-dev.c
> +++ b/sound/soc/sof/sof-of-dev.c
> @@ -41,29 +41,6 @@ static void sof_of_probe_complete(struct device *dev)
>  	pm_runtime_enable(dev);
>  }
>  
> -struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
> -{
> -	struct snd_sof_pdata *sof_pdata = sdev->pdata;
> -	const struct sof_dev_desc *desc = sof_pdata->desc;
> -	struct snd_sof_of_mach *mach = desc->of_machines;
> -
> -	if (!mach)
> -		return NULL;
> -
> -	for (; mach->compatible; mach++) {
> -		if (of_machine_is_compatible(mach->compatible)) {
> -			sof_pdata->tplg_filename = mach->sof_tplg_filename;
> -			if (mach->fw_filename)
> -				sof_pdata->fw_filename = mach->fw_filename;
> -
> -			return mach;
> -		}
> -	}
> -
> -	return NULL;
> -}
> -EXPORT_SYMBOL(sof_of_machine_select);
> -
>  int sof_of_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> diff --git a/sound/soc/sof/sof-of-dev.h b/sound/soc/sof/sof-of-dev.h
> index 547e358a37e3..b6cc70595f3b 100644
> --- a/sound/soc/sof/sof-of-dev.h
> +++ b/sound/soc/sof/sof-of-dev.h
> @@ -16,15 +16,6 @@ struct snd_sof_of_mach {
>  	const char *sof_tplg_filename;
>  };
>  
> -#if IS_ENABLED(CONFIG_SND_SOC_SOF_OF_DEV)
> -struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev);
> -#else
> -static inline struct snd_sof_of_mach *sof_of_machine_select(struct snd_sof_dev *sdev)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  extern const struct dev_pm_ops sof_of_pm;
>  
>  int sof_of_probe(struct platform_device *pdev);

-- 
Péter
