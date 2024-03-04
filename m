Return-Path: <linux-kernel+bounces-90108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86186FA75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D881F215F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E112E76;
	Mon,  4 Mar 2024 07:06:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2712E4F;
	Mon,  4 Mar 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535967; cv=none; b=eH4EgF5ytNbOGDupki1QMCSgfdthbVSbV3JLZ5MMXcBB9FiNflkriQJaiGb+Ck8otFEJ1nWciNlRlYagwo0b20JTLjFjCXI8nTZm99/K7HfgMZXApxxHEAdbBqmmV+aVHHrmE3xAY5x5uGcAMuTwJzoBRi0XHgY6ZQRyoPr3DNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535967; c=relaxed/simple;
	bh=UY3jYcbaW813smmZuxZqveKa67RKQsYjT1xCWMoDsKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=as7lxgLjj1xpb9QFAx/sR3f45ZELErVCmzQYwAFgAs9U/ocGfV+FJjnSZ9GT3OfVgTzpVlj10CJ+w6niDtez/f17m2P6jeyHD1Wo1ZIlDJ7DyMs1uBqWWfChIq1rD5bhLmPB+gnw1OzMYFmCEfElUUsGoqnr7ZITHjZlOXlmgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rh2OZ-0006L9-Ks; Mon, 04 Mar 2024 08:05:55 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Subject:
 Re: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations out of
 lock
Date: Mon, 04 Mar 2024 08:05:54 +0100
Message-ID: <2254891.Dhsi8hcfAM@diego>
In-Reply-To: <20240303121410.240761-1-andy.shevchenko@gmail.com>
References: <20240303121410.240761-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Sonntag, 3. M=E4rz 2024, 13:14:10 CET schrieb Andy Shevchenko:
> There is no need to calculate masks under the lock taken.
> Move them out of it.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/clk/clk-fractional-divider.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fract=
ional-divider.c
> index a0178182fc72..da057172cc90 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -195,14 +195,14 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsig=
ned long rate,
>  		n--;
>  	}
> =20
> +	mmask =3D GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> +	nmask =3D GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> +
>  	if (fd->lock)
>  		spin_lock_irqsave(fd->lock, flags);
>  	else
>  		__acquire(fd->lock);
> =20
> -	mmask =3D GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> -	nmask =3D GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> -
>  	val =3D clk_fd_readl(fd);
>  	val &=3D ~(mmask | nmask);
>  	val |=3D (m << fd->mshift) | (n << fd->nshift);
>=20





