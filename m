Return-Path: <linux-kernel+bounces-5286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1538188FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672E22892E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D81A71B;
	Tue, 19 Dec 2023 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ksxw6xJy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BF1A72B;
	Tue, 19 Dec 2023 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8159FFA2;
	Tue, 19 Dec 2023 14:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702993823;
	bh=P3j9JwkXtYQBgLLVSB+qthoc/yBXQU2recEtcJpQJro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ksxw6xJyY35fqLEJJozH6rEH6EHjLDAOZQIIUcsaT2dWZAgDfftyiToQdUrAkoxIJ
	 JdzNIvesoxJFhiA6Vu4KcOSF4m2XAVCOOjDZaRHPCMzRgqrr4L/Pat0Splzm7EKEid
	 bkKu88q5+WZhJJAg1hSuh6NmfRxe34GuHjWAUy/U=
Message-ID: <60b3aec2-294f-4ab0-8a4b-0c32a52c84a0@ideasonboard.com>
Date: Tue, 19 Dec 2023 15:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: rkisp1: Fix IRQ handling due to shared
 interrupts
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Mikhail Rudenko <mike.rudenko@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>
References: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
 <20231218-rkisp-shirq-fix-v1-2-173007628248@ideasonboard.com>
 <20231218092240.GB26540@pendragon.ideasonboard.com>
 <b465355b-65c2-451f-ae2e-63da9d0a6282@ideasonboard.com>
 <20231219130849.GA29638@pendragon.ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20231219130849.GA29638@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2023 15:08, Laurent Pinchart wrote:
> Hi Tomi,
> 
> CC'ing Sakari
> 
> On Tue, Dec 19, 2023 at 10:50:05AM +0200, Tomi Valkeinen wrote:
>> On 18/12/2023 11:22, Laurent Pinchart wrote:
>>> On Mon, Dec 18, 2023 at 09:54:01AM +0200, Tomi Valkeinen wrote:
>>>> The driver requests the interrupts as IRQF_SHARED, so the interrupt
>>>> handlers can be called at any time. If such a call happens while the ISP
>>>> is powered down, the SoC will hang as the driver tries to access the
>>>> ISP registers.
>>>>
>>>> This can be reproduced even without the platform sharing the IRQ line:
>>>> Enable CONFIG_DEBUG_SHIRQ and unload the driver, and the board will
>>>> hang.
>>>>
>>>> Fix this by adding a new field, 'irqs_enabled', which is used to bail
>>>> out from the interrupt handler when the ISP is not operational.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>> ---
>>>>    .../platform/rockchip/rkisp1/rkisp1-capture.c      |  3 +++
>>>>    .../media/platform/rockchip/rkisp1/rkisp1-common.h |  2 ++
>>>>    .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  3 +++
>>>>    .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 22 ++++++++++++++++++++++
>>>>    .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  3 +++
>>>>    5 files changed, 33 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>>>> index aebd3c12020b..c381c22135a2 100644
>>>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>>>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>>>> @@ -725,6 +725,9 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
>>>>    	unsigned int i;
>>>>    	u32 status;
>>>>    
>>>> +	if (!rkisp1->irqs_enabled)
>>>> +		return IRQ_NONE;
>>>
>>> Given that this is something all drivers that use shared IRQs have to
>>> do, would it make sense to use a standard helper here, such as
>>> pm_runtime_suspended() for instance ? I haven't looked at which one
>>> would be the most appropriate (if any), there's also
>>> pm_runtime_active() and pm_runtime_status_suspended(). That would
>>> simplify this patch.
>>
>> I did consider that when writing the patch. But I just wasn't very
>> comfortable using the runtime PM here, even if it would make sense, as
>> I'm just not quite sure how it works.
>>
>> For example, pm_runtime_suspended() checks if the device is in
>> RPM_SUSPENDED state, and the device will be in RPM_SUSPENDED after the
>> driver's suspend callback has finished. This makes sense.
>>
>> However, _while_ suspending (not after we have suspended), we want to
>> make sure that 1) no new irq handling will start, 2) we'll wait until
>> any currently running irq handler has finished. For 1), we can't use
>> pm_runtime_suspended() in the irq handler, as the status is not
>> RPM_SUSPENDED. We could probably check for:
>>
>> spin_lock(&dev->power.lock);
>> off = dev->power.runtime_status == RPM_SUSPENDED ||
>> dev->power.runtime_status == RPM_SUSPENDING;
>> spin_unlock(&dev->power.lock);
>> if (off)
>> 	return IRQ_NONE;
>>
>> That would not work if we would depend on the irq handling while in the
>> suspend callback (e.g. waiting for an irq which signals that the device
>> has finished processing). But we don't do that at the moment, and that
>> kind of this probably can usually be done before calling runtime_put().
>>
>> When we take into account the resume part, I think we could just check
>> for RPM_ACTIVE in the irq handler, which would then rule out
>> RPM_RESUMING, RPM_SUSPENDED and RPM_SUSPENDING.
>>
>> But we can't use pm_runtime_active(), as that also checks for
>> dev->power.disable_depth. In other words, when we disable the PM for our
>> device (e.g. when unloading the driver), the PM framework says our
>> device became active.
>>
>> Soo... I think this should work in the irq handler:
>>
>> spin_lock(&dev->power.lock);
>> active = dev->power.runtime_status == RPM_ACTIVE;
> 
> It would be nice to use pm_runtime_active() instead. This would however
> require unregistering the IRQ handler before disabling runtime PM in the
> remove path. I think that should be done nonetheless though, as relying
> on devm to unregister the IRQ handler means it will happen after
> .remove() returns, which could cause all sort of issues (I'm thinking
> about the calls to dev_get_drvdata() in the IRQ handlers for instance).
> What do you think ?

