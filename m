Return-Path: <linux-kernel+bounces-54839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89B84B447
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15311C22FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815F12FF9F;
	Tue,  6 Feb 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLWtXB+z"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9513667A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220352; cv=none; b=NKK1XAkNvFUMPcO8THz+1ze/pBXGAJpOjR1enR2WbN0QcRGGkMq4nNl+sitYzRtIQJDplkeuTTkkH3hxoC0FDM7rG+dmIg6YkL5Gobf+Y3gR2VaNaQBP05SAEy5WX1Y9p6raU4ItTv92ubw4Ymde/2Nj+ylaztSCYV0+91eYgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220352; c=relaxed/simple;
	bh=eQFJsQyvFwq05BSh9lj8zh5BxdlEHDP7SYr0OH+PaJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyyhzItLhIFyf+EmF73RL/Lhk6JZndzpvOS34D9FDR5FtaSaGsENaSGMlzBK7zqnWceF5+X4osHJasORe9ZdSzKHYTdIOqqG52YdSt+JHHtsfKd2lH8Pnfb7GLOd6hagHzQjwl/rRDNdESvvAJKOCmlyTaFZ1qQaMURGb8k9IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLWtXB+z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a38392b9917so50184666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707220347; x=1707825147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQq4/ZkHBhQWVc6Z0AnIILJ4BLJUKNZZ5xeYRzI7+2E=;
        b=hLWtXB+ztri6y3qVtXDrdUlbNBKbY1Qz3UzCewWjRhnDy1/cAc+ebFJkkB4ATNHtvn
         Jr8P9NqTdEj6smOq2s2OE0W44FtzRsNilSh25bh49zs50l/z6580bucNCTLgJPF1hA1p
         TfpWoaSAXKjJUVHlykuUhKFvR7BskDi+OoJ3kc8pxKbg7RyBEfoJM8gmrzTxE5wEjNof
         fX4tdSRrRcdBrWtkb3qRWMpWJGTQKiaqJJSeXSVaV6P1WYZp4NAtql76agDGewx3SMSC
         LvVkK5YdF+CtEWIvZOi4j6tC166Wq0DmO1YHlqGQAeoMUWKBIbujrRIffy8YL9P0dEZd
         LjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220347; x=1707825147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQq4/ZkHBhQWVc6Z0AnIILJ4BLJUKNZZ5xeYRzI7+2E=;
        b=ZHbmgA2QTsGsNxQOboZ5C6PgGYkRoi5hNNm/CW4BpXShUZkieBkztFCR6qyh6+zjCL
         rwNLRfAhbpQIVZjW2yKTRe7uqbX9eQxMjxAeMmDEvwtXCAvDIHMrgyH3mVTmfOWLKLNX
         tDQ2ogVdVsP7YhZup0KA2yw09nxrvMAoRXNrH/WPslq1OK2QIqydYKoUoOvRHzg4UKcr
         Dgpl5m84PhgqWZLOAGCLLPF4XE88Zv3pZlnKEOnXwgMxXQAY26/dyolwIxbGHtFqqka+
         E95YOsjKf7SZ590pPZe544BEFSuULlOTwC2/h5bztDPdDROMZim54YgSK41Crh0djw3A
         y1nQ==
X-Gm-Message-State: AOJu0YwPYGciuTmmXjGoEucud86O6T7ksF/ESowP17fN0IA5MtcDVJ6H
	leHg39TlLtNI19MJ6NFkOugpMqi+LNTdbICMcEQW2wzmAH65QnuPYnnWmDjT1Y82ZOsBmw4KGNl
	omcAPyQNGVQhEMDuwHDYZZqAtsOhIrFi/Ohc1
X-Google-Smtp-Source: AGHT+IEGCCTfVvImRciaRchs8bzAJB3VxEPKsJocgyiRHo92yt8IGZI+4ynzJ72V1u98rmpGnK2O8nmVcHESxButySg=
X-Received: by 2002:a17:906:49:b0:a35:deb0:cd10 with SMTP id
 9-20020a170906004900b00a35deb0cd10mr1599443ejg.64.1707220347084; Tue, 06 Feb
 2024 03:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com> <2024020637-handpick-pamphlet-bacb@gregkh>
