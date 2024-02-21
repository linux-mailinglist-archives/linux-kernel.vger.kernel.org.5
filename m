Return-Path: <linux-kernel+bounces-74683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867D85D7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0400B1F22A02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25504DA05;
	Wed, 21 Feb 2024 12:06:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DCD4D5BF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517204; cv=none; b=RvhGWsQNz/ST+W+9ZcNbQzcEmXV/carrqw4IR2wPTCPn6vCdkFQnEi8LDDP9ciG1IU2jWodqbwZQyUP9meXFuRX5t0WHHM2EOXxQDVUPpzcsd9UYe+6hAYLDX9GO/ebNtk1GJzQLK2qQli/YSopN4uLHGd3JEiAhIHukD44XuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517204; c=relaxed/simple;
	bh=os/8OtNq8qevRBkkTby5V8Bg1OWl6A4ykuFS8TPZS9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr92quND5poQeu/IIbApnecEOr0WeLI7fSh/28KGm53ocvvQaSGm8+Sm1AA0LbxRE6ZyQr+asarsflRl4Cxp+TZfK0qT7yoCnLw8S9H8Uj4yP367FEo0b/1Yh2KFYrgbq3wPZuUsOJOvBfsXmROd+5VKT7/ehzGOlAhFP8KrPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B19FEC;
	Wed, 21 Feb 2024 04:07:17 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250893F762;
	Wed, 21 Feb 2024 04:06:36 -0800 (PST)
Message-ID: <e4dcc9b4-afa0-46c7-988f-19fd7509e608@arm.com>
Date: Wed, 21 Feb 2024 12:06:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony, Reinette,

On 20/02/2024 22:58, Reinette Chatre wrote:
> On 2/20/2024 12:59 PM, Tony Luck wrote:
>> On Mon, Feb 19, 2024 at 05:49:29PM +0100, Thomas Gleixner wrote:
>>> On Sat, Feb 17 2024 at 11:55, Borislav Petkov wrote:
>>>
>>>> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>>>>> Hello!
>>>>>
>>>>> It's been back and forth for whether this series should be rebased onto Tony's
>>>>> SNC series. This version isn't, its based on tip/x86/cache.
>>>>> (I have the rebased-and-tested versions if anyone needs them)
>>>>
>>>> The set applied ontop of tip:x86/cache gives:

>> Testing tip x86/cache that WARN fires while running
>> tools/tests/selftests/resctrl/resctrl_test.

I evidently need to build a newer version of that tool.


>> Everthing runs OK if I drop the top commit:
>>   fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")
> 
> The new WARN_ON_ONCE() is why this encountered. The comment notes that
> lockdep_is_cpus_held() is used to determine if "someone is holding the
> CPUs lock" but it seems that lockdep_is_cpus_held() still only checks
> if "current" is holding cpu_hotplug_lock and that is not possible
> when running the code via IPI.

I was evidently mistaken that this was the difference between
lockdep_is_cpus_held() and lockdep_assert_cpus_held().

It's a false positive, ripping out the check is the simplest thing to do.


> So even though it is confirmed via lockdep_assert_cpus_held() that
> resctrl_arch_update_domains() holds cpu_hotplug_lock, it does not seem possible
> to have a similar lockdep check in the function called by it (resctrl_arch_update_domains())
> via IPI. It thus does not look like that lockdep checking within
> get_domain_from_cpu() can be accurate and I cannot see what it can be replaced with
> to make it accurate. Any guidance will be appreciated. Perhaps we should just drop (but
> with detailed context comments remaining) the lockdep check in get_domain_from_cpu()? 


Thanks,

James

