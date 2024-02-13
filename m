Return-Path: <linux-kernel+bounces-64128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B8853A70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297801C24721
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5862171A5;
	Tue, 13 Feb 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VgMmt3KP"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C1FBF2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850757; cv=none; b=Jm+WEOBKgSx3tWYkd0MoVpgfsozy94o73CPlHekSdz56qsQ+CROGo+8RnwvAEKcIkz7jtYEPOrf/FV+Trxl3FfK6TsWuQHbJsCkUGDPcDsv6bA9AtJJOKl04Ctzi6XLgL7CjCqHRo9s3i1XSdE48BnQH3HehlISJzg9TsNBL4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850757; c=relaxed/simple;
	bh=PJdKvMmSBNE2RAfw4YBxzlGVgpiBoCU/LGkfoHp22AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi5mjib1IqG6SdD3NlTdCMQZg4qnPzVzO1mr+1C6SVT95vIhMC013UYVrBWpPLFnSThMcjcDwnKOalh42ZlpCdoOLcPgeMnv/teU2XclSZyx5IPAY6EYuxmOK5TnkRKeNJdpArh8gUMStW/0Azc9ijMPjn3jWOB7ysmlsjuCc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VgMmt3KP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d090c83d45so61988601fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707850753; x=1708455553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VnESsGdbuiV1eQP3Vr6/roBrvwRGALjsgHY+lb97YU=;
        b=VgMmt3KPPcTU9xvAMdcfZh86W3XKu5z9SRWT/tpBrLl3yi7s9fQ9H/OjuWD1yOAO+g
         H8K2SzmpVzscTpVgS0c0vGSxzn3tAJIQMrN4ZjU25lG+UsNCK0fvNt5OcaqllPsUx0Xx
         h0oqPENzH+pLMxtKfGrBnZeJ8Slc6CwfqxkHnPaEB3qlJruF4Q1nSpMr3qhHc6JiF2yU
         CkzDQRD4zlbf3XZGzz+hfw653OTWDSgFG6W2Bg3n2dZ+3BkzvoO3phN/wrbwNaZsId55
         kG7gPSRdj5SEtZ7hrpvI5EFvH4JM9ToDDDyKesx12eIQfklNcmJ0Ngd0wg3bF5uSdmd6
         GdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850753; x=1708455553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VnESsGdbuiV1eQP3Vr6/roBrvwRGALjsgHY+lb97YU=;
        b=dm4JvGeJbZfFGwudI81vhNzNtPNbN8TA9s87izOjKR7t8VZo1mWNcbcjBoMR3XDYFa
         RCTqQu5BgwcLvMsB8dTI4DB4IJ4/u9d6opwYVvJrUTd8/Q/yWwaydDL5CN9Kz0eCj5ph
         I6t8izPTBuSlJ4fpVD9WUJkNpc5TRW2zoSzYO3Rj0V1MBDheTWX+VN8rnRvUPgtG1zVK
         hEEgG0qyoTERJE3DbsKuLjvZ2IfxNrCu0Kwm4duNPc5Ppth81RtytO84BSDJZZZPO20u
         xgloT6ws1ODzMbOKrTAau7vnnk3p3rZ/7L+OCyVJcTzQpyw62A3Vv3aHcf1jSvPoIzcJ
         /xAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFSF7DJTUdv0c0AHmhtzu6ZtnzBO8uKKGqAH5RWrMBgqrvJvr0klavlTNGFtwFsIQKwbWP697JKUVKlfEcKHG9VEkzHUEVL8+4Gl3Q
X-Gm-Message-State: AOJu0YxGKsd278w1XDBcAHcWz/Qz4rMMzB77wmu6/NqBDHLaO5dhDIvO
	bCqZh1MEdeBhltFvdCJeFvwO74c+unbqGAwc43SDkKcvseTMjdVhymxATZ9Bwc/MW3tpWs6gTTQ
	Lug7hF+KOkWR1C0U1z+JwKXCtF2TZtwq12o92lQ==
X-Google-Smtp-Source: AGHT+IEtyexlJPLvXLppQIs8o5kxOpPSJJHow6m6YouTlGPB5XovHjo+6+/VKzvuzKVXU9NzOsCafaWIzasoUDAtQ/4=
X-Received: by 2002:a05:651c:545:b0:2d0:a6d3:56c6 with SMTP id
 q5-20020a05651c054500b002d0a6d356c6mr406995ljp.32.1707850752870; Tue, 13 Feb
 2024 10:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com>
 <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
 <CAMknhBEU=iMzpE_P0KePL4cZZktBOGHRXaEox5a7XcVjXDT+Dg@mail.gmail.com>
 <e03968102b92b3711808eb532685bc9e05fc3c8d.camel@gmail.com> <20240213173110.00007855@Huawei.com>
In-Reply-To: <20240213173110.00007855@Huawei.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 12:59:01 -0600
Message-ID: <CAMknhBFQLvaTcFAt_LqEsDYvMDOwFo3u0xkt7fOsgL0tcmoX6Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, 
	David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:31=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 13 Feb 2024 17:08:19 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> > On Tue, 2024-02-13 at 09:27 -0600, David Lechner wrote:
> > > On Tue, Feb 13, 2024 at 3:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >

..

> > > > Am I missing something?
> > >
> > > No, your understanding is correct for the current state of everything
> > > in this series. So, we could do as you suggest, but I have a feeling
> > > that future additions to this driver might require that it gets
> > > changed back this way eventually.
> >
> > Hmm, not really sure about that as chip_info stuff is always our friend=
 :). And
> > I'm anyways of the opinion of keeping things simpler and start to evolv=
e when
> > really needed (because often we never really need to evolve). But bah, =
as I
> > said... this is really not a big deal.
> >
> Oops should have read Nuno's review before replying!
>
> I'd rather we embedded it for now and did the optimization at probe.
> Whilst it's a lot of work per transfer it's not enough to worry about del=
aying
> it until preenable().  Easy to make that move and take it dynamic when
> driver changes need it.  In meantime, I don't want lots of other drivers
> picking up this pattern when they may never need the complexity of
> making things more dynamic.
>

Noted.

