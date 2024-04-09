Return-Path: <linux-kernel+bounces-137337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C989E0B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D1DB272EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA115381F;
	Tue,  9 Apr 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aWV4nS4q"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5768152DE2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681082; cv=none; b=mHOimNlB7rRv26hiti3t2LCX3Cmavfe2OJiIa95TqOuRKVNh9UtA/764qqrlY3UgU1xtjod197EDS+D1g8b9nEG78C/BUsTGrhUk/1VnTM2sCNMoS7E1iTZIR08GieIqPs4WkbiQTGZ6RIMS0hIu+f78YJTmrVEyF1aS6k0dB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681082; c=relaxed/simple;
	bh=JWUdqyVAIsWLcoctxkkYi4e62PvFbfqGshP17Q8rHNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbJ3oMd4xAiW+qIwGwPrQ4ZKLUMhFxTlykgUDT3tuRLaLVhXWbVaRuAH1/ynL4XX2ZlQfRVZa392ZSbwbCxcyzzVH0GPzZuxj4hY2oNBKsZqmrjG8RAbJQLqMAxtN3Zr7XuOChq8muLuBLbbE2o2Dra0xspgJP0ajAYwswQ8Q0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aWV4nS4q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d895138ce6so30567421fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712681078; x=1713285878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjfeLLs5/QHmTieADjEMzvSqZ5segVSHp4sf0PYGlic=;
        b=aWV4nS4qSOFuCVuTvjSVOwhuSp/m7PypqRI31ulbfjk/qaEw4c0WmW9HopD94/tdlN
         PGD8dWeKBKyI4OEUdAvmM+7p31/y5AaGTr/Ey1oRsK9k25IVgSq8ZlLx7jBIOlx7uWMw
         wg+qv/UWHuC90g50TliFgrXzIKJ10gjhgZMpO+9qcLhdWZe6ozSa2jx3EF9jEhJMbOks
         cOa7YABRnyCQ/3LTXr5phAQiVeiWWVmSsyt9tNMjCdLY5KuQqghY32NFPtfarl9qK04C
         gcSERegQxzhzvNnUl5gjtRKbfdcC84stBU+L158eI0Ieycxaa2CnKL+glbEmnOQShO74
         eJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681078; x=1713285878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjfeLLs5/QHmTieADjEMzvSqZ5segVSHp4sf0PYGlic=;
        b=BINKVguP/IB0C9FCGkk4nywGRsaLlV1knPBG0w6R4DZUfvY96EVU39QC0mxYMgt4HI
         Bdc216gEibdLpBoPXFt7hZhUBvHbdFlaJlrmbUxIdG32qa96Hk+QXHfkEVsxihs+9sm1
         4fOlkbqvggdYrY2aM3K/aF5uZYC8ExdimCcNeLf7F7GyDCXlUEX+zuyRLMKmak+JOnQA
         zXrgfIYrtJQtaXI9TIT6lDpHqnKAykuQYoeH7QSf7vIib+eBeps4VtAA/wghiTh0ghFU
         asYcnOu2pUqgZQNosjIHjUFUNXIRB3bBxziyo7FSnrVNIkyAqYgEY0fTt3lsP0UlHIxz
         mLRA==
X-Forwarded-Encrypted: i=1; AJvYcCWqIGTQZQKDpxPA3xwdiHIV5UoyaqbPaFXAcFipZToQPFZeWuBkRXbdBwJfAQrt2mgMBdLIHR97UlJK8JqtZmmLSTPpnGmFkat8wAza
X-Gm-Message-State: AOJu0YzAlSd1/mjcrsQWl8iqHdYj0PE8U5rk8I33xm/Ytiwi25sMwBul
	NE7Ub+YFcNlTw9xh3OoMKPrFFnVioeFSx672CuukWf0hiNOaF0BezNl/2XFovHzULOO9hxCHcVF
	6Gd+eFKZ92w6201dHr1nZWXvn/3MLORR2Ea1J+Q==
