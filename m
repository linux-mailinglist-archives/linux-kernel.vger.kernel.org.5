Return-Path: <linux-kernel+bounces-91174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D9870AA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C915D281508
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A37993C;
	Mon,  4 Mar 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g07YAk8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90278B68;
	Mon,  4 Mar 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580430; cv=none; b=h97Xu3bfY69A8CTkdme+816SPGTXatDRlPkkICSFPPVB3sH3mqrFVn3MsT3EkfBgLT5pp+haY8hoGqMUxV4OixvjbSqWj+HAe6EU0D6/whYmkAllDGgaZseY8S8tkA8XQL7Wl0r/Q78ZgGsdf4JDGjYojiylfDsnXsDghhpHDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580430; c=relaxed/simple;
	bh=NRGBFSK4UAvrZUKX4v3ipPB7T87gQNkUmQIBQgtrHhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THBdhEOc4ev2iZxY1pWTRhw8FqlFqIGk2+DHCsQZwsoh3tw+Ux1Gbs3vjuh0QVe1o58/xdTiswiowkbwOIsjxIBAsCr6DZ4yWw8tkx6n15JEW1onvqV/0jwFfOvN/uxqBZoWeGd+4QPNvQsHtVNqT6AzAskJv8PCE80yGkKaunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g07YAk8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40826C433F1;
	Mon,  4 Mar 2024 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580430;
	bh=NRGBFSK4UAvrZUKX4v3ipPB7T87gQNkUmQIBQgtrHhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g07YAk8CLZHQ43AdB8ZPf6pYoLYryNyswI6epfxNEN0+JvDkWygaKsd2i/tEN5Q+p
	 QGjHCr06rpUacf6XFj7+6t6FRGCCYrnme332ZfXtzeIJdPyJA+B2WPhSJzp8NRTj2r
	 pfTFb4CiC9hCzYzEsvBBoXtuI6vbmSIuHCYXcRj/Ocp0iA9XDh53h8W/WVq7z0yPK8
	 3M9+2zjE5oxnmj/zWgfUVE0m4aHThHS9SryjJ+q2360QcRuAyBclpGVISvf1ua88t+
	 1xjL5HassavRpM9UTiIfZLsusZfJbl6ZujRp0KZaZ8HEoU5cfxXvDlPKstVS3LA/oQ
	 xmU2IRo8La7kg==
Date: Mon, 4 Mar 2024 19:27:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
Message-ID: <20240304-makeshift-bakeshop-26c9611de1a3@spud>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-3-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CGU1t6lbMj/vUiqU"
Content-Disposition: inline
In-Reply-To: <20240229121056.203419-3-alexghiti@rivosinc.com>


--CGU1t6lbMj/vUiqU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 01:10:56PM +0100, Alexandre Ghiti wrote:
> For now, we use stop_machine() to patch the text and when we use IPIs for
> remote icache flushes (which is emitted in patch_text_nosync()), the syst=
em
> hangs.
>=20
> So instead, make sure every CPU executes the stop_machine() patching
> function and emit a local icache flush there.
>=20
> Co-developed-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

What commit does this fix?


--CGU1t6lbMj/vUiqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYgiAAKCRB4tDGHoIJi
0qjkAQDn1f/dT64PtnCiJNs8Qio3UgBL19K4uIcjx/5UwnIPSgEAwwKcIIoDYm3r
ATY6C+CwtQiaTrYXHsoo0LaLIsGgCQ4=
=Ko4a
-----END PGP SIGNATURE-----

--CGU1t6lbMj/vUiqU--

