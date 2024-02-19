Return-Path: <linux-kernel+bounces-71206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549985A1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1571C2302E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A72C1B9;
	Mon, 19 Feb 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqBb6Lld"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6A2D046
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342209; cv=none; b=YAu6XEhpASjvNZszkgFtu4ePi2iiHPYtbjPus5BtlGH7b97Mx8wkQUq17+ihPJan78RBGL7HAvYzLPWXSB+iuoega/Q5zjvxBxWsmngGdZSl5pkrfEthj2DgaMixoRu5+wxmu7M2A4OYMvrQhOKKxpNAwFyP4/qRgATvi9n4RIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342209; c=relaxed/simple;
	bh=jA8i3ioQgOQIGjp2Ibf5r1JRi97p+s3VymmYnM5xl2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKIqCsNe+EpiEPKgSm+K8J2biJE+Xgu3+McKvB/hvLiL2UA2zG3M9wb8iMWffNXEaWN9idU3MFbCO9tO5geboxRrSHKjop83SQ9RS7WQXOceHEaJlSeAU1cBU4cHCFBmoD7pmUcLPMXY4WCv5uKX8OUI6g3UEgcwRZdZI86KObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqBb6Lld; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60818d338bfso12747437b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708342206; x=1708947006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzcrk3xPXXPW5E4xvwIqBIj0vf/WhGzB03Om/UaEaD4=;
        b=wqBb6LldsnqZeMhoa76P2+RPLWCHVZEXdMU9QT30v1k+dndzQ/sbuS+M0r7YkZo5Ri
         UfjBxAeypMbCzncMoDZkakL8TMLcqfDPaDliSlivQ/FL9jxdzUbg0qQoSpB9JN2OLi0/
         fQcXnEOomD4pdhpmolk5RFNzg/x6Sb7fB49OVFJIU6Z4l9hEA1PHQPaH2AI+y4UTVbBT
         p/B5emNTy8/x4bmm0nDygHA53J1nmAyYPV5KWogIBgmh6gkR+5+ZWs7/LC4MEiiXTfRr
         wdnWSdJ7qnLR+7OEv+tksWjxfWARuMkNiKUsmMneSQrU65zYoN8EHnp459OydgI3s9gS
         Vdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342206; x=1708947006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzcrk3xPXXPW5E4xvwIqBIj0vf/WhGzB03Om/UaEaD4=;
        b=BN/jUs986SK3ax8PANgGuXcBMY3W+2mJm2tsU/21oVbktiTvFKTckGEnwUGpZcJIVV
         YT5/U+Movze7fIhlFQHKzWXeLoRnUion59P9WmaF/VonqhQiqqOTznce8qKr76OpE+oP
         tbM1VL75aXXzjiLiNu8BHcKDLx2ZdhJj6wDAkz0fT/tkHQF6GL2QP9XXu8URBgpNPl16
         wipw60GY5ZhKPtF/LzJFke8lDIPvv9HUCOPduCiR8EtaqGWcBLBHWHAZ3ShYSZwo0YAS
         gSVvleF+FxyguFVKhgl29z1KJ2ZCXiXYv11fzBZqlKbUvGIGN7cqFmC/JAziJ/rRU19u
         BOFw==
X-Forwarded-Encrypted: i=1; AJvYcCXzScTC/MA0hmJ5zrr3QtxS+mJ6avt6Aw8i6jAvdtPvwmxlIhyqbx9JNHNYBc68RwAraknoaiz1WMgocICWIxPrY8AzkItjVBTdFIcO
X-Gm-Message-State: AOJu0YwG/p7UfUQBH9i7kBJQghPITINTaAi3kcyw9s4WsDcqtPCXHcxO
	GU2nAfMdvtA+ghb5a50k5QcBpOg2QqGECLFsrSr+IQymzh5FriJ459o0FIfHQFi3qTrTHfM3+Me
	NqDXcevn22bOd2D4hamp1wrPTQlLlWvYRHhnv
X-Google-Smtp-Source: AGHT+IFQZJmL8c/5NtY6f5BdPvoYb88H262MzAFliOOAJlGQJH69WotyinmVpQjwiiapZFhWIhykVbSBw7LtebX4I1g=
X-Received: by 2002:a0d:cb0e:0:b0:604:7b9e:f62f with SMTP id
 n14-20020a0dcb0e000000b006047b9ef62fmr13410931ywd.37.1708342206438; Mon, 19
 Feb 2024 03:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com> <ZcUXP14Ng8g5vw1j@smile.fi.intel.com>
