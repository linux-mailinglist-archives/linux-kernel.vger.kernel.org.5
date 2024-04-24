Return-Path: <linux-kernel+bounces-156710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C78B0729
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB751C228B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D5159564;
	Wed, 24 Apr 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGUUZMA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9110158210
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954103; cv=none; b=rAz0Y0qYKj7C7mPdG8zh466Am51J9Db+fnSG7YYxuQ75WiWCdU3M2z6QxhBzNj3YOUuA2Hf0LZGa2nngr4OrpRMRnblWootWo6GvXMGX8h5eESWl+j0DqMK+wEiWEwkasRRcDUm/S+tYZLQHC6+xHSs9PGT+bs9zDntp8TXx9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954103; c=relaxed/simple;
	bh=mHWzUjYz6696rmqvzHHtLW+jfpbBAvrrZwJo47hyK5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fELkSGFXLSBOnir9zWtTgv8CrkajyucaIItIEk/RlXJSGdNJgKJp11WK9qvuBX7bnksfs6TB1A36bINxERlEADk9+n+MzadeitY6rdvxwefiw2IcKbNKF/BCki5mSYQC6Mi9o7TCic3KTenwK4LOMf40DsFI1i3oNCRssNOf8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGUUZMA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80471C113CE;
	Wed, 24 Apr 2024 10:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713954103;
	bh=mHWzUjYz6696rmqvzHHtLW+jfpbBAvrrZwJo47hyK5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGUUZMA9azO4ibiF6QemdmxTWinYwIrIJrEKjAog5K5qMVwXhM6aV4SHv7jbDK5AW
	 Xy5G1tSdXySiL0mngzzT7M0pGxxBGxwC21WutXxwkUpS1XsL6gfLFSJo0Gx7DmYfln
	 8SO6clR9pNJvmdE5RUP1OwznudQfeWwKR0EYDfu5xDq0wIY/E3gLoHbWsCjsl/9eSV
	 Z7WuLr7RzIz7Ec9x4zo/1kVr9pjejlIrUXgHyvB1rSLLD/9AicK6ZO5zJd0ULXLHa+
	 F+8Y46swU6Dye3kMquQmdLl0YeXvA997hyEhxRHcC53v26fA5HkWgsva/boTnngfkn
	 +ES8novzQFB+Q==
Date: Wed, 24 Apr 2024 11:21:39 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
	David Laight <David.Laight@aculab.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v2] riscv: misaligned: remove CONFIG_RISCV_M_MODE
 specific code
Message-ID: <20240424-sampling-autopilot-313efe9aa9aa@spud>
References: <20240206154104.896809-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oRqeOvL+VdCc0NJF"
Content-Disposition: inline
In-Reply-To: <20240206154104.896809-1-cleger@rivosinc.com>


--oRqeOvL+VdCc0NJF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 04:40:59PM +0100, Cl=E9ment L=E9ger wrote:
> While reworking code to fix sparse errors, it appears that the
> RISCV_M_MODE specific could actually be removed and use the one for
> normal mode. Even though RISCV_M_MODE can do direct user memory access,
> using the user uaccess helpers is also going to work. Since there is no
> need anymore for specific accessors (load_u8()/store_u8()), we can
> directly use memcpy()/copy_{to/from}_user() and get rid of the copy
> loop entirely. __read_insn() is also fixed to use an unsigned long
> instead of a pointer which was cast in __user address space. The
> insn_addr parameter is now cast from unsigned lnog to the correct
> address space directly.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Removing some m-mode only code always feels like a win to me, given how
little testing and attention it usually gets.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--oRqeOvL+VdCc0NJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijdMwAKCRB4tDGHoIJi
0obhAP9G8BENAnUK/4kZ8hmIz9sbPYs+/H9oy+evduj/1FIkbwEAwglg5QsZanZN
2N+UjmpnEvexe+uJYsAmjiRBxr6f/wE=
=esEe
-----END PGP SIGNATURE-----

--oRqeOvL+VdCc0NJF--

