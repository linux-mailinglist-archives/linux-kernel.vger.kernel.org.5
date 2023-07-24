Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480075F560
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGXLqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGXLqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:46:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ABCE61
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199172; x=1721735172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nkkTQMhHmzPV4+XcvmoQCvwm0WloI83UVn8Oj3behns=;
  b=ka8JBrRRqX1tQY69Y+mWx5VagNjSNILxj43oLLN+bRLsvOopTQFf1YQI
   K9qPx0s8mqZiDfuo68F34/kjzJUzyy3qo7ACKDKDXE61ZfsmE61YbsDi1
   fG8wMDU27iENUB+oEZi1eZKe5AFudGhwPZ91X+Xab4z23Ppfie3Ko97Pw
   rzmwJRuMj03BUeSHxIiTHCvk4rreu5w5IyqddnAPUPgsyaIkkUhFitDPm
   gKvNu80oUJkEU16Sv1zU7OYx9DidK2iazVJ2KdqZrRqQi3BJvLKHuLf0v
   rJ7iIsivAM45kLVEZ4A+4Q6FFcjTXMQViILw/hEN+ISDCNYewFIq7fsaY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398322181"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398322181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760761952"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760761952"
Received: from sosterlu-mobl.ger.corp.intel.com (HELO [10.249.37.56]) ([10.249.37.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:46:08 -0700
Message-ID: <d75c1902-b715-4a33-1965-ec06d625e3ac@linux.intel.com>
Date:   Mon, 24 Jul 2023 12:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/9] ALSA: hda/i915: Allow override of gpu binding.
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <20230719164141.228073-3-maarten.lankhorst@linux.intel.com>
 <9b285ede-eaeb-40a2-086d-30cf74185784@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <9b285ede-eaeb-40a2-086d-30cf74185784@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/23 14:19, Péter Ujfalusi wrote:
> 
> 
> On 19/07/2023 19:41, Maarten Lankhorst wrote:
>> Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports
>> video_firmware_drivers_only(). This can be used as a first
>> approximation on whether i915 will be available. It's safe to use as
>> this is only built when CONFIG_SND_HDA_I915 is selected by CONFIG_I915.
>>
>> It's not completely fool proof, as you can boot with "nomodeset
>> i915.modeset=1" to make i915 load regardless, or use
>> "i915.force_probe=!*" to never load i915, but the common case of
>> booting with nomodeset to disable all GPU drivers this will work as
>> intended.
>>
>> Because of this, we add an extra module parameter,
>> snd_hda_core.gpu_bind that can be used to signal users intent.
>> -1 follows nomodeset, 0 disables binding, 1 forces wait/-EPROBE_DEFER
>> on binding.
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> 
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>>  sound/hda/hdac_i915.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
>> index 161a9711cd63e..c32709fa4115f 100644
>> --- a/sound/hda/hdac_i915.c
>> +++ b/sound/hda/hdac_i915.c
>> @@ -11,6 +11,13 @@
>>  #include <sound/hda_i915.h>
>>  #include <sound/hda_register.h>
>>  
>> +#include <video/nomodeset.h>
>> +
>> +static int gpu_bind = -1;
>> +module_param(gpu_bind, int, 0644);
>> +MODULE_PARM_DESC(gpu_bind, "Whether to bind sound component to GPU "
>> +			   "(1=always, 0=never, -1=on nomodeset(default))");
>> +
>>  #define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
>>  				((pci)->device == 0x0c0c) || \
>>  				((pci)->device == 0x0d0c) || \
>> @@ -121,6 +128,9 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
>>  {
>>  	struct pci_dev *display_dev = NULL;
>>  
>> +	if (!gpu_bind || (gpu_bind < 0 && video_firmware_drivers_only()))
>> +		return false;


Bear with me since I am just going back to work mode but I can't figure
out what the second part of the test does

bool video_firmware_drivers_only(void)
{
	return video_nomodeset;
}
EXPORT_SYMBOL(video_firmware_drivers_only);

and video_nomodeset=1 by default, so why would we return false when
gpu_bind = -1?

This seems to be a change of functionality, what am I missing?


>> +
>>  	for_each_pci_dev(display_dev) {
>>  		if (display_dev->vendor == PCI_VENDOR_ID_INTEL &&
>>  		    (display_dev->class >> 16) == PCI_BASE_CLASS_DISPLAY &&
> 
