Return-Path: <linux-kernel+bounces-43851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56847841989
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D721B2881E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E936B0D;
	Tue, 30 Jan 2024 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwJRPVlz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6436AE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582939; cv=none; b=PlyWB7HeKq+PgMdp169y3lnQh0EvisQb4wfk4rv9YyR4Ws9z3Ax9h/y7agciTDVk8AatJSSoGxmCsUvf9+J102/7mnvoBV3eJzuBBcovn42cXHAJ4JSsw61IlMhctTY8okputpC6BmsTIfzbF69j0M9wjZx52PEL+Li0OnsQnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582939; c=relaxed/simple;
	bh=RLrbN+jjPHHaYWcRfFc4XP7MVZtSqRQZj3eLTMKo3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaS3BiRNljiM0silJ0Yd8ZY8FMUFJjxdwkV39Ny9fJSsTqkP5FBk30MMHRTq7rF7tZbEgBDdNRQZ0z8yvKSU91S+ydFmvNk3rO3Ll8BZluPCZFSNBkBRMcapM1SxSG+Y9c4Zu51ptjs+fTIgdt9cUVtuU9jTAIIbZgSg3ddVjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwJRPVlz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706582936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5cO6FStwdwziZKKBXyLpCsTpVBHHFcr/YapoZkDLqM=;
	b=TwJRPVlz/CN5UqTDNyKdfj3jYNAFAPiXPDZE3XOBRubz5b4oBj9ayUjY56DMrnE7EUN09r
	NQiQ3GcKgwRL6JcMPang+tsvgjDYJMM3o9DLjLTbQAuP6DTtN7Gn1eJx4WchFZV4SNexGq
	ZafAg62oz1CH1NgFEtpUblt2tyAY/OQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-IK-HIRiENraWeTmEO_wcnQ-1; Mon, 29 Jan 2024 21:48:54 -0500
X-MC-Unique: IK-HIRiENraWeTmEO_wcnQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59a25e89211so2667997eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706582934; x=1707187734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5cO6FStwdwziZKKBXyLpCsTpVBHHFcr/YapoZkDLqM=;
        b=FmCd0PKL40qVu914SkTAQhL5PvDbFEmFyZuTEub5FKXCYdK5xylH82zxWseCpoFRAN
         O5l8HoSlgs5wBA6iKXkNc8CEbaAoIE6xPm4RsjtHKYkd0B0qid+T/1zYZRW68xlo8Ptf
         yZv+PERUgDfDfmgjZqu5avEhGwywpEAQEDwPW0VU31/uvUo4iHENbimRwjeYMz6rC59p
         jYeJwsXDzVyclDUm4PUa1Fsx5ui+yrqH1eZ3q914vgGVvAReCH5zjVfrqCMo4x1ai0Mv
         5juCjpPTVkQ0HuRSEWlVD3KMXlChqXMSvh2vuGNkN52LH0R8o+M/NqEHuWyQBzJnoQW6
         nicg==
X-Gm-Message-State: AOJu0YyfVDUm/8jCKBhFdJw27oLmuhKL9JSdLY1qfSVo2M7uiaMIh9H2
	FWBeGVmLr2BG5w6vph34ARL9nUsesoCj+t7SzdqW4LqurRotHwPsckzWLdp4Xtkgr9NNEfT+AOQ
	gvaOwLxxTSV9m+7aLwsF/WS37linqpFhMwp9cI2aVX0CAr7tnh22jWY2MAiAoCtd1vdpSmXTffC
	bcrmTNddaKjUshpVJgiFaDAV+i0muF8RWXRW8W
X-Received: by 2002:a05:6358:718c:b0:178:7807:4bb2 with SMTP id t12-20020a056358718c00b0017878074bb2mr2446232rwt.55.1706582933766;
        Mon, 29 Jan 2024 18:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzxTpuO41EyUV2Zka33ihWGOtyrg5rppOWYknnW+1g0hIHW+zOCEVGnP7hTrZBcaRoa9j3a2mKPgn4Ftj/RFk=
X-Received: by 2002:a05:6358:718c:b0:178:7807:4bb2 with SMTP id
 t12-20020a056358718c00b0017878074bb2mr2446226rwt.55.1706582933528; Mon, 29
 Jan 2024 18:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>
 <CACGkMEu5PaBgh37X4KysoF9YB8qy6jM5W4G6sm+8fjrnK36KXA@mail.gmail.com>
 <ad74a361d5084c62a89f7aa276273649@huawei.com> <156030296fea4f7abef6ab7155ba2e32@huawei.com>
 <CACGkMEuMTdr3NS=XdkN+XDRqiXouL2tWcXEk6-qTvOsm0JCc9Q@mail.gmail.com> <506f483f07eb41d0bbea58333ae0c933@huawei.com>
In-Reply-To: <506f483f07eb41d0bbea58333ae0c933@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 10:48:42 +0800
Message-ID: <CACGkMEt6fvqrCLFhiPQU8cpXvOGhKj2Rg2sw1f39exCzW9fkSQ@mail.gmail.com>
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

