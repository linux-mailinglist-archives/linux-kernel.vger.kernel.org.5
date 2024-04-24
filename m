Return-Path: <linux-kernel+bounces-157401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7508B110B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B332812D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254416D304;
	Wed, 24 Apr 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB6/MbLd"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65316C86C;
	Wed, 24 Apr 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979927; cv=none; b=Iv7NENQGWSSQb+u4kn6gbtA8YBUC2sxHQZ2JOSrcYxjrozlpnhEWgPJje7i++jtcqcSTk3WTygrL8R/yxje45Tv1Q3PTIB/YLC8x38fRDWqcy3KnBoTClJlc/Dud2UiZJXsa9JM8n8eCExl4jXjUMo+pgAfFHMx1CW2bl8nqL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979927; c=relaxed/simple;
	bh=ky9dC23kSEAjIUMZjZQj9SM0S228EZJh/y7s4ODPVSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nA+bttog1B0xtgMeZgMHp51+1W4nEV1TAF4gqkw0PKx0Qko2ppOXkuaRdm3Yh4dnfQ2/1S+QUAysR2VvJQjgHaQcDiSOdKMXxGDi2fzX24jXOjwh3k5R07GDWnprfCB8HNx+I4XKpX8B+HfaTf88jNjaXbGs6BVDTL6mt3coKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB6/MbLd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57222fc625aso46276a12.3;
        Wed, 24 Apr 2024 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713979924; x=1714584724; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La8CBY8A7K5cRWiONNuB5nscgpRq2aalZ6dE+X4zZYQ=;
        b=gB6/MbLdDzb8j0rXN9PPzPk6DLS9OXqtp3JHUvs2GRpROOjgpOrS7mx/NXxo/78XZ5
         ntt5gWz9F+FdUGS9kvaWY8KWTv4vmkuHPYiAd2WvOgBLv81VJAO8BhHvPGZT0C1au6zY
         dcp8QEa8vVGU2FwNxVK4sM7yA7YD/TJwfnFoGbH4/PQemOfYbAbpVdO05pSiiCgrg0mA
         U1PA/TNisjD4P8LlhOLzioF44FTQX5BrOEJKqdXqPnRBY+rZkMsqFZhYE1/78GIX1pUU
         9U0d+Qy15dvYRbcr2s3oYWKa3tEVwXUqquXSPiMuU1CXGekvCFAi+BiliOqK3f/GfIsL
         +N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713979924; x=1714584724;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La8CBY8A7K5cRWiONNuB5nscgpRq2aalZ6dE+X4zZYQ=;
        b=iDbIqs9mh+JA7ARwNKq/k7PPupbCNPOZV1Ak23cPsfSvCv7+5uaZ1Yh5SxWPEvLMBA
         dNRBTLE/yJKKHTK2y2Xst25iEOs+h6qg4X7v5mKeB0dyT3LWWEDiwhAUEKtZRpybDa28
         4HdfQYtvx4r+7D3VyqSG9opHEsvK2MY74hnZWmAE4M3USoOwnpC3pehVxi99s+WeJovs
         H99dTp19KIcvmnZzj2/AsFpQbwtashptCuC/oJmCN/Cq3UEpd+T7tkWI9LIlMcg/MqYx
         xSt38uPU3W6WMiIIC2q50vorXlqhnjpvUwQFEDp+Qi0CfYUFCFw43oIMFofiiZj/x8gP
         VB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfA1kzdocg+RFdQYhxwhiwuFQ7QzI6zOBoWzmzOtZmAlcxr/qCXZ6N75oHn0H5paIF5DekksgBNoOaTqeRjojvfxsxMo81NQQjCPo7eK9vtoLyxLaGj5cdfmIxmBDh53jnYGts6VPc7BSLodE7CKgxWG2JdW8w80BuohyluB2B8fS525ejkrqM7EyzvjVx/8tJg+naUZJ0zZNsMN13XO9e
