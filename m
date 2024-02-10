Return-Path: <linux-kernel+bounces-60401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1043B85046B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4951F22731
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D347F68;
	Sat, 10 Feb 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ2hMKBU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785BB3D0DF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569052; cv=none; b=pu3RiuVHbcZsmuH268Zs2yIkGPRGFb7u1a8VKpQVosKoW59BobD7VLjKrN/k1o29bxg3hQWeQcCaOfqGkVURbDcxTyX3N6WDoxhqAhr6rJN93OybSB8MEK/Vb7AG60j/QjTbL3gSFq2Athyzw0d/E9oZck5WB8rWESW6PWkvprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569052; c=relaxed/simple;
	bh=e5UurAD5X1o0QNkuSlPPXaN4qGflrQPKpWK+liJ9F1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPAldOZjwnSRwGVrkgActQWvGNzHtiR52Eh66DLudG+ZpTiugYLhm61UUzebn0QrX8jZRWH0WkAjWD/fn21bvNFCLxpruQIfRSRbMdFvlUmo95mPoP3o+JOJsR8AX7rW8ZBNYAWv8R6C46mEtkW3jpZ07MJiFMJp2+ZpFN7nq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZ2hMKBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D38C433C7;
	Sat, 10 Feb 2024 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707569051;
	bh=e5UurAD5X1o0QNkuSlPPXaN4qGflrQPKpWK+liJ9F1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZ2hMKBUFI9MaWV+h5YeUchrR7wmbdb0Dcm0uWbRcn/HMhwkhinTd4+2yk9QPTW/I
	 AvzNwM6z0kD9ommA8By4tPqWh+GVpkt4S9/VQ78l2bmPgP+vXUR5JcgtJiLqKAMZ6C
	 iXl+78pcrsatJKdwpx/VM3iRNzEApyfX7qObwEjP7M6PwzogOdTJzksiyF6jATb83G
	 Sw8/SiiBs30NapiPA2RN72z5Vo/iei38EKbByOSEZ0EMm5rKmMNMD/MHarxxgOfY+6
	 Zp1C4wQ7DL/HIqoiWd8usWSM5e+yiyCxfNhPsQmwoQlpkZX7GpVwaDVhS9a5HRLVqh
	 HMnntxRoSBNeg==
Date: Sat, 10 Feb 2024 12:44:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: kunit: Ensure that changed bytes are actually
 different
Message-ID: <ZcdvmDlMxGZgC8iT@finisterre.sirena.org.uk>
References: <20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org>
 <7d077da1-e792-4570-914e-5c26de420c43@roeck-us.net>
 <ZcapjWTuggJNdV/o@finisterre.sirena.org.uk>
 <d2c9b610-ca76-4104-9969-7dded960d4a2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8FGPKjRfuW9B26iX"
Content-Disposition: inline
In-Reply-To: <d2c9b610-ca76-4104-9969-7dded960d4a2@roeck-us.net>
X-Cookie: You might have mail.


--8FGPKjRfuW9B26iX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 03:20:40PM -0800, Guenter Roeck wrote:
> On 2/9/24 14:39, Mark Brown wrote:

> > > +       // so anything might be in there, including the values from
> > > +       // the val[] array.
> > > +       hw_buf[2] = val[0];
> > > +       hw_buf[3] = val[1];
> > > +       hw_buf[4] = val[0];
> > > +       hw_buf[5] = val[1];

> > I don't understand how this interacts with the pre-sync check?

> That is because the test expects the memory in hw_buf[] and val[] to be
> different (because hw_buf[] wasn't updated to the new values). The above
> cheat forces hw_buf[2,3] and val[0,1] to be the same, so the pre-sync test
> fails. The post-sync test passes because the values are expected to be
> the same at that time.

Ah, that was my read - I was thinking I was missing some way for both
tests to pass.

--8FGPKjRfuW9B26iX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXHb5cACgkQJNaLcl1U
h9C7IAf7Bnn6lINS/sHXnb8RZweA4zoZAf0pzgQXbUxB9/EN5v2NCZPf5PlWK/i7
mOz/lXetn5LFXUkRMXxmEnCE30zGaU5Yypq35uwi8jzb3jRS4aVn7Gva3uZjPJRz
a2HTitLA5zMqFDtLltUfcf90DK0l1cbuCG6GlXHG03WEYIITotDUX/flvEHnMC1u
r2NCbrGuhMzU+bt2eqFt9bVjTveLFO3TuJ0QCpmDUJuT5NZ1+bO6KXeZfRyl6HFf
aqlAJiRpfUhDQ5LGAe2SVBNsF3aIc3m/N17nbDEl742NyP1mM4fP7N/yuAvz92Q9
D9SHFxwDeH4tompa/ymOfozhy38k5Q==
=Tlka
-----END PGP SIGNATURE-----

--8FGPKjRfuW9B26iX--

