Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C67CF496
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjJSKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjJSKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:03:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32519B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697709784; x=1729245784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SgyKtQrLkgS4addmbJXnuxPILcTy9f7NSRs4ptqNYWI=;
  b=BTOQSu3nJW2OSbHU8MuhYgYODX4clJtgLlwEaGgbhwch6gD8zvpF2re2
   9nwLI1tWv3ac7GGyDiFsWQJMShkkxY/xTv44Q5FxlT59hA7vUG/StpCbh
   8LQ+565BpKddQULjxVwu6Lksl8czYYbwBHBPVU5RvqCD/BAsVzGAj+qbq
   EnQ6LvbhQf9VDBDVRQd68SaYOoxNy3FEx04dgM0R71v1KRMG3QmGuLU+b
   GqUsLJA5BePmi5bgbMnySxCfex/OwYuTNn3srl1jAFmnU/K/RLEqZw4e6
   hl9/n1yJiXP/+R8YYoftd1AoykwYOpV56Pri9zRF5AgkmRLF28XkgF0aO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383438221"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="383438221"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760588908"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="760588908"
Received: from kinstrum-mobl.ger.corp.intel.com (HELO [10.249.254.120]) ([10.249.254.120])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:02:58 -0700
Message-ID: <a581dd50-b3c0-4774-ad3e-0db5e4c47338@linux.intel.com>
Date:   Thu, 19 Oct 2023 12:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/13] ASoC: SOF: core: Ensure sof_ops_free() is still
 called when probe never ran.
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20231009115437.99976-1-maarten.lankhorst@linux.intel.com>
 <20231009115437.99976-2-maarten.lankhorst@linux.intel.com>
 <87il7aopcy.wl-tiwai@suse.de>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <87il7aopcy.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Den 2023-10-13 kl. 11:15, skrev Takashi Iwai:
> On Mon, 09 Oct 2023 13:54:25 +0200,
> Maarten Lankhorst wrote:
>> In an effort to not call sof_ops_free twice, we stopped running it when
>> probe was aborted.
>>
>> Check the result of cancel_work_sync to see if this was the case.
>>
>> Fixes: 31bb7bd9ffee ("ASoC: SOF: core: Only call sof_ops_free() on remove if the probe was successful")
>> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
> Your Signed-off-by tag is missing.
>
> Could you resubmit?
>
>
> thanks,
>
> Takashi

I missed this email apparently.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Is this enough for the tooling, or do you need an actual resubmit?

Cheers,
~Maarten

>
>> ---
>>   sound/soc/sof/core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
>> index 2d1616b81485c..0938b259f7034 100644
>> --- a/sound/soc/sof/core.c
>> +++ b/sound/soc/sof/core.c
>> @@ -459,9 +459,10 @@ int snd_sof_device_remove(struct device *dev)
>>   	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
>>   	struct snd_sof_pdata *pdata = sdev->pdata;
>>   	int ret;
>> +	bool aborted = false;
>>   
>>   	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
>> -		cancel_work_sync(&sdev->probe_work);
>> +		aborted = cancel_work_sync(&sdev->probe_work);
>>   
>>   	/*
>>   	 * Unregister any registered client device first before IPC and debugfs
>> @@ -487,6 +488,9 @@ int snd_sof_device_remove(struct device *dev)
>>   		snd_sof_free_debug(sdev);
>>   		snd_sof_remove(sdev);
>>   		sof_ops_free(sdev);
>> +	} else if (aborted) {
>> +		/* probe_work never ran */
>> +		sof_ops_free(sdev);
>>   	}
>>   
>>   	/* release firmware */
>> -- 
>> 2.39.2
>>
