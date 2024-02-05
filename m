Return-Path: <linux-kernel+bounces-52334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF58496D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBC028B24C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7112B8F;
	Mon,  5 Feb 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZVclzhN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4612B7C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126141; cv=none; b=Rbwy+B7EiXhD/1IjJdkOn1fJZHQeg28pegjsE59i4DhHexgXTzhgpoSEBNugkpLYCl9ACXAIZMRL5GzMe0uIpyZ49GqlH2yOdwf0RVDu1HKWrpPGwalStbvbrth05r33Jpe8528hxflAeUAnpZo0Fq8NKc6+RkHq0CD+O8TzXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126141; c=relaxed/simple;
	bh=gHyQystWqCUly3tPbrkhBCPw6gsoNujzTRVoP5CQ7pM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBg0QRo90vlHsVbfINzkrCHt850mckTYjTn8oEYVlG9lC0TExyLJTROLcOsY3UeeVf3oFc+rKyJ7oXDuoPdwmpCUe/c4vB9Jp2uqFcO7d89EGFSUKAyahoNQ0Hh4BIEV07p0VwOZxSwviceNdi9dbZP1HrwOQZDhpQPZj+DPk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZVclzhN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a30f7c9574eso559885366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126138; x=1707730938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHyQystWqCUly3tPbrkhBCPw6gsoNujzTRVoP5CQ7pM=;
        b=TZVclzhNDXX5igsFww/pl1DCJPSHf+PRoYYkLcTro+OlbHCyd1CgUYXN4AbziAyMcO
         gOhr/kmN26YR/l397Nuwe6UDCKlsVraOIxTMGcVtpSBCkHhg5jf4LCiSqt3dyBfaQF96
         56mWpbgNvBqHtW1iADtoedyrh/R1/aoO3/F/rUNsRiNvz2etIdZ9ORQxcEtSuZH/X/m+
         Gl0gP4jRDYE81j+mGaetwRWUaQyWBxCg6p+ltl14LGdNTY1/g3QwWuo0QvxtoFtC2T8V
         ctTHK+D5skGG9rwnB9E+VLkFqe0WWyycQAZm/6I8Fu62jV1qlAVQ43HvsQShPFZTLGUf
         20Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126138; x=1707730938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHyQystWqCUly3tPbrkhBCPw6gsoNujzTRVoP5CQ7pM=;
        b=c2ABaAuUN95tT6xgH/XMvfIZCeYc1xaJ/B7GDiqBJbHgf8xgC0+2TDoDWH4DQe5k1K
         l5YdBI1+S5SJiJG+9DCoKS8TmQo+jzBpo9UIzl4pJheE9dDhcao4CZgFVkO3d+VvPZPg
         AEefwUQr2QHVpE04exCSkdKAm18L9zpekROEWytGN6Akw69D5OwlJWcZPAoNMQonjPld
         vmMGbfIQ7GQyDwgjiGOBruQeEeSTRwXtKprTDNYIwA38ZFCsP4T1a5Df+oNoF7pEXDLb
         glNH1oyKBVj5I+nGMy2Wk1KE0tZMSBXb/ALTGyo6XM2Ez8szf/hB3gAiiEhAs061ef1X
         jjxQ==
X-Gm-Message-State: AOJu0Yw5BtElVPueQrZI4wAemku98xSekuuOnOtiJe57gl5vEnNNgH3j
	9M6TJLvC5qAj0dFIs6mX9CXKlb++d32tjSrLbqASyYzGJKit5lHq
X-Google-Smtp-Source: AGHT+IFcfmYHtuJCc9URzmeP2xl0grKFq2HDILB9l8Zy7AJqyTUxekpLb3Z0/lSXTqEWE3LwJD1epQ==
X-Received: by 2002:a17:906:b254:b0:a37:d1a2:b1ef with SMTP id ce20-20020a170906b25400b00a37d1a2b1efmr960567ejb.25.1707126137942;
        Mon, 05 Feb 2024 01:42:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU73j1hGvgo1cN/412vOLyJMA6Xn43VwIAKndzoz7uLo92Sg8la3H7sR2TSRd7v3uwycL/9Q2Kd3RDANgCo8ybx1/0U8EukpfuBR08HR+tKLwK3bhVzuiR7JpeqPM/ASsldhppHtfLO3PM+aubAl9AUj7G89c6fMyVF9+Vt2xqshLJLutExK2wVNj3FjUt+Pgjc15gRTpqvFmHP600YbOI3A5LTE3oniYz47W8VKA2YkFle0id4eGvYlc7uxhV/JZQUYn+kyQVNE1IS8AOrPZAkQ5/c7tx0qc4FUpD2/xGnNdSu+6/YKXfqEYdLyc4puKG7W9BiPyYUpcKN1B7UsPZfBC0JWFvcU4/U4aIoDt/jNFt3prer+paAbNw=
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id cx3-20020a170907168300b00a2cd74b743csm4142231ejd.3.2024.02.05.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:42:17 -0800 (PST)
Message-ID: <f00582bf4d19b539cc1427706ee9a07fd3992bc3.camel@gmail.com>
Subject: Re: [PATCH v7 01/39] ARM: ep93xx: Add terminator to
 gpiod_lookup_table
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, nikita.shubin@maquefel.me, 
	Arnd Bergmann
	 <arnd@arndb.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Russell King
 <linux@armlinux.org.uk>, "Wu, Aaron" <Aaron.Wu@analog.com>, Olof Johansson
 <olof@lixom.net>, Lee Jones <lee@kernel.org>, Ralf Baechle
 <ralf@linux-mips.org>,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Mon, 05 Feb 2024 10:42:16 +0100
In-Reply-To: <CACRpkdYDmx9qrkCo5mad_w1e0MKNYrVirg=qi+R4Q907SLdRwg@mail.gmail.com>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
	 <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
	 <CACRpkdYDmx9qrkCo5mad_w1e0MKNYrVirg=qi+R4Q907SLdRwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnd and all,

On Fri, 2024-01-19 at 00:52 +0100, Linus Walleij wrote:
> On Thu, Jan 18, 2024 at 9:22=E2=80=AFAM Nikita Shubin via B4 Relay
> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>=20
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Without the terminator, if a con_id is passed to gpio_find() that
> > does not exist in the lookup table the function will not stop looping
> > correctly, and eventually cause an oops.
> >=20
> > Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> > Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Sorry, my bug...
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Cc: stable@vger.kernel.org
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Arnd, could you please take this into arm-soc?
I can send a PR, but this probably makes little sense for one patch?

--=20
Alexander Sverdlin.


