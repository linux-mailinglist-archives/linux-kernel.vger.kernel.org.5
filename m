Return-Path: <linux-kernel+bounces-43310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1E8411FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513931F268B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F012E7E;
	Mon, 29 Jan 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="q6idbMu/"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0414290
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553035; cv=none; b=TgPEo712yBAasP82aAw0rK/TEaYPK8bA+ECRTYdVFkhRdDz7VxGd9SvhqX62nwHiKvAHpGcIZrHrUyfOYULe/RnIAkc11vMK6dOHy/1ycmIGYpHLYKHQ9op+XnodHRFX0LkDs6jHVuyO0GSq5t23a+JolgKTe6qi7AhBTImFBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553035; c=relaxed/simple;
	bh=2hXpmnPs2/nJB/+GRiV+/+t4+w9O80b41ABbW9prIic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6ECKhFZHlw6qr9H09dMlnfBEOPn0CUzPwHVjLbwzdLZ61S61wghT6gSyFEMc1UYCf+7vdnWqGtGtRxMIfkJ8E6qNiddk97N64iRm0oUDotPHyIM+DfKzkRP6cXlaK5AGnI4CDnsbbktXDDlNd6Ed8DlBzkNdMW04povcxqsHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=q6idbMu/; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0AF441C0050; Mon, 29 Jan 2024 19:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706553030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMevwOcR//91ifPHNyoWBbf+pgyJoGwBKJoFFWSxemQ=;
	b=q6idbMu/0GQVL2QXhPiXjJ3Q55PNEBKcntxQbO9hLgqR7YAPXquJ3XXvGW8OSbtdhPtCFq
	ow+dJFqZPnj5Amo1qY+BThnpDm9tzeeUDVZfv8wN2UmZ74ISP4uqy+xDbUky6niv+LmkMA
	S+PbnLQsOzRNuEHujwgmHWCr7OukAzY=
Date: Mon, 29 Jan 2024 19:30:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Maxime Ripard <mripard@redhat.com>
Cc: Lucas Stach <dev@lynxeye.de>,
	kernel list <linux-kernel@vger.kernel.org>,
	Milan Zamazal <mzamazal@redhat.com>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	catalin.marinas@arm.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kieran.bingham@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <ZbfuxUHlY3oblC5f@duo.ucw.cz>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
 <Zbd8lOgVqfCrGUL7@duo.ucw.cz>
 <xd5ofun26gfdgn7hig3gipj5rgojqyuouwmii7xecgrbzyliil@y6rufxtwdmrc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KRzS5zbXW8lXfnR6"
Content-Disposition: inline
In-Reply-To: <xd5ofun26gfdgn7hig3gipj5rgojqyuouwmii7xecgrbzyliil@y6rufxtwdmrc>


--KRzS5zbXW8lXfnR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Yeah, and it also does not work :-).
> >=20
> > Userspace gets the buffers, and it is not really equipped to work with
> > them. For example, on pinephone, memcpy() crashes on uncached
> > memory. I'm pretty sure user could have some kind of kernel-crashing
> > fun if he passed the uncached memory to futex or something similar.
>=20
> Uncached buffers are ubiquitous on arm/arm64 so there must be something
> else going on. And there's nothing to equip for, it's just a memory
> array you can access in any way you want (but very slowly).

Not really. Not on anything modern.

ll/sc will not work, for example, than's on ARM.
https://en.wikipedia.org/wiki/Load-link/store-conditional
Transactional memory will not work, that was on x86. Powerpc has
cacheline clearing instruction.

And that's design, I'm pretty sure there are also numerous CPU errata.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--KRzS5zbXW8lXfnR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbfuxQAKCRAw5/Bqldv6
8jQdAKCN7cYrDkN//ulxW3YxeSqNq+i64ACfULxt7SizbmTw+uIP9DctYlZ3YaY=
=b10z
-----END PGP SIGNATURE-----

--KRzS5zbXW8lXfnR6--

