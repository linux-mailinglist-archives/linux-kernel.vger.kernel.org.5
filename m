Return-Path: <linux-kernel+bounces-142665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3468A2E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE0B2247B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B25914E;
	Fri, 12 Apr 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfqyyvYJ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E73BBC3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926028; cv=none; b=JKDgGaxSNH4vdPN//obViJFe2YuYRooMT/kMlxfYUr2SV6PICeRdsKWGXlXfSlG2BAnwseJYUlt+DX5yv9l748Ohb/bQn850dok0NuPZ/G8kZsFwRup32EpnreU6OxYFetHMO2Nyw79Q/P+i0A5Dw/kGeZNLhlkJOXajpvnuU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926028; c=relaxed/simple;
	bh=YMEv9nfCTRdb23MZLqU4t4+ChnuYRbUYDBnLYpTmJdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMMXgA5mmk3avB5AykCqc/e7eTRypaKhOy8qVS1Zlso6QtP7A4y0KHVcGESfiQQMFflYcV8gEKpMk+wgKD9G0mowRXVN2NtXiq5cRRvgIYbZrFL/6p++6Z47B25httudqMbLic58FASlCcM4ZB7dy/feRUQ9tGcUh5j7VdCHMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfqyyvYJ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ddda842c399so905200276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712926025; x=1713530825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Fr7UK4mXSasVYjxfIK4yXcjvIBvCQKhIDx0tN0PsE=;
        b=ZfqyyvYJiENd7CkCUH+wzpZKo5CRl//WaQKOMGTwQEJS+O9wYD1RNylt5ZvQLfN7/H
         psmzCKxZAgWpObMbdCuksy6O9wS2uLjKBrpgp0yDi1+JDuQDRuGRNtBaE6k3d+LZrJEH
         08ZM1xt0J/uI7hH7t4YJonA/7sbxD8yTN4Drv/kxvAiGc4uYiZWCjW/9oszIGAcbOO+a
         8a+r4bYYGWzH3tk4fRIJp0cPZGloFcNA6eEo2kbRDu3VJwaCxuaQgMvkcgP8Tp4cKR0I
         +Xd+9win5uxYz/i4pbVzsYn2rSIPeafPIFCCuGzqB8BVOZhw0TcmGGL0JvqkW6Jr8Dcg
         Fqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712926025; x=1713530825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2Fr7UK4mXSasVYjxfIK4yXcjvIBvCQKhIDx0tN0PsE=;
        b=tF//3H1BXU64buqQ1ixePJ7UNfNOs+K0J/u31dROnyelEVy+lEYISNWimMdRqRTTDu
         IjsdPxX8CM4vR2cKx2jX8VTNPEZFSbXUaj3BNaLbwWQK75nv1WklodG4wqgBZwaEJjJ9
         Fy/AqXHp5L7kuOuMF5pdRhim1tbuzIbij2dBtyQ5r6LCy6LMOugxrdfmPzw1aOqt5lCS
         Yo6oEApUSpBV4ExAhEIAdua4D0s/hP6tHx+0UddCbgoJsoxLgyiWC+N/erDLR+taz6fC
         IKZE+szMSBRHAsPkR0JdS2k4/0cTCBITEltn0VJ28GHyR2EBoThJJYfFBkukZrJv1+g4
         phkw==
X-Forwarded-Encrypted: i=1; AJvYcCU7CCSNSV4uRmDyVcAW1wpUr95s5EpH1WO6EDmH3vyCser8YAzon1n75pVRAYWG+5bA3Dzqcm2mdG/TpzUze013gysJD5u6ZTv7rGF5
X-Gm-Message-State: AOJu0YxUKm68iYZhP5xqTiFp6cL35RtbRsKe/njiLZVDbMSHVcl7N565
	IA9gPAwebWORjLdhJ7oEF7kwtcQGEJpJqy1WQsVmv40+csjXkACYhziopWQdzPY3AA4MsGB/lBv
	J3EUIzfVI7E2vJ26bDfX8Wu1u/+afVvD7tisN
X-Google-Smtp-Source: AGHT+IEUnwxxPaCmtySQz7Q+LylZTS3MDBGhFYQXUOnNmSWMxVKq8j1tJJQKGjpGuuoPSrYprw6C7Khax0/3CXocyEA=
X-Received: by 2002:a25:a128:0:b0:dcc:f5d4:8b43 with SMTP id
 z37-20020a25a128000000b00dccf5d48b43mr2409323ybh.9.1712926025188; Fri, 12 Apr
 2024 05:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170621.2011171-1-peterx@redhat.com> <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n> <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n> <Zhhd-A7w1A8JUadM@casper.infradead.org> <ZhinCD-PoblxGFm0@casper.infradead.org>
In-Reply-To: <ZhinCD-PoblxGFm0@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Apr 2024 05:46:52 -0700
Message-ID: <CAJuCfpHpewmiyMxyPd_A8KSyQ6tB-1wHLV-FJ7KBrpV=RY9F7w@mail.gmail.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:14=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Apr 11, 2024 at 11:02:32PM +0100, Matthew Wilcox wrote:
> > > How many instructions it takes for a late RETRY for WRITEs to private=
 file
> > > mappings, fallback to mmap_sem?
> >
> > Doesn't matter.  That happens _once_ per VMA, and it's dwarfed by the
> > cost of allocating and initialising the COWed page.  You're adding
> > instructions to every single page fault.  I'm not happy that we had to
> > add extra instructions to the fault path for single-threaded programs,
> > but we at least had the justification that we were improving scalabilit=
y
> > on large systems.  Your excuse is "it makes the code cleaner".  And
> > honestly, I don't think it even does that.
>
> Suren, what would you think to this?
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 6e2fe960473d..e495adcbe968 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
>         if (!vma_start_read(vma))
>                 goto inval;
>
> -       /*
> -        * find_mergeable_anon_vma uses adjacent vmas which are not locke=
d.
> -        * This check must happen after vma_start_read(); otherwise, a
> -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the=
 VMA
> -        * from its anon_vma.
> -        */
> -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> -               goto inval_end_read;
> -
>         /* Check since vm_start/vm_end might change before we lock the VM=
A */
>         if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
>                 goto inval_end_read;
>
> That takes a few insns out of the page fault path (good!) at the cost
> of one extra trip around the fault handler for the first fault on an
> anon vma.  It makes the file & anon paths more similar to each other
> (good!)

I see what you mean. The impact would depend on the workload but in my
earlier tests when developing per-VMA locks there were on average less
than 1% faults which were for anonymous pages and had
vma->anon_vma=3D=3DNULL. I recorded that after using my desktop for a day
or so and running a series of benchmark tests. Again, that number
might be drastically different on some other workloads.

About the code, I'll take a closer look once I'm back from vacation
this weekend but I think you will also have to modify
do_anonymous_page() to use vmf_anon_prepare() instead of
anon_vma_prepare().

>
> We'd need some data to be sure it's really a win, but less code is
> always good.
>
> We could even eagerly initialise vma->anon_vma for anon vmas.  I don't
> know why we don't do that.

You found the answer to that question a long time ago and IIRC it was
because in many cases we end up not needing to set vma->anon_vma at
all. So, this is an optimization to try avoiding extra operations
whenever we can. I'll try to find your comment on this.

