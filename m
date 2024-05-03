Return-Path: <linux-kernel+bounces-167191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E3F8BA570
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE141F22875
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46A1BC49;
	Fri,  3 May 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXsYY1Wy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F5F4E2
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714704953; cv=none; b=gGbHqBq6Fsy9W+ooJUfUbeL/fj1w7P/jeChIMgM/dpAxcc+ufPk3+EmjkYsKoL+J8AeFZxX8eTEoMYta5B+Egr1htxFpo2JoBVonWG4Sbvm7nL31rK4ntsSpXJPGYSdNmMZMyO3SBvRJ65GQWn1pw90k0c89jYuSHOIWA86SfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714704953; c=relaxed/simple;
	bh=jT5s7YWR+A/p4LavrGBG6VAx4FlLFrdIZ9nf8Q/OMQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Al+IptEdZH1g4LW7X7iUKZ+gJCxtqP5C+jGWMgAIxurYBShvzbxXj9oB+SIps+ribfa4Xn0SiQtRojdiEz8F2JBSUAHOEq4/eLbf701PbEd+DeA2UlkHxblZlymNfJw/750SmiO+HtBbIMjOwMTlYhFbD6gZchYLoOxBQsS7rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXsYY1Wy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714704951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwYPftRdc+ypJrZIwEf9pDQCg1OQOYFdRop7yZ9w5nc=;
	b=WXsYY1Wykbcy660Y46AN+FLrEmWSzIbjzMe8ZEclUz9viI6FufaNCubHMaMQwQkPwSmf3j
	6sufh8mE+ayF9abZ8SN3Yxg+8FIMU3JY5iVHZ2IKVL681+vrDtT+zSHW06FP6+mFOrG2Dd
	HNvr93R6C1K8Ldp6n7kJYDP4VbbEE6I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ywL64BVhMpyZ3WEvUos5qA-1; Thu, 02 May 2024 22:55:48 -0400
X-MC-Unique: ywL64BVhMpyZ3WEvUos5qA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so3279903a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714704947; x=1715309747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwYPftRdc+ypJrZIwEf9pDQCg1OQOYFdRop7yZ9w5nc=;
        b=aWaCAovoStyskNeaWfIPqO4MrW/5yAz36JC4hRKln6NIyz7iNPyLfwwcyNYJthNuPp
         x6btN+fYDWXIsMlxDMHp8RuO1UeYE2JECiIDN7eMhpIgOcNzcfjc34wQGAQhN6KzNOkT
         0N016rkpErGUg0aoCedJ5+WYoNpJT6u+NvOAlI2YWn3o+c7XHNQVe9Se7SZ09eVHqDOF
         pONHZ715mpVLTJ23yWjsGMhc2/dxaO/YG69bEXZBv5ytAcpNternMSYAI3TzsOjS6W8u
         IYDlwZCFNmiuT9+uS0KFdwVf+PDZDT+TxhRcVVAoeo8bp1gsxxcoXRgSZctRARY6fVct
         +sqw==
X-Forwarded-Encrypted: i=1; AJvYcCUBBEeBiKTvbDzd2/5ESyZv3Lp/FdkNBLqGiYsOnQTmxdSHLz+sonyUoCXCbahZIerXwsRCEgJl8FejqsnTy4f27jACzSgm4Hjpa1ET
X-Gm-Message-State: AOJu0Yzsh5asnuoPz+EL+VFjIqp+uSKaPjCHBue/sIhgyquPX+q7jAIR
	2nznwS00BxfAmFLkJa+hrv2fntwvH1mi5SW0SOVmj2GMVxsKysp3XBrAWrMzeRITjtFM1x8f34h
	NiTkMQP/8mAOsvpMrhHZj9QmcBzVGyboKfB8fxmHdbXjYblRgSGEhST+fDghhED4KfxbcS/LXjp
	UoIeP0cBZwBcAxogU+7a+7AwxCnKS1EYKZMgFi
X-Received: by 2002:a17:90b:1487:b0:2b2:9660:7d44 with SMTP id js7-20020a17090b148700b002b296607d44mr1487484pjb.25.1714704947131;
        Thu, 02 May 2024 19:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwF7yIf+v2KN0XWVj2yqlaGxRq0b/5Y9aBa/NRwhgqBjRU0s+VYd3wqnkkstVZyYiuuahaMVp6cWCPQy+n1PM=
X-Received: by 2002:a17:90b:1487:b0:2b2:9660:7d44 with SMTP id
 js7-20020a17090b148700b002b296607d44mr1487476pjb.25.1714704946751; Thu, 02
 May 2024 19:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424065212.263784-1-hpa@redhat.com> <20240424065212.263784-3-hpa@redhat.com>
 <3e103075-c170-42e3-928b-41d3bb11e6e8@redhat.com>
In-Reply-To: <3e103075-c170-42e3-928b-41d3bb11e6e8@redhat.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Fri, 3 May 2024 10:55:35 +0800
Message-ID: <CAEth8oEbJZwUVeghgDpM3DzddY7DvGOnfXVMgQNrXG4XLr1y=Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026
 and 2027
To: Hans de Goede <hdegoede@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 7:08=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 4/24/24 8:52 AM, Kate Hsuan wrote:
>
> Maybe start the commit message with:
>
> Add an i2c_device_id id_table to match manually instantiated
> (non device-tree / ACPI instantiated) KTD202x controllers as
> found on some x86 boards.
>
> ?

Thank you for reviewing it.
I'll revise the commit message in the v8 patch.

>
> > This table shows the maximum support LED channel for KTD2026 and KTD-20=
27.
> > The 3-channel LED controller KTD2026 controls R/G/B three LEDs. The
> > 4-channel LED controller KTD2027 controls R/G/B and flashing LEDs.
>
> Other then that this looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
> >
> > Datasheet: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/leds/rgb/leds-ktd202x.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-kt=
d202x.c
> > index f1c810c415a4..60ca6ec34336 100644
> > --- a/drivers/leds/rgb/leds-ktd202x.c
> > +++ b/drivers/leds/rgb/leds-ktd202x.c
> > @@ -606,6 +606,13 @@ static void ktd202x_shutdown(struct i2c_client *cl=
ient)
> >       regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RST=
R_RESET);
> >  }
> >
> > +static const struct i2c_device_id ktd202x_id[] =3D {
> > +     {"ktd2026", KTD2026_NUM_LEDS},
> > +     {"ktd2027", KTD2027_NUM_LEDS},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ktd202x_id);
> > +
> >  static const struct of_device_id ktd202x_match_table[] =3D {
> >       { .compatible =3D "kinetic,ktd2026", .data =3D (void *)KTD2026_NU=
M_LEDS },
> >       { .compatible =3D "kinetic,ktd2027", .data =3D (void *)KTD2027_NU=
M_LEDS },
> > @@ -621,6 +628,7 @@ static struct i2c_driver ktd202x_driver =3D {
> >       .probe =3D ktd202x_probe,
> >       .remove =3D ktd202x_remove,
> >       .shutdown =3D ktd202x_shutdown,
> > +     .id_table =3D ktd202x_id,
> >  };
> >  module_i2c_driver(ktd202x_driver);
> >
>


--=20
BR,
Kate


