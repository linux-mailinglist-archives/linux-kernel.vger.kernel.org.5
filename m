Return-Path: <linux-kernel+bounces-79815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF7862721
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855E4B225B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D34D117;
	Sat, 24 Feb 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAU6cvq7"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F364CB2E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804262; cv=none; b=hqs644b8f5tcqkriT3Qg3UYbzWP/JhA9sWdl/HjrAI58ynka/VlXoN2s6tt8CyKoC7/1wsCfuDCHr1X4ZsDB6JyCB/So2O3wA2XpsAAlcTIZHCAe3E2/aYyg8YyOVtwh1ihP6vty1pceoPq+Yx8TKtBc3oqbXny3GpH2uPoYS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804262; c=relaxed/simple;
	bh=UUOl8o7DjiXMVjLqrNIsV/C14xGDcsMvBb7EYvJHBwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkhSGy9WrEHm1GeqOV4KMDVuHNQ4WTE1PqpVSccmNpCt6yTjI71WgoJOit2B5OaGTkhwU9vseSH4QPqX3DVmHKtQ896ziqrWnDi3qMGNX0bzCWJ9w2Meh+uCxSmzMYLfoyhxHgeMBf7NObhg2g88MxrldcSRHkIq6MxWrsHtRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAU6cvq7; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7da763255b7so32253241.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708804259; x=1709409059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFYaLycgFe8j4foajRXoyAWo+795ANMIvzzRfRsQJF0=;
        b=XAU6cvq7sVIZ+GegtihXNKO66yrYFpxoz7zklZyjd1GPCyncfiAYSbKicM1qBUggr6
         0ugLrB4vnxk7mBMLLlaJB9fwZIR0+u1izZHvXgP3v7UyIa0ZiOXySnJ3M/x8VwYx9id/
         3qsXLbqhSxlpHeY9sJ6QppsuGmIBP2PipUniFY8gwqbC1aZnShsUrK9uZizsKF25+3NF
         +K1a679yrhiPqmFqhgPk4UMXrh/1QSZrtu4Br6BTYfimbAsO9eIs3SawMNnh3xz6Uquc
         AfAt2W1dN0aVmCF2xGxPut1X0Wo+85hJ4cosAoNN/BDWhGJ6W6R3XSpUCmzPinvYWLiQ
         hN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708804259; x=1709409059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFYaLycgFe8j4foajRXoyAWo+795ANMIvzzRfRsQJF0=;
        b=WiT4LHz77f8zFzQFNszop1V6exKQsHjAB8s7rj0vsrMJPqJfzz4A2FOzyHmAghupal
         JCnYi6PKmbGodxqOVQ5+5fsy9t+0vsoi543caSy6b56Wv81T0FiuY+YyVQcxdNHq+kZ4
         s1WEHtSSKaDAKcDlHVxc6DzREQlSudh1H2IO+akdqqUygFAscb3YgTuQm709RdQgVjxz
         BwHTDn39Ee4z83aVCPA6qQLvKa65BzpD8rxLQIXctDr71vVeNCfIMf9zt7FAzUBAv4qY
         VVppyaaCbdI/5PpMCPuhf7AYEDAO8+3ncsRMpEaASc1g69Lp390ryX5ikdaSi4JYI1fJ
         xGEw==
X-Forwarded-Encrypted: i=1; AJvYcCU09qiCg+p0pguWTZ9p1PK/sE0xJNpOnRMEWMdMjebm+UaVuG3Nono4lpBUIq6YH/k++9Vxjvf/ksmlrWVAYVFZE3BLLr7ZKIxfS++z
X-Gm-Message-State: AOJu0YwGMNRp3h9qudEho1PticuqNjTNq2bo3lRIFaymKV3DqGVz4uAp
	sbP77+Sk4gFiW5PgS59DKIouYSk/hCGlF+Yz1OLKSxFgBYnXcrp1vlOHmQhS23fuXoRVjASrNVJ
	PP+GjsyJahpMGA91SgQ0hSYWl3vM=
