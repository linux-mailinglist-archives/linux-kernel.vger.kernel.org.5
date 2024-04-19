Return-Path: <linux-kernel+bounces-151357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667BE8AAD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DC02828CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715C81730;
	Fri, 19 Apr 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ViHSVXBA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D280BF3;
	Fri, 19 Apr 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525299; cv=none; b=k9UnkIEK77zgSFGi4st0o0vK2mr0NdnsPXvqGbGut9hBH6bPYvTpeQuulTjtwftfnmArotmVCDNidELFrVHNyaQXRfWWeR3Lf5Rm84LfTZ7FYPjEZI5A1IM3SpPp3RrR+O+CuGDhq2y8p82YIyJTBcxE/37WPS+1eh1Sc5nat08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525299; c=relaxed/simple;
	bh=gDPa2MrXoMrXr4as5EkG42RSNIOl7KdjtQco1b6NedI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUOVoPqHUbE5AUnuADWV91ErD6bG9KqNH1m61YeW0XxhCDxiPwkn9MPcigpPjlCYB6SeivZ33mkY+xVbY7jaFO/ZMDrZQku78Z3GU2obIZH03g51cZHRmHo7Q2RlK5g7DCVOK5WfSzhetqCWlGI4Tn2BerzQfVmu75YwykSKdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ViHSVXBA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713525290;
	bh=gDPa2MrXoMrXr4as5EkG42RSNIOl7KdjtQco1b6NedI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViHSVXBAbYwkBpODcua3/KxNbqWdYuqaCwmgFoVbOGT2jEJ90KG6r7f60374Zo4dl
	 ZtU9fExQBKh2P6siEbZi/YR+rG/fdFyu1tdSvM7UNgcqgkCIxl+DVOrqflq44a+dBD
	 2982+1sYXPgiD2P1USZuTMyQkIFIHKDm/WQRJlsSjgmUtH7l53k/rQTwomvycXa10p
	 5dl92dqDvB2AuL13SeW58+AtlYuGIwv5Y8YAZyVCgXid1Bx0Y7SxUlbJd4cTG9IgLT
	 yTcFywZ/SB7eec8nG8iIqLus/Sid92rTf5ShdKG3p9ImGjKPLq15EV+J3KDP/TlzjA
	 z8jr399lFk1KQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A88E3782145;
	Fri, 19 Apr 2024 11:14:50 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E4CBC106139F; Fri, 19 Apr 2024 13:14:49 +0200 (CEST)
Date: Fri, 19 Apr 2024 13:14:49 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>, 
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
Message-ID: <ppwhxcsruclsdrvd6gfxwan3so2shtxyarml5rgi6fo4ukb7bi@a4b5acxh3w65>
References: <20240416053909.256319-1-hpa@redhat.com>
 <20240416053909.256319-5-hpa@redhat.com>
 <sjhe7jvzvrlthf42lipnsnooh3z7vczdcruupsbstmpiujprze@jxwc3lquzvki>
 <a9e8759e-4d30-4923-bcfd-4cd133fe950d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7iifoiplmzvvdow"
Content-Disposition: inline
In-Reply-To: <a9e8759e-4d30-4923-bcfd-4cd133fe950d@redhat.com>


--m7iifoiplmzvvdow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 19, 2024 at 09:37:56AM +0200, Hans de Goede wrote:
> On 4/18/24 2:34 PM, Sebastian Reichel wrote:
> > On Tue, Apr 16, 2024 at 01:39:08PM +0800, Kate Hsuan wrote:
> >> Add a charging_orange_full_green LED trigger and the trigger is based =
on
> >> led_mc_trigger_event() which can set an RGB LED when the trigger is
> >> triggered. The LED will show orange when the battery status is chargin=
g.
> >> The LED will show green when the battery status is full.
> >>
> >> Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c=
5b4a1ad@gmail.com/
> >>
> >> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> >> ---
> >=20
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Thanks. Does this mean your ok with routing this change through the LED t=
ree
> together with the 2 LED core patches adding the new led_mc_trigger_event()
> function this uses ?

Yes.

-- Sebastian

--m7iifoiplmzvvdow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYiUiUACgkQ2O7X88g7
+prOFQ//TjbtkQ0OJWGd6ZCuFNOVohJ1IEGplVxLSx6KRXskQ32PZ9P1gcH7irdF
DShkzHdkeb7M7HmX15+34nuqVQF67HM3lpjmnk1jTzzV+fEy5gUiL/vGvvW/zXQ5
Lf66FfWVW0AJRn9/Rdr8HF9VlS6UWhTzgGC6+x3+1OPUm+zVxC/PV9/68a/bF8rv
RaDvyor5NbEIi5RuJzw+Zkl3gzoQNgc0kG5JUEtlGYhP5wGMdDsJLShAy3KxMKMc
b8SsPw7xeoJjU6NJog3yTwqDFtjHDYaGB68d1LQJyyNUNI3kwl1ZbmP4XuD2W1B4
ChfWvuyhD+O/L5D9SClmEdfWHatATMpiAcNLWMcyCla0E5f1T/zOqlqDLZpxLMx+
heEV5G/ZUHXBQjh6xnGd0TvVf8ikroJQaFKn48zGYLhSK0ve+/h4hMLADUm7lHlb
Ef3+/5c4Y5h7ropk4yLLgN9NBy59lqXXesELGnDF7F5+mM2wEoRlwT7+8y/Olh8Q
OwKl0DY2hmlLjOOick2y/IW3spmdIp39vy5A4JIwWywuMPRR6PJ4pqP6IZ8Ow2Lb
17chbX8TJNu+YXxL+/SxrujcvyuY8e+742pSZYWKaJNHIi/yskHOg2155clAuD3D
k/pCp43naYDabsiqKZQRcN3BRIE5tAo792W76qBnniIUWKHdTb4=
=ClyY
-----END PGP SIGNATURE-----

--m7iifoiplmzvvdow--

