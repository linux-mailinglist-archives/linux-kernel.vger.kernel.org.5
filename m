Return-Path: <linux-kernel+bounces-103259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578787BD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362D7B22B42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3EB5A0F2;
	Thu, 14 Mar 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4uEUl3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491F266A7;
	Thu, 14 Mar 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421124; cv=none; b=Vfjor8cYRgaRy02dKaQm1GhaGcYDcyPJRlMk34Vx5yjGVNnpCGPsxJ49gPhpOfK1wlE6NqyJWUXq/jf70578dPjFKTJPWR9S3VC4fZGFu/WKUnjpJmWGI10Vp9j7za+gq/V2gl9X22Sn75on0aBaZk39VwmThOaFrlQ8mRsToAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421124; c=relaxed/simple;
	bh=4Inq3wdUzCbfhyMzyuv74K/cB9sWIkWaxTOboSM39Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edBLBCoORCHbzK/18iheCqzeYpHszlW+Bu+Kh9OD2P1L4w3qHVAokWRRTeJi+tJB0Rfb3mNGmdWDJCiEZS8u+ZRPSAXsJtJZ0ytJqLOzVHp+XAfeQCmvMqs4hPp3tOw2J1nfBV7xO00IO+ra4KhYCQWgOR5CilxFT5TMwbR3f30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4uEUl3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331A8C433F1;
	Thu, 14 Mar 2024 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710421123;
	bh=4Inq3wdUzCbfhyMzyuv74K/cB9sWIkWaxTOboSM39Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4uEUl3VnnQLqFIhHQ1slMufGpKT8STx10pwcDfYM16sE5U168Ei7zN6BTDhhenri
	 k9tzCNkmWDjrczrPVAyk08I9TZm87/tGokOj4pRGYjO319WDGwWP3MIkAY4vlRtD+p
	 69eqSCex6fHuKHnFGWXX0xl7qmMS0Zt61OxU40Ls5D1XSEq4oovI+6XtAAnn6ktL34
	 dfMb6tMhLQS2Wli8Njrg8vFDe3cs5uArhs5dQNLiLkAob8JFxgZoU2+sxW4DB75ZEQ
	 LvBzutdojpWSScZvlWO132sy9D+DhiG3AfFyJAXNL0K7J/77MQZY6mLIUTd5IJUq7R
	 qaFH8650mLm1w==
Date: Thu, 14 Mar 2024 12:58:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Michael Walle <mwalle@kernel.org>, linux-spi@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
Message-ID: <e7220fc2-52d5-43a7-9ccc-55a8f5051217@sirena.org.uk>
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
 <CZSSWP7A9UM7.1R20796VHLU0F@kernel.org>
 <7109907f-baf3-47e2-b33f-3403e1299176@sirena.org.uk>
 <627b382a-0afa-4c2f-a61a-d82548f41306@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YgbYAAqH4LFosk4N"
Content-Disposition: inline
In-Reply-To: <627b382a-0afa-4c2f-a61a-d82548f41306@broadcom.com>
X-Cookie: WYSIWYG:


--YgbYAAqH4LFosk4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2024 at 12:03:25PM -0700, Florian Fainelli wrote:
> On 3/13/24 10:40, Mark Brown wrote:

> > Indeed, this doesn't apply - please fix and resend.

> But this is affecting v6.8 this would have to be fast tracked as a bug fix,
> do you still want me to be based off for-next?

We're in the merge window, nothing is getting applied to v6.8 any more
and Linus has already merged the v6.9 changes.  You need to be testing
against the -rcs to get fixes into the release.

--YgbYAAqH4LFosk4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXy9H4ACgkQJNaLcl1U
h9D7jAf/X0P5K0m6NFG5SG5JZPophcX841qX7q4pbxcwKvNqcykQkhvEgWSMyOA0
jMoQ7mZqOa4qVQxg2eBo03JN4eUPgBwA5l7V9aOLqFrQZz12lkUsn6WrxWB9mZR8
JaHTL183UP8UOhOLtgkib+rZ/RubEPArDTneVzGmZKhUwA1uRklpNPBKrv9FPYVy
tw/dEzjkZHX2V+LSFJNbw/g3oiV+4IN73H3ZnEGkTstHKizDznVj9KObT8pUDLLY
U6vXDxaPKxMbLzewQJAxpMeSqfrSJZc4Af85ErXzlIna2Degu/lPKYVja1PI2GQm
ZYdEgtghg6OMKPatcZwPCeCR6AS8Tg==
=n7/8
-----END PGP SIGNATURE-----

--YgbYAAqH4LFosk4N--

