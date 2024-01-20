Return-Path: <linux-kernel+bounces-31640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A649D8331C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF71F22932
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195F87FC;
	Sat, 20 Jan 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JA265L43"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B15170;
	Sat, 20 Jan 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709704; cv=none; b=hvbJLZQhZrZNDpP9jBhcsm/eeSEsP4Y2OuPyWuFaXBx3wUuVkiial0zC5K/NiLeZtVdYXq/6TAuUVSLFK9ZRy4l5fRuCEGHkXoEALfkXPiAkGKvXVKjz8ZhFcHudSsAJL88hUee5gAx96IROx9efyDPsutAeW8SnRKAvGWHPgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709704; c=relaxed/simple;
	bh=W7OnWjDgrb5ZNuxFpvFGDTPEYhVuCP6OSB6O3x5tm3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ktus0gD9mvJpeDSd1KfyWUaQSRFqveZLDhWAwaVumMFphV5zjFlIbozVVv7h9TQ7YauGYeDcdt8JuZEDlpcbHWfWeDNl7R1KnCwv2ELCOhv7p6NQlSFKGVBkpW8EIuuV2BGrNor3n76yrEc9Ic4MWSNmVH8jx4Y3clCvT49Cukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=JA265L43; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705709694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uTRM9d6bvlbWT4CTU/U4qeImT68CpFKTYfre+yx+3OQ=;
	b=JA265L43X+KVrNQQpKTeItKpNrS74hBHSilZLefH+GSdoIa6uDIXf4ZrMKJYw2cM106Vp6
	BQC7TTWrnq9Vj+5LxaM33VHNWqeReEPckoCVSemlDGNc/QfOnOhmwjrJbAGucqHWZWf0ra
	vjxOzGBKes+Jac25P3fz9YBWxAGp9Tk=
Message-ID: <59799a40d8cc425dc5a847a0c8e25730db4fc5c8.camel@crapouillou.net>
Subject: Re: [PATCH v4 1/4] usb: gadget: Support already-mapped DMA SGs
From: Paul Cercueil <paul@crapouillou.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Sat, 20 Jan 2024 01:14:52 +0100
In-Reply-To: <ZaruU5BpQF8SeZZS@lizhi-Precision-Tower-5810>
References: <20240117122646.41616-1-paul@crapouillou.net>
	 <20240117122646.41616-2-paul@crapouillou.net>
	 <ZaruU5BpQF8SeZZS@lizhi-Precision-Tower-5810>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Frank,

Le vendredi 19 janvier 2024 =C3=A0 16:49 -0500, Frank Li a =C3=A9crit=C2=A0=
:
> On Wed, Jan 17, 2024 at 01:26:43PM +0100, Paul Cercueil wrote:
> > Add a new 'sg_was_mapped' field to the struct usb_request. This
> > field
> > can be used to indicate that the scatterlist associated to the USB
> > transfer has already been mapped into the DMA space, and it does
> > not
> > have to be done internally.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > =C2=A0drivers/usb/gadget/udc/core.c | 7 ++++++-
> > =C2=A0include/linux/usb/gadget.h=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A02 files changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/gadget/udc/core.c
> > b/drivers/usb/gadget/udc/core.c
> > index d59f94464b87..9d4150124fdb 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -903,6 +903,11 @@ int usb_gadget_map_request_by_dev(struct
> > device *dev,
> > =C2=A0	if (req->length =3D=3D 0)
> > =C2=A0		return 0;
> > =C2=A0
> > +	if (req->sg_was_mapped) {
> > +		req->num_mapped_sgs =3D req->num_sgs;
> > +		return 0;
> > +	}
> > +
> > =C2=A0	if (req->num_sgs) {
> > =C2=A0		int=C2=A0=C2=A0=C2=A0=C2=A0 mapped;
> > =C2=A0
> > @@ -948,7 +953,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_map_request);
> > =C2=A0void usb_gadget_unmap_request_by_dev(struct device *dev,
> > =C2=A0		struct usb_request *req, int is_in)
> > =C2=A0{
> > -	if (req->length =3D=3D 0)
> > +	if (req->length =3D=3D 0 || req->sg_was_mapped)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	if (req->num_mapped_sgs) {
> > diff --git a/include/linux/usb/gadget.h
> > b/include/linux/usb/gadget.h
> > index a771ccc038ac..c529e4e06997 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -52,6 +52,7 @@ struct usb_ep;
> > =C2=A0 * @short_not_ok: When reading data, makes short packets be
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 treated as errors (queue stops advanci=
ng till cleanup).
> > =C2=A0 * @dma_mapped: Indicates if request has been mapped to DMA
> > (internal)
> > + * @sg_was_mapped: Set if the scatterlist has been mapped before
> > the request
> > =C2=A0 * @complete: Function called when request completes, so this
> > request and
> > =C2=A0 *	its buffer may be re-used.=C2=A0 The function will always be
> > called with
> > =C2=A0 *	interrupts disabled, and it must not sleep.
> > @@ -111,6 +112,7 @@ struct usb_request {
> > =C2=A0	unsigned		zero:1;
> > =C2=A0	unsigned		short_not_ok:1;
> > =C2=A0	unsigned		dma_mapped:1;
> > +	unsigned		sg_was_mapped:1;
>=20
> why not use dma_mapped direclty?

Because of the unmap case. We want to know whether we should unmap or
not.

>=20
> Frank

Cheers,
-Paul

>=20
> > =C2=A0
> > =C2=A0	void			(*complete)(struct usb_ep *ep,
> > =C2=A0					struct usb_request *req);
> > --=20
> > 2.43.0
> >=20


