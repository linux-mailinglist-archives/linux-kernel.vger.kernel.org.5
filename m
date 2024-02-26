Return-Path: <linux-kernel+bounces-80561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363CE866981
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49AE1F219E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF01B966;
	Mon, 26 Feb 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmYCNUXy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883811B81C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708924113; cv=none; b=Zn5Qh+u9tAJIf/Rb4lahDMfws1bvaIauQrbXCtXWWzE6cu+Ft/ikfPcVnsSVxGJ0VJYyC0UHjXY1BjGEARsgueiX9hc2I3gOdAGOt1+509TNrnNwahzjTF4EhCSdUwwGQ3RkhOLwfixe2mZ0a2wIjepKqM7pShsVeoGbFVoMTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708924113; c=relaxed/simple;
	bh=E88zUaazKWvIhjWloT5l/8WyHuvQl96BzJs4ChOIkvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0pEGesH3jRIjGAj9PAYwnNmEDXdF9oYaE9rsduTX/vVoW/Gysh80d0/2QBjo9E6dJ0XPXOgjGUEdebtyfnq1PuxH1wp4+4dxpQZ2/b5L82o2dPqTwAQV/Hj/9QebDvMaZDEKp29wtU+b8OZZhNdas8h6zj4pD1fNjslYwydaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmYCNUXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708924110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0IX1RHQfM6abvabBeCW943C4eGRN4zTgrwGo510uTA=;
	b=RmYCNUXylhNixz5PKIaKZ+8LS5Wha5BkdO4fz62zsfeNhqeEI2djCk1leFvfzqtnHo+hCw
	q8wf4tvgHRrK6ScoxEFJkYq4esNBgAVWWhPGKD8sLP5h2ExJbfErei3GrENmH7VUol0P2z
	XgutJ0FnIQXtMAHAGjWUn1ulbs4Y3Zw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-1Dh2yYWVPo2GT0hAdRQ4Ng-1; Mon, 26 Feb 2024 00:08:18 -0500
X-MC-Unique: 1Dh2yYWVPo2GT0hAdRQ4Ng-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29a9f042643so371853a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708924097; x=1709528897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0IX1RHQfM6abvabBeCW943C4eGRN4zTgrwGo510uTA=;
        b=gqXNXjD7sITLJJPL1v0iGV4lEzqnS4Ww5zTwp/1bByQDZSz75ByQ+GeTCnAB4Txf6U
         r/I447kM30TvHPYuRgWViCTwG/ikOSDzpVZwmqxqmCmT8SbIUjeks6/+V+akYmce4Fmw
         ddijH1wLd/FPE/bu5u6mGUZ7mLKXImkOEUAJZJF+sY/naB87giBtaCS7Kd4H+ziitxc4
         lPDGC/YOuOSt2ykSRBQkVw7pfW4zvvKqIj6W2ek6kQwDFCzdOzSI4rmOu2X/dtv7ZvcQ
         +y9Z14Srcp/WUuseWPT/CDNPqv8iB0QgpIg0Yu0AmoPVa5ZFsA/aqAnSI0O8ax2yuyYo
         igWA==
X-Forwarded-Encrypted: i=1; AJvYcCVZZFhCpWxOFdLbX1VcK84OfH7aIpzDx4zhhZZ/xPXjeiGMBQCno8DqF2LQ3a3jaMoFZUFze/AUdAOYuC1MI7ZaYyYYi4GQt1Gwzpif
X-Gm-Message-State: AOJu0YwBhYxKlt2XQO9shKayasPJMtlbVcBP/Jg4ORPjdPOyLNgx2KHO
	wbV+InSZBrGrvysII/pZedvbLao6ElNI++tacHB+FnM7abA534jpaufFm7BFre4642SSBmH47tY
	LxA0NuN7wk+GW/bQNwsTS/iYTpGEDXStknUqFW5VASTfbbEjzKgYDGgUdwJfxN/t3o2mvMqAGWG
	hbxs/0at564GH75MTqKprBxJghlUPVWADkNEsY
X-Received: by 2002:a17:90a:f682:b0:29a:a3e1:7ab4 with SMTP id cl2-20020a17090af68200b0029aa3e17ab4mr2087473pjb.20.1708924097516;
        Sun, 25 Feb 2024 21:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5E17zVQ3hcFLlFhYUZzlK76i0IGg7C5MCrl1bCx+cf+ujnpkNQXP7sOltv0GVqUnmUVqBMUDafOmfdRV/Ap8=
