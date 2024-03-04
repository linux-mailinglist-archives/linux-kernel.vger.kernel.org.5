Return-Path: <linux-kernel+bounces-90795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E5870523
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81521F23EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FBA4C622;
	Mon,  4 Mar 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pvUYGsix"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3592C18D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565333; cv=none; b=ImVW0O+5FDFI4yWyHEHo6ORexx1DkLbANS1aSGIHxYYW/fpKzy1kMVtu7a2ohUO+7zalvgF9xqzATtzDjsuZe64m1kVdZDKjjx9GgzpO34znIxGNKaKJV9vpV2kr0uZaDRx7VefAYBzaigi3MViYDYQAE7FkzXnnpGAprPskYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565333; c=relaxed/simple;
	bh=YxbTFoLqP6oY280USyFbflYr0v1oTqG8VedpUTgh7JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOGqhGVUpali5HiwVVl1w3EpJpzyvUY87iPa1uxWOw6b5mobs14MD78fRm2+V86VzMowjBaqB8Z3YY2KHIJJBM4pXE8zoL97xLihcr6umaJf8KzktX1+5sS7D8cSQAiWXJpxly438rGXreO5vPGpeM978MukSGAeySfVqb2Ufo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pvUYGsix; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7daf95b096aso1258111241.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709565331; x=1710170131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYjJ9NXUu5m1nDaRsg8bhsfXlzVxtGulq6ljiUHV0SA=;
        b=pvUYGsixQ123Y425uz1ePWL2lJdDw5rOwviYexooqHTqECkY4BduexWPLvsFOtEzjc
         fbiFXtkvFWAy1RXD0UjM4Qp6pMBb9asQY5/mvlQm4EdCmlbpPZezhWzb8gbGSZUH225Y
         qR8Fe0VM44giTUAL/NYhdSWcGi7YXH1ShHaJvd/XU0/xyhtnhVwAf1bjohiJC6jWs59d
         NeiKMfFq9ciK4MPFg/kNDLUcJga2kJNfeNuh1RWHje+ch5eGG83uuMsqpLd1te97Nkud
         EMqgvxqGKuhIIxvJHu4l99CDvoHBuBWhLMAJUUPN3lIBG3/okw17qmoEJwEM/NmvwcBx
         VqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709565331; x=1710170131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYjJ9NXUu5m1nDaRsg8bhsfXlzVxtGulq6ljiUHV0SA=;
        b=h1V+pjcmO96pMwnyC3T0wC4eX+xAc7mB1yTXHgR6NFpb0bKfbKvfo3eESWbnLWiEg5
         NeBhgG2YOMnH51oI57PtmIe26KS0ryPg7LE2YNOll86RweLUF5dheAxLmk9Toa5desnE
         jDGmS2kH+o5LHLahDAprckszdi45FGDueCw+Gmk+P+5R1+aBf1du6PSl6AkPn9cfWJZl
         EIMZN69f7BMkvTjrad30PAhdk0ki765Ms5ml7x7fzU3Drsl01rkYv0mIKilJDoMpe90v
         pfHdd+ShBrvsb32TvxX8/XZU83XU6LFRaLecD++mek6byVJ2GSrUcR9PCu6lwriMwTD5
         3L2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAVGuS/6SWxUuRTroccg9ab6eJuLTY6rCwtOwNelC5eY4ntg1qXbzhqAWS5OZcfZOmtMkGzc+Bonn42CCx9j8Fcrsc6CAJRymWXMvx
X-Gm-Message-State: AOJu0YxcZvINEjMQ79GHp3/ztGjgNMHV88Epcunmkylax699BTefw0uQ
	YiI/i+eWZFAzz8s7sPFs0w1cK0K3Gv7XMzGf6tsQBH8i4a7YQW9yfsSbpr4gwZvzXxN1rS0BcrJ
	oArP0KXRuH0VA95PwZpsN7pzfGh0GtC/BqcvwI42gH+vawFWc3LUgDA==
X-Google-Smtp-Source: AGHT+IGcUa2shBJW7CAhyhkG6SYS4eHgsUA4RZw2fnlT7G4lYKf145+I8+ZU6+U6BcVoB5jryN+nBitx1d4WjxESkak=
X-Received: by 2002:a05:6122:3685:b0:4c7:7407:e8ab with SMTP id
 ec5-20020a056122368500b004c77407e8abmr5906270vkb.12.1709565330774; Mon, 04
 Mar 2024 07:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
 <ZddL7L24RXoqR7sN@smile.fi.intel.com> <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
 <ZddOcJrYEANc2B2Y@smile.fi.intel.com> <CAMRc=MdABvY8dC+UBpkoLiHc881UFKv0VAQsCUhqnxn3f5LKRQ@mail.gmail.com>
 <ZddPEHjLeiYUd6Tb@smile.fi.intel.com>
In-Reply-To: <ZddPEHjLeiYUd6Tb@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 4 Mar 2024 16:15:19 +0100
Message-ID: <CAMRc=MdDDz1HHqB4pkHFv+_A4iVdh7m-R2B9BrmotRW3Pm2EEA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 22, 2024 at 02:40:05PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 22, 2024 at 2:39=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Feb 22, 2024 at 02:30:03PM +0100, Bartosz Golaszewski wrote:
> > > > On Thu, Feb 22, 2024 at 2:28=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wro=
te:
> > > > > > On Wed, Feb 21, 2024 at 8:36=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > > > > +       while (desc_index--)
> > > > > >
> > > > > > What about gdev->descs[0]?
> > > > >
> > > > > What about it? :-)
> > > > >
> > > > > for (i =3D i - 1; i >=3D 0; i--)
> > > > > while (--i >=3D 0)
> > > > > while (i--)
> > > > >
> > > > > are all equivalents.
> > > > >
> > > > > The difference is what the value will i get _after_ the loop.
> > > >
> > > > Ugh of course. But the first one is more readable given I got trick=
ed
> > > > by variant #3 at a quick glance but the for loop says out loud what=
 it
> > > > does.
> > >
> > > I disagree. `while (i--)` is very well known cleanup pattern.
> > > Less letters to parse, easier to understand.
> >
> > Whatever, I don't have a strong opinion, just rebase it and resend.
>
> Sure (just will wait to the fix to be settled down first), thanks for rev=
iew!
>

I realized you haven't resent it after all, do you still want to change thi=
s?

Bart

