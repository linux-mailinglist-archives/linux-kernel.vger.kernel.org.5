Return-Path: <linux-kernel+bounces-125482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E998926F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B561F22C50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55F13D62A;
	Fri, 29 Mar 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UTgakdsr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38A812;
	Fri, 29 Mar 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753059; cv=none; b=OG4WsOYOc9J6oyukw4AnGj3dp3Fau/6O+mjMrkdqySVrqNtEgYKXyqxc+jYLMfsewc48vIeIAU9PaKfV0lEX6YtiMqJp23smAE1Ov95Y9GABPjjJDs+6eEoF9z99t3wow2yMojOda65fnU/928+GpGTRE3SsGUg9WxTrLpjqvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753059; c=relaxed/simple;
	bh=chl7iEqHAbv3XJsJqUtQPaCHiV/EOzL/RghiPGmtOEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAGEZZNHLV9Vrus0mt3rZZ8EkBlbJC4vi5WfKY5KBkMF2CuF+L9MRGE03j9Dse7h2fD33YyDAvzNnE/P6+BMAMQBhjgEBrnpHl/FPiHPHg0oqxmwNg2VoNZbqWeRKmWxoh8ud0t4PWcVmRSG1YPSlA1d1A2IQqBDPVydebcSFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UTgakdsr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711753054;
	bh=qEL1ifuANFv5AmN9R/0BEzKfumJK07AKLwgE20hwRUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UTgakdsrR3EbkWZLxw5KUOgroOkjpR7cLiR+BLNXzEGLXkJ3WKQ0QikVSeDfQmwra
	 /8z7Z2YsSy/rRB+iS14lFS3IuN1q3pZiEBHZDb9NFiRA1t6ex0UiTrJ3Z4U6Chv32f
	 sGCK5r2VHypFTXgLMaYKp+U4LDIvReR5svJwFNvERAYDDIcjHa66z8t53XWqQhhqSJ
	 GQi4GdHYW8c7nYq1taK/7Ey5JUnt/k5x0BTq+yZmvJpxAOmlTp6/CfRCrE2SFJa5rn
	 9wJceNvvkRjDU9wUpGSg2RFjrrkwHSO2GL96j29+o+kqnmIA+4VwE7wwW2iHY20+gD
	 v6T0z/zy3372Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V5wlx3ts5z4wc3;
	Sat, 30 Mar 2024 09:57:33 +1100 (AEDT)
Date: Sat, 30 Mar 2024 09:57:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Boyd <sboyd@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: Add clk-fixes branch to pending-fixes
Message-ID: <20240330095732.644ba298@canb.auug.org.au>
In-Reply-To: <9ddf393a481f2caf3cdcb7b1a9e5c80c.sboyd@kernel.org>
References: <9ddf393a481f2caf3cdcb7b1a9e5c80c.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2jX3G98RUqKjTWcvsvue9nQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2jX3G98RUqKjTWcvsvue9nQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, 28 Mar 2024 18:06:43 -0700 Stephen Boyd <sboyd@kernel.org> wrote:
>
> Can you add the clk-fixes branch to linux-next's pending-fixes branch?
> Krzysztof mentioned that it wasn't in there and some CI uses that. The
> clk-fixes branch is always merged into the clk-next branch of clk.git
> and usually it is fully merged into Linus' tree before the next release.
> I accumulate clk framework and driver fixes on this branch and send code
> from here after the merge window closes.
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git#clk-fixes

Added from Tuesday.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/2jX3G98RUqKjTWcvsvue9nQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYHR1wACgkQAVBC80lX
0GzM4Qf+JK0mff1R2HHO4C8kWQxHj4T0oKZwFkdh5F6QRPDtHQ1q25RN0xJSYWFw
EqP6uBT79acZzKFEiI9i0+gtqbp4rhw1wQSNzuF1wO/c9nvdwI/0TNbZdYFqjlKA
nglA5WbshoBvWCYygXhCDy5DRh5wr6ukNuN2e5T4r8tEsAIjw5Fq2nNcCKFbDDjh
h3vlIGo4ekzXUJ0NI8vlQfpJFtuTHqPG8B54mhYpE+QJomV15yhKGas+jMcAMHiD
CKiKMU+fhuGog5C6JDEG+TFYHc8OOBrxpwJenfONDy97osLWHt33OfD4nWE5haFu
PNnPZ2g4rK0miuXKNfflWbEAKyLjkg==
=uy3o
-----END PGP SIGNATURE-----

--Sig_/2jX3G98RUqKjTWcvsvue9nQ--

