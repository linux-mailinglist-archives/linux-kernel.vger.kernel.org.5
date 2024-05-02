Return-Path: <linux-kernel+bounces-166092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED288B9620
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02E7B22162
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACD286BD;
	Thu,  2 May 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWJLZH6d"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65742C1A5
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637291; cv=none; b=hwypxyQIGJb2ZPzDXI19lJL0onGnnSXaPqeqbl3olBjGcleMrJJO4B3TGMO7KDX7cKDeS0EzJzgx4v16c47ytLBxAd1Vd4nnaC9HsUWo+vxLVNYPOItyH8HFnVpcDVH59NnV+rrhbn1mam+yHCZKtL9ku48pHOrehHpYYt32Gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637291; c=relaxed/simple;
	bh=Tfp3g8V0aVnCRLq10EyyqukrcFGEY3Nfwl4SQpl+VwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAkTloLYY54Ahik3Ybq62L0EVmh9ULwpE2XK6TB0N/nN6WAJJOnG4e4YKGFcT5ilcLKDvXpPWQIr9Q4FVkpKWNscKIGaQ6jQBUaSDi59yMfMWMIacz7ZXGFrMLn7wOy0rn+PUFIGKanTxKc+teRkGJU6nYEGvTB3sHCCpCoAnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uWJLZH6d; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de8b66d1726so429351276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637288; x=1715242088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZf1UN1L/Rqc3VF4m9QS0otqoTAznMU1NUWIQvEmWvk=;
        b=uWJLZH6dgsHmC9q64jdn9VYuAvsMbFW8SyWYhfDpkOmsm5OKAG0hF+S45ZvHjw8S0O
         CKokoQh1YIp8MVDbJ7jp9iAN2v0bLKlMgti11Qet+E8YAoyw/Ei6b1G9ydIaoGTo7vlT
         chfG4k2YUII6mLofgipkvuSpHx9xjARjGIpfhphlFV3BRy4aZudfuJh0Njcr6UdgFghw
         awYnO0wpWJV+cNWVAGFSt2hCq+leaYXHZiLtAZEEMkHborzxW+Ho74vQ2qLFJ6uOjiHY
         A1UmrYrYEmjZHx/xGrBaeOiIuPFVn20L8/rBK/0yZ7IZp8zI7ZHVJWf3N5A8DnPLiMpQ
         BsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637288; x=1715242088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZf1UN1L/Rqc3VF4m9QS0otqoTAznMU1NUWIQvEmWvk=;
        b=QdgC5HjylfXge//CXV9I3g6eQYNN1nOHWij58u0fRubsCMFcdNe2t+KG646SEbrGRt
         +gmUmMntQkuSQH4zC3TSzPq55wYse6EHipwTqvrz8HN2Vqs1DZ/av0s4uo9nPs+tzI37
         wY0yFtp2PPe+GXvXo15I2vs0Zc88l6bHNE89l7FL7KyP/ttLdX8Tzp+r1m23Zl/qsUdP
         9FD3S0+kPlBUtpCsLwTcK3vsvjT+tuTZwK3emN6ockuPx+qkkK5+GLIhpnZ7W+v2ltxC
         XotLMf/h2eD9EDTY1WzFv+r4NU8GbBBlFA5TxTWvesZvDZQTCuVm+4slYdC3TXAOl8cn
         RVkg==
X-Forwarded-Encrypted: i=1; AJvYcCXg4j4TfgywD1Km8TfVBgftuz/LMEVw4zKmErZ7LbXzst910c4zt2Dn3Q7xGPks0Nf1HycRf5Sv9osEZdkF5ksY27tEn3I6x+svGW1k
X-Gm-Message-State: AOJu0Yw+Gs+ou3a/i3aXs8nTxYIXgbTehNTEC6UQgwknkfTm6eGAGEYy
	qY5y618UYQySC4xu0DSFijs5iB6lmZ/169StvhfqYbWxZPZsqs7Tvz+HhMW56m3C4nPgkitm2Nw
	5v+rtHt8fu7DZnJzKt5vGZywn8lArQ5Ffi3cjmolRMPK1XMcnNvU=
X-Google-Smtp-Source: AGHT+IHg0BJp5L3AJ3cmZrr+G9OhRDbfgMItRirP/XPtKut2c5Z/lA4l03TlTvhccBF3NweJuJ9pEzEQzcj9kjQP3Ms=
X-Received: by 2002:a05:6902:1024:b0:dc7:4265:1e92 with SMTP id
 x4-20020a056902102400b00dc742651e92mr1729041ybt.23.1714637288608; Thu, 02 May
 2024 01:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:07:57 +0200
Message-ID: <CACRpkdY_z1fkn4U6exOQQPouOfaNLs0wCYgBZJtWs+sd5EGymA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since driver can parse num-cs device property, replace platform data
> with this new approach. This pursues the following objectives:
>
> - getting rid of the public header that barely used outside of
>   the SPI subsystem (more specifically the SPI PXA2xx drivers)
>
> - making a trampoline for the driver to support non-default number
>   of the chip select pins in case the original code is going to be
>   converted to Device Tree model
>
> It's not expected to have more users in board files except this one.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

