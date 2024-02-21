Return-Path: <linux-kernel+bounces-75242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903585E51D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC73928453D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8B84FDB;
	Wed, 21 Feb 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS779MhK"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD37BB00
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538577; cv=none; b=qoRjao5+KM5czFC6QFQZ/Ldc6xl8eBynJ10L4B2rW+rUKkekzcSpx10TwTq4wfRIAj5koSMMl5iSw/fg++i6CwzmoE1vxPx71YvJd1kTsH6Z3zsdeXYgoPtfOuMa0KzWxnhnITSge8eJGxDzwgX/zgMDDYaOKV4xeEDZOOroVUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538577; c=relaxed/simple;
	bh=yi54Lm2dqrDB+cxkACqkhgnwXGwUUIDVH5OsV836WSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOBdTNl+kWCMax+3/QpKjXH+djaeg1X9LwlhqtNwgZoUC+i/k2+kwP54vmgKDeyz9ZOHaouFzrSG8TlYLfESriNYSozFl0YjDvrQ1yZYZB8zNj5H8+HtMAvDrA43EG828hbPXQqp7eQgEc/YOptM/PmzNP/C4EnPj9TlvuqiNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS779MhK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso6722608276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708538575; x=1709143375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ4ZIhOlLj482hbMZwIkVDjrXVuHvcX1vma+IQSxDL8=;
        b=nS779MhKRQQFrZYbycRvp2QfyOb077r5exMGNNC7+TuVV3Ll2v6l4BUtWKhxdYyl7U
         ncDL45BPaPILcv2ZxEK20yCkYBRcqpGHxX4tJLZtvEZDl++hZa/vBjXeQy1a4EsimN0B
         etr+wsDAA8S7WD8VsdncF45n+npWi1LakjPBjNEq1y/Sb4wF8UHwUN8O73Bpq3eEf4hg
         VVHQokCfiA46GLOHGmq0IwKoQ8YjZvT95J0T7sR0pkn5nFv94mzjx4bQqJyQ9PGxIjq2
         UEELVcpDQkbUy1nuIqliUOe3V6t4sbgj2Ia5ws981x2dxDEjdcus9HSxXgab+HZhd86U
         gcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538575; x=1709143375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ4ZIhOlLj482hbMZwIkVDjrXVuHvcX1vma+IQSxDL8=;
        b=U3kh+AtDOVIlk8dptRZ6VJXzoHhiTA42EjfTn/ase/1G2p0fPyZSXwJoPzWNFtgoGS
         7wzGv31/xdbZOjFZC8uERgmpP3OakSSDINFk+j9QlhjT2KInwZUEpJNDVjllfQENqA4x
         eBE2aaBCASzq8K6JNfeS0lCkAbIpFnfHu3IVycDIuAMOjgbb7LWIvp1mVIn4aACNSMP1
         46WX0BQR22F+5zvDotabAtE2Hnl9auL71oa8aVQdBZJNEVgvkol2kN29OzFajH8x/rRU
         pxxYe+/HwjzG4zGC6MpZvqnlRE3UpjC+ZZg1btXKtejroQC9faaK+tJ+G1hgzVHyeh4U
         vHVw==
X-Forwarded-Encrypted: i=1; AJvYcCWr01BBYmOt2oJPudZqvUzSBT2U4w/1eNhsMJ3dzdh67+eQTRedj3Q/bQoDD+N3lch2X4s+4aP3oFBW0wUjkk7MiUXNTlDGUjwJDgrK
X-Gm-Message-State: AOJu0YxJeuuXtEuQuMENSTJD5d0n3P54+o5SU3bDbEP22dNdkl61p8Lw
	jLRoZNPuK7M8wUIdtvGGV6otqPVM+jzL5hDPnICLPNH8LGkd2gnMUj+/6VkyyF+LPAUEFAzFjOD
	vnLBXAUSgd4qtpBq9v948Q8QVFDGEt7wY
X-Google-Smtp-Source: AGHT+IF3eD0jXeGA8GC5jgAbnNJApudrAh14W8XoWF7HVCuDb0xyxZgSwcIAjE/svFpEKS9393R4xM06BGzr7Toj888=
X-Received: by 2002:a05:690c:30a:b0:608:5216:80c9 with SMTP id
 bg10-20020a05690c030a00b00608521680c9mr9108775ywb.40.1708538574924; Wed, 21
 Feb 2024 10:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220231424.126600-1-vishal.moola@gmail.com>
 <20240220231424.126600-3-vishal.moola@gmail.com> <ZdVx_Jr9tm2lV0Ku@casper.infradead.org>
 <CAOzc2pzLbiEpMuBpX7xXhZqPc0S6ZMnziT2uUFsa0tZe6yJQ0g@mail.gmail.com> <ZdY5BfO3EdcnJM99@casper.infradead.org>
In-Reply-To: <ZdY5BfO3EdcnJM99@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 21 Feb 2024 10:02:43 -0800
Message-ID: <CAOzc2py+gFdcfSebCvkWWWjht-CTBO=O4iNTQ9xs+=Wd2Kf8Hg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hugetlb: Use vmf_anon_prepare() instead of anon_vma_prepare()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 9:55=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 21, 2024 at 09:15:51AM -0800, Vishal Moola wrote:
> > > >       unsigned long haddr =3D address & huge_page_mask(h);
> > > >       struct mmu_notifier_range range;
> > > > +     struct vm_fault vmf =3D {
> > > > +                             .vma =3D vma,
> > > > +                             .address =3D haddr,
> > > > +                             .real_address =3D address,
> > > > +                             .flags =3D flags,
> > > > +     };
> > >
> > > We don't usually indent quite so far.  One extra tab would be enough.
> > >
> > > Also, I thought we talked about creating the vmf in hugetlb_fault(),
> > > then passing it to hugetlb_wp() hugetlb_no_page() and handle_userfaul=
t()?
> > > Was there a reason to abandon that idea?
> >
> > No I haven't abandoned that idea, I intend to have a separate patchset =
to go
> > on top of this one - just keeping them separate since they are conceptu=
ally
> > different. I'm converting each function to use struct vm_fault first, t=
hen
> > shifting it to be passed throughout as an arguement while cleaning up t=
he
> > excess variables laying around. In a sense working bottom-up instead
> > of top-down.
>
> I think you'll find it less work to create it in hugetlb_fault()
> first.  ie patch 2 could be to hoist its creation from half-way down
> hugetlb_fault to the top of hugetlb_fault.  Patch 3 could pass it
> through hugetlb_no_page() to hugetlb_handle_userfault() and remove its
> creation there.  Now you've alreedy got it, and can make use of it in
> this patch which would be the new patch 4.

Ah I see, that way would definitely be a lot less work. I'll make that
change for this patchset in v2 then.

> If you want to do a cleanup patch afterwards, you could hoist the vmf
> creation all the way to handle_mm_fault() ;-)

Yeah, I was already looking at doing that in the future patchset :)

