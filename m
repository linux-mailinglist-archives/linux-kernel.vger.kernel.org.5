Return-Path: <linux-kernel+bounces-86160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390286C096
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3819C2899D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B953C463;
	Thu, 29 Feb 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="C9OlH+RA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C136AE1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187523; cv=none; b=HURIHccj01g3v1NJDvWtvbXDzvbwxFMK2Zxnt60SxI/nAOK4tB02KuZXP/TciKZzDnisg0mumWssphG3vZFkrst4Eg1tN1pepa0MP03gsiwTzWMzCZDJjAZvxyLKGiynaL0Qyuh+ZugtaK2HLCMDvHVQR9g5jlDjg519vxrrEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187523; c=relaxed/simple;
	bh=+qbymGl2a1QToFGQyExG9ZunXLOUJI8LBQgEqoKp1jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7qRztuE4fPsAS4rrX5lFOEwt1P6KLpQ+zQocT2enxR2JxjLcjQVLgylMAwkJ/P/v4ffWpmabuRFdvzQBlaOrhdIDzubCCfOMLCyK5EyrT+sqcocuNTUhrq0DtDFhVLqmGG69Qyn2h+QN306Bnn+lHFmU18CbIbrRmL2+WE3RPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=C9OlH+RA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709187517;
	bh=3rPcoNkAXcpWZ8q00u4PWHD9ZMXVCcKe51zCGK/zmmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C9OlH+RAEQUYEF7CvXeN3khlG4AxZoOiNYU73WWD1H8X2VDBDwqNgHd0etKpmeWrN
	 SHdXc29fjfrEbAQdqE6vY0Cn1myrZKg8MCNPvP5MQjeJ5yWkKVPRSIymIuM4z5fLEF
	 2BDqpFy21V/Ph3RHC+BXNb2i2D6pEwU0yM+FNBC4ET6af7hAS7D9njOCl//qbQzrEw
	 fNDlDc3jr0BQdJQFj1Z9GRrPZgefCXIk6xk75bgo1lWtkbCPTjAjpa03+Q+18mxCy0
	 SKuauHA6gl+sszlKKoGImJTBepG+q7ueFWHzJyOJfsp9y2bMw7Wf90712sQKWIE1Rg
	 trl7/rdZQ1c/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tlgyh4k9sz4wc5;
	Thu, 29 Feb 2024 17:18:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Kunwu Chan
 <chentao@kylinos.cn>, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
In-Reply-To: <87bk80kjup.fsf@kernel.org>
References: <20240125092624.537564-1-chentao@kylinos.cn>
 <87h6hva4b0.fsf@mail.lhotse>
 <f3b53f0e-58ce-4b2d-ba91-f347da73f9f3@kylinos.cn>
 <87jzmq5tjr.fsf@mail.lhotse> <87bk80kjup.fsf@kernel.org>
Date: Thu, 29 Feb 2024 17:18:32 +1100
Message-ID: <87wmqng5dz.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Kunwu Chan <chentao@kylinos.cn> writes:
>>> On 2024/2/26 18:49, Michael Ellerman wrote:
>>>> Kunwu Chan <chentao@kylinos.cn> writes:
>>>>> This part was commented from commit 6d492ecc6489
>>>>> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
>>>>> in about 11 years before.
>>>>>
>>>>> If there are no plans to enable this part code in the future,
>>>>> we can remove this dead code.
>>>> 
>>>> I agree the code can go. But I'd like it to be replaced with a comment
>>>> explaining what the dead code was trying to say.
>>
>>> Thanks, i'll update a new patch with the following comment:
>>>      /*
>>>      * No CPU has hugepages but lacks no execute, so we
>>>      * don't need to worry about cpu no CPU_FTR_COHERENT_ICACHE feature case
>>>      */
>>
>> Maybe wait until we can get some input from Aneesh. I'm not sure the
>> code/comment are really up to date.
>
> How about?
>
> modified   arch/powerpc/mm/book3s64/hash_hugepage.c
> @@ -58,17 +58,13 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  		return 0;
>  
>  	rflags = htab_convert_pte_flags(new_pmd, flags);
> +	/*
> +	 * THPs are only supported on platforms that can do mixed page size
> +	 * segments (MPSS) and all such platforms have coherent icache. Hence we
> +	 * don't need to do lazy icache flush (hash_page_do_lazy_icache()) on
> +	 * noexecute fault.
> +	 */

Yeah thanks that looks good.

It could say "see eg. __hash_page_4K()", but that's probably unnecessary
as it mentions hash_page_do_lazy_icache(), and anyone interested is just
going to grep for that anyway.

cheers

