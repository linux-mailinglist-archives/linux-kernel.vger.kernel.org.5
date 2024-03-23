Return-Path: <linux-kernel+bounces-112441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15308879E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0B9B21423
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056B56B68;
	Sat, 23 Mar 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKSZ7gsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7E53E2D;
	Sat, 23 Mar 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711218056; cv=none; b=ARBUDYbWYaXC5ZDVxIeuyF5fSEUUVIBeDBDo/x9S7fKC0ubIJ7zW/9lShonb9tyjSE2HuC/hOe4ehT+7xZpdt4wD0cb/3RigAqWkOvgEFSI3JOiGgklG2rzT1tsF9kRmhwjiF7CuH5/FjQIVWbJNCzRX4bTgYinXFh3ZZnzEekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711218056; c=relaxed/simple;
	bh=h8zWVqUfcYk45b6ED46DW0u58jYaER/RJk1VldSpm6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBIB6ThUnv3Sx8HZlpVjtgBhcs9cyTVj2hjQNT8GmYyl5RXH1fPxi0ff9mR3E6ladSJqbJqJXq2AsD3Q3O2m/Xiw3zBcRkVZCz/yFsWUwXrCaJu5gWwM7mKm0i10Fvaa59dNehba/zEZ/L/NGJ6D47lW8Oe864MIH6eBKC1HHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKSZ7gsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F74DC433F1;
	Sat, 23 Mar 2024 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711218055;
	bh=h8zWVqUfcYk45b6ED46DW0u58jYaER/RJk1VldSpm6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UKSZ7gsT4C/pOUkyCAva86I+uYYZM3kjXJ41fFq5VjnD/bg5Wgl7wqapidAke6Rn7
	 tuh41EebrbJTnaOJSjqao2Qro1KlatSjz618MBdg7vX4ayYl4rRLb1x2SNfv4uFYRE
	 zrj7HmUeRibmYHWxoRdMIF1ijQqSo/wQXiz5OmUlvVneunQpGn1lZeEwNuMt2GY0yV
	 ni6eDkqJPWJlP/ZtQZUz6057XADCKG6xiOwAjfE7XRWd3ST9yGXH6Tvd9nu0KymljB
	 zNwJWUDD7SchkvTWG0JKYmAaIcSagpS9aT5UCThYlQu2NY2PZBdAyE2KysMFD2jzGz
	 +VfSHzV0ShVmw==
Date: Sat, 23 Mar 2024 18:20:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <20240323182041.5e1ef0bb@jic23-huawei>
In-Reply-To: <CAMknhBFNnePpn5j=f-RXJCw11=4TTORhG0mt+FqazLQwvHBtPQ@mail.gmail.com>
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
	<ZfX5jynjW4M9pvw1@surfacebook.localdomain>
	<CAMknhBGMUQFoQ9TxTTgy0dxHoyXkt+5tS93tpwz5Wo=h1UQD3Q@mail.gmail.com>
	<CAHp75VcP7sZKgoXzgTihf96rc5rz=U0Amoardj1Sy9uTMDHknA@mail.gmail.com>
	<CAMknhBFNnePpn5j=f-RXJCw11=4TTORhG0mt+FqazLQwvHBtPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Mar 2024 09:33:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sun, Mar 17, 2024 at 3:23=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sun, Mar 17, 2024 at 1:10=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote: =20
> > > On Sat, Mar 16, 2024 at 2:57=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > > Thu, Mar 14, 2024 at 12:43:38PM -0500, David Lechner kirjoitti: =20
> > =20
>=20
> ...
>=20
> > > > > +     case AD7944_SPI_MODE_SINGLE:
> > > > > +             ret =3D ad7944_3wire_cs_mode_conversion(adc, &indio=
_dev->channels[0]);
> > > > > +             if (ret)
> > > > > +                     goto out;
> > > > > +
> > > > > +             break;
> > > > > +     default:
> > > > > +             /* not supported */ =20
> > > >
> > > > No error code set? =20
> > >
> > > This is in an interrupt handler, so I didn't think there was anything
> > > we can do with an error. =20
> >
> > return IRQ_NONE?
> > =20
>=20
> Wouldn't this just cause the interrupt handler to trigger again
> immediately resulting in very high CPU load? I don't see any other IIO
> ADC drivers using the generic triggered buffer returning anything
> other than IRQ_HANDLED and I always assumed this was the reason.
>=20
To me, this is a long running 'open question' of what to do on error
in an interrupt.  I my mind at least there isn't a good solution so we tend
to just paper over it.

IRQ_NONE indicates it wasn't our interrupt - so if we check a status
register and none of the interrupt bits are set, then it is either
a shared interrupt in which case someone else will handle it, or it
is spurious and we want the spurious interrupt handler to deal with it.

If we get an error talking tot he device during an interrupt handler
the question is do we want to trigger again?  If it's a level interrupt
and we haven't cleared it we will anyway, but for edge interrupts we've
handled it as well as we can perhaps.=20

Anyhow, it's all a bit unclear so given we don't expect to get these
errors I tend to more prefer IRQ_HANDLED but if someone argues
strongly for IRQ_NONE I don't push back too hard.

If anyone has clear guidance on this then please link to it!

Jonathan
=20

