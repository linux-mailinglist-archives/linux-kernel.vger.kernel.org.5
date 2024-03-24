Return-Path: <linux-kernel+bounces-112814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22BB887E83
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB64281089
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A9DDAB;
	Sun, 24 Mar 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCk43MTH"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24DD51D;
	Sun, 24 Mar 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306823; cv=none; b=iiHTOCTGVqY0W4yUpi/7kN+urePCvfq3Hr9X9VwYFbQzLLvXi13z1X/HoZBdz0ZYTNewttLU0mkbETz8WP4IgUhjc49AIIgy3ZuQ3MNKaSbS7Pxv6SvZ0r+OoN5XgKtJu0i1SXDi6ZeUEDpmMGFfyRKBktw1soLP+XfvQXx65EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306823; c=relaxed/simple;
	bh=0uDTXPO9DAZL/Vz6XeOcY9b3jjyTrfYWOY4uqX6iy14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwG4yPfm+ZEubMdr0GvPcLP/nScjzeRtxxBKu07XNXVRAJSUbVeSZwLh2PlNkFD1FXLoOSP5U4PISJEZwnrfxOMfqx7W4jLgBTWrfit7pg9vPGCo80eRIxlKCJJ7OKg+5ft4U+gW2yPc9LoOJHPFcSaP22iQDl6i3ya5RL45TLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCk43MTH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so3284554276.2;
        Sun, 24 Mar 2024 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711306816; x=1711911616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs3jwcD+bSMxZx0cQlLSPlfHe7+Vx3v1SzeuR8ex/8w=;
        b=WCk43MTHvwdKZ2rMA5K/H3f02ncp1nEOt73mwCmiJEdameR3bfCV97Xd/3cLBjXK54
         yuGGFS1ai5mXdBdQy9WPyWWYGaWcVaTYspfdrSHupGKjZZXTun9f3sA0qsqhpIh6G7Yw
         5uNFKM/mLpu+f7e3Ti2XwYg4QIC3ikp0sTTHdCdXGSAPiRhnqginpDVQImez9zH3jSFp
         92K9ZIfbccVINq0+4fYMH3O0RgLjEW3+qYC2mJSee2a4/nYFdh3AX60kLFHg3HGx28PF
         9Pn2OoYU9h4EeLgOcON4UNwFYRj/MPUfmSwMwG0T/eKGoIesbVwOUFJ9WolPjAt2ftur
         NU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711306816; x=1711911616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs3jwcD+bSMxZx0cQlLSPlfHe7+Vx3v1SzeuR8ex/8w=;
        b=eZGtVO/m8x9V9E5Jq9yeuLRnYV34jaBlpeadkpfDjXN5o3BONaAR9gE60qeu09f6Nw
         O8L6RIJEkD8XLrDVXlh/Fba9NhZpsKaGFn74zI/+b2vY/tIkA1wm94WlAVOStLyKLss+
         IvC1wv+TfYzgwRDRe3Ig7oC7IkaZc6jJOS0fgc8Ehmm3EU6/MEL3CTHi9uw7Mvvx7zf4
         mLHXoxy1VsQmwaUnxHzIyTaEoo/xvzs8ZXATun2I0sk3FxrwIsFx93n6188nfzVtY0Yw
         HbRVjvh43DMC4nlr6PFqFqNNErB/NQqquvAnHTEcslXGYxH7sDgnbdEEzHriIIu5g6qf
         rYdw==
X-Forwarded-Encrypted: i=1; AJvYcCWi77NA9RSORxt7SCVV6bshVHuXVb5IHqa3lyZTyMOZ6r+/7j1CCSTi24C25EWBnUGx3SvHKs0WScss0zda0G0u4FHap//Bh1IUyhZCjqeAr8H9Umin6sTplPicA79V6Ii1DU3MSuDv62tiyTEyzYGTP/bvg0oEExtBYLSOzQse2yLOGg==
X-Gm-Message-State: AOJu0YwYsbW5WPLiYFvhU4geoPdywWENWaB8scJPFAjxqirylmvj137A
	IIsU2C5yCWp8VlqCKcvLJj+KSi8whOzElA1RxYY3NaLcs0mck+Yasd2HwLMZVO9Euqd1zBcbOrp
	ta0U+c69crlmZ3hFRStvwVgWIx84=
X-Google-Smtp-Source: AGHT+IHrUHSUlApoRrfkRpt7zMExqBxrDGo9f0m60Rh2RG+K+WM9Y21zRhb+EO3yu0XN+fiKxztqhEdYDuiOXHvXrpg=
X-Received: by 2002:a25:8609:0:b0:dcc:f6e2:44d0 with SMTP id
 y9-20020a258609000000b00dccf6e244d0mr3338435ybk.37.1711306815913; Sun, 24 Mar
 2024 12:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323122030.21800-1-l.rubusch@gmail.com> <20240323122030.21800-4-l.rubusch@gmail.com>
 <20240324133238.61d5f989@jic23-huawei>
In-Reply-To: <20240324133238.61d5f989@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 24 Mar 2024 19:59:39 +0100
Message-ID: <CAFXKEHaeWbLV6g9eEdp9de5sZO0TJPRrJvsVxnGCf9jzdxwgHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] iio: accel: adxl345: Add spi-3wire option
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 2:32=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 23 Mar 2024 12:20:27 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a setup function implementation to the spi module to enable
> > spi-3wire as option when specified in the device-tree.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h     |  3 +++
> >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 3c1ded0c2..6b84a2cee 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -8,6 +8,9 @@
> >  #ifndef _ADXL345_H_
> >  #define _ADXL345_H_
> >
> > +#define ADXL345_REG_DATA_FORMAT              0x31
> > +#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
> Name it that, rather than using a comment.   No need to precisely
> match datasheet naming - you are naming the value not the field here.
>
> ADXL345_DATA_FORMAT_SPI_3_WRITE perhaps?
>

Would you accept the following instead?
ADXL345_DATA_FORMAT_SPI_3WIRE

In the OF binding it is SPI_3WIRE. So, from this perspective I think it wou=
ld
be consistent naming.

(...)