In-Reply-To: <2024020637-handpick-pamphlet-bacb@gregkh>
From: Joy Chakraborty <joychakr@google.com>
Date: Tue, 6 Feb 2024 17:22:15 +0530
Message-ID: <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 06, 2024 at 04:01:02PM +0530, Joy Chakraborty wrote:
> > On Tue, Feb 6, 2024 at 3:00=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Feb 06, 2024 at 04:24:08AM +0000, Joy Chakraborty wrote:
> > > > reg_read() callback registered with nvmem core expects an integer e=
rror
> > > > as a return value but rmem_read() returns the number of bytes read,=
 as a
> > > > result error checks in nvmem core fail even when they shouldn't.
> > > >
> > > > Return 0 on success where number of bytes read match the number of =
bytes
> > > > requested and a negative error -EINVAL on all other cases.
> > > >
> > > > Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory a=
s nvmem")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > > > ---
> > > >  drivers/nvmem/rmem.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> > > > index 752d0bf4445e..a74dfa279ff4 100644
> > > > --- a/drivers/nvmem/rmem.c
> > > > +++ b/drivers/nvmem/rmem.c
> > > > @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int=
 offset,
> > > >
> > > >       memunmap(addr);
> > > >
> > > > -     return count;
> > > > +     if (count !=3D bytes) {
> > > > +             dev_err(priv->dev, "Failed read memory (%d)\n", count=
);
> > > > +             return -EINVAL;
> > >
> > > Why is a "short read" somehow illegal here?  What internal changes ne=
ed
> > > to be made now that this has changed?
> >
> > In my opinion "short read" should be illegal for cases where if the
> > nvmem core is unable to read the required size of data to fill up a
> > nvmem cell then data returned might have truncated value.
>
> But that's kind of against what a read() call normally expects.

That is fair, maybe the size check should be there at the nvmem core
layer to catch any truncations but the actual size read is not passed
from provider to the core layer.

>
> > No internal changes should be made since the registered reg_read() is
> > called from  __nvmem_reg_read() which eventually passes on the error
> > code to nvmem_reg_read() whose return code is already checked and
> > passed to nvmem consumers.
> > Currently rmem driver is incorrectly passing a positive value for succe=
ss.
>
> So this is an internal api issue and not a general issue?  Unwinding the
> read callbacks here is hard.

Yes, this is an internal API issue with how the return type of the
reg_read() function pointer passed to nvmem_register() is handled.
The function prototype in nvmem-provider.h does not define how the
return value is treated in nvmem core.
"
typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
void *val, size_t bytes);
"
Currently it is always checked against 0 for success in nvmem/core.c
which all nvmem-providers adhere to i.e. return 0 on success.
Actual size read from the provider is considered to be equal to the
requested size from core as the provider does not relay that
information.

>
> Also, in looking at the code, how can this ever be a short read?  You
> are using memory_read_from_buffer() which unless the values passed into
> it are incorrect, will always return the expected read amount.
>

Correct, we will have an error only if the returned value from
memory_read_from_buffer() is negative.
So to work with the current nvmem core implementation, I can return
the value as is if negative and 0 for positive.

> > > And what will userspace do with this error message in the kernel log?
> >
> > User space currently is not seeing this error for nvmem device/eeprom
> > reads due to the following code at nvmem/core.c in
> > bin_attr_nvmem_read():
> > "
> >     rc =3D nvmem_reg_read(nvmem, pos, buf, count);
> >
> >     if (rc)
> >         return rc;
> >
> >     return count;
> > "
> > since it expects to return the number of bytes.
> >
> > Userspace will see a false error with nvmem cell reads from
> > nvmem_cell_attr_read() in current code, which should be fixed on
> > returning 0 for success.
>
> So maybe fix this all up to allow the read to return the actual amount
> read?  That feels more "correct" to me.
>

If I change the behavior of the nvmem_reg_read_t callback to negative
for error and number of bytes actually read for success then, other
than the core driver I would also have to change all the
nvmem-provider drivers.
Is it okay to do so ?

> thanks,
>
> greg k-h

Thanks
Joy

