Return-Path: <linux-kernel+bounces-117154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329188A7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4415E1C3E876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038D128810;
	Mon, 25 Mar 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dR7AnY10"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB867C44
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373732; cv=none; b=CUP7oOev6rQicQNsHOlQhFOF4MZ7LCd+lJJVNovCcwfFD0XthAOmIW6INlKz/kF40c2/oqQcIv+x+PRlb9tMTD8H8/Y+6PxzbiXWWz8iSUKVSFaLVKez7mx1tIq4io/ZUOwaap+9Rr3qlcbWKF75Bj2NRTJlVx8BiZDAwlIoDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373732; c=relaxed/simple;
	bh=TCPyUbafQCw3a+le65i3q3p05CsQjzehRXJqoZCkz3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1qw/R+lc0f02A2E4+dHCqdGIrmq0yj3TnLNonFYP/BiYPoP0P6Q4e7TzvGgaZ3m0ieisqshd4zOTESfkuCoDrXM9wyBYjrwaKOehMQKj9wpEXsHD0tmbQzZVoDJ6HrVYYGWW2kPOnITuaEIfBiEwQnOaSB/ie7Ap4k+RbefQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dR7AnY10; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so45341151fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711373728; x=1711978528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMCYCOAUB399ZWIzjXcdJZ2KHil8v/UMqqPWVku47Q0=;
        b=dR7AnY10y3mjOLMoHH2w2eytqdV9Uq/BKXafcRA2zXUUwzbPFF0cps/iyRTvt969He
         O/+3xoW+jb9bNYH6D20oSKtGgep2Ysp8EdYuY5J5GQOJ+9NDHUBzQVsg6mcmLmH/fRSg
         s5yqOxGprnEqB5cGfH0G8hhVZRqIRJu31JZfVkMVkP09OXirZQ/WCNn3H+kfYqsF3jPa
         I2YUyNjgQz/qlCzwVCZkLH1afrox7DHarxEFcJnghYxprBRp0957bMB/CpwKDOV2hwld
         IQF9X7qktxL1SthMR/S538GVvz/KK6T3xI2+hFIGu2OteMb2ish6SsmwS6WPO2fYaxd/
         C1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373728; x=1711978528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMCYCOAUB399ZWIzjXcdJZ2KHil8v/UMqqPWVku47Q0=;
        b=BeEYWYvS7qndg4BnDZWqag7K2ycLBJY23EsqoGXsWrYD0syPkQKdjPIZCZN20RbEX2
         RXm04uh/ZTEh588PE9DpS6buPXGTp2kHlEeL6H0z90mQ1n0TFl1NOVG+jCgi+lpLuylD
         w8xLFLvag5iq41byZCkT2/3uFiYuKosCYaAWITd6fnRcNRECh7nhRsmYPk2DL9tmXk96
         /wM8y0R7L9Rxc/PFO5vgoOgR6bdAxqY0aoOneonzL3KaYqA33nyri4zJxGBxHY4IFDTJ
         O/4km4AXWLfj05/b90uvLYjG8clYXYzjN1KySVnp/x+ylmlhs+d+O9fkYODseC010nBC
         fG5g==
X-Forwarded-Encrypted: i=1; AJvYcCV0rjdyFAz3aOubtIP4kbO38dYbAqAXQ3PtnSTQ2VBy198UdGvj6j7ZmKiEkZKG0ky6gihRXjfrhOcXWv3DZ/ag6arSJMrIY9hxyQw3
X-Gm-Message-State: AOJu0YwpLgKddTgmPz5eGE/6hfmLzOKR1vlkyA6S1fKgCewBV1KeQvEx
	XDtHMV53POx/Wt+X722cFwQnEKXPymDLyC3KM6R5InD+BwO5srLF2KH1iuS86NB3KR00oS8JIp6
	+YHZcUKX5sIh/dU8CMGbb5460yJPz3fU2ev8uWw==
X-Google-Smtp-Source: AGHT+IHaTowjHDD+wkEmqqR2T4q/qAfyUNdkL17rUe2qmjICjJ4WsEyBPGIBcsY6t/oJ7tOBkVYkWK9qUuSPYEm359Q=
X-Received: by 2002:a05:651c:212a:b0:2d6:ce5c:de25 with SMTP id
 a42-20020a05651c212a00b002d6ce5cde25mr1524321ljq.8.1711373728029; Mon, 25 Mar
 2024 06:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
 <15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
 <CAMknhBH7umcBD0hyt=6fOKu9E8k=CSrnNE4Z+9ynn0F4B=Wk2w@mail.gmail.com>
In-Reply-To: <CAMknhBH7umcBD0hyt=6fOKu9E8k=CSrnNE4Z+9ynn0F4B=Wk2w@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Mar 2024 08:35:16 -0500
Message-ID: <CAMknhBHZT5xM5RG0cmEHvCJ5AwZnLQnV9_jW5=gP=s_45LYfcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add support for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 4:53=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Fri, Mar 22, 2024 at 5:06=E2=80=AFPM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >

..

> > +
> > +       vref_reg =3D devm_regulator_get(&spi->dev, "vref");
>
> This should to be devm_regulator_get_optional(), otherwise it can
> return a "dummy" regulator if one is missing in the devicetree which
> will fail when getting the voltage.
>
> > +       if (IS_ERR(vref_reg))
> > +               return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> > +                                    "Failed to get vref regulator\n");
> > +
> > +       ret =3D regulator_enable(vref_reg);
> > +       if (ret < 0)
> > +               return dev_err_probe(&spi->dev, ret,
> > +                                    "Failed to enable voltage regulato=
r\n");
> > +
> > +       ret =3D devm_add_action_or_reset(&spi->dev, ad4000_regulator_di=
sable, vref_reg);
> > +       if (ret)
> > +               return dev_err_probe(&spi->dev, ret,
> > +                                    "Failed to add regulator disable a=
ction\n");
> > +
> > +       st->vref =3D regulator_get_voltage(vref_reg);
> > +       if (st->vref < 0)
> > +               return dev_err_probe(&spi->dev, st->vref, "Failed to ge=
t vref\n");
> > +
> > +       if (!device_property_present(&spi->dev, "adi,spi-cs-mode")) {
> > +               st->cnv_gpio =3D devm_gpiod_get(&spi->dev, "cnv", GPIOD=
_OUT_HIGH);
> > +               if (IS_ERR(st->cnv_gpio)) {
> > +                       if (PTR_ERR(st->cnv_gpio) =3D=3D -EPROBE_DEFER)
> > +                               return -EPROBE_DEFER;
> > +
> > +                       return dev_err_probe(&spi->dev, PTR_ERR(st->cnv=
_gpio),
> > +                                            "Failed to get CNV GPIO");
> > +               }
> > +       }
>

In a review for a different patch, Jonathan said he would prefer
devm_regulator_get() and failing in regulator_get_voltage() rather
than using devm_regulator_get_optional() so I think the same would
apply here and my suggestion should be overruled.

