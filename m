Return-Path: <linux-kernel+bounces-51978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AA1849233
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574A01F219C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6679D8;
	Mon,  5 Feb 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtkI5+Md"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C779CF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707097435; cv=none; b=gkn+0Su1o283ZD88GnSWEdBnYON5NAcbBbNAdYfcbTETsBKpjs/aCD9AU6uhIh/3njMJDRhhg1EYS/r5XK2MRbq+zHuvOKLryCljXVg5zxnePW76SaqRDDq1a6dc0HJvsIKIfR+KjCDJEYq4fGaZjUFGiHFezSC7i43cXRdql/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707097435; c=relaxed/simple;
	bh=TpTIDnll6tdByqEXHboN61Gc8GS6K3HPiJf4ebys5Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljuRqAoofnPWYvhiyW70se25ti5HOGRuothkI/qvORJ0vykgQ7G/dz8I56nGBgdJ2ro7kt2TVd5u5Mi6pN+P2lxCUEgpnTyDUQyvUz2WxOWdIba7C88ho1iOLrldFMXIyTdL6p6uhYH+wfD5MNS9h5AC6wtXQrjoayOWuRnicxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtkI5+Md; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707097432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHOd+nEP3GmgSqnri0VDaG6rnDLyGN4eH7q1Djh7XH0=;
	b=GtkI5+MdXnbdHTLRSZreLpVVgKQKOhpcgUHSP7tCYi/5JJQYvgy9xQHIJy3nOBsrCU7wQk
	6oHLBFwlwzSxi5evOGw7Je486sLsnwxtV6Hwd6sc0Ff+LxiURJksptUwCKg92rqyIC8jyW
	6tMsxqZjvOPiSjQBRKI5qKqvGBhCFT0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-usAf9UMONGumN7zhvE-Yjg-1; Sun, 04 Feb 2024 20:43:51 -0500
X-MC-Unique: usAf9UMONGumN7zhvE-Yjg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59a2129fe88so5907198eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 17:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707097430; x=1707702230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHOd+nEP3GmgSqnri0VDaG6rnDLyGN4eH7q1Djh7XH0=;
        b=tjuEHi20X41sWuZfuJR9tmF8GFyj7nK/8YMsWgPdV8AKzMMkSZjS46b7YYT+cT+y1g
         JXNHnElDyf9SaCECtJwmshJwK183L5v8kiXWnKoSS+Qzatktzh5AWSHLsaMCVBYpMB1v
         uc8V5Ox3Yu/MuU4+VNQ0M7FYAx8Segl2DDiCrow1dO3FXxPNFAkCPicUNWUeB/ueE/lt
         19rJw/4hpvDZ5azBh87n60kU3ksHeqQE4ahwNKX66ZaX6OYXDe0BekyKLTuwYn3QvOqK
         V3Z/P8Gj7RfM6+8JoNeQntBByrGordbzgxTHH1mW/6oFjJHCMbrE+jDJJhNvwj4bIMX5
         bN3A==
X-Gm-Message-State: AOJu0YyAGwwk8Bv/avDSqfEdChrGQjFBY9e0SxMMEZdDbgsHfySfBucQ
	7rIrEyo+IVLVawFjD3QRdr4hFyaDln/nymC54WPTnmnzhdg6CXYheme2DxnykdtRZDhx96oMc/p
	50UIyBf1+HJs3k9KGwLoAZIhVWiBZg0YLpG3LwMAl63HITvNMTQ6KRJvDgnsDau8KEPuhmWar1W
	d/mE1MyJnGIZPvP26RGloRAwrJY/0l5ukGGdd+
X-Received: by 2002:a05:6358:9999:b0:178:799f:bcea with SMTP id j25-20020a056358999900b00178799fbceamr9403422rwb.7.1707097430009;
        Sun, 04 Feb 2024 17:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Vz1FHSJ+HwAjB1OKAdZhH85+pv5eX79VhB3fYiUAmxA+k9vX0OL9nX+EEu9G1NjsATgzF4AVtKEiGWssNBU=
