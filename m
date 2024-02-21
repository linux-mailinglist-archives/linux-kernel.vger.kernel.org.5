Return-Path: <linux-kernel+bounces-75625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CA85EC22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E1A285E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2573FE36;
	Wed, 21 Feb 2024 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="eKrBFqsl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A13E470
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556384; cv=none; b=YZFgf/m6CAE0+B5f9TElt2/zFb50VS+XgX8EoCeMVIWufB7C8TBcxqYAt9TQdlrqL7TrFzCz+16EDb82uuzPyhf/zQjHhw5YSxIV9hD0P4XD1CiY8evx1JAwPBfhXgiXxyWt9x9qVql23ZUT64ojtLt2QFZaaCxJfSnLcDI2ZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556384; c=relaxed/simple;
	bh=lYVsvuf+/UEhac8HmL0CsVxpR9l8/o1ogeNjKyJvkVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ccq+73Ao/j9+DiBQFjRXMzQiwEnLOQpFUfplfSWFcES4mhuITqTrgtBAlQd7Q/fcKbHIsBAht3OG3p7xj4d0ZhXcIs8efNXPodwNoNRq69GOYeARDvNCsWRamoz8lJCLCpIM7q2wIz/IlqZDvAAkU4suKoyWd2swV298TmJUSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=eKrBFqsl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708556379;
	bh=sGtAVvOhr+9YWRX0MUJYc+8lN19QTjbhe6EnVbTovgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eKrBFqslLC+n39jMi9oV22xQ7FzN8GPPmvghWrsvnUUfbR58woEy6Qia27+WgLBQl
	 WhaZcoBfpPYXio0nt/iEqBjH95RLww/1DYXgKPwiGiNJXWr2kIukMnw3MWdJj2i671
	 KMS19Fgup8rTA0Kuy6XlYUhfYSqoGAmAgHWIBTKPj8bZRWCJLFBW+7vtT3GCXL3Q7X
	 epnJ6TpbIzRklKIdP7PWeHxz/R3ZtaiWrBNDJaCpaeaCPkifGvHQC6m7MsEXt80X//
	 E3UxFKL/PbQe5u6LaRvKQMo5OqcSP+gBGfyqOLH0EU8wQLUoUoSwUSd9LpisedcXv2
	 uZTfr6yPA7wKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgBYR48KJz4wyY;
	Thu, 22 Feb 2024 09:59:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc: Don't ignore errors from set_memory_{n}p()
 in __kernel_map_pages()
In-Reply-To: <eefeb056-bc71-46ad-90b3-b07c392f5903@csgroup.eu>
References: <3656d47c53bff577739dac536dbae31fff52f6d8.1708078640.git.christophe.leroy@csgroup.eu>
 <20ef75884aa6a636e8298736f3d1056b0793d3d9.1708078640.git.christophe.leroy@csgroup.eu>
 <878r3eauig.fsf@mail.lhotse>
 <eefeb056-bc71-46ad-90b3-b07c392f5903@csgroup.eu>
Date: Thu, 22 Feb 2024 09:59:35 +1100
Message-ID: <875xyhbezs.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 21/02/2024 =C3=A0 13:09, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> set_memory_p() and set_memory_np() can fail.
>>>
>>> As mentioned in linux/mm.h:
>>>
>>> /*
>>>   * To support DEBUG_PAGEALLOC architecture must ensure that
>>>   * __kernel_map_pages() never fails
>>>   */
>>>
>>> So panic in case set_memory_p() or set_memory_np() fail
>>> in __kernel_map_pages().
>>>
>>> Link: https://github.com/KSPP/linux/issues/7
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/include/asm/book3s/64/hash.h |  2 +-
>>>   arch/powerpc/mm/book3s64/hash_utils.c     |  3 ++-
>>>   arch/powerpc/mm/pageattr.c                | 10 +++++++---
>>>   3 files changed, 10 insertions(+), 5 deletions(-)
>>>
>> ...
>>> diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
>>> index 16b8d20d6ca8..62b678585878 100644
>>> --- a/arch/powerpc/mm/pageattr.c
>>> +++ b/arch/powerpc/mm/pageattr.c
>>> @@ -106,17 +106,21 @@ int change_memory_attr(unsigned long addr, int nu=
mpages, long action)
>>>   #ifdef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
>>>   void __kernel_map_pages(struct page *page, int numpages, int enable)
>>>   {
>>> +	int err;
>>>   	unsigned long addr =3D (unsigned long)page_address(page);
>>>=20=20=20
>>>   	if (PageHighMem(page))
>>>   		return;
>>>=20=20=20
>>>   	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && !radix_enabled())
>>> -		hash__kernel_map_pages(page, numpages, enable);
>>> +		err =3D hash__kernel_map_pages(page, numpages, enable);
>>>   	else if (enable)
>>> -		set_memory_p(addr, numpages);
>>> +		err =3D set_memory_p(addr, numpages);
>>>   	else
>>> -		set_memory_np(addr, numpages);
>>> +		err =3D set_memory_np(addr, numpages);
>>> +
>>> +	if (err)
>>> +		panic("%s: set_memory_%sp() failed\n", enable ? "" : "n");
>>=20
>> This doesn't compile, it's missing __func__ I guess.
>
> Damn, I was too quick when I took into account checkpatch's feedback,=20
> sorry for that.
>
>>=20
>> Seems like we could keep it simpler though, it should hopefully never
>> happen anyway, eg:
>>=20
>>    panic("%s: changing memory protections failed\n", __func__);
>
> Sure, let's do that. Do you want a v2 or you do the change directly ?

No need for a v2, I'll just fix it up when applying.

cheers

