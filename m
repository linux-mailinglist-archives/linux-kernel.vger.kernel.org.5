Return-Path: <linux-kernel+bounces-63635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69315853293
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26405288C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957E5733D;
	Tue, 13 Feb 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6oTbLcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5C57300;
	Tue, 13 Feb 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833050; cv=none; b=XpXluRiveYQ5sR68wIJxZoWfvEbr0ACHb5j8YWcF8zLsBTCIPnNvBb7MbcMUR0/i0Ww7LHNUZ78x4FiaqIj7S7quRGJkflsT3rwLNNQCfQV7jB0YACYD+GTVF7zDvFVMvtp3PhPf7iGQXLpDcp0CbYxkApfgpIJ0YmYO6mc/XWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833050; c=relaxed/simple;
	bh=o78OnlwnYhWQz6fK1xJE8KAH3CBYnt55b482qC2CxzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m49IkVrV3787XMNLcJSNWGW/exOr4vkI8A5rboCkDvwwo79N7kO2zbvou6z82LNZC0DNUBDinJsOBTvH/NscQP3ElHCS96097IYn93DW/WM8tUqYMIrAZnlDfgkpykfgiuQR/y1nbja7IilrNpsqjkjy4biWXIzt5oaRBCvQuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6oTbLcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EDDC43394;
	Tue, 13 Feb 2024 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707833048;
	bh=o78OnlwnYhWQz6fK1xJE8KAH3CBYnt55b482qC2CxzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6oTbLcX65Y1yPWcSU+wVK7zfQGji1w9jUe8wedMA4beE5xu2JlKWtb841Mm2uZlR
	 qm8k5laoWPsXPw4ryiS8fTANTWrMjf30gHsSCH2I8aK+07eoAl9jgDMGFoFqkxizKw
	 lEhdjYWZjQIhvFLpvKaC0w+1jaKL+ci5AIKKu33Gvn82+DYRn6GOJJsGoj2C6nO9Do
	 gBdWxw/o1AEn7cyMVOUQPhIJ15i+5/dw6ibKJSmn6ReKLIwT/B6+oDV1uDRKvW7aEt
	 H/Rb4FxyqDzBgLmPMVfUxwefcL1WC0N4/+YZWMPRTGwXINjfYrdjfvZ225gPyi16ei
	 df6V4Jxq1hEOw==
Date: Tue, 13 Feb 2024 15:04:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, praneeth@ti.com, 
	a-bhatia1@ti.com, j-luthra@ti.com
Subject: Re: Re: [RFC PATCH 2/3] drm/tidss: Add support for display sharing
Message-ID: <qiqrhpqtnox47wj6az7t3fjp4vc6k32fw42tp5slqggrhe6utb@i7lkpaf3v3od>
References: <20240116134142.2092483-1-devarsht@ti.com>
 <20240116134142.2092483-3-devarsht@ti.com>
 <vgfzhamtiwkpdyk5ndagsb63subclinotoe6tsi3wu6z7454ec@igxfzjc5gyqm>
 <88018f5f-a7db-7278-e5c3-bb1dbf0e3f14@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mec2gkni2rkjd75q"
Content-Disposition: inline
In-Reply-To: <88018f5f-a7db-7278-e5c3-bb1dbf0e3f14@ti.com>


--mec2gkni2rkjd75q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Devarsh,

On Thu, Feb 08, 2024 at 06:26:17PM +0530, Devarsh Thakkar wrote:
> Hi Maxime,
>=20
> Thanks a lot for checking on this.
>=20
> On 26/01/24 17:45, Maxime Ripard wrote:
> > Hi,
> >=20
> > Thanks a lot for working on that.
> >=20
> > On Tue, Jan 16, 2024 at 07:11:41PM +0530, Devarsh Thakkar wrote:
> >> Display subsystem present in TI Keystone family of devices supports sh=
aring
> >> of display between multiple hosts as it provides separate register spa=
ce
> >> (common* region) for each host to programming display controller and a=
lso a
> >> unique interrupt line for each host.
> >>
> >> This adds support for display sharing, by allowing partitioning of
> >> resources either at video port level or at video plane level as
> >> described below :
> >>
> >> 1) Linux can own (i.e have write access) completely one or more of vid=
eo
> >> ports along with corresponding resources (viz. overlay managers,
> >> video planes) used by Linux in context of those video ports.
> >> Even if Linux is owning
> >> these video ports it can still share this video port with a remote core
> >> which can own one or more video planes associated with this video port.
> >>
> >> 2) Linux owns one or more of the video planes with video port
> >> (along with corresponding overlay manager) associated with these planes
> >> being owned and controlled by a remote core. Linux still has read-only
> >> access to the associated video port and overlay managers so that it can
> >> parse the settings made by remote core.
> >=20
> > So, just to make sure we're on the same page. 1) means Linux drives the
> > whole display engine, but can lend planes to the R5? How does that work,
> > is Linux aware of the workload being there (plane size, format, etc) ?
> >=20
>=20
> Well, there is no dynamic procedure being followed for lending. The
> partitioning scheme is decided and known before hand, and the remote
> core firmware updated and compiled accordingly, and similarly the
> device-tree overlay for Linux is also updated with partitioning
> information before bootup.
>=20
> What would happen here is that Linux will know before-hand this
> partitioning information via device-tree properties and won't enumerate
> the plane owned by RTOS, but it will enumerate the rest of the display
> components and initialize the DSS, after which user can load the DSS
> firmware on remote core and this firmware will only have control of
> plane as it was compiled with that configuration.

