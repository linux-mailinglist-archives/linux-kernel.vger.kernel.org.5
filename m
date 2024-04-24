Return-Path: <linux-kernel+bounces-157728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4E8B151C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D86A1C23B41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE79E15699F;
	Wed, 24 Apr 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emCY6B6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C5757F5;
	Wed, 24 Apr 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993410; cv=none; b=FrtdQNQt8stg+PJ7rfASpkQHdY5UsWkN6HPb9+RVzOFJ79p59JY34rikZJ3lVBYQGJMcZ7yMLgVcIXcq3+1AEi+OLclL/Pv1D7IKu7GedYcBWG7Dlqw9A79tbgXxts06RbG44j9oxT5ehY64jIfMwPsdchDErgI7W0ss8Wo8s4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993410; c=relaxed/simple;
	bh=csLxox6RscW+c6LkKg2RdajfWhoK7Y54fzPaNFEKYxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7SnYnATTzVRQsU6NRoOXHSPa0/VZ/dewVqEeZgVVxqfoRa6gVsw3PTmnYmuIBaMc50DasJ0w9droxfy4JueYriWRFXQXt5ssbR+sl03N0FGPS04q3jtNj59pDj5USN9+3CBWMdGaLp617ibgRNoTcQ0f5EK+syQs3nWY2ExhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emCY6B6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326ADC113CD;
	Wed, 24 Apr 2024 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713993409;
	bh=csLxox6RscW+c6LkKg2RdajfWhoK7Y54fzPaNFEKYxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emCY6B6Y0owF0am56b0wjisC3Bj4AZHrs5iWTwj/S4iAEW5IS1i839JPmcRfdexfm
	 BFLTmCnjrzm66z27S2eCcl0mNXS6pMyWZyE1FBXJp3IXoZJhAgvs4s3+DTk/2zQBit
	 mRF13e8E5jKiYoICAyWRZnHkc6oY3L08YjCNerdqOn1gGAoc4JuR2XFQwMwfxWnOWi
	 gctRfTui+DmFdxbpfBo/jsk6vpyA6HrrdvsdoGjEsc5XuX9WjcHlsS21NP4lIxnT6K
	 O9h10pIcjK6Zi9dxccvhfbFH8uKZ0SslmbsIiP3c9EV83lxLZYNST5s49qINzddVya
	 47wSoiETgdG6A==
Date: Wed, 24 Apr 2024 22:16:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clock, reset: microchip: move all mpfs reset code to
 the reset subsystem
Message-ID: <20240424-gander-alibi-87f6e1896381@spud>
References: <20240424-strangle-sharpener-34755c5e6e3e@spud>
 <722f31da34e5e1cfef05fb966f6c8c96.sboyd@kernel.org>
 <20240424-glazing-handsaw-4c303fef4f7e@spud>
 <46c9baab4b3a834c27949b99668a9c30.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rbfJg0xHpBdUC0yM"
Content-Disposition: inline
In-Reply-To: <46c9baab4b3a834c27949b99668a9c30.sboyd@kernel.org>


--rbfJg0xHpBdUC0yM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 02:09:44PM -0700, Stephen Boyd wrote:

> Am I supposed to pick this patch up?

Eh, you'll probably save Claudiu a single patch PR if you do, there's
nothing in the clk-microchip queue at the moment & I wasn't going to ask
him to pick it up until you or Philipp were happy with it, given you two
were the ones that suggested the change.
I say go for it, unless you want me to respin for dev_get_platdata().

Thanks,
Conor.

--rbfJg0xHpBdUC0yM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZil2vQAKCRB4tDGHoIJi
0sAjAP0ao7UwNnwNRRlpKl3kZOBuF3y6vTA9c7kh1pzq6jU/lQEAnbYOT43YE2pW
eS+ibtJvV8+Qxx5zQpXBg2TQSx/BngA=
=Oa8E
-----END PGP SIGNATURE-----

--rbfJg0xHpBdUC0yM--

