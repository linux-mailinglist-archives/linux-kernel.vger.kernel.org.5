Return-Path: <linux-kernel+bounces-150433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE78A9F40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161E1281969
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4316F84D;
	Thu, 18 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNp3qgbJ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6116D4C0;
	Thu, 18 Apr 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455810; cv=none; b=qZPtc5QQB9KNOeIpV6MFqsAKGWuqtGIf8Mn14Jq45hgWR0jfg0p7ftScnufpVYHPaaZptDze2LXvXrO1rCe1BJsYfuJm/a7r40BJxEKuw+brm76ckZeiI6ngaySS5/0cS1QPO7sQVJEpmM/7Z96QxYH3tcK8KP7F/LOIiIVbFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455810; c=relaxed/simple;
	bh=aBUT2+pQDzYwiVZKUr+Rvc3cYxV7V4n7dBGY3Vt9cNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxU5bt75kgLHZzrf338bXiHz3YasJfvsje+B2MHB5NEJGhEzTyPXSzwMTR6InmdS/1WJEYkIQVSeNojuYjxcn/ZcNLoM/bEX+rkZzk/U/psSYg41v3hxNRZ9VCZ9npZJLJ9Gzw2YIwpZOW1lXlptsJ1BBSif0BSrFJpC8S2uyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNp3qgbJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso1698772e87.2;
        Thu, 18 Apr 2024 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713455807; x=1714060607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVAgtcipfkcWMHjlW6nU5upWM2mMxhSXqMN6JngOSHk=;
        b=YNp3qgbJrbjjBWuirX0TRgGuMKJqG6tJzt4WupmJYKCTK52NTWYZSAP4lMn47lGdGb
         Ix6KiGEKGdscZ9pUGRYS7hYxAsFn2AfUb9f10fVVXB6L1Sbf7AdZNU7EdCaVWYZ++JOi
         zaenZ9OflDADMvtqCFkyFXoDur6MyLaGI1s8R3m52Rr/wXJ+0jgWSPAUd5r5RMCj6ABV
         q9Ex9HQRSBQ04jVY0pHtfhO3J7+94dwMpRdNyY7ThIC2MUg2iZuxG71/jca8XW3LmD8D
         zfK/6HaVFRl/tT3KpyU6xPNE+urxfzW/BQOMrocNU/1NQx6rb2E9mWd33bg1X7rI2w7S
         20pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455807; x=1714060607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVAgtcipfkcWMHjlW6nU5upWM2mMxhSXqMN6JngOSHk=;
        b=wiwpgrULwyy9w7ALnutQLw+RqJou65g7ogP24sj7DYqtVBxS+4IJHrgfaUNQz7yC9d
         6rNrJNVzxxfnapriaEF6KDHAvuYK/bWcXojzvIF4eB20OqMeka9rRnQMzL56zYEit7W9
         vApcbJIgqUqITLyJ9EWNjid0VtI75zU6dC0DwkOZL2cZVvMeQY8AeFcwVAErKNNGBOX/
         x84+NADKDTjLULI9b/ASWzjE0pXh9QiFcvDegfblX9JZh9XStrV/S3veoW777UZ7q0WM
         qbhKAbYP6pIQk+yfen1aDlTD5QgrRUmW+hvPt0ot6JTZT89qbHSf0MUnci1bnkVuvcdB
         2IOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+dSxK7wXtO/IXUt0d1I2NkApT0TgGDt/z6bea2eOQflBZJoYlQeqpgYATJoILUQW+jL6RYb8o53FO8arGKZy0aQ5TU6iSxBAJB4Itorwt6cr8P0Dqgka2gxZL0kw+jwUNZO7tskmpDOU/pzNr/n3rG64ycE7C5f0UwR/BUZGcTT8IL4ra3QuiOd/RrT3eprKllsyTXvSCavSpaDnub84
X-Gm-Message-State: AOJu0YxLvm1D+bGd9fBt9FX9PlTyYgYJop4k3UDwJIwESt/FILNGFRHe
	AP0MX2jyiR0kJnZ0k9NeSkuLHahHsC4pmJm71Ps5iGV82Goedr2bw2UgUorNHjq+kmDTwQvcow3
	6Rsxu/4mEZ8imtnrfOPspKnMDZFg=
X-Google-Smtp-Source: AGHT+IG1UvVvPMawq0PN1G95h2KMXcAMXcVnwWBMLVJAP/s7QKISoICSyXIA62E97yFHemf7G8s5MxQ9F1kvhWxIZAo=
X-Received: by 2002:a2e:8383:0:b0:2da:b1fc:8095 with SMTP id
 x3-20020a2e8383000000b002dab1fc8095mr2163555ljg.7.1713455806891; Thu, 18 Apr
 2024 08:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org> <20240414175716.958831-2-aren@peacevolution.org>
 <CAHp75VdZavToGYqLYnkKYt53HXoQxXnRER5Cn5b2==gWTvkAWQ@mail.gmail.com> <xxeg3as5m5vmmu6fbjujcnvchrerxs2rr42nloirwsktbv4r57@vpxtxblxmspl>
In-Reply-To: <xxeg3as5m5vmmu6fbjujcnvchrerxs2rr42nloirwsktbv4r57@vpxtxblxmspl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Apr 2024 18:56:09 +0300
Message-ID: <CAHp75Veoibnk2pYuAY-T+u=8t7ackQ8zBjxSHcWb1AeHnq84yQ@mail.gmail.com>
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

On Thu, Apr 18, 2024 at 6:06=E2=80=AFPM Aren <aren@peacevolution.org> wrote=
:
> On Mon, Apr 15, 2024 at 05:04:53PM +0300, Andy Shevchenko wrote:
> > On Sun, Apr 14, 2024 at 8:57=E2=80=AFPM Aren Moynihan <aren@peacevoluti=
on.org> wrote:

..

> > >         stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY)=
;
> > > +       if (data->vdd_reg)
> > > +               regulator_disable(data->vdd_reg);
> >
> > I forgot to check the order of freeing resources, be sure you have no
> > devm_*() releases happening before this call.
>
> If I understand what you're saying, this should be fine. The driver just
> uses devm to clean up acquired resources after remove is called. Or am I
> missing something and resources could be freed before calling
> stk3310_remove?

I'm not objecting to that. The point here is that the resources should
be freed in the reversed order. devm-allocated resources are deferred
to be freed after the explicit driver ->remove() callback. At the end
it should not interleave with each other, i.o.w. it should be
probe: devm followed by non-devm
remove: non-devm only.

--=20
With Best Regards,
Andy Shevchenko

