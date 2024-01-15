Return-Path: <linux-kernel+bounces-26067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8582DAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C91F21967
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FD17596;
	Mon, 15 Jan 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJu7BBnO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBED17583;
	Mon, 15 Jan 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705327221; x=1736863221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n/RLhgyGoa+DPRyRCqq45dasWWYKEjc9SvpU3zeNWxA=;
  b=DJu7BBnOuNj/SImDyBXORRaeLfB5ec7RkBklriuacBBKeIivqpouC2Fd
   oArlJNI5YQxFshQTZxWRXd/ljUWeir9uGZTbJjI+Gbs/JZBDgH8YZM2OR
   pNEBuBxGbV6rOzHg53Cm14Xkkp+E8f+NZtnicRiyahA/WHxeg6OmzgenN
   6GKm1S19K0gvoVPqClRb2ZVT08D4hHMAXtD+CnxTQGff+90WqtVC+rYr8
   4OoM/+p+IPbnkHVdF3iF7LVsuvglH+PVfmKmjQCPDXjpMKMCj7/biUYoK
   ZkB54Fm/Y0WfOxuC/6vC8N19RV0Ku8OmTZc5kKks0dxYzBDPwRMlcBhrZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="463900313"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="463900313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 06:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="733312147"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="733312147"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 06:00:14 -0800
Message-ID: <2178e799-2068-7443-59b2-310dfdd1ddee@linux.intel.com>
Date: Mon, 15 Jan 2024 16:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v12 04/41] usb: host: xhci-mem: Cleanup pending secondary
 event ring events
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
 alsa-devel@alsa-project.org
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240102214549.22498-5-quic_wcheng@quicinc.com>
 <734591a1-50b4-6dc7-0b93-077355ec12e4@linux.intel.com>
 <7b2ec96b-b72f-c848-7c35-36e61a4072ac@quicinc.com>
 <b254f73b-a1bc-3dd4-f485-a3acf556835d@quicinc.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <b254f73b-a1bc-3dd4-f485-a3acf556835d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.1.2024 1.42, Wesley Cheng wrote:
> Hi Mathias,
> 
> On 1/8/2024 12:51 PM, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 1/4/2024 6:48 AM, Mathias Nyman wrote:
>>> On 2.1.2024 23.45, Wesley Cheng wrote:
>>>> As part of xHCI bus suspend, the XHCI is halted.  However, if there are
>>>> pending events in the secondary event ring, it is observed that the xHCI
>>>> controller stops responding to further commands upon host or device
>>>> initiated bus resume.  Iterate through all pending events and update the
>>>> dequeue pointer to the beginning of the event ring.
>>>>
>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ...
>>>> +/*
>>>> + * Move the event ring dequeue pointer to skip events kept in the secondary
>>>> + * event ring.  This is used to ensure that pending events in the ring are
>>>> + * acknowledged, so the XHCI HCD can properly enter suspend/resume. The
>>>> + * secondary ring is typically maintained by an external component.
>>>> + */
>>>> +void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
>>>> +    struct xhci_ring *ring,    struct xhci_interrupter *ir)
>>>> +{
>>>> +    union xhci_trb *erdp_trb, *current_trb;
>>>> +    u64 erdp_reg;
>>>> +    u32 iman_reg;
>>>> +    dma_addr_t deq;
>>>> +
>>>> +    /* disable irq, ack pending interrupt and ack all pending events */
>>>> +    xhci_disable_interrupter(ir);
>>>> +    iman_reg = readl_relaxed(&ir->ir_set->irq_pending);
>>>> +    if (iman_reg & IMAN_IP)
>>>> +        writel_relaxed(iman_reg, &ir->ir_set->irq_pending);
>>>> +
>>>> +    /* last acked event trb is in erdp reg  */
>>>> +    erdp_reg = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
>>>> +    deq = (dma_addr_t)(erdp_reg & ERST_PTR_MASK);
>>>> +    if (!deq) {
>>>> +        xhci_err(xhci, "event ring handling not required\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    erdp_trb = current_trb = ir->event_ring->dequeue;
>>>> +    /* read cycle state of the last acked trb to find out CCS */
>>>> +    ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE;
>>>> +
>>>> +    while (1) {
>>>> +        inc_deq(xhci, ir->event_ring);
>>>> +        erdp_trb = ir->event_ring->dequeue;
>>>> +        /* cycle state transition */
>>>> +        if ((le32_to_cpu(erdp_trb->event_cmd.flags) & TRB_CYCLE) !=
>>>> +            ring->cycle_state)
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    xhci_update_erst_dequeue(xhci, ir, current_trb, true);
>>>> +}
>>>
>>> Code above is very similar to the existing event ring processing parts of xhci_irq()
>>> and xhci_handle_event()
>>>
>>> I'll see if I can refactor the existing event ring processing, decouple it from
>>> event handling so that it could be used by primary and secondary interrupters with
>>> handlers, and this case where we just want to clear the event ring.
>>>
>>
>> Thanks, that makes sense.  Will take a look as well.
>>
> 
> How about something like the below?  Tested this on my set up and everything looks to be working fine.  Had to add another param to struct xhci_interrupters to tell the XHCI interrupt handler to say if that particular interrupter wants to skip_events (handling).  This way, its something that the class driver utilizing the interrupter will have to tell XHCI sideband.  It would allow the user to determine if they want to use the interrupter to actually handle events or not on the proc running Linux.
> 

Yes, I have something similar.
I'll share it soon, just need to
clean it up a bit fist.

Thanks
Mathias


