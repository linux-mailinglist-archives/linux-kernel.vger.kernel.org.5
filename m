Return-Path: <linux-kernel+bounces-31436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC55832E55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F41C23AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D2055E7A;
	Fri, 19 Jan 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT1e8t+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD255C1B;
	Fri, 19 Jan 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686480; cv=none; b=emP20kqjlBoBx+RwBg1tuRMo1Z8d+KPN5HkHEVPj+fiCcnI3OB9cmDCXfbrrCaLEuQTbh1pOrK23TrZpc0MADMub/QMMznZiXZkOuT0E/tchte5G8pPbNcT0HIif+09rECTxYtx+vsKVCa3HK9yyAKQZhOjqr7i4Y8cMfqVGfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686480; c=relaxed/simple;
	bh=IHTccTwRzqNIFFZ7ye2V9AMKJRjZryD1NVNDaqxcovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUkePAgQS7lHJcheN/KYkBkqmX5pxtm91LeYtklNEzP2UO/DkA8ZxCL0hTeDh8w4gsD/o9wzg/SoS1DAfQEzn7fyym5AlJ4wvz3cDkNsjQyIJXn96AnEwPkgtQG6rT4CgjRo5VSdjtB0khDo+NAzm9WqR0QT+Kpf+T1SHxyj9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT1e8t+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B93C433F1;
	Fri, 19 Jan 2024 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705686479;
	bh=IHTccTwRzqNIFFZ7ye2V9AMKJRjZryD1NVNDaqxcovw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AT1e8t+0PvaMGkRhkP+p0BZ8a+0ud7vqglrmkmuOExdPbHUt4BqhlKr1vvT6FUvOr
	 AZiQqfJb9vCkcTfPlBFo9Ls2CWSwYosc/wLQ6Rq0wWFyf33msbzowscGgksvSVAwuv
	 V04WqX5oUDrMybrAzD+jftzFpEd0/RthrDmRr9S27T73he9gU8B/edEyncy748f81c
	 j4bFgRsNSBaSDZlw74Tk9LzbfxEm/YewTHQLi5sUI3hHpa4Amea2quLbwbTVWFKI8E
	 iFfa0nDksFZ4EzVQbDH8REuLce/h9mABUDsFhGLqD48BV2Pq+EW11PVWfNwjzr/h+9
	 ody7KwVPhdF3w==
Date: Fri, 19 Jan 2024 17:47:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <Zaq1y9XpmzTsXDp8@finisterre.sirena.org.uk>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <Zaqj0V82LD8wu6g+@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PdO/yksGZmL1ku6b"
Content-Disposition: inline
In-Reply-To: <Zaqj0V82LD8wu6g+@e133380.arm.com>
X-Cookie: You might have mail.


--PdO/yksGZmL1ku6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2024 at 04:31:13PM +0000, Dave Martin wrote:
> On Fri, Jan 19, 2024 at 12:29:13PM +0000, Mark Brown wrote:

> > When we are in a syscall we will only save the FPSIMD subset even though
> > the task still has access to the full register set, and on context switch

> (Pedantic nit: "A even if B" (= "A applies even in that subset of cases
> where B"), instead of "A even though B" (= "A applies notwithstanding
> that it is always the case that B") (?)  If the SVE trapping were
> ripped out altogether, it would be a different and rather simpler
> story...)

I really can't follow what you're trying to say here.  I'm not sure I
where the bit about "always" comes from here?

> If the historical meanings of TIF_SVE have been split up (which seems a
> good idea), does that resolve all of the "bare"
> test_thread_flag(TIF_SVE) that were still there?

There's a couple more, but this is all of them in the signal handling
code - I should have one or two more patches.  Most of the usage is
actually checking the trapping and therefore fine.

--PdO/yksGZmL1ku6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWqtcgACgkQJNaLcl1U
h9AnUwf/cnpsqEC3KvSy0DsFTKN0rbF0fDrKRjOyNBrxsRlSeBJVuMRm82vExP1y
55AVWYomuk5PgouebJsPlcOP8+llMA3ADhGOG4Jq1vD2HYZ7mryl9Jm8S1NJ2omK
QeGhhBBbFefKqAhPZNtNCH0YCAWIIYENLPO9AxL8Wc318R5mpoAVq4G6yYgy/IaC
8qxER+wemvizj6fBGClDtCe3QVza+q85fAMkP/5ut7E1MFN77QBYcbKpqL7kBfyO
n6InpHuFhsgF1VlzlyKUC0qEhDEgoQhASDKo2RWIy5aKrBBF5ZpOaDjyHBC6I8tS
cRIuKdmODvJk17W3Z1ODokGNBJopsg==
=vwkD
-----END PGP SIGNATURE-----

--PdO/yksGZmL1ku6b--

