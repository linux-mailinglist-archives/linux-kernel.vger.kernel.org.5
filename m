Return-Path: <linux-kernel+bounces-135463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68789C414
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AA71F210FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B47D408;
	Mon,  8 Apr 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="e8K8ojoP"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF967BAE7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583720; cv=none; b=iityDs0zJ080vET9cHjgugwHzLEsoZdLd4BfiGGaNj3s4mvdAW7NGFn6XiZBCoZlM7I43vG+ROLjIe4cb6pH7+x5ePXLXISQttkHDjmrdajhpSpDyoNKQA7KAvS8ZOjY8YkJJ7Uksj7l7C6lmTKnr86B6toSKegFRw9RtklhFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583720; c=relaxed/simple;
	bh=sL/8dnBIsSljF+3Yi5K565tV5zP4P1m6ll0623PKvzo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=huEuuxg2Tte87iRi/HeyoYV49VL9sLF6WonQjQcP7QvQeJ6Or5jIlJDUS91+vien6UkFQNwzC19Fd93CmWnuI6sjhnaB9OYH9z/4czVAAUnIkAGpK7HXNVd9cyRFGJmdAaQYQ9Esm22gTq05G/yqlOm0AyFcPrx9dsOVFL9xCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (0-bit key) header.d=zytor.com header.i=@zytor.com header.b=e8K8ojoP reason="key not found in DNS"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 438DfE3o2748190
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Apr 2024 06:41:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 438DfE3o2748190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1712583675;
	bh=3/sQf8nS1HHrjVnaHBPr1QDSvlV3K4q8SZqt2tbRJss=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=e8K8ojoP68A5STfENhU/RrxFOfpCbkgKsvNCIOC7Fer1iRirkRO1OWZcjQp+5LBnr
	 A4V5JisAyrkeeDuUnA7P73Z9B+a8Rs7cloon6b9Msb9FzYLM4MBIaFpiQ65AcC8MG4
	 476/cOnIglpqGx30PwbIhCuazVs/ISsEAwUvw0yAfcs2P5YFg3eepi1jeu7cflNAwg
	 +VQk/G8ugSwkbI1BXW1Pip9QYwBZB9nIJnv2MMEeVycqC55wQcvNH2QJsQ4Sa1aP2J
	 wQIsQJpL4i7GbGIZrztTGCMlgGx/dd8rIM8ttnR+XxgneAEFXJ8Jm+1iV2kkW+7ERR
	 4+38uTfVO5Bjg==
Date: Mon, 08 Apr 2024 06:41:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More annoying code generation by clang
User-Agent: K-9 Mail for Android
In-Reply-To: <20240408084934.GC21904@noisy.programming.kicks-ass.net>
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com> <20240408084934.GC21904@noisy.programming.kicks-ass.net>
Message-ID: <A120A8EC-AB1E-44FB-AEAB-09DFE282CCF8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 8, 2024 1:49:34 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Thu, Apr 04, 2024 at 03:53:49PM -0700, Linus Torvalds wrote:
>
>> diff --git a/arch/x86/include/asm/barrier=2Eh b/arch/x86/include/asm/ba=
rrier=2Eh
>> index 66e57c010392=2E=2E6159d2cbbfde 100644
>> --- a/arch/x86/include/asm/barrier=2Eh
>> +++ b/arch/x86/include/asm/barrier=2Eh
>> @@ -33,20 +33,15 @@
>>   * Returns:
>>   *     0 - (index < size)
>>   */
>> +#define array_index_mask_nospec(idx,sz) ({	\
>> +	typeof((idx)+(sz)) __idx =3D (idx);	\
>> +	typeof(__idx) __sz =3D (sz);		\
>> +	typeof(__idx) __mask;			\
>> +	asm volatile ("cmp %1,%2; sbb %0,%0"	\
>> +			:"=3Dr" (__mask)		\
>> +			:"ir"(__sz),"r" (__idx)	\
>> +			:"cc");			\
>> +	__mask; })
>
>Should this not carry a comment about the "ir" constraint wanting to be
>"g" except for clang being daft?
>
>(I really wish clang would go fix this, it keeps coming up time and
>again)=2E
>
>> =20
>>  /* Prevent speculative execution past this barrier=2E */
>>  #define barrier_nospec() asm volatile("lfence":::"memory")
>

If the only reason for "ir" as opposed to "g" (=3D "irm") is clang then it=
 really needs to be called out=2E Or better yet, don't do anything and let =
the clang people actually fix their code generation=2E

