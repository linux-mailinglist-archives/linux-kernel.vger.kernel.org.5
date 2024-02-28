Return-Path: <linux-kernel+bounces-84818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584CE86ABFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886501C21014
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F40C3770D;
	Wed, 28 Feb 2024 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYQM1lxm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A63770B;
	Wed, 28 Feb 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115236; cv=none; b=Sr6/66lqrD6sTdu7LFfVwss9B1dlGFwNmtY8gi2L+/nvT+WEor/jv457lJHPJ1gcI/4Uh7Z98QBxLJsl3yntLXqr8ixxlk2cKzfWCLUFjCGGrDYPJHmDKgTWcK4mfxzo+AeDe4fkYBehddIrIH2C9W9zL6brcxUzL4wzRvDLI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115236; c=relaxed/simple;
	bh=Aw6MTellXqHFmH4oHAwG/lZE8WzOhLwzBazP1CZOc3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOIJU0JCPr2I3hhwL5HcEbfmJ/2B6nZpEREKIEzLMdCqQdzT6tA8m7uiMhAsJjwXQJ52QjTQRJ0VDPOQfQoBlziqugCYsvGd/2LquM68OtSrWQeY9bqVGzrY8vKks9PZi8uxRWryZOdpjsW/ds+uQKeUoNnGd1L7JOc3yGQRor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYQM1lxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C372FC433C7;
	Wed, 28 Feb 2024 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709115236;
	bh=Aw6MTellXqHFmH4oHAwG/lZE8WzOhLwzBazP1CZOc3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYQM1lxmkxNt120hTaJP/7wOwZev0uQR715A6QnDoDDYlidkOBaA3qtqAdy6LcI8D
	 x4NmbNvlmUcC4fLeIvUTA7xbR9MZGPuKXvhwOjqZvj/tGkGpTeGJIs66+2PJkPxun8
	 FgdyrIVH/qijkwwNPFaEOWgSrz2Mx+1XyfVdMpoL0N/V0wSbTolbOJKgcNTD3AlQ9u
	 8dRu6JEYamSBWfpYetisMVpvSkNYOqcyvH4BQ3od9+kHnfCc8WO5rHQFIKfhecykWI
	 AUvpJ4wlS0GEaEYKTpYniOE2BhQWuujT5cx6TF/4JX56+4fSDsOdhw3M8GRxYfqqc7
	 HktFy5Lic9W8A==
Date: Wed, 28 Feb 2024 10:13:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v4 1/3] riscv: Fix enabling cbo.zero when running
 in M-mode
Message-ID: <20240228-rarity-underuse-4ea0ceaa9688@spud>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
 <20240228065559.3434837-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYUaLBvwPMLmjhGg"
Content-Disposition: inline
In-Reply-To: <20240228065559.3434837-2-samuel.holland@sifive.com>


--RYUaLBvwPMLmjhGg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:55:33PM -0800, Samuel Holland wrote:
> When the kernel is running in M-mode, the CBZE bit must be set in the
> menvcfg CSR, not in senvcfg.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--RYUaLBvwPMLmjhGg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8HYAAKCRB4tDGHoIJi
0qirAQDYy7d+sylmhikfmo2GXMnmIUPyHkY+kHBctTx2ItI1sgEA9XOfdZ8oy6/R
EurTtub65SmrnNrgrVNCv60+b4ljXAw=
=9KZG
-----END PGP SIGNATURE-----

--RYUaLBvwPMLmjhGg--

