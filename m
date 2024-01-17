Return-Path: <linux-kernel+bounces-29041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC3830770
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C77F1C248FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FB200CD;
	Wed, 17 Jan 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iV516Kmg"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D10200D5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499989; cv=none; b=la0Tnjs0k555hqGzkmcOPLFtbeJ4fqmMZV0xJTvuy5fpsJFhww7/yRh31Qsdjhza94DoZR7oNNZUZ4cv0kh3vX2/NOyyYOmHl/4PRzOgrIBs+/Sdx1pHnkxNx1o3WARZhv6sPOUMIfZwy25OpetSOIDUgZ07C2ejCTQdthOsL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499989; c=relaxed/simple;
	bh=ixSvmpnR3QrMMP2UAVH8Rp2h/PXUfvzlhSH5WXrwo8k=;
	h=DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:From:To:
	 Cc:Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcBJu8ipybRfBDhDgbin2UUpMLY6Q796PxTsBkIbv/GMPce8OTYQk236GH11DFoTtfXq/lgDj8f0k6nVqw6HACfLKJdVXq2vrfAEQLDM0j3kjqNJvKWNCzHwFrOzc2lsmHjoS+2ME8H9PrtocuTOULw1MJp74wuvO6XuJYPZjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iV516Kmg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ixSv
	mpnR3QrMMP2UAVH8Rp2h/PXUfvzlhSH5WXrwo8k=; b=iV516KmgJnuopq3o/lCp
	BgwbOvgAjc9UBFJI+I9NghYYPhWRHTBkyuj9XzVqfwtNFzErgo/AqTHGBcc8hcvP
	tEqKJL+6xkW+9LxvjoR+ZrlEcNxo83vAHh313KEbTabz0g043J/Ki1L8mMuTDskA
	w01DkKJU67SP9N+lrNAvt0juuRjWcThVZxjdUUDII/61ChQ0jMhq7E1zsV4oXdgu
	KyT2TurxTuCo4ZOpp93npUo6VQXPakUfVY1LNhhFV2wwMnLVma3ZljmAK+ieGrSL
	ao9DaL8vPQWIOnTZtgEuCiloiGsHhtCtF80xaJHr2H5ntSlgbj+Q8ExYCa79Awtk
	xA==
Received: (qmail 2766347 invoked from network); 17 Jan 2024 14:59:44 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jan 2024 14:59:44 +0100
X-UD-Smtp-Session: l3s3148p1@SeDAqCQPgpZehhtJ
Date: Wed, 17 Jan 2024 14:59:44 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <ZafdUGVVwVlp-0Pt@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
 <d9e86b0b-22cd-4055-90e1-44083ffbc05c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nzwFSGGxwC2b8YVx"
Content-Disposition: inline
In-Reply-To: <d9e86b0b-22cd-4055-90e1-44083ffbc05c@lunn.ch>


--nzwFSGGxwC2b8YVx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Does phy_resume() hitting it with a reset clear out the configuration
> done by config_init() and the interrupt configuration performed by
> config_intr()?

Hmm, I should have answered your mail first. Instrumentation says you
are correct. Back to the drawing board :/


--nzwFSGGxwC2b8YVx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWn3VAACgkQFA3kzBSg
KbadWw//c6TmTTvHvJE8yiQ+Wvfd8489Xx9C6/0VMOFczBOsJi4UK0HjuzSpfB4u
gmx091TZ6ospNwTCNmRXNbByAo5KO8Oq3TYuI9ZDqVkcMT7dbxKYdDXjln/29De1
DM+BfqWxXuEqGHWhUp8XYNe0F41NljUQ9ZrjgZLtLfDkcqohi8drqn2EyhTv51Bp
bnp85H2EZm9XBkZikm3IMYqbOgmB+C8S5z1VqosAWHC9aRRiWAStK+H2pyX8s8Zx
cV8SBoguZfrVQRtWe356w3613Vo6UM/xd83ADMHbhW6kEp3DVvw3ea1SOBtA0aXs
4GcYAnep6Y9dXFU3Rnx6EG2cE/gKq1Iz6E3vVGdYWJXf4Znxj6ri5jpIL2goxep9
UrxCGiL8V7VJ33N51zSGOkshI+AMLHLh6NI8QxgAwTROFJJINxnG0xZW5DwMDYuh
IvlmlhzEaJypnk3Vyssv8GhuKqzFphDXDxZxvkSeXXJEgFzmmw4hDMkyK+chOVCj
QWbcVGlb9g74CiUCx4wxQbGY7lAr0kmJu41fgzeOI20Qzm5rV4zYoVUy6HV08fLe
1EjzWcYocUK8KnpESh2/adQKzj1q4X/MBrqcYJt7DPlajicWFl0tci8GF3oEyl25
txjbl5k5cCMirPFJakFnPHFAGS9lFI3q/ep43uMyBrCfd8p/gQ8=
=OEz2
-----END PGP SIGNATURE-----

--nzwFSGGxwC2b8YVx--

