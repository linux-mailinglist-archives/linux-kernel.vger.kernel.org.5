Return-Path: <linux-kernel+bounces-130204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7389755D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3AC1C25B95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620EA152181;
	Wed,  3 Apr 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mSeckWOl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010514A62A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162284; cv=none; b=RTGaqP7q95YDzQ5TeoHg+ggSJg0G5Kgcsle3uWN2bCQKSqQvROdOPWKWd3mjmAUk9WWoiqHzw6qhbCar9OYpVMxVECFa/ubzhWYs9i5nwKTgTLx48AsC4qNRK/WRK+BH2cSvLjgAZMfb66YHvW/RWkIw11O7kp7gkHpXjhNOl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162284; c=relaxed/simple;
	bh=Giq7R76xZqUySEf7R34j+dGGeGtp38CHprsEw+dSA0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrYmVeG0ZS1SqxOMYZywQVGhSKyLlw/9f138dd6CjChlQRtr8X1fcXsfOZjBLE4J+9GQvb93SZL7IQpnPPT2QsvjxjGCo+8f8QMQZSV/o5qGo8rRv6a4FNGM4ok2fhFvRPqHSNdFX922S+abvCHt6gelIZ9krb8veBWl+PKNfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mSeckWOl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso87133771fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712162280; x=1712767080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VAwBegNB+ejGvlVIKZPfY1+rXl1zIDBpfKpOZezbB0=;
        b=mSeckWOlwsEz6B2ALe37Mf8yiSWrlNo2sQguc32Mxf3z2SxrWruloNQpoV77xN6F2K
         3lGd9WBCmDcmhuJFwrRj4rT4034vDoZYpckJwA8kCUpN0E/O+A6rtMGjTLFE66SeYn8X
         wotKHWm8Sa+KJVrjFLrZKgY2aeNgsAHRwWt6jM7ITTaGLA7SYxUoHqPMSiKOM32+9BRr
         0noVaKys5HVu4XyMiSoCMDnE57Hc2do83wTn7zDaM981wNb6mckOkpoVE4FmZSkKHG5o
         JdPhmPBepo0Emo4/eBbcSGZlJQatH3pYodHeQvcORFgqfrHyheObp6k6qKP7UBJVdGSF
         lElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162280; x=1712767080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VAwBegNB+ejGvlVIKZPfY1+rXl1zIDBpfKpOZezbB0=;
        b=kE39pFFiL+O2xeow+qmC9alBuoj1M/3r8l2+LXHsFbiuu+X+eynSf6bvDhi25JWpt/
         Xk6ylktPscPR24cY4iU5yEPkwcTtgcE6vcRa/wk+vkoqwyD6kwkrfYVNSSb9fI+DPjJo
         5q3WxnEalThoMUQVr+A8tOpFOcuZo4A9JnYL4QTFX/sW/iyspmdBOlEnXT73Jn48PxsL
         CLY73tkE90hQkSEuninY2x9xSwf52yIu2167eanVnfH5MAIA5JOJ16nanbVPZrVcwo6E
         vmdVgBc1SPzdi11StKUys26VT5nC/d/pL0vvr5h79CETU7jvq9SzfBAnYQEcx8McwA03
         Ss7w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7WgFipPm0/PSSw378piD9+/EKl4pYtYEMtKmSNYpKvvkTzm7UXRkQLEkO5RDymVGW85ZoDojpG6vLWtdXMqZdrWMfC+WG7rEBs2u
X-Gm-Message-State: AOJu0YwOS+CitcNx0x41HJD3ZLpMxgPxcbyhus+9r1OL9y4L01yPOWV6
	m1zxqEqQQlX5ZwaHhS9w3ZiSnXp621vzA0F6ChiD+kCh0BJxg8e/ELyxUOXEmTfxW1/N8uGLCy+
	4sjsJGVWU2JLy9zwbD26+pAGS9W4B5m7kAfH2Sw==
X-Google-Smtp-Source: AGHT+IGAywR9Uy125qfFJ1X4pBurkesXRwKzT38wdpNo5Q4NTcpbgaRUf5WXVt7SKnHgElyGJALlJ1K6jC7Jdecw+bo=
X-Received: by 2002:a05:651c:a06:b0:2d8:34ec:54e6 with SMTP id
 k6-20020a05651c0a0600b002d834ec54e6mr159118ljq.33.1712162279945; Wed, 03 Apr
 2024 09:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com> <c7c26d36-ab08-420c-b634-8eb6d9cee9b5@gmail.com>
