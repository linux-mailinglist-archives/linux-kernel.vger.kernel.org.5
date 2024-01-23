Return-Path: <linux-kernel+bounces-35069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722F838B70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F645B22B01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A35A78B;
	Tue, 23 Jan 2024 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cjGaJdv1"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470905BADB;
	Tue, 23 Jan 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004643; cv=none; b=Ru6DJdMfXLRRUy/LroYsT6OHOdALoqRJZ/HklKGrUh59ORXmOGfYG3k+V+cFer2jwGOD8Qp+1/nKraFE2nrwyoLxPjf/6/sZAHe2ky7hBQNbMw1FtConSG/1fXN8O+kQQptjrRGtwdoXPcxq94FoENzqzDIaohboxP9PMkhkIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004643; c=relaxed/simple;
	bh=mQ8Mr1injx5+4P+73NBjD2yPgs2m4XjU/acM0z55Gp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Re9Z1WcvoRqAJz3XbxyptQQHrCmeLMGASbPcCvMoEs+f1bdqiWco873dl6LLp3j3J/RZe6i7xaoKWssNBpV745ZPxrkH6sGnThOcs734ARxoikmdk3LCM5kpikPxu/HNkatjniY1whRhzWpXSWxub82eGqVLfpKvKN4hxXoyWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=cjGaJdv1; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706004633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q38ONilEN4l7Lhcyl2OEr4G7hBg18u52YIUmCo2B6Gc=;
	b=cjGaJdv1jUmxeSvtoqG8gsHT1XJOxAPyjtF7BS1BBvLCDNUNAK9Rsd5T8muiQ440GnG0sv
	AQkILQIRZgwDRoewyi8T0SbwkMJAKvpId+YNNX/EBav+4rJ7tNDEUVysQBJa9Y3kIAUwxU
	FxAxoaFmXq0uewsAOwxOC1xJvRqel5g=
Message-ID: <e4620acdf24628d904cedcb0030d78b14559f337.camel@crapouillou.net>
Subject: Re: [Linaro-mm-sig] [PATCH v5 1/6] dma-buf: Add
 dma_buf_{begin,end}_access()
From: Paul Cercueil <paul@crapouillou.net>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Daniel
 Vetter <daniel@ffwll.ch>
Date: Tue, 23 Jan 2024 11:10:31 +0100
In-Reply-To: <0b6b8738-9ea3-44fa-a624-9297bd55778f@amd.com>
References: <20240119141402.44262-1-paul@crapouillou.net>
	 <20240119141402.44262-2-paul@crapouillou.net>
	 <8035f515-591f-4c87-bf0a-23d5705d9b1c@gmail.com>
	 <442f69f31ece6d441f3dc41c3dfeb4dcf52c00b8.camel@crapouillou.net>
	 <0b6b8738-9ea3-44fa-a624-9297bd55778f@amd.com>
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

Hi Christian,

Le lundi 22 janvier 2024 =C3=A0 14:41 +0100, Christian K=C3=B6nig a =C3=A9c=
rit=C2=A0:
> Am 22.01.24 um 12:01 schrieb Paul Cercueil:
> > Hi Christian,
> >=20
> > Le lundi 22 janvier 2024 =C3=A0 11:35 +0100, Christian K=C3=B6nig a =C3=
=A9crit=C2=A0:
> > > Am 19.01.24 um 15:13 schrieb Paul Cercueil:
> > > > These functions should be used by device drivers when they
> > > > start
> > > > and
> > > > stop accessing the data of DMABUF. It allows DMABUF importers
> > > > to
> > > > cache
> > > > the dma_buf_attachment while ensuring that the data they want
> > > > to
> > > > access
> > > > is available for their device when the DMA transfers take
> > > > place.
> > > As Daniel already noted as well this is a complete no-go from the
> > > DMA-buf design point of view.
> > What do you mean "as Daniel already noted"? It was him who
> > suggested
> > this.
>=20
> Sorry, I haven't fully catched up to the discussion then.
>=20
> In general DMA-buf is build around the idea that the data can be=20
> accessed coherently by the involved devices.
>=20
> Having a begin/end of access for devices was brought up multiple
> times=20
> but so far rejected for good reasons.

