Return-Path: <linux-kernel+bounces-69216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC08585DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A52863A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F7135A41;
	Fri, 16 Feb 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L0he4KWH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156C1353F6;
	Fri, 16 Feb 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109814; cv=none; b=UGbPy9HesBeiGwP/vLPtiC+WHZ0yRJDObCTMiV/Jt3eQM+aJL1OwYAj4zwshkeTaYnuyfiUmdoNCsROw6yUQecCX2a+tgI5LDuLklmSqzlpxsop+TZni7fwHUUwPJcPpuP501MiDMlOr2fjYUMJs1swXxyUKK3PXMDsq2k6Qeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109814; c=relaxed/simple;
	bh=kN4EyX5AD0+0cHzU2MjpcTihUyV9EQjCifXxKHOS9h4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/nzU0BzQKmXwu6zUCPuGEPnk8zJxqehSBlnwtPIpZnlxnDs7I9x80g2p+ECyILCCUp86HAnLU+0yE3V7AtaA42WJOy5XVB+rVGUiylu4dGxW5iqEnltw8FzXZ5/yKZnFIU7UjcbwLhZGwME56UcReHoZH9Vc/pj96pYsdZVHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L0he4KWH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708109811;
	bh=kN4EyX5AD0+0cHzU2MjpcTihUyV9EQjCifXxKHOS9h4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L0he4KWHR7q8+EvoeqmtnDbY2OgMSDL1OfBgQqsSXHF0HB8HXnstV6rWz9ThQPDvJ
	 x/k1l9tAec7fTbbGiA6aU1Y+HjhzgpN3xXisYyN4f5dVC+gJKznuCtZpry6PatM1u4
	 iDhfuFaMQV1E+uwLEvPUnwic7A0nY6iQ4O+IG0+0nm66AhnlwqQpIAK6t3Te91IKpe
	 KCkoekcij6IOBE3H208gjtSBXa2YEFGMcIC6V5/29odbirCOge5CvbweWOPOEf2Da+
	 ngdgjIygfOSQaykM2QK5QzRGfyrqF2cOnyRi4wq6yEdn6NQ4OyZdr7yljeHJ2+TWxN
	 k3ReS8qTR297A==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7DFFA3780A0B;
	Fri, 16 Feb 2024 18:56:49 +0000 (UTC)
Message-ID: <30e44b19731c4821fdf325689482671f90389100.camel@collabora.com>
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Randy Li <ayaka@soulik.info>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, Hsia-Jun Li
 <randy.li@synaptics.com>, sebastian.fricke@collabora.com,
 alexious@zju.edu.cn,  linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 16 Feb 2024 13:56:46 -0500
In-Reply-To: <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
References: <20240210180414.49184-1-randy.li@synaptics.com>
	 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
	 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 15 f=C3=A9vrier 2024 =C3=A0 11:16 +0800, Randy Li a =C3=A9crit=C2=
=A0:
> On 2024/2/15 04:38, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > >   media: v4l2-mem2mem: fix mem order in last buf
> > mem order ? Did you mean call order ?
> std::memory_order
> >=20
> > Le dimanche 11 f=C3=A9vrier 2024 =C3=A0 02:04 +0800, Hsia-Jun Li a =C3=
=A9crit=C2=A0:
> > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > >=20
> > > The has_stopped property in struct v4l2_m2m_ctx is operated
> > > without a lock protecction. Then the userspace calls to
> >                   protection   When ?                   ~~
> Access to those 3 booleans you mentioned later.

There were commenting you commit message typos, not a question.

> > > v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
> > > a critical section issue.
> > As there is no locking, there is no critical section, perhaps a better =
phrasing
> > could help.
>=20
> "concurrent accesses to shared resources can lead to unexpected or=20
> erroneous behavior, so parts of the program where the shared resource is=
=20
> accessed need to be protected in ways that avoid the concurrent access."
>=20
> It didn't say we need a lock here.

I said it.

>=20
> > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > ---
> > >   drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v=
4l2-core/v4l2-mem2mem.c
> > > index 75517134a5e9..f1de71031e02 100644
> > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ct=
x *m2m_ctx,
> > >   			       struct vb2_v4l2_buffer *vbuf)
> > >   {
> > >   	vbuf->flags |=3D V4L2_BUF_FLAG_LAST;
> > > -	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
> > > -
> > >   	v4l2_m2m_mark_stopped(m2m_ctx);
> > > +
> > > +	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
> > While it most likely fix the issue while testing, since userspace most =
likely
> > polls on that queue and don't touch the driver until the poll was signa=
lled, I
> > strongly believe this is insufficient. When I look at vicodec and wave5=
, they
> > both add a layer of locking on top of the mem2mem framework to fix this=
 issue.
>=20
> Maybe a memory barrier is enough. Since vb2_buffer_done() itself would=
=20
> invoke the (spin)lock operation.
>=20
> When the poll() returns in userspace, the future operation for those=20
> three boolean variables won't happen before the lock.
>=20
> > I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3=
 booleans
> > accessed in many places that aren't in any known atomic context. I thin=
k it
> > would be nice to remove the spurious locking in drivers and try and fix=
 this
> > issue in the framework itself.
> I tend to not introduce more locks here. There is a spinlock in m2m_ctx=
=20
> which is a pain in the ass, something we could reuse it to save our CPU=
=20
> but it just can't be access.

If you can find a way with memory barrier, but that is difficult to maintai=
n and
often breaks without noticing. I'm happy to review something that introduce
thread safety rather then depending on userspace call order. Can't disagree=
 with
the spinlock, its been difficult in Wave5 and there is still a bug report o=
f one
more case were we get that spinlock mixed with mutex.

Nicolas

> >=20
> > Nicolas
> >=20
> > >   }
> > >   EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
> > >  =20
>=20


