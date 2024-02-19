Return-Path: <linux-kernel+bounces-71122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC15185A0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215A81F24C70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346BE28DB3;
	Mon, 19 Feb 2024 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yn+43PJe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A02869B;
	Mon, 19 Feb 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338348; cv=none; b=f/mnWrUkrNhWNkpDZ9En4FxKWPPGPF+fhBvv80Q5z098ZpLUXaLB3idiGXYjWVDvxFgSTeL0hrvjkbQvW5YqmYcJ0G4BCnuSkHx8dlMcjhMiFlJ8YKbgHPYBUAUBPlvXJNFJcfTk+iCHCeOUu1WrAuVLODJo24hM90afJqRU684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338348; c=relaxed/simple;
	bh=zL0WFip43RAITgM1V6q1+wudKv7V+38SkMTzwZ7HDTk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=c2AViekk+8UtB+O2eqwjwjdk49mxIwGL9Z+CKGxD+rZvascBUqt8DLtI6s9dNR81RbqVoAbHBYiAVjdFACo7WzznYRoZfe49NRHeJLjgLZ8LIB1S+H3V5GpK6VZnRjZ9kEON2jNkt2H6IGvowM9cxpO9/aOrJR3vbRu71Yv/y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yn+43PJe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708338347; x=1739874347;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=zL0WFip43RAITgM1V6q1+wudKv7V+38SkMTzwZ7HDTk=;
  b=Yn+43PJeq5Nu5diaJJJAnBRqIF77Am9OPQ6T1pCtbTKPpYiorJW0pTSL
   RjYGNQ+yQIsFhXpXMl3/6vMx7BYwX4sn1v4sRQPZNzkFAWYqmofA0Q6Cq
   zvT5uIXcnH2o4M3CJvyaGAWctnzKoxG2I391d8p4oKNz3cAiVqCyZHmeP
   m2sRxnERfUn2RqkNXAKkRPQYq+aYsxz6LGHeWhkCzuXVAS76nSvhPREYy
   YFn/yqiKJJATJP6GX6wUGmyLm4FAo1+IHEylWrcA+8ViSfNnO2+P830Ss
   gO810QFnk7Zyay0yjiGxeEAf3svMxeUvJfN96MPt3LdCOwjcuXr7xsbkY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13807123"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13807123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="936271047"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936271047"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 02:25:39 -0800
Message-ID: <96ab6033-2cb9-daa7-ddad-090138896739@linux.intel.com>
Date: Mon, 19 Feb 2024 12:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
 conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com,
 andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 Thinh.Nguyen@synopsys.com, broonie@kernel.org, bgoswami@quicinc.com,
 tiwai@suse.com, robh+dt@kernel.org, konrad.dybcio@linaro.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <2024021754-unengaged-saggy-6ab1@gregkh>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v17 00/51] Introduce QC USB SND audio offloading support
In-Reply-To: <2024021754-unengaged-saggy-6ab1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.2.2024 17.25, Greg KH wrote:
> On Fri, Feb 16, 2024 at 04:09:26PM -0800, Wesley Cheng wrote:
>> Several Qualcomm based chipsets can support USB audio offloading to a
>> dedicated audio DSP, which can take over issuing transfers to the USB
>> host controller.  The intention is to reduce the load on the main
>> processors in the SoC, and allow them to be placed into lower power modes.
>> There are several parts to this design:
>>    1. Adding ASoC binding layer
>>    2. Create a USB backend for Q6DSP
>>    3. Introduce XHCI interrupter support
>>    4. Create vendor ops for the USB SND driver
>>
>>        USB                          |            ASoC
>> --------------------------------------------------------------------
>>                                     |  _________________________
>>                                     | |sm8250 platform card     |
>>                                     | |_________________________|
>>                                     |         |           |
>>                                     |      ___V____   ____V____
>>                                     |     |Q6USB   | |Q6AFE    |
>>                                     |     |"codec" | |"cpu"    |
>>                                     |     |________| |_________|
>>                                     |         ^  ^        ^
>>                                     |         |  |________|
>>                                     |      ___V____    |
>>                                     |     |SOC-USB |   |
>>     ________       ________               |        |   |
>>    |USB SND |<--->|QC offld|<------------>|________|   |
>>    |(card.c)|     |        |<----------                |
>>    |________|     |________|___     | |                |
>>        ^               ^       |    | |    ____________V_________
>>        |               |       |    | |   |APR/GLINK             |
>>     __ V_______________V_____  |    | |   |______________________|
>>    |USB SND (endpoint.c)     | |    | |              ^
>>    |_________________________| |    | |              |
>>                ^               |    | |   ___________V___________
>>                |               |    | |->|audio DSP              |
>>     ___________V_____________  |    |    |_______________________|
>>    |XHCI HCD                 |<-    |
>>    |_________________________|      |
>>
>>
>> Adding ASoC binding layer:
>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>> The port is always present on the device, but cable/pin status can be
>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>> communicate with USB SND.
>>
>> Create a USB backend for Q6DSP:
>> q6usb: Basic backend driver that will be responsible for maintaining the
>> resources needed to initiate a playback stream using the Q6DSP.  Will
>> be the entity that checks to make sure the connected USB audio device
>> supports the requested PCM format.  If it does not, the PCM open call will
>> fail, and userpsace ALSA can take action accordingly.
>>
>> Introduce XHCI interrupter support:
>> XHCI HCD supports multiple interrupters, which allows for events to be routed
>> to different event rings.  This is determined by "Interrupter Target" field
>> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
>>
>> Events in the offloading case will be routed to an event ring that is assigned
>> to the audio DSP.
>>
>> Create vendor ops for the USB SND driver:
>> qc_audio_offload: This particular driver has several components associated
>> with it:
>> - QMI stream request handler
>> - XHCI interrupter and resource management
>> - audio DSP memory management
>>
>> When the audio DSP wants to enable a playback stream, the request is first
>> received by the ASoC platform sound card.  Depending on the selected route,
>> ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
>> will send an AFE port start command (with enabling the USB playback path), and
>> the audio DSP will handle the request accordingly.
>>
>> Part of the AFE USB port start handling will have an exchange of control
>> messages using the QMI protocol.  The qc_audio_offload driver will populate the
>> buffer information:
>> - Event ring base address
>> - EP transfer ring base address
>>
>> and pass it along to the audio DSP.  All endpoint management will now be handed
>> over to the DSP, and the main processor is not involved in transfers.
>>
>> Overall, implementing this feature will still expose separate sound card and PCM
>> devices for both the platorm card and USB audio device:
>>   0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>                        SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>   1 [Audio          ]: USB-Audio - USB Audio
>>                        Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed
>>
>> This is to ensure that userspace ALSA entities can decide which route to take
>> when executing the audio playback.  In the above, if card#1 is selected, then
>> USB audio data will take the legacy path over the USB PCM drivers, etc...
>>
>> This feature was validated using:
>> - tinymix: set/enable the multimedia path to route to USB backend
>> - tinyplay: issue playback on platform card
> 
> I've applied patches 1-10 and the 2 dts changes here, as those all had
> acks from the relevant maintainers already.
> 

Patch 10/10 is based on an old POC patch by me, but it's heavily modified.

It looks like it does a few minor things that are not optimal, like extra
spinlock/unlock, and wait_for_completion_timeout() with magical timeout value.
  
I haven't tested this version, but I guess any fixes or cleanups can be done
later on top of it.

Thanks
Mathias