X-Received: by 2002:a05:6358:9999:b0:178:799f:bcea with SMTP id
 j25-20020a056358999900b00178799fbceamr9403410rwb.7.1707097429737; Sun, 04 Feb
 2024 17:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130113710.34511-1-linyunsheng@huawei.com>
 <20240130113710.34511-6-linyunsheng@huawei.com> <CACGkMEsJq1Fg6T+9YLPzE16027sBHRZodk2+b1ySa9MeMcGjMA@mail.gmail.com>
 <dfc3dcb0-511c-945b-6099-c4d7ccbf3253@huawei.com> <CACGkMEsHLis66LntKTG01Eg7cMv-S7u05B3W6CizKRahJ5gDOw@mail.gmail.com>
 <16dd5732-06d1-8dd9-85b4-8de7686bd73e@huawei.com>
In-Reply-To: <16dd5732-06d1-8dd9-85b4-8de7686bd73e@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Feb 2024 09:43:38 +0800
Message-ID: <CACGkMEsK=eqPpe2cQCfUTwYkjjWSuJevf2MBy4BmvrNmXmX7PA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/2/4 9:30, Jason Wang wrote:
> > On Fri, Feb 2, 2024 at 8:24=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei=
com> wrote:
> >>
> >> On 2024/2/2 12:05, Jason Wang wrote:
> >>> On Tue, Jan 30, 2024 at 7:38=E2=80=AFPM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>>
> >>>> introduce vhost_net_test basing on virtio_test to test
> >>>> vhost_net changing in the kernel.
> >>>
> >>> Let's describe what kind of test is being done and how it is done her=
e.
> >>
> >> How about something like below:
> >>
> >> This patch introduces testing for both vhost_net tx and rx.
> >> Steps for vhost_net tx testing:
> >> 1. Prepare a out buf
> >> 2. Kick the vhost_net to do tx processing
> >> 3. Do the receiving in the tun side
> >> 4. verify the data received by tun is correct
> >>
> >> Steps for vhost_net rx testing::
> >> 1. Prepare a in buf
> >> 2. Do the sending in the tun side
> >> 3. Kick the vhost_net to do rx processing
> >> 4. verify the data received by vhost_net is correct
> >
> > It looks like some important details were lost, e.g the logic for batch=
ing etc.
>
> I am supposeing you are referring to the virtio desc batch handling=EF=BC=
=8C
> right?

Yes.

>
> It was a copy & paste code of virtio_test.c, I was thinking about removin=
g
> the virtio desc batch handling for now, as this patchset does not require
> that to do the testing, it mainly depend on the "sock->sk->sk_sndbuf" to
> be INT_MAX to call vhost_net_build_xdp(), which seems to be the default
> case for vhost_net.

Ok.

