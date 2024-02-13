Return-Path: <linux-kernel+bounces-63369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFD852E40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47277B25D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E224B54;
	Tue, 13 Feb 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8iD7OT7"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B902572
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821141; cv=none; b=qKs3uAtP+CxwEjyV9IR2u1q4mBsLFrzae6jWL9ksYY/12kbIDXw6r4MzHuFh8GJZPf6QmLwiYAnyLtdHmoSB60rXYOg44eLzt8H1OlsycQvEDgEeMD0Wxt/+mNrhmpPHpEpFyAw5fOPhdworVrpNRxi5BkqfGQ24tG6SdKZ4hKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821141; c=relaxed/simple;
	bh=XuhY4VGCAWQPZZW8oHE6/L5ni11ngYCzjfwA5hYTTTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7V2OWfr8ZlagA5VWrpCfiO5QVpCnVqhtbMH+SrUVz9xhb62eeykt6X39K46PCCkiw2J5GZNZlDsLyeMYq0c1kYhUANu3c8DVIUcAnLc/e6iM18knP6mLL3b0A4E+3uMs2YP0s9pchanRy3mYNg1LWQ2rfBkyq333gQ4yX13pHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8iD7OT7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0f1ec376bso27003271fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707821137; x=1708425937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4Ldg9krU0VciizTZMuqyom4NDFd6bYrpebN+XYb13Q=;
        b=K8iD7OT7pyfjFaKI8imIMcTUfXJFKzFP01BWNXe5WUAXpLmwj6E/FD6xF4LM/D7LX2
         PkfjKeQ6b2bus8gTA5hpLZj2109SOxmhrmTfmF0uQ3gch2UZAzgmaBlLvgq7M2gFehlY
         hpLahFqwuOjgRxsZUrivyebmcgaUCd5w8JyU+OlAHy4R2wlzu/1DKXeiwaBToXLOGdaX
         qMvVhRfp1bfK0v8A2ExkRvhoxQ0ztmTeRkAP5j8jnHRtocKphxqGRGa3dNNRfhwwMSlZ
         Uam0waIj7eIgSNNcA9vhrAvvmp+FgBZhlEa2CBCMuCitZOgbDBHQAvQDKV15bWZbnGTt
         HukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821137; x=1708425937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4Ldg9krU0VciizTZMuqyom4NDFd6bYrpebN+XYb13Q=;
        b=U45im/n5LxEz4z0q5NJqr6bLgPqvFnRabza7XhGEh9ef1wDbKO4ktlMrTlddkOFaFA
         uYQyolUu/ySFMO0WLQ5HF+zoqGqXvQAONv3i3/SGgheHIFaLjKUjvS5Rq/9HeG7U9yBB
         1wQcT397eMk0qGsNjf1gPiFFM7Uz4hUTsuMOMUMByH4fIUpzbQybGwXTS4CkWLp5EQ15
         xH1PT4fVv+TK2AyElFgn2mwwtMztWHPvtSXzruFryF7FYfT0KIVbZhLNvRYg9F8mNsNZ
         8l7rZctRksIMdDrrZWe3GaiqhisBcbNZqUMhGhQpMBiY+SeirWrmLXcN2zWzxcIwap5Y
         JMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWf9D5kwKxRcseb37GTnGkeJj5hmQqzjz+Co5gtfFGBP/xZkGCrASjrDY/nGZrGuhRNfxFuk7yD9QgqktAPZCY2UudjNsAh5wLgBRU
X-Gm-Message-State: AOJu0YztJHvU7v432ZWzoHuTIDrLLu9TvHaeBGYwVMiW34byU9TC4IqX
	pCAHi6bTB8Ma9GW34w8gxFbzlnJvZPzLTBvdnlUFxa2RRsKHVbMFWnpmNWUqhwg4p0FDy1YqWeb
	3KYgxckndeA3u55pLlGZYWSsbR2g=
X-Google-Smtp-Source: AGHT+IECzNXHRiNKgZeTNYhO26GK7CA7zxeXv2ILpUVDoBivsD3weIs0SnG9L5esbCH0OI5dHErsWfylMZfTkpTmiEQ=
X-Received: by 2002:ac2:4288:0:b0:510:323d:6402 with SMTP id
 m8-20020ac24288000000b00510323d6402mr5823497lfh.45.1707821137306; Tue, 13 Feb
 2024 02:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-8-d953846ae771@maquefel.me> <Zb_A5H5kkxw1oiQv@surfacebook.localdomain>
 <99042a0e72b3d29bc4b582a42a70d667033e6331.camel@maquefel.me>
In-Reply-To: <99042a0e72b3d29bc4b582a42a70d667033e6331.camel@maquefel.me>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 12:45:00 +0200
Message-ID: <CAHp75Ve3ZO4zAkZ+ph_jA6YnxafxGnC-CrfuPTjV3=cG2n-+-A@mail.gmail.com>
Subject: Re: [PATCH v7 08/39] soc: Add SoC driver for Cirrus ep93xx
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Conor Dooley <conor.dooley@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Joel Stanley <joel@jms.id.au>, Linus Walleij <linus.walleij@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, 
	Huisong Li <lihuisong@huawei.com>, Walker Chen <walker.chen@starfivetech.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Arnd Bergmann <arnd@arndb.de>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:33=E2=80=AFAM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
> On Sun, 2024-02-04 at 18:52 +0200, andy.shevchenko@gmail.com wrote:
> > Thu, Jan 18, 2024 at 11:20:51AM +0300, Nikita Shubin kirjoitti:

..

> > > +static struct auxiliary_device *ep93xx_adev_alloc(struct device
> > > *parent, const char *name,
> > > +                                                 struct
> > > ep93xx_map_info *info)
> > > +{
> > > +       struct ep93xx_regmap_adev *rdev;
> > > +       struct auxiliary_device *adev;
> > > +       int ret;
> > > +
> > > +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> > > +       if (!rdev)
> > > +               return ERR_PTR(-ENOMEM);
> >
> > Use __free() ?
> > (You already included cleanup.h for other cases, why not using it
> > here?)
>
> Why should i want this ?

To eliminate the necessity of not forgetting to clean it up when it's neede=
d.

> I don't want rdev being freed on out of scope
> - rdev is freed in ep93xx_adev_release().

It's irrelevant.

> But thank you, i've noticed a bug - i should free rdev and not adev
> both in ep93xx_adev_alloc() and ep93xx_adev_release().

Exactly to avoid such mistakes, so please switch to __free() along
with no_free_ptr().

> > > +       rdev->map =3D info->map;
> > > +       rdev->base =3D info->base;
> > > +       rdev->lock =3D &info->lock;
> > > +       rdev->write =3D ep93xx_regmap_write;
> > > +       rdev->update_bits =3D ep93xx_regmap_update_bits;
> > > +
> > > +       adev =3D &rdev->adev;
> > > +       adev->name =3D name;
> > > +       adev->dev.parent =3D parent;
> > > +       adev->dev.release =3D ep93xx_adev_release;
> > > +
> > > +       ret =3D auxiliary_device_init(adev);
> > > +       if (ret) {
> > > +               kfree(adev);
> > > +               return ERR_PTR(ret);
> > > +       }
> > > +
> > > +       return adev;
> > > +}

--=20
With Best Regards,
Andy Shevchenko

