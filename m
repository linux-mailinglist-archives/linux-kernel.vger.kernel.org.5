Return-Path: <linux-kernel+bounces-84819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7F86ABFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B351C20D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43137381AF;
	Wed, 28 Feb 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpBkus9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521B364BF;
	Wed, 28 Feb 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115274; cv=none; b=NGkhiD/gG0eJuT6GnpGXguuXBQDWU8tY5bCYiJMaW7A68b5QILElNsXJztczSClSy4NK07jb/CK0HzEB9C8vD4GMqR+K4Go4wxWHh7ZaUM9EzAVOWNyWeSg6H7xecbWkxXyW1B3qPwLn8m2hGqTWq8Zr6zssoRdVu2jqBq2Hwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115274; c=relaxed/simple;
	bh=LlpIsPA3s5JjEM2+9kxgL/praNsrMawFqUk7o7+/NC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3QNOIH1SN77BHtOxQ6LnMhz4dfNO7Ezjm6h4xseS8bqhIiVoGLwEAAUcC8CWLtfxr03+/QKSBRCOmKjnWihHFkXBKZyzUNf6PSKjTqNDvUt3vraNeS3yTqB8YG6SD0ZUSutRKzCsaHcaa6RNPGR8wt77faE5SKufa3v/847NQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpBkus9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63737C433F1;
	Wed, 28 Feb 2024 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709115274;
	bh=LlpIsPA3s5JjEM2+9kxgL/praNsrMawFqUk7o7+/NC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpBkus9WxLeKhaE00DYuxkdmEei5yuSfeL/vxQLSjUEn+6DIxN+B43J2E6fIXKE5s
	 WRC7wO5ureHOEm0e/AAxdRXMJSXiTCxhY6Pi2mfvSHj5QYSjkMBcznvx2ItcwNHEom
	 2wOYtKwluzAMEuASXHbs8//Dl4nEF6QWYtaUQ1m0HxioDx9JKTQW0KZnocp8rq1wSw
	 VTU/204MmfG0LXiy/RgmnNmYnhkCxGI+tBsICIhD4CgqmrN7uW/FPIAUrKxmcdVo7i
	 pi59kp74fst/qX240lSCzDyyZTrDhZz9YST2HmzuZjjwCFwX9PJb+x6AWI+7ifjBAs
	 SXtA9asVcQ2BQ==
Date: Wed, 28 Feb 2024 10:14:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v4 3/3] riscv: Save/restore envcfg CSR during CPU
 suspend
Message-ID: <20240228-persuader-dehydrate-549097aafac1@spud>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
 <20240228065559.3434837-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oQj8PrQtimAkDfFE"
Content-Disposition: inline
In-Reply-To: <20240228065559.3434837-4-samuel.holland@sifive.com>


--oQj8PrQtimAkDfFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:55:35PM -0800, Samuel Holland wrote:
> The value of the [ms]envcfg CSR is lost when entering a nonretentive
> idle state, so the CSR must be rewritten when resuming the CPU.
>=20
> Cc: <stable@vger.kernel.org> # v6.7+
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--oQj8PrQtimAkDfFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8HhgAKCRB4tDGHoIJi
0oltAQCyAW4xl4lPxjiVe7khhMrXdeuIuR7yGDqAKXKQJo1wkQEAuUcPMOTpBetT
Cp57UO+aOEO8qN+j2x5dwcZuPd9BSw0=
=nH9F
-----END PGP SIGNATURE-----

--oQj8PrQtimAkDfFE--

