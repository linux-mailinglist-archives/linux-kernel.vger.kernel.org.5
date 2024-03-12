Return-Path: <linux-kernel+bounces-99859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF7878E70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA40B2144B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F03C489;
	Tue, 12 Mar 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVZIX6dz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDC2E3F9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223669; cv=none; b=WtvdFh7xELRYtBxatzCOiUvhvdXDuD/1pMBzeSTePCI0q6+kYpfbzVelhVR/OMRoYrTNTog1/r5CSMcjvAfm/XMfdkgbnQEsM53tmXpE895ItP9JYaHAcTSmb8+xKWiM2762BLs4P9sZMxfmoSHQQI42t+AxJwh0+hjOxjUqLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223669; c=relaxed/simple;
	bh=PTdTvm1gihWmj2A9wZ5KGWd6ya8Pjh9Na9nVriRC1dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ss8F+EZXbTNshmhEITYEv2UWgq7LAyffu90QYPuqZwKhH9xTfyXVGTZdJ6aEhLkzNR/qCITNl3KkuI6itteZZZJPJQ42qyt/BOP+i3pereEXv2fLuIL3LrAyf7UTdOm+iE+e968nGQR6WG0O5Lgmgtfls4s1dx/2d4L4HfYwttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVZIX6dz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710223665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe4EbmT41+TcmJNou990mGnBVPpAGD8crZiGRLHTImg=;
	b=UVZIX6dzIXeg3SnF0j7vaQzLo2M1VWAo2FJhcrnHKDxCEnTuy8irHqwxNjddOSBSCbJPGr
	M05QCRykaP52fpfDhH5yQlW0+xwwIMW/zAEhTv06Qr4mY6Tjl4fKFJHlGqCuYOFsbkW6Hj
	yGg21wUemxk5+2076k+AYXPV/Ps7CA8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-DQmeK_5JPAWniE9UFm29RQ-1; Tue, 12 Mar 2024 02:07:44 -0400
X-MC-Unique: DQmeK_5JPAWniE9UFm29RQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29becb867fbso1883927a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710223663; x=1710828463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe4EbmT41+TcmJNou990mGnBVPpAGD8crZiGRLHTImg=;
        b=YWLbw6OLYZ4UCO4DYlNqfz/+LNF2ZrMU+ZoRkIsZuqrqJwzu187nUwgoc/aRLLVeGp
         Y8zPaSQbu2OeeCa6uhfEbN+7uAsNnpaYZkzZIVcxawJ78/PCOckrZFfKAgICq1KJ8nW2
         6ciVZJ4voWvL4tRL2fHCajEdw7hY4hp4Iph77LyOw/haOVi6nW1UzLSk5CNusJ9R02GB
         HPY6bI6xt1F5oWSrcPAxJftN5VspPYgKDRPUX0rqwbcQKorJiZEG4BW18vKm19NXem7H
         hsJi7pMtOpQ6kpfHbSy1nQvtaIJpURT4gaMlp7nLBJ0Ail7yPpQhy2zgSRGRct2BmOD9
         DRfA==
X-Forwarded-Encrypted: i=1; AJvYcCVKoVhKyAiTfnB4Vna4g+UI3cUZRJX0abPGYA3Fd6YxCP1KAZVwobWUIXBHDVzhDHY2Y58ztyDdygeU8PXtw+NXNvwCnXu1sV3qOiUb
X-Gm-Message-State: AOJu0Yx0kksXjjHfZjBv8pRvUX5nNP5LqwOXhUCe0itsf0fAArDYUylp
	8YGQhLHgL0Jg46+EFEVepT3qNwU6nwdsdw+CChQRv7sDsjdtIxyx/tCZA8Qvz571fyA4m5jlvtO
	oBLsRWx0oUK1aFUztVc6kpu7s1unICDrJch/kTpN3+Ea0bFxpekMigcQ7S0brzsAZTBl/7NxRNX
	zTlY08vhsNVqiClh4LAx/YcsV2PfYfd2Hr7ubl
X-Received: by 2002:a17:90a:3d06:b0:29a:11b6:a333 with SMTP id h6-20020a17090a3d0600b0029a11b6a333mr1039624pjc.15.1710223662613;
        Mon, 11 Mar 2024 23:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJAuKuTdA7O1bxTxUGVhEFv5wsTqjcI6QQBOZAKTpT2+1JFNQ/kmbSWyhg8bodc3jlj4YE/hvcvaeorc/BjuU=
