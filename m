Return-Path: <linux-kernel+bounces-62063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAA851AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD27285A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00E83FB3B;
	Mon, 12 Feb 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="napJrBdt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165B3D96E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757770; cv=none; b=GbzvxHNhg/sFPE0mYsYRcw4N1FeNJXaydS8+YbnMeOLN2aMSs+dUtlwYKh2UPBUW3YYUdhMgTIPUO6UHXA7AlLLZ8rEX6D8wKv1gM/IySIF1YRPrZLSOtd5Q/n8Lihshtmz3WotwuwsG1vhulOxRj7hn/RD91U4Y1wUVnTPmKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757770; c=relaxed/simple;
	bh=kNelyaMpoff2eV/oUmYi0oI4uhiVe9RfO18nRr4j+UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbDilWnETzZrBhx6SQWfCmz6y9+L4Y77m8h3MR/KcU4EnuYHUftnTYgFB9UuX+DtZYT6b2huu1w+yJXRsc+yLXKYXbyJy3tAeGs9TgUMvGq4RmWmLSxfir8MOjg3DO2FtdjthOYkfpLljmXEW4WiB34o/J7aRhmSs9rCzkDWIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=napJrBdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC16EC433F1;
	Mon, 12 Feb 2024 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707757769;
	bh=kNelyaMpoff2eV/oUmYi0oI4uhiVe9RfO18nRr4j+UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=napJrBdtY2MVfYL4mRAfcwfHDDTRSCeJO0fOSpuUOEAIgnbzes7Yygc2P6p5UfxIe
	 sUrzFa/Hx6C4lW1kpzmfxGgf/3raK59IV2yIUJ0dNBTOiVz0y+Y6bpekk7KL3ZdiNS
	 rpJOpcGZMdydpRk4i4Vy653sLK4cvdcpyMVQP96TOmRYcjWbrjmgQcclFULL659s8D
	 zERzkEWDfiT6PfFNHOCoPdg8BtTmw9+wP75spDQuIBF8so2RLQtC6FASj0AOwcwA+X
	 KpT2YQije7M7DsgjZl5EbpvIZa1yOr7c1pYXQVUEPKQXaDb8YPtIomy5Jb7a3zSacS
	 jSIL8ytR+uXGw==
Date: Mon, 12 Feb 2024 17:09:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <b0858303-8289-4371-be62-27da98d57020@sirena.org.uk>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <ZcpMabqH+VZv6RCZ@e133344.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jbFy/Os4nITzwxhJ"
Content-Disposition: inline
In-Reply-To: <ZcpMabqH+VZv6RCZ@e133344.arm.com>
X-Cookie: I'm not available for comment..


--jbFy/Os4nITzwxhJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 04:50:49PM +0000, Dave Martin wrote:
> On Sat, Feb 03, 2024 at 12:16:49PM +0000, Mark Brown wrote:

> > -		.n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
> > +		.n = DIV_ROUND_UP(SVE_PT_SIZE(ARCH_SVE_VQ_MAX,
> > +					      SVE_PT_REGS_SVE),
> >  				  SVE_VQ_BYTES),

> Do we need an actual check somewhere that we don't bust this limit?

..

> Userspace could specify vl > sve_vl_from_vq(ARCH_SVE_VQ_MAX) in
> PTRACE_SETREGSET; I'm not sure exactly what happens there.

We already have validation against the actual enumerated limits for the
system by virtue of setting the vector length to whatever is specified
so we'll limit any overly large vector length down to something we can
actually support and then reject an attempt to supply register data if
we changed the VL from what the user specified.

> Since ZCR_ELx_LEN_MASK was changed from 0x1ff to 0xf, it looks like the
> kernel itself will not generate an overlarge VL, although it feels a bit
> like this guarantee arrives by accident.
> Could ARCH_SVE_VQ_MAX be based on ZCR_ELx_LEN_MASK instead?

I guess.

--jbFy/Os4nITzwxhJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKUMMACgkQJNaLcl1U
h9AQ4Af8DfUN/JUR9xzcRi0ChS2rH/IdTTT/8uHAChzJ4PnIInlgEj1ZaxsM9s4y
oyqCjwEekMQlsQ3BE9cZRyn38fDS5r6KToTkfZnjMAWDU6YtXvVdPBIwZ8RWospt
+TtQu4NOV6ts8cUd7wNXQeFjn7aPTLuPfHnYUFM4XdAkF0501XcVWm/UT02FV1q/
Dpyoa2LlMpNtiDw4zrbZ3G+7BlOK/l5qqLYFw4Xb0IDPMxv8QvsI0U6zikhWj0y8
0eI9xyFJVU1StQVo1AI2NGWcGGDld4RwCPLtBuUoacf+T6Y43crcZc7/Qmx3YC+V
EeHbf/txRxdjT4EVbvxaQrAcE9O+AQ==
=vwAN
-----END PGP SIGNATURE-----

--jbFy/Os4nITzwxhJ--

