Return-Path: <linux-kernel+bounces-43202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E6B8410C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494611F22D17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7576C6B;
	Mon, 29 Jan 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htMdc4bS"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4076C65
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549597; cv=none; b=dwCfmbL4UmGjZZfobaiiSIii7hjIkG/fd/CzNuKcUEfnjbRa7VXJzH0WBaI43RmNZtgPJISRxTY3MWgJw42GATae/ncgw29b3RfUJl+rNFiWpRHLdExNGIX7koLoVHnowwteWZtwXP4BJdWJA94zQdklwUMAb289ycWJLYOOr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549597; c=relaxed/simple;
	bh=T7xOFEitKFXrH3/TEVi4TiLsju17vd/DaRjPPjQNybc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UormW4FueT83fV7WkCdgMrUaVgy0Up4d7R4FDQcKlX2XzZVUodNJ1Ap7wu2ICPnrPmT6ZIbZsUaRLZQ9LveT5+b2G9M7gx6tpY7X8DCwDrCwuSqQYOqUW53/JQ1f3AG1Vt7cfByjEBYeuQMTibT2tP+Nz0jjHLg9v9u8rvc+8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htMdc4bS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55eda7c5bffso13138a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706549594; x=1707154394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SY7dR1ULUDl95MlS9xutDJoWjeGvF20sToCQx3FqWc=;
        b=htMdc4bSnVFbIRHBvNYcGyaAzJGmoQyRrUEc9/YgIK/sS3AMYX/LLkyvPW5FJbQE8Q
         w+jLROCgeWdLuNg8/OoLV8cyOKRoFZw4j0sLu+Q5XOtp423ru6xNRGYO/nHpky9xwH3t
         2UMM7+ScbJOr0kIy3l8vQtVV7+y1T6DwDcj0TcPPNyLZO4CDar+0r3wHFA+XUm32/rDz
         yxnp7IsgAaLfi/9XwPYEMJFpQttKhTvbioZjW6ulSp/yoLTjkI7xuM/ABU83UUQeOPBQ
         1cmXrhBEXH7w6ZmBtV7lLypJf41w6/qTDqZLcLsFKvyA6CXGPtoVoh8lWkFB1lmlAv87
         CkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549594; x=1707154394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SY7dR1ULUDl95MlS9xutDJoWjeGvF20sToCQx3FqWc=;
        b=c8PVN3or6iJCwe5Y5aTKBk5G8UauLHb4qDENnBgfhg6JGUV7+rkOSuAToC9PANS94p
         hRwdtRJWj2rUjBV7U2+nxeLXfr3T4E6h1Rp27qc9fjggjKJeGlHNZljC2gQdy/HlwsyG
         kzco3iyIdva5j0VX+Mrsscv86/e61ALJMBcF7zGKJ596hq1zIP3jTLy0ruUjoPuCTf1u
         eBfDpe9kmk1krrCovpLd9HDGRJDLXKuRoIp1snfcHdadv74TiHquO9ChbqAYJZK2V5xZ
         IX/ZMoKSGW4AG84BX5dkVFantSc0LZb/xV6w7/YTz7FzvEOh8j5FID68P7eXSrWfROcS
         Skzw==
X-Gm-Message-State: AOJu0Yy/wc0ODmObFank+Lih+5ACFaH5kNBbrPUS/ljLS7ITohbB7zkw
	ZFeeXbhddb3/NSVpuBBEGRBX8+Eo/QES+EJ6GHNuR+TMYmotIy/pFJIAzz5usnITocVTl/LlAvL
	dxOPsSFcjFfTD0eeBpgTcYRhVO7Rk+drfzm/Xmsld0tdwYtevwhcc
X-Google-Smtp-Source: AGHT+IGCtN6q4Z5ktjiRCyi95AK+tvExtBpwrVcvy39Gh9YvbjrF2C+9UWCEmGoNGQp0tCenY4h4SPeghqz7SN5cMhE=
X-Received: by 2002:a05:6402:b9d:b0:55c:ebca:e69e with SMTP id
 cf29-20020a0564020b9d00b0055cebcae69emr540979edb.5.1706549594041; Mon, 29 Jan
 2024 09:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127234636.609265-1-neelnatu@google.com> <2024012727-petition-flip-917c@gregkh>
In-Reply-To: <2024012727-petition-flip-917c@gregkh>
From: Neel Natu <neelnatu@google.com>
Date: Mon, 29 Jan 2024 09:33:02 -0800
Message-ID: <CAJDe-OJoxh5V=fLqeRF+F09e023oMX1ikZb3kC7R=rrKKA1uAg@mail.gmail.com>
Subject: Re: [PATCH] kernfs: fix false-positive WARN(nr_mmapped) in kernfs_drain_open_files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 27, 2024 at 4:02=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 27, 2024 at 03:46:36PM -0800, Neel Natu wrote:
> > Prior to this change 'on->nr_mmapped' tracked the total number of
> > mmaps across all of its associated open files via kernfs_fop_mmap().
> > Thus if the file descriptor associated with a kernfs_open_file was
> > mmapped 10 times then we would have: 'of->mmapped =3D true' and
> > 'of_on(of)->nr_mmapped =3D 10'.
> >
> > The problem is that closing or draining a 'of->mmapped' file would
> > only decrement one from the 'of_on(of)->nr_mmapped' counter.
> >
> > For e.g. we have this from kernfs_unlink_open_file():
> >         if (of->mmapped)
> >                 on->nr_mmapped--;
> >
> > The WARN_ON_ONCE(on->nr_mmapped) in kernfs_drain_open_files() is
> > easy to reproduce by:
> > 1. opening a (mmap-able) kernfs file.
> > 2. mmap-ing that file more than once (mapping just once masks the issue=
).
> > 3. trigger a drain of that kernfs file.
> >
> > Modulo out-of-tree patches I was able to trigger this reliably by
> > identifying pci device nodes in sysfs that have resource regions
> > that are mmap-able and that don't have any driver attached to them
> > (steps 1 and 2). For step 3 we can "echo 1 > remove" to trigger a
> > kernfs_drain.
> >
> > Signed-off-by: Neel Natu <neelnatu@google.com>
> > ---
> >  fs/kernfs/file.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index ffa4565c275a..e9df2f87072c 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -483,9 +483,11 @@ static int kernfs_fop_mmap(struct file *file, stru=
ct vm_area_struct *vma)
> >               goto out_put;
> >
> >       rc =3D 0;
> > -     of->mmapped =3D true;
> > -     of_on(of)->nr_mmapped++;
> > -     of->vm_ops =3D vma->vm_ops;
> > +     if (!of->mmapped) {
> > +             of->mmapped =3D true;
> > +             of_on(of)->nr_mmapped++;
> > +             of->vm_ops =3D vma->vm_ops;
> > +     }
> >       vma->vm_ops =3D &kernfs_vm_ops;
> >  out_put:
> >       kernfs_put_active(of->kn);
>
> What commit id does this fix?

bdb2fd7fc56e197a63c0b0e7e07d25d5e20e7c72
kernfs: Skip kernfs_drain_open_files() more aggressively

best
Neel

>
> thanks,
>
> greg k-h

