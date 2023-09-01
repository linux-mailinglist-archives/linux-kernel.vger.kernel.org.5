Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DA278FD70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbjIAMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242569AbjIAMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:44:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C27E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693572248; x=1725108248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ywJVJh0PNqpM2RLKnYJQulhCemfMfpJ1CUH0ytkIMM=;
  b=TBIiUHKKfQ/+E7+MdDAa8SJo8r6MVz0oWrx3KBVeD0dxkhdH1BePxESV
   kqG5H+S/kGV7RuMk5v+WttFwIP+OE+wT72SfCw8d0Oe5HqBWmbJuRS/cF
   Xj05Egq8QL+6YNAEDN07DTd6/ida/ntaQgo5tANF6sAlcXAanl3AAKTGq
   O8NQ0g6KgPmVlZ0/oEq0gdRMxxS9+7a3VaUZ+Fs9x7rNl/JlEClcVV9/O
   7MukiAmtW7To2OtZNTgGL0HyKDetVoEzPSQON5o5Xr/y3RajOvhoJ4K3A
   O81pnNmJ4UdCUfG7+jKJcfZNpwE3Xk3YIVlqOMSnSp0mGHUWUFap1lfy+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378936743"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="378936743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="830113531"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="830113531"
Received: from dstavrak-mobl.ger.corp.intel.com (HELO [10.252.32.139]) ([10.252.32.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:44:04 -0700
Message-ID: <4252a4dc-0cf3-4ff2-aa55-c03e56345276@linux.intel.com>
Date:   Fri, 1 Sep 2023 15:44:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
 <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
 <alpine.DEB.2.22.394.2309011509200.3532114@eliteleevi.tm.intel.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2309011509200.3532114@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2023 15:15, Kai Vehmanen wrote:
> Hi,
> 
> On Wed, 30 Aug 2023, Maarten Lankhorst wrote:
> 
>> With the upcoming changes for i915/Xe driver relying on the
>> -EPROBE_DEFER mechanism, we need to have a first pass of the probe
>> which cannot be pushed to a workqueue. Introduce 2 new optional
>> callbacks.
> [...]
>> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
>> index 30db685cc5f4b..54c384a5d6140 100644
>> --- a/sound/soc/sof/core.c
>> +++ b/sound/soc/sof/core.c
>> @@ -327,8 +327,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>>  dsp_err:
>>  	snd_sof_remove(sdev);
>>  probe_err:
>> -	sof_ops_free(sdev);
>> -
> 
> this seems a bit out-of-place in this patch. It seems a valid change,
> but not really related to this patch, right?

The ops needs to be preserved even if the wq fails since the patch wants
to call snd_sof_remove_no_wq() unconditionally on remove.

> We seem to have a related fix waiting to be sent to alsa-devel, by
> Peter:
> "ASoC: SOF: core: Only call sof_ops_free() on remove if the probe wa"
> https://github.com/thesofproject/linux/pull/4515

I guess we can revert that in sof-dev, if this is the preferred way?

> ... not yet in Mark's tree.
> 
> Otherwise patch looks good to me.

I would have not created the snd_sof_remove_no_wq() as it makes not much
functional sense.
It might be even better if the remove in the wq would do the
hda_codec_i915_exit() as the module will remain in there until the user
removes it.

> 
> Br, Kai

-- 
Péter
