Return-Path: <linux-kernel+bounces-74998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A343185E133
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E0B1F25346
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5680635;
	Wed, 21 Feb 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CXA7eNSt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276069D24;
	Wed, 21 Feb 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529557; cv=none; b=tnAdUgB9pZDtZkWaYWysvLcY0CL3tVQ5+8QwL3Cak63vWQb3JF47v0tjt9XVEHqtvSxdjFiovkY4xummg3/IODozCnH4iVyrTMfEObeEkwEjQkG05RXUafJNUXN/VVouBjTMDgrOGYzhS4dwboEgXthejzxsP/u6z+L7cJaIkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529557; c=relaxed/simple;
	bh=TIGZ/MJ9Xb2fxnaDoPfLZV6ZzJ6jOXsj8FiH4J88P88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ukGqbUH+9uNXInpxfxs/SLzMczQZpQYNgu5S0ezUxdjEknF/Oh/hyLRzHWn/HMrzq5wwZo0T0of1PHMZGayHsY5U4xllRkdUlvPuufAM6nPoSZKmPXoqQg04jdBXMhnzpG22mNHTsARmL+3/hoEU5B49uYhjvHRdXZRRgFTN0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CXA7eNSt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708529554;
	bh=TIGZ/MJ9Xb2fxnaDoPfLZV6ZzJ6jOXsj8FiH4J88P88=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CXA7eNStnO0KMyf9ndp3Zy68MJQtJgg/SgXkikjuXJ0eBBsjb1PWGJRIL4F9l15a5
	 URsnbK28uPFn4dwVLzLJJscEuqeufXj2PPz8H0rxgJMdF+jrriR6NyEzuyQVlnWe2L
	 sSHs7HI6+6ymwsYN/Q404lHDbcqPtU2O3sc+g5Hk8xrwrU6tXD5xCQ8M4YMtXXUJX8
	 9cQ3EWtMmFs5cBwMw1tQ4uT3SMDuohZ8diW1sMKUZbkC2NKj2yxRX+Lm90U2xpuG1A
	 2XVM6CjbX2bd30tV3x9F93cSPLlr71en9l/Q9qhTTEEMguotrABVnS3bv7WEvjhBem
	 IJA0wQqqH1t/g==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BFAAE3781116;
	Wed, 21 Feb 2024 15:32:32 +0000 (UTC)
Message-ID: <2a6be79192fdd12eaee182dceb8f1cdf0fc1bd8f.camel@collabora.com>
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Hsia-Jun Li <Randy.Li@synaptics.com>, Hans Verkuil
	 <hverkuil-cisco@xs4all.nl>
Cc: mchehab@kernel.org, sebastian.fricke@collabora.com, Randy Li
	 <ayaka@soulik.info>, alexious@zju.edu.cn, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 10:32:29 -0500
In-Reply-To: <e5b1db79-7fb2-4e51-bb93-73f31bbd8804@synaptics.com>
References: <20240210180414.49184-1-randy.li@synaptics.com>
	 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
	 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
	 <27ef9490-a56b-46bf-84bd-bc2ec08896af@xs4all.nl>
	 <8d236cbfca8c4ea573d340109387fc804f1a89cd.camel@collabora.com>
	 <e5b1db79-7fb2-4e51-bb93-73f31bbd8804@synaptics.com>
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