I agree, devm with irqs sounds scary.

What I'd like to do is reserve an irq handler without activating it. 
That call could return an error, if, e.g. there's no such irq. Then 
later I would enable it (could be in the resume callback, but as well in 
the start-stream call), which would never return an error.

Having those both combined in a single call is not nice, as we have to 
deal with irq handler calls even when the driver knows it doesn't want them.

>> spin_unlock(&dev->power.lock);
>> if (!active)
>> 	return IRQ_NONE;
>>
>> I think the driver depends on runtime PM, but if no-PM was an option, I
>> guess we'd need to ifdef the above away, and trust that the device is
>> always powered on.
>>
>> So, as I said in the beginning, "I just wasn't very comfortable using
>> the runtime PM here". And that's still the case =). The runtime PM is
>> horribly complex. If you think the above is clearer, and you think it's
>> correct, I can make the change.
> 
> It sounds it may require some more work, and we should land this fix in
> v6.8, with the revert, right ? If so, I'm fine merging this patch, and
> moving to runtime PM checks on top if we decide to do so.

Yes. I think this fix should work as it is now. That said, I haven't 
heard anyone else reporting this issue, so maybe just applying the 
revert (to fix the driver) would be enough. And we could then figure out 
later how exactly to handle the shared interrupts.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> By the way, I wonder if it would make sense to handle this in the driver
> core. The prospect of copying this code in all drivers doesn't make me
> happy.

Indeed. But I wonder if it's always like this. E.g. a "wakeup" irq which 
is supposed to happen while the device is off.

  Tomi

>>>> +
>>>>    	status = rkisp1_read(rkisp1, RKISP1_CIF_MI_MIS);
>>>>    	if (!status)
>>>>    		return IRQ_NONE;
>>>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>>>> index 4b6b28c05b89..b757f75edecf 100644
>>>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>>>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>>>> @@ -450,6 +450,7 @@ struct rkisp1_debug {
>>>>     * @debug:	   debug params to be exposed on debugfs
>>>>     * @info:	   version-specific ISP information
>>>>     * @irqs:          IRQ line numbers
>>>> + * @irqs_enabled:  the hardware is enabled and can cause interrupts
>>>>     */
>>>>    struct rkisp1_device {
>>>>    	void __iomem *base_addr;
>>>> @@ -471,6 +472,7 @@ struct rkisp1_device {
>>>>    	struct rkisp1_debug debug;
>>>>    	const struct rkisp1_info *info;
>>>>    	int irqs[RKISP1_NUM_IRQS];
>>>> +	bool irqs_enabled;
>>>>    };
>>>>    
>>>>    /*
>>>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>>>> index b6e47e2f1b94..4202642e0523 100644
>>>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>>>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>>>> @@ -196,6 +196,9 @@ irqreturn_t rkisp1_csi_isr(int irq, void *ctx)
>>>>    	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>>>>    	u32 val, status;
>>>>    
>>>> +	if (!rkisp1->irqs_enabled)
>>>> +		return IRQ_NONE;
>>>> +
>>>>    	status = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_MIS);
>>>>    	if (!status)
>>>>    		return IRQ_NONE;
>>>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>>>> index acc559652d6e..73cf08a74011 100644
>>>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>>>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>>>> @@ -305,6 +305,24 @@ static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
>>>>    {
>>>>    	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>>>>    
>>>> +	rkisp1->irqs_enabled = false;
>>>> +	/* Make sure the IRQ handler will see the above */
>>>> +	mb();
>>>> +
>>>> +	/*
>>>> +	 * Wait until any running IRQ handler has returned. The IRQ handler
>>>> +	 * may get called even after this (as it's a shared interrupt line)
>>>> +	 * but the 'irqs_enabled' flag will make the handler return immediately.
>>>> +	 */
>>>> +	for (unsigned int il = 0; il < ARRAY_SIZE(rkisp1->irqs); ++il) {
>>>> +		if (rkisp1->irqs[il] == -1)
>>>> +			continue;
>>>> +
>>>> +		/* Skip if the irq line is the same as previous */
>>>> +		if (il == 0 || rkisp1->irqs[il - 1] != rkisp1->irqs[il])
>>>> +			synchronize_irq(rkisp1->irqs[il]);
>>>> +	}
>>>> +
>>>>    	clk_bulk_disable_unprepare(rkisp1->clk_size, rkisp1->clks);
>>>>    	return pinctrl_pm_select_sleep_state(dev);
>>>>    }
>>>> @@ -321,6 +339,10 @@ static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
>>>>    	if (ret)
>>>>    		return ret;
>>>>    
>>>> +	rkisp1->irqs_enabled = true;
>>>> +	/* Make sure the IRQ handler will see the above */
>>>> +	mb();
>>>> +
>>>>    	return 0;
>>>>    }
>>>>    
>>>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>>>> index f00873d31c42..78a1f7a1499b 100644
>>>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>>>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>>>> @@ -976,6 +976,9 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
>>>>    	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>>>>    	u32 status, isp_err;
>>>>    
>>>> +	if (!rkisp1->irqs_enabled)
>>>> +		return IRQ_NONE;
>>>> +
>>>>    	status = rkisp1_read(rkisp1, RKISP1_CIF_ISP_MIS);
>>>>    	if (!status)
>>>>    		return IRQ_NONE;
> 


