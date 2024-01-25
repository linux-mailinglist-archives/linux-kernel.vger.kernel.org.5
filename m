Return-Path: <linux-kernel+bounces-38893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360BD83C7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5D21F20F44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D5129A87;
	Thu, 25 Jan 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="h3bIBrka"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025374E06
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200035; cv=none; b=Gj09WAppKnE8MUpzpoiYUvu2syrRyWC9ysmqugNJV2nQ1zTsa8CWijIaXujlI8JkttQPOzMHnfnSkwzfVRrANtD3Ca3EwNCCTsxQNsxxu01umWdjZ0JyqU2JIk2w3FppJEXQwOgZIERhrtgW5KDpKIdhKi7Y35xozYFYKtntuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200035; c=relaxed/simple;
	bh=+GAO5YWuL7EqUjWOl2U03X6ovBfiXH4yE91ok6yjcAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PRei5zVau7Swyh08biQdZwVLGgdsUUoxCysruoEnhUQZShxGbQt9U3VVwwRvT8WH9o67E49F2l8uUi3nbK2XirI8NRhnxQNcu27L1UjofLXPsPK8f834h1O4a68ERKpNCEvAYLhQjG61XpJihmfnbgF2KdEWKzR0gLaHhV5HzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=h3bIBrka; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-429be992974so38670071cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1706200033; x=1706804833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0kuRjuJnX7Sn5l28ZUPlWUHDNHmw5kV8n1Gjblo8C3g=;
        b=h3bIBrkaG5iAUhBtcu6/WlLzQW+v9gajshc3yWCN191Bgjl2NYPM8HkBRsjd38AYU8
         AtxTdNI6v+uohLB37hsiGw1yOgCBoHVdUTLaAL2K8RJRVE73sG10xo27Mr0MRtrlELrH
         iUVeb+NItcm5kbROKFNjDkBUjKQ7WzDxZS2id4GCX8HA/1FxqSuOyabzcXU4Mcg5Jexb
         moFNuAMk8w9iKDIASPNnOSTYa3y1oTyJ6sajA/50tuKlC0YHvCjbd23S+UHxVGgXCcJo
         8AFRAXoBZniGU6meZhcfIL42IzoJQDBf1uvl9xXuE5ftmuP/8kLO9Qn0RrDdo797IsrE
         zAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200033; x=1706804833;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kuRjuJnX7Sn5l28ZUPlWUHDNHmw5kV8n1Gjblo8C3g=;
        b=AQVKXZrhn10nPU3d8O6yGGmk4Eu9IJpprquJTCqznPDMnJl2HybOGvef9PCZ9GENEi
         rYfQpV+KbWIgJPNPYlF99vsDwWKmALH5BLyj4ZOXkMSyCxFRkNwhxinaJslZ/0annZTt
         QL9gGpvbDlHVy/znKznLjTt1rDSddpGDK4TpMrl6CRrn1kkY/Tlfbv0AVLY6ArpOhmBS
         VpfAgENYpKK+VWToSTFtew5sqPnrm+WFV5HFQrJimekTu3V0uS+W/2YdAB24awck99gS
         Vt6jAE9F+D2apAL8Sdc1e/8p/4UFqWTiWa+NgXzmdEgaiH8tx9supzaXDXVra2y4JWej
         92eQ==
X-Gm-Message-State: AOJu0Yw7mr7o0Yw6yaC/YWLO6tFrgEl41T1NquQOgg8nmJY+dz4jX64X
	FDuN7JgIDZsUla5M97pLovLO8Z610qlMCMlOHd1yqRzAu2N864u0Kup/InkuDAU=
X-Google-Smtp-Source: AGHT+IEfSHEzRRwCKfyojQNEbFEjLJQDcya+Vj7sVhdUOrj/IlMpqvmeK52ZursW0PGkcPCVI0027g==
X-Received: by 2002:a05:6214:19ea:b0:686:ae8f:3ed3 with SMTP id q10-20020a05621419ea00b00686ae8f3ed3mr1500167qvc.66.1706200032714;
        Thu, 25 Jan 2024 08:27:12 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::580])
        by smtp.gmail.com with ESMTPSA id mv9-20020a056214338900b006869e0eed00sm3018044qvb.26.2024.01.25.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:27:12 -0800 (PST)
Message-ID: <7b7170ced40d8fce4456282a87c5f70b66606d9c.camel@ndufresne.ca>
Subject: Re: [PATCH v17 8/8] media: verisilicon: Support deleting buffers on
 capture queue
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, Hans Verkuil
	 <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	kernel@collabora.com
