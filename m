Return-Path: <linux-kernel+bounces-73355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB785C161
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A057CB258BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA577634;
	Tue, 20 Feb 2024 16:27:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9E763F3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446446; cv=none; b=ePcNiuTOLSugRf3lcmK1tuNY//hwnaOQp9nryblkC4n2c6eDJ56p7wVBM2UKY34FkuvNxjuQL6kzcnjya/gEeFbzmZcEqbfLpcQX6NWHjkTmeBcEmhjZtRBTJ9edZWGfEJHAhEkSGjrGsVIMPQTRmWvmzstxWsA4MRlF4BPmS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446446; c=relaxed/simple;
	bh=VDOX45f16PvLcH6zAT7dA/WXjYrMatUFzy/IpxKjtGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3Y2llUxMlUYX0TxOzuC02N+Tzrzo3jnw1rvPw/aRY6BKn+MjYeY8O91Q8tJrsoh0Ip3N0mPUaFiYXec5mIsherKHM8pk5VmOT3R/cIhYfyn7DC0Oxf1+j5FnICz6RNZRnC8Myn6WOIKxs/DSc7SvuX1yuLfYbv5XAFSnzzukr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89E1AFEC;
	Tue, 20 Feb 2024 08:28:02 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F2E3F762;
	Tue, 20 Feb 2024 08:27:20 -0800 (PST)
Message-ID: <91b58253-f682-49f7-914d-8faf1ce181ef@arm.com>
Date: Tue, 20 Feb 2024 16:27:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/24] x86/resctrl: Use __set_bit()/__clear_bit()
 instead of open coding
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-10-james.morse@arm.com>
 <b5bc883a-8a8a-4f07-a6ff-b1bd02ffc99d@redhat.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <b5bc883a-8a8a-4f07-a6ff-b1bd02ffc99d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

On 20/02/2024 16:00, David Hildenbrand wrote:
> On 13.02.24 19:44, James Morse wrote:
>> The resctrl CLOSID allocator uses a single 32bit word to track which
>> CLOSID are free. The setting and clearing of bits is open coded.
>>
>> Convert the existing open coded bit manipulations of closid_free_map
>> to use __set_bit() and friends. These don't need to be atomic as this
>> list is protected by the mutex.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index dcffd1c4a476..bc6e0f83c847 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -111,7 +111,7 @@ void rdt_staged_configs_clear(void)
>>    * - Our choices on how to configure each resource become progressively more
>>    *   limited as the number of resources grows.
>>    */
> 
> That comment talks about "free CLOSIDs in a single integer". Once could think about
> rephrasing that to "free CLOSIDs in a simple bitmap."
> 
>> -static int closid_free_map;
>> +static unsigned long closid_free_map;
>>   static int closid_free_map_len;
>>     int closids_supported(void)
>> @@ -130,8 +130,8 @@ static void closid_init(void)
>>         closid_free_map = BIT_MASK(rdt_min_closid) - 1;
> 
> Now that we use "unsigned long", I was wondering for a second if we should use "proper"
> bitmap functions here like
> 
>     bitmap_fill(closid_free_map, rdt_min_closid);
> 
> and converting the alloc path (replace ffs() in closid_alloc()):
> 
>     closid = find_first_bit(closid_free_map, closid_free_map_len);
>     if (closid == closid_free_map_len)
>         return -ENOSPC;
>     __clear_bit(closid, &closid_free_map);
> 
> (would get rid of the closid-- in closid_alloc())

Yup. I have this as something to post after all the MPAM changes as it's not necessary to
get MPAM going. The patch[0] uses the bitmap APIs you suggest to remove the fixed limit on
the number of CLOSID/PARTID.
MPAM systems are being built with more than 32, but will work without that patch.


> Just a thought, so
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>


Thanks!

James

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.7-rc2&id=b530deed244d9b45f3bce3cccde91f6ed0ebf7ea

