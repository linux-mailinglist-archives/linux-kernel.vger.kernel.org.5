Return-Path: <linux-kernel+bounces-81001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52EC866ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224B81C2225D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1A78B66;
	Mon, 26 Feb 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXXemsJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0078662
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938259; cv=none; b=JDWcwxP4GSkAF0mag38+2K9OUQFwnzMTxhVJI1EQE3J0L0r1ydru7/tKDup6pzI6ROjeE+/DkJGJf3pW3//a1klbcswm9kj0ieSe9Bxa2VhNZZHN3a8FpWjxmMA5D4sFs09vh+4xkPDj0kF7icwAmGw1IdlTf5e31TFTDWJKorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938259; c=relaxed/simple;
	bh=AOhnnfzeFccWaPh6IGPowe4gy919YNwS22AyIgMywL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZvD02PwhZtNhaKrguDEJQPueajqEvZj6gHF0zL/eF/EGHA4ZpSS7mGiCEOVtAqLGIdY7mo+mwkFLUFV5YGNnq7EU7egc+4NVXgsfqplADWYmnxc+EzfH11zc92eDNdegggRHRnuYyKS3bvD9xpdcylou24mm/lHwN6w1oshq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXXemsJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F30CC433C7;
	Mon, 26 Feb 2024 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708938258;
	bh=AOhnnfzeFccWaPh6IGPowe4gy919YNwS22AyIgMywL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXXemsJUNz9ZTl6Sp95ZNxXrWGLVZ3U88vdeW4k27sA8Exr172c9xHIUDudsPhIdG
	 +/ILB+s+K9QjrxgB6CZduwd1K+BSkFjWNup/KjWEZFu5q/y266GI8ejOoxs6lTfqcX
	 pSmtjggWK+VjWtuk176K2VNSB/qsDknF0lixg7A9EeCohn88LP4xbbCtL39ZlGBvaf
	 y73PJXpfIJth5SvruQwNpfXVJdPrllGio9UkZ4YEjzSDjEkuDwBjLfPCpvpjY25kAl
	 pXlmQBNp1xJXFSeFebfkMAfJHet5NUMEEatTjhzpks8r3XLJwPcTpcAg7uRmtQvSm0
	 +YFyPl5Di+wbA==
Date: Mon, 26 Feb 2024 10:04:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Francois Dugast <francois.dugast@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Tejas Upadhyay <tejas.upadhyay@intel.com>, Matthew Auld <matthew.auld@intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michal Wajdeczko <michal.wajdeczko@intel.com>, 
	Matt Roper <matthew.d.roper@intel.com>, Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/xe/kunit: fix link failure with built-in xe
Message-ID: <e5vndkeqsxozognnsn4snuhbvpvmxvz5foj44nrwpsucajwrkr@kvlqsijrehll>
References: <20240224121528.1972719-1-arnd@kernel.org>
 <7hfobmmgs6ntnusobalqxslcyv3kqdlnhxjoxbaful4ameavj2@niodl55l7b7g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mzwthjftv6ebzjkj"
Content-Disposition: inline
In-Reply-To: <7hfobmmgs6ntnusobalqxslcyv3kqdlnhxjoxbaful4ameavj2@niodl55l7b7g>


--mzwthjftv6ebzjkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 09:42:06PM -0600, Lucas De Marchi wrote:
> On Sat, Feb 24, 2024 at 01:14:59PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > When the driver is built-in but the tests are in loadable modules,
> > the helpers don't actually get put into the driver:
> >=20
> > ERROR: modpost: "xe_kunit_helper_alloc_xe_device" [drivers/gpu/drm/xe/t=
ests/xe_test.ko] undefined!
> >=20
> > Change the Makefile to ensure they are always part of the driver
> > even when the rest of the kunit tests are in loadable modules.
> >=20
> > The tests/xe_kunit_helpers.c file depends on DRM_KUNIT_TEST_HELPERS,
> > so this has to always be selected by the main XE module now, rather
> > than the actual tests. In turn, the "depends on (m || (y && KUNIT=3Dy))"
> > doesn't really do what it tried and can just be removed.
>=20
> it actually did, which was to workaround issues prior to the commit you
> are pointing out.  What it did  was to make sure xe.ko is m, or if it's
> built-in, kunit is also built-in. Apparently the problem here is that
> the xe_test.ko is missing the symbols.
>=20
> See commit 08987a8b6820 ("drm/xe: Fix build with KUNIT=3Dm").
>=20
> I'm happy to remove it though if it's indeed not needed anymore.

I think the main issue with that original patch is that it keeps the
direct include of the test files.

I assume it was done to allow kunit tests of static functions, but now
that VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT are a thing, you don't
have the need for that include, and you can build your tests in a module
while the code is builtin.

And the conversion should be pretty minimal.

Maxime

--mzwthjftv6ebzjkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdxUCgAKCRDj7w1vZxhR
xbo0AQCXLjOUMPlHPDRJQNooVy21X6D9u5gkUwNThw78/qfJIAEAkWn/qdsZFs/j
xH9z/KXXCorD31m1Jpr4RqDpaELZMwg=
=mYq4
-----END PGP SIGNATURE-----

--mzwthjftv6ebzjkj--

