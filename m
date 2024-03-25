Return-Path: <linux-kernel+bounces-117904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2E88B11B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E491C62918
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04945D747;
	Mon, 25 Mar 2024 20:13:06 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF1FC01
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397586; cv=none; b=VeLefgMsy5PFtEMPoLCXvsDAplKmdXb9t99reYSIrry1T7TGuX1TJ//paHK3SH2vZTSNdWr43E4UIehGMyy4vPJrg1CBOFnuqwvl49jghN7uAevEchZtGdlXRqA5P12KYdMVuNPruNxuE5sLMlVXL7XZ9NBXccJMiDolpYZxt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397586; c=relaxed/simple;
	bh=SfZG6A8b7DawFMujLgpCe+RcXvJsAKzCUr+HoUNG97o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+q2sMgHEV13iSe/RDLRIAd+eGMOJAlJ5tTlmzI0IXztxhnf3Qnm+qG7yNZKlSbaSURkZIBz87LF8F9wpGgylp00Sgj5kWVKzMUuGWKxb5ujuz6jUCQnD7LskSF1SNzSPyvYPR12BH0+u1I3kOl/XvMvnxU1iKtJ/+96mbAzBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D366240003;
	Mon, 25 Mar 2024 20:12:55 +0000 (UTC)
Message-ID: <5bf9b76a-8f1a-4a53-b550-f4f2ad775cd8@ghiti.fr>
Date: Mon, 25 Mar 2024 21:12:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>,
 David Laight <David.Laight@aculab.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt
 <palmer@dabbelt.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
 Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Yangyu Chen <cyy@cyyself.name>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi David, Mark,

On 25/03/2024 17:39, Mark Rutland wrote:
> On Mon, Mar 25, 2024 at 08:30:37AM +0100, Alexandre Ghiti wrote:
>> Hi David,
>>
>> On 24/03/2024 20:42, David Laight wrote:
>>> ...
>>>> The use of alternatives allows to return right away if the buffer is
>>>> beyond the usable user address space, and it's not just "slightly
>>>> faster" for some cases (a very large buffer with only a few bytes being
>>>> beyond the limit or someone could fault-in all the user pages and fail
>>>> very late...etc). access_ok() is here to guarantee that such situations
>>>> don't happen, so actually it makes more sense to use an alternative to
>>>> avoid that.
>>> Is it really worth doing ANY optimisations for the -EFAULT path?
>>> They really don't happen.
>>>
>>> The only fault path that matters is the one that has to page in
>>> data from somewhere.
>> Which is completely avoided with a strict definition of access_ok(). I see
>> access_ok() as an already existing optimization of fault paths by avoiding
>> them entirely when they are bound to happen.
> I think the point that David is making is that address+size pairs that'd fail
> access_ok() *should* be rare, and hence it's a better trade-off to occasionally
> handle faults for those if it makes the common case of successful access_ok()
> smaller or faster. For any well-behaved userspace applications, access_ok()
> should practically never fail, since userspace should be passing good
> address+size pairs as arguments to syscalls.
>
> Using a compile-time constant TASK_SIZE_MAX allows the compiler to generate
> much better code for access_ok(), and on arm64 we use a compile-time constant
> even when our page table depth can change at runtime (and when native/compat
> task sizes differ). The only abosolute boundary that needs to be maintained is
> that access_ok() fails for kernel addresses.


Hmm indeed I had completely misunderstood David's point, but actually 
not really since I disagreed with what he actually meant :)

But I had not realized access_ok() was so performance-sensitive and also 
missed the point that it was to protect the kernel more than making sure 
the userspace address is correct, so I guess we are good to go with 
Samuel's patch.

Thanks David and Mark,

Alex


>
> Mark.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