In-Reply-To: <ZcUXP14Ng8g5vw1j@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Mon, 19 Feb 2024 19:29:55 +0800
Message-ID: <CAJDAHvbYBVS=LiYHWd_KAtGtcQsjRsLCm2w3j9o4SvLBG_qiZw@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 2:02=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> > Add support for multiple coherent rmems per device. This patch replaces
> > original dma_mem with dma_mems list in device structure to store multip=
le
> > rmems.
> >
> > These multiple rmems can be assigned to the device one by one by
> > of_reserved_mem_device_init_by_idx() with the memory-region
> > declaration in device tree as below and store the rmem to the dma_mems
> > list.
> >
> >       device1@0 {
> >               ...
> >               memory-region =3D <&reserved_mem0>, <&reserved_mem1>;
> >               ...
> >       };
> >
> > When driver tries to allocate memory from the rmems, looks for the firs=
t
> > available rmem and allocates the memory from this rmem.
> >
> > Then if driver removed, of_reserved_mem_device_release() needs to be
> > invoked to release all the rmems assigned to the device.
>
> ...
>
> >       struct dma_coherent_mem *mem;
> > -     int ret;
> > +     int retval;
> >
> >       mem =3D dma_init_coherent_memory(phys_addr, device_addr, size, fa=
lse);
> >       if (IS_ERR(mem))
> >               return PTR_ERR(mem);
> >
> > -     ret =3D dma_assign_coherent_memory(dev, mem);
> > -     if (ret)
> > +     retval =3D dma_assign_coherent_memory(dev, mem);
> > +     if (retval)
> >               _dma_release_coherent_memory(mem);
> > -     return ret;
> > +     return retval;
>
> This is unrelated change.
>
> But why? Do you have retval in the _existing_ code elsewhere?

Rename the 'ret' variable to 'retval' because, in the
dma_mmap_from_dev_coherent(),
there is an argument named 'ret', and also I add 'retval' for the return va=
lue.
So I try to rename it here to be consistent.

>
>
> ...
>
> >  int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
> >               dma_addr_t *dma_handle, void **ret)
> >  {
> > -     struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> > +     struct dma_coherent_mem *mem_tmp;
> >
> > -     if (!mem)
> > +     if (list_empty(&dev->dma_mems))
> >               return 0;
> >
> > -     *ret =3D __dma_alloc_from_coherent(dev, mem, size, dma_handle);
> > +     list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> > +             *ret =3D __dma_alloc_from_coherent(dev, mem_tmp, size, dm=
a_handle);
> > +             if (*ret)
> > +                     break;
>
> This bails out on the first success. Moreover, if one calls this function
> again, it will rewrite the existing allocation. Is this all expected?
>
> OTOH, if you add multiple entries and bailing out on error condition it s=
hould
> be clear if the previous allocations have to be released.

If it's not able to allocate required memory from the first entry,
then tries to allocate
from the following entry, and so on.

>
> > +     }
>
> >       return 1;
>
> >  }
>
> ...
>
> >  int dma_release_from_dev_coherent(struct device *dev, int order, void =
*vaddr)
> >  {
> > -     struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> > +     struct dma_coherent_mem *mem_tmp;
> > +     int retval =3D 0;
> > +
> > +     list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> > +             retval =3D __dma_release_from_coherent(mem_tmp, order, va=
ddr);
> > +             if (retval =3D=3D 1)
> > +                     break;
>
> Same Q here.
>
> > +     }
> >
> > -     return __dma_release_from_coherent(mem, order, vaddr);
> > +     return retval;
> >  }
>
> ...
>
> >  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_stru=
ct *vma,
> >                          void *vaddr, size_t size, int *ret)
> >  {
> > -     struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> > +     struct dma_coherent_mem *mem_tmp;
> > +     int retval =3D 0;
> >
> > -     return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
> > +     list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> > +             retval =3D __dma_mmap_from_coherent(mem_tmp, vma, vaddr, =
size, ret);
> > +             if (retval =3D=3D 1)
> > +                     break;
>
> And here.
>
> > +     }
> > +
> > +     return retval;
> >  }
>
> ...
>
> With the above Q in mind, here is another one: Why can't we allocate all =
at once?

Not sure if I misunderstand your meaning, It tries to allocate the
memory from the first
entry that satisfies the allocation requirement, but not separately.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Regards,

Howard

