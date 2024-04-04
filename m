Return-Path: <linux-kernel+bounces-132044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F019898F10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8040C1C221BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D5130ACD;
	Thu,  4 Apr 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCeoZWVo"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155A12FF9D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259144; cv=none; b=aeM0eJix8dzFPPEt38vVboF2orJo2xdXS4jFfw4SV4h5IifRANmIennGtaP5llEOjAmFc6lO0R87+RXEiPgVHO4uFthBTS05unSXV/8lYRWrQrshpCTfWFr5wzrAK930b4ezrzYT3rKrV7OStLhBiSUpb0r89YihnAd3AWKPJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259144; c=relaxed/simple;
	bh=gsVcKtDkUNveOcQR3OkOOH5GwGE5htKXDxs/MtGdyjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBxqCDybBtMedQtsgkK37AVx16wejKqCY1DpASOx4/7I97sacsvgdgGW2piyI2ruZtqx3UwTbT+BjSQvbISFRcvjpjeCC0i6SkDOaS3+OnwabHPzgOqeYD7CZTHBE/Jp1GDzkpF8pnqAY9AeRQkyFrReZNyYBdWL1e+5odKklOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCeoZWVo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1603025276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712259142; x=1712863942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QF7YfDkyhTCu/FPW6+EBtGcxT+kvR7RnrsjI6gQgsU=;
        b=nCeoZWVoWA8RLbHUFsuDYA20rSn/xMYE8jHn4EIsPIM5BsqqtZGQZMBH9UBGrtu9OH
         pt8xyF9P2CU8h7jGTnwDK3wIg1lb8R2467a0cfXqZExj6jW4jwp9Ydx7ap95bhj2IhDQ
         VDYSks6ClLyiCj0jMMdke5L2A9TikiO081SbQ7qEgYMNiwestDyvFQ8loD8ymoVBtWS8
         ReXyGW9LvtMcVy5JDbgjlyxkMrfbYUoNPqHV0RJ7/lzw05FliBAsdCS8QRqw8IHDhNUT
         p5UQ9PR0bkVqZHvHaUo7hUaXo3YGl0hpDRAMMdZAHJcYJqKdhBpcivavTwgrfmo2ow0Q
         1m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259142; x=1712863942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QF7YfDkyhTCu/FPW6+EBtGcxT+kvR7RnrsjI6gQgsU=;
        b=dXXNad8JTwrejtxRHTqILpW64Ewgv5C9fXZKrer7iYRVjiKBxTQbZ6Su8tgiFdEKTE
         3qM3KTIMbsmOfYnxPHluIWVy/Xgi+t9GgT6fwSzby+OrikdwU5tM0rSBx2vjkHpu8Joq
         P3pNNOKZkcNx47tBtXTjwcopnhFuVuoUaLNS3utlWeexgl4Pv5mw4ey1PQEj6jOPQpAg
         mmsLSaysnztfyozAtnabHonN+VRp/vBywnmCQVL9x3T5ZfTXhXHa6kdpq6RVpfNzhpiG
         HD5x8fK6s6+/nxuAB2eh44RAiBEUvNSa5cdBEosfQv30qvF7gIqXVEeT4eJT39ywjYuB
         yLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4hDEEZkZRgWadpwG0r1w4wo8zeAgF0E7ObUYJQh0gcYldtqBBgOpQwba2Rmhib5iOLTJUBlW8oCfkHqsx6io5numhLXwwXRUYEEX4
X-Gm-Message-State: AOJu0YxPAUgTRqxd/yh41UQi0nnd0Kyl88qKNLx3rfrASci4Xe2+HOsE
	ZIYdJZQu561P8V8v6ySqtZY6WSWZsMOpB2VZcmkQA7tImB8sdKpOZMAR/d5dF6zofTLbGd2RTnW
	UjUdh7k6p5NEmwzoWeDWFFQaNJ6UXawOj
X-Google-Smtp-Source: AGHT+IHu0tf3wBJpfd3UyhX93ctSlHSzZkIbY7hMSDwDS6Q0n1uGqbYHK48drdtAqk3f12AmqnbitdryFo4MfkssZfc=
X-Received: by 2002:a25:8b81:0:b0:dcc:7131:ad4a with SMTP id
 j1-20020a258b81000000b00dcc7131ad4amr2943771ybl.62.1712259141645; Thu, 04 Apr
 2024 12:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-2-vishal.moola@gmail.com> <Zg6cualUqcsZYZxf@localhost.localdomain>
In-Reply-To: <Zg6cualUqcsZYZxf@localhost.localdomain>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 4 Apr 2024 12:32:11 -0700
Message-ID: <CAOzc2pxfUSnT6fEXAJZowYeMz=hCgWsfJRB++dis1AL_rNScGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hugetlb: Convert hugetlb_fault() to use struct vm_fault
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:26=E2=80=AFAM Oscar Salvador <osalvador@suse.de> w=
rote:
>
> On Mon, Apr 01, 2024 at 01:26:49PM -0700, Vishal Moola (Oracle) wrote:
> > Now that hugetlb_fault() has a vm_fault available for fault tracking, u=
se
> > it throughout. This cleans up the code by removing 2 variables, and
> > prepares hugetlb_fault() to take in a struct vm_fault argument.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> A question below:
>
> >  mm/hugetlb.c | 84 +++++++++++++++++++++++++---------------------------
> >  1 file changed, 41 insertions(+), 43 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8267e221ca5d..360b82374a89 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> ...
> >       /*
> > -      * entry could be a migration/hwpoison entry at this point, so th=
is
> > -      * check prevents the kernel from going below assuming that we ha=
ve
> > -      * an active hugepage in pagecache. This goto expects the 2nd pag=
e
> > -      * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
> > -      * properly handle it.
> > +      * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at thi=
s
>
> "vmf.orig_pte could be a migration/hwpoison entry at ..."
>
> > -     entry =3D pte_mkyoung(entry);
> > -     if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
> > +     vmf.orig_pte =3D pte_mkyoung(vmf.orig_pte);
> > +     if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.ori=
g_pte,
> >                                               flags & FAULT_FLAG_WRITE)=
)
>
> Would it make sense to teach huge_ptep_set_access_flags/set_huge_pte_at()=
 to use
> vm_fault struct as well? All info we are passing is stored there.
> Maybe it is not worth the trouble though, just asking.

Yeah, it makes sense. There are actually many function calls in the
hugetlb_fault() and
__handle_mm_fault() pathways that could make use of vm_fault to clean
up the stack.

It's not particularly complicated either, aside from reorganizing some
variables for every
implementation of each function. I'm not really sure if it's worth
dedicated effort
and churn though (at least I'm not focused on that for now).

