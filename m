Return-Path: <linux-kernel+bounces-50046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F292D8473A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DE91C23E88
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7623146915;
	Fri,  2 Feb 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+5ynE/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABA12FB10;
	Fri,  2 Feb 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888948; cv=none; b=oiy8WEQWZicm/OQIf+U95XybEC50hgPj111gzPskH0ZYaafVi/RGyUEu777A3A3IcMl8+nsZcmTpaZ6V94xA/h74PdIV+9mtYZlIjT2KlQZJtAGE+Re2TcaEiTPV+FBCGo3u7KCcjSbHOVDvkDKFQIzyZpiL/1OR+zaI394BGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888948; c=relaxed/simple;
	bh=xkn6mlA1ZU5+5715BkWojnUpqAm40lhMBurX+5VqgEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfohJqE01Dop1v2Z4ck5j4cTk1l1Y7iEtUO+2+iFx7AtGdcKS8U1NGWF8WNFOa/MXaF5CU5whLNZ/2Hc7+nSU8unFQRbd7UBq1DiFBzb4qVq/MUPOx9WUOD8tAaqp/mQphuKtXWW6WWdWjA5r/tIU+HopVrrs+PpwDqJUqAE+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+5ynE/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B84C433F1;
	Fri,  2 Feb 2024 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706888947;
	bh=xkn6mlA1ZU5+5715BkWojnUpqAm40lhMBurX+5VqgEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+5ynE/EC/KZE38XXLZPwn5/KHTmk/dVCUznzAwHklwsYlBroDBRUGX6QkuQoIB0V
	 yKy332GCm8YxMYnhjMLfcgUYSHys5dJ4AeYucDgSiYfKBGsK+VF56oPgoeFnibpEsT
	 YrgOisPWZbhK59iLlrcMWi908IicQxiZX0+NhlLHj+goXufPPB4vlGBpO6WjMkgOUc
	 QpubeQRxu1SfH9fop2FOtU5dlcf1q1d8tqBCuEKaDTik4e3dD6AlCCqFK6fwzA9Y2a
	 /VMLAU3IoGOsiNu5UNnbyrBVIZjpzdeO+xdPcYUyWdWeJJ80/ry8j4WF5JT+fROFEe
	 TimKGs6ZQfwJw==
Date: Fri, 2 Feb 2024 16:49:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <niqn7eql5neyfp5ficdfisdpmlwrprovqn5g7lgcfwoe74ds23@7fr4yv2miqe7>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmc24qettt5ad2pq"
Content-Disposition: inline
In-Reply-To: <20240115143308.GA159345@toolbox>


--pmc24qettt5ad2pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Mon, Jan 15, 2024 at 03:33:08PM +0100, Sebastian Wick wrote:
> >  /**
> >   * DOC: HDMI connector properties
> >   *
> > + * Broadcast RGB
> > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > + *      Infoframes will be generated according to that value.
> > + *
> > + *      The value of this property can be one of the following:
> > + *
> > + *      Automatic:
> > + *              RGB Range is selected automatically based on the mode
> > + *              according to the HDMI specifications.
> > + *
> > + *      Full:
> > + *              Full RGB Range is forced.
> > + *
> > + *      Limited 16:235:
> > + *              Limited RGB Range is forced. Unlike the name suggests,
> > + *              this works for any number of bits-per-component.
> > + *
> > + *      Drivers can set up this property by calling
> > + *      drm_connector_attach_broadcast_rgb_property().
> > + *
>=20
> This is a good time to document this in more detail. There might be two
> different things being affected:
>=20
> 1. The signalling (InfoFrame/SDP/...)
> 2. The color pipeline processing
>=20
> All values of Broadcast RGB always affect the color pipeline processing
> such that a full-range input to the CRTC is converted to either full- or
> limited-range, depending on what the monitor is supposed to accept.
>=20
> When automatic is selected, does that mean that there is no signalling,
> or that the signalling matches what the monitor is supposed to accept
> according to the spec? Also, is this really HDMI specific?
>=20
> When full or limited is selected and the monitor doesn't support the
> signalling, what happens?

Leaving the YCbCr vs RGB discussion aside, would this be better ?

 * Broadcast RGB (HDMI specific)
 *      Indicates the Quantization Range (Full vs Limited) used. The color
 *      processing pipeline will be adjusted to match the value of the
 *      property, and the Infoframes will be generated and sent accordingly.
 *
 *      The value of this property can be one of the following:
 *
 *      Automatic:
 *              The quantization range is selected automatically based on t=
he
 *              mode according to the HDMI specifications (HDMI 1.4b - Sect=
ion
 *              6.6 - Video Quantization Ranges).
 *
 *      Full:
 *              Full quantization range is forced.
 *
 *      Limited 16:235:
 *              Limited quantization range is forced. Unlike the name sugge=
sts,
 *              this works for any number of bits-per-component.
 *
 *      Property values other than Automatic can result in colors being off=
 (if
 *      limited is selected but the display expects full), or a black screen
 *      (if full is selected but the display expects limited).
 *
 *      Drivers can set up this property by calling
 *      drm_connector_attach_broadcast_rgb_property().

Thanks!
Maxime

--pmc24qettt5ad2pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZb0O8AAKCRDj7w1vZxhR
xZ36AQCNK31NPILvOExPXTtQmvsilMXK8R/AVHsg6P4vcpksegEAg+oha+xD8C+d
UP6Lt6MNk9CpDL7eulXygAjWYKyLuAs=
=QPry
-----END PGP SIGNATURE-----

--pmc24qettt5ad2pq--

