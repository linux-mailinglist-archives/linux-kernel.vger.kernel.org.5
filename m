Return-Path: <linux-kernel+bounces-73573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989F85C462
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387801C22AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1936137C2B;
	Tue, 20 Feb 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STAoQTDO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66412838D;
	Tue, 20 Feb 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456244; cv=none; b=bdBFCtNObWt5c9Gel4/nIOvf6TGJ8kOzkVbLj/rCvT8C5U6G3GsLAgeZutSZm/gIGVO1bh5Ft4lS4PijyYdRwWM7gWwPcRtf51t+BQK7OEAxHCKV2hthNbLF9l7Y+a+9IiQ9hMYkrpfaTBw/LBgNvQKxNz/wfAwGq7rGWSmN784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456244; c=relaxed/simple;
	bh=EFe3zrWR0LWM1ZcyrsqjHTnnESZFaVS5VCYSop5F4Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHUYN2HbadX2c+VtS8Rt9TipR34oYZgI9IN6dnvwBbbLsnvwWwiSHlKrfeSSTLYo+fD9F23SAyTBNSF3LxX/i8S7BNhVU7icdjFucfAgn0JfroeCeeuR0zz7ywkkH/bvm1gt+oqNhWJVfNXxQyRBusl1eO2+NxGdhKEFiVFjoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STAoQTDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A23C433C7;
	Tue, 20 Feb 2024 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456243;
	bh=EFe3zrWR0LWM1ZcyrsqjHTnnESZFaVS5VCYSop5F4Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STAoQTDOpl9BLSR1MZMUXajWDDxXaE72uD0vlU/+O/v1Jm3Y+5jz2QdLWDNQmovnI
	 Rz0JrLOjKJrUw6ux+KxWzOTkp9MrOqj2VhuUEt6TQdMvb6InRbptZWHzKrOS/KKNzk
	 bg/qJ2s1qSexFpZCJFUZno3h0TrwnU9mawV6a6IeuKtYiWsT0ntYGbdg3MiSvRVE76
	 OwMWaGbbXkiAPmlwdNngC9AF1mR5YAeHiaTJeLXBfDw4Wo005H26gTXIn7K2R1lylG
	 A0z5HqW9BUXFVKcRwXLkqe2T5MMoQDj0CIVJgNVLlGzWqdtiW/PfTs+W/1GhTUBy62
	 hXXLnqPVa8zGg==
Date: Tue, 20 Feb 2024 19:10:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alex Soo <yuklin.soo@starfivetech.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Message-ID: <20240220-bottling-reverence-e0ee08f48ccc@spud>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tADB2NrbVw9jbyhp"
Content-Disposition: inline
In-Reply-To: <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>


--tADB2NrbVw9jbyhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:11:43AM +0100, Krzysztof Kozlowski wrote:
> On 20/02/2024 07:42, Alex Soo wrote:
> > Add documentation and header file for JH8100 pinctrl driver.
> >=20
> > Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
> > ---
>=20
>=20
> RFC? Why isn't this patch ready for review?

The TL;DR is that Emil and I didn't want to apply the dts patches to
support a platform that hadn't actually been taped out yet.=20
For an SoC in that state, at least the bindings for, clock and pinctrl
could be subject to changes before tapeou. I think putting RFC on those
patches is a good idea, but of course the rationale should be mentioned.

Cheers,
Conor.

--tADB2NrbVw9jbyhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdT5LQAKCRB4tDGHoIJi
0q4/AP9aepRkgGMwUZFmvYfa5PLBEmZ95b0tJEUr42AOOQptlQEAvcfTGWd32hy5
EqoPPciZYk30PuQQ68mEvIHOaYAqnwE=
=gvQL
-----END PGP SIGNATURE-----

--tADB2NrbVw9jbyhp--

