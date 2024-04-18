Return-Path: <linux-kernel+bounces-150622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B78AA1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AA1284AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642117AD88;
	Thu, 18 Apr 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjAaH3rT"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED117AD78;
	Thu, 18 Apr 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464405; cv=none; b=JTl5T136aYViEtvjP05htcCDkxO1NLqJ+NtqPrM6oj2NDymFAP6qriHe6TT3lgBUvU9+HoBrykoTZOSMhb7/AqsDC5IzfjnhLKX1U2rqinOwDmm/VUT+MdcJ4gBPl6bvQHRh2fF0teeosg6VRTS4ldKEXKwxsspNlR4yNJXhccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464405; c=relaxed/simple;
	bh=eG3q+zpUjWVOdPOZkaSjqo0usEFxFJPlILtnK4zyysA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfmKTG2ZNGM98SuYB+yHL5FSToNSnwhONOHGuvktWLGl9vzshp+VmPTFsnQEWki0bLSoh9o7J9tZ4q2Q5nd0kQb41/S3UVM+8TckDe+NUbaN9Bkt2gBJcKuZlNGu3LrV0QVZelYD7lpK6lsd3EfJJ5xSBabEGecTBYbtwIR03Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjAaH3rT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5196c755e82so1527929e87.0;
        Thu, 18 Apr 2024 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713464402; x=1714069202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG3q+zpUjWVOdPOZkaSjqo0usEFxFJPlILtnK4zyysA=;
        b=TjAaH3rTcwZ6baENl3JUClYjXuNMYAGnHMc2Do0UqNcXq6iKXfphcPn/YEuiQc04EH
         r6sovmdLq36+sYpiocEw/AYX493w5HBFxWxMhLbMf4NCEenXNb7/nK8BLX4Hn1hyVUJ0
         2DNQgSS06phU3tEYhDk5M0MqfTThvqeCrKofEvivuqxdWuCzYq3dKdZW4Sgvjij15cel
         vJTx7B7SmymBG36jrkDD5tZM/NVcSA6jCBVIVXN4n9g3BkMjWNq3Xvf9QaKTlZ5CZVxk
         wHuD6QAhNceA5HmJpltl4RRjs+yqh9nrjDT30v5N6GeUrfhAeRzgIIIfpW1/GM+f5dS5
         9dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464402; x=1714069202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eG3q+zpUjWVOdPOZkaSjqo0usEFxFJPlILtnK4zyysA=;
        b=k8HN+lQxyRGtaAmPcO8s5w6Fj+NU0E77E1VuDSlAcaP/P3hrlNIqb1Qx5R5DkKZLlC
         ZkK/FJsvCoQHo815a9tk6LZR7CQreeQ4sgcWQddOqOohefi7eK/f2cCdoELGFpwsA58m
         21T52ez7ahVoAUTNsF+SG9Nzp9xd6Icqg16CldY0pgG489+674McEO7nn+7s2Xisl/vh
         k5uQDejpeTMpA6OGWEDuTEvQz2DdytvXW//tIMItMvX/WYEh+LnaefehhhBPt7z/rnvm
         nfFRs0jodqN8OrAX/HBMWp+9e73V+sFjQ+Z74Pr9r1ZxGIBSQ2CrB2wtt0f7V1nRQre5
         TMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+3tBJQz6CLSEWc0ibw4jvg1KDXrqR8jP0nQyTCoMjmmvCWu3tvkynShwBExFvtoUekEmlBoc25AUoxiDbV7dqiqRhUZvxJZbCUvok4bk8rxGVzmgzkVNfEfej72orIacBZ8TathXlSt0hFhmFht+QqBXwaxpE8G4/v1K6nLyE8bV10ht+6KY4Zhnrq65YebLYAZt4SybWFBCSlqmtdxD
X-Gm-Message-State: AOJu0Yw0M5oi82PgzpNaD4YKRgpGI3SuKSnfOdIbr16GWHWK2NCSCD6i
	Rr6FJb+Te5wwp6o+7k4wK79RQw1hVcnFtsQircUMeFBz398tSDKeRbLABiTnlUU58HgyCqqF5ZQ
	wOLWlntBPhgWM34pdjte+VNuLprI=
X-Google-Smtp-Source: AGHT+IHalOQ/s3NxiyYDgT5G+ca4oEPzuDrE48u3GmuLSNbZCinbhI/Pfbda9fQysbueYW+MPNlitEcynwqbQEQ4c54=
X-Received: by 2002:a05:6512:3b1e:b0:515:9185:652f with SMTP id
 f30-20020a0565123b1e00b005159185652fmr2480035lfv.33.1713464401599; Thu, 18
 Apr 2024 11:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org> <20240414175716.958831-2-aren@peacevolution.org>
 <CAHp75VdZavToGYqLYnkKYt53HXoQxXnRER5Cn5b2==gWTvkAWQ@mail.gmail.com>
 <xxeg3as5m5vmmu6fbjujcnvchrerxs2rr42nloirwsktbv4r57@vpxtxblxmspl>
 <CAHp75Veoibnk2pYuAY-T+u=8t7ackQ8zBjxSHcWb1AeHnq84yQ@mail.gmail.com> <fvuaq2yo4jh6jc3cklkvatr5r5du2jzmqblvvkpkpmxdt7e2ys@345lrhtnipfw>
In-Reply-To: <fvuaq2yo4jh6jc3cklkvatr5r5du2jzmqblvvkpkpmxdt7e2ys@345lrhtnipfw>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Apr 2024 21:19:24 +0300
Message-ID: <CAHp75VdvbQzwqTBzioqVkiV4vHrQFX6UpoDce1t6whWYHcXYKw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: light: stk3310: Implement vdd supply and power
 it off during suspend
To: Aren <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:50=E2=80=AFPM Aren <aren@peacevolution.org> wrote=
:
> On Thu, Apr 18, 2024 at 06:56:09PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 18, 2024 at 6:06=E2=80=AFPM Aren <aren@peacevolution.org> w=
rote:
> > > On Mon, Apr 15, 2024 at 05:04:53PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Apr 14, 2024 at 8:57=E2=80=AFPM Aren Moynihan <aren@peacevo=
lution.org> wrote:

..

> > > > I forgot to check the order of freeing resources, be sure you have =
no
> > > > devm_*() releases happening before this call.
> > >
> > > If I understand what you're saying, this should be fine. The driver j=
ust
> > > uses devm to clean up acquired resources after remove is called. Or a=
m I
> > > missing something and resources could be freed before calling
> > > stk3310_remove?
> >
> > I'm not objecting to that. The point here is that the resources should
> > be freed in the reversed order. devm-allocated resources are deferred
> > to be freed after the explicit driver ->remove() callback. At the end
> > it should not interleave with each other, i.o.w. it should be
> > probe: devm followed by non-devm
> > remove: non-devm only.
>
> I think what you're describing is already the case, with the exception
> of parts of the probe function not changed in this patch mixing
> acquiring resources through devm with configuring the device.

Okay, then we are fine!

> I hope I'm not being dense, thanks for the clarification

--=20
With Best Regards,
Andy Shevchenko

