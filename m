Return-Path: <linux-kernel+bounces-94434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D3873FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE078B22D58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70994140E30;
	Wed,  6 Mar 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETw2EC0J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5E13E7C5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750131; cv=none; b=bRNCP15zhIsApFo5a78VHb8Nkbdrw2q3bxfexd+hhECvp4SD4qhy2lZ/zFISC6e0qtS2gCHK6UjYyX1Hfhmy4l8EeisgYiKaC1INrIlugoUDZTMZaUWmfgLvcLOX990z2giS1RQws6n0g1em1p7ObYdtEwnkbVKUKd8G8Yia418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750131; c=relaxed/simple;
	bh=zmBinXKZQKNHCz0LtnMkq9ehI1d7BPLGv1+fCXX2m6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cleV+H7zZCWuiLJI939m5QdRmxvUnh/9/kjZXKcv/Cri6HO1tij1omfCmdbq8MLCUbOqPEKkSigneG2f7YTEXES+0UyiluVg93a4CQY451eqRKKtgFim9tbT5Bb/DliBhM32AavDyx3512WjzJH5u9XjL1qLjO/YauCwUpoafA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETw2EC0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5331C43390;
	Wed,  6 Mar 2024 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709750131;
	bh=zmBinXKZQKNHCz0LtnMkq9ehI1d7BPLGv1+fCXX2m6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETw2EC0J/ohU7u0K634Esd3Evhl2l9bJFPOjSMc68sb+83MbI/IApHw6vVAjo9tU0
	 r+OEkxX32lwhNtb4ksxN2IAtMLoF1WKP4JN88zQPH6ZCCJeLARyyhwzWqniFmnAo4W
	 p4Av+eD8DUBbKSHzdAHTpWYjLhSuQs8+HjugMS8/+2/JbhhgNDTZLPoc4VMbbVCLNo
	 XqaVQIu8+zFWNCHTHngltJoscx/5sdUc/956vel7Aofay5YZJ2flIowHOZ3KS6Dj3f
	 OmGO4frp+PrVt2Q/3wbrnkoxMRvIkOoTkuFirR/PCElp0Te32+IYfamV9tn9IpvmKN
	 25u0UK9k+2FmA==
Date: Wed, 6 Mar 2024 18:35:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] riscv: Set unaligned access speed at compile time
Message-ID: <20240306-football-payday-8c9fa3e17ee9@spud>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
 <20240301-disable_misaligned_probe_config-v6-4-612ebd69f430@rivosinc.com>
 <20240306-bring-gullible-72ec4260fd56@spud>
 <Zei2wrx4oFB5lj6i@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t+tSty/uiOvKCNKB"
Content-Disposition: inline
In-Reply-To: <Zei2wrx4oFB5lj6i@ghost>


--t+tSty/uiOvKCNKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 10:32:34AM -0800, Charlie Jenkins wrote:
> On Wed, Mar 06, 2024 at 04:19:33PM +0000, Conor Dooley wrote:
> > On Fri, Mar 01, 2024 at 05:45:35PM -0800, Charlie Jenkins wrote:

> > > +
> > > +choice
> > > +	prompt "Unaligned Accesses Support"
> > > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > > +	help
> >=20
> > > +	  This selects the hardware support for unaligned accesses. This
> >=20
> > "This determines what level of support for..."

Reading this back, s/what/the/

> > > +	  information is used by the kernel to perform optimizations. It is=
 also
> > > +	  exposed to user space via the hwprobe syscall. The hardware will =
be
> > > +	  probed at boot by default.

--t+tSty/uiOvKCNKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZei3bgAKCRB4tDGHoIJi
0iu0AQD87A294NjKr8yzgLFZSsbEa1a8agxZE11Zt8Rf9X5hKwEAvdf9re1vk0l0
wSoxYqqmGV1l4EMCzZlnHdClqrtCiQ4=
=9lC8
-----END PGP SIGNATURE-----

--t+tSty/uiOvKCNKB--

