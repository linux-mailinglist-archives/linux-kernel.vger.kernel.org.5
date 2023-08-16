Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD777E543
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjHPPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344251AbjHPPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:35:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1E2717;
        Wed, 16 Aug 2023 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692200121; x=1723736121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yT6ZcXnMvTbf27Oj680hJO0tlEBXsOca4uKhlBJLAzo=;
  b=b6iNXGQFQkTmoiSdAvHLQ9udPwHL9FT0/y4HPwwlyLLqpihjrXjw20uI
   igYui9G4aVn3KjskoVbyxTefht3kyvFPxulQfIcsvZR9ps3ZINAev+kll
   nVEx1Y1vcOYp7I8dx+cOKmEHECxWmkW59bO/fL4wGQtneYW4SCPaND/eS
   KzvzCsS7hkq2RdknOdxmx1WrM12nbX/JOoIpoNjNXFE2HJBSWN6TFA8f4
   skbQwAbGkvQBl2iypsId/RrDbYm75EGBNm1Tjf8iWE+3iNm6i/OY27/Ot
   Xa7O9+729k81jSwljh0FoVIupP44rAf2NUAnmbEA/Q2RLmNR2F2ho3xVe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372567695"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372567695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799648992"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="799648992"
Received: from hvaughns-mobl.amr.corp.intel.com (HELO [10.209.184.121]) ([10.209.184.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:35:18 -0700
Message-ID: <f00b31fe-a64a-366f-5b55-f55eaaffeac3@linux.intel.com>
Date:   Wed, 16 Aug 2023 10:35:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 31/32] sound: usb: card: Allow for rediscovery of
 connected USB SND devices
To:     Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, oneukum@suse.com, albertccwang@google.com,
        o-takashi@sakamocchi.jp
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-32-quic_wcheng@quicinc.com>
 <671a524d-b4c8-78d8-33de-40170a23d189@linux.intel.com>
 <d42b4db3-d36d-d8fd-90ca-e00c2151195c@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d42b4db3-d36d-d8fd-90ca-e00c2151195c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 20:38, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 7/25/2023 2:15 AM, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/25/23 04:34, Wesley Cheng wrote:
>>> In case of notifying SND platform drivers of connection events, some of
>>> these use cases, such as offloading, require an ASoC USB backend
>>> device to
>>> be initialized before the events can be handled.  If the USB backend
>>> device
>>> has not yet been probed, this leads to missing initial USB audio device
>>> connection events.
>>>
>>> Expose an API that traverses the usb_chip array for connected
>>> devices, and
>>> to call the respective connection callback registered to the SND
>>> platform
>>> driver.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>   sound/usb/card.c | 19 +++++++++++++++++++
>>>   sound/usb/card.h |  2 ++
>>>   2 files changed, 21 insertions(+)
>>>
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 365f6d978608..27a89aaa0bf3 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -170,6 +170,25 @@ struct snd_usb_stream
>>> *snd_usb_find_suppported_substream(int card_idx,
>>>   }
>>>   EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
>>>   +/*
>>> + * in case the platform driver was not ready at the time of USB SND
>>> + * device connect, expose an API to discover all connected USB devices
>>> + * so it can populate any dependent resources/structures.
>>> + */
>>> +void snd_usb_rediscover_devices(void)
>>> +{
>>> +    int i;
>>> +
>>> +    mutex_lock(&register_mutex);
>>> +    for (i = 0; i < SNDRV_CARDS; i++) {
>>> +        if (usb_chip[i])
>>> +            if (platform_ops && platform_ops->connect_cb)
>>> +                platform_ops->connect_cb(usb_chip[i]);
>>
>> what happens if the USB device is removed while the platform device adds
>> a port?
>>
>> This sounds super-racy to me. It's the same set of problems we're having
>> between audio and display/DRM, I would be surprised if this function
>> dealt with all corner cases of insertion/removal, bind/unbind.
>>
> 
> The chip array entries are all populated and removed while under the
> register_mutex, so going over your race condition, we should see:
> 
> Thread#1:
> q6usb_component_probe()
> --> snd_soc_usb_add_port()
>   --> snd_usb_rediscover_devices()
>     --> mutex_lock(register_mutex)
> 
> Thread#2
> --> usb_audio_disconnect()
>   --> mutex_lock(register_mutex)
> 
> So either thread#1 or thread#2 will complete first.  If
> 
> Thread#1 completes before thread#2:
>   SOC USB will notify DPCM backend of the device connection.  Shortly
> after, once thread#2 runs, we will get a disconnect event for the
> connected device.
> 
> Thread#2 completes before thread#1:
>   Then during snd_usb_rediscover_devices() we won't notify of any
> connection for that particular chip index.

You really want to capture this locking model as part of the commit
messages or code, it'll help reviewers figure things out.
