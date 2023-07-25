Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE04761057
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjGYKN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGYKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:13:24 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69AB10C9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:13:23 -0700 (PDT)
Message-ID: <35720f76-e8b0-578b-e326-ebfce536be04@linux.intel.com>
Date:   Tue, 25 Jul 2023 12:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 7/9] ALSA: hda/intel: Move snd_hdac_i915_init to before
 probe_work.
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
 <a895de13-5320-953b-3d1c-34cee259d1d2@linux.intel.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <a895de13-5320-953b-3d1c-34cee259d1d2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-07-24 12:58, Pierre-Louis Bossart wrote:
> 
> 
> On 7/19/23 18:41, Maarten Lankhorst wrote:
>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>> the snd_hdac_i915_init into a workqueue.
>>
>> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
>> probe function.
>>
>> Changes since v1:
>> - Use dev_err_probe()
>> - Don't move probed_devs bitmap unnecessarily. (tiwai)
>> - Move snd_hdac_i915_init slightly upward, to ensure
>>    it's always initialised before vga-switcheroo is called.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>>   sound/pci/hda/hda_intel.c | 59 ++++++++++++++++++++-------------------
>>   1 file changed, 30 insertions(+), 29 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 11cf9907f039f..e3128d7d742e7 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -2147,6 +2147,36 @@ static int azx_probe(struct pci_dev *pci,
>>   
>>   	pci_set_drvdata(pci, card);
>>   
>> +#ifdef CONFIG_SND_HDA_I915
>> +	/* bind with i915 if needed */
>> +	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT) {
>> +		err = snd_hdac_i915_init(azx_bus(chip), false);
>> +		if (err < 0) {
>> +			/* if the controller is bound only with HDMI/DP
>> +			 * (for HSW and BDW), we need to abort the probe;
>> +			 * for other chips, still continue probing as other
>> +			 * codecs can be on the same link.
>> +			 */
>> +			if (CONTROLLER_IN_GPU(pci)) {
>> +				dev_err_probe(card->dev, err,
>> +					     "HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
>> +
>> +				goto out_free;
>> +			} else {
>> +				/* don't bother any longer */
>> +				chip->driver_caps &= ~AZX_DCAPS_I915_COMPONENT;
>> +			}
>> +		}
>> +
>> +		/* HSW/BDW controllers need this power */
>> +		if (CONTROLLER_IN_GPU(pci))
>> +			hda->need_i915_power = true;
>> +	}
>> +#else
>> +	if (CONTROLLER_IN_GPU(pci))
>> +		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
>> +#endif
> 
> Is it intentional that the display_power() is left in the probe workqueue?
> 
> this piece of code follows the stuff above in the existing code?
> 
> /* Request display power well for the HDA controller or codec. For
>   * Haswell/Broadwell, both the display HDA controller and codec need
>   * this power. For other platforms, like Baytrail/Braswell, only the
>   * display codec needs the power and it can be released after probe.
>   */
> display_power(chip, true);

I think for the binding itself, there isn't any harm. We are not poking 
any hardware when binding,
only software. This appears to be true on the i915 side as well.

Cheers,
~Maarten
