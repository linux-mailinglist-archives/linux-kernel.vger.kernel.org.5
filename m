Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5F7D53F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjJXOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343742AbjJXOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:25:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6910C2;
        Tue, 24 Oct 2023 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698157527; x=1729693527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WwFLxwlK3z/Xf+xApxGXXQp0naSbrNazBZ+qab2Rats=;
  b=gmHpGf89MAx2L7Vt495UY3aWAv33slfUsIkh0B7egGZ/CHcg5/mpREQ9
   b1579gtbAv23yPC5NkKsnSC+8bbvxetAdYx0sCDm/W0lA+Njlypqk04AJ
   qLYMRB3eMZJdQyZJk27LC21hGH3Rv0QVpz5NMBYQy/nhU7+/IDMCGX5sO
   bBfbRf+WhjEedrIsRLeIhg5esBVJtCZLcLgcQfabz79nRc2MNGl7z2ods
   aIM7BOic+hXzzRFEHbizFCtn8rnt3CzXdMzyNB8GIRXNO/6fxrWgWoUZz
   ZtzGyXqNQAy0CDKx9CrorLkiWFpj8p2gNpxP6jjVehFigOQkap1SE/7e0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="386873937"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="386873937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758491622"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="758491622"
Received: from pwali-mobl.amr.corp.intel.com (HELO [10.209.188.4]) ([10.209.188.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 07:25:24 -0700
Message-ID: <efa9cdd0-4e5b-4b54-a4ea-7ec735224f44@linux.intel.com>
Date:   Tue, 24 Oct 2023 08:35:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 34/34] ASoC: usb: Rediscover USB SND devices on USB
 port add
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-35-quic_wcheng@quicinc.com>
 <b503058d-e23f-4a63-99b8-f0a62b2a2557@linux.intel.com>
 <6409c486-7393-4352-489c-ecd488597c4c@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <6409c486-7393-4352-489c-ecd488597c4c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 16:54, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 10/17/2023 4:11 PM, Pierre-Louis Bossart wrote:
>>
>>
>> On 10/17/23 15:01, Wesley Cheng wrote:
>>> In case the USB backend device has not been initialized/probed, USB SND
>>> device connections can still occur.  When the USB backend is eventually
>>> made available, previous USB SND device connections are not
>>> communicated to
>>> the USB backend.  Call snd_usb_rediscover_devices() to generate the
>>> connect
>>> callbacks for all USB SND devices connected.  This will allow for the
>>> USB
>>> backend to be updated with the current set of devices available.
>>>
>>> The chip array entries are all populated and removed while under the
>>> register_mutex, so going over potential race conditions:
>>>
>>> Thread#1:
>>>    q6usb_component_probe()
>>>      --> snd_soc_usb_add_port()
>>>        --> snd_usb_rediscover_devices()
>>>          --> mutex_lock(register_mutex)
>>>
>>> Thread#2
>>>    --> usb_audio_disconnect()
>>>      --> mutex_lock(register_mutex)
>>>
>>> So either thread#1 or thread#2 will complete first.  If
>>>
>>> Thread#1 completes before thread#2:
>>>    SOC USB will notify DPCM backend of the device connection.  Shortly
>>>    after, once thread#2 runs, we will get a disconnect event for the
>>>    connected device.
>>>
>>> Thread#2 completes before thread#1:
>>>    Then during snd_usb_rediscover_devices() it won't notify of any
>>>    connection for that particular chip index.
>> Looks like you are assuming the regular USB audio stuff is probed first?
>>
>> What if it's not the case? Have you tested with a manual 'blacklist' and
>> "modprobe" sequence long after all the DSP stuff is initialized?
>>
>> It really reminds me of audio+display issues, and the same opens apply
>> IMHO.
> 
> Not necessarily...if the USB audio driver is not probed, then that is
> the same scenario as when there is no USB audio capable device plugged
> in, while the offload path is waiting for the connect event. I think
> this is the standard scenario.
> 
> In the situation where the platform sound card hasn't probed yet and USB
> audio devices are being identified, then that is basically the scenario
> that would be more of an issue, since its USB SND that notifies of the
> connection state (at the time of connect/disconnect).

Not following if this scenario is covered?

> I've tried with building these drivers as modules and probing them at
> different times/sequences, and I haven't seen an issue so far.

The scenario I have in mind is this:

the platform driver is on the deny list, the USB driver detects a
device. When the platform driver probes at a later time (with a manual
modprobe to make delays really long), how would the notification be handled?

Between audio and display, we use the 'drm_audio_component' layer to
model these sort of run-time binding between independent driver stacks.
It's not used here but we need a moral equivalent, don't we?

It would really help if you documented a bit more the dependencies or
timing assumptions, to make sure we have a stable solution to build on.

