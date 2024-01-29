Return-Path: <linux-kernel+bounces-43026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736AF840A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB7A1F2716D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD3155A28;
	Mon, 29 Jan 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6BQG4Rw"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07D154C07;
	Mon, 29 Jan 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543019; cv=none; b=hyraUHWUxhktfGnycxuRz4DV1wOFC/ktVhEKTtMAExRhG7VqP+CIYZBOXE7hKAkMsVanxbi+VX3O9+Gkp5tGy4wfFpSi+b4VHvlhTXvkgiM8vjCPDYixfXOA4fzEKfLAEXdk0B0PP0YP77nkTq3+YPnn0HyVv+TE6rQYnV0zj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543019; c=relaxed/simple;
	bh=n8a6DcN34MCg2EL+T3oLmFAy3UeopUFYPMC/oHMiox8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=tJQHLkf0+wz6VVFlXlwMntx6130f1IylE8swOY1yh5kUjQiTAH5pk/o3F80r8qt6406yDLk9jQx2gxyCYoo3SApbE3hyyDk7aPIkspzldu1cJYAo//O+WsWFrnf4VceKLfFWd03AUnZ9EIfENrGaAnhXrptPdnWzyaOnCuHsmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6BQG4Rw; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706543016; x=1738079016;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=n8a6DcN34MCg2EL+T3oLmFAy3UeopUFYPMC/oHMiox8=;
  b=A6BQG4RwneBFN8Q4gWtiXBLKGTsuaebuepLrO3TglQ93JZ3mevmg9oRm
   EmgU5AwqtyssKKIAXrEnmIio4ghC5e0mXkmJ4YzujE5ba2Q+VCBLJSvZF
   iFryVKhwFL1kI+5LXp5HwJKPTQfMNtPmku4NTHlr5Ups+6oSNmw34JnUM
   W8yNIZvOVq5I7kjyOA/tVr8lsU/9lMPF06KTYAeHc5cFTB8Mlt3bPwr4l
   yUJf7JAHD0G+CB+fm1zd+U6/QRVOUEf6AmsLb9Mn9unh8datVb41pH7tI
   FrfDoUu/EgyH9tjl/YL+sCIQWKnlgneyF5dCUULtRK1A1YSfgMOdfGxeU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434159615"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="434159615"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 07:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="960921358"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="960921358"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2024 07:43:25 -0800
Message-ID: <44a3d4db-7759-dd93-782a-1efbebfdb22c@linux.intel.com>
Date: Mon, 29 Jan 2024 17:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
 mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
 corbet@lwn.net, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
 andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 konrad.dybcio@linaro.org, Thinh.Nguyen@synopsys.com, broonie@kernel.org,
 bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org, agross@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
 alsa-devel@alsa-project.org, "Neronin, Niklas" <niklas.neronin@intel.com>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240102214549.22498-5-quic_wcheng@quicinc.com>
 <734591a1-50b4-6dc7-0b93-077355ec12e4@linux.intel.com>
 <7b2ec96b-b72f-c848-7c35-36e61a4072ac@quicinc.com>
 <b254f73b-a1bc-3dd4-f485-a3acf556835d@quicinc.com>
 <2178e799-2068-7443-59b2-310dfdd1ddee@linux.intel.com>
 <ae64ce69-dc1b-1534-7950-0a35c4a56f58@quicinc.com>
 <ff0bff8b-f26a-87bd-9762-9f2af98abcca@quicinc.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v12 04/41] usb: host: xhci-mem: Cleanup pending secondary
 event ring events
