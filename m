Return-Path: <linux-kernel+bounces-37300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7B983AE00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2200728D6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8D7CF1A;
	Wed, 24 Jan 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RihsbLcV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9697CF0F;
	Wed, 24 Jan 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112507; cv=none; b=sf8dscwkNa6RsScf/86zMCnkioKdgDDaFJiJSTlgU3TxfxLcgqzLPzRe6kr96kICsD3O3bAQukw9tx8baLogKeBKOQZ1oYnvKwbHE+tHq7hyVEQdoSFY8rR2eI+D7T9CfKMmEgC0FKJC8nlYO2ZWRqDIS+Y9zDZpgrEoe7ZjSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112507; c=relaxed/simple;
	bh=DaWdpN7BwW9Rz3N8clEZtNYY2V+QP/urU1Sjx36U/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAQiOrSyDRqDXh1rvDrskykIG+QVw34qgQOetyPqwUQUvM0cGOUfdqFav0IucDbqrI9vHIKiJF6UenCA0askaBKVAuEvqfzyeAw7EMtliEycwvF5gTPFIeP0RGz6nlGUBqy2kXSWESKXLhM7Q8g28lvLT+a0dINoOFUT6dcbfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RihsbLcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE91C433C7;
	Wed, 24 Jan 2024 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112507;
	bh=DaWdpN7BwW9Rz3N8clEZtNYY2V+QP/urU1Sjx36U/Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RihsbLcVCC6tH/nJwjn7CCvFgwm8zNWzNMQq6aGrHx04N1lljeiUcNpM8F96CR+JW
	 XbYFOgVdK1D/kSgWO49KB+iQsthwA3p3z/QaQg4NQBvHfT7/0o09sLfHnRzctIwm1D
	 NJf2ErpXMaQMZfZGNtE+fLccoHe+jcP34ol9dTcaFVPU6nfjNGDzu5nsH0pJyGEHYX
	 79GCzjK4/CY1Q7Jr+XHS5g/FqPATtiu+a0B8eecWxIDqcrjI0K3AlrnZ4E0RHaZCOr
	 qU2PC9fO5iN+EUJOetdXdVvgvxnNuDnriE/uk3FM6IggoE/hKO7HSoV3DTG5DLREvf
	 7TlGEc9ULeVbw==
Date: Wed, 24 Jan 2024 16:08:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Message-ID: <e7e5982b-7b85-477d-8649-a58ea1d40e29@sirena.org.uk>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
 <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
 <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
 <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
 <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
 <38630519-733c-4598-97a7-19a5e6306513@sirena.org.uk>
 <bc19929e-8231-4bb6-bb36-555a68cb7335@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="La/ghchXRX65G8k0"
Content-Disposition: inline
In-Reply-To: <bc19929e-8231-4bb6-bb36-555a68cb7335@csgroup.eu>
X-Cookie: To err is human, to moo bovine.


--La/ghchXRX65G8k0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 03:28:32PM +0000, Christophe Leroy wrote:

> Should we revert that commit 4d8ff6b0991d ("spi: Add multi-cs memories=20
> support in SPI core") and implement something simpler ?

I really don't want to keep going through the pain with having people
constantly adding access for chip select that bypass the helpers if we
can avoid it, there's been a constant need for fixups which have just
added to the pain with the multi CS stuff.  My thinking was to get the
API in place and then improve the implementation behind it.

--La/ghchXRX65G8k0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWxNfUACgkQJNaLcl1U
h9ANugf/ZmDCYh5tXW2idgNrbFAju9Znmq74ViirQWDW6ezLyn3RTrKW3DErXQFA
KZR5lkvczxXmU2MGa3Po06YCvGwkSTbNPydt1k9U2eZJ+J6tS8Rf+wKQFbsbg4IC
8SsYWl4muzcTU12DdIIrNwpb4m6IQNGIaoSlDgC9Nr1k0rX4SGnbLtS1cCKspaDA
Gc6VnRxjITw1NxqXbA8lWXT/DR4ESVCcUvIpKfnkhqaceWy26o6lJTkzYBhqx//3
vW6lZZGOqz9BwDNgim/I0RWkus3Rn5rTP5vCwejLvBCuQaki7MS7qfmrCrDfOA1+
uny2FStMImMdPvWqoi79dau1Kc/PdA==
=dJ/B
-----END PGP SIGNATURE-----

--La/ghchXRX65G8k0--

