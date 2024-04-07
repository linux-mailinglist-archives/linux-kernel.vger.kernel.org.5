Return-Path: <linux-kernel+bounces-134226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B8B89AF3E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7216283FF7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802CD304;
	Sun,  7 Apr 2024 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dNt3tV3X"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB17483
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712475439; cv=none; b=AT8+VQSpL/yezrIXhKaggAUfmzEgOHcrIVCvLprbe29SIFVCM2mxJuEhUUL6HZubaQf2V8Rk3pU884NhARn1tIo6rGka17e4B897dUFKtkFrkjw7xpMbJ01tSPC5nzdJ7Z9cAWAeFI0cGJZv94W8OVhCO7bIJWdJWLOycPXsdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712475439; c=relaxed/simple;
	bh=ifvSm+8K5bMmWjHLvREuVwcxQRti83HpgGfPaXqTGSs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=em8POCu/4wDUvIaiQLM48jqaA762JNQFR7Yx1asfUMziQpSkM3DQ/l5LzxkbYxTuteVTLaXBf1nXYx/Hsmc7M1rLfwdZa2mulE7PRWsOug8HOunCGdhEbiwYGQjDXLy6HYAS9h1G3VeMCYs+xA61MGKk5xah7BMoBYXQRBm6PgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dNt3tV3X; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712475434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bahn4KQkeBpv/q05dP0qudxz14FvAOhzQLd0ktghZo=;
	b=dNt3tV3X/x1eFdBkdX9rtEbIxNSBBvklJ9jTVTQMJBQbW0XgXfH2oqZlTeJOMjcan7QjRi
	yM+MxrtNmgsKHnvPgTlCs6QpZ4aJ6HEvOOkUOQtMkYlJkfw60fwDjulqvo/rrBoi18nYDC
	zwGnXXkMgQGBWyJtt7dBxR51t8rMHiE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 1/3] hugetlb: Convert hugetlb_fault() to use struct
 vm_fault
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAOzc2pxfUSnT6fEXAJZowYeMz=hCgWsfJRB++dis1AL_rNScGQ@mail.gmail.com>
Date: Sun, 7 Apr 2024 15:36:39 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE21834D-E805-40AE-AFC3-E43C72BE5A15@linux.dev>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-2-vishal.moola@gmail.com>
 <Zg6cualUqcsZYZxf@localhost.localdomain>
 <CAOzc2pxfUSnT6fEXAJZowYeMz=hCgWsfJRB++dis1AL_rNScGQ@mail.gmail.com>
To: Vishal Moola <vishal.moola@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 5, 2024, at 03:32, Vishal Moola <vishal.moola@gmail.com> wrote:
>=20
> On Thu, Apr 4, 2024 at 5:26=E2=80=AFAM Oscar Salvador =
<osalvador@suse.de> wrote:
>>=20
>> On Mon, Apr 01, 2024 at 01:26:49PM -0700, Vishal Moola (Oracle) =
wrote:
>>> Now that hugetlb_fault() has a vm_fault available for fault =
tracking, use
>>> it throughout. This cleans up the code by removing 2 variables, and
>>> prepares hugetlb_fault() to take in a struct vm_fault argument.
>>>=20
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>=20
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>=20
>> A question below:
>>=20
>>> mm/hugetlb.c | 84 =
+++++++++++++++++++++++++---------------------------
>>> 1 file changed, 41 insertions(+), 43 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 8267e221ca5d..360b82374a89 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>> ...
>>>      /*
>>> -      * entry could be a migration/hwpoison entry at this point, so =
this
>>> -      * check prevents the kernel from going below assuming that we =
have
>>> -      * an active hugepage in pagecache. This goto expects the 2nd =
page
>>> -      * fault, and is_hugetlb_entry_(migration|hwpoisoned) check =
will
>>> -      * properly handle it.
>>> +      * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at =
this
>>=20
>> "vmf.orig_pte could be a migration/hwpoison entry at ..."
>>=20
>>> -     entry =3D pte_mkyoung(entry);
>>> -     if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
>>> +     vmf.orig_pte =3D pte_mkyoung(vmf.orig_pte);
>>> +     if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, =
vmf.orig_pte,
>>>                                              flags & =
FAULT_FLAG_WRITE))
>>=20
>> Would it make sense to teach =
huge_ptep_set_access_flags/set_huge_pte_at() to use
>> vm_fault struct as well? All info we are passing is stored there.
>> Maybe it is not worth the trouble though, just asking.
>=20
> Yeah, it makes sense. There are actually many function calls in the
> hugetlb_fault() and
> __handle_mm_fault() pathways that could make use of vm_fault to clean
> up the stack.
>=20
> It's not particularly complicated either, aside from reorganizing some
> variables for every
> implementation of each function. I'm not really sure if it's worth
> dedicated effort
> and churn though (at least I'm not focused on that for now).

Not all the users of set_huge_pte_at() have a vmf structure. So I do not
think it is a good idea to change it. And huge_ptep_set_access_flags() =
is
a variant of ptep_set_access_flags(), it's better to keep consistent.
Otherwise, I think both of them should be adapted if you want cleanup.
My tendency is to remain unchanged.

Muchun,
Thanks.




