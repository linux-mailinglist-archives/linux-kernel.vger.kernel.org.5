Return-Path: <linux-kernel+bounces-96725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF68760AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14731C219DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02752F8F;
	Fri,  8 Mar 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2KdkHYg"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741F524DE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888886; cv=none; b=Pt/su5457TVxPY8KUSTvVUYNb1WFESzpjC+1xInSM5u/WouSceQUdHbIrhQz9ae2jvDHi0C1lMVsk6D3jorqfkdYQiT1HDphurVGdIBAnf3+cCz/tRAn4NmrgQslemQfPB9xnqGn8Ou2VyxKnZt/nnMryrb5HGrbuyvFjkUBLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888886; c=relaxed/simple;
	bh=wVqgbOoMGqLcnUb/Mb5PUTcHXLDgjSytbNSqeiZEQpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGDaud4Fe9tQK2MbD8P6ChzpBEErogWfiXcwWaSStR/P9MW0dF9DycM4oVICOcLAjI/sJJT0/WN6sDps+SCd8CGGWVxVQKYyvbHlqGQ8wIQuOhcRRyYADuAD+AduSpCj2YuQmGWfC0TYK4dhi/ijvMUdZMLIG4sTkvwfLPKX6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2KdkHYg; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so325883241.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709888884; x=1710493684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss+8devJZ1E5Fnt41gZaOZT4I7WsgKy/EVaBoBRvx64=;
        b=A2KdkHYgAAMMpgBkhlfp8FYizuOByRk4VYTWydqgCnGS/iSkYYOg/14mUZMQMYzHg3
         DENUV1wIyujIegNDcQ5YoCRy1K/8rKofM6SCgxNloQ1QLeZ3gBn1srhaVHH0NGjYyvJw
         QIRRNzDRHtGda/mijKt6Qso0+Jq1lBJQxxxBC1+UfxubhKUkBEEAsKzyGEjQzHFP7FOY
         SrVigrPL1dEFHnyPAJd8zW+AYSj/QdqUcoOXHp50B7UPC2DkbP2pC4YP+nf4/YzOo6wd
         OvlshZHBstnUwd3SB4i7kwvxSAnJUPfsuaaSCPiaz5cL/wFlM4i1ItUNTbfDomxl5qUJ
         /8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888884; x=1710493684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss+8devJZ1E5Fnt41gZaOZT4I7WsgKy/EVaBoBRvx64=;
        b=VnT3zcgjR5n/uis+J2QbQcXptrlB9SrzaivIyudhH9xz/CiRk8k+bp3/JpsqmpsUs+
         xZ4iYmFnxmSj3f1Lg5vbMbDzF+Szw4dJmHPwDxplGXaHH4rVudjM7mqRUzhUe0MttIqn
         XevR1UMEhN/4LgHRyzGQTz/3/jBnaOmtwnWHADZdL0aWb4yHtU7FfvCoSeQtjvbPmySw
         cPKkfNSF3Zt+PktWR8k/DGQwDPO0CNUH3HmV4dqGueEbnQt4QnmssBheAiDSRe+9WDxh
         LkSE1kzn7MA4+PP4lZXwZ6+G8zCkY2FIEcZ2l0HrcRK/wF92iaZ07T6fRwWXcKoe6otJ
         5LuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXShyeSwhG2QQiYA6Hw1vCyiAxxk6tEW7eaO+PwCQwMk17yfA+tptW/gvQ0v8pkUZkJdChpoeya0rfwFiZTw+KAWMNlShzToTeQpNvB
X-Gm-Message-State: AOJu0Ywy/BPZ+pdlvH2TAlvlBPai0EuILZNFUC48tIPdqxNM7ejTfKyS
	rKryoRwY5yNhaG7G/h/qcdWYnjcw9xSXyxzTEkkVJJ3faZaYlUCq7XgkinWZTBp+MVWqdSBcIi+
	FT+rnLVsYvMycC36pXffio/G3f1s=
X-Google-Smtp-Source: AGHT+IHxzxsD+L50os7+Tl61TNXHL8RdQK46GzAyJZPjzZtJqKcP15hxF9j8PmtDsl0xoTXICDKk9FMnZbGzOOUhyEs=
X-Received: by 2002:a05:6122:2912:b0:4d3:48b9:3c91 with SMTP id
 fm18-20020a056122291200b004d348b93c91mr11474717vkb.5.1709888884106; Fri, 08
 Mar 2024 01:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308085653.124180-1-21cnbao@gmail.com> <4392e407-b9cf-4785-a926-3eb143708260@redhat.com>