X-Received: by 2002:a17:90a:f682:b0:29a:a3e1:7ab4 with SMTP id
 cl2-20020a17090af68200b0029aa3e17ab4mr2087458pjb.20.1708924097198; Sun, 25
 Feb 2024 21:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com> <20230723053441-mutt-send-email-mst@kernel.org>
 <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
 <20230724031732-mutt-send-email-mst@kernel.org> <CACGkMEvNqJvLvVqQyrw-5jLDA2RvWkSPfb_RLVZbe_wsM=AK4g@mail.gmail.com>
 <20240222142056-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240222142056-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 13:08:06 +0800
Message-ID: <CACGkMEt=2pqc8rp1wHUhs4Kn_cG1EUKpdxB+STh+80Jw7uOTaA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 25, 2023 at 11:03:11AM +0800, Jason Wang wrote:
> > On Mon, Jul 24, 2023 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jul 24, 2023 at 02:52:49PM +0800, Jason Wang wrote:
> > > > On Mon, Jul 24, 2023 at 2:46=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> > > > > >
> > > > > >
> > > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wro=
te:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin=
 wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nel=
son wrote:
> > > > > > > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Adding cond_resched() to the command waiting loop=
 for a better
> > > > > > > > > > > > > co-operation with the scheduler. This allows to g=
ive CPU a breath to
> > > > > > > > > > > > > run other task(workqueue) instead of busy looping=
 when preemption is
> > > > > > > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > >
> > > > > > > > > > > > This still leaves hung processes, but at least it d=
oesn't pin the CPU any
> > > > > > > > > > > > more.  Thanks.
> > > > > > > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com=
>
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I'd like to see a full solution
> > > > > > > > > > > 1- block until interrupt
> > > > > > > > > >
> > > > > > > > > > Would it make sense to also have a timeout?
> > > > > > > > > > And when timeout expires, set FAILED bit in device stat=
us?
> > > > > > > > >
> > > > > > > > > virtio spec does not set any limits on the timing of vq
> > > > > > > > > processing.
> > > > > > > >
> > > > > > > > Indeed, but I thought the driver could decide it is too lon=
g for it.
> > > > > > > >
> > > > > > > > The issue is we keep waiting with rtnl locked, it can quick=
ly make the
> > > > > > > > system unusable.
> > > > > > >
> > > > > > > if this is a problem we should find a way not to keep rtnl
> > > > > > > locked indefinitely.
> > > > > >
> > > > > > From the tests I have done, I think it is. With OVS, a reconfig=
uration is
> > > > > > performed when the VDUSE device is added, and when a MLX5 devic=
e is
> > > > > > in the same bridge, it ends up doing an ioctl() that tries to t=
ake the
> > > > > > rtnl lock. In this configuration, it is not possible to kill OV=
S because
> > > > > > it is stuck trying to acquire rtnl lock for mlx5 that is held b=
y virtio-
> > > > > > net.
> > > > >
> > > > > So for sure, we can queue up the work and process it later.
> > > > > The somewhat tricky part is limiting the memory consumption.
> > > >
> > > > And it needs to sync with rtnl somehow, e.g device unregistering wh=
ich
> > > > seems not easy.
> > > >
> > > > Thanks
> > >
> > > since when does device unregister need to send cvq commands?
> >
> > It doesn't do this now. But if we don't process the work under rtnl,
> > we need to synchronize with device unregistering.
> >
> > Thanks
>
> But what's not easy about it?

Yes, so I'm wondering if we can simply have the cond_resched() merged
as the first step.

And leave the indefinite wait for future investigation?

Thanks

>
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > > > > > 2- still handle surprise removal correctly by waking =
in that case
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(=
-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/n=
et/virtio_net.c
> > > > > > > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_c=
ommand(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > > > > > >              * into the hypervisor, so the reques=
t should be handled immediately.
> > > > > > > > > > > > >              */
> > > > > > > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &t=
mp) &&
> > > > > > > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > > > > +               cond_resched();
> > > > > > > > > > > > >                     cpu_relax();
> > > > > > > > > > > > > +       }
> > > > > > > > > > > > >
> > > > > > > > > > > > >             return vi->ctrl->status =3D=3D VIRTIO=
_NET_OK;
> > > > > > > > > > > > >      }
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.39.3
> > > > > > > > > > > > >
> > > > > > > > > > > > > _______________________________________________
> > > > > > > > > > > > > Virtualization mailing list
> > > > > > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > > > > > https://lists.linuxfoundation.org/mailman/listinf=
o/virtualization
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>


