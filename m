Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C654797A22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbjIGRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjIGRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:31:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0BF171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694107871; x=1725643871;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SNKXIdBqJmVcRywNeYh+7V2th6o8qWnDFUSv41r0efo=;
  b=nd//cTz5BA+eyaITwr0KotvDnCtEWMgPVUaqCvruCmfKRSwaAHVteF/1
   +43v99gRLCDiZakDloN+l+c3b/+fg+Yt4mXHttKjaEh3fp9pck0OQX/Pt
   SS6Yvb1rUjRSw3FBTjfCQpquXOyX8YK2cNwctOmKdHF8O/tj9xC06rfuh
   A35cVANPxmIMnA2mAz24NhE9lHgJvWTxtPkE/Oh7uzkpzwMcgZDinGXhh
   lDbVatA5Lk2b4ZzV5lgcLVx7ioRVH8U2Yj1dipoXUkSQuILp2Qngi1JiK
   PxKeU4OYSSwGa3i0z1caFKjByDX6Y5dzpqT1rYpxz76BOrWxjFQaQHdoX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380159010"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="380159010"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 10:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="742103116"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="742103116"
Received: from zeweiwan-mobl1.amr.corp.intel.com (HELO [10.212.62.199]) ([10.212.62.199])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 10:29:50 -0700
Message-ID: <6d39eac7-06c7-45f0-0318-72be1753641f@linux.intel.com>
Date:   Thu, 7 Sep 2023 13:29:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
 <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2309011509200.3532114@eliteleevi.tm.intel.com>
 <4252a4dc-0cf3-4ff2-aa55-c03e56345276@linux.intel.com>
 <4d84a799-c07e-e917-7c82-2f24456e3ac2@linux.intel.com>
In-Reply-To: <4d84a799-c07e-e917-7c82-2f24456e3ac2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 08:37, Pierre-Louis Bossart wrote:
> 
> 
> On 9/1/23 08:44, Péter Ujfalusi wrote:
>>
>>
>> On 01/09/2023 15:15, Kai Vehmanen wrote:
>>> Hi,
>>>
>>> On Wed, 30 Aug 2023, Maarten Lankhorst wrote:
>>>
>>>> With the upcoming changes for i915/Xe driver relying on the
>>>> -EPROBE_DEFER mechanism, we need to have a first pass of the probe
>>>> which cannot be pushed to a workqueue. Introduce 2 new optional
>>>> callbacks.
>>> [...]
>>>> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
>>>> index 30db685cc5f4b..54c384a5d6140 100644
>>>> --- a/sound/soc/sof/core.c
>>>> +++ b/sound/soc/sof/core.c
>>>> @@ -327,8 +327,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>>>>  dsp_err:
>>>>  	snd_sof_remove(sdev);
>>>>  probe_err:
>>>> -	sof_ops_free(sdev);
>>>> -
>>>
>>> this seems a bit out-of-place in this patch. It seems a valid change,
>>> but not really related to this patch, right?
>>
>> The ops needs to be preserved even if the wq fails since the patch wants
>> to call snd_sof_remove_no_wq() unconditionally on remove.
>>
>>> We seem to have a related fix waiting to be sent to alsa-devel, by
>>> Peter:
>>> "ASoC: SOF: core: Only call sof_ops_free() on remove if the probe wa"
>>> https://github.com/thesofproject/linux/pull/4515
>>
>> I guess we can revert that in sof-dev, if this is the preferred way?
>>
>>> ... not yet in Mark's tree.
>>>
>>> Otherwise patch looks good to me.
>>
>> I would have not created the snd_sof_remove_no_wq() as it makes not much
>> functional sense.
>> It might be even better if the remove in the wq would do the
>> hda_codec_i915_exit() as the module will remain in there until the user
>> removes it.
> 
> I think find all this very confusing, because there is no workqueue used
> in the remove steps. The workqueue is only used ONCE during the probe.

Maybe we should just remove any references to workqueues, and have

probe_start (cannot run in a wq)
probe (may run in a wq)
remove (cannot run in a wq, needs to call cancel_work_sync() if the
probe runs in a wq)
remove_last (cannot run in a wq, releases all resources acquired in
probe_start)

Or something similar that shows the symmetry between steps and when the
wq is allowed.