In-Reply-To: <4392e407-b9cf-4785-a926-3eb143708260@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Mar 2024 22:07:52 +1300
Message-ID: <CAGsJ_4zvsW-h24s9PGn-U-6=HO-U7hjWfNiNe5O6ZX-cwnkT3w@mail.gmail.com>
Subject: Re: [PATCH] mm: prohibit the last subpage from reusing the entire
 large folio
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, minchan@kernel.org, 
	fengwei.yin@intel.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	peterx@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com, 
	songmuchun@bytedance.com, wangkefeng.wang@huawei.com, xiehuan09@gmail.com, 
	zokeefe@google.com, chrisl@kernel.org, yuzhao@google.com, 
	Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:03=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 08.03.24 09:56, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > In a Copy-on-Write (CoW) scenario, the last subpage will reuse the enti=
re
> > large folio, resulting in the waste of (nr_pages - 1) pages. This waste=
d
> > memory remains allocated until it is either unmapped or memory
> > reclamation occurs.
> >
> > The following small program can serve as evidence of this behavior
> >
> >   main()
> >   {
> >   #define SIZE 1024 * 1024 * 1024UL
> >           void *p =3D malloc(SIZE);
> >           memset(p, 0x11, SIZE);
> >           if (fork() =3D=3D 0)
> >                   _exit(0);
> >           memset(p, 0x12, SIZE);
> >           printf("done\n");
> >           while(1);
> >   }
> >
> > For example, using a 1024KiB mTHP by:
> >   echo always > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/en=
abled
> >
> > (1) w/o the patch, it takes 2GiB,
> >
> > Before running the test program,
> >   / # free -m
> >                  total        used        free      shared  buff/cache =
  available
> >   Mem:            5754          84        5692           0          17 =
       5669
> >   Swap:              0           0           0
> >
> >   / # /a.out &
> >   / # done
> >
> > After running the test program,
> >   / # free -m
> >                   total        used        free      shared  buff/cache=
   available
> >   Mem:            5754        2149        3627           0          19 =
       3605
> >   Swap:              0           0           0
> >
> > (2) w/ the patch, it takes 1GiB only,
> >
> > Before running the test program,
> >   / # free -m
> >                   total        used        free      shared  buff/cache=
   available
> >   Mem:            5754          89        5687           0          17 =
       5664
> >   Swap:              0           0           0
> >
> >   / # /a.out &
> >   / # done
> >
> > After running the test program,
> >   / # free -m
> >                  total        used        free      shared  buff/cache =
  available
> >   Mem:            5754        1122        4655           0          17 =
       4632
> >   Swap:              0           0           0
> >
> > This patch migrates the last subpage to a small folio and immediately
> > returns the large folio to the system. It benefits both memory availabi=
lity
> > and anti-fragmentation.
> >
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Lance Yang <ioworker0@gmail.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   mm/memory.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e17669d4f72f..0200bfc15f94 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3523,6 +3523,14 @@ static bool wp_can_reuse_anon_folio(struct folio=
 *folio,
> >               folio_unlock(folio);
> >               return false;
> >       }
> > +     /*
> > +      * If the last subpage reuses the entire large folio, it would
> > +      * result in a waste of (nr_pages - 1) pages
> > +      */
> > +     if (folio_ref_count(folio) =3D=3D 1 && folio_test_large(folio)) {
> > +             folio_unlock(folio);
> > +             return false;
> > +     }
> >       /*
> >        * Ok, we've got the only folio reference from our mapping
> >        * and the folio is locked, it's dark out, and we're wearing
>
>
> Why not simply:
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e17669d4f72f7..46d286bd450c6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3498,6 +3498,10 @@ static vm_fault_t wp_page_shared(struct vm_fault
> *vmf, struct folio *folio)
>   static bool wp_can_reuse_anon_folio(struct folio *folio,
>                                      struct vm_area_struct *vma)
>   {
> +
> +       if (folio_test_large(folio))
> +               return false;
> +
>          /*
>           * We have to verify under folio lock: these early checks are
>           * just an optimization to avoid locking the folio and freeing
>
> We could only possibly succeed if we are the last one mapping a PTE
> either way. No we simply give up right away for the time being.

nice !

>
> --
> Cheers,
>
> David / dhildenb
>

