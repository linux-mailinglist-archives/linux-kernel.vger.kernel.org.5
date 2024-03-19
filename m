Return-Path: <linux-kernel+bounces-107991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDB880491
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F7EB21CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765E2C6AE;
	Tue, 19 Mar 2024 18:17:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A32C1A3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872268; cv=none; b=KXEiwcUXP9tIQOASaJB2Wv9uorSoMbnzkxoDgdRriVyoxZE3oaAxRJUdlmPwQTr2uyAs5FlqRwSXGzCVbmB9U8vcXY6sAt9Mgp+2rsYuzuQ/kwMZP52FQxB2YkEUeMBF+fF0hUxuHINoHrhFEm6OKcwW8S6eD/+gCS3zDMl/66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872268; c=relaxed/simple;
	bh=qHiCOZKBl6VYyjvsKXgMP7a6++xi2HpoY3Dnk3++uP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jANKWF6/5wk/k4p7cfi4Gx7OSixjnCxbNIZUzka5hr1yx1WFvTDtLXrtffN7kvT25U8f+J4Y+VUHTS+/51HYy0MjUx8LGKpjw4AW1zT8sYcWhiKxhMJ+46KjuecWT+CzWrsOpYL3+VRcWlaEnUe/3CBbFhuZg2cTbmAIUwcVytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE785106F;
	Tue, 19 Mar 2024 11:18:17 -0700 (PDT)
Received: from [10.57.52.192] (unknown [10.57.52.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E5063F762;
	Tue, 19 Mar 2024 11:17:40 -0700 (PDT)
Message-ID: <5b19ab13-a7a0-48e2-99a4-357a9f4aeafa@arm.com>
Date: Tue, 19 Mar 2024 18:17:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Tyler Hicks <code@tyhicks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <ZfKsAIt8RY/JcL/V@sequoia> <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240319154756.GB2901@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-19 3:47 pm, Will Deacon wrote:
> On Tue, Mar 19, 2024 at 12:57:52PM +0000, Robin Murphy wrote:
>> On 2024-03-14 7:06 pm, Tyler Hicks wrote:
>>> On 2024-03-14 09:55:46, Tyler Hicks wrote:
>>>> Given that drivers are only optionally asked to implement the .shutdown
>>>> hook, which is required to properly quiesce devices before a kexec, why
>>>> is it that we put the ARM SMMU v1/v2 into bypass mode in the arm-smmu
>>>> driver's own .shutdown hook?
>>>>
>>>>    arm_smmu_device_shutdown() -> set SMMU_sCR0.CLIENTPD bit to 1
>>>>
>>>> Driver authors often forget to even implement a .shutdown hook, which
>>>> results in some hard-to-debug memory corruption issues in the kexec'ed
>>>> target kernel due to pending DMA operations happening on untranslated
>>>> addresses. Why not leave the SMMU in translate mode but clear the stream
>>>> mapping table (or maybe even call arm_smmu_device_reset()) in the SMMU's
>>>> .shutdown hook to prevent the memory corruption from happening in the
>>>> first place?
>>>>
>>>> Fully acknowledging that the proper fix is to quiesce the devices, I
>>>> feel like resetting the SMMU and leaving it in translate mode across
>>>> kexec would be more consistent with the intent behind v5.2 commit
>>>> 954a03be033c ("iommu/arm-smmu: Break insecure users by disabling bypass
>>>> by default"). The incoming transactions of devices, that weren't
>>>> properly quiesced during a kexec, would be blocked until their drivers
>>>> have a chance to reinitialize the devices in the new kernel.
>>>>
>>>> I appreciate any help understanding why bypass mode is utilized here as
>>>> I'm sure there are nuances that I haven't considered. Thank you!
>>>
>>> I now see that Will has previously mentioned that he'd be open to such a
>>> change:
>>>
>>>    One thing I would be in favour of is changing the ->shutdown() code to
>>>    honour disable_bypass=1 so that we put the SMMU in an aborting state
>>>    instead of passthrough. Would that help at all? It would at least
>>>    avoid the memory corruption on missing shutdown callback.
>>>
>>>    - https://lore.kernel.org/linux-arm-kernel/20200608113852.GA3108@willie-the-truck/
>>>
>>> Robin mentions the need to support kexec into a non-SMMU-aware OS. I
>>> hadn't considered that bit of complexity:
>>>
>>>    ... consider if the first kernel *did* leave it enabled with whatever
>>>    left-over translations in place, and kexec'ed into another OS that
>>>    wasn't SMMU-aware...
>>>
>>>    - https://lore.kernel.org/linux-arm-kernel/e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com/
>>>
>>> Now that we're 3-4 years removed from that conversation, has anything
>>> changed? Will, is there anything we'd need to watch out for if we were
>>> to prototype this sort of change? For example, would it be wise to
>>> disable fault interrupts when putting the SMMU in an aborting state
>>> before kexec'ing?
> 
> I've grown older and wiser in those four years and no longer think that's
> a good idea :) Well, older maybe, but the reality is that the code around
> the driver has evolved and 'disable_bypass' is even more of a hack now
> than it used to be.
> 
>> Fundamentally, we expect the SMMU to be disabled at initial boot, so per the
>> intent of kexec we put it back in that state. That also seems the most
>> likely expectation of anything we could kexec into, given that it is the
>> natural state of an untouched SMMU after a hard reset, and thus comes out as
>> the least-worst option.
> 
> Heh, that sounded too good to be true when I read it so I went and looked at
> the code:
> 
> SMMUv3: arm_smmu_device_shutdown() -> clears CR0 but doesn't touch GBPA
> SMMUv2: arm_smmu_device_shutdown() -> writes CLIENTPD to CR0
> 
> So it's a bit of a muddle afaict; SMMUv2 explicitly goes into bypass
> whereas SMMUv3 probably does honour disable_bypass=false! Did I miss
> something?

I think so, namely the utter madness around how and when we do actually 
touch GBPA - if we found SMMUEN set at the start of probe, then we set 
GBPA to abort before initially clearing SMMUEN; if the DT is broken then 
we set GBPA to bypass instead of enabling SMMUEN at the end of probe, 
*unless* disable_bypass was set. Thus by the time we get to shutdown, 
SMMUEN may or may not already be 0 and GPBA may or may not have been 
changed from its initial value to either one of bypass or abort.

> As discussed elsewhere, if we remove disable_bypass from SMMUv3, then
> we should be able to be consistent here. The question is, what's the
> right behaviour?

"Not that", at the very least ;)

In terms of the shutdown behaviour, I think it actually works out as-is. 
For the normal case we haven't touched GBPA, so we are truly returning 
to the boot-time condition; in the unexpected case where SMMUEN was 
already enabled then we'll go into an explicit GPBA abort state, but 
that seems a not-unreasonable compromise for not preserving the entire 
boot-time Stream Table etc., whose presence kind of implies it wouldn't 
have been bypassing everything anyway.

The more I look at the remaining aspect of disable_bypass for 
controlling broken-DT behaviour the more I suspect it can't actually be 
useful either way, especially not since default domains. I have no 
memory of what my original reasoning might have been, so I'm inclined to 
just rip that all out and let probe fail. I see no reason these days not 
to expect a broken DT to leads to a broken system, especially not now 
with DTSchema validation.

Then there's just the kdump warning it suppresses, of which I also have 
no idea why it's there either, but apparently that one's on you :P

Cheers,
Robin.