X-Google-Smtp-Source: AGHT+IHDfyAKHWwlD9X/VzdBRfEeR4pd71e1VTx+ltpPqyBKd04yyyXe9X8P7a68xl0iT/2ZbRzolEtgQkxwaWEId6I=
X-Received: by 2002:a2e:8013:0:b0:2d8:3e60:b9c9 with SMTP id
 j19-20020a2e8013000000b002d83e60b9c9mr209693ljg.33.1712681078050; Tue, 09 Apr
 2024 09:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com> <ZhVoTi2amNTOJ4eS@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <ZhVoTi2amNTOJ4eS@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 9 Apr 2024 11:44:26 -0500
Message-ID: <CAMknhBGVkv9sP0pjmmdFngKmGVu+G4Y3MUDG199az1wOUtwasw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:09=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/08, David Lechner wrote:
> > On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
> > <marcelo.schmitt@analog.com> wrote:
> > >

..

> >
> > I also still have doubts about using IIO_BE and 8-bit xfers when it
> > comes to adding support later to achieve max sample rate with a SPI
> > offload. For example to get 2MSPS with an 18-bit chip, it will require
> > an approx 33% faster SPI clock than the actual slowest clock possible
> > because it will have to read 6 extra bits per sample. I didn't check
> > the specs, but this may not even be physically possible without
> > exceeding the datasheet max SPI clock rate. Also errors could be
> > reduced if we could actually use the slowest allowable SPI clock rate.
> > Furthermore, the offload hardware would have to be capable of adding
> > an extra byte per sample for 18 and 20-bit chips when piping the data
> > to DMA in order to get the 32-bit alignment in the buffer required by
> > IIO scan_type and the natural alignment requirements of IIO buffers in
> > general.
>
> Maybe I should already implement support for reading with SPI offload
> rather than doing it after this set is merged?
> So we can test what happens at faster sample rates before we commit to a =
solution.
>

Yes, that sounds like a wise thing to do.

>
> >
> > > +               } data;
> > > +               s64 timestamp __aligned(8);
> > > +       } scan;
> > > +       __be16 tx_buf __aligned(IIO_DMA_MINALIGN);
> > > +       __be16 rx_buf;
> > > +};
> >
> > scan.data is used as SPI rx_buf so __aligned(IIO_DMA_MINALIGN); needs
> > to be moved to the scan field.
>
> I have already tried it. Maybe I did something wrong besides buffer align=
ment
> at that time. Will give it another try.

This is the alignment for DMA cache coherency. So it should not have
any affect on the actual data read, only performance.


> > > +static void ad4000_config(struct ad4000_state *st)
> > > +{
> > > +       unsigned int reg_val;
> > > +       int ret;
> > > +
> > > +       reg_val =3D FIELD_PREP(AD4000_TURBO, 1);
> >
> > Since the driver in it's current state can get anywhere near the max
> > sample rate of ~1MSPS, I don't think it makes sense to enable turbo at
> > this point.
> >
>
> This is just enabling turbo at start up. If not enabling turbo during pro=
be,
> we would want(need?) to provide some interface for that, which might not =
be
> much desired.
>

TURBO is only needed to achieve the max sample rate of 500k/1M/2MSPS
on the various chips by skipping powering down some circuitry between
samples. We can't get anywhere close to that in Linux without some
sort of SPI offloading. So, for now, we might as well leave it
disabled and save some power.


> > > +
> > > +       st->pin_gain =3D AD4000_1_GAIN;
> > > +       if (device_property_present(&spi->dev, "adi,gain-milli")) {
> > > +               u32 val;
> >
> > Should it be an error if adi,gain-milli is set on non-adaq chips?
>
> Maybe. We should not change the scale if it's a chip that don't have the
> amplifier in front of the ADC. I think the best handling would be to just
> ignore adi,gain-milli if it's not an ADAQ device. Maybe better add a DT
> constraint,
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - adi,adaq4001
>               - adi,adaq4003
>     then:
>       properties:
>         adi,gain-milli: false
> ?

I think this is missing a not:, but otherwise yes this should be in
the DT bindings.

Even with that though, I would still be helpful to readers of the
driver to at least have a comment here pointing out that this property
and related gain scaling only applies to ADAQ chips.