Right. If the RTOS is in control of a single plane, how it is expected
to deal with Linux shutting the CRTC down, or enforcing a configuration
that isn't compatible with what the RTOS expects (like a plane with a
higher zpos masking its plane), what is the mechanism to reconcile it?

> > And 2) would mean that the display engine is under the R5 control and
> > Linux only gets to fill the plane and let the firmware know of what it
> > wants?
> >=20
>=20
> Here too the partitioning information is pre-decided and remote core
> firmware and device-tree overlay for Linux updated accordingly. But in
> this case as remote core firmware owns the display (minus the plane
> owned by Linux) it is started and initialized during the bootloader
> phase itself where it initializes the DSS and starts rendering using the
> plane owned by it and Linux just latches to the DSS without
> re-initializing it, with write access only to the plane that is owned by
> Linux. You can refer [1] for more details on this.
>
> > If so, do we even need the tidss driver in the second case? We could
> > just write a fwkms driver of some sorts that could be used by multiple
> > implementations of the same "defer to firmware" logic.
> >=20
>=20
> This feature of static partitioning of DSS resources is specific to DSS7
> hardware (which is controlled by tidss driver) which supports dedicated
> register space and interrupt line for each of the hosts [0], so that
> multiple hosts can drive the display controller simultaneously as  per
> the desired static partitioning of resources, and so I don't think a
> separate driver is required here and tidss seems the right place to
> support this, where using this device-tree approach different resource
> partitioning schemas can be achieved as described here [1]. This was
> also aligned with Tomi too where we discussed that tidss is the right
> place to support this as we are simply leveraging the DSS hardware
> capabilities of static partitioning here.

If the only thing tidss does in the "owned by RTOS" is forwarding KMS
atomic states to the RTOS, then I'm still not sure why we need to
involve tidss at all.

It's not just about interrupts, it's also about how your arbitrate
between what Linux wants and what the RTOS wants. Like if the RTOS still
wants to output something but Linux wants to disable it, how do you
reconcile the two?

You have to have something that reconciles both, and typically for
firmware-based setup this will be the firmware's job.

That's very similar to what the RaspberryPi did with fkms, and I believe
that having a generic KMS-on-remoteproc driver when the firmware has
control over the display is the path forward.

> >> For both the cases, the resources used in context of processing core
> >> running Linux along with ownership information are exposed by user as
> >> part of device-tree blob and driver uses an updated feature list tailo=
red
> >> for this shared mode accordingly. The driver also auto-populates
> >> matching overlay managers and output types from shared video
> >> port list provided in device-tree blob.
> >> In dispc_feature struct remove const access specfier for output_type
> >> array as it is required to be updated dynamically in run-time for shar=
ed
> >> mode.
> >=20
> > I'm also not entirely sure that the device tree is the right path there.
> > Surely the firmware capabilities will evolve over time, while the device
> > tree won't. Is there some way to make it discoverable at probe time by
> > the driver?
>
> I think the main highlight of the sharing feature is the hardware
> capability where each host is provided separate irq and register space
> to program display for their display context independently

Wait, what do you mean by display context here?

Maxime

--mec2gkni2rkjd75q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZct21QAKCRDj7w1vZxhR
xcvHAP40dv4AWr1xUiTUL1KMGGWshZE0Hu8pf/vQPrlh7aA+MwEA5FZHpV8kiImZ
cTaxg1C63wAZkBpkb/jDEQI5vhL6ZAI=
=wSAc
-----END PGP SIGNATURE-----

--mec2gkni2rkjd75q--

