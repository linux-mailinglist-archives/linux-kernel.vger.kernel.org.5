Return-Path: <linux-kernel+bounces-69231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC98D858600
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3139DB219A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A6135A5D;
	Fri, 16 Feb 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5c3Tatqj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E7149DF2;
	Fri, 16 Feb 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110579; cv=none; b=Q5gk85H/zQuNVfF+U8gAP4Rm1LDzcrguygtVnR3BSELb7ITmxHzZj5APHfWQaRyjy5yV8TVjACHY6NOAkL6jBhcwtyXrcZnnnHC1yrba423EkFkw8w/4jRAMEZj2EIBzCEyFRB+mPoWcsMzp/tHLLMKo3VJ03YvibwMz2LyRjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110579; c=relaxed/simple;
	bh=DeZ3Orr0jVVRVzTlscOZ+7ltViaJ+hZdtewLDmklOwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=up4OKVa2JgTLoejMRZzRvdVeHxReUViedhKLMaVoWyw6CP/QikjJTXO4gMq4OLHnrInJMzMKpQa7KTglYNgFmLf0WVF7ULAL0gDzbZmmBSrAA7FRnL1/ngft1oEHNs+HXeqSdRtUAagL8cG+F3ZTasblRIEpR1xjONccFFhzC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5c3Tatqj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708110575;
	bh=DeZ3Orr0jVVRVzTlscOZ+7ltViaJ+hZdtewLDmklOwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=5c3TatqjprbCEYgnLKI5ccgyqvIomNAlxyz4gVN28Pr62//sClUOYSz6R8Ocetnmw
	 cjOmqGNSUoKN3YOpocUAZoyt0HSwATBCXXIvIzp3D0boUdflt0T2xyJv5xWLF8hI72
	 RPdx0I3dDgDicAFe2zVbHNd5iFjXackvVAGkSX+t8+KT9n3uBjG4xXdz8a6NSDjnwn
	 /7871Kl03zGobmj4BTB4J0Yii1mPp40xiklrHpUDVy7IvwbzswTBcViKe1Hl2olP+a
	 QDKla0yVyyMQjuTRO8yBHwWw3V14g+Ik8w96e5CgbOVHMe2VmGpEx/Oa7+priyVwsY
	 R7zSAxX6jfd7Q==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D6173780A0B;
	Fri, 16 Feb 2024 19:09:34 +0000 (UTC)
Message-ID: <8d236cbfca8c4ea573d340109387fc804f1a89cd.camel@collabora.com>
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Randy Li <ayaka@soulik.info>
Cc: mchehab@kernel.org, Hsia-Jun Li <randy.li@synaptics.com>, 
 sebastian.fricke@collabora.com, alexious@zju.edu.cn,
 linux-media@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 16 Feb 2024 14:09:31 -0500
In-Reply-To: <27ef9490-a56b-46bf-84bd-bc2ec08896af@xs4all.nl>
References: <20240210180414.49184-1-randy.li@synaptics.com>
	 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
	 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
	 <27ef9490-a56b-46bf-84bd-bc2ec08896af@xs4all.nl>
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

