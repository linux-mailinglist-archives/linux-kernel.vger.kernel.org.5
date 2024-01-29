Return-Path: <linux-kernel+bounces-42116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382983FC87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B051C22011
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C181078D;
	Mon, 29 Jan 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaxRgdLS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F5F9FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497542; cv=none; b=Vj8486eESprm85Kpl30BSsfWKjKMq1t7/cuYPYRm/NmBQN4chAZq36iaBabzhuUHhDphjQdrhyWRcs99HK6SFZUHttHvZwFmtlM2lh3fKvviFMOdzrJ5rblutyi0M2ala+XSsV2dEw0cuM+3TpKtuJbHsAU0GxoTpqjoKfnypgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497542; c=relaxed/simple;
	bh=YtumUDa9xISoGxbg6DJBDnOO+Rukg7wlbjEEjxfD3UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3DSeZ5mtPZ7BZpF8kYvDTuOiUJAHrSGMMZSHQb74iM5MyWmLbJ/hrMYgX0s+bYkhDInTDmeV8flbYk3aMjx36DUTNdjUw9sY3u3gYDk/zYCmzsjrH7oRxP5SMBbOBqliOaN9mFZxPt/Y56LEV5r9XBeFuJ9phKrIiZ12UdgO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaxRgdLS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxcHXDna7cKu/U9+4vXe/vVpNtUCeHUKRMCX5kQ7Mpk=;
	b=PaxRgdLSeZeHpPt3MDz4uwN8/MfvNAklAcNE9SLZ6LVZ6YB+IZZFQ+4qQSvszz4h+WH3sL
	BFOhwCJdgyguoJJCJpxN93Qn4LSvnLePukurR7BRGBQ8c0gbVoShEipa6vZhIDQ/2BOLqs
	Rc0X04PSsdlNpcRf4nc+WcvDPLFXuIk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-aaTj1ZhBPF2sArW8nEvE4Q-1; Sun, 28 Jan 2024 22:05:37 -0500
X-MC-Unique: aaTj1ZhBPF2sArW8nEvE4Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd3b54e5c6so3382371b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497536; x=1707102336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxcHXDna7cKu/U9+4vXe/vVpNtUCeHUKRMCX5kQ7Mpk=;
        b=VTEyJSmklbCfmmIG4XsguriwzeblUYyfCfvMZMfg8xopTVKZO6CyUq8cq3aRa8cEeH
         HPodczzaWKG/pXrtSJEFBQi8kipcoSTrro1Ck7rn57d+b0IyDnikGm+v65CxbT4cqBaH
         AXVNTT4fqhhsCsautx5ERpK32bCFxylQndOqK266RryYghBmHtMUViUyBMA9G4o1cOVF
         fwOFZk76EC8JjAKd9MVsbPuYf3B3BOejPY/Dswbf5yGDgLpa3mkuICVBPz3C6oTIbaWa
         0uO84zJN81IBHf61Rc5SYrPjN51v9FBhANMMr9xiDSn2vAhhFi7h4q+L06b4pleHK+jf
         0vEg==
X-Gm-Message-State: AOJu0YxdB76NzqELEHV5vjGAZ3RVJCPUXNkeeyDjdiwpFndEmH78ecIS
	g0UBv5HYoN3wCp/6Zn1Cwvy/TwIJU1LcZypcxGSYBbQacB0UrCEFeh8eGwNizWHadulS4k1xuk4
	ypoheGTdN6+heo4uxp8tOWLyhbWyFqxg+xUH9IEeNdkpfmmE6EirwlqJUa/jLeLlw8LlJN0zXU7
	x4JhJ8m0S9HyT/dWmlfnN3DqTsY4kMG6CyoYP0
X-Received: by 2002:a05:6808:2096:b0:3be:68bf:f811 with SMTP id s22-20020a056808209600b003be68bff811mr445577oiw.20.1706497536651;
        Sun, 28 Jan 2024 19:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwSYFKtOFj1s4WRiGoVdbQaT36N6KL4HDrAVc5wEDiWUARymRb8voEFpf5mPyhonR8JwLBNdJn84fdszA4rAo=
X-Received: by 2002:a05:6808:2096:b0:3be:68bf:f811 with SMTP id
 s22-20020a056808209600b003be68bff811mr445564oiw.20.1706497536445; Sun, 28 Jan
 2024 19:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>
 <CACGkMEu5PaBgh37X4KysoF9YB8qy6jM5W4G6sm+8fjrnK36KXA@mail.gmail.com>
 <ad74a361d5084c62a89f7aa276273649@huawei.com> <156030296fea4f7abef6ab7155ba2e32@huawei.com>
