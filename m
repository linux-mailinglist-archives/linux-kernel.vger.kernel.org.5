Return-Path: <linux-kernel+bounces-19351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C6826BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BCC1C2219F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F352225D3;
	Mon,  8 Jan 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUcKlsH/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2B21A06
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AFDC433C8;
	Mon,  8 Jan 2024 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704710755;
	bh=/8w4vROXmW0/3v/ZTMz/G2a/IUmTbhMJq4VGl/To7Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUcKlsH/SdHBtzI4vy0A2Qqm35XwzGuihd4efUl5q23f+fmPWhTqPUxAsFT9sFh2L
	 qY9e6sgVaivOOC6OP5miQTTk7CjX3y+/Rc3CM7M5Ot5kaY468yaK5bl2qIYA1KkRlv
	 U2ZrRCBzKjNg3uCHRhg9XfP54Q7NnBMgEWEHu1TOsTevWQ/uRZdmF57jUr0dMxtRid
	 jdsWFOHAetoZXEM035kJhLQdv7L1UzaUTMEAGsJ3MiRYkrirWLpY7PXuCQQxEPpxHi
	 lYau/fwzX/vG+VkN+wImDsU3lJ3JBQBF610qbJ4QCThDc+3I9gOIbHoTMNMrO3/vZA
	 P8MOEjhgdiqJQ==
Date: Mon, 8 Jan 2024 11:45:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Michal Wajdeczko <michal.wajdeczko@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v4 3/6] drm/tests: managed: Remove the waitqueue usage
Message-ID: <bu62aukq2iw36k52tvrimatph3hn6ec3a4c5gaf4orkak6igoz@do6v344l7g43>
References: <20240105101324.26811-1-michal.winiarski@intel.com>
 <20240105101324.26811-4-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iu3intlqu5kvvetm"
Content-Disposition: inline
In-Reply-To: <20240105101324.26811-4-michal.winiarski@intel.com>


--iu3intlqu5kvvetm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 11:13:21AM +0100, Micha=C5=82 Winiarski wrote:
> DRM managed release (drm_managed_release) is called as part of devres
> release (devres_release_all), which is not async.
> The release action should have already been executed once
> drm_kunit_helper_free_device exits, meaning that there's no need to use
> a waitqueue - we can just inspect the "action_done" state directly.
>=20
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>

I disagree, nothing guarantees in the API that it will be executed right
away. Since it might be asynchronous (if something else holds a
reference for example), we need the workqueue.

Fortunately, it turns out that it's actually done right away, which also
means we'll never hit the timeout and thus never stall the test run.

Maxime

--iu3intlqu5kvvetm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZvSXwAKCRDj7w1vZxhR
xUy9AP9z4a9PtD1LHH9YlF2EJRnFrx0g0iY1U0rxHWhnZXFVPgD4iX4Hm1zoLjXz
0BccGN772xsxXdWGatm/UjMXqVaxBQ==
=mn+1
-----END PGP SIGNATURE-----

--iu3intlqu5kvvetm--

