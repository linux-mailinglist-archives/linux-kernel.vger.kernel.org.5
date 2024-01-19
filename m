Return-Path: <linux-kernel+bounces-31421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25A3832E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723EE287F74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C3155E67;
	Fri, 19 Jan 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN2WSWBD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831AF43ABC;
	Fri, 19 Jan 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685126; cv=none; b=QLBGE6g4wWmOr+8uVf/E8sX8A3TcwCYe9naLyyqD+tMy5HPTcIQICcVgxoojHeb3POWIbOX8F0vA62GZeeaMKsjC5KjSzxstOflMyZeIzoCmGrog8tyk+nrp3L91u+Mn9CoUYNJoLRiCiNeiRQTrHO1Jj1ac7hALbk6OlcBA7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685126; c=relaxed/simple;
	bh=iwpLtpC3VoaXo/9dNwwAnOeyq3xO3HPbvtrcusavOkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZVA6pe5KWXfOb7yhFJQfVIWlouBZgd9fNTqyZGdvEItkf4Fd3i8+v3XetgocTj5RcQRZdbshffRGkPiE0qgLOjLBJk9XQG42ONNpcISCQ17yjLfXA5I+4CxgPUtmiBqeOlCSdFWVwOKD5azIBtyyzkNYy5Tvhd3gjNk2aQZQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN2WSWBD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso1287142e87.1;
        Fri, 19 Jan 2024 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705685122; x=1706289922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2xwilmGBZvQQTbXPdBchYmIXQPAhkMfZIZcjK72Cz0=;
        b=gN2WSWBDYtB5U7wB7DVn2BENUuIh29SYfT9KDu3qtdrsle4LZmKq0FCzKpyYCPakwc
         ZwIGycKBwVs152WUEgyFUgT6muUekWZZcJpxqFgWFF3cnUEWlP7Hn4CJUh5+Xy/hjeMd
         gIvcMbT4Z16QDi+5JXvWAyjwcJtFWFHsT/n4BPKhLc3ephWmW6qT+iz/fH+vt1edTWLq
         txYBprhnZ7xGm01lfwpU4/FUXhHN/hI4Cpf0NfXKJHQXIVz7+LhINvjA1yQLkT/GObyG
         Yfawd6Wwqd1e/V1afdXgr+x62z5kbqpIOFNwtJ6cJXFuK2geFlhZ5GZDbu2Qjzhi2x9y
         kTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705685122; x=1706289922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2xwilmGBZvQQTbXPdBchYmIXQPAhkMfZIZcjK72Cz0=;
        b=utCZW8gXW2OxA5Qz5H5FhFLy9TZ/BFEK3zC1gMG8muUwMt9coLhTHJb91L4PRXq4Zd
         ko+5QtYUd4vzJkR6djczhpqYOE+wUtZA8yN6t8mMz1C4M1E6m7OXMFfXyWxXx4iTrENI
         eGrki603ZhGCVLvii5PJpRz+DB8m4UruxJH32UgVG1hM9Xz9TnobB469SFfNUsQBugbK
         HEDd3+gW3zFTGzfGpjzSZi4zxvG62e8ODIZ0djjsoJHnLAAg/Bo+PNZZi9egKSImVUfH
         9Q+GZY7Y0YG8nu8aAQyUxEFNUw/w11bLH5SjVHWaH/9zY+yIQnsNgypqjf37T9NA79RY
         GZ0Q==
X-Gm-Message-State: AOJu0YxOti3jz4Rv3x4r6v7p+baMOI5kX+uYTGBMUQEVmOGxpk8CmTQr
	I6DcFNXIBUhQQYX9pMvMpTivAt0CrjxfYwHXKmqdDz65xR0eVo4fipxAtQO/SYiuA7SCNGAtSa2
	OK1dNNh715sDH6dHYn9SlRxnn7c4=
X-Google-Smtp-Source: AGHT+IF5XBmlwwuB2LVSDw9ikBo4az/a9C2r6G+L3etJbaHVu5L0DLlw90iBG9K5c+qoRpuFYDN6QuG5tfAYOseHeIE=
X-Received: by 2002:a19:ca18:0:b0:50e:aedd:ed76 with SMTP id
 a24-20020a19ca18000000b0050eaedded76mr463lfg.131.1705685122156; Fri, 19 Jan
 2024 09:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-7-ckeepax@opensource.cirrus.com> <Zali4qxdegY7H6eY@surfacebook.localdomain>
 <20240119165917.GC16899@ediswmail.ad.cirrus.com>
In-Reply-To: <20240119165917.GC16899@ediswmail.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Jan 2024 19:24:45 +0200
Message-ID: <CAHp75Vd_hnnuHQxmiPTkS5GdpEf3iMik9=51x55_Xgr+7LDJ3Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] ASoC: cs42l43: Add support for the cs42l43
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com, 
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com, 
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:59=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Jan 18, 2024 at 07:41:54PM +0200, andy.shevchenko@gmail.com wrote=
:
> > Fri, Aug 04, 2023 at 11:46:02AM +0100, Charles Keepax kirjoitti:

