Return-Path: <linux-kernel+bounces-73005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8285BBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D2A281B75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7769301;
	Tue, 20 Feb 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZa37MV8"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2725B1F9;
	Tue, 20 Feb 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431781; cv=none; b=GusdRHCNSsnHSEX6OhHCc32fk4vPSeLO2Mk5PQEg0LlzjNAWzmYm10jeY7rjQdyKFFIziRopGXH/UIjIFVLkQUMp5SRUpiSifQ7O307DLydtv6HH1zfFbXLxbHYsWIuTPIWKPpf74SjibPWThqbR7pWm4Np8gdLMIz+VkGf0fDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431781; c=relaxed/simple;
	bh=xqTSVgfznTksrbz5QT8iopPyYXLCy7wv5bGIEH4MSb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWF9dMJI5CPkLfZ/GsmILiXqvR72I73FIQfSVSFlJiXINh2DDMApocsFF6hQtBqYKGmMEr7rTCLyi2YhZK0Aom+3H2L59OfSjBOKvfHeYYo3tYH1PRw76e8PkQ4cEU6cwCadqeaCaNEPQIjRs9zzD/aGc/+55WB8VG4rIM7BlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZa37MV8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d23d301452so23902261fa.1;
        Tue, 20 Feb 2024 04:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708431777; x=1709036577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9QwagbwsopEqnSDcxYcEzfKPag+Slzzzgw7BDLAReYI=;
        b=mZa37MV8dXtcpzxexmWiNeacxxRmFSphd1O8jqdjxAobwJ6h7WsPusbHKi7zWa9keq
         K2RpsK2XWYk5kRG6SMaSwXXuouZkMqsh26VZ3qrrnxBcQGeakTY9EtAsZK8P8TwljfbI
         FS7X+Ynl3x5LVm5FXkPLwacYdRdh8NROK+qyR/BTQflhGi1YQG0WJpdMPzdwlfDuWFtV
         +6rFIX+z3rZLITJbFOavXPfOXTWEYEqswi7UyiQg+NCkeL5dPvOFKrcn4l6uejHuJR/u
         XaYZ1SLaEFEgkur+TP0EXKydiE0r9j4bk7LhbZmdM91ItxxyGfssJ8cQA5hc4HTJpCaC
         P/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431777; x=1709036577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QwagbwsopEqnSDcxYcEzfKPag+Slzzzgw7BDLAReYI=;
        b=c5hNk+UR1L8ViyClWRjN+K/jhvhNvDhfC2Vu1HWtngqsKlFvX0MTdRInp/ctoUyRLd
         SzIZ0fJUAD4ImxA0bT/L8HwW+BiU+iO7y/N9hWmPZcemvnXUzQpc6GlM1cA5OKDuAHA6
         znuS3mDHXou6t/KKnacWt/ZrZpooVzaZsQzeGzyAX80VTh8aVzR3aMbC8D/wCVimw4x/
         A2ViTBNRsaoSHBx/r+RfMTcR/P+JznFfJvXde+SxXWgXzQhSqx7NEp3V2S5Zp1UfPS3i
         IQdW4hkK5iLijjR6GaEifm18RK0+dN718y9PgmowKqVOzsc2PAaNqZEgGD1C1rkc/sBO
         w0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+7g0dreECzsgD/L2ze0jHUiNw/LPgnvzRSB17XiBUAnQdVPVN4gScAYV48KJBp8xxvxH48qw33HegC4zMBMcCOxrqbfQ1gh3HK0ZW7sFWlp/OzNTEu9eN1zyGwDRJLIUgxmg2QB6EU3DT6XhnOpMP0jCRVghrSkxvzwSVBOKBHQ==
X-Gm-Message-State: AOJu0YwxOkIwBVSBDXnSOzwfmKdDEiYF9nFkiU9L+8lkI4lVMujyEAv6
	gwQYn1mhoamQMBEmg4JbfWHW6LbiFTEABbmYcGnu52ygPvJhA3yz/tnmzi8270HUNIrUuXuS0Rk
	eDcyHpimr2ccm5/X72gZX5qa86Js=