In-Reply-To: <156030296fea4f7abef6ab7155ba2e32@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:05:25 +0800
Message-ID: <CACGkMEuMTdr3NS=XdkN+XDRqiXouL2tWcXEk6-qTvOsm0JCc9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
To: wangyunjian <wangyunjian@huawei.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, xudingke <xudingke@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 5:34=E2=80=AFPM wangyunjian <wangyunjian@huawei.com=
> wrote:
>
> > > -----Original Message-----
> > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > Sent: Thursday, January 25, 2024 12:49 PM
> > > To: wangyunjian <wangyunjian@huawei.com>
> > > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com; kuba@kernel.org;
> > > davem@davemloft.net; magnus.karlsson@intel.com;
> > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kvm@vger.kernel.org; virtualization@lists.linux.dev; xudingke
> > > <xudingke@huawei.com>
> > > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> > >
> > > On Wed, Jan 24, 2024 at 5:38=E2=80=AFPM Yunjian Wang
> > <wangyunjian@huawei.com>
> > > wrote:
> > > >
> > > > Now the zero-copy feature of AF_XDP socket is supported by some
> > > > drivers, which can reduce CPU utilization on the xdp program.
> > > > This patch set allows tun to support AF_XDP Rx zero-copy feature.
> > > >
> > > > This patch tries to address this by:
> > > > - Use peek_len to consume a xsk->desc and get xsk->desc length.
> > > > - When the tun support AF_XDP Rx zero-copy, the vq's array maybe em=
pty.
> > > > So add a check for empty vq's array in vhost_net_buf_produce().
> > > > - add XDP_SETUP_XSK_POOL and ndo_xsk_wakeup callback support
> > > > - add tun_put_user_desc function to copy the Rx data to VM
> > >
> > > Code explains themselves, let's explain why you need to do this.
> > >
> > > 1) why you want to use peek_len
> > > 2) for "vq's array", what does it mean?
> > > 3) from the view of TUN/TAP tun_put_user_desc() is the TX path, so I
> > > guess you meant TX zerocopy instead of RX (as I don't see codes for
> > > RX?)
> >
> > OK, I agree and use TX zerocopy instead of RX zerocopy. I meant RX zero=
copy
> > from the view of vhost-net.
> >
> > >
> > > A big question is how could you handle GSO packets from userspace/gue=
sts?
> >
> > Now by disabling VM's TSO and csum feature. XDP does not support GSO
> > packets.
> > However, this feature can be added once XDP supports it in the future.
> >
> > >
> > > >
> > > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > > ---
> > > >  drivers/net/tun.c   | 165
> > > +++++++++++++++++++++++++++++++++++++++++++-
> > > >  drivers/vhost/net.c |  18 +++--
> > > >  2 files changed, 176 insertions(+), 7 deletions(-)
>
> [...]
>
> > > >
> > > >  static int peek_head_len(struct vhost_net_virtqueue *rvq, struct
> > > > sock
> > > > *sk)  {
> > > > +       struct socket *sock =3D sk->sk_socket;
> > > >         struct sk_buff *head;
> > > >         int len =3D 0;
> > > >         unsigned long flags;
> > > >
> > > > -       if (rvq->rx_ring)
> > > > -               return vhost_net_buf_peek(rvq);
> > > > +       if (rvq->rx_ring) {
> > > > +               len =3D vhost_net_buf_peek(rvq);
> > > > +               if (likely(len))
> > > > +                       return len;
> > > > +       }
> > > > +
> > > > +       if (sock->ops->peek_len)
> > > > +               return sock->ops->peek_len(sock);
> > >
> > > What prevents you from reusing the ptr_ring here? Then you don't need
> > > the above tricks.
> >
> > Thank you for your suggestion. I will consider how to reuse the ptr_rin=
g.
>
> If ptr_ring is used to transfer xdp_descs, there is a problem: After some
> xdp_descs are obtained through xsk_tx_peek_desc(), the descs may fail
> to be added to ptr_ring. However, no API is available to implement the
> rollback function.

I don't understand, this issue seems to exist in the physical NIC as well?

We get more descriptors than the free slots in the NIC ring.

How did other NIC solve this issue?

Thanks

>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > >         spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
> > > >         head =3D skb_peek(&sk->sk_receive_queue);
> > > > --
> > > > 2.33.0
> > > >
>


