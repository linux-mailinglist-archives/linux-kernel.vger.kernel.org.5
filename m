Return-Path: <linux-kernel+bounces-121300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CF88E4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F12729F9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF701482E7;
	Wed, 27 Mar 2024 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfYSHL7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6612EBF1;
	Wed, 27 Mar 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543363; cv=none; b=ZasEhp62eVdkywjUJljw0Zyc27CJy93Juzne5J8QE5EvepOu/ZNSQIOB9Z7Dv9tKNr4FyuvLSamvDJHZiFBmz/jxFicdxTKZZJWKuQUC4WujRL0XwvwRaMucB3hJ5qvchpaYrZX0dYJ/ZK/FWlC2sXpmjZY203dXeqb05I2MJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543363; c=relaxed/simple;
	bh=060ldzSvr1r+sVWZLmOY7us7S/7PcOH4lo2/HCwzbME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMLHYgpzFfv/ufoosoZZ4e5Yla1bcd2utpS/ntfL3VprZYnf71/2Lh7sMx0SIslJko3AxrveUJKR/DWWdfOh1qL7UkwOzS4rH4RQjGUjYl4Mlk+VS7MzX/rmZIvAOWsH/na6KtJWJi0gHFT4jfkxpk+LNb4TC7quzuTeJ7jb8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfYSHL7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E6DC43390;
	Wed, 27 Mar 2024 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711543363;
	bh=060ldzSvr1r+sVWZLmOY7us7S/7PcOH4lo2/HCwzbME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfYSHL7LS+gP6qHLU5Fj7lhY2R9DQvdcVoRa+WhR+HqiIkQvrGW7o0q9CNZp5w4Hq
	 v5z2dnYp/MoTMEU5rGjkHgoliUu9Nc3JtrfnBb1MiEC4Fm/eKY9K//VMS94/JpqgTb
	 0KSR3fGWMcVX03uqN3SpJSRAJ5KXSrRP5K47Ie2/IkAMTlBQHkuptdj1/qENLbDJP9
	 XiF/C4NcFDBsF+wzpVvJziT/sWURqLNiJY42ZQweDASb/l1oUhL7JxhT4B+5MpS37+
	 fY8816V2T6o2zFPjHzXTjoNL/QH/PBedd46XQPJ5pS97dkL49Ff/fBgNVwIDmVJbLt
	 XAwkUPm6gabnA==
Date: Wed, 27 Mar 2024 13:42:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Kocialkowski <contact@paulk.fr>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 4/4] drm/bridge: hotplug-bridge: add driver to support
 hot-pluggable DSI bridges
Message-ID: <20240327-radiant-cherry-myna-25afc4@houat>
References: <20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com>
 <20240326-hotplug-drm-bridge-v1-4-4b51b5eb75d5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="smru7vmch6uoqfjy"
Content-Disposition: inline
In-Reply-To: <20240326-hotplug-drm-bridge-v1-4-4b51b5eb75d5@bootlin.com>


