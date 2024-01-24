Return-Path: <linux-kernel+bounces-37608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1320283B281
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3981F2566E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970AD131E38;
	Wed, 24 Jan 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL6MsKPW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D84132C38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125781; cv=none; b=XTDHV3OdkDZ2Zo8qZTJmVhs5zspD/mCB/ou8IM4Ijfg3HFaSbIE3TecWZk72nPyAv2017R95hUE+QSj/skaPfXz3vJRhH4aEdXPupjcyIHnB7GHHJgQCHdTIeBdsgqAdC1g+AYnvTxcepZjPgGvjD5UG6oadynU07DX7AEg0zVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125781; c=relaxed/simple;
	bh=GJF9p1XcRmgc40UfJpNRJQSEB4xtSRoBG0/8WumtW9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVqUkyee0m/ttAyLwJsaEWpPGeoMVOZWrFB2MfTrLouI5LPpAwsg8R9MYqjJxDRnbemuTP9WGcWvF9iiq4s2JpELPMq6pk90gFtIZNk6c2VVn3IHVZh2s9aiZMBQ9axi6bZONFLKEAo7OkLSroGjOyv+LiaMyR6EeqexuB/WtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL6MsKPW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dd839abbf7so1856951b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706125779; x=1706730579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUEOwL0aT/KLBhzPn+5DluzUuCnwfBYA/R1aUTFAgCI=;
        b=JL6MsKPWvqszGc78AjeJjW0TXKA2fRLu906SCS60nCkuct1GHlHVFc4MMrGWJHYTqY
         7IIbf3ynu4duwQIRwch+VNd5WMD+umA9yde1ukB9j+aeDy8I60Hbg6jkYiOHAdL1SRZI
         Nb0oOkJIhQCTS9XES++Ue9/xj/i2F9QV/xW7xeTjvduDJ3eHzHOtWaKPBPYQMzcML7US
         9r9ybiYx+/dbGeQk3xvRV3Dc0ur3V9kbe7vbkqRaybAThhf8dSXbJSEJvP/GMauR2sdJ
         P5wl8yi2nLwNKswdu/a6LM7BktM3Szu0dWV5KMBWHpcnnYFyFUMi6Y2FvYU2MIlZ5La5
         Ul6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125779; x=1706730579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUEOwL0aT/KLBhzPn+5DluzUuCnwfBYA/R1aUTFAgCI=;
        b=VWASAxm3FxAKuR/pq744lkUiSDum2GOJzHZ2Ek5H+a7cc0NIH/DtcDnUrUUFD2HcZ2
         DJxgcJrsfuOHsWA1oiEbjBhy0iyyNDOrL4HVQBti5yXqsuS4PG/JBPSHU/15Cb8ZznaI
         wzieGR+atWnoE59d6sSjrpVhuJQmlDTlsv4Gw0hT9JRepT2Ny7ECNvC8VhRb/aRWWFTw
         J6W1+KITxgZd8KfT8zjzeaarVPUjPYH9mdZPq6/m1Hr1o/uP741V34h3t9iaHWdUmPkk
         pCg6tpgoHDAijScs1cQSSVTl0r6FJ7bMCNO+TNFJT/50PuWXo/0x/fv3VZgSb/eYCeOO
         i7vQ==
X-Gm-Message-State: AOJu0Yw3sxafenwOF8A+2PY1YfkV1OhrGA4U7nAwsTC8JJDIDTHHqm0I
	MYWnJN/h1B29XsKHDxKS7bsmfEH0VgIBkbXXibdmXvRH9h5llqtCTW2U5wtq7pE7Ek6XM5/AOql
	mQl8o7LeSAtZfdZ4+8E4JvbuFZOiJd1C3u1agcg==
X-Google-Smtp-Source: AGHT+IFXnsU6JzJpLgdE8tZSUC/O5y/OBNN7Hbw326L/sc6vMWMF7xBRsZm9zZoZuJHG8eMzCH3jQgmYWc8nW3X4iy8=
X-Received: by 2002:aa7:9e81:0:b0:6dd:8a25:e167 with SMTP id
 p1-20020aa79e81000000b006dd8a25e167mr43901pfq.34.1706125778918; Wed, 24 Jan
 2024 11:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-17-tudor.ambarus@linaro.org> <CAPLW+4k-5vdkBNdewTgG72iAr0oLv1zXncnmx-qy6diJqQMNDg@mail.gmail.com>
 <cfa6e878-01bd-45aa-8fbf-030288a0e65b@linaro.org>
In-Reply-To: <cfa6e878-01bd-45aa-8fbf-030288a0e65b@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jan 2024 13:49:27 -0600
Message-ID: <CAPLW+4nPC2F0jS1UrTVEJA83gcxgfX4wa_YT0Lu5oJG4G5B2EA@mail.gmail.com>
Subject: Re: [PATCH 16/21] spi: s3c64xx: add missing blank line after declaration
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 3:54=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
>
>
> On 1/23/24 19:28, Sam Protsenko wrote:
> > On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> Add missing blank line after declaration. Move initialization in the
> >> body of the function.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index f5474f3b3920..2abf5994080a 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -1273,8 +1273,9 @@ static int s3c64xx_spi_suspend(struct device *de=
v)
> >>  {
> >>         struct spi_controller *host =3D dev_get_drvdata(dev);
> >>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_dev=
data(host);
> >> +       int ret;
> >>
> >> -       int ret =3D spi_controller_suspend(host);
> >> +       ret =3D spi_controller_suspend(host);
> >
> > Why not just moving the empty line below the declaration block,
> > keeping the initialization on the variable declaration line?
> >
>
> just a matter of personal preference. I find it ugly to do an
> initialization at variable declaration and then to immediately check the
> return value in the body of the function. But I'll do as you say, just
> cosmetics anyway.

That's not like "do as I say", I'm just a mere reviewer anyway, so
it's just my opinion :) You can leave it as is, and I kinda can see
your point now (having actual logical operation executed in main body
rather than in initialization list):

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

