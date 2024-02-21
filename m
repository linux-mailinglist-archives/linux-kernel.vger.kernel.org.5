Return-Path: <linux-kernel+bounces-75030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E826585E1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93237283456
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980A81219;
	Wed, 21 Feb 2024 15:52:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF4811E3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530734; cv=none; b=i88gILgnerFT7OXkf7uL4yT4ev51hgGAAmyKOYLrzJba1WyEynJSg2pIOJGXpUJhsV+E0s8tnr881QHBW8iMOAK+jHNAfvKAQhqise1ebBvQy5xL8yXCZJ3WUuG1BQY45evTGkdBrZ5zECqIznxvWTvMiuxMKvfVU3kcYZos8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530734; c=relaxed/simple;
	bh=GOdl8juPhn5nyV5Pl4HF5qwOPyavoNeFUHjkU2P9PL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5ylqpN/LWgZ8ZR7+YlvyhPZ6m/c0HKM26+4AqQI2TBLJMANhQ/Ijaqy9QBdNYSbOnJVcVLYaM0DnqzId0augMcSr6FUCmZ0n4vKqzVHGQ21kO8zeglwosnnj/DApKVh4g2MxgM1b7RFtntBdkv/c+3wZiJQ4uNVsijJiTeDIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7123E1007;
	Wed, 21 Feb 2024 07:52:39 -0800 (PST)
Received: from [10.34.100.133] (e126645.nice.arm.com [10.34.100.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112653F73F;
	Wed, 21 Feb 2024 07:51:58 -0800 (PST)
Message-ID: <6843f6b2-4c41-4649-9885-88fde7215e3f@arm.com>
Date: Wed, 21 Feb 2024 16:51:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] support NUMA emulation for genertic arch
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>,
 Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
 luto@kernel.org, teng.ma@linux.alibaba.com
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
 <ZdWUPlqsxC_y3YFM@kernel.org>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ZdWUPlqsxC_y3YFM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/21/24 07:12, Mike Rapoport wrote:
> On Tue, Feb 20, 2024 at 07:36:00PM +0800, Rongwei Wang wrote:
>> A brief introduction
>> ====================
>>
>> The NUMA emulation can fake more node base on a single
>> node system, e.g.
> 
> ...
>   
>> Lastly, it seems not a good choice to realize x86 and other genertic
>> archs separately. But it can indeed avoid some architecture related
>> APIs adjustments and alleviate future maintenance.
> 
> Why is it a good choice? Copying 1k lines from x86 to a new place and
> having to maintain two copies does not sound like a good choice to me.

I agree it would be better to avoid duplication and extract the common
code from the original x86 implementation. The RFC seemed to go more
in this direction.
Also NITs:
- genertic -> generic
- there is a 'ifdef CONFIG_X86' in drivers/base/numa_emulation.c,
   but the file should not be used by x86 as the arch doesn't set
   CONFIG_GENERIC_ARCH_NUMA

Regards,
Pierre

> 
>> The previous RFC link see [1].
>>
>> Any advice are welcome, Thanks!
>>
>> Change log
>> ==========
>>
>> RFC v1 -> v1
>> * add new CONFIG_NUMA_FAKE for genertic archs.
>> * keep x86 implementation, realize numa emulation in driver/base/ for
>>    genertic arch, e.g, arm64.
>>
>> [1] RFC v1: https://patchwork.kernel.org/project/linux-arm-kernel/cover/20231012024842.99703-1-rongwei.wang@linux.alibaba.com/
>>
>> Rongwei Wang (2):
>>    arch_numa: remove __init for early_cpu_to_node
>>    numa: introduce numa emulation for genertic arch
>>
>>   drivers/base/Kconfig          |   9 +
>>   drivers/base/Makefile         |   1 +
>>   drivers/base/arch_numa.c      |  32 +-
>>   drivers/base/numa_emulation.c | 909 ++++++++++++++++++++++++++++++++++
>>   drivers/base/numa_emulation.h |  41 ++
>>   include/asm-generic/numa.h    |   2 +-
>>   6 files changed, 992 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/base/numa_emulation.c
>>   create mode 100644 drivers/base/numa_emulation.h
>>
>> -- 
>> 2.32.0.3.gf3a3e56d6
>>
>>
> 