X-Gm-Message-State: AOJu0YzAa48r0e8Yji2+TSXNHqkjmDkcfZYoZFYvzoEjHwGdpZmBwhsf
	sYsKaNpQQ/0v6wXbS4Ca1hz51xGLyZ6r/6E7SkKaZEHyjcyLJVXwXjdShimeW5vOhX4ouJxVcxh
	H3WyDF292J/rirp4DljiHiBFlVeo=
X-Google-Smtp-Source: AGHT+IEHsGNzCu85UmN/IAwPLj4+iSJ8a0O7TKVWxRZUR6ImV/Qxw+2RnQGWugEoeniUZrj1ox7+m8kyWcG2g89JkaQ=
X-Received: by 2002:a17:906:6d91:b0:a52:28f:5e61 with SMTP id
 h17-20020a1709066d9100b00a52028f5e61mr2933730ejt.27.1713979924148; Wed, 24
 Apr 2024 10:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423223309.1468198-2-aren@peacevolution.org>
 <20240423223309.1468198-4-aren@peacevolution.org> <CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
 <5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
 <CAHp75VdR9HtWbSif+j8QHX5zG9xPF1GzUFY2s-0OjD3RAWD9-Q@mail.gmail.com> <xxbwdl6ebvut3u7qhzfy65e4eheixghqe7yn4qemyuowxyxj5a@r2wa2b7bhw2x>
In-Reply-To: <xxbwdl6ebvut3u7qhzfy65e4eheixghqe7yn4qemyuowxyxj5a@r2wa2b7bhw2x>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 20:31:27 +0300
Message-ID: <CAHp75VejwJ7h5jaNL+VL7FE4UMbTEP3QA1E=_y-1PSrz99zBKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Aren Moynihan <aren@peacevolution.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 7:14=E2=80=AFPM Ond=C5=99ej Jirman <megi@xff.cz> wr=
ote:
> On Wed, Apr 24, 2024 at 06:20:41PM GMT, Andy Shevchenko wrote:
> > On Wed, Apr 24, 2024 at 3:59=E2=80=AFPM Ond=C5=99ej Jirman <megi@xff.cz=
> wrote:
> > > On Wed, Apr 24, 2024 at 02:16:06AM GMT, Andy Shevchenko wrote:
> > > > On Wed, Apr 24, 2024 at 1:41=E2=80=AFAM Aren Moynihan <aren@peacevo=
lution.org> wrote:

..

> > > > >         ret =3D stk3310_init(indio_dev);
> > > > >         if (ret < 0)
> > > > > -               return ret;
> > > > > +               goto err_vdd_disable;
> > > >
> > > > This is wrong. You will have the regulator being disabled _before_
> > > > IRQ. Note, that the original code likely has a bug which sets state=
s
> > > > before disabling IRQ and removing a handler.
> > >
> > > How so? stk3310_init is called before enabling the interrupt.
> >
> > Exactly, IRQ is registered with devm and hence the error path and
> > remove stages will got it in a wrong order.
>
> Makes no sense.

Huh?!

> IRQ is not enabled here, yet. So in error path, the code will
> just disable the regulator and devm will unref it later on. IRQ doesn't e=
nter
> the picture here at all in the error path.

Error path _after_ IRQ handler has been _successfully_ installed.
And complete ->remove() stage.

> > > Original code has a bug that IRQ is enabled before registering the
> > > IIO device,
> >
> > Indeed, but this is another bug.
> >
> > > so if IRQ is triggered before registration, iio_push_event
> > > from IRQ handler may be called on a not yet registered IIO device.
> > >
> > > Never saw it happen, though. :)
> >
> > Because nobody cares enough to enable DEBUG_SHIRQ.
>
> Nice debug tool. I bet it makes quite a mess when enabled. :)

FWIW, I have had it enabled for ages, but I have only a few devices,
so I fixed a few cases in the past WRT shared IRQ issues.

--=20
With Best Regards,
Andy Shevchenko

