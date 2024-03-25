Return-Path: <linux-kernel+bounces-116619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526A88A141
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9495E1C37FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC745F47E;
	Mon, 25 Mar 2024 09:11:02 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AF55798
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351544; cv=none; b=E1niBaoiqP6KGIVbzEr0UpAPNgly14ek2Y4e0hJo3b0QyDVOwRFs2b4ynaEmzErOeQRtqOgEIfpJkvb7kvHM3NGfYFyKqKbp8wIp5z3eixddSeKFvp+YQsFtIQarWrPQvhlMWANBvY44qdy5aEXJim9B+xVPeDndNTrqtQ1R4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351544; c=relaxed/simple;
	bh=6Ex/aBChk/0aJOCZhha4d9sYX6YbFHzLZTQVJK1TS4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUMKbclGpktypdpPDmtlYpQ0cOfc8d5I8+nSXzrAGx+8Kc57hbJZnXQdsnA5cpIqckWkLkg5KrtnBMl5prSjxqUAPAZIZzFFged+umTpdbFnelv6MsGToSgi87mOF2FBGZjqMfZ3ZHCz2HUIH7RHIo+pgb2GPBhCxPsMMMmZ+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56277240002;
	Mon, 25 Mar 2024 07:25:29 +0000 (UTC)
Message-ID: <1883cf6b-7756-405b-a843-d8ae31e01d61@ghiti.fr>
Date: Mon, 25 Mar 2024 08:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Samuel Holland
 <samuel.holland@sifive.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
 guoren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Matthew Wilcox
 <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Xiao W Wang
 <xiao.w.wang@intel.com>, Yangyu Chen <cyy@cyyself.name>,
 linux-kernel@vger.kernel.org
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <b0a07878-a9f1-40aa-b177-423b05137d2e@app.fastmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <b0a07878-a9f1-40aa-b177-423b05137d2e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Arnd,

On 24/03/2024 23:05, Arnd Bergmann wrote:
> On Tue, Mar 19, 2024, at 17:51, Alexandre Ghiti wrote:
>> On 18/03/2024 22:29, Samuel Holland wrote:
>>> On 2024-03-18 3:50 PM, Alexandre Ghiti wrote:
>>>> On Wed, Mar 13, 2024 at 7:00 PM Samuel Holland
>>> It looks like the call to fixup_exception() [added
>>> in 416721ff05fd ("riscv, mm: Perform BPF exhandler fixup on page fault")] is
>>> only intended to catch null pointer dereferences. So making the change wouldn't
>>> have any functional impact, but it would still be a valid optimization.
>>>
>>>> Or I was wondering if it would not be better to do like x86 and use an
>>>> alternative, it would be more correct (even though I believe your
>>>> solution works)
>>>> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64.h#L82.
>>> What would be the benefit of using an alternative? Any access to an address
>>> between TASK_SIZE and TASK_SIZE_MAX is guaranteed to generate a page fault, so
>>> the only benefit I see is returning -EFAULT slightly faster at the cost of
>>> applying a few hundred alternatives at boot. But it's possible I'm missing
>>> something.
>>
>> The use of alternatives allows to return right away if the buffer is
>> beyond the usable user address space, and it's not just "slightly
>> faster" for some cases (a very large buffer with only a few bytes being
>> beyond the limit or someone could fault-in all the user pages and fail
>> very late...etc). access_ok() is here to guarantee that such situations
>> don't happen, so actually it makes more sense to use an alternative to
>> avoid that.
> The access_ok() function really wants a compile-time constant
> value for TASK_SIZE_MAX so it can do constant folding for
> repeated calls inside of one function, so for configurations
> with a boot-time selected TASK_SIZE_64 it's already not ideal,
> with or without alternatives.
>
> If I read the current code correctly, riscv doesn't even
> have a way to build with a compile-time selected
> VA_BITS/PGDIR_SIZE, which is probably a better place to
> start optimizing, since this rarely needs to be selected
> dynamically.


Indeed, we do not support compile-time fixed VA_BITS! We could, but that 
would only be used for custom kernels. I don't think distro kernels will 
ever (?) propose 3 different kernels for sv39, sv48 and sv57 because the 
cost of dynamically choosing the address space width is not big enough 
to me (and the burden of maintaining 3 different kernels is).

Let me know if I'm wrong, I'd be happy to work on that.

Thanks,

Alex


>
>        Arnd

