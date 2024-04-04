Return-Path: <linux-kernel+bounces-131782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15860898BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0AF1B2577F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A012AAE0;
	Thu,  4 Apr 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf4ZmMZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15461D531
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246583; cv=none; b=W//ONCRMRBxp2t8MllX+NCjrZMm7bJPu2TkF0/4MsFeVoCw8GsI8j+nIPKhiikQBOQiJ7ifnhAcdZhAe4IsYvqgJXYkI/NeaEloULbItn72xVJ6RT95QdoeyE+QYY+f5xXshSRfjJTWXTrGskloyptx4RxbClwc0X7pj+1tMdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246583; c=relaxed/simple;
	bh=oygxtAYgo7ybilPD4TDbXauKq+YBViBtgvaImPWLI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG2Czn1LNW+FDZrAqXCDGqFrByfkzkxKaUXMfZWfFnShqFDqivKo2aHHNqdZwLTFahcY1Gf7fxjvofXkdzKHbqN5RJ25yRWlLrI6TL6hVIyF4Lnm1DxbpQvuygfqXakQ3QxbNZk92S3NXz5LKpsZS/9gmDymlfDAbwSyqaeb0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf4ZmMZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46023C433F1;
	Thu,  4 Apr 2024 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246582;
	bh=oygxtAYgo7ybilPD4TDbXauKq+YBViBtgvaImPWLI7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kf4ZmMZyEcoI29vi+4BvRfIYFMyEkLSITJ6nuExiwuz9p9HLGL9wSTeuO9kqFQpcr
	 onSSOu7kIaM8FQmm+0F9v2c8e1scpXxOK21tRZySKPrYLj488vJBEX6eYiO2kgviiW
	 9zAIbOHctgAVYhN6E3prvcefWdcyqA+tmLow7aPUVD2ocaJotmPnmoMmDIuvhT/Svf
	 +brI59zDzju6Sj6p/lkZiIwssGNY2rqoSbQcz/ZxZZYq4LX+4FPTXfYMThwAYZAunV
	 syvtrFymcGWRUWQWrrLzEu3Gp1sYxBrtlhyQ0iFiXr/Ej/YBAiBCtiONzWuFjOxgGk
	 BqFSPgaUfxN1A==
Date: Thu, 4 Apr 2024 17:02:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 2/2] riscv: T-Head: Test availability bit before
 enabling MAEE errata
Message-ID: <20240404-drown-wronged-bfc421e412aa@spud>
References: <20240329121414.688391-1-christoph.muellner@vrull.eu>
 <20240329121414.688391-3-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wpMuYirtpZPsx9jO"
Content-Disposition: inline
In-Reply-To: <20240329121414.688391-3-christoph.muellner@vrull.eu>


--wpMuYirtpZPsx9jO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 01:14:14PM +0100, Christoph M=FCllner wrote:
> T-Head's MAEE mechanism (non-compatible equivalent of RVI's Svpbmt)
> is currently assumed for all T-Head harts. However, QEMU recently
> decided to drop acceptance of guests that write reserved bits in PTEs.
> As MAEE uses reserved bits in PTEs and Linux applies the MAEE errata
> for all T-Head harts, this broke the Linux startup on QEMU emulations
> of the C906 emulation.
>=20
> This patch attempts to address this issue by testing the MAEE bit
> in the th.sxstatus CSR. This CSR is available in HW and can be
> emulated in QEMU.
>=20
> This patch also makes the MAEE probing mechanism reliable, because
> a test for the right combination of mvendorid, marchid, and mimpid
> is not sufficient to enable MAEE.
>=20
> Signed-off-by: Christoph M=FCllner <christoph.muellner@vrull.eu>

Seems ideal to me, I'm guessing the QEMU guys were okay with emulating
the CSR. I don't see any screaming at the very least on the patch for
it.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--wpMuYirtpZPsx9jO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg7PMQAKCRB4tDGHoIJi
0iaGAP9p8R6uT9Dq2VFAZHEcMfzw8GOIp1Ed5vkewkKknFDwcQD/dslVWUtYecpf
gVVa5+8uAg5289fOiPhqPgRKomQtwwk=
=NeFs
-----END PGP SIGNATURE-----

--wpMuYirtpZPsx9jO--