X-Received: by 2002:a17:90a:3d06:b0:29a:11b6:a333 with SMTP id
 h6-20020a17090a3d0600b0029a11b6a333mr1039607pjc.15.1710223662289; Mon, 11 Mar
 2024 23:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <7d478cb842e28094f4d6102e593e3de25ab27dfe.camel@redhat.com>
 <223aeca6435342ec8a4d57c959c23303@huawei.com> <20240301065141-mutt-send-email-mst@kernel.org>
 <ffbe60c2732842a3b81e6ae0f58d2556@huawei.com> <CACGkMEsFtJTMFVHt8pJ39Ge8nTJcsX=R_dYghz_93+_Yn--ZDQ@mail.gmail.com>
 <d44e32c757014b38bb64d92af683b128@huawei.com>
In-Reply-To: <d44e32c757014b38bb64d92af683b128@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Mar 2024 14:07:30 +0800
Message-ID: <CACGkMEtG40J1zZG4nSvviw4MqX+RPOVuHG9PHR-PiYcZLj38CQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
To: wangyunjian <wangyunjian@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, xudingke <xudingke@huawei.com>, 
	"liwei (DT)" <liwei395@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 9:28=E2=80=AFPM wangyunjian <wangyunjian@huawei.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Monday, March 11, 2024 12:01 PM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; Paolo Abeni <pabeni@redhat.com=
