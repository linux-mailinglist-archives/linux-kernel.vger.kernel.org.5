Return-Path: <linux-kernel+bounces-111422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4EA886C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526AF287295
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4DC3FE58;
	Fri, 22 Mar 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQncd7zO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743E6FAE;
	Fri, 22 Mar 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110710; cv=none; b=lWsl19rYep/tJ4yhpOz0jolMcKeCg/TAb8HOWaY7cI9av/fig/sH9qZ9pz0tgIpU2+bl4wSDVh6iypl4kN6Nqr0GQ9n4c+G55S6aUFBhfEtqwKC0TBWqiX8kXFC8ZDaYRG2G7KEiG85Wff7l5VZtWd0SNugOExPgdZNvJo0JokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110710; c=relaxed/simple;
	bh=QlyE6XyvtK5YH4auzoYHbK4QQ96PMKT1SN7P95GQyFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2wfFPzwjGwy5r3LW6dc59lB0Q8UPnA0E/nxWKQlj4B/Od+V1QOmQMpmOmYKQm/fhfDjGB9V1O1c6+JK0jfyIUMcQuxr9Q/8LKwRsvpDgsD6pI0nvxhsZEZcfLrcufIRLKgs4sdPlkOCbW8K+CgjyINSLWHcV2eUZfdIQHpFnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQncd7zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A77C433C7;
	Fri, 22 Mar 2024 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711110710;
	bh=QlyE6XyvtK5YH4auzoYHbK4QQ96PMKT1SN7P95GQyFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQncd7zOWU2lzxFreJmwqfG9yf1KhjFzLXGssQ1hhk5T0UKSaYEGZ6ary5hJPu1HU
	 olKpkrPJ0gCBlwJ2yKEoHXBrlEbhWKNXF0R/oKjV5ZKtkd9l0hiiSuc2CVWPYyDmuv
	 ITIfayGHMp/DzLD4GvK/BDJ9HR+FL+2mlPJPZpcAJAOcrzIXapdM82MMCdlRm/B4cm
	 UYLTu308/ix2n/Xw6ZoJhp3FGCxTmqqraSjn9JyzqfG7c00V9Xz0iD7aztkwK5zE0J
	 Nsby0PX8HX3EvkNXf4u+5v++RAgAThY13/Otrjznwg3v+tEVrU+qORoLhtthyf7QZV
	 hn2yy43ReMKTA==
Date: Fri, 22 Mar 2024 13:31:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Wick <sebastian.wick@redhat.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [v10,20/27] drm/connector: hdmi: Add Infoframes generation
Message-ID: <20240322-steadfast-tanuki-from-mars-b5ea5f@houat>
References: <20240321-kms-hdmi-connector-state-v10-20-e6c178361898@kernel.org>
 <07125064-2a78-4515-bb48-655f2aec140f@linux.dev>
 <20240322-loose-resourceful-bullmastiff-92cfaf@houat>
 <7835e928-7d09-446e-91dd-13a0fa549bc2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ygdzto2cjdjjo7zs"
Content-Disposition: inline
In-Reply-To: <7835e928-7d09-446e-91dd-13a0fa549bc2@linux.dev>


--ygdzto2cjdjjo7zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 07:13:54PM +0800, Sui Jingfeng wrote:
> Hi,
>=20
>=20
> On 2024/3/22 18:31, Maxime Ripard wrote:
> > Which default config are you talking about? This compiles fine with all
> > drm-misc defconfig, x86 defconfig and allmodconfig.
>=20
> The drm_hdmi_avi_infoframe_colorimetry() function is belong to the drm_di=
splay_helper.ko
> kernel module, it get called from hdmi_generate_avi_infoframe() in drm_at=
omic_state_helper.c.
> While drm_atomic_state_helper.c belongs to drm_kms_helper.ko. Therefore d=
rm_kms_helper.ko
> is dependent on drm_display_helper.ko implicitly. So we probably should s=
elect it.

Right. I was asking which config are you using to generate that build error

Maxime

--ygdzto2cjdjjo7zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZf16MwAKCRDj7w1vZxhR
xVPkAP9G35ser3LI9Mkz4UPsJ7hdxEY40m/H7avmJllz/P8YowD+LcjpoKgFLzQ2
L2LkEn9vRNdhZy+7qFgJZ6RKstIwPAM=
=B6jC
-----END PGP SIGNATURE-----

--ygdzto2cjdjjo7zs--

