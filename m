Return-Path: <linux-kernel+bounces-59729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57884FAFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E6D1F23964
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FA7BB1C;
	Fri,  9 Feb 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzZBu2fD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB57AE7C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499561; cv=none; b=swchSaWXpRrqnOMOLEoYNNoO0C1URKPODf2R67n7l1LMq9vDkaSTZ78o1b07CUHDGo6wRee9Gs6eqxb+MBCpqD+ojQNthMXP4lFyDVcYq5MOiyrqqwqSvTTyy8ru7CnYuJaMJRAgf9xP3VLSOdVFJyj9cEuabEnPe/xGLL8sFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499561; c=relaxed/simple;
	bh=SX7R0k7n31rJzoAWZU1A+fnnfBJtFHW537yR+c++CoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2/MoUIC9WebnKetpoYlY/t5PXdQ5IwP1BwQLUjHyBruAb9HM6kmN9ppFvt/b7QstCVEOqf0H/BOyZ/pdiCgtY7q0iAJkYxUGIo8LGcmujrL8g0RJw6nTdgAbeaH5VlpoXmga+Tq7nVXHK3r5vJj0hg26FAyvRp2urWjTk8OacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzZBu2fD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9569AC433C7;
	Fri,  9 Feb 2024 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499561;
	bh=SX7R0k7n31rJzoAWZU1A+fnnfBJtFHW537yR+c++CoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzZBu2fD8obFCQzCEPEZofQwwlxFx36yXdrYgEmh6XN8j4P8ZEcqzJuS684vj9Wib
	 8FtIf3KH0jwxFDUZKI/BpEcsjo2rUwJERs2DbRHvqz2I4IaSKTynhMPLv/WjGlQJBd
	 OxTEyhnm0a/s1+gzSDLNWoaevEDHlCcYGHF/NhvW42A1ivV8bVV1Ajh2VNBcHxdW/k
	 JGqrkSfRDtVguloFAM9FULkUOLkv/BP4mTzZsSLrO5KSiVLda+8h+w9+th033TF5K3
	 A1C4N+Tjv+Kw/i3iKA3ja/G3GdxW6GSo4zH7MAK8EALOrwKzkr/wa2/uEH1BFFjGuV
	 kaxi2ShJJsFXA==
Date: Fri, 9 Feb 2024 17:25:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/sme: Restore SMCR on exit from suspend
Message-ID: <ZcZgJaZy+57ERBnm@finisterre.sirena.org.uk>
References: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
 <20240203-arm64-sme-resume-v2-1-a1fbaddc4425@kernel.org>
 <20240209164648.GA24829@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgNJdvOI4EBBtGYb"
Content-Disposition: inline
In-Reply-To: <20240209164648.GA24829@willie-the-truck>
X-Cookie: You might have mail.


--cgNJdvOI4EBBtGYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 04:46:48PM +0000, Will Deacon wrote:

> Looking at the other places where we touch SMCR_EL1, it looks like we
> always use a read-modify-write sequence. However, doesn't that mean we
> inherit a bunch of unknown bits on cold boot? I'm basically wondering
> whether we should be initialising these registers to a well-known value
> earlier in the CPU init path, a bit like we do for the EL2 variants.

That'd be safer from a future proofing point of view, yes - we've got a
similar pattern with ZCR as well from the looks of it.  I'll send a
separate series.

--cgNJdvOI4EBBtGYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGYCQACgkQJNaLcl1U
h9D5bwf/QRbbYQHO+ijbviMUq6i2yZEnISNstcxLQJZc055HOhvmSYTDpZJu+1sE
WTGEPvKgRLQ4/B8M8DmmWzXMVn9MtHLsuTbgrV4Aa8ipmCBWKLxhzlLyhVEl/i3Y
d+i3NPvhAYfaCoteaQ/0XEn0YZsqOyengxmGxKLHLpGU1x7pCU6w/c8kJxWWtiNp
yUIXD/yfrVkNDejzDN25m1v15seBALXjc1sO6cpt0ARYGue2XAa8qSKVcMQuG1hh
Khx+BUT0/9FjuH/TZZIXlyhtG8OJReN/sT81hWhr5bdYWTlImr3e0jtqfoIH081t
UpMe9g44ECHYky/i2CikaNahID6Y6Q==
=Os+q
-----END PGP SIGNATURE-----

--cgNJdvOI4EBBtGYb--

