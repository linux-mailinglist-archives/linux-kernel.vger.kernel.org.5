Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBE77BAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjHNOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHNOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:07:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1746E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692022046; x=1723558046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q1bF0M0Z60l5z0SrmLHcCPMfxrtvXjd7D+J79KEYuOE=;
  b=HDQRJcqa8wetHCa9fkm4+JgOqBRK7j+PdwfI1pjHstHjfclyfs4jBVYi
   KxiToNSmi578RNUh5Ixm1dAkdWNgq/WSz5NelNobAuQFoQ5HtoflHVe1X
   GjXEeR8SO2jzyzizIMSFVkZqLflVCksl+MvT9qEM8CCLehrJNMcd71/dy
   K5BwzVM93nJ7bO0I+jmYE1ruhOyoY/CX4neHU7j//qwv4pkaFi4scSpdk
   3Dm9a2fHmq0W9pVM+UmPAinL4VNKL45z/iLe3LYsRsPnivHo3/s9cTMVA
   k00fzOZshbtzKjTf2Tm2hkmbcZOTyJnkb2SN4phxNQF+H8MSif/iDO46m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="370943684"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="370943684"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="798825224"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798825224"
Received: from ryana2x-mobl.amr.corp.intel.com (HELO [10.212.126.76]) ([10.212.126.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:07:25 -0700
Message-ID: <4f5d8095-537b-433e-4839-6061beb2b0bb@linux.intel.com>
Date:   Mon, 14 Aug 2023 08:55:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: SOF: Intel: fix hda_sdw_check_wakeen_irq()
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
References: <20230814074711.1068093-1-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230814074711.1068093-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/23 02:46, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function cannot work, as the 'chip' variable is never initialized:
> 
> sound/soc/sof/intel/hda.c:423:6: error: variable 'chip' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (chip && chip->check_sdw_wakeen_irq)
>             ^~~~
> 
> Set it the same way that other functions in this file do.
> 
> Fixes: 9362ab78f175d ("ASoC: SOF: Intel: add abstraction for SoundWire wake-ups")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> There hasn't been a new linux-next in a few days, so there is a good chance
> someone else already fixed this in the meantime. Sending out my fix in case
> that hasn't happened yet.

yes it was found by Nathan Chancelor and corrected already. Thanks for
checking though!


> ---
>  sound/soc/sof/intel/hda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 04c748a72b137..6c9c7b390cf53 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -415,7 +415,7 @@ bool hda_sdw_check_wakeen_irq_common(struct snd_sof_dev *sdev)
>  static bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
>  {
>  	u32 interface_mask = hda_get_interface_mask(sdev);
> -	const struct sof_intel_dsp_desc *chip;
> +	const struct sof_intel_dsp_desc *chip = get_chip_info(sdev->pdata);
>  
>  	if (!(interface_mask & BIT(SOF_DAI_INTEL_ALH)))
>  		return false;
