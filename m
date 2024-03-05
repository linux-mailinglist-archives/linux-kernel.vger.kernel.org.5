Return-Path: <linux-kernel+bounces-91993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E44871979
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9271F239D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AB524D0;
	Tue,  5 Mar 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBiHkQVX"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76A50A69
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630517; cv=none; b=fx3N8rWdgTwUgMvI7tg2MmzZY/YoEWFwdlENLVw0iwqqJ1ALNGwgzGKHfQxLUwBGD3IjBohluScisIA+HCJRW7Yelxyo5h6B2qbzUPPT/8d13RdcJOCze1HWayXhXpBJN2dKEeu3xeV3DDjk9CoTYluNMO8Sk75aYXagDlGOXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630517; c=relaxed/simple;
	bh=tSug6WA7S3J/jl6aSD4ovNDbyn0BnpOAACsZdgPC1Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRo+nUag+MG7h7Miwkl3t6ZLZu0pOfY+DT9gGuINwOS5F36hnKa+agmvGc2H19y5q4R9+JBrpplJlQPXJ8wYfcXcIm8kV37QbhfSMy04WLoHzE3qgTTZXWLsjjmLtOT2MtFh0GeU5E9bFfunswr/9tamli2xuAhwEqi7sqZ4W3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBiHkQVX; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db44846716so232016241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630514; x=1710235314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id7WtNTe1LzwKP1cNlJHEDlQn7HJgOx4TEWTCZ+ujxA=;
        b=UBiHkQVXoVJCtL6dWj+sHmzYkT8L4wvrDzBO/53RbMEx2PM4NDBUala3geKV3tj2K/
         zH89j9uZL92D6K+bnkTXk4rjsuQFyDv/hy4/dPokPegWRLdieo1REnuUbHe3s9GFnFYI
         ceKugg5zRKsLsfJY3TfkPKtHkTnyXg01ylwOd9VAV/Oyrbyg9zAZfiojDtsPUrmuXEpn
         CS/n9+vslElwwBS8CzEKgZxghFYuWEjEQxxde4ldsQjj0fyfRZ9sWWemksckHvfoM3HU
         ToIvy/TxCWPLvVdMhKuj37qBHwWu0Vtp9LzgMhqFs8Mu885FJoxAjeW7/jte4hbjOkax
         rXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630514; x=1710235314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id7WtNTe1LzwKP1cNlJHEDlQn7HJgOx4TEWTCZ+ujxA=;
        b=U6Pad33E/ptd+LTJ/js0TD7nknsv2aw6HhdQLUGqQUW1iP/AbRYWZJXxZVRyI7adhf
         bx6p7xA7GR0pC05jicvkHAQQyMVSrMZZHlx7TPB+D2h0U88n8rYKhjR1RWQmAOCD5SqZ
         ScQOqMEE1Ze04ZjscEf9XnpMl4j3uWky8IgxssKLJCtD5HcGubwRmyeFEd5Iu6apyuul
         WUOkIDRSAFFz43tZfv70kGzcUQE9lHrO+Yi63rN1n9IMR7I6fhVXX3PX5veObGAnG6Ar
         Ds7KbJ6PhfZVH5LCJFmpu0P1wmLCEbL7KqP6kcFrSO0seZVIft/+n3+4C0MwPdnZvkmi
         vz1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3zoYyRaCty1k9jeYc2BubJJEBZfMsgLaWVtgrBPSgLyxp5zESeo737HQOqTTUoY4Y2VrgiaDqotfkCP7b0csFASze/7MwXXs5KxJS
X-Gm-Message-State: AOJu0Yym7Cfqbabhn5/6WjGqTSk+YT38nP3/oN+KzzJoc6PP1AimNqLW
	cTgPx1x6NdJZ/SUy4/Qx4sVAnL4++MC4lhKq1H2paA5ABLMg53QbHTXvVZZEWLEA7UxyqezKS2/
	mI55OGjXov+l8lOmYXvixm4NZ1DM=
