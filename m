Return-Path: <linux-kernel+bounces-162636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B128A8B5E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682711F21DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663986630;
	Mon, 29 Apr 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk56Xddm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A88839E2;
	Mon, 29 Apr 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406305; cv=none; b=Jjas4ZZIM71RlNtO8BRrdPVz7Xful/SmtPXRLcOBN1jM5jUwQaZg8ioXQv448DzdpSqIZ248BG38B6Jnd5qa2mpUCYX5qz1iOKcHvqmdAiBg6kMxDNRUtT0sj//DSHen+LP1HBeobojDPZ7iqDVMv8088Jbcd1+Q5sZ6wBIbIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406305; c=relaxed/simple;
	bh=w2p2+FlqKmcMpgXu5J6HinktIQLlBvOsnXvudXyY0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/VCsWnl5x+JBf6XKsCyKz1ocjYYyq2E2HJ8sSNSdeEYZ17lTYku5j3p7MNvysiK/PsTdUn9s4przI19SQZBLTkGLsOVXevZaZrD+JyEvq8pnjKPHjrdCYV4QXt3m3v6WnJdlrkVyo/iyvIbq3+HSpKBAnLiLyXGwIOJSJRAKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk56Xddm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F9C113CD;
	Mon, 29 Apr 2024 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406304;
	bh=w2p2+FlqKmcMpgXu5J6HinktIQLlBvOsnXvudXyY0ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uk56XddmE/1h7ryY/qEwqhBowp4RnkabxXAj5MmwmF5mcI/By8uXeEPPvDKCvsaDc
	 2mBsI6d8aeBlbBdEpT31q2dis0lvHCs5ph0GI0MrwSmYjk0IUIKKqboxYMxOC6GWhD
	 n7JOzw+GUVK7wpQurkDT6fI1nFrqTHI4HpqOVS5QF0kKqGQz+tLDNvFWe55/GK+UuW
	 2X0bc1Pm5e7O7b2CulMTA2wy21dqQNQZKT4po9HdPL85zAap0aYMubcrmTySv4sy71
	 g1oU+pcuzDcK+tfhZroQjgXy2dGexgQ7Cbx9ZYEjoZeXTuIR8+5QNv8Cff9THdR/8E
	 ZzoMv5e+zqgMQ==
Date: Tue, 30 Apr 2024 00:58:22 +0900
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <Zi_Dnr9ye0IGoVMT@finisterre.sirena.org.uk>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
 <20240429145203.219bee06@kmaincent-XPS-13-7390>
 <Zi-vhKx-WlYPQe3c@pengutronix.de>
 <5063429d-5dca-4538-b240-50c35cbf5e93@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bo8r1wdIHpgK6ehz"
Content-Disposition: inline
In-Reply-To: <5063429d-5dca-4538-b240-50c35cbf5e93@lunn.ch>
X-Cookie: lisp, v.:


--bo8r1wdIHpgK6ehz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 04:57:35PM +0200, Andrew Lunn wrote:

> I was not expecting over-provisioning to happen. So prioritisation
> does not make much sense. You either have the power budget, or you
> don't. The SFP gets to use a higher power class if there is budget, or
> it is kept at a lower power class if there is no budget. I _guess_ you
> could give it a high power class, let it establish link, monitor its
> actual power consumption, and then decide to drop it to a lower class
> if the actual consumption indicates it could work at a lower
> class. But the danger is, you are going to loose link.

I suspect these devices will be like most other modern systems and
typically not consume anything like their peak current most of the time,
for networking hardware I'd imagine this will only be when the link is
saturated and could depend on factors like how long the physical links
are.  If it's anything like other similar hardware you may also be
making power requests with a very low resolution specification of the
consumption so have conservative allocation end up rejecting systems
that should work.

--bo8r1wdIHpgK6ehz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvw50ACgkQJNaLcl1U
h9DjNAf+NMX+1h+nLe7YsdoVEifR8tW/hw3s5gl7CudpxtOjlkqGSUJhP3iVHc9r
7IhxAGGw6ENDf/uChIOGv+sE+Ev8TO96q9Jz6eiUV9SYisWkfU/8csDGrlOjRqVf
6g7f0JY2IsvtMqBgef1ok2ov899wACM3EQS/lCyVjsBNSYzFIB/JwolzH8ynPDz+
7busVF7vf/+6QU7caq7zMHEeVHB+KZcCgpxlOk+wh7Hlqqfaxeg6qhYDE8mpDG0/
9PBZz2F+gHSx9+tDCltfB6dzUpbzE8l6K/Rqexgto2mAKy0nF17iSPWCd+++8dOD
lfwBp9OMRqV6UMIgxHqArbktai0c9A==
=oodJ
-----END PGP SIGNATURE-----

--bo8r1wdIHpgK6ehz--

