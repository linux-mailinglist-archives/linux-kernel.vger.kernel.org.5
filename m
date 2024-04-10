Return-Path: <linux-kernel+bounces-138142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5589ED36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F8F1C20C64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5F13D60D;
	Wed, 10 Apr 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JMLOm1kE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128C13D52A;
	Wed, 10 Apr 2024 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736533; cv=none; b=DSK01TnmvI0U4Gk6MSuhRI30IUqCGnPsc1++U5zedsNzkAgbldt+O4FyQxnVwhOy4S8ZVqcHz8YSZnaoa8KcnzBiizh23NqGy9Z3SadXqJnPd3GFip8pe9SafUL2rc+uDG9VvTyNRLxHGqup2ReoZCzFFhOgtttlnM0M7EwU+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736533; c=relaxed/simple;
	bh=KS6I4HH8eby4GzV/ULCJd4lnaTez7aBJmrwmmizEjbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov8OOETvstgdIdZqwLxF0DnRa8CIRGx9DapEhEhaldZxegTa8vgys4OO3paoBNq6srZyVL/yuLbUwxlb0DvAKluA5g/kQLD6ABtGq77+/5W1tstGlu5tnT0REASv5v4354FUIIu3YvD3N/PfLlntQ1pjE+Lh3Du38MynVXKegls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JMLOm1kE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712736529;
	bh=KS6I4HH8eby4GzV/ULCJd4lnaTez7aBJmrwmmizEjbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMLOm1kEL4UGwTTkvbkniqxboz1c3WU+iT0aKYh+vBwFiYhw4i+ViTQ8FpgZtPQfS
	 JO6tzsWuk+2EI8DRTCXrpFnPJzdULGwU527HdI5rh14m/f8tUUzOvz+oU7RIadRDrH
	 pImZp8DX3fcFzzExTJi8WfsWjwsJJ3AV+zmHfS5ut3cnOuU8S4xg0buXvu3iaSteQN
	 fqu2jrjsS6QmvXaF4rS84FT2ymOPlCjaIzKV2qfH9wcT76k04Up7OpbXUJ0UfMogqw
	 edP842v5sBEIZDamCfDkV3z0gqiCLynPBKLv3FgDkq/+rxfiupUfQz8VESyy0ASRtq
	 jXC/S9B+y3vig==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B687A3780C13;
	Wed, 10 Apr 2024 08:08:49 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B61D31063262; Wed, 10 Apr 2024 10:08:48 +0200 (CEST)
Date: Wed, 10 Apr 2024 10:08:48 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hermes Zhang <chenhuiz@axis.com>
Cc: Andrew Davis <afd@ti.com>, Hermes Zhang <Hermes.Zhang@axis.com>, 
	kernel@axis.com, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: bq27xxx: Divide the reg cache to each
 register
Message-ID: <i4tusers6p4ofzusgalshmiekfeczfvfvkjrmz42n5saaq2nmy@th6eweffbu6k>
References: <20240306100904.1914263-1-Hermes.Zhang@axis.com>
 <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
 <c3c219ca-e126-42fb-8f20-5df0dec58d7c@ti.com>
 <ff34e22e-702f-acc9-469d-33f092bf20bd@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n3zerunypjlzwp5a"
Content-Disposition: inline
In-Reply-To: <ff34e22e-702f-acc9-469d-33f092bf20bd@axis.com>


--n3zerunypjlzwp5a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 02, 2024 at 10:04:22AM +0800, Hermes Zhang wrote:
> On 2024/4/1 21:57, Andrew Davis wrote:
> > On 4/1/24 8:15 AM, Sebastian Reichel wrote:
> > > [+cc Andrew Davis]
> > >=20
> > > Hello Hermes,
> > >=20
> > > Sorry for the delay. This arrived too close to the 6.9 merge window.
> > > I had a look now and while the patch looks fine to me on a conceptual
> > > level, it did not apply. It looks like you used a pre-2024 kernel tree
> > > to generate the patch against. Please always use something recent base
> > > tree (and ideally use git's --base option to document the used
> > > parent commit).
> > >=20
> > > Other than that I just applied a series from Andrew, which cleans up
> > > the register caching in bq27xxx and removed most registers from the
> > > cache. That's something I did not consider earlier, since I thought
> > > the cache was introduced to fix a different issue. But that was
> > > apparently sbs-battery and not bq27xxx.
> >=20
> > The original BQ27000 device did not have an interrupt pin to signal
> > when important updates to the battery occurred, so early devices
> > using it would have userspace poll those values. As the kernel driver
> > added its own polling for updates, it seems the early driver authors
> > simply decided to cache the values between kernel reads and return
> > those to userspace when it reads.
> >=20
> > This is a problem though for two reasons.
> > 1. If no one is interested in these values the kernel will still poll
> > =A0=A0 them anyway, wasting I2C bus time and power.
> > 2. If userspace is actually interested in some value and so checks it
> > =A0=A0 often, it will only get real updated values when the kernel next
> >    polls, which might not be often enough for some use-cases.
> >=20
> Agree! Also good to know the history.

well, there was another driver, which had to introduce caching to
reduce I2C bus load when userspace polls data too quickly. Since
bq27xxx already had caching, its removal might have regressed some
platform. If nobody complains I'm of course happy with the much
simpler code :)

-- Sebastian

--n3zerunypjlzwp5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYWSQwACgkQ2O7X88g7
+poY8A/9G1KVulGheVYOGNJYFbUgTPbeVzesFW2K4/x1y9k/kk1Y43Afl4uujE/g
94h+7hWylbvYGuJ0MfwbmaokV0J9ST2qsWjRpPBSgm4dw9NVXZ3ks5qHZtRFJJWX
3XHOIaJinQ8JTcU3QUlp0soMgOKl78c+5yAPzSeg8cGsorE1LwNdVgE73VMku+fc
4yPeOsbKxZphsfvPrJkJfA4FanWHqwdIygYxiiqXKIsjz2V/xQmdX+OGR4HwKuqC
B4CIhQx0SgaHr6txIBI0sgpCrhcLNQhwy/5LWH3RRWmKKwkkXmSqLKnHl7DxtHD+
W/45spUkCeRN1izobpXMsh26xwcSLDatJvoCxE3m49SdglI0SjLXpz7jv2er1JWz
xrgVJJ7f+SkXVQMo3sLwJ8ITe18MmyEUn0dT1kvVnDmIulhyXoWXmXXnD1bevwgr
Du2+gxn1ih35eJ0mP3ZnWxeix2OJG+Q5//d73OkY+hQyijOv8rOIKbqD2FwNC+Sc
qXvJxASoKBAz1N/RwkfUe9bxGSuqJtgVjuWD2VAiRGFL92KUBsdlC4phvvThWhb5
Xz774Y67R8RKhBCRZXWIfH/PnHbnZEcOp7jnQngfsBkBhYMGb+7nYhQkcpkZ2KcY
TTYDAqfstI8UMWeRf3tSIeurRciDl6u9PPpTLXyYieytch1LbtY=
=EEZn
-----END PGP SIGNATURE-----

--n3zerunypjlzwp5a--

