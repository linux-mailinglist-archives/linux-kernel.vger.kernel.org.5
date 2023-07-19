Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD6759A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGSPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGSPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:54:40 -0400
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6ECD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:54:39 -0700 (PDT)
Message-ID: <a913df90-174c-7132-bbfa-bf30f0664d9c@linux.intel.com>
Date:   Wed, 19 Jul 2023 17:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] ASoC: Intel: avs: Move snd_hdac_i915_init to before
 probe_work.
Content-Language: en-US
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org
Cc:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-4-maarten.lankhorst@linux.intel.com>
 <18fb40b9-f5b4-60d8-79df-e0719cf48231@intel.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <18fb40b9-f5b4-60d8-79df-e0719cf48231@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 2023-07-19 17:26, Cezary Rojewski wrote:
> On 2023-07-18 10:45 AM, Maarten Lankhorst wrote:
>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
>> can be destroyed, but I don't have the means to test this.
>>
>> Removing the workqueue would simplify init even further, but is left
>> as exercise for the reviewer.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>>   sound/soc/intel/avs/core.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
>> index 3311a6f142001..d3a7f42387e9b 100644
>> --- a/sound/soc/intel/avs/core.c
>> +++ b/sound/soc/intel/avs/core.c
>> @@ -191,10 +191,6 @@ static void avs_hda_probe_work(struct work_struct 
>> *work)
>>       pm_runtime_set_active(bus->dev); /* clear runtime_error flag */
>> -    ret = snd_hdac_i915_init(bus, true);
>> -    if (ret < 0)
>> -        dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
>> -
>>       snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
>>       avs_hdac_bus_init_chip(bus, true);
>>       avs_hdac_bus_probe_codecs(bus);
>> @@ -465,10 +461,19 @@ static int avs_pci_probe(struct pci_dev *pci, 
>> const struct pci_device_id *id)
>>       pci_set_drvdata(pci, bus);
>>       device_disable_async_suspend(dev);
>> +    ret = snd_hdac_i915_init(bus, false);
>> +    if (ret == -EPROBE_DEFER)
>> +        goto err_unmaster;
>> +    else if (ret < 0)
>> +        dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
>> +
> 
> While our tests are currently passing I have my doubts about 
> EPROBE_DEFER. We do want to have audio functionality there even if some 
> problems with HDMI arise along the way - some audio is better than no 
> audio. Here, i915 may ruin the day for a platform equipped with 
> hda/hdmi/i2c/dmic chips simultaneously.
> 
> Also, why call snd_hdac_i915_init() _after_ setting drvdata?

I wanted to make the most cautious change. The previous flow called the 
function immediately from probe_work, so I moved it to right before the 
scheduling of probe_work

>>       schedule_work(&adev->probe_work);
>>       return 0;
>> +err_unmaster:
>> +    pci_clear_master(pci);
>> +    pci_set_drvdata(pci, NULL);
> 
> Not a fan. It's hard to grasp entire error-step within name of a single 
> label. Thus I'd suggest "err_<cause>" naming pattern instead. Even here, 
> under "unmaster" you hid clearing master and drvdata both. Let's do 
> "err_i915_init" instead.
> 
Ok, will rename.

~Maarten