X-Google-Smtp-Source: AGHT+IEjvhkKPprfha6QhgiHusnogY8KSenenoJcr4StfYITppop2KKbZFy+i/DOA9qFHT3FXrb28iF5pROZZ8owkuw=
X-Received: by 2002:a05:6102:5110:b0:472:bfaa:2f5c with SMTP id
 bm16-20020a056102511000b00472bfaa2f5cmr1357477vsb.9.1709630514618; Tue, 05
 Mar 2024 01:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
 <804524c8-772c-42d0-93a5-90d77f13f304@redhat.com> <CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
 <87r0gp868d.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xUdqpWaYDrNV3Fbh=3cWyoDJz3AbWa=mfsKbka+MAVag@mail.gmail.com>
 <87il2182nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87il2182nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 22:21:43 +1300
Message-ID: <CAGsJ_4wYVogJD=ROfX195MPZrqK+=ibuycPBeFjrD1i9SvOqrw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, chrisl@kernel.org, yuzhao@google.com, 
	hanchuanhua@oppo.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:12=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Mar 5, 2024 at 8:55=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Tue, Mar 5, 2024 at 10:15=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >> >> > But we did "resolve" those bugs by entirely untouching all PTEs i=
f we
> >> >> > found some PTEs were skipped in try_to_unmap_one [1].
> >> >> >
> >> >> > While we find we only get the PTL from 2nd, 3rd but not
> >> >> > 1st PTE, we entirely give up on try_to_unmap_one, and leave
> >> >> > all PTEs untouched.
> >> >> >
> >> >> > /* we are not starting from head */
> >> >> > if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw=
pte))) {
> >> >> >                     ret =3D false;
> >> >> >                     atomic64_inc(&perf_stat.mapped_walk_start_fro=
m_non_head);
> >> >> >                     set_pte_at(mm, address, pvmw.pte, pteval);
> >> >> >                     page_vma_mapped_walk_done(&pvmw);
> >> >> >                     break;
> >> >> > }
> >> >> > This will ensure all PTEs still have a unified state such as CONT=
-PTE
> >> >> > after try_to_unmap fails.
> >> >> > I feel this could have some false postive because when racing
> >> >> > with unmap, 1st PTE might really become pte_none. So explicitly
> >> >> > holding PTL from 1st PTE seems a better way.
> >> >>
> >> >> Can we estimate the "cost" of holding the PTL?
> >> >>
> >> >
> >> > This is just moving PTL acquisition one or two PTE earlier in those =
corner
> >> > cases. In normal cases, it doesn't affect when PTL is held.
> >>
> >> The mTHP may be mapped at the end of page table.  In that case, the PT=
L
> >> will be held longer.  Or am I missing something?
> >
> > no. this patch doesn't change when we release PTL but change when we
> > get PTL.
> >
> > when the original code iterates nr_pages PTEs in a large folio, it will=
 skip
> > invalid PTEs, when it meets a valid one, it will acquire PTL. so if it =
gets
> > intermediate PTE values some other threads are modifying, it might
> > skip PTE0, or sometimes PTE0 and PTE1 according to my test. but
> > arriving at PTE2, likely other threads have written a new value, so we
> > will begin to hold PTL and iterate till the end of the large folio.
>
> Is there any guarantee that the mTHP will always be mapped at the
> beginning of the page table (PTE0)?  IIUC, mTHP can be mapped at PTE496.
> If so, with your patch, PTL will be held from PTE0 instead of PTE496 in
> some cases.

I agree. but in another discussion[1], the plan is if we find a large folio=
 has
been deferred split, we split it before try_to_unmap and pageout. otherwise=
,
we may result in lots of redundant I/O, because PTE0-495 will still be
pageout()-ed.

[1] https://lore.kernel.org/linux-mm/a4a9054f-2040-4f70-8d10-a5af4972e5aa@a=
rm.com/

>
> --
> Best Regards,
> Huang, Ying
>
> > The proposal is that we directly get PTL from PTE0, thus we don't get
> > intermediate values for the head of nr_pages PTEs. this will ensure
> > a large folio is either completely unmapped or completely mapped.
> > but not partially mapped and partially unmapped.
> >
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying
> >>
> >>
> >> > In normal cases, page_vma_mapped_walk will find PTE0 is present, thu=
s hold
> >> > PTL immediately. in corner cases, page_vma_mapped_walk races with br=
eak-
> >> > before-make, after skipping one or two PTEs whose states are transfe=
rring,
> >> > it will find a present pte then acquire lock.
> >> >
> >> >> --
> >> >> Cheers,
> >> >>
> >> >> David / dhildenb
> >> >

Thanks
Barry