In-Reply-To: <c7c26d36-ab08-420c-b634-8eb6d9cee9b5@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 11:37:48 -0500
Message-ID: <CAMknhBFZKKim4JyXLpHY=EoyW4ZPp03aHte5xy0ZkDnW16sfeA@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:53=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
com> wrote:
>
>
> On 01/04/2024 22:45, David Lechner wrote:
> > On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
>
> ...
>
> >>  #define AD7175_2_ID                    0x0cd0
> >>  #define AD7172_4_ID                    0x2050
> >>  #define AD7173_ID                      0x30d0
> >> +#define AD4111_ID                      0x30d0
> >> +#define AD4112_ID                      0x30d0
> >> +#define AD4114_ID                      0x30d0
> >
> > It might make it a bit more obvious that not all chips have a unique
> > ID if we rename AD7173_ID to AD7173_AD4111_AD4112_AD4114_ID rather
> > than introducing multiple macros with the same value.
> >
> > Or leave it as AD7173_ID to keep it short and add a comment where it
> > is used with 411x chips in ad7173_device_info[].
> >
>
> Sure
>
> >> +#define AD4116_ID                      0x34d0
> >> +#define AD4115_ID                      0x38d0
> >>  #define AD7175_8_ID                    0x3cd0
> >>  #define AD7177_ID                      0x4fd0
> >>  #define AD7173_ID_MASK                 GENMASK(15, 4)
>
> ...
>
> >>  struct ad7173_device_info {
> >>         const unsigned int *sinc5_data_rates;
> >>         unsigned int num_sinc5_data_rates;
> >>         unsigned int odr_start_value;
> >> +       unsigned int num_inputs_with_divider;
> >>         unsigned int num_channels;
> >>         unsigned int num_configs;
> >>         unsigned int num_inputs;
> >
> > Probably a good idea to change num_inputs to num_voltage_inputs so it
> > isn't confused with the total number of inputs.
> >
> > Similarly num_voltage_inputs_with_divider instead of num_inputs_with_di=
vider.
> >
> > Also could use a comment to make it clear if num_voltage_inputs
> > includes num_voltage_inputs_with_divider or not. And that it doesn't
> > include VINCOM.
> >
>
> Alright for these 3 statements above.
>
> > Probably also need some flag here to differentiate ADCINxx voltage
> > inputs on AD4116.
> >
>
> That is the purpose of num_inputs_with_divider. Mangled some changes
> when splitting into individual patches. Will include in V2.
> "
> if (ain[1] =3D=3D AD411X_VCOM_INPUT &&
>                     ain[0] >=3D st->info->num_inputs_with_divider)
>                         return dev_err_probe(dev, -EINVAL,
>                 "VCOM must be paired with inputs having divider.\n");
> "
>
> ...
>
> >>
> >> +static unsigned int ad4111_current_channel_config[] =3D {
> >> +       [AD4111_CURRENT_IN0P_IN0N] =3D 0x1E8,
> >> +       [AD4111_CURRENT_IN1P_IN1N] =3D 0x1C9,
> >> +       [AD4111_CURRENT_IN2P_IN2N] =3D 0x1AA,
> >> +       [AD4111_CURRENT_IN3P_IN3N] =3D 0x18B,
> >> +};
> >
> > As mentioned in the DT bindings review, it would make more sense to
> > just use the datasheet numbers for the current input channels in the
> > diff-channels DT property, then we don't need this lookup table.
> >
> Yet, the datasheet does not specify the numbers, just a single bitfield
> for each pair. It is too much of a churn to need to decode that bitfield
> into individual values when the user just wants to select a single pair.
>
> ...
>
> >> +               case IIO_CURRENT:
> >> +                       *val =3D ad7173_get_ref_voltage_milli(st, ch->=
cfg.ref_sel);
> >> +                       *val /=3D AD4111_SHUNT_RESISTOR_OHM;
> >> +                       *val2 =3D chan->scan_type.realbits - !!(ch->cf=
g.bipolar);
> >
> > Static analysis tools like to complain about using bool as int.
> > Probably more clear to write it as (ch->cfg.bipolar ? 1 : 0) anyway.
> >
> Maybe it does not apply here, but i followed this advice:
>
> Andy Shevchenko V1 of AD7173 (named initially ad717x)
> "
> > +     return (bool)(value & mask);
>
> This is weird. You have int which you get from bool, wouldn't be better
> to use
> !!(...) as other GPIO drivers do?

As long as the build bots don't complain, there isn't a reason to
change it. It is just a matter of personal preference at that point.

I got a sparse warning for something like this recently [1], but maybe
that case was just because it was inside of a FIELD_PREP() using it as
bit logic instead of addition and we won't get any warnings here.

[1]: https://lore.kernel.org/linux-iio/20240129195611.701611-3-dlechner@bay=
libre.com/

>
> "
>
>
> >> +               case IIO_CURRENT:
> >>                         *val =3D -BIT(chan->scan_type.realbits - 1);
> >
> > Expecting a special case here, at least when ADCIN15 is configured for
> > pseudo-differential inputs.
> >
>
> And what configuration would that be?
> The only configurable part is the BI_UNIPOLARx bit in the channel
> register, which is addressed here.
>
> There seems to be a confusion similar to what we had with single-ended
> channels. The ADC is differential. Pseudo-differential in this datasheet
> just means that you wired a fixed voltage(higher than 0) to the negative
> analog input.
>
>  Which you can also do on the other inputs with a divider.
>

As discussed elsewhere, you can disregard this suggestion.

> ...
>
> >> -               chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], ain[1]=
);
> >> +               if (reg >=3D AD4111_CURRENT_CHAN_CUTOFF) {
> >> +                       chan->type =3D IIO_CURRENT;
> >> +                       chan->channel =3D ain[0];
> >> +                       chan_st_priv->ain =3D ad4111_current_channel_c=
onfig[ain[0]];
> >> +               } else {
> >> +                       chan->channel =3D ain[0];
> >> +                       chan->channel2 =3D ain[1];
> >> +                       chan->differential =3D true;
> >
> > Expecting chan->differential =3D false when ADCIN15 is configured for
> > pseudo-differential inputs.
> >
> > Also, perhaps missed in previous reviews, I would expect
> > chan->differential =3D false when channels are used as single-ended.
> >
> Why?
> Also, how would one detect if you are using single-ended channels?
>
> The ADC is still differential. Single ended is represented as connecting
> AVSS(or another fixed voltage) and only letting the AIN+ input to fluctua=
te.
>
> In the IIO framework the only difference this makes is in the naming of
> the channel:
>  voltage0-voltage1 vs just voltage0
>
> All channels are differential. Pseudo differential: still differential.

In the discussions on the AD7380 patch series, we came to the
conclusion that pseduo-differential is technically not differential in
the context of the .differential flag in IIO.

But as mentioned in my follow up, for this driver it is going to make
things far simpler if we just ignore that and treat
pseudo-differential the same as fully differential.

