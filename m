Return-Path: <linux-kernel+bounces-42542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09C8402D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8178E1C21ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A158108;
	Mon, 29 Jan 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpyBq7uU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6555810D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524335; cv=none; b=KJZtxpqW2+aMiDZwTjaZAllkF8YQ3yDMl/glqB4k/LEtqw+zkLK7TmFoo41uqfI4OG+oec0F1kKtGHbj/KNdQN0NVnVBV9rJ5vKT14qsc5Tz8UtBsxuMhtEjduMpsg/R+6RpWOOnCw05hLD0kI1x/CXFOmeL+SZscAeMEpidzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524335; c=relaxed/simple;
	bh=hSrQeulBJP6f7Cl5YGuj8SjRqojYDcJ3SxASn5yQP/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRUzYlbtDKowUNcJZRuEDiTBX8b1lIWyX9ds9OpJk0RYlHQU6iODMXX+WEGQZOdvudkBKUmhwE6iqbvmlaZZIjC9HWFGLDvsF9anpzwmnEbMug0xfKOXoTX76bvFLXrUheqO+GOups4se5Ql9z2Ith1coD6Z+E1V6n7op/CbmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpyBq7uU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706524332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hSrQeulBJP6f7Cl5YGuj8SjRqojYDcJ3SxASn5yQP/g=;
	b=CpyBq7uUWrgcgqHMBTSPgZyNBrVTgkeC5LH8Mp3tVBtFOMq52Vl7xv2nw6IxNiEeEnZrCo
	6bbkpYc8Rgn/nOiVCPAiUd7BCdcrCq4njpiGWiKOU2XoP6vrLzobZPV8QovcG6PtgxlVc2
	D1oS7WosaIOKeZzhaq1BL0I7qshVDDg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-ezPDptSZMuGkFjM4-_F2-w-1; Mon, 29 Jan 2024 05:32:10 -0500
X-MC-Unique: ezPDptSZMuGkFjM4-_F2-w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ae4fd9c3cso814797f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524329; x=1707129129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSrQeulBJP6f7Cl5YGuj8SjRqojYDcJ3SxASn5yQP/g=;
        b=C2hqgFQIqc3NHzKC9IeTUHqsGCSixEgzMvkGQocdnGNu7cPfYrLMvfYcJXAvcamRZF
         W8pyFDYVKbSIFCGgb03BNly3CTd3Buk0wPPrwNyHRr1+DEcm7xfdRGsJJ+46dnGVWU3H
         tg5mmkliTk2FyiNIfnIbCRzbKesRmYIH1iyzyIImFo9cF00RlsPEZPKyltFWzQ65ug/H
         4VikzH+uimMoxsf22y1XjEm6Vnos7AsoNLB6QlKF9d23xyXBcrQAaEhEZ2REteZKtNda
         2hs9b+MQhFSmqbPk3+HLacDzVLPYfYcMJr2reXrxN/GNbXmbJfEDiVGW+GEdDJVCffPy
         DA+g==
X-Gm-Message-State: AOJu0YyjwLviCoQGAZpbU9yTCgxKhWRz1UWKKl73z1SimQWEpDF1p5wv
	cnTfv5aC8ea6iRaw/Xri0zMmF+TV94IkRp3tKa8aRBet0nIszm6aPj1XLVFjs5eSNXgWLaopKEJ
	Kpt6wDgr9foVzUGNSMr1ml2wjV50Y5QXkc8r2WjlmffKUupj/mXAY3n8Mp71G6g==
X-Received: by 2002:a05:6000:1788:b0:33a:e2fa:6cc8 with SMTP id e8-20020a056000178800b0033ae2fa6cc8mr4401454wrg.38.1706524329648;
        Mon, 29 Jan 2024 02:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF09g2HXpZvz0vVeDKKSoVe4wTKN5Hqy926UbiMg26Ii1Oafi0mU4TDkY2KCAHB2MH6G4kAQQ==
X-Received: by 2002:a05:6000:1788:b0:33a:e2fa:6cc8 with SMTP id e8-20020a056000178800b0033ae2fa6cc8mr4401436wrg.38.1706524329282;
        Mon, 29 Jan 2024 02:32:09 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b0033af093e296sm1535587wrp.15.2024.01.29.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:32:09 -0800 (PST)
Date: Mon, 29 Jan 2024 11:32:08 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lucas Stach <dev@lynxeye.de>, 
	kernel list <linux-kernel@vger.kernel.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	catalin.marinas@arm.com, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	kieran.bingham@ideasonboard.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <xd5ofun26gfdgn7hig3gipj5rgojqyuouwmii7xecgrbzyliil@y6rufxtwdmrc>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
 <Zbd8lOgVqfCrGUL7@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rgbsaoykivldpxmx"
Content-Disposition: inline
In-Reply-To: <Zbd8lOgVqfCrGUL7@duo.ucw.cz>


--rgbsaoykivldpxmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:23:16AM +0100, Pavel Machek wrote:
> Hi!
>=20
> > That's right and a reality you have to deal with on those small ARM
> > systems. The ARM architecture allows for systems that don't enforce
> > hardware coherency across the whole SoC and many of the small/cheap SoC
> > variants make use of this architectural feature.
> >=20
> > What this means is that the CPU caches aren't coherent when it comes to
> > DMA from other masters like the video capture units. There are two ways
> > to enforce DMA coherency on such systems:
> > 1. map the DMA buffers uncached on the CPU
> > 2. require explicit cache maintenance when touching DMA buffers with
> > the CPU
> >=20
> > Option 1 is what you see is happening in your setup, as it is simple,
> > straight-forward and doesn't require any synchronization points.
>=20
> Yeah, and it also does not work :-).
>=20
> Userspace gets the buffers, and it is not really equipped to work with
> them. For example, on pinephone, memcpy() crashes on uncached
> memory. I'm pretty sure user could have some kind of kernel-crashing
> fun if he passed the uncached memory to futex or something similar.

Uncached buffers are ubiquitous on arm/arm64 so there must be something
else going on. And there's nothing to equip for, it's just a memory
array you can access in any way you want (but very slowly).

How does it not work?

> > Option 2 could be implemented by allocating cached DMA buffers in the
> > V4L2 device and then executing the necessary cache synchronization in
> > qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
> > master. However this isn't guaranteed to be any faster, as the cache
> > synchronization itself is a pretty heavy-weight operation when you are
> > dealing with buffer that are potentially multi-megabytes in size.
>=20
> Yes, cache synchronization can be slow, but IIRC it was on order of
> milisecond in the worst case.. and copying megayte images is still
> slower than that.
>=20
> Note that it is faster to do read/write syscalls then deal with
> uncached memory. And userspace can't simply flush the caches and remap
> memory as cached.

You can't change the memory mapping, but you can flush the caches with
dma-buf. It's even required by the dma-buf documentation.

> v4l2 moved away from read/write "because it is slow" and switched to
> interface that is even slower than that. And libcamera exposes
> uncached memory to the user :-(.

There's also the number of copies to consider. If you were to use
read/write to display a frame on a framebuffer, you would use 4 copies
vs 2 with dma-buf.

Maxime

--rgbsaoykivldpxmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbd+qAAKCRDj7w1vZxhR
xTHhAP9A4AyvYSGs0JorWHjsfmCICZAeJOyYv/T4wk5MHI8IzQEAmMs2T3pXgUVp
aoZS4N2vWOpFF9+yrzmpVk/QoucFHgg=
=dyAt
-----END PGP SIGNATURE-----

--rgbsaoykivldpxmx--