--smru7vmch6uoqfjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 05:28:14PM +0100, Luca Ceresoli wrote:
> This driver implements the point of a DRM pipeline where a connector allo=
ws
> removal of all the following bridges up to the panel.
>=20
> The DRM subsystem currently allows hotplug of the monitor but not precedi=
ng
> components. However there are embedded devices where the "tail" of the DRM
> pipeline, including one or more bridges, can be physically removed:
>=20
>  .------------------------.
>  |   DISPLAY CONTROLLER   |
>  | .---------.   .------. |
>  | | ENCODER |<--| CRTC | |
>  | '---------'   '------' |
>  '------|-----------------'
>         |
>         |               HOTPLUG
>         V              CONNECTOR
>    .---------.        .--.    .-.        .---------.         .-------.
>    | 0 to N  |        | _|   _| |        | 1 to N  |         |       |
>    | BRIDGES |--DSI-->||_   |_  |--DSI-->| BRIDGES |--LVDS-->| PANEL |
>    |         |        |  |    | |        |         |         |       |
>    '---------'        '--'    '-'        '---------'         '-------'
>=20
>  [--- fixed components --]  [----------- removable add-on -----------]
>=20
> This driver supports such devices, where the final segment of a MIPI DSI
> bus, including one or more bridges, can be physically disconnected and
> reconnected at runtime, possibly with a different model.
>=20
> This implementation supports a MIPI DSI bus only, but it is designed to be
> as far as possible generic and extendable to other busses that have no
> native hotplug and model ID discovery.
>
> This driver does not provide facilities to add and remove the hot-pluggab=
le
> components from the kernel: this needs to be done by other means
> (e.g. device tree overlay runtime insertion and removal). The
> hotplug-bridge gets notified of hot-plugging by the DRM bridge notifier
> callbacks after they get added or before they get removed.
>=20
> The hotplug-bridge role is to implement the "hot-pluggable connector" in
> the bridge chain. In this position, what the hotplug-bridge should ideally
> do is:
>=20
>  * communicate with the previous component (bridge or encoder) so that it
>    believes it always has a connected bridge following it and the DRM card
>    is always present
>  * be notified of the addition and removal of the following bridge and
>    attach/detach to/from it
>  * communicate with the following bridge so that it will attach and detach
>    using the normal procedure (as if the entire pipeline were being creat=
ed
>    or destroyed, not only the tail)
>  * expose the "add-on connected/disconnected" status via the DRM connector
>    connected/disconnected status, so that users of the DRM pipeline know
>    when they can render output on the display
>=20
> However some aspects make it a bit more complex than that. Most notably:
>=20
>  * the next bridge can be probed and removed at any moment and all probing
>    sequences need to be handled
>  * the DSI host/device registration process, which adds to the DRM bridge
>    attach process, makes the initial card registration tricky
>  * the need to register and deregister the following bridges at runtime
>    without tearing down the whole DRM card prevents using the functions
>    that are normally recommended
>  * the automatic mechanism to call the appropriate .get_modes operation
>    (typically provided by the panel bridge) cannot work as the panel can
>    disappear and reappear as a different model, so an ad-hoc lookup is
>    needed

There's several additional hurdles there:

 - You mentioned the connector in your ideal scenario. But as soon as
   you remove the last bridge, the connector will probably go away too.
   There's two scenarii here then:

   - The driver is ok, and it will stay there until the last user its to
     the main DRM device. Which means that if you create a new one,
     you'll have the old one and the new one together, but you can't
     tell which one you're supposed to use.

   - If the driver isn't ok, the connector will be freed immediately.
     There's plenty of lingering pointers in the framework, and
     especially the states though, leading to use-after-free errors.

 - So far, we told everyone that the graphics pipeline wasn't going to
   change. How do you expect applications to deal with a connector going
   away without any regression? I guess the natural thing here would be
   to emit a uevent just like we do when the connection status change,
   but the thing is: we're doing that for the connector, and the
   connector is gone.

Between the userspace expectations and the memory-safety issue plaguing
way too many drivers, I'm not sure this approach can work.

I guess one way to somewhat achieve what you're trying to do would be to
introduce the connection status at the bridge level, reflect the
aggregate connection status of all bridges on the connector, and make
each bridge driver probe its device in the connect hook through DCS or
I2C.

We wouldn't be able to change the bridge halfway through the system's
life, but like I said, KMS cannot hotplug connectors at the moment and
doing so requires far more work.

Maxime

--smru7vmch6uoqfjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZgQUOwAKCRAnX84Zoj2+
dh89AYC0DigxAGT86h4ujIKZDYh8aLMH+7++xfwqa5vubnN/TG4u3JA5729E+nAl
ZyDl3gABf0rN7Y5nsjQqQ1hkChegPiN0UnpVkGJfp+rRP+p/rc4xoED8H091rEe2
n7civUZ4iA==
=7Rs7
-----END PGP SIGNATURE-----

--smru7vmch6uoqfjy--