On Mon, Jan 29, 2024 at 7:10=E2=80=AFPM wangyunjian <wangyunjian@huawei.com=
> wrote:
>
> > -----Original Message-----
> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Monday, January 29, 2024 11:05 AM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com; kuba@kernel.org;
> > davem@davemloft.net; magnus.karlsson@intel.com; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>
> > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> >
> > On Sat, Jan 27, 2024 at 5:34=E2=80=AFPM wangyunjian <wangyunjian@huawei=
com>
> > wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > > Sent: Thursday, January 25, 2024 12:49 PM
> > > > > To: wangyunjian <wangyunjian@huawei.com>
> > > > > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com;
> > > > > kuba@kernel.org; davem@davemloft.net; magnus.karlsson@intel.com;
> > > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > kvm@vger.kernel.org; virtualization@lists.linux.dev; xudingke
> > > > > <xudingke@huawei.com>
> > > > > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy suppor=
t
> > > > >
> > > > > On Wed, Jan 24, 2024 at 5:38=E2=80=AFPM Yunjian Wang
> > > > <wangyunjian@huawei.com>
> > > > > wrote:
> > > > > >
> > > > > > Now the zero-copy feature of AF_XDP socket is supported by some
> > > > > > drivers, which can reduce CPU utilization on the xdp program.
> > > > > > This patch set allows tun to support AF_XDP Rx zero-copy featur=
e.
> > > > > >
> > > > > > This patch tries to address this by:
> > > > > > - Use peek_len to consume a xsk->desc and get xsk->desc length.
> > > > > > - When the tun support AF_XDP Rx zero-copy, the vq's array mayb=
e
> > empty.
> > > > > > So add a check for empty vq's array in vhost_net_buf_produce().
> > > > > > - add XDP_SETUP_XSK_POOL and ndo_xsk_wakeup callback support
> > > > > > - add tun_put_user_desc function to copy the Rx data to VM
> > > > >
> > > > > Code explains themselves, let's explain why you need to do this.
> > > > >
> > > > > 1) why you want to use peek_len
> > > > > 2) for "vq's array", what does it mean?
> > > > > 3) from the view of TUN/TAP tun_put_user_desc() is the TX path, s=
o
> > > > > I guess you meant TX zerocopy instead of RX (as I don't see codes
> > > > > for
> > > > > RX?)
> > > >
> > > > OK, I agree and use TX zerocopy instead of RX zerocopy. I meant RX
> > > > zerocopy from the view of vhost-net.
> > > >
> > > > >
> > > > > A big question is how could you handle GSO packets from
> > userspace/guests?
> > > >
> > > > Now by disabling VM's TSO and csum feature. XDP does not support GS=
O
> > > > packets.
> > > > However, this feature can be added once XDP supports it in the futu=
re.
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > > > > ---
> > > > > >  drivers/net/tun.c   | 165
> > > > > +++++++++++++++++++++++++++++++++++++++++++-
> > > > > >  drivers/vhost/net.c |  18 +++--
> > > > > >  2 files changed, 176 insertions(+), 7 deletions(-)
> > >
> > > [...]
> > >
> > > > > >
> > > > > >  static int peek_head_len(struct vhost_net_virtqueue *rvq,
> > > > > > struct sock
> > > > > > *sk)  {
> > > > > > +       struct socket *sock =3D sk->sk_socket;
> > > > > >         struct sk_buff *head;
> > > > > >         int len =3D 0;
> > > > > >         unsigned long flags;
> > > > > >
> > > > > > -       if (rvq->rx_ring)
> > > > > > -               return vhost_net_buf_peek(rvq);
> > > > > > +       if (rvq->rx_ring) {
> > > > > > +               len =3D vhost_net_buf_peek(rvq);
> > > > > > +               if (likely(len))
> > > > > > +                       return len;
> > > > > > +       }
> > > > > > +
> > > > > > +       if (sock->ops->peek_len)
> > > > > > +               return sock->ops->peek_len(sock);
> > > > >
> > > > > What prevents you from reusing the ptr_ring here? Then you don't
> > > > > need the above tricks.
> > > >
> > > > Thank you for your suggestion. I will consider how to reuse the ptr=
_ring.
> > >
> > > If ptr_ring is used to transfer xdp_descs, there is a problem: After
> > > some xdp_descs are obtained through xsk_tx_peek_desc(), the descs may
> > > fail to be added to ptr_ring. However, no API is available to
> > > implement the rollback function.
> >
> > I don't understand, this issue seems to exist in the physical NIC as we=
ll?
> >
> > We get more descriptors than the free slots in the NIC ring.
> >
> > How did other NIC solve this issue?
>
> Currently, physical NICs such as i40e, ice, ixgbe, igc, and mlx5 obtains
> available NIC descriptors and then retrieve the same number of xsk
> descriptors for processing.

Any reason we can't do the same? ptr_ring should be much simpler than
NIC ring anyhow.

Thanks

>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >
> > > > > >         spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
> > > > > >         head =3D skb_peek(&sk->sk_receive_queue);
> > > > > > --
> > > > > > 2.33.0
> > > > > >
> > >
>


