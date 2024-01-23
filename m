Return-Path: <linux-kernel+bounces-35954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFDF83991E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DA82970D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979CC12AADF;
	Tue, 23 Jan 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI+E/vQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7182D68;
	Tue, 23 Jan 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036548; cv=none; b=DMNZZ39ZIkaTuVYH3uO3nQvIGXpHF3aA1t3LrmocH41f7N5y2s+aer+C1N1qZn2gk+TvOXzHFw2rfkfdyRCuRM8xzaA2KJSYIyfHRfJmu+q4F7amQO1UMasm56zUEWMHcwSJec0tli2Bh5hvPhHhL8+ZzrNW5A+aNXvNsUTDxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036548; c=relaxed/simple;
	bh=AMlDrC2WRr+dn3kpkOK/SkiOONKbAsdL0acAmBH3IjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENtregCY+vGVO4adjV4osA06lVp7WsLynR/xluEpNl37Cv1DMqMQ76BzFAaTU2vUJCZzQR/a2dA0G6BkHmMrjyAFVuOpbv6ETIWafrihXjBfoDA3XpCYtviyyGz9SfhoWROG2yijbmxfmyLZWTjtT4+6a6js/egVWxyhdLKTWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI+E/vQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7EC433F1;
	Tue, 23 Jan 2024 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706036548;
	bh=AMlDrC2WRr+dn3kpkOK/SkiOONKbAsdL0acAmBH3IjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uI+E/vQarJSnVSiAoOq2dQ+lhl/3Dg9WADb6ph2o3G24rWx9PVbPPWzvKd7z2zbon
	 fd6tZtG/0iNYSKyscM4lFRgg2/UaexicgL6rNqJYfM30JB4KsOQL5l1oWYLoYxMR97
	 I0EncXE4ocoHnjdEM4oyR8YA19HLvXSLEdV1HW7psOzzgaAY21cO3Nb4XpYPaphHNn
	 90li19FKkUnbA7o2ArL4OM4cyZxrKwRsWI2pHKzDLgnvpj9HC2OuX37bFZu/sQrgcS
	 QAhXfNIsJufrQs3TEWy/D0kEWsGaZIPkiBCz3GaZNV7kzmZoCtQU76ow+j+Afkj6Pb
	 6VmYsmdwH/FLw==
Date: Tue, 23 Jan 2024 19:02:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: fault: Implement copy_from_kernel_nofault_allowed()
Message-ID: <4d46dafe-b5bd-4395-b680-94b11814f7c6@sirena.org.uk>
References: <20240123011238.work.301-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nyrYAyHMl+yOHan+"
Content-Disposition: inline
In-Reply-To: <20240123011238.work.301-kees@kernel.org>
X-Cookie: Stay together, drag each other down.


--nyrYAyHMl+yOHan+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 05:12:38PM -0800, Kees Cook wrote:
> Under PAN emulation when dumping backtraces from things like the
> LKDTM EXEC_USERSPACE test[1], a double fault (which would hang a CPU)
> would happen because of dump_instr() attempting to read a userspace
> address. Make sure copy_from_kernel_nofault() does not attempt this
> any more.

This appears to fix the original issue:

   https://lava.sirena.org.uk/scheduler/job/497571

(though so did your earlier patch) so:

Tested-by: Mark Brown <broonie@kernel.org>

--nyrYAyHMl+yOHan+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwDT4ACgkQJNaLcl1U
h9Cz8Qf/Qy2KDqML2iyqq2XSVkt1s9bKd4G6tBipnCo95/TlOxpB5ZqdYHctfIBP
aDHBIqLHEm9S3Czkfrl3AvoWoir3p72kVBnaIYjoREM3n/33Qlg4tyR6s3ZNP4oP
6yVQeL13bjBKf1833x0AZ2WV6ShsyHf5BFgR5H2zCoK7wxg8IyfhHsorMGOHOTOA
TX328+5DL39ZskOyWnAwdte3d7oXTUDN9KSPUJEKav62YHjz63FWo4QhyXDTF9Hl
rO07Q8ky6jGtc8OCFi07Z5CLth43IyU1SGNQqxsibIYhtuyziqIU6pUeb62Oli67
UQ/nlT/qhBrOd4Ns+kX/2VQaHTvVMg==
=d+Ba
-----END PGP SIGNATURE-----

--nyrYAyHMl+yOHan+--

