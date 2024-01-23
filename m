Return-Path: <linux-kernel+bounces-35940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA98398F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08981C29726
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DB82D67;
	Tue, 23 Jan 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwg+fSiR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF347F43;
	Tue, 23 Jan 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036152; cv=none; b=AiH+3u14Qj2AAv+v5w7WDl+DQg+qP0QI/AgiXX/VtyA8ZHtJb4EVJylRrQtqAB9RcPBk2NULrEYosUlpLDrqrvTlU82w6RTF6SH+VLOukD4/BAn7ll8Ybw1ZGd6N6jyVS6f/l1l8dgaSxQE52xkxo13nWszHp4jatMvvjy332DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036152; c=relaxed/simple;
	bh=LbUKSvKEEnCK/ONAHtaYUgJW5qcQlDle3dKpVkI4v/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecyHBwkefDUpIDMcnhKjCWzLi9/3ev4ClzdNsHG4CzXVtidOjadVyx6SGPNJfPGXrUsWKxYZI88//lUv7IqGRakZiXdvA4eRT3IxERzbtsTDU5rZsEUtUCl7Cl5nBwMGfK+X6ow/y2cZAJ/5R8HBoCky1l8ZvMcEEjLOg712mtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwg+fSiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EE8C433C7;
	Tue, 23 Jan 2024 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706036151;
	bh=LbUKSvKEEnCK/ONAHtaYUgJW5qcQlDle3dKpVkI4v/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwg+fSiRkGh0CLOkYlQshenLD1ZSxXz+wcv25k+VgxT+U8oJXTxmlrWu40N5+dx76
	 NArsJxk3O+WdtxjDBGaFyRSuwknT+ew7yRCg0qVqigPS1k9VdNWyDKeAqo92TatKDZ
	 KTU/aNXgmAeZwquqWgcWsWB4KBJaX0/WqX5LdvWJ7E0N68xmkb71u9CNBOyDlknPo0
	 NT51jUMsXUVkRIoEX6dJVwHBF+JZhQJEifpE2YaczapEY1n0A8gkCMVnho/dytGxzU
	 TzfES/fUDANwzZENJecqK4hnect0HUvtOY7AKE49oGktGXg1Y0HVvVDEFKIpiW8cIH
	 QD4Pjv7+a1UOA==
Date: Tue, 23 Jan 2024 18:55:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <1ce926bc-537f-492e-9e4d-6e7c9f5fc057@sirena.org.uk>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <Zaqj0V82LD8wu6g+@e133380.arm.com>
 <Zaq1y9XpmzTsXDp8@finisterre.sirena.org.uk>
 <Za/YD/0a5Mn4IOAk@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IiAKNAKMl0gnu4G/"
Content-Disposition: inline
In-Reply-To: <Za/YD/0a5Mn4IOAk@e133380.arm.com>
X-Cookie: Stay together, drag each other down.


--IiAKNAKMl0gnu4G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 03:15:27PM +0000, Dave Martin wrote:
> On Fri, Jan 19, 2024 at 05:47:55PM +0000, Mark Brown wrote:

> > There's a couple more, but this is all of them in the signal handling
> > code - I should have one or two more patches.  Most of the usage is
> > actually checking the trapping and therefore fine.

> I see, I guess this area needs keeping an eye on generally, but if there
> are no more cases considered urgent then I guess that's fine for now
> (modulo other patches in flight).

Yeah, it needs keeping an eye on going forwards and there should be at
least one more patch to come probably this week but orthogonal to this
one in content (similar changes in different parts of the code).

--IiAKNAKMl0gnu4G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwC7EACgkQJNaLcl1U
h9BJTgf+I0kR+cPHQZfvqZ6cXjEhHFpVcYkXSaH79lkoFkjblsMnW0CZ0SuxhlnZ
X5iS0SWtUdcKUCiyzErfdsZQeJHHmcA0yenLBM56RCcwVt7odNKv8XRWrTxOAkxn
6gIK4tPIC54iByVK3q5An6s3vL3AAxv8vnM1VWugs7kCHShKk8e4t9pF64cIhKRR
v95Y/QX8JbS+/T6JMGXoqUgaldLVN6Sv17sunSf+8jcq4W4cPiSwZklLOh9qXfvY
Nj/3lf13TJTWTiC+UR6ShBrpeVXQIRnqZXEsyCj7FLp0AE0ULzMZRz89i6dTf8X6
ulhJxv7RZsw0GXZJFt7cYaCCopatKg==
=Z1QX
-----END PGP SIGNATURE-----

--IiAKNAKMl0gnu4G/--

