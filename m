Return-Path: <linux-kernel+bounces-56521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BDA84CB30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519051C264C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340F76C9A;
	Wed,  7 Feb 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzf2LjNa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6E76C7C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311395; cv=none; b=WKig2bQjfUa9ZQiRioh4L/azebn+/X6gK3stw6QhuS/lcJb5sQzSidY5ws8yC3dGujqHMeJX4Py4XRpvzRh+Xiz09rNas+UGnOhZKSwNSUOLKrS/5vmILjQzFMOVHqIcl13SUgkKetwhwUFKme0DNaCtrqQj3d4FwzZfmYf+jW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311395; c=relaxed/simple;
	bh=/Y7Rp6JLK3KTUfIx/d3yU8gPQzkl6YzLrdpKTC1zKcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea/DuEjYnyXym0L/V3hhSawlEWwC5gaat2Hz02kqVgQxoVfbus9q3LpbDet54JgV/l0rMlVINwJmjZHIHXvXDhC02wb1n4Qy7lCF/X4hAAZt4MaTJr3LdyBQvZUd8XkcP2vspWTt+Hhngi6jvCQSUU/t9pJ8ihv0c+MUpXPoQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzf2LjNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BDEC433F1;
	Wed,  7 Feb 2024 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707311394;
	bh=/Y7Rp6JLK3KTUfIx/d3yU8gPQzkl6YzLrdpKTC1zKcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qzf2LjNaBzADUEIfJKQj8khlEXm7FaNk2pHW1eIb1Dl6gs8Bpn2aDuCFmYckUjT05
	 1j6mKhh2XUkW+4LGNqPg9vEXYrN6URtTgGMS79Ufp0Qp8v3egYXiMIaQFCxTT7uGME
	 i96LxnMx+Hlih/J227Yrs08pZLNh3HoRcWJlU9FoRwrj5SWsbhnDF+jMH/WqLVbBve
	 AqCDAecyL+4aLrvaUW3zyjP+TvTNNEkWzccyBNVzuI2sr37ytdGKxitVm4igJps70U
	 ThwPrDwk+e2IasVtBi0FMDeXT3lC+8hmmsbibbvcVwHlAHCmX470ufOChOHMBHKDJm
	 SPiqN8PFVjl8A==
Date: Wed, 7 Feb 2024 13:09:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcOBH7ip/KMhLYGO@finisterre.sirena.org.uk>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <ZcEW3y0IlEctOYBA@e133380.arm.com>
 <ZcEd2zU/JpeIwn5f@finisterre.sirena.org.uk>
 <ZcN2XMkvqxNnsz5K@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rmfeupVH/TKSQ1M"
Content-Disposition: inline
In-Reply-To: <ZcN2XMkvqxNnsz5K@e133380.arm.com>
X-Cookie: You might have mail.


--6rmfeupVH/TKSQ1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2024 at 12:23:56PM +0000, Dave Martin wrote:
> On Mon, Feb 05, 2024 at 05:41:47PM +0000, Mark Brown wrote:
> > On Mon, Feb 05, 2024 at 05:11:59PM +0000, Dave Martin wrote:

> > > If the kernel is now juggling two #defines for the maximum vector size,
> > > this feels like it may seed bitrot...

> > Ideally we'd just not have the existing define externally but it's there
> > and it's been used.

> To clarify, is this intended as a temporary band-aid against silly
> behaviour while a cleaner solution is found, or a permanent limitation?

Ideally we'd just make everything dynamic, other than the regset issue
and the bitmasks used for VL enumeration we're there already.  Making
the bitmasks dynamically sized is more painful but are also doing
enumeration that userspace doesn't need to do.

> We'd need to change various things if the architectural max VL actually
> grew, so no forward-portability is lost immediately if the kernel
> adopts 16 internally, but I'm still a little concerned that people may
> poke about in the kernel code as a reference and this will muddy the
> waters regarding how to do the right thing in userspace (I know people
> shouldn't, but...)

I think if we fix the ptrace regset issue we're doing a good enough job
of just using fully dynamic sizing with no limits other than what's been
enumerated there.  We could possibly deal with the enumberation code by
changing it to use ZCR/SMCR_ELx_LEN_ based defines so that it's
obviously coming from what we can possibly write to the register but
it's a bit less clear how to do that neatly.

--6rmfeupVH/TKSQ1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDgR4ACgkQJNaLcl1U
h9AoCwf/UzA9RWQOz5FFe8FoxTh4RW10IfcyZsauHYVzBn/Z+KxZldwBeYc/LCnk
gPyi9nj/lr0NPtBUk/BHN0mJdlmIWwA8uq2XE67tXYIrAPwXvcox0eqPJoRDmjgZ
Huaw2kepFzaO1SUdnFoc95jXBOJeFwkoVXrzZxPQEHqK7JUY2q1z1U4S+G48LOs/
Wrxv/U1Uc9HiGvbOnUhbJcGk2QEW1uIMV2sYLuI87EhOf3aGhDN+cVWOhzcMBx9w
QrjkzGdMn5oDmlnKFDCMkftE++y3WGxLiKDo045a85HVyski2lZ0gkwpaGAolbo7
iWKVOfzkWIO7TxNG/PF5BkCcUKAxmA==
=fQjN
-----END PGP SIGNATURE-----

--6rmfeupVH/TKSQ1M--

