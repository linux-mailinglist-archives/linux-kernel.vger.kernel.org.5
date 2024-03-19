Return-Path: <linux-kernel+bounces-107216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2987F961
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A0B1F21A28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2B53E06;
	Tue, 19 Mar 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwp5CQdn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622354773;
	Tue, 19 Mar 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836350; cv=none; b=Ey9olF5OBYOoFvoS8ttaKHuBKwwflyjEmmr4+TT8f4QKwSrcT+CkNnnaMY1UwI31cONoH2xpT8QxgWR596v66adpqUgVS6tntBN67VbRxLP3P4KsSja4Jwrwq+GMt5eYQI9sYXyc5/rsk8ex94oqIS22FRoPTqi2y1k2Cd9sP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836350; c=relaxed/simple;
	bh=3SfmKfgUNOAfWCL6jKlcEf4C3YVN39oYJGMEMbuonRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzUxnQxCrogh1tzepPOGfeyvBb81yGW7Z/noVc5c0clnLWApVQHrggvqrVTTZ4HVb61Zh+eVioIGBaUmHUjYPLaG+G3Lejh+mjP4IYa5OzjV4zfFSQGqlC+XcM1Tt786cS9fGcco8NeSFiiyIjhPaw0io4uQw/P/nU8VaWAYo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwp5CQdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54FEC433F1;
	Tue, 19 Mar 2024 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710836350;
	bh=3SfmKfgUNOAfWCL6jKlcEf4C3YVN39oYJGMEMbuonRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vwp5CQdn0MIt9yrPHEn/qNqGQhxuevwB8kuKHo0hf5vB9zBbeR1dBbvQFfba3D5ms
	 qldO+kjEhp2TzRHDvFXQxfDUVX3+2MfeNT9p12orWYvhYGqXGvxZgac4oTTlaos32r
	 Y2lt0/aPq4w0UKk0cdENv5BA6aZ9TZ8CxBTQ7QVBYhj8rZ+nEnqRMr3WY9xT1vwkBD
	 8Bml0CbA/0KVQw7dlNSF0IjGdYFiEqP0yk8ddXTy0OgmBuCxqXrBYPnXwQEhCIRRDU
	 DCO4pwCfa8Wq5NILweaQshURhPwib4yxlUOaU/+kGrMm20KDt7ZfNc9wSsvZNdt7UK
	 ixNOpk2nFNMhg==
Date: Tue, 19 Mar 2024 08:19:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Ziv Xu <ziv.xu@starfivetech.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] clocksource: Add JH7110 timer driver
Message-ID: <20240319-vivacious-anointer-cf790d8852c1@spud>
References: <20240318030649.10413-1-ziv.xu@starfivetech.com>
 <20240318030649.10413-3-ziv.xu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YezK/PMoxPe85t3w"
Content-Disposition: inline
In-Reply-To: <20240318030649.10413-3-ziv.xu@starfivetech.com>


--YezK/PMoxPe85t3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 11:06:48AM +0800, Ziv Xu wrote:

> +static int jh7110_timer_start(struct jh7110_clkevt *clkevt)
> +{
> +	int ret;
> +
> +	/* Disable and clear interrupt first */
> +	writel(JH7110_TIMER_INT_DIS, clkevt->base + JH7110_TIMER_INT_MASK);
> +	ret = jh7110_timer_int_clear(clkevt);

The return value here is not checked/used.

> +	writel(JH7110_TIMER_INT_ENA, clkevt->base + JH7110_TIMER_INT_MASK);
> +	writel(JH7110_TIMER_ENA, clkevt->base + JH7110_TIMER_ENABLE);
> +
> +	return 0;
> +}

--YezK/PMoxPe85t3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZflKeAAKCRB4tDGHoIJi
0iiAAP9eFKT0Wvg9p6zbDBpV0eN1dqOCx6nUB2Ukf5DY1ap3LQEA5MjriVvzPk0/
gnnyHqu05K8r0itRDk0eHc7kHO+3mws=
=dyH+
-----END PGP SIGNATURE-----

--YezK/PMoxPe85t3w--