>;
> > willemdebruijn.kernel@gmail.com; kuba@kernel.org; bjorn@kernel.org;
> > magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> > jonathan.lemon@gmail.com; davem@davemloft.net; bpf@vger.kernel.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.o=
rg;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (=
DT)
> > <liwei395@huawei.com>
> > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
> >
> > On Mon, Mar 4, 2024 at 9:45=E2=80=AFPM wangyunjian <wangyunjian@huawei.=
com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > Sent: Friday, March 1, 2024 7:53 PM
> > > > To: wangyunjian <wangyunjian@huawei.com>
> > > > Cc: Paolo Abeni <pabeni@redhat.com>;
> > > > willemdebruijn.kernel@gmail.com; jasowang@redhat.com;
> > > > kuba@kernel.org; bjorn@kernel.org; magnus.karlsson@intel.com;
> > > > maciej.fijalkowski@intel.com; jonathan.lemon@gmail.com;
> > > > davem@davemloft.net; bpf@vger.kernel.org; netdev@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > > > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>;
> > > > liwei (DT) <liwei395@huawei.com>
> > > > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy
> > > > support
> > > >
> > > > On Fri, Mar 01, 2024 at 11:45:52AM +0000, wangyunjian wrote:
> > > > > > -----Original Message-----
> > > > > > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > > > > > Sent: Thursday, February 29, 2024 7:13 PM
> > > > > > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > > > > > willemdebruijn.kernel@gmail.com; jasowang@redhat.com;
> > > > > > kuba@kernel.org; bjorn@kernel.org; magnus.karlsson@intel.com;
> > > > > > maciej.fijalkowski@intel.com; jonathan.lemon@gmail.com;
> > > > > > davem@davemloft.net
> > > > > > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > > > > > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > > > > > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>;
> > > > > > liwei (DT) <liwei395@huawei.com>
> > > > > > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy
> > > > > > support
> > > > > >
> > > > > > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > > > > > @@ -2661,6 +2776,54 @@ static int tun_ptr_peek_len(void *ptr)
> > > > > > >         }
> > > > > > >  }
> > > > > > >
> > > > > > > +static void tun_peek_xsk(struct tun_file *tfile) {
> > > > > > > +       struct xsk_buff_pool *pool;
> > > > > > > +       u32 i, batch, budget;
> > > > > > > +       void *frame;
> > > > > > > +
> > > > > > > +       if (!ptr_ring_empty(&tfile->tx_ring))
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       spin_lock(&tfile->pool_lock);
> > > > > > > +       pool =3D tfile->xsk_pool;
> > > > > > > +       if (!pool) {
> > > > > > > +               spin_unlock(&tfile->pool_lock);
> > > > > > > +               return;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (tfile->nb_descs) {
> > > > > > > +               xsk_tx_completed(pool, tfile->nb_descs);
> > > > > > > +               if (xsk_uses_need_wakeup(pool))
> > > > > > > +                       xsk_set_tx_need_wakeup(pool);
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       spin_lock(&tfile->tx_ring.producer_lock);
> > > > > > > +       budget =3D min_t(u32, tfile->tx_ring.size,
> > > > > > > + TUN_XDP_BATCH);
> > > > > > > +
> > > > > > > +       batch =3D xsk_tx_peek_release_desc_batch(pool, budget=
);
> > > > > > > +       if (!batch) {
> > > > > >
> > > > > > This branch looks like an unneeded "optimization". The generic
> > > > > > loop below should have the same effect with no measurable perf
> > > > > > delta - and
> > > > smaller code.
> > > > > > Just remove this.
> > > > > >
> > > > > > > +               tfile->nb_descs =3D 0;
> > > > > > > +               spin_unlock(&tfile->tx_ring.producer_lock);
> > > > > > > +               spin_unlock(&tfile->pool_lock);
> > > > > > > +               return;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       tfile->nb_descs =3D batch;
> > > > > > > +       for (i =3D 0; i < batch; i++) {
> > > > > > > +               /* Encode the XDP DESC flag into lowest bit
> > > > > > > + for consumer to
> > > > differ
> > > > > > > +                * XDP desc from XDP buffer and sk_buff.
> > > > > > > +                */
> > > > > > > +               frame =3D tun_xdp_desc_to_ptr(&pool->tx_descs=
[i]);
> > > > > > > +               /* The budget must be less than or equal to
> > tx_ring.size,
> > > > > > > +                * so enqueuing will not fail.
> > > > > > > +                */
> > > > > > > +               __ptr_ring_produce(&tfile->tx_ring, frame);
> > > > > > > +       }
> > > > > > > +       spin_unlock(&tfile->tx_ring.producer_lock);
> > > > > > > +       spin_unlock(&tfile->pool_lock);
> > > > > >
> > > > > > More related to the general design: it looks wrong. What if
> > > > > > get_rx_bufs() will fail (ENOBUF) after successful peeking? With
> > > > > > no more incoming packets, later peek will return 0 and it looks
> > > > > > like that the half-processed packets will stay in the ring fore=
ver???
> > > > > >
> > > > > > I think the 'ring produce' part should be moved into tun_do_rea=
d().
> > > > >
> > > > > Currently, the vhost-net obtains a batch descriptors/sk_buffs fro=
m
> > > > > the ptr_ring and enqueue the batch descriptors/sk_buffs to the
> > > > > virtqueue'queue, and then consumes the descriptors/sk_buffs from
> > > > > the virtqueue'queue in sequence. As a result, TUN does not know
> > > > > whether the batch descriptors have been used up, and thus does no=
t
> > > > > know when to
> > > > return the batch descriptors.
> > > > >
> > > > > So, I think it's reasonable that when vhost-net checks ptr_ring i=
s
> > > > > empty, it calls peek_len to get new xsk's descs and return the de=
scriptors.
> > > > >
> > > > > Thanks
> > > >
> > > > What you need to think about is that if you peek, another call in
> > > > parallel can get the same value at the same time.
> > >
> > > Thank you. I have identified a problem. The tx_descs array was create=
d within
> > xsk's pool.
> > > When xsk is freed, the pool and tx_descs are also freed. Howerver,
> > > some descs may remain in the virtqueue'queue, which could lead to a
> > use-after-free scenario.
> >
> > This can probably solving by when xsk pool is disabled, signal the vhos=
t_net to
> > drop those descriptors.
>
> I think TUN can notify vhost_net to drop these descriptors through netdev=
 events.

Great, actually, the "issue" described above exist in this patch as
well. For example, you did:

                        spin_lock(&tfile->pool_lock);
                        if (tfile->pool) {
                              ret =3D tun_put_user_desc(tun, tfile,
&tfile->desc, to);

You did copy_to_user() under spinlock which is actually a bug.

> However, there is a potential concurrency problem. When handling netdev e=
vents
> and packets, vhost_net preempts the 'vq->mutex_lock', leading to unstable=
 performance.

I think we don't need to care the perf in this case.

And we gain a lot:

1) no trick in peek
2) batching support
..

Thanks

>
> Thanks
> >
> > Thanks
> >
> > > Currently,
> > > I do not have an idea to solve this concurrency problem and believe
> > > this scenario may not be appropriate for reusing the ptr_ring.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > > >
> > > > > > Cheers,
> > > > > >
> > > > > > Paolo
> > > > >
> > >
>


