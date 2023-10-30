Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB27DB570
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjJ3ItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJ3Isn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:48:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE756B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698655721; x=1730191721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Svl2OIef/iELg/Wu3PXi8qtvE9agVW+eXmQX0CeRqo=;
  b=A6f2XbDIjImveiz4UWFxQfxMSX8O5EVdtu5MU/aP8lpbapq+UiDf/py9
   UhRhfv4k0es6C1UfMUUWNW1phXmm3YWVrYYhZ3ogetNRT4llZ+HGKS4Km
   FJJ2o2JGvP/ZoGjS6naIaEBuH85HPJgcjDkqrpJHo3m0sAswaqIsIqSEv
   WAWCBf4lMq1b2RvOV+XExDcV5ilvVW3m5i2hzrjtE2u8QKMloBhoCGPFk
   p1SJPt/3QOkgMOWmruwOegl6UWbm9C0/aSN87/IHQLw3c0zg0IOzJVuV1
   Wb2VWs6JUZFlSTeGM0PcvYTAGwZ+fz1I8lAc6ud6gg+m/tETzR0yWihKl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="900599"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="900599"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="850848905"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="850848905"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:48:37 -0700
Message-ID: <95e0e4a0-edff-43f6-a58b-f2324b730a99@linux.intel.com>
Date:   Mon, 30 Oct 2023 09:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-cfg: Use AVS driver on SKL/KBL/APL
 Chromebooks
Content-Language: en-US
To:     Brady Norander <bradynorander@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <ZTz9orCylVwn3Pye@arch>
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ZTz9orCylVwn3Pye@arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2023 2:25 PM, Brady Norander wrote:
> The legacy SKL driver no longer works properly on these Chromebook
> platforms. Use the new AVS driver by default instead.
> 
> Signed-off-by: Brady Norander <bradynorander@gmail.com>
> ---
>   sound/hda/intel-dsp-config.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> index 756fa0aa69bb..1045be1fd441 100644
> --- a/sound/hda/intel-dsp-config.c
> +++ b/sound/hda/intel-dsp-config.c
> @@ -16,10 +16,11 @@
>   static int dsp_driver;
>   
>   module_param(dsp_driver, int, 0444);
> -MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF)");
> +MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF, 4=AVS)");
>   
>   #define FLAG_SST			BIT(0)
>   #define FLAG_SOF			BIT(1)
> +#define FLAG_AVS			BIT(2)
>   #define FLAG_SST_ONLY_IF_DMIC		BIT(15)
>   #define FLAG_SOF_ONLY_IF_DMIC		BIT(16)
>   #define FLAG_SOF_ONLY_IF_SOUNDWIRE	BIT(17)
> @@ -56,7 +57,7 @@ static const struct config_entry config_table[] = {
>   /*
>    * Apollolake (Broxton-P)
>    * the legacy HDAudio driver is used except on Up Squared (SOF) and
> - * Chromebooks (SST), as well as devices based on the ES8336 codec
> + * Chromebooks (AVS), as well as devices based on the ES8336 codec
>    */
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
>   	{
> @@ -81,7 +82,7 @@ static const struct config_entry config_table[] = {
>   #endif
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
>   	{
> -		.flags = FLAG_SST,
> +		.flags = FLAG_AVS,
>   		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
>   		.dmi_table = (const struct dmi_system_id []) {
>   			{
> @@ -96,13 +97,13 @@ static const struct config_entry config_table[] = {
>   #endif
>   /*
>    * Skylake and Kabylake use legacy HDAudio driver except for Google
> - * Chromebooks (SST)
> + * Chromebooks (AVS)
>    */
>   
>   /* Sunrise Point-LP */
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
>   	{
> -		.flags = FLAG_SST,
> +		.flags = FLAG_AVS,
>   		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
>   		.dmi_table = (const struct dmi_system_id []) {
>   			{
> @@ -122,7 +123,7 @@ static const struct config_entry config_table[] = {
>   /* Kabylake-LP */
>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
>   	{
> -		.flags = FLAG_SST,
> +		.flags = FLAG_AVS,
>   		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
>   		.dmi_table = (const struct dmi_system_id []) {
>   			{
> @@ -667,6 +668,9 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
>   		}
>   	}
>   
> +	if (cfg->flags & FLAG_AVS)
> +		return SND_INTEL_DSP_DRIVER_AVS;
> +
>   	return SND_INTEL_DSP_DRIVER_LEGACY;
>   }
>   EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);

+ Cezary
