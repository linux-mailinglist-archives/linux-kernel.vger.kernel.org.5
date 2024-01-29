Return-Path: <linux-kernel+bounces-42543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432288402D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D18282BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB864C61D;
	Mon, 29 Jan 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="iGwIEb/j"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72856475
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524403; cv=none; b=YLASObI0jgV+H9YXQfPCP1Xa3IyuJgNU5R5YVgvd1wT/vscEctnLJ/cW21MvW3g6USj5KN+4huKudX5IQkCye4+4X+FjZGjRtE5gEVrYvt+L5c7QRZqGvlGtsXEVIfFF/+UJJ1Fzqu1x2IqTAwBMx4FlflSFPxEtEmee2j1fp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524403; c=relaxed/simple;
	bh=sh2kS7ao1/TGPIDk4Rpb1+FLli8hLQuDbSYnDXLSoAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyApbYgi/DpHxui7JwVFQlsjzCoS+KXP/mbdquuEA4ghCMGut9lBnaV3LqaUqnG3iqU11y1k+T+WHUii6eQH498cZxxXKNx/BJljpW6jOv7B5AJErR8MBLQxSjCe7D5ArNSpRjhKxW494OSOM46GRfKe061r3gjn/QzPJgqVDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=iGwIEb/j; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 455881C006B; Mon, 29 Jan 2024 11:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706523797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eoSahHYTkU3Tn0SlA1bbHgPGiJsJnoBjGx+t0D+Ut34=;
	b=iGwIEb/jD2rK0jntF/mW3aSeHxHroaMF31tiTVH8UO6uxtg/B7pAlf4YoklBl+PxBc+Wfu
	tU1vazLkLx5N2PyHgidcKapqY9jQ8rgcj3nRnBj+y3hWYblj1IAr9my/bevvgEh/+CkNmO
	bXg4exmibukyj+YpasWym1HREaMjzNo=
Date: Mon, 29 Jan 2024 11:23:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lucas Stach <dev@lynxeye.de>,
	kernel list <linux-kernel@vger.kernel.org>
Cc: Milan Zamazal <mzamazal@redhat.com>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	catalin.marinas@arm.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>,
	Maxime Ripard <mripard@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kieran.bingham@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <Zbd8lOgVqfCrGUL7@duo.ucw.cz>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hnxbezOAcVndUORq"
Content-Disposition: inline
In-Reply-To: <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>


--hnxbezOAcVndUORq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> That's right and a reality you have to deal with on those small ARM
> systems. The ARM architecture allows for systems that don't enforce
> hardware coherency across the whole SoC and many of the small/cheap SoC
> variants make use of this architectural feature.
>=20
> What this means is that the CPU caches aren't coherent when it comes to
> DMA from other masters like the video capture units. There are two ways
> to enforce DMA coherency on such systems:
> 1. map the DMA buffers uncached on the CPU
> 2. require explicit cache maintenance when touching DMA buffers with
> the CPU
>=20
> Option 1 is what you see is happening in your setup, as it is simple,
> straight-forward and doesn't require any synchronization points.

Yeah, and it also does not work :-).

Userspace gets the buffers, and it is not really equipped to work with
them. For example, on pinephone, memcpy() crashes on uncached
memory. I'm pretty sure user could have some kind of kernel-crashing
fun if he passed the uncached memory to futex or something similar.

> Option 2 could be implemented by allocating cached DMA buffers in the
> V4L2 device and then executing the necessary cache synchronization in
> qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
> master. However this isn't guaranteed to be any faster, as the cache
> synchronization itself is a pretty heavy-weight operation when you are
> dealing with buffer that are potentially multi-megabytes in size.

Yes, cache synchronization can be slow, but IIRC it was on order of
milisecond in the worst case.. and copying megayte images is still
slower than that.

Note that it is faster to do read/write syscalls then deal with
uncached memory. And userspace can't simply flush the caches and remap
memory as cached.

v4l2 moved away from read/write "because it is slow" and switched to
interface that is even slower than that. And libcamera exposes
uncached memory to the user :-(.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--hnxbezOAcVndUORq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbd8lAAKCRAw5/Bqldv6
8iYKAJ0cTLemxbgoFmela6/AGCR4/hC6PgCglJC5fmhFvpx6Hd9/0aGqZxh0V/I=
=AF/b
-----END PGP SIGNATURE-----

--hnxbezOAcVndUORq--

