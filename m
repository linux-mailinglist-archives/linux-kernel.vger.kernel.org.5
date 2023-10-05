Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44DE7B9F08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjJEORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjJEOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:14:59 -0400
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 04:32:42 PDT
Received: from mblankhorst.nl (lankhorst.se [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE124E9D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 04:32:42 -0700 (PDT)
Message-ID: <ee92964c-c277-a258-5081-cf0a19ccff79@lankhorst.se>
Date:   Thu, 5 Oct 2023 13:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 11/12] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Alsa-devel <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com>
 <20231004145540.32321-12-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2310041953090.3390143@eliteleevi.tm.intel.com>
 <b4a010aa-b547-42ad-844f-849f287abd54@linux.intel.com>
Content-Language: en-US
From:   Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <b4a010aa-b547-42ad-844f-849f287abd54@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-05 12:58, Péter Ujfalusi wrote:
> 
> 
> On 04/10/2023 19:59, Kai Vehmanen wrote:
>> Hi,
>>
>> I'm good with rest of the series, but one patch requires work.
>>
>> On Wed, 4 Oct 2023, Maarten Lankhorst wrote:
>>
>>> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
>>> the snd_hdac_i915_init into a workqueue.
>>>
>>> Use the -EPROBE_DEFER mechanism instead, which must be returned in the
>>> probe function.
>>>
>>> The previously added probe_early can be used for this,
>>> and we also use the newly added remove_late for unbinding afterwards.
>> [...]
>>> --- a/sound/soc/sof/intel/hda-common-ops.c
>>> +++ b/sound/soc/sof/intel/hda-common-ops.c
>>> @@ -19,6 +19,7 @@ struct snd_sof_dsp_ops sof_hda_common_ops = {
>>>   	.probe_early	= hda_dsp_probe_early,
>>>   	.probe		= hda_dsp_probe,
>>>   	.remove		= hda_dsp_remove,
>>> +	.remove_late	= hda_dsp_remove_late,
>>>   
>>>   	/* Register IO uses direct mmio */
>>>   
>>> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
>>> index 86a2571488bc..4eb7f04b8ae1 100644
>>> --- a/sound/soc/sof/intel/hda.c
>>> +++ b/sound/soc/sof/intel/hda.c
>>> @@ -1160,6 +1160,7 @@ int hda_dsp_probe_early(struct snd_sof_dev *sdev)
>>>   		return -ENOMEM;
>>>   	sdev->pdata->hw_pdata = hdev;
>>>   	hdev->desc = chip;
>>> +	ret = hda_init(sdev);
>>>   
>>>   err:
>>>   	return ret;
>>
>> I don't think this works. The hda_codec_i915_init() errors are ignored in
>> hda_init() so this never returns -EPROBE_DEFER.
>>
>> So something like this is needed on top (tested quickly on one SOF
>> machine and this blocks SOF load until i915 or xe driver is loaded):
>>
>> --cut--
>> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
>> index 9025bfaf6a7e..8b17c82dcc89 100644
>> --- a/sound/soc/sof/intel/hda.c
>> +++ b/sound/soc/sof/intel/hda.c
>> @@ -863,13 +863,20 @@ static int hda_init(struct snd_sof_dev *sdev)
>>          /* init i915 and HDMI codecs */
>>          ret = hda_codec_i915_init(sdev);
>>          if (ret < 0)
>> -               dev_warn(sdev->dev, "init of i915 and HDMI codec
>> failed\n");
>> +               dev_warn(sdev->dev, "init of i915 and HDMI codec failed
>> (%d)\n", ret);
> 
> we should not print anything or maximum dev_dbg in case of EPROBE_DEFER.
There's dev_err_probe, which is dev_err on error, or sets the reason for 
deferred probe to the arguments if the error is -EPROBE_DEFER.

~Maarten
