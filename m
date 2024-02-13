Return-Path: <linux-kernel+bounces-64037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1285393B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422371C224ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047B60B98;
	Tue, 13 Feb 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8L4GOs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C11605B6;
	Tue, 13 Feb 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846950; cv=none; b=aW7ed4Qw6g5XCsrQDdQNsl+FfXGXpKVfmUGDf14Xca+/QLH72uCAXO2NUgWj4UlbmCjhpGGvrNQ5R+YgcMeIlEiLmJII+xwa7ZeK01B48Mi3CCsoPyOf829v4qF4cFhzI7OhBQAOYgCZ8XhTYhVXyvHIFI4F+smdIFuG8TF8lY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846950; c=relaxed/simple;
	bh=aFUTRfWPd5A5BcBrutUwYob7cONVtIUJ2AARzRcrfr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqrJBm47tkLdhCr0+eOeq1fhDxeFEg1Eum2iCBD3jLdRASurHSVBhzjj8up58sN4drUuluVhM1IFKiLBwPvpXA1E5EOtvzTXXjoNkv+seJ1Dz041KdheG6R1dJtI5ztLzc7nDdUdQ6v5pjhf6gsP9WBcR8+3syrHim/8/4ZYnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8L4GOs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A31C433B2;
	Tue, 13 Feb 2024 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846949;
	bh=aFUTRfWPd5A5BcBrutUwYob7cONVtIUJ2AARzRcrfr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8L4GOs2Io2KLsFwrgFXp5QIdrCEZhJa1U0h20O4wROD7rUhHTQ5P3T7Uf3ClEsai
	 zaY9RqrrXk8tu8TvxpaNRBEXwuDeZU5cS8TMM7/MFEDn0qRhd/iuXVVR4RKFczVW3v
	 FbMFcjUMecNZCJPNwyn99J7so94l6aTGoCC7+fNtByI//jQzvYqkmCPGSJrcglbxHY
	 sGPOZqIo4+yRj1y0xvdlEMdKm9/cshAQ9dD84bsuXJqHj+tmrJYjgGmfZ0LFhO2N1f
	 rF0ohMMII6eZJ5NQpOoKmnqoSAeP4SEkmMcJho3BqxBfwu8kvzWlzsqE/HJ+NxNMlx
	 7ga+BUbzqbnOQ==
Date: Tue, 13 Feb 2024 17:55:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
Message-ID: <890cc62c-9ae3-41b7-98a8-2c3245570045@sirena.org.uk>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
 <92e7e0acf6d8746a07729924982acbfea777c468.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+0uhG4FWQ18FZmwB"
Content-Disposition: inline
In-Reply-To: <92e7e0acf6d8746a07729924982acbfea777c468.camel@gmail.com>
X-Cookie: Does not include installation.


--+0uhG4FWQ18FZmwB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:53:56AM +0100, Nuno S=E1 wrote:
> On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> > This adds a new spi_optimize_message() function that can be used to
> > optimize SPI messages that are used more than once. Peripheral drivers
> > that use the same message multiple times can use this API to perform SPI
> > message validation and controller-specific optimizations once and then
> > reuse the message while avoiding the overhead of revalidating the

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--+0uhG4FWQ18FZmwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLrR8ACgkQJNaLcl1U
h9AICQf9EfUz5AuSoWRn8XL1IupJA3HL7p0laFINvbncTuz94ipcA9dkZJdiNBw1
06RNd4VaCsrv6F8MxB3cmEKaJ/gVL+VqopQLzmzbBd8LoCDc04KH9nb0Q2e5uVXm
faWUyheED0rGuOJJyL6XJgIHMUM0PXif6bM/X/UGOna8zRZgbCAxuON+hFAo6bQM
eaueKdLrcFVjfEvOnuRoGT17IQj3GCxsYNjSVk3X8fC8f93fyWIpaYbbT6ouoxaz
FvtmYXuhXyIoFHMtqQtsKp849RavJ9LiqiUae8Aml5UsvEViNxDJNGE9nI5n9W2i
K4OINM1BqmC9Mo8Poiojv4BnzdCljA==
=AnHQ
-----END PGP SIGNATURE-----

--+0uhG4FWQ18FZmwB--

