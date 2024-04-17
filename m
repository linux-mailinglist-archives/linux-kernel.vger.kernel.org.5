Return-Path: <linux-kernel+bounces-147840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1968A7A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464E8B21A35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8742524F;
	Wed, 17 Apr 2024 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S2zYhIQq"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E5187F;
	Wed, 17 Apr 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320139; cv=none; b=JwHna9MXxFHaZHghinRF/KV9TkzJnbabBNSb59E2RtNI/vqUOSuLyXAj5+cfVRqu0cC5zxdEgsGhGBIkd48fZglTElqxiooxuRubP0JQ0vbPOuxGAKbmJ00AExy4j0JXk80FrcXp7UdSyy9PxmoCl4ltS/h9oqcQO1uHce9g/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320139; c=relaxed/simple;
	bh=omV0IA49HoXwT0kyGj7AZ71R/UujjbWkNeetXSdxGdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNJHA6k/kqU8nv4gteLZEvsmjxDqNE5gwxoYfTrSdLFmCrrvRIu9LTCEx3yqzbPjupq5cDjqpBPMOY2HiKXo+xNI6U2AlIOiLBoBbwRfKFVrdEV1/jJRskEYFC5MKjIrVTgbws0RhNh5OTq09TrUgOrHvB9injXHUhjoU0vsNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S2zYhIQq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=u0IYFiNnZuPAYt7tDNRGy4tT9L7GKEy8U8Q+P2ys8oI=;
	b=S2zYhIQqqgGHRmyhkGTkoYj8R3cou2mv6Rj0ba7g9icKNHxbI79V2zcC2yDZJB
	PY+O2UVUvUoZhLxqxNRuEKs/ZCHuHtN/aKMSXxTZejuVbkNsvW8z2lQb3xFxv/hG
	uez93caOs/03ITI7yvDLDYrw1pIQY4onmRSVkwOlGzL6k=
Received: from [192.168.38.19] (unknown [124.232.57.198])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3X1w9MB9mfsJ_BQ--.14588S2;
	Wed, 17 Apr 2024 10:13:17 +0800 (CST)
Message-ID: <6b847511-cc5d-4a55-a764-48461209fe53@163.com>
Date: Wed, 17 Apr 2024 10:13:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: hibernate: Fix level3 translation fault in
 swsusp_save()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, keescook@chromium.org, tianyaxiong@kylinos.cn,
 xiongxin@kylinos.cn, rppt@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, songshuaishuai@tinylab.org, wangkefeng.wang@huawei.com,
 akpm@linux-foundation.org, ardb@kernel.org, david@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZeBRfxQ8WTEVzpfL@kernel.org>
 <20240301021924.33210-1-13327272236@163.com> <Zhlvs2ol7Va1r1Mr@arm.com>
Content-Language: en-US
From: Yaxiong Tian <13327272236@163.com>
In-Reply-To: <Zhlvs2ol7Va1r1Mr@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1w9MB9mfsJ_BQ--.14588S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr17tr1fZF43WF4rCFy7GFg_yoW5tr4kpr
	W7WrWFyw1DAFnYv393Xan5urn3A3sYgr45JF1DArn7ZF4ayFZ5Kr45Kry29Fyqqrn5Cr4F
	qFWUKwnayFn0ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeUDXUUUUU=
X-CM-SenderInfo: jprtjjaxsxjjitw6il2tof0z/1tbiYh-DJWV4HPYA2AAAs0


在 2024/4/13 01:30, Catalin Marinas 写道:
> For some reason I missed the updated patch.
>
> On Fri, Mar 01, 2024 at 10:19:24AM +0800, Yaxiong Tian wrote:
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> On ARM64 machines using UEFI, if can_set_direct_map() return false by
>> setting some CONFIGS in kernel build or grub,such as
>> NO CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT、NO CONFIG_KFENCE
>> NO CONFIG_RODATA_FULL_DEFAULT_ENABLED.Also with setting rodata=off、
>> debug_pagealloc=off in grub and NO CONFIG_KFENCE.
>> swsusp_save() will fail due to can't finding the map table under the
>> nomap memory.such as:
> [...]
>> [   48.532162] Call trace:
>> [   48.532162]  swsusp_save+0x280/0x538
>> [   48.532162]  swsusp_arch_suspend+0x148/0x190
>> [   48.532162]  hibernation_snapshot+0x240/0x39c
>> [   48.532162]  hibernate+0xc4/0x378
>> [   48.532162]  state_store+0xf0/0x10c
>> [   48.532162]  kobj_attr_store+0x14/0x24
>>
>> This issue can be reproduced in QEMU using UEFI when booting with
>> rodata=off、debug_pagealloc=off in grub and NO CONFIG_KFENCE.
>>
>> This is because in swsusp_save()->copy_data_pages()->page_is_saveable(),
>> kernel_page_present() presumes that a page is present when can_set_direct_map()
>> returns false even for NOMAP ranges.So NOMAP pages will saved in after,and then
>> cause level3 translation fault in this pages.
> I can see how kernel_page_present() ended up returning true if
> !can_set_direct_map(), though based on the function naming only, it
> feels a bit unintuitive. Is arm64 the only architecture making use of
> MEMBLOCK_NOMAP? Or is it the only one where kernel_page_present() also
> returns true if !can_set_direct_map()?
It looks like ARM64 is only one where kernel_page_present() also returns
true if  !can_set_direct_map(). I remember that on x86 models  there are
no NOMAP regions, on ARM64 machines these NOMAP regions are set with uefi.
Other details are too old to remember.
>> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
>> index 02870beb271e..d90005de1d26 100644
>> --- a/arch/arm64/kernel/hibernate.c
>> +++ b/arch/arm64/kernel/hibernate.c
>> @@ -94,7 +94,7 @@ int pfn_is_nosave(unsigned long pfn)
>>   	unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
>>   
>>   	return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn)) ||
>> -		crash_is_nosave(pfn);
>> +		crash_is_nosave(pfn) || !pfn_is_map_memory(pfn);
>>   }
> This indeed fixes the problem but it looks like an arm64-specific
> workaround. I can see at least arm, loongarch and riscv making use of
> memblock_is_map_memory() (which is what pfn_is_map_memory() calls). Do
> they not have the same problem? On riscv, for example,
> kernel_page_present() does not depend on any ARCH_HAS_SET_DIRECT_MAP
> related options/conditions (neither does x86 though not sure it cares
> about MEMBLOCK_NOMAP). Should we do the same for arm64 and drop the
> !can_set_direct_map() condition in kernel_page_present()?
I drop the  !can_set_direct_map() condition in kernel_page_present(). And
test it. The test was passed. I use kretprobe to inspect in 
kernel_page_present()
find that the NOMAP pages  will reture false. So in saveable_page() 
these page
will skip. The final logic for processing these pages is the same as 
before (v5.4).
I think it is good way.


