Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15793760FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGYJyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGYJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:54:47 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0861B8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:54:46 -0700 (PDT)
Message-ID: <932c4293-375f-685c-2cfd-0bc80fd80683@linux.intel.com>
Date:   Tue, 25 Jul 2023 11:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/9] ALSA: hda/i915: Allow override of gpu binding.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
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
 <d75c1902-b715-4a33-1965-ec06d625e3ac@linux.intel.com>
Content-Language: en-US
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <d75c1902-b715-4a33-1965-ec06d625e3ac@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-07-24 12:25, Pierre-Louis Bossart wrote:
> 
> 
> On 7/21/23 14:19, Péter Ujfalusi wrote:
>>
>>
>> On 19/07/2023 19:41, Maarten Lankhorst wrote:
>>> Selecting CONFIG_DRM selects CONFIG_VIDEO_NOMODESET, which exports
>>> video_firmware_drivers_only(). This can be used as a first
>>> approximation on whether i915 will be available. It's safe to use as
>>> this is only built when CONFIG_SND_HDA_I915 is selected by CONFIG_I915.
>>>
>>> It's not completely fool proof, as you can boot with "nomodeset
>>> i915.modeset=1" to make i915 load regardless, or use
>>> "i915.force_probe=!*" to never load i915, but the common case of
>>> booting with nomodeset to disable all GPU drivers this will work as
>>> intended.
>>>
>>> Because of this, we add an extra module parameter,
>>> snd_hda_core.gpu_bind that can be used to signal users intent.
>>> -1 follows nomodeset, 0 disables binding, 1 forces wait/-EPROBE_DEFER
>>> on binding.
>>
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>
>>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> ---
>>>   sound/hda/hdac_i915.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
>>> index 161a9711cd63e..c32709fa4115f 100644
>>> --- a/sound/hda/hdac_i915.c
>>> +++ b/sound/hda/hdac_i915.c
>>> @@ -11,6 +11,13 @@
>>>   #include <sound/hda_i915.h>
>>>   #include <sound/hda_register.h>
>>>   
>>> +#include <video/nomodeset.h>
>>> +
>>> +static int gpu_bind = -1;
>>> +module_param(gpu_bind, int, 0644);
>>> +MODULE_PARM_DESC(gpu_bind, "Whether to bind sound component to GPU "
>>> +			   "(1=always, 0=never, -1=on nomodeset(default))");
>>> +
>>>   #define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
>>>   				((pci)->device == 0x0c0c) || \
>>>   				((pci)->device == 0x0d0c) || \
>>> @@ -121,6 +128,9 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
>>>   {
>>>   	struct pci_dev *display_dev = NULL;
>>>   
>>> +	if (!gpu_bind || (gpu_bind < 0 && video_firmware_drivers_only()))
>>> +		return false;
> 
> 
> Bear with me since I am just going back to work mode but I can't figure
> out what the second part of the test does
> 
> bool video_firmware_drivers_only(void)
> {
> 	return video_nomodeset;
> }
> EXPORT_SYMBOL(video_firmware_drivers_only);
> 
> and video_nomodeset=1 by default, so why would we return false when
> gpu_bind = -1?
> 
> This seems to be a change of functionality, what am I missing?
video_nomodeset is 0 by default, only when nomodeset is given as 
argument is it set to 1. :-)

Cheers,
~Maarten
