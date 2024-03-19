Return-Path: <linux-kernel+bounces-107543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD887FDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E1328280E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076F3FB89;
	Tue, 19 Mar 2024 12:57:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4763D988
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853079; cv=none; b=fLjMhzJ/M75XiwBx+at5VAJ2eVKp1d65FmnmbQPS+S0Mgr7E/Ci5SySMz9pMGM3KGit0uuxjmZxLtC4VgQZbx96n6JGRYZHuw5f3UiWXdAVxdFUDahE5YaGHSYcQkqV69mWBH6v7UWS71p7xK4p6+8Y+aex1MgL4aA95yd/5AGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853079; c=relaxed/simple;
	bh=gPy0dzKldnkL8GYlabeRrMPsaq+rydPOynPMmkrLYYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6dz5igc8H9luNECvupDp8qVwO5bVDoxBdiKnDFDB5vwt3v0ZflLYQkEuWCL3r+ga7xIerQBkoctyxWi0F3ST4DHshaJEHL3TXcTANm6Zteia3/G0ONDWQEhDcGRPsaFU3SCzxARlCiCtQ/WVB+diMc744zVM6aSRn52t9lHlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9284E106F;
	Tue, 19 Mar 2024 05:58:31 -0700 (PDT)
Received: from [10.57.52.192] (unknown [10.57.52.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1C43F762;
	Tue, 19 Mar 2024 05:57:55 -0700 (PDT)
Message-ID: <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
Date: Tue, 19 Mar 2024 12:57:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Content-Language: en-GB
To: Tyler Hicks <code@tyhicks.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <ZfKsAIt8RY/JcL/V@sequoia> <ZfNKv70oqqwMwIeS@sequoia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZfNKv70oqqwMwIeS@sequoia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-14 7:06 pm, Tyler Hicks wrote:
> On 2024-03-14 09:55:46, Tyler Hicks wrote:
>> Given that drivers are only optionally asked to implement the .shutdown
>> hook, which is required to properly quiesce devices before a kexec, why
>> is it that we put the ARM SMMU v1/v2 into bypass mode in the arm-smmu
>> driver's own .shutdown hook?
>>
>>   arm_smmu_device_shutdown() -> set SMMU_sCR0.CLIENTPD bit to 1
>>
>> Driver authors often forget to even implement a .shutdown hook, which
>> results in some hard-to-debug memory corruption issues in the kexec'ed
>> target kernel due to pending DMA operations happening on untranslated
>> addresses. Why not leave the SMMU in translate mode but clear the stream
>> mapping table (or maybe even call arm_smmu_device_reset()) in the SMMU's
>> .shutdown hook to prevent the memory corruption from happening in the
>> first place?
>>
>> Fully acknowledging that the proper fix is to quiesce the devices, I
>> feel like resetting the SMMU and leaving it in translate mode across
>> kexec would be more consistent with the intent behind v5.2 commit
>> 954a03be033c ("iommu/arm-smmu: Break insecure users by disabling bypass
>> by default"). The incoming transactions of devices, that weren't
>> properly quiesced during a kexec, would be blocked until their drivers
>> have a chance to reinitialize the devices in the new kernel.
>>
>> I appreciate any help understanding why bypass mode is utilized here as
>> I'm sure there are nuances that I haven't considered. Thank you!
> 
> I now see that Will has previously mentioned that he'd be open to such a
> change:
> 
>   One thing I would be in favour of is changing the ->shutdown() code to
>   honour disable_bypass=1 so that we put the SMMU in an aborting state
>   instead of passthrough. Would that help at all? It would at least
>   avoid the memory corruption on missing shutdown callback.
> 
>   - https://lore.kernel.org/linux-arm-kernel/20200608113852.GA3108@willie-the-truck/
> 
> Robin mentions the need to support kexec into a non-SMMU-aware OS. I
> hadn't considered that bit of complexity:
> 
>   ... consider if the first kernel *did* leave it enabled with whatever
>   left-over translations in place, and kexec'ed into another OS that
>   wasn't SMMU-aware...
> 
>   - https://lore.kernel.org/linux-arm-kernel/e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com/
> 
> Now that we're 3-4 years removed from that conversation, has anything
> changed? Will, is there anything we'd need to watch out for if we were
> to prototype this sort of change? For example, would it be wise to
> disable fault interrupts when putting the SMMU in an aborting state
> before kexec'ing?

Fundamentally, we expect the SMMU to be disabled at initial boot, so per 
the intent of kexec we put it back in that state. That also seems the 
most likely expectation of anything we could kexec into, given that it 
is the natural state of an untouched SMMU after a hard reset, and thus 
comes out as the least-worst option.

Beyond properly quiescing and resetting the system back to a boot-time 
state, the outgoing kernel in a kexec can only really do things which 
affect itself. Sure, we *could* configure the SMMU to block all traffic 
and disable the interrupt to avoid getting stuck in a storm of faults on 
the way out, but what does that mean for the incoming kexec payload? 
That it can have the pleasure of discovering the SMMU, innocently 
enabling the interrupt and getting stuck in an unexpected storm of 
faults. Or perhaps just resetting the SMMU into a disabled state and 
thus still unwittingly allowing its memory to be corrupted by the 
previous kernel not supporting kexec properly.

So no, I would not say that anything has changed here, at least not in 
favour of this idea. If anything, it's become even more impractical now 
that we have RMRs to properly support cases like an EFI framebuffer 
where neither the outgoing nor incoming kernels necessarily have the 
ability to quiesce the underlying DMA or recover it from faults, thus we 
have to be even more careful.

Thanks,
Robin.

