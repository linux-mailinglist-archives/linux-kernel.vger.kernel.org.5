Return-Path: <linux-kernel+bounces-119716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E083A88CC59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF75306EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66913C3CD;
	Tue, 26 Mar 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUTPiMi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51D1CAA6;
	Tue, 26 Mar 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479005; cv=none; b=OeGYWb1jKfN8RlEi+6vLxUXum5VfH2eXAVUwaGcP4BA7ln3IsNBlhDzHwCt7hUhx0jkjhzHfXJVhK0Cu9oiiSdike+Y/wCnC4D4sZmV5RYMl0GpyHjzFd2LUP+QDU8vVG547Znz6gE4hlFiRD6co2aqiErkYOTDSbWucnGNkDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479005; c=relaxed/simple;
	bh=MYuM+OziDJdcqGASBxOjcMDhgk1DD1EdDwugw6fhpyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnMEekbO78cNfoIlEJTOcLyPqC8W38YAhwe4nlVgJkN42QlVn9gTQlKqInHWGsgCTpj5eIe4kT+ThrCOZnptYHOXvQIkLInmdfcFG9ycmqpY92sa9Kyj5Fqe7duzuqnocMSuKLihlfRC+oJny2PDXd+bH7AmLIZdFiOAD9iOzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUTPiMi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56FEC433C7;
	Tue, 26 Mar 2024 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479003;
	bh=MYuM+OziDJdcqGASBxOjcMDhgk1DD1EdDwugw6fhpyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUTPiMi8e0zVtlDau51t9OecraKkse+TAeJojtYWQj2huM91czxYvM058AN3YEU0X
	 N08mkK/ewmQjw6YCYo24goEgIiEEXloWQkCQZlkQ3UEtDz42m/UAro96uXVdHhRF3w
	 KSk5s5MxAOON9l4fB5HcBLV2rYoR93llL0cdSKG/1c0WyXg0UNRvR1YtXsBCSxqWIk
	 4+N66CY6t9ZIZdgrPxvhxAbeis7GvWMSp/nF7uJeEKeD8i2sZapWGdI5qFtES6Ry2A
	 q/2c2BiHOSO17V8lURkrIUSi7KLikVcAKp2gLW2hrjmFXlu8lqa2BTIWYsc5MVCyib
	 fJU1sStbEF8kw==
Date: Tue, 26 Mar 2024 18:49:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQoCtIiJKf7dtUuN"
Content-Disposition: inline
In-Reply-To: <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--QQoCtIiJKf7dtUuN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:44:11PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 06:25:16PM +0000, Mark Brown wrote:
> > On Tue, Mar 26, 2024 at 08:22:59PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 26, 2024 at 06:16:28PM +0000, Mark Brown wrote:

> > > > I think the ACPI dependency there is as much about hiding the device on
> > > > irrelevant platforms as anything else, might be better replaced with an
> > > > x86 dependency though.

..

> > That's nice but I'm not sure what that has to do with the dependency on
> > ACPI?

> ACPI_PTR() makes ID no-op only if ACPI is defined. That also satisfies
> the ugly ifdeffery that is removed by this patch as well. If there is
> no dependency we will have compiler warning for defined but not used
> variable.

Again I don't think that's the main purpose of the dependency here.

--QQoCtIiJKf7dtUuN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDGNUACgkQJNaLcl1U
h9C8+Af/fFTCxQftM30tVRlx9RD+EQOzywVtsH2M+mMBZDrU8zVhvNWqGdSL5QWs
lxoNu9iD+DmL5pj9fsZCVqz5+RyrMxEO5af+LphPJbhG0O8hbnNwr3s3Y5Jq8nYZ
q/JpG5oHZZLRIZwxopT2J2S6QwLXI7NfzvfFPPez0KlDQmMb3elNvTb6rBNC0a4H
76yWVcfPTBa0lWryB1LjfxydqUns6j87MxJY6HL5u0qOeWMiAElqDhbJ4zQn7OG0
ONZriWvwARPb9wM0iU5QC3uGyp/rPYBwGKZDX9jXaOpcxxMyH/Ch9KTkYQcqtG1Z
USVoGM0nZNY3/z0k1w0iSxa3TTv8FQ==
=Gdyq
-----END PGP SIGNATURE-----

--QQoCtIiJKf7dtUuN--