..

> > > +   BUILD_BUG_ON(ARRAY_SIZE(cs42l43_jack_override_modes) !=3D
> > > +                ARRAY_SIZE(cs42l43_jack_text) - 1);
> >
> > Use static_assert() instead.
>
> I am happy either way, but for my own education what is the
> reason to prefer static_assert here, is it just to be able to use
> =3D=3D rather than !=3D? Or is there in general a preference to use
> static_assert, there is no obvious since BUILD_BUG_ON is being
> deprecated?

It's generally preferred since there are (known) issues with it:
- it can't be put without the scope (globally);
- it produces a lot of a noise and hard to read error report;
- ...anything I forgot / don't know (yet) about...

BUILD_BUG_ON() might be useful in some cases, but I don't see how.

..

> > > +   ret =3D cs42l43_shutter_get(priv, CS42L43_STATUS_MIC_SHUTTER_MUTE=
_SHIFT);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +   else if (!ret)
> >
> > Reundant 'else'
> >
> > > +           ucontrol->value.integer.value[0] =3D ret;
> > > +   else
> > > +           ret =3D cs42l43_dapm_get_volsw(kcontrol, ucontrol);
> >
> > and why not positive check?
> >
> > > +   return ret;
> >
> > Or even simply as
> >
> >       if (ret > 0)
> >               ret =3D cs42l43_dapm_get_volsw(kcontrol, ucontrol);
> >       else if (ret =3D=3D 0)
> >               ucontrol->value.integer.value[0] =3D ret;
> >
> >       return ret;
>
> Yeah will update, that is definitely neater.

Note before doing that the last one has a downside from the

if (ret < 0)
  return ret;
if (ret)
  ret =3D ...
else
  ...
return ret;

as it assumes that there will be no additional code in between
'if-else-if' and last 'return'. Purely a maintenance aspect, but
still... So, think about it which one you would prefer,

..

> > > +   while (freq > cs42l43_pll_configs[ARRAY_SIZE(cs42l43_pll_configs)=
 - 1].freq) {
> > > +           div++;
> > > +           freq /=3D 2;
> > > +   }
> >
> > fls() / fls_long()?
>
> Apologies but I might need a little bit more of a pointer here.
> We need to scale freq down to under 3.072MHz and I am struggling
> a little to see how to do that with fls.

The second argument of > operator is invariant to the loop, correct?
So it can be written as (pseudocode)

 y =3D 0;
 while (x > CONST) {
   x /=3D 2;
   y++;
 }

This is basically the open coded 'find the scale of x against CONST as
power of 2 value'. Okay, it might be not directly fls(), but something
along those types of bit operations (I believe something similar is
used in spi-pxa2xx.c for calculating the divider for the Intel Quark
case).

y =3D fls(x) - fls(CONST); // roughly looks like this, needs careful checki=
ng

..

> > > +   // Don't use devm as we need to get against the MFD device
> >
> > This is weird...
> >
> > > +   priv->mclk =3D clk_get_optional(cs42l43->dev, "mclk");
> > > +   if (IS_ERR(priv->mclk)) {
> > > +           dev_err_probe(priv->dev, PTR_ERR(priv->mclk), "Failed to =
get mclk\n");
> > > +           goto err_pm;
> > > +   }
> > > +
> > > +   ret =3D devm_snd_soc_register_component(priv->dev, &cs42l43_compo=
nent_drv,
> > > +                                         cs42l43_dais, ARRAY_SIZE(cs=
42l43_dais));
> > > +   if (ret) {
> > > +           dev_err_probe(priv->dev, ret, "Failed to register compone=
nt\n");
> > > +           goto err_clk;
> > > +   }
> > > +
> > > +   pm_runtime_mark_last_busy(priv->dev);
> > > +   pm_runtime_put_autosuspend(priv->dev);
> > > +
> > > +   return 0;
> > > +
> > > +err_clk:
> > > +   clk_put(priv->mclk);
> > > +err_pm:
> > > +   pm_runtime_put_sync(priv->dev);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +static int cs42l43_codec_remove(struct platform_device *pdev)
> > > +{
> > > +   struct cs42l43_codec *priv =3D platform_get_drvdata(pdev);
> > > +
> > > +   clk_put(priv->mclk);
> >
> > You have clocks put before anything else, and your remove order is brok=
en now.
> >
> > To fix this (in case you may not used devm_clk_get() call), you should =
drop
> > devm calls all way after the clk_get(). Do we have
> > snd_soc_register_component()? If yes, use it to fix.
> >
> > I believe you never tested rmmod/modprobe in a loop.
>
> Hmm... will need to think this through a little bit, so might take
> a little longer on this one. But I guess this only becomes a problem
> if you attempt to remove the driver whilst you are currently playing
> audio, and I would expect the card tear down would stop the clock
> running before we get here.

I don't know the HW, it is up to you how to address this. The issue
really exists and might become a hard to hunt bug (e.g., if there is
an IRQ fired or async work which would like to access the HW with
clock off and hang the system).

--=20
With Best Regards,
Andy Shevchenko

