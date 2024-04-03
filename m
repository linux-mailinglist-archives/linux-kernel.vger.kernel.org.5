Return-Path: <linux-kernel+bounces-130111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3481F897476
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFA9B260B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371A148FE8;
	Wed,  3 Apr 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JNVpZrHT"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0414A0A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158855; cv=none; b=rDTAXFxvSBJ65eLpSXxNC9zu9pOjQNm62WpdFa8P7zuBxgc3nOlYanf2teZWqUDegFKHTY3kBLCqTIwdayXlucpJi3DtXKJuWWaBkCmqTRy/RJLAhXxXe9GiufgFDsLkDqf/4cTBo5lLzNj7nQ7vnBszWT51xpU4uumnOLAlFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158855; c=relaxed/simple;
	bh=71HGpz3bu1XDU0ChqyX7V270qylnWQI/CQmlprroP9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW5nbTocZJMoy6DZKTZMydCKc+x6juoG+8kkK1JE1BeMQBQU3YYqJ5qmEdCH4Qa7StjE3wy9OAEEYemgNciBOl5+eASPrCnyK5q/jBYliJdHVh2tGEOFD0jH0bHwspBaXvNwa4s44D3lPC1+N99+Fb4wISMgJ88GMUSkMmFvihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JNVpZrHT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso86061401fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712158851; x=1712763651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEfL+KtRzP5VGoQFCUbE4sa/jrpJAy8sRsW3/DJwOpQ=;
        b=JNVpZrHTqiLRern+TappnwIRBenKhCr+Y2IYUg7PhBk05gU7mq0L4T/WHaSyd5jccu
         10v4wIZhHPCg0VsmbkfsfgiHhxxNAGf0wfZy57hDz3XzCGdVLWW3yXRdBalUyWRG5FQ6
         ltd1bhNa5sSuMN+7atN2FFID+eVW0UTC+zRkLUwHNZOrsRdPXvxjS7Tx/Q9dZ0RkJ8df
         PTfiYQ+Yw6XfLUQozIKf15QAEL5GkZ/5TC5D/hiGv90rtRzUmu07P98Op22lpjoL22s/
         C0gS/n7nSNcJUeYQ6wPJOYZUbvdRE6++Yvdr8Vyzr2HCwCIDv+j8tPaaNy+lVf6hGSyo
         h4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158851; x=1712763651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEfL+KtRzP5VGoQFCUbE4sa/jrpJAy8sRsW3/DJwOpQ=;
        b=EO9SyD1tCGwMNfwF8D7IdxH/xzHJLrVDJ9XLkpKnnNOJKyh5OJt5LgMekhNoCEgzKJ
         qYfYs/UR1wyeKSSoZ7n2Y8q7ruSb1WvwfduWsthzLl4JOz4QfF+RlhVZm/kvE19P2DPa
         yetbY9R+6tbs5YRy3asTZbvfbfIcwzbnd7S27K+K8Dd3V6mkIHHjYQJw42Hoybl0Nzx2
         ulekt75lXMUDs8XIMfmjYj/YuiMPwRnmueKhvsvtrWGE/p8o917t7e0vCkFQWHWyNPuH
         BOlVv8x0lKv/r/PwkFDypQMQQLGrmMjrTKfu8QpeqGXC/4ifrlY527/uVpggf1fjVCSl
         DRJw==
X-Forwarded-Encrypted: i=1; AJvYcCXL5hb+uL3fjL6LKwLVivfBXcYFYC8EesrumrGyWpWYazo/sgnr6cURi1vLJHUmGtfzJaRKRatAOkxsnH7+mWwQ/Qu4409WlkHlzszl
X-Gm-Message-State: AOJu0YxovLX+0qrHbU5/kF2GB89RGiz5+W2aPldNazX8cBNFyz4MqMAG
	yublU9vZq09Li0aiAvkmzYpCZVQdDJ3vXmBCEtUVwEK+3wAxubD9VcCXUNsMg7HIbTpnkDOX3bT
	4M8JbVv3ZG00DZPPw8SKXKI3PuzqekBsZrXZGexiSF7NNfEaJ+PM=
X-Google-Smtp-Source: AGHT+IFPoZ5LKOh6VIQyxGEDW1MJSsgvKWiqYEr33OpuO+5YGw2wi8BAE5xhL2PmHMYV6XsvdtZC/+qNSzSfLhGHfNs=
X-Received: by 2002:a2e:8004:0:b0:2d6:c7eb:8837 with SMTP id
 j4-20020a2e8004000000b002d6c7eb8837mr1883ljg.46.1712158851383; Wed, 03 Apr
 2024 08:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com> <25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
