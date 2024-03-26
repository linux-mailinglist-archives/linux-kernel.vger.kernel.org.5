Return-Path: <linux-kernel+bounces-119813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE088CD46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3F1F83BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145713D27F;
	Tue, 26 Mar 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKtoyTD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF313D26D;
	Tue, 26 Mar 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481572; cv=none; b=P4QofflMXmPZQIsG+r0S76I0xxLhfJtqDdWzjJeVQ+TdCl2pnsjyDcwBVr8dGMc6rZUpVPc3aX1mF0EZev6xhxvzou9FSZU0WiefS1CXlFf+FYvMMayEGyw0umxjCLrNDb6WeLq7T2S/0C9VzCJb8QOSIDF1YQSJ5q/jqJ3r79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481572; c=relaxed/simple;
	bh=zjtXxG6GkrKHX7ZVzuhHixYQz3Ed7diFfe6IuuueTPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn90hl23+yWmTf2XqBDS7oOpZ7875ocA9oAWscr/BSNGxLEa5sXfmL9HFlglTnRhnOcJvOXvk49JSHiuaePGBnHLSb2Eyp6T5763GVDj7ynUldCm9j3LA2yy7bvaufDLJBIcGQCJYnBNmRfcR73TxgjKB0trWbKO5DdKJpMQrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKtoyTD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E09C43394;
	Tue, 26 Mar 2024 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711481572;
	bh=zjtXxG6GkrKHX7ZVzuhHixYQz3Ed7diFfe6IuuueTPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKtoyTD8XJvuRURdUoASew6kz6I6Aa86XY+nymo87hYDPMZfZwIO6cXlFAylFbIUr
	 dHsRVFpy6ZKJpud019oOaZA5G5Zt90ewTphie46PTqBBJ3Xk0EaPcWpCarB0dQ/8lQ
	 Ema+MkF2m3kazdVKt4MNM6UkNdWyp8zoaercqvn8EO9lzXbAml+zVBn9OD4Q12EkJT
	 Ks8rmywGg+x5vBOhKy9BdnjA/PuznqBoHgR3U8srbBdlAmCtkxZDRTa9zvIDy/Ixa4
	 RtrtzBkAvMaauSx9jIs5Ak2lN9o1dme00cNuCAc1lZt39jLIZysUr3RZR1H6t93TSQ
	 GuxncRAUxkJ8A==
Date: Tue, 26 Mar 2024 19:32:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <a30da48d-f801-4d0a-9db7-9c9bb159ca6b@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
 <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
 <4241ecb8-07e4-4613-a289-4699c39d0d08@sirena.org.uk>
 <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="83N6LXkbTVvXHN3Y"
Content-Disposition: inline
In-Reply-To: <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--83N6LXkbTVvXHN3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 09:20:05PM +0200, Andy Shevchenko wrote:

> For my knowledge there is none of the ACPI-based platform where CONFIG_ACPI
> needs to be 'n' while having the real device (as per ACPI ID table) to be on.
> That's why I answered purely from the compilation point of view.

I don't understand the relevance of that, and frankly can't make much
sense of it.

> Personally I see that dependency more confusing than hinting about anything.

When you don't have a dependency in Kconfig then people get offered the
device even if it is impossible for it to be useful on their platform.
The purpose of any || COMPILE_TEST dependency is to improve the
usability of Kconfig.

--83N6LXkbTVvXHN3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDIt8ACgkQJNaLcl1U
h9DgYgf7BD2phDMXyXNj0GNfBpQOfAsGLKPuOckyUz0mPx95Xr73FcJ8/ph5wGU0
LYqvuVV5rIvJ6sNp+cn2mTKcfquF6c4d0mUUG7TxRvBMlW86Y3lpVmDe/fR1YoIT
/vrIt+9Ee7k/gYgfugOhqq8bdkZEdBXqGlDPm6PHS7dMobPG7aD/NL8OlVna0ZV/
w30X8p1CWx0pp2RVW3MpHbTfjMmqQ3WDa93TPTn3YQTTPfDlUchkhEPifxmhr3aT
B0RkQ38R41IXTgZGDIerUgBq5YY2kN89br5dJVeV/suhaWDKy6T3G9+ohz1cvWsI
G0leEgFXZ88+MztI1hsug0LIcnuznw==
=eeQ/
-----END PGP SIGNATURE-----

--83N6LXkbTVvXHN3Y--

