Return-Path: <linux-kernel+bounces-36481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3CC83A182
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA50B250E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD9E56D;
	Wed, 24 Jan 2024 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1skpl4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F35E55E;
	Wed, 24 Jan 2024 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075117; cv=none; b=KbDoc9VohrdGnJ3EPORde5xbZDWrobDGInxYsXZb5HnMbS12RG/0k6wGPE3H0HoXVpswHZm7ekOJiSNnF25Ix4JIUJkPBzgkbDWpSHMMGO2kVAXkV/8Gv05b0AYO8m5OUHWlkHk5JGpAR5k7BwKzrgg2W7CjdGMyFPuA07wcUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075117; c=relaxed/simple;
	bh=5dLOTB19eqgu6rIiWX9LXiC2Xe6lJz1n50JwsYBoJ6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVrfSvUmAfwL7xnoy5tbOH2cswnQGC/fpww91hH/NaHNq2RhvK5I6IdTH5vWfM9qHn+ZaozxJiEG+yD9TQt3Hfk2l6r2O9NQI3a0Xanx9EMCwbhpw6Q9lEXVSJVCoBA/FLbR39kIpEyDmELXsSIvD4J6wO0nERI+yf4aWaC/rPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1skpl4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA06C433F1;
	Wed, 24 Jan 2024 05:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706075117;
	bh=5dLOTB19eqgu6rIiWX9LXiC2Xe6lJz1n50JwsYBoJ6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O1skpl4y2xjw6BP+gzZ5mPe0LKyiUIrkGJSxeRvOjofb/gZvo6wl7nFZdgUFQ8p8g
	 mKeTO4ObwcUC2+OyxrBUFcF6ovICMunK8lCIQIgR+AqdvzCkI0GjG8X1Rp61fv1x0O
	 sXYkIvLLfqVyEudSZNXUQ7C6skbTv82wU+p9IkYysxMfhaPHouWfsN/hk5ltc2+h0S
	 XzFm2ohqjonzRS2gKeLXiMhGX5iu1V+ZgCwo5e1vYgDR7B50640MCgmUl3IJbLWDcS
	 qOgK2IzFJaPYHpWQn+N9JUVQLiSVJ/DJXQoM6urufjCoLD8pjAm5mcQutss0xfdEOG
	 C2zeUU0iz2qHw==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v1 01/11] arm/pgtable: define PFN_PTE_SHIFT on arm and
 arm64
In-Reply-To: <794c1dc3-520c-4030-b0fe-e24782576347@redhat.com>
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-2-david@redhat.com>
 <fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com>
 <46080ac1-7789-499b-b7f3-0231d7bd6de7@redhat.com>
 <6703b648-10ab-4fea-b7f1-75421319465b@arm.com>
 <ae3d826f-758f-4738-b72a-e99f098bb2b3@csgroup.eu>
 <3a970289-a72f-418e-b43c-89f67f0d5283@redhat.com>
 <e0d9caab-39c7-446a-aeef-5d914d321c72@arm.com>
 <794c1dc3-520c-4030-b0fe-e24782576347@redhat.com>
Date: Wed, 24 Jan 2024 11:15:03 +0530
Message-ID: <8734unqo80.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Hildenbrand <david@redhat.com> writes:

> On 23.01.24 12:38, Ryan Roberts wrote:
>> On 23/01/2024 11:31, David Hildenbrand wrote:
>>>>>
>>>>>> If high bits are used for
>>>>>> something else, then we might produce a garbage PTE on overflow, but=
 that
>>>>>> shouldn't really matter I concluded for folio_pte_batch() purposes, =
we'd not
>>>>>> detect "belongs to this folio batch" either way.
>>>>>
>>>>> Exactly.
>>>>>
>>>>>>
>>>>>> Maybe it's likely cleaner to also have a custom pte_next_pfn() on pp=
c, I just
>>>>>> hope that we don't lose any other arbitrary PTE bits by doing the pt=
e_pgprot().
>>>>>
>>>>> I don't see the need for ppc to implement pte_next_pfn().
>>>>
>>>> Agreed.
>>>
>>> So likely we should then do on top for powerpc (whitespace damage):
>>>
>>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>>> index a04ae4449a025..549a440ed7f65 100644
>>> --- a/arch/powerpc/mm/pgtable.c
>>> +++ b/arch/powerpc/mm/pgtable.c
>>> @@ -220,10 +220,7 @@ void set_ptes(struct mm_struct *mm, unsigned long =
addr,
>>> pte_t *ptep,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ptep++;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 addr +=3D PAGE_SIZE;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * increment the pfn.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pte =3D pfn_pte(pte_pfn(pte) + 1, pte_pgprot((pte)));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pte =3D pte_next_pfn(pte);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0}
>>=20
>> Looks like commit 47b8def9358c ("powerpc/mm: Avoid calling
>> arch_enter/leave_lazy_mmu() in set_ptes") changed from doing the simple
>> increment to this more complex approach, but the log doesn't say why.
>
> @Aneesh, was that change on purpose?
>

Because we had a bug with the patch that introduced the change and that
line was confusing. The right thing should have been to add
pte_pfn_next() to make it clear. It was confusing because not all pte
format had pfn at PAGE_SHIFT offset (even though we did use the correct
PTE_RPN_SHIFT in this specific case). To make it simpler I ended up
switching that line to pte_pfn(pte) + 1 .

-aneesh

