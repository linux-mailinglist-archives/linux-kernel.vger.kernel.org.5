Return-Path: <linux-kernel+bounces-98294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CF877801
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFAEEB20E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302939AFD;
	Sun, 10 Mar 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJNxaL9Z"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C81E502
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710095620; cv=none; b=Yzb7r2TOtiWDnI4IOe/NEaWQ9Z7+gh9dG7rY1cKxUQoseDh1cwIyI4Cv1q1to7HclhO+X0HY4O/E1fMK1TIT2QUKOnbESrB53LL8b8x/wHPHa5osoPnagC3CrL7VqE0KKD/0gn5QTkDP8gRLjwlpY8u4yXK+6hqQ7BmwHD2ORJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710095620; c=relaxed/simple;
	bh=MmuHHmxJmjWcNPf7DeIDPD3TRmMZ/XQvYTWvLXfrFtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cez6dnsmgiuIM7DO+MTjEoADSASBtFwaMS3F3ckwbtKVt5UmUKneROPinda/RI5GfxdGeQfFcNC9GTr9gEcG1/0Uf8MZqQgrBkD5mL9uDIx/atyHP089Ube3PWDqUwRGtguqoEJNJQCennSK0ATrTJ3SolTfZeJ63fxiue1uYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJNxaL9Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6098a20ab22so30969047b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710095617; x=1710700417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmuHHmxJmjWcNPf7DeIDPD3TRmMZ/XQvYTWvLXfrFtY=;
        b=IJNxaL9ZbyiZvbHl5PplSI/1TSB1LuRZE0NnCAeh/URtWOG4ZXcJEwZ0FsiYjaYu7a
         S4QBB5kKPchnaZ1cVZHBRrV44RG6k2+SfBOmKLjdohk5ptHOIVLndKR9N7ci26f5SlTA
         mmBtprHg+sd0wNUWC6p7Hv1RJ0vbI16G2cDo0zt/i8F22q9DDZ8t5un1GWzuNCF59n+n
         VQj8lysM4Tdo05V4lwnBjglNLLh4PxH47GTu/e4xdsyQ68fDCk6bSpH1GNeczK4K7ek2
         V7+NB+pQb+4P4/fG7wAsVhEfOekr4lsC8EphzU9O1zCFcLORxNxRxhFoGBT4mYYUyZRL
         UV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710095617; x=1710700417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmuHHmxJmjWcNPf7DeIDPD3TRmMZ/XQvYTWvLXfrFtY=;
        b=wkEqO78xDc+Rps77P3j3VZwbAvrTvwEF+06M8Diq2M8o2FaLaTQ/eiTwDUWwanTftk
         WNt2aO4TfZGd+WmWaS5YI98ZHk8pkdQXeLa7uYh1jH4x6OivdE2w45rHBqFmpd8u/fvb
         cXAKlRWr3uyy4y+1nexIrQ9sn9NUqMfSOUrXmhdFgrnR9dYFp0olPNIPry98832VTFhX
         w5C2JcTXwaq2Pzd43bsO3m8pzt9+j6HSoccKz+B9V39l+52NhHDPV27LqRzTymctjeVe
         JAOoePu4cpuDPA5D7b/IcaPmxb+tsIazzjXrFz4HG4UUeDKUeVaRevHh+QpSzKRtPHTo
         fAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV+pPbj5m8eMA90KrZ1xe94ABSxOGxtHOYSfaikqv8BXeHdLarM6tJbYTbEERGrFPiMHsZyUvoSW245GONwoOiMjKJOdoefyf7TomL
X-Gm-Message-State: AOJu0YyYhkOUqGM0Xxw7TAcWcPnAyUL4hlsW4Vx/1WqWp8/iLCJTxSjo
	ugxvdHQRkgLvk30M0giUQXyg11jZllUAe50p+nfN1GThiEH45bgaGKFCmhIdq6x7+Ex7IA3er5t
	CWp9s4ZoZa0ZYonxAhdoAfbC2D5qfPOz3Ogv18g==
X-Google-Smtp-Source: AGHT+IHk9/MZKfH04meNx0eo0VkRFv/IXxZwyToHYYJmCwjWJCWpR3X7GXee/M5l0I1grTFtDjTL9/mR0bD01Xz2tOI=
X-Received: by 2002:a0d:f141:0:b0:5ff:4959:1da8 with SMTP id
 a62-20020a0df141000000b005ff49591da8mr4341361ywf.50.1710095617659; Sun, 10
 Mar 2024 11:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com> <20240310-realtek-led-v1-3-4d9813ce938e@gmail.com>
In-Reply-To: <20240310-realtek-led-v1-3-4d9813ce938e@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 10 Mar 2024 19:33:26 +0100
Message-ID: <CACRpkda0pPwW34QyrKYBOsztPhTdCiZ5cop0T9TP7DFTn8d6cg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: realtek: do not assert reset on remove
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 5:52=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The necessity of asserting the reset on removal was previously questioned=
, as DSA's own cleanup methods should suffice to prevent traffic leakage[1]=
.
>
> When a driver has subdrivers controlled by devres, they will be unregiste=
red after the main driver's .remove is executed. If it asserts a reset, the=
 subdrivers will be unable to communicate with the hardware during their cl=
eanup. For LEDs, this means that they will fail to turn off, resulting in a=
 timeout error.
>
> [1] https://lore.kernel.org/r/20240123215606.26716-9-luizluca@gmail.com/
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

The commit message needs some linebreaks :D

Other than that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

