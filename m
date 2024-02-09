Return-Path: <linux-kernel+bounces-59744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CEF84FB28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA9C1C2369A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0507E770;
	Fri,  9 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE2vaQub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE053398
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500411; cv=none; b=Gll39vLuNvS8Yc1sMcPC35vYXPKt+IpuVnJY2rQgx6AL63dpKBlkBdfsFn14J/Jgpocq5tjej3jEgOFYTpxiEo9I2uXqafFGcPNvaHBLIhZG8+UqUrV8JKXisFE25dCBF+kOpdZcnPDBVy4qGP+TijLBVCASvl/ReZ0N+X1dDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500411; c=relaxed/simple;
	bh=uNQQdtH6UFZLTLAbeZXvxiavQgfNt+/6JYRGrZdz8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGwdgbuuPm3XwIHqUcvfs8r8Q2ffySkHw4gmGxFacxzTsYqRUMWwuBduZOqOSUTnwsCXQ6uE6FVWEwNDn+ISUWj7yfRSHgiq3X/qlQwQWPYA3Znve+Vtep+Vy2quAI0BOuEkRxevoOAI9MkUCCZ3PHiIaeWL7vOIcDjp5pzzTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE2vaQub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EF6C433C7;
	Fri,  9 Feb 2024 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707500410;
	bh=uNQQdtH6UFZLTLAbeZXvxiavQgfNt+/6JYRGrZdz8j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE2vaQubrJi583g3SJJKA3b6Ghlhd5vr0BbfGQgr7l4ks56TXGCW5QAsUfuX/OPG9
	 VglhX8BON3RISzqRCNlx1ft+mq9zDb7NqVF6ux+qhAdAyd+wfW/XcpJ7I8s0X5SI/G
	 3cMHiOT6f5h8eKDlxdndbdWIg2yMB54qVD+Cnn6nMjN3rWa+nq0yWn5UuaWr66c4aa
	 3jNrWI3S68HsBvXhX2TrLdzMUV3AQTs40Bp94Cg7irN92nm6dRAlIA/xwPiVVokUi4
	 lnLK42qiPC05UPzKldac8wkp85BfwJryjhj6sdpufZ3ZgV/tZJJUFlGwFWKP7Vawkn
	 O0MhWwNjf8J3Q==
Date: Fri, 9 Feb 2024 17:40:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <ZcZjdnchVblj4iP+@finisterre.sirena.org.uk>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <CAD=FV=XupbtO3_+P9=XO26vH_5nALSSLZZHZywPSR_hQsWxM0Q@mail.gmail.com>
 <20240209171155.GB25069@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bt/WGUaP7bIvKfoi"
Content-Disposition: inline
In-Reply-To: <20240209171155.GB25069@willie-the-truck>
X-Cookie: You might have mail.


--bt/WGUaP7bIvKfoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 05:11:55PM +0000, Will Deacon wrote:

> I can pick this up as a short-term hack if it solves the problem for you,
> but I also saw that you posted:

> https://lore.kernel.org/r/20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid

> to fallback onto vmalloc() for large allocations.

> What's your preference for a fix?

We need the change kvzalloc() regardless since the ZA regset is just
over 64K which is on the big side, I do think that reducing the reported
regset size is useful as a fix independently since even with kvzalloc()
it's still pointless and rude to ask for such a big allocation and we
might reasonably be generating core files or dumping crashing processes
under memory pressure.

Dave was looking at sizing the regsets dynamically but there's enough
going on there that it's not great if people want to pick it up for
stable.

--bt/WGUaP7bIvKfoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGY3YACgkQJNaLcl1U
h9C/VAf/UtPKLS512P+gFBhbamgPYl2plAY+VsbTOvsLsMDb/VU58mlAJG7XYakP
9JJfei4c2vAm6+uN00bqGQmmYQtTG+NPH0ZgNbMOcwqVHL9xlJgeBWD7OSgnHZVk
VakcwgnF9mxv18L2+fMcKKe0a6GzXf7oPyfncbfoWMWqMcUDGNqkCHXs4psUuYav
/rYOmcuS90M5oMylI9b/gSDpiYv2+Xh15SwghD5IB09weilR5mdHurHgEkItVVi1
ocxqZKd/n+f9nkyjsJ/duyCp71hwrF0MERLMpIBMaNsiMH2IOnQEROC8Z9uhWfL1
cRf+Al21F8Myp+cKA5CZ9jybWPsWnw==
=2tur
-----END PGP SIGNATURE-----

--bt/WGUaP7bIvKfoi--

