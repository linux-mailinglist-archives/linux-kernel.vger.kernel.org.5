Return-Path: <linux-kernel+bounces-91950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22808718DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65605284826
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EC0548E3;
	Tue,  5 Mar 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsJgH1WE"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFF5026A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629353; cv=none; b=R7dzP0ZTFhMS72ujougrRl3ONW1MYm3k4WsOJXQY0EBInW18takBX88YWXEb9XM19g2SKIHO+gUhl2dHiRGgdm3EeZOtfE0AcriXgBD1IAsdqvAJYcheqIxbo4fQ3Xk+ViJ1Jt2rRkik0dxZpM5/ELpKpGBHI8ZUmFI0WWXVl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629353; c=relaxed/simple;
	bh=YTF54RnuRPU+Rv2eItHbB2OOwbzL8rjLvjPa2ZDXW8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXC1D9eleKj+d99S4uAanxqOWPs7ufMKTRkywlzTW9JLjHhThJMGRxrb3ELEsluumMVhnWsyN/v0+1wfvaL2CFtyylCiSNpbZK2dy+wdmIs3xRn7L9H37IHALt4XGVdGvC3sdhV1To4gjMXUiHHih3jI/uNH6DK4SEePMX8tEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsJgH1WE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7da763255b7so1999850241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709629351; x=1710234151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9O4/C5JIqFC23mQvpNgI9LI8n16+t6tllhELPHKHyw=;
        b=SsJgH1WET4x0+cIlwpMKvXUC9gAPoHKplNggN4ztwe8ehM3ugjPST3J6WAr+Mmr3tD
         PMtcpGTf5vsad726ma60g1a3i9phPWlChH4j6cqVX+vHKil7AdUJvRMVVKimZMmrItZ7
         NHhM3rcTo7GfxUlNf8j6DE2R9VUVloRC2o1wa1x5IJ8+DdYvpd1oOw4sbWED5AdwmoIT
         dNBhJux1YawvYrxKPCZMpMnSSlCY2WHOZjp/FYOhGVJrPMs9OSnEFIqAmqKFmvBXEayr
         dwr8aHy8mB1GhPOu2PRXQSIGht073ckpR3KZH2mabpQYaGpIWwKS53m6w1mocbgjsssj
         bIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629351; x=1710234151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9O4/C5JIqFC23mQvpNgI9LI8n16+t6tllhELPHKHyw=;
        b=thyNAK76zeU7U8ZOSkGw1ycsjvMmdo8svBpC6Yu6mQnS2s/jGz+/M7uzjbJJGAq4aF
         gECx2f5WsLqPiSjdiiiZ8QamXTVj6v2194YLI+WSZqobn1IoCkx39kiztcfVYUw3fLyL
         xEigqdFYWwZXzMRQznKJmBBOx8MxIUTVw/FGLtBjGLwYOzuWDbEh2xsBr6RXJiRG4WPD
         3yVGQiptj68byG48Xa9EWZcsx6eNVIw0a3X68gaMiFKvPq2DLsLdim3+/y6trCU4WZxB
         nlqLFyiU6oDnY4HSdZXSQKB+owICKYfqPbc8t6fZIt/46hHzW2cfeTFcre5VG1MGs6+U
         wHcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+6gnOHPdQIdQOo1ZukG04+0UVZzy0HKP8STR3GomwxaOAj+rOYb/HgxxqLpjM+zFKwpqwoJL7W1zlXWRK6DiRDUkCg8E06gImEP7I
X-Gm-Message-State: AOJu0YyKyZrDpGxHQ5FAG4oUjc/4VllqSETLGpBxPLVfov80LUCv84Bi
	KmmS4RzXAzavIDEXX5Mz7P4hAq8FPStMZJUEn8xogyEZQ/+hgo3NZvtNeYUyXNLy+0faVUjDwe7
	Ttz14ERsiP/UfestqJkrql3Np2v0=
X-Google-Smtp-Source: AGHT+IEstg6+xCVsEJBmJXw14YeuMGvQQFKdM/Rms94gAjBGAqimP19wTmiZegJOv2e5dCwOf93YtjJTvGronMossZg=
X-Received: by 2002:a05:6122:30c:b0:4b8:383e:8266 with SMTP id
 c12-20020a056122030c00b004b8383e8266mr885132vko.11.1709629350734; Tue, 05 Mar
 2024 01:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com> <CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
 <804524c8-772c-42d0-93a5-90d77f13f304@redhat.com> <CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
 <87r0gp868d.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87r0gp868d.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 22:02:18 +1300
Message-ID: <CAGsJ_4xUdqpWaYDrNV3Fbh=3cWyoDJz3AbWa=mfsKbka+MAVag@mail.gmail.com>
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

On Tue, Mar 5, 2024 at 8:55=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Mar 5, 2024 at 10:15=E2=80=AFAM David Hildenbrand <david@redhat=
com> wrote:
> >> > But we did "resolve" those bugs by entirely untouching all PTEs if w=
e
> >> > found some PTEs were skipped in try_to_unmap_one [1].
> >> >
> >> > While we find we only get the PTL from 2nd, 3rd but not
> >> > 1st PTE, we entirely give up on try_to_unmap_one, and leave
> >> > all PTEs untouched.
> >> >
> >> > /* we are not starting from head */
> >> > if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw.pt=
e))) {
> >> >                     ret =3D false;
> >> >                     atomic64_inc(&perf_stat.mapped_walk_start_from_n=
on_head);
> >> >                     set_pte_at(mm, address, pvmw.pte, pteval);
> >> >                     page_vma_mapped_walk_done(&pvmw);
> >> >                     break;
> >> > }
> >> > This will ensure all PTEs still have a unified state such as CONT-PT=
E
> >> > after try_to_unmap fails.
> >> > I feel this could have some false postive because when racing
> >> > with unmap, 1st PTE might really become pte_none. So explicitly
> >> > holding PTL from 1st PTE seems a better way.
> >>
> >> Can we estimate the "cost" of holding the PTL?
> >>
> >
> > This is just moving PTL acquisition one or two PTE earlier in those cor=
ner
> > cases. In normal cases, it doesn't affect when PTL is held.
>
> The mTHP may be mapped at the end of page table.  In that case, the PTL
> will be held longer.  Or am I missing something?

no. this patch doesn't change when we release PTL but change when we
get PTL.

when the original code iterates nr_pages PTEs in a large folio, it will ski=
p
invalid PTEs, when it meets a valid one, it will acquire PTL. so if it gets
intermediate PTE values some other threads are modifying, it might
skip PTE0, or sometimes PTE0 and PTE1 according to my test. but
arriving at PTE2, likely other threads have written a new value, so we
will begin to hold PTL and iterate till the end of the large folio.

The proposal is that we directly get PTL from PTE0, thus we don't get
intermediate values for the head of nr_pages PTEs. this will ensure
a large folio is either completely unmapped or completely mapped.
but not partially mapped and partially unmapped.

>
> --
> Best Regards,
> Huang, Ying
>
>
> > In normal cases, page_vma_mapped_walk will find PTE0 is present, thus h=
old
> > PTL immediately. in corner cases, page_vma_mapped_walk races with break=
-
> > before-make, after skipping one or two PTEs whose states are transferri=
ng,
> > it will find a present pte then acquire lock.
> >
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >
Thanks
Barry