Le mercredi 21 f=C3=A9vrier 2024 =C3=A0 18:37 +0800, Hsia-Jun Li a =C3=A9cr=
it=C2=A0:
>=20
> On 2/17/24 03:09, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Le jeudi 15 f=C3=A9vrier 2024 =C3=A0 09:41 +0100, Hans Verkuil a =C3=A9=
crit :
> > > On 15/02/2024 04:16, Randy Li wrote:
> > > >=20
> > > > On 2024/2/15 04:38, Nicolas Dufresne wrote:
> > > > > Hi,
> > > > >=20
> > > > > >    media: v4l2-mem2mem: fix mem order in last buf
> > > > > mem order ? Did you mean call order ?
> > > > std::memory_order
> > > > >=20
> > > > > Le dimanche 11 f=C3=A9vrier 2024 =C3=A0 02:04 +0800, Hsia-Jun Li =
a =C3=A9crit :
> > > > > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > > > > >=20
> > > > > > The has_stopped property in struct v4l2_m2m_ctx is operated
> > > > > > without a lock protecction. Then the userspace calls to
> > > > >                    protection   When ?                   ~~
> > > > Access to those 3 booleans you mentioned later.
> > > > > > v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
> > > > > > a critical section issue.
> > > > > As there is no locking, there is no critical section, perhaps a b=
etter phrasing
> > > > > could help.
> > > >=20
> > > > "concurrent accesses to shared resources can lead to unexpected or =
erroneous behavior, so parts of the program where the shared resource is ac=
cessed need to be protected in ways that avoid the
> > > > concurrent access."
> > > >=20
> > > > It didn't say we need a lock here.
> > > >=20
> > > > > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > > > > ---
> > > > > >    drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
> > > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/m=
edia/v4l2-core/v4l2-mem2mem.c
> > > > > > index 75517134a5e9..f1de71031e02 100644
> > > > > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > > > @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_=
m2m_ctx *m2m_ctx,
> > > > > >                       struct vb2_v4l2_buffer *vbuf)
> > > > > >    {
> > > > > >        vbuf->flags |=3D V4L2_BUF_FLAG_LAST;
> > > > > > -    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
> > > > > > -
> > > > > >        v4l2_m2m_mark_stopped(m2m_ctx);
> > > > > > +
> > > > > > +    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
> > > > > While it most likely fix the issue while testing, since userspace=
 most likely
> > > > > polls on that queue and don't touch the driver until the poll was=
 signalled, I
> > > > > strongly believe this is insufficient. When I look at vicodec and=
 wave5, they
> > > > > both add a layer of locking on top of the mem2mem framework to fi=
x this issue.
> > > >=20
> > > > Maybe a memory barrier is enough. Since vb2_buffer_done() itself wo=
uld invoke the (spin)lock operation.
> > > >=20
> > > > When the poll() returns in userspace, the future operation for thos=
e three boolean variables won't happen before the lock.
> > > >=20
> > > > > I think this is unfortunate, but v4l2_m2m_mark_stopped() is backe=
d by 3 booleans
> > > > > accessed in many places that aren't in any known atomic context. =
I think it
> > > > > would be nice to remove the spurious locking in drivers and try a=
nd fix this
> > > > > issue in the framework itself.
> > > > I tend to not introduce more locks here. There is a spinlock in m2m=
_ctx which is a pain in the ass, something we could reuse it to save our CP=
U but it just can't be access.
> > >=20
> > > I think the root cause is something else.
> > >=20
> > > Let me say first of all that swapping the order of the two calls does=
 make sense:
> > > before returning the buffer you want to mark the queue as stopped.
> > >=20
> > > But the real problem is that for drivers using the mem2mem framework =
the streaming
> > > ioctls can be serialized with a different lock than the VIDIOC_DE/ENC=
ODER_CMD ioctls.
> > >=20
> > > The reason for that is that those two ioctls are not marked with INFO=
_FL_QUEUE,
> > > but I think they should. These ioctls are really part of the streamin=
g ioctls
> > > and should all use the same lock.
> > >=20
> > > Note that for many drivers the same mutex is used for the streaming i=
octls as for
> > > all other ioctls, but it looks like at least the venus driver uses se=
parate mutexes.
> > >=20
>=20
> But I saw many drivers didn't assign that q_lock here. I am an one.
> Since it is an optional mutex lock.
>=20
> > > With that change in v4l2-core/v4l2-ioctl.c I don't believe any lockin=
g is needed,
> > > since it should always be serialized by the same top-level mutex.
> > >=20
> > > The v4l2_ioctl_get_lock() function in v4l2-ioctl.c is the one that se=
lects which
> > > mutex to use for a given ioctl.
> >=20
> > There was no way to comply with the spec without accessing that state i=
n the irq
> > thread in Wave5. In that case, we need to decide if we continue or canc=
el a
> > dynamic resolution change.
> >=20
> >=20
> >                  if (!v4l2_m2m_has_stopped(m2m_ctx)) {
> >                          switch_state(inst, VPU_INST_STATE_STOP);
> >=20
> >                          if (dec_info.sequence_changed)
> >                                  handle_dynamic_resolution_change(inst)=
;
> >                          else
> >                                  send_eos_event(inst);
> >=20
> >                          flag_last_buffer_done(inst);
> >                  }
> >=20
> > That forced us to introduce a spinlock to protect that state in that dr=
iver.
> >=20
> Usually we won't do buffer operation in the irq handler context. It=20
> causes too many times,

I took this one out of context, but this is inside a threaded IRQ handle, w=
e
indeed have too much work and state to match with how Wave5 firmware behave=
 As
discuss on IRC, not being able to see the Synaptics driver you are referrin=
g to
has its limitation.

>=20
> But that makes a point. Sometimes, I can't just introduce that a mutex,=
=20
> while most of the m2m context has acquired a spinlock.

In wave5, we had to use a spinlock as the framework holds its own spinlock =
while
calling job_ready() (can't mix lock mutex while a spinlock is held), and we=
 need
thread safety in that call in order to use that state to make the right
decisions. On agressive stress test, we were getting stalls due to decision=
s
being made with partially written state.

> > As for locking cmd_start, that might help, its certainly a behaviour ch=
ange and
> > will have to be taken with care. How does the ioctl lock interact with =
blocking
> > QBUF notably ?
> >=20
> > Nicolas
> >=20
> > >=20
> > > Regards,
> > >=20
> > >        Hans
> > >=20
> > > > >=20
> > > > > Nicolas
> > > > >=20
> > > > > >    }
> > > > > >    EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
> > > > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
>=20