Date: Thu, 25 Jan 2024 11:27:10 -0500
In-Reply-To: <1cd7c504-c384-4c9c-bedd-79cd8aed8484@collabora.com>
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
	 <20240119094944.26763-9-benjamin.gaignard@collabora.com>
	 <56c1410e-7a4c-4913-823d-83b8bc0ac002@xs4all.nl>
	 <1cd7c504-c384-4c9c-bedd-79cd8aed8484@collabora.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 24 janvier 2024 =C3=A0 16:35 +0100, Benjamin Gaignard a =C3=A9c=
rit=C2=A0:
> Le 24/01/2024 =C3=A0 13:52, Hans Verkuil a =C3=A9crit=C2=A0:
> > On 19/01/2024 10:49, Benjamin Gaignard wrote:
> > > Allow to delete buffers on capture queue because it the one which
> > > own the decoded buffers. After a dynamic resolution change lot of
> > > them could remain allocated but won't be used anymore so deleting
> > > them save memory.
> > > Do not add this feature on output queue because the buffers are
> > > smaller, fewer and always recycled even after a dynamic resolution
> > > change.
> > >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > ---
> > >   drivers/media/platform/verisilicon/hantro_drv.c  | 1 +
> > >   drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
> > >   2 files changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/driver=
s/media/platform/verisilicon/hantro_drv.c
> > > index db3df6cc4513..f6b0a676a740 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > > @@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, =
struct vb2_queue *dst_vq)
> > >   	dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > >   	dst_vq->lock =3D &ctx->dev->vpu_mutex;
> > >   	dst_vq->dev =3D ctx->dev->v4l2_dev.dev;
> > > +	src_vq->supports_delete_bufs =3D true;
> > As I mentioned, I remain unconvinced by this. It is just making the API=
 inconsistent
> > since if you support delete_bufs, then why support it for one queue onl=
y and not both?
>=20
> Because the both queues don't handle the same type of data.
> For example for a stateless decoder, for me, it makes sense to allow dele=
te decoded frames
> if they won't be used anymore but that won't makes sense for bitstream bu=
ffers.

I personally think that for stateless and stateful decoder bitstream queue =
this
can be useful. We currently guess the size we need, and there is no way to
allocate bigger ones without the driver forgetting about reference frames.

In stateful, some drivers allow to split the bitstream (I tested wave5 nota=
bly),
but I was told this is not always the case. A bit of a gray zone in that AP=
I,
with lack of capabilities to describe it. On stateless, the entire bitstrea=
m
slice must be in one buffer.

Though, for the asymmetry, most stateful decoders won't allow delete bufs o=
n
capture, because the buffers are registered in the firmware ahead of time. =
wave5
can't even implement create_bufs on capture. We had an argument about havin=
g
create_bufs on only one queue for that specific driver, as we wanted someth=
ing
upstream, we flex to removing create bufs completely. I think the all or no=
thing
rule on per queue create/delete_bufs is not aligned with the reality.

Nicolas
>=20
> >=20
> > >  =20
> > >   	return vb2_queue_init(dst_vq);
> > >   }
> > > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drive=
rs/media/platform/verisilicon/hantro_v4l2.c
> > > index 941fa23c211a..34eab90e8a42 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops =3D =
{
> > >   	.vidioc_dqbuf =3D v4l2_m2m_ioctl_dqbuf,
> > >   	.vidioc_prepare_buf =3D v4l2_m2m_ioctl_prepare_buf,
> > >   	.vidioc_create_bufs =3D v4l2_m2m_ioctl_create_bufs,
> > > +	.vidioc_delete_bufs =3D v4l2_m2m_ioctl_delete_bufs,
> > >   	.vidioc_expbuf =3D v4l2_m2m_ioctl_expbuf,
> > >  =20
> > >   	.vidioc_subscribe_event =3D v4l2_ctrl_subscribe_event,
> > In my view setting vidioc_delete_bufs should enable this feature, and i=
f
> > for some strange reason only one queue support it, then make a wrapper
> > callback that returns an error when used with the wrong queue.
> >=20
> > Also note that patch 6/8 never checks for q->supports_delete_bufs in
> > vb2_core_delete_bufs(), which is wrong!
>=20
> I will fix that in next version.
> Regards,
> Benjamin
>=20
> >=20
> > Regards,
> >=20
> > 	Hans
> >=20
>=20


