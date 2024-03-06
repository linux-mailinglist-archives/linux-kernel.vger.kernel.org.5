Return-Path: <linux-kernel+bounces-93595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714F873229
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D08F283C18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0760861;
	Wed,  6 Mar 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="od7K+B61"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDD5C8EB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715829; cv=none; b=mwOy2U7nm8e0DCbV//i5Zh64uYhBfmJAIaXXXHdSVQtu0X7dpPiRp7dY4tcTIHWaTsjcvK+E4IjbcaFNXTXt9Ixm0yko1N3CB5n4mgy7OLql133iq1PaCX9v2bDMqap1Qhn93uWULTnUELf9pExptcj+BA2kY8s59P3eJSIBeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715829; c=relaxed/simple;
	bh=MTuT19JZZrNFRbGttqnosgvFkNW3Quab1xPTgUgjTkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bInrdrBkZfyQ6XrpmLHqOd1UNhjB9lW788gHj0gl6X8RK+DNgkVJVp+GX2NbGTv2cC0ZB5n6mILnR9U65CGBMMbCAonDfZapHF2Le46+eK2fBlZe/LszTojIRG8K+A4Wzv3U5/e8MACSqW25BbtNd/A2dyjwG5GDk7GBf4++2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=od7K+B61; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6084e809788so4675497b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709715826; x=1710320626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKZ7A/WJk+lPfE1tZuzbZKiRTIcPzY9aV6hM5q3yvk=;
        b=od7K+B61ICqiSV2r+bJYXxEjNrAF+U6hf9WGdvO4o/y2SoeykxBk3pEsqkzJrDKHQM
         VvhGwPjogB93w+LCDhmd1shcwc17iNJ9AB/bXxJisUiYO3RO6C+I65fdoAnqWpYvXOVT
         2DgSL8lM3jvbrHUOagPAdrakvUpBVVwDn7A8Xd+objgdx2/CKirWUufbvHL+9bkz0G3A
         +zZ1sZMbSjbKpQPgTQ1PFgoEB1C+vS93icOT1ES4vcTc6/VUct75glOSB7ZOt0jGOJql
         MgsFywiik3NzNbT3+sJfI5W3Rjza2VFfhU6/1XGaeB7SNwLFnkqQvqiLAZjrxRwqNCVJ
         a8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715826; x=1710320626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNKZ7A/WJk+lPfE1tZuzbZKiRTIcPzY9aV6hM5q3yvk=;
        b=CPSdnbXszhHUGtdbKA643W2om/mysdeUa1ZZHy+ayd6E17YRC5wS4y6tSUdHv8IhAX
         sicSlXTdE3MOdqW1wSYu5fp8TCDYFEYPl/HnPWfvn4ecKcErJX4+wfolpnSS7JR1W0Fh
         Wjfxp6HIeQjeHyapJEPdZ6mW3qzU4eDeagwxbIqnwTZGovHWphc3jjI4dN91PCD0sHG6
         UQVGVdmD8Zth5Kbu96APctDzVJsnAMNK26PyBbOiDuyBvpAX8PJV/oR/aKFFcqeOR3cY
         gWkC05D5SAKxQNhaPM6TxngAwsLrGohIpR5B+PELQxi4K0XkuFdUAjveNo7N8NmAAGOn
         sJGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Wf9D41+26c8iX7MKdspdQW4Q0T5XGGvDHo4/JdvboU0R+WetaorgAeAeAVEDUAndUPDHlWoElxL2taDYLa1+gMNZNd+VnP98tM7M
X-Gm-Message-State: AOJu0YwIDoJwj/XooRgS18MbhzLf6vQm7TKHC8VPs9Rq4a8mnKGAixNh
	aH+JegrSmINyk3Tu6oXtpW2RrJpLeihXVWVKZZu8hqqciL3qpqK6oA5YekVyUAWzw8Fkq/Nkt67
	kF1O96E2S9/VpjaStfRN2tj9T6aucQvrpv/3xrw==
X-Google-Smtp-Source: AGHT+IEq0l4q0PGKGt/n9ZV87AxjL59m+ib2AxsDu8+ir/Z6fft6885YjPaR5xoKLN5EeK7eKL/Ps1HmkmZxbVDhpYg=
X-Received: by 2002:a0d:d894:0:b0:609:e180:5e67 with SMTP id
 a142-20020a0dd894000000b00609e1805e67mr119509ywe.25.1709715826481; Wed, 06
 Mar 2024 01:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <CACRpkdY1QfeqRfU-doq_qss8VzgWo9jLnULQREGmHPqsgpqWaQ@mail.gmail.com> <51913f10-892e-42b0-b609-c4f56878c473@gmail.com>
In-Reply-To: <51913f10-892e-42b0-b609-c4f56878c473@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 10:03:34 +0100
Message-ID: <CACRpkdZ7s2kNOFjG0v7U2xBtw8Ri2UTOxhQ2sa6_2KjkFsOA=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/16] net: dsa: vsc73xx: Make vsc73xx usable
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:28=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
> On 3/5/24 14:45, Linus Walleij wrote:
> > On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@g=
mail.com> wrote:
> >
> >> This patch series focuses on making vsc73xx usable.
> >
> > Can't help to think it is a bit funny regarding how many units
> > of this chips are shipped in e.g. home routers.
>
> How many use this particular DSA driver as opposed to an user-space SDK
> driver though?

They don't have a userspace driver either, they all have a kernelspace
hack on kernel 2.6.15 or so :/

https://github.com/linusw/linux-SL3516/blob/SL93512R_v2.6.6/drivers/net/sl_=
switch.c

> Do you have a list of devices, so I make sure I don't buy those :P?

- StorLink reference design SL93512R (and the rest of them, and later resol=
d
  from Cortina Systems). I got this from Imre Kaloz who got it from StorLin=
k.

- ITian Square One
  https://dflund.se/~triad/krad/itian-squareone/
  https://openwrt.org/toh/itian/square_one_sq201
  (The place where I started this switch support.)
  using the same hack as above.

HEY! You sent that to me :D

I think a bunch of other random router vendors copied this from the StorLin=
k
reference design as well, I just don't have all the Gemini devices.

Yours,
Linus Walleij