Le jeudi 15 f=C3=A9vrier 2024 =C3=A0 09:41 +0100, Hans Verkuil a =C3=A9crit=
=C2=A0:
> On 15/02/2024 04:16, Randy Li wrote:
> >=20
> > On 2024/2/15 04:38, Nicolas Dufresne wrote:
> > > Hi,
> > >=20
> > > > =C2=A0 media: v4l2-mem2mem: fix mem order in last buf
> > > mem order ? Did you mean call order ?
> > std::memory_order
> > >=20
> > > Le dimanche 11 f=C3=A9vrier 2024 =C3=A0 02:04 +0800, Hsia-Jun Li a =
=C3=A9crit=C2=A0:
> > > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > > >=20
> > > > The has_stopped property in struct v4l2_m2m_ctx is operated
> > > > without a lock protecction. Then the userspace calls to
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 protection=C2=A0=C2=A0 When ?=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ~~
> > Access to those 3 booleans you mentioned later.
> > > > v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
> > > > a critical section issue.
> > > As there is no locking, there is no critical section, perhaps a bette=
r phrasing
> > > could help.
> >=20
> > "concurrent accesses to shared resources can lead to unexpected or erro=
neous behavior, so parts of the program where the shared resource is access=
ed need to be protected in ways that avoid the
> > concurrent access."
> >=20
> > It didn't say we need a lock here.
> >=20
> > > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > > ---
> > > > =C2=A0 drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
> > > > =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media=
/v4l2-core/v4l2-mem2mem.c
> > > > index 75517134a5e9..f1de71031e02 100644
> > > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_=
ctx *m2m_ctx,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vb2_v4l2_buff=
er *vbuf)
> > > > =C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbuf->flags |=3D V4L2_BUF_FLAG_LAST;
> > > > -=C2=A0=C2=A0=C2=A0 vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_D=
ONE);
> > > > -
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_m2m_mark_stopped(m2m_ctx);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_D=
ONE);
> > > While it most likely fix the issue while testing, since userspace mos=
t likely
> > > polls on that queue and don't touch the driver until the poll was sig=
nalled, I
> > > strongly believe this is insufficient. When I look at vicodec and wav=
e5, they
> > > both add a layer of locking on top of the mem2mem framework to fix th=
is issue.
> >=20
> > Maybe a memory barrier is enough. Since vb2_buffer_done() itself would =
invoke the (spin)lock operation.
> >=20
> > When the poll() returns in userspace, the future operation for those th=
ree boolean variables won't happen before the lock.
> >=20
> > > I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by=
 3 booleans
> > > accessed in many places that aren't in any known atomic context. I th=
ink it
> > > would be nice to remove the spurious locking in drivers and try and f=
ix this
> > > issue in the framework itself.
> > I tend to not introduce more locks here. There is a spinlock in m2m_ctx=
 which is a pain in the ass, something we could reuse it to save our CPU bu=
t it just can't be access.
>=20
> I think the root cause is something else.
>=20
> Let me say first of all that swapping the order of the two calls does mak=
e sense:
> before returning the buffer you want to mark the queue as stopped.
>=20
> But the real problem is that for drivers using the mem2mem framework the =
streaming
> ioctls can be serialized with a different lock than the VIDIOC_DE/ENCODER=
_CMD ioctls.
>=20
> The reason for that is that those two ioctls are not marked with INFO_FL_=
QUEUE,
> but I think they should. These ioctls are really part of the streaming io=
ctls
> and should all use the same lock.=20
>=20
> Note that for many drivers the same mutex is used for the streaming ioctl=
s as for
> all other ioctls, but it looks like at least the venus driver uses separa=
te mutexes.
>=20
> With that change in v4l2-core/v4l2-ioctl.c I don't believe any locking is=
 needed,
> since it should always be serialized by the same top-level mutex.
>=20
> The v4l2_ioctl_get_lock() function in v4l2-ioctl.c is the one that select=
s which
> mutex to use for a given ioctl.

There was no way to comply with the spec without accessing that state in th=
e irq
thread in Wave5. In that case, we need to decide if we continue or cancel a
dynamic resolution change.


		if (!v4l2_m2m_has_stopped(m2m_ctx)) {
                        switch_state(inst, VPU_INST_STATE_STOP);

                        if (dec_info.sequence_changed)
                                handle_dynamic_resolution_change(inst);
                        else
                                send_eos_event(inst);

                        flag_last_buffer_done(inst);
                }

That forced us to introduce a spinlock to protect that state in that driver=
.

As for locking cmd_start, that might help, its certainly a behaviour change=
 and
will have to be taken with care. How does the ioctl lock interact with bloc=
king
QBUF notably ?

Nicolas

>=20
> Regards,
>=20
> 	Hans
>=20
> > >=20
> > > Nicolas
> > >=20
> > > > =C2=A0 }
> > > > =C2=A0 EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
> > > > =C2=A0=20
> >=20
>=20
>=20


