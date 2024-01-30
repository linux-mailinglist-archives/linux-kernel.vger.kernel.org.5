Return-Path: <linux-kernel+bounces-44775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BFC84273D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494031F2A2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD97E771;
	Tue, 30 Jan 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy0O/93W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403DD7E573;
	Tue, 30 Jan 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626430; cv=none; b=qp5jytaKTesCZ/b3I/veSTn5ksvrQoQ3LhnJ3RM+Z8YUicj9iFAZX3w1+WHFF9FUcecaGgncWeGnTGo9aDtPPH4H8B5UeSEZorPb+RmRlvTrRJkKr4xBJU1oepmmoOJN7nMa5Iu2A13u3PGdnl3jIDLs2KtmWeacG2OpwAsvQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626430; c=relaxed/simple;
	bh=N0iog0ijV4doQ+YIYxF95qcClBn/v7yYTr77/Hyg/Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLAay4EX3ylu6GVGWRTyFe9PaN2EI6Dx82kjRgZ2Gn4WxeZ9vQITuzJV57ikOpTt9mn45TQtxy6qniuwhOJwvYkvZqcDI1N7Yw06fE0PsKzu4ZymoxfQ5KjEkoF8zAF5PYkw9i1pjRyPQcLUUMQrGXoEWTLE1Iz9ePSjXZN+2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy0O/93W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6BEC433A6;
	Tue, 30 Jan 2024 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626429;
	bh=N0iog0ijV4doQ+YIYxF95qcClBn/v7yYTr77/Hyg/Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jy0O/93WzYQo2pGkM8n7++wg0eclSkOqdwO9rrwaziGZW5CosXPumVpSamhyU7n/+
	 f4XflTKAxKDN1cLHYJng3AQmdbaUXgcAEhBzwjsEsnZm5Z170gQi+YiTnsoTxffDOh
	 w54exNU6K8YaUbBE1l+XXmnyp4MRDtFJ5e/QJOOyAoD7F+WLsIiPCPUfcLG6YtBW5m
	 PPkd+QznI9O9km7Y9NIMTtmj0B2w94VUejpaNwW/hnS5S+Z856APRIcO103cG0PPnc
	 IcJixesAfg9hsqTzFbGkOl5gN1ehloWlziAvWB5mNh8S5LpbarFD7N2WFnCa6Defy1
	 L4WHi1gmzcqeQ==
Date: Tue, 30 Jan 2024 14:53:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <7027bd80-1fea-493a-83d7-ffef4e548f08@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="W+TBP/Hhe0/VKR6a"
Content-Disposition: inline
In-Reply-To: <ZbkLY+gz7Az1OgNK@e133380.arm.com>
X-Cookie: 1 bulls, 3 cows.


--W+TBP/Hhe0/VKR6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 02:44:51PM +0000, Dave Martin wrote:
> On Tue, Jan 30, 2024 at 02:09:34PM +0000, Mark Brown wrote:

> > That said if this is preempted ptrace *could* come in and rewrite the
> > data or at worst change the vector length (which could leave us with
> > sve_state deallocated or a different size, possibly while we're in the
> > middle of accessing it).  This could also happen with the existing check
> > for TIF_SVE so I don't think there's anything new here - AFAICT this has
> > always been an issue with the vector code, unless I'm missing some
> > bigger thing which excludes ptrace.  I think any change that's needed
> > there won't overlap with this one, I'm looking.

> I'm pretty sure that terrible things will happen treewide if ptrace can
> ever access or manipulate the internal state of a _running_ task.

> I think the logic is that any ptrace call that can access or manipulate
> the state of a task is gated on the task being ptrace-stopped.  Once we

..

> I haven't tracked down the smokeproof gun in the code yet, though.

Yes, exactly - this feels like something that surely must be handled
already with exclusion along the lines that you're describing but I
didn't yet spot exactly what the mechanism is.

> From memory, I think that the above forced flush was there to protect
> against the context switch code rather than ptrace, and guarantees that
> any change that ctxsw _might_ spontaneously make to the task state has
> already been done and dusted before we do the actual signal delivery.
> This may be a red herring so far as ptrace hazards are concerned.

Indeed, it's all about the current task and won't help at for ptrace.

--W+TBP/Hhe0/VKR6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW5DXgACgkQJNaLcl1U
h9B8Jwf/bbGTk8dY3wv6i5yLgXvA8OX0zJOWfZewnjQeBtwiZSZLA7nl0VKHB4u1
B3ZpNoFsiFy3mrLJnR3yRXZj8UttcAuGEYM4YqYXik8h0Xcx44kIjlX93iANunfp
X1+WyrOXFaY9DYv3IOnn2YdBb8ssafW3CDTTs7F5MHwf4biheXe1CuGipJHGv2nb
DH2tlhGWKszWBl6tY0bl905s0Wvw2ggNM0lsFFheBb8IPd+idcNSldYMNU09yIae
9kIgQ6XgCSQLasL5PUhBBz1T1QDnY0+8iqkZceEcYqUYZjWM+v/cBJnlrR1m3C09
1YGX+yP+cL8f25SHy4eHhcbUDFN2jw==
=eCS8
-----END PGP SIGNATURE-----

--W+TBP/Hhe0/VKR6a--