X-Google-Smtp-Source: AGHT+IEkpVS/KLRMQPnw9X+wbLmx8m3CphQHdqOKfKZj2lOQX8oXUjoSzV2wjU0pHsir6K65f5qJDRQfuUb9ylYVQPU=
X-Received: by 2002:a05:6102:1613:b0:471:e1cd:8c35 with SMTP id
 cu19-20020a056102161300b00471e1cd8c35mr421404vsb.19.1708804259619; Sat, 24
 Feb 2024 11:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223041550.77157-1-21cnbao@gmail.com> <20240224190255.45616-1-sj@kernel.org>
In-Reply-To: <20240224190255.45616-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 03:50:48 +0800
Message-ID: <CAGsJ_4x-p+8SzyHQq_EJpbq+hSEu5MCtwpGWvafpk4xfpB1gKg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, minchan@kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 3:02=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 23 Feb 2024 17:15:50 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > While doing MADV_PAGEOUT, the current code will clear PTE young
> > so that vmscan won't read young flags to allow the reclamation
> > of madvised folios to go ahead.
> > It seems we can do it by directly ignoring references, thus we
> > can remove tlb flush in madvise and rmap overhead in vmscan.
> >
> > Regarding the side effect, in the original code, if a parallel
> > thread runs side by side to access the madvised memory with the
> > thread doing madvise, folios will get a chance to be re-activated
> > by vmscan. But with the patch, they will still be reclaimed. But
> > this behaviour doing PAGEOUT and doing access at the same time is
> > quite silly like DoS. So probably, we don't need to care.
>
> I think we might need to take care of the case, since users may use just =
a
> best-effort estimation like DAMON for the target pages.  In such cases, t=
he
> page granularity re-check of the access could be helpful.  So I concern i=
f this
> could be a visible behavioral change for some valid use cases.

Hi SeongJae,

If you read the code of MADV_PAGEOUT,  you will find it is not the best-eff=
ort.
It does clearing pte  young and immediately after the ptes are cleared, it =
reads
pte and checks if the ptes are young. If not, reclaim it. So the
purpose of clearing
PTE young is helping the check of young in folio_references to return false=
.
The gap between clearing ptes and re-checking ptes is quite small at
microseconds
level.

>
> >
> > A microbench as below has shown 6% decrement on the latency of
> > MADV_PAGEOUT,
>
> I assume some of the users may use MADV_PAGEOUT for proactive reclamation=
 of
> the memory.  In the use case, I think latency of MADV_PAGEOUT might be no=
t that
> important.
>
> Hence I think the cons of the behavioral change might outweigh the pros o=
f the
> latench improvement, for such best-effort proactive reclamation use case.=
  Hope
> to hear and learn from others' opinions.

I don't see  the behavioral change for MADV_PAGEOUT as just the ping-pong
is removed. The only chance is in that very small time gap, somebody access=
es
the cleared ptes and makes it young again, considering this time gap
is so small,
i don't think it is worth caring.  thus, i don't see pros for MADV_PAGEOUT =
case,
but we improve the efficiency of MADV_PAGEOUT and save the power of
Android phones.

>
> >
> >  #define PGSIZE 4096
> >  main()
> >  {
> >       int i;
> >  #define SIZE 512*1024*1024
> >       volatile long *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >
> >       for (i =3D 0; i < SIZE/sizeof(long); i +=3D PGSIZE / sizeof(long)=
)
> >               p[i] =3D  0x11;
> >
> >       madvise(p, SIZE, MADV_PAGEOUT);
> >  }
> >
> > w/o patch                    w/ patch
> > root@10:~# time ./a.out      root@10:~# time ./a.out
> > real  0m49.634s            real   0m46.334s
> > user  0m0.637s             user   0m0.648s
> > sys   0m47.434s            sys    0m44.265s
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
>

Thanks
Barry

