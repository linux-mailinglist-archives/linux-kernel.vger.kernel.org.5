Return-Path: <linux-kernel+bounces-151378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2A8AADCB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DCD1F21729
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49AD823CD;
	Fri, 19 Apr 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpnoKl85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA378004E;
	Fri, 19 Apr 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526598; cv=none; b=j3vKfxvH9XiXCpLlv9F60bcDSynpn5ChSE7rNNEV607yMYTk3jgU2XHazU92oSrxxJHNABFhDMAoiajNSONVTQTh3UaSgni6RpiqK0tkC89F7xIcJ4OsS9CZK090bAgvhoSTISPyyt1PrUkHCN+xmWo5GaKqvmUumstmwqv9G3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526598; c=relaxed/simple;
	bh=RGBSiE3AtLVUYHvusd2OokOMgXmKs1k7wH7HEVhiQfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHgP9h6N2bRMNI4NISzU/NYCOXWKoUDxLj/iRaS0BNUez5lKs0t7reaofzkewDVbHCJCM59kxrfmbumcc4y7A9vDGaZX4ykoM5bfgQ/lXbkC4/tZDJbxLc5BFxm917ZalmPIkP8fcSubUZ/tOyWpquOPXS+/RNdFtp9kAS1Ua/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpnoKl85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CAC072AA;
	Fri, 19 Apr 2024 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713526597;
	bh=RGBSiE3AtLVUYHvusd2OokOMgXmKs1k7wH7HEVhiQfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpnoKl85z8PRUnvUV94bspdas7JkiksyoW1AUSsd8W5fmoKjOprRdlJzjtY6JkGDo
	 F0P+F3/zUJxWmjy8oa50ws3MIqDHtYzGjVrG1jzikp5TGwnUoJn1cHGzczVzY7/vLn
	 a/6Bo33zheUhgEgSIl9SJk7FV/aPdJQByPCu0l97+mJU3etiiUh2gM4qLtPLgq+Hwx
	 /NVNq7ikFh7ooDTrQjG6s6bh766F3Lxjm8nHQEGC3zZR5LHt+dGGkyO3T7J68mVyU4
	 hlmj5QeaA/+KjRDCsa3scXjCF6fBijP+eJ79KqrxYBIPcMjklOk3F+BeHm/FiCn7jA
	 71LTAmbS+VjBQ==
Date: Fri, 19 Apr 2024 13:36:34 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Wick <sebastian.wick@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v11 17/28] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <20240419-intrepid-enthusiastic-spoonbill-3fb9f2@houat>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
 <20240326-kms-hdmi-connector-state-v11-17-c5680ffcf261@kernel.org>
 <Zh6EevKDKt60E8e9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="twt2bamgclgwo5q2"
Content-Disposition: inline
In-Reply-To: <Zh6EevKDKt60E8e9@intel.com>


--twt2bamgclgwo5q2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:00:26PM +0300, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 26, 2024 at 04:40:21PM +0100, Maxime Ripard wrote:
> > The i915 driver has a property to force the RGB range of an HDMI output.
> > The vc4 driver then implemented the same property with the same
> > semantics. KWin has support for it, and a PR for mutter is also there to
> > support it.
>=20
> Is there a i915 patch to switch over to hdmi.broadcast_rgb? Though
> the "hdmi" name is perhaps not the best idea given this is also a
> thing for DP.

No, there's none yet. I can try to cook one as a follow-up, but I have
no way to test it

Maxime

--twt2bamgclgwo5q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZiJXPQAKCRAnX84Zoj2+
dqW3AX4z9SPfNEYqLIrzCMiper2UznzSiItRQraVPOKwQb/7kJbeWynLWAgun2KI
ipBCYTIBgNmPOT2WW4J8MjsQTegdqZL5wVAo0erF9fB7LiOU6HNZ9VZCiYz2cjwl
d06WM355Fw==
=BZv7
-----END PGP SIGNATURE-----

--twt2bamgclgwo5q2--