In-Reply-To: <25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 10:40:39 -0500
Message-ID: <CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:43=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
com> wrote:
>
> On 01/04/2024 22:37, David Lechner wrote:
> > On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> ...
>
> >>      properties:
> >>        reg:
> >> +        description:
> >> +          Reg values 16-19 are only permitted for ad4111/ad4112 curre=
nt channels.
> >>          minimum: 0
> >> -        maximum: 15
> >> +        maximum: 19
> >
> > This looks wrong. Isn't reg describing the number of logical channels
> > (# of channel config registers)?
> >
> > After reviewing the driver, I see that > 16 is used as a way of
> > flagging current inputs, but still seems like the wrong way to do it.
> > See suggestion below.
> >
>
> This was a suggestion from Jonathan, maybe I implemented it wrong.
> Other alternative that came to my mind: attribute "adi,current-channel".

Having a boolean flag like this would make more sense to me if we
don't agree that the suggestion below is simpler.

> >>
> >>        diff-channels:
> >> +        description:
> >> +          For using current channels specify only the positive channe=
l.
> >> +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0>
> >
> > I find this a bit confusing since 2 is already VIN2 and 0 is already
> > VIN0. I think it would make more sense to assign unique channel
> > numbers individually to the negative and positive current inputs.
> > Also, I think it makes sense to use the same numbers that the
> > registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> > positive).
> >
> > So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10>
> >
> >
> It would mean for the user to look in the datasheet at the possible
> channel INPUT configurations values, decode the bit field into two
> integer values and place it here (0110101010) -> 13 10. This is
> cumbersome for just choosing current input 2.

It could be documented in the devicetree bindings, just as it is done
in adi,ad4130.yaml so that users of the bindings don't have to
decipher the datasheet.

>
> >> +
> >> +          Family AD411x supports a dedicated VCOM voltage input.
> >> +          To select it set the second channel to 16.
> >> +            (VIN2, VCOM) -> diff-channels =3D <2 16>
> >
> > The 411x datasheets call this pin VINCOM so calling it VCOM here is a
> > bit confusing.
> >
>
> Sure, I'll rename to VINCOM.
>
> > Also, do we need to add a vincom-supply to get this voltage? Or is it
> > safe to assume it is always connected to AVSS? The datasheet seems to
> > indicate that the latter is the case. But then it also has this
> > special case (at least for AD4116, didn't check all datasheets)
> > "VIN10, VINCOM (single-ended or differential pair)". If it can be used
> > as part of a fully differential input, we probably need some extra
> > flag to indicate that case.
> >
>
> I cannot see any configuration options for these use cases. All inputs
> are routed to the same mux and routed to the differential positive and
> negative ADC inputs.
>
> "VIN10, VINCOM (single-ended or differential pair)" the only difference
> between these two use cases is if you connected VINCOM to AVSS (with
> unipolar coding) or not with bipolar encoding. The channel is still
> measuring the difference between the two selected inputs and comparing
> to the selected reference.
>
> > Similarly, do we need special handling for ADCIN15 on AD4116? It has a
> > "(pseudo differential or differential pair)" notation that other
> > inputs don't. In other words, it is more like VINCOM than it is to the
> > other ADCINxx pins. So we probably need an adcin15-supply for this pin
> > to properly get the right channel configuration. I.e. the logic in the
> > IIO driver would be if adcin15-supply is present, any channels that
> > use this input are pseudo-differential, otherwise any channels that
> > use it are fully differential.
> >
>
> I cannot seem to understand what would a adcin15-supply be needed for.
> This input, the same as all others, enters the mux and is routed to
> either positive or negative input of the ADC.
>
> The voltage on the ADCIN15 pin is not important to the user, just the
> difference in voltage between that pin and the other one selected.
>

These suggestions come from some recent discussion about
pseudo-differential vs. fully differential inputs (e.g. search the IIO
mailing list for AD7380).

So what I suggested here might be more technically correct according
to what I got out of that discussion. But for this specific case, I
agree it is good enough to just treat all inputs as always
fully-differential to keep things from getting too unwieldy.

> >>          items:
> >>            minimum: 0
> >>            maximum: 31
> >> @@ -166,7 +191,6 @@ allOf:
> >>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>
> >>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> >> -  # Other models have [0-3] channel registers
> >
> > Did you forget to remove
> >
> >             reg:
> >               maximum: 3
> >
> > from this if statement that this comment is referring to?
> >
> >
>
>
> Other way around, forgot in a previous patch to remove the comment.
> I'll move this change to a precursor patch.
>
> >>    - if:
> >>        properties:
> >>          compatible:
> >> @@ -187,6 +211,37 @@ allOf:
> >>                  - vref
> >>                  - refout-avss
> >>                  - avdd
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - adi,ad4114
> >> +              - adi,ad4115
> >> +              - adi,ad4116
> >> +              - adi,ad7173-8
> >> +              - adi,ad7175-8
> >> +    then:
> >> +      patternProperties:
> >> +        "^channel@[0-9a-f]$":
> >> +          properties:
> >> +            reg:
> >> +              maximum: 15
> >
> > As with the previous reg comment, this if statement should not be
> > needed since maximum should not be changed to 19.
> >
>
> We'll see what is the best approach regarding the current channels,
> perhaps the one you mentioned in the later reply with always configuring
> like the temp channel.
>
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - adi,ad7172-2
> >> +              - adi,ad7175-2
> >> +              - adi,ad7176-2
> >> +              - adi,ad7177-2
> >> +    then:
> >> +      patternProperties:
> >> +        "^channel@[0-9a-f]$":
> >> +          properties:
> >>              reg:
> >>                maximum: 3
> >
> > It looks to me like AD7172-4 actually has 8 possible channels rather
> > than 16. So it would need a special condition as well. But that is a
> > bug in the previous bindings and should therefore be fixed in a
> > separate patch.
>
> It is addressed already in the binding:
> "
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: adi,ad7172-4
> [...]
>               maximum: 7
> "

Ah, I missed it hiding with adi,reference-select overrides.

