Return-Path: <linux-kernel+bounces-44861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F784283E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260711C247C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356282D95;
	Tue, 30 Jan 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdUwFC7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EC823D5;
	Tue, 30 Jan 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629327; cv=none; b=Rj/nkee7j9rku20y2Ek0GorNaNpY5PYuqguW3LvaOPzQV3Pbn/agS2sCYLqhtKAHc8i4774lrHobvvXadSs7nVBb88l57EElYI1aWEw6W1dfbwFIBmvz7WhPCP/TVT7iSQcznUKSoFcm7A+wxWlr1k+eK9M2BfzF7qwtuXO3eTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629327; c=relaxed/simple;
	bh=K9ilCI4Rt3rm9gX90CpAUoo1upcRz8+OttanBkZjGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhmXdWVfyCzMiNGto8e35I9Ev57CnV3hUUvoyKCBMIb4Kwa4hwkCZ0GERTiEhdQ0Fz+GCB3+BVvySLEclXzJEucG1TdCtBgVdgGmqvUiut2eT+znlwSdNR55f1BaFyqLSKmHv9v+kBcDbG/WsUKVXJ/yyLbsxU1wwwY6opdx5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdUwFC7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D83C433C7;
	Tue, 30 Jan 2024 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629327;
	bh=K9ilCI4Rt3rm9gX90CpAUoo1upcRz8+OttanBkZjGIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdUwFC7zS1yWxDNbi6ul7ioKdZ9jQvFgeF+RS4fuhYu0mR9B8/QYUURgLB9lZklwN
	 D6VlTSU8W9v+EpVwqVNgDleoRlWOL+3HFfQQam597ipkOtllep1gFGQs5gvztR06eW
	 SUaX955QD19uj8xZ2fdp7fBSD7BXz/WlOhuOJmMOdlOsLkCc3rwN4fPFt0Ok2eVGrq
	 bEns3NZwFPw/maDpfqILC5Um8lDr0YdK05rawpe8iXcZgN/cmPUU9UWQcZfumK3GVA
	 su5CvJ/a8M89v4WnD9C6gCVwu93B59cskCywuQ3WvuskKYdtPFdcYN+BN5i0+MKnWo
	 O2Hh5UBtlcGAw==
Date: Tue, 30 Jan 2024 15:42:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <19c46e3c-c6bf-40d0-8d58-06516d9dd878@sirena.org.uk>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <20240130115107.GB13551@willie-the-truck>
 <b0ed6698-bc65-48fb-96b8-0cd077448196@sirena.org.uk>
 <ZbkLY+gz7Az1OgNK@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gCnTtxSCeQg0qyr"
Content-Disposition: inline
In-Reply-To: <ZbkLY+gz7Az1OgNK@e133380.arm.com>
X-Cookie: 1 bulls, 3 cows.


--4gCnTtxSCeQg0qyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 02:44:51PM +0000, Dave Martin wrote:

> I think the logic is that any ptrace call that can access or manipulate
> the state of a task is gated on the task being ptrace-stopped.  Once we
> have committed to deliveing a signal, we have obviously run past the
> opportunity to stop (and hence be ptraced) on that signal.

This seems to be all there, the core ptrace and the signal handling code
talk to each other and ensure that we won't try to rewrite the state in
the middle of signal handling so we should be safe here.

--4gCnTtxSCeQg0qyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW5GMgACgkQJNaLcl1U
h9Dnmwf/SHPLNxtI08Q9P0nCm/6VzM/IFHTnckNtHAY8LCQ0FRHuj9g6onqnusDI
8UOpeTzVaTMm/ZP1w+8DaGzGob0e91EdaX2vh07aDEXkWCLxU3qtqbi3U3TRSws2
F+NLZ5cL0NOcKh0v/KLrFbi+W+J8aqGTaAZgTy+xzDfkCT8XBjfIY7WetfNg+bP8
1qJN2IJD+hktFW/6UHlC6CS3opanMbckIEa79Fr+K3+Ju7AeGim0vQ6lkfyNcsuW
Qs3Qr89FDX76WSDa8cKdkx12RpDAQWf8qZRA21fpzqjcU9rcq0NXRIAbe0wzXDf3
5el0OMaq6kteT/w1XyahKRRPthsDZA==
=NMhg
-----END PGP SIGNATURE-----

--4gCnTtxSCeQg0qyr--

