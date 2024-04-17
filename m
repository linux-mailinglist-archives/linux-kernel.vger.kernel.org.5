Return-Path: <linux-kernel+bounces-148645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BE8A857B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16D61C20B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4481411DE;
	Wed, 17 Apr 2024 14:00:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99B142636;
	Wed, 17 Apr 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362434; cv=none; b=hsusynp8NwVH8Mn68C1dYZwMVXZneuAQ13KzqIr1hSfWT/ygBxgpmfUBg6FPqC2lJmcNoNf8trjw+/44tosrj/Q28Zjw7uB7+dTUCEESrUdvAkID8J2+xgAicwulHjM4g8oHswTfWKrqPLIRuIxDdxRZmh8UXGSW8vvNEku1h/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362434; c=relaxed/simple;
	bh=m6TR/ZLlLCkGO3F3ndV7pOLLTILChKbKAc0O9NR6yTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM5kGo3XKk3D2mWJUihEExymBTSxY0jLNEj/ylAJsr/JKIGgTm/HtuLVtllGCbQKtn8khN8SHLdvzP5dJ+EX5BnZd10Z/mLu2pm6z+Olh7k3RtqNvj0bi4V4BhYLdMOWyTJx8eXHKPZQsTr4mbGIR3ye6WjB4hPvbTNQUyIn8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F9F339;
	Wed, 17 Apr 2024 07:00:56 -0700 (PDT)
Received: from [192.168.20.58] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598433F738;
	Wed, 17 Apr 2024 07:00:25 -0700 (PDT)
Message-ID: <260d9932-bf51-43ac-8490-99c39f5e9258@arm.com>
Date: Wed, 17 Apr 2024 09:00:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v3 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
Content-Language: en-US
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com,
 james.morse@arm.com, jhugo@codeaurora.org, john.garry@huawei.com,
 Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, sudeep.holla@arm.com,
 tiantao6@huawei.com
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
 <20240416031438.7637-2-cuiyunhui@bytedance.com>
 <9f36bedd-1a68-43a9-826d-ce56caf01c52@arm.com>
 <CAEEQ3w=W+xLGP3WsyAQmRNaHm1xVRtqcGJ+t0TnZvJdCTR4v6w@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAEEQ3w=W+xLGP3WsyAQmRNaHm1xVRtqcGJ+t0TnZvJdCTR4v6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 4/16/24 22:15, yunhui cui wrote:
> Hi Jeremy,
> 
> On Wed, Apr 17, 2024 at 4:04 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> Hi,
>>
>>
>> On 4/15/24 22:14, Yunhui Cui wrote:
>>> Before cacheinfo can be built correctly, we need to initialize level
>>> and type. Since RSIC-V currently does not have a register group that
>>> describes cache-related attributes like ARM64, we cannot obtain them
>>> directly, so now we obtain cache leaves from the ACPI PPTT table
>>> (acpi_get_cache_info()) and set the cache type through split_levels.
>>>
>>> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
>>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>> ---
>>>    arch/riscv/kernel/cacheinfo.c | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>
>>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
>>> index 30a6878287ad..dc5fb70362f1 100644
>>> --- a/arch/riscv/kernel/cacheinfo.c
>>> +++ b/arch/riscv/kernel/cacheinfo.c
>>> @@ -6,6 +6,7 @@
>>>    #include <linux/cpu.h>
>>>    #include <linux/of.h>
>>>    #include <asm/cacheinfo.h>
>>> +#include <linux/acpi.h>
>>>
>>>    static struct riscv_cacheinfo_ops *rv_cache_ops;
>>>
>>> @@ -78,6 +79,25 @@ int populate_cache_leaves(unsigned int cpu)
>>>        struct device_node *prev = NULL;
>>>        int levels = 1, level = 1;
>>>
>>> +     if (!acpi_disabled) {
>>> +             int ret, idx, fw_levels, split_levels;
>>> +
>>> +             ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             for (idx = 0; level <= this_cpu_ci->num_levels &&
>>> +                  idx < this_cpu_ci->num_leaves; idx++, level++) {
>>
>> AFAIK the purpose of idx here it to assure that the number of cache
>> leaves is not overflowing. But right below we are utilizing two of them
>> at once, so this check isn't correct. OTOH, since its allocated as
>> levels + split_levels I don't think its actually possible for this to
>> cause a problem. Might be worthwhile to just hoist it before the loop
>> and revalidate the total leaves about to be utilized.
>>

I think I was suggesting something along the lines of:

BUG_ON((split_levels > fw_levels) || (split_levels + fw_levels > 
this_cpu_ci->num_leaves));

Then removing idx entirely. ex:

for (; level <= this_cpu_ci->num_levels; level++)
..
> 
> Do you mean to modify the logic as follows to make it more complete?
Sure that is one way to do it, but then you need to probably repeat the 
idx check:
> for (idx = 0; level <= this_cpu_ci->num_levels &&
>        idx < this_cpu_ci->num_leaves; level++) {
>          if (level <= split_levels) {
>                 ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
>                 idx++;
if (idx >= this_cpu_ci->num_leaves) break;
>                 ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
>                 idx++;
>         } else {
>                 ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>                 idx++;
>        }
> }




