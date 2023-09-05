Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB29792B12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjIEQrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354731AbjIENwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:52:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD0197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693921964; x=1725457964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GGTb85SwmehwRQFdOE4/kZdtjUSb36Ogu5VpLNfqXYs=;
  b=ivtLKZJpntQW/kv7VF5FLWAGMWULne1uYvDtwHiCTHiTFn3nKf11WzE/
   PaimC9gqh055KCa0CjXXVbugqZVOQHeEuW7iNIP10EH7ArjkVCMZmjZlg
   wscxJdi9TqzcAgzootzzs0AqiAlv70TMOsFhzhWwj2kYIJz6Hd3p1oFsh
   Q3CTlbdp54vQeMDmk/5/Pra1DmsfebKVhgC2en6WIF5HGGHQKkE7TcQWR
   DlOLIDEWjTK4VN6QlYlBqIC3x/2TQzxHYaKwNh7BNO8sLraFMeWarakbw
   MmGqjJrUbrTk20tTRf8DQKA8l6GIrHSi3Y+PXVKe8C7k2utaIMvw2+lR8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463165892"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="463165892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741100793"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="741100793"
Received: from qatran-mobl2.amr.corp.intel.com (HELO [10.212.36.84]) ([10.212.36.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:52:41 -0700
Message-ID: <4d84a799-c07e-e917-7c82-2f24456e3ac2@linux.intel.com>
Date:   Tue, 5 Sep 2023 08:37:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Content-Language: en-US
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <4252a4dc-0cf3-4ff2-aa55-c03e56345276@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/23 08:44, Péter Ujfalusi wrote:
> 
> 
> On 01/09/2023 15:15, Kai Vehmanen wrote:
>> Hi,
>>
>> On Wed, 30 Aug 2023, Maarten Lankhorst wrote:
>>
>>> With the upcoming changes for i915/Xe driver relying on the
>>> -EPROBE_DEFER mechanism, we need to have a first pass of the probe
>>> which cannot be pushed to a workqueue. Introduce 2 new optional
>>> callbacks.
>> [...]
>>> diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
>>> index 30db685cc5f4b..54c384a5d6140 100644
>>> --- a/sound/soc/sof/core.c
>>> +++ b/sound/soc/sof/core.c
>>> @@ -327,8 +327,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
>>>  dsp_err:
>>>  	snd_sof_remove(sdev);
>>>  probe_err:
>>> -	sof_ops_free(sdev);
>>> -
>>
>> this seems a bit out-of-place in this patch. It seems a valid change,
>> but not really related to this patch, right?
> 
> The ops needs to be preserved even if the wq fails since the patch wants
> to call snd_sof_remove_no_wq() unconditionally on remove.
> 
>> We seem to have a related fix waiting to be sent to alsa-devel, by
>> Peter:
>> "ASoC: SOF: core: Only call sof_ops_free() on remove if the probe wa"
>> https://github.com/thesofproject/linux/pull/4515
> 
> I guess we can revert that in sof-dev, if this is the preferred way?
> 
>> ... not yet in Mark's tree.
>>
>> Otherwise patch looks good to me.
> 
> I would have not created the snd_sof_remove_no_wq() as it makes not much
> functional sense.
> It might be even better if the remove in the wq would do the
> hda_codec_i915_exit() as the module will remain in there until the user
> removes it.

I think find all this very confusing, because there is no workqueue used
in the remove steps. The workqueue is only used ONCE during the probe.
