Return-Path: <linux-kernel+bounces-119968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8F88CF87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AA11F67619
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4713D614;
	Tue, 26 Mar 2024 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ4ybbDM"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60D12B157;
	Tue, 26 Mar 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486814; cv=none; b=ZETfweHHrpBaDZqNL2k9qaL1KIDjjWLMjTk16bkZmRfwctjI6VVPWCK8sIYiWMxUVN/VJXcEKGER2L2BxePf2XPiT4Os3Vo+csr22z6vDQeYTpqKy6YQaVWILgY4SlxS+uG0vm9tavSKrrMGZKDZap2l9GKEZcGSORnFBaeHFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486814; c=relaxed/simple;
	bh=BMDy0xEWSqRLIBS7dqDM7r65pTCpIKpqHbzXnYc8qSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtV1nu8x5u4hEJLotwJnaNrnXHHX3BfcImGci7gg8c8lwSg6ETPWYGpkYO+IHDdWafGTcflQWBsHnnXn1ueZfuLd1kS83nMHulVQEJU5Z2eoGMN/DPDmm/x3SxmrG8iIOpcnqzlqJgH8/Zx6pmo4DTRaBqxuQQMCbgoC58GYMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ4ybbDM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc73148611so6699741276.3;
        Tue, 26 Mar 2024 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711486812; x=1712091612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGCp3Hdv4uExC/POBDKFeOwya+tu2FDjTleJp+1lj24=;
        b=bJ4ybbDMbnyN0AY01ONxvhRhwHZETgbrYY7ZqPMGCGMlHLOsGnkvKB9Wpk8itcGZ00
         nSV2xLbOXgR1h3+nJOYAAMtt85gq1gmD19hAH2JYtWXExbkN/gLSacD9uLPrYJ4QcEet
         kKPVpHBStk3xGxDmaWchmGxbknJ+agLajtkmeqQzndEnclVFGulNcJAKYbX7xekZWMHh
         Pa8P3qgt0QqbyVnqVDYubYQEqIFmbhSmv7LI3mA+UT5UqhP6rl4x7Ef+BZalI08cB4DI
         MtUKnq/adVAEvwwOidmDwKkjzChte7RrxcCqaSicObwNiTXxVfqL2gzbS0JOzQlDsPQy
         2Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486812; x=1712091612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGCp3Hdv4uExC/POBDKFeOwya+tu2FDjTleJp+1lj24=;
        b=kqqtcOQc2R0YJeHLK6X+e55TcbCWHvZwR1KpU0KIXV7dp2gnix4OVD8KDxRCkILxt+
         n3HIdYHTfDzqQixyylnHq5Va9byU06uKZYo3mrGkedhjXNZ5V7PmFMwIcxaG8mMqYaTj
         igd6zQEaKLM/3UHxKx6c+obRSM/w9frPPr9HpyuRGyWuy7qmLN4LtcSylborhlMf9lsA
         +JIlLex4NqkQ2vaHkazbIwg1nV+AUHxsDVXdg+O5FHgcAtpkC+qcNHKbm3bVVAEW81jA
         HeBCXdx3ouvIp1+xi7zp6TlHNgI3Mywua2rqK0o5Ek+pkm3xIrOpMeSqvV6/fwksvNEs
         nthw==
X-Forwarded-Encrypted: i=1; AJvYcCU8O4KBhm9QEe+7qMMqqR4Qev44LAXWw63sdtCXrzf8z5HFuGFLDiIQKmfwiCTgG3h/zZ8DWTvnYJCwxtNsN6EoXMhWcFtMBoaZdAcgNqofrn7q9VWU6A5+RDkxQsf8ciPuRu+/Zu0Hu8St8WCpkGWA5PA+Xlj3O5fV+f/8OE/HM5xQOw==
X-Gm-Message-State: AOJu0YxGLrNT1EYwihqpP3qPqQnTtVXPct1hFOGGQAGbb8kyiXb0Pa+a
	qfCzRpPtckfWH9eZ0qqmWGhsKU0XEfuDkN53mRk7Mzps4W9SdHORjkCo9V2aMrC6J6UgoQwDN7w
	Ybs3mBJ0Ds4p1xTZxjQ/Wb0NtM8Q=
X-Google-Smtp-Source: AGHT+IGnBS3uYEPzzhWdmO60nBwmDa62VvwywhNlYBEtbXjLv1cMyRZvHokMWD6A29XZ3J9dV656THZwPA8V+zsZvj4=
X-Received: by 2002:a25:dccd:0:b0:dcc:8d09:c7c4 with SMTP id
 y196-20020a25dccd000000b00dcc8d09c7c4mr2182951ybe.7.1711486810191; Tue, 26
 Mar 2024 14:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325153356.46112-1-l.rubusch@gmail.com> <20240325153356.46112-2-l.rubusch@gmail.com>
 <20240325203155.23ddfe3d@jic23-huawei>
In-Reply-To: <20240325203155.23ddfe3d@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 26 Mar 2024 21:59:34 +0100
Message-ID: <CAFXKEHaQLu9WFJe4r4+QaWO-wjM0hpYkWF_s8NOSh2Hoo5w8FQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] iio: accel: adxl345: Make data_range obsolete
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:32=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 25 Mar 2024 15:33:50 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Replace write() data_format by regmap_update_bits(), because
> > bus specific pre-configuration may have happened before on
> > the same register. Changes then need to be masked.
> >
> > Remove the data_range field from the struct adxl345_data,
> > because it is not used anymore.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 8bd30a23e..be6758015 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -42,13 +42,13 @@
> >  #define ADXL345_DATA_FORMAT_4G               1
> >  #define ADXL345_DATA_FORMAT_8G               2
> >  #define ADXL345_DATA_FORMAT_16G              3
> > +#define ADXL345_DATA_FORMAT_MSK              ~((u8) BIT(6)) /* ignore =
spi-3wire */
>
> I'm not keen on seeing masking of a bit we don't yet
> handle done by value.  Can we instead build this up by what we 'want' to
> write rather than don't. Will need a few more defines perhaps to cover
> the masks of SELF_TEST, INT_INVERT, FULL_RES, Justify and Range.
>

Good point. Anyway, there is also an input driver implementation for
the adxl345, mainly dealing with the interrupt feature as input
device. Thus, for the iio implementation I would suggest to reduce the
mask just to cover SELF_TEST and FULL_RES and leave INT_INVERT out. Is
this ok?

> >
> >  #define ADXL345_DEVID                        0xE5
> >
> >  struct adxl345_data {
> >       const struct adxl345_chip_info *info;
> >       struct regmap *regmap;
> > -     u8 data_range;
> >  };
> >
> >  #define ADXL345_CHANNEL(index, axis) {                                =
       \
> > @@ -219,14 +219,13 @@ int adxl345_core_probe(struct device *dev, struct=
 regmap *regmap)
> >       data =3D iio_priv(indio_dev);
> >       data->regmap =3D regmap;
> >       /* Enable full-resolution mode */
> > -     data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;
> >       data->info =3D device_get_match_data(dev);
> >       if (!data->info)
> >               return -ENODEV;
> >
> > -     ret =3D regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> > -                        data->data_range);
> > -     if (ret < 0)
> > +     ret =3D regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> > +                              ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FO=
RMAT_FULL_RES);
> > +     if (ret)
> >               return dev_err_probe(dev, ret, "Failed to set data range\=
n");
> >
> >       indio_dev->name =3D data->info->name;
>

