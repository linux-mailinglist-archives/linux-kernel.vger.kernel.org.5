Return-Path: <linux-kernel+bounces-131859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21600898CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62F51F2744B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BE12AAE8;
	Thu,  4 Apr 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gCFUcowO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B0535AC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249874; cv=none; b=apDVytHqY7FAGDdw3a0398hxrtzTgaJ4PjYQ+VGuNL9aeLMLLp8JrSCCyM13z0uAW9BuPmQns1/RaKaIXa36DLOEPI1L8beqiiQ58AVhThDGnuIM+x3DTDcMMaozJUaLA2odTwu8gWqWZaFELSoqOyowg9UGnG5P+lrYhgQYC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249874; c=relaxed/simple;
	bh=2KPWHevbjorOUSsHZapNRmUD0fpaRYqhSR1Dgg8DGcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGttsp9qtm3/741CvqO90UALIfD6RW5zCRwKM4T6+Za68Q2tM1czrYeEXVb9gq6kXU4plfChddHUWpM8oUlo1MPFqN+SJrPjpr6iuXjg+kgqlZcHbFREFj/Pp+fQTZvpsNKJKo+1rk8Jkqf2qcEiswmyV01qKsUoocvnv/43mUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gCFUcowO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516bf5a145aso1570507e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712249870; x=1712854670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTE8+oh/R1tis1FpRuf547JjNaef5iXS7/FKBvUGN+U=;
        b=gCFUcowOCbOm/9NdxQBKmh/ioVV9o3cAMbVHhnnxyBAZiCnHznWLLeIq9ZvAc1c9As
         WcFSS4q1X8W9z3ldcUtQcvqAzI+mto4jbEW1DDJNx7J0ZvYeH2kgYZdIH/A+rsQGLPmq
         41WUPlP3FYK2zWstV7se0zLYc1yRoFZUxFb53ASJKlRN9OHhFi8Df0J2VnUr3AJhYa2i
         P5AZaYe6h99h759hQsvHWuf8FU22kKP3yaFsCWJgLOhrcdXybC5v8erR5gBvVK7fKSUS
         irrKf9cqwmPm4r4iBKmM1K1oNecfUZhSw8GjNjRVs05Exiw21iy7xLsvNMo71BTa6BPu
         bgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249870; x=1712854670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTE8+oh/R1tis1FpRuf547JjNaef5iXS7/FKBvUGN+U=;
        b=BZRrELg3rb0QR9KNSl3xPjT08UAa+etCoFgHBHh3x3X3Gg29XJurgjNXC1UmLbWarH
         7CQxaWE86187+t+kjyT8MWXFL3tHiQ9ugxMVhvwNf4xvKGnJEy4Cbz32h5lca66C904O
         2DajWg/sRBlWuDzwOxULv/RoSFCQr4IVRxeEETwDwI73v7Ia/K7xhrTx0LTAnxFykz0A
         IV/voRaNZcip3oAiaWWVMN7ooJXwOUYiuthbqnKhFnvS8aQNidy87Ne5tTojzMo5t1JA
         24mMusyhaJPYMl0DGggUHbKZ+eGmRyP1IOhc5DMP/Q0KkJMhxLZk9jkRatvo/5qUZXqR
         VGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGcQbjIR3P+VN5W0fwNhRWpE4lNh7jZACYKjSijL+T0vzzTfMOy3VBHJcrZIo8GLik9N0DbzOjK7I7A5xWbLOsd2yOtFoyhKkr9dii
X-Gm-Message-State: AOJu0YzLZGsWjuSn99b/A7EyM7/kjqAGrgOi2oHk9qbD0U4deJBr7Kd3
	iWhsbroG0P1GvqZBZ4msxn9jSHxWUH/vOcd0ctmQRW5xQu7IN3X6F0bN+XdH15oQoR9saqCHaMd
	LLpLtUxTeeqa+xgiSKnxfzMH3C3fh65dC1PjzaA==
X-Google-Smtp-Source: AGHT+IFE0+ahlc5nRL1hgLfZODKxbfrTp1Qc4vXsx4HOv/uC4g10dvAfQIHFs1k8Dy9M4egSuyjIIZGniBCN0XY0PDc=
X-Received: by 2002:ac2:4826:0:b0:516:d1af:e4e9 with SMTP id
 6-20020ac24826000000b00516d1afe4e9mr17779lft.25.1712249870133; Thu, 04 Apr
 2024 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404093328.21604-1-brgl@bgdev.pl> <20240404093328.21604-3-brgl@bgdev.pl>
 <Zg7I7nYkZLcIgETq@smile.fi.intel.com>
In-Reply-To: <Zg7I7nYkZLcIgETq@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 18:57:39 +0200
Message-ID: <CAMRc=Me=nH0bWzd3WstJnkQYmLHN7c+c4_wq41JXzcfp5pODRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: cdev: fix missed label sanitizing in debounce_setup()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Apr 04, 2024 at 11:33:28AM +0200, Bartosz Golaszewski wrote:
> > From: Kent Gibson <warthog618@gmail.com>
> >
> > When adding sanitization of the label, the path through
> > edge_detector_setup() that leads to debounce_setup() was overlooked.
> > A request taking this path does not allocate a new label and the
> > request label is freed twice when the request is released, resulting
> > in memory corruption.
> >
> > Add label sanitization to debounce_setup().
>
> ...
>
> > +static inline char *make_irq_label(const char *orig)
> > +{
> > +     char *new;
> > +
> > +     if (!orig)
> > +             return NULL;
> > +
> > +     new =3D kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> > +     if (!new)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     return new;
> > +}
> > +
> > +static inline void free_irq_label(const char *label)
> > +{
> > +     kfree(label);
> > +}
>
> First of all this could have been done in the previous patch already, but=
 okay.
>
> ...
>
> > +                     label =3D make_irq_label(line->req->label);
> > +                     if (IS_ERR(label))
> > +                             return -ENOMEM;
> > +
> >                       irqflags =3D IRQF_TRIGGER_FALLING | IRQF_TRIGGER_=
RISING;
> >                       ret =3D request_irq(irq, debounce_irq_handler, ir=
qflags,
> >                                         line->req->label, line);
>
> But the main point how does this change fix anything?
>
> Shouldn't be
>
> -                                         line->req->label, line);
> +                                         label, line);

It should, I badly copy-pasted Kent's correct code. Thanks, I fixed it in t=
ree.

Bart

>
> ?
>
> > +                     if (ret) {
> > +                             free_irq_label(label);
> >                               return ret;
> > +                     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

