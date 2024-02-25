Return-Path: <linux-kernel+bounces-80058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F03862A47
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D5D281C18
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14C12E68;
	Sun, 25 Feb 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCkVK61S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597DEED5;
	Sun, 25 Feb 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708863583; cv=none; b=eqq3iwCqDkm/aZhihu4UOlBYSDY3IyFGwKnCLpyrhXGsL3RuHlo3xS6+CP28Ki2iMGsyztlesQOnNW4gEN2Q0g5vIn2YMrXP9YZHqs4uc15eXTlA7EL+D/z8HyL+RzphMay+NYzZN/PE5zOgewIrrtqLzcKlwXOaYR79XCxudcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708863583; c=relaxed/simple;
	bh=OoaVoO3IQY4tlcRi4RazlYeV6/cKOTwPaU6Y2PtEvRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddoNM/wrpqM3N9DQ4/qlfgUm0RARy5bBksJxfLdQywlQoPUBVy6mSZ4aMs3alF6cWtU2DKTaPX1GAcfF+p3wZQczTS4Qj0fplBpg7J4xtcfYCzvbZqHFw2XpEzj8IZEUD26J1fAoi0vBfeP7hzaaCeB4abyWJ7+QuVsgUDrP5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCkVK61S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF02C433F1;
	Sun, 25 Feb 2024 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708863583;
	bh=OoaVoO3IQY4tlcRi4RazlYeV6/cKOTwPaU6Y2PtEvRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCkVK61SbpjdfrhC56v0uo5ksvCnOmNdQJfLvG/5wKbOWawe9ugV/Qzpw7j87IZsL
	 zzX28U6I7GOs4LcM4ThFkzT0QfORyfH+YqQ7tRsJowWAhTJveN/aruNocA3quksBgx
	 Xxh+K20joL3iStdJ5sjZi5KK47x/eQi02/zw56As9pCTlJWAVwJyKAJfcheJOWuy7U
	 T90lqRHu4Jtv6/oG9pjBIQ5/3+iGVbUJ7lgAhmFTErk+EumzBshTG7qWJApXrkt566
	 YquGIVUTnL1eFi3b8adO1PoFxf6xfiySxWg+7gEMgWRLhhURXTQm0q/O3S6YMps6+m
	 nJ1jDqYfLvsgQ==
Date: Sun, 25 Feb 2024 12:19:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] iio: avoid fortify-string overflow error
Message-ID: <20240225121929.2e3fdc1b@jic23-huawei>
In-Reply-To: <20240224121140.1883201-1-arnd@kernel.org>
References: <20240224121140.1883201-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2024 13:11:34 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The memcpy() call in dlhl60d.c triggers a check with clang-19:
> 
> In file included from drivers/iio/pressure/dlhl60d.c:11:
> In file included from include/linux/module.h:17:
> include/linux/fortify-string.h:553:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>   553 |                         __write_overflow_field(p_size_field, size);
>       |                         ^
> 
> It writes into a two member array from a loop over a linked list
> that likely has some indication of having more than two entries.
> 
> Add a conditional check there to avoid the overflow.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

It's a false positive, but the compiler has no way to tell that only bits
0 and 1 can be set.
https://lore.kernel.org/linux-iio/20240222222335.work.759-kees@kernel.org/
for discussion on why + the missing zero initialization bug Kees noticed whilst
looking at this code.

Kees proposed an alternative way to suppress the warning that I've just applied.
https://lore.kernel.org/linux-iio/20240223172936.it.875-kees@kernel.org/

Your solution also works but leaves the implication of a real path to
overflow the buffer when there isn't one, hence I prefer what Kees had unless
some future version of clang trips over that in which case we can revisit.

Thanks

Jonathan

> ---
>  drivers/iio/pressure/dlhl60d.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
> index 28c8269ba65d..a43ecda849db 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -262,6 +262,8 @@ static irqreturn_t dlh_trigger_handler(int irq, void *private)
>  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
>  			DLH_NUM_DATA_BYTES);
>  		i++;
> +		if (i >= ARRAY_SIZE(tmp_buf))
> +			break;
>  	}
>  
>  	iio_push_to_buffers(indio_dev, tmp_buf);


