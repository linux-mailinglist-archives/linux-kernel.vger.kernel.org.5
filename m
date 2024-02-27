Return-Path: <linux-kernel+bounces-83659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B453869D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4FBB2AE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1D249F5;
	Tue, 27 Feb 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfR4fyGL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F9208AD;
	Tue, 27 Feb 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052913; cv=none; b=X2AP3w3ZCruUoYidzTj3KFH0jhb6odjWgsAEjTXRHZcDIyfCzPaU1f+/EtLDmcreTumSScCBLmPD8i5FUq2/WaTvoeBDU9eu9wRQP3C3vOcvBFqetCTpN/ZHvqsN85eR1negfYzffo6rTn8mJHyRQjkHiLSB+X8opwFKzAH6wDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052913; c=relaxed/simple;
	bh=E3P+/Pu/JFwXdRA5On7mNX59HYdJgkRhGHToAT9Vi40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIftaCQw4IxIu+kKRR7OwkSFN/bfZZKuO7l52yQ9kKQ4r3zdVZq9/kSTkZn7NPEGI3ar37br3KlV2Pl2/EDKnZBdQ6j8SA4zl7OagI++jMFD/fjog1TrBEWUgAogPRkcESbsnELOHx+APN8RjRV37ALmDg1A9hA5pF5IS1o41J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfR4fyGL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so520011166b.3;
        Tue, 27 Feb 2024 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709052910; x=1709657710; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3P+/Pu/JFwXdRA5On7mNX59HYdJgkRhGHToAT9Vi40=;
        b=OfR4fyGLrFAeRcBLeeEvQsNEuKFogGR4t+r6qBZAlISDmKEvql+CS3cR2A/m+CF4TY
         dh9ZctN53JDKMCir7iiyAm8XDJzpszu4AeyZHcqKUXukJRrvkD7oNtfXCMKQb3mzawqG
         Q57E+R3eMl02RkejvgEtkqip3aTn5mrU/K/OWqEn+xktU/Ku/UZzS4FfsKBjuOMGitAP
         aLKqoRiHKrhn61nJPj/A6h2L45dkcrbyCr68I+IV5N5SqFbkYOQYxPHdSDOLARkCHaT5
         H9KWZIYT2R+0Krk9yO+BDcMaaNYpQalAG6tpQ+au/mtQODQddZjDJhSV5/SqDPOCGEpJ
         Cbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052910; x=1709657710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3P+/Pu/JFwXdRA5On7mNX59HYdJgkRhGHToAT9Vi40=;
        b=MqKnrib9RIjl8SN/qFrpJZ/eXREWe2UhDtow1Lq72uImhDpTlMhh0HngLDjWQZZa8+
         rE5r57mSFzqnLiosBhFXVXRES+x0pzSizI8eTinpl+lPMqa1ikE72FLVpzb5LuClN9ci
         5zX4MQ+WPUd9OV3uH4brWhdsWHBQZnBzpTKf3P1jOS5kUEQxXyXAaqvv5UFMDu3uHy9E
         bDNFZNxHb4/jYqkgMx4IHu+hU5E3PZF2Lj78qBI/d+4Q1rUldfuNZ1+niJ/niK6UWSo5
         MksQ3LGTPusLYG8P9JY5+EySPkgm0VjmF23emx511hVFkiMfu3QAIMZI6I95qZSbb/Ro
         AHEw==
X-Forwarded-Encrypted: i=1; AJvYcCUGzq/yAYHZ1QDDeHHgmyftJ2GIpBInpO4uqqDx9YADHHrEXvNfmHp5X+O/tKmD0tWNQspF+LoX/0GYhxFFPGiC6gNrIUUqPvn9S7iu4rKeo0hhTlPVZtL9f9d4W7fEkguhmYkI8XfkVA==
X-Gm-Message-State: AOJu0YzNA65qvJaBhs+8kIeivMvCP1Oy5huOCDphhOtygxdrQTHlGIs/
	DHQnqX0qfxh5wMW8m73HaoGTJD1CW1xRP2DFZGy314HBV5Ec4UxC
X-Google-Smtp-Source: AGHT+IGgkz9gMLdSkT1c2s4FwwOKv3tkCjUdASPcAvBHbgtmS2qxRRbHPVgNiBVanVURTKWSS9DoIQ==
X-Received: by 2002:a17:907:b9c7:b0:a3f:da1c:ae4c with SMTP id xa7-20020a170907b9c700b00a3fda1cae4cmr7538523ejc.54.1709052910006;
        Tue, 27 Feb 2024 08:55:10 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id o4-20020a170906358400b00a3ec0600ddasm938935ejb.148.2024.02.27.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:55:08 -0800 (PST)
Message-ID: <86f2262d059db84070745e299d96dde3e6078220.camel@gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan
	 <saravanak@google.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Date: Tue, 27 Feb 2024 17:55:07 +0100
In-Reply-To: <20240227162422.76a00f11@bootlin.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-3-herve.codina@bootlin.com>
	 <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
	 <20240227162422.76a00f11@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 16:24 +0100, Herve Codina wrote:
> Hi Saravana, Luca, Nuno,
>=20
> On Tue, 20 Feb 2024 16:37:05 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> ...
>=20
> > >=20
> > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > index a9a292d6d59b..5c5f808b163e 100644
> > > --- a/drivers/of/overlay.c
> > > +++ b/drivers/of/overlay.c
> > > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Wait for any ongoing de=
vice link removals before removing some of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nodes
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal();
> > > +=C2=A0=20
> >=20
> > Nuno in his patch[1] had this "wait" happen inside
> > __of_changeset_entry_destroy(). Which seems to be necessary to not hit
> > the issue that Luca reported[2] in this patch series. Is there any
> > problem with doing that?
> >=20
> > Luca for some reason did a unlock/lock(of_mutex) in his test patch and
> > I don't think that's necessary.
>=20
> I think the unlock/lock in Luca's case and so in Nuno's case is needed.
>=20
> I do the device_link_wait_removal() wihout having the of_mutex locked.
>=20
> Now, suppose I do the device_link_wait_removal() call with the of_mutex l=
ocked.
> The following flow is allowed and a deadlock is present.
>=20
> of_overlay_remove()
> =C2=A0 lock(of_mutex)
> =C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal()
>=20
> And, from the workqueue jobs execution:
> =C2=A0 ...
> =C2=A0=C2=A0=C2=A0 device_put()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 some_driver->remove()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_overlay_remove() <--- The j=
ob will never end.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is waiting for of_mutex.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Deadlock
>=20

We may need some input from Saravana (and others) on this. I might be missi=
ng
something but can a put_device() lead into a driver remove callback? Driver=
 code is
not device code and put_device() leads to device_release() which will eithe=
r call the
device=C2=A0->release(), ->type->release() or the class ->dev_release(). An=
d, IMO, calling
of_overlay_remove() or something like that (like something that would lead =
to
unbinding a device from it's driver) in a device release callback would be =
at the
very least very questionable. Typically, what you see in there is of_node_p=
ut() and
things like kfree() of the device itself or any other data.

The driver remove callback should be called when unbinding the device from =
it's
drivers and devlinks should also be removed after device_unbind_cleanup() (=
i.e, after
the driver remove callback).

Having said the above, the driver core has lots of subtleties so, again, I =
can be
missing something. But at this point I'm still not seeing any deadlock...

- Nuno S=C3=A1


