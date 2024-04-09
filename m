Return-Path: <linux-kernel+bounces-136894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FD189D978
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9828BB5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FE12DDAD;
	Tue,  9 Apr 2024 12:53:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD6384
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667229; cv=none; b=Zyw2iY10k3k8dU8DlP+oyfeGSrMvHWwrLRskc+to/66mH50sVFDc4/w6NAXtqBVvjIJ+zl4XyB38Wkk8DtlIz8by9nYad98NJakqEjBuSc+ClNe3PyX1rJp1dkh8y99MTGXFrNscGxA+lg9mtF7u5F5hOBIRoci8W5v5CsLWgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667229; c=relaxed/simple;
	bh=9aeQ+agCGwtYdf3BbxbVPlScwQwTRPj98UxQNe7am5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0hThAF1CeqAh2Wg9SLg9Ol5x/TXJEjXowtPeXOOecPvZfJcXKyh6LG6judpcN2TFzs3jK5RaDdMs+FHfrBU/m26gRObc01Y2BpldYu2zFMaNrj0xBHhlface3DwghjjviwUBNUTlIu8GC2IfOOJNDpr8CuYsU/bLeILcNJ8R7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3035139F;
	Tue,  9 Apr 2024 05:54:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4F23F766;
	Tue,  9 Apr 2024 05:53:46 -0700 (PDT)
Message-ID: <726d6946-6fc8-4c53-86ad-385ab24fa4c7@arm.com>
Date: Tue, 9 Apr 2024 13:53:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no
 interrupt was assigned
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240307193104.58302-1-ilkka@os.amperecomputing.com>
 <042bbb32-481e-40d8-a46a-472b724ec33f@arm.com>
 <89d7ff41-ce2a-fd95-ebfc-4df914efd4c8@os.amperecomputing.com>
 <c2e3e77c-ba50-4228-9eb8-c8fbcc84edfb@arm.com>
 <8fdfceb2-90b3-a1a9-fa88-a45ece30c0bb@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <8fdfceb2-90b3-a1a9-fa88-a45ece30c0bb@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2024 2:05 am, Ilkka Koskinen wrote:
> 
> On Mon, 8 Apr 2024, Robin Murphy wrote:
>> On 2024-04-05 11:33 pm, Ilkka Koskinen wrote:
>>>
>>> On Fri, 5 Apr 2024, Robin Murphy wrote:
>>>> On 2024-03-07 7:31 pm, Ilkka Koskinen wrote:
>>>>> The driver enabled and disabled interrupts even if no interrupt was
>>>>> assigned to the device.
>>>>
>>>> Why's that a concern - if the interrupt isn't routed anywhere, 
>>>> surely it makes no difference what happens at the source end?
>>>
>>> The issue is that we have two PMUs attached to the same interrupt line.
>>> Unfortunately, I just don't seem to find time to add support for 
>>> shared interrupts to the cspmu driver. Meanwhile, I assigned the 
>>> interrupt to one of the PMUs while the other one has zero in the APMT 
>>> table.
>>
>> I suspected something like that ;)
>>
>>> Without the patch, I can trigger "ghost interrupt" in the latter PMU.
>>
>> An occasional spurious interrupt should be no big deal. If it ends up 
>> as a screaming spurious interrupt because we never handle the overflow 
>> condition on the "other" PMU, then what matters most is that we never 
>> handle the overflow, thus the "other" PMU is still useless since you 
>> can't assume the user is going to read it frequently enough to avoid 
>> losing information and getting nonsense counts back. So this hack 
>> really isn't a viable solution for anything.
> 
> IIRC, what happens is that kernel will disable the interrupt eventually 
> due to unhandled spurious interrupts making the "working" PMU also useless.

Indeed, but if having one inaccurate PMU is fine, having more than one 
is no big deal either, right? The moral of the story is that hacking the 
firmware to lie about the hardware is just not a great idea.

TBH it's always seemed a bit broken that we allow probing without an IRQ 
but then have no accommodation for overflow if so. Fixing that would be 
a good thing in itself, and would at least have the side-effect of 
allowing your hack to work, however much I may disapprove of that :)

FWIW it is still lingering some way down my to-do list to factor out the 
fiddly IRQ-sharing/migration code into at least a helper library (if not 
further into perf core itself) before it gets copy-pasted much more, and 
it occurs to me that I could then easily factor the IRQ-substitute timer 
approach from e.g. arm-ccn into that as well... The more I think about 
it the more I might just convince myself that I want it for the driver 
I'm currently working on and justify bumping it up the list, let's see...

Cheers,
Robin.