X-Google-Smtp-Source: AGHT+IGXmsc5+QDVXYHuToO9jG/rogV7vVtEygW/qf5y8ysTBc+VvU2gsXLZr7JFxuoJCvMlUp3juBNxPPSSzGwknq8=
X-Received: by 2002:a2e:b0d8:0:b0:2d0:ca39:5fb8 with SMTP id
 g24-20020a2eb0d8000000b002d0ca395fb8mr8934370ljl.53.1708431777125; Tue, 20
 Feb 2024 04:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
 <20240219-realtek-reset-v4-3-858b82a29503@gmail.com> <lvt7su5mmf7b3w4gbxd6vlt25klsyziuuaznfzjy7d4oxz46qx@4dzc4cgmfkbc>
In-Reply-To: <lvt7su5mmf7b3w4gbxd6vlt25klsyziuuaznfzjy7d4oxz46qx@4dzc4cgmfkbc>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 20 Feb 2024 09:22:44 -0300
Message-ID: <CAJq09z5ak_S3iFnGw+rw0JQwoxf=x69=Ync3Xg5AQ0hx_tsGXg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: dsa: realtek: support reset controller
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alvin,

> On Mon, Feb 19, 2024 at 08:44:42PM -0300, Luiz Angelo Daros de Luca wrote:
> > +void rtl83xx_reset_assert(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     ret = reset_control_assert(priv->reset_ctl);
> > +     if (!ret)
> > +             return;
>
> If priv->reset_ctl is NULL - i.e. if no DT property is specified - then
> this will always return early and the GPIO will not be asserted.

I made a mistake. I should be

if (ret) {
          dev_warn...
}

not returning on error (as you suggested below).

I was sure I was doing just that... I was surprised to see it as it
is.  I'll recheck my branch with all the integrated changes. It passed
my tests as when reset is missed, it normally does not matter. Thanks
for the catch.

>
> > +
> > +     dev_warn(priv->dev,
> > +              "Failed to assert the switch reset control: %pe\n",
> > +              ERR_PTR(ret));
>
> You only log an error if the reset controller assert fails, but not if
> the GPIO assert fails. Why the unequal treatment?

Because it does not return a value. There is no way to tell if it failed.

>
> I suggest keeping it simple:
>
> void rtl83xx_reset_assert(struct realtek_priv *priv)
> {
>   int ret;
>
>   ret = reset_control_assert(priv->reset_ctl);
>   if (ret)
>     dev_warn(priv->dev, "failed to assert reset control: %d\n", ret);
>
>   ret = gpiod_set_value(priv->reset, false);
>   if (ret)
>     dev_warn(priv->dev, "failed to assert reset GPIO: %d\n", ret);
> }
>
> or even drop the warnings altogether.
>
> > +
> > +     gpiod_set_value(priv->reset, true);
> > +}
> > +
> > +void rtl83xx_reset_deassert(struct realtek_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     ret = reset_control_deassert(priv->reset_ctl);
> > +     if (!ret)
> > +             return;
> > +
> > +     dev_warn(priv->dev,
> > +              "Failed to deassert the switch reset control: %pe\n",
> > +              ERR_PTR(ret));
> > +
> > +     gpiod_set_value(priv->reset, false);
> > +}
>
> Same comments apply to this function. Just deassert both.
>
> > +
> >  MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
> >  MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> >  MODULE_DESCRIPTION("Realtek DSA switches common module");
> > diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
> > index 0ddff33df6b0..c8a0ff8fd75e 100644
> > --- a/drivers/net/dsa/realtek/rtl83xx.h
> > +++ b/drivers/net/dsa/realtek/rtl83xx.h
> > @@ -18,5 +18,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv);
> >  void rtl83xx_unregister_switch(struct realtek_priv *priv);
> >  void rtl83xx_shutdown(struct realtek_priv *priv);
> >  void rtl83xx_remove(struct realtek_priv *priv);
> > +void rtl83xx_reset_assert(struct realtek_priv *priv);
> > +void rtl83xx_reset_deassert(struct realtek_priv *priv);
> >
> >  #endif /* _RTL83XX_H */
> >
> > --
> > 2.43.0
> >

Regards,

Luiz

