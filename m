Return-Path: <linux-kernel+bounces-97715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B08A876E5A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2281F21D1E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38B6111E;
	Sat,  9 Mar 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnMD7Ljb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA515AF;
	Sat,  9 Mar 2024 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946372; cv=none; b=ftMucAvdgLTO+S/wWiCaDIV8jcpbnevUbdUcIb56CmVr6qnRiL+LcbKPopBjju//Z2z2g9UP+7r4ImSKwJQIea/D2N46CGgJMmlQTG6lunWouA+hMZZ9S3jWk1kVipcK7YtAnfMDDlYRncHl1ITBgFc6o8yhVHTJcwjW5I7O+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946372; c=relaxed/simple;
	bh=lREFPRi9v8Cfg8jashZ/rXxJfnbAtvwWICX/500teMI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Iya7yer4EX1vLwOPE4Eq5izEkVhogf6kCechwhjPt+nkcxRrPfY/tr3vacUJTU2YioJL7+qbQQiJakVzfOv/SDhUHZAa54nXj0bzob1sS60rYEEk4Z5/wlrTrEh6Ie8uVHwqdrE7SGJvmfrxHYCrHYcfjeup5HLG4PgIwA8ZjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnMD7Ljb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AACCC433F1;
	Sat,  9 Mar 2024 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709946371;
	bh=lREFPRi9v8Cfg8jashZ/rXxJfnbAtvwWICX/500teMI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AnMD7Ljb/bWwLQLHeFoHolay53eZ+jAE0E/LgyknWXXz+brGzGIiVEEg6pEDJdrEW
	 TsZjveV1LR15YbyJzSHOcwQNY1RYB7LLwMGOzbTboGIVoID6s8brknXDPG/5C75mUy
	 80Uwt+HyCShbU8u35uM0hNZqydopewDPTCysW0PV/lxKzgGebBc4Wipp+B9NwUrh+p
	 jQ9do/lNy1tV3f2rFPe1K5X1ZBChj8S1pZL4IA0JgmE6TD5pvJ6rD4dKs/mVTQZlX8
	 eAlwDsuIw9j+Cqp2Rh2qcCDmChPmGlCoAK44qRCIUHol9IItu+Z94ptmuE94e/oNT1
	 3lSlW+jdM8whQ==
Message-ID: <384bf6c936fac50042389cc5f53c3199.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240303121410.240761-1-andy.shevchenko@gmail.com>
References: <20240303121410.240761-1-andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations out of lock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Heiko Stuebner <heiko@sntech.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Mar 2024 17:06:09 -0800
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-03-03 04:14:10)
> There is no need to calculate masks under the lock taken.
> Move them out of it.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Applied to clk-next

> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fract=
ional-divider.c
> index a0178182fc72..da057172cc90 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -195,14 +195,14 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsig=
ned long rate,
>                 n--;
>         }
> =20
> +       mmask =3D GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> +       nmask =3D GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> +
>         if (fd->lock)
>                 spin_lock_irqsave(fd->lock, flags);
>         else
>                 __acquire(fd->lock);
> =20
> -       mmask =3D GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> -       nmask =3D GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> -
>         val =3D clk_fd_readl(fd);
>         val &=3D ~(mmask | nmask);
>         val |=3D (m << fd->mshift) | (n << fd->nshift);

Should we pre-calculate the mask and shift values too!?

