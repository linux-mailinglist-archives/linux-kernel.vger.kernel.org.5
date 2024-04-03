Return-Path: <linux-kernel+bounces-130144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AFB897499
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF53294F95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF814A625;
	Wed,  3 Apr 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TuEH3ztd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971914A4EC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159727; cv=none; b=O6jceko/ghdswLJqaTTj93bssuus++bsOapiYkB902Eo579O3UeniOUvCe1qUzP19VQKt+h7YqKULNwL+DjhcBnEUGBAfAmBLq8jgaw22HLokuPKADkCDcNTjFXcfd4XU/ASVqSU3BKkoyQqbIxXRgb5KdTsZtJ52VOh7NTqB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159727; c=relaxed/simple;
	bh=/o6IZyT1LfuupSF3G+8xq2Vg1z1nzIx/s7vaBZlSSG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjDdX3WVVW5eu+RgwhS8Txt7oNYtn/SJ9zEbowxGjPMHV6LAPZedsB2H+tkZb6e9u3QxfoUJzcJdsvOk2byfH98ntpawmoB9C2/3q94fZabSVuePNiONgQ5P7iIdKk24IvS+jfaHQlogm8ff0XYEwaXuEQHsaW3tkVeqPGlboSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TuEH3ztd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so97455751fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712159723; x=1712764523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvSkYKcaQbv67yPHeuZ/wW0CyAcjTwHZKDOQEYRmRhg=;
        b=TuEH3ztd7pS/9HOa5LN2VfWm0C2PXLRlPxdPwTETRlga7kanYKnOs3xMnSdhUuwivN
         th3xKIHpfHEf6GKewqL9zwzsbaDvNN8FpFFJ3ed+uiho2NsyzsfpHxmzRx0AGgc2UUuO
         rxG/G+q5hGqfLNQc4wGmy4fe/5olY/wChLmk1/TOHXzutEOt1afJQzYm2c1pvBYsIxxx
         oh7aArthlbZYd4YHLKPFeFib+Z9FwcXQ8WQJSuLROGVbV1CPBWeQLEkg+ThEbS3lWxDW
         MRexxdd3tF9X2eYJOxAtU0OReWX3KExD6BMukD/iNqpTmO5H2u/QnDlG/kynPgAK5b+i
         bEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159723; x=1712764523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvSkYKcaQbv67yPHeuZ/wW0CyAcjTwHZKDOQEYRmRhg=;
        b=kwR3o+3Q1IRxAhMFoQCDsco+aGdpImQljci1yU2cqBAg/4hVOOFog8nDGCBOWH1gtX
         6uXF2fjOfgLXMz2g2r7BkPEhF4Wd7hLB+0jdzCHwfsXK6eLkHGsNzwo0c8psZZfrpkKx
         MYfs+03LR0ShBtEOEnZn6ZCI5+5k14y1YZDNHXQ/k57VITuVL08wlC2G3MInPa3sP3XK
         3mxRDYVvpUhxaaUiDufuS2941vgyKJNCTX6y3DUuG7eg5bHIJCNa+geZ2Xhf/Ntzvdeb
         8IUW/alolWQFpS45xeDEqy3LuxavAB5dMIyy3dHV5pmdTM0hhqNL7jV3+O3+PVY/QF5u
         hBiA==
X-Forwarded-Encrypted: i=1; AJvYcCVTZlpRGauspVdUFcAdnoVPMmdwZuvN14TpiOqFSCW8U7ZViQ0aZUZBVF+VpIhtrEUzCJ+W5eKzmWLdkgtDDcrVNjvTdSd6MI0/zbwI
X-Gm-Message-State: AOJu0YxfC5pEgeyFY5yMd2pVghUEwXTM4YoxPaETJAvmdOA0kqrSYHfx
	g3bw/Sh1ikpryJskWBQaTtqc81KkwVxWd9rNLIvpCH3x1vqtNhmiRtQ5jCO5yd2SK4B7zIs1mps
	kBaLGphWQ3g9JpOyZFR6zzO4YOLdKRYk6ohbXCg==
X-Google-Smtp-Source: AGHT+IH/4+JhH3G1jUDn64Y/+eh5lyT/4m8lKfMLh68eVFUoan0LdJw5TkrgcxLN/CUrlMztFQihUcNA0I8iVYniD6U=
X-Received: by 2002:a2e:90c5:0:b0:2d7:447b:c30c with SMTP id
 o5-20020a2e90c5000000b002d7447bc30cmr33524ljg.48.1712159722851; Wed, 03 Apr
 2024 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-3-34618a9cc502@analog.com>
 <CAMknhBHo3xkkZymVfvauL7nBPn9+c1ZUoPwyk4mJO4syRJEhiQ@mail.gmail.com> <1d777161-7d86-4d45-91bc-c7653504b890@gmail.com>
In-Reply-To: <1d777161-7d86-4d45-91bc-c7653504b890@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 10:55:11 -0500
Message-ID: <CAMknhBFohF_0NUDeweO=dWdStREZrphpvTzke7F6Ngr-7rXriQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: ad7173: refactor channel configuration parsing
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:01=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
com> wrote:
>
> On 01/04/2024 22:39, David Lechner wrote:
> > On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> > <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >>
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> Move configurations regarding number of channels from
> >> *_fw_parse_device_config to *_fw_parse_channel_config.
> >>
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >> ---
> >
> > Commit messages need to explain _why_ the change is being made [1]. It
> > is not obvious to me why this needs to be moved.
> >
> > [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#the-canonical-patch-format
>
>
> Jonathan Cameron:
>
> "
> > +     if (num_channels =3D=3D 0)
> > +             return dev_err_probe(dev, -ENODATA, "No channels specifie=
d\n");
> > +     indio_dev->num_channels =3D num_channels;
> > +     st->num_channels =3D num_channels;
>
> I'm not seeing benefit of duplication here really and logically it feels =
like
> a lot of this last chunk would sit better in ad7173_fw_parse_channel_conf=
ig()
>
> Perhaps that's a job for a future tidying up patch.
> "
> https://lore.kernel.org/all/20240303162148.3ad91aa2@jic23-huawei/
>

Thanks.

A Link: and Suggested-by: in the commit message with this info would
be a reasonable way to communicate this.

I looks like this is also adding an additional check "  if
(num_channels > st->info->num_channels)" in addition to moving
existing code. It would be helpful to have the reason for this in the
commit message as well.

With the suggested additions to the commit message...
Reviewed-by: David Lechner <dlechner@baylibre.com>

