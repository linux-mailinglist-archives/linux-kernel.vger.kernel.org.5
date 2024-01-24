Return-Path: <linux-kernel+bounces-36641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9599083A442
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFFF287E45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0197117981;
	Wed, 24 Jan 2024 08:38:45 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069711799E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085524; cv=none; b=o4x/R11YLA7Xo3zd7uIcS9ZcFcUcsUv/vwn6la5bVi3S3tqZ8OW+xExOZu7Bep8bD/Z/VjGXAw53y/x9Jrc61p0kPWpP2bd7IV/sHA0FQTQQVSNlGPrDqcpljyMZDEEqUqwLm+BEfyjpgVdHA6D7+Ty5Hae/51lQCrZ7P3uq3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085524; c=relaxed/simple;
	bh=D/eQ9P4RCw3rHW5sQCHc3F8xx4YvkOg1xY7lET+BG5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a89uPhQvHCE4Zyv42oQgs7CPoblyGhh+tkukTSeXUX1drB8jbMiA/xo7tXo/nXD0iepehnvsweiMHg5N8ty/j8i3Gsxw6iWJCb5aLpTbqvgAykUhw1StNy/B+WM7cSwAqU0O0BgkkCGQLpyOn9crN3Cbw9j4yvPGf+ganEKrCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9D7640002;
	Wed, 24 Jan 2024 08:38:30 +0000 (UTC)
Message-ID: <cd68cf4e-7a6b-4875-ae1b-0c28a6eacaad@ghiti.fr>
Date: Wed, 24 Jan 2024 09:38:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH] riscv: Fix wrong size passed to
 local_flush_tlb_range_asid()
Content-Language: en-US
To: Dennis Zhou <dennis@kernel.org>, yunhui cui <cuiyunhui@bytedance.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240123132730.2297719-1-alexghiti@rivosinc.com>
 <CAEEQ3wk5edUFTuE3H3KDGkCXj0+=i7Z1BM2M+6X-Tk9_m8X_iQ@mail.gmail.com>
 <ZbDICZkatO3/lGf/@snowbird>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZbDICZkatO3/lGf/@snowbird>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Dennis, Yunhui,

On 24/01/2024 09:19, Dennis Zhou wrote:
> Hello,
>
> On Wed, Jan 24, 2024 at 10:44:12AM +0800, yunhui cui wrote:
>> Hi Alexandre,
>>
>> On Tue, Jan 23, 2024 at 9:31 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>> local_flush_tlb_range_asid() takes the size as argument, not the end of
>>> the range to flush, so fix this by computing the size from the end and
>>> the start of the range.
>>>
>>> Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>   arch/riscv/mm/tlbflush.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>>> index 8d12b26f5ac3..9619965f6501 100644
>>> --- a/arch/riscv/mm/tlbflush.c
>>> +++ b/arch/riscv/mm/tlbflush.c
>>> @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>>>
>>>   void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>>>   {
>>> -       local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>>> +       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>>>   }
> Well this was a miss during code review.. I'm going to take another look
> tomorrow and then likely pull this into a fixes branch.
>
>> What makes me curious is that this patch has not been tested?
>> BTW, It is best to keep the parameter order of all functions in
>> tlbflush.c consistent: cpumask, start, size, stride, asid.
>>
> I can't speak to the riscv communities testing/regression suites, but
> this would only be caught in a performance regression test.
>
> That being said, Alexandre, can you please lmk what level of testing
> this has gone through?


All my patches go through the same level of testing:

* Build/boot an Ubuntu kernel with and without KASAN + a few simple 
testsuites (libhugetlbfs, riscv kselftests and other)
* Build/boot a simple rootfs on ~40 different rv64 configs
* Build/boot a simple rootfs on ~30 different rv32 configs

And I run LTP/full kselftests/perf testsuite on a weekly basis on every 
rc. All this validation is done on qemu.

The patch is functional, it "simply" flushes the whole TLB instead of a 
few entries, so the only way to catch that would have been a performance 
regression. But given it only runs on qemu, it would have been hard to 
catch any performance regression since that involves the TLB.

@Yunhui: Please let me know how I should validate my patches better.

Thanks,

Alex


> Thanks,
> Dennis
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

