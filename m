Return-Path: <linux-kernel+bounces-69001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232E2858337
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6BE28551C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B877130E48;
	Fri, 16 Feb 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQZOmAn6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB0130E3C;
	Fri, 16 Feb 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102868; cv=none; b=DTwCTaSefGipalZEBsSPfEgDJEdwJO1qV1Pfn7oKytxKKFWL0y48ZtjPdTAkhu+2PP0xXa1uvjTeIzRp+Ly1BXItgVrv5oBaD77TeLv3vjyoWyw29bXIbL1c2+a9Z4sbvPTcA+F1Uszd1dPJ3HXLqVcxoToUJMY79yyrdXFv9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102868; c=relaxed/simple;
	bh=QIGn6C67UP/6QvFhVFu1DP65JGMjupNiEXX7Y9U0G1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwyW76h1qjHEdEPGbg8nMlrw+ZzOPdDkrdTv1n4gcybDcm7w3oNeZwAWq0g1RgoDwkZMtmaSEjhsoz/oAkDgr7GelThRuN+LQ+WUg+HBnqYm8fbKhcbALCRuDSdIvhdg5Dcx20VVlr3BMZeEl80wWl9yKBkdOcrM10kthQ6jBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQZOmAn6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e05775202so31390066b.3;
        Fri, 16 Feb 2024 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708102865; x=1708707665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztXazuWgeFLTVRCzNp0sF29aKvhsni1fvdU/hqpY3uo=;
        b=BQZOmAn6G9XgOVtQRGOVwZYNMtZzRiwepAaBX46P2h+QfGKVSKMVPW3ZtACTb48Uz6
         6MAWv5TEFNkjiiHeEnRm1+DPaMvlnCUD0+cE2jj9ywS3g08x7cTmxqWcso+ixQVAfM27
         r7VQgXBdLidS8TKAXNcQMtnp1tx5cZpJcVJdJ9VGtYgsNrJ+gaYoSSgwfk7u/7TCfdkL
         UPz4yYyRsPhn517nYbzJHEMA9qdHseVF1S9qETysBT5tdoxgJcjklQXAYUE2COVIO94C
         TXXqyEMS4unf9cbXjvZ9iMRc6uEn7xWx61jrQIR0sSBGWdb/j4SeH1FUqSoToD32icq1
         vVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102865; x=1708707665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztXazuWgeFLTVRCzNp0sF29aKvhsni1fvdU/hqpY3uo=;
        b=cK8B7VXPz1uQXfndMg45QM8FxhQICpsFE3fCKwnRHqo81Wbng59xsgqOYutzd9yW8b
         5iwIF1c6/bVkD2eqdKBEyjrF51d8+cTIm/sw9zr6CCzwdNQUklAX6bZaznmEmaICwkun
         le88kvovb8msZexcGIvOZ23sYmt3Dkt5O17Macb5s12NETbZSSxZoKaNCZqBtmRcuGQ7
         KGp4LfpjiSLkutRkJk2S8pL6u30dxaDFEwpdZizt0OR/UgNMgmY3zpaN5+Hk9XWeH/cX
         ZFlyHnp+KuJ4VP1J6wBXwt/4UpOkW+TPHtOxmhz4dZfBSxmJ91cUyGKn+z1/xtRdl4Nx
         KNgw==
X-Forwarded-Encrypted: i=1; AJvYcCXru78YbXDggNGd9bv7Dfo0+MIhjPNKGxcIKuE83h4d0H4FN3GwG0U2cRqW2zdBkFJBNBJTO4ODW4Vy0dCwVFAGD/wSu9c/kgHp8MF0riacgcEH4FClhXxibjAB2ugHEqdBWtkKkKR2
X-Gm-Message-State: AOJu0YzF6DlYfe86Vmt4ai+UumvsdyvdLDuCM75rrQ8hwEp2OlV5qt/3
	f2eP2fBV7p3mOOXLwTtEv19eCOKm1z7Kofc4qUn2FV8cUD8CTqyfCst2ZMzxTtq8hWO+i3/l0b3
	HTer9XEqbqLi89n5/ua2pc7Z3rSI=
X-Google-Smtp-Source: AGHT+IFk3s8UGzjSG4LKdeG+jC1wpKj1lCEkk2zmi8ut+064Q4kpWFf8zFjb1wXWM0X1a6tJ52bbQt3q7I+P4vzraUs=
X-Received: by 2002:a17:906:6d18:b0:a3d:d238:38e3 with SMTP id
 m24-20020a1709066d1800b00a3dd23838e3mr2226050ejr.26.1708102865262; Fri, 16
 Feb 2024 09:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
 <20240215180102.13887-4-fancer.lancer@gmail.com> <Zc5mxyTjq6X_QRsQ@smile.fi.intel.com>
 <4sbbhf4ltdwrmj7rrr6f7lnjbdxrwfjoutmcgsh2c44jy5fxzj@xgqdscqdnkkv>
In-Reply-To: <4sbbhf4ltdwrmj7rrr6f7lnjbdxrwfjoutmcgsh2c44jy5fxzj@xgqdscqdnkkv>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2024 19:00:28 +0200
Message-ID: <CAHp75VeK0kb40Ma9WjMAGQE9Y5O1OdeuNhQwDvYCaLHbvj+60Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: dw: Drop default number of CS setting
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:36=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
> On Thu, Feb 15, 2024 at 09:32:23PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 09:00:48PM +0300, Serge Semin wrote:
> > > DW APB/AHB SSI core now supports the procedure which automatically
> > > determines the number of native CS. Thus there is no longer point in
> > > defaulting to four CS if platform doesn't specify the real number.

the platform


..

> > > -   num_cs =3D 4;
> >
> > Simply update the default here?
> >
> > > -   device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
>
> Do you suggest to simply:
>
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -364,8 +364,9 @@ static int dw_spi_mmio_probe(struct platform_device *=
pdev)
>                                      &dws->reg_io_width))
>                 dws->reg_io_width =3D 4;
>
> -       num_cs =3D 4;
> +       num_cs =3D 0;
>
>         device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
>
> ?

Either this or do

num_cs =3D dw_spi_get_num_cs_from_hw(...);

What would work better WRT hardware?

..

> My idea was to make the statement looking closer to what is
> implemented for "reg-io-width" property. An alternative to what you
> suggest and to my patch can be converting the dw_spi::num_cs type to
> u32 and pass it to the device_property_read_u32() method directly:

..patch...

> What do you think? Would that be better?

I like the change, but again, are you sure it won't break any setups?
If yes, go for this!

--=20
With Best Regards,
Andy Shevchenko