In-Reply-To: <ff0bff8b-f26a-87bd-9762-9f2af98abcca@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.1.2024 23.13, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 1/16/2024 12:24 PM, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 1/15/2024 6:01 AM, Mathias Nyman wrote:
>>> On 10.1.2024 1.42, Wesley Cheng wrote:
>>>> Hi Mathias,
>>>>
>>>> On 1/8/2024 12:51 PM, Wesley Cheng wrote:
>>>>> Hi Mathias,
>>>>>
>>>>> On 1/4/2024 6:48 AM, Mathias Nyman wrote:
>>>>>> On 2.1.2024 23.45, Wesley Cheng wrote:
>>>>>>> As part of xHCI bus suspend, the XHCI is halted.  However, if there are
>>>>>>> pending events in the secondary event ring, it is observed that the xHCI
>>>>>>> controller stops responding to further commands upon host or device
>>>>>>> initiated bus resume.  Iterate through all pending events and update the
>>>>>>> dequeue pointer to the beginning of the event ring.
>>>>>>>
>>>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>>> ...
>>>>>>> +/*
>>>>>>> + * Move the event ring dequeue pointer to skip events kept in the secondary
>>>>>>> + * event ring.  This is used to ensure that pending events in the ring are
>>>>>>> + * acknowledged, so the XHCI HCD can properly enter suspend/resume. The
>>>>>>> + * secondary ring is typically maintained by an external component.
>>>>>>> + */
>>>>>>> +void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
>>>>>>> +    struct xhci_ring *ring,    struct xhci_interrupter *ir)
>>>>>>> +{
>>>>>>> +    union xhci_trb *erdp_trb, *current_trb;
>>>>>>> +    u64 erdp_reg;
>>>>>>> +    u32 iman_reg;
>>>>>>> +    dma_addr_t deq;
>>>>>>> +
>>>>>>> +    /* disable irq, ack pending interrupt and ack all pending events */
>>>>>>> +    xhci_disable_interrupter(ir);
>>>>>>> +    iman_reg = readl_relaxed(&ir->ir_set->irq_pending);
>>>>>>> +    if (iman_reg & IMAN_IP)
>>>>>>> +        writel_relaxed(iman_reg, &ir->ir_set->irq_pending);
>>>>>>> +
>>>>>>> +    /* last acked event trb is in erdp reg  */
>>>>>>> +    erdp_reg = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
>>>>>>> +    deq = (dma_addr_t)(erdp_reg & ERST_PTR_MASK);
>>>>>>> +    if (!deq) {
>>>>>>> +        xhci_err(xhci, "event ring handling not required\n");
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    erdp_trb = current_trb = ir->event_ring->dequeue;
>>>>>>> +    /* read cycle state of the last acked trb to find out CCS */
>>>>>>> +    ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE;
>>>>>>> +
>>>>>>> +    while (1) {
>>>>>>> +        inc_deq(xhci, ir->event_ring);
>>>>>>> +        erdp_trb = ir->event_ring->dequeue;
>>>>>>> +        /* cycle state transition */
>>>>>>> +        if ((le32_to_cpu(erdp_trb->event_cmd.flags) & TRB_CYCLE) !=
>>>>>>> +            ring->cycle_state)
>>>>>>> +            break;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    xhci_update_erst_dequeue(xhci, ir, current_trb, true);
>>>>>>> +}
>>>>>>
>>>>>> Code above is very similar to the existing event ring processing parts of xhci_irq()
>>>>>> and xhci_handle_event()
>>>>>>
>>>>>> I'll see if I can refactor the existing event ring processing, decouple it from
>>>>>> event handling so that it could be used by primary and secondary interrupters with
>>>>>> handlers, and this case where we just want to clear the event ring.
>>>>>>
>>>>>
>>>>> Thanks, that makes sense.  Will take a look as well.
>>>>>
>>>>
>>>> How about something like the below?  Tested this on my set up and everything looks to be working fine.  Had to add another param to struct xhci_interrupters to tell the XHCI interrupt handler to say if that particular interrupter wants to skip_events (handling).  This way, its something that the class driver utilizing the interrupter will have to tell XHCI sideband.  It would allow the user to determine if they want to use the interrupter to actually handle events or not on the proc running Linux.
>>>>
>>>
>>> Yes, I have something similar.
>>> I'll share it soon, just need to
>>> clean it up a bit fist.
>>>
>>
>> Sure, no worries.  Will test it when its available.  Thanks!
>>
> 
> Was just wondering if you had the time to clean up the changes?  If not, maybe you can provide a patch with whatever you have, and I can try my best to clean it up to your liking?  Thanks!

Sure, got stuck fixing other issues.

Code is not yet cleaned up, commit messages are not ready etc, but current work is in
a fix_eventhandling branch:

git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git  fix_eventhandling
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=fix_eventhandling

I was in the middle of figuring out when and where the ip_autoclear and interrupt
moderation values should be set for secondary interrupters

Thanks
Mathias