>
> >
> >>
>
> ...
>
> >>>> +static void vdev_create_socket(struct vdev_info *dev)
> >>>> +{
> >>>> +       struct ifreq ifr;
> >>>> +
> >>>> +       dev->sock =3D socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE))=
;
> >>>> +       assert(dev->sock !=3D -1);
> >>>> +
> >>>> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> >>>
> >>> Nit: it might be better to accept the device name instead of repeatin=
g
> >>> the snprintf trick here, this would facilitate the future changes.
> >>
> >> I am not sure I understand what did you mean by "accept the device nam=
e"
> >> here.
> >>
> >> The above is used to get ifindex of the tun netdevice created in
> >> tun_alloc(), so that we can use it in vdev_send_packet() to send
> >> a packet using the tun netdevice created in tun_alloc(). Is there
> >> anything obvious I missed here?
> >
> > I meant a const char *ifname for this function and let the caller to
> > pass the name.
>
> Sure.
>
> >
> >>
>
> >>>> +
> >>>> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
> >>>> +                       bool delayed, int batch, int bufs)
> >>>> +{
> >>>> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> >>>> +       long long spurious =3D 0;
> >>>> +       struct scatterlist sl;
> >>>> +       unsigned int len;
> >>>> +       int r;
> >>>> +
> >>>> +       for (;;) {
> >>>> +               long started_before =3D vq->started;
> >>>> +               long completed_before =3D vq->completed;
> >>>> +
> >>>> +               do {
> >>>> +                       if (random_batch)
> >>>> +                               batch =3D (random() % vq->vring.num)=
 + 1;
> >>>> +
> >>>> +                       while (vq->started < bufs &&
> >>>> +                              (vq->started - vq->completed) < batch=
) {
> >>>> +                               sg_init_one(&sl, dev->res_buf, HDR_L=
EN + TEST_BUF_LEN);
> >>>> +
> >>>> +                               r =3D virtqueue_add_inbuf(vq->vq, &s=
l, 1,
> >>>> +                                                       dev->res_buf=
 + vq->started,
> >>>> +                                                       GFP_ATOMIC);
> >>>> +                               if (unlikely(r !=3D 0)) {
> >>>> +                                       if (r =3D=3D -ENOSPC &&
> >>>
> >>> Drivers usually maintain a #free_slots, this can help to avoid the
> >>> trick for checking ENOSPC?
> >>
> >> The above "(vq->started - vq->completed) < batch" seems to ensure that
> >> the 'r' can't be '-ENOSPC'?
> >
> > Well, if this is true any reason we still check ENOSPEC here?
>
> As mentioned above, It was a copy & paste code of virtio_test.c.
> Will remove 'r =3D=3D -ENOSPC' checking.

I see.

>
> >
> >> We just need to ensure the batch <=3D desc_num,
> >> and the 'r =3D=3D -ENOSPC' checking seems to be unnecessary.
> >>
> >>>
> >>>> +                                           vq->started > started_be=
fore)
> >>>> +                                               r =3D 0;
> >>>> +                                       else
> >>>> +                                               r =3D -1;
> >>>> +                                       break;
> >>>> +                               }
> >>>> +
> >>>> +                               ++vq->started;
> >>>> +
> >>>> +                               vdev_send_packet(dev);
> >>>> +
> >>>> +                               if (unlikely(!virtqueue_kick(vq->vq)=
)) {
> >>>> +                                       r =3D -1;
> >>>> +                                       break;
> >>>> +                               }
> >>>> +                       }
> >>>> +
> >>>> +                       if (vq->started >=3D bufs)
> >>>> +                               r =3D -1;
> >>>> +
> >>>> +                       /* Flush out completed bufs if any */
> >>>> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> >>>> +                               struct ether_header *eh;
> >>>> +
> >>>> +                               eh =3D (struct ether_header *)(dev->=
res_buf + HDR_LEN);
> >>>> +
> >>>> +                               /* tun netdev is up and running, ign=
ore the
> >>>> +                                * non-TEST_PTYPE packet.
> >>>> +                                */
> >>>
> >>> I wonder if it's better to set up some kind of qdisc to avoid the
> >>> unexpected packet here, or is it too complicated?
> >>
> >> Yes, at least I don't know to do that yet.
> >
> > For example, the blackhole qdisc?
>
> It seems the blackhole_enqueue() just drop everything, which includes
> the packet sent using the raw socket in vdev_send_packet()?

I vaguely remember there's a mode that af_packet will bypass the qdisc
but I might be wrong.

But rethink of this, though it facilitates the code but it introduces
unnecessary dependencies like black hole which seems to be suboptimal.

>
> We may bypass qdisc for the raw socket in vdev_send_packet()=EF=BC=8Cbut =
it
> means other caller may bypass qdisc, and even cook up a packet with
> ethertype being ETH_P_LOOPBACK, there is part of the reason I added a
> simple payload verification in verify_res_buf().

Fine.

Thanks

>
> >
> > Thanks
> >
> > .
> >
>