I would argue that if it was brought up multiple times, then there are
also good reasons to support such a mechanism.

> That an exporter has to call extra functions to access his own
> buffers=20
> is a complete no-go for the design since this forces exporters into=20
> doing extra steps for allowing importers to access their data.

Then what about we add these dma_buf_{begin,end}_access(), with only
implementations for "dumb" exporters e.g. udmabuf or the dmabuf heaps?
And only importers (who cache the mapping and actually care about non-
coherency) would have to call these.

At the very least, is there a way to check that "the data can be
accessed coherently by the involved devices"? So that my importer can
EPERM if there is no coherency vs. a device that's already attached.

Cheers,
-Paul

> That in turn is pretty much un-testable unless you have every
> possible=20
> importer around while testing the exporter.
>=20
> Regards,
> Christian.
>=20
> >=20
> > > Regards,
> > > Christian.
> > Cheers,
> > -Paul
> >=20
> > > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > >=20
> > > > ---
> > > > v5: New patch
> > > > ---
> > > > =C2=A0=C2=A0 drivers/dma-buf/dma-buf.c | 66
> > > > +++++++++++++++++++++++++++++++++++++++
> > > > =C2=A0=C2=A0 include/linux/dma-buf.h=C2=A0=C2=A0 | 37 +++++++++++++=
+++++++++
> > > > =C2=A0=C2=A0 2 files changed, 103 insertions(+)
> > > >=20
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-
> > > > buf.c
> > > > index 8fe5aa67b167..a8bab6c18fcd 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -830,6 +830,8 @@ static struct sg_table *
> > > > __map_dma_buf(struct
> > > > dma_buf_attachment *attach,
> > > > =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_mmap()
> > > > =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_begin_cpu_ac=
cess()
> > > > =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_end_cpu_acce=
ss()
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_begin_access()
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_end_access()
> > > > =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_map_attachme=
nt_unlocked()
> > > > =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_unmap_attach=
ment_unlocked()
> > > > =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_vmap_unlocke=
d()
> > > > @@ -1602,6 +1604,70 @@ void dma_buf_vunmap_unlocked(struct
> > > > dma_buf
> > > > *dmabuf, struct iosys_map *map)
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF)=
;
> > > > =C2=A0=C2=A0=20
> > > > +/**
> > > > + * @dma_buf_begin_access - Call before any hardware access
> > > > from/to
> > > > the DMABUF
> > > > + * @attach:	[in]	attachment used for hardware access
> > > > + * @sg_table:	[in]	scatterlist used for the DMA transfer
> > > > + * @direction:=C2=A0 [in]=C2=A0=C2=A0=C2=A0 direction of DMA trans=
fer
> > > > + */
> > > > +int dma_buf_begin_access(struct dma_buf_attachment *attach,
> > > > +			 struct sg_table *sgt, enum
> > > > dma_data_direction dir)
> > > > +{
> > > > +	struct dma_buf *dmabuf;
> > > > +	bool cookie;
> > > > +	int ret;
> > > > +
> > > > +	if (WARN_ON(!attach))
> > > > +		return -EINVAL;
> > > > +
> > > > +	dmabuf =3D attach->dmabuf;
> > > > +
> > > > +	if (!dmabuf->ops->begin_access)
> > > > +		return 0;
> > > > +
> > > > +	cookie =3D dma_fence_begin_signalling();
> > > > +	ret =3D dmabuf->ops->begin_access(attach, sgt, dir);
> > > > +	dma_fence_end_signalling(cookie);
> > > > +
> > > > +	if (WARN_ON_ONCE(ret))
> > > > +		return ret;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(dma_buf_begin_access, DMA_BUF);
> > > > +
> > > > +/**
> > > > + * @dma_buf_end_access - Call after any hardware access
> > > > from/to
> > > > the DMABUF
> > > > + * @attach:	[in]	attachment used for hardware access
> > > > + * @sg_table:	[in]	scatterlist used for the DMA transfer
> > > > + * @direction:=C2=A0 [in]=C2=A0=C2=A0=C2=A0 direction of DMA trans=
fer
> > > > + */
> > > > +int dma_buf_end_access(struct dma_buf_attachment *attach,
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table *sgt, enum
> > > > dma_data_direction dir)
> > > > +{
> > > > +	struct dma_buf *dmabuf;
> > > > +	bool cookie;
> > > > +	int ret;
> > > > +
> > > > +	if (WARN_ON(!attach))
> > > > +		return -EINVAL;
> > > > +
> > > > +	dmabuf =3D attach->dmabuf;
> > > > +
> > > > +	if (!dmabuf->ops->end_access)
> > > > +		return 0;
> > > > +
> > > > +	cookie =3D dma_fence_begin_signalling();
> > > > +	ret =3D dmabuf->ops->end_access(attach, sgt, dir);
> > > > +	dma_fence_end_signalling(cookie);
> > > > +
> > > > +	if (WARN_ON_ONCE(ret))
> > > > +		return ret;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(dma_buf_end_access, DMA_BUF);
> > > > +
> > > > =C2=A0=C2=A0 #ifdef CONFIG_DEBUG_FS
> > > > =C2=A0=C2=A0 static int dma_buf_debug_show(struct seq_file *s, void
> > > > *unused)
> > > > =C2=A0=C2=A0 {
> > > > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > > > index 8ff4add71f88..8ba612c7cc16 100644
> > > > --- a/include/linux/dma-buf.h
> > > > +++ b/include/linux/dma-buf.h
> > > > @@ -246,6 +246,38 @@ struct dma_buf_ops {
> > > > =C2=A0=C2=A0=C2=A0	 */
> > > > =C2=A0=C2=A0=C2=A0	int (*end_cpu_access)(struct dma_buf *, enum
> > > > dma_data_direction);
> > > > =C2=A0=C2=A0=20
> > > > +	/**
> > > > +	 * @begin_access:
> > > > +	 *
> > > > +	 * This is called from dma_buf_begin_access() when a
> > > > device driver
> > > > +	 * wants to access the data of the DMABUF. The
> > > > exporter
> > > > can use this
> > > > +	 * to flush/sync the caches if needed.
> > > > +	 *
> > > > +	 * This callback is optional.
> > > > +	 *
> > > > +	 * Returns:
> > > > +	 *
> > > > +	 * 0 on success or a negative error code on failure.
> > > > +	 */
> > > > +	int (*begin_access)(struct dma_buf_attachment *,
> > > > struct
> > > > sg_table *,
> > > > +			=C2=A0=C2=A0=C2=A0 enum dma_data_direction);
> > > > +
> > > > +	/**
> > > > +	 * @end_access:
> > > > +	 *
> > > > +	 * This is called from dma_buf_end_access() when a
> > > > device
> > > > driver is
> > > > +	 * done accessing the data of the DMABUF. The exporter
> > > > can
> > > > use this
> > > > +	 * to flush/sync the caches if needed.
> > > > +	 *
> > > > +	 * This callback is optional.
> > > > +	 *
> > > > +	 * Returns:
> > > > +	 *
> > > > +	 * 0 on success or a negative error code on failure.
> > > > +	 */
> > > > +	int (*end_access)(struct dma_buf_attachment *, struct
> > > > sg_table *,
> > > > +			=C2=A0 enum dma_data_direction);
> > > > +
> > > > =C2=A0=C2=A0=C2=A0	/**
> > > > =C2=A0=C2=A0=C2=A0	 * @mmap:
> > > > =C2=A0=C2=A0=C2=A0	 *
> > > > @@ -606,6 +638,11 @@ void dma_buf_detach(struct dma_buf
> > > > *dmabuf,
> > > > =C2=A0=C2=A0 int dma_buf_pin(struct dma_buf_attachment *attach);
> > > > =C2=A0=C2=A0 void dma_buf_unpin(struct dma_buf_attachment *attach);
> > > > =C2=A0=C2=A0=20
> > > > +int dma_buf_begin_access(struct dma_buf_attachment *attach,
> > > > +			 struct sg_table *sgt, enum
> > > > dma_data_direction dir);
> > > > +int dma_buf_end_access(struct dma_buf_attachment *attach,
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table *sgt, enum
> > > > dma_data_direction dir);
> > > > +
> > > > =C2=A0=C2=A0 struct dma_buf *dma_buf_export(const struct
> > > > dma_buf_export_info
> > > > *exp_info);
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>=20


